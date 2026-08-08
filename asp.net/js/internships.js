document.addEventListener("DOMContentLoaded", () => {
    const PER_PAGE = 12;

    const CATEGORY_LABELS = {
        "software-dev": "Software Development",
        "data-science": "Data Science",
        "design": "Design (UI/UX)",
        "marketing": "Marketing",
        "finance": "Finance",
        "business": "Business & Consulting",
        "product": "Product Management",
        "engineering": "Engineering & Manufacturing",
        "healthcare": "Healthcare",
        "education": "Education",
    };

    const LOCATION_LABELS = {
        bengaluru: "Bengaluru",
        hyderabad: "Hyderabad",
        mumbai: "Mumbai",
        gurugram: "Gurugram",
        pune: "Pune",
        noida: "Noida",
        chennai: "Chennai",
        remote: "Remote",
    };

    const DURATION_BUCKETS = [
        { key: "1-month", label: "1 Month" },
        { key: "2-3-months", label: "2-3 Months" },
        { key: "3-6-months", label: "3-6 Months" },
        { key: "6-plus-months", label: "6+ Months" },
    ];

    const MODE_OPTIONS = [
        { key: "wfh", label: "Work From Home" },
        { key: "hybrid", label: "Hybrid" },
        { key: "onsite", label: "On-site" },
    ];

    const DURATION_ORDER_MAP = Object.fromEntries(
        DURATION_BUCKETS.map((d, i) => [d.key, i])
    );

    const sampleInternships = [
        {
            id: 1,
            title: "Frontend Developer Intern",
            categoryKey: "software-dev",
            categoryLabel: "Software Development",
            company: "Google",
            companyIcon: { type: "img", url: "../assets/logo-google.png" },
            location: "Bengaluru, India",
            locationKey: "bengaluru",
            modeKey: "hybrid",
            modeLabel: "Hybrid",
            stipendType: "paid",
            stipend: 20000,
            durationLabel: "3-6 Months",
            durationKey: "3-6-months",
            postedDaysAgo: 2,
        },
        {
            id: 2,
            title: "UI/UX Design Intern",
            categoryKey: "design",
            categoryLabel: "Design (UI/UX)",
            company: "Figma",
            companyIcon: { type: "img", url: "../assets/logo-figma.svg" },
            location: "Remote",
            locationKey: "remote",
            modeKey: "wfh",
            modeLabel: "Work From Home",
            stipendType: "paid",
            stipend: 15000,
            durationLabel: "2-3 Months",
            durationKey: "2-3-months",
            postedDaysAgo: 5,
        },
        {
            id: 3,
            title: "Business Analyst Intern",
            categoryKey: "business",
            categoryLabel: "Business & Consulting",
            company: "Deloitte",
            companyIcon: { type: "img", url: "../assets/logo-deloitte.svg" },
            location: "Gurugram, India",
            locationKey: "gurugram",
            modeKey: "onsite",
            modeLabel: "On-site",
            stipendType: "paid",
            stipend: 18000,
            durationLabel: "1 Month",
            durationKey: "1-month",
            postedDaysAgo: 1,
        },
    ];

    const dataSource =
        (Array.isArray(window.INTERNSHIPS_DATA) && window.INTERNSHIPS_DATA.length > 0
            ? window.INTERNSHIPS_DATA
            : sampleInternships).slice();

    const state = {
        keyword: "",
        category: "",
        location: "",
        durations: new Set(),
        stipends: new Set(),
        modes: new Set(),
        sort: "newest",
        page: 1,
    };

    const savedKey = "simsSavedInternships";
    const getSaved = () => {
        try {
            return new Set(JSON.parse(localStorage.getItem(savedKey)) || []);
        } catch {
            return new Set();
        }
    };
    const setSaved = (set) => {
        localStorage.setItem(savedKey, JSON.stringify([...set]));
    };
    let savedIds = getSaved();

    const topCategory = document.getElementById("topCategory");
    const sideCategory = document.getElementById("sideCategory");
    const topLocation = document.getElementById("topLocation");
    const sideLocation = document.getElementById("sideLocation");
    const topDuration = document.getElementById("topDuration");
    const durationChecksEl = document.getElementById("durationChecks");
    const modeChecksEl = document.getElementById("modeChecks");
    const stipendChecksEl = document.getElementById("stipendChecks");
    const topKeywordInput = document.getElementById("topKeywordInput");
    const sideKeywordInput = document.getElementById("sideKeywordInput");
    const sortSelect = document.getElementById("sortBySelect");
    const gridEl = document.getElementById("internshipsGrid");
    const resultCountEl = document.getElementById("resultCount");
    const paginationEl = document.getElementById("pagination");
    const noResultsEl = document.getElementById("noResults");

    function safeAppendOption(select, value, text) {
        if (!select) return;
        const opt = document.createElement("option");
        opt.value = value;
        opt.textContent = text;
        select.appendChild(opt);
    }

    Object.keys(CATEGORY_LABELS).forEach((key) => {
        safeAppendOption(topCategory, key, CATEGORY_LABELS[key]);
        safeAppendOption(sideCategory, key, CATEGORY_LABELS[key]);
    });

    Object.keys(LOCATION_LABELS).forEach((key) => {
        safeAppendOption(topLocation, key, LOCATION_LABELS[key]);
        safeAppendOption(sideLocation, key, LOCATION_LABELS[key]);
    });

    DURATION_BUCKETS.forEach((d) => {
        safeAppendOption(topDuration, d.key, d.label);
        if (durationChecksEl) {
            const label = document.createElement("label");
            label.className = "checkbox-item";
            label.innerHTML = `<input type="checkbox" data-group="duration" data-value="${d.key}"> ${d.label}`;
            durationChecksEl.appendChild(label);
        }
    });

    MODE_OPTIONS.forEach((m) => {
        if (modeChecksEl) {
            const label = document.createElement("label");
            label.className = "checkbox-item";
            label.innerHTML = `<input type="checkbox" data-group="mode" data-value="${m.key}"> ${m.label}`;
            modeChecksEl.appendChild(label);
        }
    });

    function syncSelectPair(topSel, sideSel, value) {
        if (topSel) topSel.value = value;
        if (sideSel) sideSel.value = value;
    }

    function syncDurationCheckboxes() {
        if (!durationChecksEl || !topDuration) return;
        durationChecksEl.querySelectorAll("input").forEach((cb) => {
            cb.checked = state.durations.has(cb.dataset.value);
        });
        topDuration.value =
            state.durations.size === 1 ? [...state.durations][0] : "";
    }

    function applyKeyword(value) {
        const cleaned = (value || "").trim();
        state.keyword = cleaned.toLowerCase();
        if (topKeywordInput) topKeywordInput.value = cleaned;
        if (sideKeywordInput) sideKeywordInput.value = cleaned;
        state.page = 1;
        render();
    }

    topCategory?.addEventListener("change", () => {
        state.category = topCategory.value;
        syncSelectPair(topCategory, sideCategory, state.category);
        state.page = 1;
        render();
    });

    sideCategory?.addEventListener("change", () => {
        state.category = sideCategory.value;
        syncSelectPair(topCategory, sideCategory, state.category);
        state.page = 1;
        render();
    });

    topLocation?.addEventListener("change", () => {
        state.location = topLocation.value;
        syncSelectPair(topLocation, sideLocation, state.location);
        state.page = 1;
        render();
    });

    sideLocation?.addEventListener("change", () => {
        state.location = sideLocation.value;
        syncSelectPair(topLocation, sideLocation, state.location);
        state.page = 1;
        render();
    });

    topDuration?.addEventListener("change", () => {
        state.durations = new Set(topDuration.value ? [topDuration.value] : []);
        syncDurationCheckboxes();
        state.page = 1;
        render();
    });

    durationChecksEl?.addEventListener("change", (e) => {
        const cb = e.target;
        if (!cb || !cb.dataset) return;
        if (cb.checked) state.durations.add(cb.dataset.value);
        else state.durations.delete(cb.dataset.value);
        syncDurationCheckboxes();
        state.page = 1;
        render();
    });

    stipendChecksEl?.addEventListener("change", (e) => {
        const cb = e.target;
        if (!cb || !cb.dataset) return;
        if (cb.checked) state.stipends.add(cb.dataset.value);
        else state.stipends.delete(cb.dataset.value);
        state.page = 1;
        render();
    });

    modeChecksEl?.addEventListener("change", (e) => {
        const cb = e.target;
        if (!cb || !cb.dataset) return;
        if (cb.checked) state.modes.add(cb.dataset.value);
        else state.modes.delete(cb.dataset.value);
        state.page = 1;
        render();
    });

    topKeywordInput?.addEventListener("input", () => applyKeyword(topKeywordInput.value));
    sideKeywordInput?.addEventListener("input", () => applyKeyword(sideKeywordInput.value));
    document.getElementById("topSearchBtn")?.addEventListener("click", () => applyKeyword(topKeywordInput?.value || ""));
    topKeywordInput?.addEventListener("keydown", (e) => {
        if (e.key === "Enter") applyKeyword(topKeywordInput.value);
    });

    document.getElementById("applyFiltersBtn")?.addEventListener("click", () => {
        state.page = 1;
        render();
        document.getElementById("internshipsResultsTop")?.scrollIntoView({
            behavior: "smooth",
            block: "start",
        });
    });

    document.getElementById("clearAllBtn")?.addEventListener("click", () => {
        state.keyword = "";
        state.category = "";
        state.location = "";
        state.durations.clear();
        state.stipends.clear();
        state.modes.clear();
        state.sort = "newest";
        state.page = 1;

        if (topKeywordInput) topKeywordInput.value = "";
        if (sideKeywordInput) sideKeywordInput.value = "";
        if (topCategory) topCategory.value = "";
        if (sideCategory) sideCategory.value = "";
        if (topLocation) topLocation.value = "";
        if (sideLocation) sideLocation.value = "";
        if (topDuration) topDuration.value = "";
        document.querySelectorAll("#durationChecks input, #stipendChecks input, #modeChecks input").forEach((cb) => {
            cb.checked = false;
        });
        if (sortSelect) sortSelect.value = "newest";

        render();
    });

    sortSelect?.addEventListener("change", () => {
        state.sort = sortSelect.value;
        state.page = 1;
        render();
    });

    function getFiltered() {
        let list = dataSource.filter((item) => {
            if (state.keyword) {
                const hay = `${item.title} ${item.company} ${item.categoryLabel}`.toLowerCase();
                if (!hay.includes(state.keyword)) return false;
            }
            if (state.category && item.categoryKey !== state.category) return false;
            if (state.location && item.locationKey !== state.location) return false;
            if (state.durations.size && !state.durations.has(item.durationKey)) return false;
            if (state.stipends.size && !state.stipends.has(item.stipendType)) return false;
            if (state.modes.size && !state.modes.has(item.modeKey)) return false;
            return true;
        });

        switch (state.sort) {
            case "stipend-desc":
                list.sort((a, b) => (b.stipend || 0) - (a.stipend || 0));
                break;
            case "stipend-asc":
                list.sort((a, b) => (a.stipend || 0) - (b.stipend || 0));
                break;
            case "duration-asc":
                list.sort(
                    (a, b) =>
                        (DURATION_ORDER_MAP[a.durationKey] ?? 999) -
                        (DURATION_ORDER_MAP[b.durationKey] ?? 999)
                );
                break;
            default:
                list.sort((a, b) => (a.postedDaysAgo || 0) - (b.postedDaysAgo || 0));
        }
        return list;
    }

    function logoHtml(icon) {
        if (icon && icon.type === "img") {
            return `<img src="${icon.url}" alt="logo" class="internship-logo-img" style="width:40px;height:40px;object-fit:contain;border-radius:8px;">`;
        }
        if (icon && icon.type === "fa") {
            return `<span class="internship-logo" style="background:${icon.color || "#eef"}18;color:${icon.color || "#334"}"><i class="${icon.value || "fa-solid fa-briefcase"}"></i></span>`;
        }
        return `<span class="internship-logo"><i class="fa-solid fa-briefcase"></i></span>`;
    }

    function modeIcon(modeKey) {
        if (modeKey === "wfh") return "fa-house";
        if (modeKey === "hybrid") return "fa-building-user";
        return "fa-building";
    }

    function cardHtml(item) {
        const isSaved = savedIds.has(item.id);
        const imageHref = `internship-details.aspx?id=${item.id}`;
        return `
      <a href="${imageHref}" class="internship-card" data-id="${item.id}" style="display:block;text-decoration:none;color:inherit;">
        <i class="fa-${isSaved ? "solid" : "regular"} fa-bookmark internship-bookmark ${isSaved ? "saved" : ""}" data-id="${item.id}"></i>
        <div class="internship-card-head">
          ${logoHtml(item.companyIcon)}
          <div>
            <p class="internship-title">${item.title}</p>
            <p class="internship-company">${item.company}</p>
          </div>
        </div>
        <div class="internship-meta-row">
          <span><i class="fa-solid fa-location-dot"></i> ${item.location}</span>
          <span><i class="fa-solid ${modeIcon(item.modeKey)}"></i> ${item.modeLabel}</span>
        </div>
        <div class="internship-stipend-row">
          <span class="stipend-tag ${item.stipendType}">${item.stipendType === "paid" ? "Paid" : "Unpaid"}</span>
          ${item.stipendType === "paid" ? `<span class="stipend-amount">₹${Number(item.stipend || 0).toLocaleString()} / month</span>` : ""}
        </div>
        <div class="internship-footer-row">
          <span><i class="fa-regular fa-clock"></i> ${item.durationLabel}</span>
          <span>Posted ${item.postedDaysAgo === 0 ? "today" : `${item.postedDaysAgo} day${item.postedDaysAgo === 1 ? "" : "s"} ago`}</span>
        </div>
      </a>`;
    }

    function renderPagination(totalPages) {
        if (!paginationEl) return;
        if (totalPages <= 1) {
            paginationEl.innerHTML = "";
            return;
        }

        let html = "";
        html += `<button class="page-btn" data-page="prev" ${state.page === 1 ? "disabled" : ""}><i class="fa-solid fa-chevron-left"></i></button>`;

        const maxButtons = 5;
        let startPage = Math.max(1, state.page - 2);
        let endPage = Math.min(totalPages, startPage + maxButtons - 1);
        startPage = Math.max(1, endPage - maxButtons + 1);

        if (startPage > 1) {
            html += `<button class="page-btn" data-page="1">1</button>`;
            if (startPage > 2) html += `<span class="page-ellipsis">...</span>`;
        }

        for (let p = startPage; p <= endPage; p++) {
            html += `<button class="page-btn ${p === state.page ? "active" : ""}" data-page="${p}">${p}</button>`;
        }

        if (endPage < totalPages) {
            if (endPage < totalPages - 1) html += `<span class="page-ellipsis">...</span>`;
            html += `<button class="page-btn" data-page="${totalPages}">${totalPages}</button>`;
        }

        html += `<button class="page-btn" data-page="next" ${state.page === totalPages ? "disabled" : ""}><i class="fa-solid fa-chevron-right"></i></button>`;
        paginationEl.innerHTML = html;

        paginationEl.querySelectorAll(".page-btn").forEach((btn) => {
            btn.addEventListener("click", () => {
                if (btn.disabled) return;
                const val = btn.dataset.page;
                if (val === "prev") state.page -= 1;
                else if (val === "next") state.page += 1;
                else state.page = parseInt(val, 10);
                render();
                document.getElementById("internshipsResultsTop")?.scrollIntoView({
                    behavior: "smooth",
                    block: "start",
                });
            });
        });
    }

    const toast = document.getElementById("loginToast");
    const toastMsg = document.getElementById("loginToastMsg");
    let toastTimer = null;
    function showToast(message) {
        if (!toast || !toastMsg) return;
        toastMsg.textContent = message;
        toast.classList.add("show", "success");
        clearTimeout(toastTimer);
        toastTimer = setTimeout(() => toast.classList.remove("show"), 2800);
    }

    function render() {
        if (!gridEl || !resultCountEl || !noResultsEl) return;
        const filtered = getFiltered();
        const total = filtered.length;
        const totalPages = Math.max(1, Math.ceil(total / PER_PAGE));
        if (state.page > totalPages) state.page = totalPages;

        const start = (state.page - 1) * PER_PAGE;
        const pageItems = filtered.slice(start, start + PER_PAGE);

        gridEl.innerHTML = pageItems.map(cardHtml).join("");
        noResultsEl.style.display = total === 0 ? "block" : "none";
        gridEl.style.display = total === 0 ? "none" : "grid";

        resultCountEl.textContent =
            total === 0
                ? `Showing 0 of ${dataSource.length} internships`
                : `Showing ${start + 1}-${Math.min(start + PER_PAGE, total)} of ${total} internships`;

        renderPagination(totalPages);

        gridEl.querySelectorAll(".internship-bookmark").forEach((icon) => {
            icon.addEventListener("click", (e) => {
                e.preventDefault();
                e.stopPropagation();
                const id = parseInt(icon.dataset.id, 10);
                if (savedIds.has(id)) {
                    savedIds.delete(id);
                    icon.classList.remove("saved", "fa-solid");
                    icon.classList.add("fa-regular");
                    showToast("Removed from saved internships.");
                } else {
                    savedIds.add(id);
                    icon.classList.add("saved", "fa-solid");
                    icon.classList.remove("fa-regular");
                    showToast("Saved to your bookmarks!");
                }
                setSaved(savedIds);
            });
        });
    }

    render();
});

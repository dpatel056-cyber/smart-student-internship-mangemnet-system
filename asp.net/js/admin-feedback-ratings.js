document.addEventListener("DOMContentLoaded", function () {
    // 1. DATASET WITH REALISTIC DATES FOR DATE FILTERING
    const feedbackList = [
        { id: "FB-1024", name: "Dhruvi Patel", email: "dhruvi@gmail.com", rating: 5, feedback: "Very easy to use, responsive and smooth navigation throughout the internship application process.", rawDate: "2026-08-21", date: "21 Aug 2026", time: "10:30 AM", status: "Reviewed", avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=80" },
        { id: "FB-1023", name: "Rahul Shah", email: "rahul@gmail.com", rating: 4, feedback: "Good experience with internship listings, companies respond very fast.", rawDate: "2026-08-20", date: "20 Aug 2026", time: "04:15 PM", status: "New", avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80" },
        { id: "FB-1022", name: "Priya Patel", email: "priya@gmail.com", rating: 2, feedback: "Needs improvement in interview notifications and chat message latency.", rawDate: "2026-08-20", date: "20 Aug 2026", time: "02:00 PM", status: "New", avatar: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=100&auto=format&fit=crop&q=80" },
        { id: "FB-1021", name: "Amit Shah", email: "amit@gmail.com", rating: 5, feedback: "Excellent service! We hired 3 interns within a week. Highly recommended platform.", rawDate: "2026-08-19", date: "19 Aug 2026", time: "11:45 AM", status: "Responded", avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&auto=format&fit=crop&q=80" },
        { id: "FB-1020", name: "Neha Sharma", email: "neha.sharma@gmail.com", rating: 5, feedback: "The certificate verification feature is amazing and saved us a lot of manual work.", rawDate: "2026-08-19", date: "19 Aug 2026", time: "09:20 AM", status: "Resolved", avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&auto=format&fit=crop&q=80" },
        { id: "FB-1019", name: "Karan Mehta", email: "karan.mehta@gmail.com", rating: 4, feedback: "Dashboard is clean and well-structured. Would love dark mode support soon.", rawDate: "2026-08-18", date: "18 Aug 2026", time: "06:10 PM", status: "Reviewed", avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&auto=format&fit=crop&q=80" },
        { id: "FB-1018", name: "Vivek Singh", email: "vivek.singh@gmail.com", rating: 1, feedback: "Facing an issue while uploading PDF resume above 3MB. Please fix the upload handler.", rawDate: "2026-08-18", date: "18 Aug 2026", time: "03:30 PM", status: "New", avatar: "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=100&auto=format&fit=crop&q=80" },
        { id: "FB-1017", name: "Anjali Dave", email: "anjali.dave@gmail.com", rating: 5, feedback: "Great internship management tool! Everything is centralized nicely.", rawDate: "2026-08-17", date: "17 Aug 2026", time: "01:15 PM", status: "Responded", avatar: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&auto=format&fit=crop&q=80" },
        { id: "FB-1016", name: "Harsh Patel", email: "harsh.patel@gmail.com", rating: 4, feedback: "Smooth application flow, but email alerts could be more customizable.", rawDate: "2026-08-17", date: "17 Aug 2026", time: "10:40 AM", status: "Reviewed", avatar: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100&auto=format&fit=crop&q=80" },
        { id: "FB-1015", name: "Sneha Desai", email: "sneha.desai@gmail.com", rating: 5, feedback: "Very professional student profiles with verified skills. Great job team!", rawDate: "2026-08-16", date: "16 Aug 2026", time: "08:20 AM", status: "Resolved", avatar: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=100&auto=format&fit=crop&q=80" }
    ];

    // Generate remaining 1,238 mock items for real pagination feel
    const allFeedback = [...feedbackList];
    const statusOptions = ["New", "Reviewed", "Responded", "Resolved"];
    const names = ["Rohan Gupta", "Pooja Varma", "Manish Trivedi", "Kinjal Rathod", "Jaydeep Parmar", "Bhavin Soni", "Riddhi Zala", "Nirav Patel", "Aayushi Pandya", "Chirag Barot"];

    for (let i = 11; i <= 1248; i++) {
        const name = names[i % names.length];
        const email = name.toLowerCase().replace(" ", ".") + (i > 10 ? i : "") + "@gmail.com";
        const rating = (i % 7 === 0) ? 1 : (i % 5 === 0) ? 2 : (i % 4 === 0) ? 3 : (i % 2 === 0) ? 4 : 5;
        const stat = statusOptions[i % statusOptions.length];
        const dayOffset = (i % 25);
        const d = new Date(2026, 7, Math.max(1, 21 - dayOffset));
        const dayNum = d.getDate();
        const rawDate = `2026-08-${dayNum < 10 ? '0' : ''}${dayNum}`;
        const dateStr = `${dayNum} Aug 2026`;

        allFeedback.push({
            id: `FB-${1024 - i + 10}`,
            name: name,
            email: email,
            rating: rating,
            feedback: `Feedback from user regarding general platform responsiveness and application workflow.`,
            rawDate: rawDate,
            date: dateStr,
            time: "10:00 AM",
            status: stat,
            avatar: `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=2563eb&color=fff`
        });
    }

    // State
    let currentPage = 1;
    let pageSize = 10;
    let filteredData = [...allFeedback];
    let selectedItem = allFeedback[0];

    // DOM Elements
    const searchInput = document.getElementById("fbSearchInput");
    const filterRating = document.getElementById("fbFilterRating");
    const filterStatus = document.getElementById("fbFilterStatus");
    const filterDate = document.getElementById("fbFilterDate");
    const customDateGroup = document.getElementById("customDateGroup");
    const customStartDate = document.getElementById("customStartDate");
    const customEndDate = document.getElementById("customEndDate");
    const btnClear = document.getElementById("btnClearFbFilters");
    const tableBody = document.getElementById("feedbackTableBody");
    const pageSizeSelect = document.getElementById("fbPageSize");
    const entriesInfo = document.getElementById("fbEntriesInfo");
    const paginationNav = document.getElementById("fbPaginationNav");

    // Drawer Elements
    const drawerOverlay = document.getElementById("fbDrawerOverlay");
    const btnCloseDrawer = document.getElementById("btnCloseDrawer");
    const btnCancelDrawer = document.getElementById("btnCancelDrawer");
    const btnSendResponse = document.getElementById("btnSendResponse");
    const drawerId = document.getElementById("drawerId");
    const drawerName = document.getElementById("drawerName");
    const drawerEmail = document.getElementById("drawerEmail");
    const drawerAvatar = document.getElementById("drawerAvatar");
    const drawerStars = document.getElementById("drawerStars");
    const drawerDate = document.getElementById("drawerDate");
    const drawerStatusSelect = document.getElementById("drawerStatusSelect");
    const drawerFeedbackText = document.getElementById("drawerFeedbackText");
    const drawerAdminResponse = document.getElementById("drawerAdminResponse");

    // Helper to render stars
    function getStarsHtml(rating) {
        let stars = "";
        for (let i = 1; i <= 5; i++) {
            if (i <= rating) {
                stars += `<i class="fa-solid fa-star star-filled"></i>`;
            } else {
                stars += `<i class="fa-solid fa-star star-empty"></i>`;
            }
        }
        return stars;
    }

    // Date Range handler
    function handleDateRangeToggle() {
        if (filterDate && customDateGroup) {
            if (filterDate.value === "Custom") {
                customDateGroup.style.display = "flex";
            } else {
                customDateGroup.style.display = "none";
            }
        }
    }

    function getDateBounds(dateVal) {
        if (dateVal === "All") return null;

        const recordDates = allFeedback.map(item => item.rawDate).sort();
        const referenceDate = recordDates.length ? recordDates[recordDates.length - 1] : "2026-08-21";
        const reference = new Date(referenceDate + "T00:00:00");
        const formatDate = date => date.toISOString().slice(0, 10);

        if (dateVal === "Custom") {
            let start = customStartDate && customStartDate.value ? customStartDate.value : "";
            let end = customEndDate && customEndDate.value ? customEndDate.value : "";
            if (!start && !end) return null;
            if (start && end && start > end) {
                const temp = start;
                start = end;
                end = temp;
            }
            return { start, end };
        }

        const end = formatDate(reference);
        const startDate = new Date(reference);
        const days = dateVal === "Yesterday" ? 1 : dateVal === "Last 7 Days" ? 6 : dateVal === "Last 30 Days" ? 29 : 0;
        startDate.setDate(startDate.getDate() - days);
        const start = formatDate(startDate);
        return dateVal === "Yesterday" ? { start, end: start } : { start, end };
    }

    // Comprehensive Filtering Logic
    function applyFilters() {
        const query = searchInput ? searchInput.value.toLowerCase().trim() : "";
        const ratingVal = filterRating ? filterRating.value : "All";
        const statusVal = filterStatus ? filterStatus.value : "All";
        const dateVal = filterDate ? filterDate.value : "All";

        const dateBounds = getDateBounds(dateVal);

        filteredData = allFeedback.filter(item => {
            // Text Search
            const matchesQuery = !query || item.name.toLowerCase().includes(query) || item.email.toLowerCase().includes(query) || item.feedback.toLowerCase().includes(query);
            
            // Rating
            const matchesRating = (ratingVal === "All" || item.rating.toString() === ratingVal);
            
            // Status
            const matchesStatus = (statusVal === "All" || item.status === statusVal);

            // Date Filter
            const matchesDate = !dateBounds ||
                ((!dateBounds.start || item.rawDate >= dateBounds.start) &&
                 (!dateBounds.end || item.rawDate <= dateBounds.end));

            return matchesQuery && matchesRating && matchesStatus && matchesDate;
        });

        currentPage = 1;
        renderTable();
    }

    // Render Table
    function renderTable() {
        if (!tableBody) return;

        const totalItems = filteredData.length;
        const totalPages = Math.ceil(totalItems / pageSize) || 1;

        if (currentPage > totalPages) currentPage = totalPages;
        if (currentPage < 1) currentPage = 1;

        const startIndex = (currentPage - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, totalItems);
        const pageItems = filteredData.slice(startIndex, endIndex);

        if (pageItems.length === 0) {
            tableBody.innerHTML = `
                <tr>
                    <td colspan="6" style="text-align: center; padding: 36px; color: #64748b;">
                        No feedback found matching your criteria.
                    </td>
                </tr>
            `;
        } else {
            let rowsHtml = "";
            pageItems.forEach(item => {
                const statusClass = item.status === "New" ? "status-new" :
                                    item.status === "Reviewed" ? "status-reviewed" :
                                    item.status === "Responded" ? "status-responded" : "status-resolved";

                rowsHtml += `
                    <tr>
                        <td>
                            <div class="fb-user-cell">
                                <img src="${item.avatar}" alt="${item.name}" class="fb-avatar" onerror="this.src='https://ui-avatars.com/api/?name=${encodeURIComponent(item.name)}&background=e2e8f0&color=333'" />
                                <div>
                                    <span class="fb-user-name">${item.name}</span>
                                    <span class="fb-user-email">${item.email}</span>
                                </div>
                            </div>
                        </td>
                        <td>
                            <div class="fb-table-stars">${getStarsHtml(item.rating)}</div>
                        </td>
                        <td>
                            <div class="fb-feedback-snippet" title="${item.feedback}">“${item.feedback}”</div>
                        </td>
                        <td>${item.date}</td>
                        <td>
                            <span class="fb-status-pill ${statusClass}">${item.status}</span>
                        </td>
                        <td style="text-align: right;">
                            <button type="button" class="fb-btn-view" data-id="${item.id}">
                                <i class="fa-regular fa-eye"></i> View
                            </button>
                        </td>
                    </tr>
                `;
            });
            tableBody.innerHTML = rowsHtml;
        }

        // Entries Info
        if (entriesInfo) {
            if (totalItems === 0) {
                entriesInfo.textContent = "Showing 0 to 0 of 0 entries";
            } else {
                entriesInfo.textContent = `Showing ${startIndex + 1}–${endIndex} of ${totalItems.toLocaleString()} entries`;
            }
        }

        // Render Pagination
        renderPagination(totalPages);

        // Attach View Buttons
        const viewBtns = tableBody.querySelectorAll(".fb-btn-view");
        viewBtns.forEach(btn => {
            btn.addEventListener("click", function () {
                const id = this.getAttribute("data-id");
                const found = allFeedback.find(f => f.id === id);
                if (found) openDrawer(found);
            });
        });
    }

    // Render Pagination
    function renderPagination(totalPages) {
        if (!paginationNav) return;

        let navHtml = "";
        const isPrevDisabled = currentPage === 1;
        navHtml += `<button type="button" class="page-btn page-nav-btn" ${isPrevDisabled ? "disabled style='opacity:0.4; cursor:not-allowed;'" : ""} id="btnFbPrev" title="Previous"><i class="fa-solid fa-chevron-left"></i></button>`;

        function addBtn(p) {
            navHtml += `<button type="button" class="page-btn ${p === currentPage ? "active" : ""}" data-page="${p}">${p}</button>`;
        }
        function addDots() {
            navHtml += `<span class="page-ellipsis">...</span>`;
        }

        if (totalPages <= 7) {
            for (let i = 1; i <= totalPages; i++) addBtn(i);
        } else {
            if (currentPage <= 4) {
                for (let i = 1; i <= 5; i++) addBtn(i);
                addDots();
                addBtn(totalPages);
            } else if (currentPage >= totalPages - 3) {
                addBtn(1);
                addDots();
                for (let i = totalPages - 4; i <= totalPages; i++) addBtn(i);
            } else {
                addBtn(1);
                addDots();
                addBtn(currentPage - 1);
                addBtn(currentPage);
                addBtn(currentPage + 1);
                addDots();
                addBtn(totalPages);
            }
        }

        const isNextDisabled = currentPage === totalPages || totalPages === 0;
        navHtml += `<button type="button" class="page-btn page-nav-btn" ${isNextDisabled ? "disabled style='opacity:0.4; cursor:not-allowed;'" : ""} id="btnFbNext" title="Next"><i class="fa-solid fa-chevron-right"></i></button>`;

        paginationNav.innerHTML = navHtml;

        // Page click handlers
        paginationNav.querySelectorAll(".page-btn[data-page]").forEach(btn => {
            btn.addEventListener("click", function () {
                const p = parseInt(this.getAttribute("data-page"), 10);
                if (p && p !== currentPage) {
                    currentPage = p;
                    renderTable();
                }
            });
        });

        const prevBtn = document.getElementById("btnFbPrev");
        if (prevBtn && !isPrevDisabled) {
            prevBtn.addEventListener("click", function () {
                if (currentPage > 1) {
                    currentPage--;
                    renderTable();
                }
            });
        }

        const nextBtn = document.getElementById("btnFbNext");
        if (nextBtn && !isNextDisabled) {
            nextBtn.addEventListener("click", function () {
                if (currentPage < totalPages) {
                    currentPage++;
                    renderTable();
                }
            });
        }
    }

    // Drawer Controls
    function openDrawer(item) {
        selectedItem = item;
        if (drawerId) drawerId.textContent = `#${item.id}`;
        if (drawerName) drawerName.textContent = item.name;
        if (drawerEmail) drawerEmail.textContent = item.email;
        if (drawerAvatar) drawerAvatar.src = item.avatar;
        if (drawerStars) drawerStars.innerHTML = getStarsHtml(item.rating);
        if (drawerDate) drawerDate.textContent = `${item.date}, ${item.time || "10:30 AM"}`;
        if (drawerStatusSelect) drawerStatusSelect.value = item.status;
        if (drawerFeedbackText) drawerFeedbackText.textContent = `“${item.feedback}”`;
        if (drawerAdminResponse) drawerAdminResponse.value = "";

        if (drawerOverlay) {
            drawerOverlay.classList.add("active");
            document.body.style.overflow = "hidden";
        }
    }

    function closeDrawer() {
        if (drawerOverlay) {
            drawerOverlay.classList.remove("active");
            document.body.style.overflow = "";
        }
    }

    if (btnCloseDrawer) btnCloseDrawer.addEventListener("click", closeDrawer);
    if (btnCancelDrawer) btnCancelDrawer.addEventListener("click", closeDrawer);
    if (drawerOverlay) {
        drawerOverlay.addEventListener("click", function (e) {
            if (e.target === drawerOverlay) closeDrawer();
        });
    }

    if (btnSendResponse) {
        btnSendResponse.addEventListener("click", function () {
            const resp = drawerAdminResponse ? drawerAdminResponse.value.trim() : "";
            if (!resp) {
                simsAlert("Please enter a response message before sending.", {
                    type: "warning",
                    title: "Response Required",
                    btnText: "Got it"
                });
                return;
            }
            if (selectedItem) {
                selectedItem.status = "Responded";
                if (drawerStatusSelect) drawerStatusSelect.value = "Responded";
            }
            closeDrawer();
            renderTable();
            simsToast(
                "Response sent successfully to " + selectedItem.name + "!",
                "success",
                "Response Sent",
                4000
            );
        });
    }

    // Filter Events
    if (searchInput) searchInput.addEventListener("input", applyFilters);
    if (filterRating) filterRating.addEventListener("change", applyFilters);
    if (filterStatus) filterStatus.addEventListener("change", applyFilters);
    
    if (filterDate) {
        filterDate.addEventListener("change", function () {
            handleDateRangeToggle();
            applyFilters();
        });
    }

    if (customStartDate) customStartDate.addEventListener("change", applyFilters);
    if (customEndDate) customEndDate.addEventListener("change", applyFilters);

    if (btnClear) {
        btnClear.addEventListener("click", function () {
            if (searchInput) searchInput.value = "";
            if (filterRating) filterRating.value = "All";
            if (filterStatus) filterStatus.value = "All";
            if (filterDate) filterDate.value = "All";
            if (customStartDate) customStartDate.value = "";
            if (customEndDate) customEndDate.value = "";
            if (pageSizeSelect) pageSizeSelect.value = "10";
            pageSize = 10;
            handleDateRangeToggle();
            applyFilters();
        });
    }

    if (pageSizeSelect) {
        pageSizeSelect.addEventListener("change", function () {
            pageSize = parseInt(this.value, 10) || 10;
            currentPage = 1;
            renderTable();
        });
    }

    // Initial render
    renderTable();
});

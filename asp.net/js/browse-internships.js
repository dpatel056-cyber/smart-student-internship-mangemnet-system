document.addEventListener('DOMContentLoaded', () => {

  const PER_PAGE = 12;

  /* =========================================================
     Metadata
  ========================================================= */
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
    "education": "Education"
  };
  const CATEGORY_ORDER = Object.keys(CATEGORY_LABELS);

  const LOCATION_LABELS = {
    bengaluru:"Bengaluru", hyderabad:"Hyderabad", mumbai:"Mumbai", gurugram:"Gurugram",
    pune:"Pune", noida:"Noida", chennai:"Chennai", remote:"Remote"
  };

  /* =========================================================
     State
  ========================================================= */
  const state = {
    keyword: "",
    category: "",
    location: "",
    durations: new Set(),
    stipends: new Set(),
    modes: new Set(),
    sort: "newest",
    page: 1
  };

  const savedKey = 'simsSavedInternships';
  function getSaved() {
    try { return new Set(JSON.parse(localStorage.getItem(savedKey)) || []); }
    catch (e) { return new Set(); }
  }
  function setSaved(set) {
    localStorage.setItem(savedKey, JSON.stringify([...set]));
  }
  let savedIds = getSaved();

  /* =========================================================
     Populate selects and checkboxes
  ========================================================= */
  const topLocation = document.getElementById('topLocation');
  const sideCategory = document.getElementById('sideCategory');
  const durationChecksEl = document.getElementById('durationChecks');
  const modeChecksEl = document.getElementById('modeChecks');

  CATEGORY_ORDER.forEach(key => {
    const opt = document.createElement('option');
    opt.value = key; opt.textContent = CATEGORY_LABELS[key];
    sideCategory.appendChild(opt);
  });

  Object.keys(LOCATION_LABELS).forEach(key => {
    const opt = document.createElement('option');
    opt.value = key; opt.textContent = LOCATION_LABELS[key];
    topLocation.appendChild(opt);
  });

  DURATION_BUCKETS.forEach(d => {
    const label = document.createElement('label');
    label.className = 'im-checkbox-item';
    label.innerHTML = `<input type="checkbox" data-group="duration" data-value="${d.key}"> ${d.label}`;
    durationChecksEl.appendChild(label);
  });

  MODE_OPTIONS.forEach(m => {
    const label = document.createElement('label');
    label.className = 'im-checkbox-item';
    label.innerHTML = `<input type="checkbox" data-group="mode" data-value="${m.key}"> ${m.label}`;
    modeChecksEl.appendChild(label);
  });

  /* =========================================================
     Filters Sync & Events
  ========================================================= */
  const topKeywordInput = document.getElementById('topKeywordInput');
  const topSearchBtn = document.getElementById('topSearchBtn');

  function applyKeyword(value) {
    state.keyword = value.trim().toLowerCase();
    topKeywordInput.value = value;
    state.page = 1;
    render();
  }

  topKeywordInput.addEventListener('keydown', (e) => { if (e.key === 'Enter') applyKeyword(topKeywordInput.value); });
  topSearchBtn.addEventListener('click', () => applyKeyword(topKeywordInput.value));

  sideCategory.addEventListener('change', () => {
    state.category = sideCategory.value;
    state.page = 1; render();
  });

  topLocation.addEventListener('change', () => {
    state.location = topLocation.value;
    state.page = 1; render();
  });

  durationChecksEl.addEventListener('change', (e) => {
    const cb = e.target;
    if (cb.checked) state.durations.add(cb.dataset.value);
    else state.durations.delete(cb.dataset.value);
    state.page = 1; render();
  });

  modeChecksEl.addEventListener('change', (e) => {
    const cb = e.target;
    if (cb.checked) state.modes.add(cb.dataset.value);
    else state.modes.delete(cb.dataset.value);
    state.page = 1; render();
  });

  document.getElementById('stipendChecks').addEventListener('change', (e) => {
    const cb = e.target;
    if (cb.checked) state.stipends.add(cb.dataset.value);
    else state.stipends.delete(cb.dataset.value);
    state.page = 1; render();
  });

  const sortBySelect = document.getElementById('sortBySelect');
  sortBySelect.addEventListener('change', () => {
    state.sort = sortBySelect.value;
    state.page = 1; render();
  });

  function clearFilters() {
    state.keyword = ""; state.category = ""; state.location = "";
    state.durations.clear(); state.stipends.clear(); state.modes.clear();
    state.sort = "newest"; state.page = 1;

    topKeywordInput.value = "";
    sideCategory.value = "";
    topLocation.value = "";
    sortBySelect.value = "newest";

    document.querySelectorAll('.im-filters input[type="checkbox"]').forEach(cb => cb.checked = false);

    render();
  }

  document.getElementById('clearFiltersBtn').addEventListener('click', clearFilters);
  document.getElementById('resetEmptyBtn').addEventListener('click', clearFilters);

  /* =========================================================
     Filtering + sorting logic
  ========================================================= */
  const DURATION_ORDER_MAP = {};
  DURATION_BUCKETS.forEach((d, i) => { DURATION_ORDER_MAP[d.key] = i; });

  function getFiltered() {
    const activeData = window.GlobalStore ? window.GlobalStore.getInternships() : (window.INTERNSHIPS_DATA || []);
    let list = activeData.filter(item => {
      if (state.keyword) {
        const hay = (item.title + ' ' + item.company + ' ' + item.categoryLabel).toLowerCase();
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
      case 'stipend-desc': list.sort((a, b) => b.stipend - a.stipend); break;
      case 'stipend-asc': list.sort((a, b) => a.stipend - b.stipend); break;
      default: list.sort((a, b) => a.postedDaysAgo - b.postedDaysAgo);
    }
    return list;
  }

  /* =========================================================
     Rendering
  ========================================================= */
  const gridEl = document.getElementById('internshipsGrid');
  const resultCountEl = document.getElementById('resultCount');
  const paginationEl = document.getElementById('pagination');
  const noResultsEl = document.getElementById('noResults');

  function logoHtml(icon) {
    if (icon.type === 'fa') {
      return `<div class="im-company-logo" style="background:${icon.color}18;color:${icon.color}"><i class="${icon.value}"></i></div>`;
    }
        if (icon.type === 'img') {
      return `<img src="${icon.url}" alt="logo" style="width:100%;height:100%;object-fit:contain;border-radius:inherit;">`;
    }
    return `<div class="im-company-logo" style="background:${icon.bg};color:${icon.color}">${icon.value}</div>`;
  }

  function modeIcon(modeKey) {
    if (modeKey === 'wfh') return 'fa-house';
    if (modeKey === 'hybrid') return 'fa-building-user';
    return 'fa-building';
  }

  function cardHtml(item) {
    const isSaved = savedIds.has(item.id);
    return `
      <div class="im-card" data-id="${item.id}">
        <div class="im-card-head">
          ${logoHtml(item.companyIcon)}
          <button class="im-save-btn ${isSaved ? 'saved' : ''}" data-id="${item.id}" aria-label="Save Internship">
            <i class="fa-${isSaved ? 'solid' : 'regular'} fa-bookmark"></i>
          </button>
        </div>
        <h3 class="im-card-title">${item.title}</h3>
        <div class="im-card-company">
          ${item.company}
        </div>
        
        <div class="im-card-meta">
          <div class="im-meta-item"><i class="fa-solid fa-location-dot"></i> ${item.location.split(',')[0]}</div>
          <div class="im-meta-item"><i class="fa-solid ${modeIcon(item.modeKey)}"></i> ${item.modeLabel}</div>
          <div class="im-meta-item"><i class="fa-regular fa-clock"></i> ${item.durationLabel}</div>
          <div class="im-meta-item"><i class="fa-solid fa-indian-rupee-sign"></i> ${item.stipendType === 'paid' ? '₹' + item.stipend.toLocaleString() : 'Unpaid'}</div>
        </div>
        
        <div class="im-card-footer">
          <div class="im-badge ${item.stipendType === 'paid' ? 'success' : 'primary'}">${item.stipendType === 'paid' ? 'Paid' : 'Unpaid'}</div>
          <div class="im-card-actions">
            <a href="internship-details.html?id=${item.id}" class="btn btn-primary" style="padding: 8px 16px; font-size: 13px;">View Details</a>
          </div>
        </div>
      </div>`;
  }

  function render() {
    const filtered = getFiltered();
    const total = filtered.length;
    const totalPages = Math.max(1, Math.ceil(total / PER_PAGE));
    if (state.page > totalPages) state.page = totalPages;

    const start = (state.page - 1) * PER_PAGE;
    const pageItems = filtered.slice(start, start + PER_PAGE);

    gridEl.innerHTML = pageItems.map(cardHtml).join('');
    noResultsEl.style.display = total === 0 ? 'block' : 'none';
    gridEl.style.display = total === 0 ? 'none' : 'grid';

    const activeDataCount = window.GlobalStore ? window.GlobalStore.getInternships().length : (window.INTERNSHIPS_DATA ? window.INTERNSHIPS_DATA.length : 0);
    resultCountEl.textContent = total === 0
      ? `Showing 0 of ${activeDataCount} internships`
      : `Showing ${start + 1}-${Math.min(start + PER_PAGE, total)} of ${total} internships`;

    renderPagination(totalPages);

    gridEl.querySelectorAll('.im-save-btn').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.preventDefault();
        const id = parseInt(btn.dataset.id, 10);
        const icon = btn.querySelector('i');
        if (savedIds.has(id)) {
          savedIds.delete(id);
          btn.classList.remove('saved');
          icon.classList.remove('fa-solid');
          icon.classList.add('fa-regular');
          showToast('Removed from saved internships.');
        } else {
          savedIds.add(id);
          btn.classList.add('saved');
          icon.classList.add('fa-solid');
          icon.classList.remove('fa-regular');
          showToast('Saved to your bookmarks!');
        }
        setSaved(savedIds);
      });
    });
  }

  function renderPagination(totalPages) {
    if (totalPages <= 1) { paginationEl.innerHTML = ''; return; }
    let html = '';
    html += `<button class="page-btn" data-page="prev" ${state.page === 1 ? 'disabled' : ''}><i class="fa-solid fa-chevron-left"></i></button>`;

    const maxButtons = 5;
    let startPage = Math.max(1, state.page - 2);
    let endPage = Math.min(totalPages, startPage + maxButtons - 1);
    startPage = Math.max(1, endPage - maxButtons + 1);

    if (startPage > 1) {
      html += `<button class="page-btn" data-page="1">1</button>`;
      if (startPage > 2) html += `<span class="page-ellipsis">...</span>`;
    }
    for (let p = startPage; p <= endPage; p++) {
      html += `<button class="page-btn ${p === state.page ? 'active' : ''}" data-page="${p}">${p}</button>`;
    }
    if (endPage < totalPages) {
      if (endPage < totalPages - 1) html += `<span class="page-ellipsis">...</span>`;
      html += `<button class="page-btn" data-page="${totalPages}">${totalPages}</button>`;
    }
    html += `<button class="page-btn" data-page="next" ${state.page === totalPages ? 'disabled' : ''}><i class="fa-solid fa-chevron-right"></i></button>`;

    paginationEl.innerHTML = html;

    paginationEl.querySelectorAll('.page-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        if (btn.disabled) return;
        const val = btn.dataset.page;
        if (val === 'prev') state.page -= 1;
        else if (val === 'next') state.page += 1;
        else state.page = parseInt(val, 10);
        render();
        window.scrollTo({ top: 0, behavior: 'smooth' });
      });
    });
  }

  const dashToast = document.getElementById('dashToast');
  const dashToastMsg = document.getElementById('dashToastMsg');
  let toastTimer = null;
  function showToast(message) {
    if (!dashToast) return;
    dashToastMsg.textContent = message;
    dashToast.classList.add('show', 'success');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => dashToast.classList.remove('show'), 2800);
  }

  // Init
  render();
});

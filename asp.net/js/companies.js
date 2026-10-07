document.addEventListener('DOMContentLoaded', () => {
  const PER_PAGE = 9;

  const INDUSTRY_LABELS = {
    'it-services': 'Information Technology',
    finance: 'Finance',
    marketing: 'Marketing',
    design: 'Design',
    education: 'Education',
    technology: 'Technology / Internet',
    consulting: 'Consulting',
    ecommerce: 'E-commerce',
    healthcare: 'Healthcare',
    manufacturing: 'Manufacturing'
  };

  const INDUSTRY_ORDER = ['it-services', 'finance', 'marketing', 'design', 'education', 'technology', 'consulting', 'ecommerce', 'healthcare', 'manufacturing'];
  const LOCATION_LABELS = { bengaluru: 'Bengaluru', hyderabad: 'Hyderabad', mumbai: 'Mumbai', gurugram: 'Gurugram', pune: 'Pune', noida: 'Noida', chennai: 'Chennai', remote: 'Remote' };
  const SIZE_ORDER = ['51-200', '201-1000', '1000-5000', '5000+'];

  function foundedBucket(year) {
    if (!year) return '2016-present';
    if (year < 1950) return 'before-1950';
    if (year <= 1999) return '1950-1999';
    if (year <= 2010) return '2000-2010';
    if (year <= 2015) return '2011-2015';
    return '2016-present';
  }

  const FOUNDED_LABELS = {
    'before-1950': 'Before 1950',
    '1950-1999': '1950 - 1999',
    '2000-2010': '2000 - 2010',
    '2011-2015': '2011 - 2015',
    '2016-present': '2016 - Present'
  };
  const FOUNDED_ORDER = Object.keys(FOUNDED_LABELS);

  function getDataset() {
    if (window.GlobalStore && typeof window.GlobalStore.getCompanies === 'function') {
      const companies = window.GlobalStore.getCompanies();
      if (Array.isArray(companies) && companies.length) return companies;
    }
    if (Array.isArray(window.COMPANIES_DATA) && window.COMPANIES_DATA.length) return window.COMPANIES_DATA;
    return [];
  }

  const rawCompanies = getDataset().map((c, idx) => ({
    ...c,
    id: c.id || idx + 1,
    foundedKey: c.foundedKey || foundedBucket(c.founded),
    icon: c.icon || c.logo || { type: 'img', url: '../assets/logo-default.png' },
    tag: c.tag || c.ind || 'Company',
    openings: Number(c.openings || 0),
    popularity: Number(c.popularity || 0)
  }));

  if (!rawCompanies.length) return;

  const state = {
    search: '',
    industries: new Set(),
    locations: new Set(),
    sizes: new Set(),
    founded: new Set(),
    sort: 'popularity',
    page: 1
  };

  const industryCounts = {};
  const locationCounts = {};
  const sizeCounts = {};
  const foundedCounts = {};
  rawCompanies.forEach((c) => {
    industryCounts[c.category] = (industryCounts[c.category] || 0) + 1;
    locationCounts[c.locationKey] = (locationCounts[c.locationKey] || 0) + 1;
    sizeCounts[c.size] = (sizeCounts[c.size] || 0) + 1;
    foundedCounts[c.foundedKey] = (foundedCounts[c.foundedKey] || 0) + 1;
  });

  const industryListEl = document.getElementById('industryList');
  const locationListEl = document.getElementById('locationList');
  const sizeListEl = document.getElementById('sizeList');
  const foundedListEl = document.getElementById('foundedList');
  const topIndustrySelect = document.getElementById('topIndustry');
  const topLocationSelect = document.getElementById('topLocation');
  const topSizeSelect = document.getElementById('topSize');
  const searchInput = document.getElementById('companySearchInput');
  const searchBtn = document.getElementById('companySearchBtn');
  const sortSelect = document.getElementById('sortBySelect');
  const gridEl = document.getElementById('companiesGrid');
  const resultCountEl = document.getElementById('resultCount');
  const paginationEl = document.getElementById('pagination');
  const noResultsEl = document.getElementById('noResults');

  function buildCheckboxList(container, items, counts, group, showMoreAfter) {
    if (!container) return;
    container.innerHTML = '';
    const allLi = document.createElement('label');
    allLi.className = 'filter-check all-check';
    allLi.innerHTML = `<input type="checkbox" checked data-group="${group}" data-all="1"> <span>All ${group === 'industry' ? 'Industries' : group === 'location' ? 'Locations' : group === 'size' ? 'Sizes' : 'Years'}</span> <em>${rawCompanies.length}</em>`;
    container.appendChild(allLi);

    items.forEach((key, idx) => {
      const label = group === 'industry' ? INDUSTRY_LABELS[key] : group === 'location' ? LOCATION_LABELS[key] : group === 'founded' ? FOUNDED_LABELS[key] : `${key} Employees`;
      const li = document.createElement('label');
      li.className = 'filter-check';
      if (showMoreAfter !== undefined && idx >= showMoreAfter) li.classList.add('extra-item');
      li.innerHTML = `<input type="checkbox" data-group="${group}" data-value="${key}"> <span>${label}</span> <em>${counts[key] || 0}</em>`;
      container.appendChild(li);
    });
  }

  buildCheckboxList(industryListEl, INDUSTRY_ORDER, industryCounts, 'industry', 5);
  buildCheckboxList(locationListEl, Object.keys(LOCATION_LABELS), locationCounts, 'location');
  buildCheckboxList(sizeListEl, SIZE_ORDER, sizeCounts, 'size');
  buildCheckboxList(foundedListEl, FOUNDED_ORDER, foundedCounts, 'founded');
  if (industryListEl) industryListEl.querySelectorAll('.extra-item').forEach((el) => (el.style.display = 'none'));

  INDUSTRY_ORDER.forEach((key) => {
    const opt = document.createElement('option');
    opt.value = key;
    opt.textContent = INDUSTRY_LABELS[key];
    topIndustrySelect?.appendChild(opt);
  });
  Object.keys(LOCATION_LABELS).forEach((key) => {
    const opt = document.createElement('option');
    opt.value = key;
    opt.textContent = LOCATION_LABELS[key];
    topLocationSelect?.appendChild(opt);
  });
  SIZE_ORDER.forEach((key) => {
    const opt = document.createElement('option');
    opt.value = key;
    opt.textContent = `${key} Employees`;
    topSizeSelect?.appendChild(opt);
  });

  function groupToStateKey(group) {
    return group === 'industry' ? 'industries' : group === 'location' ? 'locations' : group === 'size' ? 'sizes' : 'founded';
  }

  function syncCheckboxes(group) {
    const container = group === 'industry' ? industryListEl : group === 'location' ? locationListEl : group === 'size' ? sizeListEl : foundedListEl;
    if (!container) return;
    const selected = state[groupToStateKey(group)];
    const allBox = container.querySelector('[data-all="1"]');
    if (allBox) allBox.checked = selected.size === 0;
    container.querySelectorAll('input[data-value]').forEach((cb) => {
      cb.checked = selected.has(cb.dataset.value);
    });
  }

  function syncTopSelect(group) {
    if (group === 'founded') return;
    const select = group === 'industry' ? topIndustrySelect : group === 'location' ? topLocationSelect : topSizeSelect;
    if (!select) return;
    const selected = state[groupToStateKey(group)];
    select.value = selected.size === 1 ? [...selected][0] : '';
  }

  function setGroupSelection(group, keys) {
    state[groupToStateKey(group)] = new Set(keys);
    syncCheckboxes(group);
    syncTopSelect(group);
    state.page = 1;
    render();
  }

  [industryListEl, locationListEl, sizeListEl, foundedListEl].forEach((container) => {
    container?.addEventListener('change', (e) => {
      const input = e.target;
      if (!input || input.tagName !== 'INPUT') return;
      const group = input.dataset.group;
      const selected = state[groupToStateKey(group)];
      if (input.dataset.all === '1') {
        selected.clear();
      } else if (input.checked) {
        selected.add(input.dataset.value);
      } else {
        selected.delete(input.dataset.value);
      }
      setGroupSelection(group, [...selected]);
    });
  });

  topIndustrySelect?.addEventListener('change', () => setGroupSelection('industry', topIndustrySelect.value ? [topIndustrySelect.value] : []));
  topLocationSelect?.addEventListener('change', () => setGroupSelection('location', topLocationSelect.value ? [topLocationSelect.value] : []));
  topSizeSelect?.addEventListener('change', () => setGroupSelection('size', topSizeSelect.value ? [topSizeSelect.value] : []));

  document.querySelectorAll('.filter-accordion-head').forEach((head) => {
    head.addEventListener('click', () => head.closest('.filter-section')?.classList.toggle('collapsed'));
  });

  function applySearch() {
    state.search = (searchInput?.value || '').trim().toLowerCase();
    state.page = 1;
    render();
  }

  searchBtn?.addEventListener('click', applySearch);
  searchInput?.addEventListener('keydown', (e) => { if (e.key === 'Enter') applySearch(); });
  searchInput?.addEventListener('input', applySearch);
  sortSelect?.addEventListener('change', () => { state.sort = sortSelect.value; state.page = 1; render(); });

  function getFilteredCompanies() {
    let list = rawCompanies.filter((c) => {
      if (state.search) {
        const hay = `${c.name} ${c.tag} ${c.location}`.toLowerCase();
        if (!hay.includes(state.search)) return false;
      }
      if (state.industries.size && !state.industries.has(c.category)) return false;
      if (state.locations.size && !state.locations.has(c.locationKey)) return false;
      if (state.sizes.size && !state.sizes.has(c.size)) return false;
      if (state.founded.size && !state.founded.has(c.foundedKey)) return false;
      return true;
    });

    switch (state.sort) {
      case 'name-asc':
        list.sort((a, b) => a.name.localeCompare(b.name));
        break;
      case 'openings-desc':
        list.sort((a, b) => b.openings - a.openings);
        break;
      case 'newest':
        list.sort((a, b) => (b.founded || 0) - (a.founded || 0));
        break;
      default:
        list.sort((a, b) => (b.popularity || 0) - (a.popularity || 0));
    }
    return list;
  }

  function iconHtml(icon) {
    const value = icon?.value || '';
    if (icon?.type === 'fa') {
      return `<span class="company-logo" style="background:${icon.color || '#2563eb'}18;color:${icon.color || '#2563eb'}"><i class="${value}"></i></span>`;
    }
    if (icon?.type === 'img') {
      return `<img src="${icon.url}" alt="${icon.alt || 'logo'}" class="company-logo-img">`;
    }
    return `<span class="company-logo" style="background:#eff6ff;color:#2563eb">C</span>`;
  }

  function cardHtml(c) {
    return `
      <div class="company-card">
        ${c.icon?.type === 'img' ? `<img src="${c.icon.url}" alt="${c.name}" class="company-logo-img">` : `<span class="company-logo" style="background:#eff6ff;color:#2563eb">${(c.name || '?').charAt(0)}</span>`}
        <h4 class="company-name">${c.name}</h4>
        <p class="company-tag">${c.tag}</p>
        <p class="company-meta"><i class="fa-solid fa-location-dot"></i> ${c.location}</p>
        <p class="company-meta"><i class="fa-solid fa-briefcase"></i> ${c.openings} Openings</p>
      </div>`;
  }

  function renderPagination(totalPages) {
    if (!paginationEl) return;
    if (totalPages <= 1) {
      paginationEl.innerHTML = '';
      return;
    }
    let html = `<button class="page-btn" data-page="prev" ${state.page === 1 ? 'disabled' : ''}><i class="fa-solid fa-chevron-left"></i></button>`;
    for (let p = 1; p <= totalPages; p++) {
      html += `<button class="page-btn ${p === state.page ? 'active' : ''}" data-page="${p}">${p}</button>`;
    }
    html += `<button class="page-btn" data-page="next" ${state.page === totalPages ? 'disabled' : ''}><i class="fa-solid fa-chevron-right"></i></button>`;
    paginationEl.innerHTML = html;
    paginationEl.querySelectorAll('.page-btn').forEach((btn) => {
      btn.addEventListener('click', () => {
        if (btn.disabled) return;
        const val = btn.dataset.page;
        if (val === 'prev') state.page -= 1;
        else if (val === 'next') state.page += 1;
        else state.page = parseInt(val, 10);
        render();
      });
    });
  }

  function render() {
    const filtered = getFilteredCompanies();
    const total = filtered.length;
    const totalPages = Math.max(1, Math.ceil(total / PER_PAGE));
    if (state.page > totalPages) state.page = totalPages;
    const start = (state.page - 1) * PER_PAGE;
    const pageItems = filtered.slice(start, start + PER_PAGE);
    if (gridEl) gridEl.innerHTML = pageItems.map(cardHtml).join('');
    if (noResultsEl) noResultsEl.style.display = total === 0 ? 'block' : 'none';
    if (gridEl) gridEl.style.display = total === 0 ? 'none' : 'grid';
    if (resultCountEl) {
      resultCountEl.textContent = total === 0 ? `Showing 0 of ${rawCompanies.length} companies` : `Showing ${start + 1}-${Math.min(start + PER_PAGE, total)} of ${total} companies`;
    }
    renderPagination(totalPages);
  }

  document.getElementById('resetFiltersBtn')?.addEventListener('click', () => {
    state.search = '';
    state.industries.clear();
    state.locations.clear();
    state.sizes.clear();
    state.founded.clear();
    state.sort = 'popularity';
    state.page = 1;
    if (searchInput) searchInput.value = '';
    if (sortSelect) sortSelect.value = 'popularity';
    syncCheckboxes('industry');
    syncCheckboxes('location');
    syncCheckboxes('size');
    syncCheckboxes('founded');
    syncTopSelect('industry');
    syncTopSelect('location');
    syncTopSelect('size');
    render();
  });

  render();
});

/* ============================================================
   SIMS - Module 2 : Experience & Projects page JavaScript
   One shared Add/Edit modal + one shared card renderer drives
   all 4 tabs: projects, experience, certificates, achievements.
============================================================ */
document.addEventListener('pmChromeReady', () => {

  let profile = PMData.getProfile();
  let activeTab = 'projects';
  let editingItemId = null;
  let deletingItemId = null;

  const TAB_CONFIG = {
    projects: {
      icon: 'fa-diagram-project', iconClass: 'icon-blue',
      titleLabel: 'Project Title', titlePlaceholder: 'e.g. Smart Attendance System',
      metaLabel: 'Tech Stack', metaPlaceholder: 'e.g. Python, OpenCV, Flask',
      dateLabel: 'Year', datePlaceholder: 'e.g. 2025',
      addTitle: 'Add Project', editTitle: 'Edit Project',
      modalSub: 'Share the details of your academic project.',
      emptyIcon: 'fa-diagram-project', emptyText: 'No academic projects added yet.'
    },
    experience: {
      icon: 'fa-briefcase', iconClass: 'icon-green',
      titleLabel: 'Role / Position', titlePlaceholder: 'e.g. Frontend Developer Intern',
      metaLabel: 'Company Name', metaPlaceholder: 'e.g. TechNova Pvt Ltd',
      dateLabel: 'Duration', datePlaceholder: 'e.g. Jun 2025 - Aug 2025',
      addTitle: 'Add Experience', editTitle: 'Edit Experience',
      modalSub: 'Share details of your internship or work experience.',
      emptyIcon: 'fa-briefcase', emptyText: 'No internship experience added yet.'
    },
    certificates: {
      icon: 'fa-certificate', iconClass: 'icon-purple',
      titleLabel: 'Certificate Title', titlePlaceholder: 'e.g. AWS Cloud Practitioner',
      metaLabel: 'Issuing Organization', metaPlaceholder: 'e.g. Amazon Web Services',
      dateLabel: 'Date Issued', datePlaceholder: 'e.g. Mar 2026',
      addTitle: 'Add Certificate', editTitle: 'Edit Certificate',
      modalSub: 'Add a course or professional certification.',
      emptyIcon: 'fa-certificate', emptyText: 'No certificates added yet.'
    },
    achievements: {
      icon: 'fa-trophy', iconClass: 'icon-orange',
      titleLabel: 'Achievement Title', titlePlaceholder: 'e.g. Winner - Smart India Hackathon 2025',
      metaLabel: 'Awarded By', metaPlaceholder: 'e.g. Government of India',
      dateLabel: 'Date', datePlaceholder: 'e.g. Dec 2025',
      addTitle: 'Add Achievement', editTitle: 'Edit Achievement',
      modalSub: 'Add an award, recognition or hackathon win.',
      emptyIcon: 'fa-trophy', emptyText: 'No achievements added yet.'
    }
  };

  function escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str || '';
    return div.innerHTML;
  }

  /* ---- Tab switching ---- */
  const tabBtns = document.querySelectorAll('.pm-tab-btn');
  const tabPanels = document.querySelectorAll('.pm-tab-panel');

  tabBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      activeTab = btn.dataset.tab;
      tabBtns.forEach(b => b.classList.toggle('active', b === btn));
      tabPanels.forEach(p => p.classList.toggle('active', p.dataset.panel === activeTab));
    });
  });

  /* ---- Render all lists + counts ---- */
  function renderList(type) {
    const cfg = TAB_CONFIG[type];
    const listEl = document.getElementById('list' + capitalize(type));
    const emptyEl = document.getElementById('empty' + capitalize(type));
    const countEl = document.getElementById('count' + capitalize(type));
    const items = profile[type] || [];

    countEl.textContent = items.length;

    if (!items.length) {
      listEl.innerHTML = '';
      emptyEl.style.display = 'block';
      return;
    }
    emptyEl.style.display = 'none';

    listEl.innerHTML = items.map(item => `
      <div class="pm-item-card" data-id="${item.id}">
        <div class="pm-item-main">
          <span class="pm-item-icon ${cfg.iconClass}"><i class="fa-solid ${cfg.icon}"></i></span>
          <div class="pm-item-body">
            <h4>${escapeHtml(item.title)}</h4>
            <div class="pm-item-meta">
              ${item.meta ? `<span><i class="fa-solid fa-building"></i> ${escapeHtml(item.meta)}</span>` : ''}
              ${item.date ? `<span><i class="fa-solid fa-calendar"></i> ${escapeHtml(item.date)}</span>` : ''}
            </div>
            ${item.description ? `<p class="pm-item-desc">${escapeHtml(item.description)}</p>` : ''}
          </div>
        </div>
        <div class="pm-item-actions">
          <button type="button" class="pm-icon-action ep-edit-btn" data-type="${type}" data-id="${item.id}" aria-label="Edit"><i class="fa-solid fa-pen"></i></button>
          <button type="button" class="pm-icon-action pm-danger ep-delete-btn" data-type="${type}" data-id="${item.id}" aria-label="Delete"><i class="fa-solid fa-trash"></i></button>
        </div>
      </div>
    `).join('');
  }

  function capitalize(s) { return s.charAt(0).toUpperCase() + s.slice(1); }

  function renderAll() { Object.keys(TAB_CONFIG).forEach(renderList); }
  renderAll();

  /* ---- Add / Edit modal (shared) ---- */
  const epModalOverlay = document.getElementById('epModalOverlay');
  const epModalIcon = document.getElementById('epModalIcon');
  const epModalTitle = document.getElementById('epModalTitle');
  const epModalSub = document.getElementById('epModalSub');
  const epTitleLabel = document.getElementById('epTitleLabel');
  const epMetaLabel = document.getElementById('epMetaLabel');
  const epDateLabel = document.getElementById('epDateLabel');
  const epDescLabel = document.getElementById('epDescLabel');
  const epTitleInput = document.getElementById('epTitleInput');
  const epMetaInput = document.getElementById('epMetaInput');
  const epDateInput = document.getElementById('epDateInput');
  const epDescInput = document.getElementById('epDescInput');
  const epTitleError = document.getElementById('epTitleError');

  let currentModalType = 'projects';

  function openAddEditModal(type, id) {
    currentModalType = type;
    editingItemId = id || null;
    const cfg = TAB_CONFIG[type];

    epModalIcon.className = `modal-icon ${cfg.iconClass}`;
    epModalIcon.innerHTML = `<i class="fa-solid ${cfg.icon}"></i>`;
    epModalSub.textContent = cfg.modalSub;
    epTitleLabel.textContent = cfg.titleLabel;
    epMetaLabel.textContent = cfg.metaLabel;
    epDateLabel.textContent = cfg.dateLabel;
    epDescLabel.textContent = 'Description';
    epTitleInput.placeholder = cfg.titlePlaceholder;
    epMetaInput.placeholder = cfg.metaPlaceholder;
    epDateInput.placeholder = cfg.datePlaceholder;

    epTitleError.classList.remove('show');
    epTitleInput.closest('.pm-form-group').classList.remove('has-error');

    if (id) {
      const item = profile[type].find(i => i.id === id);
      epModalTitle.textContent = cfg.editTitle;
      epTitleInput.value = item ? item.title : '';
      epMetaInput.value = item ? (item.meta || '') : '';
      epDateInput.value = item ? (item.date || '') : '';
      epDescInput.value = item ? (item.description || '') : '';
    } else {
      epModalTitle.textContent = cfg.addTitle;
      epTitleInput.value = '';
      epMetaInput.value = '';
      epDateInput.value = '';
      epDescInput.value = '';
    }

    epModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
  }
  function closeAddEditModal() {
    epModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }

  document.querySelectorAll('.pm-add-btn').forEach(btn => {
    btn.addEventListener('click', () => openAddEditModal(btn.dataset.type, null));
  });
  document.getElementById('epModalCloseBtn').addEventListener('click', closeAddEditModal);
  document.getElementById('epCancelBtn').addEventListener('click', closeAddEditModal);
  epModalOverlay.addEventListener('click', (e) => { if (e.target === epModalOverlay) closeAddEditModal(); });

  document.getElementById('epSaveBtn').addEventListener('click', () => {
    const title = epTitleInput.value.trim();
    if (!title) {
      epTitleError.classList.add('show');
      epTitleInput.closest('.pm-form-group').classList.add('has-error');
      return;
    }

    const data = {
      title,
      meta: epMetaInput.value.trim(),
      date: epDateInput.value.trim(),
      description: epDescInput.value.trim()
    };

    if (!profile[currentModalType]) profile[currentModalType] = [];

    if (editingItemId) {
      const item = profile[currentModalType].find(i => i.id === editingItemId);
      if (item) Object.assign(item, data);
      showToast('Entry updated successfully!', 'success');
    } else {
      profile[currentModalType].push(Object.assign({ id: PMData.uid() }, data));
      showToast('Entry added successfully!', 'success');
    }

    PMData.saveProfile(profile);
    closeAddEditModal();
    renderList(currentModalType);
  });

  /* ---- Delete (shared) ---- */
  const epDeleteModalOverlay = document.getElementById('epDeleteModalOverlay');
  const epDeleteName = document.getElementById('epDeleteName');
  let deletingType = null;

  function openDeleteModal(type, id) {
    deletingType = type;
    deletingItemId = id;
    const item = profile[type].find(i => i.id === id);
    epDeleteName.textContent = item ? item.title : 'this item';
    epDeleteModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
  }
  function closeDeleteModal() {
    epDeleteModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }

  document.getElementById('epDeleteNoBtn').addEventListener('click', closeDeleteModal);
  epDeleteModalOverlay.addEventListener('click', (e) => { if (e.target === epDeleteModalOverlay) closeDeleteModal(); });

  document.getElementById('epDeleteYesBtn').addEventListener('click', () => {
    profile[deletingType] = profile[deletingType].filter(i => i.id !== deletingItemId);
    PMData.saveProfile(profile);
    closeDeleteModal();
    renderList(deletingType);
    showToast('Entry deleted.', 'success');
  });

  /* ---- Event delegation for edit/delete on cards ---- */
  document.querySelectorAll('.pm-item-list').forEach(list => {
    list.addEventListener('click', (e) => {
      const editBtn = e.target.closest('.ep-edit-btn');
      const deleteBtn = e.target.closest('.ep-delete-btn');
      if (editBtn) openAddEditModal(editBtn.dataset.type, editBtn.dataset.id);
      if (deleteBtn) openDeleteModal(deleteBtn.dataset.type, deleteBtn.dataset.id);
    });
  });
});

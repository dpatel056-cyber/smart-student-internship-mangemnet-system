/* ============================================================
   SIMS - Module 3 : Certificates & Documents page JavaScript
============================================================ */
document.addEventListener('pmChromeReady', () => {

  const MAX_SIZE_BYTES = RDData.MAX_FILE_SIZE_MB * 1024 * 1024;
  const MAX_DATAURL_BYTES = 1.5 * 1024 * 1024;

  let activeFilter = 'all';
  let searchTerm = '';
  let selectedFiles = []; // { file, valid, reason }
  let deletingDocId = null;

  const grid = document.getElementById('rdDocGrid');
  const emptyState = document.getElementById('rdDocEmptyState');
  const tabsWrap = document.getElementById('rdDocTabs');

  const icons = {
    certificate: 'fa-award',
    academic: 'fa-graduation-cap'
  };
  const labels = {
    certificate: 'Certificate',
    academic: 'Academic Document'
  };

  function escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str == null ? '' : str;
    return div.innerHTML;
  }

  function render() {
    const docs = RDData.getDocuments();

    document.getElementById('countAll').textContent = docs.length;
    document.getElementById('countCertificate').textContent = docs.filter(d => d.category === 'certificate').length;
    document.getElementById('countAcademic').textContent = docs.filter(d => d.category === 'academic').length;

    let filtered = activeFilter === 'all' ? docs : docs.filter(d => d.category === activeFilter);
    if (searchTerm.trim()) {
      const term = searchTerm.trim().toLowerCase();
      filtered = filtered.filter(d =>
        (d.title || '').toLowerCase().includes(term) ||
        (d.issuer || '').toLowerCase().includes(term)
      );
    }

    if (!filtered.length) {
      grid.innerHTML = '';
      emptyState.style.display = 'block';
      return;
    }
    emptyState.style.display = 'none';

    grid.innerHTML = filtered.map(d => `
      <div class="rd-doc-card" data-id="${d.id}">
        <span class="rd-cat-badge cat-${d.category}">${labels[d.category] || 'Document'}</span>
        <div class="rd-doc-card-top">
          <span class="rd-doc-icon cat-${d.category}"><i class="fa-solid ${icons[d.category] || 'fa-file'}"></i></span>
          <div style="min-width:0;">
            <h4>${escapeHtml(d.title)}</h4>
            ${d.issuer ? `<div class="rd-doc-issuer">${escapeHtml(d.issuer)}</div>` : ''}
            <div class="rd-doc-meta">${d.date ? `<span><i class="fa-regular fa-calendar"></i> ${escapeHtml(d.date)}</span>` : ''}</div>
            <div class="rd-doc-file"><i class="fa-solid fa-paperclip"></i> ${escapeHtml(d.fileName)} &middot; ${RDData.formatSize(d.sizeKB)}</div>
          </div>
        </div>
        <div class="rd-doc-card-actions">
          <button type="button" class="pm-icon-action rd-doc-view-btn" data-id="${d.id}" title="View"><i class="fa-solid fa-eye"></i></button>
          <button type="button" class="pm-icon-action rd-doc-download-btn" data-id="${d.id}" title="Download"><i class="fa-solid fa-download"></i></button>
          <button type="button" class="pm-icon-action pm-danger rd-doc-delete-btn" data-id="${d.id}" title="Delete"><i class="fa-solid fa-trash"></i></button>
        </div>
      </div>
    `).join('');
  }

  render();

  /* ---- Tabs ---- */
  tabsWrap.addEventListener('click', (e) => {
    const btn = e.target.closest('.pm-tab-btn');
    if (!btn) return;
    tabsWrap.querySelectorAll('.pm-tab-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    activeFilter = btn.dataset.filter;
    render();
  });

  /* ---- Search ---- */
  document.getElementById('rdDocSearchInput').addEventListener('input', (e) => {
    searchTerm = e.target.value;
    render();
  });

  /* =========================================================
     Upload modal
  ========================================================= */
  const modalOverlay = document.getElementById('rdDocModalOverlay');
  const modalTitle = document.getElementById('rdDocModalTitle');
  const catCertificateInput = document.getElementById('rdCatCertificate');
  const catAcademicInput = document.getElementById('rdCatAcademic');
  const catCertificateCard = document.getElementById('rdCatCertificateCard');
  const catAcademicCard = document.getElementById('rdCatAcademicCard');
  const titleInput = document.getElementById('rdDocTitleInput');
  const titleError = document.getElementById('rdDocTitleError');
  const issuerInput = document.getElementById('rdDocIssuerInput');
  const dateInput = document.getElementById('rdDocDateInput');
  const fileInput = document.getElementById('rdDocFileInput');
  const fileHint = document.getElementById('rdDocFileHint');
  const fileError = document.getElementById('rdDocFileError');
  const fileListWrap = document.getElementById('rdDocFileList');

  function setCategory(cat) {
    catCertificateInput.checked = cat === 'certificate';
    catAcademicInput.checked = cat === 'academic';
    catCertificateCard.classList.toggle('active', cat === 'certificate');
    catAcademicCard.classList.toggle('active', cat === 'academic');
    modalTitle.textContent = cat === 'certificate' ? 'Upload Certificate' : 'Upload Academic Document';
    fileHint.textContent = cat === 'academic'
      ? 'You can select multiple academic documents at once (marksheets, provisional certificates, etc.)'
      : 'Select a single certificate file, or multiple if you have several to add at once.';
  }
  [catCertificateCard, catAcademicCard].forEach(card => {
    card.addEventListener('click', () => setCategory(card.querySelector('input').value));
  });

  function resetForm() {
    titleInput.value = '';
    issuerInput.value = '';
    dateInput.value = '';
    fileInput.value = '';
    selectedFiles = [];
    fileListWrap.innerHTML = '';
    titleError.classList.remove('show');
    titleInput.closest('.pm-form-group').classList.remove('has-error');
    fileError.classList.remove('show');
  }

  function openUploadModal(defaultCategory) {
    resetForm();
    setCategory(defaultCategory);
    modalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
    setTimeout(() => titleInput.focus(), 100);
  }
  function closeUploadModal() {
    modalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }

  document.getElementById('uploadCertificateBtn').addEventListener('click', () => openUploadModal('certificate'));
  document.getElementById('uploadAcademicBtn').addEventListener('click', () => openUploadModal('academic'));
  document.getElementById('rdDocModalCloseBtn').addEventListener('click', closeUploadModal);
  document.getElementById('rdDocCancelBtn').addEventListener('click', closeUploadModal);
  modalOverlay.addEventListener('click', (e) => { if (e.target === modalOverlay) closeUploadModal(); });

  function renderFileList() {
    fileListWrap.innerHTML = selectedFiles.map((entry, idx) => `
      <div class="rd-file-row" style="margin-top:0; padding:10px 12px;">
        <div class="rd-file-icon" style="${entry.valid ? '' : 'background:#fee2e2;color:#ef4444;'}"><i class="fa-solid ${entry.valid ? 'fa-file-pdf' : 'fa-triangle-exclamation'}"></i></div>
        <div class="rd-file-info">
          <div class="rd-file-name">${escapeHtml(entry.file.name)}</div>
          <div class="rd-file-size">${entry.valid ? RDData.formatSize(entry.file.size / 1024) : entry.reason}</div>
        </div>
        <button type="button" class="rd-file-remove" data-idx="${idx}" aria-label="Remove"><i class="fa-solid fa-xmark"></i></button>
      </div>
    `).join('');
  }

  fileInput.addEventListener('change', (e) => {
    const files = Array.from(e.target.files || []);
    fileError.classList.remove('show');
    selectedFiles = files.map(file => {
      const okType = /\.(pdf|jpg|jpeg|png)$/i.test(file.name);
      const okSize = file.size <= MAX_SIZE_BYTES;
      let reason = '';
      if (!okType) reason = 'Unsupported file type';
      else if (!okSize) reason = `Too large (max ${RDData.MAX_FILE_SIZE_MB} MB)`;
      return { file, valid: okType && okSize, reason };
    });
    renderFileList();
  });

  fileListWrap.addEventListener('click', (e) => {
    const btn = e.target.closest('.rd-file-remove');
    if (!btn) return;
    selectedFiles.splice(Number(btn.dataset.idx), 1);
    renderFileList();
  });

  document.getElementById('rdDocSaveBtn').addEventListener('click', () => {
    const category = catAcademicInput.checked ? 'academic' : 'certificate';
    const validFiles = selectedFiles.filter(e => e.valid);

    let hasError = false;
    if (!validFiles.length) {
      fileError.textContent = selectedFiles.length
        ? 'All selected files failed validation. Please choose PDF/JPG/PNG files under 5 MB.'
        : 'Please select at least one valid file (PDF/JPG/PNG, under 5 MB).';
      fileError.classList.add('show');
      hasError = true;
    }
    if (validFiles.length <= 1 && !titleInput.value.trim()) {
      titleError.classList.add('show');
      titleInput.closest('.pm-form-group').classList.add('has-error');
      hasError = true;
    }
    if (hasError) return;

    const docs = RDData.getDocuments();
    const issuer = issuerInput.value.trim();
    const date = dateInput.value
      ? new Date(dateInput.value).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' })
      : RDData.todayFormatted();

    let processed = 0;
    function afterAllProcessed() {
      RDData.saveDocuments(docs);
      closeUploadModal();
      render();
      showToast(`${validFiles.length} document${validFiles.length === 1 ? '' : 's'} uploaded successfully!`, 'success');
    }

    validFiles.forEach((entry) => {
      const title = validFiles.length === 1
        ? titleInput.value.trim()
        : entry.file.name.replace(/\.[^.]+$/, '');

      const pushDoc = (dataUrl) => {
        docs.unshift({
          id: RDData.uid(),
          category,
          title,
          issuer,
          date,
          fileName: entry.file.name,
          sizeKB: Math.round(entry.file.size / 1024),
          dataUrl
        });
        processed++;
        if (processed === validFiles.length) afterAllProcessed();
      };

      if (entry.file.size <= MAX_DATAURL_BYTES) {
        const reader = new FileReader();
        reader.onload = () => pushDoc(reader.result);
        reader.onerror = () => pushDoc(null);
        reader.readAsDataURL(entry.file);
      } else {
        pushDoc(null);
      }
    });
  });

  /* =========================================================
     View / Download / Delete (event delegation on grid)
  ========================================================= */
  const viewModalOverlay = document.getElementById('rdDocViewModalOverlay');
  const viewTitle = document.getElementById('rdDocViewTitle');
  const viewSub = document.getElementById('rdDocViewSub');
  let viewingDocId = null;

  function closeViewModal() {
    viewModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }
  document.getElementById('rdDocViewCloseBtn').addEventListener('click', closeViewModal);
  document.getElementById('rdDocViewCloseBtn2').addEventListener('click', closeViewModal);
  viewModalOverlay.addEventListener('click', (e) => { if (e.target === viewModalOverlay) closeViewModal(); });

  function downloadDoc(doc) {
    if (doc.dataUrl) {
      const a = document.createElement('a');
      a.href = doc.dataUrl;
      a.download = doc.fileName || 'document.pdf';
      document.body.appendChild(a);
      a.click();
      a.remove();
      showToast('Download started.', 'success');
    } else {
      showToast('Demo file has no stored bytes to download. In production this calls the document file API.', 'success');
    }
  }

  document.getElementById('rdDocViewDownloadBtn').addEventListener('click', () => {
    const doc = RDData.getDocuments().find(d => d.id === viewingDocId);
    if (doc) downloadDoc(doc);
  });

  const deleteModalOverlay = document.getElementById('rdDocDeleteModalOverlay');
  const deleteNameEl = document.getElementById('rdDocDeleteName');
  function closeDeleteModal() {
    deleteModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }
  document.getElementById('rdDocDeleteNoBtn').addEventListener('click', closeDeleteModal);
  deleteModalOverlay.addEventListener('click', (e) => { if (e.target === deleteModalOverlay) closeDeleteModal(); });
  document.getElementById('rdDocDeleteYesBtn').addEventListener('click', () => {
    const docs = RDData.getDocuments().filter(d => d.id !== deletingDocId);
    RDData.saveDocuments(docs);
    closeDeleteModal();
    render();
    showToast('Document deleted.', 'success');
  });

  grid.addEventListener('click', (e) => {
    const viewBtn = e.target.closest('.rd-doc-view-btn');
    const downloadBtn = e.target.closest('.rd-doc-download-btn');
    const deleteBtn = e.target.closest('.rd-doc-delete-btn');
    const docs = RDData.getDocuments();

    if (viewBtn) {
      const doc = docs.find(d => d.id === viewBtn.dataset.id);
      if (!doc) return;
      viewingDocId = doc.id;
      viewTitle.textContent = doc.title;
      viewSub.innerHTML = `${escapeHtml(doc.issuer || labels[doc.category])}<br>${escapeHtml(doc.fileName)} &middot; ${RDData.formatSize(doc.sizeKB)}${doc.date ? ' &middot; ' + escapeHtml(doc.date) : ''}`;
      viewModalOverlay.classList.add('open');
      document.body.classList.add('modal-open');
    }
    if (downloadBtn) {
      const doc = docs.find(d => d.id === downloadBtn.dataset.id);
      if (doc) downloadDoc(doc);
    }
    if (deleteBtn) {
      const doc = docs.find(d => d.id === deleteBtn.dataset.id);
      if (!doc) return;
      deletingDocId = doc.id;
      deleteNameEl.textContent = doc.title;
      deleteModalOverlay.classList.add('open');
      document.body.classList.add('modal-open');
    }
  });
});

/* ============================================================
   SIMS - Module 3 : Upload Resume page JavaScript
   Handles drag & drop, PDF-only + max-size validation, a
   simulated upload progress bar and the success popup. Also
   doubles as the "Replace Resume" page when opened with
   ?mode=replace, reusing the exact same markup/logic.
============================================================ */
document.addEventListener('pmChromeReady', () => {

  const isReplaceMode = new URLSearchParams(window.location.search).get('mode') === 'replace';
  const MAX_SIZE_BYTES = RDData.MAX_FILE_SIZE_MB * 1024 * 1024;
  /* Only store the actual file bytes in localStorage (for real PDF preview)
     when the file is small enough to comfortably fit the browser's
     localStorage quota. Larger PDFs still "upload" successfully but the
     preview page falls back to a placeholder card. */
  const MAX_DATAURL_BYTES = 1.5 * 1024 * 1024;

  if (isReplaceMode) {
    document.getElementById('uploadPageTitle').firstChild.textContent = 'Replace Resume ';
    document.getElementById('uploadPageSubtitle').textContent = 'Upload a new PDF to replace your existing resume';
    document.getElementById('uploadBreadcrumbCurrent').textContent = 'Replace Resume';
    document.getElementById('uploadCardTitle').textContent = 'Replace Your Resume';
    document.getElementById('rdDropzoneTitle').textContent = 'Drag & drop your new resume here';
    document.getElementById('rdUploadBtnLabel').textContent = 'Replace Resume';
    document.getElementById('rdSuccessTitle').textContent = 'Resume Replaced Successfully!';
    document.getElementById('rdSuccessSub').textContent = 'Your previous resume has been replaced with the new file.';
  }

  let selectedFile = null;

  const dropzone = document.getElementById('rdDropzone');
  const browseLink = document.getElementById('rdBrowseLink');
  const fileInput = document.getElementById('rdFileInput');
  const fileRow = document.getElementById('rdFileRow');
  const fileNameEl = document.getElementById('rdFileName');
  const fileSizeEl = document.getElementById('rdFileSize');
  const removeBtn = document.getElementById('rdFileRemoveBtn');
  const uploadBtn = document.getElementById('rdUploadBtn');
  const progressWrap = document.getElementById('rdProgressWrap');
  const progressFill = document.getElementById('rdProgressFill');
  const progressPercent = document.getElementById('rdProgressPercent');
  const successModalOverlay = document.getElementById('rdSuccessModalOverlay');

  function openFileDialog() { fileInput.click(); }
  dropzone.addEventListener('click', openFileDialog);
  browseLink.addEventListener('click', (e) => { e.stopPropagation(); openFileDialog(); });

  ['dragenter', 'dragover'].forEach(evt => {
    dropzone.addEventListener(evt, (e) => { e.preventDefault(); e.stopPropagation(); dropzone.classList.add('drag-over'); });
  });
  ['dragleave', 'drop'].forEach(evt => {
    dropzone.addEventListener(evt, (e) => { e.preventDefault(); e.stopPropagation(); dropzone.classList.remove('drag-over'); });
  });
  dropzone.addEventListener('drop', (e) => {
    const files = e.dataTransfer.files;
    if (files && files.length) handleFile(files[0]);
  });
  fileInput.addEventListener('change', (e) => {
    if (e.target.files && e.target.files.length) handleFile(e.target.files[0]);
  });

  function handleFile(file) {
    const isPdf = file.type === 'application/pdf' || /\.pdf$/i.test(file.name);
    if (!isPdf) {
      showToast('Only PDF files are allowed. Please select a .pdf file.', 'error');
      resetSelection();
      return;
    }
    if (file.size > MAX_SIZE_BYTES) {
      showToast(`File is too large. Maximum allowed size is ${RDData.MAX_FILE_SIZE_MB} MB.`, 'error');
      resetSelection();
      return;
    }

    selectedFile = file;
    fileNameEl.textContent = file.name;
    fileSizeEl.textContent = RDData.formatSize(file.size / 1024);
    fileRow.style.display = 'flex';
    dropzone.classList.add('has-file');
    document.getElementById('rdDropzoneTitle').textContent = 'Resume selected';
    uploadBtn.disabled = false;
    progressWrap.classList.remove('show');
    progressFill.style.width = '0%';
    progressPercent.textContent = '0%';
  }

  function resetSelection() {
    selectedFile = null;
    fileInput.value = '';
    fileRow.style.display = 'none';
    dropzone.classList.remove('has-file');
    document.getElementById('rdDropzoneTitle').textContent = isReplaceMode ? 'Drag & drop your new resume here' : 'Drag & drop your resume here';
    uploadBtn.disabled = true;
    progressWrap.classList.remove('show');
  }

  removeBtn.addEventListener('click', (e) => { e.stopPropagation(); resetSelection(); });

  /* ---- Upload (simulated progress bar) ---- */
  uploadBtn.addEventListener('click', () => {
    if (!selectedFile) return;
    uploadBtn.disabled = true;
    removeBtn.style.visibility = 'hidden';
    progressWrap.classList.add('show');

    let progress = 0;
    const timer = setInterval(() => {
      progress += Math.random() * 18 + 7;
      if (progress >= 100) {
        progress = 100;
        clearInterval(timer);
        finishUpload();
      }
      progressFill.style.width = progress + '%';
      progressPercent.textContent = Math.round(progress) + '%';
    }, 180);
  });

  function finishUpload() {
    const proceed = (dataUrl) => {
      const now = RDData.todayFormatted();
      const existing = RDData.getResume();
      RDData.saveResume({
        uploaded: true,
        fileName: selectedFile.name,
        fileSizeKB: Math.round(selectedFile.size / 1024),
        uploadedDate: existing.uploaded ? existing.uploadedDate : now,
        updatedDate: now,
        dataUrl: dataUrl,
        version: (existing.version || 0) + 1
      });
      successModalOverlay.classList.add('open');
      document.body.classList.add('modal-open');
    };

    if (selectedFile.size <= MAX_DATAURL_BYTES) {
      const reader = new FileReader();
      reader.onload = () => proceed(reader.result);
      reader.onerror = () => proceed(null);
      reader.readAsDataURL(selectedFile);
    } else {
      proceed(null);
    }
  }

  successModalOverlay.addEventListener('click', (e) => {
    if (e.target === successModalOverlay) {
      successModalOverlay.classList.remove('open');
      document.body.classList.remove('modal-open');
    }
  });
});

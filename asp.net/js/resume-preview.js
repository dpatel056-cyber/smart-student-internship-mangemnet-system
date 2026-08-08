/* ============================================================
   SIMS - Module 3 : Resume Preview page JavaScript
============================================================ */
document.addEventListener('pmChromeReady', (evt) => {

  const previewContent = document.getElementById('rdPreviewContent');
  const emptyContent = document.getElementById('rdEmptyContent');
  const frameWrap = document.getElementById('rdPdfFrameWrap');
  const placeholder = document.getElementById('rdPdfPlaceholder');

  function render() {
    const resume = RDData.getResume();

    if (!resume.uploaded) {
      previewContent.style.display = 'none';
      emptyContent.style.display = 'block';
      return;
    }

    previewContent.style.display = 'block';
    emptyContent.style.display = 'none';

    if (resume.dataUrl) {
      frameWrap.innerHTML = `<iframe id="rdPdfFrame" src="${resume.dataUrl}" title="Resume preview"></iframe>`;
    } else {
      frameWrap.innerHTML = '';
      frameWrap.appendChild(placeholder);
    }

    document.getElementById('rdPdfName').textContent = resume.fileName;
    document.getElementById('rdPdfMeta').textContent = `${RDData.formatSize(resume.fileSizeKB)} · Updated ${resume.updatedDate}`;

    document.getElementById('rdInfoFileName').textContent = resume.fileName;
    document.getElementById('rdInfoFileSize').textContent = RDData.formatSize(resume.fileSizeKB);
    document.getElementById('rdInfoUploadedDate').textContent = resume.uploadedDate || '-';
    document.getElementById('rdInfoUpdatedDate').textContent = resume.updatedDate || '-';
    document.getElementById('rdInfoVersion').textContent = 'v' + (resume.version || 1);
    document.getElementById('rdInfoOwner').textContent = (evt.detail && evt.detail.profile && evt.detail.profile.fullName) || 'Student';

    document.getElementById('rdDeleteFileName').textContent = resume.fileName;
  }

  render();

  /* ---- Download ---- */
  document.getElementById('rdPreviewDownloadBtn').addEventListener('click', () => {
    const resume = RDData.getResume();
    if (resume.dataUrl) {
      const a = document.createElement('a');
      a.href = resume.dataUrl;
      a.download = resume.fileName || 'resume.pdf';
      document.body.appendChild(a);
      a.click();
      a.remove();
      showToast('Resume download started.', 'success');
    } else {
      showToast('Demo file has no stored bytes to download. In production this calls the resume file API.', 'success');
    }
  });

  /* ---- Delete ---- */
  const deleteModalOverlay = document.getElementById('rdDeleteModalOverlay');
  document.getElementById('rdPreviewDeleteBtn').addEventListener('click', () => {
    deleteModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
  });
  document.getElementById('rdDeleteNoBtn').addEventListener('click', () => {
    deleteModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  });
  deleteModalOverlay.addEventListener('click', (e) => {
    if (e.target === deleteModalOverlay) {
      deleteModalOverlay.classList.remove('open');
      document.body.classList.remove('modal-open');
    }
  });
  document.getElementById('rdDeleteYesBtn').addEventListener('click', () => {
    RDData.deleteResume();
    deleteModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
    showToast('Resume deleted successfully.', 'success');
    render();
  });
});

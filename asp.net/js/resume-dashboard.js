/* ============================================================
   SIMS - Module 3 : Resume Dashboard page JavaScript
============================================================ */
document.addEventListener('pmChromeReady', () => {

  const heroTitle = document.getElementById('rdHeroTitle');
  const heroSub = document.getElementById('rdHeroSub');
  const heroPill = document.getElementById('rdHeroStatusPill');
  const heroActionBtn = document.getElementById('rdHeroActionBtn');
  const statusCardText = document.getElementById('rdStatusCardText');
  const statusCardPill = document.getElementById('rdStatusCardPill');
  const deleteFileName = document.getElementById('rdDeleteFileName');

  function render() {
    const resume = RDData.getResume();

    if (resume.uploaded) {
      heroTitle.textContent = 'Your resume is up to date';
      heroSub.textContent = `${resume.fileName} · Last updated ${resume.updatedDate}`;
      heroPill.className = 'rd-status-pill uploaded';
      heroPill.innerHTML = '<i class="fa-solid fa-circle-check"></i> Uploaded';
      heroActionBtn.innerHTML = '<i class="fa-solid fa-eye"></i> Preview Resume';
      heroActionBtn.setAttribute('href', 'resume-preview.html');

      statusCardText.textContent = `${resume.fileName} was last updated on ${resume.updatedDate}. Recruiters can view this resume on your profile.`;
      statusCardPill.className = 'pm-resume-status uploaded';
      statusCardPill.innerHTML = '<i class="fa-solid fa-circle-check"></i> Uploaded';

      deleteFileName.textContent = resume.fileName;
    } else {
      heroTitle.textContent = 'No resume uploaded yet';
      heroSub.textContent = 'Upload a PDF resume so recruiters can review your profile.';
      heroPill.className = 'rd-status-pill missing';
      heroPill.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i> Not Uploaded';
      heroActionBtn.innerHTML = '<i class="fa-solid fa-cloud-arrow-up"></i> Upload Resume';
      heroActionBtn.setAttribute('href', 'upload-resume.html');

      statusCardText.textContent = 'You have not uploaded a resume yet. Upload one to complete your profile.';
      statusCardPill.className = 'pm-resume-status missing';
      statusCardPill.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i> Missing';

      deleteFileName.textContent = 'your resume';
    }
  }

  render();

  /* ---- Download ---- */
  document.getElementById('rdDownloadBtn').addEventListener('click', () => {
    const resume = RDData.getResume();
    if (!resume.uploaded) {
      showToast('No resume uploaded yet. Please upload one first.', 'error');
      return;
    }
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
  function openDeleteModal() {
    const resume = RDData.getResume();
    if (!resume.uploaded) {
      showToast('No resume uploaded to delete.', 'error');
      return;
    }
    deleteModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
  }
  function closeDeleteModal() {
    deleteModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }
  document.getElementById('rdDeleteBtn').addEventListener('click', openDeleteModal);
  document.getElementById('rdDeleteNoBtn').addEventListener('click', closeDeleteModal);
  deleteModalOverlay.addEventListener('click', (e) => { if (e.target === deleteModalOverlay) closeDeleteModal(); });
  document.getElementById('rdDeleteYesBtn').addEventListener('click', () => {
    RDData.deleteResume();
    closeDeleteModal();
    render();
    showToast('Resume deleted successfully.', 'success');
  });
});

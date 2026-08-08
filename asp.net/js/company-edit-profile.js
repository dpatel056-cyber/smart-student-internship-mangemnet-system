/* ============================================================
   SIMS - Company Edit Profile JavaScript
   Handles: logo/cover upload preview, form validation, save
============================================================ */
document.addEventListener('DOMContentLoaded', () => {

  /* ---- Image Upload Preview ---- */
  function setupUpload(zoneId, inputId, previewId, isLogo) {
    const zone  = document.getElementById(zoneId);
    const input = document.getElementById(inputId);
    const preview = document.getElementById(previewId);
    if (!zone || !input || !preview) return;

    zone.addEventListener('click', () => input.click());
    zone.addEventListener('dragover', e => { e.preventDefault(); zone.style.borderColor = '#2563eb'; });
    zone.addEventListener('dragleave', () => { zone.style.borderColor = ''; });
    zone.addEventListener('drop', e => {
      e.preventDefault();
      zone.style.borderColor = '';
      if (e.dataTransfer.files[0]) handleFile(e.dataTransfer.files[0]);
    });
    input.addEventListener('change', () => { if (input.files[0]) handleFile(input.files[0]); });

    function handleFile(file) {
      if (!file.type.startsWith('image/')) {
        if (window.simsShowToast) window.simsShowToast('Please select a valid image file.', 'error');
        return;
      }
      const reader = new FileReader();
      reader.onload = e => {
        if (isLogo) {
          preview.style.backgroundImage = `url(${e.target.result})`;
          preview.style.backgroundSize = 'cover';
          preview.style.backgroundPosition = 'center';
          preview.textContent = '';
        } else {
          preview.style.backgroundImage = `url(${e.target.result})`;
          preview.style.backgroundSize = 'cover';
          preview.style.backgroundPosition = 'center';
        }
        if (window.simsShowToast) window.simsShowToast('Image uploaded successfully!', 'success');
      };
      reader.readAsDataURL(file);
    }
  }

  setupUpload('logoUploadZone', 'logoInput', 'logoPreview', true);
  setupUpload('coverUploadZone', 'coverInput', 'coverPreview', false);

  /* ---- Form Validation & Save ---- */
  const form = document.getElementById('editProfileForm');
  const saveBtn = document.getElementById('saveChangesBtn');

  if (form) {
    form.addEventListener('submit', e => {
      e.preventDefault();
      let hasError = false;

      const companyName = document.getElementById('companyName');
      const companyEmail = document.getElementById('companyEmail');
      const nameError = document.getElementById('companyNameError');
      const emailError = document.getElementById('emailError');

      // Reset
      [nameError, emailError].forEach(el => { if (el) el.style.display = 'none'; });
      [companyName, companyEmail].forEach(el => { if (el) el.style.borderColor = ''; });

      // Validate name
      if (companyName && !companyName.value.trim()) {
        companyName.style.borderColor = '#ef4444';
        if (nameError) nameError.style.display = 'block';
        hasError = true;
      }

      // Validate email
      const emailVal = companyEmail ? companyEmail.value.trim() : '';
      if (companyEmail && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailVal)) {
        companyEmail.style.borderColor = '#ef4444';
        if (emailError) emailError.style.display = 'block';
        hasError = true;
      }

      if (hasError) return;

      // Simulate save
      if (saveBtn) {
        saveBtn.disabled = true;
        const spinner = document.getElementById('saveBtnSpinner');
        if (spinner) spinner.style.display = 'inline-block';
        const icon = saveBtn.querySelector('i');
        if (icon) icon.className = '';

        setTimeout(() => {
          saveBtn.disabled = false;
          if (spinner) spinner.style.display = 'none';
          if (icon) icon.className = 'fa-solid fa-floppy-disk';
          if (window.simsShowToast) window.simsShowToast('Company profile updated successfully!', 'success');
          setTimeout(() => { window.location.href = 'company-profile.html'; }, 1400);
        }, 1000);
      }
    });
  }

});

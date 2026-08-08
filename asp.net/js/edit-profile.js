/* ============================================================
   SIMS - Module 2 : Edit Profile page JavaScript
============================================================ */
document.addEventListener('pmChromeReady', () => {

  let profile = PMData.getProfile();
  let photoDataUrl = profile.photo || null;
  let formDirty = false;

  const els = {
    fullName: document.getElementById('fullNameInput'),
    enrollment: document.getElementById('enrollmentInput'),
    email: document.getElementById('emailInput'),
    mobile: document.getElementById('mobileInput'),
    address: document.getElementById('addressInput'),
    department: document.getElementById('departmentInput'),
    course: document.getElementById('courseInput'),
    semester: document.getElementById('semesterInput'),
    college: document.getElementById('collegeInput'),
    dob: document.getElementById('dobInput'),
    gender: document.getElementById('genderInput'),
    linkedin: document.getElementById('linkedinInput'),
    github: document.getElementById('githubInput')
  };

  const photoPreview = document.getElementById('pmPhotoPreview');

  function renderPhotoPreview() {
    if (photoDataUrl) {
      photoPreview.innerHTML = `<img src="${photoDataUrl}" alt="Profile photo">`;
    } else {
      photoPreview.textContent = PMData.getInitials(els.fullName.value || profile.fullName);
    }
  }

  function fillForm() {
    els.fullName.value = profile.fullName || '';
    els.enrollment.value = profile.enrollment || '';
    els.email.value = profile.email || '';
    els.mobile.value = profile.mobile || '';
    els.address.value = profile.address || '';
    setSelectValueOrAdd(els.department, profile.department);
    setSelectValueOrAdd(els.course, profile.course);
    setSelectValueOrAdd(els.semester, profile.semester);
    els.college.value = profile.college || '';
    els.dob.value = profile.dob || '';
    els.gender.value = profile.gender || '';
    els.linkedin.value = profile.linkedin || '';
    els.github.value = profile.github || '';
    renderPhotoPreview();
  }

  function setSelectValueOrAdd(selectEl, value) {
    if (!value) return;
    const exists = Array.from(selectEl.options).some(o => o.value === value);
    if (!exists) {
      const opt = document.createElement('option');
      opt.value = value;
      opt.textContent = value;
      selectEl.appendChild(opt);
    }
    selectEl.value = value;
  }

  fillForm();

  const form = document.getElementById('editProfileForm');
  form.addEventListener('input', () => { formDirty = true; });
  form.addEventListener('change', () => { formDirty = true; });
  els.fullName.addEventListener('input', () => { if (!photoDataUrl) renderPhotoPreview(); });

  /* ---- Photo upload ---- */
  const photoInput = document.getElementById('photoInput');
  const removePhotoBtn = document.getElementById('removePhotoBtn');

  photoInput.addEventListener('change', () => {
    const file = photoInput.files && photoInput.files[0];
    if (!file) return;
    if (!file.type.startsWith('image/')) {
      showToast('Please select a valid image file.', 'error');
      return;
    }
    if (file.size > 2 * 1024 * 1024) {
      showToast('Image is too large. Max size is 2MB.', 'error');
      return;
    }
    const reader = new FileReader();
    reader.onload = (e) => {
      photoDataUrl = e.target.result;
      formDirty = true;
      renderPhotoPreview();
    };
    reader.readAsDataURL(file);
  });

  removePhotoBtn.addEventListener('click', () => {
    photoDataUrl = null;
    photoInput.value = '';
    formDirty = true;
    renderPhotoPreview();
  });

  /* ---- Validation helpers ---- */
  function setError(groupId, errorId, show) {
    const group = document.getElementById(groupId).closest('.pm-form-group');
    const errorEl = document.getElementById(errorId);
    if (group) group.classList.toggle('has-error', show);
    if (errorEl) errorEl.classList.toggle('show', show);
  }

  function isValidEmail(v) { return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v); }
  function isValidMobile(v) { return /^[+]?[\d\s-]{10,15}$/.test(v.trim()); }

  function validate() {
    let valid = true;

    if (!els.fullName.value.trim()) {
      setError('fullNameInput', 'fullNameError', true);
      valid = false;
    } else {
      setError('fullNameInput', 'fullNameError', false);
    }

    if (!els.email.value.trim() || !isValidEmail(els.email.value.trim())) {
      setError('emailInput', 'emailError', true);
      valid = false;
    } else {
      setError('emailInput', 'emailError', false);
    }

    if (!els.mobile.value.trim() || !isValidMobile(els.mobile.value.trim())) {
      setError('mobileInput', 'mobileError', true);
      valid = false;
    } else {
      setError('mobileInput', 'mobileError', false);
    }

    return valid;
  }

  /* ---- Save ---- */
  form.addEventListener('submit', (e) => {
    e.preventDefault();
    if (!validate()) {
      showToast('Please fix the highlighted fields.', 'error');
      return;
    }

    profile.photo = photoDataUrl;
    profile.fullName = els.fullName.value.trim();
    profile.enrollment = els.enrollment.value.trim();
    profile.email = els.email.value.trim();
    profile.mobile = els.mobile.value.trim();
    profile.address = els.address.value.trim();
    profile.department = els.department.value;
    profile.course = els.course.value;
    profile.semester = els.semester.value;
    profile.college = els.college.value.trim();
    profile.dob = els.dob.value;
    profile.gender = els.gender.value;
    profile.linkedin = els.linkedin.value.trim();
    profile.github = els.github.value.trim();

    PMData.saveProfile(profile);
    formDirty = false;
    showToast('Profile updated successfully!', 'success');
    setTimeout(() => { window.location.href = 'my-profile.html'; }, 900);
  });

  /* ---- Cancel ---- */
  const cancelModalOverlay = document.getElementById('cancelModalOverlay');
  const cancelEditBtn = document.getElementById('cancelEditBtn');
  const cancelModalNoBtn = document.getElementById('cancelModalNoBtn');
  const cancelModalYesBtn = document.getElementById('cancelModalYesBtn');

  cancelEditBtn.addEventListener('click', () => {
    if (!formDirty) {
      window.location.href = 'my-profile.html';
      return;
    }
    cancelModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
  });
  cancelModalNoBtn.addEventListener('click', () => {
    cancelModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  });
  cancelModalYesBtn.addEventListener('click', () => { window.location.href = 'my-profile.html'; });
  cancelModalOverlay.addEventListener('click', (e) => {
    if (e.target === cancelModalOverlay) {
      cancelModalOverlay.classList.remove('open');
      document.body.classList.remove('modal-open');
    }
  });
});

/* ============================================================
   SIMS - Module 2 : Education Details page JavaScript
============================================================ */
document.addEventListener('pmChromeReady', () => {

  let profile = PMData.getProfile();
  let editingEduId = null;
  let deletingEduId = null;

  const educationList = document.getElementById('educationList');
  const educationEmptyState = document.getElementById('educationEmptyState');
  const eduCountLabel = document.getElementById('eduCountLabel');

  function escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
  }

  function render() {
    const list = profile.education || [];
    eduCountLabel.textContent = `${list.length} record${list.length === 1 ? '' : 's'} added`;

    if (!list.length) {
      educationList.innerHTML = '';
      educationEmptyState.style.display = 'block';
      return;
    }
    educationEmptyState.style.display = 'none';

    educationList.innerHTML = list.map(ed => `
      <div class="pm-item-card" data-id="${ed.id}">
        <div class="pm-item-main">
          <span class="pm-item-icon"><i class="fa-solid fa-building-columns"></i></span>
          <div class="pm-item-body">
            <h4>${escapeHtml(ed.college || 'College Name')}</h4>
            <div class="pm-item-sub">${escapeHtml(ed.course || '')}${ed.department ? ' - ' + escapeHtml(ed.department) : ''}</div>
            <div class="pm-item-meta">
              ${ed.university ? `<span><i class="fa-solid fa-landmark"></i> ${escapeHtml(ed.university)}</span>` : ''}
              ${ed.semester ? `<span><i class="fa-solid fa-layer-group"></i> ${escapeHtml(ed.semester)}</span>` : ''}
              ${ed.cgpa ? `<span><i class="fa-solid fa-star"></i> CGPA: ${escapeHtml(ed.cgpa)}</span>` : ''}
              ${ed.passingYear ? `<span><i class="fa-solid fa-calendar"></i> ${escapeHtml(ed.passingYear)}</span>` : ''}
            </div>
          </div>
        </div>
        <div class="pm-item-actions">
          <button type="button" class="pm-icon-action edu-edit-btn" data-id="${ed.id}" aria-label="Edit"><i class="fa-solid fa-pen"></i></button>
          <button type="button" class="pm-icon-action pm-danger edu-delete-btn" data-id="${ed.id}" aria-label="Delete"><i class="fa-solid fa-trash"></i></button>
        </div>
      </div>
    `).join('');
  }

  render();

  /* ---- Add / Edit modal ---- */
  const eduModalOverlay = document.getElementById('eduModalOverlay');
  const eduModalTitle = document.getElementById('eduModalTitle');
  const fields = {
    college: document.getElementById('eduCollegeInput'),
    university: document.getElementById('eduUniversityInput'),
    course: document.getElementById('eduCourseInput'),
    department: document.getElementById('eduDepartmentInput'),
    semester: document.getElementById('eduSemesterInput'),
    cgpa: document.getElementById('eduCgpaInput'),
    passingYear: document.getElementById('eduYearInput')
  };
  const collegeError = document.getElementById('eduCollegeError');
  const yearError = document.getElementById('eduYearError');

  function clearErrors() {
    [fields.college, fields.passingYear].forEach(f => f.closest('.pm-form-group').classList.remove('has-error'));
    collegeError.classList.remove('show');
    yearError.classList.remove('show');
  }

  function openEduModal(id) {
    editingEduId = id || null;
    clearErrors();
    if (id) {
      const ed = profile.education.find(e => e.id === id);
      eduModalTitle.textContent = 'Edit Education';
      Object.keys(fields).forEach(k => { fields[k].value = ed ? (ed[k] || '') : ''; });
    } else {
      eduModalTitle.textContent = 'Add Education';
      Object.keys(fields).forEach(k => { fields[k].value = ''; });
    }
    eduModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
  }
  function closeEduModal() {
    eduModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }

  document.getElementById('addEducationBtn').addEventListener('click', () => openEduModal(null));
  document.getElementById('eduModalCloseBtn').addEventListener('click', closeEduModal);
  document.getElementById('eduCancelBtn').addEventListener('click', closeEduModal);
  eduModalOverlay.addEventListener('click', (e) => { if (e.target === eduModalOverlay) closeEduModal(); });

  document.getElementById('eduSaveBtn').addEventListener('click', () => {
    clearErrors();
    let valid = true;

    if (!fields.college.value.trim()) {
      collegeError.classList.add('show');
      fields.college.closest('.pm-form-group').classList.add('has-error');
      valid = false;
    }
    if (!fields.passingYear.value.trim() || !/^\d{4}$/.test(fields.passingYear.value.trim())) {
      yearError.classList.add('show');
      fields.passingYear.closest('.pm-form-group').classList.add('has-error');
      valid = false;
    }
    if (!valid) return;

    const data = {
      college: fields.college.value.trim(),
      university: fields.university.value.trim(),
      course: fields.course.value.trim(),
      department: fields.department.value.trim(),
      semester: fields.semester.value.trim(),
      cgpa: fields.cgpa.value.trim(),
      passingYear: fields.passingYear.value.trim()
    };

    if (editingEduId) {
      const ed = profile.education.find(e => e.id === editingEduId);
      if (ed) Object.assign(ed, data);
      showToast('Education record updated!', 'success');
    } else {
      profile.education.push(Object.assign({ id: PMData.uid() }, data));
      showToast('Education record added!', 'success');
    }

    PMData.saveProfile(profile);
    closeEduModal();
    render();
  });

  /* ---- Delete ---- */
  const deleteEduModalOverlay = document.getElementById('deleteEduModalOverlay');
  const deleteEduName = document.getElementById('deleteEduName');

  function openDeleteModal(id) {
    deletingEduId = id;
    const ed = profile.education.find(e => e.id === id);
    deleteEduName.textContent = ed ? ed.college : 'this record';
    deleteEduModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
  }
  function closeDeleteModal() {
    deleteEduModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }

  document.getElementById('deleteEduNoBtn').addEventListener('click', closeDeleteModal);
  deleteEduModalOverlay.addEventListener('click', (e) => { if (e.target === deleteEduModalOverlay) closeDeleteModal(); });

  document.getElementById('deleteEduYesBtn').addEventListener('click', () => {
    profile.education = profile.education.filter(e => e.id !== deletingEduId);
    PMData.saveProfile(profile);
    closeDeleteModal();
    render();
    showToast('Education record deleted.', 'success');
  });

  /* ---- Delegation ---- */
  educationList.addEventListener('click', (e) => {
    const editBtn = e.target.closest('.edu-edit-btn');
    const deleteBtn = e.target.closest('.edu-delete-btn');
    if (editBtn) openEduModal(editBtn.dataset.id);
    if (deleteBtn) openDeleteModal(deleteBtn.dataset.id);
  });
});

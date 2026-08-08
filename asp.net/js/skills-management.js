/* ============================================================
   SIMS - Module 2 : Skills Management page JavaScript
============================================================ */
document.addEventListener('pmChromeReady', () => {

  let profile = PMData.getProfile();
  let editingSkillId = null;
  let deletingSkillId = null;
  let searchTerm = '';

  const skillsWrap = document.getElementById('skillsWrap');
  const skillsEmptyState = document.getElementById('skillsEmptyState');
  const skillsCountLabel = document.getElementById('skillsCountLabel');

  function escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
  }

  function render() {
    const skills = profile.skills || [];
    skillsCountLabel.textContent = `${skills.length} skill${skills.length === 1 ? '' : 's'} added`;

    const filtered = skills.filter(s => s.name.toLowerCase().includes(searchTerm.toLowerCase()));

    if (!filtered.length) {
      skillsWrap.innerHTML = '';
      skillsEmptyState.style.display = 'block';
      return;
    }
    skillsEmptyState.style.display = 'none';

    skillsWrap.innerHTML = filtered.map(s => `
      <span class="skill-tag" data-id="${s.id}">
        ${escapeHtml(s.name)}
        <span class="skill-tag-actions">
          <button type="button" class="skill-edit-btn" data-id="${s.id}" aria-label="Edit skill"><i class="fa-solid fa-pen"></i></button>
          <button type="button" class="skill-delete-btn" data-id="${s.id}" aria-label="Delete skill"><i class="fa-solid fa-xmark"></i></button>
        </span>
      </span>
    `).join('');
  }

  render();

  /* ---- Search ---- */
  document.getElementById('skillSearchInput').addEventListener('input', (e) => {
    searchTerm = e.target.value;
    render();
  });

  /* ---- Add / Edit modal ---- */
  const skillModalOverlay = document.getElementById('skillModalOverlay');
  const skillModalTitle = document.getElementById('skillModalTitle');
  const skillNameInput = document.getElementById('skillNameInput');
  const skillNameError = document.getElementById('skillNameError');

  function openSkillModal(id) {
    editingSkillId = id || null;
    skillNameError.classList.remove('show');
    skillNameInput.closest('.pm-form-group').classList.remove('has-error');
    if (id) {
      const skill = profile.skills.find(s => s.id === id);
      skillModalTitle.textContent = 'Edit Skill';
      skillNameInput.value = skill ? skill.name : '';
    } else {
      skillModalTitle.textContent = 'Add Skill';
      skillNameInput.value = '';
    }
    skillModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
    setTimeout(() => skillNameInput.focus(), 100);
  }
  function closeSkillModal() {
    skillModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }

  document.getElementById('addSkillBtn').addEventListener('click', () => openSkillModal(null));
  document.getElementById('skillModalCloseBtn').addEventListener('click', closeSkillModal);
  document.getElementById('skillCancelBtn').addEventListener('click', closeSkillModal);
  skillModalOverlay.addEventListener('click', (e) => { if (e.target === skillModalOverlay) closeSkillModal(); });

  document.getElementById('skillSaveBtn').addEventListener('click', () => {
    const name = skillNameInput.value.trim();
    if (!name) {
      skillNameError.classList.add('show');
      skillNameInput.closest('.pm-form-group').classList.add('has-error');
      return;
    }

    const duplicate = profile.skills.some(s => s.name.toLowerCase() === name.toLowerCase() && s.id !== editingSkillId);
    if (duplicate) {
      skillNameError.textContent = 'This skill is already on your profile.';
      skillNameError.classList.add('show');
      skillNameInput.closest('.pm-form-group').classList.add('has-error');
      return;
    }

    if (editingSkillId) {
      const skill = profile.skills.find(s => s.id === editingSkillId);
      if (skill) skill.name = name;
      showToast('Skill updated successfully!', 'success');
    } else {
      profile.skills.push({ id: PMData.uid(), name });
      showToast('Skill added successfully!', 'success');
    }

    PMData.saveProfile(profile);
    closeSkillModal();
    render();
  });

  /* ---- Delete confirmation ---- */
  const deleteSkillModalOverlay = document.getElementById('deleteSkillModalOverlay');
  const deleteSkillName = document.getElementById('deleteSkillName');

  function openDeleteModal(id) {
    deletingSkillId = id;
    const skill = profile.skills.find(s => s.id === id);
    deleteSkillName.textContent = skill ? skill.name : 'this skill';
    deleteSkillModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
  }
  function closeDeleteModal() {
    deleteSkillModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }

  document.getElementById('deleteSkillNoBtn').addEventListener('click', closeDeleteModal);
  deleteSkillModalOverlay.addEventListener('click', (e) => { if (e.target === deleteSkillModalOverlay) closeDeleteModal(); });

  document.getElementById('deleteSkillYesBtn').addEventListener('click', () => {
    profile.skills = profile.skills.filter(s => s.id !== deletingSkillId);
    PMData.saveProfile(profile);
    closeDeleteModal();
    render();
    showToast('Skill removed.', 'success');
  });

  /* ---- Event delegation for edit/delete buttons on tags ---- */
  skillsWrap.addEventListener('click', (e) => {
    const editBtn = e.target.closest('.skill-edit-btn');
    const deleteBtn = e.target.closest('.skill-delete-btn');
    if (editBtn) openSkillModal(editBtn.dataset.id);
    if (deleteBtn) openDeleteModal(deleteBtn.dataset.id);
  });
});

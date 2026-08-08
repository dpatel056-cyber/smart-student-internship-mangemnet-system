/* ============================================================
   SIMS - Module 2 : My Profile page JavaScript
   Renders the student profile from PMData (localStorage demo)
   once profile-shared.js signals the chrome (sidebar/topbar) is
   ready via the "pmChromeReady" event.
============================================================ */
document.addEventListener('pmChromeReady', () => {

  const profile = PMData.getProfile();
  const initials = PMData.getInitials(profile.fullName);

  /* ---- Left summary card ---- */
  const avatarLg = document.getElementById('pmAvatarLg');
  if (profile.photo) {
    avatarLg.innerHTML = `<img src="${profile.photo}" alt="${profile.fullName}">`;
  } else {
    avatarLg.textContent = initials;
  }

  document.getElementById('pmName').textContent = profile.fullName;
  document.getElementById('pmEnrollment').textContent = profile.enrollment;
  document.getElementById('pmCourseLine').textContent = `${profile.course}, ${profile.department}`;
  document.getElementById('pmCollegeLine').textContent = profile.college;

  /* ---- Right info grid ---- */
  document.getElementById('pmEmail').textContent = profile.email || '-';
  document.getElementById('pmMobile').textContent = profile.mobile || '-';
  document.getElementById('pmDepartment').textContent = profile.department || '-';
  document.getElementById('pmCourse').textContent = profile.course || '-';
  document.getElementById('pmSemester').textContent = profile.semester || '-';
  document.getElementById('pmCollege').textContent = profile.college || '-';
  document.getElementById('pmAddress').textContent = profile.address && profile.address.trim() ? profile.address : 'Not added yet';

  const resumeStatusEl = document.getElementById('pmResumeStatus');
  if (profile.resumeUploaded) {
    resumeStatusEl.className = 'pm-resume-status uploaded';
    resumeStatusEl.innerHTML = '<i class="fa-solid fa-circle-check"></i> Uploaded';
  } else {
    resumeStatusEl.className = 'pm-resume-status missing';
    resumeStatusEl.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i> Not Uploaded';
  }

  const completion = PMData.getCompletion(profile);
  document.getElementById('pmCompletionValue').textContent = `${completion.percent}% Complete`;
  document.getElementById('pmMiniPercent').textContent = `${completion.percent}%`;
  document.getElementById('pmMiniBar').style.width = completion.percent + '%';

  const skillsWrap = document.getElementById('pmSkillsInline');
  if (profile.skills && profile.skills.length) {
    skillsWrap.innerHTML = profile.skills.map(s => `<span class="skill-tag">${escapeHtml(s.name)}</span>`).join('');
  } else {
    skillsWrap.innerHTML = `<span style="font-size:12.5px;color:var(--text-muted);">No skills added yet. <a href="skills-management.html" style="color:var(--blue-600);font-weight:600;">Add skills</a></span>`;
  }

  function escapeHtml(str) {
    const div = document.createElement('div');
    div.textContent = str;
    return div.innerHTML;
  }

  /* ---- View Resume modal ---- */
  const resumeModalOverlay = document.getElementById('resumeModalOverlay');
  const viewResumeBtn = document.getElementById('viewResumeBtn');
  const resumeModalCloseBtn = document.getElementById('resumeModalCloseBtn');
  const resumeModalCloseBtn2 = document.getElementById('resumeModalCloseBtn2');
  const resumeModalSub = document.getElementById('resumeModalSub');
  const resumeDownloadBtn = document.getElementById('resumeDownloadBtn');

  function openResumeModal() {
    if (profile.resumeUploaded) {
      resumeModalSub.innerHTML = `<strong>${escapeHtml(profile.resumeName || 'Resume.pdf')}</strong><br>Last updated: ${profile.resumeUpdated || '-'}`;
      resumeDownloadBtn.style.display = 'flex';
    } else {
      resumeModalSub.textContent = "You haven't uploaded a resume yet. Upload one from the Dashboard to let recruiters view it.";
      resumeDownloadBtn.style.display = 'none';
    }
    resumeModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
  }
  function closeResumeModal() {
    resumeModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }

  if (viewResumeBtn) viewResumeBtn.addEventListener('click', openResumeModal);
  [resumeModalCloseBtn, resumeModalCloseBtn2].forEach(btn => btn && btn.addEventListener('click', closeResumeModal));
  resumeModalOverlay.addEventListener('click', (e) => { if (e.target === resumeModalOverlay) closeResumeModal(); });
  resumeDownloadBtn.addEventListener('click', () => {
    closeResumeModal();
    showToast('Resume download started (demo).', 'success');
  });
});

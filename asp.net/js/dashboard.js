/* ============================================================
   SIMS - Student Dashboard JavaScript
   Vanilla JS only. Handles:
     - Session/auth guard (redirects to login.html if not a
       logged-in Student — for a real backend this same check
       should also be enforced server-side, see the ASP.NET
       note at the top of student-dashboard.html)
     - Populating the Welcome Message + Student Profile Card
       from the session saved by login.js
     - Rendering Recent Applications / Upcoming Interviews /
       Notifications from demo data
     - Sidebar (mobile open/close), Topbar profile dropdown,
       Notification bell
     - Logout confirmation popup (Yes -> Public Home Page,
       No -> stay on Dashboard)
============================================================ */

/* =========================================================
   AUTH GUARD — runs immediately (not waiting on DOMContentLoaded)
   so an unauthenticated user is redirected as early as possible.
========================================================= */
(function authGuard() {
  let session = null;
  try {
    session = JSON.parse(localStorage.getItem('simsSession'));
  } catch (e) {
    session = null;
  }

  if (!session || session.role !== 'student') {
    window.location.href = 'login.html';
  }
})();

document.addEventListener('DOMContentLoaded', () => {

  /* =========================================================
     Master Page: Inject Sidebar & Topbar Logic
  ========================================================= */
  /* Sidebar injection moved to student-layout.js */

  /* =========================================================
     Load session + demo student profile
  ========================================================= */
  let session = null;
  try {
    session = JSON.parse(localStorage.getItem('simsSession'));
  } catch (e) {
    session = null;
  }

  // Guard again in case localStorage changed between the two checks.
  if (!session || session.role !== 'student') {
    window.location.href = 'login.html';
    return;
  }

  let savedProfile = {};
  try { savedProfile = JSON.parse(localStorage.getItem(`simsStudentProfileData_${session.email}`)) || {}; } catch (e) {}
  const STUDENT_PROFILE = {
    name: savedProfile.fullName || session.name || 'Student',
    email: savedProfile.email || (session.email && session.email.includes('@') ? session.email : 'student@sims.com'),
    enrollment: savedProfile.enrollment || session.enrollment || 'ENR2024001'
  };

  const studentEmail = STUDENT_PROFILE.email;
  const studentName = STUDENT_PROFILE.name;

  function seedStudentFallbackData() {
    if (!localStorage.getItem('SIMS_APPLICATIONS_DATA')) {
      localStorage.setItem('SIMS_APPLICATIONS_DATA', JSON.stringify([
        {
          id: 'APP-10001',
          internshipId: 1,
          internshipTitle: 'Frontend Developer Intern',
          company: 'TechNova Pvt Ltd',
          studentName,
          studentEmail,
          status: 'Shortlisted',
          appliedOn: new Date(Date.now() - 1000 * 60 * 60 * 24 * 3).toISOString()
        },
        {
          id: 'APP-10002',
          internshipId: 2,
          internshipTitle: 'Data Analyst Intern',
          company: 'Bright Solutions',
          studentName,
          studentEmail,
          status: 'Pending',
          appliedOn: new Date(Date.now() - 1000 * 60 * 60 * 24 * 7).toISOString()
        }
      ]));
    }

    if (!localStorage.getItem('SIMS_NOTIFS_DATA')) {
      localStorage.setItem('SIMS_NOTIFS_DATA', JSON.stringify([
        {
          id: 'NOTIF-10001',
          userId: studentEmail,
          title: 'Application Update',
          message: 'Your application for Frontend Developer Intern was shortlisted.',
          type: 'success',
          read: false,
          date: new Date().toISOString()
        },
        {
          id: 'NOTIF-10002',
          userId: studentEmail,
          title: 'Resume Reminder',
          message: 'Your latest resume was successfully uploaded.',
          type: 'info',
          read: true,
          date: new Date(Date.now() - 1000 * 60 * 60 * 24).toISOString()
        }
      ]));
    }

    if (!localStorage.getItem('SIMS_INTERVIEWS_DATA')) {
      localStorage.setItem('SIMS_INTERVIEWS_DATA', JSON.stringify([
        {
          id: 'INTV-10001',
          studentEmail,
          studentName,
          company: 'Bright Solutions',
          internshipTitle: 'Data Analyst Intern',
          date: new Date(Date.now() + 1000 * 60 * 60 * 24 * 5).toISOString()
        }
      ]));
    }
  }

  // GlobalStore owns all initial data. Keeping one seed path prevents pages
  // from overwriting each other's live student records.
  window.GlobalStore?.ensureSeedStudentData();

  function getStudentApplications() {
    const apps = window.GlobalStore ? window.GlobalStore.getApplications() : [];
    return apps.filter(app => app.studentEmail === studentEmail);
  }

  function getStudentNotifications() {
    const all = JSON.parse(localStorage.getItem('SIMS_NOTIFS_DATA')) || [];
    return all.filter(n => n.userId === studentEmail || n.userId === studentName);
  }

  function updateSidebarBadges() {
    const apps = getStudentApplications();
    const notifications = getStudentNotifications();
    const appCount = apps.length;
    const unreadCount = notifications.filter(n => !n.read).length;

    document.querySelectorAll('.sidebar-link[data-page="applications"] .badge-count').forEach(el => {
      el.textContent = appCount > 0 ? appCount : '';
    });
    document.querySelectorAll('.sidebar-link[data-page="notifications"] .badge-count').forEach(el => {
      el.textContent = unreadCount > 0 ? unreadCount : '';
    });

    const topbarBadge = document.querySelector('#dashNotifBtn .badge, .icon-btn .badge');
    if (topbarBadge) {
      topbarBadge.textContent = unreadCount > 0 ? unreadCount : '';
    }
  }

  function getInitials(name) {
    return name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase();
  }

  const initials = getInitials(STUDENT_PROFILE.name);
  const avatarImage = savedProfile.photo ? `<img src="${savedProfile.photo}" alt="${STUDENT_PROFILE.name}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;">` : null;
  const dashAvatarSm = document.getElementById('dashAvatarSm');
  if (dashAvatarSm) dashAvatarSm.innerHTML = avatarImage || initials;
  
  const dashAvatarLg = document.getElementById('dashAvatarLg');
  if (dashAvatarLg) dashAvatarLg.innerHTML = avatarImage || initials;
  
  const profileName = document.getElementById('profileName');
  if (profileName) profileName.textContent = STUDENT_PROFILE.name;
  
  const profileEmail = document.getElementById('profileEmail');
  if (profileEmail) profileEmail.textContent = STUDENT_PROFILE.email;
  
  const profileEnrollment = document.getElementById('profileEnrollment');
  if (profileEnrollment) profileEnrollment.textContent = STUDENT_PROFILE.enrollment;
  
  const profileCourse = document.getElementById('profileCourse');
  const profileCollege = document.getElementById('profileCollege');
  if (profileCourse) profileCourse.textContent = [savedProfile.course, savedProfile.department].filter(Boolean).join(', ');
  if (profileCollege) profileCollege.textContent = savedProfile.college || '';

  // Pages that include a compact student summary use the same profile source.
  const setProfileText = (id, value) => {
    const element = document.getElementById(id);
    if (element && value) element.textContent = value;
  };
  setProfileText('applicationProfileName', STUDENT_PROFILE.name);
  setProfileText('applicationProfileAcademic', [savedProfile.course, savedProfile.department, savedProfile.college].filter(Boolean).join(' • '));
  setProfileText('applicationProfileEmail', STUDENT_PROFILE.email);
  setProfileText('applicationProfileMobile', savedProfile.mobile);
  document.querySelectorAll('.sidebar-link[href="#"], .quick-action-btn[href="#"], .profile-dropdown a[href="#"]').forEach(link => {
    link.addEventListener('click', (e) => {
      if (link.id === 'logoutLink' || link.id === 'dropdownLogoutLink') return; // handled separately
      e.preventDefault();
      showToast('This section is coming soon in the full build.', 'success');
    });
  });

  /* =========================================================
     Profile dropdown toggle
  ========================================================= */
  const dashProfileTrigger = document.getElementById('dashProfileTrigger');
  const profileDropdown = document.getElementById('profileDropdown');

  if (dashProfileTrigger && profileDropdown) {
    profileDropdown.querySelectorAll('a[href="settings.html"]').forEach((link) => {
      const maybeHr = link.nextElementSibling && link.nextElementSibling.tagName === 'HR'
        ? link.nextElementSibling
        : (link.previousElementSibling && link.previousElementSibling.tagName === 'HR' ? link.previousElementSibling : null);
      link.remove();
      if (maybeHr) maybeHr.remove();
    });

    dashProfileTrigger.addEventListener('click', (e) => {
      e.stopPropagation();
      profileDropdown.classList.toggle('open');
    });

    document.addEventListener('click', (e) => {
      if (!profileDropdown.contains(e.target) && !dashProfileTrigger.contains(e.target)) {
        profileDropdown.classList.remove('open');
      }
    });
  }

  /* =========================================================
     Notification bell + theme toggle (demo — reuses the toast pattern)
  ========================================================= */
  const dashNotifBtn = document.getElementById('dashNotifBtn');
  if (dashNotifBtn) {
    dashNotifBtn.addEventListener('click', () => {
      window.location.href = 'notifications.html';
    });
  }

  const themeToggleBtn = document.querySelector('.theme-toggle-btn, #themeToggleBtn');
  if (themeToggleBtn) {
    themeToggleBtn.addEventListener('click', () => {
      document.body.classList.toggle('dark-theme');
      themeToggleBtn.classList.toggle('active');
      const icon = themeToggleBtn.querySelector('i');
      icon.className = document.body.classList.contains('dark-theme') ? 'fa-solid fa-sun' : 'fa-solid fa-moon';
    });
  }

  /* =========================================================
     Toast helper (same visual language as login page)
  ========================================================= */
  const toast = document.getElementById('dashToast');
  const toastMsg = document.getElementById('dashToastMsg');
  let toastTimer = null;

  function showToast(message, type = 'success') {
    toast.classList.remove('success', 'error');
    toast.classList.add(type);
    toastMsg.textContent = message;
    toast.querySelector('i').className = type === 'success'
      ? 'fa-solid fa-circle-check'
      : 'fa-solid fa-circle-exclamation';
    toast.classList.add('show');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => toast.classList.remove('show'), 3000);
  }

  /* =========================================================
     LOGOUT — confirmation popup
     Yes -> clear session, go to Public Home Page (index.html)
     No  -> close popup, stay on Dashboard
  ========================================================= */
  const logoutModalOverlay = document.getElementById('logoutModalOverlay');
  const logoutLink = document.getElementById('logoutLink');
  const dropdownLogoutLink = document.getElementById('dropdownLogoutLink');
  const logoutYesBtn = document.getElementById('logoutYesBtn');
  const logoutNoBtn = document.getElementById('logoutNoBtn');

  function openLogoutModal(e) {
    if (e) e.preventDefault();
    profileDropdown.classList.remove('open');
    logoutModalOverlay.classList.add('open');
    document.body.classList.add('modal-open');
  }

  function closeLogoutModal() {
    logoutModalOverlay.classList.remove('open');
    document.body.classList.remove('modal-open');
  }

  [logoutLink, dropdownLogoutLink].forEach(el => {
    if (el && !el.hasAttribute('data-bs-toggle')) el.addEventListener('click', openLogoutModal);
  });

  if (logoutNoBtn) logoutNoBtn.addEventListener('click', closeLogoutModal);

  if (logoutModalOverlay) {
    logoutModalOverlay.addEventListener('click', (e) => {
      if (e.target === logoutModalOverlay) closeLogoutModal();
    });
  }

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && logoutModalOverlay && logoutModalOverlay.classList.contains('open')) {
      closeLogoutModal();
    }
  });

  if (logoutYesBtn) {
    logoutYesBtn.addEventListener('click', () => {
      localStorage.removeItem('simsSession');
      window.location.href = 'index.html';
    });
  }

  window.addEventListener('storage', (e) => {
    if (e.key === 'SIMS_APPLICATIONS_DATA' || e.key === 'SIMS_NOTIFS_DATA' || e.key === 'SIMS_INTERVIEWS_DATA') {
      renderDashboardWidgets();
    }
  });

  window.addEventListener('sims:data-changed', renderDashboardWidgets);

});

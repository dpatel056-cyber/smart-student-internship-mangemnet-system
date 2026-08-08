/* ============================================================
   SIMS - Company Dashboard JavaScript
   Handles:
     - Auth Guard (company role only)
     - Centralized Sidebar Injection (Master Page)
     - Dynamic Active State + Breadcrumbs
     - Profile Dropdown + Sidebar Toggle
     - Logout Confirmation Popup
     - Toast Notifications
   ASP.NET NOTE: In production replace the localStorage session
   guard with a server-side Session["Role"] check in Page_Load.
============================================================ */

/* =========================================================
   AUTH GUARD — runs immediately
========================================================= */
(function authGuard() {
  let session = null;
  try { session = JSON.parse(localStorage.getItem('simsSession')); } catch(e){}
  if (!session || session.role !== 'company') {
    window.location.href = 'login.html?role=company';
  }
})();

document.addEventListener('DOMContentLoaded', () => {

  /* =========================================================
     Session
  ========================================================= */
  let session = {};
  try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}

  if (!session.role || session.role !== 'company') {
    window.location.href = 'login.html?role=company';
    return;
  }

  const COMPANY = {
    name: session.name || 'TechNova Pvt Ltd',
    email: session.email || 'company@sims.com'
  };

  function getInitials(name) {
    return name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase();
  }

  /* =========================================================
     Master Sidebar Injection
  ========================================================= */
  const sidebarEl = document.getElementById('dashboardSidebar');
  if (sidebarEl) {
    sidebarEl.innerHTML = `
      <a href="company-dashboard.html" class="sidebar-brand">
        <span class="brand-icon"><i class="fa-solid fa-building"></i></span>
        <span class="brand-text">
          <span class="brand-name">SIMS</span>
          <span class="brand-sub">Company Panel</span>
        </span>
      </a>
      <nav class="sidebar-nav">
        <ul>
          <li><a href="company-dashboard.html" class="sidebar-link" id="sl-dashboard"><i class="fa-solid fa-house"></i> Dashboard</a></li>
        </ul>
        <div class="sidebar-divider"></div>
        <p class="co-sidebar-label">Company</p>
        <ul>
          <li><a href="company-profile.html" class="sidebar-link" id="sl-profile"><i class="fa-solid fa-building"></i> Company Profile</a></li>
          <li><a href="company-edit-profile.html" class="sidebar-link" id="sl-edit-profile"><i class="fa-solid fa-pen-to-square"></i> Edit Profile</a></li>
        </ul>
        <div class="sidebar-divider"></div>
        <p class="co-sidebar-label">Internship Management</p>
        <ul>
          <li><a href="company-post-internship.html" class="sidebar-link" id="sl-post"><i class="fa-solid fa-plus-circle"></i> Post Internship</a></li>
          <li><a href="company-manage-internships.html" class="sidebar-link" id="sl-manage"><i class="fa-solid fa-layer-group"></i> Manage Internships</a></li>
          <li><a href="company-internship-performance.html" class="sidebar-link" id="sl-performance"><i class="fa-solid fa-chart-line"></i> Internship Performance</a></li>
          <li><a href="#" class="sidebar-link" id="sl-applications"><i class="fa-solid fa-file-lines"></i> View Applications</a></li>
        </ul>
        <div class="sidebar-divider"></div>
        <p class="co-sidebar-label">Students</p>
        <ul>
          <li><a href="company-applications.html" class="sidebar-link" id="sl-applications"><i class="fa-solid fa-file-lines"></i> Applications Received</a></li>
          <li><a href="company-shortlisted.html" class="sidebar-link" id="sl-shortlist"><i class="fa-solid fa-star"></i> Shortlisted Students</a></li>
          <li><a href="company-selected.html" class="sidebar-link" id="sl-selected"><i class="fa-solid fa-circle-check"></i> Selected Students</a></li>
          <li><a href="company-rejected.html" class="sidebar-link" id="sl-rejected"><i class="fa-solid fa-user-xmark"></i> Rejected Students</a></li>
        </ul>
        <div class="sidebar-divider"></div>
        <p class="co-sidebar-label">Interview & Hiring</p>
        <ul>
          <li><a href="company-interview-schedule.html" class="sidebar-link" id="sl-interviews"><i class="fa-solid fa-calendar-check"></i> Interview Schedule</a></li>
          <li><a href="company-hired.html" class="sidebar-link" id="sl-hired"><i class="fa-solid fa-user-tie"></i> Hired Students</a></li>
          <li><a href="company-offer-letter.html" class="sidebar-link" id="sl-offer"><i class="fa-solid fa-envelope-open-text"></i> Offer Letters</a></li>
        </ul>
        <div class="sidebar-divider"></div>
        <p class="co-sidebar-label">Reports & Communication</p>
        <ul>
          <li><a href="company-messages.html" class="sidebar-link" id="sl-messages"><i class="fa-regular fa-message"></i> Messages & Chat</a></li>
          <li><a href="company-reports.html" class="sidebar-link" id="sl-reports"><i class="fa-solid fa-file-invoice"></i> Reports Generation</a></li>
          <li><a href="company-analytics.html" class="sidebar-link" id="sl-analytics"><i class="fa-solid fa-chart-pie"></i> Analytics Dashboard</a></li>
          <li><a href="company-feedback.html" class="sidebar-link" id="sl-feedback"><i class="fa-regular fa-star"></i> Feedback & Ratings</a></li>
          <li><a href="company-notifications.html" class="sidebar-link" id="sl-notifications"><i class="fa-regular fa-bell"></i> Notifications <span class="badge-count">2</span></a></li>
          <li><a href="company-settings.html" class="sidebar-link" id="sl-settings"><i class="fa-solid fa-gear"></i> Settings</a></li>
        </ul>
      </nav>
      <div class="sidebar-logout">
        <a href="#" class="sidebar-link" id="logoutLink">
          <i class="fa-solid fa-right-from-bracket"></i> Logout
        </a>
      </div>
    `;

    /* Auto Active State */
    const currentPage = window.location.pathname.split('/').pop() || 'company-dashboard.html';
    const pageToSidebar = {
      'company-dashboard.html': 'sl-dashboard',
      'company-profile.html': 'sl-profile',
      'company-edit-profile.html': 'sl-edit-profile',
      'company-analytics.html': 'sl-analytics',
      'company-post-internship.html': 'sl-post',
      'company-manage-internships.html': 'sl-manage',
      'company-edit-internship.html': 'sl-manage',
      'company-internship-details.html': 'sl-manage',
      'company-internship-performance.html': 'sl-performance',
      'company-applications.html': 'sl-applications',
      'company-student-details.html': 'sl-applications',
      'company-resume-viewer.html': 'sl-applications',
      'company-shortlisted.html': 'sl-shortlist',
      'company-selected.html': 'sl-selected',
      'company-rejected.html': 'sl-rejected',
      'company-interview-schedule.html': 'sl-interviews',
      'company-interview-details.html': 'sl-interviews',
      'company-interview-feedback.html': 'sl-interviews',
      'company-offer-letter.html': 'sl-offer',
      'company-hired.html': 'sl-hired',
      'company-notifications.html': 'sl-notifications',
      'company-messages.html': 'sl-messages',
      'company-reports.html': 'sl-reports',
      'company-feedback.html': 'sl-feedback',
      'company-settings.html': 'sl-settings',
      'company-settings-password.html': 'sl-settings',
      'company-settings-theme.html': 'sl-settings',
      'company-settings-language.html': 'sl-settings',
      'company-settings-security.html': 'sl-settings',
    };

    const activeId = pageToSidebar[currentPage];
    if (activeId) {
      const activeLink = document.getElementById(activeId);
      if (activeLink) activeLink.classList.add('active');
    }

    /* Breadcrumb injection */
    const breadcrumbEl = document.querySelector('.pm-breadcrumb');
    if (breadcrumbEl) {
      const breadcrumbs = {
        'company-dashboard.html': `<span class="current">Dashboard</span>`,
        'company-profile.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Company Profile</span>`,
        'company-edit-profile.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-profile.html">Company Profile</a><i class="fa-solid fa-chevron-right"></i><span class="current">Edit Profile</span>`,
        'company-analytics.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Analytics</span>`,
        'company-post-internship.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-manage-internships.html">Internship Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Post Internship</span>`,
        'company-manage-internships.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Manage Internships</span>`,
        'company-edit-internship.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-manage-internships.html">Manage Internships</a><i class="fa-solid fa-chevron-right"></i><span class="current">Edit Internship</span>`,
        'company-internship-details.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-manage-internships.html">Manage Internships</a><i class="fa-solid fa-chevron-right"></i><span class="current">Internship Details</span>`,
        'company-internship-performance.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Internship Performance</span>`,
        'company-applications.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Applications Received</span>`,
        'company-student-details.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-applications.html">Applications Received</a><i class="fa-solid fa-chevron-right"></i><span class="current">Student Details</span>`,
        'company-resume-viewer.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-applications.html">Applications Received</a><i class="fa-solid fa-chevron-right"></i><a href="company-student-details.html">Student Details</a><i class="fa-solid fa-chevron-right"></i><span class="current">Resume Viewer</span>`,
        'company-shortlisted.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Shortlisted Students</span>`,
        'company-selected.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Selected Students</span>`,
        'company-rejected.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Rejected Students</span>`,
        'company-interview-schedule.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Interview Schedule</span>`,
        'company-interview-details.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-interview-schedule.html">Interview Schedule</a><i class="fa-solid fa-chevron-right"></i><span class="current">Interview Details</span>`,
        'company-interview-feedback.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-interview-schedule.html">Interview Schedule</a><i class="fa-solid fa-chevron-right"></i><a href="company-interview-details.html">Interview Details</a><i class="fa-solid fa-chevron-right"></i><span class="current">Feedback</span>`,
        'company-offer-letter.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Offer Letter Generation</span>`,
        'company-hired.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Hired Students</span>`,
        'company-notifications.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Notifications</span>`,
        'company-messages.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Messages & Chat</span>`,
        'company-reports.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Reports Generation</span>`,
        'company-feedback.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Feedback & Ratings</span>`,
        'company-settings.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><span class="current">Settings</span>`,
        'company-settings-password.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-settings.html">Settings</a><i class="fa-solid fa-chevron-right"></i><span class="current">Change Password</span>`,
        'company-settings-theme.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-settings.html">Settings</a><i class="fa-solid fa-chevron-right"></i><span class="current">Theme & Appearance</span>`,
        'company-settings-language.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-settings.html">Settings</a><i class="fa-solid fa-chevron-right"></i><span class="current">Language Settings</span>`,
        'company-settings-security.html': `<a href="company-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i><a href="company-settings.html">Settings</a><i class="fa-solid fa-chevron-right"></i><span class="current">Privacy & Security</span>`,
      };
      breadcrumbEl.innerHTML = breadcrumbs[currentPage] || `<a href="company-dashboard.html">Dashboard</a>`;
    }

    /* Sidebar #-links toast */
    sidebarEl.querySelectorAll('.sidebar-link[href="#"]').forEach(link => {
      link.addEventListener('click', e => {
        e.preventDefault();
        showToast('This section is coming in the next module.', 'success');
      });
    });
  }

  /* =========================================================
     Populate topbar with company info
  ========================================================= */
  const dashAvatarSm = document.getElementById('dashAvatarSm');
  const dashAvatarLg = document.getElementById('dashAvatarLg');
  const dashNameTop  = document.getElementById('dashNameTop');
  const profileName  = document.getElementById('profileName');
  const profileEmail = document.getElementById('profileEmailDisplay');
  const welcomeHeading = document.getElementById('welcomeHeading');
  const welcomeDate    = document.getElementById('welcomeDate');

  const initials = getInitials(COMPANY.name);
  if (dashAvatarSm) dashAvatarSm.textContent = initials;
  if (dashAvatarLg) dashAvatarLg.textContent = initials;
  if (dashNameTop)  dashNameTop.innerHTML = `${COMPANY.name}<span>Company</span>`;
  if (profileName)  profileName.textContent = COMPANY.name;
  if (profileEmail) profileEmail.textContent = COMPANY.email;
  if (welcomeHeading) welcomeHeading.textContent = `Welcome back, ${COMPANY.name.split(' ')[0]}! 👋`;
  if (welcomeDate) {
    welcomeDate.textContent = new Date().toLocaleDateString('en-IN', {
      weekday: 'long', day: 'numeric', month: 'long', year: 'numeric'
    });
  }

  /* =========================================================
     Sidebar — mobile open/close
  ========================================================= */
  const sidebar    = document.getElementById('dashboardSidebar');
  const toggleBtn  = document.getElementById('sidebarToggleBtn');
  const backdrop   = document.getElementById('sidebarBackdrop');

  function openSidebar()  { sidebar.classList.add('open'); backdrop.classList.add('show'); }
  function closeSidebar() { sidebar.classList.remove('open'); backdrop.classList.remove('show'); }

  if (toggleBtn)  toggleBtn.addEventListener('click', () => sidebar.classList.contains('open') ? closeSidebar() : openSidebar());
  if (backdrop)   backdrop.addEventListener('click', closeSidebar);

  /* =========================================================
     Profile dropdown
  ========================================================= */
  const trigger  = document.getElementById('dashProfileTrigger');
  const dropdown = document.getElementById('profileDropdown');

  if (trigger && dropdown) {
    trigger.addEventListener('click', e => { e.stopPropagation(); dropdown.classList.toggle('open'); });
    document.addEventListener('click', e => {
      if (!dropdown.contains(e.target) && !trigger.contains(e.target)) dropdown.classList.remove('open');
    });
  }

  /* =========================================================
     Toast
  ========================================================= */
  const toast    = document.getElementById('dashToast');
  const toastMsg = document.getElementById('dashToastMsg');
  let toastTimer = null;

  function showToast(message, type = 'success') {
    if (!toast) return;
    toast.classList.remove('success', 'error');
    toast.classList.add(type);
    toastMsg.textContent = message;
    const icon = toast.querySelector('i');
    if (icon) icon.className = type === 'success' ? 'fa-solid fa-circle-check' : 'fa-solid fa-circle-exclamation';
    toast.classList.add('show');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => toast.classList.remove('show'), 3000);
  }

  /* =========================================================
     LOGOUT
  ========================================================= */
  const logoutOverlay    = document.getElementById('logoutModalOverlay');
  const logoutLink       = document.getElementById('logoutLink');
  const dropdownLogout   = document.getElementById('dropdownLogoutLink');
  const logoutYesBtn     = document.getElementById('logoutYesBtn');
  const logoutNoBtn      = document.getElementById('logoutNoBtn');

  function openLogout(e) {
    if (e) e.preventDefault();
    if (dropdown) dropdown.classList.remove('open');
    if (logoutOverlay) { logoutOverlay.classList.add('open'); document.body.classList.add('modal-open'); }
  }
  function closeLogout() {
    if (logoutOverlay) { logoutOverlay.classList.remove('open'); document.body.classList.remove('modal-open'); }
  }

  [logoutLink, dropdownLogout].forEach(el => { if (el) el.addEventListener('click', openLogout); });
  if (logoutNoBtn) logoutNoBtn.addEventListener('click', closeLogout);
  if (logoutOverlay) logoutOverlay.addEventListener('click', e => { if (e.target === logoutOverlay) closeLogout(); });
  document.addEventListener('keydown', e => { if (e.key === 'Escape' && logoutOverlay?.classList.contains('open')) closeLogout(); });
    if(logoutYesBtn) {
      logoutYesBtn.addEventListener('click', () => {
        window.location.href = 'index.html'; // Redirect to Public Home Page
      });
    }

  /* Expose showToast globally for page-specific scripts */
  window.simsShowToast = showToast;

});

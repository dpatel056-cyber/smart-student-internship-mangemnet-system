/* ============================================================
   SIMS - Student Panel Unified Layout
   Injects the same Sidebar and Header across all student pages.
============================================================ */

document.addEventListener('DOMContentLoaded', () => {

  // 1. Inject Sidebar HTML
  const sidebarEl = document.getElementById('dashboardSidebar');
  if (sidebarEl) {
    sidebarEl.innerHTML = `
      <div class="sidebar-shell">
        <a href="student-dashboard.aspx" class="sidebar-brand">
          <span class="brand-group">
            <span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span>
            <span class="brand-text">
              <span class="brand-name">SIMS</span>
              <span class="brand-sub">Student Panel</span>
            </span>
          </span>
          <button class="sidebar-collapse-btn" type="button" id="sidebarCollapseBtn" aria-label="Collapse sidebar">
            <i class="fa-solid fa-chevron-left"></i>
          </button>
        </a>

        <nav class="sidebar-nav">
          <ul>
            <li class="sidebar-item">
              <a href="student-dashboard.aspx" class="sidebar-link" data-page="dashboard" data-tooltip="Dashboard">
                <span class="sidebar-link-icon"><i class="fa-solid fa-house"></i></span>
                <span class="sidebar-link-label">Dashboard</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="my-profile.aspx" class="sidebar-link" data-page="profile" data-tooltip="My Profile">
                <span class="sidebar-link-icon"><i class="fa-solid fa-user"></i></span>
                <span class="sidebar-link-label">My Profile</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="resume-dashboard.aspx" class="sidebar-link" data-page="resume-dashboard" data-tooltip="Resume Dashboard">
                <span class="sidebar-link-icon"><i class="fa-solid fa-folder-open"></i></span>
                <span class="sidebar-link-label">Resume Dashboard</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="browse-internships.aspx" class="sidebar-link" data-page="browse" data-tooltip="Browse Internships">
                <span class="sidebar-link-icon"><i class="fa-solid fa-magnifying-glass"></i></span>
                <span class="sidebar-link-label">Browse Internships</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="my-applications.aspx" class="sidebar-link" data-page="applications" data-tooltip="My Applications">
                <span class="sidebar-link-icon"><i class="fa-solid fa-clipboard-list"></i></span>
                <span class="sidebar-link-label">My Applications</span>
                <span class="badge-count"></span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="interview-schedule.aspx" class="sidebar-link" data-page="interviews" data-tooltip="Interview Schedule">
                <span class="sidebar-link-icon"><i class="fa-solid fa-calendar-check"></i></span>
                <span class="sidebar-link-label">Interview Schedule</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="offer-letter.aspx" class="sidebar-link" data-page="offer-letter" data-tooltip="Offer Letter">
                <span class="sidebar-link-icon"><i class="fa-solid fa-envelope-open-text"></i></span>
                <span class="sidebar-link-label">Offer Letter</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="upcoming-deadlines.aspx" class="sidebar-link" data-page="upcoming-deadlines" data-tooltip="Upcoming Deadlines">
                <span class="sidebar-link-icon"><i class="fa-solid fa-stopwatch"></i></span>
                <span class="sidebar-link-label">Upcoming Deadlines</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="notifications.aspx" class="sidebar-link" data-page="notifications" data-tooltip="Notifications">
                <span class="sidebar-link-icon"><i class="fa-solid fa-bell"></i></span>
                <span class="sidebar-link-label">Notifications</span>
                <span class="badge-count"></span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="messages.aspx" class="sidebar-link" data-page="messages" data-tooltip="Messages / Chat">
                <span class="sidebar-link-icon"><i class="fa-solid fa-comments"></i></span>
                <span class="sidebar-link-label">Messages / Chat</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="feedback-rating.aspx" class="sidebar-link" data-page="feedback" data-tooltip="Feedback & Rating">
                <span class="sidebar-link-icon"><i class="fa-solid fa-star"></i></span>
                <span class="sidebar-link-label">Feedback & Rating</span>
              </a>
            </li>
            <li class="sidebar-item">
              <a href="help-support.aspx" class="sidebar-link" data-page="help" data-tooltip="Help & Support">
                <span class="sidebar-link-icon"><i class="fa-solid fa-circle-question"></i></span>
                <span class="sidebar-link-label">Help & Support</span>
              </a>
            </li>
          </ul>
        </nav>

        <div class="sidebar-logout">
          <a href="#" class="sidebar-link" id="sidebarLogoutLink" data-tooltip="Logout">
            <span class="sidebar-link-icon"><i class="fa-solid fa-right-from-bracket"></i></span>
            <span class="sidebar-link-label">Logout</span>
          </a>
        </div>
      </div>
    `;

    // Active link highlight
    const currentPath = window.location.pathname.split('/').pop() || 'student-dashboard.aspx';
    const links = sidebarEl.querySelectorAll('.sidebar-link');
    let foundActive = false;
    
    links.forEach(link => {
      link.classList.remove('active');
      if (link.getAttribute('href') === currentPath) {
        link.classList.add('active');
        foundActive = true;
      }
    });

    if (!foundActive) {
      if (currentPath.includes('internship')) {
        const bl = sidebarEl.querySelector('[href="browse-internships.aspx"]');
        if (bl) bl.classList.add('active');
      }
    }
  }

  // 2. Inject Topbar HTML
  const topbarEl = document.querySelector('.dashboard-topbar');
  // Only inject if it's currently empty (we will empty it in the HTML files)
  if (topbarEl && topbarEl.innerHTML.trim() === '') {
    topbarEl.innerHTML = `
      <div class="dashboard-topbar-left">
        <button class="sidebar-toggle-btn" id="sidebarToggleBtn" aria-label="Toggle menu">
          <i class="fa-solid fa-bars"></i>
        </button>
        <div class="dashboard-topbar-search">
          <i class="fa-solid fa-magnifying-glass"></i>
          <input type="text" placeholder="Search menus, interns, updates...">
        </div>
      </div>

      <div class="dashboard-topbar-right">
        <button class="icon-btn dash-icon-btn" id="dashMessageBtn" aria-label="Messages" onclick="window.location.href='messages.aspx'">
          <i class="fa-regular fa-comment"></i>
        </button>
        <button class="icon-btn dash-icon-btn" id="dashNotifBtn" aria-label="Notifications" onclick="window.location.href='notifications.aspx'">
          <i class="fa-regular fa-bell"></i>
          <span class="badge" id="topbarNotifBadge"></span>
        </button>

        <div class="dash-profile-trigger" id="dashProfileTrigger">
          <span class="dash-avatar-sm" id="layoutAvatarSm">AP</span>
          <span class="dash-name" id="layoutNameTop">Student<span>Student</span></span>
          <i class="fa-solid fa-chevron-down" style="font-size:11px;color:#94a3b8;"></i>

          <div class="profile-dropdown" id="profileDropdown">
            <a href="my-profile.aspx"><i class="fa-solid fa-user"></i> My Profile</a>
            <a href="#" class="dropdown-danger" id="dropdownLogoutLink" data-bs-toggle="modal" data-bs-target="#logoutModal"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
          </div>
        </div>
      </div>
    `;
  }

  // 3. Load Session Data (Auth Guard)
  let session = null;
  try {
    session = JSON.parse(localStorage.getItem('simsSession'));
  } catch (e) {
    session = null;
  }
  
  if (!session || session.role !== 'student') {
    window.location.href = 'login.aspx';
    return;
  }
  
  const studentEmail = session.email;
  let currentStudentName = session.name || 'Student';
  
  function updateProfileUI() {
    let savedProfile = {};
    try {
      savedProfile = JSON.parse(localStorage.getItem(`simsStudentProfileData_${session.email}`)) || {};
    } catch (e) {}

    const studentName = savedProfile.fullName || session.name || 'Student';
    currentStudentName = studentName;
    const initials = studentName.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase();
    const avatarImage = savedProfile.photo ? `<img src="${savedProfile.photo}" alt="${studentName}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;">` : null;

    const layoutAvatarSm = document.getElementById('layoutAvatarSm');
    const layoutNameTop = document.getElementById('layoutNameTop');
    const welcomeHeading = document.getElementById('welcomeHeading');
    
    if (layoutAvatarSm) layoutAvatarSm.innerHTML = avatarImage || initials;
    if (layoutNameTop) layoutNameTop.innerHTML = `${studentName}<span>Student</span>`;
    if (welcomeHeading) {
      const firstName = studentName.split(' ')[0];
      welcomeHeading.innerHTML = `Welcome back, ${firstName}! 👋`;
    }
  }
  
  // Call initially
  updateProfileUI();

  // Update on storage change (other tabs)
  window.addEventListener('storage', (e) => {
    if (e.key === `simsStudentProfileData_${session.email}`) {
      updateProfileUI();
    }
  });

  // Update on custom event (this tab)
  window.addEventListener('sims:profile-updated', updateProfileUI);

  // 4. Update Badges Dynamically
  function updateBadges() {
    let allApps = [];
    if (window.GlobalStore && window.GlobalStore.getApplications) {
        allApps = window.GlobalStore.getApplications();
    } else {
        try { allApps = JSON.parse(localStorage.getItem('SIMS_APPLICATIONS_DATA')) || []; } catch(e){}
    }
    const studentApps = allApps.filter(app => app.studentEmail === studentEmail);
    const appCount = studentApps.length;

    let allNotifs = [];
    try { allNotifs = JSON.parse(localStorage.getItem('SIMS_NOTIFS_DATA')) || []; } catch(e){}
    const unreadCount = allNotifs.filter(n => (n.userId === studentEmail || n.userId === currentStudentName) && !n.read).length;

    document.querySelectorAll('.sidebar-link[data-page="applications"] .badge-count').forEach(el => {
        el.textContent = appCount > 0 ? appCount : '';
    });
    document.querySelectorAll('.sidebar-link[data-page="notifications"] .badge-count').forEach(el => {
        el.textContent = unreadCount > 0 ? unreadCount : '';
    });
    
    const topbarBadge = document.getElementById('topbarNotifBadge');
    if (topbarBadge) topbarBadge.textContent = unreadCount > 0 ? unreadCount : '';
  }
  updateBadges();

  // 5. Setup Event Listeners (Sidebar toggle, Profile Dropdown, Logout, Theme)
  const sidebar = document.getElementById('dashboardSidebar');
  const sidebarToggleBtn = document.getElementById('sidebarToggleBtn');
  const sidebarBackdrop = document.getElementById('sidebarBackdrop');
  const sidebarCollapseBtn = document.getElementById('sidebarCollapseBtn');
  
  function openSidebar() {
    if(sidebar) sidebar.classList.add('open');
    if(sidebarBackdrop) sidebarBackdrop.classList.add('show');
  }
  function closeSidebar() {
    if(sidebar) sidebar.classList.remove('open');
    if(sidebarBackdrop) sidebarBackdrop.classList.remove('show');
  }
  
  if (sidebarToggleBtn) sidebarToggleBtn.addEventListener('click', () => {
    sidebar.classList.contains('open') ? closeSidebar() : openSidebar();
  });
  if (sidebarBackdrop) sidebarBackdrop.addEventListener('click', closeSidebar);
  if (sidebarCollapseBtn) {
    sidebarCollapseBtn.addEventListener('click', () => {
      sidebar.classList.toggle('collapsed');
      const icon = sidebarCollapseBtn.querySelector('i');
      icon.className = sidebar.classList.contains('collapsed') ? 'fa-solid fa-chevron-right' : 'fa-solid fa-chevron-left';
    });
  }

  const dashProfileTrigger = document.getElementById('dashProfileTrigger');
  const profileDropdown = document.getElementById('profileDropdown');
  if (dashProfileTrigger && profileDropdown) {
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

  const themeToggleBtn = document.getElementById('themeToggleBtn');
  if (themeToggleBtn) {
    themeToggleBtn.addEventListener('click', () => {
      document.body.classList.toggle('dark-theme');
      themeToggleBtn.classList.toggle('active');
      const icon = themeToggleBtn.querySelector('i');
      icon.className = document.body.classList.contains('dark-theme') ? 'fa-solid fa-sun' : 'fa-solid fa-moon';
    });
  }

  // Logout Logic
  const logoutLinks = [
    document.getElementById('sidebarLogoutLink'),
    document.getElementById('dropdownLogoutLink')
  ];

  let logoutModal = document.getElementById('logoutModalOverlay');
  if (!logoutModal) {
    logoutModal = document.createElement('div');
    logoutModal.className = 'modal-overlay';
    logoutModal.id = 'logoutModalOverlay';
    logoutModal.innerHTML = `
      <div class="modal-box" style="max-width:380px; text-align:center;">
        <div class="modal-icon icon-red"><i class="fa-solid fa-right-from-bracket"></i></div>
        <h3 class="modal-title">Logout Confirmation</h3>
        <p class="modal-sub">Are you sure you want to logout from SIMS Student Dashboard?</p>
        <div style="display:flex; gap:12px;">
          <button type="button" class="btn btn-ghost" id="logoutNoBtn" style="flex:1; justify-content:center;">No, Stay</button>
          <button type="button" class="btn btn-primary" id="logoutYesBtn" style="flex:1; justify-content:center;">Yes, Logout</button>
        </div>
      </div>
    `;
    document.body.appendChild(logoutModal);
  }

  function closeLogoutModal() {
    logoutModal.classList.remove('open');
    document.body.classList.remove('modal-open');
  }

  function triggerLogout(e) {
    if (e) e.preventDefault();
    logoutModal.classList.add('open');
    document.body.classList.add('modal-open');
    const profileDropdown = document.getElementById('profileDropdown');
    if (profileDropdown) profileDropdown.classList.remove('open');
  }

  logoutLinks.forEach(link => {
      if (link) link.addEventListener('click', triggerLogout);
  });

  const logoutNoBtn = document.getElementById('logoutNoBtn');
  const logoutYesBtn = document.getElementById('logoutYesBtn');

  if (logoutNoBtn) logoutNoBtn.addEventListener('click', closeLogoutModal);
  if (logoutYesBtn) {
    logoutYesBtn.addEventListener('click', () => {
      localStorage.removeItem('simsSession');
      window.location.href = 'index.aspx';
    });
  }

  logoutModal.addEventListener('click', (e) => {
    if (e.target === logoutModal) closeLogoutModal();
  });
});

/* ============================================================
   SIMS - Admin Dashboard JavaScript (Master)
   Handles:
     - Auth Guard (admin role only)
     - Centralized Sidebar Injection (Master Page pattern)
     - Dynamic Active State + Breadcrumbs
     - Profile Dropdown + Sidebar Toggle
     - Logout Confirmation Modal
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
  if (!session || session.role !== 'admin') {
    window.location.href = 'login.html?role=admin';
  }
})();

document.addEventListener('DOMContentLoaded', () => {

  /* =========================================================
     Session
  ========================================================= */
  let session = {};
  try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}

  if (!session.role || session.role !== 'admin') {
    window.location.href = 'login.html?role=admin';
    return;
  }

  const ADMIN = {
    name:        session.name  || 'System Administrator',
    email:       session.email || 'admin@sims.com',
    designation: 'Platform Administrator',
    department:  'IT & Systems'
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
      <a href="admin-dashboard.html" class="sidebar-brand">
        <span class="brand-icon"><i class="fa-solid fa-shield-halved"></i></span>
        <span class="brand-text">
          <span class="brand-name">SIMS</span>
          <span class="brand-sub">Admin Panel</span>
        </span>
      </a>
      <nav class="sidebar-nav">
        <ul>
          <li><a href="admin-dashboard.html" class="sidebar-link" id="sl-dashboard">
            <i class="fa-solid fa-house"></i> Dashboard
          </a></li>
        </ul>

        <div class="sidebar-divider"></div>
        <p class="co-sidebar-label">User Management</p>
        <ul>
          <li><a href="admin-students.html" class="sidebar-link" id="sl-students">
            <i class="fa-solid fa-user-graduate"></i> Student Management
          </a></li>
          <li><a href="admin-companies.html" class="sidebar-link" id="sl-companies">
            <i class="fa-solid fa-building"></i> Company Management
          </a></li>
        </ul>

        <div class="sidebar-divider"></div>
        <p class="co-sidebar-label">Operations</p>
        <ul>
          <li><a href="admin-internships.html" class="sidebar-link" id="sl-internships">
            <i class="fa-solid fa-briefcase"></i> Internship Management
          </a></li>
          <li><a href="admin-interviews.html" class="sidebar-link" id="sl-interviews">
            <i class="fa-solid fa-calendar-check"></i> Interview & Placement
          </a></li>
        </ul>

        <div class="sidebar-divider"></div>
        <ul>
          <li><a href="admin-notifications.html" class="sidebar-link" id="sl-communication">
            <i class="fa-solid fa-bullhorn"></i> Communication & Reports
          </a></li>
        </ul>

        <div class="sidebar-divider"></div>
        <ul>
          <li><a href="admin-settings.html" class="sidebar-link" id="sl-settings">
            <i class="fa-solid fa-gear"></i> System Settings
          </a></li>
        </ul>
      </nav>

      <div class="sidebar-logout">
        <div class="sidebar-user-mini">
          <span class="dash-avatar-sm" style="background:linear-gradient(135deg,#2563eb,#7c3aed);width:34px;height:34px;font-size:12px;" id="sidebarAvatarMini"></span>
          <div style="flex:1;min-width:0;">
            <div style="font-size:13px;font-weight:600;color:var(--text-dark);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;" id="sidebarNameMini"></div>
            <div style="font-size:11px;color:var(--text-muted);">Admin</div>
          </div>
        </div>
        <a href="#" class="sidebar-link" id="logoutLink" style="margin-top:8px;">
          <i class="fa-solid fa-right-from-bracket"></i> Logout
        </a>
      </div>
    `;

    /* Fill mini user info */
    const sidebarAvatarMini = document.getElementById('sidebarAvatarMini');
    const sidebarNameMini   = document.getElementById('sidebarNameMini');
    if (sidebarAvatarMini) sidebarAvatarMini.textContent = getInitials(ADMIN.name);
    if (sidebarNameMini)   sidebarNameMini.textContent   = ADMIN.name;

    /* Auto Active State */
    const currentPage = window.location.pathname.split('/').pop() || 'admin-dashboard.html';
    const pageToSidebar = {
      'admin-dashboard.html':             'sl-dashboard',
      'admin-profile.html':               'sl-dashboard',
      'admin-edit-profile.html':          'sl-dashboard',
      'admin-students.html':              'sl-students',
      'admin-student-details.html':       'sl-students',
      'admin-student-verification.html':  'sl-students',
      'admin-student-applications.html':  'sl-students',
      'admin-student-reports.html':       'sl-students',
      'admin-student-block.html':         'sl-students',
      'admin-companies.html':             'sl-companies',
      'admin-company-details.html':       'sl-companies',
      'admin-company-verification.html':  'sl-companies',
      'admin-internships.html':           'sl-internships',
      'admin-internship-details.html':    'sl-internships',
      'admin-internship-approval.html':   'sl-internships',
      'admin-categories-skills.html':     'sl-internships',
      'admin-applications.html':          'sl-applications',
      'admin-interviews.html':            'sl-interviews',
      'admin-interview-schedule.html':    'sl-interviews',
      'admin-interview-feedback.html':    'sl-interviews',
      'admin-offer-letters.html':         'sl-interviews',
      'admin-certificates.html':          'sl-interviews',
      'admin-qr-verification.html':       'sl-interviews',
      'admin-notifications.html':         'sl-communication',
      'admin-messages.html':              'sl-communication',
      'admin-contact.html':               'sl-communication',
      'admin-feedback.html':              'sl-communication',
      'admin-reports.html':               'sl-communication',
      'admin-analytics.html':             'sl-communication',
      'admin-email-templates.html':       'sl-communication',
      'admin-settings.html':              'sl-settings',
      'admin-roles.html':                 'sl-settings',
      'admin-change-password.html':       'sl-settings',
      'admin-theme.html':                 'sl-settings',
      'admin-backup.html':                'sl-settings',
      'admin-activity-logs.html':         'sl-settings',
    };
    const activeId = pageToSidebar[currentPage];
    if (activeId) {
      const activeLink = document.getElementById(activeId);
      if (activeLink) activeLink.classList.add('active');
    }
  }

  /* =========================================================
     Breadcrumb Injection
  ========================================================= */
  const breadcrumbEl = document.getElementById('breadcrumbNav');
  if (breadcrumbEl) {
    const currentPage = window.location.pathname.split('/').pop() || 'admin-dashboard.html';
    const D = `<a href="admin-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i>`;
    const breadcrumbs = {
      'admin-dashboard.html':             `<span class="current">Dashboard</span>`,
      'admin-profile.html':               `${D}<span class="current">Admin Profile</span>`,
      'admin-edit-profile.html':          `${D}<a href="admin-profile.html">Admin Profile</a><i class="fa-solid fa-chevron-right"></i><span class="current">Edit Profile</span>`,
      'admin-analytics.html':             `${D}<span class="current">Reports & Analytics</span>`,
      'admin-activity-logs.html':         `${D}<span class="current">Activity Logs</span>`,
      'admin-students.html':              `${D}<a href="admin-students.html">Student Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Student List</span>`,
      'admin-student-details.html':       `${D}<a href="admin-students.html">Student Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Student Details</span>`,
      'admin-student-verification.html':  `${D}<a href="admin-students.html">Student Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Student Verification</span>`,
      'admin-student-applications.html':  `${D}<a href="admin-students.html">Student Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Student Applications</span>`,
      'admin-student-reports.html':       `${D}<a href="admin-students.html">Student Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Student Reports</span>`,
      'admin-student-block.html':         `${D}<a href="admin-students.html">Student Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Block / Unblock Students</span>`,
      'admin-companies.html':             `${D}<a href="admin-companies.html">Company Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Company List</span>`,
      'admin-company-details.html':       `${D}<a href="admin-companies.html">Company Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Company Details</span>`,
      'admin-company-verification.html':  `${D}<a href="admin-companies.html">Company Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Company Verification</span>`,
      'admin-internships.html':           `${D}<a href="admin-internships.html">Internship Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Internship List</span>`,
      'admin-internship-details.html':    `${D}<a href="admin-internships.html">Internship Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Internship Details</span>`,
      'admin-internship-approval.html':   `${D}<a href="admin-internships.html">Internship Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Internship Approval</span>`,
      'admin-categories-skills.html':     `${D}<a href="admin-internships.html">Internship Management</a><i class="fa-solid fa-chevron-right"></i><span class="current">Categories & Skills</span>`,
      'admin-applications.html':          `${D}<span class="current">Applications</span>`,
      'admin-interviews.html':            `${D}<a href="admin-interviews.html">Interview & Placement</a><i class="fa-solid fa-chevron-right"></i><span class="current">Interview Management</span>`,
      'admin-interview-schedule.html':    `${D}<a href="admin-interviews.html">Interview & Placement</a><i class="fa-solid fa-chevron-right"></i><span class="current">Interview Schedule</span>`,
      'admin-interview-feedback.html':    `${D}<a href="admin-interviews.html">Interview & Placement</a><i class="fa-solid fa-chevron-right"></i><span class="current">Interview Feedback</span>`,
      'admin-offer-letters.html':         `${D}<a href="admin-interviews.html">Interview & Placement</a><i class="fa-solid fa-chevron-right"></i><span class="current">Offer Letter Management</span>`,
      'admin-certificates.html':          `${D}<a href="admin-interviews.html">Interview & Placement</a><i class="fa-solid fa-chevron-right"></i><span class="current">Certificate Management</span>`,
      'admin-qr-verification.html':       `${D}<a href="admin-interviews.html">Interview & Placement</a><i class="fa-solid fa-chevron-right"></i><span class="current">QR Code Verification</span>`,
      'admin-notifications.html':         `${D}<a href="admin-notifications.html">Communication & Reports</a><i class="fa-solid fa-chevron-right"></i><span class="current">Notifications</span>`,
      'admin-messages.html':              `${D}<a href="admin-notifications.html">Communication & Reports</a><i class="fa-solid fa-chevron-right"></i><span class="current">Messages / Chat</span>`,
      'admin-contact.html':               `${D}<a href="admin-notifications.html">Communication & Reports</a><i class="fa-solid fa-chevron-right"></i><span class="current">Contact Us</span>`,
      'admin-feedback.html':              `${D}<a href="admin-notifications.html">Communication & Reports</a><i class="fa-solid fa-chevron-right"></i><span class="current">Feedback</span>`,
      'admin-reports.html':               `${D}<a href="admin-notifications.html">Communication & Reports</a><i class="fa-solid fa-chevron-right"></i><span class="current">Reports</span>`,
      'admin-analytics.html':             `${D}<a href="admin-notifications.html">Communication & Reports</a><i class="fa-solid fa-chevron-right"></i><span class="current">Analytics Dashboard</span>`,
      'admin-email-templates.html':       `${D}<a href="admin-notifications.html">Communication & Reports</a><i class="fa-solid fa-chevron-right"></i><span class="current">Email Templates</span>`,
      'admin-settings.html':              `${D}<a href="admin-settings.html">System Settings</a><i class="fa-solid fa-chevron-right"></i><span class="current">General Settings</span>`,
      'admin-roles.html':                 `${D}<a href="admin-settings.html">System Settings</a><i class="fa-solid fa-chevron-right"></i><span class="current">Role & Permission Management</span>`,
      'admin-change-password.html':       `${D}<a href="admin-settings.html">System Settings</a><i class="fa-solid fa-chevron-right"></i><span class="current">Change Password</span>`,
      'admin-theme.html':                 `${D}<a href="admin-settings.html">System Settings</a><i class="fa-solid fa-chevron-right"></i><span class="current">Theme & Appearance</span>`,
      'admin-backup.html':                `${D}<a href="admin-settings.html">System Settings</a><i class="fa-solid fa-chevron-right"></i><span class="current">Backup & Restore</span>`,
      'admin-activity-logs.html':         `${D}<a href="admin-settings.html">System Settings</a><i class="fa-solid fa-chevron-right"></i><span class="current">Audit Logs</span>`,
    };
    breadcrumbEl.innerHTML = breadcrumbs[currentPage] || `<a href="admin-dashboard.html">Dashboard</a>`;
  }

  /* =========================================================
     Topbar: Avatar & Name
  ========================================================= */
  const avatarEl = document.getElementById('dashAvatarSm');
  const nameEl   = document.getElementById('dashNameTop');
  if (avatarEl) avatarEl.textContent = getInitials(ADMIN.name);
  if (nameEl)   nameEl.innerHTML     = `${ADMIN.name}<span>Administrator</span>`;

  /* =========================================================
     Profile Dropdown
  ========================================================= */
  const profileTrigger  = document.getElementById('dashProfileTrigger');
  const profileDropdown = document.getElementById('profileDropdown');
  if (profileTrigger && profileDropdown) {
    profileTrigger.addEventListener('click', (e) => {
      e.stopPropagation();
      profileDropdown.classList.toggle('open');
    });
    document.addEventListener('click', () => profileDropdown.classList.remove('open'));
  }

  /* =========================================================
     Sidebar Toggle (mobile)
  ========================================================= */
  const sidebarToggleBtn = document.getElementById('sidebarToggleBtn');
  const sidebarBackdrop  = document.getElementById('sidebarBackdrop');

  function openSidebar()  {
    sidebarEl?.classList.add('open');
    sidebarBackdrop?.classList.add('show');
    document.body.style.overflow = 'hidden';
  }
  function closeSidebar() {
    sidebarEl?.classList.remove('open');
    sidebarBackdrop?.classList.remove('show');
    document.body.style.overflow = '';
  }

  if (sidebarToggleBtn) sidebarToggleBtn.addEventListener('click', openSidebar);
  if (sidebarBackdrop)  sidebarBackdrop.addEventListener('click', closeSidebar);

  /* =========================================================
     Logout Modal Injection
  ========================================================= */
  if (!document.getElementById('logoutModalOverlay')) {
    const m = document.createElement('div');
    m.id = 'logoutModalOverlay';
    m.className = 'modal-overlay';
    m.innerHTML = `
      <div class="modal-box" style="max-width:360px;text-align:center;">
        <div class="modal-icon" style="background:#fef2f2;color:#ef4444;"><i class="fa-solid fa-right-from-bracket"></i></div>
        <h3 class="modal-title">Logout Confirmation</h3>
        <p class="modal-sub">Are you sure you want to logout?</p>
        <div style="display:flex;gap:10px;margin-top:20px;">
          <button class="btn btn-ghost" id="logoutNoBtn" style="flex:1;justify-content:center;">Cancel</button>
          <button class="btn btn-primary" id="logoutYesBtn" style="flex:1;justify-content:center;background:#ef4444;border-color:#ef4444;">Yes, Logout</button>
        </div>
      </div>
    `;
    document.body.appendChild(m);
  }

  const logoutOverlay      = document.getElementById('logoutModalOverlay');
  const logoutNoBtn        = document.getElementById('logoutNoBtn');
  const logoutYesBtn       = document.getElementById('logoutYesBtn');
  const dropdownLogoutLink = document.getElementById('dropdownLogoutLink');

  function openLogout()  { logoutOverlay?.classList.add('open');    }
  function closeLogout() { logoutOverlay?.classList.remove('open'); }

  const logoutLink = document.getElementById('logoutLink');
  if (logoutLink)          logoutLink.addEventListener('click', (e) => { e.preventDefault(); openLogout(); });
  if (dropdownLogoutLink)  dropdownLogoutLink.addEventListener('click', (e) => { e.preventDefault(); openLogout(); });
  if (logoutNoBtn)         logoutNoBtn.addEventListener('click', closeLogout);
  if (logoutOverlay)       logoutOverlay.addEventListener('click', (e) => { if (e.target === logoutOverlay) closeLogout(); });
  document.addEventListener('keydown', e => {
    if (e.key === 'Escape' && logoutOverlay?.classList.contains('open')) closeLogout();
  });
  if (logoutYesBtn) {
    logoutYesBtn.addEventListener('click', () => {
      localStorage.removeItem('simsSession');
      window.location.href = 'index.html';
    });
  }

  /* =========================================================
     Toast Notification
  ========================================================= */
  function showToast(message, type = 'success') {
    const toast    = document.getElementById('dashToast');
    const toastMsg = document.getElementById('dashToastMsg');
    if (!toast || !toastMsg) return;
    toast.className = 'login-toast ' + type;
    toastMsg.textContent = message;
    toast.querySelector('i').className = type === 'success'
      ? 'fa-solid fa-circle-check'
      : 'fa-solid fa-circle-exclamation';
    toast.classList.add('show');
    setTimeout(() => toast.classList.remove('show'), 3500);
  }

  /* Dynamic Dashboard Stats */
  function updateAdminStats() {
    if (!window.GlobalStore) return;
    const allApps = window.GlobalStore.getApplications();
    const allInternships = window.GlobalStore.getInternships();
    const allCompanies = window.COMPANIES_DATA || [];
    const allInterviews = window.GlobalStore.getInterviews();

    const totalStudentsEl = document.getElementById('totalStudents');
    const activeInternshipsEl = document.getElementById('activeInternships');
    const totalCompaniesEl = document.getElementById('totalCompanies');
    const totalApplicationsEl = document.getElementById('totalApplications');

    const uniqueStudents = [...new Set(allApps.map(a => a.studentEmail))].length;
    if (totalStudentsEl) totalStudentsEl.textContent = uniqueStudents;
    if (activeInternshipsEl) activeInternshipsEl.textContent = allInternships.length;
    if (totalCompaniesEl) totalCompaniesEl.textContent = allCompanies.length;
    if (totalApplicationsEl) totalApplicationsEl.textContent = allApps.length;

    // Recent Applications table
    const recentAppsBody = document.getElementById('recentApplicationsBody') || document.getElementById('applicationsTableBody');
    if (recentAppsBody) {
      const recent = allApps.slice(-5).reverse();
      recentAppsBody.innerHTML = recent.length === 0
        ? '<tr><td colspan="5" style="text-align:center;">No applications yet.</td></tr>'
        : recent.map(a => `<tr>
            <td><strong>${a.studentName}</strong></td>
            <td>${a.internshipTitle}</td>
            <td>${a.company}</td>
            <td>${new Date(a.appliedOn).toLocaleDateString()}</td>
            <td><span style="color:#2563eb;font-weight:600;">${a.status}</span></td>
          </tr>`).join('');
    }
    // Dynamic Analytics Rendering
    const currentPage = window.location.pathname.split('/').pop() || 'admin-dashboard.html';
    if (currentPage === 'admin-analytics.html') {
       const allStudents = window.GlobalStore.getStudents();
       const kpiCards = document.querySelectorAll('.adm-kpi-num');
       if (kpiCards.length >= 4) {
         kpiCards[0].textContent = allStudents.length.toLocaleString();
         kpiCards[1].textContent = allCompanies.length.toLocaleString();
         kpiCards[2].textContent = allInternships.length.toLocaleString();
         
         const hiredCount = allApps.filter(a => a.status === 'Selected').length;
         const placementRate = allStudents.length > 0 ? Math.round((hiredCount / allStudents.length) * 100) : 0;
         kpiCards[3].textContent = placementRate + '%';
       }

       const chartBox = document.querySelector('.chart-box');
       if (chartBox) {
         const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
         const counts = [0, 0, 0, 0, 0, 0];
         allApps.forEach(app => {
           const date = new Date(app.appliedOn);
           const monthIndex = date.getMonth();
           if (monthIndex >= 0 && monthIndex < 6) {
             counts[monthIndex]++;
           }
         });
         const maxCount = Math.max(...counts, 1);
         chartBox.innerHTML = months.map((m, i) => {
           const pct = Math.round((counts[i] / maxCount) * 100);
           return `<div class="chart-bar" style="height:${pct}%;"><div class="chart-bar-val">${counts[i]}</div><div class="chart-bar-lbl">${m}</div></div>`;
         }).join('');
       }

       const activeCount = allInternships.filter(i => i.status === 'Active' || !i.status).length;
       const pendingCount = allInternships.filter(i => i.status === 'Pending').length;
       const closedCount = allInternships.filter(i => i.status === 'Closed').length;
       const totalInt = allInternships.length || 1;

       const activePct = Math.round((activeCount / totalInt) * 100);
       const pendingPct = Math.round((pendingCount / totalInt) * 100);
       const closedPct = Math.round((closedCount / totalInt) * 100);

       const donutWrap = document.querySelector('.donut-wrap');
       if (donutWrap) {
         donutWrap.style.background = `conic-gradient(#16a34a 0% ${activePct}%, #ca8a04 ${activePct}% ${activePct + pendingPct}%, #ef4444 ${activePct + pendingPct}% 100%)`;
         const donutHole = donutWrap.querySelector('.donut-hole');
         if (donutHole) {
           donutHole.innerHTML = `
             <span style="font-size:24px;font-weight:800;color:var(--text-dark);">${allInternships.length}</span>
             <span style="font-size:11px;color:var(--text-muted);font-weight:600;">Total</span>
           `;
         }
       }
       const labelsWrap = donutWrap ? donutWrap.nextElementSibling : null;
       if (labelsWrap && labelsWrap.style.display !== 'none') {
         labelsWrap.innerHTML = `
           <div style="display:flex;align-items:center;gap:6px;font-size:12px;font-weight:600;"><div style="width:12px;height:12px;border-radius:3px;background:#16a34a;"></div>Active (${activePct}%)</div>
           <div style="display:flex;align-items:center;gap:6px;font-size:12px;font-weight:600;"><div style="width:12px;height:12px;border-radius:3px;background:#ca8a04;"></div>Pending (${pendingPct}%)</div>
           <div style="display:flex;align-items:center;gap:6px;font-size:12px;font-weight:600;"><div style="width:12px;height:12px;border-radius:3px;background:#ef4444;"></div>Closed (${closedPct}%)</div>
         `;
       }
    }
  }

  updateAdminStats();
  window.addEventListener('storage', updateAdminStats);

  window.simsShowToast = showToast;

}); // end DOMContentLoaded

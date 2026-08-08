document.addEventListener('DOMContentLoaded', () => {

  const params = new URLSearchParams(window.location.search);
  const requestedAppId = params.get('id');
  const requestedInternshipId = params.get('internshipId');

  const session = (() => {
    try { return JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) { return {}; }
  })();

  const allApplications = window.GlobalStore ? window.GlobalStore.getApplications() : [];
  const studentApplications = session.role === 'student' && session.email
    ? allApplications.filter(app => app.studentEmail === session.email)
    : allApplications;

  let app = null;
  if (requestedAppId) {
    app = studentApplications.find(item => String(item.id) === String(requestedAppId));
  }
  if (!app && requestedInternshipId) {
    app = studentApplications.find(item => String(item.internshipId) === String(requestedInternshipId));
  }
  if (!app && studentApplications.length) {
    app = [...studentApplications].sort((a, b) => new Date(b.appliedOn || 0) - new Date(a.appliedOn || 0))[0];
  }

  const titleEl = document.getElementById('stTitle');
  const companyEl = document.getElementById('stCompany');
  const locationEl = document.getElementById('stLocation');
  const dateEl = document.getElementById('stAppliedDate');
  const appIdEl = document.getElementById('stAppId');
  const badgeWrap = document.getElementById('stBadgeWrap');
  const timelineWrap = document.getElementById('timelineWrap');
  const messageEl = document.getElementById('stMessage');
  const withdrawBtn = document.getElementById('withdrawBtn');
  const withdrawModal = document.getElementById('withdrawModalOverlay');
  const withdrawCancelBtn = document.getElementById('withdrawCancelBtn');
  const withdrawConfirmBtn = document.getElementById('withdrawConfirmBtn');
  const withdrawSuccessModal = document.getElementById('withdrawSuccessModalOverlay');
  const withdrawSuccessOkBtn = document.getElementById('withdrawSuccessOkBtn');

  function openWithdrawModal() {
    if (withdrawModal) withdrawModal.classList.add('open');
  }

  function closeWithdrawModal() {
    if (withdrawModal) withdrawModal.classList.remove('open');
  }

  function openWithdrawSuccessModal() {
    if (withdrawSuccessModal) withdrawSuccessModal.classList.add('open');
  }

  function closeWithdrawSuccessModal() {
    if (withdrawSuccessModal) withdrawSuccessModal.classList.remove('open');
  }

  function emptyState() {
    if (titleEl) titleEl.textContent = 'No application found';
    if (companyEl) companyEl.textContent = 'Go back to My Applications';
    if (locationEl) locationEl.textContent = '-';
    if (dateEl) dateEl.textContent = '-';
    if (appIdEl) appIdEl.textContent = '-';
    if (badgeWrap) badgeWrap.innerHTML = '<div class="im-badge primary" style="font-size:14px; padding:8px 16px;">No Data</div>';
    if (timelineWrap) {
      timelineWrap.innerHTML = `
        <div class="im-empty-state" style="display:block; margin: 12px 0 0; padding: 10px 0 0; background: transparent; border: 0;">
          <i class="fa-solid fa-paper-plane im-empty-icon" style="color:#cbd5e1;"></i>
          <h3 class="im-empty-title">Application not available</h3>
          <p class="im-empty-text">Open an application from the My Applications page to view its status timeline.</p>
          <a href="my-applications.html" class="btn btn-primary">Go to My Applications</a>
        </div>
      `;
    }
    if (messageEl) messageEl.textContent = 'No application record was found for this page.';
    if (withdrawBtn) withdrawBtn.style.display = 'none';
  }

  if (!app) {
    emptyState();
    return;
  }

  const internship = (window.INTERNSHIPS_DATA || []).find(item => String(item.id) === String(app.internshipId));
  const company = (window.COMPANIES_DATA || []).find(item => item.name === (app.company || internship?.company)) || null;

  const title = app.internshipTitle || internship?.title || 'Internship';
  const companyName = app.company || internship?.company || company?.name || 'Company';
  const location = internship?.location || '-';
  const appliedDate = app.appliedOn ? new Date(app.appliedOn).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }) : '-';
  const statusKey = String(app.status || 'Pending').toLowerCase();
  const statusLabel = app.status || 'Pending';

  function statusTone(key) {
    if (key === 'shortlisted' || key === 'selected') return 'success';
    if (key === 'rejected') return 'warning';
    return 'primary';
  }

  function statusIcon(key) {
    if (key === 'shortlisted') return 'fa-check-double';
    if (key === 'selected') return 'fa-circle-check';
    if (key === 'rejected') return 'fa-circle-xmark';
    return 'fa-spinner';
  }

  if (titleEl) titleEl.textContent = title;
  if (companyEl) companyEl.textContent = companyName;
  if (locationEl) locationEl.textContent = location.split(',')[0] || location;
  if (dateEl) dateEl.textContent = appliedDate;
  if (appIdEl) appIdEl.textContent = app.id;

  if (badgeWrap) {
    badgeWrap.innerHTML = `<div class="im-badge ${statusTone(statusKey)}" style="font-size:14px; padding:8px 16px;"><i class="fa-solid ${statusIcon(statusKey)}"></i> ${statusLabel}</div>`;
  }

  const timeline = [];
  timeline.push(`
    <div class="im-tl-step done">
      <div class="im-tl-icon"><i class="fa-solid fa-paper-plane"></i></div>
      <div class="im-tl-content">
        <h4>Application Submitted</h4>
        <p>Your application was successfully sent to ${companyName}.</p>
        <span class="im-tl-date">${appliedDate}</span>
      </div>
    </div>
  `);

  const viewed = ['shortlisted', 'selected', 'rejected'].includes(statusKey);
  timeline.push(`
    <div class="im-tl-step ${viewed ? 'done' : 'active'}">
      <div class="im-tl-icon"><i class="fa-solid fa-eye"></i></div>
      <div class="im-tl-content">
        <h4>Application Viewed</h4>
        <p>${viewed ? 'The employer has viewed your application.' : 'The employer has not viewed your application yet.'}</p>
        <span class="im-tl-date">${viewed ? 'Reviewed' : 'Pending'}</span>
      </div>
    </div>
  `);

  if (statusKey === 'shortlisted') {
    timeline.push(`
      <div class="im-tl-step done">
        <div class="im-tl-icon"><i class="fa-solid fa-check-double"></i></div>
        <div class="im-tl-content">
          <h4>Shortlisted for Interview</h4>
          <p>Congratulations! Your application is shortlisted. The employer may contact you soon.</p>
          <span class="im-tl-date">In progress</span>
        </div>
      </div>
    `);
    if (messageEl) messageEl.textContent = 'Your application is shortlisted. Wait for interview details.';
  } else if (statusKey === 'selected') {
    timeline.push(`
      <div class="im-tl-step done">
        <div class="im-tl-icon"><i class="fa-solid fa-circle-check"></i></div>
        <div class="im-tl-content">
          <h4>Selected</h4>
          <p>You have been selected for this internship.</p>
          <span class="im-tl-date">Finalized</span>
        </div>
      </div>
    `);
    if (messageEl) messageEl.textContent = 'Congratulations. Your application has been selected.';
  } else if (statusKey === 'rejected') {
    timeline.push(`
      <div class="im-tl-step rejected">
        <div class="im-tl-icon"><i class="fa-solid fa-circle-xmark"></i></div>
        <div class="im-tl-content">
          <h4>Not Selected</h4>
          <p>Unfortunately, the employer has moved ahead with other candidates.</p>
          <span class="im-tl-date">Finalized</span>
        </div>
      </div>
    `);
    if (messageEl) messageEl.textContent = 'This application is closed.';
  } else {
    timeline.push(`
      <div class="im-tl-step active">
        <div class="im-tl-icon"><i class="fa-solid fa-spinner"></i></div>
        <div class="im-tl-content">
          <h4>Under Review</h4>
          <p>Your application is still being reviewed by the employer.</p>
          <span class="im-tl-date">Pending</span>
        </div>
      </div>
    `);
    if (messageEl) messageEl.textContent = 'Your application is currently being reviewed. We will notify you of any updates.';
  }

  if (timelineWrap) timelineWrap.innerHTML = timeline.join('');

  const canWithdraw = ['pending', 'shortlisted'].includes(statusKey);
  if (withdrawBtn) {
    if (!canWithdraw) {
      withdrawBtn.style.display = 'none';
    } else {
      withdrawBtn.addEventListener('click', openWithdrawModal);
    }
  }

  if (withdrawCancelBtn) {
    withdrawCancelBtn.addEventListener('click', closeWithdrawModal);
  }

  if (withdrawConfirmBtn) {
    withdrawConfirmBtn.addEventListener('click', () => {
      closeWithdrawModal();
      if (window.GlobalStore && window.GlobalStore.deleteApplication) {
        window.GlobalStore.deleteApplication(app.id);
      } else {
        const apps = allApplications.filter(item => String(item.id) !== String(app.id));
        localStorage.setItem('SIMS_APPLICATIONS_DATA', JSON.stringify(apps));
      }
      openWithdrawSuccessModal();
    });
  }

  if (withdrawSuccessOkBtn) {
    withdrawSuccessOkBtn.addEventListener('click', () => {
      closeWithdrawSuccessModal();
      window.location.href = 'my-applications.html';
    });
  }

  if (withdrawModal) {
    withdrawModal.addEventListener('click', (event) => {
      if (event.target === withdrawModal) closeWithdrawModal();
    });
  }

  if (withdrawSuccessModal) {
    withdrawSuccessModal.addEventListener('click', (event) => {
      if (event.target === withdrawSuccessModal) closeWithdrawSuccessModal();
    });
  }

});

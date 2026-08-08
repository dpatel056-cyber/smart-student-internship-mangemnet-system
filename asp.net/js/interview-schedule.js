document.addEventListener('DOMContentLoaded', () => {

  const ivGrid = document.getElementById('ivGrid');
  const noIvResults = document.getElementById('noIvResults');
  const ivCount = document.getElementById('ivCount');

  let session = {};
  try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}

  function getBadgeHtml(status) {
    switch(status) {
      case 'completed': return `<div class="iv-badge completed"><i class="fa-solid fa-check-circle"></i> Completed</div>`;
      case 'cancelled': return `<div class="iv-badge cancelled"><i class="fa-solid fa-times-circle"></i> Cancelled</div>`;
      case 'pending': return `<div class="iv-badge pending"><i class="fa-solid fa-clock"></i> Pending</div>`;
      default: return `<div class="iv-badge scheduled"><i class="fa-solid fa-calendar-check"></i> Scheduled</div>`;
    }
  }

  function cardHtml(item) {
    return `
      <div class="iv-card" data-id="${item.id}">
        <div class="iv-card-head">
          <div class="im-company-logo" style="background:#eff6ff;color:#2563eb;font-size:18px;"><i class="fa-solid fa-building"></i></div>
          ${getBadgeHtml(item.status || 'scheduled')}
        </div>
        <h3 class="iv-card-title">${item.internshipTitle || item.role || 'Interview'}</h3>
        <div class="iv-card-company">${item.company}</div>
        <div class="iv-details-grid">
          <div class="iv-detail-item" title="Date"><i class="fa-regular fa-calendar"></i> ${new Date(item.date).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' })}</div>
          <div class="iv-detail-item" title="Time"><i class="fa-regular fa-clock"></i> ${item.time || 'TBD'}</div>
          <div class="iv-detail-item" title="Mode"><i class="fa-solid ${(item.mode||'Online') === 'Online' ? 'fa-video' : 'fa-building'}"></i> ${item.mode || 'Online'}</div>
          <div class="iv-detail-item" title="Interviewer"><i class="fa-regular fa-user"></i> ${item.interviewer || 'HR Team'}</div>
        </div>
        <div class="iv-card-footer">
          ${item.link && item.status !== 'completed' ? `<a href="${item.link}" target="_blank" class="btn btn-primary">Join Meeting</a>` : ''}
          ${item.status === 'completed' ? `<button class="btn btn-ghost" disabled>Completed</button>` : `<button class="btn btn-ghost reschedule-btn" data-company="${item.company}">Reschedule</button>`}
        </div>
      </div>`;
  }

  function render() {
    const allInterviews = window.GlobalStore ? window.GlobalStore.getInterviews() : [];
    const myInterviews = session.email ? allInterviews.filter(i => i.studentEmail === session.email) : allInterviews;

    if (myInterviews.length === 0) {
      if (ivGrid) ivGrid.style.display = 'none';
      if (noIvResults) noIvResults.style.display = 'block';
      if (ivCount) ivCount.textContent = '0';
    } else {
      if (ivGrid) { ivGrid.style.display = 'grid'; ivGrid.innerHTML = myInterviews.map(cardHtml).join(''); }
      if (noIvResults) noIvResults.style.display = 'none';
      if (ivCount) ivCount.textContent = myInterviews.length;

      ivGrid.querySelectorAll('.reschedule-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
          e.preventDefault();
          openRescheduleModal(btn.dataset.company);
        });
      });
    }
  }

  const modal = document.getElementById('rescheduleModal');
  const closeBtn = document.getElementById('closeRescheduleBtn');
  const form = document.getElementById('rescheduleForm');
  const resCompany = document.getElementById('resCompany');

  function openRescheduleModal(companyName) {
    if (resCompany) resCompany.textContent = companyName;
    if (form) form.reset();
    if (modal) modal.classList.add('show');
  }

  if (closeBtn) closeBtn.addEventListener('click', () => { if (modal) modal.classList.remove('show'); });
  if (form) {
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      if (modal) modal.classList.remove('show');
      showToast('Reschedule request sent to ' + (resCompany ? resCompany.textContent : ''));
    });
  }

  const dashToast = document.getElementById('dashToast');
  const dashToastMsg = document.getElementById('dashToastMsg');
  let toastTimer = null;
  function showToast(message) {
    if (!dashToast) return;
    dashToastMsg.textContent = message;
    dashToast.classList.add('show', 'success');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => dashToast.classList.remove('show'), 2800);
  }

  render();

  window.addEventListener('storage', (e) => {
    if (e.key === 'SIMS_INTERVIEWS_DATA') render();
  });
});

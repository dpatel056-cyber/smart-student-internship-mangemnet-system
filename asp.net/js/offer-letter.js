document.addEventListener('DOMContentLoaded', () => {

  const params = new URLSearchParams(window.location.search);
  const requestedId = params.get('id');
  let session = {};
  try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) {}
  const offers = window.GlobalStore ? window.GlobalStore.getOffers(session.email) : [];
  let offer = offers.find(o => String(o.id) === String(requestedId)) || offers[0];

  if (!offer) {
    document.querySelector('.ol-container').innerHTML = '<div class="empty-state"><i class="fa-regular fa-envelope"></i><h3>No offer letter available</h3><p>Your offer letters will appear here once a company issues one.</p><a class="btn btn-primary" href="browse-internships.html">Browse internships</a></div>';
    return;
  }

  /* =========================================================
     Populate DOM
  ========================================================= */
  
  function logoHtml() {
    const initials = offer.company.split(/\s+/).map(word => word[0]).join('').slice(0, 2).toUpperCase();
    return `<div class="iv-company-logo" style="background:#eff6ff;color:#2563eb;width:64px;height:64px;font-size:22px;">${initials}</div>`;
  }

  // Document
  document.getElementById('olIconWrapper').innerHTML = logoHtml();
  document.getElementById('olCompany').textContent = offer.company;
  document.getElementById('olCurrentDate').textContent = new Date().toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
  document.getElementById('olStudentName').textContent = offer.studentName || session.name || 'Student';
  document.getElementById('olContentText').textContent = offer.content;
  document.getElementById('olCompanySign').textContent = offer.company;

  // Sidebar
  document.getElementById('olPosition').textContent = offer.position;
  document.getElementById('olStipend').textContent = offer.stipend;
  document.getElementById('olDuration').textContent = offer.duration;
  document.getElementById('olJoining').textContent = new Date(offer.joiningDate).toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
  
  const dDate = new Date(offer.deadlineDate);
  document.getElementById('olDeadline').textContent = dDate.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });

  // Modal
  document.getElementById('successRole').textContent = offer.position;
  document.getElementById('successCompany').textContent = offer.company;

  /* =========================================================
     Actions
  ========================================================= */
  const btnAccept = document.getElementById('btnAccept');
  const btnReject = document.getElementById('btnReject');
  const btnDownload = document.getElementById('btnDownload');
  const btnPrint = document.getElementById('btnPrint');
  
  const actionWrap = document.getElementById('actionWrap');
  const statusWrap = document.getElementById('statusWrap');
  const acceptSuccessModal = document.getElementById('acceptSuccessModal');
  const btnContinue = document.getElementById('btnContinue');

  function markAsAccepted() {
    offer.status = 'accepted';
    window.GlobalStore?.updateOffer(offer.id, { status: 'accepted', respondedAt: new Date().toISOString() });
    window.GlobalStore?.addNotification({ userId: session.email, title: 'Offer accepted', message: `You accepted the offer from ${offer.company}.`, type: 'success', read: false, date: new Date().toISOString() });
    actionWrap.style.display = 'none';
    statusWrap.style.display = 'block';
  }

  if (btnAccept) {
    btnAccept.addEventListener('click', () => {
      acceptSuccessModal.classList.add('show');
    });
  }

  if (btnContinue) {
    btnContinue.addEventListener('click', () => {
      acceptSuccessModal.classList.remove('show');
      markAsAccepted();
      // Wait a moment then redirect
      setTimeout(() => {
        window.location.href = 'upcoming-deadlines.html';
      }, 1000);
    });
  }

  if (btnReject) {
    btnReject.addEventListener('click', () => {
      if(confirm('Are you sure you want to reject this offer? This cannot be undone.')) {
        window.GlobalStore?.updateOffer(offer.id, { status: 'rejected', respondedAt: new Date().toISOString() });
        window.GlobalStore?.addNotification({ userId: session.email, title: 'Offer rejected', message: `You rejected the offer from ${offer.company}.`, type: 'info', read: false, date: new Date().toISOString() });
        window.location.href = 'student-dashboard.html';
      }
    });
  }

  if (btnPrint) {
    btnPrint.addEventListener('click', () => {
      window.print();
    });
  }

  if (btnDownload) {
    btnDownload.addEventListener('click', () => {
      // In a real app, this would trigger a PDF generation or file download.
      // For this prototype, we'll just trigger print to save as PDF.
      window.print();
    });
  }

  // Export CSV button handler
  const btnExportCSV = document.getElementById('btnExportCSV');
  if (btnExportCSV) {
    btnExportCSV.addEventListener('click', () => {
      if (window.OffersAPI && typeof window.OffersAPI.exportCSV === 'function') {
        window.OffersAPI.exportCSV();
      } else {
        alert('Export functionality not available.');
      }
    });
  }

});

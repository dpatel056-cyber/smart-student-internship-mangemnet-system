// applications.js – renders the Applications grid dynamically for student, company and admin pages
// Expected HTML placeholder: <div id="applicationsContainer"></div>

(function() {
  document.addEventListener('DOMContentLoaded', () => {
    const container = document.getElementById('applicationsContainer');
    if (!container) return;
    const session = (() => {
      try { return JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) { return {}; }
    })();
    const role = session.role || '';
    const userId = session.email || '';
    const userName = session.name || '';

    // Helper to create a card element
    function createAppCard(app) {
      const card = document.createElement('div');
      card.className = 'app-card';
      card.innerHTML = `
        <h4 class="app-title">${app.internshipTitle}</h4>
        <p class="app-company">${app.company}</p>
        <p class="app-status">Status: <strong>${app.status || 'Pending'}</strong></p>
        <button class="app-action-btn" data-id="${app.id}">${actionLabel(app.status)}</button>
      `;
      // Attach button handler
      const btn = card.querySelector('.app-action-btn');
      btn.addEventListener('click', () => handleAction(app.id, btn));
      return card;
    }

    // Determine button label based on current status and role
    function actionLabel(status) {
      if (role === 'admin') return 'Update';
      if (role === 'company') {
        if (status === 'Shortlisted') return 'Schedule Interview';
        if (status === 'Interviewed') return 'Send Offer';
        return 'Review';
      }
      // student
      return status === 'Accepted' ? 'View Offer' : 'Withdraw';
    }

    function handleAction(appId, btn) {
      // Simple demo: cycle status for illustration
      const apps = GlobalStore.getApplications();
      const app = apps.find(a => a.id === appId);
      if (!app) return;
      // Cycle through a few statuses
      const nextStatus = {
        'Pending': 'Shortlisted',
        'Shortlisted': 'Interviewed',
        'Interviewed': 'Offered',
        'Offered': 'Accepted',
        'Accepted': 'Completed',
        'Completed': 'Completed'
      }[app.status] || 'Pending';
      GlobalStore.updateApplicationStatus(appId, nextStatus);
      // Trigger UI refresh via storage event (already listened by other modules)
      btn.textContent = actionLabel(nextStatus);
    }

    function render() {
      const apps = GlobalStore.getApplications();
      let filtered = [];
      if (role === 'student') {
        filtered = apps.filter(a => a.studentEmail === userId);
      } else if (role === 'company') {
        filtered = apps.filter(a => a.company === userName);
      } else if (role === 'admin') {
        filtered = apps; // admin sees all
      }
      container.innerHTML = '';
      filtered.forEach(app => {
        container.appendChild(createAppCard(app));
      });
    }

    render();
    // Re‑render on any relevant data change
    window.addEventListener('storage', e => {
      if (['SIMS_APPLICATIONS_DATA','SIMS_NOTIFICATIONS_DATA','SIMS_INTERVIEWS_DATA','SIMS_OFFERS_DATA'].includes(e.key)) {
        render();
      }
    });
  });
})();

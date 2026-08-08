document.addEventListener('DOMContentLoaded', () => {

  function seedStudentFallbackData() {
    let session = {};
    try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) {}

    const studentEmail = session.email || 'student@sims.com';
    const studentName = session.name || 'Aarav Patel';

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
  }

  seedStudentFallbackData();

  const appsGrid = document.getElementById('appsGrid');
  const noAppsResults = document.getElementById('noAppsResults');
  const appCount = document.getElementById('appCount');
  const statusFilter = document.getElementById('statusFilter');

  function getStatusColor(status) {
      if (status === 'Pending') return 'primary';
      if (status === 'Shortlisted' || status === 'Selected') return 'success';
      if (status === 'Rejected') return 'warning';
      return 'primary';
  }

  function openApplicationStatus(appId) {
      window.location.href = `application-status.html?id=${encodeURIComponent(appId)}`;
  }

  function render() {
      const filter = statusFilter ? statusFilter.value : 'all';
      let apps = window.GlobalStore ? window.GlobalStore.getApplications() : [];

      let session = {};
      try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}
      
      // Filter by the logged-in student
      if (session.role === 'student' && session.email) {
          apps = apps.filter(a => a.studentEmail === session.email);
      }

      if (appCount) appCount.textContent = apps.length;

      // Filter by dropdown status
      if (filter !== 'all') {
          if (filter === 'in_review') apps = apps.filter(a => a.status === 'Pending');
          else if (filter === 'shortlisted') apps = apps.filter(a => a.status === 'Shortlisted');
          else if (filter === 'rejected') apps = apps.filter(a => a.status === 'Rejected');
      }

      if (apps.length === 0) {
          appsGrid.style.display = 'none';
          noAppsResults.style.display = 'block';
      } else {
          appsGrid.style.display = 'grid';
          noAppsResults.style.display = 'none';

          appsGrid.innerHTML = apps.map(app => `
              <div class="im-card" data-id="${app.id}" data-status-url="application-status.html?id=${encodeURIComponent(app.id)}" role="button" tabindex="0" style="cursor:pointer;">
                  <div class="im-card-head">
                      <div class="im-badge ${getStatusColor(app.status)}">${app.status}</div>
                  </div>
                  <h3 class="im-card-title">${app.internshipTitle}</h3>
                  <div class="im-card-company" style="margin-bottom: 20px;">
                      ${app.company}
                  </div>
                  <div class="im-card-meta" style="grid-template-columns: 1fr;">
                      <div class="im-meta-item"><i class="fa-solid fa-calendar-check"></i> Applied on ${new Date(app.appliedOn).toLocaleDateString()}</div>
                  </div>
                  <div class="im-card-actions" style="margin-top: 18px; justify-content: flex-end;">
                      <a href="application-status.html?id=${encodeURIComponent(app.id)}" class="btn btn-ghost" style="padding: 8px 14px; font-size: 13px;">View Status</a>
                  </div>
              </div>
          `).join('');

          appsGrid.querySelectorAll('.im-card[data-status-url]').forEach(card => {
              card.addEventListener('click', (event) => {
                  if (event.target.closest('a, button')) return;
                  openApplicationStatus(card.dataset.id);
              });
              card.addEventListener('keydown', (event) => {
                  if (event.key === 'Enter' || event.key === ' ') {
                      event.preventDefault();
                      openApplicationStatus(card.dataset.id);
                  }
              });
          });
      }
  }

  if (statusFilter) {
      statusFilter.addEventListener('change', render);
  }

  render();

  window.addEventListener('storage', (e) => {
      if (!e.key || e.key === 'SIMS_APPLICATIONS_DATA') {
          render();
      }
  });

  window.addEventListener('sims:data-changed', (e) => {
      if (!e || !e.detail || e.detail.key === 'SIMS_APPLICATIONS_DATA' || e.detail.key === 'student-profile') {
          render();
      }
  });

});

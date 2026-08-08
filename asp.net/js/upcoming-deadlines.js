document.addEventListener('DOMContentLoaded', () => {

  let session = {};
  try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) {}

  function getDeadlines() {
    const interviews = window.GlobalStore ? window.GlobalStore.getInterviews().filter(item => item.studentEmail === session.email && item.status !== 'completed' && item.status !== 'cancelled') : [];
    const offers = window.GlobalStore ? window.GlobalStore.getOffers(session.email).filter(item => item.status === 'pending') : [];
    const internships = window.GlobalStore ? window.GlobalStore.getInternships() : [];
    const applicationDeadlines = internships.filter(item => item.deadline).map(item => ({
      id: `internship-${item.id}`, date: item.deadline, title: `${item.title} application deadline`,
      desc: `Last date to apply at ${item.company}.`, type: 'deadline', priority: 'medium'
    }));
    return [
      ...interviews.map(item => ({ id: item.id, date: item.date, title: `${item.company} interview`, desc: item.internshipTitle || item.role || 'Interview scheduled.', type: 'interview', priority: 'high' })),
      ...offers.map(item => ({ id: item.id, date: item.deadlineDate, title: `${item.company} offer response`, desc: `Respond to the offer for ${item.position}.`, type: 'offer', priority: 'high' })),
      ...applicationDeadlines
    ].filter(item => item.date).sort((a, b) => new Date(a.date) - new Date(b.date));
  }
  
  /* =========================================================
     Calendar Logic
  ========================================================= */
  const calGrid = document.getElementById('calGrid');
  const calMonthYear = document.getElementById('calMonthYear');
  
  let currentDate = new Date();

  function renderCalendar() {
    const deadlines = getDeadlines();
    const year = currentDate.getFullYear();
    const month = currentDate.getMonth();
    
    const monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    calMonthYear.textContent = `${monthNames[month]} ${year}`;
    
    // Clear previous cells (keep headers)
    const headers = [];
    for(let i=0; i<7; i++) headers.push(calGrid.children[i].outerHTML);
    calGrid.innerHTML = headers.join('');
    
    const firstDay = new Date(year, month, 1).getDay();
    const daysInMonth = new Date(year, month + 1, 0).getDate();
    
    // Empty cells before 1st
    for (let i = 0; i < firstDay; i++) {
      calGrid.innerHTML += `<div class="dl-cal-cell empty"></div>`;
    }
    
    // Days
    const todayStr = new Date().toISOString().slice(0, 10);
    
    for (let day = 1; day <= daysInMonth; day++) {
      const dStr = `${year}-${String(month+1).padStart(2, '0')}-${String(day).padStart(2, '0')}`;
      
      const dayDeadlines = deadlines.filter(d => d.date === dStr);
      let indicators = '';
      if (dayDeadlines.length > 0) {
        indicators = `<div class="dl-cal-indicators">` + dayDeadlines.map(d => `<div class="dl-cal-indicator ${d.type}" title="${d.title}"></div>`).join('') + `</div>`;
      }
      
      const isToday = (dStr === todayStr) ? 'today' : '';
      
      calGrid.innerHTML += `
        <div class="dl-cal-cell ${isToday}">
          <div class="dl-cal-date">${day}</div>
          ${indicators}
        </div>
      `;
    }
  }

  document.getElementById('btnPrevMonth').addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() - 1);
    renderCalendar();
  });
  document.getElementById('btnNextMonth').addEventListener('click', () => {
    currentDate.setMonth(currentDate.getMonth() + 1);
    renderCalendar();
  });

  /* =========================================================
     Reminders List
  ========================================================= */
  const reminderList = document.getElementById('reminderList');
  
  function renderReminders() {
    const deadlines = getDeadlines().filter(item => new Date(item.date) >= new Date(new Date().setHours(0, 0, 0, 0)));
    // Only show next 3 upcoming
    const upcoming = deadlines.slice(0, 4);
    
    reminderList.innerHTML = upcoming.map(item => {
      const d = new Date(item.date);
      const month = d.toLocaleString('en-GB', { month: 'short' });
      const day = d.getDate();
      
      return `
        <div class="dl-card">
          <div class="dl-card-date">
            <span class="dl-card-month">${month}</span>
            <span class="dl-card-day">${day}</span>
          </div>
          <div class="dl-card-content">
            <h4 class="dl-card-title">${item.title}</h4>
            <p class="dl-card-desc">${item.desc}</p>
            <span class="dl-card-priority ${item.priority}">${item.priority} Priority</span>
            
            <div class="dl-card-actions">
              <button class="btn btn-primary set-reminder-btn" style="padding:4px 12px; font-size:12px;">Set Reminder</button>
            </div>
          </div>
        </div>
      `;
    }).join('');
    
    reminderList.querySelectorAll('.set-reminder-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        showToast('Reminder set successfully!');
      });
    });
  }

  /* =========================================================
     Timeline View
  ========================================================= */
  const timelineList = document.getElementById('timelineList');
  
  function getIcon(type) {
    if (type === 'interview') return 'fa-calendar-days';
    if (type === 'offer') return 'fa-envelope-open-text';
    return 'fa-clock';
  }
  
  function getColor(type) {
    if (type === 'interview') return 'var(--blue-600)';
    if (type === 'offer') return '#16a34a';
    return '#ef4444';
  }

  function renderTimeline() {
    const deadlines = getDeadlines();
    timelineList.innerHTML = deadlines.map(item => {
      const d = new Date(item.date);
      const dateStr = d.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
      const icon = getIcon(item.type);
      const color = getColor(item.type);
      
      return `
        <div class="im-tl-step active">
          <div class="im-tl-icon" style="border-color:${color}; color:${color};"><i class="fa-solid ${icon}"></i></div>
          <div class="im-tl-content">
            <h4>${item.title}</h4>
            <p>${item.desc}</p>
            <span class="im-tl-date" style="color: ${color}; font-weight: 500;"><i class="fa-regular fa-calendar" style="margin-right:4px;"></i> ${dateStr}</span>
          </div>
        </div>
      `;
    }).join('');
  }

  /* =========================================================
     Toast
  ========================================================= */
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

  // Init
  renderCalendar();
  renderReminders();
  renderTimeline();

  window.addEventListener('storage', (e) => {
    if (['SIMS_INTERVIEWS_DATA', 'SIMS_OFFERS_DATA', 'SIMS_INTERNSHIPS_DATA'].includes(e.key)) {
      renderCalendar(); renderReminders(); renderTimeline();
    }
  });

});

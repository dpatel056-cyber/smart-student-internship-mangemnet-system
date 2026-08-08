// interview.js – CRUD for interview scheduling and UI rendering
// Requires GlobalStore with methods: addInterview, updateInterview, getInterviews
(function() {
  const storageKey = 'SIMS_INTERVIEWS_DATA';

  // Helper to persisting data in GlobalStore (fallback to localStorage if not present)
  function saveInterviews(data) {
    if (window.GlobalStore && GlobalStore.setInterviews) {
      GlobalStore.setInterviews(data);
    } else {
      localStorage.setItem(storageKey, JSON.stringify(data));
    }
    // Trigger storage event for real‑time sync
    localStorage.setItem(storageKey, localStorage.getItem(storageKey));
  }

  function loadInterviews() {
    if (window.GlobalStore && GlobalStore.getInterviews) {
      return GlobalStore.getInterviews() || [];
    }
    const raw = localStorage.getItem(storageKey);
    return raw ? JSON.parse(raw) : [];
  }

  // Public API
  window.InterviewAPI = {
    addInterview(interview) {
      const interviews = loadInterviews();
      interview.id = interview.id || Date.now().toString();
      interviews.push(interview);
      saveInterviews(interviews);
    },
    updateInterview(id, updates) {
      const interviews = loadInterviews();
      const idx = interviews.findIndex(i => i.id === id);
      if (idx === -1) return;
      interviews[idx] = { ...interviews[idx], ...updates };
      saveInterviews(interviews);
    },
    getInterviews() {
      return loadInterviews();
    }
  };

  // UI rendering for schedule page (company‑side)
  function renderScheduleForm() {
    const form = document.getElementById('interviewScheduleForm');
    if (!form) return;
    form.addEventListener('submit', e => {
      e.preventDefault();
      const date = form.elements['date'].value;
      const time = form.elements['time'].value;
      const notes = form.elements['notes'].value;
      const candidate = form.elements['candidate'].value;
      if (!date || !time || !candidate) return alert('Date, time and candidate are required');
      InterviewAPI.addInterview({ date, time, notes, candidate, status: 'Scheduled' });
      alert('Interview scheduled');
      form.reset();
      // Refresh list if present
      renderInterviewList();
    });
  }

  // UI rendering for admin overview page
  function renderInterviewList() {
    const container = document.getElementById('adminInterviewList');
    if (!container) return;
    const interviews = InterviewAPI.getInterviews();
    if (interviews.length === 0) {
      container.innerHTML = '<p>No interviews scheduled.</p>';
      return;
    }
    const rows = interviews.map(i => `
      <tr data-id="${i.id}">
        <td>${i.candidate}</td>
        <td>${i.date}</td>
        <td>${i.time}</td>
        <td>${i.notes || ''}</td>
        <td>${i.status}</td>
      </tr>`).join('');
    container.innerHTML = `
      <table class="interview-table">
        <thead><tr><th>Candidate</th><th>Date</th><th>Time</th><th>Notes</th><th>Status</th></tr></thead>
        <tbody>${rows}</tbody>
      </table>`;
  }

  document.addEventListener('DOMContentLoaded', () => {
    // Decide which page we are on by presence of elements
    if (document.getElementById('interviewScheduleForm')) {
      renderScheduleForm();
    }
    if (document.getElementById('adminInterviewList')) {
      renderInterviewList();
    }
  });
})();

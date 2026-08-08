document.addEventListener('DOMContentLoaded', () => {

  const toggles = document.querySelectorAll('.form-check-input');
  let session = {};
  try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) {}
  const privacyKey = `SIMS_PRIVACY_PREFERENCES_${session.email || 'student'}`;
  let preferences = {};
  try { preferences = JSON.parse(localStorage.getItem(privacyKey)) || {}; } catch (e) {}
  toggles.forEach(toggle => { if (Object.prototype.hasOwnProperty.call(preferences, toggle.id)) toggle.checked = preferences[toggle.id]; });
  
  toggles.forEach(toggle => {
    toggle.addEventListener('change', (e) => {
      const isChecked = e.target.checked;
      const id = e.target.id;
      let settingName = '';

      if (id === 'toggle2FA') settingName = 'Two-Step Verification';
      if (id === 'toggleAlerts') settingName = 'Login Alerts';
      if (id === 'toggleRemember') settingName = 'Remember Devices';

      const stateStr = isChecked ? 'enabled' : 'disabled';
      preferences[id] = isChecked;
      localStorage.setItem(privacyKey, JSON.stringify(preferences));
      showToast(`${settingName} has been ${stateStr}.`);
    });
  });

  const revokeBtns = document.querySelectorAll('.revoke-btn');
  revokeBtns.forEach(btn => {
    btn.addEventListener('click', (e) => {
      const tr = e.target.closest('tr');
      const deviceName = tr.cells[0].textContent.trim();
      
      if (confirm(`Are you sure you want to revoke access for ${deviceName}?`)) {
        tr.remove();
        showToast(`Access revoked for ${deviceName}.`);
        
        // If no more revoke buttons
        const remaining = document.querySelectorAll('.revoke-btn');
        if (remaining.length === 0) {
          showToast('All remote sessions have been revoked.');
        }
      }
    });
  });

  // Toast
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

});

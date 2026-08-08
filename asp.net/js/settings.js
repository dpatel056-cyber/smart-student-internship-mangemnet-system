// settings.js – handles theme, language, and password updates
(function() {
  document.addEventListener('DOMContentLoaded', () => {
    const session = JSON.parse(localStorage.getItem('simsSession') || '{}');
    const themeToggle = document.getElementById('themeToggle'); // assumed checkbox
    const langSelect = document.getElementById('langSelect'); // assumed <select>
    const pwdForm = document.getElementById('pwdForm'); // assumed form

    // Load persisted settings
    const settings = GlobalStore.getSettings?.() || {};
    if (settings.theme) {
      document.documentElement.setAttribute('data-theme', settings.theme);
      if (themeToggle) themeToggle.checked = settings.theme === 'dark';
    }
    if (settings.language && langSelect) langSelect.value = settings.language;

    // Theme toggle handler
    if (themeToggle) {
      themeToggle.addEventListener('change', e => {
        const newTheme = e.target.checked ? 'dark' : 'light';
        document.documentElement.setAttribute('data-theme', newTheme);
        GlobalStore.updateSetting('theme', newTheme);
      });
    }

    // Language change handler
    if (langSelect) {
      langSelect.addEventListener('change', e => {
        GlobalStore.updateSetting('language', e.target.value);
      });
    }

    // Password change handler (simple demo – real app would hash & validate)
    if (pwdForm) {
      pwdForm.addEventListener('submit', e => {
        e.preventDefault();
        const newPwd = pwdForm.elements['newPassword'].value;
        if (!newPwd) return alert('Enter a new password');
        // Update user password in store (assuming current user email is session.email)
        GlobalStore.updateUserPassword(session.email, newPwd);
        alert('Password updated');
        pwdForm.reset();
      });
    }
  });
})();

document.addEventListener('DOMContentLoaded', () => {

  const previewBody = document.getElementById('previewBody');
  const themeCards = document.querySelectorAll('.theme-card');
  const colorCircles = document.querySelectorAll('.color-circle');
  const fontSizeRange = document.getElementById('fontSizeRange');
  const btnSave = document.getElementById('btnSave');
  const btnReset = document.getElementById('btnReset');
  let session = {};
  try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) {}
  const preferenceKey = `SIMS_THEME_PREFERENCES_${session.email || 'student'}`;

  function applyPreferences(preferences) {
    const modeCard = [...themeCards].find(card => card.dataset.mode === preferences.mode) || themeCards[0];
    modeCard?.click();
    const colorCircle = [...colorCircles].find(circle => circle.dataset.color === preferences.color) || colorCircles[0];
    colorCircle?.click();
    if (fontSizeRange) { fontSizeRange.value = preferences.fontSize || 2; fontSizeRange.dispatchEvent(new Event('input')); }
  }
  try { const saved = JSON.parse(localStorage.getItem(preferenceKey)); if (saved) applyPreferences(saved); } catch (e) {}

  // Mode Selection
  themeCards.forEach(card => {
    card.addEventListener('click', () => {
      themeCards.forEach(c => c.classList.remove('active'));
      card.classList.add('active');
      
      const mode = card.dataset.mode;
      if (mode === 'dark') {
        previewBody.classList.add('dark-preview-mode');
      } else if (mode === 'light') {
        previewBody.classList.remove('dark-preview-mode');
      } else {
        // System default: typically we'd matchMedia, for preview we'll assume light
        previewBody.classList.remove('dark-preview-mode');
      }
    });
  });

  // Color Selection
  colorCircles.forEach(circle => {
    circle.addEventListener('click', () => {
      colorCircles.forEach(c => c.classList.remove('active'));
      circle.classList.add('active');
      const color = circle.dataset.color;
      // In a real app we would update the CSS variable root
      document.documentElement.style.setProperty('--blue-600', color);
    });
  });

  // Font Size
  fontSizeRange.addEventListener('input', (e) => {
    const val = parseInt(e.target.value);
    let size = '14px'; // default
    if (val === 1) size = '13px';
    if (val === 3) size = '16px';
    document.documentElement.style.setProperty('font-size', size);
  });

  // Save / Reset
  btnSave.addEventListener('click', () => {
    const activeMode = document.querySelector('.theme-card.active')?.dataset.mode || 'light';
    const activeColor = document.querySelector('.color-circle.active')?.dataset.color || '#2563eb';
    localStorage.setItem(preferenceKey, JSON.stringify({ mode: activeMode, color: activeColor, fontSize: fontSizeRange.value }));
    showToast('Theme preferences saved successfully!');
  });

  btnReset.addEventListener('click', () => {
    themeCards.forEach(c => c.classList.remove('active'));
    themeCards[0].classList.add('active');
    previewBody.classList.remove('dark-preview-mode');

    colorCircles.forEach(c => c.classList.remove('active'));
    colorCircles[0].classList.add('active');
    document.documentElement.style.setProperty('--blue-600', '#2563eb');

    fontSizeRange.value = 2;
    document.documentElement.style.setProperty('font-size', '14px');
    localStorage.removeItem(preferenceKey);

    showToast('Theme reset to default settings.');
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

document.addEventListener('DOMContentLoaded', () => {

  const langCards = document.querySelectorAll('.lang-card');
  const previewTitle = document.getElementById('previewTitle');
  const previewDesc = document.getElementById('previewDesc');
  const btnSaveLang = document.getElementById('btnSaveLang');
  let session = {};
  try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) {}
  const languageKey = `SIMS_LANGUAGE_PREFERENCE_${session.email || 'student'}`;

  const contentMap = {
    en: {
      title: 'Welcome to your Dashboard',
      desc: 'This is how your selected language will appear across the platform. You can change this at any time from your settings.'
    },
    gu: {
      title: 'તમારા ડેશબોર્ડ પર સ્વાગત છે',
      desc: 'તમારી પસંદ કરેલી ભાષા સમગ્ર પ્લેટફોર્મ પર આ રીતે દેખાશે. તમે તમારા સેટિંગ્સમાંથી કોઈપણ સમયે આ બદલી શકો છો.'
    }
  };

  function selectLanguage(lang) {
    const card = [...langCards].find(item => item.dataset.lang === lang);
    if (!card) return;
    langCards.forEach(c => c.classList.remove('active'));
    card.classList.add('active');
    previewTitle.textContent = contentMap[lang].title;
    previewDesc.textContent = contentMap[lang].desc;
  }

  langCards.forEach(card => {
    card.addEventListener('click', () => {
      selectLanguage(card.dataset.lang);
    });
  });

  selectLanguage(localStorage.getItem(languageKey) || document.querySelector('.lang-card.active')?.dataset.lang || 'en');

  btnSaveLang.addEventListener('click', () => {
    localStorage.setItem(languageKey, document.querySelector('.lang-card.active')?.dataset.lang || 'en');
    showToast('Language preference saved successfully!');
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

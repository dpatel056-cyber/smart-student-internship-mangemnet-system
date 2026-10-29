document.addEventListener('DOMContentLoaded', () => {
  if (window._simsScriptInitialized) return;
  window._simsScriptInitialized = true;

  /* ===== Active Navigation Link Detection ===== */
  const path = window.location.pathname.toLowerCase();
  const navLinks = document.querySelectorAll('#mainNav a[data-nav-page]');

  if (navLinks.length > 0) {
    navLinks.forEach(link => link.classList.remove('active'));

    let matched = false;
    navLinks.forEach(link => {
      const page = link.getAttribute('data-nav-page').toLowerCase();

      if (page === 'internships.aspx' && (path.includes('internship-details.aspx') || path.includes('internships.aspx'))) {
        link.classList.add('active');
        matched = true;
      } else if (page === 'companies.aspx' && (path.includes('company-details.aspx') || path.includes('companies.aspx'))) {
        link.classList.add('active');
        matched = true;
      } else if (path.endsWith('/' + page) || path.endsWith(page)) {
        link.classList.add('active');
        matched = true;
      }
    });

    if (!matched) {
      if (path.endsWith('/index.aspx') || path.endsWith('/') || path.includes('index.aspx')) {
        const homeLink = document.querySelector('#mainNav a[data-nav-page="index.aspx"]');
        if (homeLink) homeLink.classList.add('active');
      }
    }
  }

  /* ===== Mobile hamburger menu ===== */
  const hamburgerBtn = document.getElementById('hamburgerBtn');
  const mainNav = document.getElementById('mainNav');

  if (hamburgerBtn && mainNav) {
    hamburgerBtn.addEventListener('click', () => {
      mainNav.classList.toggle('open');
      const icon = hamburgerBtn.querySelector('i');
      icon.classList.toggle('fa-bars');
      icon.classList.toggle('fa-xmark');
    });
  }

  /* Close mobile menu when clicking outside */
  document.addEventListener('click', (e) => {
    if (window.innerWidth <= 992 && mainNav && mainNav.classList.contains('open')) {
      if (!mainNav.contains(e.target) && !hamburgerBtn.contains(e.target)) {
        mainNav.classList.remove('open');
      }
    }
  });

  /* ===== Search panel toggle ===== */
  const searchBtn = document.getElementById('searchBtn');
  const searchPanel = document.getElementById('searchPanel');
  const searchClose = document.getElementById('searchClose');
  const searchInput = document.getElementById('searchInput');
  const notifBtn = document.getElementById('notifBtn');
  const notifPanel = document.getElementById('notifPanel');

  function closeNotif() {
    notifPanel.classList.remove('open');
    notifBtn.classList.remove('active');
  }

  function closeSearch() {
    searchPanel.classList.remove('open');
    searchBtn.classList.remove('active');
  }

  if (searchBtn && searchPanel) {
    searchBtn.addEventListener('click', (e) => {
      e.stopPropagation();
      closeNotif();
      searchPanel.classList.toggle('open');
      searchBtn.classList.toggle('active');
      if (searchPanel.classList.contains('open')) {
        setTimeout(() => searchInput.focus(), 200);
      }
    });
  }

  if (searchClose) {
    searchClose.addEventListener('click', () => closeSearch());
  }

  /* ===== Notification panel toggle ===== */
  if (notifBtn && notifPanel) {
    notifBtn.addEventListener('click', (e) => {
      e.stopPropagation();
      closeSearch();
      notifPanel.classList.toggle('open');
      notifBtn.classList.toggle('active');
    });
  }

  /* Close panels when clicking outside */
  document.addEventListener('click', (e) => {
    if (notifPanel && notifPanel.classList.contains('open') && !notifPanel.contains(e.target)) {
      closeNotif();
    }
    if (searchPanel && searchPanel.classList.contains('open') && !searchPanel.contains(e.target) && e.target !== searchBtn) {
      closeSearch();
    }
  });

  /* Close panels with Escape key */
  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
      closeSearch();
      closeNotif();
    }
  });

  /* ===== Scroll to top button ===== */
  const scrollTopBtn = document.getElementById('scrollTopBtn');
  if (scrollTopBtn) {
    window.addEventListener('scroll', () => {
      if (window.scrollY > 300) {
        scrollTopBtn.classList.add('show');
      } else {
        scrollTopBtn.classList.remove('show');
      }
    });

    scrollTopBtn.addEventListener('click', () => {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  /* ===== Newsletter form ===== */
  const newsletterForm = document.getElementById('newsletterForm');
  if (newsletterForm) {
    newsletterForm.addEventListener('submit', (e) => {
      e.preventDefault();
      const emailInput = newsletterForm.querySelector('input[type="email"]');
      const email = emailInput.value.trim();
      if (email) {
        simsToast('Thank you for subscribing! You will receive our latest updates.', 'success', 'Subscribed!');
        newsletterForm.reset();
      }
    });
  }

  /* ===== Contact form ===== */
  const contactForm = document.getElementById('contactForm');
  if (contactForm) {
    contactForm.addEventListener('submit', (e) => {
      e.preventDefault();
      simsToast('Thank you! Your message has been sent. We will get back to you soon.', 'success', 'Message Sent!');
      contactForm.reset();
    });
  }

});

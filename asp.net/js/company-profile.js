document.addEventListener('DOMContentLoaded', () => {

  /* =========================================================
     Shared helpers
  ========================================================= */
  function slugify(name) {
    return name.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
  }

  function websiteFor(name) {
    return 'www.' + name.toLowerCase().replace(/[^a-z0-9]/g, '') + '.com';
  }

  // Simple deterministic pseudo-random generator seeded by a string,
  // so the same company always gets the same generated content.
  function seededRandom(seed) {
    let h = 0;
    for (let i = 0; i < seed.length; i++) { h = (h * 31 + seed.charCodeAt(i)) >>> 0; }
    return function () {
      h = (h * 1664525 + 1013904223) >>> 0;
      return (h & 0xfffffff) / 0xfffffff;
    };
  }

  /* =========================================================
     Find the requested company from the query string
  ========================================================= */
  const params = new URLSearchParams(window.location.search);
  const requestedName = params.get('company') || '';
  const requestedSlug = slugify(requestedName);

  let company = COMPANIES_DATA.find(c => slugify(c.name) === requestedSlug);
  if (!company) company = COMPANIES_DATA[0]; // graceful fallback

  const rand = seededRandom(company.name);

  /* =========================================================
     Derived fields
  ========================================================= */
  const type = company.size === '5000+' ? 'Public' : 'Private';
  const website = websiteFor(company.name);
  const rating = Math.min(4.9, (3.6 + (company.popularity / 100) * 1.3)).toFixed(1);
  const reviewCount = Math.round(300 + company.popularity * 27 + rand() * 400);

  const INDUSTRY_LABELS = {
    "it-services": "Information Technology & Services",
    "finance": "Finance & Fintech",
    "marketing": "Marketing & Advertising",
    "design": "Design & Software",
    "education": "Education / EdTech",
    "technology": "Technology & Internet",
    "consulting": "Consulting & Business",
    "ecommerce": "E-commerce & Retail",
    "healthcare": "Healthcare",
    "manufacturing": "Manufacturing"
  };
  const industryLabel = INDUSTRY_LABELS[company.category] || company.tag;

  /* =========================================================
     Populate header / basic info
  ========================================================= */
  document.title = `${company.name} - Company Profile | SIMS`;
  document.getElementById('cpBreadcrumbName').textContent = company.name;
  document.getElementById('cpName').textContent = company.name;
  document.getElementById('cpIndustry').textContent = company.tag;
  document.getElementById('cpLocation').textContent = company.location;
  document.getElementById('cpSize').textContent = company.size + ' Employees';
  document.getElementById('cpRatingInline').textContent = rating;
  document.getElementById('cpReviewCountInline').textContent = `(${reviewCount.toLocaleString()} Reviews)`;
  document.getElementById('cpFounded').textContent = company.founded;
  document.getElementById('cpHQ').textContent = company.location;
  document.getElementById('cpType').textContent = type;
  document.getElementById('cpOpenCount').textContent = company.openings;
  document.getElementById('cpTabOpenCount').textContent = `(${company.openings})`;
  document.getElementById('cpAboutName').textContent = company.name;
  document.getElementById('cpLifeName').textContent = company.name;
  document.getElementById('cpContactName').textContent = company.name;
  document.getElementById('cpWhyName').textContent = company.name;
  document.getElementById('cpInternCountHead').textContent = company.openings;

  // Logo badge (reuses the same icon system as the companies listing page)
  const logoEl = document.getElementById('cpLogo');
  if (logoEl) {
    if (company.icon.type === 'fa') {
      logoEl.style.background = company.icon.color + '18';
      logoEl.style.color = company.icon.color;
      logoEl.innerHTML = `<i class="${company.icon.value}"></i>`;
    } else if (company.icon.type === 'img') {
      logoEl.style.background = '#f8fafc';
      logoEl.innerHTML = `<img src="${company.icon.url}" alt="${company.name}" style="width:100%;height:100%;object-fit:contain;border-radius:inherit;">`;
    } else {
      logoEl.style.background = company.icon.bg;
      logoEl.style.color = company.icon.color;
      logoEl.textContent = company.icon.value;
    }
  }

  // About paragraph (templated, since we don't store long-form copy per company)
  const aboutTemplates = [
    `${company.name} is a leading name in ${industryLabel.toLowerCase()}, known for building products and services that reach millions of people. Headquartered in ${company.location}, the company continues to grow its footprint with a strong focus on innovation and quality.`,
    `Founded in ${company.founded}, ${company.name} has grown into one of the well-recognised names in ${industryLabel.toLowerCase()}. With a presence in ${company.location} and beyond, the organisation is known for its collaborative culture and commitment to excellence.`,
    `${company.name} operates in the ${industryLabel.toLowerCase()} space, offering interns and employees the opportunity to work on meaningful, real-world projects. The company's ${company.location} office is home to a diverse and driven team.`
  ];
  document.getElementById('cpAboutText').textContent = aboutTemplates[Math.floor(rand() * aboutTemplates.length)];

  /* =========================================================
     Highlights sidebar
  ========================================================= */
  document.getElementById('cpHlIndustry').textContent = industryLabel;
  document.getElementById('cpHlSize').textContent = company.size + ' Employees';
  document.getElementById('cpHlFounded').textContent = company.founded;
  document.getElementById('cpHlHQ').textContent = company.location;
  document.getElementById('cpHlWebsite').innerHTML = `<a href="#" style="color:var(--blue-600)">${website}</a>`;

  document.getElementById('cpContactHQ').textContent = company.location;
  document.getElementById('cpContactWebsite').textContent = website;
  document.getElementById('cpContactEmail').textContent = `careers@${website.replace('www.', '')}`;

  /* =========================================================
     Rating card
  ========================================================= */
  document.getElementById('cpRatingBig').textContent = rating;
  document.getElementById('cpRatingCountBig').textContent = `(${reviewCount.toLocaleString()} Reviews)`;
  const ratingStat = document.getElementById('cpRatingStat');
  if (ratingStat) ratingStat.textContent = rating;

  function starString(value) {
    const full = Math.round(value);
    return '★'.repeat(full) + '☆'.repeat(5 - full);
  }
  document.getElementById('cpStarsInline').textContent = starString(parseFloat(rating));
  document.getElementById('cpRatingStarsBig').textContent = starString(parseFloat(rating));

  // Rating breakdown bars (5-star down to 1-star), weighted toward the top
  const basePercents = [68, 20, 7, 3, 2];
  const jitter = basePercents.map(() => Math.round((rand() - 0.5) * 6));
  const percents = basePercents.map((p, i) => Math.max(1, p + jitter[i]));
  const total = percents.reduce((a, b) => a + b, 0);
  const normalized = percents.map(p => Math.round((p / total) * 100));

  const barsContainer = document.getElementById('cpRatingBars');
  barsContainer.innerHTML = [5, 4, 3, 2, 1].map((star, i) => `
    <div class="cp-rating-bar-row">
      <span>${star}★</span>
      <div class="cp-rating-bar-track"><div class="cp-rating-bar-fill" style="width:${normalized[i]}%"></div></div>
      <span>${normalized[i]}%</span>
    </div>`).join('');

  /* =========================================================
     Gallery (shared generic stock photos, reused per company)
  ========================================================= */
  const galleryPhotos = [
    "https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1600880292203-757bb62b4baf?auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4?auto=format&fit=crop&w=400&q=80",
    "https://images.unsplash.com/photo-1542744173-8e7e53415bb0?auto=format&fit=crop&w=400&q=80"
  ];
  document.getElementById('cpGalleryGrid').innerHTML = galleryPhotos
    .map(src => `<img src="${src}" alt="${company.name} office life" loading="lazy">`)
    .join('');

  /* =========================================================
     Reviews (generic reviewer pool, quotes reference the company)
  ========================================================= */
  const reviewerPool = [
    { name: "Aarav Sharma", role: "Software Engineering Intern", color: "#2563eb" },
    { name: "Neha Verma", role: "Marketing Intern", color: "#db2777" },
    { name: "Rohan Mehta", role: "Product Management Intern", color: "#059669" },
    { name: "Priya Nair", role: "Design Intern", color: "#7c3aed" },
    { name: "Karan Malhotra", role: "Data Analyst Intern", color: "#d97706" }
  ];
  const quoteTemplates = [
    `An amazing learning experience at ${company.name}. The team was super supportive and the projects were genuinely challenging and exciting.`,
    `${company.name} gave me the freedom to learn, explore and grow. It was a truly rewarding experience end to end.`,
    `I got to work on real-world problems at ${company.name} and the mentorship I received was invaluable to my growth.`,
    `The culture at ${company.name} is very welcoming. I learned more in a few months here than I expected to.`
  ];

  const shuffledReviewers = [...reviewerPool].sort(() => rand() - 0.5).slice(0, 3);
  const reviewsHtml = shuffledReviewers.map((r, i) => {
    const q = quoteTemplates[Math.floor(rand() * quoteTemplates.length)];
    const initials = r.name.split(' ').map(w => w[0]).join('');
    const daysAgo = Math.floor(rand() * 20) + 1;
    return `
      <div class="cp-review-card">
        <div class="cp-review-head">
          <span class="cp-review-avatar" style="background:${r.color}">${initials}</span>
          <div>
            <h5>${r.name}</h5>
            <span>${r.role}</span>
          </div>
        </div>
        <div class="cp-review-stars">★★★★★</div>
        <p>"${q}"</p>
        <span class="cp-review-time">Posted ${daysAgo} days ago</span>
      </div>`;
  }).join('');
  document.getElementById('cpReviewGrid').innerHTML = reviewsHtml;

  /* =========================================================
     Internships — pulled from the shared INTERNSHIPS_DATA so
     every listing links through to a real details page.
  ========================================================= */
  const companyInternships = (typeof INTERNSHIPS_DATA !== 'undefined')
    ? INTERNSHIPS_DATA.filter(i => i.company === company.name).slice(0, 4)
    : [];

  function internLogoHtml(icon) {
    if (icon.type === 'fa') return `<i class="${icon.value}"></i>`;
    if (icon.type === 'img') return `<img src="${icon.url}" alt="logo" style="width:100%;height:100%;object-fit:contain;">`;
    return icon.value;
  }

  const internshipsHtml = companyInternships.map(item => `
      <a href="internship-details.html?id=${item.id}" class="cp-internship-card" style="display:block;text-decoration:none;color:inherit;">
        <div class="cp-i-logo" style="${item.companyIcon.type === 'fa' ? `background:${item.companyIcon.color}18;color:${item.companyIcon.color}` : item.companyIcon.type === 'img' ? 'background:#f8fafc' : `background:${item.companyIcon.bg};color:${item.companyIcon.color}`}">
          ${internLogoHtml(item.companyIcon)}
        </div>
        <h5>${item.title}</h5>
        <p class="cp-i-company">${item.company}</p>
        <p class="cp-i-meta"><i class="fa-solid fa-location-dot"></i> ${item.location.split(',')[0]}, India</p>
        <p class="cp-i-meta"><i class="fa-solid fa-clock"></i> ${item.modeLabel} • ${item.durationLabel}</p>
        <p class="cp-i-stipend">${item.stipendType === 'paid' ? `₹${item.stipend.toLocaleString()} / month` : 'Unpaid'}</p>
      </a>`).join('');
  document.getElementById('cpInternshipGrid').innerHTML = internshipsHtml || '<p style="color:var(--text-muted);font-size:13.5px;">No open internships listed right now. Please check back soon.</p>';

  /* =========================================================
     Tabs — smooth scroll + scrollspy active state
  ========================================================= */
  const tabs = document.querySelectorAll('.cp-tab');
  const sections = [...tabs].map(tab => document.getElementById(tab.dataset.tab));
  const tabsWrap = document.querySelector('.cp-tabs-wrap');

  tabs.forEach(tab => {
    tab.addEventListener('click', (e) => {
      e.preventDefault();
      const target = document.getElementById(tab.dataset.tab);
      const offset = tabsWrap.offsetHeight + 12;
      const top = target.getBoundingClientRect().top + window.scrollY - offset;
      window.scrollTo({ top, behavior: 'smooth' });
    });
  });

  const observer_offset = () => (tabsWrap ? tabsWrap.offsetHeight : 60) + 30;

  function updateActiveTabOnScroll() {
    const offset = observer_offset();
    const sortedSections = [...sections].filter(Boolean).sort((a, b) => a.offsetTop - b.offsetTop);
    let activeId = sortedSections[0] ? sortedSections[0].id : null;
    sortedSections.forEach(sec => {
      const top = sec.getBoundingClientRect().top;
      if (top - offset <= 0) activeId = sec.id;
    });
    tabs.forEach(t => t.classList.toggle('active', t.dataset.tab === activeId));
  }

  let scrollSpyTicking = false;
  window.addEventListener('scroll', () => {
    if (!scrollSpyTicking) {
      window.requestAnimationFrame(() => {
        updateActiveTabOnScroll();
        scrollSpyTicking = false;
      });
      scrollSpyTicking = true;
    }
  });
  updateActiveTabOnScroll();

  /* =========================================================
     Toast + placeholder interactive buttons
  ========================================================= */
  const toast = document.getElementById('loginToast');
  const toastMsg = document.getElementById('loginToastMsg');
  let toastTimer = null;
  function showToast(message) {
    if (!toast) return;
    toastMsg.textContent = message;
    toast.classList.add('show', 'success');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => toast.classList.remove('show'), 3200);
  }

  const followBtn = document.getElementById('followBtn');
  followBtn.addEventListener('click', () => {
    const isFollowing = followBtn.classList.toggle('followed');
    followBtn.innerHTML = isFollowing
      ? `<i class="fa-solid fa-heart"></i> Following`
      : `<i class="fa-regular fa-heart"></i> Follow Company`;
    showToast(isFollowing ? `You are now following ${company.name}.` : `You unfollowed ${company.name}.`);
  });

  document.getElementById('writeReviewBtn').addEventListener('click', () => {
    showToast('Review submission is coming soon!');
  });
  document.getElementById('viewPhotosBtn').addEventListener('click', () => {
    showToast('Full photo gallery is coming soon!');
  });
  document.getElementById('viewAllReviewsBtn').addEventListener('click', () => {
    showToast('Full reviews listing is coming soon!');
  });
  document.getElementById('viewAllInternshipsLink').addEventListener('click', (e) => {
    e.preventDefault();
    showToast('Full internships listing is coming soon!');
  });

});

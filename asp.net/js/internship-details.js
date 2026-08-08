document.addEventListener('DOMContentLoaded', () => {
  const DETAIL_PROFILES = {
    1: {
      overview: 'This Frontend Developer Intern role is focused on building responsive, accessible, and polished user interfaces for a student internship platform. You will work with modern web technologies, learn component-based development, and collaborate closely with designers and backend engineers.',
      responsibilities: [
        'Build and maintain UI components for internship and dashboard pages.',
        'Convert design mockups into responsive web pages.',
        'Fix UI bugs and improve page performance across devices.',
        'Work with APIs to display dynamic internship data.',
        'Participate in reviews and learn code standards from the team.'
      ],
      requirements: [
        'Basic knowledge of HTML, CSS, and JavaScript.',
        'Familiarity with React or another component-based framework is a plus.',
        'Good eye for design and attention to detail.',
        'Willingness to learn and work with a team.',
        'Available for a 3 to 6 month internship period.'
      ],
      benefits: ['Mentorship', 'Real Projects', 'Certificate', 'Flexible Hours', 'Portfolio Growth'],
      skills: ['HTML', 'CSS', 'JavaScript', 'React', 'Responsive Design']
    },
    2: {
      overview: 'The UI/UX Design Intern role is meant for students who want to design intuitive digital experiences. You will support research, wireframing, prototyping, and visual design tasks while learning how product decisions are shaped by user needs.',
      responsibilities: [
        'Create wireframes, mockups, and clickable prototypes.',
        'Assist in user research and competitor analysis.',
        'Design user-friendly layouts for web and mobile screens.',
        'Help refine the visual design system and components.',
        'Collaborate with developers to ensure smooth implementation.'
      ],
      requirements: [
        'Knowledge of Figma, Adobe XD, or similar design tools.',
        'Understanding of UX principles and design hierarchy.',
        'Strong creativity and communication skills.',
        'Basic portfolio or design samples are preferred.',
        'Available for a 2 to 3 month internship period.'
      ],
      benefits: ['Certificate', 'Mentorship', 'Flexible Hours', 'Creative Ownership', 'Design Exposure'],
      skills: ['Figma', 'Wireframing', 'Prototyping', 'UI Design', 'UX Thinking']
    },
    3: {
      overview: 'The Business Analyst Intern role is built for students who enjoy problem solving, research, and structured thinking. You will help teams understand data, identify opportunities, and prepare business insights that support decisions across operations and strategy.',
      responsibilities: [
        'Collect and organize business data from internal sources.',
        'Prepare reports, summaries, and presentations for stakeholders.',
        'Support process analysis and workflow improvement tasks.',
        'Work with teams to document requirements and findings.',
        'Contribute insights during planning and review discussions.'
      ],
      requirements: [
        'Strong analytical and logical thinking skills.',
        'Basic knowledge of Excel, presentation tools, and data handling.',
        'Interest in business operations, strategy, or consulting.',
        'Good verbal and written communication.',
        'Available for a 1 month internship period.'
      ],
      benefits: ['Certificate', 'Mentorship', 'Industry Exposure', 'Resume Value', 'Real Business Experience'],
      skills: ['Analysis', 'Excel', 'Research', 'Presentation', 'Communication']
    }
  };

  let session = null;
  try {
    session = JSON.parse(localStorage.getItem('simsSession'));
  } catch {
    session = null;
  }

  if (session && session.role === 'student') {
    const loginAction = document.querySelector('.navbar-actions a[href="login.aspx"]');
    if (loginAction) {
      loginAction.href = '#';
      loginAction.innerHTML = '<i class="fa-solid fa-right-from-bracket"></i> Logout';
      loginAction.addEventListener('click', (event) => {
        event.preventDefault();
        if (confirm('Are you sure you want to logout?')) {
          localStorage.removeItem('simsSession');
          window.location.href = 'index.aspx';
        }
      });
    }
  }

  const params = new URLSearchParams(window.location.search);
  const requestedId = parseInt(params.get('id'), 10);
  const internships = Array.isArray(window.INTERNSHIPS_DATA) ? window.INTERNSHIPS_DATA : [];
  const internship = internships.find((item) => item.id === requestedId) || internships[0] || null;

  if (!internship) {
    const titleEl = document.getElementById('imdTitle');
    const overviewEl = document.getElementById('imdOverview');
    if (titleEl) titleEl.textContent = 'No internship found';
    if (overviewEl) overviewEl.textContent = 'There is no internship data available to display right now.';
    return;
  }

  const companies = Array.isArray(window.COMPANIES_DATA) ? window.COMPANIES_DATA : [];
  const company = companies.find((c) => c.name === internship.company) || null;

  function seededRandom(seed) {
    let h = 0;
    for (let i = 0; i < seed.length; i++) {
      h = (h * 31 + seed.charCodeAt(i)) >>> 0;
    }
    return function () {
      h = (h * 1664525 + 1013904223) >>> 0;
      return (h & 0xfffffff) / 0xfffffff;
    };
  }

  function formatDate(d) {
    return d.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
  }

  const rand = seededRandom('intern-' + internship.id);
  const openings = company && Number.isFinite(company.openings) ? company.openings : (2 + Math.floor(rand() * 8));
  const today = new Date();
  const startDate = new Date(today);
  startDate.setDate(today.getDate() + 7 + Math.floor(rand() * 21));
  const deadlineDate = new Date(today);
  deadlineDate.setDate(today.getDate() + 1 + Math.floor(rand() * 14));

  const profile = DETAIL_PROFILES[internship.id] || {
    overview: `${internship.company} is looking for a motivated ${internship.title} to join the team. This internship offers hands-on exposure, real project work, and a chance to build practical industry skills.`,
    responsibilities: [
      `Support day-to-day tasks related to ${internship.title.toLowerCase()}.`,
      'Collaborate with team members to complete assigned work on time.',
      'Learn internal tools, workflows, and best practices used by the company.',
      'Contribute ideas, improvements, and feedback during team discussions.',
      'Prepare simple progress updates and documentation when needed.'
    ],
    requirements: [
      'Currently pursuing graduation or a related diploma/degree.',
      'Good communication and problem-solving skills.',
      'Eagerness to learn and work in a team environment.',
      'Basic understanding of the role-specific tools or concepts.',
      'Availability for the full internship duration.'
    ],
    benefits: ['Mentorship', 'Certificate', 'Flexible Hours', 'Real Projects', 'Career Growth'],
    skills: ['Communication', 'Teamwork', 'Adaptability', 'Problem Solving', 'Time Management']
  };

  const setText = (id, value) => {
    const el = document.getElementById(id);
    if (el) el.textContent = value;
  };

  document.title = `${internship.title} - SIMS Internship Details`;

  const imdLogo = document.getElementById('imdLogo');
  if (imdLogo) {
    const icon = internship.companyIcon || {};
    if (icon.type === 'fa') {
      imdLogo.innerHTML = `<i class="${icon.value || 'fa-solid fa-briefcase'}" style="color:${icon.color || '#2563eb'}"></i>`;
    } else if (icon.type === 'img') {
      imdLogo.innerHTML = `<img src="${icon.url}" alt="${internship.company} logo" style="width:100%;height:100%;object-fit:contain;border-radius:inherit;">`;
    } else {
      imdLogo.innerHTML = `<span style="color:${icon.color || '#2563eb'}">${icon.value || internship.company.charAt(0)}</span>`;
    }
  }

  setText('imdTitle', internship.title);
  const companyLink = document.getElementById('imdCompanyName');
  if (companyLink) {
    companyLink.textContent = internship.company;
    companyLink.removeAttribute('href');
    companyLink.style.cursor = 'default';
    companyLink.style.textDecoration = 'none';
    companyLink.style.color = 'inherit';
  }
  setText('imdLocation', internship.location);
  setText('imdMode', internship.modeLabel);
  setText('imdStipend', internship.stipendType === 'paid'
    ? `₹${Number(internship.stipend || 0).toLocaleString()} / month`
    : 'Unpaid');
  setText('imdDuration', internship.durationLabel);

  setText('jdTitle', internship.title);
  setText('jdIndustry', internship.categoryLabel || (company && company.tag) || 'Technology');
  setText('jdOpenings', String(openings));
  setText('jdStartDate', formatDate(startDate));
  setText('jdDeadline', formatDate(deadlineDate));

  const overviewEl = document.getElementById('imdOverview');
  if (overviewEl) overviewEl.textContent = profile.overview;

  const renderList = (id, items) => {
    const el = document.getElementById(id);
    if (el) el.innerHTML = items.map((item) => `<li>${item}</li>`).join('');
  };

  const renderTags = (id, items) => {
    const el = document.getElementById(id);
    if (el) el.innerHTML = items.map((item) => `<span class="imd-skill-tag">${item}</span>`).join('');
  };

  renderList('imdResponsibilities', profile.responsibilities);
  renderList('imdRequirements', profile.requirements);
  renderTags('imdBenefits', profile.benefits);
  renderTags('imdSkills', profile.skills);

  const applyBtn = document.getElementById('applyBtn');
  if (applyBtn) {
    applyBtn.href = `apply-internship.html?id=${internship.id}`;
  }

  const savedKey = 'simsSavedInternships';
  const toast = document.getElementById('dashToast');
  const toastMsg = document.getElementById('dashToastMsg');
  const saveBtn = document.getElementById('saveBtn');
  let toastTimer = null;

  function showToast(message) {
    if (!toast || !toastMsg) return;
    toastMsg.textContent = message;
    toast.classList.add('show', 'success');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => toast.classList.remove('show'), 2800);
  }

  function getSaved() {
    try {
      return new Set(JSON.parse(localStorage.getItem(savedKey)) || []);
    } catch {
      return new Set();
    }
  }

  function setSaved(set) {
    try {
      localStorage.setItem(savedKey, JSON.stringify([...set]));
    } catch {
      // ignore storage errors
    }
  }

  const savedIds = getSaved();

  function updateSaveBtnUI(saved) {
    if (!saveBtn) return;
    if (saved) {
      saveBtn.innerHTML = '<i class="fa-solid fa-bookmark"></i> Saved';
      saveBtn.style.background = 'rgba(37, 99, 235, 0.1)';
      saveBtn.style.color = '#2563eb';
      saveBtn.style.borderColor = 'transparent';
    } else {
      saveBtn.innerHTML = '<i class="fa-regular fa-bookmark"></i> Save Internship';
      saveBtn.style.background = '#fff';
      saveBtn.style.color = '#2563eb';
      saveBtn.style.borderColor = '#2563eb';
    }
  }

  updateSaveBtnUI(savedIds.has(internship.id));

  if (saveBtn) {
    saveBtn.addEventListener('click', (e) => {
      e.preventDefault();
      if (savedIds.has(internship.id)) {
        savedIds.delete(internship.id);
        updateSaveBtnUI(false);
        showToast('Removed from saved internships.');
      } else {
        savedIds.add(internship.id);
        updateSaveBtnUI(true);
        showToast('Saved to your bookmarks!');
      }
      setSaved(savedIds);
    });
  }
});

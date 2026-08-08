document.addEventListener('DOMContentLoaded', () => {

  /* ===================== FAQ DATA ===================== */
  const faqCategories = [
    { id: 'general',    name: 'General',          icon: 'fa-comments',        color: 'cat-blue'   },
    { id: 'students',   name: 'For Students',     icon: 'fa-user-graduate',   color: 'cat-green'  },
    { id: 'companies',  name: 'For Companies',    icon: 'fa-building',        color: 'cat-purple' },
    { id: 'internships',name: 'Internships',      icon: 'fa-briefcase',       color: 'cat-orange' },
    { id: 'applications',name:'Applications',     icon: 'fa-file-lines',      color: 'cat-pink'   },
    { id: 'certificates',name:'Certificates',     icon: 'fa-certificate',     color: 'cat-teal'   },
    { id: 'security',   name: 'Account & Security', icon: 'fa-shield-halved', color: 'cat-skyblue'}
  ];

  const faqData = {
    general: [
      { q: 'What is SIMS?', a: 'SIMS (Smart Student Internship Management System) is a platform that connects students with verified companies offering internship opportunities. It helps students discover, apply, and manage internships while enabling companies to find and hire talented students.' },
      { q: 'How can I register on SIMS?', a: 'Click the "Register" button in the top-right corner, choose whether you are a student or a company, fill in your basic details, verify your email address, and your account will be ready to use.' },
      { q: 'Is SIMS free to use?', a: 'Yes, SIMS is completely free for students. Companies can post a limited number of internships for free, with optional premium plans for advanced hiring features.' },
      { q: 'How can I search for internships?', a: 'Use the "Browse Internships" page and filter by category, location, duration, or stipend to find internships that match your interests and skills.' },
      { q: 'Can I apply for multiple internships?', a: 'Yes, you can apply to as many internships as you like. Your applications are tracked in one place under "My Applications" so you can monitor their status.' },
      { q: 'How will I know if my application is shortlisted?', a: 'You will receive an in-app notification and an email as soon as a company updates your application status to shortlisted, rejected, or selected.' }
    ],
    students: [
      { q: 'Do I need to pay to create a student account?', a: 'No, creating and using a student account on SIMS is completely free, including applying to internships and downloading certificates.' },
      { q: 'How do I upload or update my resume?', a: 'Go to your Student Dashboard, open "Upload Resume", and either upload a new PDF or edit your existing one. Companies will always see your latest version.' },
      { q: 'Can I edit my profile after registration?', a: 'Yes, you can update your skills, education, portfolio links, and profile photo anytime from your Student Dashboard settings.' },
      { q: 'How do I know which internships match my skills?', a: 'SIMS highlights recommended internships on your dashboard based on the skills and interests listed in your profile.' },
      { q: 'What happens after I complete an internship?', a: 'Once a company marks your internship as completed, a verified certificate is automatically generated and added to your profile.' },
      { q: 'Can I withdraw an application after applying?', a: 'Yes, open "My Applications", select the internship, and click "Withdraw Application" before the company reviews it.' },
      { q: 'Will I get feedback if I am rejected?', a: 'Some companies share feedback directly on the application, while others may only update the status without additional comments.' },
      { q: 'Can I save internships to apply later?', a: 'Yes, click the bookmark icon on any internship listing to save it to your "Saved Internships" list for later.' }
    ],
    companies: [
      { q: 'How do I post an internship?', a: 'Log in to your Company Dashboard, click "Post Internship", fill in the role details, required skills, duration, and stipend, then publish it live.' },
      { q: 'Can I manage multiple internship postings at once?', a: 'Yes, the "Manage Internships" section lets you view, edit, pause, or close any of your active or past postings from one place.' },
      { q: 'How do I view student applications?', a: 'Open "View Applications" from your dashboard to see every applicant for a specific internship, along with their resume and profile.' },
      { q: 'Is there a limit on how many students I can hire?', a: 'No, there is no limit. You can shortlist and hire as many students as your internship positions require.' },
      { q: 'How can I search for talented students directly?', a: 'Use the "Find Talents" tool to search the student database by skills, location, or course to proactively reach out to candidates.' },
      { q: 'Can I see analytics on my postings?', a: 'Yes, the "Reports" section shows views, application counts, and conversion rates for each internship you post.' }
    ],
    internships: [
      { q: 'What types of internships are available on SIMS?', a: 'SIMS lists remote, hybrid, and on-site internships across technology, marketing, design, finance, and many other fields.' },
      { q: 'Are internships on SIMS paid or unpaid?', a: 'Both paid and unpaid internships are listed. The stipend, if any, is always clearly mentioned on the internship details page.' },
      { q: 'How long do internships typically last?', a: 'Duration varies by company, typically ranging from 4 weeks to 6 months, and is always specified in the internship listing.' },
      { q: 'Can I filter internships by location?', a: 'Yes, you can filter by city, remote-only, or hybrid options using the filters on the "Browse Internships" page.' },
      { q: 'Do internships offer a certificate on completion?', a: 'Most internships on SIMS provide a verified digital certificate once the company marks your internship as successfully completed.' },
      { q: 'Can international students apply for internships?', a: 'Yes, remote internships are open to international students, though on-site roles may have location-based eligibility.' },
      { q: 'What if an internship listing looks suspicious?', a: 'Use the "Report" button on the listing page, and our team will review and take action within 24 hours.' }
    ],
    applications: [
      { q: 'How do I apply for an internship?', a: 'Open the internship listing, click "Apply Now", attach your resume, add a short cover note, and submit your application.' },
      { q: 'Can I track the status of my application?', a: 'Yes, "My Applications" shows a live status for each one — Applied, Under Review, Shortlisted, Selected, or Rejected.' },
      { q: 'How long does it take to hear back?', a: 'Response times vary by company, but most update application status within 7 to 14 days of your submission.' },
      { q: 'Can I edit my application after submitting it?', a: 'You can update your attached resume before the company reviews your application, but the cover note cannot be edited afterward.' },
      { q: 'Will I be notified about interview calls?', a: 'Yes, interview schedules and messages from companies appear in your notifications and are also sent to your registered email.' }
    ],
    certificates: [
      { q: 'How do I get my internship certificate?', a: 'Once a company marks your internship as completed, your certificate is generated automatically and appears under "Certificates" in your dashboard.' },
      { q: 'Can I download my certificate as a PDF?', a: 'Yes, every certificate can be downloaded as a high-quality PDF directly from your Student Dashboard.' },
      { q: 'Are SIMS certificates verified?', a: 'Yes, each certificate includes a unique verification ID that anyone can use to confirm its authenticity on our verification page.' },
      { q: 'Can I add my certificate to LinkedIn?', a: 'Yes, use the "Share" option on your certificate to add it directly as a LinkedIn certification with a verified link.' }
    ],
    security: [
      { q: 'How do I reset my password?', a: 'Click "Forgot Password" on the login page, enter your registered email, and follow the reset link sent to your inbox.' },
      { q: 'Is my personal data safe on SIMS?', a: 'Yes, SIMS uses encrypted storage and never shares your personal data with third parties without your consent.' },
      { q: 'Can I delete my account permanently?', a: 'Yes, go to Account Settings and select "Delete Account". This action is permanent and removes all your data from SIMS.' },
      { q: 'How do I enable two-factor authentication?', a: 'Go to Account Settings > Security, and toggle on Two-Factor Authentication to add an extra layer of protection to your login.' },
      { q: 'Who can see my profile information?', a: 'Only verified companies you apply to, or those you make your profile visible to, can view your full profile details.' }
    ]
  };

  const catListEl = document.getElementById('faqCatList');
  const faqListEl = document.getElementById('faqList');
  const faqEmptyEl = document.getElementById('faqEmpty');

  if (!catListEl || !faqListEl) return;

  let activeCategory = 'general';

  /* ===== Render category sidebar ===== */
  function renderCategories() {
    catListEl.innerHTML = faqCategories.map(cat => {
      const count = (faqData[cat.id] || []).length;
      const isActive = cat.id === activeCategory ? 'active' : '';
      return `
        <li>
          <button type="button" class="faq-cat-btn ${isActive}" data-cat="${cat.id}">
            <span class="faq-cat-icon ${cat.color}"><i class="fa-solid ${cat.icon}"></i></span>
            <span class="faq-cat-name">${cat.name}</span>
            <span class="faq-cat-count">${count}</span>
          </button>
        </li>`;
    }).join('');
  }

  /* ===== Render FAQ list for active category ===== */
  function renderFaqList() {
    const items = faqData[activeCategory] || [];

    if (items.length === 0) {
      faqListEl.innerHTML = '';
      faqEmptyEl.style.display = 'block';
      return;
    }

    faqEmptyEl.style.display = 'none';

    faqListEl.innerHTML = items.map((item, index) => {
      const isOpen = index === 0 ? 'open' : '';
      const icon = index === 0 ? 'fa-minus' : 'fa-plus';
      return `
        <li class="faq-item ${isOpen}">
          <button type="button" class="faq-question">
            <span>${item.q}</span>
            <i class="fa-solid ${icon}"></i>
          </button>
          <div class="faq-answer">
            <p>${item.a}</p>
          </div>
        </li>`;
    }).join('');
  }

  /* ===== Category click handling ===== */
  catListEl.addEventListener('click', (e) => {
    const btn = e.target.closest('.faq-cat-btn');
    if (!btn) return;
    const cat = btn.dataset.cat;
    if (cat === activeCategory) return;
    activeCategory = cat;
    renderCategories();
    renderFaqList();
  });

  /* ===== Accordion click handling (event delegation) ===== */
  faqListEl.addEventListener('click', (e) => {
    const questionBtn = e.target.closest('.faq-question');
    if (!questionBtn) return;

    const item = questionBtn.closest('.faq-item');
    const icon = questionBtn.querySelector('i');
    const isOpen = item.classList.contains('open');

    /* Close all other items (classic accordion behaviour) */
    faqListEl.querySelectorAll('.faq-item.open').forEach(openItem => {
      if (openItem !== item) {
        openItem.classList.remove('open');
        const openIcon = openItem.querySelector('.faq-question i');
        openIcon.classList.remove('fa-minus');
        openIcon.classList.add('fa-plus');
      }
    });

    /* Toggle clicked item */
    item.classList.toggle('open', !isOpen);
    icon.classList.toggle('fa-plus', isOpen);
    icon.classList.toggle('fa-minus', !isOpen);
  });

  /* ===== Init ===== */
  renderCategories();
  renderFaqList();

});

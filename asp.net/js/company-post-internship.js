/* ============================================================
   SIMS - Company Post Internship JS
   Handles: skill tags, form validation, publish/draft/preview
============================================================ */
document.addEventListener('DOMContentLoaded', () => {
  const params = new URLSearchParams(window.location.search);
  const editId = params.get('id');

  /* ---- Skill Tags ---- */
  const skillInput  = document.getElementById('skillInput');
  const addSkillBtn = document.getElementById('addSkillBtn');
  const skillTags   = document.getElementById('skillTags');
  const skills = [];

  function renderSkill(skill, index) {
    const tag = document.createElement('span');
    tag.style.cssText = 'display:inline-flex;align-items:center;gap:6px;background:#eff6ff;color:#2563eb;font-size:12.5px;font-weight:600;padding:5px 12px;border-radius:20px;';
    tag.innerHTML = `${skill} <button type="button" style="background:none;border:none;cursor:pointer;color:#2563eb;font-size:13px;padding:0;line-height:1;" data-index="${index}">&times;</button>`;
    tag.querySelector('button').addEventListener('click', () => {
      skills.splice(index, 1);
      renderAllSkills();
    });
    return tag;
  }

  function renderAllSkills() {
    skillTags.innerHTML = '';
    skills.forEach((s, i) => skillTags.appendChild(renderSkill(s, i)));
  }

  function addSkill() {
    const val = skillInput.value.trim();
    if (!val) return;
    if (skills.includes(val)) { skillInput.value = ''; return; }
    skills.push(val);
    skillInput.value = '';
    renderAllSkills();
  }

  addSkillBtn.addEventListener('click', addSkill);
  skillInput.addEventListener('keydown', e => { if (e.key === 'Enter') { e.preventDefault(); addSkill(); } });

  // Prefill some demo skills
  function normalizeCategory(label) {
    const map = {
      'Software Development': 'software-dev',
      'Data Science & Analytics': 'data-science',
      'UI/UX Design': 'design',
      'Digital Marketing': 'marketing',
      'Finance & Accounting': 'finance',
      'Human Resources': 'business',
      'Business Development': 'business',
      'Content Writing': 'marketing',
      'Operations': 'business',
      'Research': 'business'
    };
    return map[label] || 'business';
  }

  function normalizeMode(label) {
    if (!label) return { key: 'onsite', label: 'On-site' };
    if (label === 'Remote') return { key: 'wfh', label: 'Work From Home' };
    if (label === 'Hybrid') return { key: 'hybrid', label: 'Hybrid' };
    return { key: 'onsite', label: 'On-site' };
  }

  function getSession() {
    try { return JSON.parse(localStorage.getItem('simsSession')) || {}; } catch { return {}; }
  }

  function loadEditInternship() {
    if (!editId || !window.GlobalStore) return;
    const item = window.GlobalStore.getInternships().find(i => String(i.id) === String(editId));
    if (!item) return;
    document.getElementById('internshipTitle').value = item.title || '';
    document.getElementById('category').value = item.categoryLabel || '';
    document.getElementById('department').value = item.department || '';
    document.getElementById('internshipType').value = item.modeLabel === 'Work From Home' ? 'Remote' : item.modeLabel || 'On-site';
    document.getElementById('location').value = item.location || '';
    document.getElementById('stipend').value = item.stipendType === 'unpaid' ? 'Unpaid' : `₹${Number(item.stipend || 0).toLocaleString()}`;
    document.getElementById('duration').value = item.durationLabel || '';
    document.getElementById('vacancies').value = item.vacancies || 1;
    document.getElementById('lastDate').value = item.lastDate || document.getElementById('lastDate').value;
    document.getElementById('status').value = (item.status || 'Active').toLowerCase();
    document.getElementById('description').value = item.description || '';
    document.getElementById('responsibilities').value = Array.isArray(item.responsibilities) ? item.responsibilities.join('\n') : (item.responsibilities || '');
    document.getElementById('benefits').value = Array.isArray(item.benefits) ? item.benefits.join('\n') : (item.benefits || '');
    if (Array.isArray(item.skills)) {
      skills.splice(0, skills.length, ...item.skills.map(s => typeof s === 'string' ? s : (s.name || s)));
      renderAllSkills();
    }
    const header = document.querySelector('.co-page-header h1');
    const sub = document.querySelector('.co-page-header p');
    if (header) header.textContent = 'Edit Internship';
    if (sub) sub.textContent = `Update the details of your ${item.title}.`;
  }

  if (editId && window.GlobalStore) {
    loadEditInternship();
  } else {
    ['HTML', 'CSS', 'JavaScript', 'React'].forEach(s => { skills.push(s); });
    renderAllSkills();
  }

  /* ---- Set min date for Last Date ---- */
  const lastDateInput = document.getElementById('lastDate');
  if (lastDateInput) {
    const today = new Date().toISOString().split('T')[0];
    lastDateInput.min = today;
    // Default to 30 days from now
    const d = new Date(); d.setDate(d.getDate() + 30);
    lastDateInput.value = d.toISOString().split('T')[0];
  }

  /* ---- Form Submit (Publish) ---- */
  const form = document.getElementById('postInternshipForm');
  const publishBtn = document.getElementById('publishBtn');

  const requiredFields = [
    { id: 'internshipTitle', msg: 'Internship Title is required.' },
    { id: 'category', msg: 'Please select a category.' },
    { id: 'internshipType', msg: 'Please select an internship type.' },
    { id: 'location', msg: 'Location is required.' },
    { id: 'duration', msg: 'Please select a duration.' },
    { id: 'vacancies', msg: 'Number of vacancies is required.' },
    { id: 'lastDate', msg: 'Last date to apply is required.' },
    { id: 'description', msg: 'Internship description is required.' },
  ];

  form.addEventListener('submit', e => {
    e.preventDefault();
    let hasError = false;

    // Clear old errors
    requiredFields.forEach(f => {
      const el = document.getElementById(f.id);
      if (el) el.style.borderColor = '';
    });

    requiredFields.forEach(f => {
      const el = document.getElementById(f.id);
      if (!el || !el.value.trim()) {
        if (el) el.style.borderColor = '#ef4444';
        hasError = true;
        if (!hasError || requiredFields.indexOf(f) === requiredFields.findIndex(x => !document.getElementById(x.id)?.value.trim())) {
          if (window.simsShowToast) window.simsShowToast(f.msg, 'error');
        }
      }
    });

    if (hasError) {
      if (window.simsShowToast) window.simsShowToast('Please fill all required fields.', 'error');
      return;
    }

    publishBtn.disabled = true;
    const spinner = document.getElementById('publishSpinner');
    if (spinner) spinner.style.display = 'inline-block';
    const icon = publishBtn.querySelector('i');
    if (icon) icon.className = '';

    setTimeout(() => {
      let session = {};
      try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}
      
      const newInternship = {
        title: document.getElementById('internshipTitle').value,
        categoryKey: document.getElementById('category').value,
        categoryLabel: document.getElementById('category').options[document.getElementById('category').selectedIndex].text,
        company: session.name || 'TechNova Pvt Ltd',
        companyIcon: {type: 'img', url: '../assets/logo-default.png'},
        location: document.getElementById('location').value,
        locationKey: document.getElementById('location').value.toLowerCase().replace(/[^a-z]/g, ''),
        modeKey: normalizeMode(document.getElementById('internshipType').value).key,
        modeLabel: normalizeMode(document.getElementById('internshipType').value).label,
        stipendType: document.getElementById('stipend').value === 'Unpaid' ? 'unpaid' : 'paid',
        stipend: document.getElementById('stipend').value || 0,
        durationLabel: document.getElementById('duration').options[document.getElementById('duration').selectedIndex].text,
        durationKey: document.getElementById('duration').value,
        postedDaysAgo: 0,
        department: document.getElementById('department').value,
        vacancies: Number(document.getElementById('vacancies').value || 1),
        lastDate: document.getElementById('lastDate').value,
        description: document.getElementById('description').value,
        responsibilities: document.getElementById('responsibilities').value.split('\n').filter(Boolean),
        benefits: document.getElementById('benefits').value.split('\n').filter(Boolean),
        skills: skills.map(name => ({ name })),
        status: document.getElementById('status').value === 'draft' ? 'Draft' : (document.getElementById('status').value === 'closed' ? 'Closed' : 'Active'),
        companyEmail: session.email || ''
      };
      
      if (window.GlobalStore) {
        if (editId) {
          window.GlobalStore.updateInternship(editId, newInternship);
        } else {
          window.GlobalStore.addInternship(newInternship);
        }
      }

      publishBtn.disabled = false;
      if (spinner) spinner.style.display = 'none';
      if (icon) icon.className = 'fa-solid fa-paper-plane';
      if (window.simsShowToast) window.simsShowToast('Internship published successfully!', 'success');
      setTimeout(() => { window.location.href = 'company-manage-internships.html'; }, 1400);
    }, 1200);
  });

  /* ---- Save Draft ---- */
  const saveDraftBtn = document.getElementById('saveDraftBtn');
  if (saveDraftBtn) {
    saveDraftBtn.addEventListener('click', () => {
      if (window.simsShowToast) window.simsShowToast('Internship saved as draft!', 'success');
    });
  }

  /* ---- Preview ---- */
  const previewBtn = document.getElementById('previewBtn');
  if (previewBtn) {
    previewBtn.addEventListener('click', () => {
      if (window.simsShowToast) window.simsShowToast('Preview mode will open in the next module!', 'success');
    });
  }

});

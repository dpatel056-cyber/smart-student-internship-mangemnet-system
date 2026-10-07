/* ============================================================
   SIMS - Module 2 : Student Profile Management
   Shared JavaScript loaded on EVERY page of this module:
     my-profile.html, edit-profile.html, profile-completion.html,
     skills-management.html, education-details.html,
     experience-projects.html

   Responsibilities:
     1) Auth guard (same pattern as dashboard.js)
     2) Student Profile data layer backed by localStorage
        (demo persistence layer — swap for Web API/WebMethod
        calls in the ASP.NET backend without touching page JS,
        see PMData notes below)
     3) Common chrome wiring: sidebar open/close, topbar profile
        dropdown, notification bell, logout confirmation modal,
        toast helper — identical behaviour to dashboard.js so the
        whole app feels like one product.

   ASP.NET MASTER PAGE INTEGRATION NOTE:
     PMData.getProfile()/saveProfile() etc. are the ONLY place
     that touches localStorage. Replace the body of those
     functions with fetch() calls to a Web API / WebMethod and
     every page in this module keeps working unchanged.
============================================================ */

/* =========================================================
   AUTH GUARD — same behaviour as dashboard.js
========================================================= */
(function authGuard() {
  let session = null;
  try {
    session = JSON.parse(localStorage.getItem('simsSession'));
  } catch (e) {
    session = null;
  }
  if (!session || session.role !== 'student') {
    window.location.href = 'login.html';
  }
})();

/* =========================================================
   PMData — Student Profile data layer (localStorage demo)
========================================================= */
const PMData = (function () {
  const LEGACY_STORAGE_KEY = 'simsStudentProfileData';

  function storageKey() {
    let session = null;
    try { session = JSON.parse(localStorage.getItem('simsSession')); } catch (e) { session = null; }
    return `simsStudentProfileData_${(session && session.email) || 'student@sims.com'}`;
  }

  function uid() {
    return 'id' + Date.now().toString(36) + Math.random().toString(36).slice(2, 7);
  }

  function defaultProfile() {
    let session = null;
    try { session = JSON.parse(localStorage.getItem('simsSession')); } catch (e) { session = null; }

    return {
      photo: null,
      fullName: (session && session.name) || 'Student',
      enrollment: (session && session.enrollment) || 'ENR2024001',
      email: (session && session.email && session.email.includes('@')) ? session.email : 'student@sims.com',
      mobile: '+91 98765 43210',
      address: '',
      department: 'Computer Engineering',
      course: 'B.Tech',
      semester: '6th Semester',
      college: 'L.D. College of Engineering',
      dob: '2004-05-14',
      gender: 'Male',
      linkedin: '',
      github: 'https://github.com/aaravpatel',
      resumeUploaded: true,
      resumeName: 'Aarav_Patel_Resume.pdf',
      resumeUpdated: '10 Jul 2026',
      skills: [
        { id: uid(), name: 'HTML5' },
        { id: uid(), name: 'CSS3' },
        { id: uid(), name: 'JavaScript' },
        { id: uid(), name: 'React' },
        { id: uid(), name: 'Java' }
      ],
      education: [
        { id: uid(), college: 'L.D. College of Engineering', university: 'Gujarat Technological University', course: 'B.Tech', department: 'Computer Engineering', semester: '6th Semester', cgpa: '8.40', passingYear: '2027' },
        { id: uid(), college: 'Sardar Patel Vidyalaya', university: 'GSEB Board', course: 'HSC (Science)', department: 'Science', semester: '12th', cgpa: '92%', passingYear: '2023' }
      ],
      projects: [
        { id: uid(), title: 'Smart Attendance System', description: 'Face-recognition based attendance system built for the college lab to auto mark student attendance.', meta: 'Python, OpenCV, Flask', date: '2025' }
      ],
      experience: [
        { id: uid(), title: 'Frontend Developer Intern', description: 'Built and maintained responsive UI components for an internal admin dashboard used by 200+ employees.', meta: 'TechNova Pvt Ltd', date: 'Jun 2025 - Aug 2025' }
      ],
      certificates: [
        { id: uid(), title: 'AWS Cloud Practitioner', description: 'Foundational certification covering core AWS cloud concepts, services and security.', meta: 'Amazon Web Services', date: 'Mar 2026' }
      ],
      achievements: [
        { id: uid(), title: 'Winner - Smart India Hackathon 2025', description: 'Led a 4-member team to build a civic-tech solution, won first place among 120+ teams.', meta: 'Government of India', date: 'Dec 2025' }
      ]
    };
  }

  function getProfile() {
    try {
      const key = storageKey();
      const raw = localStorage.getItem(key);
      if (!raw) {
        const legacy = localStorage.getItem(LEGACY_STORAGE_KEY);
        const seed = legacy && key.endsWith('student@sims.com') ? JSON.parse(legacy) : defaultProfile();
        localStorage.setItem(key, JSON.stringify(seed));
        return seed;
      }
      return JSON.parse(raw);
    } catch (e) {
      const seed = defaultProfile();
      localStorage.setItem(storageKey(), JSON.stringify(seed));
      return seed;
    }
  }

  function saveProfile(data) {
    localStorage.setItem(storageKey(), JSON.stringify(data));
    // Keep the authenticated identity in sync so dashboard and every other
    // student page immediately use the latest profile name/email.
    let session = null;
    try { session = JSON.parse(localStorage.getItem('simsSession')); } catch (e) { session = null; }
    if (session) {
      const previousEmail = session.email;
      session.name = data.fullName || session.name;
      session.email = data.email || session.email;
      session.enrollment = data.enrollment || session.enrollment;
      localStorage.setItem('simsSession', JSON.stringify(session));
      // If email was edited, keep a copy under the new user-specific key too.
      localStorage.setItem(storageKey(), JSON.stringify(data));
      if (window.GlobalStore && previousEmail) {
        window.GlobalStore.updateUser(previousEmail, { name: session.name, email: session.email, enrollment: session.enrollment, profile: data });
        window.GlobalStore.syncStudentProfile(previousEmail, data);
      }
    }
    window.dispatchEvent(new CustomEvent('sims:profile-updated', { detail: { profile: data } }));
    return data;
  }

  function resetProfile() {
    const seed = defaultProfile();
    localStorage.setItem(storageKey(), JSON.stringify(seed));
    return seed;
  }

  /* ---- Completion checklist config, used on My Profile + Profile Completion pages ---- */
  const COMPLETION_FIELDS = [
    { key: 'photo', label: 'Profile Photo', check: d => !!d.photo, link: 'edit-profile.html' },
    { key: 'fullName', label: 'Full Name', check: d => !!(d.fullName && d.fullName.trim()), link: 'edit-profile.html' },
    { key: 'email', label: 'Email Address', check: d => !!(d.email && d.email.trim()), link: 'edit-profile.html' },
    { key: 'mobile', label: 'Mobile Number', check: d => !!(d.mobile && d.mobile.trim()), link: 'edit-profile.html' },
    { key: 'address', label: 'Address', check: d => !!(d.address && d.address.trim()), link: 'edit-profile.html' },
    { key: 'department', label: 'Department', check: d => !!(d.department && d.department.trim()), link: 'edit-profile.html' },
    { key: 'course', label: 'Course', check: d => !!(d.course && d.course.trim()), link: 'edit-profile.html' },
    { key: 'semester', label: 'Semester', check: d => !!(d.semester && d.semester.trim()), link: 'edit-profile.html' },
    { key: 'college', label: 'College Name', check: d => !!(d.college && d.college.trim()), link: 'edit-profile.html' },
    { key: 'dob', label: 'Date of Birth', check: d => !!(d.dob && d.dob.trim()), link: 'edit-profile.html' },
    { key: 'gender', label: 'Gender', check: d => !!(d.gender && d.gender.trim()), link: 'edit-profile.html' },
    { key: 'linkedin', label: 'LinkedIn Profile Link', check: d => !!(d.linkedin && d.linkedin.trim()), link: 'edit-profile.html' },
    { key: 'github', label: 'GitHub Profile Link', check: d => !!(d.github && d.github.trim()), link: 'edit-profile.html' },
    { key: 'skills', label: 'At Least 1 Skill Added', check: d => d.skills && d.skills.length > 0, link: 'skills-management.html' },
    { key: 'resume', label: 'Resume Uploaded', check: d => !!d.resumeUploaded, link: 'my-profile.html' },
    { key: 'education', label: 'Education Details Added', check: d => d.education && d.education.length > 0, link: 'education-details.html' },
    { key: 'expproj', label: 'Project / Experience Added', check: d => (d.projects && d.projects.length > 0) || (d.experience && d.experience.length > 0), link: 'experience-projects.html' }
  ];

  function getCompletion(data) {
    const profile = data || getProfile();
    const completed = [];
    const missing = [];
    COMPLETION_FIELDS.forEach(f => {
      if (f.check(profile)) completed.push(f); else missing.push(f);
    });
    const percent = Math.round((completed.length / COMPLETION_FIELDS.length) * 100);
    return { percent, completed, missing, total: COMPLETION_FIELDS.length };
  }

  function getInitials(name) {
    if (!name) return 'ST';
    return name.trim().split(/\s+/).map(n => n[0]).join('').slice(0, 2).toUpperCase();
  }

  return { getProfile, saveProfile, resetProfile, getCompletion, getInitials, uid };
})();

/* =========================================================
   Common chrome wiring — runs on DOMContentLoaded on every
   Module 2 page (sidebar, topbar dropdown, notif bell, logout,
   toast). Mirrors dashboard.js so behaviour stays identical.
========================================================= */
document.addEventListener('DOMContentLoaded', () => {
  const profile = PMData.getProfile();

  /*
   * NOTE: Sidebar, Topbar, Theme Toggle, Profile Dropdown, and Logout logic
   * has been completely moved to student-layout.js to ensure a unified layout
   * across all student pages.
   */
  const toast = document.getElementById('dashToast');
  const toastMsg = document.getElementById('dashToastMsg');
  let toastTimer = null;
  const profileDropdown = document.getElementById('profileDropdown');

  window.showToast = function showToast(message, type = 'success') {
    if (!toast || !toastMsg) return;
    toast.classList.remove('success', 'error');
    toast.classList.add(type);
    toastMsg.textContent = message;
    toast.querySelector('i').className = type === 'success' ? 'fa-solid fa-circle-check' : 'fa-solid fa-circle-exclamation';
    toast.classList.add('show');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => toast.classList.remove('show'), 3000);
  };
  /* Let each page's own script run its render logic after chrome is ready */
  document.dispatchEvent(new CustomEvent('pmChromeReady', { detail: { profile } }));
});

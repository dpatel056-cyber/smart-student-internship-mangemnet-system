/* ============================================================
   SIMS - Module 3 : Resume & Documents Management
   Shared JavaScript data layer, loaded on EVERY page of this
   module: resume-dashboard, upload-resume, resume-preview,
   certificates-documents, internship-certificate.

   Auth guard + sidebar/topbar/logout/toast chrome is already
   wired by profile-shared.js (Module 2), which is loaded on
   every Module 3 page BEFORE this file, so it is not repeated
   here. This file only adds the RDData persistence layer.

   ASP.NET MASTER PAGE INTEGRATION NOTE:
     RDData.getResume()/saveResume()/getDocuments()/etc. are the
     ONLY places that touch localStorage. Replace the body of
     those functions with fetch() calls to a Web API / WebMethod
     (e.g. POST /api/resume/upload multipart form data) and every
     page in this module keeps working unchanged, since the DOM
     ids and CSS classes used by resume-module.css do not change.
============================================================ */

const RDData = (function () {
  const RESUME_KEY = 'simsResumeData';
  const DOCS_KEY = 'simsDocumentsData';
  const CERT_KEY = 'simsInternshipCertificate';
  const MAX_FILE_SIZE_MB = 5;

  function uid() {
    return 'doc' + Date.now().toString(36) + Math.random().toString(36).slice(2, 7);
  }

  function currentProfile() {
    try { return (typeof PMData !== 'undefined') ? PMData.getProfile() : null; }
    catch (e) { return null; }
  }

  /* ---------------- Resume ---------------- */
  function defaultResume() {
    const profile = currentProfile();
    return {
      uploaded: !!(profile && profile.resumeUploaded),
      fileName: (profile && profile.resumeName) || 'Aarav_Patel_Resume.pdf',
      fileSizeKB: 428,
      uploadedDate: '02 Jun 2026',
      updatedDate: (profile && profile.resumeUpdated) || '10 Jul 2026',
      dataUrl: null,
      version: (profile && profile.resumeUploaded) ? 3 : 0
    };
  }

  function getResume() {
    try {
      const raw = localStorage.getItem(RESUME_KEY);
      if (!raw) {
        const seed = defaultResume();
        localStorage.setItem(RESUME_KEY, JSON.stringify(seed));
        return seed;
      }
      return JSON.parse(raw);
    } catch (e) {
      const seed = defaultResume();
      localStorage.setItem(RESUME_KEY, JSON.stringify(seed));
      return seed;
    }
  }

  function saveResume(data) {
    try {
      localStorage.setItem(RESUME_KEY, JSON.stringify(data));
    } catch (e) {
      /* localStorage quota exceeded (large PDF data URL) - keep everything
         except the raw file bytes so the app still functions. */
      const lite = Object.assign({}, data, { dataUrl: null });
      localStorage.setItem(RESUME_KEY, JSON.stringify(lite));
    }
    /* keep Module 2 "My Profile" resume status in sync */
    const profile = currentProfile();
    if (profile && typeof PMData !== 'undefined') {
      profile.resumeUploaded = !!data.uploaded;
      profile.resumeName = data.fileName;
      profile.resumeUpdated = data.updatedDate;
      PMData.saveProfile(profile);
    }
    return data;
  }

  function deleteResume() {
    const empty = { uploaded: false, fileName: '', fileSizeKB: 0, uploadedDate: '', updatedDate: '', dataUrl: null, version: 0 };
    return saveResume(empty);
  }

  /* ---------------- Certificates & Academic Documents ---------------- */
  function defaultDocuments() {
    return [
      { id: uid(), category: 'certificate', title: 'AWS Cloud Practitioner', issuer: 'Amazon Web Services', date: '12 Mar 2026', fileName: 'AWS_Cloud_Practitioner.pdf', sizeKB: 312, dataUrl: null },
      { id: uid(), category: 'certificate', title: 'Smart India Hackathon 2025 - Winner', issuer: 'Government of India', date: '18 Dec 2025', fileName: 'SIH_2025_Certificate.pdf', sizeKB: 298, dataUrl: null },
      { id: uid(), category: 'academic', title: 'Semester 5 Marksheet', issuer: 'Gujarat Technological University', date: '20 Jan 2026', fileName: 'Semester5_Marksheet.pdf', sizeKB: 184, dataUrl: null },
      { id: uid(), category: 'academic', title: 'HSC Certificate', issuer: 'GSEB Board', date: '05 May 2023', fileName: 'HSC_Certificate.pdf', sizeKB: 156, dataUrl: null }
    ];
  }

  function getDocuments() {
    try {
      const raw = localStorage.getItem(DOCS_KEY);
      if (!raw) {
        const seed = defaultDocuments();
        localStorage.setItem(DOCS_KEY, JSON.stringify(seed));
        return seed;
      }
      return JSON.parse(raw);
    } catch (e) {
      const seed = defaultDocuments();
      localStorage.setItem(DOCS_KEY, JSON.stringify(seed));
      return seed;
    }
  }

  function saveDocuments(list) {
    try {
      localStorage.setItem(DOCS_KEY, JSON.stringify(list));
    } catch (e) {
      const lite = list.map(d => Object.assign({}, d, { dataUrl: null }));
      localStorage.setItem(DOCS_KEY, JSON.stringify(lite));
    }
    return list;
  }

  /* ---------------- Internship Certificate (demo, read-only) ---------------- */
  function defaultCertificate() {
    const profile = currentProfile();
    return {
      certificateId: 'SIMS-INT-2026-0417',
      studentName: (profile && profile.fullName) || 'Aarav Patel',
      companyName: 'TechNova Pvt Ltd',
      role: 'Frontend Developer Intern',
      duration: 'Jun 2025 - Aug 2025 (8 Weeks)',
      issueDate: '05 Sep 2025',
      grade: 'A+ (Outstanding)',
      verifyUrl: 'https://sims.example.edu/verify/SIMS-INT-2026-0417'
    };
  }

  function getCertificate() {
    try {
      const raw = localStorage.getItem(CERT_KEY);
      if (!raw) {
        const seed = defaultCertificate();
        localStorage.setItem(CERT_KEY, JSON.stringify(seed));
        return seed;
      }
      return JSON.parse(raw);
    } catch (e) {
      const seed = defaultCertificate();
      localStorage.setItem(CERT_KEY, JSON.stringify(seed));
      return seed;
    }
  }

  /* ---------------- Helpers ---------------- */
  function formatSize(kb) {
    if (!kb) return '0 KB';
    if (kb < 1024) return Math.round(kb) + ' KB';
    return (kb / 1024).toFixed(2) + ' MB';
  }

  function todayFormatted() {
    const d = new Date();
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return String(d.getDate()).padStart(2, '0') + ' ' + months[d.getMonth()] + ' ' + d.getFullYear();
  }

  return {
    MAX_FILE_SIZE_MB,
    uid, formatSize, todayFormatted,
    getResume, saveResume, deleteResume,
    getDocuments, saveDocuments,
    getCertificate
  };
})();

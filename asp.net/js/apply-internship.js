document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('applicationForm');
  const studentNameInput = document.getElementById('studentName');
  const studentEmailInput = document.getElementById('studentEmail');
  const internshipSelect = document.getElementById('internshipSelect');

  if (studentNameInput && studentEmailInput) {
    let session = {};
    try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) {}
    studentNameInput.value = session.name || 'Aarav Patel';
    studentEmailInput.value = session.email || 'student@sims.com';
  }

  if (internshipSelect && window.GlobalStore && window.GlobalStore.getInternships) {
    const internships = window.GlobalStore.getInternships();
    internshipSelect.innerHTML = '<option value="">Select Internship</option>' + internships.slice(0, 8).map(item => `<option value="${item.id}">${item.title} (${item.company})</option>`).join('');
  }


  const params = new URLSearchParams(window.location.search);
  const requestedId = parseInt(params.get('id'), 10);

  let internship = INTERNSHIPS_DATA.find(i => i.id === requestedId);
  if (!internship) internship = INTERNSHIPS_DATA[0]; // fallback

  const company = COMPANIES_DATA.find(c => c.name === internship.company) || COMPANIES_DATA[0];

  /* =========================================================
     Populate DOM
  ========================================================= */
  const bcDetails = document.getElementById('bcDetails');
  if (bcDetails) {
    bcDetails.textContent = internship.title;
    bcDetails.href = `internship-details.html?id=${internship.id}`;
  }

  document.getElementById('appTitle').textContent = internship.title;
  document.getElementById('appCompany').textContent = internship.company;
  document.getElementById('appLocation').textContent = internship.location;

  /* =========================================================
     Textarea Char Count
  ========================================================= */
  const coverLetter = document.getElementById('coverLetter');
  const charCount = document.getElementById('charCount');
  
  if (coverLetter && charCount) {
    coverLetter.addEventListener('input', () => {
      // rough word count approximation
      const text = coverLetter.value.trim();
      const words = text ? text.split(/\s+/).length : 0;
      charCount.textContent = words;
      if (words > 500) {
        charCount.style.color = '#ef4444';
      } else {
        charCount.style.color = 'inherit';
      }
    });
  }

  /* =========================================================
     Form Submission
  ========================================================= */
  const applyForm = document.getElementById('applyForm');
  const cancelBtn = document.getElementById('cancelBtn');

  if (cancelBtn) {
    cancelBtn.addEventListener('click', () => {
      window.location.href = `internship-details.html?id=${internship.id}`;
    });
  }

  function addApplication(selectedInternship) {
    if (window.GlobalStore) {
      let session = {};
      try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}
      
      const newApp = {
        id: 'APP-' + Math.floor(Math.random() * 1000000),
        internshipId: selectedInternship.id,
        internshipTitle: selectedInternship.title,
        company: selectedInternship.company,
        studentName: studentNameInput?.value.trim() || session.name || 'Student Name',
        studentEmail: studentEmailInput?.value.trim() || session.email || 'student@example.com',
        studentEnrollment: session.enrollment || '',
        status: 'Pending',
        appliedOn: new Date().toISOString()
      };
      window.GlobalStore.addApplication(newApp);
    }
  }

  if (applyForm) {
    applyForm.addEventListener('submit', (e) => {
      e.preventDefault();
      
      const words = coverLetter.value.trim().split(/\s+/).length;
      if (words > 500) {
        alert("Cover letter cannot exceed 500 words.");
        return;
      }
      
      // Save application
      const selectedInternship = window.GlobalStore?.getInternships().find(item => String(item.id) === String(internshipSelect?.value || internship.id)) || internship;
      addApplication(selectedInternship);

      window.location.href = 'my-applications.html';
    });
  }

});

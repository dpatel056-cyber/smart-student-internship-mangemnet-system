document.addEventListener('DOMContentLoaded', () => {

  /* =========================================================
     FAQ Accordion
  ========================================================= */
  const faqList = document.getElementById('faqList');

  if (faqList) {
    faqList.innerHTML = MOCK_FAQ.map((item, index) => `
      <div class="hs-faq-item ${index === 0 ? 'open' : ''}">
        <div class="hs-faq-q">
          ${item.q}
          <i class="fa-solid fa-chevron-down"></i>
        </div>
        <div class="hs-faq-a">
          <div style="padding-top:12px;">${item.a}</div>
        </div>
      </div>
    `).join('');

    faqList.querySelectorAll('.hs-faq-q').forEach(q => {
      q.addEventListener('click', () => {
        const item = q.parentElement;
        const isOpen = item.classList.contains('open');
        
        // Close all
        faqList.querySelectorAll('.hs-faq-item').forEach(i => i.classList.remove('open'));
        
        // Toggle clicked
        if (!isOpen) item.classList.add('open');
      });
    });
  }

  /* =========================================================
     File Upload Mock
  ========================================================= */
  const tkUploadBox = document.getElementById('tkUploadBox');
  const tkFileInput = document.getElementById('tkFileInput');
  const tkUploadText = document.getElementById('tkUploadText');

  if (tkUploadBox && tkFileInput) {
    tkUploadBox.addEventListener('click', () => {
      tkFileInput.click();
    });

    tkFileInput.addEventListener('change', () => {
      if (tkFileInput.files.length > 0) {
        const file = tkFileInput.files[0];
        tkUploadText.innerHTML = `<strong style="color:var(--navy-900);">${file.name}</strong><br><small style="color:#16a34a;">Ready to upload</small>`;
      } else {
        tkUploadText.innerHTML = `Click to upload or drag & drop<br><small style="color:#94a3b8;">PNG, JPG, PDF up to 5MB</small>`;
      }
    });
  }

  /* =========================================================
     Form Submission
  ========================================================= */
  const ticketForm = document.getElementById('ticketForm');
  const tkCancelBtn = document.getElementById('tkCancelBtn');

  if (ticketForm) {
    ticketForm.addEventListener('submit', (e) => {
      e.preventDefault();
      let session = {};
      try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (err) {}
      const attachment = tkFileInput?.files?.[0];
      const ticket = window.GlobalStore?.addSupportTicket({
        studentEmail: session.email || '',
        studentName: session.name || 'Student',
        subject: document.getElementById('tkSubject').value.trim(),
        category: document.getElementById('tkCategory').value,
        description: document.getElementById('tkDesc').value.trim(),
        attachmentName: attachment ? attachment.name : ''
      });
      showToast(ticket ? `Support ticket ${ticket.id} raised successfully.` : 'Support ticket raised successfully!');
      ticketForm.reset();
      tkUploadText.innerHTML = `Click to upload or drag & drop<br><small style="color:#94a3b8;">PNG, JPG, PDF up to 5MB</small>`;
    });
  }

  if (tkCancelBtn) {
    tkCancelBtn.addEventListener('click', () => {
      ticketForm.reset();
      tkUploadText.innerHTML = `Click to upload or drag & drop<br><small style="color:#94a3b8;">PNG, JPG, PDF up to 5MB</small>`;
    });
  }

  /* =========================================================
     Toast
  ========================================================= */
  const dashToast = document.getElementById('dashToast');
  const dashToastMsg = document.getElementById('dashToastMsg');
  let toastTimer = null;
  function showToast(message) {
    if (!dashToast) return;
    dashToastMsg.textContent = message;
    dashToast.classList.add('show', 'success');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => dashToast.classList.remove('show'), 3000);
  }

});

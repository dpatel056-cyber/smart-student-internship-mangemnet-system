/* ============================================================
   SIMS - Module 3 : Internship Certificate page JavaScript
============================================================ */
document.addEventListener('pmChromeReady', () => {

  const cert = RDData.getCertificate();

  document.getElementById('rdCertIdBadge').textContent = 'ID: ' + cert.certificateId;
  document.getElementById('rdCertStudentName').textContent = cert.studentName;
  document.getElementById('rdCertRole').textContent = cert.role;
  document.getElementById('rdCertCompany').textContent = cert.companyName;
  document.getElementById('rdCertDuration').textContent = cert.duration;
  document.getElementById('rdCertDetailCompany').textContent = cert.companyName;
  document.getElementById('rdCertDetailDuration').textContent = cert.duration;
  document.getElementById('rdCertDetailGrade').textContent = cert.grade;
  document.getElementById('rdCertIssueDate').textContent = cert.issueDate;

  const qrImg = document.getElementById('rdCertQrImg');
  qrImg.src = 'https://api.qrserver.com/v1/create-qr-code/?size=160x160&data=' + encodeURIComponent(cert.verifyUrl);
  qrImg.alt = 'Scan to verify certificate ' + cert.certificateId;

  /* ---- Download PDF (client-side render via html2canvas + jsPDF) ---- */
  const downloadBtn = document.getElementById('rdCertDownloadBtn');
  downloadBtn.addEventListener('click', async () => {
    if (typeof html2canvas === 'undefined' || !window.jspdf) {
      showToast('PDF library failed to load. Check your internet connection and try again.', 'error');
      return;
    }
    const originalLabel = downloadBtn.innerHTML;
    downloadBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Preparing PDF&hellip;';
    downloadBtn.disabled = true;

    try {
      const certEl = document.getElementById('rdCertificate');
      const canvas = await html2canvas(certEl, { scale: 2, useCORS: true, backgroundColor: '#ffffff' });
      const imgData = canvas.toDataURL('image/png');
      const { jsPDF } = window.jspdf;
      const pdf = new jsPDF({
        orientation: canvas.width > canvas.height ? 'landscape' : 'portrait',
        unit: 'px',
        format: [canvas.width, canvas.height]
      });
      pdf.addImage(imgData, 'PNG', 0, 0, canvas.width, canvas.height);
      pdf.save(`Internship_Certificate_${cert.certificateId}.pdf`);
      showToast('Certificate PDF downloaded successfully!', 'success');
    } catch (err) {
      showToast('Could not generate the PDF. Please try again.', 'error');
    } finally {
      downloadBtn.innerHTML = originalLabel;
      downloadBtn.disabled = false;
    }
  });

  /* ---- Print ---- */
  document.getElementById('rdCertPrintBtn').addEventListener('click', () => {
    window.print();
  });

  /* ---- Share ---- */
  document.getElementById('rdCertShareBtn').addEventListener('click', async () => {
    const shareData = {
      title: 'SIMS Internship Certificate',
      text: `${cert.studentName}'s internship completion certificate from ${cert.companyName} (${cert.certificateId})`,
      url: cert.verifyUrl
    };
    if (navigator.share) {
      try {
        await navigator.share(shareData);
      } catch (err) {
        /* user cancelled the share sheet - no action needed */
      }
      return;
    }
    try {
      await navigator.clipboard.writeText(cert.verifyUrl);
      showToast('Verification link copied to clipboard!', 'success');
    } catch (err) {
      showToast('Unable to copy the link automatically. Copy it from the address bar instead.', 'error');
    }
  });
});

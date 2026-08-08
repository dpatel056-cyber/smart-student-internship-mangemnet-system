document.addEventListener('DOMContentLoaded', () => {
  const params = new URLSearchParams(window.location.search);
  const internshipId = params.get('id');
  const item = window.GlobalStore ? window.GlobalStore.getInternships().find(i => String(i.id) === String(internshipId)) : null;
  const fallback = item || (window.GlobalStore ? window.GlobalStore.getInternships()[0] : null);
  if (!fallback) return;

  const setText = (id, value) => { const el = document.getElementById(id); if (el) el.textContent = value ?? ''; };
  const setHtml = (id, value) => { const el = document.getElementById(id); if (el) el.innerHTML = value ?? ''; };

  document.title = `${fallback.title} - SIMS | Internship Details`;
  setText('detailTitle', fallback.title);
  setText('detailStatus', fallback.status || 'Active');
  setText('detailPosted', fallback.postedDate || 'Recently');
  setText('detailCompany', fallback.company);
  setText('detailIndustry', fallback.categoryLabel || '');
  setText('detailCategoryDept', `${fallback.categoryLabel || ''}${fallback.department ? ' • ' + fallback.department : ''}`);
  setText('detailLocationType', `${fallback.location || ''}${fallback.modeLabel ? ' • ' + fallback.modeLabel : ''}`);
  setText('detailStipend', fallback.stipendType === 'unpaid' ? 'Unpaid' : `₹${Number(fallback.stipend || 0).toLocaleString()} / month`);
  setText('detailDuration', fallback.durationLabel || '');
  setText('detailVacancies', String(fallback.vacancies || 1));
  setText('detailLastDate', fallback.lastDate || 'Not set');
  setText('detailDescription', fallback.description || 'No description added.');
  setHtml('detailResponsibilities', (Array.isArray(fallback.responsibilities) ? fallback.responsibilities : String(fallback.responsibilities || '').split('\n')).filter(Boolean).map(v => `<li>${v}</li>`).join(''));
  setHtml('detailBenefits', (Array.isArray(fallback.benefits) ? fallback.benefits : String(fallback.benefits || '').split('\n')).filter(Boolean).map(v => `<li>${v}</li>`).join(''));
  setHtml('detailSkills', (Array.isArray(fallback.skills) ? fallback.skills : []).map(v => `<span class="co-tag">${typeof v === 'string' ? v : (v.name || '')}</span>`).join(''));

  const editBtn = document.getElementById('detailEditBtn');
  const deleteBtn = document.getElementById('detailDeleteBtn');
  const closeBtn = document.getElementById('detailCloseBtn');
  if (editBtn) editBtn.href = `company-edit-internship.html?id=${fallback.id}`;

  if (closeBtn) {
    closeBtn.addEventListener('click', () => {
      if (!confirm('Are you sure you want to close this internship? Students will no longer be able to apply.')) return;
      window.GlobalStore?.updateInternship(fallback.id, { status: 'Closed' });
      window.location.reload();
    });
  }

  if (deleteBtn) {
    deleteBtn.addEventListener('click', () => {
      if (!confirm('Are you sure you want to delete this internship? This cannot be undone.')) return;
      window.GlobalStore?.deleteInternship(fallback.id);
      window.location.href = 'company-manage-internships.html';
    });
  }
});

/* ============================================================
   SIMS - Module 2 : Profile Completion page JavaScript
============================================================ */
document.addEventListener('pmChromeReady', () => {

  const profile = PMData.getProfile();
  const completion = PMData.getCompletion(profile);

  document.getElementById('pcHeading').textContent = `Profile ${completion.percent}% Complete`;
  document.getElementById('pcPercentBig').textContent = `${completion.percent}%`;
  document.getElementById('pcProgressFill').style.width = completion.percent + '%';

  const sub = document.getElementById('pcSub');
  if (completion.percent === 100) {
    sub.textContent = 'Your profile is fully complete. Great job — recruiters can now see the full picture!';
  } else if (completion.percent >= 70) {
    sub.textContent = "You're almost there! Complete the remaining details to stand out to recruiters.";
  } else {
    sub.textContent = 'A complete profile gets noticed more often. Fill in the missing details below.';
  }

  document.getElementById('completedCountLabel').textContent = `${completion.completed.length} of ${completion.total} sections completed`;
  document.getElementById('missingCountLabel').textContent = `${completion.missing.length} section${completion.missing.length === 1 ? '' : 's'} remaining`;

  const completedList = document.getElementById('completedList');
  const missingList = document.getElementById('missingList');

  if (completion.completed.length) {
    completedList.innerHTML = completion.completed.map(f => `
      <div class="pm-detail-row completed">
        <i class="fa-solid fa-circle-check pm-row-icon"></i>
        <span>${f.label}</span>
      </div>
    `).join('');
  } else {
    completedList.innerHTML = `<div class="pm-empty-state"><i class="fa-solid fa-circle-check"></i><p>Nothing completed yet.</p></div>`;
  }

  if (completion.missing.length) {
    missingList.innerHTML = completion.missing.map(f => `
      <div class="pm-detail-row missing">
        <i class="fa-solid fa-circle-exclamation pm-row-icon"></i>
        <span>${f.label}</span>
        <a href="${f.link}">Add <i class="fa-solid fa-arrow-right"></i></a>
      </div>
    `).join('');
  } else {
    missingList.innerHTML = `<div class="pm-empty-state"><i class="fa-solid fa-circle-check"></i><p>Nothing missing — your profile is complete!</p></div>`;
  }

  document.getElementById('completeRemainingBtn').addEventListener('click', () => {
    if (completion.missing.length) {
      window.location.href = completion.missing[0].link;
    } else {
      showToast('Your profile is already 100% complete!', 'success');
    }
  });
});

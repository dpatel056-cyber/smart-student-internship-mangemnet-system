document.addEventListener('DOMContentLoaded', () => {

  const savedKey = 'simsSavedInternships';
  
  function getSaved() {
    try { return new Set(JSON.parse(localStorage.getItem(savedKey)) || []); }
    catch (e) { return new Set(); }
  }
  function setSaved(set) {
    localStorage.setItem(savedKey, JSON.stringify([...set]));
  }

  let savedIds = getSaved();

  const savedGrid = document.getElementById('savedGrid');
  const noSavedResults = document.getElementById('noSavedResults');
  const savedCount = document.getElementById('savedCount');

  function logoHtml(icon) {
    if (icon.type === 'fa') {
      return `<div class="im-company-logo" style="background:${icon.color}18;color:${icon.color}"><i class="${icon.value}"></i></div>`;
    }
        if (icon.type === 'img') {
      return `<img src="${icon.url}" alt="logo" style="width:100%;height:100%;object-fit:contain;border-radius:inherit;">`;
    }
    return `<div class="im-company-logo" style="background:${icon.bg};color:${icon.color}">${icon.value}</div>`;
  }

  function modeIcon(modeKey) {
    if (modeKey === 'wfh') return 'fa-house';
    if (modeKey === 'hybrid') return 'fa-building-user';
    return 'fa-building';
  }

  function cardHtml(item) {
    return `
      <div class="im-card" data-id="${item.id}" id="saved-card-${item.id}">
        <div class="im-card-head">
          ${logoHtml(item.companyIcon)}
          <button class="im-save-btn saved" data-id="${item.id}" aria-label="Remove Saved Internship" title="Remove from saved">
            <i class="fa-solid fa-bookmark"></i>
          </button>
        </div>
        <h3 class="im-card-title">${item.title}</h3>
        <div class="im-card-company">
          ${item.company}
        </div>
        
        <div class="im-card-meta">
          <div class="im-meta-item"><i class="fa-solid fa-location-dot"></i> ${item.location.split(',')[0]}</div>
          <div class="im-meta-item"><i class="fa-solid ${modeIcon(item.modeKey)}"></i> ${item.modeLabel}</div>
          <div class="im-meta-item"><i class="fa-regular fa-clock"></i> ${item.durationLabel}</div>
          <div class="im-meta-item"><i class="fa-solid fa-indian-rupee-sign"></i> ${item.stipendType === 'paid' ? '₹' + item.stipend.toLocaleString() : 'Unpaid'}</div>
        </div>
        
        <div class="im-card-footer">
          <div class="im-badge ${item.stipendType === 'paid' ? 'success' : 'primary'}">${item.stipendType === 'paid' ? 'Paid' : 'Unpaid'}</div>
          <div class="im-card-actions">
            <a href="apply-internship.html?id=${item.id}" class="btn btn-primary" style="padding: 8px 16px; font-size: 13px;">Apply Now</a>
            <a href="internship-details.html?id=${item.id}" class="btn btn-ghost" style="padding: 8px 16px; font-size: 13px; margin-left: 8px;">Details</a>
          </div>
        </div>
      </div>`;
  }

  function render() {
    const savedList = INTERNSHIPS_DATA.filter(item => savedIds.has(item.id));
    
    if (savedList.length === 0) {
      savedGrid.style.display = 'none';
      noSavedResults.style.display = 'block';
    } else {
      savedGrid.style.display = 'grid';
      noSavedResults.style.display = 'none';
      savedGrid.innerHTML = savedList.map(cardHtml).join('');
    }
    
    if (savedCount) {
      savedCount.textContent = savedList.length;
    }

    // Attach listeners to remove buttons
    savedGrid.querySelectorAll('.im-save-btn').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.preventDefault();
        const id = parseInt(btn.dataset.id, 10);
        
        savedIds.delete(id);
        setSaved(savedIds);
        
        const card = document.getElementById(`saved-card-${id}`);
        if (card) {
          card.remove();
        }
        
        showToast('Removed from saved internships.');
        
        // Re-check count
        if (savedCount) savedCount.textContent = savedIds.size;
        
        if (savedIds.size === 0) {
          savedGrid.style.display = 'none';
          noSavedResults.style.display = 'block';
        }
      });
    });
  }

  const dashToast = document.getElementById('dashToast');
  const dashToastMsg = document.getElementById('dashToastMsg');
  let toastTimer = null;
  function showToast(message) {
    if (!dashToast) return;
    dashToastMsg.textContent = message;
    dashToast.classList.add('show', 'success');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => dashToast.classList.remove('show'), 2800);
  }

  // Init
  render();

});

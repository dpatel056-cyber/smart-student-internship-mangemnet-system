document.addEventListener('DOMContentLoaded', () => {

  const savedKey = 'simsSavedCompanies';
  
  function getSaved() {
    try { return new Set(JSON.parse(localStorage.getItem(savedKey)) || []); }
    catch (e) { return new Set(); }
  }
  function setSaved(set) {
    localStorage.setItem(savedKey, JSON.stringify([...set]));
  }

  // Seed with some mock data if empty for demo purposes
  let savedNames = getSaved();
  if (savedNames.size === 0) {
    savedNames = new Set(["Google", "Microsoft", "TCS"]);
    setSaved(savedNames);
  }

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

  function cardHtml(item) {
    return `
      <div class="im-card" data-name="${item.name}" id="saved-card-${item.name.replace(/\s+/g, '-')}">
        <div class="im-card-head">
          ${logoHtml(item.icon)}
          <button class="im-save-btn saved" data-name="${item.name}" aria-label="Remove Saved Company" title="Unfollow company">
            <i class="fa-solid fa-bookmark"></i>
          </button>
        </div>
        <h3 class="im-card-title">${item.name}</h3>
        <div class="im-card-company" style="margin-bottom: 20px;">
          ${item.tag}
        </div>
        
        <div class="im-card-meta" style="grid-template-columns: 1fr;">
          <div class="im-meta-item"><i class="fa-solid fa-location-dot"></i> ${item.location}</div>
          <div class="im-meta-item"><i class="fa-solid fa-users"></i> ${item.size} Employees</div>
        </div>
        
        <div class="im-card-footer">
          <div class="im-badge primary"><i class="fa-solid fa-briefcase"></i> ${item.openings} Openings</div>
          <div class="im-card-actions">
            <!-- For demo purposes, we link to browse internships with a pre-filled search -->
            <a href="browse-internships.html" class="btn btn-primary" style="padding: 8px 16px; font-size: 13px;">View Openings</a>
          </div>
        </div>
      </div>`;
  }

  function render() {
    const savedList = COMPANIES_DATA.filter(item => savedNames.has(item.name));
    
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
        const name = btn.dataset.name;
        
        savedNames.delete(name);
        setSaved(savedNames);
        
        const cardId = `saved-card-${name.replace(/\s+/g, '-')}`;
        const card = document.getElementById(cardId);
        if (card) {
          card.remove();
        }
        
        showToast(`Unfollowed ${name}.`);
        
        // Re-check count
        if (savedCount) savedCount.textContent = savedNames.size;
        
        if (savedNames.size === 0) {
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

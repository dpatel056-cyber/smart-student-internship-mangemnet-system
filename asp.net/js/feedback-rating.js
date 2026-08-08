document.addEventListener('DOMContentLoaded', () => {

  let session = {};
  try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) {}
  const feedbackList = document.getElementById('feedbackList');
  const noFeedback = document.getElementById('noFeedback');

  /* =========================================================
     Star Rating Logic
  ========================================================= */
  let currentRatings = {
    overall: 0,
    environment: 0,
    learning: 0,
    mentor: 0,
    culture: 0
  };

  function bindStars(containerIdOrClass, isCategory = false) {
    const containers = isCategory ? document.querySelectorAll(containerIdOrClass) : [document.getElementById(containerIdOrClass)];
    
    containers.forEach(container => {
      if (!container) return;
      const stars = container.querySelectorAll(isCategory ? '.fb-cat-star' : '.fb-star');
      const catName = isCategory ? container.dataset.cat : 'overall';

      stars.forEach(star => {
        // Hover
        star.addEventListener('mouseover', () => {
          const val = parseInt(star.dataset.val);
          stars.forEach(s => {
            if (parseInt(s.dataset.val) <= val) {
              s.classList.remove('fa-regular');
              s.classList.add('fa-solid');
            } else {
              s.classList.remove('fa-solid');
              s.classList.add('fa-regular');
            }
          });
        });

        // Mouse out
        container.addEventListener('mouseleave', () => {
          const selected = currentRatings[catName];
          stars.forEach(s => {
            if (parseInt(s.dataset.val) <= selected) {
              s.classList.remove('fa-regular');
              s.classList.add('fa-solid', 'active');
            } else {
              s.classList.remove('fa-solid', 'active');
              s.classList.add('fa-regular');
            }
          });
        });

        // Click
        star.addEventListener('click', () => {
          currentRatings[catName] = parseInt(star.dataset.val);
          stars.forEach(s => {
            if (parseInt(s.dataset.val) <= currentRatings[catName]) {
              s.classList.remove('fa-regular');
              s.classList.add('fa-solid', 'active');
            } else {
              s.classList.remove('fa-solid', 'active');
              s.classList.add('fa-regular');
            }
          });
        });
      });
    });
  }

  bindStars('overallStars');
  bindStars('.fb-cat-stars', true);

  /* =========================================================
     Render Previous Feedback
  ========================================================= */
  function renderFeedback() {
    const localFeedback = window.GlobalStore ? window.GlobalStore.getFeedback(session.email) : [];
    if (localFeedback.length === 0) {
      feedbackList.style.display = 'none';
      noFeedback.style.display = 'block';
    } else {
      feedbackList.style.display = 'block';
      noFeedback.style.display = 'none';

      feedbackList.innerHTML = localFeedback.map(f => {
        let starsHtml = '';
        for(let i=1; i<=5; i++) {
          starsHtml += `<i class="fa-${i <= f.stars ? 'solid' : 'regular'} fa-star"></i>`;
        }

        return `
          <div class="fb-review">
            <div class="fb-review-avatar">${f.avatar}</div>
            <div class="fb-review-content">
              <div class="fb-review-head">
                <span class="fb-review-name">${f.company} - ${f.role}</span>
                <span class="fb-review-date">${f.date}</span>
              </div>
              <div class="fb-review-stars">${starsHtml}</div>
              <p class="fb-review-text">${f.text}</p>
            </div>
          </div>
        `;
      }).join('');
    }
  }

  /* =========================================================
     Form Submit & Reset
  ========================================================= */
  const feedbackForm = document.getElementById('feedbackForm');
  const fbCompany = document.getElementById('fbCompany');
  const fbRole = document.getElementById('fbRole');
  const fbReviewText = document.getElementById('fbReviewText');
  const resetBtn = document.getElementById('resetBtn');

  const fbSuccessModal = document.getElementById('fbSuccessModal');
  const fbModalClose = document.getElementById('fbModalClose');

  function resetForm() {
    feedbackForm.reset();
    currentRatings = { overall: 0, environment: 0, learning: 0, mentor: 0, culture: 0 };
    
    // reset stars UI
    document.querySelectorAll('.fb-star, .fb-cat-star').forEach(s => {
      s.classList.remove('fa-solid', 'active');
      s.classList.add('fa-regular');
    });
  }

  resetBtn.addEventListener('click', resetForm);

  feedbackForm.addEventListener('submit', (e) => {
    e.preventDefault();

    if (currentRatings.overall === 0) {
      showToast('Please select an Overall Rating.');
      return;
    }

    const newFeedback = {
      studentEmail: session.email,
      company: fbCompany.value,
      role: fbRole.value,
      stars: currentRatings.overall,
      text: fbReviewText.value.trim(),
      date: new Date().toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' }),
      avatar: 'AP'
    };

    window.GlobalStore?.addFeedback(newFeedback);
    renderFeedback();
    resetForm();
    
    fbSuccessModal.classList.add('show');
  });

  fbModalClose.addEventListener('click', () => {
    fbSuccessModal.classList.remove('show');
  });

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
    toastTimer = setTimeout(() => dashToast.classList.remove('show'), 2800);
  }

  // Init
  renderFeedback();

  window.addEventListener('storage', (e) => {
    if (e.key === 'SIMS_FEEDBACK_DATA') renderFeedback();
  });

});

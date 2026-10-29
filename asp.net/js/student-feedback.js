const ratingLabels = {
            '5': '5 - Excellent',
            '4': '4 - Very Good',
            '3': '3 - Good',
            '2': '2 - Fair',
            '1': '1 - Needs Improvement'
        };
        function setStars(rating) {
            const stars = document.querySelectorAll('#starsContainer i');
            stars.forEach(star => {
                const val = parseInt(star.getAttribute('data-val'));
                if (val <= rating) {
                    star.classList.add('active');
                } else {
                    star.classList.remove('active');
                }
            });
            const textEl = document.getElementById('ratingTextLabel');
            if (textEl && ratingLabels[rating]) {
                textEl.innerText = ratingLabels[rating];
            }
        }
        function syncRatingFromDropdown(val) {
            setStars(parseInt(val));
        }
        document.addEventListener('DOMContentLoaded', function () {
            const stars = document.querySelectorAll('#starsContainer i');
            const ddl = document.getElementById('ddlRating');
            stars.forEach(star => {
                star.addEventListener('click', function () {
                    const val = this.getAttribute('data-val');
                    setStars(parseInt(val));
                    if (ddl) {
                        ddl.value = val;
                    }
                });
            });
            if (ddl) {
                setStars(parseInt(ddl.value) || 5);
            }
        });
        function openDrawer(id, type, company, internship, category, rating, subject, message, date, time) {
            // Target
            let targetText = 'General Platform (Admin)';
            if (type === 'Company' && company) {
                targetText = company + (internship ? ' (' + internship + ')' : '');
            }
            document.getElementById('drTarget').innerText = targetText;
            document.getElementById('drCategory').innerText = category || 'General';
            // Rating Stars
            const r = parseInt(rating) || 5;
            let starHtml = '';
            for (let i = 1; i <= 5; i++) {
                if (i <= r) {
                    starHtml += '<i class="fa-solid fa-star" class="fa-star-gold"></i>';
                } else {
                    starHtml += '<i class="fa-regular fa-star" class="fa-star-gray"></i>';
                }
            }
            document.getElementById('drStars').innerHTML = starHtml;
            document.getElementById('drRatingScore').innerText = r + ' / 5';
            document.getElementById('drSubmittedDate').innerText = date || '-';
            document.getElementById('drSubmittedTime').innerText = time || '-';
            document.getElementById('drSubject').innerText = subject || '-';
            document.getElementById('drMessage').innerText = message || '-';
            // Show Drawer Modal
            document.getElementById('drawerOverlay').classList.add('is-active');
            document.getElementById('feedbackDrawer').classList.add('is-open');
        }
        function closeDrawer() {
            document.getElementById('drawerOverlay').classList.remove('is-active');
            document.getElementById('feedbackDrawer').classList.remove('is-open');
        }
        // Close on Escape key
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                closeDrawer();
            }
        });

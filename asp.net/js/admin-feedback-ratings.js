/* =====================================================
   SCRIPT FOR admin-feedback-ratings.aspx
   ===================================================== */
function openDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var drawer = document.getElementById('feedbackDrawer');
            if (overlay && drawer) {
                overlay.classList.add('is-active');
                drawer.classList.add('is-open');
            }
        }

        function closeDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var drawer = document.getElementById('feedbackDrawer');
            if (overlay && drawer) {
                overlay.classList.remove('is-active');
                drawer.classList.remove('is-open');
            }
        }

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                closeDrawer();
            }
        });

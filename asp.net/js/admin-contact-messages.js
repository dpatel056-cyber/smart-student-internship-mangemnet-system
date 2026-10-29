/* =====================================================
   SCRIPT FOR admin-contact-messages.aspx
   ===================================================== */
/* OPEN DRAWER */
        function openDrawer() {
            var overlay = document.getElementById('cmDrawerOverlay');
            var drawer = document.getElementById('cmDetailDrawer');
            if (overlay) {
                overlay.style.display = 'block';
            }
            setTimeout(function () {
                if (drawer) {
                    drawer.classList.add('open');
                }
            }, 10);
            document.body.style.overflow = 'hidden';
        }

        /* CLOSE DRAWER */
        function closeDrawer() {
            var drawer = document.getElementById('cmDetailDrawer');
            var overlay = document.getElementById('cmDrawerOverlay');
            if (drawer) {
                drawer.classList.remove('open');
            }
            setTimeout(function () {
                if (overlay) {
                    overlay.style.display = 'none';
                }
            }, 300);
            document.body.style.overflow = '';
        }

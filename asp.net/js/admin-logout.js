/* ==========================================================================
   SIMS ADMIN LOGOUT PAGE — FRONTEND / DEMO JAVASCRIPT
   No backend calls. All state is client-side for demo purposes only.
   ========================================================================== */
(function () {
    'use strict';

    // Set to false to disable the automatic redirect countdown (useful while testing).
    var ENABLE_AUTO_REDIRECT = true;
    var REDIRECT_SECONDS = 5;
    var countdownTimer = null;

    document.addEventListener('DOMContentLoaded', function () {
        initLogoutModal();
        initSignOutOtherModal();
        initIndividualSessionSignOut();
        initGlobalModalBehavior();
    });

    /* ---------------------------------------------------------------
       TOASTS
    --------------------------------------------------------------- */
    function showToast(message) {
        var container = document.getElementById('toastContainer');
        if (!container) return;

        var toast = document.createElement('div');
        toast.className = 'sims-logout-toast';
        toast.innerHTML =
            '<i class="fa-solid fa-circle-check sims-logout-toast-icon"></i>' +
            '<span>' + message + '</span>' +
            '<button type="button" class="sims-logout-toast-close" aria-label="Close">' +
            '<i class="fa-solid fa-xmark"></i></button>';

        container.appendChild(toast);

        toast.querySelector('.sims-logout-toast-close').addEventListener('click', function () {
            removeToast(toast);
        });

        setTimeout(function () { removeToast(toast); }, 4000);
    }

    function removeToast(toast) {
        if (toast && toast.parentNode) {
            toast.style.opacity = '0';
            setTimeout(function () {
                if (toast.parentNode) toast.parentNode.removeChild(toast);
            }, 150);
        }
    }

    /* ---------------------------------------------------------------
       LOGOUT CONFIRMATION MODAL
    --------------------------------------------------------------- */
    function initLogoutModal() {
        var btnLogout = document.getElementById('btnLogout');
        var btnConfirm = document.getElementById('btnConfirmLogout');

        if (btnLogout) {
            btnLogout.addEventListener('click', function () {
                openModal('modalLogoutOverlay');
            });
        }

        if (btnConfirm) {
            btnConfirm.addEventListener('click', function () {
                closeModal('modalLogoutOverlay');
                performDemoLogout();
            });
        }
    }

    function performDemoLogout() {
        // Demo only: swap states, no real session/auth calls.
        var stateConfirm = document.getElementById('stateConfirm');
        var stateSuccess = document.getElementById('stateSuccess');

        if (stateConfirm) stateConfirm.style.display = 'none';
        if (stateSuccess) stateSuccess.style.display = 'block';

        var timeValue = document.getElementById('logoutTimeValue');
        if (timeValue) {
            timeValue.textContent = formatNow();
        }

        window.scrollTo({ top: 0, behavior: 'smooth' });

        if (ENABLE_AUTO_REDIRECT) {
            startRedirectCountdown();
        } else {
            var countdownEl = document.getElementById('redirectCountdown');
            if (countdownEl) countdownEl.style.display = 'none';
        }
    }

    function formatNow() {
        var d = new Date();
        var options = { day: '2-digit', month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' };
        return d.toLocaleString('en-US', options).replace(',', '');
    }

    function startRedirectCountdown() {
        var seconds = REDIRECT_SECONDS;
        var countdownValueEl = document.getElementById('countdownValue');
        if (countdownValueEl) countdownValueEl.textContent = seconds;

        countdownTimer = setInterval(function () {
            seconds -= 1;
            if (countdownValueEl) countdownValueEl.textContent = Math.max(seconds, 0);

            if (seconds <= 0) {
                clearInterval(countdownTimer);
                // Demo-only redirect. Comment out the line below to disable navigation during testing.
                window.location.href = 'admin-login.aspx';
            }
        }, 1000);
    }

    /* ---------------------------------------------------------------
       SIGN OUT ALL OTHER DEVICES MODAL
    --------------------------------------------------------------- */
    function initSignOutOtherModal() {
        var btnOpen = document.getElementById('btnSignOutAllOther');
        var btnConfirm = document.getElementById('btnConfirmSignOutOther');

        if (btnOpen) {
            btnOpen.addEventListener('click', function () {
                openModal('modalSignOutOtherOverlay');
            });
        }

        if (btnConfirm) {
            btnConfirm.addEventListener('click', function () {
                closeModal('modalSignOutOtherOverlay');
                removeOtherSessionCards();
                showToast('You have been signed out from all other devices.');
            });
        }
    }

    function removeOtherSessionCards() {
        var cards = document.querySelectorAll('.sims-logout-session-signout');
        cards.forEach(function (btn) {
            var card = btn.closest('.sims-logout-session-card');
            if (card) {
                card.style.opacity = '0.4';
                var status = card.querySelector('.sims-logout-session-card-time');
                if (status) status.textContent = 'Signed out';
            }
            btn.disabled = true;
        });
    }

    /* ---------------------------------------------------------------
       INDIVIDUAL SESSION SIGN OUT
    --------------------------------------------------------------- */
    function initIndividualSessionSignOut() {
        var buttons = document.querySelectorAll('.sims-logout-session-signout');
        buttons.forEach(function (btn) {
            btn.addEventListener('click', function () {
                var card = btn.closest('.sims-logout-session-card');
                var deviceName = card ? card.querySelector('.sims-logout-session-card-title').textContent : 'device';

                if (card) {
                    card.style.opacity = '0.4';
                }
                btn.textContent = 'Signed out';
                btn.disabled = true;

                showToast('Signed out from ' + deviceName + '.');
            });
        });
    }

    /* ---------------------------------------------------------------
       GENERIC MODAL OPEN / CLOSE / OVERLAY BEHAVIOR
    --------------------------------------------------------------- */
    function openModal(id) {
        var overlay = document.getElementById(id);
        if (!overlay) return;
        overlay.classList.add('sims-logout-modal-open');
        document.body.classList.add('sims-logout-modal-open-body');
    }

    function closeModal(id) {
        var overlay = document.getElementById(id);
        if (!overlay) return;
        overlay.classList.remove('sims-logout-modal-open');
        if (!document.querySelector('.sims-logout-modal-overlay.sims-logout-modal-open')) {
            document.body.classList.remove('sims-logout-modal-open-body');
        }
    }

    function initGlobalModalBehavior() {
        // Close buttons (X and Cancel) with data-close
        document.querySelectorAll('[data-close]').forEach(function (btn) {
            btn.addEventListener('click', function () {
                closeModal(btn.getAttribute('data-close'));
            });
        });

        // Click outside modal content closes overlay
        document.querySelectorAll('.sims-logout-modal-overlay').forEach(function (overlay) {
            overlay.addEventListener('click', function (e) {
                if (e.target === overlay) {
                    closeModal(overlay.id);
                }
            });
        });

        // Escape key closes any open modal
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                document.querySelectorAll('.sims-logout-modal-overlay.sims-logout-modal-open').forEach(function (overlay) {
                    overlay.classList.remove('sims-logout-modal-open');
                });
                document.body.classList.remove('sims-logout-modal-open-body');
            }
        });
    }

})();

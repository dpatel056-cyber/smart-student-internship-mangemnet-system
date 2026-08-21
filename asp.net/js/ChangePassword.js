(function () {
    function byId(id) {
        return document.getElementById(id);
    }

    function scorePassword(value) {
        var score = 0;
        if (!value) return 0;

        if (value.length >= 8) score += 25;
        if (/[A-Z]/.test(value)) score += 20;
        if (/[a-z]/.test(value)) score += 20;
        if (/[0-9]/.test(value)) score += 15;
        if (/[^A-Za-z0-9]/.test(value)) score += 20;

        return Math.min(100, score);
    }

    function setStrength(value) {
        var rail = byId('strengthRail');
        var label = byId('strengthLabel');
        if (!rail || !label) return;

        if (!value) {
            rail.setAttribute('data-level', '');
            label.textContent = 'Weak';
            return;
        }

        var score = scorePassword(value);
        var level = score < 35 ? 'weak' : score < 75 ? 'medium' : 'strong';
        rail.setAttribute('data-level', level);
        label.textContent = level.charAt(0).toUpperCase() + level.slice(1);
    }

    function togglePassword(btn) {
        var targetId = btn.getAttribute('data-target');
        var input = byId(targetId);
        var icon = btn.querySelector('i');
        if (!input || !icon) return;

        var isPassword = input.getAttribute('type') === 'password';
        input.setAttribute('type', isPassword ? 'text' : 'password');
        icon.className = isPassword ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye';
        btn.setAttribute('aria-label', isPassword ? 'Hide password' : 'Show password');
    }

    function init() {
        var currentPwd = byId('txtCurrentPassword');
        var newPwd = byId('txtNewPassword');
        var confirmPwd = byId('txtConfirmPassword');

        document.querySelectorAll('.cp-eye').forEach(function (btn) {
            btn.addEventListener('click', function () {
                togglePassword(btn);
            });
        });

        if (newPwd) {
            newPwd.addEventListener('input', function () {
                setStrength(newPwd.value);
            });
            setStrength(newPwd.value);
        }

        if (currentPwd) {
            currentPwd.addEventListener('keydown', function (e) {
                if (e && e.getModifierState && e.getModifierState('CapsLock')) {
                    currentPwd.setAttribute('data-capslock', 'on');
                } else {
                    currentPwd.removeAttribute('data-capslock');
                }
            });
        }

        if (confirmPwd) {
            confirmPwd.addEventListener('input', function () {
                if (!newPwd || !confirmPwd) return;
                if (confirmPwd.value && confirmPwd.value !== newPwd.value) {
                    confirmPwd.setCustomValidity('Passwords do not match');
                } else {
                    confirmPwd.setCustomValidity('');
                }
            });
        }

        var cancelBtn = byId('btnCancelPassword');
        if (cancelBtn) {
            cancelBtn.addEventListener('click', function () {
                if (currentPwd) currentPwd.value = '';
                if (newPwd) newPwd.value = '';
                if (confirmPwd) confirmPwd.value = '';
                document.querySelectorAll('.cp-eye i').forEach(function (icon) {
                    icon.className = 'fa-solid fa-eye';
                });
                document.querySelectorAll('.cp-input input').forEach(function (input) {
                    input.setAttribute('type', 'password');
                    input.setCustomValidity('');
                });
                setStrength('');
            });
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();

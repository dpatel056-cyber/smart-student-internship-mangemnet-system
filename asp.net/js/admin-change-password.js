/* =====================================================================
       ADMIN CHANGE PASSWORD PAGE — Vanilla JS (front-end only, no server call)
       Handles: show/hide password, live weighted strength meter, requirement
       checklist, Caps Lock detection, strong password generator, client-side
       validation, and mock success/error UI.
       Scoped to admin-change-password.aspx only.
    ===================================================================== */
(function () {
    var form = document.getElementById('cpForm');
    if (!form) return;

    var currentPwd = document.getElementById('cpCurrentPassword');
    var newPwd = document.getElementById('cpNewPassword');
    var confirmPwd = document.getElementById('cpConfirmPassword');

    var strengthWrap = document.getElementById('cpStrength');
    var strengthFill = document.getElementById('cpStrengthFill');
    var strengthMiniFill = document.getElementById('cpStrengthMiniFill');
    var strengthLabel = document.getElementById('cpStrengthLabel');
    var strengthLabelText = strengthLabel ? strengthLabel.querySelector('span') : null;
    var strengthLabelIcon = strengthLabel ? strengthLabel.querySelector('i') : null;
    var strengthMiniText = document.getElementById('cpStrengthMiniText');

    var successAlert = document.getElementById('cpSuccessAlert');
    var errorAlert = document.getElementById('cpErrorAlert');
    var errorAlertText = document.getElementById('cpErrorAlertText');

    var currentError = document.getElementById('cpCurrentError');
    var sameAsOldError = document.getElementById('cpSameAsOldError');
    var confirmError = document.getElementById('cpConfirmError');
    var confirmSuccess = document.getElementById('cpConfirmSuccess');

    var capsCurrent = document.getElementById('cpCapsCurrent');
    var capsNew = document.getElementById('cpCapsNew');

    var submitBtn = document.getElementById('cpSubmitBtn');
    var cancelBtn = document.getElementById('cpCancelBtn');
    var generateBtn = document.getElementById('cpGenerateBtn');

    var requirements = {
        length: { el: document.getElementById('reqLength'), test: function (v) { return v.length >= 8; } },
        upper: { el: document.getElementById('reqUpper'), test: function (v) { return /[A-Z]/.test(v); } },
        lower: { el: document.getElementById('reqLower'), test: function (v) { return /[a-z]/.test(v); } },
        number: { el: document.getElementById('reqNumber'), test: function (v) { return /[0-9]/.test(v); } },
        special: { el: document.getElementById('reqSpecial'), test: function (v) { return /[^A-Za-z0-9]/.test(v); } }
    };

    var COMMON_WEAK = ['password', '12345678', 'qwerty', 'letmein', 'admin123', 'welcome1', 'iloveyou', '123456789', 'abc12345'];

    /* ---------------------------------------------------------------
       Show / hide password toggles
    --------------------------------------------------------------- */
    document.querySelectorAll('.cp-toggle-eye').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var targetId = btn.getAttribute('data-target');
            var input = document.getElementById(targetId);
            if (!input) return;
            var icon = btn.querySelector('i');
            var isHidden = input.type === 'password';
            input.type = isHidden ? 'text' : 'password';
            if (icon) {
                icon.className = isHidden ? 'fa-solid fa-eye-slash' : 'fa-solid fa-eye';
            }
            btn.setAttribute('aria-label', isHidden ? 'Hide password' : 'Show password');
            input.focus();
        });
    });

    /* ---------------------------------------------------------------
       Caps Lock detection (per field)
    --------------------------------------------------------------- */
    function bindCapsLock(input, warningEl) {
        if (!input || !warningEl) return;
        function handle(e) {
            var on = false;
            if (typeof e.getModifierState === 'function') {
                try { on = e.getModifierState('CapsLock'); } catch (err) { on = false; }
            }
            warningEl.classList.toggle('show', !!on);
        }
        input.addEventListener('keydown', handle);
        input.addEventListener('keyup', handle);
        input.addEventListener('blur', function () { warningEl.classList.remove('show'); });
    }
    bindCapsLock(currentPwd, capsCurrent);
    bindCapsLock(newPwd, capsNew);

    /* ---------------------------------------------------------------
       Requirements checklist
    --------------------------------------------------------------- */
    function updateRequirements(value) {
        var metCount = 0;
        Object.keys(requirements).forEach(function (key) {
            var req = requirements[key];
            if (!req.el) return;
            var met = req.test(value);
            req.el.classList.toggle('cp-req-met', met);
            if (met) metCount++;
        });
        return metCount;
    }

    /* ---------------------------------------------------------------
       Weighted strength score (0-100).
       Rewards length + character variety, penalizes common/weak
       patterns so "password123" doesn't score as strong just
       because it satisfies the basic character-class checklist.
    --------------------------------------------------------------- */
    function scorePassword(value) {
        if (!value) return 0;

        var score = 0;
        var length = value.length;

        // Length contributes the most — up to 45 points.
        score += Math.min(length, 16) * 2.4;
        if (length >= 12) score += 8;
        if (length >= 16) score += 6;

        // Character variety — up to ~40 points.
        var classes = 0;
        if (/[a-z]/.test(value)) classes++;
        if (/[A-Z]/.test(value)) classes++;
        if (/[0-9]/.test(value)) classes++;
        if (/[^A-Za-z0-9]/.test(value)) classes++;
        score += classes * 9;

        // Bonus for genuinely mixed content (not just "Aa1!").
        var uniqueChars = new Set(value.split('')).size;
        score += Math.min(uniqueChars, 12) * 1.2;

        // Penalties for weak, predictable patterns.
        var lower = value.toLowerCase();
        for (var i = 0; i < COMMON_WEAK.length; i++) {
            if (lower.indexOf(COMMON_WEAK[i]) !== -1) { score -= 35; break; }
        }
        if (/^(.)\1+$/.test(value)) score -= 40; // all same character
        if (/(.)\1\1/.test(value)) score -= 10;  // 3+ repeated chars in a row
        if (/^[0-9]+$/.test(value)) score -= 15; // digits only
        if (/^[a-zA-Z]+$/.test(value)) score -= 8; // letters only
        if (/0123|1234|2345|3456|4567|5678|6789|abcd|bcde|cdef/i.test(value)) score -= 12; // sequences

        return Math.max(0, Math.min(100, Math.round(score)));
    }

    function levelFromScore(score, metCount) {
        if (metCount === 0) return { level: '', label: 'Enter a new password', icon: 'fa-circle-info' };
        if (score < 35 || metCount <= 2) return { level: 'weak', label: 'Weak — easy to guess', icon: 'fa-face-frown' };
        if (score < 55) return { level: 'fair', label: 'Fair — add more variety', icon: 'fa-face-meh' };
        if (score < 75) return { level: 'good', label: 'Good', icon: 'fa-face-smile' };
        if (score < 90) return { level: 'strong', label: 'Strong', icon: 'fa-shield-halved' };
        return { level: 'excellent', label: 'Excellent password', icon: 'fa-shield-heart' };
    }

    function updateStrength(value) {
        if (!strengthWrap) return;

        var metCount = updateRequirements(value);

        if (!value) {
            strengthWrap.setAttribute('data-level', '');
            if (strengthFill) strengthFill.style.width = '0%';
            if (strengthMiniFill) strengthMiniFill.style.width = '0%';
            if (strengthMiniText) strengthMiniText.textContent = 'Strong';
            if (strengthLabelText) strengthLabelText.textContent = 'Enter a new password';
            if (strengthLabelIcon) strengthLabelIcon.className = 'fa-solid fa-circle-info';
            return 0;
        }

        var score = scorePassword(value);
        var info = levelFromScore(score, metCount);

        strengthWrap.setAttribute('data-level', info.level);
        if (strengthFill) strengthFill.style.width = Math.max(6, score) + '%';
        if (strengthMiniFill) strengthMiniFill.style.width = Math.max(6, score) + '%';
        if (strengthMiniText) strengthMiniText.textContent = info.level ? info.level.charAt(0).toUpperCase() + info.level.slice(1) : 'Strong';
        if (strengthLabelText) strengthLabelText.textContent = info.label + ' \u2014 ' + score + '%';
        if (strengthLabelIcon) strengthLabelIcon.className = 'fa-solid ' + info.icon;

        return score;
    }

    function checkSameAsOld() {
        if (!newPwd || !currentPwd) return true;
        var clash = !!newPwd.value && newPwd.value === currentPwd.value;
        newPwd.classList.toggle('cp-input-invalid', clash);
        if (sameAsOldError) sameAsOldError.classList.toggle('show', clash);
        return !clash;
    }

    if (newPwd) {
        newPwd.addEventListener('input', function () {
            newPwd.classList.remove('cp-input-invalid');
            if (sameAsOldError) sameAsOldError.classList.remove('show');
            updateStrength(newPwd.value);
            checkMatch();
        });
        // Initialize requirement list (all unmet) on load
        updateStrength('');
    }

    if (currentPwd) {
        currentPwd.addEventListener('input', function () {
            currentPwd.classList.remove('cp-input-invalid');
            if (currentError) currentError.classList.remove('show');
        });
        currentPwd.addEventListener('blur', checkSameAsOld);
    }

    /* ---------------------------------------------------------------
       Confirm password match check
    --------------------------------------------------------------- */
    function checkMatch() {
        if (!confirmPwd || !confirmPwd.value) {
            if (confirmPwd) confirmPwd.classList.remove('cp-input-invalid', 'cp-input-valid');
            if (confirmError) confirmError.classList.remove('show');
            if (confirmSuccess) confirmSuccess.classList.remove('show');
            return true;
        }
        var matches = confirmPwd.value === newPwd.value;
        confirmPwd.classList.toggle('cp-input-invalid', !matches);
        confirmPwd.classList.toggle('cp-input-valid', matches);
        if (confirmError) confirmError.classList.toggle('show', !matches);
        if (confirmSuccess) confirmSuccess.classList.toggle('show', matches);
        return matches;
    }

    if (confirmPwd) {
        confirmPwd.addEventListener('input', checkMatch);
    }

    /* ---------------------------------------------------------------
       Strong password generator
    --------------------------------------------------------------- */
    function generateStrongPassword(length) {
        length = length || 14;
        var sets = {
            lower: 'abcdefghijkmnopqrstuvwxyz',
            upper: 'ABCDEFGHJKLMNPQRSTUVWXYZ',
            number: '23456789',
            special: '!@#$%^&*()-_=+?'
        };
        var all = sets.lower + sets.upper + sets.number + sets.special;
        var randomInt;

        if (window.crypto && window.crypto.getRandomValues) {
            randomInt = function (max) {
                var arr = new Uint32Array(1);
                window.crypto.getRandomValues(arr);
                return arr[0] % max;
            };
        } else {
            randomInt = function (max) { return Math.floor(Math.random() * max); };
        }

        var chars = [
            sets.lower[randomInt(sets.lower.length)],
            sets.upper[randomInt(sets.upper.length)],
            sets.number[randomInt(sets.number.length)],
            sets.special[randomInt(sets.special.length)]
        ];

        for (var i = chars.length; i < length; i++) {
            chars.push(all[randomInt(all.length)]);
        }

        // Shuffle (Fisher-Yates) so required classes aren't always at the start.
        for (var j = chars.length - 1; j > 0; j--) {
            var k = randomInt(j + 1);
            var tmp = chars[j]; chars[j] = chars[k]; chars[k] = tmp;
        }

        return chars.join('');
    }

    var toastEl = null;
    function showToast(message, iconClass) {
        if (!toastEl) {
            toastEl = document.createElement('div');
            toastEl.className = 'cp-toast';
            document.body.appendChild(toastEl);
        }
        toastEl.innerHTML = '<i class="fa-solid ' + (iconClass || 'fa-circle-check') + '"></i><span></span>';
        toastEl.querySelector('span').textContent = message;
        toastEl.classList.add('show');
        clearTimeout(toastEl._hideTimer);
        toastEl._hideTimer = setTimeout(function () {
            toastEl.classList.remove('show');
        }, 2600);
    }

    if (generateBtn) {
        generateBtn.addEventListener('click', function () {
            var pwd = generateStrongPassword(14);

            [newPwd, confirmPwd].forEach(function (input) {
                if (!input) return;
                input.type = 'text';
                input.value = pwd;
                var toggle = document.querySelector('.cp-toggle-eye[data-target="' + input.id + '"] i');
                if (toggle) toggle.className = 'fa-solid fa-eye-slash';
            });

            newPwd.classList.remove('cp-input-invalid');
            if (sameAsOldError) sameAsOldError.classList.remove('show');
            updateStrength(pwd);
            checkMatch();
            checkSameAsOld();

            if (navigator.clipboard && navigator.clipboard.writeText) {
                navigator.clipboard.writeText(pwd).then(function () {
                    showToast('Strong password generated and copied to clipboard', 'fa-clipboard-check');
                }).catch(function () {
                    showToast('Strong password generated', 'fa-wand-magic-sparkles');
                });
            } else {
                showToast('Strong password generated', 'fa-wand-magic-sparkles');
            }
        });
    }

    /* ---------------------------------------------------------------
       Alerts
    --------------------------------------------------------------- */
    function hideAlerts() {
        if (successAlert) successAlert.classList.remove('show');
        if (errorAlert) errorAlert.classList.remove('show');
    }

    function showError(message) {
        hideAlerts();
        if (errorAlertText) errorAlertText.textContent = message;
        if (errorAlert) {
            errorAlert.classList.add('show');
            errorAlert.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
    }

    function showSuccess() {
        hideAlerts();
        if (successAlert) {
            successAlert.classList.add('show');
            successAlert.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }
    }

    document.querySelectorAll('.cp-alert-close').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var alertEl = btn.closest('.cp-alert');
            if (alertEl) alertEl.classList.remove('show');
        });
    });

    /* ---------------------------------------------------------------
       Cancel button: reset the form back to its initial state
    --------------------------------------------------------------- */
    if (cancelBtn) {
        cancelBtn.addEventListener('click', function () {
            form.reset();
            [currentPwd, newPwd, confirmPwd].forEach(function (el) {
                if (el) {
                    el.classList.remove('cp-input-invalid', 'cp-input-valid');
                    el.type = 'password';
                }
            });
            document.querySelectorAll('.cp-toggle-eye i').forEach(function (icon) {
                icon.className = 'fa-solid fa-eye';
            });
            if (confirmError) confirmError.classList.remove('show');
            if (confirmSuccess) confirmSuccess.classList.remove('show');
            if (currentError) currentError.classList.remove('show');
            if (sameAsOldError) sameAsOldError.classList.remove('show');
            if (capsCurrent) capsCurrent.classList.remove('show');
            if (capsNew) capsNew.classList.remove('show');
            updateStrength('');
            hideAlerts();
        });
    }

    /* ---------------------------------------------------------------
       Submit (front-end only — no real request is sent)
    --------------------------------------------------------------- */
    form.addEventListener('submit', function (e) {
        e.preventDefault();
        hideAlerts();

        var hasError = false;

        if (!currentPwd.value.trim()) {
            currentPwd.classList.add('cp-input-invalid');
            if (currentError) currentError.classList.add('show');
            hasError = true;
        } else {
            currentPwd.classList.remove('cp-input-invalid');
            if (currentError) currentError.classList.remove('show');
        }

        var metCount = updateRequirements(newPwd.value);
        var score = updateStrength(newPwd.value);
        if (!newPwd.value || metCount < 5 || score < 40) {
            newPwd.classList.add('cp-input-invalid');
            hasError = true;
        } else {
            newPwd.classList.remove('cp-input-invalid');
        }

        if (!checkSameAsOld()) {
            hasError = true;
        }

        var matches = checkMatch();
        if (!confirmPwd.value || !matches) {
            confirmPwd.classList.add('cp-input-invalid');
            if (confirmError) confirmError.classList.add('show');
            hasError = true;
        }

        if (hasError) {
            showError('Please fix the highlighted fields before continuing.');
            return;
        }

        /* Demo-only success flow: this page is UI/UX only and does not
           call a server endpoint or change any real password. */
        submitBtn.disabled = true;
        var originalHtml = submitBtn.innerHTML;
        submitBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Updating...';

        setTimeout(function () {
            submitBtn.disabled = false;
            submitBtn.innerHTML = originalHtml;
            showSuccess();
            form.reset();
            [currentPwd, newPwd, confirmPwd].forEach(function (el) {
                el.classList.remove('cp-input-invalid', 'cp-input-valid');
                el.type = 'password';
            });
            document.querySelectorAll('.cp-toggle-eye i').forEach(function (icon) {
                icon.className = 'fa-solid fa-eye';
            });
            if (confirmSuccess) confirmSuccess.classList.remove('show');
            if (sameAsOldError) sameAsOldError.classList.remove('show');
            updateStrength('');
        }, 900);
    });
})();

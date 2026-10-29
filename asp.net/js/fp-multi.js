document.addEventListener('DOMContentLoaded', () => {

    // ----------------------------------------------------
    // OTP Input Boxes Auto-advance & Backspace handling
    // ----------------------------------------------------
    const otpBoxes = document.querySelectorAll('.otp-box');
    if (otpBoxes.length > 0) {
        otpBoxes.forEach((box, i) => {
            box.addEventListener('input', (e) => {
                if (e.target.value.length >= 1 && i < otpBoxes.length - 1) {
                    otpBoxes[i + 1].focus();
                }
            });
            box.addEventListener('keydown', (e) => {
                if (e.key === 'Backspace' && e.target.value === '' && i > 0) {
                    otpBoxes[i - 1].focus();
                }
            });
            // Auto-paste entire 6-digit OTP
            box.addEventListener('paste', (e) => {
                e.preventDefault();
                const pasteData = (e.clipboardData || window.clipboardData).getData('text').trim();
                if (pasteData.length === otpBoxes.length) {
                    otpBoxes.forEach((b, idx) => {
                        b.value = pasteData[idx] || '';
                    });
                    otpBoxes[otpBoxes.length - 1].focus();
                }
            });
        });

        // Click demo OTP to auto-fill
        const demoHint = document.getElementById('demoOtpHint');
        const demoVal = document.getElementById('demoOtpValue');
        if (demoHint && demoVal) {
            demoHint.style.cursor = 'pointer';
            demoHint.setAttribute('title', 'Click to auto-fill OTP');
            demoHint.addEventListener('click', () => {
                const otp = demoVal.textContent.trim();
                if (otp.length === 6) {
                    otpBoxes.forEach((b, idx) => {
                        b.value = otp[idx] || '';
                    });
                    otpBoxes[otpBoxes.length - 1].focus();
                }
            });
        }
    }

    // ----------------------------------------------------
    // Resend OTP Countdown Timer
    // ----------------------------------------------------
    const timerText = document.getElementById('otpTimerText');
    const timerSeconds = document.getElementById('otpTimerSeconds');
    const resendLink = document.getElementById('otpResendLink');

    if (timerText && resendLink) {
        let timeLeft = 30;
        const timerInterval = setInterval(() => {
            timeLeft--;
            if (timerSeconds) timerSeconds.textContent = timeLeft;
            if (timeLeft <= 0) {
                clearInterval(timerInterval);
                timerText.style.display = 'none';
                resendLink.style.display = 'inline';
            }
        }, 1000);
    }

    // ----------------------------------------------------
    // Password Visibility Eye Toggle
    // ----------------------------------------------------
    const toggleIcons = document.querySelectorAll('.toggle-password');
    toggleIcons.forEach(icon => {
        icon.addEventListener('click', function() {
            const targetId = this.getAttribute('data-target');
            if (targetId) {
                const input = document.getElementById(targetId);
                if (input && input.type === 'password') {
                    input.type = 'text';
                    this.classList.replace('fa-eye', 'fa-eye-slash');
                } else if (input) {
                    input.type = 'password';
                    this.classList.replace('fa-eye-slash', 'fa-eye');
                }
            }
        });
    });

});

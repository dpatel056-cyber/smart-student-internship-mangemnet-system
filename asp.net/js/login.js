document.addEventListener('DOMContentLoaded', () => {
    let currentRole = 'student';

    const roleTabs = document.querySelectorAll('.role-tab');
    const emailInput = document.getElementById('txtemail');
    const passwordInput = document.getElementById('txtpassword');
    const loginForm = document.getElementById('loginForm');

    // Tab switching
    roleTabs.forEach(tab => {
        tab.addEventListener('click', () => {
            roleTabs.forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            currentRole = tab.dataset.role;

            // Sync selected role into hidden field for server-side postback
            const hfRole = document.getElementById('hfSelectedRole');
            if (hfRole) hfRole.value = currentRole;

            const emailLabel = document.querySelector('label[for="email"]');
            if (emailLabel && emailInput) {
                if (currentRole === 'student') {
                    emailLabel.textContent = 'Email / Enrollment Number';
                    emailInput.placeholder = 'Enter your email or enrollment number';
                } else if (currentRole === 'company') {
                    emailLabel.textContent = 'Company Email / Registration ID';
                    emailInput.placeholder = 'Enter company email or registration ID';
                } else {
                    emailLabel.textContent = 'Admin Email';
                    emailInput.placeholder = 'Enter admin email';
                }
            }

        });
    });

    // Password show/hide toggle on the login form
    const togglePassword = document.getElementById('togglePassword');
    if (togglePassword && passwordInput) {
        togglePassword.addEventListener('click', () => {
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                togglePassword.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                togglePassword.classList.replace('fa-eye-slash', 'fa-eye');
            }
        });
    }

    // ==========================================
    // Forgot Password Flow
    // ==========================================
    const fpLink = document.getElementById('forgotPasswordLink');
    const fpOverlay = document.getElementById('fpModalOverlay');
    const fpClose = document.getElementById('fpCloseBtn');

    if (fpOverlay) {
        const steps = [
            document.getElementById('fpStep1'),
            document.getElementById('fpStep2'),
            document.getElementById('fpStep3'),
            document.getElementById('fpStepSuccess')
        ];

        const stepIndicators = document.querySelectorAll('.fp-step');

        function showStep(index) {
            steps.forEach((step, i) => {
                if (step) {
                    if (i === index) step.classList.add('active');
                    else step.classList.remove('active');
                }
            });

            stepIndicators.forEach((indicator, i) => {
                if (i <= index) indicator.classList.add('active');
                else indicator.classList.remove('active');
            });
        }

        if (fpLink) {
            fpLink.addEventListener('click', (e) => {
                // Let it navigate to forgot_password.aspx
            });
        }

        if (fpClose) {
            fpClose.addEventListener('click', () => {
                fpOverlay.classList.remove('active');
                if (window.location.pathname.toLowerCase().includes('forgot_password.aspx')) {
                    window.location.href = 'login.aspx';
                }
            });
        }

        // Auto-show modal if we are on forgot_password.aspx
        if (window.location.pathname.toLowerCase().includes('forgot_password.aspx')) {
            fpOverlay.classList.add('active');
            showStep(0);
        }

        // Step 1: Send OTP
        const fpSendOtpBtn = document.getElementById('fpSendOtpBtn');
        const fpEmail = document.getElementById('fpEmail');
        const fpEmailError = document.getElementById('fpEmailError');
        let resettingUser = null;

        if (fpSendOtpBtn) {
            fpSendOtpBtn.addEventListener('click', (e) => {
                e.preventDefault();
                const val = fpEmail.value.trim();

                if (!val) {
                    fpEmailError.style.display = 'block';
                    return;
                }

                fpEmailError.style.display = 'none';
                fpSendOtpBtn.classList.add('disabled');
                const originalHtml = fpSendOtpBtn.innerHTML;
                fpSendOtpBtn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Sending...';

                // Call SendOTP.ashx backend
                const formData = new URLSearchParams();
                formData.append('email', val);

                fetch('SendOTP.ashx', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: formData
                })
                    .then(response => response.json())
                    .then(data => {
                        fpSendOtpBtn.classList.remove('disabled');
                        fpSendOtpBtn.innerHTML = originalHtml;

                        if (data.success) {
                            resettingUser = { email: val };
                            const emailParts = val.split('@');
                            let masked = emailParts[0];
                            if (masked.length > 3) {
                                masked = masked.substring(0, 3) + '***';
                            }
                            const domain = emailParts.length > 1 ? '@' + emailParts[1] : '';
                            document.getElementById('fpMaskedTarget').textContent = masked + domain;

                            showStep(1);
                            startOtpTimer();

                            if (data.dummyOtp && window.simsShowToast) {
                                window.simsShowToast('Dummy OTP generated: ' + data.dummyOtp, 'info');
                            }
                        } else {
                            fpEmailError.textContent = data.message || 'Email/Enrollment not found.';
                            fpEmailError.style.display = 'block';
                        }
                    })
                    .catch(err => {
                        console.error('OTP Send Error:', err);
                        fpSendOtpBtn.classList.remove('disabled');
                        fpSendOtpBtn.innerHTML = originalHtml;
                        fpEmailError.textContent = 'Something went wrong. Please try again.';
                        fpEmailError.style.display = 'block';
                    });
            });
        }

        // Step 2: Verify OTP
        const otpBoxes = document.querySelectorAll('.otp-box');
        otpBoxes.forEach((box, i) => {
            box.addEventListener('input', (e) => {
                if (e.target.value.length === 1 && i < otpBoxes.length - 1) {
                    otpBoxes[i + 1].focus();
                }
            });
            box.addEventListener('keydown', (e) => {
                if (e.key === 'Backspace' && e.target.value === '' && i > 0) {
                    otpBoxes[i - 1].focus();
                }
            });
        });

        let timerInterval;
        function startOtpTimer() {
            let timeLeft = 30;
            const timerText = document.getElementById('otpTimerText');
            const timerSeconds = document.getElementById('otpTimerSeconds');
            const resendLink = document.getElementById('otpResendLink');

            timerText.style.display = 'inline';
            resendLink.style.display = 'none';

            clearInterval(timerInterval);
            timerInterval = setInterval(() => {
                timeLeft--;
                if (timerSeconds) timerSeconds.textContent = timeLeft;
                if (timeLeft <= 0) {
                    clearInterval(timerInterval);
                    timerText.style.display = 'none';
                    resendLink.style.display = 'inline';
                }
            }, 1000);
        }

        const resendLink = document.getElementById('otpResendLink');
        if (resendLink) {
            resendLink.addEventListener('click', (e) => {
                e.preventDefault();
                if (window.simsShowToast) window.simsShowToast('OTP Resent!', 'success');
                startOtpTimer();
            });
        }

        const fpVerifyOtpBtn = document.getElementById('fpVerifyOtpBtn');
        const otpError = document.getElementById('otpError');
        const fpBackToStep1Btn = document.getElementById('fpBackToStep1Btn');

        if (fpVerifyOtpBtn) {
            fpVerifyOtpBtn.addEventListener('click', (e) => {
                e.preventDefault();
                let otpEntered = '';
                otpBoxes.forEach(b => otpEntered += b.value);

                if (otpEntered.length !== 6) {
                    otpError.textContent = 'Please enter all 6 digits.';
                    otpError.style.display = 'block';
                    return;
                }

                otpError.style.display = 'none';
                fpVerifyOtpBtn.classList.add('disabled');
                const originalHtml = fpVerifyOtpBtn.innerHTML;
                fpVerifyOtpBtn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Verifying...';

                const formData = new URLSearchParams();
                formData.append('otp', otpEntered);

                fetch('VerifyOTP.ashx', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: formData
                })
                    .then(response => response.json())
                    .then(data => {
                        fpVerifyOtpBtn.classList.remove('disabled');
                        fpVerifyOtpBtn.innerHTML = originalHtml;

                        if (data.success) {
                            showStep(2);
                        } else {
                            otpError.textContent = data.message || 'Invalid OTP.';
                            otpError.style.display = 'block';
                        }
                    })
                    .catch(err => {
                        console.error('OTP Verify Error:', err);
                        fpVerifyOtpBtn.classList.remove('disabled');
                        fpVerifyOtpBtn.innerHTML = originalHtml;
                        otpError.textContent = 'Something went wrong. Please try again.';
                        otpError.style.display = 'block';
                    });
            });
        }

        if (fpBackToStep1Btn) {
            fpBackToStep1Btn.addEventListener('click', (e) => {
                e.preventDefault();
                showStep(0);
            });
        }

        // Step 3: Reset Password
        const fpResetPasswordBtn = document.getElementById('fpResetPasswordBtn');
        const fpNewPassword = document.getElementById('fpNewPassword');
        const fpConfirmPassword = document.getElementById('fpConfirmPassword');
        const fpNewPasswordError = document.getElementById('fpNewPasswordError');
        const fpConfirmPasswordError = document.getElementById('fpConfirmPasswordError');

        if (fpResetPasswordBtn) {
            fpResetPasswordBtn.addEventListener('click', (e) => {
                e.preventDefault();

                let valid = true;
                if (fpNewPassword.value.length < 6) {
                    fpNewPasswordError.style.display = 'block';
                    valid = false;
                } else {
                    fpNewPasswordError.style.display = 'none';
                }

                if (fpNewPassword.value !== fpConfirmPassword.value) {
                    fpConfirmPasswordError.style.display = 'block';
                    valid = false;
                } else {
                    fpConfirmPasswordError.style.display = 'none';
                }

                if (!valid) return;

                fpResetPasswordBtn.classList.add('disabled');
                const originalHtml = fpResetPasswordBtn.innerHTML;
                fpResetPasswordBtn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Resetting...';

                const formData = new URLSearchParams();
                formData.append('email', resettingUser ? resettingUser.email : '');
                formData.append('newPassword', fpNewPassword.value);

                fetch('ResetPassword.ashx', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: formData
                })
                    .then(response => response.json())
                    .then(data => {
                        fpResetPasswordBtn.classList.remove('disabled');
                        fpResetPasswordBtn.innerHTML = originalHtml;
                        showStep(3);
                    })
                    .catch(err => {
                        console.error('Reset Password Error:', err);
                        fpResetPasswordBtn.classList.remove('disabled');
                        fpResetPasswordBtn.innerHTML = originalHtml;
                        showStep(3);
                    });
            });
        }

        // Step 4: Success
        const fpBackToLoginBtn = document.getElementById('fpBackToLoginBtn');
        if (fpBackToLoginBtn) {
            fpBackToLoginBtn.addEventListener('click', (e) => {
                e.preventDefault();
                fpOverlay.classList.remove('active');
                // Autofill email for convenience
                if (resettingUser && emailInput) {
                    emailInput.value = resettingUser.email;
                }
                if (window.location.pathname.toLowerCase().includes('forgot_password.aspx')) {
                    window.location.href = 'login.aspx';
                }
            });
        }

        // Setup password toggles for modal
        const toggleIcons = document.querySelectorAll('.fp-panel .toggle-password');
        toggleIcons.forEach(icon => {
            icon.addEventListener('click', function () {
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
    }
});

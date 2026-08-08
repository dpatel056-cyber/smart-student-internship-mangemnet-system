document.addEventListener('DOMContentLoaded', () => {
    
    // Helper to get URL params
    function getQueryParam(param) {
        const urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }
    
    // ----------------------------------------------------
    // STEP 1: FORGOT PASSWORD PAGE (Email Input)
    // ----------------------------------------------------
    const fpSendOtpBtn = document.getElementById('fpSendOtpBtn');
    if (fpSendOtpBtn) {
        const fpEmail = document.getElementById('fpEmail');
        const fpEmailError = document.getElementById('fpEmailError');
        
        fpSendOtpBtn.addEventListener('click', (e) => {
            e.preventDefault();
            const val = fpEmail.value.trim();
            const users = window.GlobalStore ? window.GlobalStore.getUsers() : [];
            
            const resettingUser = users.find(u => u.email === val || u.enrollment === val);
            
            if (!resettingUser && val !== 'test@sims.com') { // Allow 'test' for demo
              fpEmailError.style.display = 'block';
              return;
            }
            
            fpEmailError.style.display = 'none';
            fpSendOtpBtn.classList.add('disabled');
            const originalHtml = fpSendOtpBtn.innerHTML;
            fpSendOtpBtn.innerHTML = '<i class="fa-solid fa-circle-notch fa-spin"></i> Sending...';
            
            const actualEmail = resettingUser ? resettingUser.email : val;
            
            // Try backend SendOTP
            const formData = new URLSearchParams();
            formData.append('email', actualEmail);

            fetch('SendOTP.ashx', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    if(data.dummyOtp) sessionStorage.setItem('sims_dummy_otp', data.dummyOtp);
                    window.location.href = 'verify_otp.aspx?email=' + encodeURIComponent(actualEmail);
                } else {
                    fallbackSimulateSendOtp(actualEmail);
                }
            })
            .catch(err => {
                fallbackSimulateSendOtp(actualEmail);
            });

            function fallbackSimulateSendOtp(email) {
                sessionStorage.setItem('sims_dummy_otp', '123456');
                setTimeout(() => {
                    window.location.href = 'verify_otp.aspx?email=' + encodeURIComponent(email);
                }, 800);
            }
        });
    }

    // ----------------------------------------------------
    // STEP 2: VERIFY OTP PAGE
    // ----------------------------------------------------
    const fpVerifyOtpBtn = document.getElementById('fpVerifyOtpBtn');
    if (fpVerifyOtpBtn) {
        const currentEmail = getQueryParam('email') || 'your email';
        const maskedTarget = document.getElementById('fpMaskedTarget');
        if (maskedTarget) {
            const emailParts = currentEmail.split('@');
            let masked = emailParts[0];
            if (masked.length > 3) masked = masked.substring(0, 3) + '***';
            const domain = emailParts.length > 1 ? '@' + emailParts[1] : '';
            maskedTarget.textContent = masked + domain;
        }

        // Show OTP on screen if simulated
        const dummyOtp = sessionStorage.getItem('sims_dummy_otp');
        if (dummyOtp) {
            const demoHint = document.getElementById('demoOtpHint');
            const demoVal = document.getElementById('demoOtpValue');
            if (demoHint && demoVal) {
                demoVal.textContent = dummyOtp;
                demoHint.style.display = 'block';
            }
        }

        // OTP Input Logic
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

        // Timer Logic
        let timerInterval;
        let timeLeft = 30;
        const timerText = document.getElementById('otpTimerText');
        const timerSeconds = document.getElementById('otpTimerSeconds');
        const resendLink = document.getElementById('otpResendLink');
        
        if (timerText && resendLink) {
            timerInterval = setInterval(() => {
              timeLeft--;
              if (timerSeconds) timerSeconds.textContent = timeLeft;
              if (timeLeft <= 0) {
                clearInterval(timerInterval);
                timerText.style.display = 'none';
                resendLink.style.display = 'inline';
              }
            }, 1000);
            
            resendLink.addEventListener('click', (e) => {
                e.preventDefault();
                if(window.simsShowToast) window.simsShowToast('OTP Resent!', 'success');
                timeLeft = 30;
                resendLink.style.display = 'none';
                timerText.style.display = 'inline';
                if (timerSeconds) timerSeconds.textContent = timeLeft;
            });
        }

        const otpError = document.getElementById('otpError');
        
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
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    window.location.href = 'reset_password.aspx?email=' + encodeURIComponent(currentEmail);
                } else {
                    fallbackSimulateVerifyOtp(otpEntered, originalHtml);
                }
            })
            .catch(err => {
                fallbackSimulateVerifyOtp(otpEntered, originalHtml);
            });

            function fallbackSimulateVerifyOtp(val, html) {
                const expected = sessionStorage.getItem('sims_dummy_otp') || '123456';
                if (val === expected) {
                    setTimeout(() => {
                        window.location.href = 'reset_password.aspx?email=' + encodeURIComponent(currentEmail);
                    }, 500);
                } else {
                    fpVerifyOtpBtn.classList.remove('disabled');
                    fpVerifyOtpBtn.innerHTML = html;
                    otpError.textContent = 'Invalid OTP. Please try again.';
                    otpError.style.display = 'block';
                }
            }
        });
    }

    // ----------------------------------------------------
    // STEP 3: RESET PASSWORD PAGE
    // ----------------------------------------------------
    const fpResetPasswordBtn = document.getElementById('fpResetPasswordBtn');
    if (fpResetPasswordBtn) {
        const currentEmail = getQueryParam('email');
        const fpNewPassword = document.getElementById('fpNewPassword');
        const fpConfirmPassword = document.getElementById('fpConfirmPassword');
        const fpNewPasswordError = document.getElementById('fpNewPasswordError');
        const fpConfirmPasswordError = document.getElementById('fpConfirmPasswordError');
        
        // Setup password toggles
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
            
            setTimeout(() => {
                // Update password in global store if we have the email
                if (currentEmail && window.GlobalStore) {
                    const users = window.GlobalStore.getUsers();
                    const userIndex = users.findIndex(u => u.email === currentEmail || u.enrollment === currentEmail);
                    if (userIndex !== -1) {
                        users[userIndex].password = fpNewPassword.value;
                        window.GlobalStore.saveUsers(users);
                    }
                }
                
                // Show success screen on the same page
                document.getElementById('fpStep3').style.display = 'none';
                document.getElementById('fpStepSuccess').style.display = 'block';
                
                // Update step indicators
                const indicators = document.querySelectorAll('.fp-step-circle');
                if(indicators.length >= 3) {
                    indicators[2].innerHTML = '<i class="fa-solid fa-check"></i>';
                }
                
            }, 1000);
        });
    }

});

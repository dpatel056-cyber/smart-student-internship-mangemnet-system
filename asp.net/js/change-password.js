document.addEventListener('DOMContentLoaded', () => {

  // Toggle Password Visibility
  const toggleBtns = document.querySelectorAll('.toggle-pwd');
  toggleBtns.forEach(btn => {
    btn.addEventListener('click', () => {
      const targetId = btn.getAttribute('data-target');
      const input = document.getElementById(targetId);
      const icon = btn.querySelector('i');
      
      if (input.type === 'password') {
        input.type = 'text';
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
      } else {
        input.type = 'password';
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
      }
    });
  });

  // Password Strength Indicator
  const newPwdInput = document.getElementById('newPwd');
  const fillBar = document.getElementById('pwStrengthFill');
  const textLabel = document.getElementById('pwStrengthText');

  newPwdInput.addEventListener('input', () => {
    const val = newPwdInput.value;
    let score = 0;
    
    if (val.length > 5) score++;
    if (val.length >= 8) score++;
    if (/[A-Z]/.test(val)) score++;
    if (/[0-9]/.test(val)) score++;
    if (/[^A-Za-z0-9]/.test(val)) score++;

    // Reset classes
    fillBar.className = 'pw-strength-fill';
    textLabel.className = 'pw-text';

    if (val.length === 0) {
      fillBar.style.width = '0%';
      textLabel.textContent = 'Weak';
      textLabel.classList.add('pw-weak');
    } else if (score <= 2) {
      fillBar.style.width = '25%';
      fillBar.classList.add('pw-weak');
      textLabel.textContent = 'Weak';
      textLabel.classList.add('pw-weak');
    } else if (score === 3) {
      fillBar.style.width = '50%';
      fillBar.classList.add('pw-fair');
      textLabel.textContent = 'Fair';
      textLabel.classList.add('pw-fair');
    } else if (score === 4) {
      fillBar.style.width = '75%';
      fillBar.classList.add('pw-good');
      textLabel.textContent = 'Good';
      textLabel.classList.add('pw-good');
    } else {
      fillBar.style.width = '100%';
      fillBar.classList.add('pw-strong');
      textLabel.textContent = 'Strong';
      textLabel.classList.add('pw-strong');
    }
  });

  // Form Validation and Submission
  const pwdForm = document.getElementById('pwdForm');
  const confirmPwdInput = document.getElementById('confirmPwd');
  
  pwdForm.addEventListener('submit', (e) => {
    e.preventDefault();
    e.stopPropagation();

    let isValid = true;
    
    // Check required
    if (!document.getElementById('currentPwd').value) {
      document.getElementById('currentPwd').classList.add('is-invalid');
      isValid = false;
    } else {
      document.getElementById('currentPwd').classList.remove('is-invalid');
    }

    let session = {};
    try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (err) {}
    const currentUser = window.GlobalStore?.getUsers().find(user => user.email === session.email);
    if (currentUser && currentUser.password !== document.getElementById('currentPwd').value) {
      document.getElementById('currentPwd').classList.add('is-invalid');
      isValid = false;
    }

    if (newPwdInput.value.length < 8) {
      newPwdInput.classList.add('is-invalid');
      isValid = false;
    } else {
      newPwdInput.classList.remove('is-invalid');
    }

    if (newPwdInput.value !== confirmPwdInput.value) {
      confirmPwdInput.classList.add('is-invalid');
      isValid = false;
    } else {
      confirmPwdInput.classList.remove('is-invalid');
    }

    if (isValid) {
      if (session.email) window.GlobalStore?.updateUser(session.email, { password: newPwdInput.value });
      // Show Bootstrap Modal
      const successModal = new bootstrap.Modal(document.getElementById('successModal'));
      successModal.show();
      pwdForm.reset();
      fillBar.style.width = '0%';
      textLabel.textContent = 'Weak';
      textLabel.className = 'pw-text pw-weak';
    }
  });

  // Clear validation on input
  document.querySelectorAll('.form-control').forEach(input => {
    input.addEventListener('input', () => {
      input.classList.remove('is-invalid');
    });
  });

});

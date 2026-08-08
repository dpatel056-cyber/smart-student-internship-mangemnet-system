document.addEventListener('DOMContentLoaded', () => {
    let currentRole = 'student';

    const roleTabs = document.querySelectorAll('.role-tab');
    const roleFieldGroups = document.querySelectorAll('.role-fields');
    const toast = document.getElementById('loginToast');
    const toastMsg = document.getElementById('loginToastMsg');
    const hfRole = document.getElementById('hfSelectedRole');
    let toastTimer = null;

    /* =========================================================
       Role tab switching — show only the fields relevant to
       the selected role, and sync hidden field for ASP.NET server postback
    ========================================================= */
    function setRole(role) {
        currentRole = role;

        if (hfRole) hfRole.value = role;

        roleTabs.forEach(tab => {
            tab.classList.toggle('active', tab.dataset.role === role);
        });

        roleFieldGroups.forEach(group => {
            const isActive = group.dataset.roleFields === role;
            group.classList.toggle('active', isActive);
            group.querySelectorAll('input, select').forEach(el => {
                el.disabled = !isActive;
            });
        });
    }

    roleTabs.forEach(tab => {
        tab.addEventListener('click', () => setRole(tab.dataset.role));
    });

    // Initialise
    setRole(currentRole);

    /* =========================================================
       Show / hide password
    ========================================================= */
    document.querySelectorAll('.toggle-password').forEach(icon => {
        icon.addEventListener('click', () => {
            const targetId = icon.dataset.target;
            const input = document.getElementById(targetId);
            if (!input) return;

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

    /* =========================================================
       Toast
    ========================================================= */
    function showToast(msg, type) {
        if (!toast || !toastMsg) return;

        toast.classList.remove('success', 'error');
        toast.classList.add(type);
        toastMsg.innerHTML = msg;

        toast.classList.add('show');
        clearTimeout(toastTimer);
        toastTimer = setTimeout(() => {
            toast.classList.remove('show');
        }, 3000);
    }

    /* =========================================================
       Social buttons
    ========================================================= */
    const googleBtn = document.getElementById('googleBtn');
    if (googleBtn) {
        googleBtn.addEventListener('click', (e) => {
            e.preventDefault();
            showToast('Google Sign Up Coming Soon', 'error');
        });
    }

    const linkedinBtn = document.getElementById('linkedinBtn');
    if (linkedinBtn) {
        linkedinBtn.addEventListener('click', (e) => {
            e.preventDefault();
            showToast('LinkedIn Sign Up Coming Soon', 'error');
        });
    }
});
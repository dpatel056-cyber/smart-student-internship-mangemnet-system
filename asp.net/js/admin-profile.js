/* ==========================================================================
   SIMS ADMIN PROFILE PAGE — FRONTEND / DEMO JAVASCRIPT
   No backend calls. All state is client-side for demo purposes only.
   ========================================================================== */
(function () {
    'use strict';

    var hasUnsavedChanges = false;

    document.addEventListener('DOMContentLoaded', function () {
        initEditProfile();
        initPasswordSection();
        initPhotoModal();
        initSignOutModal();
        initDeactivateModal();
        init2faModal();
        initPreferences();
        initGlobalModalBehavior();
    });

    /* ---------------------------------------------------------------
       TOASTS
    --------------------------------------------------------------- */
    function showToast(message) {
        var container = document.getElementById('toastContainer');
        if (!container) return;

        var toast = document.createElement('div');
        toast.className = 'sims-profile-toast';
        toast.innerHTML =
            '<i class="fa-solid fa-circle-check sims-profile-toast-icon"></i>' +
            '<span>' + message + '</span>' +
            '<button type="button" class="sims-profile-toast-close" aria-label="Close">' +
            '<i class="fa-solid fa-xmark"></i></button>';

        container.appendChild(toast);

        toast.querySelector('.sims-profile-toast-close').addEventListener('click', function () {
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
       EDIT PROFILE (view <-> edit toggle)
    --------------------------------------------------------------- */
    function initEditProfile() {
        var viewMode = document.getElementById('personalViewMode');
        var editMode = document.getElementById('personalEditMode');
        var btnEdit = document.getElementById('btnEditProfile');
        var btnEditTop = document.getElementById('btnEditProfileTop');
        var btnSave = document.getElementById('btnSaveProfile');
        var btnCancel = document.getElementById('btnCancelProfile');

        function enterEditMode() {
            viewMode.style.display = 'none';
            editMode.style.display = 'block';
            editMode.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }

        function exitEditMode() {
            viewMode.style.display = 'block';
            editMode.style.display = 'none';
        }

        if (btnEdit) btnEdit.addEventListener('click', enterEditMode);
        if (btnEditTop) btnEditTop.addEventListener('click', enterEditMode);

        // Hero Edit Profile button
        var btnEditHero = document.getElementById('btnEditProfileHero');
        if (btnEditHero) btnEditHero.addEventListener('click', function () {
            var personalCard = document.getElementById('personalInfoCard');
            if (personalCard) personalCard.scrollIntoView({ behavior: 'smooth', block: 'start' });
            enterEditMode();
        });

        // Track unsaved changes
        if (editMode) {
            editMode.addEventListener('input', function () { hasUnsavedChanges = true; });
        }

        if (btnCancel) {
            btnCancel.addEventListener('click', function () {
                if (hasUnsavedChanges && !confirm('You have unsaved changes. Discard them?')) {
                    return;
                }
                hasUnsavedChanges = false;
                exitEditMode();
            });
        }

        if (btnSave) {
            btnSave.addEventListener('click', function () {
                if (!validateProfileForm()) return;

                // Demo only: reflect edited values into the view mode
                syncViewFromForm();
                hasUnsavedChanges = false;
                exitEditMode();
                showToast('Profile updated successfully.');
            });
        }
    }

    function validateProfileForm() {
        var valid = true;
        valid = validateRequired('fldFirstName', 'valFirstName', 'First name is required.') && valid;
        valid = validateRequired('fldLastName', 'valLastName', 'Last name is required.') && valid;
        valid = validateRequired('fldUsername', 'valUsername', 'Username is required.') && valid;
        valid = validateEmail('fldEmail', 'valEmail') && valid;
        valid = validatePhone('fldPhone', 'valPhone') && valid;
        return valid;
    }

    function validateRequired(fieldId, errorId, message) {
        var field = document.getElementById(fieldId);
        var error = document.getElementById(errorId);
        if (!field) return true;
        if (!field.value.trim()) {
            setFieldError(field, error, message);
            return false;
        }
        clearFieldError(field, error);
        return true;
    }

    function validateEmail(fieldId, errorId) {
        var field = document.getElementById(fieldId);
        var error = document.getElementById(errorId);
        if (!field) return true;
        var pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!field.value.trim()) {
            setFieldError(field, error, 'Email address is required.');
            return false;
        }
        if (!pattern.test(field.value.trim())) {
            setFieldError(field, error, 'Enter a valid email address.');
            return false;
        }
        clearFieldError(field, error);
        return true;
    }

    function validatePhone(fieldId, errorId) {
        var field = document.getElementById(fieldId);
        var error = document.getElementById(errorId);
        if (!field) return true;
        if (!field.value.trim()) { clearFieldError(field, error); return true; }
        var pattern = /^[+]?[\d\s-]{7,15}$/;
        if (!pattern.test(field.value.trim())) {
            setFieldError(field, error, 'Enter a valid phone number.');
            return false;
        }
        clearFieldError(field, error);
        return true;
    }

    function setFieldError(field, errorEl, message) {
        field.classList.add('sims-profile-input-error');
        if (errorEl) errorEl.textContent = message;
    }

    function clearFieldError(field, errorEl) {
        field.classList.remove('sims-profile-input-error');
        if (errorEl) errorEl.textContent = '';
    }

    function syncViewFromForm() {
        var map = {
            fldFirstName: null, fldLastName: null // combined into full name below
        };
        var firstName = getVal('fldFirstName');
        var lastName = getVal('fldLastName');
        var fullName = (firstName + ' ' + lastName).trim();

        setInfoValue(0, fullName);
        setInfoValue(1, getVal('fldUsername'));
        setInfoValue(2, getVal('fldEmail'));
        setInfoValue(3, getVal('fldPhone'));
        setInfoValue(4, getVal('fldDob'));
        setInfoValue(5, getVal('fldGender'));
        setInfoValue(6, getVal('fldDepartment'));
        setInfoValue(7, getVal('fldDesignation'));
        setInfoValue(8, getVal('fldBio'));

        var heroName = document.querySelector('.sims-profile-name');
        if (heroName && fullName) heroName.textContent = fullName;
    }

    function getVal(id) {
        var el = document.getElementById(id);
        return el ? el.value : '';
    }

    function setInfoValue(index, value) {
        var items = document.querySelectorAll('#personalViewMode .sims-profile-info-value');
        if (items[index] && value) items[index].textContent = value;
    }

    /* ---------------------------------------------------------------
       CHANGE PASSWORD
    --------------------------------------------------------------- */
    function initPasswordSection() {
        // Show/hide password toggles
        var toggles = document.querySelectorAll('.sims-profile-password-toggle');
        toggles.forEach(function (btn) {
            btn.addEventListener('click', function () {
                var targetId = btn.getAttribute('data-target');
                var input = document.getElementById(targetId);
                if (!input) return;
                var icon = btn.querySelector('i');
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

        var newPasswordField = document.getElementById('fldNewPassword');
        if (newPasswordField) {
            newPasswordField.addEventListener('input', function () {
                updatePasswordStrength(newPasswordField.value);
            });
        }

        var btnUpdate = document.getElementById('btnUpdatePassword');
        var btnCancel = document.getElementById('btnCancelPassword');

        if (btnUpdate) {
            btnUpdate.addEventListener('click', function () {
                if (!validatePasswordForm()) return;
                clearPasswordFields();
                showToast('Password changed successfully.');
            });
        }

        if (btnCancel) {
            btnCancel.addEventListener('click', clearPasswordFields);
        }
    }

    function updatePasswordStrength(value) {
        var fill = document.getElementById('strengthBarFill');
        var label = document.getElementById('strengthLabel');
        var requirements = document.querySelectorAll('#pwdRequirements li');

        var rules = {
            len: value.length >= 8,
            upper: /[A-Z]/.test(value),
            lower: /[a-z]/.test(value),
            num: /[0-9]/.test(value),
            special: /[^A-Za-z0-9]/.test(value)
        };

        requirements.forEach(function (li) {
            var rule = li.getAttribute('data-rule');
            if (rules[rule]) {
                li.classList.add('sims-profile-req-met');
            } else {
                li.classList.remove('sims-profile-req-met');
            }
        });

        var score = Object.keys(rules).filter(function (k) { return rules[k]; }).length;
        var pct = (score / 5) * 100;
        var color = '#DC2626';
        var text = 'Weak';

        if (value.length === 0) {
            pct = 0; text = 'Password strength'; color = '#E5E7EB';
        } else if (score <= 2) {
            text = 'Weak'; color = '#DC2626';
        } else if (score === 3) {
            text = 'Medium'; color = '#D97706';
        } else if (score === 4) {
            text = 'Strong'; color = '#2563EB';
        } else if (score === 5) {
            text = 'Very Strong'; color = '#16A34A';
        }

        if (fill) { fill.style.width = pct + '%'; fill.style.background = color; }
        if (label) { label.textContent = text; label.style.color = color; }
    }

    function validatePasswordForm() {
        var valid = true;
        var current = document.getElementById('fldCurrentPassword');
        var next = document.getElementById('fldNewPassword');
        var confirm = document.getElementById('fldConfirmPassword');
        var errCurrent = document.getElementById('valCurrentPassword');
        var errConfirm = document.getElementById('valConfirmPassword');

        if (!current.value) {
            setFieldError(current, errCurrent, 'Current password is required.');
            valid = false;
        } else {
            clearFieldError(current, errCurrent);
        }

        var strongEnough = next.value.length >= 8 &&
            /[A-Z]/.test(next.value) && /[a-z]/.test(next.value) &&
            /[0-9]/.test(next.value) && /[^A-Za-z0-9]/.test(next.value);

        if (!strongEnough) {
            valid = false;
        }

        if (!confirm.value || confirm.value !== next.value) {
            setFieldError(confirm, errConfirm, 'Passwords do not match.');
            valid = false;
        } else {
            clearFieldError(confirm, errConfirm);
        }

        return valid;
    }

    function clearPasswordFields() {
        ['fldCurrentPassword', 'fldNewPassword', 'fldConfirmPassword'].forEach(function (id) {
            var el = document.getElementById(id);
            if (el) el.value = '';
        });
        updatePasswordStrength('');
    }

    /* ---------------------------------------------------------------
       PROFILE PHOTO MODAL
    --------------------------------------------------------------- */
    function initPhotoModal() {
        var btnOpen = document.getElementById('btnChangePhoto');
        var fileInput = document.getElementById('fldPhotoInput');
        var btnBrowse = document.getElementById('btnBrowseFile');
        var dropZone = document.getElementById('uploadDropZone');
        var newPreviewWrap = document.getElementById('photoNewPreviewWrap');
        var newPreviewImg = document.getElementById('photoNewPreview');
        var btnRemoveNew = document.getElementById('btnRemoveNewPhoto');
        var btnSave = document.getElementById('btnSavePhoto');
        var valPhoto = document.getElementById('valPhotoUpload');

        var selectedFile = null;
        var maxSizeBytes = 2 * 1024 * 1024;
        var allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];

        if (btnOpen) {
            btnOpen.addEventListener('click', function () {
                openModal('modalPhotoOverlay');
            });
        }

        if (btnBrowse && fileInput) {
            btnBrowse.addEventListener('click', function () { fileInput.click(); });
        }

        if (fileInput) {
            fileInput.addEventListener('change', function (e) {
                handleFile(e.target.files && e.target.files[0]);
            });
        }

        if (dropZone) {
            ['dragenter', 'dragover'].forEach(function (evt) {
                dropZone.addEventListener(evt, function (e) {
                    e.preventDefault();
                    dropZone.classList.add('sims-profile-drag-over');
                });
            });
            ['dragleave', 'drop'].forEach(function (evt) {
                dropZone.addEventListener(evt, function (e) {
                    e.preventDefault();
                    dropZone.classList.remove('sims-profile-drag-over');
                });
            });
            dropZone.addEventListener('drop', function (e) {
                var file = e.dataTransfer.files && e.dataTransfer.files[0];
                handleFile(file);
            });
        }

        function handleFile(file) {
            if (!file) return;
            if (valPhoto) valPhoto.textContent = '';

            if (allowedTypes.indexOf(file.type) === -1) {
                if (valPhoto) valPhoto.textContent = 'Only JPG, JPEG and PNG files are allowed.';
                return;
            }
            if (file.size > maxSizeBytes) {
                if (valPhoto) valPhoto.textContent = 'File size must not exceed 2 MB.';
                return;
            }

            selectedFile = file;
            var reader = new FileReader();
            reader.onload = function (e) {
                newPreviewImg.src = e.target.result;
                newPreviewWrap.style.display = 'block';
            };
            reader.readAsDataURL(file);
        }

        if (btnRemoveNew) {
            btnRemoveNew.addEventListener('click', function () {
                selectedFile = null;
                newPreviewImg.src = '';
                newPreviewWrap.style.display = 'none';
                if (fileInput) fileInput.value = '';
            });
        }

        if (btnSave) {
            btnSave.addEventListener('click', function () {
                if (!selectedFile) {
                    if (valPhoto) valPhoto.textContent = 'Please select a photo to upload.';
                    return;
                }
                // Demo only: apply preview to main avatar
                var mainAvatar = document.getElementById('simsProfileAvatarImg');
                var currentPreview = document.getElementById('photoCurrentPreview');
                if (mainAvatar) mainAvatar.src = newPreviewImg.src;
                if (currentPreview) currentPreview.src = newPreviewImg.src;

                closeModal('modalPhotoOverlay');
                showToast('Profile photo updated successfully.');

                selectedFile = null;
                newPreviewWrap.style.display = 'none';
                if (fileInput) fileInput.value = '';
            });
        }
    }

    /* ---------------------------------------------------------------
       SIGN OUT ALL DEVICES MODAL
    --------------------------------------------------------------- */
    function initSignOutModal() {
        var btnOpen = document.getElementById('btnOpenSignOutAll');
        var btnConfirm = document.getElementById('btnConfirmSignOutAll');

        if (btnOpen) {
            btnOpen.addEventListener('click', function () { openModal('modalSignOutOverlay'); });
        }
        if (btnConfirm) {
            btnConfirm.addEventListener('click', function () {
                closeModal('modalSignOutOverlay');
                showToast('You have been signed out from all devices.');
            });
        }
    }

    /* ---------------------------------------------------------------
       DEACTIVATE ACCOUNT MODAL
    --------------------------------------------------------------- */
    function initDeactivateModal() {
        var btnOpen = document.getElementById('btnOpenDeactivate');
        var btnConfirm = document.getElementById('btnConfirmDeactivate');

        if (btnOpen) {
            btnOpen.addEventListener('click', function () { openModal('modalDeactivateOverlay'); });
        }
        if (btnConfirm) {
            btnConfirm.addEventListener('click', function () {
                closeModal('modalDeactivateOverlay');
                showToast('Your account deactivation request has been submitted.');
            });
        }
    }

    /* ---------------------------------------------------------------
       DISABLE 2FA MODAL
    --------------------------------------------------------------- */
    function init2faModal() {
        var btnOpen = document.getElementById('btnDisable2fa');
        var btnConfirm = document.getElementById('btnConfirmDisable2fa');

        if (btnOpen) {
            btnOpen.addEventListener('click', function () { openModal('modal2faOverlay'); });
        }
        if (btnConfirm) {
            btnConfirm.addEventListener('click', function () {
                closeModal('modal2faOverlay');
                showToast('Two-factor authentication has been disabled.');
            });
        }
    }

    /* ---------------------------------------------------------------
       PREFERENCES
    --------------------------------------------------------------- */
    function initPreferences() {
        var btnSave = document.getElementById('btnSavePreferences');
        if (btnSave) {
            btnSave.addEventListener('click', function () {
                showToast('Preferences saved successfully.');
            });
        }
    }

    /* ---------------------------------------------------------------
       GENERIC MODAL OPEN / CLOSE / OVERLAY BEHAVIOR
    --------------------------------------------------------------- */
    function openModal(id) {
        var overlay = document.getElementById(id);
        if (!overlay) return;
        overlay.classList.add('sims-profile-modal-open');
        document.body.classList.add('sims-profile-modal-open-body');
    }

    function closeModal(id) {
        var overlay = document.getElementById(id);
        if (!overlay) return;
        overlay.classList.remove('sims-profile-modal-open');
        if (!document.querySelector('.sims-profile-modal-overlay.sims-profile-modal-open')) {
            document.body.classList.remove('sims-profile-modal-open-body');
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
        document.querySelectorAll('.sims-profile-modal-overlay').forEach(function (overlay) {
            overlay.addEventListener('click', function (e) {
                if (e.target === overlay) {
                    overlay.classList.remove('sims-profile-modal-open');
                    if (!document.querySelector('.sims-profile-modal-overlay.sims-profile-modal-open')) {
                        document.body.classList.remove('sims-profile-modal-open-body');
                    }
                }
            });
        });

        // Escape key closes any open modal
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                document.querySelectorAll('.sims-profile-modal-overlay.sims-profile-modal-open').forEach(function (overlay) {
                    overlay.classList.remove('sims-profile-modal-open');
                });
                document.body.classList.remove('sims-profile-modal-open-body');
            }
        });
    }

})();

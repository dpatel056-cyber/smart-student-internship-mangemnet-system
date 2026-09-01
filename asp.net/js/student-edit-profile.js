(function () {
    'use strict';

    var isFormDirty = false;
    var isSubmitting = false;

    document.addEventListener('DOMContentLoaded', function () {
        initPhotoPreview();
        initResumeNamePreview();
        initSkillsTagSystem();
        initUnsavedChangesDetection();
    });

    /* ---------------------------------------------------------------
       1. LIVE PROFILE PHOTO PREVIEW
    --------------------------------------------------------------- */
    function initPhotoPreview() {
        var fileInput = document.getElementById('fuProfilePhoto');
        var imgPreview = document.getElementById('imgProfilePreview');
        var initialsFallback = document.getElementById('txtInitialsFallback');

        if (!fileInput) return;

        fileInput.addEventListener('change', function (e) {
            var file = e.target.files[0];
            if (!file) return;

            // Validate type
            if (!file.type.match('image.*')) {
                alert('Please select a valid image file (JPG, JPEG, PNG).');
                fileInput.value = '';
                return;
            }

            // Validate size (2 MB)
            if (file.size > 2 * 1024 * 1024) {
                alert('Profile photo size must be less than 2 MB.');
                fileInput.value = '';
                return;
            }

            var reader = new FileReader();
            reader.onload = function (e) {
                if (imgPreview) {
                    imgPreview.src = e.target.result;
                    imgPreview.style.display = 'block';
                }
                if (initialsFallback) {
                    initialsFallback.style.display = 'none';
                }
                markFormDirty();
            };
            reader.readAsDataURL(file);
        });
    }

    /* ---------------------------------------------------------------
       2. LIVE RESUME FILE NAME PREVIEW
    --------------------------------------------------------------- */
    function initResumeNamePreview() {
        var resumeInput = document.getElementById('fuResume');
        var resumeFilename = document.getElementById('lblResumeFilename');

        if (!resumeInput) return;

        resumeInput.addEventListener('change', function (e) {
            var file = e.target.files[0];
            if (!file) return;

            if (file.type !== 'application/pdf' && !file.name.endsWith('.pdf')) {
                alert('Please upload a valid PDF document for your resume.');
                resumeInput.value = '';
                return;
            }

            if (file.size > 5 * 1024 * 1024) {
                alert('Resume file size must be less than 5 MB.');
                resumeInput.value = '';
                return;
            }

            if (resumeFilename) {
                resumeFilename.textContent = file.name;
            }
            markFormDirty();
        });
    }

    /* ---------------------------------------------------------------
       3. DYNAMIC SKILLS TAG SYSTEM
    --------------------------------------------------------------- */
    function initSkillsTagSystem() {
        var btnAddSkill = document.getElementById('btnAddSkill');
        var txtNewSkill = document.getElementById('txtNewSkill');
        var skillsContainer = document.getElementById('skillsContainer');
        var hdnSkillsList = document.getElementById('hdnSkillsList');

        if (!btnAddSkill || !txtNewSkill || !skillsContainer) return;

        btnAddSkill.addEventListener('click', function (e) {
            e.preventDefault();
            var skillText = txtNewSkill.value.trim();
            if (!skillText) return;

            // Check duplicate
            var existingChips = skillsContainer.querySelectorAll('.student-skill-chip-text');
            for (var i = 0; i < existingChips.length; i++) {
                if (existingChips[i].textContent.toLowerCase() === skillText.toLowerCase()) {
                    alert('Skill already added!');
                    txtNewSkill.value = '';
                    return;
                }
            }

            createSkillChip(skillText);
            txtNewSkill.value = '';
            updateHiddenSkillsField();
            markFormDirty();
        });

        // Event delegation for removing chips
        skillsContainer.addEventListener('click', function (e) {
            if (e.target.classList.contains('student-skill-remove') || e.target.parentNode.classList.contains('student-skill-remove')) {
                var chip = e.target.closest('.student-skill-chip');
                if (chip) {
                    chip.parentNode.removeChild(chip);
                    updateHiddenSkillsField();
                    markFormDirty();
                }
            }
        });
    }

    function createSkillChip(skillName) {
        var skillsContainer = document.getElementById('skillsContainer');
        var chip = document.createElement('div');
        chip.className = 'student-skill-chip';
        chip.innerHTML = '<span class="student-skill-chip-text">' + escapeHtml(skillName) + '</span>' +
            '<i class="fa-solid fa-xmark student-skill-remove" title="Remove skill"></i>';
        skillsContainer.appendChild(chip);
    }

    function updateHiddenSkillsField() {
        var hdnSkillsList = document.getElementById('hdnSkillsList');
        if (!hdnSkillsList) return;

        var chips = document.querySelectorAll('#skillsContainer .student-skill-chip-text');
        var arr = [];
        chips.forEach(function (c) { arr.push(c.textContent.trim()); });
        hdnSkillsList.value = arr.join(',');
    }

    function escapeHtml(str) {
        return str.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
    }

    /* ---------------------------------------------------------------
       4. UNSAVED CHANGES DETECTION
    --------------------------------------------------------------- */
    function initUnsavedChangesDetection() {
        var formControls = document.querySelectorAll('.student-edit-input, .student-edit-select, .student-edit-textarea');
        formControls.forEach(function (ctrl) {
            ctrl.addEventListener('input', markFormDirty);
            ctrl.addEventListener('change', markFormDirty);
        });

        var saveBtn = document.getElementById('btnSaveProfile');
        if (saveBtn) {
            saveBtn.addEventListener('click', function () {
                isSubmitting = true;
            });
        }

        window.addEventListener('beforeunload', function (e) {
            if (isFormDirty && !isSubmitting) {
                var confirmationMessage = 'You have unsaved changes. Are you sure you want to leave?';
                (e || window.event).returnValue = confirmationMessage;
                return confirmationMessage;
            }
        });
    }

    function markFormDirty() {
        isFormDirty = true;
    }

})();

function openProfileTab(tabName, clickedButton) {
    document.querySelectorAll('.profile-tab-content').forEach(function (content) { content.classList.remove('active'); });
    document.querySelectorAll('.profile-tab').forEach(function (button) { button.classList.remove('active'); });
    var selectedContent = document.getElementById(tabName);
    if (selectedContent) selectedContent.classList.add('active');
    if (clickedButton) {
        clickedButton.classList.add('active');
    } else {
        var btn = document.querySelector('.profile-tab[onclick*="\'' + tabName + '\'"]');
        if (btn) btn.classList.add('active');
    }
    try { sessionStorage.setItem('activeProfileTab', tabName); } catch (e) { }
    if (tabName === 'projects') {
        formatTechnologyTags();
    }
}

function formatTechnologyTags() {
    var techContainers = document.querySelectorAll('.technology-tags');
    techContainers.forEach(function (container) {
        if (container.getAttribute('data-formatted') === 'true') {
            return;
        }
        var rawText = container.textContent || '';
        rawText = rawText.trim();
        if (!rawText) return;

        var tags = rawText.split(/[,،]+/).map(function (item) {
            return item.trim();
        }).filter(function (item) {
            return item.length > 0;
        });

        if (tags.length > 0) {
            container.innerHTML = '';
            tags.forEach(function (tag) {
                var span = document.createElement('span');
                span.className = 'tech-tag';
                span.textContent = tag;
                container.appendChild(span);
            });
            container.setAttribute('data-formatted', 'true');
        }
    });
}

function openResumeUpload() {
    var fu = document.querySelector('[id$="fuResume"]') || document.getElementById('fuResume') || document.getElementById('resumeFile');
    if (fu) {
        fu.value = '';
        fu.click();
    }
}
function replaceResume() {
    openResumeUpload();
}
function autoUploadResume(input) {
    if (!input || !input.files || !input.files.length) return;
    var file = input.files[0];
    if (file.type !== 'application/pdf' && !file.name.toLowerCase().endsWith('.pdf')) {
        showProfileToast('Please select a PDF file only (.pdf).', 'error');
        input.value = '';
        return;
    }
    if (file.size > 5 * 1024 * 1024) {
        showProfileToast('Resume file size must be less than 5 MB.', 'error');
        input.value = '';
        return;
    }
    var submitBtn = document.querySelector('[id$="btnUploadResumeSubmit"]') || document.getElementById('btnUploadResumeSubmit');
    if (submitBtn) {
        submitBtn.click();
    }
}
function openEditProfile() { document.getElementById('editProfileModal').classList.add('show'); document.body.style.overflow = 'hidden'; }
function closeEditProfile() { document.getElementById('editProfileModal').classList.remove('show'); document.body.style.overflow = ''; }
function saveProfile() { alert('Profile changes will be saved to database in the next step.'); closeEditProfile(); }

function addProfileSkill() { openSkillForm(); }

var selectedSkillCategory = 'technical';
function openSkillForm() {
    document.getElementById('skillModal').classList.add('show');
    document.body.style.overflow = 'hidden';
    var ddlSkill = document.querySelector('[id$="ddlSkillName"]');
    if (ddlSkill) ddlSkill.selectedIndex = 0;
    var hdnCat = document.querySelector('[id$="hdnSkillCategory"]');
    if (hdnCat) hdnCat.value = 'technical';
    selectSkillCategory('technical', document.querySelector('[data-skill-category="technical"]'));
}
function closeSkillForm() { document.getElementById('skillModal').classList.remove('show'); document.body.style.overflow = ''; }
function selectSkillCategory(category, button) {
    selectedSkillCategory = category;
    document.querySelectorAll('.skill-category-card').forEach(function (item) { item.classList.toggle('active', item === button); });
    var hdnCat = document.querySelector('[id$="hdnSkillCategory"]');
    if (hdnCat) hdnCat.value = category;
}

function openAddProjectForm() {
    var hdn = document.querySelector('[id$="hdnProjectId"]');
    if (hdn) hdn.value = '';
    var txtName = document.querySelector('[id$="txtProjectName"]');
    if (txtName) txtName.value = '';
    var ddlType = document.querySelector('[id$="ddlProjectType"]');
    if (ddlType) ddlType.selectedIndex = 0;
    var txtDesc = document.querySelector('[id$="txtProjectDesc"]');
    if (txtDesc) { txtDesc.value = ''; updateProjectCharCount(txtDesc); }
    var txtTech = document.querySelector('[id$="txtProjectTech"]');
    if (txtTech) txtTech.value = '';
    var txtLink = document.querySelector('[id$="txtProjectLink"]');
    if (txtLink) txtLink.value = '';
    var lblTitle = document.querySelector('[id$="lblProjectModalTitle"]');
    if (lblTitle) lblTitle.textContent = 'Add Project';

    openProjectModal();
}

function openProjectModal() {
    var modal = document.getElementById('projectModal');
    if (modal) {
        modal.classList.add('show');
        document.body.style.overflow = 'hidden';
    }
    var txtDesc = document.querySelector('[id$="txtProjectDesc"]');
    if (txtDesc) updateProjectCharCount(txtDesc);
}

function closeProjectForm() {
    var modal = document.getElementById('projectModal');
    if (modal) {
        modal.classList.remove('show');
        document.body.style.overflow = '';
    }
}

function updateProjectCharCount(el) {
    var counter = document.getElementById('projectDescCharCount');
    if (counter && el) {
        counter.textContent = el.value.length + '/1000';
    }
}

function openAddCertificateForm() {
    var hdn = document.querySelector('[id$="hdnCertId"]');
    if (hdn) hdn.value = '';
    var txtName = document.querySelector('[id$="txtCertName"]');
    if (txtName) txtName.value = '';
    var txtOrg = document.querySelector('[id$="txtCertOrg"]');
    if (txtOrg) txtOrg.value = '';
    var txtIssue = document.querySelector('[id$="txtCertIssueDate"]');
    if (txtIssue) txtIssue.value = '';
    var txtExp = document.querySelector('[id$="txtCertExpiryDate"]');
    if (txtExp) txtExp.value = '';
    var txtCredId = document.querySelector('[id$="txtCertCredId"]');
    if (txtCredId) txtCredId.value = '';
    var txtCredUrl = document.querySelector('[id$="txtCertCredUrl"]');
    if (txtCredUrl) txtCredUrl.value = '';
    var txtDesc = document.querySelector('[id$="txtCertDesc"]');
    if (txtDesc) { txtDesc.value = ''; updateCertCharCount(txtDesc); }
    var hdnFile = document.querySelector('[id$="hdnExistingCertFile"]');
    if (hdnFile) hdnFile.value = '';
    var lblTitle = document.querySelector('[id$="lblCertModalTitle"]');
    if (lblTitle) lblTitle.textContent = 'Add Certificate';

    clearSelectedCertFile();
    openCertificateModal();
}

function openCertificateModal() {
    var modal = document.getElementById('certificateModal');
    if (modal) {
        modal.classList.add('show');
        document.body.style.overflow = 'hidden';
    }
    var txtDesc = document.querySelector('[id$="txtCertDesc"]');
    if (txtDesc) updateCertCharCount(txtDesc);
}

function closeCertificateForm() {
    var modal = document.getElementById('certificateModal');
    if (modal) {
        modal.classList.remove('show');
        document.body.style.overflow = '';
    }
}

function updateCertCharCount(el) {
    var counter = document.getElementById('certDescCharCount');
    if (counter && el) {
        counter.textContent = el.value.length + '/1000';
    }
}

function previewCertFile(input) {
    if (input && input.files && input.files[0]) {
        var file = input.files[0];
        if (file.size > 5 * 1024 * 1024) {
            alert('File size must be less than 5 MB.');
            input.value = '';
            return;
        }
        var sizeStr = (file.size / (1024 * 1024)).toFixed(1) + ' MB';
        var nameSpan = document.getElementById('certSelectedFileName');
        var sizeSpan = document.getElementById('certSelectedFileSize');
        var box = document.getElementById('certFileSelectedBox');
        if (nameSpan) nameSpan.textContent = file.name;
        if (sizeSpan) sizeSpan.textContent = sizeStr;
        if (box) box.style.display = 'flex';
    }
}

function clearSelectedCertFile() {
    var fu = document.querySelector('[id$="fuCertificate"]');
    if (fu) fu.value = '';
    var hdn = document.querySelector('[id$="hdnExistingCertFile"]');
    if (hdn) hdn.value = '';
    var box = document.getElementById('certFileSelectedBox');
    if (box) box.style.display = 'none';
}

function populateCertFilePreview(fileName) {
    if (fileName && fileName.trim() !== '') {
        var nameSpan = document.getElementById('certSelectedFileName');
        var sizeSpan = document.getElementById('certSelectedFileSize');
        var box = document.getElementById('certFileSelectedBox');
        if (nameSpan) nameSpan.textContent = fileName;
        if (sizeSpan) sizeSpan.textContent = 'Existing File';
        if (box) box.style.display = 'flex';
    } else {
        clearSelectedCertFile();
    }
}

document.addEventListener('DOMContentLoaded', function () {
    try {
        var savedTab = sessionStorage.getItem('activeProfileTab');
        if (savedTab && document.getElementById(savedTab)) {
            openProfileTab(savedTab);
        }
    } catch (e) { }
    formatTechnologyTags();
    setupProfileCrud();
});

function setupProfileCrud() {
    normalizeEducationFields();
    formatTechnologyTags();
    var skillAddButton = document.querySelector('#skills .add-skill-btn');
    if (skillAddButton) skillAddButton.onclick = openSkillForm;

    var addProject = document.querySelector('#projects .add-project-btn');
    if (addProject) addProject.onclick = openAddProjectForm;

    var addCertificate = document.querySelector('#certifications .add-certificate-btn');
    if (addCertificate) addCertificate.onclick = openAddCertificateForm;
}

function normalizeEducationFields() {
    // Keep server controls intact
}

var deleteTargetCard = null;
var pendingCustomDeleteCallback = null;

function showDeleteModal(title, message, callback) {
    var modal = document.getElementById('deleteConfirmModal');
    if (!modal) return;
    var titleEl = document.getElementById('deleteConfirmTitle');
    var msgEl = document.getElementById('deleteConfirmMessage');
    if (titleEl) titleEl.textContent = title || 'Delete Confirmation';
    if (msgEl) msgEl.textContent = message || 'Are you sure you want to delete this item?';
    pendingCustomDeleteCallback = callback;
    modal.classList.add('show');
    document.body.style.overflow = 'hidden';
}

function closeDeleteConfirm() {
    pendingCustomDeleteCallback = null;
    deleteTargetCard = null;
    var modal = document.getElementById('deleteConfirmModal');
    if (modal) modal.classList.remove('show');
    document.body.style.overflow = '';
}

function executeCustomDelete() {
    if (typeof pendingCustomDeleteCallback === 'function') {
        var fn = pendingCustomDeleteCallback;
        pendingCustomDeleteCallback = null;
        closeDeleteConfirm();
        fn();
    } else if (deleteTargetCard) {
        deleteTargetCard.remove();
        closeDeleteConfirm();
    } else {
        closeDeleteConfirm();
    }
}

function confirmDeleteResumeCustom() {
    showDeleteModal('Delete Resume', 'Are you sure you want to delete your uploaded resume?', function () {
        var btn = document.querySelector('[id$="btnHiddenDeleteResume"]');
        if (btn) btn.click();
    });
}

function confirmDeleteProjectCustom(btn) {
    if (btn && btn.getAttribute('data-confirmed') === 'true') {
        btn.removeAttribute('data-confirmed');
        return true;
    }
    showDeleteModal('Delete Project', 'Are you sure you want to delete this project?', function () {
        if (btn) {
            btn.setAttribute('data-confirmed', 'true');
            btn.click();
        }
    });
    return false;
}

function showProfileToast(message, type) {
    var toast = document.getElementById('profileToast');
    if (!toast) {
        toast = document.createElement('div');
        toast.id = 'profileToast';
        toast.className = 'profile-toast';
        document.body.appendChild(toast);
    }
    var icon = type === 'error' ? '<i class="fa-solid fa-circle-exclamation"></i>' : '<i class="fa-solid fa-circle-check"></i>';
    toast.innerHTML = icon + '<span>' + message + '</span>';
    toast.className = 'profile-toast show ' + (type || 'success');
    clearTimeout(toast._timer);
    toast._timer = setTimeout(function () {
        toast.classList.remove('show');
    }, 3500);
}

function openDeleteConfirm(card) { deleteTargetCard = card; showDeleteModal('Delete Item', 'Are you sure you want to delete this item?'); }
function confirmDeleteCard() { executeCustomDelete(); }
function deleteCard(card) { if (card) openDeleteConfirm(card); }
function editProject(card) { openCrudForm('project', card); }
function addProjectCard() { openCrudForm('project'); }
function editCertificate(card) { openCrudForm('certificate', card); }
function addCertificateCard() { openCrudForm('certificate'); }
function viewCertificate(card) { alert('Viewing certificate: ' + card.querySelector('h3').textContent); }
function downloadCertificate(card) { var text = 'Certificate: ' + card.querySelector('h3').textContent; var link = document.createElement('a'); link.href = URL.createObjectURL(new Blob([text], { type: 'text/plain' })); link.download = 'certificate.txt'; link.click(); URL.revokeObjectURL(link.href); }
function updateProjectCard(card, data) { card.querySelector('h3').textContent=data.title; var type=card.querySelector('.project-type'); if(type) type.textContent=data.type || 'Project'; card.querySelector('.project-description p').textContent=data.description; var tags=card.querySelector('.technology-tags'); if(tags){tags.innerHTML='';(data.technologies||'').split(',').forEach(function(value){if(value.trim()){var item=document.createElement('span');item.textContent=value.trim();tags.appendChild(item);}});} }
var activeCrudType = '', activeCrudCard = null;
function openCrudForm(type, card) {
    activeCrudType = type; activeCrudCard = card || null;
    var crudModal = document.getElementById('profileCrudModal');
    crudModal.classList.toggle('education-crud', type === 'education');
    crudModal.classList.toggle('project-crud', type === 'project');
    crudModal.classList.toggle('certificate-crud', type === 'certificate');

    var modalHeaderDiv = crudModal.querySelector('.edit-modal-header');
    if (type === 'project') {
        crudModal.querySelector('.edit-modal-header').innerHTML =
            '<div class="project-modal-header-left">' +
                '<div class="project-header-icon"><i class="fa-solid fa-code"></i></div>' +
                '<div>' +
                    '<h2 id="crudModalTitle">' + (card ? 'Edit Project' : 'Add Project') + '</h2>' +
                    '<p id="crudModalSubtitle">Enter the details of your project below.</p>' +
                '</div>' +
            '</div>' +
            '<button type="button" class="close-edit-modal" onclick="closeCrudForm()"><i class="fa-solid fa-xmark"></i></button>';

        var titleVal = card ? (card.querySelector('h3')?.textContent || '') : '';
        var typeVal = card ? (card.querySelector('.project-type')?.textContent || '') : '';
        var descVal = card ? (card.querySelector('.project-description p')?.textContent || '') : '';
        var techVal = card ? Array.from(card.querySelectorAll('.technology-tags span')).map(function (item) { return item.textContent; }).join(', ') : '';
        var linkVal = card ? (card.querySelector('.project-link.github-link')?.href || card.querySelector('.project-link.demo-link')?.href || '') : '';
        if (linkVal === '#' || linkVal.indexOf(window.location.href) !== -1) linkVal = '';

        document.getElementById('crudFields').innerHTML =
            '<div class="edit-field">' +
                '<label>Project Name <span class="required-mark">*</span></label>' +
                '<div class="input-with-icon">' +
                    '<i class="fa-regular fa-file-lines field-icon"></i>' +
                    '<input type="text" name="title" value="' + titleVal.replace(/"/g, '&quot;') + '" placeholder="e.g. Smart Student Internship Management System" required>' +
                '</div>' +
            '</div>' +
            '<div class="edit-field">' +
                '<label>Project Type <span class="required-mark">*</span></label>' +
                '<div class="input-with-icon select-with-icon">' +
                    '<i class="fa-solid fa-tag field-icon"></i>' +
                    '<select name="type" required>' +
                        '<option value="" disabled ' + (!typeVal ? 'selected' : '') + '>Select project type</option>' +
                        '<option value="Academic Project" ' + (typeVal === 'Academic Project' ? 'selected' : '') + '>Academic Project</option>' +
                        '<option value="Personal Project" ' + (typeVal === 'Personal Project' ? 'selected' : '') + '>Personal Project</option>' +
                        '<option value="Internship Project" ' + (typeVal === 'Internship Project' ? 'selected' : '') + '>Internship Project</option>' +
                        '<option value="Client Project" ' + (typeVal === 'Client Project' ? 'selected' : '') + '>Client Project</option>' +
                        '<option value="Open Source" ' + (typeVal === 'Open Source' ? 'selected' : '') + '>Open Source</option>' +
                    '</select>' +
                '</div>' +
            '</div>' +
            '<div class="edit-field full-width desc-field-wrapper">' +
                '<label>Description <span class="required-mark">*</span></label>' +
                '<div class="textarea-with-icon">' +
                    '<i class="fa-regular fa-file-lines field-icon"></i>' +
                    '<textarea name="description" rows="4" maxlength="1000" placeholder="Describe your project, its purpose, key features and what you built..." oninput="updateCharCount(this)" required>' + descVal + '</textarea>' +
                    '<div class="char-count" id="descCharCount">' + descVal.length + '/1000</div>' +
                '</div>' +
            '</div>' +
            '<div class="edit-field full-width">' +
                '<label>Technologies Used <span class="required-mark">*</span></label>' +
                '<div class="input-with-icon">' +
                    '<i class="fa-solid fa-code field-icon"></i>' +
                    '<input type="text" name="technologies" value="' + techVal.replace(/"/g, '&quot;') + '" placeholder="e.g. ASP.NET, C#, SQL Server, HTML, CSS, JavaScript" required>' +
                '</div>' +
            '</div>' +
            '<div class="edit-field full-width">' +
                '<label>Project Link <span class="optional-mark">(Optional)</span></label>' +
                '<div class="input-with-icon">' +
                    '<i class="fa-solid fa-link field-icon"></i>' +
                    '<input type="url" name="link" value="' + linkVal.replace(/"/g, '&quot;') + '" placeholder="e.g. https://github.com/username/project">' +
                '</div>' +
            '</div>';

        var saveBtn = crudModal.querySelector('.save-profile-btn');
        if (saveBtn) {
            saveBtn.innerHTML = '<i class="fa-solid fa-floppy-disk"></i> Save';
        }
    } else {
        crudModal.querySelector('.edit-modal-header').innerHTML =
            '<div>' +
                '<h2 id="crudModalTitle">' + (card ? 'Update ' + type : 'Add ' + type) + '</h2>' +
                '<p id="crudModalSubtitle">' + (type === 'education' ? 'Add your previous education details.' : 'Enter information below.') + '</p>' +
            '</div>' +
            '<button type="button" class="close-edit-modal" onclick="closeCrudForm()"><i class="fa-solid fa-xmark"></i></button>';

        var fields = type === 'education' ? [['title','Education title','e.g. Higher Secondary'],['school','School / College name','e.g. ABC Higher Secondary School'],['year','Completion year','e.g. 2024']] : [['title','Certificate name',''],['issuer','Issuing organization',''],['date','Issue date',''],['credential','Credential ID','']];
        var values = {};
        if (card) { values.title = card.querySelector('h3, h4')?.textContent || ''; values.school = card.querySelector('p')?.textContent || ''; values.year = card.querySelector('span')?.textContent || ''; values.issuer = card.querySelector('.certificate-issuer')?.textContent || ''; }
        document.getElementById('crudFields').innerHTML = fields.map(function (field) { var value = (values[field[0]] || '').replace(/"/g, '&quot;'); var typeName = field[0] === 'year' ? 'number' : 'text'; return '<div class="edit-field ' + (field[0] === 'description' ? 'full-width' : '') + '"><label>' + field[1] + '<span class="required-mark">*</span></label>' + (field[0] === 'description' ? '<textarea name="' + field[0] + '" rows="4" placeholder="' + field[2] + '" required>' + value + '</textarea>' : '<input type="' + typeName + '" name="' + field[0] + '" value="' + value + '" placeholder="' + field[2] + '" required>') + '</div>'; }).join('');

        var saveBtn = crudModal.querySelector('.save-profile-btn');
        if (saveBtn) saveBtn.innerHTML = '<i class="fa-solid fa-check"></i> Save';
    }

    crudModal.classList.add('show'); document.body.style.overflow = 'hidden';
}
function updateCharCount(el) {
    var counter = document.getElementById('descCharCount');
    if (counter) counter.textContent = el.value.length + '/1000';
}

function closeCrudForm() { document.getElementById('profileCrudModal').classList.remove('show'); document.body.style.overflow = ''; }
function saveCrudForm() {
    var data = {}; document.querySelectorAll('#crudFields [name]').forEach(function (input) { data[input.name] = input.value.trim(); });
    if (!data.title || (activeCrudType === 'education' && (!data.school || !data.year))) { alert('Please fill all required fields.'); return; }
    if (activeCrudType === 'education') { if (activeCrudCard) { activeCrudCard.querySelector('h4').textContent = data.title; activeCrudCard.querySelector('p').textContent = data.school; activeCrudCard.querySelector('span').textContent = data.year; } else { var card = document.createElement('div'); card.className = 'education-mini-card'; card.innerHTML = '<div class="mini-icon"><i class="fa-solid fa-school"></i></div><div><h4></h4><p></p><span></span></div>'; card.querySelector('h4').textContent=data.title; card.querySelector('p').textContent=data.school; card.querySelector('span').textContent=data.year; document.querySelector('#education .previous-education-grid').appendChild(card); addEducationActions(card); } }
    if (activeCrudType === 'project') { if (activeCrudCard) { updateProjectCard(activeCrudCard, data); } else { addProjectCardFromData(data); } }
    if (activeCrudType === 'certificate') { if (activeCrudCard) { activeCrudCard.querySelector('h3').textContent=data.title; activeCrudCard.querySelector('.certificate-issuer').textContent=data.issuer; } else { addCertificateCardFromData(data); } }
    closeCrudForm();
}
function projectMarkup(data) { return '<div class="project-card-header"><div class="project-title-area"><div class="project-icon"><i class="fa-solid fa-laptop-code"></i></div><div><h3></h3><span class="project-type">Personal Project</span></div></div><div class="project-actions"><button type="button" title="Edit"><i class="fa-solid fa-pen"></i></button><button type="button" title="Delete"><i class="fa-solid fa-trash"></i></button></div></div><div class="project-description"><p></p></div><div class="project-info"><div class="project-info-label"><i class="fa-solid fa-code"></i> Technologies Used</div><div class="technology-tags"></div></div><div class="project-details-grid"><div><span class="project-label">Role</span><span class="project-value role-value"></span></div><div><span class="project-label">Start Date</span><span class="project-value start-value"></span></div><div><span class="project-label">End Date</span><span class="project-value end-value"></span></div></div><div class="project-links"><a class="project-link github-link" href="#"><i class="fa-brands fa-github"></i> GitHub</a><a class="project-link demo-link" href="#"><i class="fa-solid fa-arrow-up-right-from-square"></i> Live Demo</a></div>'; }
function updateProjectCard(card, data) { card.querySelector('h3').textContent=data.title; card.querySelector('.project-description p').textContent=data.description; card.querySelector('.technology-tags').innerHTML=''; (data.technologies || '').split(',').forEach(function(t){if(t.trim()){var s=document.createElement('span');s.textContent=t.trim();card.querySelector('.technology-tags').appendChild(s);}}); card.querySelector('.role-value').textContent=data.role || ''; card.querySelector('.start-value').textContent=data.startDate || ''; card.querySelector('.end-value').textContent=data.endDate || ''; card.querySelector('.github-link').href=data.github || '#'; card.querySelector('.demo-link').href=data.demo || '#'; }
function addProjectCardFromData(data) { var card=document.createElement('div'); card.className='project-card'; card.innerHTML=projectMarkup(data); document.querySelector('#projects .add-project-placeholder').before(card); updateProjectCard(card,data); card.querySelector('[title="Edit"]').onclick=function(){editProject(card);}; card.querySelector('[title="Delete"]').onclick=function(){deleteCard(card);}; }
function addCertificateCardFromData(data) { var card=document.createElement('div'); card.className='certificate-card'; card.innerHTML='<div class="certificate-main"><div class="certificate-icon"><i class="fa-solid fa-award"></i></div><div class="certificate-content"><div class="certificate-title-row"><div><h3></h3><p class="certificate-issuer"></p></div><span class="certificate-status">Verified</span></div><div class="certificate-actions"><button type="button" class="certificate-action primary">View Certificate</button><button type="button" class="certificate-action">Download</button><button type="button" class="certificate-icon-btn" title="Edit"><i class="fa-solid fa-pen"></i></button><button type="button" class="certificate-icon-btn delete" title="Delete"><i class="fa-solid fa-trash"></i></button></div></div></div>'; card.querySelector('h3').textContent=data.title; card.querySelector('.certificate-issuer').textContent=data.issuer; document.querySelector('#certifications .add-certificate-placeholder').before(card); card.querySelector('[title="Edit"]').onclick=function(){editCertificate(card);}; card.querySelector('[title="Delete"]').onclick=function(){deleteCard(card);}; card.querySelector('.primary').onclick=function(){viewCertificate(card);}; card.querySelector('.certificate-action:not(.primary)').onclick=function(){downloadCertificate(card);}; }

(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        initDragAndDrop();
        initFileInputValidation();
        initModalEvents();
    });

    /* ---------------------------------------------------------------
       1. DRAG AND DROP & FILE INPUT SELECTION
    --------------------------------------------------------------- */
    function initDragAndDrop() {
        var dropzone = document.getElementById('resumeDropzone');
        var fileInput = document.getElementById('fuResumeUpload');

        if (!dropzone || !fileInput) return;

        dropzone.addEventListener('click', function () {
            fileInput.click();
        });

        ['dragenter', 'dragover'].forEach(function (eventName) {
            dropzone.addEventListener(eventName, function (e) {
                e.preventDefault();
                e.stopPropagation();
                dropzone.classList.add('drag-over');
            }, false);
        });

        ['dragleave', 'drop'].forEach(function (eventName) {
            dropzone.addEventListener(eventName, function (e) {
                e.preventDefault();
                e.stopPropagation();
                dropzone.classList.remove('drag-over');
            }, false);
        });

        dropzone.addEventListener('drop', function (e) {
            var dt = e.dataTransfer;
            var files = dt.files;
            if (files && files.length > 0) {
                fileInput.files = files;
                handleSelectedFile(files[0]);
            }
        });
    }

    function initFileInputValidation() {
        var fileInput = document.getElementById('fuResumeUpload');
        var removeBtn = document.getElementById('btnRemoveSelectedFile');

        if (!fileInput) return;

        fileInput.addEventListener('change', function (e) {
            if (e.target.files && e.target.files.length > 0) {
                handleSelectedFile(e.target.files[0]);
            }
        });

        if (removeBtn) {
            removeBtn.addEventListener('click', function (e) {
                e.stopPropagation();
                fileInput.value = '';
                var selectedBox = document.getElementById('selectedFileBox');
                if (selectedBox) selectedBox.style.display = 'none';
            });
        }
    }

    function handleSelectedFile(file) {
        var fileInput = document.getElementById('fuResumeUpload');
        var selectedBox = document.getElementById('selectedFileBox');
        var lblFileName = document.getElementById('lblSelectedFileName');

        if (!file) return;

        // Validation 1: Only PDF
        if (file.type !== 'application/pdf' && !file.name.toLowerCase().endsWith('.pdf')) {
            alert('Invalid file format. Please upload a PDF file only.');
            if (fileInput) fileInput.value = '';
            if (selectedBox) selectedBox.style.display = 'none';
            return;
        }

        // Validation 2: Max 5 MB
        if (file.size > 5 * 1024 * 1024) {
            alert('File too large! Maximum file size allowed is 5 MB.');
            if (fileInput) fileInput.value = '';
            if (selectedBox) selectedBox.style.display = 'none';
            return;
        }

        var formattedSize = (file.size / (1024 * 1024)).toFixed(1) + ' MB';
        if (lblFileName) {
            lblFileName.textContent = file.name + ' (' + formattedSize + ')';
        }
        if (selectedBox) {
            selectedBox.style.display = 'flex';
        }
    }

    /* ---------------------------------------------------------------
       2. MODAL DIALOG CONTROLS (DELETE & REPLACE)
    --------------------------------------------------------------- */
    function initModalEvents() {
        // Delete Modal Trigger
        var btnOpenDelete = document.getElementById('btnTriggerDeleteModal');
        var modalDelete = document.getElementById('modalDeleteResume');
        var btnCancelDelete = document.getElementById('btnCancelDelete');

        if (btnOpenDelete && modalDelete) {
            btnOpenDelete.addEventListener('click', function (e) {
                e.preventDefault();
                modalDelete.style.display = 'flex';
            });
        }

        if (btnCancelDelete && modalDelete) {
            btnCancelDelete.addEventListener('click', function () {
                modalDelete.style.display = 'none';
            });
        }

        // Replace Modal Trigger
        var btnOpenReplace = document.getElementById('btnTriggerReplaceModal');
        var modalReplace = document.getElementById('modalReplaceResume');
        var btnCancelReplace = document.getElementById('btnCancelReplace');
        var btnConfirmReplace = document.getElementById('btnConfirmReplace');

        if (btnOpenReplace && modalReplace) {
            btnOpenReplace.addEventListener('click', function (e) {
                e.preventDefault();
                modalReplace.style.display = 'flex';
            });
        }

        if (btnCancelReplace && modalReplace) {
            btnCancelReplace.addEventListener('click', function () {
                modalReplace.style.display = 'none';
            });
        }

        if (btnConfirmReplace && modalReplace) {
            btnConfirmReplace.addEventListener('click', function () {
                modalReplace.style.display = 'none';
                // Focus / scroll to upload dropzone
                var dropzone = document.getElementById('resumeDropzone');
                if (dropzone) {
                    dropzone.scrollIntoView({ behavior: 'smooth' });
                    dropzone.click();
                }
            });
        }
    }

})();

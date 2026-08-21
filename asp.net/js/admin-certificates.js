/* ==========================================================================
   SIMS – CERTIFICATE MANAGEMENT PAGE JAVASCRIPT (Frontend / Demo only)
   ========================================================================== */

(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        initModals();
        initActionMenus();
        initBulkSelection();
        initFilters();
        initGenerateSubmit();
        initQuickVerify();
        initExportButtons();
        initPreviewButtons();
        initEmptyStateDemo();
    });

    /* ---------------- TOAST NOTIFICATIONS ---------------- */
    function showToast(message, type) {
        type = type || 'success';
        var container = document.getElementById('simsCertToastContainer');
        if (!container) {
            container = document.createElement('div');
            container.id = 'simsCertToastContainer';
            container.style.position = 'fixed';
            container.style.top = '20px';
            container.style.right = '20px';
            container.style.zIndex = '10050';
            container.style.display = 'flex';
            container.style.flexDirection = 'column';
            container.style.gap = '10px';
            document.body.appendChild(container);
        }
        var toast = document.createElement('div');
        var bg = type === 'success' ? '#16a34a' : (type === 'danger' ? '#dc2626' : '#2563eb');
        toast.textContent = message;
        toast.style.background = bg;
        toast.style.color = '#fff';
        toast.style.padding = '12px 18px';
        toast.style.borderRadius = '8px';
        toast.style.fontSize = '13.5px';
        toast.style.fontWeight = '600';
        toast.style.boxShadow = '0 8px 20px rgba(0,0,0,.18)';
        toast.style.opacity = '0';
        toast.style.transition = 'opacity .2s ease, transform .2s ease';
        toast.style.transform = 'translateY(-8px)';
        container.appendChild(toast);
        requestAnimationFrame(function () {
            toast.style.opacity = '1';
            toast.style.transform = 'translateY(0)';
        });
        setTimeout(function () {
            toast.style.opacity = '0';
            toast.style.transform = 'translateY(-8px)';
            setTimeout(function () { toast.remove(); }, 200);
        }, 2800);
    }

    /* ---------------- MODAL CORE ---------------- */
    var overlay = null;

    function initModals() {
        overlay = document.getElementById('modalOverlay');

        var openMap = {
            btnOpenGenerate: 'modalGenerateCertificate'
        };
        Object.keys(openMap).forEach(function (btnId) {
            var btn = document.getElementById(btnId);
            if (btn) btn.addEventListener('click', function () { openModal(openMap[btnId]); });
        });

        document.querySelectorAll('[data-close]').forEach(function (btn) {
            btn.addEventListener('click', closeAllModals);
        });

        if (overlay) overlay.addEventListener('click', closeAllModals);

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeAllModals();
        });
    }

    function openModal(id) {
        closeAllModals();
        var modal = document.getElementById(id);
        if (!modal) return;
        if (overlay) overlay.classList.add('sims-active');
        modal.classList.add('sims-active');
        document.body.classList.add('modal-open');
    }

    function closeAllModals() {
        document.querySelectorAll('.sims-certificate-modal.sims-active').forEach(function (m) {
            m.classList.remove('sims-active');
        });
        if (overlay) overlay.classList.remove('sims-active');
        document.body.classList.remove('modal-open');
    }

    /* ---------------- ROW ACTION MENUS (3-dot) ---------------- */
    function initActionMenus() {
        document.querySelectorAll('.sims-certificate-action-toggle').forEach(function (toggle) {
            toggle.addEventListener('click', function (e) {
                e.stopPropagation();
                var dropdown = toggle.nextElementSibling;
                var wasOpen = dropdown.classList.contains('sims-open');
                closeAllActionMenus();
                if (!wasOpen) dropdown.classList.add('sims-open');
            });
        });

        document.addEventListener('click', closeAllActionMenus);

        var actionModalMap = {
            'act-view': 'modalViewCertificate',
            'act-preview': 'modalCertificatePreview',
            'act-generate': 'modalGenerateCertificate',
            'act-verify': 'modalVerifyCertificate',
            'act-send': 'modalSendCertificate',
            'act-revoke': 'modalRevokeCertificate',
            'act-regenerate': 'modalGenerateCertificate',
            'act-viewstudent': 'modalStudentQuickView',
            'act-viewcompany': 'modalCompanyQuickView',
            'act-delete': 'modalDeleteCertificate'
        };

        document.querySelectorAll('.sims-certificate-action-dropdown a').forEach(function (link) {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                var matchedClass = Object.keys(actionModalMap).find(function (cls) {
                    return link.classList.contains(cls);
                });
                closeAllActionMenus();

                if (matchedClass === 'act-download') {
                    showToast('Certificate download started (demo only).', 'info');
                    return;
                }
                if (matchedClass && actionModalMap[matchedClass]) {
                    openModal(actionModalMap[matchedClass]);
                } else {
                    showToast('Action triggered (demo only).', 'info');
                }
            });
        });

        // Download action (separate, since it doesn't map to a modal)
        document.querySelectorAll('.act-download').forEach(function (link) {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                closeAllActionMenus();
                showToast('Certificate download started (demo only).', 'info');
            });
        });
    }

    function closeAllActionMenus() {
        document.querySelectorAll('.sims-certificate-action-dropdown.sims-open').forEach(function (d) {
            d.classList.remove('sims-open');
        });
    }

    /* ---------------- BULK SELECTION ---------------- */
    function initBulkSelection() {
        var selectAll = document.getElementById('chkSelectAll');
        var rowChecks = document.querySelectorAll('.rowChk');
        var toolbar = document.getElementById('bulkToolbar');
        var countLabel = document.getElementById('selectedCount');

        function updateToolbar() {
            var checked = document.querySelectorAll('.rowChk:checked').length;
            if (checked > 0) {
                toolbar.style.display = 'flex';
                countLabel.textContent = 'Selected: ' + checked;
            } else {
                toolbar.style.display = 'none';
            }
        }

        if (selectAll) {
            selectAll.addEventListener('change', function () {
                rowChecks.forEach(function (chk) { chk.checked = selectAll.checked; });
                updateToolbar();
            });
        }

        rowChecks.forEach(function (chk) {
            chk.addEventListener('change', function () {
                if (!chk.checked && selectAll) selectAll.checked = false;
                updateToolbar();
            });
        });

        document.querySelectorAll('.sims-certificate-bulk-btn').forEach(function (btn) {
            btn.addEventListener('click', function () {
                showToast('Bulk action performed (demo only).', 'success');
            });
        });
    }

    /* ---------------- SEARCH / FILTERS / RESET ---------------- */
    function initFilters() {
        var searchBtn = document.getElementById('btnSearchCertificates');
        var resetBtn = document.getElementById('btnResetCertificates');
        var clearFiltersBtn = document.getElementById('btnClearFilters');
        var searchInput = document.getElementById('txtCertificateSearch');

        if (searchBtn) {
            searchBtn.addEventListener('click', function () {
                showToast('Filters applied (demo only).', 'info');
            });
        }

        if (resetBtn) {
            resetBtn.addEventListener('click', resetFilters);
        }
        if (clearFiltersBtn) {
            clearFiltersBtn.addEventListener('click', function () {
                resetFilters();
                document.getElementById('emptyState').style.display = 'none';
                document.querySelectorAll('.sims-certificate-row').forEach(function (r) { r.style.display = ''; });
            });
        }

        function resetFilters() {
            if (searchInput) searchInput.value = '';
            document.querySelectorAll('.sims-certificate-filters .sims-certificate-select').forEach(function (sel) {
                sel.selectedIndex = 0;
            });
            showToast('Filters reset.', 'info');
        }
    }

    /* ---------------- GENERATE CERTIFICATE SUBMIT (DEMO) ---------------- */
    function initGenerateSubmit() {
        var btn = document.getElementById('btnSubmitGenerate');
        if (!btn) return;
        btn.addEventListener('click', function () {
            closeAllModals();
            showToast('Certificate generated successfully (demo only).', 'success');
        });
    }

    /* ---------------- QUICK VERIFICATION PANEL ---------------- */
    function initQuickVerify() {
        var btn = document.getElementById('btnVerifyQuick');
        var input = document.getElementById('txtVerifyInput');
        var result = document.getElementById('verifyResult');
        if (!btn) return;

        btn.addEventListener('click', function () {
            if (!input.value.trim()) {
                showToast('Please enter a certificate ID or verification code.', 'danger');
                return;
            }
            result.style.display = 'block';
            showToast('Certificate verified successfully.', 'success');
        });
    }

    /* ---------------- EXPORT BUTTONS (DEMO) ---------------- */
    function initExportButtons() {
        document.querySelectorAll('.sims-certificate-export-btn').forEach(function (btn) {
            btn.addEventListener('click', function () {
                showToast('Export started (demo only).', 'info');
            });
        });
        var exportHeaderBtn = document.getElementById('btnExportCertificates');
        if (exportHeaderBtn) {
            exportHeaderBtn.addEventListener('click', function () {
                showToast('Preparing export (demo only).', 'info');
            });
        }
    }

    /* ---------------- CERTIFICATE PREVIEW / PRINT / DOWNLOAD (DEMO) ---------------- */
    function initPreviewButtons() {
        document.querySelectorAll('.act-preview-btn').forEach(function (btn) {
            btn.addEventListener('click', function () {
                openModal('modalCertificatePreview');
            });
        });

        var printBtn = document.getElementById('btnPrintCert');
        if (printBtn) {
            printBtn.addEventListener('click', function () {
                showToast('Print dialog would open here (demo only).', 'info');
            });
        }

        var downloadBtn = document.getElementById('btnDownloadCertPdf');
        if (downloadBtn) {
            downloadBtn.addEventListener('click', function () {
                showToast('Certificate PDF download started (demo only).', 'success');
            });
        }
    }

    /* ---------------- DEMO: SHOW EMPTY STATE WHEN SEARCH HAS NO MATCH ---------------- */
    function initEmptyStateDemo() {
        var searchInput = document.getElementById('txtCertificateSearch');
        var tableRows = document.querySelectorAll('.sims-certificate-row');
        var emptyState = document.getElementById('emptyState');
        if (!searchInput) return;

        searchInput.addEventListener('keyup', function () {
            var term = searchInput.value.trim().toLowerCase();
            if (term === 'xyznotfound') {
                tableRows.forEach(function (r) { r.style.display = 'none'; });
                if (emptyState) emptyState.style.display = 'block';
            } else {
                tableRows.forEach(function (r) { r.style.display = ''; });
                if (emptyState) emptyState.style.display = 'none';
            }
        });
    }

})();

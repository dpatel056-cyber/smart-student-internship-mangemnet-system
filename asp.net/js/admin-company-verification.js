/* ==========================================================================
   SIMS - Company Verification & Approval Page
   Frontend-only demo JavaScript. No backend / database calls.
   ========================================================================== */

(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        initSearchAndFilters();
        initSelectAllAndBulk();
        initActionMenus();
        initModals();
        initTabs();
        initChecklist();
        initRowActionRouting();
        initTopButtons();
        initDocumentButtons();
    });

    /* ---------------------------------------------------------------------
       SEARCH & FILTERS
    --------------------------------------------------------------------- */
    function initSearchAndFilters() {
        var searchInput = document.getElementById('verificationSearchInput');
        var statusFilter = document.getElementById('filterStatus');
        var industryFilter = document.getElementById('filterIndustry');
        var priorityFilter = document.getElementById('filterPriority');
        var btnSearch = document.getElementById('btnFilterSearch');
        var btnReset = document.getElementById('btnFilterReset');
        var table = document.getElementById('verificationTable');

        function applyFilters() {
            if (!table) return;
            var term = (searchInput.value || '').toLowerCase().trim();
            var status = statusFilter.value;
            var priority = priorityFilter.value;
            var rows = table.querySelectorAll('tbody tr');
            var visibleCount = 0;

            rows.forEach(function (row) {
                var company = (row.getAttribute('data-company') || '').toLowerCase();
                var companyId = (row.getAttribute('data-companyid') || '').toLowerCase();
                var rowStatus = row.getAttribute('data-status');
                var rowPriority = row.getAttribute('data-priority');

                var matchesTerm = !term || company.indexOf(term) !== -1 || companyId.indexOf(term) !== -1;
                var matchesStatus = status === 'all' || status === rowStatus;
                var matchesPriority = priority === 'all' || priority === rowPriority;

                var visible = matchesTerm && matchesStatus && matchesPriority;
                row.style.display = visible ? '' : 'none';
                if (visible) visibleCount++;
            });

            toggleEmptyState(visibleCount === 0);
        }

        if (btnSearch) btnSearch.addEventListener('click', applyFilters);
        if (searchInput) {
            searchInput.addEventListener('keyup', function (e) {
                if (e.key === 'Enter') applyFilters();
            });
        }

        if (btnReset) {
            btnReset.addEventListener('click', function () {
                searchInput.value = '';
                statusFilter.value = 'all';
                industryFilter.value = 'all';
                priorityFilter.value = 'all';
                document.getElementById('filterDate').value = 'all';
                applyFilters();
            });
        }
    }

    function toggleEmptyState(show) {
        var emptyState = document.getElementById('verificationEmptyState');
        var tableScroll = document.querySelector('.sims-verification-table-scroll');
        if (!emptyState) return;
        emptyState.style.display = show ? 'block' : 'none';
        if (tableScroll) tableScroll.style.display = show ? 'none' : 'block';
    }

    /* ---------------------------------------------------------------------
       SELECT ALL / ROW SELECTION / BULK ACTIONS
    --------------------------------------------------------------------- */
    function initSelectAllAndBulk() {
        var selectAll = document.getElementById('selectAllRows');
        var rowChecks = document.querySelectorAll('.sims-verification-row-check');
        var bulkBar = document.getElementById('bulkActionBar');
        var bulkCount = document.getElementById('bulkSelectedCount');

        function updateBulkBar() {
            var checked = document.querySelectorAll('.sims-verification-row-check:checked').length;
            if (bulkCount) bulkCount.textContent = checked;
            if (bulkBar) bulkBar.style.display = checked > 0 ? 'flex' : 'none';
        }

        if (selectAll) {
            selectAll.addEventListener('change', function () {
                rowChecks.forEach(function (cb) {
                    cb.checked = selectAll.checked;
                });
                updateBulkBar();
            });
        }

        rowChecks.forEach(function (cb) {
            cb.addEventListener('change', updateBulkBar);
        });

        document.querySelectorAll('[data-bulk]').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var action = btn.getAttribute('data-bulk');
                var checked = document.querySelectorAll('.sims-verification-row-check:checked').length;

                if (action === 'approve') {
                    showToast('Bulk approval requires all verification conditions to be met for each company.', 'warn');
                    return;
                }

                var messages = {
                    'review': 'Started review for ' + checked + ' selected companies.',
                    'request-docs': 'Document request sent to ' + checked + ' selected companies.',
                    'reject': checked + ' selected companies marked for rejection review.',
                    'export': 'Exporting ' + checked + ' selected companies...'
                };
                showToast(messages[action] || 'Bulk action completed.', 'success');
            });
        });
    }

    /* ---------------------------------------------------------------------
       ROW ACTION (three-dot) MENUS
    --------------------------------------------------------------------- */
    function initActionMenus() {
        document.querySelectorAll('.sims-verification-action-toggle').forEach(function (toggle) {
            toggle.addEventListener('click', function (e) {
                e.stopPropagation();
                var menu = toggle.nextElementSibling;
                var isOpen = menu.classList.contains('sims-verification-menu-open');
                closeAllActionMenus();
                if (!isOpen) menu.classList.add('sims-verification-menu-open');
            });
        });

        document.addEventListener('click', closeAllActionMenus);
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeAllActionMenus();
        });
    }

    function closeAllActionMenus() {
        document.querySelectorAll('.sims-verification-action-menu').forEach(function (menu) {
            menu.classList.remove('sims-verification-menu-open');
        });
    }

    /* ---------------------------------------------------------------------
       ROW ACTION ROUTING (View / Review / Start / Approve / Reject / etc.)
    --------------------------------------------------------------------- */
    function initRowActionRouting() {
        document.querySelectorAll('.sims-verification-action-menu button').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var action = btn.getAttribute('data-action');
                var row = btn.closest('tr');
                var companyName = row ? row.getAttribute('data-company') : 'this company';
                closeAllActionMenus();

                switch (action) {
                    case 'view':
                    case 'review-docs':
                        openModal('reviewModalOverlay');
                        if (action === 'review-docs') selectTab('tab-docs');
                        break;
                    case 'start-review':
                        showToast('Verification started for ' + companyName + '.', 'success');
                        break;
                    case 'approve':
                        openModal('approveModalOverlay');
                        break;
                    case 'reject':
                        openModal('rejectModalOverlay');
                        break;
                    case 'request-docs':
                        openModal('requestDocsModalOverlay');
                        break;
                    case 'history':
                        openModal('historyModalOverlay');
                        break;
                    case 'rejection-reason':
                        showToast('Rejection reason: Invalid GST/PAN details.', 'warn');
                        break;
                }
            });
        });

        document.querySelectorAll('.sims-verification-view-docs').forEach(function (btn) {
            btn.addEventListener('click', function () {
                openModal('reviewModalOverlay');
                selectTab('tab-docs');
            });
        });
    }

    /* ---------------------------------------------------------------------
       TOP HEADER BUTTONS
    --------------------------------------------------------------------- */
    function initTopButtons() {
        var btnHistory = document.getElementById('btnVerificationHistoryTop');
        var btnExport = document.getElementById('btnExportReport');

        if (btnHistory) {
            btnHistory.addEventListener('click', function () {
                openModal('historyModalOverlay');
            });
        }

        if (btnExport) {
            btnExport.addEventListener('click', function () {
                showToast('Preparing verification report for export...', 'success');
            });
        }
    }

    /* ---------------------------------------------------------------------
       DOCUMENT VIEW / REQUEST BUTTONS (inside review modal)
    --------------------------------------------------------------------- */
    function initDocumentButtons() {
        document.querySelectorAll('.sims-verification-doc-view').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var docName = btn.getAttribute('data-doc') || 'Document';
                var nameField = document.getElementById('docPreviewName');
                if (nameField) nameField.textContent = docName;
                openModal('docPreviewOverlay');
            });
        });

        var btnRequestMissing = document.getElementById('btnRequestMissingDoc');
        if (btnRequestMissing) {
            btnRequestMissing.addEventListener('click', function () {
                openModal('requestDocsModalOverlay');
            });
        }
    }

    /* ---------------------------------------------------------------------
       TABS INSIDE REVIEW MODAL
    --------------------------------------------------------------------- */
    function initTabs() {
        document.querySelectorAll('.sims-verification-tab-btn').forEach(function (tab) {
            tab.addEventListener('click', function () {
                selectTab(tab.getAttribute('data-tab'));
            });
        });
    }

    function selectTab(tabId) {
        document.querySelectorAll('.sims-verification-tab-btn').forEach(function (btn) {
            btn.classList.toggle('sims-verification-tab-active', btn.getAttribute('data-tab') === tabId);
        });
        document.querySelectorAll('.sims-verification-tab-panel').forEach(function (panel) {
            panel.classList.toggle('sims-verification-tab-active', panel.id === tabId);
        });
    }

    /* ---------------------------------------------------------------------
       VERIFICATION CHECKLIST -> ENABLE/DISABLE APPROVE BUTTON
    --------------------------------------------------------------------- */
    function initChecklist() {
        var checkboxes = document.querySelectorAll('#tab-checklist .sims-verification-check');
        var approveBtn = document.getElementById('btnOpenApproveFromReview');

        function evaluateChecklist() {
            if (!approveBtn) return;
            var allChecked = Array.prototype.every.call(checkboxes, function (cb) {
                return cb.checked;
            });
            approveBtn.disabled = !allChecked;
        }

        checkboxes.forEach(function (cb) {
            cb.addEventListener('change', evaluateChecklist);
        });

        evaluateChecklist();
    }

    /* ---------------------------------------------------------------------
       MODAL OPEN / CLOSE / OVERLAY / SCROLL LOCK / ESC / OUTSIDE CLICK
    --------------------------------------------------------------------- */
    function initModals() {
        // Close buttons (X and Cancel/Close footer buttons)
        document.querySelectorAll('[data-close]').forEach(function (btn) {
            btn.addEventListener('click', function () {
                closeModal(btn.getAttribute('data-close'));
            });
        });

        // Click outside modal content closes it
        document.querySelectorAll('.sims-verification-modal-overlay').forEach(function (overlay) {
            overlay.addEventListener('click', function (e) {
                if (e.target === overlay) {
                    closeModal(overlay.id);
                }
            });
        });

        // Escape key closes the topmost open modal
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                var openOverlay = document.querySelector('.sims-verification-modal-overlay.sims-verification-open');
                if (openOverlay) closeModal(openOverlay.id);
            }
        });

        // Approve from within review modal -> open approve confirmation
        var btnOpenApprove = document.getElementById('btnOpenApproveFromReview');
        if (btnOpenApprove) {
            btnOpenApprove.addEventListener('click', function () {
                if (btnOpenApprove.disabled) return;
                openModal('approveModalOverlay');
            });
        }

        var btnOpenReject = document.getElementById('btnOpenRejectFromReview');
        if (btnOpenReject) {
            btnOpenReject.addEventListener('click', function () {
                openModal('rejectModalOverlay');
            });
        }

        // Confirm actions (demo only)
        var btnConfirmApprove = document.getElementById('btnConfirmApprove');
        if (btnConfirmApprove) {
            btnConfirmApprove.addEventListener('click', function () {
                closeModal('approveModalOverlay');
                closeModal('reviewModalOverlay');
                showToast('Company verified successfully.', 'success');
            });
        }

        var btnConfirmReject = document.getElementById('btnConfirmReject');
        if (btnConfirmReject) {
            btnConfirmReject.addEventListener('click', function () {
                closeModal('rejectModalOverlay');
                closeModal('reviewModalOverlay');
                showToast('Company verification rejected.', 'warn');
            });
        }

        var btnConfirmRequestDocs = document.getElementById('btnConfirmRequestDocs');
        if (btnConfirmRequestDocs) {
            btnConfirmRequestDocs.addEventListener('click', function () {
                closeModal('requestDocsModalOverlay');
                showToast('Document request sent to company.', 'success');
            });
        }
    }

    function openModal(overlayId) {
        var overlay = document.getElementById(overlayId);
        if (!overlay) return;
        overlay.classList.add('sims-verification-open');
        document.body.classList.add('sims-verification-modal-open');
    }

    function closeModal(overlayId) {
        var overlay = document.getElementById(overlayId);
        if (!overlay) return;
        overlay.classList.remove('sims-verification-open');

        // Only unlock body scroll if no other modal remains open
        var anyOpen = document.querySelector('.sims-verification-modal-overlay.sims-verification-open');
        if (!anyOpen) {
            document.body.classList.remove('sims-verification-modal-open');
        }
    }

    /* ---------------------------------------------------------------------
       TOAST NOTIFICATION
    --------------------------------------------------------------------- */
    var toastTimer = null;

    function showToast(message, type) {
        var toast = document.getElementById('verificationToast');
        var msgEl = document.getElementById('verificationToastMessage');
        var icon = toast ? toast.querySelector('i') : null;
        if (!toast || !msgEl) return;

        msgEl.textContent = message;

        if (icon) {
            icon.className = type === 'warn' ? 'fas fa-triangle-exclamation' : 'fas fa-circle-check';
            icon.style.color = type === 'warn' ? '#d97706' : '#16a34a';
        }

        toast.classList.add('sims-verification-toast-show');

        if (toastTimer) clearTimeout(toastTimer);
        toastTimer = setTimeout(function () {
            toast.classList.remove('sims-verification-toast-show');
        }, 3200);
    }

})();

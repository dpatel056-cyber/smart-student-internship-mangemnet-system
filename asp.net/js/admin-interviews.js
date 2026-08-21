/* ==========================================================================
   SIMS – INTERVIEW MANAGEMENT PAGE JAVASCRIPT (Frontend / Demo only)
   ========================================================================== */

(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        initModals();
        initActionMenus();
        initBulkSelection();
        initFilters();
        initModeToggleInScheduleForm();
        initScheduleSubmit();
        initEscapeAndOutsideClick();
        initEmptyStateDemo();
    });

    /* ---------------- TOAST NOTIFICATIONS ---------------- */
    function showToast(message, type) {
        type = type || 'success';
        var container = document.getElementById('simsInterviewToastContainer');
        if (!container) {
            container = document.createElement('div');
            container.id = 'simsInterviewToastContainer';
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

        // Open triggers
        var openMap = {
            btnOpenSchedule: 'modalScheduleInterview'
        };
        Object.keys(openMap).forEach(function (btnId) {
            var btn = document.getElementById(btnId);
            if (btn) btn.addEventListener('click', function () { openModal(openMap[btnId]); });
        });

        // "View Details" buttons on upcoming cards
        document.querySelectorAll('.sims-interview-link-btn').forEach(function (btn) {
            btn.addEventListener('click', function () { openModal('modalViewInterview'); });
        });

        // Close buttons
        document.querySelectorAll('[data-close]').forEach(function (btn) {
            btn.addEventListener('click', closeAllModals);
        });

        if (overlay) overlay.addEventListener('click', closeAllModals);
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
        document.querySelectorAll('.sims-interview-modal.sims-active').forEach(function (m) {
            m.classList.remove('sims-active');
        });
        if (overlay) overlay.classList.remove('sims-active');
        document.body.classList.remove('modal-open');
    }

    function initEscapeAndOutsideClick() {
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeAllModals();
        });
    }

    /* ---------------- ROW ACTION MENUS (3-dot) ---------------- */
    function initActionMenus() {
        document.querySelectorAll('.sims-interview-action-toggle').forEach(function (toggle) {
            toggle.addEventListener('click', function (e) {
                e.stopPropagation();
                var dropdown = toggle.nextElementSibling;
                var wasOpen = dropdown.classList.contains('sims-open');
                closeAllActionMenus();
                if (!wasOpen) dropdown.classList.add('sims-open');
            });
        });

        document.addEventListener('click', closeAllActionMenus);

        // Wire up demo action links to relevant modals
        var actionModalMap = {
            'act-view': 'modalViewInterview',
            'act-edit': 'modalEditInterview',
            'act-reschedule': 'modalReschedule',
            'act-reminder': 'modalSendReminder',
            'act-cancel': 'modalCancelInterview',
            'act-schedule': 'modalScheduleInterview',
            'act-viewstudent': 'modalStudentQuickView',
            'act-viewcompany': 'modalCompanyQuickView',
            'act-delete': 'modalDeleteInterview'
        };

        document.querySelectorAll('.sims-interview-action-dropdown a').forEach(function (link) {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                var matchedClass = Object.keys(actionModalMap).find(function (cls) {
                    return link.classList.contains(cls);
                });
                closeAllActionMenus();
                if (matchedClass === 'act-viewinternship') {
                    showToast('Internship details would open here.', 'info');
                    return;
                }
                if (matchedClass && actionModalMap[matchedClass]) {
                    openModal(actionModalMap[matchedClass]);
                } else {
                    showToast('Action triggered (demo only).', 'info');
                }
            });
        });
    }

    function closeAllActionMenus() {
        document.querySelectorAll('.sims-interview-action-dropdown.sims-open').forEach(function (d) {
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

        document.querySelectorAll('.sims-interview-bulk-btn').forEach(function (btn) {
            btn.addEventListener('click', function () {
                showToast('Bulk action performed (demo only).', 'success');
            });
        });
    }

    /* ---------------- SEARCH / FILTERS / RESET ---------------- */
    function initFilters() {
        var searchBtn = document.getElementById('btnSearchInterviews');
        var resetBtn = document.getElementById('btnResetInterviews');
        var clearFiltersBtn = document.getElementById('btnClearFilters');
        var searchInput = document.getElementById('txtInterviewSearch');

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
            });
        }

        function resetFilters() {
            if (searchInput) searchInput.value = '';
            document.querySelectorAll('.sims-interview-filters .sims-interview-select').forEach(function (sel) {
                sel.selectedIndex = 0;
            });
            showToast('Filters reset.', 'info');
        }
    }

    /* ---------------- SCHEDULE MODAL: ONLINE/OFFLINE TOGGLE ---------------- */
    function initModeToggleInScheduleForm() {
        var modeSelect = document.querySelector('#modalScheduleInterview .sims-interview-mode-select');
        if (!modeSelect) return;
        var onlineFields = document.querySelectorAll('#modalScheduleInterview .sims-mode-online-field');
        var offlineFields = document.querySelectorAll('#modalScheduleInterview .sims-mode-offline-field');

        modeSelect.addEventListener('change', function () {
            var isOnline = modeSelect.value === 'Online';
            onlineFields.forEach(function (f) { f.style.display = isOnline ? '' : 'none'; });
            offlineFields.forEach(function (f) { f.style.display = isOnline ? 'none' : ''; });
        });
    }

    /* ---------------- SCHEDULE SUBMIT (DEMO) ---------------- */
    function initScheduleSubmit() {
        var btn = document.getElementById('btnSubmitSchedule');
        if (!btn) return;
        btn.addEventListener('click', function () {
            closeAllModals();
            showToast('Interview scheduled successfully (demo only).', 'success');
        });
    }

    /* ---------------- DEMO: SHOW EMPTY STATE WHEN SEARCH HAS NO MATCH ---------------- */
    function initEmptyStateDemo() {
        var searchInput = document.getElementById('txtInterviewSearch');
        var tableRows = document.querySelectorAll('.sims-interview-row');
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

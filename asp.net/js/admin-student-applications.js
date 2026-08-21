/* =========================================================
   SIMS - Student Applications Management Page
   Frontend-only demo behaviour (no backend calls yet)
========================================================= */
(function () {
    "use strict";

    document.addEventListener("DOMContentLoaded", function () {
        initActionDropdowns();
        initBulkSelection();
        initModals();
        initInterviewModeToggle();
        initFilters();
        initDemoStatusButtons();
    });

    /* ===================== ACTION DROPDOWNS ===================== */
    function initActionDropdowns() {
        document.querySelectorAll(".sims-application-action-menu").forEach(function (menu) {
            var trigger = menu.querySelector(".sims-app-action-trigger");
            if (!trigger) return;

            trigger.addEventListener("click", function (e) {
                e.stopPropagation();
                var isOpen = menu.classList.contains("open");
                closeAllActionMenus();
                if (!isOpen) {
                    menu.classList.add("open");
                }
            });
        });

        document.addEventListener("click", closeAllActionMenus);
        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") closeAllActionMenus();
        });

        // Wire up individual action items
        document.querySelectorAll(".sims-app-action-view").forEach(function (el) {
            el.addEventListener("click", function (e) {
                e.preventDefault();
                openModal("viewApplicationOverlay");
                closeAllActionMenus();
            });
        });

        document.querySelectorAll(".sims-app-action-schedule").forEach(function (el) {
            el.addEventListener("click", function (e) {
                e.preventDefault();
                openModal("scheduleInterviewOverlay");
                closeAllActionMenus();
            });
        });

        document.querySelectorAll(".sims-app-action-reject").forEach(function (el) {
            el.addEventListener("click", function (e) {
                e.preventDefault();
                openModal("rejectApplicationOverlay");
                closeAllActionMenus();
            });
        });

        document.querySelectorAll(".sims-app-action-shortlist").forEach(function (el) {
            el.addEventListener("click", function (e) {
                e.preventDefault();
                var row = el.closest("tr");
                if (row) setRowStatusDemo(row, "shortlisted");
                closeAllActionMenus();
            });
        });

        document.querySelectorAll(".sims-app-action-select").forEach(function (el) {
            el.addEventListener("click", function (e) {
                e.preventDefault();
                var row = el.closest("tr");
                if (row) setRowStatusDemo(row, "selected");
                closeAllActionMenus();
            });
        });

        document.querySelectorAll(".sims-app-action-resume, .sims-app-resume-btn").forEach(function (el) {
            el.addEventListener("click", function (e) {
                e.preventDefault();
                // Demo only - real implementation will open/download the actual resume file
                alert("Resume preview will open here once the backend is connected.");
                closeAllActionMenus();
            });
        });

        document.querySelectorAll(".sims-app-action-student").forEach(function (el) {
            el.addEventListener("click", function (e) {
                e.preventDefault();
                alert("This will navigate to the student's profile page.");
                closeAllActionMenus();
            });
        });
    }

    function closeAllActionMenus() {
        document.querySelectorAll(".sims-application-action-menu.open").forEach(function (menu) {
            menu.classList.remove("open");
        });
    }

    /* ===================== BULK SELECTION ===================== */
    function initBulkSelection() {
        var selectAll = document.getElementById("selectAllApplications");
        var rowCheckboxes = document.querySelectorAll(".sims-app-row-checkbox");
        var bulkToolbar = document.getElementById("bulkToolbar");
        var bulkCountEl = document.getElementById("bulkSelectedCount");

        function updateBulkToolbar() {
            var checkedCount = document.querySelectorAll(".sims-app-row-checkbox:checked").length;
            if (bulkCountEl) bulkCountEl.textContent = checkedCount;
            if (bulkToolbar) {
                if (checkedCount > 0) {
                    bulkToolbar.classList.add("active");
                } else {
                    bulkToolbar.classList.remove("active");
                }
            }
            if (selectAll) {
                selectAll.checked = checkedCount > 0 && checkedCount === rowCheckboxes.length;
            }
        }

        if (selectAll) {
            selectAll.addEventListener("change", function () {
                rowCheckboxes.forEach(function (cb) {
                    cb.checked = selectAll.checked;
                });
                updateBulkToolbar();
            });
        }

        rowCheckboxes.forEach(function (cb) {
            cb.addEventListener("change", updateBulkToolbar);
        });

        ["bulkShortlist", "bulkExport", "bulkReject", "bulkDelete"].forEach(function (id) {
            var btn = document.getElementById(id);
            if (!btn) return;
            btn.addEventListener("click", function () {
                var count = document.querySelectorAll(".sims-app-row-checkbox:checked").length;
                alert(count + " application(s) will be processed here once connected to the backend.");
            });
        });
    }

    /* ===================== MODALS ===================== */
    function initModals() {
        // Close buttons
        document.querySelectorAll("[data-close-modal]").forEach(function (btn) {
            btn.addEventListener("click", function () {
                closeModal(btn.getAttribute("data-close-modal"));
            });
        });

        // Click outside modal content closes it
        document.querySelectorAll(".sims-application-modal-overlay").forEach(function (overlay) {
            overlay.addEventListener("click", function (e) {
                if (e.target === overlay) {
                    closeModal(overlay.id);
                }
            });
        });

        // Escape key closes any open modal
        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") {
                var openOverlay = document.querySelector(".sims-application-modal-overlay.active");
                if (openOverlay) closeModal(openOverlay.id);
            }
        });

        // View modal footer buttons
        var viewShortlistBtn = document.getElementById("viewModalShortlistBtn");
        if (viewShortlistBtn) {
            viewShortlistBtn.addEventListener("click", function () {
                closeModal("viewApplicationOverlay");
                alert("Application shortlisted (demo only).");
            });
        }

        var viewRejectBtn = document.getElementById("viewModalRejectBtn");
        if (viewRejectBtn) {
            viewRejectBtn.addEventListener("click", function () {
                closeModal("viewApplicationOverlay");
                openModal("rejectApplicationOverlay");
            });
        }

        // Schedule interview confirm
        var confirmScheduleBtn = document.getElementById("confirmScheduleBtn");
        if (confirmScheduleBtn) {
            confirmScheduleBtn.addEventListener("click", function () {
                closeModal("scheduleInterviewOverlay");
                alert("Interview scheduled (demo only).");
            });
        }

        // Reject confirm
        var confirmRejectBtn = document.getElementById("confirmRejectBtn");
        if (confirmRejectBtn) {
            confirmRejectBtn.addEventListener("click", function () {
                closeModal("rejectApplicationOverlay");
                alert("Application rejected (demo only).");
            });
        }

        // Delete confirm
        var confirmDeleteBtn = document.getElementById("confirmDeleteBtn");
        if (confirmDeleteBtn) {
            confirmDeleteBtn.addEventListener("click", function () {
                closeModal("deleteApplicationOverlay");
                alert("Application deleted (demo only).");
            });
        }
    }

    function openModal(id) {
        var overlay = document.getElementById(id);
        if (!overlay) return;
        overlay.classList.add("active");
        document.body.classList.add("sims-modal-open");
    }

    function closeModal(id) {
        var overlay = document.getElementById(id);
        if (!overlay) return;
        overlay.classList.remove("active");

        // Only unlock body scroll if no other modal is open
        var anyOpen = document.querySelector(".sims-application-modal-overlay.active");
        if (!anyOpen) {
            document.body.classList.remove("sims-modal-open");
        }
    }

    /* ===================== INTERVIEW MODE TOGGLE ===================== */
    function initInterviewModeToggle() {
        var modeSelect = document.getElementById("interviewModeSelect");
        var meetingLinkField = document.getElementById("meetingLinkField");
        var locationField = document.getElementById("locationField");

        if (!modeSelect) return;

        modeSelect.addEventListener("change", function () {
            if (modeSelect.value === "online") {
                meetingLinkField.style.display = "";
                locationField.style.display = "none";
            } else {
                meetingLinkField.style.display = "none";
                locationField.style.display = "";
            }
        });
    }

    /* ===================== SEARCH / FILTERS ===================== */
    function initFilters() {
        var searchInput = document.getElementById("appSearchInput");
        var statusFilter = document.getElementById("filterStatus");
        var internshipFilter = document.getElementById("filterInternship");
        var companyFilter = document.getElementById("filterCompany");
        var dateFilter = document.getElementById("filterDate");
        var applyBtn = document.getElementById("btnApplyFilters");
        var resetBtn = document.getElementById("btnResetFilters");
        var clearEmptyBtn = document.getElementById("btnClearFiltersEmpty");
        var emptyState = document.getElementById("applicationsEmptyState");
        var tableScroll = document.querySelector(".sims-application-table-scroll table");

        function runFilter() {
            var term = (searchInput.value || "").trim().toLowerCase();
            var statusVal = statusFilter.value;
            var rows = document.querySelectorAll("#applicationsTableBody tr");
            var visibleCount = 0;

            rows.forEach(function (row) {
                var matchesStatus = statusVal === "all" || row.getAttribute("data-status") === statusVal;
                var rowText = row.textContent.toLowerCase();
                var matchesSearch = term === "" || rowText.indexOf(term) !== -1;

                var visible = matchesStatus && matchesSearch;
                row.style.display = visible ? "" : "none";
                if (visible) visibleCount++;
            });

            if (emptyState) {
                emptyState.style.display = visibleCount === 0 ? "block" : "none";
            }
            if (tableScroll) {
                tableScroll.style.display = visibleCount === 0 ? "none" : "table";
            }
        }

        if (applyBtn) applyBtn.addEventListener("click", runFilter);
        if (searchInput) {
            searchInput.addEventListener("keyup", function (e) {
                if (e.key === "Enter") runFilter();
            });
        }

        function resetFilters() {
            if (searchInput) searchInput.value = "";
            if (statusFilter) statusFilter.value = "all";
            if (internshipFilter) internshipFilter.value = "all";
            if (companyFilter) companyFilter.value = "all";
            if (dateFilter) dateFilter.value = "all";
            runFilter();
        }

        if (resetBtn) resetBtn.addEventListener("click", resetFilters);
        if (clearEmptyBtn) clearEmptyBtn.addEventListener("click", resetFilters);

        var advFiltersBtn = document.getElementById("btnAdvancedFilters");
        if (advFiltersBtn) {
            advFiltersBtn.addEventListener("click", function () {
                var panel = document.getElementById("applicationFiltersPanel");
                if (panel) panel.scrollIntoView({ behavior: "smooth", block: "start" });
            });
        }

        var exportBtn = document.getElementById("btnExportApplications");
        if (exportBtn) {
            exportBtn.addEventListener("click", function () {
                alert("Applications will be exported here once connected to the backend.");
            });
        }
    }

    /* ===================== DEMO STATUS CHANGE HELPERS ===================== */
    function initDemoStatusButtons() {
        // Placeholder hook kept for future wiring once backend endpoints exist.
    }

    function setRowStatusDemo(row, newStatus) {
        row.setAttribute("data-status", newStatus);
        var statusCell = row.querySelector(".sims-application-status");
        if (!statusCell) return;

        var statusMap = {
            pending: { cls: "sims-status-pending", icon: "fa-hourglass-half", label: "Pending" },
            shortlisted: { cls: "sims-status-shortlisted", icon: "fa-list-check", label: "Shortlisted" },
            selected: { cls: "sims-status-selected", icon: "fa-circle-check", label: "Selected" },
            rejected: { cls: "sims-status-rejected", icon: "fa-circle-xmark", label: "Rejected" }
        };

        var config = statusMap[newStatus];
        if (!config) return;

        statusCell.className = "sims-application-status " + config.cls;
        statusCell.innerHTML = '<i class="fa-solid ' + config.icon + '"></i> ' + config.label;
    }

})();

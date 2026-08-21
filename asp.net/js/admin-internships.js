/* =========================================================================
   SIMS - INTERNSHIP MANAGEMENT PAGE
   Frontend-only demo JavaScript (no backend / database calls)
========================================================================= */

(function () {
    "use strict";

    document.addEventListener("DOMContentLoaded", init);

    var ACTION_MENUS = {
        pending: [
            { action: "view", label: "View Internship", icon: "fa-eye" },
            { action: "edit", label: "Edit Internship", icon: "fa-pen" },
            { action: "approve", label: "Approve Internship", icon: "fa-check", cls: "sims-internship-action-success" },
            { action: "reject", label: "Reject Internship", icon: "fa-xmark", cls: "sims-internship-action-danger" },
            { action: "view-company", label: "View Company", icon: "fa-building" },
            { divider: true },
            { action: "delete", label: "Delete Internship", icon: "fa-trash", cls: "sims-internship-action-danger" }
        ],
        approved: [
            { action: "view", label: "View Internship", icon: "fa-eye" },
            { action: "edit", label: "Edit Internship", icon: "fa-pen" },
            { action: "activate", label: "Activate Internship", icon: "fa-bolt", cls: "sims-internship-action-success" },
            { action: "view-applications", label: "View Applications", icon: "fa-file-alt" },
            { action: "view-company", label: "View Company", icon: "fa-building" },
            { divider: true },
            { action: "close", label: "Close Internship", icon: "fa-lock", cls: "sims-internship-action-warn" }
        ],
        active: [
            { action: "view", label: "View Internship", icon: "fa-eye" },
            { action: "edit", label: "Edit Internship", icon: "fa-pen" },
            { action: "view-applications", label: "View Applications", icon: "fa-file-alt" },
            { action: "view-company", label: "View Company", icon: "fa-building" },
            { divider: true },
            { action: "close", label: "Close Internship", icon: "fa-lock", cls: "sims-internship-action-warn" }
        ],
        closed: [
            { action: "view", label: "View Internship", icon: "fa-eye" },
            { action: "edit", label: "Edit Internship", icon: "fa-pen" },
            { action: "view-applications", label: "View Applications", icon: "fa-file-alt" },
            { action: "view-company", label: "View Company", icon: "fa-building" },
            { action: "duplicate", label: "Duplicate Internship", icon: "fa-clone" },
            { divider: true },
            { action: "delete", label: "Delete Internship", icon: "fa-trash", cls: "sims-internship-action-danger" }
        ],
        rejected: [
            { action: "view", label: "View Internship", icon: "fa-eye" },
            { action: "edit", label: "Edit Internship", icon: "fa-pen" },
            { action: "view-company", label: "View Company", icon: "fa-building" },
            { divider: true },
            { action: "delete", label: "Delete Internship", icon: "fa-trash", cls: "sims-internship-action-danger" }
        ],
        draft: [
            { action: "view", label: "View Internship", icon: "fa-eye" },
            { action: "edit", label: "Edit Internship", icon: "fa-pen" },
            { action: "view-company", label: "View Company", icon: "fa-building" },
            { divider: true },
            { action: "delete", label: "Delete Internship", icon: "fa-trash", cls: "sims-internship-action-danger" }
        ]
    };

    var STATUS_META = {
        pending: { label: "Pending", icon: "fa-hourglass-half" },
        approved: { label: "Approved", icon: "fa-circle-check" },
        active: { label: "Active", icon: "fa-bolt" },
        closed: { label: "Closed", icon: "fa-lock" },
        rejected: { label: "Rejected", icon: "fa-ban" },
        draft: { label: "Draft", icon: "fa-file" }
    };

    var pendingRow = null; // row currently targeted by a confirmation modal

    function init() {
        buildActionMenus();
        bindHeaderActions();
        bindFilterActions();
        bindTableInteractions();
        bindBulkSelection();
        bindModalGenerics();
        bindConfirmationModals();
        bindQuickViews();
        bindFormModal();
        bindEmptyState();
        document.addEventListener("keydown", handleEscapeKey);
    }

    /* ===================== ACTION DROPDOWN MENUS ===================== */

    function buildActionMenus() {
        document.querySelectorAll("[data-status-menu]").forEach(function (menu) {
            var status = menu.getAttribute("data-status-menu");
            var items = ACTION_MENUS[status];
            if (!items) { return; }

            menu.innerHTML = "";
            items.forEach(function (item) {
                if (item.divider) {
                    var div = document.createElement("div");
                    div.className = "sims-internship-action-divider";
                    menu.appendChild(div);
                    return;
                }
                var a = document.createElement("a");
                a.href = "#";
                a.setAttribute("data-action", item.action);
                if (item.cls) { a.className = item.cls; }
                a.innerHTML = '<i class="fas ' + item.icon + '"></i> ' + item.label;
                menu.appendChild(a);
            });
        });
    }

    function bindTableInteractions() {
        document.querySelectorAll("[data-menu-trigger]").forEach(function (trigger) {
            trigger.addEventListener("click", function (e) {
                e.stopPropagation();
                var dropdown = trigger.nextElementSibling;
                var wasOpen = dropdown.classList.contains("sims-internship-open");
                closeAllDropdowns();
                if (!wasOpen) {
                    dropdown.classList.add("sims-internship-open");
                }
            });
        });

        document.addEventListener("click", closeAllDropdowns);

        // Row action clicks (dropdown items + inline links like company/applications)
        document.getElementById("internshipTableBody").addEventListener("click", function (e) {
            var link = e.target.closest("[data-action]");
            if (!link) { return; }
            e.preventDefault();
            var row = link.closest(".sims-internship-row");
            var action = link.getAttribute("data-action");
            closeAllDropdowns();
            handleRowAction(action, row);
        });
    }

    function closeAllDropdowns() {
        document.querySelectorAll(".sims-internship-action-dropdown.sims-internship-open").forEach(function (d) {
            d.classList.remove("sims-internship-open");
        });
    }

    function handleRowAction(action, row) {
        var title = row.querySelector(".sims-internship-cell-title").textContent;
        var id = row.getAttribute("data-id");
        var company = row.querySelector(".sims-internship-company-link").textContent;

        switch (action) {
            case "view":
                openModal("viewInternshipOverlay");
                break;
            case "edit":
                openFormModal("edit", { title: title, id: id, company: company });
                break;
            case "approve":
                pendingRow = row;
                openModal("approveInternshipOverlay");
                break;
            case "reject":
                pendingRow = row;
                openModal("rejectInternshipOverlay");
                break;
            case "activate":
                setRowStatus(row, "active");
                showToast("success", title + " has been activated.");
                break;
            case "close":
                pendingRow = row;
                openModal("closeInternshipOverlay");
                break;
            case "view-applications":
                openModal("applicationsQuickViewOverlay");
                break;
            case "view-company":
                openModal("companyQuickViewOverlay");
                break;
            case "duplicate":
                showToast("success", title + " has been duplicated as a draft.");
                break;
            case "delete":
                pendingRow = row;
                openModal("deleteInternshipOverlay");
                break;
            default:
                break;
        }
    }

    /* ===================== HEADER ACTIONS ===================== */

    function bindHeaderActions() {
        document.getElementById("btnAddInternship").addEventListener("click", function () {
            openFormModal("add");
        });

        document.getElementById("btnExportInternships").addEventListener("click", function () {
            showToast("success", "Internship list export started. This is a demo action.");
        });
    }

    /* ===================== SEARCH & FILTERS ===================== */

    function bindFilterActions() {
        document.getElementById("btnSearchInternships").addEventListener("click", function () {
            showToast("success", "Filters applied.");
        });

        document.getElementById("btnResetInternships").addEventListener("click", resetFilters);
        document.getElementById("btnClearFilters").addEventListener("click", resetFilters);
    }

    function resetFilters() {
        document.getElementById("txtInternshipSearch").value = "";
        ["ddlStatus", "ddlCompany", "ddlCategory", "ddlWorkMode", "ddlType", "ddlDatePosted"].forEach(function (id) {
            var el = document.getElementById(id);
            if (el) { el.selectedIndex = 0; }
        });
        showAllRows();
        showToast("success", "Filters have been reset.");
    }

    function bindEmptyState() {
        // Demo: typing "zzz" in the search box simulates a no-results state
        document.getElementById("txtInternshipSearch").addEventListener("input", function (e) {
            if (e.target.value.trim().toLowerCase() === "zzz") {
                showEmptyState();
            } else {
                showAllRows();
            }
        });
    }

    function showEmptyState() {
        document.getElementById("internshipTable").hidden = true;
        document.getElementById("internshipEmptyState").hidden = false;
    }

    function showAllRows() {
        document.getElementById("internshipTable").hidden = false;
        document.getElementById("internshipEmptyState").hidden = true;
    }

    /* ===================== BULK SELECTION ===================== */

    function bindBulkSelection() {
        var selectAll = document.getElementById("chkSelectAll");
        var rowChecks = document.querySelectorAll(".sims-internship-row-check");
        var toolbar = document.getElementById("bulkToolbar");
        var countEl = document.getElementById("bulkSelectedCount");

        selectAll.addEventListener("change", function () {
            rowChecks.forEach(function (cb) { cb.checked = selectAll.checked; });
            updateBulkToolbar();
        });

        rowChecks.forEach(function (cb) {
            cb.addEventListener("change", function () {
                var allChecked = Array.prototype.every.call(rowChecks, function (c) { return c.checked; });
                selectAll.checked = allChecked;
                updateBulkToolbar();
            });
        });

        function updateBulkToolbar() {
            var checkedCount = Array.prototype.filter.call(rowChecks, function (c) { return c.checked; }).length;
            countEl.textContent = checkedCount;
            toolbar.hidden = checkedCount === 0;
        }

        document.querySelectorAll("[data-bulk-action]").forEach(function (btn) {
            btn.addEventListener("click", function () {
                var action = btn.getAttribute("data-bulk-action");
                var checkedCount = Array.prototype.filter.call(rowChecks, function (c) { return c.checked; }).length;
                var messages = {
                    approve: "internships approved.",
                    activate: "internships activated.",
                    close: "internships closed.",
                    export: "internships exported.",
                    delete: "internships deleted."
                };
                showToast(action === "delete" ? "error" : "success", checkedCount + " " + messages[action]);
            });
        });
    }

    /* ===================== GENERIC MODAL OPEN/CLOSE ===================== */

    function openModal(overlayId) {
        var overlay = document.getElementById(overlayId);
        if (!overlay) { return; }
        overlay.hidden = false;
        document.body.classList.add("sims-internship-modal-open");
    }

    function closeModal(overlay) {
        overlay.hidden = true;
        var anyOpen = Array.prototype.some.call(
            document.querySelectorAll(".sims-internship-modal-overlay"),
            function (o) { return !o.hidden; }
        );
        if (!anyOpen) {
            document.body.classList.remove("sims-internship-modal-open");
        }
    }

    function bindModalGenerics() {
        document.querySelectorAll(".sims-internship-modal-overlay").forEach(function (overlay) {
            // click outside modal box closes it
            overlay.addEventListener("click", function (e) {
                if (e.target === overlay) {
                    closeModal(overlay);
                }
            });
        });

        document.querySelectorAll("[data-close-modal]").forEach(function (btn) {
            btn.addEventListener("click", function () {
                var overlay = btn.closest(".sims-internship-modal-overlay");
                closeModal(overlay);
            });
        });
    }

    function handleEscapeKey(e) {
        if (e.key !== "Escape") { return; }
        var openOverlay = document.querySelector(".sims-internship-modal-overlay:not([hidden])");
        if (openOverlay) {
            closeModal(openOverlay);
        }
    }

    /* ===================== CONFIRMATION MODALS ===================== */

    function bindConfirmationModals() {
        document.getElementById("btnConfirmApprove").addEventListener("click", function () {
            if (pendingRow) {
                setRowStatus(pendingRow, "approved");
            }
            closeModal(document.getElementById("approveInternshipOverlay"));
            showToast("success", "Internship approved successfully.");
            pendingRow = null;
        });

        document.getElementById("btnConfirmReject").addEventListener("click", function () {
            var reason = document.getElementById("fldRejectReason");
            if (!reason.value) {
                showToast("error", "Please select a rejection reason.");
                return;
            }
            if (pendingRow) {
                setRowStatus(pendingRow, "rejected");
            }
            closeModal(document.getElementById("rejectInternshipOverlay"));
            showToast("success", "Internship rejected.");
            pendingRow = null;
        });

        document.getElementById("btnConfirmClose").addEventListener("click", function () {
            if (pendingRow) {
                setRowStatus(pendingRow, "closed");
            }
            closeModal(document.getElementById("closeInternshipOverlay"));
            showToast("success", "Internship closed.");
            pendingRow = null;
        });

        document.getElementById("btnConfirmDelete").addEventListener("click", function () {
            if (pendingRow) {
                pendingRow.remove();
            }
            closeModal(document.getElementById("deleteInternshipOverlay"));
            showToast("error", "Internship deleted.");
            pendingRow = null;
        });
    }

    function setRowStatus(row, newStatus) {
        row.setAttribute("data-status", newStatus);

        var statusBadge = row.querySelector(".sims-internship-status");
        var meta = STATUS_META[newStatus];
        statusBadge.className = "sims-internship-status sims-internship-status-" + newStatus;
        statusBadge.innerHTML = '<i class="fas ' + meta.icon + '"></i> ' + meta.label;

        var menu = row.querySelector("[data-status-menu]");
        menu.setAttribute("data-status-menu", newStatus);
        buildActionMenus();
    }

    /* ===================== QUICK VIEWS ===================== */

    function bindQuickViews() {
        document.getElementById("btnViewAllApplications").addEventListener("click", function () {
            // Prepared navigation target — left as a demo action for now
            showToast("success", "Redirecting to admin-student-applications.aspx...");
            // window.location.href = "admin-student-applications.aspx";
        });

        document.getElementById("btnViewFullCompany").addEventListener("click", function () {
            showToast("success", "Redirecting to company profile...");
            // window.location.href = "admin-companies.aspx";
        });
    }

    /* ===================== ADD / EDIT FORM MODAL ===================== */

    function bindFormModal() {
        document.getElementById("skillPicker").addEventListener("click", function (e) {
            var chip = e.target.closest(".sims-internship-skill-chip");
            if (!chip) { return; }
            chip.classList.toggle("sims-internship-skill-chip-active");
        });

        document.getElementById("btnSaveInternship").addEventListener("click", function () {
            var title = document.getElementById("fldTitle").value.trim();
            var company = document.getElementById("fldCompany").value;
            var category = document.getElementById("fldCategory").value;

            if (!title || !company || !category) {
                showToast("error", "Please fill in all required fields.");
                return;
            }

            var isEdit = document.getElementById("internshipFormTitle").textContent.indexOf("Edit") !== -1;
            closeModal(document.getElementById("internshipFormOverlay"));
            showToast("success", isEdit ? "Internship updated successfully." : "Internship saved successfully.");
        });
    }

    function openFormModal(mode, data) {
        var titleEl = document.getElementById("internshipFormTitle");
        var saveBtn = document.getElementById("btnSaveInternship");

        if (mode === "edit") {
            titleEl.textContent = "Edit Internship";
            saveBtn.textContent = "Update Internship";
            prefillEditForm(data);
        } else {
            titleEl.textContent = "Add Internship";
            saveBtn.textContent = "Save Internship";
            document.getElementById("internshipForm").reset();
        }

        openModal("internshipFormOverlay");
    }

    function prefillEditForm(data) {
        document.getElementById("fldTitle").value = "Web Developer Intern";
        document.getElementById("fldCompany").value = "ABC Technologies";
        document.getElementById("fldCategory").value = "Web Development";
        document.getElementById("fldType").value = "Full Time";
        document.getElementById("fldWorkMode").value = "Hybrid";
        document.getElementById("fldLocation").value = "Ahmedabad, Gujarat";
        document.getElementById("fldDuration").value = "6 Months";
        document.getElementById("fldStartDate").value = "2026-09-01";
        document.getElementById("fldDeadline").value = "2026-08-30";
        document.getElementById("fldOpenings").value = "5";
        document.getElementById("fldStipendAmount").value = "₹10,000 / Month";
        document.getElementById("fldCgpa").value = "7.0";
        document.getElementById("fldStatus").value = "Active";
    }

    /* ===================== TOASTS ===================== */

    function showToast(type, message) {
        var container = document.getElementById("internshipToastContainer");
        var toast = document.createElement("div");
        toast.className = "sims-internship-toast " + (type === "success" ? "sims-internship-toast-success" : "sims-internship-toast-error");
        var icon = type === "success" ? "fa-circle-check" : "fa-circle-exclamation";
        toast.innerHTML = '<i class="fas ' + icon + '"></i><span>' + message + '</span>';
        container.appendChild(toast);

        setTimeout(function () {
            toast.style.opacity = "0";
            toast.style.transition = "opacity 0.25s ease";
            setTimeout(function () { toast.remove(); }, 250);
        }, 3200);
    }

})();

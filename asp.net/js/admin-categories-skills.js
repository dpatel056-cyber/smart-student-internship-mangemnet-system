/* =====================================================================
   SIMS – CATEGORIES & SKILLS MANAGEMENT PAGE
   Frontend/demo JavaScript only. No backend/database calls.
===================================================================== */
(function () {
    "use strict";

    document.addEventListener("DOMContentLoaded", function () {
        initModals();
        initCategorySearch();
        initSkillSearch();
        initActionDropdowns();
        initBulkSelection("category");
        initBulkSelection("skill");
        initCategoryActions();
        initSkillActions();
        initAddButtons();
        initEscapeAndOutsideClick();
        initFilterResets();
        initExportButton();
    });

    /* =====================================================================
       TOAST NOTIFICATIONS
    ===================================================================== */
    function showToast(message, type) {
        type = type || "info";
        var container = document.getElementById("simsToastContainer");
        if (!container) return;

        var iconMap = {
            success: "fa-circle-check",
            warning: "fa-triangle-exclamation",
            danger: "fa-circle-exclamation",
            info: "fa-circle-info"
        };

        var toast = document.createElement("div");
        toast.className = "sims-toast sims-toast-" + type;
        toast.innerHTML = '<i class="fas ' + (iconMap[type] || iconMap.info) + '"></i><span>' + message + "</span>";
        container.appendChild(toast);

        setTimeout(function () {
            toast.style.transition = "opacity 0.25s ease, transform 0.25s ease";
            toast.style.opacity = "0";
            toast.style.transform = "translateX(20px)";
            setTimeout(function () {
                if (toast.parentNode) toast.parentNode.removeChild(toast);
            }, 250);
        }, 3200);
    }

    /* =====================================================================
       MODAL OPEN / CLOSE (shared)
    ===================================================================== */
    function openModal(overlayId) {
        var overlay = document.getElementById(overlayId);
        if (!overlay) return;
        overlay.classList.add("sims-modal-visible");
        document.body.classList.add("modal-open");
    }

    function closeModal(overlayId) {
        var overlay = document.getElementById(overlayId);
        if (!overlay) return;
        overlay.classList.remove("sims-modal-visible");
        // Only unlock scroll if no other modal is open
        var anyOpen = document.querySelector(".sims-category-skill-modal-overlay.sims-modal-visible");
        if (!anyOpen) {
            document.body.classList.remove("modal-open");
        }
    }

    function initModals() {
        document.querySelectorAll("[data-close-modal]").forEach(function (btn) {
            btn.addEventListener("click", function () {
                closeModal(btn.getAttribute("data-close-modal"));
            });
        });

        // Clicking directly on the dark overlay (not the modal box) closes it
        document.querySelectorAll(".sims-category-skill-modal-overlay").forEach(function (overlay) {
            overlay.addEventListener("click", function (e) {
                if (e.target === overlay) {
                    overlay.classList.remove("sims-modal-visible");
                    var anyOpen = document.querySelector(".sims-category-skill-modal-overlay.sims-modal-visible");
                    if (!anyOpen) document.body.classList.remove("modal-open");
                }
            });
        });
    }

    function initEscapeAndOutsideClick() {
        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") {
                var openOverlay = document.querySelector(".sims-category-skill-modal-overlay.sims-modal-visible");
                if (openOverlay) {
                    closeModal(openOverlay.id);
                }
                // also close any open action dropdown
                closeAllActionMenus();
            }
        });

        document.addEventListener("click", function (e) {
            if (!e.target.closest(".sims-category-action-menu") && !e.target.closest(".sims-skill-action-menu")) {
                closeAllActionMenus();
            }
        });
    }

    /* =====================================================================
       ACTION DROPDOWN MENUS (three-dot)
    ===================================================================== */
    function closeAllActionMenus() {
        document.querySelectorAll(".sims-category-action-menu.sims-menu-active, .sims-skill-action-menu.sims-menu-active")
            .forEach(function (menu) {
                menu.classList.remove("sims-menu-active");
                var dd = menu.querySelector(".sims-action-dropdown");
                if (dd) dd.classList.remove("sims-open-up");
            });
    }

    function initActionDropdowns() {
        document.querySelectorAll(".sims-action-btn").forEach(function (btn) {
            btn.addEventListener("click", function (e) {
                e.stopPropagation();
                var menu = btn.closest(".sims-category-action-menu, .sims-skill-action-menu");
                var wasActive = menu.classList.contains("sims-menu-active");
                closeAllActionMenus();
                if (!wasActive) {
                    menu.classList.add("sims-menu-active");

                    // Prevent clipping: flip dropdown upward if not enough space below
                    var dropdown = menu.querySelector(".sims-action-dropdown");
                    var rect = btn.getBoundingClientRect();
                    var spaceBelow = window.innerHeight - rect.bottom;
                    if (spaceBelow < 260) {
                        dropdown.classList.add("sims-open-up");
                    } else {
                        dropdown.classList.remove("sims-open-up");
                    }
                }
            });
        });
    }

    /* =====================================================================
       CATEGORY SEARCH / FILTER
    ===================================================================== */
    function initCategorySearch() {
        var searchInput = document.getElementById("categorySearchInput");
        var statusFilter = document.getElementById("categoryStatusFilter");

        if (searchInput) searchInput.addEventListener("input", filterCategories);
        if (statusFilter) statusFilter.addEventListener("change", filterCategories);
    }

    function filterCategories() {
        var query = (document.getElementById("categorySearchInput").value || "").toLowerCase().trim();
        var status = document.getElementById("categoryStatusFilter").value;
        var rows = document.querySelectorAll("#categoryTableBody .sims-category-row");
        var visibleCount = 0;

        rows.forEach(function (row) {
            var name = (row.getAttribute("data-name") || "").toLowerCase();
            var code = (row.getAttribute("data-code") || "").toLowerCase();
            var desc = (row.getAttribute("data-description") || "").toLowerCase();
            var rowStatus = row.getAttribute("data-status");

            var matchesQuery = !query || name.indexOf(query) !== -1 || code.indexOf(query) !== -1 || desc.indexOf(query) !== -1;
            var matchesStatus = status === "all" || status === rowStatus;

            var visible = matchesQuery && matchesStatus;
            row.style.display = visible ? "" : "none";
            if (visible) visibleCount++;
        });

        document.getElementById("categoryEmptyState").style.display = visibleCount === 0 ? "flex" : "none";
        document.getElementById("categoryTable").style.display = visibleCount === 0 ? "none" : "table";
    }

    /* =====================================================================
       SKILL SEARCH / FILTER
    ===================================================================== */
    function initSkillSearch() {
        var searchInput = document.getElementById("skillSearchInput");
        var statusFilter = document.getElementById("skillStatusFilter");
        var typeFilter = document.getElementById("skillTypeFilter");

        if (searchInput) searchInput.addEventListener("input", filterSkills);
        if (statusFilter) statusFilter.addEventListener("change", filterSkills);
        if (typeFilter) typeFilter.addEventListener("change", filterSkills);
    }

    function filterSkills() {
        var query = (document.getElementById("skillSearchInput").value || "").toLowerCase().trim();
        var status = document.getElementById("skillStatusFilter").value;
        var type = document.getElementById("skillTypeFilter").value;
        var rows = document.querySelectorAll("#skillTableBody .sims-skill-row");
        var visibleCount = 0;

        rows.forEach(function (row) {
            var name = (row.getAttribute("data-name") || "").toLowerCase();
            var code = (row.getAttribute("data-code") || "").toLowerCase();
            var desc = (row.getAttribute("data-description") || "").toLowerCase();
            var rowStatus = row.getAttribute("data-status");
            var rowType = row.getAttribute("data-type");

            var matchesQuery = !query || name.indexOf(query) !== -1 || code.indexOf(query) !== -1 || desc.indexOf(query) !== -1;
            var matchesStatus = status === "all" || status === rowStatus;
            var matchesType = type === "all" || type === rowType;

            var visible = matchesQuery && matchesStatus && matchesType;
            row.style.display = visible ? "" : "none";
            if (visible) visibleCount++;
        });

        document.getElementById("skillEmptyState").style.display = visibleCount === 0 ? "flex" : "none";
        document.getElementById("skillTable").style.display = visibleCount === 0 ? "none" : "table";
    }

    function initFilterResets() {
        var resetCategory = document.getElementById("btnResetCategoryFilters");
        var clearCategory = document.getElementById("btnClearCategoryFilters");
        var resetSkill = document.getElementById("btnResetSkillFilters");
        var clearSkill = document.getElementById("btnClearSkillFilters");

        function resetCategoryFilters() {
            document.getElementById("categorySearchInput").value = "";
            document.getElementById("categoryStatusFilter").value = "all";
            filterCategories();
        }

        function resetSkillFilters() {
            document.getElementById("skillSearchInput").value = "";
            document.getElementById("skillStatusFilter").value = "all";
            document.getElementById("skillTypeFilter").value = "all";
            filterSkills();
        }

        if (resetCategory) resetCategory.addEventListener("click", resetCategoryFilters);
        if (clearCategory) clearCategory.addEventListener("click", resetCategoryFilters);
        if (resetSkill) resetSkill.addEventListener("click", resetSkillFilters);
        if (clearSkill) clearSkill.addEventListener("click", resetSkillFilters);
    }

    /* =====================================================================
       BULK SELECTION (shared logic for category & skill tables)
    ===================================================================== */
    function initBulkSelection(target) {
        var isCategory = target === "category";
        var selectAllId = isCategory ? "categorySelectAll" : "skillSelectAll";
        var toolbarId = isCategory ? "categoryBulkToolbar" : "skillBulkToolbar";
        var countId = isCategory ? "categorySelectedCount" : "skillSelectedCount";
        var bodyId = isCategory ? "categoryTableBody" : "skillTableBody";

        var selectAll = document.getElementById(selectAllId);
        var toolbar = document.getElementById(toolbarId);
        var countEl = document.getElementById(countId);
        var body = document.getElementById(bodyId);

        function updateToolbar() {
            var checked = body.querySelectorAll(".sims-row-check:checked");
            countEl.textContent = checked.length;
            toolbar.style.display = checked.length > 0 ? "flex" : "none";
        }

        if (selectAll) {
            selectAll.addEventListener("change", function () {
                body.querySelectorAll(".sims-row-check").forEach(function (cb) {
                    var row = cb.closest("tr");
                    if (row.style.display !== "none") {
                        cb.checked = selectAll.checked;
                    }
                });
                updateToolbar();
            });
        }

        body.addEventListener("change", function (e) {
            if (e.target.classList.contains("sims-row-check")) {
                updateToolbar();
            }
        });

        // Bulk action buttons
        document.querySelectorAll('[data-bulk-action][data-target="' + target + '"]').forEach(function (btn) {
            btn.addEventListener("click", function () {
                var action = btn.getAttribute("data-bulk-action");
                var checked = body.querySelectorAll(".sims-row-check:checked");
                var count = checked.length;
                var label = isCategory ? "categories" : "skills";

                if (action === "activate") {
                    showToast(count + " " + label + " activated (demo only).", "success");
                } else if (action === "deactivate") {
                    showToast(count + " " + label + " deactivated (demo only).", "warning");
                } else if (action === "export") {
                    showToast(count + " " + label + " exported (demo only).", "info");
                } else if (action === "delete") {
                    showToast(count + " " + label + " deleted (demo only).", "danger");
                }

                checked.forEach(function (cb) { cb.checked = false; });
                if (selectAll) selectAll.checked = false;
                updateToolbar();
            });
        });
    }

    /* =====================================================================
       ADD CATEGORY / ADD SKILL BUTTONS (header + section shortcuts)
    ===================================================================== */
    function initAddButtons() {
        ["btnOpenAddCategory", "btnOpenAddCategory2"].forEach(function (id) {
            var btn = document.getElementById(id);
            if (btn) btn.addEventListener("click", function () { openAddCategoryModal(); });
        });

        ["btnOpenAddSkill", "btnOpenAddSkill2"].forEach(function (id) {
            var btn = document.getElementById(id);
            if (btn) btn.addEventListener("click", function () { openAddSkillModal(); });
        });

        var saveCategoryBtn = document.getElementById("btnSaveCategory");
        if (saveCategoryBtn) {
            saveCategoryBtn.addEventListener("click", function () {
                var name = document.getElementById("categoryNameInput").value.trim();
                var code = document.getElementById("categoryCodeInput").value.trim();
                var desc = document.getElementById("categoryDescInput").value.trim();

                if (!name || !code || !desc) {
                    showToast("Please fill in all required fields.", "warning");
                    return;
                }

                var isEdit = saveCategoryBtn.getAttribute("data-mode") === "edit";
                showToast(isEdit ? "Category updated successfully (demo only)." : "Category saved successfully (demo only).", "success");
                closeModal("categoryFormModalOverlay");
            });
        }

        var saveSkillBtn = document.getElementById("btnSaveSkill");
        if (saveSkillBtn) {
            saveSkillBtn.addEventListener("click", function () {
                var name = document.getElementById("skillNameInput").value.trim();
                var code = document.getElementById("skillCodeInput").value.trim();

                if (!name || !code) {
                    showToast("Please fill in all required fields.", "warning");
                    return;
                }

                var isEdit = saveSkillBtn.getAttribute("data-mode") === "edit";
                showToast(isEdit ? "Skill updated successfully (demo only)." : "Skill saved successfully (demo only).", "success");
                closeModal("skillFormModalOverlay");
            });
        }
    }

    function openAddCategoryModal() {
        document.getElementById("categoryFormModalTitle").textContent = "Add Internship Category";
        document.getElementById("btnSaveCategory").textContent = "Save Category";
        document.getElementById("btnSaveCategory").removeAttribute("data-mode");
        document.getElementById("categoryForm").reset();
        openModal("categoryFormModalOverlay");
    }

    function openEditCategoryModal(row) {
        document.getElementById("categoryFormModalTitle").textContent = "Edit Internship Category";
        document.getElementById("btnSaveCategory").textContent = "Update Category";
        document.getElementById("btnSaveCategory").setAttribute("data-mode", "edit");

        document.getElementById("categoryNameInput").value = row.getAttribute("data-name") || "";
        document.getElementById("categoryCodeInput").value = row.getAttribute("data-code") || "";
        document.getElementById("categoryDescInput").value = row.getAttribute("data-description") || "";
        document.getElementById("categoryStatusInput").value = row.getAttribute("data-status") || "active";

        openModal("categoryFormModalOverlay");
    }

    function openAddSkillModal() {
        document.getElementById("skillFormModalTitle").textContent = "Add Skill";
        document.getElementById("btnSaveSkill").textContent = "Save Skill";
        document.getElementById("btnSaveSkill").removeAttribute("data-mode");
        document.getElementById("skillForm").reset();
        openModal("skillFormModalOverlay");
    }

    function openEditSkillModal(row) {
        document.getElementById("skillFormModalTitle").textContent = "Edit Skill";
        document.getElementById("btnSaveSkill").textContent = "Update Skill";
        document.getElementById("btnSaveSkill").setAttribute("data-mode", "edit");

        document.getElementById("skillNameInput").value = row.getAttribute("data-name") || "";
        document.getElementById("skillCodeInput").value = row.getAttribute("data-code") || "";
        document.getElementById("skillTypeInput").value = row.getAttribute("data-type") || "technical";
        document.getElementById("skillDescInput").value = row.getAttribute("data-description") || "";
        document.getElementById("skillStatusInput").value = row.getAttribute("data-status") || "active";

        openModal("skillFormModalOverlay");
    }

    /* =====================================================================
       CATEGORY ROW ACTIONS (view / edit / activate / deactivate / delete)
    ===================================================================== */
    var activeCategoryRow = null;
    var activeSkillRow = null;

    function initCategoryActions() {
        document.querySelectorAll("#categoryTableBody .sims-action-item").forEach(function (item) {
            item.addEventListener("click", function (e) {
                e.preventDefault();
                var row = item.closest(".sims-category-row");
                var action = item.getAttribute("data-action");
                activeCategoryRow = row;
                closeAllActionMenus();

                if (action === "view") {
                    openViewCategoryModal(row);
                } else if (action === "edit") {
                    openEditCategoryModal(row);
                } else if (action === "activate" || action === "deactivate") {
                    openCategoryStatusModal(row, action);
                } else if (action === "view-internships") {
                    showToast('Opening internships for "' + row.getAttribute("data-name") + '" (demo only).', "info");
                } else if (action === "delete") {
                    openDeleteCategoryModal(row);
                }
            });
        });

        var confirmStatusBtn = document.getElementById("btnConfirmCategoryStatus");
        if (confirmStatusBtn) {
            confirmStatusBtn.addEventListener("click", function () {
                if (!activeCategoryRow) return;
                var pendingAction = confirmStatusBtn.getAttribute("data-pending-action");
                var name = activeCategoryRow.getAttribute("data-name");

                if (pendingAction === "activate") {
                    showToast('"' + name + '" activated successfully (demo only).', "success");
                } else {
                    showToast('"' + name + '" deactivated successfully (demo only).', "warning");
                }
                closeModal("categoryStatusModalOverlay");
            });
        }

        var confirmDeleteBtn = document.getElementById("btnConfirmDeleteCategory");
        if (confirmDeleteBtn) {
            confirmDeleteBtn.addEventListener("click", function () {
                if (!activeCategoryRow) return;
                showToast('"' + activeCategoryRow.getAttribute("data-name") + '" deleted successfully (demo only).', "danger");
                closeModal("categoryDeleteModalOverlay");
            });
        }

        var viewAssocBtn = document.getElementById("btnViewAssociatedInternships");
        if (viewAssocBtn) {
            viewAssocBtn.addEventListener("click", function () {
                showToast("Opening associated internships (demo only).", "info");
            });
        }

        var viewCategoryInternshipsBtn = document.getElementById("btnViewCategoryInternships");
        if (viewCategoryInternshipsBtn) {
            viewCategoryInternshipsBtn.addEventListener("click", function () {
                showToast("Opening internships list (demo only).", "info");
            });
        }
    }

    function openViewCategoryModal(row) {
        document.getElementById("viewCategoryName").textContent = row.getAttribute("data-name");
        document.getElementById("viewCategoryCode").textContent = row.getAttribute("data-code");
        document.getElementById("viewCategoryDesc").textContent = row.getAttribute("data-description");
        document.getElementById("viewCategoryCreated").textContent = row.getAttribute("data-created");
        document.getElementById("viewCategoryTotalInternships").textContent = row.getAttribute("data-internships");
        document.getElementById("viewCategoryTotalApplications").textContent = row.getAttribute("data-students");

        var status = row.getAttribute("data-status");
        var statusHtml = status === "active"
            ? '<span class="sims-category-status sims-status-active"><i class="fas fa-circle"></i> Active</span>'
            : '<span class="sims-category-status sims-status-inactive"><i class="fas fa-circle"></i> Inactive</span>';
        document.getElementById("viewCategoryStatus").innerHTML = statusHtml;

        openModal("categoryViewModalOverlay");
    }

    function openCategoryStatusModal(row, action) {
        var isActivate = action === "activate";
        document.getElementById("categoryStatusModalTitle").textContent = isActivate ? "Activate Category" : "Deactivate Category";
        document.getElementById("categoryStatusModalMessage").textContent = isActivate
            ? "Are you sure you want to activate this category?"
            : "Are you sure you want to deactivate this category?";

        var warningBox = document.getElementById("categoryStatusModalWarning");
        warningBox.style.display = isActivate ? "none" : "flex";

        var confirmBtn = document.getElementById("btnConfirmCategoryStatus");
        confirmBtn.textContent = isActivate ? "Activate" : "Deactivate";
        confirmBtn.className = "sims-btn " + (isActivate ? "sims-btn-primary" : "sims-btn-warning");
        confirmBtn.setAttribute("data-pending-action", action);

        openModal("categoryStatusModalOverlay");
    }

    function openDeleteCategoryModal(row) {
        var name = row.getAttribute("data-name");
        var internshipCount = parseInt(row.getAttribute("data-internships"), 10) || 0;

        document.getElementById("deleteCategoryName").textContent = name;
        document.getElementById("deleteCategoryInternshipCount").textContent = internshipCount;

        var blocked = internshipCount > 0;
        document.getElementById("categoryDeleteBlocked").style.display = blocked ? "flex" : "none";
        document.getElementById("categoryDeleteWarning").style.display = blocked ? "none" : "flex";
        document.getElementById("btnViewAssociatedInternships").style.display = blocked ? "inline-flex" : "none";
        document.getElementById("btnConfirmDeleteCategory").style.display = blocked ? "none" : "inline-flex";

        openModal("categoryDeleteModalOverlay");
    }

    /* =====================================================================
       SKILL ROW ACTIONS (view / edit / activate / deactivate / delete)
    ===================================================================== */
    function initSkillActions() {
        document.querySelectorAll("#skillTableBody .sims-action-item").forEach(function (item) {
            item.addEventListener("click", function (e) {
                e.preventDefault();
                var row = item.closest(".sims-skill-row");
                var action = item.getAttribute("data-action");
                activeSkillRow = row;
                closeAllActionMenus();

                if (action === "view") {
                    openViewSkillModal(row);
                } else if (action === "edit") {
                    openEditSkillModal(row);
                } else if (action === "activate" || action === "deactivate") {
                    openSkillStatusModal(row, action);
                } else if (action === "view-internships") {
                    showToast('Opening internships for "' + row.getAttribute("data-name") + '" (demo only).', "info");
                } else if (action === "view-students") {
                    showToast('Opening students for "' + row.getAttribute("data-name") + '" (demo only).', "info");
                } else if (action === "delete") {
                    openDeleteSkillModal(row);
                }
            });
        });

        var confirmStatusBtn = document.getElementById("btnConfirmSkillStatus");
        if (confirmStatusBtn) {
            confirmStatusBtn.addEventListener("click", function () {
                if (!activeSkillRow) return;
                var pendingAction = confirmStatusBtn.getAttribute("data-pending-action");
                var name = activeSkillRow.getAttribute("data-name");

                if (pendingAction === "activate") {
                    showToast('"' + name + '" activated successfully (demo only).', "success");
                } else {
                    showToast('"' + name + '" deactivated successfully (demo only).', "warning");
                }
                closeModal("skillStatusModalOverlay");
            });
        }

        var confirmDeleteBtn = document.getElementById("btnConfirmDeleteSkill");
        if (confirmDeleteBtn) {
            confirmDeleteBtn.addEventListener("click", function () {
                if (!activeSkillRow) return;
                showToast('"' + activeSkillRow.getAttribute("data-name") + '" deleted successfully (demo only).', "danger");
                closeModal("skillDeleteModalOverlay");
            });
        }

        var viewAssocBtn = document.getElementById("btnViewAssociatedRecords");
        if (viewAssocBtn) {
            viewAssocBtn.addEventListener("click", function () {
                showToast("Opening associated records (demo only).", "info");
            });
        }

        var viewSkillInternshipsBtn = document.getElementById("btnViewSkillInternships");
        if (viewSkillInternshipsBtn) {
            viewSkillInternshipsBtn.addEventListener("click", function () {
                showToast("Opening internships list (demo only).", "info");
            });
        }

        var viewSkillStudentsBtn = document.getElementById("btnViewSkillStudents");
        if (viewSkillStudentsBtn) {
            viewSkillStudentsBtn.addEventListener("click", function () {
                showToast("Opening students list (demo only).", "info");
            });
        }
    }

    function openViewSkillModal(row) {
        document.getElementById("viewSkillName").textContent = row.getAttribute("data-name");
        document.getElementById("viewSkillCode").textContent = row.getAttribute("data-code");
        document.getElementById("viewSkillDesc").textContent = row.getAttribute("data-description");
        document.getElementById("viewSkillCreated").textContent = row.getAttribute("data-created");
        document.getElementById("viewSkillInternships").textContent = row.getAttribute("data-internships");
        document.getElementById("viewSkillStudents").textContent = row.getAttribute("data-students");

        var type = row.getAttribute("data-type");
        var typeLabelMap = {
            "technical": "Technical",
            "framework": "Framework",
            "database": "Database",
            "soft-skill": "Soft Skill",
            "tool": "Tool",
            "other": "Other"
        };
        document.getElementById("viewSkillType").innerHTML =
            '<span class="sims-skill-type sims-type-' + type + '">' + (typeLabelMap[type] || "Other") + "</span>";

        var status = row.getAttribute("data-status");
        var statusHtml = status === "active"
            ? '<span class="sims-skill-status sims-status-active"><i class="fas fa-circle"></i> Active</span>'
            : '<span class="sims-skill-status sims-status-inactive"><i class="fas fa-circle"></i> Inactive</span>';
        document.getElementById("viewSkillStatus").innerHTML = statusHtml;

        openModal("skillViewModalOverlay");
    }

    function openSkillStatusModal(row, action) {
        var isActivate = action === "activate";
        document.getElementById("skillStatusModalTitle").textContent = isActivate ? "Activate Skill" : "Deactivate Skill";
        document.getElementById("skillStatusModalMessage").textContent = isActivate
            ? "Are you sure you want to activate this skill?"
            : "Are you sure you want to deactivate this skill?";

        var warningBox = document.getElementById("skillStatusModalWarning");
        warningBox.style.display = isActivate ? "none" : "flex";

        var confirmBtn = document.getElementById("btnConfirmSkillStatus");
        confirmBtn.textContent = isActivate ? "Activate" : "Deactivate";
        confirmBtn.className = "sims-btn " + (isActivate ? "sims-btn-primary" : "sims-btn-warning");
        confirmBtn.setAttribute("data-pending-action", action);

        openModal("skillStatusModalOverlay");
    }

    function openDeleteSkillModal(row) {
        var name = row.getAttribute("data-name");
        var internshipCount = parseInt(row.getAttribute("data-internships"), 10) || 0;
        var studentCount = row.getAttribute("data-students") || "0";

        document.getElementById("deleteSkillName").textContent = name;
        document.getElementById("deleteSkillInternshipCount").textContent = internshipCount;
        document.getElementById("deleteSkillStudentCount").textContent = studentCount;

        var blocked = internshipCount > 0;
        document.getElementById("skillDeleteBlocked").style.display = blocked ? "flex" : "none";
        document.getElementById("skillDeleteWarning").style.display = blocked ? "none" : "flex";
        document.getElementById("btnViewAssociatedRecords").style.display = blocked ? "inline-flex" : "none";
        document.getElementById("btnConfirmDeleteSkill").style.display = blocked ? "none" : "inline-flex";

        openModal("skillDeleteModalOverlay");
    }

    /* =====================================================================
       EXPORT DATA (demo)
    ===================================================================== */
    function initExportButton() {
        var btn = document.getElementById("btnExportData");
        if (btn) {
            btn.addEventListener("click", function () {
                showToast("Preparing export of categories & skills data (demo only).", "info");
            });
        }
    }

})();

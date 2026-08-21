/* ==========================================================
   SIMS ADMIN - NOTIFICATION MANAGEMENT JS (Frontend Demo Only)
========================================================== */
(function () {
    "use strict";

    document.addEventListener("DOMContentLoaded", function () {

        /* ---------- MODAL HELPERS ---------- */
        function openModal(id) {
            var overlay = document.getElementById(id);
            if (!overlay) return;
            overlay.classList.add("show");
            document.body.classList.add("modal-open");
        }
        function closeModal(id) {
            var overlay = document.getElementById(id);
            if (!overlay) return;
            overlay.classList.remove("show");
            var anyOpen = document.querySelector(".sims-notification-modal-overlay.show");
            if (!anyOpen) document.body.classList.remove("modal-open");
        }
        function closeAllModals() {
            document.querySelectorAll(".sims-notification-modal-overlay.show").forEach(function (el) {
                el.classList.remove("show");
            });
            document.body.classList.remove("modal-open");
        }

        // Close buttons
        document.querySelectorAll("[data-close]").forEach(function (btn) {
            btn.addEventListener("click", function () {
                closeModal(btn.getAttribute("data-close"));
            });
        });

        // Click outside modal closes it
        document.querySelectorAll(".sims-notification-modal-overlay").forEach(function (overlay) {
            overlay.addEventListener("click", function (e) {
                if (e.target === overlay) {
                    overlay.classList.remove("show");
                    var anyOpen = document.querySelector(".sims-notification-modal-overlay.show");
                    if (!anyOpen) document.body.classList.remove("modal-open");
                }
            });
        });

        // Escape key closes topmost modal
        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") {
                var openModals = document.querySelectorAll(".sims-notification-modal-overlay.show");
                if (openModals.length) {
                    openModals[openModals.length - 1].classList.remove("show");
                    var anyOpen = document.querySelector(".sims-notification-modal-overlay.show");
                    if (!anyOpen) document.body.classList.remove("modal-open");
                }
            }
        });

        /* ---------- TOASTS ---------- */
        function showToast(message, type) {
            var container = document.getElementById("toastContainer");
            if (!container) return;
            var toast = document.createElement("div");
            toast.className = "sims-notification-toast" + (type ? " " + type : "");
            var icon = type === "success" ? "fa-circle-check" : (type === "error" ? "fa-circle-exclamation" : "fa-circle-info");
            toast.innerHTML = '<i class="fa-solid ' + icon + '"></i><span>' + message + "</span>";
            container.appendChild(toast);
            setTimeout(function () {
                toast.style.opacity = "0";
                setTimeout(function () { toast.remove(); }, 200);
            }, 2800);
        }

        /* ---------- HEADER / QUICK ACTION BUTTONS ---------- */
        var btnCreate = document.getElementById("btnCreateNotification");
        if (btnCreate) btnCreate.addEventListener("click", function () {
            document.getElementById("createModalTitle").textContent = "Create Notification";
            document.getElementById("sentEditWarning").style.display = "none";
            openModal("modalCreate");
        });

        var btnTemplates = document.getElementById("btnTemplates");
        if (btnTemplates) btnTemplates.addEventListener("click", function () { openModal("modalTemplates"); });

        var qaTemplates = document.getElementById("qaTemplates");
        if (qaTemplates) qaTemplates.addEventListener("click", function () { openModal("modalTemplates"); });

        var qaSend = document.getElementById("qaSend");
        if (qaSend) qaSend.addEventListener("click", function () { openModal("modalCreate"); });

        var qaSchedule = document.getElementById("qaSchedule");
        if (qaSchedule) qaSchedule.addEventListener("click", function () { openModal("modalSchedule"); });

        var qaHistory = document.getElementById("qaHistory");
        if (qaHistory) qaHistory.addEventListener("click", function () { showToast("Loading notification history...", "info"); });

        var btnExport = document.getElementById("btnExport");
        if (btnExport) btnExport.addEventListener("click", function () { showToast("Exporting notifications (demo)", "success"); });

        var btnCreateTemplate = document.getElementById("btnCreateTemplate");
        if (btnCreateTemplate) btnCreateTemplate.addEventListener("click", function () { openModal("modalCreateTemplate"); });

        /* ---------- CREATE MODAL DYNAMIC FIELDS ---------- */
        var ddlRecipientType = document.getElementById("ddlCreateRecipientType");
        var specificUserField = document.getElementById("specificUserField");
        if (ddlRecipientType) ddlRecipientType.addEventListener("change", function () {
            specificUserField.style.display = (this.value === "Specific User") ? "block" : "none";
        });

        var rbImmediate = document.getElementById("rbImmediate");
        var rbSchedule = document.getElementById("rbSchedule");
        var scheduleDateField = document.getElementById("scheduleDateField");
        var scheduleTimeField = document.getElementById("scheduleTimeField");
        function toggleScheduleFields() {
            var show = rbSchedule && rbSchedule.checked;
            scheduleDateField.style.display = show ? "block" : "none";
            scheduleTimeField.style.display = show ? "block" : "none";
        }
        if (rbImmediate) rbImmediate.addEventListener("change", toggleScheduleFields);
        if (rbSchedule) rbSchedule.addEventListener("change", toggleScheduleFields);

        /* ---------- CHARACTER COUNTER ---------- */
        var txtMessage = document.getElementById("txtMessage");
        var charCount = document.getElementById("charCount");
        if (txtMessage && charCount) {
            txtMessage.addEventListener("input", function () {
                charCount.textContent = this.value.length;
            });
        }

        /* ---------- PREVIEW ---------- */
        var btnPreview = document.getElementById("btnPreviewNotification");
        if (btnPreview) btnPreview.addEventListener("click", function () {
            var titleInput = document.querySelector("#modalCreate .sims-notification-input");
            var previewTitle = document.getElementById("previewTitle");
            var previewMessage = document.getElementById("previewMessage");
            if (titleInput && titleInput.value.trim() !== "") previewTitle.textContent = titleInput.value;
            if (txtMessage && txtMessage.value.trim() !== "") previewMessage.textContent = txtMessage.value;
            openModal("modalPreview");
        });

        /* ---------- SAVE / SEND FROM CREATE MODAL ---------- */
        var btnSaveDraft = document.getElementById("btnSaveDraft");
        if (btnSaveDraft) btnSaveDraft.addEventListener("click", function () {
            closeModal("modalCreate");
            showToast("Notification saved as draft (demo)", "success");
        });

        var btnSendNotification = document.getElementById("btnSendNotification");
        if (btnSendNotification) btnSendNotification.addEventListener("click", function () {
            closeModal("modalCreate");
            openModal("modalSendNow");
        });

        // Send Now modal confirm button (last button in footer)
        var sendNowFooterBtns = document.querySelectorAll("#modalSendNow .sims-notification-btn-primary");
        sendNowFooterBtns.forEach(function (btn) {
            btn.addEventListener("click", function () {
                closeModal("modalSendNow");
                showToast("Notification sent successfully (demo)", "success");
            });
        });

        /* ---------- SEARCH / FILTER / RESET ---------- */
        var btnSearch = document.getElementById("btnSearch");
        if (btnSearch) btnSearch.addEventListener("click", function () {
            showToast("Filters applied (demo)", "info");
        });

        var btnReset = document.getElementById("btnReset");
        function resetFilters() {
            ["txtSearch"].forEach(function (id) {
                var el = document.getElementById(id);
                if (el) el.value = "";
            });
            ["ddlStatus", "ddlRecipient", "ddlType", "ddlPriority", "ddlDate"].forEach(function (id) {
                var el = document.getElementById(id);
                if (el) el.selectedIndex = 0;
            });
            document.getElementById("emptyState").style.display = "none";
            document.getElementById("notificationTable").style.display = "table";
        }
        if (btnReset) btnReset.addEventListener("click", resetFilters);

        var btnClearFilters = document.getElementById("btnClearFilters");
        if (btnClearFilters) btnClearFilters.addEventListener("click", resetFilters);

        /* ---------- SELECT ALL / BULK TOOLBAR ---------- */
        var chkSelectAll = document.getElementById("chkSelectAll");
        var rowChks = document.querySelectorAll(".rowChk");
        var bulkToolbar = document.getElementById("bulkToolbar");
        var bulkCount = document.getElementById("bulkCount");

        function updateBulkToolbar() {
            var checked = document.querySelectorAll(".rowChk:checked").length;
            bulkCount.textContent = checked;
            bulkToolbar.style.display = checked > 0 ? "flex" : "none";
        }
        if (chkSelectAll) chkSelectAll.addEventListener("change", function () {
            rowChks.forEach(function (chk) { chk.checked = chkSelectAll.checked; });
            updateBulkToolbar();
        });
        rowChks.forEach(function (chk) {
            chk.addEventListener("change", updateBulkToolbar);
        });

        ["bulkSend", "bulkRetry", "bulkCancel", "bulkExport", "bulkDelete"].forEach(function (id) {
            var el = document.getElementById(id);
            if (el) el.addEventListener("click", function () {
                showToast("Bulk action performed (demo)", "success");
                rowChks.forEach(function (chk) { chk.checked = false; });
                if (chkSelectAll) chkSelectAll.checked = false;
                updateBulkToolbar();
            });
        });

        /* ---------- ACTION DROPDOWN MENUS ---------- */
        document.querySelectorAll(".sims-notification-action-btn").forEach(function (btn) {
            btn.addEventListener("click", function (e) {
                e.stopPropagation();
                var dropdown = btn.nextElementSibling;
                var isOpen = dropdown.classList.contains("show");
                document.querySelectorAll(".sims-notification-action-dropdown.show").forEach(function (d) {
                    d.classList.remove("show");
                });
                if (!isOpen) dropdown.classList.add("show");
            });
        });
        document.addEventListener("click", function () {
            document.querySelectorAll(".sims-notification-action-dropdown.show").forEach(function (d) {
                d.classList.remove("show");
            });
        });

        /* ---------- ROW ACTION LINKS ---------- */
        document.querySelectorAll(".actView").forEach(function (a) {
            a.addEventListener("click", function () { openModal("modalView"); });
        });
        document.querySelectorAll(".actEdit").forEach(function (a) {
            a.addEventListener("click", function () {
                document.getElementById("createModalTitle").textContent = "Edit Notification";
                var row = a.closest("tr");
                var isSent = row && row.getAttribute("data-status") === "Sent";
                document.getElementById("sentEditWarning").style.display = isSent ? "flex" : "none";
                openModal("modalCreate");
            });
        });
        document.querySelectorAll(".actSendNow").forEach(function (a) {
            a.addEventListener("click", function () { openModal("modalSendNow"); });
        });
        document.querySelectorAll(".actSchedule").forEach(function (a) {
            a.addEventListener("click", function () { openModal("modalSchedule"); });
        });
        document.querySelectorAll(".actCancelSchedule").forEach(function (a) {
            a.addEventListener("click", function () { openModal("modalCancelSchedule"); });
        });
        document.querySelectorAll(".actDuplicate").forEach(function (a) {
            a.addEventListener("click", function () { showToast("Notification duplicated (demo)", "success"); });
        });
        document.querySelectorAll(".actDelete").forEach(function (a) {
            a.addEventListener("click", function () { openModal("modalDelete"); });
        });
        document.querySelectorAll(".actReport").forEach(function (a) {
            a.addEventListener("click", function () { openModal("modalReport"); });
        });
        document.querySelectorAll(".actRecipients").forEach(function (a) {
            a.addEventListener("click", function () { openModal("modalRecipients"); });
        });
        document.querySelectorAll(".actRetry").forEach(function (a) {
            a.addEventListener("click", function () { showToast("Retrying notification delivery (demo)", "info"); });
        });

        /* ---------- VIEW MODAL FOOTER BUTTONS ---------- */
        var btnViewEdit = document.getElementById("btnViewEdit");
        if (btnViewEdit) btnViewEdit.addEventListener("click", function () {
            closeModal("modalView");
            document.getElementById("createModalTitle").textContent = "Edit Notification";
            openModal("modalCreate");
        });
        var btnViewDuplicate = document.getElementById("btnViewDuplicate");
        if (btnViewDuplicate) btnViewDuplicate.addEventListener("click", function () {
            showToast("Notification duplicated (demo)", "success");
        });
        var btnViewReport = document.getElementById("btnViewReport");
        if (btnViewReport) btnViewReport.addEventListener("click", function () {
            closeModal("modalView");
            openModal("modalReport");
        });

        /* ---------- SCHEDULE MODAL REMINDER TOGGLE ---------- */
        var chkReminder = document.getElementById("chkReminder");
        var ddlReminder = document.getElementById("ddlReminder");
        if (chkReminder) chkReminder.addEventListener("change", function () {
            ddlReminder.disabled = !this.checked;
        });

        /* ---------- TEMPLATE VARIABLE CHIPS ---------- */
        document.querySelectorAll("#modalCreateTemplate .chip").forEach(function (chip) {
            chip.addEventListener("click", function () {
                var textarea = document.querySelector("#modalCreateTemplate .sims-notification-textarea");
                if (textarea) {
                    textarea.value += chip.textContent;
                    textarea.focus();
                }
            });
        });

    });
})();

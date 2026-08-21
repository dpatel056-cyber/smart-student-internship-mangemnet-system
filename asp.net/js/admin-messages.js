/* ==========================================================
   SIMS ADMIN - MESSAGES & COMMUNICATION JS (Frontend Demo Only)
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
            var anyOpen = document.querySelector(".sims-message-modal-overlay.show");
            if (!anyOpen) document.body.classList.remove("modal-open");
        }

        document.querySelectorAll("[data-close]").forEach(function (btn) {
            btn.addEventListener("click", function () { closeModal(btn.getAttribute("data-close")); });
        });

        document.querySelectorAll(".sims-message-modal-overlay").forEach(function (overlay) {
            overlay.addEventListener("click", function (e) {
                if (e.target === overlay) {
                    overlay.classList.remove("show");
                    var anyOpen = document.querySelector(".sims-message-modal-overlay.show");
                    if (!anyOpen) document.body.classList.remove("modal-open");
                }
            });
        });

        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") {
                var openModals = document.querySelectorAll(".sims-message-modal-overlay.show");
                if (openModals.length) {
                    openModals[openModals.length - 1].classList.remove("show");
                    var anyOpen = document.querySelector(".sims-message-modal-overlay.show");
                    if (!anyOpen) document.body.classList.remove("modal-open");
                }
            }
        });

        /* ---------- TOASTS ---------- */
        function showToast(message, type) {
            var container = document.getElementById("toastContainer");
            if (!container) return;
            var toast = document.createElement("div");
            toast.className = "sims-message-toast" + (type ? " " + type : "");
            var icon = type === "success" ? "fa-circle-check" : (type === "error" ? "fa-circle-exclamation" : "fa-circle-info");
            toast.innerHTML = '<i class="fa-solid ' + icon + '"></i><span>' + message + "</span>";
            container.appendChild(toast);
            setTimeout(function () {
                toast.style.opacity = "0";
                setTimeout(function () { toast.remove(); }, 200);
            }, 2800);
        }

        /* ---------- HEADER BUTTONS ---------- */
        var btnNewMessage = document.getElementById("btnNewMessage");
        if (btnNewMessage) btnNewMessage.addEventListener("click", function () { openModal("modalNewMessage"); });

        var btnTemplates = document.getElementById("btnTemplates");
        if (btnTemplates) btnTemplates.addEventListener("click", function () { openModal("modalTemplates"); });

        var btnExport = document.getElementById("btnExport");
        if (btnExport) btnExport.addEventListener("click", function () { showToast("Exporting messages (demo)", "success"); });

        var btnCreateTemplate = document.getElementById("btnCreateTemplate");
        if (btnCreateTemplate) btnCreateTemplate.addEventListener("click", function () { openModal("modalCreateTemplate"); });

        var btnSaveDraftMsg = document.getElementById("btnSaveDraftMsg");
        if (btnSaveDraftMsg) btnSaveDraftMsg.addEventListener("click", function () {
            closeModal("modalNewMessage");
            showToast("Message saved as draft (demo)", "success");
        });

        var btnSendNewMessage = document.getElementById("btnSendNewMessage");
        if (btnSendNewMessage) btnSendNewMessage.addEventListener("click", function () {
            closeModal("modalNewMessage");
            showToast("Message sent successfully (demo)", "success");
        });

        /* ---------- SEARCH / FILTER / RESET ---------- */
        var btnSearch = document.getElementById("btnSearch");
        if (btnSearch) btnSearch.addEventListener("click", function () { showToast("Filters applied (demo)", "info"); });

        function resetFilters() {
            var s = document.getElementById("txtSearch");
            if (s) s.value = "";
            ["ddlUserType", "ddlStatus", "ddlPriority", "ddlCategory", "ddlDate"].forEach(function (id) {
                var el = document.getElementById(id);
                if (el) el.selectedIndex = 0;
            });
            document.getElementById("listEmptyState").style.display = "none";
        }
        var btnReset = document.getElementById("btnReset");
        if (btnReset) btnReset.addEventListener("click", resetFilters);
        var btnClearFilters = document.getElementById("btnClearFilters");
        if (btnClearFilters) btnClearFilters.addEventListener("click", resetFilters);

        /* ---------- TABS ---------- */
        document.querySelectorAll(".tab-btn").forEach(function (tab) {
            tab.addEventListener("click", function () {
                document.querySelectorAll(".tab-btn").forEach(function (t) { t.classList.remove("active"); });
                tab.classList.add("active");
            });
        });

        /* ---------- CONVERSATION SELECTION ---------- */
        var chatEmptyState = document.getElementById("chatEmptyState");
        var chatBody = document.getElementById("chatBody");
        document.querySelectorAll(".sims-message-conversation-item").forEach(function (item) {
            item.addEventListener("click", function (e) {
                if (e.target.classList.contains("convChk")) return;
                document.querySelectorAll(".sims-message-conversation-item").forEach(function (i) { i.classList.remove("active"); });
                item.classList.add("active");
                var unread = item.querySelector(".sims-message-unread");
                if (unread) unread.remove();
            });
        });

        /* ---------- SELECT ALL / BULK TOOLBAR ---------- */
        var chkSelectAll = document.getElementById("chkSelectAll");
        var convChks = document.querySelectorAll(".convChk");
        var bulkToolbar = document.getElementById("bulkToolbar");
        var bulkCount = document.getElementById("bulkCount");

        function updateBulkToolbar() {
            var checked = document.querySelectorAll(".convChk:checked").length;
            bulkCount.textContent = checked;
            bulkToolbar.style.display = checked > 0 ? "flex" : "none";
        }
        if (chkSelectAll) chkSelectAll.addEventListener("change", function () {
            convChks.forEach(function (chk) { chk.checked = chkSelectAll.checked; });
            updateBulkToolbar();
        });
        convChks.forEach(function (chk) {
            chk.addEventListener("click", function (e) { e.stopPropagation(); });
            chk.addEventListener("change", updateBulkToolbar);
        });

        ["bulkRead", "bulkUnread", "bulkPriority", "bulkAssign", "bulkClose", "bulkExport", "bulkDelete"].forEach(function (id) {
            var el = document.getElementById(id);
            if (el) el.addEventListener("click", function () {
                showToast("Bulk action performed (demo)", "success");
                convChks.forEach(function (chk) { chk.checked = false; });
                if (chkSelectAll) chkSelectAll.checked = false;
                updateBulkToolbar();
            });
        });

        /* ---------- CHAT HEADER ACTION MENU ---------- */
        document.querySelectorAll(".chatActionBtn").forEach(function (btn) {
            btn.addEventListener("click", function (e) {
                e.stopPropagation();
                var dropdown = btn.parentElement.querySelector(".sims-message-action-dropdown");
                var isOpen = dropdown.classList.contains("show");
                document.querySelectorAll(".sims-message-action-dropdown.show").forEach(function (d) { d.classList.remove("show"); });
                if (!isOpen) dropdown.classList.add("show");
            });
        });
        document.addEventListener("click", function () {
            document.querySelectorAll(".sims-message-action-dropdown.show").forEach(function (d) { d.classList.remove("show"); });
        });

        /* ---------- ACTION LINKS ---------- */
        document.querySelectorAll(".actDetails").forEach(function (a) { a.addEventListener("click", function () { openModal("modalDetails"); }); });
        document.querySelectorAll(".actReply").forEach(function (a) { a.addEventListener("click", function () { openModal("modalReply"); }); });
        document.querySelectorAll(".actMarkRead").forEach(function (a) { a.addEventListener("click", function () { showToast("Marked as read (demo)", "success"); }); });
        document.querySelectorAll(".actMarkUnread").forEach(function (a) { a.addEventListener("click", function () { showToast("Marked as unread (demo)", "info"); }); });
        document.querySelectorAll(".actPriority").forEach(function (a) { a.addEventListener("click", function () { openModal("modalPriority"); }); });
        document.querySelectorAll(".actCategory").forEach(function (a) { a.addEventListener("click", function () { showToast("Category updated (demo)", "success"); }); });
        document.querySelectorAll(".actAssign").forEach(function (a) { a.addEventListener("click", function () { openModal("modalAssign"); }); });
        document.querySelectorAll(".actClose").forEach(function (a) { a.addEventListener("click", function () { openModal("modalCloseConv"); }); });
        document.querySelectorAll(".actDelete").forEach(function (a) { a.addEventListener("click", function () { showToast("Conversation deleted (demo)", "error"); }); });

        var btnCloseConversation = document.getElementById("btnCloseConversation");
        if (btnCloseConversation) btnCloseConversation.addEventListener("click", function () { openModal("modalCloseConv"); });

        var btnDetailsReply = document.getElementById("btnDetailsReply");
        if (btnDetailsReply) btnDetailsReply.addEventListener("click", function () {
            closeModal("modalDetails");
            openModal("modalReply");
        });

        /* ---------- QUICK VIEW ---------- */
        var btnViewProfile = document.getElementById("btnViewProfile");
        if (btnViewProfile) btnViewProfile.addEventListener("click", function () { openModal("modalStudentView"); });

        /* ---------- COMPOSER ---------- */
        var txtComposer = document.getElementById("txtComposer");
        var btnSendMessage = document.getElementById("btnSendMessage");
        var chkInternalNote = document.getElementById("chkInternalNote");

        function sendComposerMessage() {
            if (!txtComposer || txtComposer.value.trim() === "") return;
            var isNote = chkInternalNote && chkInternalNote.checked;
            var now = new Date();
            var time = now.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" });

            if (isNote) {
                var noteDiv = document.createElement("div");
                noteDiv.className = "sims-message-internal-note";
                noteDiv.innerHTML = '<div class="sims-message-internal-note-head"><i class="fa-solid fa-note-sticky"></i> Internal Note</div>' +
                    "<p>" + txtComposer.value.replace(/</g, "&lt;") + "</p>" +
                    '<div class="sims-message-internal-note-meta">Added by Admin • ' + time + "</div>";
                chatBody.appendChild(noteDiv);
            } else {
                var row = document.createElement("div");
                row.className = "sims-message-bubble-row admin";
                row.innerHTML = '<div class="sims-message-conversation-avatar sm">A</div>' +
                    '<div class="sims-message-bubble"><div class="sims-message-bubble-head"><span class="sims-message-sender">Admin</span><span class="sims-message-time">' + time + '</span></div><p>' +
                    txtComposer.value.replace(/</g, "&lt;") + "</p></div>";
                chatBody.appendChild(row);
            }
            chatBody.scrollTop = chatBody.scrollHeight;
            txtComposer.value = "";
            showToast(isNote ? "Internal note added (demo)" : "Message sent (demo)", "success");
        }

        if (btnSendMessage) btnSendMessage.addEventListener("click", sendComposerMessage);
        if (txtComposer) txtComposer.addEventListener("keydown", function (e) {
            if (e.key === "Enter" && !e.shiftKey) {
                e.preventDefault();
                sendComposerMessage();
            }
        });

        var btnAttach = document.getElementById("btnAttach");
        if (btnAttach) btnAttach.addEventListener("click", function () { showToast("Attachment picker opened (demo)", "info"); });

        /* ---------- MODAL ACTION BUTTONS INSIDE MODALS ---------- */
        // Delegate for reopen conversation trigger if present dynamically (kept simple/demo)
        document.querySelectorAll("[id^=btnReopen]").forEach(function (btn) {
            btn.addEventListener("click", function () { openModal("modalReopenConv"); });
        });

        /* ---------- TEMPLATE VARIABLE CHIPS ---------- */
        document.querySelectorAll("#modalCreateTemplate .chip").forEach(function (chip) {
            chip.addEventListener("click", function () {
                var textarea = document.querySelector("#modalCreateTemplate .sims-message-textarea");
                if (textarea) {
                    textarea.value += chip.textContent;
                    textarea.focus();
                }
            });
        });

    });
})();

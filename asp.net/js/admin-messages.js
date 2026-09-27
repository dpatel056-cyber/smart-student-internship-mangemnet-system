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
            var listEmptyState = document.getElementById("listEmptyState");
            if (listEmptyState) listEmptyState.style.display = "none";
            if (typeof applyMessageCardFilter === "function") applyMessageCardFilter("all");
        }

        /* ---------- SUMMARY CARD FILTERS ---------- */
        var messageCards = document.querySelectorAll(".msg-stat-card[data-message-filter]");
        var messageItems = document.querySelectorAll(".msg-item[data-message-status]");
        var messageSearch = document.querySelector(".msg-search-input");
        var messagePills = document.querySelectorAll(".msg-filter-pill[data-message-filter]");
        var messageLayout = document.querySelector(".msg-layout");
        var backToConversations = document.getElementById("msgBackToConversations");
        var activeMessageFilter = "all";

        function applyMessageCardFilter(filter) {
            activeMessageFilter = filter;
            var query = messageSearch ? messageSearch.value.toLowerCase().trim() : "";

            messageCards.forEach(function (card) {
                card.classList.toggle("message-filter-active", card.getAttribute("data-message-filter") === filter && filter !== "all");
            });
            messagePills.forEach(function (pill) {
                pill.classList.toggle("active", pill.getAttribute("data-message-filter") === filter);
            });

            messageItems.forEach(function (item) {
                var statuses = (item.getAttribute("data-message-status") || "").split(" ");
                var searchable = (item.getAttribute("data-message-search") || item.textContent).toLowerCase();
                var matchesCard = filter === "all" || statuses.indexOf(filter) !== -1;
                var matchesSearch = !query || searchable.indexOf(query) !== -1;
                item.style.display = matchesCard && matchesSearch ? "flex" : "none";
            });

            var visibleCount = Array.from(messageItems).filter(function (item) { return item.style.display !== "none"; }).length;
            var emptyState = document.querySelector(".msg-conversation-list .msg-list-empty");
            if (visibleCount === 0 && !emptyState) {
                var empty = document.createElement("div");
                empty.className = "msg-list-empty";
                empty.innerHTML = '<i class="fa-regular fa-message"></i><span>No conversations found.</span>';
                document.querySelector(".msg-conversation-list").appendChild(empty);
            } else if (emptyState) {
                emptyState.style.display = visibleCount === 0 ? "flex" : "none";
            }
        }

        messageCards.forEach(function (card) {
            card.style.cursor = "pointer";
            card.addEventListener("click", function () {
                var filter = card.getAttribute("data-message-filter");
                applyMessageCardFilter(activeMessageFilter === filter && filter !== "all" ? "all" : filter);
            });
        });

        if (messageSearch) messageSearch.addEventListener("input", function () { applyMessageCardFilter(activeMessageFilter); });
        messagePills.forEach(function (pill) {
            pill.addEventListener("click", function () { applyMessageCardFilter(pill.getAttribute("data-message-filter")); });
        });

        messageItems.forEach(function (item) {
            item.addEventListener("click", function () {
                messageItems.forEach(function (other) { other.classList.remove("active"); });
                item.classList.add("active");
                if (messageLayout) messageLayout.classList.add("chat-open");
                var name = item.querySelector(".msg-item-name");
                var chatName = document.querySelector(".msg-chat-user-name");
                var detailName = document.querySelector(".msg-details-name");
                if (name && chatName) chatName.textContent = name.textContent;
                if (name && detailName) detailName.textContent = name.textContent;
                var unreadBadge = item.querySelector(".msg-unread-badge");
                if (unreadBadge) unreadBadge.remove();
            });
        });

        var detailsPanel = document.querySelector(".msg-col-details");
        var profileBackButton = document.getElementById("msgProfileBackBtn");
        function showStudentProfile() {
            if (detailsPanel) detailsPanel.classList.remove("profile-hidden");
            if (messageLayout) {
                messageLayout.classList.add("profile-open");
                messageLayout.classList.remove("chat-open");
            }
        }
        document.querySelectorAll(".msg-item-name, .msg-item .msg-avatar, .msg-chat-user-name, .msg-chat-user-info .msg-avatar").forEach(function (trigger) {
            trigger.addEventListener("click", function (event) {
                showStudentProfile();
            });
        });

        if (backToConversations) backToConversations.addEventListener("click", function () {
            if (messageLayout) messageLayout.classList.remove("chat-open");
            if (detailsPanel) detailsPanel.classList.add("profile-hidden");
        });

        if (profileBackButton) profileBackButton.addEventListener("click", function () {
            if (messageLayout) {
                messageLayout.classList.remove("profile-open");
                messageLayout.classList.add("chat-open");
            }
            if (detailsPanel) detailsPanel.classList.add("profile-hidden");
        });

        document.querySelectorAll(".msg-delete-conversation").forEach(function (button) {
            button.addEventListener("click", function () {
                var activeItem = document.querySelector(".msg-item.active");
                if (activeItem) activeItem.remove();
                if (detailsPanel) detailsPanel.classList.add("profile-hidden");
                document.querySelectorAll(".msg-dropdown-menu").forEach(function (menu) { menu.style.display = "none"; });
                showToast("Conversation deleted successfully.", "success");
            });
        });

        var attachInput = document.getElementById("newMessageAttachment");
        var attachButton = document.getElementById("newMessageAttachBtn");
        var attachName = document.getElementById("newMessageAttachmentName");
        if (attachButton && attachInput) attachButton.addEventListener("click", function () { attachInput.click(); });
        if (attachInput) attachInput.addEventListener("change", function () {
            if (attachName) attachName.textContent = this.files.length ? this.files[0].name : "";
        });

        var sendNewMessage = document.getElementById("newMessageSendBtn");
        if (sendNewMessage) sendNewMessage.addEventListener("click", function () {
            var recipient = document.querySelector("#newMsgModal .msg-form-input");
            var body = document.querySelector("#newMsgModal .msg-form-textarea");
            if (!recipient || !recipient.value.trim() || !body || !body.value.trim()) {
                showToast("Please select a student and enter a message.", "error");
                return;
            }
            closeNewMessageModal();
            document.querySelectorAll("#newMsgModal .msg-form-input").forEach(function (field) { field.value = ""; });
            body.value = "";
            if (attachInput) attachInput.value = "";
            if (attachName) attachName.textContent = "";
            showToast("Message sent successfully.", "success");
        });

        // WhatsApp-style composer: append sent messages to the open chat.
        var chatComposer = document.querySelector(".msg-textarea");
        var chatSendButton = document.querySelector(".msg-send-btn");
        var chatBody = document.querySelector(".msg-chat-area");
        function sendChatMessage() {
            if (!chatComposer || !chatBody) return;
            var message = chatComposer.value.trim();
            if (!message) return;
            var now = new Date();
            var time = now.toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" });
            var wrapper = document.createElement("div");
            wrapper.className = "msg-bubble-wrapper right";
            var bubble = document.createElement("div");
            bubble.className = "msg-bubble right";
            bubble.textContent = message;
            var meta = document.createElement("div");
            meta.className = "msg-bubble-meta";
            meta.innerHTML = time + ' <i class="fa-solid fa-check-double msg-read-icon"></i>';
            wrapper.appendChild(bubble);
            wrapper.appendChild(meta);
            chatBody.appendChild(wrapper);
            chatComposer.value = "";
            chatComposer.style.height = "24px";
            chatBody.scrollTop = chatBody.scrollHeight;
        }
        if (chatSendButton) chatSendButton.addEventListener("click", sendChatMessage);
        if (chatComposer) chatComposer.addEventListener("keydown", function (event) {
            if (event.key === "Enter" && !event.shiftKey) {
                event.preventDefault();
                sendChatMessage();
            }
        });
        var chatAttachmentInput = document.getElementById("chatAttachmentInput");
        var chatAttachButton = document.getElementById("chatAttachButton");
        if (chatAttachButton && chatAttachmentInput) chatAttachButton.addEventListener("click", function () { chatAttachmentInput.click(); });
        if (chatAttachmentInput) chatAttachmentInput.addEventListener("change", function () {
            if (this.files.length) showToast("Attached: " + this.files[0].name, "success");
        });
        applyMessageCardFilter("all");
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

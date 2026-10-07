<%@ Page Title="Live Messages & Chat" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-messages.aspx.cs" Inherits="asp.net.student_messages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --chat-primary: #2563EB;
            --chat-primary-hover: #1D4ED8;
            --chat-bg-sidebar: #FFFFFF;
            --chat-bg-main: #F0F4F8;
            --chat-border: #E2E8F0;
            --bubble-out: #DCF8C6;
            --bubble-in: #FFFFFF;
            --text-dark: #0F172A;
            --text-muted: #64748B;
        }
        .chat-page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
            flex-wrap: wrap;
            gap: 12px;
        }
        .chat-page-header h1 {
            font-size: 24px;
            font-weight: 700;
            color: #0F172A;
            margin: 0 0 3px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .chat-page-header p {
            color: #64748B;
            margin: 0;
            font-size: 14px;
        }
        /* ================= WHATSAPP MESSENGER FRAME ================= */
        .messenger-frame {
            display: flex;
            height: calc(100vh - 170px);
            min-height: 560px;
            max-height: 800px;
            background: #FFFFFF;
            border: 1px solid var(--chat-border);
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 20px rgba(15, 23, 42, 0.05);
        }
        /* ================= LEFT SIDEBAR (CONTACTS) ================= */
        .messenger-sidebar {
            width: 360px;
            min-width: 320px;
            max-width: 400px;
            background: var(--chat-bg-sidebar);
            border-right: 1px solid var(--chat-border);
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
        }
        .sidebar-header {
            padding: 16px 18px 12px;
            background: #FFFFFF;
            border-bottom: 1px solid var(--chat-border);
        }
        .sidebar-search-box {
            position: relative;
            margin-bottom: 12px;
        }
        .sidebar-search-box i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94A3B8;
            font-size: 14px;
        }
        .sidebar-search-input {
            width: 100%;
            padding: 10px 14px 10px 38px;
            background: #F1F5F9;
            border: 1.5px solid transparent;
            border-radius: 10px;
            font-size: 13.5px;
            color: #0F172A;
            outline: none;
            box-sizing: border-box;
            transition: all 0.2s ease;
        }
        .sidebar-search-input:focus {
            background: #FFFFFF;
            border-color: var(--chat-primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }
        /* Segmented Filter Tabs */
        .filter-pills {
            display: grid;
            grid-template-columns: 1fr 1.3fr 1.1fr;
            gap: 4px;
            background: #F1F5F9;
            padding: 4px;
            border-radius: 10px;
            border: 1px solid #E2E8F0;
        }
        .filter-pill {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            padding: 7px 6px;
            font-size: 12px;
            font-weight: 600;
            color: #64748B;
            background: transparent;
            border: none;
            border-radius: 7px;
            cursor: pointer;
            transition: all 0.2s ease;
            white-space: nowrap;
            user-select: none;
        }
        .filter-pill:hover {
            color: #0F172A;
            background: rgba(255, 255, 255, 0.7);
        }
        .filter-pill.active {
            background: var(--chat-primary);
            color: #FFFFFF;
            font-weight: 700;
            box-shadow: 0 2px 6px rgba(37, 99, 235, 0.25);
        }
        .filter-pill i {
            font-size: 11px;
        }
        .pill-count {
            font-size: 10.5px;
            font-weight: 700;
            padding: 1px 6px;
            border-radius: 10px;
            background: #E2E8F0;
            color: #475569;
            display: inline-block;
            line-height: 1.3;
        }
        .filter-pill.active .pill-count {
            background: rgba(255, 255, 255, 0.25);
            color: #FFFFFF;
        }
        /* Contacts List */
        .contacts-scroll-list {
            flex: 1;
            overflow-y: auto;
            padding: 6px 0;
        }
        .contact-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            cursor: pointer;
            transition: background 0.15s ease;
            border-bottom: 1px solid #F8FAFC;
            position: relative;
        }
        .contact-item:hover {
            background: #F8FAFC;
        }
        .contact-item.active {
            background: #EFF6FF;
            border-left: 3.5px solid var(--chat-primary);
        }
        .contact-avatar-wrapper {
            position: relative;
            flex-shrink: 0;
        }
        .contact-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 15px;
            color: #FFFFFF;
        }
        .avatar-company {
            background: linear-gradient(135deg, #0EA5E9, #0284C7);
        }
        .avatar-admin {
            background: linear-gradient(135deg, #8B5CF6, #6D28D9);
        }
        .online-dot {
            width: 11px;
            height: 11px;
            background: #22C55E;
            border: 2px solid #FFFFFF;
            border-radius: 50%;
            position: absolute;
            bottom: 0;
            right: 0;
        }
        .contact-info {
            flex: 1;
            min-width: 0;
        }
        .contact-top-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 3px;
        }
        .contact-name {
            font-size: 14px;
            font-weight: 600;
            color: #0F172A;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .contact-time {
            font-size: 11px;
            color: #94A3B8;
            flex-shrink: 0;
        }
        .contact-bottom-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 6px;
        }
        .contact-snippet {
            font-size: 12.5px;
            color: #64748B;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .role-pill-mini {
            font-size: 10px;
            font-weight: 700;
            padding: 2px 6px;
            border-radius: 4px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }
        .role-comp {
            background: #E0F2FE;
            color: #0284C7;
        }
        .role-ad {
            background: #F5F3FF;
            color: #7C3AED;
        }
        .unread-badge {
            background: #2563EB;
            color: #FFFFFF;
            font-size: 10.5px;
            font-weight: 700;
            padding: 2px 6px;
            border-radius: 10px;
            min-width: 18px;
            text-align: center;
        }
        /* ================= RIGHT CHAT PANE ================= */
        .messenger-chat-pane {
            flex: 1;
            display: flex;
            flex-direction: column;
            background: #EFEAE2; /* WhatsApp warm tone */
            background-image: radial-gradient(#CBD5E1 1px, transparent 1px);
            background-size: 20px 20px;
            position: relative;
        }
        /* Empty State */
        .chat-empty-state {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 30px;
            background: #F8FAFC;
        }
        .empty-illustration {
            width: 80px;
            height: 80px;
            background: #EFF6FF;
            color: var(--chat-primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
            margin-bottom: 18px;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.1);
        }
        .chat-empty-state h3 {
            font-size: 19px;
            font-weight: 700;
            color: #0F172A;
            margin: 0 0 6px 0;
        }
        .chat-empty-state p {
            color: #64748B;
            font-size: 14px;
            max-width: 380px;
            line-height: 1.5;
            margin: 0;
        }
        /* Active Chat Container */
        .chat-active-view {
            flex: 1;
            display: flex;
            flex-direction: column;
            height: 100%;
        }
        /* Chat Header */
        .chat-header {
            padding: 12px 20px;
            background: #FFFFFF;
            border-bottom: 1px solid var(--chat-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            z-index: 10;
        }
        .chat-header-user {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .chat-header-name {
            font-size: 15px;
            font-weight: 700;
            color: #0F172A;
            margin: 0 0 2px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .chat-header-sub {
            font-size: 12px;
            color: #64748B;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .chat-header-actions {
            display: flex;
            gap: 8px;
        }
        .chat-header-btn {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            border: 1px solid #E2E8F0;
            background: #FFFFFF;
            color: #64748B;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
        }
        .chat-header-btn:hover {
            background: #F1F5F9;
            color: #0F172A;
        }
        /* Messages Body */
        .chat-messages-scroll {
            flex: 1;
            overflow-y: auto;
            padding: 20px 24px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        /* Date Divider */
        .chat-date-divider {
            align-self: center;
            background: #FFFFFF;
            color: #64748B;
            font-size: 11.5px;
            font-weight: 600;
            padding: 4px 14px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.06);
            margin: 8px 0;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }
        /* Chat Bubbles */
        .chat-bubble-row {
            display: flex;
            width: 100%;
        }
        .chat-bubble-row.outgoing {
            justify-content: flex-end;
        }
        .chat-bubble-row.incoming {
            justify-content: flex-start;
        }
        .chat-bubble {
            max-width: 68%;
            padding: 10px 14px 8px 14px;
            border-radius: 12px;
            position: relative;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.08);
            font-size: 14px;
            line-height: 1.5;
            word-wrap: break-word;
        }
        .chat-bubble-row.outgoing .chat-bubble {
            background: #DCF8C6; /* WhatsApp Outgoing Green */
            color: #0F172A;
            border-top-right-radius: 2px;
        }
        .chat-bubble-row.incoming .chat-bubble {
            background: #FFFFFF; /* WhatsApp Incoming White */
            color: #0F172A;
            border-top-left-radius: 2px;
        }
        .bubble-sender-name {
            font-size: 11.5px;
            font-weight: 700;
            color: #0284C7;
            margin-bottom: 3px;
        }
        .bubble-text {
            display: block;
            margin-bottom: 4px;
            white-space: pre-wrap;
        }
        .bubble-meta {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 4px;
            font-size: 10.5px;
            color: #64748B;
        }
        .bubble-meta i {
            font-size: 12px;
            color: #3B82F6; /* Blue Double Tick */
        }
        /* Chat Input Bar */
        .chat-input-bar {
            padding: 12px 18px;
            background: #FFFFFF;
            border-top: 1px solid var(--chat-border);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .chat-input-field {
            flex: 1;
            padding: 12px 16px;
            background: #F1F5F9;
            border: 1.5px solid transparent;
            border-radius: 24px;
            font-size: 14px;
            color: #0F172A;
            outline: none;
            box-sizing: border-box;
            transition: all 0.2s;
            font-family: inherit;
        }
        .chat-input-field:focus {
            background: #FFFFFF;
            border-color: var(--chat-primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }
        .btn-chat-send {
            width: 44px;
            height: 44px;
            background: var(--chat-primary);
            color: #FFFFFF;
            border: none;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.1s, background 0.2s;
            flex-shrink: 0;
        }
        .btn-chat-send:hover {
            background: var(--chat-primary-hover);
            transform: scale(1.05);
        }
        .btn-chat-send:active {
            transform: scale(0.95);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0 30px 0;">
        <!-- Header -->
        <div class="chat-page-header">
            <div>
                <h1><i class="fa-solid fa-comments" style="color: #2563eb;"></i> Live Messenger &amp; Direct Chat</h1>
                <p>Real-time direct communication with hiring companies and SIMS platform administrators.</p>
            </div>
            <div>
                <span id="activeCountBadge" style="background: #ECFDF5; color: #059669; font-size: 13px; font-weight: 600; padding: 6px 14px; border-radius: 20px; border: 1px solid #A7F3D0; display: inline-flex; align-items: center; gap: 6px;">
                    <i class="fa-solid fa-circle" style="font-size: 8px; color: #10B981;"></i> Contacts Synchronized
                </span>
            </div>
        </div>
        <!-- ================= MAIN WHATSAPP MESSENGER ================= -->
        <div class="messenger-frame">
            <!-- LEFT SIDEBAR: CONTACT LIST -->
            <div class="messenger-sidebar">
                <div class="sidebar-header">
                    <!-- Search Input -->
                    <div class="sidebar-search-box">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" id="contactSearchInput" class="sidebar-search-input" placeholder="Search company or admin..." oninput="filterContacts();" />
                    </div>
                    <!-- Filter Tabs (All / Companies / Admin) -->
                    <div class="filter-pills">
                        <div class="filter-pill active" onclick="setContactFilter('all', this);">
                            <span>All</span>
                            <span class="pill-count" id="cntAll">0</span>
                        </div>
                        <div class="filter-pill" onclick="setContactFilter('Company', this);">
                            <i class="fa-solid fa-briefcase"></i>
                            <span>Companies</span>
                            <span class="pill-count" id="cntCompanies">0</span>
                        </div>
                        <div class="filter-pill" onclick="setContactFilter('Admin', this);">
                            <i class="fa-solid fa-shield-halved"></i>
                            <span>Admin</span>
                            <span class="pill-count" id="cntAdmin">1</span>
                        </div>
                    </div>
                </div>
                <!-- Contacts Scrollable List -->
                <div class="contacts-scroll-list" id="contactsListContainer">
                    <div style="padding: 30px 20px; text-align: center; color: #94A3B8;">
                        <i class="fa-solid fa-spinner fa-spin" style="font-size: 20px; margin-bottom: 8px;"></i>
                        <p style="margin: 0; font-size: 13px;">Loading contacts...</p>
                    </div>
                </div>
            </div>
            <!-- RIGHT PANE: CHAT MESSAGES WINDOW -->
            <div class="messenger-chat-pane">
                <!-- 1. EMPTY STATE (When no contact is selected) -->
                <div class="chat-empty-state" id="chatEmptyState">
                    <div class="empty-illustration">
                        <i class="fa-solid fa-paper-plane"></i>
                    </div>
                    <h3>SIMS Student Messenger</h3>
                    <p>Select any registered company or administrator from the left panel to open your live conversation history and send direct messages.</p>
                </div>
                <!-- 2. ACTIVE CHAT CONVERSATION VIEW -->
                <div class="chat-active-view" id="chatActiveView" style="display: none;">
                    <!-- Chat Header -->
                    <div class="chat-header">
                        <div class="chat-header-user">
                            <div class="contact-avatar-wrapper">
                                <div class="contact-avatar" id="activeAvatar">C</div>
                                <div class="online-dot"></div>
                            </div>
                            <div>
                                <div class="chat-header-name">
                                    <span id="activeName">-</span>
                                    <span id="activeRoleBadge" class="role-pill-mini role-comp">COMPANY</span>
                                </div>
                                <div class="chat-header-sub">
                                    <span id="activeEmail" style="color: #2563eb; font-weight: 500;">-</span>
                                    <span>&bull;</span>
                                    <span id="activeSubtitle">-</span>
                                </div>
                            </div>
                        </div>
                        <div class="chat-header-actions">
                            <button type="button" class="chat-header-btn" onclick="refreshActiveConversation();" title="Refresh Messages">
                                <i class="fa-solid fa-rotate"></i>
                            </button>
                        </div>
                    </div>
                    <!-- Messages Scroll Body -->
                    <div class="chat-messages-scroll" id="chatMessagesScroll">
                        <!-- Rendered Bubbles -->
                    </div>
                    <!-- Chat Input Bar -->
                    <div class="chat-input-bar">
                        <input type="text" id="txtMessageInput" class="chat-input-field" placeholder="Type a message... (Press Enter to send)" onkeydown="if(event.key==='Enter') sendCurrentMessage();" autocomplete="off" />
                        <button type="button" class="btn-chat-send" onclick="sendCurrentMessage();" title="Send Message">
                            <i class="fa-solid fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ================= JAVASCRIPT REAL-TIME CHAT LOGIC ================= -->
    <script>
        let allContacts = [];
        let currentFilter = 'all';
        let selectedContact = null;
        let pollInterval = null;
        document.addEventListener('DOMContentLoaded', function () {
            loadContacts();
        });
        // 1. Fetch All Contacts from Database via WebMethod
        function loadContacts() {
            fetch('student-messages.aspx/GetContactsList', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: '{}'
            })
            .then(res => res.json())
            .then(data => {
                if (data && data.d) {
                    allContacts = data.d;
                    updateCounters();
                    renderContactsList();
                    // Check URL parameter for auto-open
                    const urlParams = new URLSearchParams(window.location.search);
                    const preEmail = urlParams.get('email') || urlParams.get('companyEmail') || urlParams.get('to');
                    if (preEmail && !selectedContact) {
                        selectContact(preEmail);
                    } else if (selectedContact) {
                        const found = allContacts.find(c => c.Email.toLowerCase() === selectedContact.Email.toLowerCase());
                        if (found) selectedContact = found;
                    }
                }
            })
            .catch(err => {
                console.error("Error loading contacts:", err);
            });
        }
        // 2. Update Counter Badges
        function updateCounters() {
            document.getElementById('cntAll').innerText = allContacts.length;
            const compCnt = allContacts.filter(c => c.Role === 'Company').length;
            const adCnt = allContacts.filter(c => c.Role === 'Admin').length;
            document.getElementById('cntCompanies').innerText = compCnt;
            document.getElementById('cntAdmin').innerText = adCnt;
        }
        // 3. Set Filter (All / Company / Admin)
        function setContactFilter(filter, el) {
            currentFilter = filter;
            document.querySelectorAll('.filter-pill').forEach(p => p.classList.remove('active'));
            if (el) el.classList.add('active');
            renderContactsList();
        }
        // 4. Live Search Filter
        function filterContacts() {
            renderContactsList();
        }
        // 5. Render Contacts in Left Sidebar
        function renderContactsList() {
            const container = document.getElementById('contactsListContainer');
            const searchKeyword = document.getElementById('contactSearchInput').value.toLowerCase().trim();
            let filtered = allContacts.filter(c => {
                const matchFilter = currentFilter === 'all' || c.Role === currentFilter;
                const matchSearch = !searchKeyword ||
                                    c.Name.toLowerCase().includes(searchKeyword) ||
                                    c.Email.toLowerCase().includes(searchKeyword) ||
                                    (c.Subtitle && c.Subtitle.toLowerCase().includes(searchKeyword));
                return matchFilter && matchSearch;
            });
            if (filtered.length === 0) {
                container.innerHTML = `
                    <div style="padding: 40px 20px; text-align: center; color: #94A3B8;">
                        <i class="fa-solid fa-user-xmark" style="font-size: 26px; margin-bottom: 8px;"></i>
                        <p style="margin: 0; font-size: 13.5px;">No contacts found matching criteria.</p>
                    </div>`;
                return;
            }
            let html = '';
            filtered.forEach(c => {
                const isAct = selectedContact && selectedContact.Email.toLowerCase() === c.Email.toLowerCase();
                const avatarClass = c.Role === 'Company' ? 'avatar-company' : 'avatar-admin';
                const roleClass = c.Role === 'Company' ? 'role-comp' : 'role-ad';
                html += `
                    <div class="contact-item ${isAct ? 'active' : ''}" onclick="selectContact('${escapeHtml(c.Email)}');">
                        <div class="contact-avatar-wrapper">
                            <div class="contact-avatar ${avatarClass}">${escapeHtml(c.Initials)}</div>
                            <div class="online-dot"></div>
                        </div>
                        <div class="contact-info">
                            <div class="contact-top-row">
                                <span class="contact-name">${escapeHtml(c.Name)}</span>
                                <span class="contact-time">${escapeHtml(c.LastTime)}</span>
                            </div>
                            <div class="contact-bottom-row">
                                <span class="contact-snippet">${escapeHtml(c.LastMessage)}</span>
                                <div style="display:flex; align-items:center; gap:4px; flex-shrink:0;">
                                    <span class="role-pill-mini ${roleClass}">${escapeHtml(c.Role)}</span>
                                    ${c.UnreadCount > 0 ? `<span class="unread-badge">${c.UnreadCount}</span>` : ''}
                                </div>
                            </div>
                        </div>
                    </div>`;
            });
            container.innerHTML = html;
        }
        // 6. Select Contact & Open Live Chat
        function selectContact(email) {
            const contact = allContacts.find(c => c.Email.toLowerCase() === email.toLowerCase());
            if (!contact) return;
            selectedContact = contact;
            contact.UnreadCount = 0; // Clear local unread
            renderContactsList();
            // Switch to Active View
            document.getElementById('chatEmptyState').style.display = 'none';
            document.getElementById('chatActiveView').style.display = 'flex';
            // Populate Active Header
            const avatarEl = document.getElementById('activeAvatar');
            avatarEl.innerText = contact.Initials;
            avatarEl.className = 'contact-avatar ' + (contact.Role === 'Company' ? 'avatar-company' : 'avatar-admin');
            document.getElementById('activeName').innerText = contact.Name;
            document.getElementById('activeEmail').innerText = contact.Email;
            document.getElementById('activeSubtitle').innerText = contact.Subtitle || contact.Role;
            const roleBadge = document.getElementById('activeRoleBadge');
            roleBadge.innerText = contact.Role.toUpperCase();
            roleBadge.className = 'role-pill-mini ' + (contact.Role === 'Company' ? 'role-comp' : 'role-ad');
            // Fetch Conversation Messages
            fetchConversation(contact.Email);
            // Start auto polling for live messages
            if (pollInterval) clearInterval(pollInterval);
            pollInterval = setInterval(() => {
                if (selectedContact) {
                    fetchConversation(selectedContact.Email, false);
                }
            }, 3500);
            // Focus input
            setTimeout(() => {
                document.getElementById('txtMessageInput').focus();
            }, 100);
        }
        // 7. Fetch Conversation from Backend
        function fetchConversation(email, scrollBottom = true) {
            fetch('student-messages.aspx/GetConversation', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: JSON.stringify({ contactEmail: email })
            })
            .then(res => res.json())
            .then(data => {
                if (data && data.d) {
                    renderMessages(data.d, scrollBottom);
                }
            })
            .catch(err => {
                console.error("Error loading conversation:", err);
            });
        }
        // 8. Render Messages in WhatsApp Bubbles
        function renderMessages(messages, scrollBottom) {
            const scrollContainer = document.getElementById('chatMessagesScroll');
            if (!messages || messages.length === 0) {
                scrollContainer.innerHTML = `
                    <div style="margin: auto; text-align: center; color: #94A3B8; padding: 20px;">
                        <i class="fa-regular fa-comment-dots" style="font-size: 32px; color: #CBD5E1; margin-bottom: 8px;"></i>
                        <p style="margin: 0; font-size: 14px;">No messages exchanged yet.<br>Send a message to start the conversation!</p>
                    </div>`;
                return;
            }
            let html = '';
            let lastDate = '';
            messages.forEach(msg => {
                // Date separator
                if (msg.SentDate && msg.SentDate !== lastDate) {
                    html += `<div class="chat-date-divider">${escapeHtml(msg.SentDate)}</div>`;
                    lastDate = msg.SentDate;
                }
                const isOut = msg.IsOutgoing;
                const rowClass = isOut ? 'outgoing' : 'incoming';
                html += `
                    <div class="chat-bubble-row ${rowClass}">
                        <div class="chat-bubble">
                            ${!isOut ? `<div class="bubble-sender-name">${escapeHtml(msg.SenderName)}</div>` : ''}
                            <span class="bubble-text">${escapeHtml(msg.MessageText)}</span>
                            <div class="bubble-meta">
                                <span>${escapeHtml(msg.SentTime)}</span>
                                ${isOut ? `<i class="fa-solid fa-check-double" title="Delivered"></i>` : ''}
                            </div>
                        </div>
                    </div>`;
            });
            scrollContainer.innerHTML = html;
            if (scrollBottom) {
                scrollContainer.scrollTop = scrollContainer.scrollHeight;
            }
        }
        // 9. Send Message
        function sendCurrentMessage() {
            if (!selectedContact) return;
            const input = document.getElementById('txtMessageInput');
            const text = input.value.trim();
            if (!text) return;
            input.value = '';
            // Optimistic UI Append
            const scrollContainer = document.getElementById('chatMessagesScroll');
            const nowTime = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
            const optimisticRow = document.createElement('div');
            optimisticRow.className = 'chat-bubble-row outgoing';
            optimisticRow.innerHTML = `
                <div class="chat-bubble">
                    <span class="bubble-text">${escapeHtml(text)}</span>
                    <div class="bubble-meta">
                        <span>${nowTime}</span>
                        <i class="fa-solid fa-check-double" style="color: #94A3B8;"></i>
                    </div>
                </div>`;
            scrollContainer.appendChild(optimisticRow);
            scrollContainer.scrollTop = scrollContainer.scrollHeight;
            // Update local snippet in sidebar
            selectedContact.LastMessage = text;
            selectedContact.LastTime = nowTime;
            renderContactsList();
            // Send via Backend WebMethod
            fetch('student-messages.aspx/SendChatMessage', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: JSON.stringify({
                    receiverEmail: selectedContact.Email,
                    receiverName: selectedContact.Name,
                    receiverRole: selectedContact.Role,
                    messageText: text
                })
            })
            .then(res => res.json())
            .then(data => {
                // Re-fetch conversation to sync
                fetchConversation(selectedContact.Email, true);
                loadContacts();
            })
            .catch(err => {
                console.error("Error sending message:", err);
            });
        }
        function refreshActiveConversation() {
            if (selectedContact) {
                fetchConversation(selectedContact.Email, true);
                loadContacts();
            }
        }
        function escapeHtml(str) {
            if (!str) return '';
            return str.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#039;");
        }
    </script>
</asp:Content>

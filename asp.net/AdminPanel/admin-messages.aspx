<%@ Page Title="Live Messages & Chat" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-messages.aspx.cs" Inherits="asp.net.css.admin_messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --chat-primary: #2563EB;
            --chat-primary-hover: #1D4ED8;
            --chat-border: #E2E8F0;
        }

        /* Page header */
        .chat-page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
            margin-bottom: 18px;
        }
        .chat-page-header h1 {
            display: flex;
            align-items: center;
            gap: 10px;
            margin: 0 0 3px;
            font-size: 24px;
            font-weight: 700;
            color: #0F172A;
        }
        .chat-page-header h1 i { color: var(--chat-primary); }
        .chat-page-header p { margin: 0; font-size: 14px; color: #64748B; }
        .contacts-count-badge {
            display: inline-flex;
            align-items: center;
            padding: 6px 14px;
            background: #ECFDF5;
            color: #059669;
            border: 1px solid #A7F3D0;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        .contacts-count-badge:empty { display: none; }

        /* Messenger frame */
        .messenger-frame {
            display: flex;
            height: calc(100vh - 170px);
            min-height: 560px;
            max-height: 800px;
            overflow: hidden;
            background: #FFF;
            border: 1px solid var(--chat-border);
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(15,23,42,.05);
        }

        /* Sidebar */
        .messenger-sidebar {
            display: flex;
            flex-direction: column;
            flex-shrink: 0;
            width: 360px;
            min-width: 320px;
            max-width: 400px;
            background: #FFF;
            border-right: 1px solid var(--chat-border);
        }
        .sidebar-header { padding: 16px 18px 12px; background: #FFF; border-bottom: 1px solid var(--chat-border); }
        .sidebar-search-box { position: relative; margin-bottom: 12px; }
        .sidebar-search-box i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 14px;
            color: #94A3B8;
        }
        .sidebar-search-input {
            width: 100%;
            padding: 10px 14px 10px 38px;
            box-sizing: border-box;
            background: #F1F5F9;
            border: 1.5px solid transparent;
            border-radius: 10px;
            font-size: 13.5px;
            color: #0F172A;
            outline: none;
            transition: all .2s ease;
        }
        .sidebar-search-input:focus {
            background: #FFF;
            border-color: var(--chat-primary);
            box-shadow: 0 0 0 3px rgba(37,99,235,.1);
        }

        /* Filter tabs */
        .filter-pills {
            display: grid;
            grid-template-columns: 1fr 1.25fr 1.35fr;
            gap: 4px;
            padding: 4px;
            background: #F1F5F9;
            border: 1px solid var(--chat-border);
            border-radius: 10px;
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
            border-radius: 7px;
            cursor: pointer;
            white-space: nowrap;
            user-select: none;
            transition: all .2s ease;
        }
        .filter-pill:hover { color: #0F172A; background: rgba(255,255,255,.7); }
        .filter-pill.active {
            background: var(--chat-primary);
            color: #FFF;
            font-weight: 700;
            box-shadow: 0 2px 6px rgba(37,99,235,.25);
        }
        .filter-pill i { font-size: 11px; }
        .pill-count {
            display: inline-block;
            padding: 1px 6px;
            background: var(--chat-border);
            color: #475569;
            border-radius: 10px;
            font-size: 10.5px;
            font-weight: 700;
            line-height: 1.3;
        }
        .filter-pill.active .pill-count { background: rgba(255,255,255,.25); color: #FFF; }

        /* Contacts list */
        .contacts-scroll-list { flex: 1; overflow-y: auto; padding: 6px 0; }
        .contacts-state { padding: 40px 20px; text-align: center; color: #94A3B8; }
        .contacts-state i { margin-bottom: 8px; font-size: 24px; }
        .contacts-state p { margin: 0; font-size: 13.5px; }
        .contact-item {
            position: relative;
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            border-bottom: 1px solid #F8FAFC;
            cursor: pointer;
            transition: background .15s ease;
        }
        .contact-item:hover { background: #F8FAFC; }
        .contact-item.active { background: #EFF6FF; border-left: 3.5px solid var(--chat-primary); }
        .contact-avatar-wrapper { position: relative; flex-shrink: 0; }
        .contact-avatar {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            border-radius: 50%;
            font-size: 15px;
            font-weight: 700;
            color: #FFF;
        }
        .avatar-student { background: linear-gradient(135deg, #3B82F6, #1D4ED8); }
        .avatar-company { background: linear-gradient(135deg, #10B981, #059669); }
        .online-dot {
            position: absolute;
            right: 0;
            bottom: 0;
            width: 11px;
            height: 11px;
            background: #22C55E;
            border: 2px solid #FFF;
            border-radius: 50%;
        }
        .contact-info { flex: 1; min-width: 0; }
        .contact-top-row { display: flex; align-items: center; justify-content: space-between; margin-bottom: 3px; }
        .contact-bottom-row { display: flex; align-items: center; justify-content: space-between; gap: 6px; }
        .contact-badges { display: flex; align-items: center; gap: 4px; flex-shrink: 0; }
        .contact-name,
        .contact-snippet { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .contact-name { font-size: 14px; font-weight: 600; color: #0F172A; }
        .contact-snippet { font-size: 12.5px; color: #64748B; }
        .contact-time { flex-shrink: 0; font-size: 11px; color: #94A3B8; }
        .role-pill-mini {
            padding: 2px 6px;
            border-radius: 4px;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: .3px;
            text-transform: uppercase;
        }
        .role-st { background: #EFF6FF; color: #2563EB; }
        .role-co { background: #F0FDF4; color: #16A34A; }
        .unread-badge {
            min-width: 18px;
            padding: 2px 6px;
            background: var(--chat-primary);
            color: #FFF;
            border-radius: 10px;
            font-size: 10.5px;
            font-weight: 700;
            text-align: center;
        }

        /* Chat pane */
        .messenger-chat-pane {
            position: relative;
            display: flex;
            flex-direction: column;
            flex: 1;
            background: #EFEAE2 radial-gradient(#CBD5E1 1px, transparent 1px) 0 0 / 20px 20px;
        }
        .chat-empty-state {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            flex: 1;
            padding: 30px;
            text-align: center;
            background: #F8FAFC;
        }
        .empty-illustration {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 80px;
            height: 80px;
            margin-bottom: 18px;
            background: #EFF6FF;
            color: var(--chat-primary);
            border-radius: 50%;
            font-size: 34px;
            box-shadow: 0 4px 12px rgba(37,99,235,.1);
        }
        .chat-empty-state h3 { margin: 0 0 6px; font-size: 19px; font-weight: 700; color: #0F172A; }
        .chat-empty-state p { max-width: 380px; margin: 0; font-size: 14px; line-height: 1.5; color: #64748B; }
        .chat-active-view { display: none; flex: 1; flex-direction: column; height: 100%; }

        /* Chat header */
        .chat-header {
            z-index: 10;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 20px;
            background: #FFF;
            border-bottom: 1px solid var(--chat-border);
        }
        .chat-header-user { display: flex; align-items: center; gap: 12px; }
        .chat-header-name {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0 0 2px;
            font-size: 15px;
            font-weight: 700;
            color: #0F172A;
        }
        .chat-header-sub { display: flex; align-items: center; gap: 6px; margin: 0; font-size: 12px; color: #64748B; }
        .chat-header-email { font-weight: 500; color: var(--chat-primary); }
        .chat-header-actions { display: flex; gap: 8px; }
        .chat-header-btn {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 36px;
            height: 36px;
            background: #FFF;
            color: #64748B;
            border: 1px solid var(--chat-border);
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all .2s;
        }
        .chat-header-btn:hover { background: #F1F5F9; color: #0F172A; }

        /* Messages */
        .chat-messages-scroll {
            display: flex;
            flex-direction: column;
            flex: 1;
            gap: 10px;
            padding: 20px 24px;
            overflow-y: auto;
        }
        .chat-empty-messages { margin: auto; padding: 20px; text-align: center; color: #94A3B8; }
        .chat-empty-messages i { margin-bottom: 8px; font-size: 32px; color: #CBD5E1; }
        .chat-empty-messages p { margin: 0; font-size: 14px; }
        .chat-date-divider {
            align-self: center;
            margin: 8px 0;
            padding: 4px 14px;
            background: #FFF;
            color: #64748B;
            border-radius: 12px;
            font-size: 11.5px;
            font-weight: 600;
            letter-spacing: .3px;
            text-transform: uppercase;
            box-shadow: 0 1px 3px rgba(0,0,0,.06);
        }
        .chat-bubble-row { display: flex; width: 100%; }
        .chat-bubble-row.outgoing { justify-content: flex-end; }
        .chat-bubble-row.incoming { justify-content: flex-start; }
        .chat-bubble {
            position: relative;
            max-width: 68%;
            padding: 10px 14px 8px;
            border-radius: 12px;
            font-size: 14px;
            line-height: 1.5;
            color: #0F172A;
            word-wrap: break-word;
            box-shadow: 0 1px 3px rgba(15,23,42,.08);
        }
        .chat-bubble-row.outgoing .chat-bubble { background: #DCF8C6; border-top-right-radius: 2px; }
        .chat-bubble-row.incoming .chat-bubble { background: #FFF; border-top-left-radius: 2px; }
        .bubble-sender-name { margin-bottom: 3px; font-size: 11.5px; font-weight: 700; color: var(--chat-primary); }
        .bubble-text { display: block; margin-bottom: 4px; white-space: pre-wrap; }
        .bubble-meta {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 4px;
            font-size: 10.5px;
            color: #64748B;
        }
        .bubble-meta i { font-size: 12px; color: #3B82F6; }
        .bubble-meta i.pending { color: #94A3B8; }

        /* Input bar */
        .chat-input-bar {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 18px;
            background: #FFF;
            border-top: 1px solid var(--chat-border);
        }
        .chat-input-field {
            flex: 1;
            padding: 12px 16px;
            box-sizing: border-box;
            background: #F1F5F9;
            border: 1.5px solid transparent;
            border-radius: 24px;
            font-family: inherit;
            font-size: 14px;
            color: #0F172A;
            outline: none;
            transition: all .2s;
        }
        .chat-input-field:focus {
            background: #FFF;
            border-color: var(--chat-primary);
            box-shadow: 0 0 0 3px rgba(37,99,235,.1);
        }
        .btn-chat-send {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            width: 44px;
            height: 44px;
            background: var(--chat-primary);
            color: #FFF;
            border: none;
            border-radius: 50%;
            font-size: 16px;
            cursor: pointer;
            transition: transform .1s, background .2s;
        }
        .btn-chat-send:hover { background: var(--chat-primary-hover); transform: scale(1.05); }
        .btn-chat-send:active { transform: scale(.95); }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0 30px;">

        <!-- Header -->
        <div class="chat-page-header">
            <div>
                <h1><i class="fa-solid fa-comments"></i> Live Messenger &amp; Direct Chat</h1>
                <p>Real-time two-way communication with registered students and companies across SIMS.</p>
            </div>
            <span id="activeCountBadge" class="contacts-count-badge"></span>
        </div>

        <!-- Messenger -->
        <div class="messenger-frame">

            <!-- Sidebar: Contacts -->
            <div class="messenger-sidebar">
                <div class="sidebar-header">
                    <div class="sidebar-search-box">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" id="contactSearchInput" class="sidebar-search-input" placeholder="Search student or company..." oninput="renderContactsList();" />
                    </div>
                    <div class="filter-pills">
                        <div class="filter-pill active" onclick="setContactFilter('all', this);">
                            <span>All</span>
                            <span class="pill-count" id="cntAll"></span>
                        </div>
                        <div class="filter-pill" onclick="setContactFilter('Student', this);">
                            <i class="fa-solid fa-graduation-cap"></i>
                            <span>Students</span>
                            <span class="pill-count" id="cntStudents"></span>
                        </div>
                        <div class="filter-pill" onclick="setContactFilter('Company', this);">
                            <i class="fa-solid fa-building"></i>
                            <span>Companies</span>
                            <span class="pill-count" id="cntCompanies"></span>
                        </div>
                    </div>
                </div>

                <div class="contacts-scroll-list" id="contactsListContainer">
                    <div class="contacts-state">
                        <i class="fa-solid fa-spinner fa-spin"></i>
                        <p>Loading contacts...</p>
                    </div>
                </div>
            </div>

            <!-- Chat Pane -->
            <div class="messenger-chat-pane">

                <!-- Empty state -->
                <div class="chat-empty-state" id="chatEmptyState">
                    <div class="empty-illustration"><i class="fa-solid fa-paper-plane"></i></div>
                    <h3>SIMS Live Messenger</h3>
                    <p>Select any student or company from the left panel to open their live conversation history and send direct messages.</p>
                </div>

                <!-- Active conversation -->
                <div class="chat-active-view" id="chatActiveView">
                    <div class="chat-header">
                        <div class="chat-header-user">
                            <div class="contact-avatar-wrapper">
                                <div class="contact-avatar" id="activeAvatar"></div>
                                <div class="online-dot"></div>
                            </div>
                            <div>
                                <div class="chat-header-name">
                                    <span id="activeName"></span>
                                    <span id="activeRoleBadge" class="role-pill-mini"></span>
                                </div>
                                <div class="chat-header-sub">
                                    <span id="activeEmail" class="chat-header-email"></span>
                                    <span>&bull;</span>
                                    <span id="activeSubtitle"></span>
                                </div>
                            </div>
                        </div>
                        <div class="chat-header-actions">
                            <button type="button" class="chat-header-btn" onclick="refreshActiveConversation();" title="Refresh Messages">
                                <i class="fa-solid fa-rotate"></i>
                            </button>
                        </div>
                    </div>

                    <div class="chat-messages-scroll" id="chatMessagesScroll"></div>

                    <div class="chat-input-bar">
                        <input type="text" id="txtMessageInput" class="chat-input-field" placeholder="Type a message... (Press Enter to send)"
                            onkeydown="if (event.key === 'Enter') sendCurrentMessage();" autocomplete="off" />
                        <button type="button" class="btn-chat-send" onclick="sendCurrentMessage();" title="Send Message">
                            <i class="fa-solid fa-paper-plane"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let allContacts = [];
        let currentFilter = 'all';
        let selectedContact = null;
        let pollInterval = null;

        document.addEventListener('DOMContentLoaded', loadContacts);

        function callMethod(method, payload) {
            return fetch('admin-messages.aspx/' + method, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: JSON.stringify(payload || {})
            }).then(res => res.json());
        }

        function escapeHtml(str) {
            if (!str) return '';
            return String(str)
                .replace(/&/g, '&amp;')
                .replace(/</g, '&lt;')
                .replace(/>/g, '&gt;')
                .replace(/"/g, '&quot;')
                .replace(/'/g, '&#039;');
        }

        function isStudent(contact) {
            return contact.Role === 'Student';
        }

        function sameEmail(a, b) {
            return a.toLowerCase() === b.toLowerCase();
        }

        function loadContacts() {
            callMethod('GetContactsList')
                .then(data => {
                    if (!data || !data.d) return;
                    allContacts = data.d;
                    updateCounters();
                    renderContactsList();
                    if (selectedContact) {
                        const found = allContacts.find(c => sameEmail(c.Email, selectedContact.Email));
                        if (found) selectedContact = found;
                    }
                })
                .catch(err => console.error('Error loading contacts:', err));
        }

        function updateCounters() {
            const students = allContacts.filter(isStudent).length;
            document.getElementById('cntAll').innerText = allContacts.length;
            document.getElementById('cntStudents').innerText = students;
            document.getElementById('cntCompanies').innerText = allContacts.length - students;
            document.getElementById('activeCountBadge').innerText = allContacts.length + ' Registered Contacts';
        }

        function setContactFilter(filter, el) {
            currentFilter = filter;
            document.querySelectorAll('.filter-pill').forEach(p => p.classList.remove('active'));
            if (el) el.classList.add('active');
            renderContactsList();
        }

        function renderContactsList() {
            const container = document.getElementById('contactsListContainer');
            const keyword = document.getElementById('contactSearchInput').value.toLowerCase().trim();

            const filtered = allContacts.filter(c => {
                const matchFilter = currentFilter === 'all' || c.Role === currentFilter;
                const matchSearch = !keyword
                    || c.Name.toLowerCase().includes(keyword)
                    || c.Email.toLowerCase().includes(keyword)
                    || (c.Subtitle && c.Subtitle.toLowerCase().includes(keyword));
                return matchFilter && matchSearch;
            });

            if (filtered.length === 0) {
                container.innerHTML = `
                    <div class="contacts-state">
                        <i class="fa-solid fa-user-xmark"></i>
                        <p>No contacts found matching criteria.</p>
                    </div>`;
                return;
            }

            container.innerHTML = filtered.map(c => {
                const active = selectedContact && sameEmail(selectedContact.Email, c.Email);
                const student = isStudent(c);
                return `
                    <div class="contact-item ${active ? 'active' : ''}" onclick="selectContact('${escapeHtml(c.Email)}');">
                        <div class="contact-avatar-wrapper">
                            <div class="contact-avatar ${student ? 'avatar-student' : 'avatar-company'}">${escapeHtml(c.Initials)}</div>
                            <div class="online-dot"></div>
                        </div>
                        <div class="contact-info">
                            <div class="contact-top-row">
                                <span class="contact-name">${escapeHtml(c.Name)}</span>
                                <span class="contact-time">${escapeHtml(c.LastTime)}</span>
                            </div>
                            <div class="contact-bottom-row">
                                <span class="contact-snippet">${escapeHtml(c.LastMessage)}</span>
                                <div class="contact-badges">
                                    <span class="role-pill-mini ${student ? 'role-st' : 'role-co'}">${escapeHtml(c.Role)}</span>
                                    ${c.UnreadCount > 0 ? `<span class="unread-badge">${c.UnreadCount}</span>` : ''}
                                </div>
                            </div>
                        </div>
                    </div>`;
            }).join('');
        }

        function selectContact(email) {
            const contact = allContacts.find(c => sameEmail(c.Email, email));
            if (!contact) return;

            selectedContact = contact;
            contact.UnreadCount = 0;
            renderContactsList();

            document.getElementById('chatEmptyState').style.display = 'none';
            document.getElementById('chatActiveView').style.display = 'flex';

            const student = isStudent(contact);
            const avatar = document.getElementById('activeAvatar');
            avatar.innerText = contact.Initials;
            avatar.className = 'contact-avatar ' + (student ? 'avatar-student' : 'avatar-company');

            document.getElementById('activeName').innerText = contact.Name;
            document.getElementById('activeEmail').innerText = contact.Email;
            document.getElementById('activeSubtitle').innerText = contact.Subtitle || contact.Role;

            const roleBadge = document.getElementById('activeRoleBadge');
            roleBadge.innerText = contact.Role.toUpperCase();
            roleBadge.className = 'role-pill-mini ' + (student ? 'role-st' : 'role-co');

            fetchConversation(contact.Email);

            if (pollInterval) clearInterval(pollInterval);
            pollInterval = setInterval(() => {
                if (selectedContact) fetchConversation(selectedContact.Email, false);
            }, 3500);

            setTimeout(() => document.getElementById('txtMessageInput').focus(), 100);
        }

        function fetchConversation(email, scrollBottom = true) {
            callMethod('GetConversation', { contactEmail: email })
                .then(data => {
                    if (data && data.d) renderMessages(data.d, scrollBottom);
                })
                .catch(err => console.error('Error loading conversation:', err));
        }

        function renderMessages(messages, scrollBottom) {
            const scrollContainer = document.getElementById('chatMessagesScroll');

            if (!messages || messages.length === 0) {
                scrollContainer.innerHTML = `
                    <div class="chat-empty-messages">
                        <i class="fa-regular fa-comment-dots"></i>
                        <p>No messages exchanged yet.<br>Send a greeting to start the conversation!</p>
                    </div>`;
                return;
            }

            let lastDate = '';
            scrollContainer.innerHTML = messages.map(msg => {
                let html = '';
                if (msg.SentDate && msg.SentDate !== lastDate) {
                    html += `<div class="chat-date-divider">${escapeHtml(msg.SentDate)}</div>`;
                    lastDate = msg.SentDate;
                }
                const out = msg.IsOutgoing;
                html += `
                    <div class="chat-bubble-row ${out ? 'outgoing' : 'incoming'}">
                        <div class="chat-bubble">
                            ${out ? '' : `<div class="bubble-sender-name">${escapeHtml(msg.SenderName)}</div>`}
                            <span class="bubble-text">${escapeHtml(msg.MessageText)}</span>
                            <div class="bubble-meta">
                                <span>${escapeHtml(msg.SentTime)}</span>
                                ${out ? '<i class="fa-solid fa-check-double" title="Delivered"></i>' : ''}
                            </div>
                        </div>
                    </div>`;
                return html;
            }).join('');

            if (scrollBottom) scrollContainer.scrollTop = scrollContainer.scrollHeight;
        }

        function sendCurrentMessage() {
            if (!selectedContact) return;

            const input = document.getElementById('txtMessageInput');
            const text = input.value.trim();
            if (!text) return;
            input.value = '';

            const scrollContainer = document.getElementById('chatMessagesScroll');
            const nowTime = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

            const row = document.createElement('div');
            row.className = 'chat-bubble-row outgoing';
            row.innerHTML = `
                <div class="chat-bubble">
                    <span class="bubble-text">${escapeHtml(text)}</span>
                    <div class="bubble-meta">
                        <span>${nowTime}</span>
                        <i class="fa-solid fa-check-double pending"></i>
                    </div>
                </div>`;
            scrollContainer.appendChild(row);
            scrollContainer.scrollTop = scrollContainer.scrollHeight;

            selectedContact.LastMessage = text;
            selectedContact.LastTime = nowTime;
            renderContactsList();

            callMethod('SendChatMessage', {
                receiverEmail: selectedContact.Email,
                receiverName: selectedContact.Name,
                receiverRole: selectedContact.Role,
                messageText: text
            })
                .then(() => {
                    fetchConversation(selectedContact.Email, true);
                    loadContacts();
                })
                .catch(err => console.error('Error sending message:', err));
        }

        function refreshActiveConversation() {
            if (!selectedContact) return;
            fetchConversation(selectedContact.Email, true);
            loadContacts();
        }
    </script>
</asp:Content>
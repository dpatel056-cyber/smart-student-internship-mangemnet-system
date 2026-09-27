<%@ Page Title="Messages" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-messages.aspx.cs" Inherits="asp.net.css.admin_messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../js/admin-messages.js" defer></script>
    <style>
        /* Messages specific styles */
        :root {
            --msg-primary: #4F46E5;
            --msg-primary-hover: #4338CA;
            --msg-bg: #F8FAFC;
            --msg-card-bg: #FFFFFF;
            --msg-text-main: #0F172A;
            --msg-text-muted: #64748B;
            --msg-border: #E2E8F0;
            --msg-shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --msg-shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --msg-radius: 12px;
            --msg-radius-lg: 16px;
            --msg-success: #10B981;
            --msg-warning: #F59E0B;
            --msg-danger: #EF4444;
        }

        .msg-page-container {
            font-family: 'Inter', sans-serif;
            background-color: var(--msg-bg);
            padding: 24px;
            min-height: calc(100vh - 80px); /* Adjust based on header height */
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* Header Section */
        .msg-header-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .msg-title-area h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--msg-text-main);
            margin: 0 0 4px 0;
        }

        .msg-title-area p {
            font-size: 14px;
            color: var(--msg-text-muted);
            margin: 0;
        }

        /* Summary Cards */
        .msg-stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .msg-stat-card {
            background: var(--msg-card-bg);
            border-radius: var(--msg-radius);
            padding: 20px;
            box-shadow: var(--msg-shadow-sm);
            border: 1px solid var(--msg-border);
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .msg-stat-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .icon-blue { background: #EFF6FF; color: #3B82F6; }
        .icon-yellow { background: #FEF3C7; color: #D97706; }
        .icon-orange { background: #FFEDD5; color: #EA580C; }
        .icon-green { background: #DCFCE7; color: #16A34A; }

        .msg-stat-details {
            flex: 1;
        }

        .msg-stat-title {
            font-size: 13px;
            font-weight: 600;
            color: var(--msg-text-muted);
            margin-bottom: 4px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .msg-stat-value {
            font-size: 24px;
            font-weight: 700;
            color: var(--msg-text-main);
            line-height: 1;
        }

        /* Main Interface */
        .msg-layout {
            display: flex;
            gap: 20px;
            height: 600px; /* Fixed height for scrollable chat interface */
            width: 100%;
        }

        .msg-card {
            background: var(--msg-card-bg);
            border-radius: var(--msg-radius-lg);
            box-shadow: var(--msg-shadow-md);
            border: 1px solid var(--msg-border);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        /* Column 1: Conversations (28%) */
        .msg-col-list {
            flex: 0 0 28%;
            max-width: 28%;
        }

        .msg-col-header {
            padding: 20px;
            border-bottom: 1px solid var(--msg-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            z-index: 2;
        }

        .msg-col-title {
            font-size: 16px;
            font-weight: 700;
            color: var(--msg-text-main);
            margin: 0;
        }

        .msg-btn-new {
            background: var(--msg-primary);
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: background 0.2s;
        }

        .msg-btn-new:hover {
            background: var(--msg-primary-hover);
        }

        .msg-search-bar {
            padding: 16px 20px 8px;
        }

        .msg-search-input-wrapper {
            position: relative;
        }

        .msg-search-input-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94A3B8;
            font-size: 14px;
        }

        .msg-search-input {
            width: 100%;
            padding: 10px 14px 10px 36px;
            border: 1px solid var(--msg-border);
            border-radius: 8px;
            font-size: 14px;
            color: var(--msg-text-main);
            outline: none;
            background: #F8FAFC;
        }

        .msg-search-input:focus {
            border-color: var(--msg-primary);
            background: white;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .msg-filter-bar {
            padding: 8px 20px 16px;
            display: flex;
            gap: 8px;
            overflow-x: auto;
            border-bottom: 1px solid var(--msg-border);
            /* Hide scrollbar */
            scrollbar-width: none;
            -ms-overflow-style: none;
        }
        .msg-filter-bar::-webkit-scrollbar { display: none; }

        .msg-filter-pill {
            padding: 6px 12px;
            background: white;
            border: 1px solid var(--msg-border);
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 600;
            color: var(--msg-text-muted);
            cursor: pointer;
            white-space: nowrap;
            transition: all 0.2s;
        }

        .msg-filter-pill.active {
            background: #EFF6FF;
            color: var(--msg-primary);
            border-color: #BFDBFE;
        }

        .msg-conversation-list {
            flex: 1;
            overflow-y: auto;
        }

        .msg-item {
            padding: 16px 20px;
            border-bottom: 1px solid var(--msg-border);
            display: flex;
            gap: 12px;
            cursor: pointer;
            transition: background 0.2s;
            position: relative;
        }

        .msg-item:hover {
            background: #F8FAFC;
        }

        .msg-item.active {
            background: #EEF2FF;
            border-left: 3px solid var(--msg-primary);
        }

        .msg-avatar-wrapper {
            position: relative;
            width: 44px;
            height: 44px;
            flex-shrink: 0;
        }

        .msg-avatar {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            background: var(--msg-primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 16px;
        }

        .msg-status-indicator {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            border: 2px solid white;
        }

        .status-online { background: var(--msg-success); }
        .status-offline { background: #CBD5E1; }

        .msg-item-content {
            flex: 1;
            min-width: 0;
        }

        .msg-item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 4px;
        }

        .msg-item-name {
            font-size: 14px;
            font-weight: 600;
            color: var(--msg-text-main);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .msg-item-time {
            font-size: 12px;
            color: var(--msg-text-muted);
            flex-shrink: 0;
        }

        .msg-item-preview {
            font-size: 13px;
            color: var(--msg-text-muted);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .msg-item.unread .msg-item-name,
        .msg-item.unread .msg-item-preview {
            color: var(--msg-text-main);
            font-weight: 600;
        }

        .msg-unread-badge {
            background: var(--msg-primary);
            color: white;
            font-size: 11px;
            font-weight: 700;
            padding: 2px 6px;
            border-radius: 9999px;
            margin-left: auto;
        }

        .msg-priority-icon {
            color: var(--msg-warning);
            font-size: 12px;
        }

        /* Column 2: Chat Window (45%) */
        .msg-col-chat {
            flex: 1; /* roughly 45% */
            min-width: 0;
        }

        .msg-chat-header {
            padding: 16px 24px;
            border-bottom: 1px solid var(--msg-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
        }

        .msg-chat-user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .msg-chat-user-details {
            display: flex;
            flex-direction: column;
        }

        .msg-chat-user-name {
            font-size: 16px;
            font-weight: 700;
            color: var(--msg-text-main);
        }

        .msg-chat-user-meta {
            font-size: 13px;
            color: var(--msg-text-muted);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .msg-status-text.online {
            color: var(--msg-success);
            font-weight: 500;
        }

        .msg-action-btn {
            background: none;
            border: none;
            color: #94A3B8;
            padding: 8px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .msg-action-btn:hover {
            background: #F1F5F9;
            color: var(--msg-text-main);
        }

        .msg-chat-area {
            flex: 1;
            background: #F8FAFC;
            padding: 24px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .msg-date-divider {
            text-align: center;
            margin: 8px 0;
            position: relative;
        }

        .msg-date-divider span {
            background: #F8FAFC;
            padding: 0 12px;
            font-size: 12px;
            font-weight: 600;
            color: #94A3B8;
            position: relative;
            z-index: 1;
        }

        .msg-date-divider::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            width: 100%;
            height: 1px;
            background: var(--msg-border);
            z-index: 0;
        }

        .msg-bubble-wrapper {
            display: flex;
            flex-direction: column;
            max-width: 75%;
        }

        .msg-bubble-wrapper.left {
            align-self: flex-start;
        }

        .msg-bubble-wrapper.right {
            align-self: flex-end;
            align-items: flex-end;
        }

        .msg-bubble {
            padding: 12px 16px;
            border-radius: 16px;
            font-size: 14px;
            line-height: 1.5;
            position: relative;
        }

        .msg-bubble.left {
            background: white;
            color: var(--msg-text-main);
            border: 1px solid var(--msg-border);
            border-bottom-left-radius: 4px;
        }

        .msg-bubble.right {
            background: var(--msg-primary);
            color: white;
            border-bottom-right-radius: 4px;
        }

        .msg-bubble-meta {
            font-size: 11px;
            color: var(--msg-text-muted);
            margin-top: 4px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .msg-bubble-wrapper.right .msg-bubble-meta {
            justify-content: flex-end;
        }

        .msg-read-icon {
            color: var(--msg-primary);
            font-size: 12px;
        }

        .msg-composer {
            padding: 16px 24px;
            background: white;
            border-top: 1px solid var(--msg-border);
        }

        .msg-input-wrapper {
            display: flex;
            align-items: flex-end;
            gap: 12px;
            background: #F8FAFC;
            border: 1px solid var(--msg-border);
            border-radius: 12px;
            padding: 10px 16px;
            transition: border-color 0.2s;
        }
        
        .msg-input-wrapper:focus-within {
            border-color: var(--msg-primary);
            background: white;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .msg-composer-btn {
            background: none;
            border: none;
            color: #94A3B8;
            font-size: 18px;
            cursor: pointer;
            padding: 4px;
            transition: color 0.2s;
            margin-bottom: 4px;
        }

        .msg-composer-btn:hover {
            color: var(--msg-primary);
        }

        .msg-textarea {
            flex: 1;
            border: none;
            background: transparent;
            resize: none;
            outline: none;
            font-family: inherit;
            font-size: 14px;
            color: var(--msg-text-main);
            min-height: 24px;
            max-height: 120px;
            padding: 6px 0;
            line-height: 1.5;
        }

        .msg-send-btn {
            background: var(--msg-primary);
            color: white;
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: background 0.2s;
            margin-bottom: 2px;
        }

        .msg-send-btn:hover {
            background: var(--msg-primary-hover);
        }

        /* Column 3: Student Details (27%) */
        .msg-col-details {
            flex: 0 0 27%;
            max-width: 27%;
            overflow-y: auto;
            background: #F8FAFC;
        }

        .msg-col-details.profile-hidden { display: none; }
        .msg-layout:not(.chat-open) .msg-col-chat { display: none; }
        .msg-layout:not(.chat-open) .msg-col-list { flex: 1 1 100%; max-width: 100%; }
        .msg-back-btn { display: none; border: 0; background: transparent; color: #64748B; font-size: 18px; cursor: pointer; padding: 4px 8px 4px 0; }
        .msg-layout.chat-open .msg-back-btn { display: inline-flex; align-items: center; }
        .msg-layout.chat-open .msg-col-list { flex: 0 0 28%; max-width: 28%; }
        .msg-layout.profile-open .msg-col-chat { display: none; }
        .msg-layout.profile-open .msg-col-details {
            display: flex;
            flex: 1 1 72%;
            max-width: 72%;
            width: 72%;
        }
        .msg-profile-back-btn {
            position: absolute;
            left: 24px;
            top: 22px;
            border: 0;
            background: transparent;
            color: #64748B;
            font-size: 22px;
            cursor: pointer;
            padding: 6px;
        }
        .msg-chat-user-name, .msg-chat-user-info .msg-avatar, .msg-item-name, .msg-item .msg-avatar { cursor: pointer; }
        .msg-attachment-name { color: #64748B; font-size: 12px; margin-left: 8px; }

        .msg-details-header {
            padding: 32px 20px 20px;
            text-align: center;
            border-bottom: 1px solid var(--msg-border);
            background: white;
            position: relative;
        }

        .msg-large-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: var(--msg-primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            font-weight: 700;
            margin: 0 auto 16px;
        }

        .msg-details-name {
            font-size: 18px;
            font-weight: 700;
            color: var(--msg-text-main);
            margin: 0 0 4px 0;
        }

        .msg-details-id {
            font-size: 14px;
            color: var(--msg-text-muted);
            margin: 0 0 12px 0;
        }

        .msg-badge {
            display: inline-flex;
            align-items: center;
            padding: 4px 10px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-active { background: #DCFCE7; color: #16A34A; }
        .badge-pending { background: #FFF7ED; color: #EA580C; }
        .badge-archived { background: #F1F5F9; color: #475569; }

        .msg-details-section {
            padding: 20px;
            border-bottom: 1px solid var(--msg-border);
        }

        .msg-section-title {
            font-size: 12px;
            font-weight: 700;
            color: var(--msg-text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin: 0 0 12px 0;
        }

        .msg-info-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .msg-info-item {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .msg-info-label {
            font-size: 12px;
            color: var(--msg-text-muted);
        }

        .msg-info-value {
            font-size: 14px;
            font-weight: 500;
            color: var(--msg-text-main);
        }

        .msg-action-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .msg-action-link {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 12px;
            border-radius: 8px;
            color: var(--msg-text-main);
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            background: white;
            border: 1px solid var(--msg-border);
            transition: all 0.2s;
            cursor: pointer;
        }

        .msg-action-link:hover {
            background: #F1F5F9;
            border-color: #CBD5E1;
        }

        .msg-action-link i {
            color: var(--msg-text-muted);
            width: 16px;
            text-align: center;
        }

        .msg-action-link.danger {
            color: var(--msg-danger);
        }
        .msg-action-link.danger i {
            color: var(--msg-danger);
        }
        .msg-action-link.danger:hover {
            background: #FEE2E2;
            border-color: #FCA5A5;
        }

        /* Modal */
        .msg-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.4);
            backdrop-filter: blur(2px);
            z-index: 1000;
            display: none;
            align-items: center;
            justify-content: center;
        }

        .msg-modal {
            background: white;
            border-radius: 16px;
            width: 100%;
            max-width: 500px;
            box-shadow: var(--msg-shadow-lg);
            overflow: hidden;
        }

        .msg-modal-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--msg-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .msg-modal-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--msg-text-main);
            margin: 0;
        }

        .msg-modal-close {
            background: none;
            border: none;
            color: #94A3B8;
            font-size: 20px;
            cursor: pointer;
            padding: 4px;
        }

        .msg-modal-body {
            padding: 24px;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .msg-form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .msg-form-label {
            font-size: 13px;
            font-weight: 600;
            color: var(--msg-text-main);
        }

        .msg-form-input {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid var(--msg-border);
            border-radius: 8px;
            font-size: 14px;
            color: var(--msg-text-main);
            outline: none;
            font-family: inherit;
        }

        .msg-form-input:focus {
            border-color: var(--msg-primary);
        }

        .msg-form-textarea {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid var(--msg-border);
            border-radius: 8px;
            font-size: 14px;
            color: var(--msg-text-main);
            outline: none;
            resize: vertical;
            min-height: 120px;
            font-family: inherit;
        }
        
        .msg-form-textarea:focus {
            border-color: var(--msg-primary);
        }

        .msg-attach-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            background: #F8FAFC;
            border: 1px dashed #CBD5E1;
            border-radius: 8px;
            color: var(--msg-text-muted);
            font-size: 13px;
            font-weight: 500;
            cursor: pointer;
            width: fit-content;
        }

        .msg-modal-footer {
            padding: 16px 24px;
            background: #F8FAFC;
            border-top: 1px solid var(--msg-border);
            display: flex;
            justify-content: flex-end;
            gap: 12px;
        }

        .msg-btn-outline {
            padding: 10px 20px;
            background: white;
            border: 1px solid var(--msg-border);
            border-radius: 8px;
            color: var(--msg-text-main);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        .msg-btn-primary {
            padding: 10px 20px;
            background: var(--msg-primary);
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }
        
        /* Dropdown Action Menu */
        .msg-dropdown {
            position: relative;
            display: inline-block;
        }
        
        .msg-dropdown-menu {
            position: absolute;
            right: 0;
            top: 100%;
            min-width: 200px;
            background: white;
            border: 1px solid var(--msg-border);
            border-radius: 8px;
            box-shadow: var(--msg-shadow-lg);
            z-index: 10;
            display: none;
            padding: 8px 0;
        }
        
        .msg-dropdown:hover .msg-dropdown-menu {
            display: block;
        }
        
        .msg-dropdown-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 16px;
            font-size: 14px;
            color: var(--msg-text-main);
            text-decoration: none;
            cursor: pointer;
            transition: background 0.1s;
        }
        
        .msg-dropdown-item:hover {
            background: #F1F5F9;
            color: var(--msg-primary);
        }

        .msg-list-empty {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 8px;
            min-height: 180px;
            padding: 24px 16px;
            color: #64748B;
            font-size: 13px;
            text-align: center;
        }

        .msg-list-empty i { color: #94A3B8; font-size: 28px; }
        .msg-chat-user-name,
        .msg-chat-user-info .msg-avatar,
        .msg-item-name,
        .msg-item .msg-avatar { cursor: pointer; }
        .msg-attachment-name { color: #64748B; font-size: 12px; margin-left: 8px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="msg-page-container">
        <!-- Header -->
        <div class="msg-header-section">
            <div class="msg-title-area">
                <h1>Messages</h1>
                <p>Manage conversations with students and users.</p>
            </div>
        </div>

        <!-- Summary Cards -->
        <div class="msg-stats-grid">
            <div class="msg-stat-card" data-message-filter="all">
                <div class="msg-stat-icon icon-blue"><i class="fa-solid fa-comments"></i></div>
                <div class="msg-stat-details">
                    <div class="msg-stat-title">Total Conversations</div>
                    <div class="msg-stat-value">248</div>
                </div>
            </div>
            <div class="msg-stat-card" data-message-filter="unread">
                <div class="msg-stat-icon icon-yellow"><i class="fa-solid fa-envelope"></i></div>
                <div class="msg-stat-details">
                    <div class="msg-stat-title">Unread</div>
                    <div class="msg-stat-value">24</div>
                </div>
            </div>
            <div class="msg-stat-card" data-message-filter="pending">
                <div class="msg-stat-icon icon-orange"><i class="fa-solid fa-clock-rotate-left"></i></div>
                <div class="msg-stat-details">
                    <div class="msg-stat-title">Pending Reply</div>
                    <div class="msg-stat-value">18</div>
                </div>
            </div>
            <div class="msg-stat-card" data-message-filter="resolved">
                <div class="msg-stat-icon icon-green"><i class="fa-solid fa-check-double"></i></div>
                <div class="msg-stat-details">
                    <div class="msg-stat-title">Resolved</div>
                    <div class="msg-stat-value">206</div>
                </div>
            </div>
        </div>

        <!-- Main Interface -->
        <div class="msg-layout">
            <!-- Column 1: Conversations -->
            <div class="msg-card msg-col-list">
            <div class="msg-col-header">
                <h2 class="msg-col-title">Conversations</h2>
                    <button type="button" class="msg-btn-new" onclick="openNewMessageModal()">
                        <i class="fa-solid fa-plus"></i> New Message
                    </button>
            </div>
                
                <div class="msg-search-bar">
                    <div class="msg-search-input-wrapper">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" class="msg-search-input" placeholder="Search conversations..." />
                    </div>
                </div>
                
                <div class="msg-filter-bar">
                    <div class="msg-filter-pill active" data-message-filter="all">All</div>
                    <div class="msg-filter-pill" data-message-filter="unread">Unread</div>
                    <div class="msg-filter-pill" data-message-filter="pending">Pending</div>
                    <div class="msg-filter-pill" data-message-filter="resolved">Resolved</div>
                </div>

                <div class="msg-conversation-list">
                    <!-- Convo 1 (Active & Unread) -->
                    <div class="msg-item active unread" data-message-status="unread pending" data-message-search="Dhruvi Patel I need help with my course">
                        <div class="msg-avatar-wrapper">
                            <div class="msg-avatar" style="background: #6366F1;">DP</div>
                            <div class="msg-status-indicator status-online"></div>
                        </div>
                        <div class="msg-item-content">
                            <div class="msg-item-header">
                                <span class="msg-item-name">Dhruvi Patel</span>
                                <span class="msg-item-time">10:30 AM</span>
                            </div>
                            <div class="msg-item-preview">
                                I need help with my course...
                                <span class="msg-unread-badge">2</span>
                            </div>
                        </div>
                    </div>

                    <!-- Convo 2 -->
                    <div class="msg-item" data-message-status="resolved" data-message-search="Rahul Shah Thank you for your response">
                        <div class="msg-avatar-wrapper">
                            <div class="msg-avatar" style="background: #EC4899;">RS</div>
                            <div class="msg-status-indicator status-offline"></div>
                        </div>
                        <div class="msg-item-content">
                            <div class="msg-item-header">
                                <span class="msg-item-name">Rahul Shah</span>
                                <span class="msg-item-time">09:45 AM</span>
                            </div>
                            <div class="msg-item-preview">
                                Thank you for your response.
                            </div>
                        </div>
                    </div>

                    <!-- Convo 3 (Priority) -->
                    <div class="msg-item" data-message-status="pending" data-message-search="Priya Patel Can you explain the fees">
                        <div class="msg-avatar-wrapper">
                            <div class="msg-avatar" style="background: #10B981;">PP</div>
                            <div class="msg-status-indicator status-offline"></div>
                        </div>
                        <div class="msg-item-content">
                            <div class="msg-item-header">
                                <span class="msg-item-name">Priya Patel</span>
                                <span class="msg-item-time">Yesterday</span>
                            </div>
                            <div class="msg-item-preview">
                                <i class="fa-solid fa-flag msg-priority-icon"></i>
                                Can you explain the fees?
                            </div>
                        </div>
                    </div>

                    <!-- Convo 4 -->
                    <div class="msg-item" data-message-status="resolved" data-message-search="Amit Shah I have submitted my documents">
                        <div class="msg-avatar-wrapper">
                            <div class="msg-avatar" style="background: #F59E0B;">AS</div>
                            <div class="msg-status-indicator status-online"></div>
                        </div>
                        <div class="msg-item-content">
                            <div class="msg-item-header">
                                <span class="msg-item-name">Amit Shah</span>
                                <span class="msg-item-time">Yesterday</span>
                            </div>
                            <div class="msg-item-preview">
                                I have submitted my documents.
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Column 2: Chat Window -->
            <div class="msg-card msg-col-chat">
                <div class="msg-chat-header">
                    <button type="button" class="msg-back-btn" id="msgBackToConversations" title="Back to conversations">
                        <i class="fa-solid fa-arrow-left"></i>
                    </button>
                    <div class="msg-chat-user-info">
                        <div class="msg-avatar-wrapper">
                            <div class="msg-avatar" style="background: #6366F1;">DP</div>
                            <div class="msg-status-indicator status-online"></div>
                        </div>
                        <div class="msg-chat-user-details">
                            <span class="msg-chat-user-name">Dhruvi Patel</span>
                            <span class="msg-chat-user-meta">
                                STU001 &bull; <span class="msg-status-text online">Online</span>
                            </span>
                        </div>
                    </div>
                    <div class="msg-dropdown">
                        <button type="button" class="msg-action-btn"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                        <div class="msg-dropdown-menu">
                            <div class="msg-dropdown-item msg-delete-conversation" style="color: #EF4444;"><i class="fa-solid fa-trash"></i> Delete Conversation</div>
                        </div>
                    </div>
                </div>

                <div class="msg-chat-area">
                    <div class="msg-date-divider"><span>Today, 21 Aug 2026</span></div>

                    <!-- Student Msg 1 -->
                    <div class="msg-bubble-wrapper left">
                        <div class="msg-bubble left">
                            Hi Admin, I need information about the BCA course.
                        </div>
                        <div class="msg-bubble-meta">10:25 AM</div>
                    </div>

                    <!-- Admin Msg 1 -->
                    <div class="msg-bubble-wrapper right">
                        <div class="msg-bubble right">
                            Sure! I'll help you with the course details.
                        </div>
                        <div class="msg-bubble-meta">
                            10:28 AM <i class="fa-solid fa-check-double msg-read-icon"></i>
                        </div>
                    </div>

                    <!-- Student Msg 2 -->
                    <div class="msg-bubble-wrapper left">
                        <div class="msg-bubble left">
                            Can you also tell me about the admission process?
                        </div>
                        <div class="msg-bubble-meta">10:30 AM</div>
                    </div>
                </div>

                <div class="msg-composer">
                    <div class="msg-input-wrapper">
                        <input type="file" id="chatAttachmentInput" hidden />
                        <button type="button" class="msg-composer-btn" id="chatAttachButton" title="Attach file"><i class="fa-solid fa-paperclip"></i></button>
                        <textarea class="msg-textarea" placeholder="Type your message..." rows="1"></textarea>
                        <button type="button" class="msg-composer-btn" title="Emoji"><i class="fa-regular fa-face-smile"></i></button>
                        <button type="button" class="msg-send-btn" title="Send"><i class="fa-solid fa-paper-plane"></i></button>
                    </div>
                </div>
            </div>

            <!-- Column 3: Student Details -->
            <div class="msg-card msg-col-details profile-hidden">
                <div class="msg-details-header">
                    <button type="button" class="msg-profile-back-btn" id="msgProfileBackBtn" title="Back to chat">
                        <i class="fa-solid fa-arrow-left"></i>
                    </button>
                    <div class="msg-large-avatar">DP</div>
                    <h3 class="msg-details-name">Dhruvi Patel</h3>
                    <p class="msg-details-id">STU001</p>
                    <span class="msg-badge badge-active">Active</span>
                </div>
                
                <div class="msg-details-section">
                    <h4 class="msg-section-title">Information</h4>
                    <div class="msg-info-list">
                        <div class="msg-info-item">
                            <span class="msg-info-label">Email</span>
                            <span class="msg-info-value">dhruvi@gmail.com</span>
                        </div>
                        <div class="msg-info-item">
                            <span class="msg-info-label">Phone</span>
                            <span class="msg-info-value">98765xxxxx</span>
                        </div>
                        <div class="msg-info-item">
                            <span class="msg-info-label">Course</span>
                            <span class="msg-info-value">BCA</span>
                        </div>
                        <div class="msg-info-item">
                            <span class="msg-info-label">Registration Date</span>
                            <span class="msg-info-value">21 Aug 2026</span>
                        </div>
                        <div class="msg-info-item">
                            <span class="msg-info-label">Last Login</span>
                            <span class="msg-info-value">21 Aug 2026, 10:20 AM</span>
                        </div>
                    </div>
                </div>

                <div class="msg-details-section">
                    <h4 class="msg-section-title">Conversation Info</h4>
                    <div class="msg-info-list">
                        <div class="msg-info-item">
                            <span class="msg-info-label">Started</span>
                            <span class="msg-info-value">21 Aug 2026</span>
                        </div>
                        <div class="msg-info-item">
                            <span class="msg-info-label">Last message</span>
                            <span class="msg-info-value">10:30 AM</span>
                        </div>
                        <div class="msg-info-item">
                            <span class="msg-info-label">Total messages</span>
                            <span class="msg-info-value">12</span>
                        </div>
                        <div class="msg-info-item">
                            <span class="msg-info-label">Status</span>
                            <span class="msg-info-value"><span class="msg-badge badge-pending">Pending Reply</span></span>
                        </div>
                    </div>
                </div>

                <div class="msg-details-section msg-delete-section" style="border-bottom: none;">
                    <div class="msg-action-list">
                        <button type="button" class="msg-action-link danger msg-delete-conversation"><i class="fa-solid fa-trash"></i> Delete Conversation</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- New Message Modal -->
    <div class="msg-modal-overlay" id="newMsgModal">
        <div class="msg-modal">
            <div class="msg-modal-header">
                <h2 class="msg-modal-title">New Message</h2>
                <button type="button" class="msg-modal-close" onclick="closeNewMessageModal()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="msg-modal-body">
                <div class="msg-form-group">
                    <label class="msg-form-label">To:</label>
                    <input type="text" class="msg-form-input" placeholder="Search student..." />
                </div>
                <div class="msg-form-group">
                    <label class="msg-form-label">Subject:</label>
                    <input type="text" class="msg-form-input" placeholder="Enter subject..." />
                </div>
                <div class="msg-form-group">
                    <label class="msg-form-label">Message:</label>
                    <textarea class="msg-form-textarea" placeholder="Write your message..."></textarea>
                </div>
                <div class="msg-form-group">
                    <input type="file" id="newMessageAttachment" hidden />
                    <button type="button" class="msg-attach-btn" id="newMessageAttachBtn"><i class="fa-solid fa-paperclip"></i> Attach file</button>
                    <span id="newMessageAttachmentName" class="msg-attachment-name"></span>
                </div>
            </div>
            <div class="msg-modal-footer">
                <button type="button" class="msg-btn-outline" onclick="closeNewMessageModal()">Cancel</button>
                <button type="button" class="msg-btn-primary" id="newMessageSendBtn"><i class="fa-solid fa-paper-plane" style="margin-right:6px;"></i> Send Message</button>
            </div>
        </div>
    </div>

    <script>
        function openNewMessageModal() {
            document.getElementById('newMsgModal').style.display = 'flex';
        }
        function closeNewMessageModal() {
            document.getElementById('newMsgModal').style.display = 'none';
        }
        
        // Auto-resize textarea in composer
        const textarea = document.querySelector('.msg-textarea');
        if(textarea) {
            textarea.addEventListener('input', function() {
                this.style.height = '24px';
                this.style.height = (this.scrollHeight) + 'px';
            });
        }
    </script>
</asp:Content>

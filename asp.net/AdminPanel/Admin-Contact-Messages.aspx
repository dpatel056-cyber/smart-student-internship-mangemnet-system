<%@ Page Title="Contact Messages" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="Admin-Contact-Messages.aspx.cs" Inherits="asp.net.AdminPanel.Admin_Contact_Messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Contact Messages specific styles */
        :root {
            --cm-primary: #4F46E5;
            --cm-primary-hover: #4338CA;
            --cm-bg: #F8FAFC;
            --cm-card-bg: #FFFFFF;
            --cm-text-main: #0F172A;
            --cm-text-muted: #64748B;
            --cm-border: #E2E8F0;
            --cm-shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --cm-shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --cm-shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --cm-radius: 12px;
            --cm-radius-lg: 16px;
        }

        .cm-container {
            font-family: 'Inter', sans-serif;
            background-color: var(--cm-bg);
            padding: 24px;
            min-height: calc(100vh - 80px); /* Adjust based on header height */
        }

        /* Header Section */
        .cm-header-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 24px;
        }

        .cm-title-area h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--cm-text-main);
            margin: 0 0 4px 0;
        }

        .cm-title-area p {
            font-size: 14px;
            color: var(--cm-text-muted);
            margin: 0;
        }

        .cm-header-actions {
            display: flex;
            gap: 12px;
        }

        .cm-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
            font-size: 14px;
            font-weight: 500;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
            border: 1px solid transparent;
        }

        .cm-btn-outline {
            background: white;
            border-color: var(--cm-border);
            color: var(--cm-text-main);
            box-shadow: var(--cm-shadow-sm);
        }

        .cm-btn-outline:hover {
            background: #F1F5F9;
        }

        .cm-btn-primary {
            background: var(--cm-primary);
            color: white;
            box-shadow: var(--cm-shadow-sm);
        }

        .cm-btn-primary:hover {
            background: var(--cm-primary-hover);
        }

        /* Summary Cards */
        .cm-stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 24px;
            margin-bottom: 32px;
        }

        .cm-stat-card {
            background: var(--cm-card-bg);
            border-radius: var(--cm-radius);
            padding: 24px;
            box-shadow: var(--cm-shadow-sm);
            border: 1px solid var(--cm-border);
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .cm-stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .icon-blue { background: #EFF6FF; color: #3B82F6; }
        .icon-yellow { background: #FEF3C7; color: #D97706; }
        .icon-orange { background: #FFEDD5; color: #EA580C; }
        .icon-green { background: #DCFCE7; color: #16A34A; }

        .cm-stat-details {
            flex: 1;
        }

        .cm-stat-title {
            font-size: 14px;
            font-weight: 500;
            color: var(--cm-text-muted);
            margin-bottom: 4px;
        }

        .cm-stat-value {
            font-size: 28px;
            font-weight: 700;
            color: var(--cm-text-main);
            line-height: 1;
        }

        /* Main Content Area */
        .cm-content-card {
            background: var(--cm-card-bg);
            border-radius: var(--cm-radius-lg);
            box-shadow: var(--cm-shadow-md);
            border: 1px solid var(--cm-border);
            overflow: hidden;
        }

        /* Filters */
        .cm-filters-bar {
            padding: 20px 24px;
            border-bottom: 1px solid var(--cm-border);
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            align-items: center;
            justify-content: space-between;
        }

        .cm-search-wrapper {
            position: relative;
            flex: 1;
            min-width: 300px;
            max-width: 400px;
        }

        .cm-search-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94A3B8;
        }

        .cm-search-input {
            width: 100%;
            padding: 10px 14px 10px 40px;
            border: 1px solid var(--cm-border);
            border-radius: 8px;
            font-size: 14px;
            color: var(--cm-text-main);
            outline: none;
            transition: border-color 0.2s;
        }

        .cm-search-input:focus {
            border-color: var(--cm-primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .cm-filter-group {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .cm-select {
            padding: 10px 36px 10px 14px;
            border: 1px solid var(--cm-border);
            border-radius: 8px;
            font-size: 14px;
            color: var(--cm-text-main);
            background-color: white;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748B'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
            outline: none;
            cursor: pointer;
        }

        .cm-select:focus {
            border-color: var(--cm-primary);
        }

        .cm-btn-clear {
            background: none;
            border: none;
            color: var(--cm-text-muted);
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            padding: 8px;
            border-radius: 6px;
        }
        
        .cm-btn-clear:hover {
            background: #F1F5F9;
            color: var(--cm-text-main);
        }

        /* Table */
        .cm-table-container {
            overflow-x: auto;
        }

        .cm-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cm-table th {
            background-color: #F8FAFC;
            padding: 16px 24px;
            text-align: left;
            font-size: 12px;
            font-weight: 600;
            color: var(--cm-text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 1px solid var(--cm-border);
            white-space: nowrap;
        }

        .cm-table td {
            padding: 16px 24px;
            font-size: 14px;
            color: var(--cm-text-main);
            border-bottom: 1px solid var(--cm-border);
            vertical-align: middle;
        }

        .cm-table tr:last-child td {
            border-bottom: none;
        }

        .cm-table tr:hover td {
            background-color: #F8FAFC;
        }

        /* Student Cell */
        .cm-student-cell {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .cm-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background-color: var(--cm-primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 14px;
        }

        .cm-student-info {
            display: flex;
            flex-direction: column;
        }

        .cm-student-name {
            font-weight: 600;
            color: var(--cm-text-main);
        }

        .cm-subject-text {
            font-weight: 500;
            color: var(--cm-text-main);
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* Badges */
        .cm-badge {
            display: inline-flex;
            align-items: center;
            padding: 4px 10px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-new { background-color: #EFF6FF; color: #2563EB; }
        .badge-progress { background-color: #FFF7ED; color: #EA580C; }
        .badge-responded { background-color: #FAF5FF; color: #9333EA; }
        .badge-resolved { background-color: #F0FDF4; color: #16A34A; }

        .badge-category { background-color: #F1F5F9; color: #475569; }

        /* Actions */
        .cm-action-btn {
            background: none;
            border: none;
            color: #94A3B8;
            padding: 8px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .cm-action-btn:hover {
            background: #F1F5F9;
            color: var(--cm-primary);
        }

        /* Pagination */
        .cm-pagination-bar {
            padding: 16px 24px;
            border-top: 1px solid var(--cm-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: white;
            border-bottom-left-radius: var(--cm-radius-lg);
            border-bottom-right-radius: var(--cm-radius-lg);
        }

        .cm-pagination-info {
            font-size: 14px;
            color: var(--cm-text-muted);
        }

        .cm-pagination-controls {
            display: flex;
            gap: 6px;
        }

        .cm-page-btn {
            min-width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--cm-border);
            border-radius: 6px;
            background: white;
            color: var(--cm-text-muted);
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            padding: 0 8px;
        }

        .cm-page-btn:hover:not(:disabled) {
            background: #F1F5F9;
            color: var(--cm-text-main);
        }

        .cm-page-btn.active {
            background: var(--cm-primary);
            color: white;
            border-color: var(--cm-primary);
        }

        .cm-page-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Drawer Overlay */
        .cm-drawer-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.4);
            z-index: 1040;
            display: none;
            backdrop-filter: blur(2px);
        }

        /* Detail Drawer */
        .cm-drawer {
            position: fixed;
            top: 0;
            right: -500px;
            width: 500px;
            height: 100vh;
            background: white;
            z-index: 1050;
            box-shadow: -4px 0 24px rgba(0,0,0,0.1);
            transition: right 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            flex-direction: column;
        }

        .cm-drawer.open {
            right: 0;
        }

        .cm-drawer-header {
            padding: 24px;
            border-bottom: 1px solid var(--cm-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cm-drawer-title {
            font-size: 18px;
            font-weight: 700;
            color: var(--cm-text-main);
            margin: 0;
        }

        .cm-drawer-close {
            background: none;
            border: none;
            color: #94A3B8;
            font-size: 20px;
            cursor: pointer;
            padding: 4px;
            border-radius: 6px;
        }

        .cm-drawer-close:hover {
            background: #F1F5F9;
            color: var(--cm-text-main);
        }

        .cm-drawer-body {
            flex: 1;
            overflow-y: auto;
            padding: 24px;
        }

        /* Drawer Details */
        .cm-detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 24px;
        }

        .cm-detail-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .cm-detail-label {
            font-size: 12px;
            font-weight: 600;
            color: var(--cm-text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .cm-detail-value {
            font-size: 14px;
            color: var(--cm-text-main);
            font-weight: 500;
        }
        
        .cm-detail-status {
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .cm-status-dropdown {
            padding: 4px 28px 4px 10px;
            border: 1px solid var(--cm-border);
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            background-color: white;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748B'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 8px center;
            background-size: 12px;
            cursor: pointer;
        }

        .cm-message-box {
            background: #F8FAFC;
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 32px;
            border: 1px solid var(--cm-border);
        }

        .cm-message-text {
            font-size: 15px;
            color: var(--cm-text-main);
            line-height: 1.6;
            margin: 0;
        }

        /* History Section */
        .cm-history-section {
            margin-bottom: 32px;
        }

        .cm-section-title {
            font-size: 16px;
            font-weight: 700;
            color: var(--cm-text-main);
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .cm-timeline {
            display: flex;
            flex-direction: column;
            gap: 16px;
            position: relative;
        }

        .cm-timeline::before {
            content: '';
            position: absolute;
            left: 15px;
            top: 10px;
            bottom: 10px;
            width: 2px;
            background: var(--cm-border);
        }

        .cm-timeline-item {
            display: flex;
            gap: 16px;
            position: relative;
        }

        .cm-timeline-icon {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: white;
            border: 2px solid var(--cm-border);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1;
            font-size: 12px;
            flex-shrink: 0;
        }
        
        .cm-timeline-icon.student { border-color: var(--cm-primary); color: var(--cm-primary); }
        .cm-timeline-icon.admin { border-color: #10B981; color: #10B981; }

        .cm-timeline-content {
            background: white;
            border: 1px solid var(--cm-border);
            padding: 12px 16px;
            border-radius: 12px;
            flex: 1;
            box-shadow: var(--cm-shadow-sm);
        }

        .cm-timeline-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 6px;
        }

        .cm-timeline-name {
            font-weight: 600;
            font-size: 13px;
            color: var(--cm-text-main);
        }

        .cm-timeline-time {
            font-size: 12px;
            color: var(--cm-text-muted);
        }

        .cm-timeline-text {
            font-size: 14px;
            color: var(--cm-text-main);
            margin: 0;
            line-height: 1.5;
        }

        /* Reply Section */
        .cm-reply-area {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .cm-textarea {
            width: 100%;
            border: 1px solid var(--cm-border);
            border-radius: 12px;
            padding: 16px;
            font-size: 14px;
            color: var(--cm-text-main);
            resize: vertical;
            min-height: 120px;
            font-family: inherit;
            outline: none;
            transition: border-color 0.2s;
        }

        .cm-textarea:focus {
            border-color: var(--cm-primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .cm-drawer-footer {
            padding: 16px 24px;
            border-top: 1px solid var(--cm-border);
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            background: #F8FAFC;
        }

        /* Delete Modal */
        .cm-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.5);
            z-index: 1100;
            display: none;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(2px);
        }

        .cm-modal {
            background: white;
            border-radius: 16px;
            width: 100%;
            max-width: 400px;
            padding: 32px 24px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
            text-align: center;
        }

        .cm-modal-icon {
            width: 64px;
            height: 64px;
            background: #FEE2E2;
            color: #EF4444;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin: 0 auto 16px;
        }

        .cm-modal-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--cm-text-main);
            margin: 0 0 8px 0;
        }

        .cm-modal-text {
            font-size: 14px;
            color: var(--cm-text-muted);
            margin: 0 0 24px 0;
            line-height: 1.5;
        }

        .cm-modal-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
        }

        .cm-btn-danger {
            background: #EF4444;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            flex: 1;
        }

        .cm-btn-danger:hover {
            background: #DC2626;
        }
        
        .cm-btn-cancel {
            background: white;
            color: var(--cm-text-main);
            border: 1px solid var(--cm-border);
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            flex: 1;
        }
        
        .cm-btn-cancel:hover {
            background: #F1F5F9;
        }

        /* Dropdown Action Menu */
        .cm-dropdown {
            position: relative;
            display: inline-block;
        }
        
        .cm-dropdown-menu {
            position: absolute;
            right: 0;
            top: 100%;
            min-width: 180px;
            background: white;
            border: 1px solid var(--cm-border);
            border-radius: 8px;
            box-shadow: var(--cm-shadow-lg);
            z-index: 10;
            display: none;
            padding: 8px 0;
        }
        
        .cm-dropdown.show .cm-dropdown-menu {
            display: block;
        }
        
        .cm-dropdown-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 16px;
            font-size: 14px;
            color: var(--cm-text-main);
            text-decoration: none;
            cursor: pointer;
            transition: background 0.1s;
        }
        
        .cm-dropdown-item:hover {
            background: #F1F5F9;
            color: var(--cm-primary);
        }
        
        .cm-dropdown-item.text-danger {
            color: #EF4444;
        }
        
        .cm-dropdown-item.text-danger:hover {
            background: #FEE2E2;
            color: #DC2626;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cm-container">
        <!-- Header -->
        <div class="cm-header-section">
            <div class="cm-title-area">
                <h1>Contact Messages</h1>
                <p>Manage enquiries and messages submitted through the contact form.</p>
            </div>

        </div>

        <!-- Summary Cards -->
        <div class="cm-stats-grid">
            <div class="cm-stat-card">
                <div class="cm-stat-icon icon-blue">
                    <i class="fa-solid fa-inbox"></i>
                </div>
                <div class="cm-stat-details">
                    <div class="cm-stat-title">Total Enquiries</div>
                    <div class="cm-stat-value">248</div>
                </div>
            </div>
            <div class="cm-stat-card">
                <div class="cm-stat-icon icon-yellow">
                    <i class="fa-solid fa-envelope-open-text"></i>
                </div>
                <div class="cm-stat-details">
                    <div class="cm-stat-title">New</div>
                    <div class="cm-stat-value">32</div>
                </div>
            </div>
            <div class="cm-stat-card">
                <div class="cm-stat-icon icon-orange">
                    <i class="fa-solid fa-spinner"></i>
                </div>
                <div class="cm-stat-details">
                    <div class="cm-stat-title">In Progress</div>
                    <div class="cm-stat-value">18</div>
                </div>
            </div>
            <div class="cm-stat-card">
                <div class="cm-stat-icon icon-green">
                    <i class="fa-solid fa-check-circle"></i>
                </div>
                <div class="cm-stat-details">
                    <div class="cm-stat-title">Resolved</div>
                    <div class="cm-stat-value">198</div>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="cm-content-card">
            <!-- Filters -->
            <div class="cm-filters-bar">
                <div class="cm-search-wrapper">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" class="cm-search-input" placeholder="Search by student name, email or subject..." />
                </div>
                <div class="cm-filter-group">
                    <select class="cm-select">
                        <option value="">All Status</option>
                        <option value="new">New</option>
                        <option value="inprogress">In Progress</option>
                        <option value="responded">Responded</option>
                        <option value="resolved">Resolved</option>
                    </select>

                    <select class="cm-select">
                        <option value="">Any Date</option>
                        <option value="today">Today</option>
                        <option value="week">This Week</option>
                        <option value="month">This Month</option>
                    </select>
                    <button type="button" class="cm-btn-clear">Clear Filters</button>
                </div>
            </div>

            <!-- Table -->
            <div class="cm-table-container">
                <table class="cm-table">
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Email</th>
                            <th>Subject</th>

                            <th>Submitted Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Row 1 -->
                        <tr style="background-color: #F8FAFC; border-left: 3px solid var(--cm-primary);">
                            <td>
                                <div class="cm-student-cell">
                                    <div class="cm-avatar" style="background-color: #6366F1;">DP</div>
                                    <span class="cm-student-name">Dhruvi Patel</span>
                                </div>
                            </td>
                            <td style="color: var(--cm-text-muted);">dhruvi@gmail.com</td>
                            <td><div class="cm-subject-text">Course Inquiry</div></td>

                            <td>21 Aug 2026</td>
                            <td><span class="cm-badge badge-new">New</span></td>
                            <td>
                                <div class="cm-dropdown">
                                    <button type="button" class="cm-action-btn" onclick="openDrawer('dhruvi');">
                                        <i class="fa-solid fa-eye"></i> View
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <!-- Row 2 -->
                        <tr>
                            <td>
                                <div class="cm-student-cell">
                                    <div class="cm-avatar" style="background-color: #EC4899;">RS</div>
                                    <span class="cm-student-name">Rahul Shah</span>
                                </div>
                            </td>
                            <td style="color: var(--cm-text-muted);">rahul@gmail.com</td>
                            <td><div class="cm-subject-text">Admission Query</div></td>

                            <td>21 Aug 2026</td>
                            <td><span class="cm-badge badge-progress">In Progress</span></td>
                            <td>
                                <div class="cm-dropdown">
                                    <button type="button" class="cm-action-btn" onclick="openDrawer('rahul');">
                                        <i class="fa-solid fa-eye"></i> View
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <!-- Row 3 -->
                        <tr>
                            <td>
                                <div class="cm-student-cell">
                                    <div class="cm-avatar" style="background-color: #10B981;">PP</div>
                                    <span class="cm-student-name">Priya Patel</span>
                                </div>
                            </td>
                            <td style="color: var(--cm-text-muted);">priya@gmail.com</td>
                            <td><div class="cm-subject-text">Fee Details</div></td>

                            <td>20 Aug 2026</td>
                            <td><span class="cm-badge badge-resolved">Resolved</span></td>
                            <td>
                                <div class="cm-dropdown">
                                    <button type="button" class="cm-action-btn" onclick="openDrawer('priya');">
                                        <i class="fa-solid fa-eye"></i> View
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <!-- Row 4 -->
                        <tr>
                            <td>
                                <div class="cm-student-cell">
                                    <div class="cm-avatar" style="background-color: #F59E0B;">AS</div>
                                    <span class="cm-student-name">Amit Shah</span>
                                </div>
                            </td>
                            <td style="color: var(--cm-text-muted);">amit@gmail.com</td>
                            <td><div class="cm-subject-text">Technical Issue</div></td>

                            <td>19 Aug 2026</td>
                            <td><span class="cm-badge badge-responded">Responded</span></td>
                            <td>
                                <div class="cm-dropdown">
                                    <button type="button" class="cm-action-btn" onclick="openDrawer('amit');">
                                        <i class="fa-solid fa-eye"></i> View
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="cm-pagination-bar">
                <div class="cm-pagination-info">Showing 1–10 of 248 enquiries</div>
                <div style="display:flex; align-items:center; gap: 20px;">
                    <div style="display:flex; align-items:center; gap: 8px; font-size:14px; color:var(--cm-text-muted);">
                        Rows per page:
                        <select class="cm-select" style="padding: 4px 24px 4px 10px;">
                            <option>10</option>
                            <option>20</option>
                            <option>50</option>
                        </select>
                    </div>
                    <div class="cm-pagination-controls">
                        <button class="cm-page-btn" disabled>Previous</button>
                        <button class="cm-page-btn active">1</button>
                        <button class="cm-page-btn">2</button>
                        <button class="cm-page-btn">3</button>
                        <button class="cm-page-btn">4</button>
                        <button class="cm-page-btn">5</button>
                        <button class="cm-page-btn">Next</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Drawer Overlay -->
    <div class="cm-drawer-overlay" id="cmDrawerOverlay" onclick="closeDrawer()"></div>

    <!-- Detail Drawer -->
    <div class="cm-drawer" id="cmDetailDrawer">
        <div class="cm-drawer-header">
            <h2 class="cm-drawer-title">Contact Details</h2>
            <div style="display:flex; gap: 10px;">
                <button class="cm-action-btn" style="color: #EF4444;" onclick="openDeleteModal()" title="Delete">
                    <i class="fa-solid fa-trash"></i>
                </button>
                <button class="cm-drawer-close" onclick="closeDrawer()">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>
        </div>
        
        <div class="cm-drawer-body">
            <!-- Details Grid -->
            <div class="cm-detail-grid">
                <div class="cm-detail-item">
                    <span class="cm-detail-label">Student</span>
                    <span class="cm-detail-value">Dhruvi Patel</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">Email</span>
                    <span class="cm-detail-value">dhruvi@gmail.com</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">Phone</span>
                    <span class="cm-detail-value">98765xxxxx</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">Submitted</span>
                    <span class="cm-detail-value">21 Aug 2026, 10:30 AM</span>
                </div>

                <div class="cm-detail-item">
                    <span class="cm-detail-label">Status</span>
                    <div class="cm-detail-status">
                        <select class="cm-status-dropdown" style="color: #2563EB; border-color: #BFDBFE; background-color: #EFF6FF;">
                            <option value="new" selected>New</option>
                            <option value="inprogress">In Progress</option>
                            <option value="responded">Responded</option>
                            <option value="resolved">Resolved</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Subject & Message -->
            <div class="cm-detail-item" style="margin-bottom: 12px;">
                <span class="cm-detail-label">Subject</span>
                <span class="cm-detail-value" style="font-weight: 700; font-size: 16px;">Course Inquiry</span>
            </div>
            
            <div class="cm-message-box">
                <p class="cm-message-text">"I want to know more about the BCA course and admission process."</p>
            </div>

            <!-- History Section -->
            <div class="cm-history-section">
                <h3 class="cm-section-title"><i class="fa-solid fa-clock-rotate-left"></i> Message History</h3>
                <div class="cm-timeline">
                    <!-- Student Message -->
                    <div class="cm-timeline-item">
                        <div class="cm-timeline-icon student"><i class="fa-solid fa-user"></i></div>
                        <div class="cm-timeline-content">
                            <div class="cm-timeline-header">
                                <span class="cm-timeline-name">Dhruvi Patel</span>
                                <span class="cm-timeline-time">21 Aug 2026, 10:30 AM</span>
                            </div>
                            <p class="cm-timeline-text">I want to know more about the BCA course and admission process.</p>
                        </div>
                    </div>
                    
                    <!-- Admin Reply (Hidden by default, shown to demonstrate state) -->
                    <div class="cm-timeline-item" id="adminReplyMock" style="display:none;">
                        <div class="cm-timeline-icon admin"><i class="fa-solid fa-user-shield"></i></div>
                        <div class="cm-timeline-content">
                            <div class="cm-timeline-header">
                                <span class="cm-timeline-name">Admin</span>
                                <span class="cm-timeline-time">21 Aug 2026, 11:15 AM</span>
                            </div>
                            <p class="cm-timeline-text">Thank you for contacting us. We will provide you with the required course information shortly.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Admin Response -->
            <div class="cm-reply-area">
                <label class="cm-detail-label">Admin Response</label>
                <textarea class="cm-textarea" placeholder="Type your response here..."></textarea>
            </div>
        </div>
        
        <div class="cm-drawer-footer">
            <button class="cm-btn cm-btn-outline" onclick="closeDrawer()">Cancel</button>
            <button class="cm-btn cm-btn-primary" onclick="sendReply()">
                <i class="fa-solid fa-paper-plane"></i> Send Reply
            </button>
        </div>
    </div>

    <!-- Delete Modal -->
    <div class="cm-modal-overlay" id="cmDeleteModal">
        <div class="cm-modal">
            <div class="cm-modal-icon">
                <i class="fa-solid fa-triangle-exclamation"></i>
            </div>
            <h2 class="cm-modal-title">Delete Contact Message?</h2>
            <p class="cm-modal-text">This contact message will be permanently deleted. This action cannot be undone.</p>
            <div class="cm-modal-actions">
                <button class="cm-btn-cancel" onclick="closeDeleteModal()">Cancel</button>
                <button class="cm-btn-danger" onclick="confirmDelete()">Delete</button>
            </div>
        </div>
    </div>

    <script>
        // Drawer Logic
        function openDrawer(studentId) {
            document.getElementById('cmDrawerOverlay').style.display = 'block';
            setTimeout(() => {
                document.getElementById('cmDetailDrawer').classList.add('open');
            }, 10);
            document.body.style.overflow = 'hidden';
            
            // Just for demo purposes, if it's Amit, show the reply
            if (studentId === 'amit') {
                document.getElementById('adminReplyMock').style.display = 'flex';
            } else {
                document.getElementById('adminReplyMock').style.display = 'none';
            }
        }

        function closeDrawer() {
            document.getElementById('cmDetailDrawer').classList.remove('open');
            setTimeout(() => {
                document.getElementById('cmDrawerOverlay').style.display = 'none';
            }, 300);
            document.body.style.overflow = '';
        }

        function sendReply() {
            // Mock sending reply
            document.getElementById('adminReplyMock').style.display = 'flex';
            document.querySelector('.cm-textarea').value = '';
            
            // Update status to Responded mock
            const statusDropdown = document.querySelector('.cm-status-dropdown');
            statusDropdown.value = 'responded';
            statusDropdown.style.color = '#9333EA';
            statusDropdown.style.borderColor = '#E9D5FF';
            statusDropdown.style.backgroundColor = '#FAF5FF';
        }

        // Modal Logic
        function openDeleteModal() {
            closeDrawer();
            setTimeout(() => {
                document.getElementById('cmDeleteModal').style.display = 'flex';
                document.body.style.overflow = 'hidden';
            }, 300);
        }

        function closeDeleteModal() {
            document.getElementById('cmDeleteModal').style.display = 'none';
            document.body.style.overflow = '';
        }

        function confirmDelete() {
            closeDeleteModal();
            // In a real app, you would make an AJAX call or postback to delete
        }

        // Status Dropdown Color Change Handler
        document.addEventListener('DOMContentLoaded', () => {
            const dropdowns = document.querySelectorAll('.cm-status-dropdown');
            dropdowns.forEach(dropdown => {
                dropdown.addEventListener('change', (e) => {
                    const val = e.target.value;
                    if (val === 'new') {
                        e.target.style.color = '#2563EB';
                        e.target.style.borderColor = '#BFDBFE';
                        e.target.style.backgroundColor = '#EFF6FF';
                    } else if (val === 'inprogress') {
                        e.target.style.color = '#EA580C';
                        e.target.style.borderColor = '#FED7AA';
                        e.target.style.backgroundColor = '#FFF7ED';
                    } else if (val === 'responded') {
                        e.target.style.color = '#9333EA';
                        e.target.style.borderColor = '#E9D5FF';
                        e.target.style.backgroundColor = '#FAF5FF';
                    } else if (val === 'resolved') {
                        e.target.style.color = '#16A34A';
                        e.target.style.borderColor = '#BBF7D0';
                        e.target.style.backgroundColor = '#F0FDF4';
                    }
                });
            });
        });
    </script>
</asp:Content>

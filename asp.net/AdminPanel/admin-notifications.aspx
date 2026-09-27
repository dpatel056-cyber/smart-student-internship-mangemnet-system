<%@ Page Title="Notifications" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-notifications.aspx.cs" Inherits="asp.net.css.admin_notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../js/admin-notifications.js" defer></script>
    <style>
        :root {
            --nt-primary: #4F46E5;
            --nt-primary-hover: #4338CA;
            --nt-bg: #F8FAFC;
            --nt-card-bg: #FFFFFF;
            --nt-text-main: #0F172A;
            --nt-text-muted: #64748B;
            --nt-border: #E2E8F0;
            --nt-shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --nt-shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --nt-radius: 12px;
            --nt-radius-lg: 16px;
            
            /* Status Colors */
            --nt-unread: #3B82F6;
            --nt-success: #10B981;
            --nt-warning: #F59E0B;
            --nt-danger: #EF4444;
            --nt-system: #94A3B8;
        }

        .nt-page-container {
            font-family: 'Inter', sans-serif;
            background-color: var(--nt-bg);
            padding: 24px;
            min-height: calc(100vh - 80px);
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* Header Section */
        .nt-header-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .nt-title-area h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--nt-text-main);
            margin: 0 0 4px 0;
        }

        .nt-title-area p {
            font-size: 14px;
            color: var(--nt-text-muted);
            margin: 0;
        }

        .nt-header-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .nt-btn-outline {
            padding: 8px 16px;
            background: white;
            border: 1px solid var(--nt-border);
            border-radius: 8px;
            color: var(--nt-text-main);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .nt-btn-outline:hover {
            background: #F1F5F9;
            border-color: #CBD5E1;
        }

        .nt-btn-icon {
            padding: 8px 12px;
            background: white;
            border: 1px solid var(--nt-border);
            border-radius: 8px;
            color: var(--nt-text-muted);
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .nt-btn-icon:hover {
            color: var(--nt-primary);
            border-color: #CBD5E1;
            background: #F8FAFC;
        }

        .nt-admin-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            padding-left: 12px;
            border-left: 1px solid var(--nt-border);
        }

        .nt-admin-avatar {
            width: 36px;
            height: 36px;
            background: var(--nt-primary);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        .nt-admin-info {
            display: flex;
            flex-direction: column;
        }

        .nt-admin-name {
            font-size: 14px;
            font-weight: 700;
            color: var(--nt-text-main);
            line-height: 1.2;
        }

        .nt-admin-role {
            font-size: 12px;
            color: var(--nt-text-muted);
        }

        /* Summary Cards */
        .nt-stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .nt-stat-card {
            background: var(--nt-card-bg);
            border-radius: var(--nt-radius);
            padding: 20px;
            box-shadow: var(--nt-shadow-sm);
            border: 1px solid var(--nt-border);
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .nt-stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .icon-blue { background: #EFF6FF; color: #3B82F6; }
        .icon-indigo { background: #EEF2FF; color: #4F46E5; }
        .icon-green { background: #DCFCE7; color: #16A34A; }
        .icon-orange { background: #FFF7ED; color: #EA580C; }

        .nt-stat-details {
            flex: 1;
        }

        .nt-stat-title {
            font-size: 13px;
            font-weight: 600;
            color: var(--nt-text-muted);
            margin-bottom: 4px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .nt-stat-value {
            font-size: 24px;
            font-weight: 700;
            color: var(--nt-text-main);
            line-height: 1;
            display: flex;
            align-items: baseline;
            gap: 8px;
        }

        .nt-stat-trend {
            font-size: 12px;
            font-weight: 500;
        }
        .trend-up { color: var(--nt-success); }
        .trend-neutral { color: var(--nt-text-muted); }

        /* Category Tabs */
        .nt-tabs {
            display: flex;
            gap: 8px;
            border-bottom: 1px solid var(--nt-border);
            padding-bottom: 2px;
            overflow-x: auto;
        }

        .nt-tab-item {
            padding: 10px 16px;
            font-size: 14px;
            font-weight: 600;
            color: var(--nt-text-muted);
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.2s;
            white-space: nowrap;
        }

        .nt-tab-item:hover {
            color: var(--nt-text-main);
        }

        .nt-tab-item.active {
            color: var(--nt-primary);
            border-bottom-color: var(--nt-primary);
        }

        /* Master-Detail Layout */
        .nt-layout {
            display: flex;
            gap: 24px;
            align-items: flex-start;
        }

        .nt-card {
            background: var(--nt-card-bg);
            border-radius: var(--nt-radius-lg);
            box-shadow: var(--nt-shadow-md);
            border: 1px solid var(--nt-border);
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        /* Left Column (65%) */
        .nt-col-list {
            flex: 0 0 65%;
            max-width: 65%;
        }

        .nt-filters-bar {
            padding: 16px 20px;
            border-bottom: 1px solid var(--nt-border);
            display: flex;
            gap: 12px;
            align-items: center;
            background: #F8FAFC;
        }

        .nt-search-wrapper {
            flex: 1;
            position: relative;
        }

        .nt-search-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94A3B8;
        }

        .nt-search-input {
            width: 100%;
            padding: 10px 14px 10px 36px;
            border: 1px solid var(--nt-border);
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            background: white;
            font-family: inherit;
        }

        .nt-search-input:focus {
            border-color: var(--nt-primary);
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
        }

        .nt-select {
            padding: 10px 32px 10px 14px;
            border: 1px solid var(--nt-border);
            border-radius: 8px;
            font-size: 14px;
            color: var(--nt-text-main);
            background: white;
            outline: none;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748B'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 16px;
        }

        .nt-btn-clear {
            background: none;
            border: none;
            color: var(--nt-text-muted);
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            white-space: nowrap;
        }
        .nt-btn-clear:hover { color: var(--nt-text-main); text-decoration: underline; }

        .nt-list-container {
            display: flex;
            flex-direction: column;
        }

        .nt-item {
            padding: 16px 20px;
            border-bottom: 1px solid var(--nt-border);
            display: flex;
            gap: 16px;
            align-items: flex-start;
            cursor: pointer;
            transition: background 0.2s;
            position: relative;
        }

        .nt-item:hover {
            background: #F8FAFC;
        }

        .nt-item.selected {
            background: #EEF2FF;
        }

        .nt-status-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin-top: 6px;
            flex-shrink: 0;
        }
        .dot-unread { background: var(--nt-unread); }
        .dot-read { background: var(--nt-success); }
        .dot-important { background: var(--nt-warning); }
        .dot-security { background: var(--nt-danger); }
        .dot-system { background: var(--nt-system); }

        .nt-item-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
            background: #F1F5F9;
            color: var(--nt-text-muted);
        }
        
        /* Category icon colors */
        .nt-item.type-students .nt-item-icon { background: #EFF6FF; color: #3B82F6; }
        .nt-item.type-contact .nt-item-icon { background: #F3E8FF; color: #A855F7; }
        .nt-item.type-feedback .nt-item-icon { background: #FEF3C7; color: #D97706; }
        .nt-item.type-companies .nt-item-icon { background: #E0E7FF; color: #4338CA; }
        .nt-item.type-security .nt-item-icon { background: #FEE2E2; color: #EF4444; }
        .nt-item.type-system .nt-item-icon { background: #F1F5F9; color: #64748B; }
        .nt-item.type-messages .nt-item-icon { background: #E0F2FE; color: #0284C7; }

        .nt-item-content {
            flex: 1;
            min-width: 0;
        }

        .nt-item-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 4px;
        }

        .nt-item-title {
            font-size: 15px;
            font-weight: 600;
            color: var(--nt-text-main);
        }

        .nt-item-time {
            font-size: 12px;
            color: var(--nt-text-muted);
            white-space: nowrap;
        }

        .nt-item-desc {
            font-size: 14px;
            color: var(--nt-text-muted);
            margin-bottom: 10px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .nt-item.unread .nt-item-title {
            font-weight: 700;
        }
        .nt-item.unread .nt-item-desc {
            color: var(--nt-text-main);
        }

        .nt-item-meta {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .nt-badge {
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 600;
            background: #F1F5F9;
            color: var(--nt-text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .nt-badge-important { background: #FEF2F2; color: #DC2626; border: 1px solid #FCA5A5; }
        .nt-badge-unread { background: #EFF6FF; color: #2563EB; }

        .nt-item-actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nt-btn-view {
            padding: 6px 12px;
            background: white;
            border: 1px solid var(--nt-border);
            border-radius: 6px;
            color: var(--nt-text-main);
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }
        .nt-btn-view:hover { background: #F8FAFC; border-color: #CBD5E1; }

        .nt-btn-more {
            padding: 6px 8px;
            background: none;
            border: none;
            color: #94A3B8;
            cursor: pointer;
            border-radius: 6px;
        }
        .nt-btn-more:hover { background: #F1F5F9; color: var(--nt-text-main); }

        /* Pagination */
        .nt-pagination {
            padding: 16px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: white;
            border-top: 1px solid var(--nt-border);
        }

        .nt-page-info {
            font-size: 14px;
            color: var(--nt-text-muted);
        }

        .nt-page-controls {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .nt-page-btn {
            min-width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--nt-border);
            background: white;
            color: var(--nt-text-main);
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            padding: 0 10px;
        }
        .nt-page-btn:hover:not(:disabled) { background: #F8FAFC; }
        .nt-page-btn.active { background: var(--nt-primary); color: white; border-color: var(--nt-primary); }
        .nt-page-btn:disabled { opacity: 0.5; cursor: not-allowed; }

        /* Right Column (35%) */
        .nt-col-details {
            display: none;
            flex: 0 0 35%;
            max-width: 35%;
            position: sticky;
            top: 24px;
        }

        .nt-layout.detail-open .nt-col-details { display: flex; }
        .nt-layout:not(.detail-open) .nt-col-list { flex: 1 1 100%; max-width: 100%; }
        .nt-filters-bar { display: none; }
        .nt-item-meta { display: none; }
        .nt-detail-panel { position: relative; }
        .nt-detail-back-btn {
            position: absolute;
            top: 18px;
            left: 20px;
            border: 0;
            background: transparent;
            color: #64748B;
            font-size: 22px;
            cursor: pointer;
            padding: 6px;
        }

        .nt-detail-panel {
            padding: 32px 24px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            background: white;
        }

        .nt-detail-icon {
            width: 72px;
            height: 72px;
            border-radius: 16px;
            background: #EFF6FF;
            color: #3B82F6;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin-bottom: 20px;
        }

        .nt-detail-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--nt-text-main);
            margin: 0 0 12px 0;
            line-height: 1.3;
        }

        .nt-detail-desc {
            font-size: 15px;
            color: var(--nt-text-muted);
            line-height: 1.5;
            margin: 0 0 32px 0;
        }

        .nt-detail-info-box {
            width: 100%;
            background: #F8FAFC;
            border: 1px solid var(--nt-border);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 32px;
            text-align: left;
        }

        .nt-detail-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid var(--nt-border);
        }
        .nt-detail-row:last-child { border-bottom: none; }

        .nt-detail-label { font-size: 13px; color: var(--nt-text-muted); font-weight: 500; }
        .nt-detail-value { font-size: 13px; color: var(--nt-text-main); font-weight: 600; }

        .nt-detail-actions {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .nt-btn-primary {
            width: 100%;
            padding: 12px;
            background: var(--nt-primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .nt-btn-primary:hover { background: var(--nt-primary-hover); }

        .nt-btn-secondary {
            width: 100%;
            padding: 12px;
            background: white;
            color: var(--nt-text-main);
            border: 1px solid var(--nt-border);
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .nt-btn-secondary:hover { background: #F8FAFC; }

        .nt-btn-danger {
            width: 100%;
            padding: 12px;
            background: white;
            color: var(--nt-danger);
            border: 1px solid #FEE2E2;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s;
        }
        .nt-btn-danger:hover { background: #FEF2F2; border-color: #FCA5A5; }
        
        /* Dropdown Action Menu */
        .nt-dropdown {
            position: relative;
            display: inline-block;
        }
        
        .nt-dropdown-menu {
            position: absolute;
            right: 0;
            top: 100%;
            min-width: 180px;
            background: white;
            border: 1px solid var(--nt-border);
            border-radius: 8px;
            box-shadow: var(--nt-shadow-md);
            z-index: 10;
            display: none;
            padding: 8px 0;
        }
        
        .nt-dropdown:hover .nt-dropdown-menu {
            display: block;
        }
        
        .nt-dropdown-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 16px;
            font-size: 14px;
            color: var(--nt-text-main);
            text-decoration: none;
            cursor: pointer;
            transition: background 0.1s;
        }
        
        .nt-dropdown-item:hover { background: #F1F5F9; color: var(--nt-primary); }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const list = document.querySelector('.nt-list-container');
            if (!list) return;
            const extra = [
                ['Internship application shortlisted', 'Karan Mehta application moved to shortlisted.', 'Students', 'Read', 'Today'],
                ['New company registered', 'Innovate Labs submitted a registration request.', 'Companies', 'Unread', 'Today'],
                ['Feedback received', 'A new 5-star feedback was submitted.', 'Feedback', 'Read', 'Yesterday'],
                ['Interview scheduled', 'An interview was scheduled for tomorrow.', 'Students', 'Unread', 'Yesterday'],
                ['Certificate generated', 'Placement certificate generated successfully.', 'Students', 'Read', 'Yesterday'],
                ['New message received', 'Sneha Desai sent a new message.', 'Messages', 'Unread', 'Yesterday'],
                ['Company profile updated', 'ABC Technologies updated its profile.', 'Companies', 'Read', 'This Week'],
                ['System backup completed', 'Weekly system backup completed successfully.', 'System', 'Read', 'This Week'],
                ['Application status updated', 'A student application status was updated.', 'Students', 'Unread', 'This Week'],
                ['Security check completed', 'Routine security verification completed.', 'Security', 'Read', 'This Week'],
                ['New contact enquiry', 'A new contact enquiry needs attention.', 'Contact', 'Unread', 'This Week'],
                ['Internship approval completed', 'An internship was approved by admin.', 'Companies', 'Read', 'This Week']
            ];
            extra.forEach(function (item, index) {
                const row = document.createElement('div');
                row.className = 'nt-item type-' + item[2].toLowerCase();
                if (item[3] === 'Unread') row.classList.add('unread');
                row.innerHTML = '<div class="nt-status-dot ' + (item[3] === 'Unread' ? 'dot-unread' : 'dot-read') + '"></div>' +
                    '<div class="nt-item-icon"><i class="fa-solid fa-bell"></i></div>' +
                    '<div class="nt-item-content"><div class="nt-item-header"><span class="nt-item-title">' + item[0] + '</span><span class="nt-item-time">' + item[4] + '</span></div>' +
                    '<div class="nt-item-desc">' + item[1] + '</div><div class="nt-item-meta"><span class="nt-badge">' + item[2] + '</span>' +
                    (item[3] === 'Unread' ? '<span class="nt-badge nt-badge-unread">Unread</span>' : '') + '</div></div>' +
                    '<div class="nt-item-actions"><button class="nt-btn-view">View</button><button class="nt-btn-more"><i class="fa-solid fa-ellipsis-vertical"></i></button></div>';
                list.appendChild(row);
            });

            const items = Array.from(list.querySelectorAll('.nt-item'));
            const search = document.querySelector('.nt-search-input');
            const filterSelects = document.querySelectorAll('.nt-filters-bar .nt-select');
            const categoryFilter = filterSelects[0];
            const readFilter = filterSelects[1];
            const dateFilter = filterSelects[2];
            const clear = document.querySelector('.nt-btn-clear');
            const pageInfo = document.querySelector('.nt-page-info');
            const controls = document.querySelector('.nt-page-controls');
            const pageSizeControl = document.querySelector('.nt-pagination .nt-select');
            let page = 1;
            let pageSize = pageSizeControl ? Number(pageSizeControl.value) || 10 : 10;

            function filteredItems() {
                const query = search ? search.value.toLowerCase().trim() : '';
                const category = categoryFilter ? categoryFilter.value.replace('Category: ', '') : 'All';
                const readStatus = readFilter ? readFilter.value.replace('Read Status: ', '') : 'All';
                const date = dateFilter ? dateFilter.value.replace('Date: ', '') : 'All Time';
                return items.filter(function (item) {
                    const text = item.textContent.toLowerCase();
                    const itemCategory = item.querySelector('.nt-badge') ? item.querySelector('.nt-badge').textContent.trim() : '';
                    const isUnread = item.classList.contains('unread');
                    const itemTime = item.querySelector('.nt-item-time') ? item.querySelector('.nt-item-time').textContent : '';
                    return (!query || text.includes(query)) &&
                        (category === 'All' || itemCategory === category) &&
                        (readStatus === 'All' || (readStatus === 'Unread' && isUnread) || (readStatus === 'Read' && !isUnread)) &&
                        (date === 'All Time' || itemTime.includes(date) || (date === 'This Week' && (itemTime.includes('Today') || itemTime.includes('Yesterday'))));
                });
            }

            function render() {
                const matches = filteredItems();
                const totalPages = Math.max(1, Math.ceil(matches.length / pageSize));
                if (page > totalPages) page = totalPages;
                items.forEach(function (item) { item.style.display = 'none'; });
                matches.slice((page - 1) * pageSize, page * pageSize).forEach(function (item) { item.style.display = 'flex'; });
                const first = matches.length ? ((page - 1) * pageSize) + 1 : 0;
                const last = Math.min(page * pageSize, matches.length);
                if (pageInfo) pageInfo.textContent = 'Showing ' + first + '-' + last + ' of ' + matches.length + ' notifications';
                if (!controls) return;
                controls.innerHTML = '';
                const previous = document.createElement('button');
                previous.className = 'nt-page-btn'; previous.textContent = 'Previous'; previous.disabled = page === 1;
                previous.onclick = function () { if (page > 1) { page--; render(); } };
                controls.appendChild(previous);
                for (let i = 1; i <= totalPages; i++) {
                    const button = document.createElement('button');
                    button.className = 'nt-page-btn' + (i === page ? ' active' : ''); button.textContent = i;
                    button.onclick = function () { page = i; render(); };
                    controls.appendChild(button);
                }
                const next = document.createElement('button');
                next.className = 'nt-page-btn'; next.textContent = 'Next'; next.disabled = page === totalPages;
                next.onclick = function () { if (page < totalPages) { page++; render(); } };
                controls.appendChild(next);
            }

            [search, categoryFilter, readFilter, dateFilter].forEach(function (control) {
                if (control) control.addEventListener(control.tagName === 'SELECT' ? 'change' : 'input', function () { page = 1; render(); });
            });
            if (clear) clear.addEventListener('click', function () {
                if (search) search.value = '';
                [categoryFilter, readFilter, dateFilter].forEach(function (select) { if (select) select.selectedIndex = 0; });
                page = 1; render();
            });
            if (pageSizeControl) pageSizeControl.addEventListener('change', function () { pageSize = Number(this.value) || 10; page = 1; render(); });
            document.querySelectorAll('.nt-btn-view').forEach(function (button) {
                button.addEventListener('click', function () {
                    const layout = document.querySelector('.nt-layout');
                    if (layout) layout.classList.add('detail-open');
                });
            });
            const detailBack = document.getElementById('ntDetailBackBtn');
            if (detailBack) detailBack.addEventListener('click', function () {
                const layout = document.querySelector('.nt-layout');
                if (layout) layout.classList.remove('detail-open');
            });
            document.addEventListener('click', function (event) {
                const viewButton = event.target.closest('.nt-btn-view');
                if (!viewButton) return;
                event.preventDefault();
                event.stopPropagation();
                const layout = document.querySelector('.nt-layout');
                if (layout) layout.classList.add('detail-open');
            }, true);
            render();
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="nt-page-container">
        
        <!-- Header Section -->
        <div class="nt-header-section">
            <div class="nt-title-area">
                <h1>Notifications</h1>
                <p>Stay updated with important system activities.</p>
            </div>
        </div>

        <!-- Summary Cards -->
        <div class="nt-stats-grid">
            <div class="nt-stat-card">
                <div class="nt-stat-icon icon-indigo"><i class="fa-solid fa-bell"></i></div>
                <div class="nt-stat-details">
                    <div class="nt-stat-title">Total Notifications</div>
                    <div class="nt-stat-value">248</div>
                </div>
            </div>
            <div class="nt-stat-card">
                <div class="nt-stat-icon icon-blue"><i class="fa-solid fa-envelope"></i></div>
                <div class="nt-stat-details">
                    <div class="nt-stat-title">Unread</div>
                    <div class="nt-stat-value">24 <span class="nt-stat-trend trend-neutral"></span></div>
                </div>
            </div>
            <div class="nt-stat-card">
                <div class="nt-stat-icon icon-green"><i class="fa-solid fa-envelope-open"></i></div>
                <div class="nt-stat-details">
                    <div class="nt-stat-title">Read</div>
                    <div class="nt-stat-value">224</div>
                </div>
            </div>
            <div class="nt-stat-card">
                <div class="nt-stat-icon icon-orange"><i class="fa-solid fa-triangle-exclamation"></i></div>
                <div class="nt-stat-details">
                    <div class="nt-stat-title">Important</div>
                    <div class="nt-stat-value">8 <span class="nt-stat-trend trend-up"><i class="fa-solid fa-arrow-trend-up"></i></span></div>
                </div>
            </div>
        </div>

        <!-- Master Detail Layout -->
        <div class="nt-layout">
            
            <!-- Left Column: Notification List -->
            <div class="nt-card nt-col-list">
                
                <!-- Filter Bar -->
                <div class="nt-filters-bar">
                    <div class="nt-search-wrapper">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" class="nt-search-input" placeholder="Search notifications..." />
                    </div>
                    <select class="nt-select">
                        <option>Category: All</option>
                        <option>Students</option>
                        <option>Companies</option>
                    </select>
                    <select class="nt-select">
                        <option>Read Status: All</option>
                        <option>Unread</option>
                        <option>Read</option>
                    </select>
                    <select class="nt-select">
                        <option>Date: All Time</option>
                        <option>Today</option>
                        <option>This Week</option>
                    </select>
                    <button type="button" class="nt-btn-clear">Clear Filters</button>
                </div>

                <!-- List Content -->
                <div class="nt-list-container">
                    
                    <!-- Item 1 (Selected & Unread) -->
                    <div class="nt-item selected unread type-students">
                        <div class="nt-status-dot dot-unread"></div>
                        <div class="nt-item-icon"><i class="fa-solid fa-user-plus"></i></div>
                        <div class="nt-item-content">
                            <div class="nt-item-header">
                                <span class="nt-item-title">New Student Registered</span>
                                <span class="nt-item-time">Today &bull; 10:30 AM</span>
                            </div>
                            <div class="nt-item-desc">Dhruvi Patel has registered as a new student.</div>
                            <div class="nt-item-meta">
                                <span class="nt-badge">Students</span>
                                <span class="nt-badge nt-badge-unread">Unread</span>
                            </div>
                        </div>
                        <div class="nt-item-actions">
                            <button class="nt-btn-view">View</button>
                            <div class="nt-dropdown">
                                <button class="nt-btn-more"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                <div class="nt-dropdown-menu">
                                    <div class="nt-dropdown-item"><i class="fa-solid fa-eye"></i> View Details</div>
                                    <div class="nt-dropdown-item"><i class="fa-solid fa-check"></i> Mark as Read</div>
                                    <div class="nt-dropdown-item" style="color:#EF4444;"><i class="fa-solid fa-trash"></i> Delete Notification</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Item 2 -->
                    <div class="nt-item unread type-contact">
                        <div class="nt-status-dot dot-unread"></div>
                        <div class="nt-item-icon"><i class="fa-solid fa-address-book"></i></div>
                        <div class="nt-item-content">
                            <div class="nt-item-header">
                                <span class="nt-item-title">New Contact Message</span>
                                <span class="nt-item-time">Today &bull; 09:45 AM</span>
                            </div>
                            <div class="nt-item-desc">Rahul Shah submitted a new contact enquiry.</div>
                            <div class="nt-item-meta">
                                <span class="nt-badge">Contact</span>
                                <span class="nt-badge nt-badge-unread">Unread</span>
                            </div>
                        </div>
                        <div class="nt-item-actions">
                            <button class="nt-btn-view">View</button>
                            <button class="nt-btn-more"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                        </div>
                    </div>

                    <!-- Item 3 -->
                    <div class="nt-item type-feedback">
                        <div class="nt-status-dot dot-read"></div>
                        <div class="nt-item-icon"><i class="fa-solid fa-star"></i></div>
                        <div class="nt-item-content">
                            <div class="nt-item-header">
                                <span class="nt-item-title">New Feedback Received</span>
                                <span class="nt-item-time">Today &bull; 09:20 AM</span>
                            </div>
                            <div class="nt-item-desc">Priya Patel submitted a 5-star rating.</div>
                            <div class="nt-item-meta">
                                <span class="nt-badge">Feedback</span>
                            </div>
                        </div>
                        <div class="nt-item-actions">
                            <button class="nt-btn-view">View</button>
                            <button class="nt-btn-more"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                        </div>
                    </div>

                    <!-- Item 4 -->
                    <div class="nt-item unread type-companies">
                        <div class="nt-status-dot dot-unread"></div>
                        <div class="nt-item-icon"><i class="fa-solid fa-building"></i></div>
                        <div class="nt-item-content">
                            <div class="nt-item-header">
                                <span class="nt-item-title">Company Approval Required</span>
                                <span class="nt-item-time">Today &bull; 09:00 AM</span>
                            </div>
                            <div class="nt-item-desc">XYZ Solutions is waiting for admin approval.</div>
                            <div class="nt-item-meta">
                                <span class="nt-badge">Companies</span>
                                <span class="nt-badge nt-badge-unread">Unread</span>
                            </div>
                        </div>
                        <div class="nt-item-actions">
                            <button class="nt-btn-view">Review</button>
                            <button class="nt-btn-more"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                        </div>
                    </div>

                    <!-- Item 5 (Security) -->
                    <div class="nt-item unread type-security" style="background: #FEF2F2;">
                        <div class="nt-status-dot dot-security"></div>
                        <div class="nt-item-icon"><i class="fa-solid fa-shield-halved"></i></div>
                        <div class="nt-item-content">
                            <div class="nt-item-header">
                                <span class="nt-item-title" style="color: #DC2626;">Security Alert</span>
                                <span class="nt-item-time">Yesterday &bull; 08:45 PM</span>
                            </div>
                            <div class="nt-item-desc" style="color: #991B1B;">5 failed login attempts detected for an account.</div>
                            <div class="nt-item-meta">
                                <span class="nt-badge">Security</span>
                                <span class="nt-badge nt-badge-important">Important</span>
                            </div>
                        </div>
                        <div class="nt-item-actions">
                            <button class="nt-btn-view" style="color: #DC2626; border-color: #FCA5A5;">View</button>
                            <button class="nt-btn-more"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                        </div>
                    </div>

                    <!-- Item 6 (System) -->
                    <div class="nt-item type-system">
                        <div class="nt-status-dot dot-system"></div>
                        <div class="nt-item-icon"><i class="fa-solid fa-server"></i></div>
                        <div class="nt-item-content">
                            <div class="nt-item-header">
                                <span class="nt-item-title">System Maintenance Scheduled</span>
                                <span class="nt-item-time">Yesterday &bull; 07:30 PM</span>
                            </div>
                            <div class="nt-item-desc">System maintenance scheduled on 25 Aug 2026 from 02:00 AM to 04:00 AM.</div>
                            <div class="nt-item-meta">
                                <span class="nt-badge">System</span>
                            </div>
                        </div>
                        <div class="nt-item-actions">
                            <button class="nt-btn-view">View</button>
                            <button class="nt-btn-more"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                        </div>
                    </div>

                    <!-- Item 7 -->
                    <div class="nt-item unread type-messages">
                        <div class="nt-status-dot dot-unread"></div>
                        <div class="nt-item-icon"><i class="fa-solid fa-comment-dots"></i></div>
                        <div class="nt-item-content">
                            <div class="nt-item-header">
                                <span class="nt-item-title">New Message Received</span>
                                <span class="nt-item-time">Yesterday &bull; 06:15 PM</span>
                            </div>
                            <div class="nt-item-desc">Amit Shah sent you a new message.</div>
                            <div class="nt-item-meta">
                                <span class="nt-badge">Messages</span>
                                <span class="nt-badge nt-badge-unread">Unread</span>
                            </div>
                        </div>
                        <div class="nt-item-actions">
                            <button class="nt-btn-view">View</button>
                            <button class="nt-btn-more"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                        </div>
                    </div>
                </div>

                <!-- Pagination -->
                <div class="nt-pagination">
                    <div class="nt-page-info">Showing 1-10 of 19 notifications</div>
                    <div style="display:flex; align-items:center; gap: 20px;">
                        <div style="display:flex; align-items:center; gap: 8px; font-size:14px; color:var(--nt-text-muted);">
                            Rows per page:
                            <select class="nt-select" style="padding: 4px 24px 4px 10px; background-position: right 8px center;">
                                <option>10</option>
                                <option>20</option>
                                <option>50</option>
                            </select>
                        </div>
                        <div class="nt-page-controls">
                            <button class="nt-page-btn" disabled>Previous</button>
                            <button class="nt-page-btn active">1</button>
                            <button class="nt-page-btn">2</button>
                            <button class="nt-page-btn">3</button>
                            <button class="nt-page-btn">4</button>
                            <button class="nt-page-btn">5</button>
                            <button class="nt-page-btn">Next</button>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Right Column: Detail Panel -->
            <div class="nt-card nt-col-details">
                <div class="nt-detail-panel">
                    <button type="button" class="nt-detail-back-btn" id="ntDetailBackBtn" title="Back to notifications">
                        <i class="fa-solid fa-arrow-left"></i>
                    </button>
                    <div class="nt-detail-icon">
                        <i class="fa-regular fa-bell"></i>
                    </div>
                    <h2 class="nt-detail-title">New Student Registered</h2>
                    <p class="nt-detail-desc">Dhruvi Patel has registered as a new student on the platform.</p>
                    
                    <div class="nt-detail-info-box">
                        <div class="nt-detail-row">
                            <span class="nt-detail-label">Category</span>
                            <span class="nt-detail-value">Students</span>
                        </div>
                        <div class="nt-detail-row">
                            <span class="nt-detail-label">Date & Time</span>
                            <span class="nt-detail-value">21 Aug 2026, 10:30 AM</span>
                        </div>
                        <div class="nt-detail-row">
                            <span class="nt-detail-label">Priority</span>
                            <span class="nt-detail-value">Medium</span>
                        </div>
                        <div class="nt-detail-row">
                            <span class="nt-detail-label">Status</span>
                            <span class="nt-detail-value" style="color: var(--nt-unread);">Unread</span>
                        </div>
                    </div>

                    <div class="nt-detail-actions">
                        <button type="button" class="nt-btn-primary">View Student Profile</button>
                        <button type="button" class="nt-btn-secondary">Mark as Read</button>
                        <button type="button" class="nt-btn-danger">Delete Notification</button>
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>

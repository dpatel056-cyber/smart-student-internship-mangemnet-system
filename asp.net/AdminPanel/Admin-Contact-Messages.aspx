<%@ Page Title="Contact Messages" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-contact-messages.aspx.cs" Inherits="asp.net.AdminPanel.Admin_Contact_Messages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --cm-primary: #4F46E5;
            --cm-primary-hover: #4338CA;
            --cm-bg: #F8FAFC;
            --cm-card-bg: #FFFFFF;
            --cm-text-main: #0F172A;
            --cm-text-muted: #64748B;
            --cm-border: #E2E8F0;
            --cm-shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --cm-shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.08), 0 2px 4px -2px rgb(0 0 0 / 0.06);
            --cm-shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.10), 0 4px 6px -4px rgb(0 0 0 / 0.08);
            --cm-radius: 12px;
            --cm-radius-lg: 16px;
        }

        /* ===== PAGE LAYOUT ===== */
        .cm-container {
            font-family: 'Inter', sans-serif;
            background-color: var(--cm-bg);
            padding: 30px clamp(16px, 3vw, 42px) 48px;
            min-height: calc(100vh - 80px);
            max-width: 1440px;
            margin: 0 auto;
            box-sizing: border-box;
        }

        .cm-header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
        }

        .cm-title-area h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--cm-text-main);
            margin: 0 0 5px 0;
            letter-spacing: -.02em;
        }

        .cm-title-area p {
            font-size: 14px;
            color: var(--cm-text-muted);
            margin: 0;
        }

        /* ===== BUTTONS ===== */
        .cm-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 10px 16px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all .2s ease;
            border: 1px solid transparent;
            text-decoration: none;
        }

        .cm-btn-outline {
            background: #fff;
            border-color: var(--cm-border);
            color: var(--cm-text-main);
            box-shadow: var(--cm-shadow-sm);
        }

            .cm-btn-outline:hover {
                background: #F1F5F9;
            }

        .cm-btn-primary {
            background: var(--cm-primary);
            color: #fff;
            border-color: var(--cm-primary);
            box-shadow: var(--cm-shadow-sm);
        }

            .cm-btn-primary:hover {
                background: var(--cm-primary-hover);
                border-color: var(--cm-primary-hover);
            }

        /* ===== STATS CARDS ===== */
        .cm-stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }

        .cm-stat-card {
            background: var(--cm-card-bg);
            border-radius: var(--cm-radius);
            padding: 20px;
            min-height: 94px;
            box-shadow: var(--cm-shadow-sm);
            border: 1px solid var(--cm-border);
            display: flex;
            align-items: center;
            gap: 16px;
            transition: transform .2s ease, box-shadow .2s ease;
        }

            .cm-stat-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 24px rgba(15, 23, 42, .08);
            }

        .cm-stat-icon {
            width: 48px;
            height: 48px;
            min-width: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .icon-blue {
            background: #EFF6FF;
            color: #3B82F6;
        }

        .icon-yellow {
            background: #FEF3C7;
            color: #D97706;
        }

        .icon-orange {
            background: #FFEDD5;
            color: #EA580C;
        }

        .icon-green {
            background: #DCFCE7;
            color: #16A34A;
        }

        .cm-stat-details {
            flex: 1;
        }

        .cm-stat-title {
            font-size: 14px;
            font-weight: 500;
            color: var(--cm-text-muted);
            margin-bottom: 5px;
        }

        .cm-stat-value {
            font-size: 27px;
            font-weight: 700;
            color: var(--cm-text-main);
            line-height: 1;
        }

        /* ===== CONTENT CARD & FILTERS ===== */
        .cm-content-card {
            background: #fff;
            border-radius: var(--cm-radius-lg);
            box-shadow: 0 12px 30px rgba(15, 23, 42, .07);
            border: 1px solid var(--cm-border);
            overflow: hidden;
        }

        .cm-filters-bar {
            padding: 18px 22px;
            border-bottom: 1px solid var(--cm-border);
            display: flex;
            flex-wrap: wrap;
            gap: 14px;
            align-items: center;
            justify-content: space-between;
            background: #fff;
        }

        .cm-search-wrapper {
            position: relative;
            flex: 1;
            min-width: 300px;
            max-width: 520px;
        }

            .cm-search-wrapper i {
                position: absolute;
                left: 14px;
                top: 50%;
                transform: translateY(-50%);
                color: #94A3B8;
                pointer-events: none;
            }

        .cm-search-input {
            width: 100%;
            box-sizing: border-box;
            padding: 11px 14px 11px 40px;
            border: 1px solid var(--cm-border);
            border-radius: 8px;
            font-size: 14px;
            color: var(--cm-text-main);
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }

            .cm-search-input:focus {
                border-color: var(--cm-primary);
                box-shadow: 0 0 0 3px rgba(79, 70, 229, .10);
            }

        .cm-filter-group {
            display: flex;
            gap: 12px;
            align-items: center;
            flex-wrap: wrap;
        }

        .cm-select {
            padding: 10px 36px 10px 14px;
            border: 1px solid var(--cm-border);
            border-radius: 8px;
            font-size: 14px;
            color: var(--cm-text-main);
            background-color: #fff;
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

        /* ===== TABLE ===== */
        .cm-table-container {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

            .cm-table-container > div {
                width: 100% !important;
            }

            .cm-table,
            .cm-table-container table {
                width: 100% !important;
                min-width: 760px;
                border-collapse: separate;
                border-spacing: 0;
            }

                .cm-table th,
                .cm-table-container th {
                    background: #F8FAFC;
                    padding: 15px 18px;
                    text-align: left;
                    font-size: 11px;
                    font-weight: 700;
                    color: #64748B;
                    text-transform: uppercase;
                    letter-spacing: .07em;
                    border-bottom: 1px solid var(--cm-border);
                    white-space: nowrap;
                }

                .cm-table td,
                .cm-table-container td {
                    padding: 17px 18px;
                    font-size: 14px;
                    color: #172554;
                    border-bottom: 1px solid #E8EDF4;
                    vertical-align: middle;
                }

                .cm-table tr:last-child td,
                .cm-table-container tr:last-child td {
                    border-bottom: 0;
                }

                .cm-table tr:hover td,
                .cm-table-container tr:hover td {
                    background: #F8FBFF;
                }

            /* ===== GRIDVIEW STATUS ===== */
            .cm-table-container td span {
                font-weight: 600;
            }

            /* ===== ACTION LINKS ===== */
            .cm-table-container td a {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                padding: 8px 11px;
                border: 1px solid #DBE5F2;
                border-radius: 8px;
                color: #2563EB;
                background: #fff;
                font-size: 13px;
                font-weight: 600;
                text-decoration: none;
                transition: all .2s ease;
            }

                .cm-table-container td a:hover {
                    background: #EFF6FF;
                    border-color: #93C5FD;
                }

        .cm-table-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cm-table-container td a.cm-delete-link {
            color: #ef4444;
            border-color: #fecaca;
        }

            .cm-table-container td a.cm-delete-link:hover {
                background: #fef2f2;
                border-color: #fca5a5;
            }

        /* ===== PAGINATION ===== */
        .cm-pagination-bar {
            padding: 16px 22px;
            border-top: 1px solid var(--cm-border);
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #fff;
        }

        .cm-pagination-info {
            font-size: 14px;
            color: var(--cm-text-muted);
        }

        /* ===== DRAWER OVERLAY ===== */
        .cm-drawer-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, .40);
            z-index: 1040;
            display: none;
            backdrop-filter: blur(2px);
        }

        /* ===== DRAWER ===== */
        .cm-drawer {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0.95);
            width: 600px;
            max-width: 92vw;
            max-height: 85vh;
            background: #fff;
            z-index: 1050;
            display: flex;
            flex-direction: column;
            border-radius: var(--cm-radius-lg);
            border: 1px solid #E2E8F0;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, .25);
            opacity: 0;
            visibility: hidden;
            transition: transform .3s cubic-bezier(.4, 0, .2, 1), opacity .3s cubic-bezier(.4, 0, .2, 1), visibility .3s;
        }

            .cm-drawer.open {
                transform: translate(-50%, -50%) scale(1);
                opacity: 1;
                visibility: visible;
            }

        /* ===== DRAWER HEADER ===== */
        .cm-drawer-header {
            min-height: 74px;
            padding: 0 28px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #fff;
            border-bottom: 1px solid #E2E8F0;
            flex-shrink: 0;
            border-radius: var(--cm-radius-lg) var(--cm-radius-lg) 0 0;
        }

        .cm-drawer-title {
            margin: 0;
            font-size: 18px;
            font-weight: 700;
            color: #0F172A;
        }

        .cm-drawer-header-actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .cm-action-btn {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: transparent;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all .2s ease;
        }

        .cm-delete-top-btn {
            color: #EF4444 !important;
        }

            .cm-delete-top-btn:hover {
                background: #FEF2F2;
                color: #DC2626 !important;
            }

        .cm-drawer-close {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: transparent;
            border: none;
            color: #94A3B8;
            font-size: 21px;
            border-radius: 8px;
            cursor: pointer;
            transition: all .2s ease;
        }

            .cm-drawer-close:hover {
                background: #F1F5F9;
                color: #475569;
            }

        /* ===== DRAWER BODY ===== */
        .cm-drawer-body {
            flex: 1;
            overflow-y: auto;
            padding: 26px 28px 35px;
            background: #fff;
            box-sizing: border-box;
        }

        /* ===== DETAILS GRID ===== */
        .cm-detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            column-gap: 38px;
            row-gap: 25px;
            margin-bottom: 30px;
        }

        .cm-detail-item {
            display: flex;
            flex-direction: column;
            gap: 7px;
            min-width: 0;
        }

        .cm-detail-label {
            display: block;
            font-size: 11px;
            font-weight: 700;
            color: #7890AD;
            text-transform: uppercase;
            letter-spacing: .08em;
        }

        .cm-detail-value {
            display: block;
            font-size: 15px;
            line-height: 1.45;
            font-weight: 500;
            color: #172554;
            overflow-wrap: anywhere;
        }

        /* ===== STATUS ===== */
        .cm-detail-status {
            display: flex;
            align-items: center;
        }

        .cm-status-dropdown {
            min-width: 128px;
            padding: 8px 32px 8px 12px;
            border: 1px solid #BFDBFE;
            border-radius: 8px;
            color: #2563EB;
            background: #EFF6FF;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            outline: none;
        }

        /* ===== SUBJECT ===== */
        .cm-subject-section {
            display: flex;
            flex-direction: column;
            gap: 7px;
            margin-bottom: 12px;
        }

        .cm-subject-value {
            display: block;
            font-size: 18px;
            line-height: 1.4;
            font-weight: 700;
            color: #172554;
            overflow-wrap: anywhere;
        }

        /* ===== MESSAGE ===== */
        .cm-message-section {
            margin-bottom: 30px;
        }

        .cm-message-box {
            width: 100%;
            box-sizing: border-box;
            padding: 17px 18px;
            background: #F8FAFC;
            border: 1px solid #E2E8F0;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(15, 23, 42, .03);
        }

        .cm-message-text {
            display: block;
            font-size: 14px;
            line-height: 1.65;
            color: #334155;
            overflow-wrap: anywhere;
        }

        /* ===== HISTORY ===== */
        .cm-history-section {
            margin-bottom: 30px;
        }

        .cm-section-title {
            display: flex;
            align-items: center;
            gap: 8px;
            margin: 0 0 16px;
            font-size: 16px;
            font-weight: 700;
            color: #172033;
        }

            .cm-section-title i {
                font-size: 16px;
            }

        .cm-timeline {
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 14px;
        }

            .cm-timeline::before {
                content: "";
                position: absolute;
                left: 15px;
                top: 10px;
                bottom: 10px;
                width: 2px;
                background: #E2E8F0;
            }

        .cm-timeline-item {
            position: relative;
            display: flex;
            gap: 13px;
            align-items: flex-start;
        }

        .cm-timeline-icon {
            width: 32px;
            min-width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 2;
            font-size: 12px;
        }

            .cm-timeline-icon.student {
                border: 2px solid #4F46E5;
                color: #4F46E5;
            }

            .cm-timeline-icon.admin {
                border: 2px solid #10B981;
                color: #10B981;
            }

        .cm-timeline-content {
            flex: 1;
            min-width: 0;
            background: #fff;
            border: 1px solid #DFE6EF;
            border-radius: 11px;
            padding: 13px 15px;
            box-shadow: 0 2px 8px rgba(15, 23, 42, .04);
        }

        .cm-timeline-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            margin-bottom: 7px;
        }

        .cm-timeline-name {
            font-size: 14px;
            font-weight: 700;
            color: #172033;
        }

        .cm-timeline-time {
            font-size: 11px;
            color: #64748B;
            white-space: nowrap;
        }

        .cm-timeline-text {
            margin: 0;
            font-size: 13px;
            line-height: 1.55;
            color: #334155;
            overflow-wrap: anywhere;
        }

        /* ===== ADMIN RESPONSE ===== */
        .cm-reply-area {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 4px;
        }

        .cm-textarea {
            width: 100%;
            min-height: 125px;
            box-sizing: border-box;
            padding: 14px 15px;
            border: 1px solid #DBE3ED;
            border-radius: 11px;
            background: #fff;
            font-family: inherit;
            font-size: 14px;
            line-height: 1.55;
            color: #172033;
            resize: vertical;
            outline: none;
            transition: all .2s ease;
        }

            .cm-textarea::placeholder {
                color: #94A3B8;
            }

            .cm-textarea:focus {
                border-color: #4F46E5;
                box-shadow: 0 0 0 3px rgba(79, 70, 229, .10);
            }

        /* ===== DRAWER FOOTER ===== */
        .cm-drawer-footer {
            min-height: 72px;
            padding: 15px 28px;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 10px;
            background: #F8FAFC;
            border-top: 1px solid #E2E8F0;
            flex-shrink: 0;
        }

            .cm-drawer-footer .cm-btn {
                min-width: 95px;
                justify-content: center;
            }

        /* ===== DELETE MODAL ===== */
        .cm-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, .50);
            z-index: 1100;
            display: none;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(2px);
            padding: 20px;
            box-sizing: border-box;
        }

        .cm-modal {
            width: 100%;
            max-width: 400px;
            background: #fff;
            border-radius: 16px;
            padding: 32px 24px;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, .10), 0 10px 10px -5px rgba(0, 0, 0, .04);
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
            margin: 0 0 8px;
        }

        .cm-modal-text {
            font-size: 14px;
            color: var(--cm-text-muted);
            margin: 0 0 24px;
            line-height: 1.5;
        }

        .cm-modal-actions {
            display: flex;
            gap: 12px;
            justify-content: center;
        }

        .cm-btn-danger {
            background: #EF4444;
            color: #fff;
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
            background: #fff;
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

        /* ===== RESPONSIVE ===== */
        @media (max-width: 900px) {
            .cm-stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }

            .cm-filters-bar {
                align-items: stretch;
            }

            .cm-search-wrapper {
                max-width: none;
                width: 100%;
            }
        }

        @media (max-width: 600px) {
            .cm-container {
                padding: 20px 12px 32px;
            }

            .cm-title-area h1 {
                font-size: 22px;
            }

            .cm-stats-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .cm-filter-group {
                width: 100%;
            }

                .cm-filter-group .cm-select {
                    flex: 1;
                    min-width: 0;
                }

            .cm-detail-grid {
                grid-template-columns: 1fr;
                row-gap: 18px;
            }

            .cm-drawer {
                width: 100vw;
            }

            .cm-drawer-header {
                padding: 0 18px;
            }

            .cm-drawer-body {
                padding: 22px 18px 30px;
            }

            .cm-drawer-footer {
                padding: 14px 18px;
            }

            .cm-timeline-header {
                align-items: flex-start;
                flex-direction: column;
                gap: 3px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cm-container">

        <!-- Page Header -->
        <div class="cm-header-section">
            <div class="cm-title-area">
                <h1>Contact Messages</h1>
                <p>Manage enquiries and messages submitted through the contact form.</p>
            </div>
        </div>

        <!-- Content Card -->
        <div class="cm-content-card">

            <!-- Search Bar -->
            <div class="cm-filters-bar" style="padding: 18px 22px; border-bottom: 1px solid var(--cm-border); display: flex; align-items: center; justify-content: space-between; background: #fff;">
                <div class="cm-search-wrapper" style="position: relative; flex: 1; min-width: 300px; max-width: 520px;">
                    <i class="fa-solid fa-magnifying-glass" style="position: absolute; left: 14px; top: 50%; transform: translateY(-50%); color: #94A3B8; pointer-events: none;"></i>
                    <input type="text" id="txtSearch" class="cm-search-input" placeholder="Search by student name, email or subject..." style="width: 100%; box-sizing: border-box; padding: 11px 14px 11px 40px; border: 1px solid var(--cm-border); border-radius: 8px; font-size: 14px; color: var(--cm-text-main); outline: none;" />
                </div>
            </div>

            <!-- Messages Table -->
            <div class="cm-table-container">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" CssClass="cm-table" UseAccessibleHeader="true" GridLines="None" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Student">
                            <ItemTemplate>
                                <asp:Label ID="lblStudent" runat="server" Text='<%# Eval("c_name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("c_email") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Subject">
                            <ItemTemplate>
                                <asp:Label ID="lblSubject" runat="server" Text='<%# Eval("c_subject") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Submitted Date">
                            <ItemTemplate>
                                <asp:Label ID="lblSubmittedDate" runat="server" Text='<%# Eval("c_date", "{0:dd MMM yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Submitted Time">
                            <ItemTemplate>
                                <asp:Label ID="lblSubmittedTime" runat="server" Text='<%# Eval("c_date", "{0:hh:mm tt}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ACTION">
                            <ItemTemplate>
                                <div class="cm-table-actions">
                                    <asp:LinkButton ID="btnView" runat="server" CommandName="ViewContact" CommandArgument='<%# Eval("Id") %>'><i class="fa-solid fa-eye"></i> View</asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("Id") %>' CssClass="cm-delete-link" CausesValidation="false"><i class="fa-solid fa-trash-can"></i> Delete</asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- Drawer Overlay -->
        <div class="cm-drawer-overlay" id="cmDrawerOverlay" onclick="closeDrawer()"></div>
        <!-- Details Drawer -->
        <div class="cm-drawer" id="cmDetailDrawer">
            <asp:HiddenField ID="hfContactId" runat="server" />
            <div class="cm-drawer-header">
                <h2 class="cm-drawer-title">Contact Details</h2>
                <div class="cm-drawer-header-actions">
                    <button type="button" class="cm-drawer-close" onclick="closeDrawer()">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
            </div>
            <div class="cm-drawer-body">
                <div class="cm-detail-grid">
                    <!-- Student -->
                    <div class="cm-detail-item">
                        <span class="cm-detail-label">Student</span>
                        <asp:Label ID="lblDetailName" runat="server" CssClass="cm-detail-value"></asp:Label>
                    </div>
                    <!-- Email -->
                    <div class="cm-detail-item">
                        <span class="cm-detail-label">Email</span>
                        <asp:Label ID="lblDetailEmail" runat="server" CssClass="cm-detail-value"></asp:Label>
                    </div>
                    <!-- Submitted Date -->
                    <div class="cm-detail-item">
                        <span class="cm-detail-label">Submitted Date</span>
                        <asp:Label ID="lblDetailDate" runat="server" CssClass="cm-detail-value"></asp:Label>
                    </div>
                    <!-- Submitted Time -->
                    <div class="cm-detail-item">
                        <span class="cm-detail-label">Submitted Time</span>
                        <asp:Label ID="lblDetailTime" runat="server" CssClass="cm-detail-value"></asp:Label>
                    </div>
                </div>
                <!-- Subject -->
                <div class="cm-subject-section">
                    <span class="cm-detail-label">Subject</span>
                    <asp:Label ID="lblDetailSubject" runat="server" CssClass="cm-subject-value"></asp:Label>
                </div>
                <br />
                <!-- Message -->
                <div class="cm-message-section">
                    <span class="cm-detail-label">Message</span>
                    <div class="cm-message-box">
                        <asp:Label ID="lblDetailMessage" runat="server" CssClass="cm-message-text"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        /* OPEN DRAWER */
        function openDrawer() {
            var overlay = document.getElementById('cmDrawerOverlay');
            var drawer = document.getElementById('cmDetailDrawer');
            if (overlay) {
                overlay.style.display = 'block';
            }
            setTimeout(function () {
                if (drawer) {
                    drawer.classList.add('open');
                }
            }, 10);
            document.body.style.overflow = 'hidden';
        }

        /* CLOSE DRAWER */
        function closeDrawer() {
            var drawer = document.getElementById('cmDetailDrawer');
            var overlay = document.getElementById('cmDrawerOverlay');
            if (drawer) {
                drawer.classList.remove('open');
            }
            setTimeout(function () {
                if (overlay) {
                    overlay.style.display = 'none';
                }
            }, 300);
            document.body.style.overflow = '';
        }
    </script>
</asp:Content>

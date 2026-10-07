<%@ Page Title="Offer Letters" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-offer-letters.aspx.cs" Inherits="asp.net.company_offer_letters" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <style>
        .page-header-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 24px;
        }
        .btn-open-drawer {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 18px;
            background: #2563eb;
            color: #ffffff;
            border-radius: 10px;
            font-size: 13.5px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(37,99,235,0.2);
            transition: all 0.2s ease;
        }
        .btn-open-drawer:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(37,99,235,0.25);
        }
        /* Stats Grid */
        .task-stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 24px;
        }
        @media (max-width: 991px) {
            .task-stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 575px) {
            .task-stats-grid {
                grid-template-columns: 1fr;
            }
        }
        .stat-card-task {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 16px 20px;
            display: flex;
            align-items: center;
            gap: 14px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.02);
            transition: transform 0.2s;
        }
        .stat-card-task:hover {
            transform: translateY(-2px);
        }
        /* Modal / Drawer Overlay & Panel */
        .drawer-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.55);
            backdrop-filter: blur(4px);
            z-index: 1040;
            display: none;
        }
        .drawer-panel {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0.95);
            width: 1220px;
            max-width: 95vw;
            height: 90vh;
            max-height: 90vh;
            background: #f8fafc;
            border-radius: 18px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 25px 50px -12px rgba(15, 23, 42, 0.3);
            z-index: 1050;
            display: flex;
            flex-direction: column;
            opacity: 0;
            visibility: hidden;
            overflow: hidden;
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.3s cubic-bezier(0.4, 0, 0.2, 1), visibility 0.3s;
        }
        .drawer-panel.open {
            transform: translate(-50%, -50%) scale(1);
            opacity: 1;
            visibility: visible;
        }
        .drawer-header {
            padding: 16px 24px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #ffffff;
            border-radius: 18px 18px 0 0;
            flex-shrink: 0;
        }
        .drawer-header h2 {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .drawer-close-btn {
            width: 34px;
            height: 34px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #ffffff;
            border: 1px solid #cbd5e1;
            font-size: 20px;
            line-height: 1;
            color: #64748b;
            cursor: pointer;
            border-radius: 8px;
            transition: all 0.15s ease;
        }
        .drawer-close-btn:hover {
            background: #f1f5f9;
            color: #0f172a;
            border-color: #94a3b8;
        }
        .drawer-body {
            padding: 18px 22px;
            overflow: hidden;
            flex: 1;
            min-height: 0;
            display: flex;
        }
        .drawer-footer {
            padding: 14px 24px;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            background: #ffffff;
            border-radius: 0 0 18px 18px;
            flex-shrink: 0;
        }
        .btn-drawer-cancel {
            padding: 10px 18px;
            background: #ffffff;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            color: #475569;
            cursor: pointer;
            transition: all 0.15s ease;
        }
        .btn-drawer-cancel:hover {
            background: #f1f5f9;
            color: #0f172a;
        }
        .offer-builder-grid {
            display: grid;
            grid-template-columns: 460px 1fr;
            gap: 20px;
            width: 100%;
            height: 100%;
            min-height: 0;
            align-items: stretch;
        }
        @media (max-width: 1100px) {
            .drawer-panel {
                height: 92vh;
            }
            .drawer-body {
                overflow-y: auto;
                display: block;
            }
            .offer-builder-grid {
                display: flex;
                flex-direction: column;
                height: auto;
            }
            .preview-wrapper {
                height: auto !important;
                max-height: none !important;
                overflow-y: visible !important;
            }
        }
        .builder-form-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(15,23,42,0.03);
            height: 100%;
            overflow-y: auto;
            box-sizing: border-box;
            position: sticky;
            top: 0;
        }
        .builder-form-card h2 {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 14px 0;
            display: flex;
            align-items: center;
            gap: 8px;
            padding-bottom: 10px;
            border-bottom: 1px solid #f1f5f9;
        }
        .form-row-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        .form-item {
            margin-bottom: 13px;
        }
        .form-item label {
            display: block;
            font-size: 12.5px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 5px;
        }
        .form-input-ctrl {
            width: 100%;
            padding: 9px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13px;
            color: #0f172a;
            outline: none;
            background: #f8fafc;
            box-sizing: border-box;
            transition: all 0.15s ease;
        }
        .form-input-ctrl:focus {
            border-color: #2563eb;
            background: #ffffff;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.08);
        }
        .btn-send-offer {
            padding: 10px 22px;
            background: #2563eb;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            transition: background 0.15s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }
        .btn-send-offer:hover {
            background: #1d4ed8;
        }
        .btn-reset-form {
            padding: 10px 16px;
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
        }
        .btn-reset-form:hover {
            background: #e2e8f0;
            color: #0f172a;
        }
        /* Official Letterhead Preview Styling - Independently Scrollable */
        .preview-wrapper {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 18px 20px 20px 20px;
            box-shadow: 0 2px 10px rgba(15,23,42,0.03);
            height: 100%;
            max-height: 100%;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            box-sizing: border-box;
        }
        .letterhead-scroll-box {
            flex: 1;
            overflow-y: auto;
            min-height: 0;
            padding-right: 4px;
        }
        .letterhead-scroll-box::-webkit-scrollbar,
        .builder-form-card::-webkit-scrollbar {
            width: 6px;
        }
        .letterhead-scroll-box::-webkit-scrollbar-track,
        .builder-form-card::-webkit-scrollbar-track {
            background: #f8fafc;
            border-radius: 10px;
        }
        .letterhead-scroll-box::-webkit-scrollbar-thumb,
        .builder-form-card::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 10px;
        }
        .letterhead-scroll-box::-webkit-scrollbar-thumb:hover,
        .builder-form-card::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }
        .preview-header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            padding-bottom: 10px;
            border-bottom: 1px solid #f1f5f9;
            background: #ffffff;
            flex-shrink: 0;
        }
        .live-badge {
            background: #ecfdf5;
            color: #059669;
            border: 1px solid #a7f3d0;
            padding: 3px 9px;
            border-radius: 12px;
            font-size: 11.5px;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        .live-dot {
            width: 7px;
            height: 7px;
            background: #10b981;
            border-radius: 50%;
            animation: pulse 1.5s infinite;
        }
        @keyframes pulse {
            0% { opacity: 1; transform: scale(1); }
            50% { opacity: 0.4; transform: scale(1.2); }
            100% { opacity: 1; transform: scale(1); }
        }
        /* Letterhead A4 Document */
        .letterhead-doc {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 28px 32px;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
            box-shadow: 0 2px 8px rgba(0,0,0,0.03);
            font-size: 13px;
            line-height: 1.6;
        }
        .lh-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 2px solid #2563eb;
            padding-bottom: 14px;
            margin-bottom: 16px;
        }
        .lh-company-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 2px solid #2563eb;
            padding-bottom: 14px;
            margin-bottom: 16px;
        }
        .lh-brand-info h2, .lh-brand-name {
            font-size: 20px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 2px 0;
            letter-spacing: -0.3px;
        }
        .lh-brand-sub {
            font-size: 11.5px;
            color: #64748b;
            margin: 0;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .lh-company-meta {
            text-align: right;
            font-size: 11px;
            color: #64748b;
            line-height: 1.4;
        }
        .lh-date-ref {
            display: flex;
            justify-content: space-between;
            font-size: 11.5px;
            color: #64748b;
            margin-bottom: 14px;
            font-weight: 600;
        }
        .lh-recipient-box {
            background: #f8fafc;
            border-left: 3px solid #2563eb;
            padding: 8px 12px;
            border-radius: 0 6px 6px 0;
            margin-bottom: 14px;
            font-size: 12.5px;
        }
        .lh-recipient-box p {
            margin: 0 0 2px 0;
        }
        .lh-subject {
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 12px;
            font-size: 13.5px;
            border-bottom: 1px solid #f1f5f9;
            padding-bottom: 6px;
        }
        .lh-terms-table {
            width: 100%;
            border-collapse: collapse;
            margin: 14px 0;
            font-size: 12.5px;
        }
        .lh-terms-table th, .lh-terms-table td {
            padding: 7px 10px;
            border: 1px solid #e2e8f0;
            text-align: left;
        }
        .lh-terms-table th {
            background: #f8fafc;
            color: #475569;
            font-weight: 600;
            width: 38%;
        }
        .lh-terms-table td {
            color: #0f172a;
            font-weight: 600;
        }
        .lh-sign-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 20px;
            padding-top: 12px;
            border-top: 1px solid #f1f5f9;
        }
        .lh-seal-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 10px;
            border: 1.5px dashed #2563eb;
            border-radius: 8px;
            color: #2563eb;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }
        .co-table-responsive {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            scrollbar-width: none; /* Firefox */
            -ms-overflow-style: none; /* IE and Edge */
        }
        .co-table-responsive::-webkit-scrollbar {
            display: none; /* Chrome, Safari, Opera */
            width: 0;
            height: 0;
        }
        .co-table {
            width: 100%;
            min-width: 980px;
            border-collapse: collapse;
            font-size: 13px;
        }
        .co-table th {
            background: #f8fafc;
            padding: 14px 18px;
            font-weight: 600;
            color: #475569;
            border-bottom: 1px solid #e2e8f0;
            text-align: left;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }
        .co-table td {
            padding: 14px 18px;
            border-bottom: 1px solid #f1f5f9;
            color: #334155;
            vertical-align: middle;
        }
        .co-table tr:hover td {
            background: #f8fafc;
        }
        /* Buttons in GridView */
        .btn-table-action {
            padding: 7px 12px;
            font-size: 12.5px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.15s ease;
            cursor: pointer;
            border: 1px solid transparent;
            white-space: nowrap;
            line-height: 1.2;
            flex-shrink: 0;
        }
        .btn-action-view {
            background: #eff6ff;
            color: #2563eb;
            border-color: #bfdbfe;
        }
        .btn-action-view:hover {
            background: #2563eb;
            color: #ffffff;
        }
        .btn-action-edit {
            background: #f8fafc;
            color: #475569;
            border-color: #cbd5e1;
        }
        .btn-action-edit:hover {
            background: #e2e8f0;
            color: #0f172a;
        }
        .btn-action-delete {
            background: #fef2f2;
            color: #dc2626;
            border-color: #fecaca;
        }
        .btn-action-delete:hover {
            background: #dc2626;
            color: #ffffff;
        }
        /* Fullscreen View / Print Modal */
        .print-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1060;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .print-modal-container {
            background: #f8fafc;
            width: 100%;
            max-width: 800px;
            max-height: 90vh;
            border-radius: 16px;
            overflow-y: auto;
            box-shadow: 0 20px 40px rgba(0,0,0,0.25);
            display: flex;
            flex-direction: column;
        }
        .print-modal-bar {
            padding: 14px 24px;
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        .btn-print-btn {
            padding: 8px 16px;
            background: #2563eb;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-print-btn:hover {
            background: #1d4ed8;
        }
        .btn-close-modal {
            background: none;
            border: none;
            font-size: 22px;
            color: #64748b;
            cursor: pointer;
        }
        .btn-close-modal:hover {
            color: #0f172a;
        }
        @media print {
            body * {
                visibility: hidden;
            }
            #printableLetterhead, #printableLetterhead * {
                visibility: visible;
            }
            #printableLetterhead {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                box-shadow: none !important;
                border: none !important;
                padding: 0 !important;
            }
            .print-modal-bar, .company-sidebar, .company-topbar, .btn-print-btn, .btn-close-modal, .drawer-panel, .drawer-overlay {
                display: none !important;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header -->
    <div class="page-header-box">
        <div>
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Offer Letters</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Generate, preview, issue, and manage official internship offer letters for selected candidates.</p>
        </div>
        <button type="button" class="btn-open-drawer" onclick="openDrawer();">
            <i class="fa-solid fa-file-circle-plus"></i> Generate New Offer Letter
        </button>
    </div>
    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    <!-- Stats Summary Cards -->
    <div class="task-stats-grid">
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#eff6ff; color:#2563eb; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-file-signature"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblTotalOffers" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Total Offers Issued</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#f0fdf4; color:#16a34a; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-circle-check"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblAcceptedOffers" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Accepted Offers</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#fef9c3; color:#ca8a04; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-paper-plane"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblSentOffers" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Sent / Pending Response</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#fee2e2; color:#dc2626; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-circle-xmark"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblRejectedOffers" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Declined / Rejected</div>
            </div>
        </div>
    </div>
    <!-- ================= ISSUED OFFER LETTERS GRIDVIEW ================= -->
    <div class="co-panel" style="margin-bottom: 30px; width: 100%;">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-file-signature" style="color: #2563eb; margin-right: 8px;"></i> Issued Offer Letters</h3>
        </div>
        <div class="co-table-responsive">
            <asp:GridView ID="gvOffers" runat="server" AutoGenerateColumns="False" OnRowCommand="gvOffers_RowCommand" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true">
                <Columns>
                    <asp:TemplateField HeaderText="Candidate" ItemStyle-Width="25%">
                        <ItemTemplate>
                            <div class="co-applicant-cell" style="min-width: 210px;">
                                <div class="co-applicant-avatar av2"><%# GetInitials(Eval("FullName")) %></div>
                                <div>
                                    <div style="font-weight: 700; color: #0f172a; font-size: 13.5px;"><%# Eval("FullName") %></div>
                                    <div style="font-size: 12px; color: #64748b;"><%# Eval("StudentEmail") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Offer Designation & Stipend" ItemStyle-Width="26%">
                        <ItemTemplate>
                            <div style="min-width: 210px;">
                                <div style="font-weight: 600; color: #1e293b; font-size: 13px;"><%# Eval("OfferTitle") %></div>
                                <div style="font-size: 12.5px; color: #15803d; font-weight: 600; margin-top: 2px;"><%# FormatStipend(Eval("Stipend")) %></div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Joining Date" ItemStyle-Width="14%">
                        <ItemTemplate>
                            <span style="font-size: 13px; color: #334155; font-weight: 600; white-space: nowrap;"><%# Eval("JoiningDate") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issued Date" ItemStyle-Width="12%">
                        <ItemTemplate>
                            <span style="font-size: 12.5px; color: #64748b; font-weight: 500; white-space: nowrap;"><%# FormatDate(Eval("IssuedDate")) %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="10%">
                        <ItemTemplate>
                            <div style="white-space: nowrap;">
                                <%# GetOfferStatusBadge(Eval("Status")) %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end" ItemStyle-Width="13%">
                        <ItemTemplate>
                            <div style="display: flex; align-items: center; justify-content: flex-end; gap: 6px; flex-wrap: nowrap; min-width: 180px;">
                                <button type="button" class="btn-table-action btn-action-view"
                                        onclick='openLetterModal("<%# Eval("FullName") %>", "<%# Eval("College") %>", "<%# Eval("OfferTitle") %>", "<%# Eval("Stipend") %>", "<%# Eval("JoiningDate") %>", "<%# Eval("Duration") %>", "<%# Eval("Location") %>", "<%# Eval("OfferId") %>", "<%# FormatDate(Eval("IssuedDate")) %>");'
                                        title="View / Print Official Offer Letter">
                                    <i class="fa-solid fa-print"></i> View &amp; Print
                                </button>
                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("OfferId") %>' CssClass="btn-table-action btn-action-edit" title="Edit Offer">
                                    <i class="fa-solid fa-pen"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("OfferId") %>' OnClientClick="return confirm('Are you sure you want to delete this offer letter?');" CssClass="btn-table-action btn-action-delete" title="Delete Offer">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoOffers" runat="server" Visible="false">
                <div style="text-align: center; padding: 50px 20px; color: #64748b;">
                    <i class="fa-solid fa-file-circle-xmark" style="font-size: 46px; color: #cbd5e1; margin-bottom: 14px; display: block;"></i>
                    <h4 style="font-size: 17px; font-weight: 700; color: #1e293b; margin-bottom: 6px;">No Offer Letters Issued Yet</h4>
                    <p style="font-size: 13.5px; margin: 0 0 16px 0;">Click the button below to issue an official offer letter to a selected student.</p>
                    <button type="button" class="btn-open-drawer" onclick="openDrawer();">
                        <i class="fa-solid fa-file-circle-plus"></i> Generate New Offer Letter
                    </button>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
    <!-- ================= CENTER MODAL DIALOG FOR OFFER LETTER GENERATION & LIVE PREVIEW ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>
    <div class="drawer-panel" id="drawerPanel">
        <div class="drawer-header">
            <h2><i class="fa-solid fa-file-signature" style="color: #2563eb;"></i> Generate Internship Offer Letter</h2>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();" title="Close">&times;</button>
        </div>
        <div class="drawer-body">
            <!-- Two-Column Offer Letter Builder & Live Letterhead Preview -->
            <div class="offer-builder-grid">
                <!-- Left: Quick Details Fill Form -->
                <div class="builder-form-card">
                    <h2><i class="fa-solid fa-file-pen" style="color: #2563eb;"></i> Offer Details Form</h2>
                    <div class="form-item">
                        <label><i class="fa-solid fa-user-check" style="color:#2563eb; margin-right:4px;"></i> Select Selected Candidate <span style="color:#ef4444;">*</span></label>
                        <asp:DropDownList ID="ddlCandidate" runat="server" CssClass="form-input-ctrl" AutoPostBack="true" OnSelectedIndexChanged="ddlCandidate_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Candidate Full Name</label>
                            <asp:TextBox ID="txtCandidateName" runat="server" placeholder="Candidate Name" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Candidate College / Inst.</label>
                            <asp:TextBox ID="txtCandidateCollege" runat="server" placeholder="College / Institute" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Offer Issue Date</label>
                            <asp:TextBox ID="txtOfferDate" runat="server" TextMode="Date" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Offer Designation / Role <span style="color:#ef4444;">*</span></label>
                            <asp:TextBox ID="txtOfferTitle" runat="server" placeholder="e.g. Frontend Developer Intern" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Monthly Stipend (&#8377;)</label>
                            <asp:TextBox ID="txtStipend" runat="server" placeholder="e.g. 15,000 / month" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Internship Duration</label>
                            <asp:TextBox ID="txtDuration" runat="server" placeholder="e.g. 3 Months" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Joining Date <span style="color:#ef4444;">*</span></label>
                            <asp:TextBox ID="txtJoiningDate" runat="server" TextMode="Date" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Acceptance Deadline</label>
                            <asp:TextBox ID="txtValidTill" runat="server" TextMode="Date" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-item">
                        <label>Work Location / Office Address</label>
                        <asp:TextBox ID="txtWorkLocation" runat="server" placeholder="e.g. Ahmedabad, Gujarat" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                    </div>
                </div>
                <!-- Right: Live Letterhead Preview (Auto-Updates in Real-Time) -->
                <div class="preview-wrapper">
                    <div class="preview-header-bar">
                        <div style="font-weight: 700; color: #0f172a; font-size: 14px;">
                            <i class="fa-solid fa-eye" style="color: #2563eb; margin-right: 6px;"></i> Live Letterhead Preview
                        </div>
                        <div class="live-badge">
                            <span class="live-dot"></span> Live Real-Time
                        </div>
                    </div>
                    <div class="letterhead-scroll-box">
                        <!-- Live Letterhead Box -->
                        <div class="letterhead-doc">
                            <!-- Header -->
                            <div class="lh-header">
                                <div class="lh-brand-info">
                                    <% if (!string.IsNullOrEmpty(CompLogo)) { %>
                                        <img src="<%= CompLogo %>" alt="Logo" style="height: 32px; max-width: 120px; object-fit: contain; margin-bottom: 4px; display: block;" />
                                    <% } %>
                                    <h2 class="lh-brand-name"><%= CompName %></h2>
                                    <p class="lh-brand-sub">Internship & Talent Acquisition Division</p>
                                </div>
                                <div class="lh-company-meta">
                                    <div><%= CompLocation %></div>
                                    <div><%= CompEmail %></div>
                                    <div><%= CompPhone %></div>
                                    <% if (!string.IsNullOrEmpty(CompWebsite)) { %><div><%= CompWebsite %></div><% } %>
                                </div>
                            </div>
                            <!-- Date & Ref -->
                            <div class="lh-date-ref">
                                <span>REF: <%= DateTime.Now.Year %>/OFFER/<span id="prevRefCode">001</span></span>
                                <span>Date: <span id="prevOfferDate"><%= FormattedOfferDate %></span></span>
                            </div>
                            <!-- Candidate To Box -->
                            <div class="lh-recipient-box">
                                <p style="font-weight: 700; color: #0f172a;">To,</p>
                                <p style="font-weight: 700; color: #2563eb; font-size: 13.5px;" id="prevCandidateName"><%= SelectedCandName %></p>
                                <p id="prevCandidateCollege"><%= SelectedCandCollege %></p>
                            </div>
                            <!-- Subject -->
                            <div class="lh-subject">
                                Subject: Formal Internship Offer Letter - <span id="prevSubjectRole" style="color: #2563eb;"><%= SelectedRole %></span>
                            </div>
                            <!-- Letter Body -->
                            <p style="margin-bottom: 10px;">
                                Dear <strong id="prevSalutationName"><%= SelectedCandName %></strong>,
                            </p>
                            <p style="margin-bottom: 10px;">
                                On behalf of <strong><%= CompName %></strong>, we are pleased to offer you an internship position as <strong id="prevBodyRole" style="color: #2563eb;"><%= SelectedRole %></strong>. We were very impressed by your qualifications and performance during the selection process.
                            </p>
                            <!-- Offer Terms Matrix Table -->
                            <table class="lh-terms-table">
                                <tr>
                                    <th>Position / Role</th>
                                    <td id="prevTableRole"><%= SelectedRole %></td>
                                </tr>
                                <tr>
                                    <th>Internship Duration</th>
                                    <td id="prevTableDuration"><%= SelectedDuration %></td>
                                </tr>
                                <tr>
                                    <th>Monthly Stipend</th>
                                    <td id="prevTableStipend" style="color: #15803d;"><%= SelectedStipend %></td>
                                </tr>
                                <tr>
                                    <th>Expected Joining Date</th>
                                    <td id="prevTableJoiningDate"><%= SelectedJoining %></td>
                                </tr>
                                <tr>
                                    <th>Work Location / Mode</th>
                                    <td id="prevTableLocation"><%= SelectedLocation %></td>
                                </tr>
                                <tr>
                                    <th>Offer Acceptance Deadline</th>
                                    <td id="prevTableValidTill"><%= SelectedValidTill %></td>
                                </tr>
                            </table>
                            <p style="margin-bottom: 14px; font-size: 12px; color: #475569;">
                                Please confirm your acceptance of this offer by signing and returning a copy of this letter or confirming directly on the portal before the acceptance deadline.
                            </p>
                            <!-- Signatory Section -->
                            <div class="lh-sign-section">
                                <div>
                                    <div style="font-weight: 700; color: #0f172a;"><%= CompHr %></div>
                                    <div style="font-size: 11.5px; color: #64748b;">Authorized Signatory &bull; <%= CompName %></div>
                                </div>
                                <div class="lh-seal-badge">
                                    <i class="fa-solid fa-certificate"></i> Official Verified Offer
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="drawer-footer">
            <button type="button" class="btn-drawer-cancel" onclick="closeDrawer();">Cancel</button>
            <asp:Button ID="btnReset" runat="server" Text="Reset Form" CssClass="btn-reset-form" OnClick="btnResetForm_Click" CausesValidation="false" />
            <asp:LinkButton ID="btnIssueOffer" runat="server" CssClass="btn-send-offer" OnClick="btnIssueOffer_Click">
                <i class="fa-solid fa-paper-plane"></i> Send Offer Letter to Student
            </asp:LinkButton>
        </div>
    </div>
    <!-- ================= FULLSCREEN PRINT / VIEW MODAL (100% IDENTICAL TO PREVIEW) ================= -->
    <div class="print-modal-overlay" id="printModal" onclick="closePrintModal(event);">
        <div class="print-modal-container" onclick="event.stopPropagation();">
            <div class="print-modal-bar">
                <div style="font-weight:700; color:#0f172a; font-size:15px;">
                    <i class="fa-solid fa-file-signature" style="color:#2563eb;"></i> Official Company Offer Letter
                </div>
                <div style="display:flex; gap:10px; align-items:center;">
                    <button type="button" class="btn-print-btn" onclick="window.print();">
                        <i class="fa-solid fa-print"></i> Print / Save PDF
                    </button>
                    <button type="button" class="btn-close-modal" onclick="closePrintModal();">&times;</button>
                </div>
            </div>
            <div style="padding: 24px;">
                <div class="letterhead-doc" id="printableLetterhead" style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:32px 36px;">
                    <!-- Company Header -->
                    <div class="lh-company-header">
                        <div>
                            <% if (!string.IsNullOrEmpty(CompLogo)) { %>
                                <img src="<%= CompLogo %>" alt="Logo" style="height: 38px; max-width: 140px; object-fit: contain; margin-bottom: 6px; display: block;" />
                            <% } %>
                            <h2 class="lh-brand-name"><%= CompName %></h2>
                            <p class="lh-brand-sub">Internship & Talent Acquisition Division</p>
                        </div>
                        <div class="lh-company-meta">
                            <div><%= CompLocation %></div>
                            <div><%= CompEmail %></div>
                            <div><%= CompPhone %></div>
                            <% if (!string.IsNullOrEmpty(CompWebsite)) { %><div><%= CompWebsite %></div><% } %>
                        </div>
                    </div>
                    <!-- Date & Ref -->
                    <div class="lh-date-ref">
                        <span>REF: <%= DateTime.Now.Year %>/OFFER/<span id="modalRef">001</span></span>
                        <span>Date: <span id="modalOfferDate"><%= DateTime.Now.ToString("dd MMMM yyyy") %></span></span>
                    </div>
                    <!-- Candidate To Box -->
                    <div class="lh-recipient-box">
                        <p style="font-weight: 700; color: #0f172a;">To,</p>
                        <p style="font-weight: 700; color: #2563eb; font-size: 13.5px;" id="modalCandName">[Candidate Full Name]</p>
                        <p id="modalCandCollege">[College / University Name]</p>
                    </div>
                    <!-- Subject -->
                    <div class="lh-subject">
                        Subject: Formal Internship Offer Letter - <span id="modalSubjectRole" style="color: #2563eb;">[Internship Role]</span>
                    </div>
                    <!-- Letter Body -->
                    <p style="margin-bottom: 10px;">
                        Dear <strong id="modalSalutation">[Candidate Name]</strong>,
                    </p>
                    <p style="margin-bottom: 10px;">
                        On behalf of <strong><%= CompName %></strong>, we are pleased to offer you an internship position as <strong id="modalBodyRole" style="color: #2563eb;">[Internship Role]</strong>. We were very impressed by your qualifications and performance during the selection process.
                    </p>
                    <!-- Offer Terms Matrix Table (All 6 Rows) -->
                    <table class="lh-terms-table">
                        <tr>
                            <th>Position / Role</th>
                            <td id="modalTableRole">[Internship Role]</td>
                        </tr>
                        <tr>
                            <th>Internship Duration</th>
                            <td id="modalTableDuration">3 Months</td>
                        </tr>
                        <tr>
                            <th>Monthly Stipend</th>
                            <td id="modalTableStipend" style="color: #15803d;">&#8377; 15,000 / month</td>
                        </tr>
                        <tr>
                            <th>Expected Joining Date</th>
                            <td id="modalTableJoiningDate"><%= DateTime.Now.AddDays(7).ToString("dd MMM yyyy") %></td>
                        </tr>
                        <tr>
                            <th>Work Location / Mode</th>
                            <td id="modalTableLocation"><%= CompLocation %></td>
                        </tr>
                        <tr>
                            <th>Offer Acceptance Deadline</th>
                            <td id="modalTableValidTill"><%= DateTime.Now.AddDays(14).ToString("dd MMM yyyy") %></td>
                        </tr>
                    </table>
                    <p style="margin-bottom: 14px; font-size: 12px; color: #475569;">
                        Please confirm your acceptance of this offer by signing and returning a copy of this letter or confirming directly on the portal before the acceptance deadline.
                    </p>
                    <!-- Signatory Section -->
                    <div class="lh-sign-section">
                        <div>
                            <div style="font-weight: 700; color: #0f172a;"><%= CompHr %></div>
                            <div style="font-size: 11.5px; color: #64748b;">Authorized Signatory &bull; <%= CompName %></div>
                        </div>
                        <div class="lh-seal-badge">
                            <i class="fa-solid fa-certificate"></i> Official Verified Offer
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Live Sync & Drawer Scripts -->
    <script>
        function openDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var panel = document.getElementById('drawerPanel');
            if (overlay && panel) {
                overlay.style.display = 'block';
                setTimeout(function () {
                    panel.classList.add('open');
                }, 10);
            }
            updateTemplatePreview();
        }
        function closeDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var panel = document.getElementById('drawerPanel');
            if (overlay && panel) {
                panel.classList.remove('open');
                setTimeout(function () {
                    overlay.style.display = 'none';
                }, 300);
            }
        }
        function updateTemplatePreview() {
            var candNameInput = document.getElementById('<%= txtCandidateName.ClientID %>');
            var candName = candNameInput ? (candNameInput.value || '[Candidate Full Name]') : '[Candidate Full Name]';
            var candCollegeInput = document.getElementById('<%= txtCandidateCollege.ClientID %>');
            var candCollege = candCollegeInput ? (candCollegeInput.value || 'College / University Name') : 'College / University Name';
            var offerDateInput = document.getElementById('<%= txtOfferDate.ClientID %>');
            var offerDate = offerDateInput ? offerDateInput.value : '';
            var titleInput = document.getElementById('<%= txtOfferTitle.ClientID %>');
            var title = titleInput ? (titleInput.value || '[Internship Role]') : '[Internship Role]';
            var stipendInput = document.getElementById('<%= txtStipend.ClientID %>');
            var rawStipend = stipendInput ? (stipendInput.value || '15,000 / month') : '15,000 / month';
            rawStipend = rawStipend.replace(/â,¹|â‚¹|\?|₹|Rs\.|INR/g, '').trim();
            var stipendHtml = 'Unpaid';
            if (rawStipend) {
                if (!rawStipend.toLowerCase().includes('month') && !rawStipend.toLowerCase().includes('unpaid') && !rawStipend.toLowerCase().includes('fixed')) {
                    rawStipend = rawStipend + ' / month';
                }
                stipendHtml = '<i class="fa-solid fa-indian-rupee-sign" style="font-size:12px; margin-right:3px;"></i> ' + rawStipend;
            }
            var durationInput = document.getElementById('<%= txtDuration.ClientID %>');
            var duration = durationInput ? (durationInput.value || '3 Months') : '3 Months';
            var joiningInput = document.getElementById('<%= txtJoiningDate.ClientID %>');
            var joining = joiningInput ? (joiningInput.value || '<%= DateTime.Now.AddDays(7).ToString("dd MMM yyyy") %>') : '<%= DateTime.Now.AddDays(7).ToString("dd MMM yyyy") %>';
            var locationInput = document.getElementById('<%= txtWorkLocation.ClientID %>');
            var location = locationInput ? (locationInput.value || '<%= CompLocation %>') : '<%= CompLocation %>';
            var validTillInput = document.getElementById('<%= txtValidTill.ClientID %>');
            var validTill = validTillInput ? (validTillInput.value || '<%= DateTime.Now.AddDays(14).ToString("dd MMM yyyy") %>') : '<%= DateTime.Now.AddDays(14).ToString("dd MMM yyyy") %>';
            // Update candidate info
            var prevCand = document.getElementById('prevCandidateName');
            if (prevCand) prevCand.innerText = candName;
            var prevSal = document.getElementById('prevSalutationName');
            if (prevSal) prevSal.innerText = candName;
            var prevColl = document.getElementById('prevCandidateCollege');
            if (prevColl) prevColl.innerText = candCollege;
            // Update offer date
            var prevDate = document.getElementById('prevOfferDate');
            if (prevDate) {
                if (offerDate) {
                    var d = new Date(offerDate);
                    if (!isNaN(d.getTime())) {
                        var options = { day: '2-digit', month: 'long', year: 'numeric' };
                        prevDate.innerText = d.toLocaleDateString('en-GB', options);
                    } else {
                        prevDate.innerText = offerDate;
                    }
                }
            }
            // Update role & details
            var prevSubRole = document.getElementById('prevSubjectRole');
            if (prevSubRole) prevSubRole.innerText = title;
            var prevBodyRole = document.getElementById('prevBodyRole');
            if (prevBodyRole) prevBodyRole.innerText = title;
            var prevTableRole = document.getElementById('prevTableRole');
            if (prevTableRole) prevTableRole.innerText = title;
            var prevTableStipend = document.getElementById('prevTableStipend');
            if (prevTableStipend) prevTableStipend.innerHTML = stipendHtml;
            var prevTableDur = document.getElementById('prevTableDuration');
            if (prevTableDur) prevTableDur.innerText = duration;
            var prevTableJoin = document.getElementById('prevTableJoiningDate');
            if (prevTableJoin) {
                if (joining && joining.indexOf('-') > -1) {
                    var jd = new Date(joining);
                    if (!isNaN(jd.getTime())) {
                        prevTableJoin.innerText = jd.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
                    } else {
                        prevTableJoin.innerText = joining;
                    }
                } else {
                    prevTableJoin.innerText = joining;
                }
            }
            var prevTableLoc = document.getElementById('prevTableLocation');
            if (prevTableLoc) prevTableLoc.innerText = location;
            var prevTableValid = document.getElementById('prevTableValidTill');
            if (prevTableValid) {
                if (validTill && validTill.indexOf('-') > -1) {
                    var vd = new Date(validTill);
                    if (!isNaN(vd.getTime())) {
                        prevTableValid.innerText = vd.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
                    } else {
                        prevTableValid.innerText = validTill;
                    }
                } else {
                    prevTableValid.innerText = validTill;
                }
            }
        }
        function openLetterModal(name, college, role, stipend, joining, duration, location, id, issuedDate) {
            document.getElementById('modalRef').innerText = id || '001';
            document.getElementById('modalCandName').innerText = name || '[Candidate Full Name]';
            document.getElementById('modalCandCollege').innerText = college || 'College / University Name';
            document.getElementById('modalSubjectRole').innerText = role || '[Internship Role]';
            document.getElementById('modalSalutation').innerText = name || 'Candidate';
            document.getElementById('modalBodyRole').innerText = role || '[Internship Role]';
            document.getElementById('modalTableRole').innerText = role || '[Internship Role]';
            document.getElementById('modalTableDuration').innerText = duration || '3 Months';
            var cleanStipend = (stipend || '').replace(/â,¹|â‚¹|\?|₹|Rs\.|INR/g, '').trim();
            var modalStipendHtml = 'Unpaid';
            if (cleanStipend) {
                if (!cleanStipend.toLowerCase().includes('month') && !cleanStipend.toLowerCase().includes('unpaid') && !cleanStipend.toLowerCase().includes('fixed')) {
                    cleanStipend = cleanStipend + ' / month';
                }
                modalStipendHtml = '<i class="fa-solid fa-indian-rupee-sign" style="font-size:12px; margin-right:3px;"></i> ' + cleanStipend;
            }
            document.getElementById('modalTableStipend').innerHTML = modalStipendHtml;
            document.getElementById('modalTableJoiningDate').innerText = joining || '';
            document.getElementById('modalTableLocation').innerText = location || '<%= CompLocation %>';
            if (joining) {
                var jd = new Date(joining);
                if (!isNaN(jd.getTime())) {
                    var dl = new Date(jd.getTime() - (3 * 24 * 60 * 60 * 1000));
                    document.getElementById('modalTableValidTill').innerText = dl.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
                } else {
                    document.getElementById('modalTableValidTill').innerText = joining;
                }
            } else {
                document.getElementById('modalTableValidTill').innerText = '<%= DateTime.Now.AddDays(14).ToString("dd MMM yyyy") %>';
            }
            if (issuedDate) {
                document.getElementById('modalOfferDate').innerText = issuedDate;
            }
            document.getElementById('printModal').style.display = 'flex';
        }
        function closePrintModal(e) {
            document.getElementById('printModal').style.display = 'none';
        }
        // Initialize on load
        window.addEventListener('DOMContentLoaded', function() {
            updateTemplatePreview();
        });
    </script>
</asp:Content>

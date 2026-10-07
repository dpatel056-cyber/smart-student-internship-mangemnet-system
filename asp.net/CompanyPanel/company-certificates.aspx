<%@ Page Title="Internship Certificates" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-certificates.aspx.cs" Inherits="asp.net.company_certificates" %>
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
        .cert-builder-grid {
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
            .cert-builder-grid {
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
        .btn-issue-cert {
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
            text-decoration: none;
        }
        .btn-issue-cert:hover {
            background: #1d4ed8;
            color: #ffffff;
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
        /* Official Certificate Preview Styling - Independently Scrollable */
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
        .cert-scroll-box {
            flex: 1;
            overflow-y: auto;
            min-height: 0;
            padding-right: 4px;
        }
        .cert-scroll-box::-webkit-scrollbar,
        .builder-form-card::-webkit-scrollbar {
            width: 6px;
        }
        .cert-scroll-box::-webkit-scrollbar-track,
        .builder-form-card::-webkit-scrollbar-track {
            background: #f8fafc;
            border-radius: 10px;
        }
        .cert-scroll-box::-webkit-scrollbar-thumb,
        .builder-form-card::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 10px;
        }
        .cert-scroll-box::-webkit-scrollbar-thumb:hover,
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
        /* Certificate Canvas Document */
        .cert-canvas-doc {
            background: #ffffff;
            border: 8px solid #1e3a8a;
            border-image: linear-gradient(135deg, #1e3a8a, #d97706, #1e3a8a) 8;
            padding: 28px 32px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.05);
            position: relative;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
            text-align: center;
            box-sizing: border-box;
            background-image: radial-gradient(#f8fafc 15%, transparent 16%);
            background-size: 20px 20px;
        }
        .cert-inner-border {
            border: 2px dashed #d97706;
            padding: 20px 24px;
            position: relative;
            background: rgba(255, 255, 255, 0.96);
        }
        .cert-top-brand {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 12px;
            margin-bottom: 14px;
        }
        .cert-brand-left {
            text-align: left;
        }
        .cert-brand-left h3 {
            font-size: 16px;
            font-weight: 800;
            color: #0f172a;
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }
        .cert-brand-left p {
            font-size: 11px;
            color: #64748b;
            margin: 2px 0 0 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .cert-brand-meta {
            text-align: right;
            font-size: 11px;
            color: #64748b;
            line-height: 1.4;
        }
        .cert-header-tag {
            font-size: 11.5px;
            font-weight: 700;
            color: #d97706;
            letter-spacing: 2.5px;
            text-transform: uppercase;
            margin-bottom: 5px;
        }
        .cert-main-title {
            font-size: 21px;
            font-weight: 900;
            color: #1e3a8a;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin: 0 0 10px 0;
        }
        .cert-present-text {
            font-size: 12px;
            color: #64748b;
            font-style: italic;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 6px;
        }
        .cert-candidate-name {
            font-size: 23px;
            font-weight: 800;
            color: #0f172a;
            font-family: 'Georgia', serif;
            margin: 4px 0 2px 0;
            padding-bottom: 4px;
            display: inline-block;
            border-bottom: 2px solid #d97706;
            min-width: 220px;
        }
        .cert-college-name {
            font-size: 12.5px;
            color: #475569;
            margin-bottom: 12px;
        }
        .cert-body-desc {
            font-size: 12.5px;
            line-height: 1.65;
            color: #334155;
            max-width: 620px;
            margin: 0 auto 16px auto;
        }
        .cert-body-desc strong {
            color: #0f172a;
        }
        /* Certificate Footer */
        .cert-footer-grid {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 18px;
            padding-top: 12px;
            border-top: 1px solid #f1f5f9;
        }
        .cert-meta-col {
            text-align: left;
            font-size: 11px;
            color: #64748b;
            line-height: 1.5;
        }
        .cert-seal-col {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .cert-seal-badge {
            width: 62px;
            height: 62px;
            border-radius: 50%;
            background: radial-gradient(circle, #fef3c7, #fde68a);
            border: 3px double #d97706;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #b45309;
            box-shadow: 0 4px 10px rgba(217, 119, 6, 0.2);
            font-size: 8.5px;
            font-weight: 800;
            text-transform: uppercase;
            text-align: center;
            line-height: 1.1;
        }
        .cert-seal-badge i {
            font-size: 16px;
            margin-bottom: 2px;
        }
        .cert-sign-col {
            text-align: right;
        }
        .cert-sign-name {
            font-weight: 700;
            color: #0f172a;
            font-size: 12.5px;
            border-top: 1px solid #94a3b8;
            padding-top: 4px;
            display: inline-block;
            min-width: 130px;
        }
        .cert-sign-title {
            font-size: 10.5px;
            color: #64748b;
        }
        /* Table Card */
        /* Table Card & Responsive GridView */
        .co-panel {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 14px rgba(15,23,42,0.03);
        }
        .co-panel-header {
            padding: 16px 22px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .co-panel-header h3 {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
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
            min-width: 1100px;
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
        .btn-table-action {
            padding: 7px 12px;
            border-radius: 8px;
            font-size: 12.5px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            cursor: pointer;
            border: 1px solid transparent;
            transition: all 0.15s ease;
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
            background: #0f172a;
            color: #ffffff;
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
            background: rgba(15, 23, 42, 0.65);
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
            max-width: 850px;
            max-height: 92vh;
            border-radius: 16px;
            overflow-y: auto;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
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
            #printableCertDoc, #printableCertDoc * {
                visibility: visible;
            }
            #printableCertDoc {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                box-shadow: none !important;
                border-width: 8px !important;
                padding: 20px !important;
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
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Internship Certificates</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Automated company-branded completion certificate generator and candidate issuance.</p>
        </div>
        <button type="button" class="btn-open-drawer" onclick="openDrawer();">
            <i class="fa-solid fa-award"></i> Generate New Certificate
        </button>
    </div>
    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    <!-- Stats Summary Cards -->
    <div class="task-stats-grid">
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#eff6ff; color:#2563eb; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-award"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblTotalCerts" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Total Certificates Issued</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#f0fdf4; color:#16a34a; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-user-check"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblEligibleInterns" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Eligible / Completed Interns</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#faf5ff; color:#9333ea; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-user-graduate"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblCertifiedInterns" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Certified Students</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#fef9c3; color:#ca8a04; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-clock-rotate-left"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblPendingCertificates" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Pending Issuance</div>
            </div>
        </div>
    </div>
    <!-- ================= ISSUED CERTIFICATES GRIDVIEW ================= -->
    <div class="co-panel" style="margin-bottom: 30px; width: 100%;">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-award" style="color: #d97706; margin-right: 8px;"></i> Issued Internship Certificates</h3>
        </div>
        <div class="co-table-responsive">
            <asp:GridView ID="gvCerts" runat="server" AutoGenerateColumns="False" OnRowCommand="gvCerts_RowCommand" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true">
                <Columns>
                    <asp:TemplateField HeaderText="Photo" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" ItemStyle-Width="60px">
                        <ItemTemplate>
                            <%# GetProfileAvatarHtml(Eval("ProfilePhoto"), Eval("FullName")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" ItemStyle-Width="15%">
                        <ItemTemplate>
                            <div style="min-width: 140px;">
                                <asp:Label ID="lblFullName" runat="server" Style="font-weight: 700; color: #0f172a; font-size: 13.5px;" Text='<%# Eval("FullName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" ItemStyle-Width="16%">
                        <ItemTemplate>
                            <div style="min-width: 160px;">
                                <asp:Label ID="lblStudentEmail" runat="server" Style="font-size: 12.5px; color: #64748b;" Text='<%# Eval("StudentEmail") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Certificate Title" ItemStyle-Width="18%">
                        <ItemTemplate>
                            <div style="min-width: 170px;">
                                <asp:Label ID="lblCertTitle" runat="server" Style="font-weight: 600; color: #1e293b; font-size: 13px;" Text='<%# Eval("CertificateTitle") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Role" ItemStyle-Width="15%">
                        <ItemTemplate>
                            <div style="min-width: 150px;">
                                <asp:Label ID="lblRole" runat="server" Style="font-size: 12.5px; color: #2563eb; font-weight: 600;" Text='<%# Eval("InternshipRole") != null && !string.IsNullOrEmpty(Eval("InternshipRole").ToString()) ? Eval("InternshipRole") : Eval("InternshipTitle") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ID / Code" ItemStyle-Width="13%">
                        <ItemTemplate>
                            <div style="min-width: 130px; white-space: nowrap;">
                                <asp:Label ID="lblCertNo" runat="server" Style="font-weight: 700; font-size: 12.5px; color: #0f172a; display: block;" Text='<%# Eval("CertificateNo") %>'></asp:Label>
                                <div style="font-size: 11.5px; color: #64748b;">Code: <asp:Label ID="lblVerificationCode" runat="server" Style="font-family: monospace; font-weight: 600;" Text='<%# Eval("VerificationCode") %>'></asp:Label></div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Date" ItemStyle-Width="9%">
                        <ItemTemplate>
                            <asp:Label ID="lblIssueDate" runat="server" Style="font-size: 12.5px; color: #475569; font-weight: 500; white-space: nowrap;" Text='<%# FormatDate(Eval("IssueDate")) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="8%">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# GetCertStatusBadge(Eval("Status")) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end" ItemStyle-Width="12%">
                        <ItemTemplate>
                            <div style="display: flex; align-items: center; justify-content: flex-end; gap: 6px; flex-wrap: nowrap; min-width: 175px;">
                                <button type="button" class="btn-table-action btn-action-view"
                                        onclick='openCertModal("<%# Eval("FullName") %>", "<%# Eval("College") %>", "<%# Eval("CertificateTitle") %>", "<%# Eval("InternshipRole") != null && !string.IsNullOrEmpty(Eval("InternshipRole").ToString()) ? Eval("InternshipRole") : Eval("InternshipTitle") %>", "<%# Eval("Duration") %>", "<%# FormatDate(Eval("IssueDate")) %>", "<%# Eval("Performance") %>", "<%# Eval("SignatoryName") %>", "<%# Eval("CertificateNo") %>", "<%# Eval("VerificationCode") %>");'
                                        title="View / Print Official Certificate">
                                    <i class="fa-solid fa-print"></i> View &amp; Print
                                </button>
                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("CertificateId") %>' CssClass="btn-table-action btn-action-edit" title="Edit Certificate">
                                    <i class="fa-solid fa-pen"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("CertificateId") %>' OnClientClick="return confirm('Are you sure you want to delete this certificate?');" CssClass="btn-table-action btn-action-delete" title="Delete Certificate">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoCerts" runat="server" Visible="false">
                <div style="text-align: center; padding: 50px 20px; color: #64748b;">
                    <i class="fa-solid fa-certificate" style="font-size: 42px; color: #cbd5e1; margin-bottom: 12px; display: block;"></i>
                    <h4 style="font-size: 16px; font-weight: 600; color: #1e293b; margin-bottom: 4px;">No Certificates Issued Yet</h4>
                    <p style="font-size: 13px; margin: 0;">Click on <strong>Generate New Certificate</strong> above to issue a verified completion certificate for a student.</p>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
    <!-- ================= MODAL DRAWER: CERTIFICATE GENERATOR & LIVE PREVIEW ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>
    <div class="drawer-panel" id="drawerPanel">
        <div class="drawer-header">
            <h2><i class="fa-solid fa-award" style="color: #d97706;"></i> Generate Internship Certificate</h2>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();">&times;</button>
        </div>
        <div class="drawer-body">
            <div class="cert-builder-grid">
                <!-- Left: Quick Details Fill Form -->
                <div class="builder-form-card">
                    <h2><i class="fa-solid fa-file-pen" style="color: #2563eb;"></i> Certificate Details Form</h2>
                    <div class="form-item">
                        <label><i class="fa-solid fa-user-check" style="color:#2563eb; margin-right:4px;"></i> Select Candidate with Completed Tasks / Quizzes <span style="color:#ef4444;">*</span></label>
                        <asp:DropDownList ID="ddlCandidate" runat="server" CssClass="form-input-ctrl" AutoPostBack="true" OnSelectedIndexChanged="ddlCandidate_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Candidate Full Name</label>
                            <asp:TextBox ID="txtCandidateName" runat="server" placeholder="Candidate Name" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Candidate College / Inst.</label>
                            <asp:TextBox ID="txtCandidateCollege" runat="server" placeholder="College / Institute" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-item">
                        <label>Certificate Title <span style="color:#ef4444;">*</span></label>
                        <asp:TextBox ID="txtCertTitle" runat="server" placeholder="e.g. Certificate of Internship Excellence" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Internship Role / Position <span style="color:#ef4444;">*</span></label>
                            <asp:TextBox ID="txtInternshipRole" runat="server" placeholder="e.g. Full Stack Developer" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Duration / Period</label>
                            <asp:TextBox ID="txtDuration" runat="server" placeholder="e.g. 3 Months" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Issue Date <span style="color:#ef4444;">*</span></label>
                            <asp:TextBox ID="txtIssueDate" runat="server" TextMode="Date" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Performance / Remarks</label>
                            <asp:TextBox ID="txtPerformance" runat="server" placeholder="e.g. Outstanding Performance & Dedication" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-item">
                        <label>Authorized Signatory Name</label>
                        <asp:TextBox ID="txtSignatoryName" runat="server" placeholder="e.g. HR / Founder Name" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                    </div>
                </div>
                <!-- Right: Live Branded Certificate Preview (Auto-Updates in Real-Time) -->
                <div class="preview-wrapper">
                    <div class="preview-header-bar">
                        <div style="display:flex; align-items:center; gap:8px;">
                            <span style="font-weight:700; color:#0f172a; font-size:14px;"><i class="fa-solid fa-eye" style="color:#2563eb;"></i> Live Certificate Template Preview</span>
                        </div>
                        <div class="live-badge">
                            <span class="live-dot"></span> Live Real-Time
                        </div>
                    </div>
                    <div class="cert-scroll-box">
                        <div class="cert-canvas-doc" id="certPreview">
                            <div class="cert-inner-border">
                                <!-- Top Brand -->
                                <div class="cert-top-brand">
                                    <div class="cert-brand-left">
                                        <% if (!string.IsNullOrEmpty(CompLogo)) { %>
                                            <img src="<%= CompLogo %>" alt="Logo" style="height: 34px; max-width: 130px; object-fit: contain; margin-bottom: 4px; display: block;" />
                                        <% } %>
                                        <h3><%= CompName %></h3>
                                        <p>Internship &amp; Talent Acquisition Division</p>
                                    </div>
                                    <div class="cert-brand-meta">
                                        <div><%= CompLocation %></div>
                                        <div><%= CompEmail %></div>
                                    </div>
                                </div>
                                <!-- Certificate Title & Header -->
                                <div class="cert-header-tag"><i class="fa-solid fa-award"></i> Verified Completion</div>
                                <h2 class="cert-main-title" id="prevCertTitle"><%= SelectedCertTitle %></h2>
                                <div class="cert-present-text">This is proudly presented to</div>
                                <!-- Candidate Name -->
                                <div class="cert-candidate-name" id="prevCandName"><%= SelectedCandName %></div>
                                <div class="cert-college-name" id="prevCandCollege"><%= SelectedCandCollege %></div>
                                <!-- Certificate Body -->
                                <p class="cert-body-desc">
                                    For successfully completing the professional internship program as <strong id="prevCertRole" style="color:#1e3a8a;"><%= SelectedRole %></strong> at <strong><%= CompName %></strong> for a duration of <strong id="prevCertDuration"><%= SelectedDuration %></strong>. During this tenure, the candidate demonstrated exemplary professionalism, technical capability, and <strong id="prevCertPerformance" style="color:#d97706;"><%= SelectedPerformance %></strong>.
                                </p>
                                <!-- Footer -->
                                <div class="cert-footer-grid">
                                    <div class="cert-meta-col">
                                        <div><strong>Issue Date:</strong> <span id="prevCertDate"><%= FormattedIssueDate %></span></div>
                                        <div><strong>Certificate No:</strong> <span id="prevCertNo"><%= PreviewCertNo %></span></div>
                                        <div><strong>Verification:</strong> <span id="prevVerifyCode"><%= PreviewVerifyCode %></span></div>
                                    </div>
                                    <div class="cert-seal-col">
                                        <div class="cert-seal-badge">
                                            <i class="fa-solid fa-medal"></i>
                                            <span>Official<br />Verified</span>
                                        </div>
                                    </div>
                                    <div class="cert-sign-col">
                                        <div class="cert-sign-name" id="prevSignatoryName"><%= SelectedSignatory %></div>
                                        <div class="cert-sign-title">Authorized Signatory &bull; <%= CompName %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="drawer-footer">
            <button type="button" class="btn-drawer-cancel" onclick="closeDrawer();">Cancel</button>
            <asp:Button ID="btnResetForm" runat="server" Text="Reset Form" CssClass="btn-reset-form" OnClick="btnResetForm_Click" CausesValidation="false" />
            <asp:LinkButton ID="btnIssueCert" runat="server" CssClass="btn-issue-cert" OnClick="btnIssueCert_Click">
                <i class="fa-solid fa-award"></i> Issue Certificate to Student
            </asp:LinkButton>
        </div>
    </div>
    <!-- ================= FULLSCREEN PRINT / VIEW MODAL (100% IDENTICAL TO PREVIEW) ================= -->
    <div class="print-modal-overlay" id="printModal" onclick="closePrintModal(event);">
        <div class="print-modal-container" onclick="event.stopPropagation();">
            <div class="print-modal-bar">
                <div style="font-weight:700; color:#0f172a; font-size:15px;">
                    <i class="fa-solid fa-award" style="color:#d97706;"></i> Official Verified Certificate
                </div>
                <div style="display:flex; gap:10px; align-items:center;">
                    <button type="button" class="btn-print-btn" onclick="window.print();">
                        <i class="fa-solid fa-print"></i> Print / Save PDF
                    </button>
                    <button type="button" class="btn-close-modal" onclick="closePrintModal();">&times;</button>
                </div>
            </div>
            <div style="padding: 24px;">
                <div class="cert-canvas-doc" id="printableCertDoc">
                    <div class="cert-inner-border">
                        <!-- Top Brand -->
                        <div class="cert-top-brand">
                            <div class="cert-brand-left">
                                <% if (!string.IsNullOrEmpty(CompLogo)) { %>
                                    <img src="<%= CompLogo %>" alt="Logo" style="height: 34px; max-width: 130px; object-fit: contain; margin-bottom: 4px; display: block;" />
                                <% } %>
                                <h3><%= CompName %></h3>
                                <p>Internship &amp; Talent Acquisition Division</p>
                            </div>
                            <div class="cert-brand-meta">
                                <div><%= CompLocation %></div>
                                <div><%= CompEmail %></div>
                            </div>
                        </div>
                        <!-- Certificate Title & Header -->
                        <div class="cert-header-tag"><i class="fa-solid fa-award"></i> Verified Completion</div>
                        <h2 class="cert-main-title" id="modalCertTitle">Certificate of Internship Excellence</h2>
                        <div class="cert-present-text">This is proudly presented to</div>
                        <!-- Candidate Name -->
                        <div class="cert-candidate-name" id="modalCandName">[Candidate Full Name]</div>
                        <div class="cert-college-name" id="modalCandCollege">[College / Institute Name]</div>
                        <!-- Certificate Body -->
                        <p class="cert-body-desc">
                            For successfully completing the professional internship program as <strong id="modalCertRole" style="color:#1e3a8a;">[Internship Role]</strong> at <strong><%= CompName %></strong> for a duration of <strong id="modalCertDuration">3 Months</strong>. During this tenure, the candidate demonstrated exemplary professionalism, technical capability, and <strong id="modalCertPerformance" style="color:#d97706;">Outstanding Performance &amp; Dedication</strong>.
                        </p>
                        <!-- Footer -->
                        <div class="cert-footer-grid">
                            <div class="cert-meta-col">
                                <div><strong>Issue Date:</strong> <span id="modalCertDate"><%= DateTime.Now.ToString("dd MMMM yyyy") %></span></div>
                                <div><strong>Certificate No:</strong> <span id="modalCertNo">CERT-2026-0001</span></div>
                                <div><strong>Verification:</strong> <span id="modalVerifyCode">8F9B2C1A</span></div>
                            </div>
                            <div class="cert-seal-col">
                                <div class="cert-seal-badge">
                                    <i class="fa-solid fa-medal"></i>
                                    <span>Official<br />Verified</span>
                                </div>
                            </div>
                            <div class="cert-sign-col">
                                <div class="cert-sign-name" id="modalSignatoryName"><%= CompHr %></div>
                                <div class="cert-sign-title">Authorized Signatory &bull; <%= CompName %></div>
                            </div>
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
            updateCertPreview();
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
        function updateCertPreview() {
            var candNameInput = document.getElementById('<%= txtCandidateName.ClientID %>');
            var candName = candNameInput ? (candNameInput.value || '[Candidate Full Name]') : '[Candidate Full Name]';
            var candCollegeInput = document.getElementById('<%= txtCandidateCollege.ClientID %>');
            var candCollege = candCollegeInput ? (candCollegeInput.value || 'College / University Name') : 'College / University Name';
            var certTitleInput = document.getElementById('<%= txtCertTitle.ClientID %>');
            var certTitle = certTitleInput ? (certTitleInput.value || 'Certificate of Internship Excellence') : 'Certificate of Internship Excellence';
            var roleInput = document.getElementById('<%= txtInternshipRole.ClientID %>');
            var role = roleInput ? (roleInput.value || '[Internship Role]') : '[Internship Role]';
            var durationInput = document.getElementById('<%= txtDuration.ClientID %>');
            var duration = durationInput ? (durationInput.value || '3 Months') : '3 Months';
            var issueDateInput = document.getElementById('<%= txtIssueDate.ClientID %>');
            var issueDate = issueDateInput ? issueDateInput.value : '';
            var performanceInput = document.getElementById('<%= txtPerformance.ClientID %>');
            var performance = performanceInput ? (performanceInput.value || 'Outstanding Performance & Dedication') : 'Outstanding Performance & Dedication';
            var signatoryInput = document.getElementById('<%= txtSignatoryName.ClientID %>');
            var signatory = signatoryInput ? (signatoryInput.value || '<%= CompHr %>') : '<%= CompHr %>';
            var prevCandName = document.getElementById('prevCandName');
            if (prevCandName) prevCandName.innerText = candName;
            var prevCandCollege = document.getElementById('prevCandCollege');
            if (prevCandCollege) prevCandCollege.innerText = candCollege;
            var prevCertTitle = document.getElementById('prevCertTitle');
            if (prevCertTitle) prevCertTitle.innerText = certTitle;
            var prevCertRole = document.getElementById('prevCertRole');
            if (prevCertRole) prevCertRole.innerText = role;
            var prevCertDuration = document.getElementById('prevCertDuration');
            if (prevCertDuration) prevCertDuration.innerText = duration;
            var prevCertPerformance = document.getElementById('prevCertPerformance');
            if (prevCertPerformance) prevCertPerformance.innerText = performance;
            var prevSignatoryName = document.getElementById('prevSignatoryName');
            if (prevSignatoryName) prevSignatoryName.innerText = signatory;
            var prevCertDate = document.getElementById('prevCertDate');
            if (prevCertDate) {
                if (issueDate) {
                    var d = new Date(issueDate);
                    if (!isNaN(d.getTime())) {
                        var options = { day: '2-digit', month: 'long', year: 'numeric' };
                        prevCertDate.innerText = d.toLocaleDateString('en-GB', options);
                    } else {
                        prevCertDate.innerText = issueDate;
                    }
                }
            }
        }
        function openCertModal(name, college, title, role, duration, issueDate, performance, signatory, certNo, verifyCode) {
            document.getElementById('modalCandName').innerText = name || '[Candidate Full Name]';
            document.getElementById('modalCandCollege').innerText = college || '';
            document.getElementById('modalCertTitle').innerText = title || 'Certificate of Internship Excellence';
            document.getElementById('modalCertRole').innerText = role || '[Internship Role]';
            document.getElementById('modalCertDuration').innerText = duration || '3 Months';
            document.getElementById('modalCertPerformance').innerText = performance || 'Outstanding Performance & Dedication';
            document.getElementById('modalSignatoryName').innerText = signatory || '<%= CompHr %>';
            document.getElementById('modalCertNo').innerText = certNo || 'CERT-2026-0001';
            document.getElementById('modalVerifyCode').innerText = verifyCode || '8F9B2C1A';
            if (issueDate) {
                document.getElementById('modalCertDate').innerText = issueDate;
            }
            document.getElementById('printModal').style.display = 'flex';
        }
        function closePrintModal(e) {
            document.getElementById('printModal').style.display = 'none';
        }
        // Initialize on load
        window.addEventListener('DOMContentLoaded', function() {
            updateCertPreview();
        });
    </script>
</asp:Content>

<%@ Page Title="Certificate Management" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-certificates.aspx.cs" Inherits="asp.net.css.admin_certificates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --cert-primary: #4F46E5;
            --cert-primary-hover: #4338CA;
            --cert-bg: #F8FAFC;
            --cert-card-bg: #FFFFFF;
            --cert-text-main: #0F172A;
            --cert-text-muted: #64748B;
            --cert-border: #E2E8F0;
            --cert-shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --cert-shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --cert-shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --cert-radius: 12px;
            --cert-radius-lg: 16px;
            
            --cert-issued: #10B981;
            --cert-pending: #F59E0B;
            --cert-revoked: #EF4444;
        }

        .cert-container {
            font-family: 'Inter', sans-serif;
            background-color: var(--cert-bg);
            padding: 24px;
            min-height: calc(100vh - 80px);
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* Header Section */
        .cert-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .cert-title-area h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--cert-text-main);
            margin: 0 0 4px 0;
        }

        .cert-title-area p {
            font-size: 14px;
            color: var(--cert-text-muted);
            margin: 0;
        }

        .cert-header-actions {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .cert-btn-primary {
            padding: 10px 20px;
            background: var(--cert-primary);
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: background 0.2s;
        }
        .cert-btn-primary:hover { background: var(--cert-primary-hover); }

        .cert-btn-outline {
            padding: 10px 16px;
            background: white;
            border: 1px solid var(--cert-border);
            border-radius: 8px;
            color: var(--cert-text-main);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }
        .cert-btn-outline:hover { background: #F1F5F9; border-color: #CBD5E1; }

        .cert-btn-icon {
            padding: 10px;
            background: white;
            border: 1px solid var(--cert-border);
            border-radius: 8px;
            color: var(--cert-text-muted);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s;
        }
        .cert-btn-icon:hover { color: var(--cert-primary); background: #F8FAFC; border-color: #CBD5E1; }

        .cert-admin-profile {
            width: 40px;
            height: 40px;
            background: var(--cert-primary);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin-left: 8px;
        }

        /* Summary Cards */
        .cert-stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .cert-stat-card {
            background: var(--cert-card-bg);
            border-radius: var(--cert-radius);
            padding: 20px;
            box-shadow: var(--cert-shadow-sm);
            border: 1px solid var(--cert-border);
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .cert-stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .icon-indigo { background: #EEF2FF; color: #4F46E5; }
        .icon-green { background: #DCFCE7; color: #16A34A; }
        .icon-orange { background: #FFF7ED; color: #EA580C; }
        .icon-red { background: #FEF2F2; color: #DC2626; }

        .cert-stat-details { flex: 1; }
        .cert-stat-title {
            font-size: 13px;
            font-weight: 600;
            color: var(--cert-text-muted);
            margin-bottom: 4px;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .cert-stat-value {
            font-size: 24px;
            font-weight: 700;
            color: var(--cert-text-main);
            line-height: 1;
            display: flex;
            align-items: baseline;
            gap: 8px;
        }
        .cert-stat-trend { font-size: 12px; font-weight: 500; }
        .trend-up { color: var(--cert-issued); }
        .trend-neutral { color: var(--cert-text-muted); }
        .trend-down { color: var(--cert-revoked); }

        /* Templates Section */
        .cert-section-title {
            font-size: 16px;
            font-weight: 700;
            color: var(--cert-text-main);
            margin: 0 0 16px 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .cert-templates-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .cert-template-card {
            background: var(--cert-card-bg);
            border-radius: var(--cert-radius);
            border: 1px solid var(--cert-border);
            padding: 16px;
            box-shadow: var(--cert-shadow-sm);
        }

        .cert-template-preview {
            width: 100%;
            height: 100px;
            background: #F1F5F9;
            border: 1px dashed #CBD5E1;
            border-radius: 8px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #94A3B8;
            font-size: 24px;
            position: relative;
            overflow: hidden;
        }
        
        /* Mock certificate visual inside preview */
        .cert-template-preview::before {
            content: '';
            position: absolute;
            inset: 8px;
            border: 1px solid #CBD5E1;
            background: white;
            border-radius: 4px;
        }
        .cert-template-preview i { position: relative; z-index: 1; }

        .cert-template-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cert-template-name {
            font-size: 14px;
            font-weight: 600;
            color: var(--cert-text-main);
        }

        .cert-template-actions {
            display: flex;
            gap: 8px;
        }

        .cert-template-actions button {
            background: none;
            border: none;
            color: var(--cert-text-muted);
            cursor: pointer;
            font-size: 13px;
        }
        .cert-template-actions button:hover { color: var(--cert-primary); }

        .cert-template-create {
            background: #F8FAFC;
            border: 1px dashed #CBD5E1;
            border-radius: var(--cert-radius);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 12px;
            color: var(--cert-text-muted);
            cursor: pointer;
            transition: all 0.2s;
            height: 100%;
            min-height: 160px;
        }
        .cert-template-create:hover {
            background: white;
            border-color: var(--cert-primary);
            color: var(--cert-primary);
        }
        .cert-template-create i { font-size: 24px; }
        .cert-template-create span { font-size: 14px; font-weight: 600; }

        /* Main Split Layout */
        .cert-split-layout {
            display: flex;
            gap: 24px;
            align-items: flex-start;
        }

        .cert-card {
            background: var(--cert-card-bg);
            border-radius: var(--cert-radius-lg);
            box-shadow: var(--cert-shadow-md);
            border: 1px solid var(--cert-border);
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        /* Left Table (70%) */
        .cert-col-table {
            flex: 0 0 70%;
            max-width: 70%;
        }

        .cert-filters-bar {
            padding: 16px 20px;
            border-bottom: 1px solid var(--cert-border);
            display: flex;
            gap: 12px;
            align-items: center;
            background: #F8FAFC;
            flex-wrap: wrap;
        }

        .cert-search-wrapper {
            flex: 1;
            min-width: 200px;
            position: relative;
        }
        .cert-search-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94A3B8;
        }
        .cert-search-input {
            width: 100%;
            padding: 10px 14px 10px 36px;
            border: 1px solid var(--cert-border);
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            background: white;
            font-family: inherit;
        }
        .cert-search-input:focus { border-color: var(--cert-primary); }

        .cert-select {
            padding: 10px 32px 10px 14px;
            border: 1px solid var(--cert-border);
            border-radius: 8px;
            font-size: 14px;
            color: var(--cert-text-main);
            background: white;
            outline: none;
            cursor: pointer;
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748B'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 16px;
        }

        .cert-btn-clear {
            background: none;
            border: none;
            color: var(--cert-text-muted);
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
        }
        .cert-btn-clear:hover { color: var(--cert-text-main); text-decoration: underline; }

        .cert-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cert-table th {
            background: #F8FAFC;
            padding: 12px 20px;
            text-align: left;
            font-size: 12px;
            font-weight: 600;
            color: var(--cert-text-muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 1px solid var(--cert-border);
        }

        .cert-table td {
            padding: 16px 20px;
            border-bottom: 1px solid var(--cert-border);
            font-size: 14px;
            color: var(--cert-text-main);
            vertical-align: middle;
        }
        .cert-table tr:hover td { background: #F8FAFC; }
        .cert-table tr:last-child td { border-bottom: none; }

        .cert-student-cell {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .cert-avatar {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 13px;
        }

        .cert-badge {
            display: inline-flex;
            align-items: center;
            padding: 4px 10px;
            border-radius: 9999px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-issued { background: #DCFCE7; color: var(--cert-issued); }
        .badge-pending { background: #FEF3C7; color: var(--cert-pending); }
        .badge-revoked { background: #FEE2E2; color: var(--cert-revoked); }

        .cert-dropdown { position: relative; display: inline-block; }
        .cert-action-btn {
            background: none;
            border: none;
            color: #94A3B8;
            cursor: pointer;
            padding: 8px;
            border-radius: 6px;
        }
        .cert-action-btn:hover { background: #F1F5F9; color: var(--cert-text-main); }
        .cert-dropdown-menu {
            position: absolute;
            right: 0;
            top: 100%;
            min-width: 180px;
            background: white;
            border: 1px solid var(--cert-border);
            border-radius: 8px;
            box-shadow: var(--cert-shadow-md);
            z-index: 10;
            display: none;
            padding: 8px 0;
        }
        .cert-dropdown:hover .cert-dropdown-menu { display: block; }
        .cert-dropdown-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 16px;
            font-size: 14px;
            color: var(--cert-text-main);
            text-decoration: none;
            cursor: pointer;
        }
        .cert-dropdown-item:hover { background: #F1F5F9; color: var(--cert-primary); }
        .cert-dropdown-item.danger:hover { color: var(--cert-revoked); background: #FEE2E2; }

        /* Pagination */
        .cert-pagination {
            padding: 16px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid var(--cert-border);
        }
        .cert-page-info { font-size: 14px; color: var(--cert-text-muted); }
        .cert-page-controls { display: flex; align-items: center; gap: 6px; }
        .cert-page-btn {
            min-width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid var(--cert-border);
            background: white;
            color: var(--cert-text-main);
            border-radius: 6px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            padding: 0 10px;
        }
        .cert-page-btn:hover:not(:disabled) { background: #F8FAFC; }
        .cert-page-btn.active { background: var(--cert-primary); color: white; border-color: var(--cert-primary); }
        .cert-page-btn:disabled { opacity: 0.5; cursor: not-allowed; }

        /* Right Column (30%) */
        .cert-col-recent {
            flex: 0 0 30%;
            max-width: 30%;
        }

        .cert-recent-header {
            padding: 20px;
            border-bottom: 1px solid var(--cert-border);
            font-size: 16px;
            font-weight: 700;
            color: var(--cert-text-main);
            background: white;
        }

        .cert-recent-list {
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .cert-recent-item {
            display: flex;
            gap: 12px;
        }

        .cert-recent-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 14px;
        }
        .icon-gen { background: #EFF6FF; color: #3B82F6; }
        .icon-dl { background: #F3E8FF; color: #A855F7; }
        .icon-rev { background: #FEE2E2; color: #EF4444; }

        .cert-recent-content {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }
        .cert-recent-title { font-size: 14px; font-weight: 600; color: var(--cert-text-main); }
        .cert-recent-desc { font-size: 13px; color: var(--cert-text-muted); }
        .cert-recent-time { font-size: 12px; color: #94A3B8; margin-top: 4px; }

        /* Modals & Overlays */
        .cert-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.5);
            backdrop-filter: blur(2px);
            z-index: 1000;
            display: none;
            align-items: center;
            justify-content: center;
        }

        /* Generate Certificate Modal */
        .cert-modal-xl {
            background: white;
            border-radius: var(--cert-radius-lg);
            width: 100%;
            max-width: 900px;
            box-shadow: var(--cert-shadow-lg);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            max-height: 90vh;
        }
        .cert-modal-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--cert-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .cert-modal-title { font-size: 18px; font-weight: 700; color: var(--cert-text-main); margin: 0; }
        .cert-modal-close { background: none; border: none; font-size: 20px; color: #94A3B8; cursor: pointer; }

        .cert-modal-body-split {
            display: flex;
            flex: 1;
            overflow: hidden;
        }
        .cert-modal-form {
            flex: 1;
            padding: 24px;
            overflow-y: auto;
            border-right: 1px solid var(--cert-border);
        }
        .cert-modal-preview {
            flex: 1;
            background: #F8FAFC;
            padding: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow-y: auto;
        }

        .cert-form-section {
            margin-bottom: 24px;
        }
        .cert-form-title {
            font-size: 14px;
            font-weight: 700;
            color: var(--cert-text-main);
            margin: 0 0 16px 0;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .cert-form-group { margin-bottom: 16px; }
        .cert-form-label { display: block; font-size: 13px; font-weight: 600; color: var(--cert-text-main); margin-bottom: 6px; }
        .cert-form-input {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid var(--cert-border);
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            font-family: inherit;
        }
        .cert-form-input:disabled { background: #F1F5F9; color: #94A3B8; }
        
        .cert-modal-footer {
            padding: 16px 24px;
            border-top: 1px solid var(--cert-border);
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            background: #F8FAFC;
        }

        /* Certificate Preview Design */
        .cert-preview-wrapper {
            background: white;
            width: 100%;
            max-width: 400px;
            aspect-ratio: 1.414 / 1; /* A4 Landscape roughly */
            border: 2px solid #E2E8F0;
            padding: 12px;
            box-shadow: var(--cert-shadow-md);
            position: relative;
        }
        .cert-preview-inner {
            border: 4px double #4F46E5;
            height: 100%;
            padding: 24px;
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            position: relative;
        }
        .cert-preview-logo { width: 40px; height: 40px; background: #EEF2FF; border-radius: 50%; margin: 0 auto 12px; }
        .cert-preview-title { font-size: 20px; font-weight: 700; color: #1E293B; letter-spacing: 0.1em; margin-bottom: 12px; }
        .cert-preview-text { font-size: 11px; color: #64748B; margin-bottom: 8px; }
        .cert-preview-name { font-size: 24px; font-weight: 700; color: #4F46E5; margin-bottom: 12px; font-family: 'Times New Roman', serif; font-style: italic; }
        .cert-preview-course { font-size: 14px; font-weight: 600; color: #334155; margin-bottom: 24px; }
        
        .cert-preview-bottom {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: auto;
        }
        .cert-preview-sign {
            width: 80px;
            border-top: 1px solid #94A3B8;
            padding-top: 4px;
            font-size: 9px;
            color: #64748B;
        }
        .cert-preview-qr {
            width: 40px;
            height: 40px;
            background: #E2E8F0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        .cert-preview-meta {
            position: absolute;
            bottom: 8px;
            right: 8px;
            font-size: 8px;
            color: #94A3B8;
            text-align: right;
        }

        /* Detail Drawer */
        .cert-drawer-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.4);
            z-index: 1000;
            display: none;
        }
        .cert-drawer {
            position: fixed;
            top: 0;
            right: -400px;
            width: 400px;
            height: 100vh;
            background: white;
            box-shadow: -4px 0 15px rgba(0,0,0,0.1);
            z-index: 1001;
            transition: right 0.3s ease;
            display: flex;
            flex-direction: column;
        }
        .cert-drawer.open { right: 0; }
        
        .cert-drawer-header {
            padding: 24px;
            border-bottom: 1px solid var(--cert-border);
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }
        .cert-drawer-title h2 { margin: 0 0 4px 0; font-size: 20px; color: var(--cert-text-main); }
        .cert-drawer-title p { margin: 0; font-size: 14px; color: var(--cert-text-muted); }
        .cert-drawer-close { background: none; border: none; font-size: 20px; color: #94A3B8; cursor: pointer; }
        
        .cert-drawer-body {
            padding: 24px;
            overflow-y: auto;
            flex: 1;
        }

        .cert-verify-panel {
            background: #F8FAFC;
            border: 1px solid var(--cert-border);
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 24px;
        }
        .cert-verify-header {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            font-weight: 600;
            color: var(--cert-issued);
            margin-bottom: 12px;
        }

        .cert-detail-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid var(--cert-border);
        }
        .cert-detail-row:last-child { border-bottom: none; }
        .cert-detail-label { font-size: 13px; color: var(--cert-text-muted); font-weight: 500; }
        .cert-detail-value { font-size: 13px; color: var(--cert-text-main); font-weight: 600; text-align: right;}

        .cert-drawer-actions {
            padding: 24px;
            border-top: 1px solid var(--cert-border);
            display: flex;
            flex-direction: column;
            gap: 12px;
            background: #F8FAFC;
        }

        /* Revoke Modal */
        .cert-modal-sm {
            background: white;
            border-radius: var(--cert-radius-lg);
            width: 100%;
            max-width: 400px;
            padding: 24px;
            box-shadow: var(--cert-shadow-lg);
            text-align: center;
        }
        .cert-modal-icon-danger {
            width: 64px;
            height: 64px;
            background: #FEE2E2;
            color: var(--cert-revoked);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin: 0 auto 16px;
        }
        .cert-modal-sm h3 { font-size: 20px; color: var(--cert-text-main); margin: 0 0 8px 0; }
        .cert-modal-sm p { font-size: 14px; color: var(--cert-text-muted); margin: 0 0 20px 0; }
        
        .cert-revoke-form { text-align: left; margin-bottom: 24px; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cert-container">
        
        <!-- Header -->
        <div class="cert-header">
            <div class="cert-title-area">
                <h1>Certificate Management</h1>
                <p>Create, issue and manage student certificates.</p>
            </div>
            <div class="cert-header-actions">
                <button type="button" class="cert-btn-primary" onclick="openGenerateModal()">
                    <i class="fa-solid fa-plus"></i> Generate Certificate
                </button>
                <button type="button" class="cert-btn-outline"><i class="fa-solid fa-file-export"></i> Export</button>
                <button type="button" class="cert-btn-icon" onclick="location.reload();"><i class="fa-solid fa-rotate-right"></i></button>
                <div class="cert-admin-profile">A</div>
            </div>
        </div>

        <!-- Summary Cards -->
        <div class="cert-stats-grid">
            <div class="cert-stat-card">
                <div class="cert-stat-icon icon-indigo"><i class="fa-solid fa-certificate"></i></div>
                <div class="cert-stat-details">
                    <div class="cert-stat-title">Total Certificates</div>
                    <div class="cert-stat-value">1,248</div>
                </div>
            </div>
            <div class="cert-stat-card">
                <div class="cert-stat-icon icon-green"><i class="fa-solid fa-check-circle"></i></div>
                <div class="cert-stat-details">
                    <div class="cert-stat-title">Issued</div>
                    <div class="cert-stat-value">1,120</div>
                </div>
            </div>
            <div class="cert-stat-card">
                <div class="cert-stat-icon icon-orange"><i class="fa-solid fa-clock-rotate-left"></i></div>
                <div class="cert-stat-details">
                    <div class="cert-stat-title">Pending</div>
                    <div class="cert-stat-value">84</div>
                </div>
            </div>
            <div class="cert-stat-card">
                <div class="cert-stat-icon icon-red"><i class="fa-solid fa-ban"></i></div>
                <div class="cert-stat-details">
                    <div class="cert-stat-title">Revoked</div>
                    <div class="cert-stat-value">44</div>
                </div>
            </div>
        </div>

        <!-- Certificate Templates -->
        <div>
            <h2 class="cert-section-title"><i class="fa-solid fa-layer-group"></i> Certificate Templates</h2>
            <div class="cert-templates-grid">
                <div class="cert-template-card">
                    <div class="cert-template-preview"><i class="fa-solid fa-award"></i></div>
                    <div class="cert-template-info">
                        <span class="cert-template-name">Template 01<br><small style="color:var(--cert-text-muted); font-weight:500;">Classic Certificate</small></span>
                        <div class="cert-template-actions">
                            <button type="button" title="Preview"><i class="fa-solid fa-eye"></i></button>
                            <button type="button" title="Edit"><i class="fa-solid fa-pen"></i></button>
                        </div>
                    </div>
                </div>
                <div class="cert-template-card">
                    <div class="cert-template-preview"><i class="fa-solid fa-medal"></i></div>
                    <div class="cert-template-info">
                        <span class="cert-template-name">Template 02<br><small style="color:var(--cert-text-muted); font-weight:500;">Modern Certificate</small></span>
                        <div class="cert-template-actions">
                            <button type="button" title="Preview"><i class="fa-solid fa-eye"></i></button>
                            <button type="button" title="Edit"><i class="fa-solid fa-pen"></i></button>
                        </div>
                    </div>
                </div>
                <div class="cert-template-card">
                    <div class="cert-template-preview"><i class="fa-solid fa-trophy"></i></div>
                    <div class="cert-template-info">
                        <span class="cert-template-name">Template 03<br><small style="color:var(--cert-text-muted); font-weight:500;">Professional Certificate</small></span>
                        <div class="cert-template-actions">
                            <button type="button" title="Preview"><i class="fa-solid fa-eye"></i></button>
                            <button type="button" title="Edit"><i class="fa-solid fa-pen"></i></button>
                        </div>
                    </div>
                </div>
                <div class="cert-template-create">
                    <i class="fa-solid fa-plus"></i>
                    <span>Create Template</span>
                </div>
            </div>
        </div>

        <!-- Main Content Area -->
        <div class="cert-split-layout">
            
            <!-- Left Column: Table -->
            <div class="cert-card cert-col-table">
                <div class="cert-filters-bar">
                    <div class="cert-search-wrapper">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" class="cert-search-input" placeholder="Search student name or certificate ID..." />
                    </div>
                    <select class="cert-select"><option>Certificate Type</option></select>
                    <select class="cert-select"><option>Course</option></select>
                    <select class="cert-select"><option>Status</option></select>
                    <select class="cert-select"><option>Issue Date</option></select>
                    <button type="button" class="cert-btn-clear">Clear Filters</button>
                </div>

                <div style="overflow-x: auto;">
                    <table class="cert-table">
                        <thead>
                            <tr>
                                <th>Student</th>
                                <th>Certificate ID</th>
                                <th>Course</th>
                                <th>Issue Date</th>
                                <th>Certificate Type</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="cert-student-cell">
                                        <div class="cert-avatar" style="background:#4F46E5;">DP</div>
                                        <strong>Dhruvi Patel</strong>
                                    </div>
                                </td>
                                <td style="font-family: monospace;">CERT001</td>
                                <td>BCA</td>
                                <td>21 Aug 2026</td>
                                <td>Course Completion</td>
                                <td><span class="cert-badge badge-issued">Issued</span></td>
                                <td>
                                    <div class="cert-dropdown">
                                        <button type="button" class="cert-action-btn" onclick="openDrawer('CERT001')"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <div class="cert-dropdown-menu">
                                            <a class="cert-dropdown-item" onclick="openDrawer('CERT001')"><i class="fa-solid fa-eye"></i> View Certificate</a>
                                            <a class="cert-dropdown-item"><i class="fa-solid fa-download"></i> Download PDF</a>
                                            <a class="cert-dropdown-item"><i class="fa-solid fa-print"></i> Print</a>
                                            <a class="cert-dropdown-item"><i class="fa-solid fa-check-double"></i> Verify</a>
                                            <a class="cert-dropdown-item danger" onclick="openRevokeModal()"><i class="fa-solid fa-ban"></i> Revoke</a>
                                            <a class="cert-dropdown-item danger"><i class="fa-solid fa-trash"></i> Delete</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="cert-student-cell">
                                        <div class="cert-avatar" style="background:#10B981;">RS</div>
                                        <strong>Rahul Shah</strong>
                                    </div>
                                </td>
                                <td style="font-family: monospace;">CERT002</td>
                                <td>Web Development</td>
                                <td>20 Aug 2026</td>
                                <td>Course Completion</td>
                                <td><span class="cert-badge badge-issued">Issued</span></td>
                                <td>
                                    <div class="cert-dropdown">
                                        <button type="button" class="cert-action-btn"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <div class="cert-dropdown-menu">
                                            <a class="cert-dropdown-item"><i class="fa-solid fa-eye"></i> View Certificate</a>
                                            <a class="cert-dropdown-item"><i class="fa-solid fa-download"></i> Download PDF</a>
                                            <a class="cert-dropdown-item danger" onclick="openRevokeModal()"><i class="fa-solid fa-ban"></i> Revoke</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="cert-student-cell">
                                        <div class="cert-avatar" style="background:#F59E0B;">PP</div>
                                        <strong>Priya Patel</strong>
                                    </div>
                                </td>
                                <td style="font-family: monospace;">CERT003</td>
                                <td>Python Programming</td>
                                <td style="color:var(--cert-text-muted);">—</td>
                                <td>Course Completion</td>
                                <td><span class="cert-badge badge-pending">Pending</span></td>
                                <td>
                                    <div class="cert-dropdown">
                                        <button type="button" class="cert-action-btn"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="cert-student-cell">
                                        <div class="cert-avatar" style="background:#EF4444;">AS</div>
                                        <strong>Amit Shah</strong>
                                    </div>
                                </td>
                                <td style="font-family: monospace;">CERT004</td>
                                <td>Data Analytics</td>
                                <td>18 Aug 2026</td>
                                <td>Course Completion</td>
                                <td><span class="cert-badge badge-revoked">Revoked</span></td>
                                <td>
                                    <div class="cert-dropdown">
                                        <button type="button" class="cert-action-btn"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <div class="cert-pagination">
                    <div class="cert-page-info">Showing 1–10 of 1,248 certificates</div>
                    <div style="display:flex; align-items:center; gap: 20px;">
                        <div style="display:flex; align-items:center; gap: 8px; font-size:14px; color:var(--cert-text-muted);">
                            Rows per page:
                            <select class="cert-select" style="padding: 4px 24px 4px 10px; background-position: right 8px center;">
                                <option>10</option>
                            </select>
                        </div>
                        <div class="cert-page-controls">
                            <button class="cert-page-btn" disabled>Previous</button>
                            <button class="cert-page-btn active">1</button>
                            <button class="cert-page-btn">2</button>
                            <button class="cert-page-btn">3</button>
                            <button class="cert-page-btn">4</button>
                            <button class="cert-page-btn">5</button>
                            <button class="cert-page-btn">Next</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Right Column: Recent Activity -->
            <div class="cert-card cert-col-recent">
                <div class="cert-recent-header">Recent Certificates</div>
                <div class="cert-recent-list">
                    <div class="cert-recent-item">
                        <div class="cert-recent-icon icon-gen"><i class="fa-solid fa-plus"></i></div>
                        <div class="cert-recent-content">
                            <span class="cert-recent-title">Certificate Generated</span>
                            <span class="cert-recent-desc">Dhruvi Patel — CERT001</span>
                            <span class="cert-recent-time">Today, 10:30 AM</span>
                        </div>
                    </div>
                    <div class="cert-recent-item">
                        <div class="cert-recent-icon icon-dl"><i class="fa-solid fa-download"></i></div>
                        <div class="cert-recent-content">
                            <span class="cert-recent-title">Certificate Downloaded</span>
                            <span class="cert-recent-desc">Rahul Shah — CERT002</span>
                            <span class="cert-recent-time">Today, 09:45 AM</span>
                        </div>
                    </div>
                    <div class="cert-recent-item">
                        <div class="cert-recent-icon icon-rev"><i class="fa-solid fa-ban"></i></div>
                        <div class="cert-recent-content">
                            <span class="cert-recent-title">Certificate Revoked</span>
                            <span class="cert-recent-desc">Priya Patel — CERT003</span>
                            <span class="cert-recent-time">Yesterday, 05:20 PM</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Generate Certificate Modal -->
    <div class="cert-overlay" id="generateModal">
        <div class="cert-modal-xl">
            <div class="cert-modal-header">
                <h2 class="cert-modal-title">Generate Certificate</h2>
                <button type="button" class="cert-modal-close" onclick="closeGenerateModal()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="cert-modal-body-split">
                <!-- Form Area -->
                <div class="cert-modal-form">
                    <div class="cert-form-section">
                        <h3 class="cert-form-title">Student Information</h3>
                        <div class="cert-form-group">
                            <label class="cert-form-label">Select Student</label>
                            <select class="cert-select" style="width:100%;"><option>Dhruvi Patel</option></select>
                        </div>
                        <div class="cert-form-group">
                            <label class="cert-form-label">Student ID</label>
                            <input type="text" class="cert-form-input" value="STU001" disabled />
                        </div>
                        <div class="cert-form-group">
                            <label class="cert-form-label">Course</label>
                            <input type="text" class="cert-form-input" value="BCA" disabled />
                        </div>
                    </div>
                    <div class="cert-form-section">
                        <h3 class="cert-form-title">Certificate Details</h3>
                        <div class="cert-form-group">
                            <label class="cert-form-label">Certificate Type</label>
                            <select class="cert-select" style="width:100%;"><option>Course Completion</option></select>
                        </div>
                        <div class="cert-form-group" style="display:flex; gap:16px;">
                            <div style="flex:1;">
                                <label class="cert-form-label">Completion Date</label>
                                <input type="date" class="cert-form-input" value="2026-08-21" />
                            </div>
                            <div style="flex:1;">
                                <label class="cert-form-label">Issue Date</label>
                                <input type="date" class="cert-form-input" value="2026-08-21" />
                            </div>
                        </div>
                        <div class="cert-form-group">
                            <label class="cert-form-label">Certificate Template</label>
                            <select class="cert-select" style="width:100%;"><option>Template 01 - Classic</option></select>
                        </div>
                        <div class="cert-form-group" style="display:flex; gap:16px;">
                            <div style="flex:1;">
                                <label class="cert-form-label">Certificate ID (Auto)</label>
                                <input type="text" class="cert-form-input" value="CERT001" disabled />
                            </div>
                            <div style="flex:1;">
                                <label class="cert-form-label">Verification Code (Auto)</label>
                                <input type="text" class="cert-form-input" value="8FJ29K" disabled />
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Preview Area -->
                <div class="cert-modal-preview">
                    <div class="cert-preview-wrapper">
                        <div class="cert-preview-inner">
                            <div class="cert-preview-logo"><i class="fa-solid fa-graduation-cap"></i></div>
                            <div class="cert-preview-title">CERTIFICATE<br><span style="font-size:12px;">OF COMPLETION</span></div>
                            <div class="cert-preview-text">This is to certify that</div>
                            <div class="cert-preview-name">Dhruvi Patel</div>
                            <div class="cert-preview-text">has successfully completed</div>
                            <div class="cert-preview-course">BCA Course</div>
                            
                            <div class="cert-preview-bottom">
                                <div class="cert-preview-sign">Director Signature</div>
                                <div class="cert-preview-qr"><i class="fa-solid fa-qrcode"></i></div>
                                <div class="cert-preview-sign">Instructor Signature</div>
                            </div>
                            <div class="cert-preview-meta">
                                Completion Date: 21 August 2026<br>
                                Certificate ID: CERT001<br>
                                Verification Code: 8FJ29K
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="cert-modal-footer">
                <button type="button" class="cert-btn-outline" onclick="closeGenerateModal()">Cancel</button>
                <button type="button" class="cert-btn-outline"><i class="fa-solid fa-eye"></i> Preview Certificate</button>
                <button type="button" class="cert-btn-primary" onclick="closeGenerateModal()">Generate Certificate</button>
            </div>
        </div>
    </div>

    <!-- Details Drawer -->
    <div class="cert-drawer-overlay" id="certDrawerOverlay" onclick="closeDrawer()"></div>
    <div class="cert-drawer" id="certDrawer">
        <div class="cert-drawer-header">
            <div class="cert-drawer-title">
                <h2>Certificate</h2>
                <p>CERT001</p>
            </div>
            <button type="button" class="cert-drawer-close" onclick="closeDrawer()"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="cert-drawer-body">
            <div style="text-align:center; margin-bottom:24px;">
                <div class="cert-avatar" style="width:64px; height:64px; margin:0 auto 12px; font-size:24px; background:#4F46E5;">DP</div>
                <h3 style="margin:0 0 4px 0; font-size:18px; color:var(--cert-text-main);">Dhruvi Patel</h3>
                <span class="cert-badge badge-issued">Issued / Valid</span>
            </div>

            <div class="cert-verify-panel">
                <div class="cert-verify-header"><i class="fa-solid fa-circle-check"></i> Certificate Verified</div>
                <div class="cert-detail-row">
                    <span class="cert-detail-label">Verification Code</span>
                    <span class="cert-detail-value" style="font-family:monospace;">8FJ29K</span>
                </div>
                <div class="cert-detail-row">
                    <span class="cert-detail-label">Certificate ID</span>
                    <span class="cert-detail-value" style="font-family:monospace;">CERT001</span>
                </div>
                <div class="cert-detail-row">
                    <span class="cert-detail-label">Certificate Status</span>
                    <span class="cert-detail-value" style="color:var(--cert-issued);">Valid</span>
                </div>
            </div>

            <h4 style="font-size:14px; color:var(--cert-text-main); margin-bottom:12px;">Details</h4>
            <div style="background:#F8FAFC; border:1px solid var(--cert-border); border-radius:12px; padding:16px;">
                <div class="cert-detail-row">
                    <span class="cert-detail-label">Student Name</span>
                    <span class="cert-detail-value">Dhruvi Patel</span>
                </div>
                <div class="cert-detail-row">
                    <span class="cert-detail-label">Student ID</span>
                    <span class="cert-detail-value">STU001</span>
                </div>
                <div class="cert-detail-row">
                    <span class="cert-detail-label">Course</span>
                    <span class="cert-detail-value">BCA</span>
                </div>
                <div class="cert-detail-row">
                    <span class="cert-detail-label">Certificate Type</span>
                    <span class="cert-detail-value">Course Completion</span>
                </div>
                <div class="cert-detail-row">
                    <span class="cert-detail-label">Issue Date</span>
                    <span class="cert-detail-value">21 Aug 2026</span>
                </div>
                <div class="cert-detail-row">
                    <span class="cert-detail-label">Completion Date</span>
                    <span class="cert-detail-value">21 Aug 2026</span>
                </div>
                <div class="cert-detail-row">
                    <span class="cert-detail-label">Issued By</span>
                    <span class="cert-detail-value">Admin</span>
                </div>
            </div>
        </div>
        <div class="cert-drawer-actions">
            <button type="button" class="cert-btn-outline" style="justify-content:center; width:100%;"><i class="fa-solid fa-download"></i> Download PDF</button>
            <button type="button" class="cert-btn-outline" style="justify-content:center; width:100%;"><i class="fa-solid fa-print"></i> Print</button>
            <button type="button" class="cert-btn-outline" style="justify-content:center; width:100%; color:var(--cert-danger); border-color:#FEE2E2;" onclick="openRevokeModal()"><i class="fa-solid fa-ban"></i> Revoke Certificate</button>
        </div>
    </div>

    <!-- Revoke Modal -->
    <div class="cert-overlay" id="revokeModal">
        <div class="cert-modal-sm">
            <div class="cert-modal-icon-danger"><i class="fa-solid fa-triangle-exclamation"></i></div>
            <h3>Revoke Certificate?</h3>
            <p>Are you sure you want to revoke this certificate? This action cannot be undone.</p>
            
            <div class="cert-revoke-form">
                <label class="cert-form-label">Reason for revocation:</label>
                <textarea class="cert-form-input" placeholder="Enter reason for revocation..." rows="3" style="resize:none; padding:12px;"></textarea>
            </div>

            <div style="display:flex; gap:12px;">
                <button type="button" class="cert-btn-outline" style="flex:1; justify-content:center;" onclick="closeRevokeModal()">Cancel</button>
                <button type="button" class="cert-btn-primary" style="flex:1; justify-content:center; background:var(--cert-revoked);" onclick="closeRevokeModal()">Revoke</button>
            </div>
        </div>
    </div>

    <script>
        function openGenerateModal() { document.getElementById('generateModal').style.display = 'flex'; }
        function closeGenerateModal() { document.getElementById('generateModal').style.display = 'none'; }
        
        function openDrawer(id) { 
            document.getElementById('certDrawerOverlay').style.display = 'block';
            document.getElementById('certDrawer').classList.add('open');
        }
        function closeDrawer() { 
            document.getElementById('certDrawerOverlay').style.display = 'none';
            document.getElementById('certDrawer').classList.remove('open');
        }
        
        function openRevokeModal() { 
            closeDrawer();
            document.getElementById('revokeModal').style.display = 'flex'; 
        }
        function closeRevokeModal() { document.getElementById('revokeModal').style.display = 'none'; }
    </script>
</asp:Content>

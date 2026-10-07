<%@ Page Title="Admin - Internships" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-internships.aspx.cs" Inherits="asp.net.admin_internships" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-internships.css" />
    <style>
        /* Page header */
        .page-header { margin-bottom: 22px; }
        .page-title { margin: 0 0 4px; font-size: 24px; font-weight: 700; color: #0f172a; }
        .page-subtitle { margin: 0; font-size: 14px; color: #64748b; }

        /* Filter bar */
        .admin-filter-bar {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 22px;
            padding: 14px 18px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,.02);
        }
        .filter-search-wrap { position: relative; flex: 1 1 200px; min-width: 180px; }
        .filter-search-wrap .search-icon {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 12.5px;
            color: #94a3b8;
        }
        .filter-search-wrap input {
            width: 100%;
            padding: 8px 12px 8px 34px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13px;
            color: #1e293b;
            outline: none;
            transition: border-color .2s;
        }
        .filter-search-wrap input:focus { border-color: #2563eb; }

        .filter-select-wrap { position: relative; flex: 0 0 auto; }
        .wrap-domain { width: 165px; }
        .wrap-location,
        .wrap-workmode { width: 135px; }
        .wrap-type,
        .wrap-status { width: 125px; }
        .filter-select-wrap select {
            width: 100%;
            padding: 8px 26px 8px 30px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 12.5px;
            color: #1e293b;
            background: #fff;
            appearance: none;
            cursor: pointer;
            outline: none;
            white-space: nowrap;
            text-overflow: ellipsis;
            transition: border-color .2s;
        }
        .filter-select-wrap select:focus { border-color: #2563eb; }
        .filter-select-wrap .prefix-icon,
        .filter-select-wrap .chevron-icon {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            pointer-events: none;
        }
        .filter-select-wrap .prefix-icon { left: 10px; font-size: 12px; color: #64748b; }
        .filter-select-wrap .chevron-icon { right: 9px; font-size: 10px; color: #94a3b8; }

        .filter-actions { display: flex; align-items: center; gap: 8px; }
        .btn-filter-search,
        .btn-filter-clear {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 12.5px;
            font-weight: 600;
            border-radius: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: all .15s ease;
        }
        .btn-filter-search { padding: 8px 16px; background: #2563eb; color: #fff; border: none; }
        .btn-filter-clear { padding: 8px 14px; background: #f1f5f9; color: #475569; border: 1px solid #e2e8f0; }
        .btn-filter-clear:hover { background: #e2e8f0; color: #0f172a; }

        /* List container */
        .list-card { padding: 24px; background: #fff; border: 1px solid #e2e8f0; border-radius: 16px; }
        .list-card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 18px;
        }
        .list-card-title { margin: 0; font-size: 18px; font-weight: 700; color: #0f172a; }
        .result-count { font-size: 13px; font-weight: 500; color: #64748b; }

        /* Cards grid */
        .admin-internships-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 22px;
            width: 100%;
            margin-top: 10px;
        }
        .admin-internship-card {
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 20px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            box-shadow: 0 4px 12px rgba(15,23,42,.04);
            transition: all .25s ease;
        }
        .admin-internship-card:hover {
            transform: translateY(-4px);
            border-color: #cbd5e1;
            box-shadow: 0 10px 24px rgba(37,99,235,.1);
        }

        .admin-card-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 14px;
            margin-bottom: 16px;
        }
        .admin-card-main { display: flex; align-items: center; gap: 14px; flex: 1; min-width: 0; overflow: hidden; }
        .admin-card-status { margin-left: 8px; flex-shrink: 0; }
        .admin-company-logo-avatar {
            width: 52px;
            height: 52px;
            flex-shrink: 0;
            border: 2px solid #e2e8f0;
            border-radius: 50% !important;
            overflow: hidden !important;
            object-fit: cover;
            background: #f8fafc;
        }
        .admin-card-title-wrap { display: flex; flex-direction: column; gap: 3px; flex: 1; overflow: hidden; }
        .admin-card-title,
        .admin-company-name {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .admin-card-title { margin: 0; font-size: 16.5px; font-weight: 700; line-height: 1.3; color: #0f172a; }
        .admin-company-name {
            display: flex;
            align-items: center;
            gap: 4px;
            font-size: 13.5px;
            font-weight: 600;
            color: #2563eb;
        }
        .admin-company-name i { font-size: 11px; }

        /* Info list */
        .admin-info-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 16px;
            padding: 12px 14px;
            background: #f8fafc;
            border: 1px solid #f1f5f9;
            border-radius: 10px;
            font-size: 13px;
            color: #334155;
        }
        .admin-info-row { display: flex; align-items: center; justify-content: space-between; gap: 8px; }
        .admin-info-label {
            display: flex;
            align-items: center;
            gap: 6px;
            flex-shrink: 0;
            font-weight: 500;
            color: #64748b;
        }
        .admin-info-label i { width: 14px; color: #2563eb; }
        .admin-info-val {
            font-weight: 600;
            text-align: right;
            color: #0f172a;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .admin-info-val.stipend { color: #16a34a; }

        /* Card actions */
        .admin-card-actions {
            display: flex;
            align-items: center;
            gap: 10px;
            padding-top: 14px;
            border-top: 1px solid #f1f5f9;
        }
        .admin-btn-action {
            flex: 1;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            padding: 8px 12px;
            font-size: 13px;
            font-weight: 600;
            text-align: center;
            text-decoration: none !important;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all .2s ease;
        }
        .admin-btn-action i.toggle-icon { font-size: 14px; }
        .admin-btn-primary { background: #2563eb; color: #fff !important; }
        .admin-btn-primary:hover { background: #1d4ed8; }
        .admin-btn-danger { background: #fef2f2; color: #ef4444 !important; border: 1px solid #fee2e2; }
        .admin-btn-danger:hover { background: #ef4444; color: #fff !important; }
        .admin-btn-status-active { background: #ecfdf5; color: #059669 !important; border: 1px solid #a7f3d0; }
        .admin-btn-status-active:hover { background: #d1fae5; color: #047857 !important; border-color: #6ee7b7; }
        .admin-btn-status-inactive { background: #fef2f2; color: #dc2626 !important; border: 1px solid #fecaca; }
        .admin-btn-status-inactive:hover { background: #fee2e2; color: #b91c1c !important; border-color: #fca5a5; }

        /* Status badges */
        .status-badge-active,
        .status-badge-inactive {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 3px 9px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            white-space: nowrap;
        }
        .status-badge-active { background: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; }
        .status-badge-inactive { background: #fee2e2; color: #dc2626; border: 1px solid #fecaca; }

        /* Empty state */
        .empty-state-box-admin {
            width: 100%;
            margin-top: 20px;
            padding: 50px 20px;
            text-align: center;
            background: #fff;
            border: 2px dashed #cbd5e1;
            border-radius: 14px;
        }
        .empty-state-icon { margin-bottom: 14px; font-size: 44px; color: #94a3b8; }
        .empty-state-title { margin: 0 0 8px; font-size: 18px; font-weight: 700; color: #0f172a; }
        .empty-state-text { margin: 0 0 16px; font-size: 14px; color: #64748b; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sims-internship-page" style="padding: 10px 0;">

        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">Internship Management</h1>
            <p class="page-subtitle">Manage, review, search and filter all internship opportunities posted by registered companies.</p>
        </div>

        <!-- Search & Filter Bar -->
        <div class="admin-filter-bar">

            <div class="filter-search-wrap">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search role, skills, company..." />
            </div>

            <div class="filter-select-wrap wrap-domain">
                <i class="fa-solid fa-layer-group prefix-icon"></i>
                <asp:DropDownList ID="ddlDomain" runat="server" AppendDataBoundItems="true">
                    <asp:ListItem Text="All Domains" Value="" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="filter-select-wrap wrap-location">
                <i class="fa-solid fa-location-dot prefix-icon"></i>
                <asp:DropDownList ID="ddlLocation" runat="server" AppendDataBoundItems="true">
                    <asp:ListItem Text="All Locations" Value="" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="filter-select-wrap wrap-workmode">
                <i class="fa-solid fa-laptop-code prefix-icon"></i>
                <asp:DropDownList ID="ddlWorkMode" runat="server" AppendDataBoundItems="true">
                    <asp:ListItem Text="All Work Modes" Value="" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="filter-select-wrap wrap-type">
                <i class="fa-solid fa-briefcase prefix-icon"></i>
                <asp:DropDownList ID="ddlType" runat="server" AppendDataBoundItems="true">
                    <asp:ListItem Text="All Types" Value="" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="filter-select-wrap wrap-status">
                <i class="fa-solid fa-toggle-on prefix-icon"></i>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Text="All Status" Value="" />
                    <asp:ListItem Text="Active" Value="Active" />
                    <asp:ListItem Text="Inactive" Value="Inactive" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="filter-actions">
                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn-filter-search" CausesValidation="false">
                    <i class="fa-solid fa-magnifying-glass"></i> Search
                </asp:LinkButton>
                <asp:LinkButton ID="btnClearFilters" runat="server" CssClass="btn-filter-clear" CausesValidation="false">
                    <i class="fa-solid fa-xmark"></i> Clear Filters
                </asp:LinkButton>
            </div>
        </div>

        <!-- Internships List -->
        <div class="list-card">
            <div class="list-card-header">
                <h2 class="list-card-title">All Posted Internships</h2>
                <asp:Label ID="lblResultCount" runat="server" CssClass="result-count" />
            </div>

            <asp:DataList ID="DataListAdminInternships" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"
                CssClass="admin-internships-grid" OnItemCommand="DataListAdminInternships_ItemCommand">
                <ItemTemplate>
                    <div class="admin-internship-card">

                        <!-- Header: Logo, Title, Company, Status -->
                        <div class="admin-card-header">
                            <div class="admin-card-main">
                                <asp:Image ID="imgCompanyLogo" runat="server" CssClass="admin-company-logo-avatar"
                                    ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>'
                                    onerror="this.onerror=null; this.src='../CompanyUploads/default-company.png';" />
                                <div class="admin-card-title-wrap">
                                    <h3 class="admin-card-title" title='<%# Eval("InternshipTitle") %>'>
                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("InternshipTitle") %>' />
                                    </h3>
                                    <div class="admin-company-name" title='<%# Eval("c_company") %>'>
                                        <i class="fa-solid fa-building"></i>
                                        <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>' />
                                    </div>
                                </div>
                            </div>
                            <div class="admin-card-status">
                                <%# IsInternshipActive(Eval("Status"))
                                    ? "<span class='status-badge-active'><i class='fa-solid fa-circle-check'></i> Active</span>"
                                    : "<span class='status-badge-inactive'><i class='fa-solid fa-circle-xmark'></i> Inactive</span>" %>
                            </div>
                        </div>

                        <!-- Info List -->
                        <div class="admin-info-list">
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-location-dot"></i> Location:</span>
                                <span class="admin-info-val"><asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-clock"></i> Duration:</span>
                                <span class="admin-info-val"><asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-tag"></i> Domain:</span>
                                <span class="admin-info-val"><asp:Label ID="lblDomain" runat="server" Text='<%# Eval("InternshipDomain") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-laptop-code"></i> Work Mode:</span>
                                <span class="admin-info-val"><asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-money-bill-wave"></i> Stipend:</span>
                                <span class="admin-info-val stipend"><%# Eval("StipendAmount") %></span>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="admin-card-actions">
                            <asp:LinkButton ID="btnView" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("Id") %>'
                                CssClass="admin-btn-action admin-btn-primary" ToolTip="View full internship details">
                                <i class="fa-solid fa-eye"></i> View
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnToggleStatus" runat="server" CommandName="cmd_toggle_status"
                                CommandArgument='<%# Eval("Id") + "|" + (Eval("Status") != null ? Eval("Status").ToString() : "Active") %>'
                                CssClass='<%# IsInternshipActive(Eval("Status")) ? "admin-btn-action admin-btn-status-active" : "admin-btn-action admin-btn-status-inactive" %>'>
                                <%# IsInternshipActive(Eval("Status"))
                                    ? "<i class='fa-solid fa-toggle-on toggle-icon'></i> Active"
                                    : "<i class='fa-solid fa-toggle-off toggle-icon'></i> Inactive" %>
                            </asp:LinkButton>

                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="cmd_delete" CommandArgument='<%# Eval("Id") %>'
                                CssClass="admin-btn-action admin-btn-danger" ToolTip="Delete this internship">
                                <i class="fa-solid fa-trash"></i> Delete
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>

            <!-- Empty State -->
            <div id="pnlNoInternships" runat="server" visible="false">
                <div class="empty-state-box-admin">
                    <div class="empty-state-icon"><i class="fas fa-briefcase"></i></div>
                    <h3 class="empty-state-title">No Internships Found</h3>
                    <p class="empty-state-text">There are currently no internship postings available.</p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
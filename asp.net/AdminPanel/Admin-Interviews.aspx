<%@ Page Title="Interview Management" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-interviews.aspx.cs" Inherits="asp.net.css.admin_interviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Page header */
        .page-header { margin-bottom: 24px; }
        .page-title { margin: 0 0 4px; font-size: 24px; font-weight: 700; color: #0f172a; }
        .page-subtitle { margin: 0; font-size: 14px; color: #64748b; }

        /* Stats */
        .iv-stats { display: flex; flex-wrap: wrap; gap: 16px; margin-bottom: 24px; }
        .iv-stat-card {
            display: flex;
            align-items: center;
            gap: 16px;
            flex: 1;
            min-width: 200px;
            padding: 20px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0,0,0,.02);
        }
        .iv-stat-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 48px;
            height: 48px;
            font-size: 20px;
            border-radius: 10px;
        }
        .iv-stat-icon.blue   { background: #eff6ff; color: #2563eb; }
        .iv-stat-icon.yellow { background: #fefce8; color: #ca8a04; }
        .iv-stat-icon.green  { background: #f0fdf4; color: #16a34a; }
        .iv-stat-icon.red    { background: #fef2f2; color: #dc2626; }
        .iv-stat-value { font-size: 22px; font-weight: 700; color: #0f172a; }
        .iv-stat-label { font-size: 13px; color: #64748b; }

        /* Filter bar */
        .iv-filter-bar {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 14px;
            margin-bottom: 24px;
            padding: 18px 24px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
        }
        .iv-search-wrap { position: relative; flex: 1; min-width: 280px; }
        .iv-search-wrap .search-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 14px;
            color: #94a3b8;
        }
        .iv-search-wrap input {
            width: 100%;
            padding: 10px 14px 10px 38px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            color: #1e293b;
            outline: none;
        }
        .iv-select-wrap { position: relative; min-width: 180px; }
        .iv-select-wrap select {
            width: 100%;
            padding: 10px 36px 10px 14px;
            background: #fff;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            color: #1e293b;
            appearance: none;
            cursor: pointer;
            outline: none;
        }
        .iv-select-wrap .chevron-icon {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 12px;
            color: #94a3b8;
            pointer-events: none;
        }
        .iv-filter-actions { display: flex; align-items: center; gap: 8px; }
        .btn-filter-search,
        .btn-filter-clear {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            font-size: 13.5px;
            font-weight: 600;
            border-radius: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: all .15s ease;
        }
        .btn-filter-search { padding: 10px 20px; background: #2563eb; color: #fff; border: none; }
        .btn-filter-clear { padding: 10px 18px; background: #f1f5f9; color: #475569; border: 1px solid #e2e8f0; }
        .btn-filter-clear:hover { background: #e2e8f0; color: #0f172a; }

        /* Cards grid */
        .iv-list { margin-bottom: 24px; }
        .admin-interviews-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(330px, 1fr));
            gap: 22px;
            width: 100%;
        }
        .admin-interview-card {
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 20px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(15,23,42,.04);
            transition: all .25s ease;
        }
        .admin-interview-card:hover {
            transform: translateY(-3px);
            border-color: #cbd5e1;
            box-shadow: 0 10px 24px rgba(37,99,235,.08);
        }

        .admin-card-header { display: flex; align-items: center; gap: 14px; margin-bottom: 16px; }
        .admin-company-logo-avatar {
            flex-shrink: 0;
            width: 52px;
            height: 52px;
            border: 2px solid #e2e8f0;
            border-radius: 50% !important;
            overflow: hidden !important;
            object-fit: cover;
            background: #f8fafc;
        }
        .admin-card-title-wrap { display: flex; flex-direction: column; gap: 3px; flex: 1; overflow: hidden; }
        .admin-card-title,
        .admin-company-name { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .admin-card-title { margin: 0; font-size: 16px; font-weight: 700; line-height: 1.3; color: #0f172a; }
        .admin-company-name {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 13.5px;
            font-weight: 600;
            color: #2563eb;
        }
        .admin-company-name i { font-size: 11px; }

        /* Info list */
        .admin-info-list {
            display: flex;
            flex-direction: column;
            gap: 9px;
            padding: 14px 16px;
            background: #f8fafc;
            border: 1px solid #f1f5f9;
            border-radius: 12px;
            font-size: 13px;
            color: #334155;
        }
        .admin-info-row { display: flex; align-items: center; justify-content: space-between; gap: 10px; }
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

        /* Status Badges */
        .status-completed,
        .status-scheduled,
        .status-cancelled {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 700;
            white-space: nowrap;
        }
        .status-completed {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        .status-scheduled {
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }
        .status-cancelled {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0;">

        <!-- Header -->
        <div class="page-header">
            <h1 class="page-title">Interviews</h1>
            <p class="page-subtitle">Monitor and manage student interview schedules across companies.</p>
        </div>

        <asp:Label ID="lblMsg" runat="server" Visible="false" />

        <!-- Stats -->
        <div class="iv-stats">
            <div class="iv-stat-card">
                <div class="iv-stat-icon blue"><i class="fa-solid fa-calendar-days"></i></div>
                <div>
                    <div class="iv-stat-value"><asp:Label ID="lblTotalInterviews" runat="server" /></div>
                    <div class="iv-stat-label">Total Interviews</div>
                </div>
            </div>
            <div class="iv-stat-card">
                <div class="iv-stat-icon yellow"><i class="fa-solid fa-clock"></i></div>
                <div>
                    <div class="iv-stat-value"><asp:Label ID="lblScheduled" runat="server" /></div>
                    <div class="iv-stat-label">Scheduled</div>
                </div>
            </div>
            <div class="iv-stat-card">
                <div class="iv-stat-icon green"><i class="fa-solid fa-circle-check"></i></div>
                <div>
                    <div class="iv-stat-value"><asp:Label ID="lblCompleted" runat="server" /></div>
                    <div class="iv-stat-label">Completed</div>
                </div>
            </div>
            <div class="iv-stat-card">
                <div class="iv-stat-icon red"><i class="fa-solid fa-circle-xmark"></i></div>
                <div>
                    <div class="iv-stat-value"><asp:Label ID="lblCancelled" runat="server" /></div>
                    <div class="iv-stat-label">Cancelled</div>
                </div>
            </div>
        </div>

        <!-- Filter Bar -->
        <div class="iv-filter-bar">
            <div class="iv-search-wrap">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by candidate, email, internship or company..." />
            </div>

            <div class="iv-select-wrap">
                <asp:DropDownList ID="ddlStatusFilter" runat="server">
                    <asp:ListItem Text="All Status" Value="" />
                    <asp:ListItem Text="Scheduled" Value="Scheduled" />
                    <asp:ListItem Text="Completed" Value="Completed" />
                    <asp:ListItem Text="Cancelled" Value="Cancelled" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="iv-filter-actions">
                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn-filter-search" CausesValidation="false">
                    <i class="fa-solid fa-magnifying-glass"></i> Search
                </asp:LinkButton>
                <asp:LinkButton ID="btnClearFilters" runat="server" CssClass="btn-filter-clear" CausesValidation="false">
                    <i class="fa-solid fa-xmark"></i> Clear Filters
                </asp:LinkButton>
            </div>
        </div>

        <!-- Interviews List -->
        <div class="iv-list">
            <asp:DataList ID="dlInterviews" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="admin-interviews-grid">
                <ItemTemplate>
                    <div class="admin-interview-card">

                        <!-- Header: Logo, Title, Company -->
                        <div class="admin-card-header">
                            <asp:Image ID="imgLogo" runat="server" CssClass="admin-company-logo-avatar"
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

                        <!-- Info List -->
                        <div class="admin-info-list">
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-user"></i> Candidate:</span>
                                <span class="admin-info-val"><asp:Label ID="lblCandidate" runat="server" Text='<%# Eval("FullName") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-envelope"></i> Email:</span>
                                <span class="admin-info-val" title='<%# Eval("StudentEmail") %>'><asp:Label ID="lblEmail" runat="server" Text='<%# Eval("StudentEmail") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-calendar-days"></i> Date:</span>
                                <span class="admin-info-val"><asp:Label ID="lblDate" runat="server" Text='<%# Eval("InterviewDate", "{0:dd MMM yyyy}") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-clock"></i> Time:</span>
                                <span class="admin-info-val"><asp:Label ID="lblTime" runat="server" Text='<%# Eval("InterviewTime") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-laptop-code"></i> Type:</span>
                                <span class="admin-info-val"><asp:Label ID="lblType" runat="server" Text='<%# Eval("InterviewType") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-circle-info"></i> Status:</span>
                                <span class="admin-info-val"><asp:Label ID="lblStatus" runat="server" Text='<%# GetStatusBadge(Eval("Status")) %>' /></span>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </div>
</asp:Content>
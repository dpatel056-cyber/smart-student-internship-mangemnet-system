<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-dashboard.aspx.cs" Inherits="asp.net.admin_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="../js/admin-dashboard-charts.js" defer></script>
    <style>
        /* ===== LAYOUT GRIDS ===== */
        .dash-analytics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 24px;
            margin-bottom: 24px;
        }

        .dash-bottom-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 20px;
            margin-bottom: 24px;
        }

        /* ===== CARDS ===== */
        .dash-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            padding: 24px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
            display: flex;
            flex-direction: column;
        }

        .dash-card-full {
            display: block;
            margin-bottom: 24px;
            width: 100%;
        }

        .dash-card-sm {
            border-radius: 14px;
            padding: 18px 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
        }

        /* ===== CARD HEADER ===== */
        .dash-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .dash-card-header-tight {
            margin-bottom: 4px;
        }

        .dash-card-header-sm {
            margin-bottom: 2px;
        }

        .dash-card-title {
            font-size: 17px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .dash-card-title-sm {
            font-size: 15px;
            gap: 8px;
        }

        .dash-icon-blue {
            color: #2563eb;
        }

        .dash-icon-amber {
            color: #f59e0b;
        }

        .dash-link {
            font-size: 13px;
            font-weight: 600;
            color: #2563eb;
            text-decoration: none;
        }

        .dash-link-sm {
            font-size: 12px;
        }

        .dash-link-icon {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

            .dash-link-icon i {
                font-size: 11px;
            }

        .dash-subtitle {
            font-size: 13px;
            color: #64748b;
            margin: 0 0 18px 0;
        }

        .dash-subtitle-sm {
            font-size: 12px;
            margin: 0 0 10px 0;
        }

        /* ===== CHART ===== */
        .dash-chart-wrap {
            position: relative;
            height: 260px;
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: auto 0;
        }

        /* ===== APPLICATION STATUS ROWS ===== */
        .dash-status-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            justify-content: center;
            flex: 1;
        }

        .dash-status-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 13px 18px;
            border-radius: 12px;
            background: var(--st-bg);
            border: 1px solid var(--st-border);
        }

        .dash-status-left {
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 600;
            font-size: 14px;
            color: var(--st-text);
        }

        .dash-status-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            background: var(--st-pill-bg);
            color: var(--st-pill-text);
        }

        .dash-status-count {
            font-size: 18px;
            font-weight: 700;
            color: var(--st-text);
        }

        .dash-status-selected {
            --st-bg: #f0fdf4;
            --st-border: #bbf7d0;
            --st-text: #15803d;
            --st-pill-bg: #dcfce7;
            --st-pill-text: #16a34a;
        }

        .dash-status-shortlisted {
            --st-bg: #eff6ff;
            --st-border: #bfdbfe;
            --st-text: #1e40af;
            --st-pill-bg: #dbeafe;
            --st-pill-text: #2563eb;
        }

        .dash-status-pending {
            --st-bg: #fefce8;
            --st-border: #fef08a;
            --st-text: #854d0e;
            --st-pill-bg: #fef9c3;
            --st-pill-text: #ca8a04;
        }

        .dash-status-rejected {
            --st-bg: #fef2f2;
            --st-border: #fecaca;
            --st-text: #991b1b;
            --st-pill-bg: #fee2e2;
            --st-pill-text: #dc2626;
        }

        /* ===== RECENT APPLICATIONS TABLE ===== */
        .dash-table-box {
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            overflow: hidden;
            background: #ffffff;
        }

        .dash-table-scroll {
            overflow-x: auto;
            width: 100%;
        }

        .dash-grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 0;
        }

            .dash-grid th {
                background: #f8fafc;
                font-weight: 700;
                color: #475569;
                height: 45px;
                padding: 1rem;
                border: 1px solid #e2e8f0;
            }

            .dash-grid td {
                height: 56px;
                padding: 1rem;
                border: 1px solid #f1f5f9;
            }

            .dash-grid tr:nth-child(even) td {
                background: #ffffff;
            }

            .dash-grid th:nth-child(1),
            .dash-grid th:nth-child(2) {
                width: 20%;
            }

            .dash-grid th:nth-child(3) {
                width: 22%;
            }

            .dash-grid th:nth-child(4) {
                width: 16%;
            }

            .dash-grid th:nth-child(5),
            .dash-grid th:nth-child(6) {
                width: 11%;
            }

        /* ===== TABLE CELLS ===== */
        .dash-cell {
            display: flex;
            align-items: center;
            gap: 7px;
            color: #64748b;
            font-size: 13px;
        }

            .dash-cell i {
                color: #94a3b8;
                font-size: 12px;
            }

        .dash-cell-student {
            gap: 12px;
        }

        .dash-cell-internship {
            gap: 8px;
        }

            .dash-cell-internship i {
                color: #2563eb;
                font-size: 13px;
            }

        .dash-cell-company {
            color: #334155;
            font-size: 13.5px;
            font-weight: 500;
        }

        .dash-cell-date {
            gap: 6px;
        }

        .dash-student-name {
            font-weight: 700;
            color: #0f172a;
            font-size: 13.5px;
        }

        .dash-internship-title {
            font-weight: 600;
            color: #1e293b;
            font-size: 13.5px;
        }

        /* ===== STATUS BADGES (TABLE) ===== */
        .status-pending,
        .status-shortlisted,
        .status-selected,
        .status-rejected {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            white-space: nowrap;
            line-height: 1.2;
        }

        .status-pending {
            background: #fef3c7;
            color: #b45309;
            border: 1px solid #fde68a;
        }

        .status-shortlisted {
            background: #dbeafe;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }

        .status-selected {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }

        .status-rejected {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        /* ===== EMPTY STATES ===== */
        .dash-empty {
            padding: 32px;
            text-align: center;
            color: #64748b;
            font-size: 14px;
        }

            .dash-empty i {
                font-size: 28px;
                color: #cbd5e1;
                display: block;
                margin-bottom: 8px;
            }

        .dash-empty-sm {
            padding: 16px;
            font-size: 13px;
        }

        /* ===== RECENT COMPANIES ===== */
        .dash-company-list {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .dash-company-item {
            padding: 7px 12px;
            border-radius: 10px;
            background: #f8fafc;
            border: 1px solid #f1f5f9;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .dash-company-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .dash-company-logo {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid #e2e8f0;
            flex-shrink: 0;
        }

        .dash-company-name {
            font-weight: 600;
            font-size: 13px;
            color: #0f172a;
            display: block;
            line-height: 1.2;
        }

        .dash-company-meta {
            font-size: 11px;
            color: #64748b;
            display: block;
        }

        .dash-company-view {
            font-size: 11px;
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 3px;
        }

            .dash-company-view i {
                font-size: 9px;
            }

        /* ===== QUICK ACTIONS ===== */
        .dash-actions {
            display: flex;
            flex-direction: column;
            gap: 6px;
            flex: 1;
            justify-content: center;
        }

        .dash-action {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 7px 12px;
            border-radius: 10px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            text-decoration: none;
            transition: all 0.2s ease;
        }

            .dash-action:hover {
                background: var(--ac-hover-bg);
                border-color: var(--ac-hover-border);
            }

        .dash-action-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .dash-action-icon {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            background: var(--ac-bg);
            color: var(--ac-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            flex-shrink: 0;
        }

        .dash-action-title {
            font-weight: 600;
            font-size: 13px;
            color: #0f172a;
            line-height: 1.2;
        }

        .dash-action-desc {
            font-size: 11px;
            color: #64748b;
        }

        .dash-action-arrow {
            width: 26px;
            height: 26px;
            border-radius: 50%;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--ac-color);
            font-size: 10px;
        }

        .dash-action-purple {
            --ac-bg: #ede9fe;
            --ac-color: #7c3aed;
            --ac-hover-bg: #f5f3ff;
            --ac-hover-border: #c4b5fd;
        }

        .dash-action-blue {
            --ac-bg: #dbeafe;
            --ac-color: #2563eb;
            --ac-hover-bg: #eff6ff;
            --ac-hover-border: #93c5fd;
        }

        .dash-action-green {
            --ac-bg: #dcfce7;
            --ac-color: #16a34a;
            --ac-hover-bg: #f0fdf4;
            --ac-hover-border: #86efac;
        }

        .dash-action-amber {
            --ac-bg: #fef3c7;
            --ac-color: #d97706;
            --ac-hover-bg: #fffbeb;
            --ac-hover-border: #fde68a;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sims-dashboard">

        <!-- ===================== 1. WELCOME SECTION ===================== -->
        <div class="sims-dashboard-header">
            <div class="sims-dashboard-header-text">
                <h1 class="sims-dashboard-title">Dashboard</h1>
                <p class="sims-dashboard-subtitle">Welcome back, Admin. Here's what's happening with your internship management system.</p>
            </div>
        </div>

        <!-- ===================== 2. TOP KPI STAT CARDS (4x2 GRID) ===================== -->
        <div class="sims-stat-grid-v2">

            <!-- Card 1: Total Students -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-purple">
                    <i class="fa-solid fa-user-graduate"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Total Students</span>
                    <span class="sims-stat-num-v2">
                        <asp:Label ID="lblTotalStudents" runat="server"></asp:Label></span>
                </div>
            </div>

            <!-- Card 2: Total Companies -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-blue">
                    <i class="fa-solid fa-building"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Total Companies</span>
                    <span class="sims-stat-num-v2">
                        <asp:Label ID="lblTotalCompanies" runat="server"></asp:Label></span>
                </div>
            </div>

            <!-- Card 3: Total Internships -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-green">
                    <i class="fa-solid fa-briefcase"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Total Internships</span>
                    <span class="sims-stat-num-v2">
                        <asp:Label ID="lblTotalInternships" runat="server"></asp:Label></span>
                </div>
            </div>

            <!-- Card 4: Total Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-orange">
                    <i class="fa-solid fa-file-lines"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Total Applications</span>
                    <span class="sims-stat-num-v2">
                        <asp:Label ID="lblTotalApplications" runat="server"></asp:Label></span>
                </div>
            </div>

            <!-- Card 5: Pending Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-yellow">
                    <i class="fa-solid fa-hourglass-half"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Pending Applications</span>
                    <span class="sims-stat-num-v2">
                        <asp:Label ID="lblPendingApps" runat="server"></asp:Label></span>
                </div>
            </div>

            <!-- Card 6: Upcoming Interviews -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-purple-light">
                    <i class="fa-solid fa-calendar-days"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Upcoming Interviews</span>
                    <span class="sims-stat-num-v2">
                        <asp:Label ID="lblUpcomingInterviews" runat="server"></asp:Label></span>
                </div>
            </div>

            <!-- Card 7: Certificates Issued -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-teal">
                    <i class="fa-solid fa-certificate"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Certificates Issued</span>
                    <span class="sims-stat-num-v2">
                        <asp:Label ID="lblCertificatesIssued" runat="server"></asp:Label></span>
                </div>
            </div>

            <!-- Card 8: Total Inquiries -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-pink">
                    <i class="fa-solid fa-comments"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Total Inquiries</span>
                    <span class="sims-stat-num-v2">
                        <asp:Label ID="lblTotalFeedback" runat="server"></asp:Label></span>
                </div>
            </div>

        </div>

        <!-- ===================== 3. APPLICATION ANALYTICS (2 CARDS) ===================== -->
        <div class="dash-analytics-grid">

            <!-- LEFT: APPLICATION OVERVIEW (DOUGHNUT CHART) -->
            <div class="dash-card">
                <div class="dash-card-header">
                    <h2 class="dash-card-title">
                        <i class="fa-solid fa-chart-pie dash-icon-blue"></i>Application Overview
                    </h2>
                </div>
                <div class="dash-chart-wrap">
                    <canvas id="adminApplicationPieChart"
                        data-pending='<%= totalPending %>'
                        data-shortlisted='<%= totalShortlisted %>'
                        data-selected='<%= totalSelected %>'
                        data-rejected='<%= totalRejected %>'></canvas>
                </div>
            </div>

            <!-- RIGHT: APPLICATION STATUS BREAKDOWN -->
            <div class="dash-card">
                <div class="dash-card-header">
                    <h2 class="dash-card-title">
                        <i class="fa-solid fa-list-check dash-icon-blue"></i>Application Status
                    </h2>
                    <asp:HyperLink ID="lnkStatusViewAll" runat="server" NavigateUrl="admin-student-applications.aspx" CssClass="dash-link">View All &rarr;</asp:HyperLink>
                </div>
                <div class="dash-status-list">

                    <!-- Selected -->
                    <div class="dash-status-row dash-status-selected">
                        <div class="dash-status-left">
                            <span class="dash-status-pill"><i class="fa-solid fa-check"></i> Selected</span>
                            <span>Selected Candidates</span>
                        </div>
                        <span class="dash-status-count">
                            <asp:Label ID="lblStatusSelected" runat="server"></asp:Label></span>
                    </div>

                    <!-- Shortlisted -->
                    <div class="dash-status-row dash-status-shortlisted">
                        <div class="dash-status-left">
                            <span class="dash-status-pill"><i class="fa-solid fa-list-check"></i> Shortlisted</span>
                            <span>Shortlisted for Review</span>
                        </div>
                        <span class="dash-status-count">
                            <asp:Label ID="lblStatusShortlisted" runat="server"></asp:Label></span>
                    </div>

                    <!-- Pending -->
                    <div class="dash-status-row dash-status-pending">
                        <div class="dash-status-left">
                            <span class="dash-status-pill"><i class="fa-solid fa-clock"></i> Pending</span>
                            <span>Applications Under Review</span>
                        </div>
                        <span class="dash-status-count">
                            <asp:Label ID="lblStatusPending" runat="server"></asp:Label></span>
                    </div>

                    <!-- Rejected -->
                    <div class="dash-status-row dash-status-rejected">
                        <div class="dash-status-left">
                            <span class="dash-status-pill"><i class="fa-solid fa-xmark"></i> Rejected</span>
                            <span>Rejected Applications</span>
                        </div>
                        <span class="dash-status-count">
                            <asp:Label ID="lblStatusRejected" runat="server"></asp:Label></span>
                    </div>

                </div>
            </div>

        </div>

        <!-- ===================== 4. RECENT APPLICATIONS (FULL WIDTH) ===================== -->
        <div class="dash-card dash-card-full">
            <div class="dash-card-header dash-card-header-tight">
                <h2 class="dash-card-title">
                    <i class="fa-solid fa-file-lines dash-icon-blue"></i>Recent Applications
                </h2>
                <asp:HyperLink ID="lnkApplicationsViewAll" runat="server" NavigateUrl="admin-student-applications.aspx" CssClass="dash-link dash-link-icon">View All Applications <i class="fa-solid fa-arrow-right"></i></asp:HyperLink>
            </div>
            <p class="dash-subtitle">Latest internship applications submitted by students</p>
            <div class="dash-table-box">
                <div class="dash-table-scroll">
                    <asp:GridView ID="gvRecentApplications" runat="server" AutoGenerateColumns="False" CssClass="dash-grid" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%">
                        <Columns>
                            <asp:TemplateField HeaderText="STUDENT">
                                <ItemTemplate>
                                    <div class="dash-cell dash-cell-student">
                                        <asp:Label ID="lblStudentName" runat="server" Text='<%# Eval("FullName") %>' CssClass="dash-student-name"></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="EMAIL">
                                <ItemTemplate>
                                    <div class="dash-cell">
                                        <i class="fa-regular fa-envelope"></i>
                                        <asp:Label ID="lblStudentEmail" runat="server" Text='<%# Eval("StudentEmail") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="INTERNSHIP">
                                <ItemTemplate>
                                    <div class="dash-cell dash-cell-internship">
                                        <i class="fa-solid fa-laptop-code"></i>
                                        <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>' CssClass="dash-internship-title"></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="COMPANY">
                                <ItemTemplate>
                                    <div class="dash-cell dash-cell-company">
                                        <i class="fa-solid fa-building"></i>
                                        <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="APPLIED DATE">
                                <ItemTemplate>
                                    <div class="dash-cell dash-cell-date">
                                        <i class="fa-regular fa-calendar"></i>
                                        <asp:Label ID="lblAppliedDate" runat="server" Text='<%# Convert.ToDateTime(Eval("AppliedDate")).ToString("dd MMM yyyy") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="STATUS">
                                <ItemTemplate>
                                    <%# GetStatusBadge(Eval("Status")) %>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                        <EmptyDataTemplate>
                            <div class="dash-empty">
                                <i class="fa-regular fa-folder-open"></i>
                                No recent applications found.
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- ===================== 5. RECENT COMPANIES (50%) & QUICK ACTIONS (50%) ===================== -->
        <div class="dash-bottom-grid">

            <!-- LEFT: RECENT COMPANIES -->
            <div class="dash-card dash-card-sm">
                <div class="dash-card-header dash-card-header-sm">
                    <h2 class="dash-card-title dash-card-title-sm">
                        <i class="fa-solid fa-building dash-icon-blue"></i>Recent Companies
                    </h2>
                    <asp:HyperLink ID="lnkCompaniesViewAll" runat="server" NavigateUrl="admin-companies.aspx" CssClass="dash-link dash-link-sm">View All &rarr;</asp:HyperLink>
                </div>
                <p class="dash-subtitle dash-subtitle-sm">Newly registered companies</p>
                <div class="dash-company-list">
                    <asp:GridView ID="gvRecentCompanies" runat="server" AutoGenerateColumns="False" GridLines="None" ShowHeader="false" Width="100%">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="dash-company-item">
                                        <div class="dash-company-left">
                                            <asp:Image ID="imgCompanyLogo" runat="server" ImageUrl='<%# GetCompanyLogoUrl(Eval("c_logo")) %>' CssClass="dash-company-logo" />
                                            <div>
                                                <span class="dash-company-name">
                                                    <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                                </span>
                                                <span class="dash-company-meta">
                                                    <asp:Label ID="lblCompanyIndustry" runat="server" Text='<%# Eval("c_industry") %>'></asp:Label>
                                                    &middot;
                                                    <asp:Label ID="lblCompanyLocation" runat="server" Text='<%# Eval("c_location") %>'></asp:Label>
                                                </span>
                                            </div>
                                        </div>
                                        <asp:HyperLink ID="lnkViewCompany" runat="server" NavigateUrl='<%# "viewCompanyDetails.aspx?id=" + Eval("CompanyId") %>' CssClass="dash-company-view">View <i class="fa-solid fa-chevron-right"></i></asp:HyperLink>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="dash-empty dash-empty-sm">No recent companies found.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>

            <!-- RIGHT: QUICK ACTIONS -->
            <div class="dash-card dash-card-sm">
                <div class="dash-card-header dash-card-header-sm">
                    <h2 class="dash-card-title dash-card-title-sm">
                        <i class="fa-solid fa-bolt dash-icon-amber"></i>Quick Actions
                    </h2>
                </div>
                <p class="dash-subtitle dash-subtitle-sm">Fast access to management and master records</p>
                <div class="dash-actions">

                    <!-- Action 1: All Students -->
                    <asp:HyperLink ID="lnkAllStudents" runat="server" NavigateUrl="admin-students.aspx" CssClass="dash-action dash-action-purple">
                        <div class="dash-action-left">
                            <div class="dash-action-icon"><i class="fa-solid fa-user-graduate"></i></div>
                            <div>
                                <div class="dash-action-title">All Students</div>
                                <div class="dash-action-desc">Manage profiles, search & enrollments</div>
                            </div>
                        </div>
                        <div class="dash-action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                    </asp:HyperLink>

                    <!-- Action 2: All Companies -->
                    <asp:HyperLink ID="lnkAllCompanies" runat="server" NavigateUrl="admin-companies.aspx" CssClass="dash-action dash-action-blue">
                        <div class="dash-action-left">
                            <div class="dash-action-icon"><i class="fa-solid fa-building"></i></div>
                            <div>
                                <div class="dash-action-title">All Companies</div>
                                <div class="dash-action-desc">Browse employers & verification</div>
                            </div>
                        </div>
                        <div class="dash-action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                    </asp:HyperLink>

                    <!-- Action 3: All Internships -->
                    <asp:HyperLink ID="lnkAllInternships" runat="server" NavigateUrl="admin-internships.aspx" CssClass="dash-action dash-action-green">
                        <div class="dash-action-left">
                            <div class="dash-action-icon"><i class="fa-solid fa-briefcase"></i></div>
                            <div>
                                <div class="dash-action-title">All Internships</div>
                                <div class="dash-action-desc">View openings & active listings</div>
                            </div>
                        </div>
                        <div class="dash-action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                    </asp:HyperLink>

                    <!-- Action 4: All Applications -->
                    <asp:HyperLink ID="lnkAllApplications" runat="server" NavigateUrl="admin-student-applications.aspx" CssClass="dash-action dash-action-amber">
                        <div class="dash-action-left">
                            <div class="dash-action-icon"><i class="fa-solid fa-file-signature"></i></div>
                            <div>
                                <div class="dash-action-title">All Applications</div>
                                <div class="dash-action-desc">Track student submissions & status</div>
                            </div>
                        </div>
                        <div class="dash-action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
                    </asp:HyperLink>

                </div>
            </div>

        </div>
    </div>

    <script>
        (function () {
            function renderDashboardCharts() {
                if (typeof Chart === "undefined") {
                    setTimeout(renderDashboardCharts, 100);
                    return;
                }
                var canvas = document.getElementById("adminApplicationPieChart");
                if (canvas) {
                    if (canvas._chartInstance) {
                        canvas._chartInstance.destroy();
                    }
                    var pendingCount = parseInt(canvas.getAttribute("data-pending") || "0", 10);
                    var shortlistedCount = parseInt(canvas.getAttribute("data-shortlisted") || "0", 10);
                    var selectedCount = parseInt(canvas.getAttribute("data-selected") || "0", 10);
                    var rejectedCount = parseInt(canvas.getAttribute("data-rejected") || "0", 10);
                    var total = pendingCount + shortlistedCount + selectedCount + rejectedCount;
                    var chartData = [selectedCount, shortlistedCount, pendingCount, rejectedCount];
                    var chartLabels = ["Selected", "Shortlisted", "Pending", "Rejected"];
                    var chartColors = [
                        "#16a34a", // Green (Selected)
                        "#2563eb", // Blue (Shortlisted)
                        "#ca8a04", // Yellow/Amber (Pending)
                        "#dc2626"  // Red (Rejected)
                    ];
                    if (total === 0) {
                        chartData = [1];
                        chartLabels = ["No Applications Yet"];
                        chartColors = ["#e2e8f0"];
                    }
                    var ctx = canvas.getContext("2d");
                    canvas._chartInstance = new Chart(ctx, {
                        type: "doughnut",
                        data: {
                            labels: chartLabels,
                            datasets: [{
                                data: chartData,
                                backgroundColor: chartColors,
                                borderWidth: 3,
                                borderColor: "#ffffff",
                                hoverOffset: total > 0 ? 6 : 0
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: "bottom",
                                    labels: {
                                        usePointStyle: true,
                                        pointStyle: "circle",
                                        padding: 14,
                                        font: {
                                            family: "'Inter', sans-serif",
                                            size: 12,
                                            weight: "600"
                                        },
                                        color: "#1e293b"
                                    }
                                },
                                tooltip: {
                                    enabled: total > 0,
                                    callbacks: {
                                        label: function (context) {
                                            var label = context.label || "";
                                            var value = context.parsed || 0;
                                            var percentage = total > 0 ? Math.round((value / total) * 100) : 0;
                                            return " " + label + ": " + value + " (" + percentage + "%)";
                                        }
                                    }
                                }
                            },
                            cutout: "68%"
                        }
                    });
                }
            }
            if (document.readyState === "loading") {
                document.addEventListener("DOMContentLoaded", renderDashboardCharts);
            } else {
                renderDashboardCharts();
            }
            window.addEventListener("load", renderDashboardCharts);
        })();
    </script>
</asp:Content>

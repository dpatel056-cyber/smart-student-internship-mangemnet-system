<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-dashboard.aspx.cs" Inherits="asp.net.admin_dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization"
    Namespace="System.Web.UI.DataVisualization.Charting"
    TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-dashboard.css" />
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
            <div class="dash-card">
                <div class="dash-card-header">
                    <h2 class="dash-card-title">
                        <i class="fa-solid fa-chart-pie dash-icon-blue"></i>
                        Application Overview
                    </h2>
                </div>

                <div class="dash-chart-wrap">
                    <asp:Chart ID="adminApplicationPieChart" runat="server"
                        Width="440px" Height="270px"
                        BackColor="White"
                        Palette="None"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">

                        <Series>
                            <asp:Series Name="Applications"
                                ChartType="Doughnut"
                                XValueMember="Status"
                                YValueMembers="Total"
                                IsValueShownAsLabel="true"
                                Font="Segoe UI, 9pt"
                                YValueType="Int32"
                                ChartArea="ApplicationArea"
                                Legend="ApplicationLegend">
                            </asp:Series>
                        </Series>

                        <ChartAreas>
                            <asp:ChartArea Name="ApplicationArea"
                                BackColor="White">
                            </asp:ChartArea>
                        </ChartAreas>

                        <Legends>
                            <asp:Legend Name="ApplicationLegend"
                                Docking="Right"
                                Alignment="Center"
                                BackColor="White"
                                Font="Segoe UI, 10px, style=Bold"
                                ForeColor="#334155">
                            </asp:Legend>
                        </Legends>
                    </asp:Chart>
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
                            <span class="dash-status-pill"><i class="fa-solid fa-check"></i>Selected</span>
                            <span>Selected Candidates</span>
                        </div>
                        <span class="dash-status-count">
                            <asp:Label ID="lblStatusSelected" runat="server"></asp:Label></span>
                    </div>

                    <!-- Shortlisted -->
                    <div class="dash-status-row dash-status-shortlisted">
                        <div class="dash-status-left">
                            <span class="dash-status-pill"><i class="fa-solid fa-list-check"></i>Shortlisted</span>
                            <span>Shortlisted for Review</span>
                        </div>
                        <span class="dash-status-count">
                            <asp:Label ID="lblStatusShortlisted" runat="server"></asp:Label></span>
                    </div>

                    <!-- Pending -->
                    <div class="dash-status-row dash-status-pending">
                        <div class="dash-status-left">
                            <span class="dash-status-pill"><i class="fa-solid fa-clock"></i>Pending</span>
                            <span>Applications Under Review</span>
                        </div>
                        <span class="dash-status-count">
                            <asp:Label ID="lblStatusPending" runat="server"></asp:Label></span>
                    </div>

                    <!-- Rejected -->
                    <div class="dash-status-row dash-status-rejected">
                        <div class="dash-status-left">
                            <span class="dash-status-pill"><i class="fa-solid fa-xmark"></i>Rejected</span>
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
                                        <asp:Label ID="lblAppliedDate" runat="server" Text='<%# Eval("AppliedDate", "{0:dd MMM yyyy}") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="STATUS">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server"
                                        Text='<%# GetStatusBadge(Eval("Status").ToString()) %>'>
                                    </asp:Label>
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
                                            <asp:Image ID="imgCompanyLogo" runat="server" ImageUrl='<%# Eval("c_logo") %>' CssClass="dash-company-logo" />
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

</asp:Content>

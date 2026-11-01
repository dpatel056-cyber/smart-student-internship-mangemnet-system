<%@ Page Title="Company Dashboard" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-dashboard.aspx.cs" Inherits="asp.net.Companydashboard" %>

<%@ Register Assembly="System.Web.DataVisualization"
    Namespace="System.Web.UI.DataVisualization.Charting"
    TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/company-dashboard.css") %>" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header -->
    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 16px; margin-bottom: 24px;">
        <div>
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Dashboard</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Overall stats, recent applicants, and application status overview.</p>
        </div>
        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
            <a href="<%= ResolveUrl("~/CompanyPanel/company-post-internship.aspx") %>" style="padding: 10px 18px; background: #2563eb; color: #fff; border-radius: 8px; font-size: 13.5px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 7px; transition: background 0.15s ease;">
                <i class="fa-solid fa-circle-plus"></i> Post Internship
            </a>
            <a href="<%= ResolveUrl("~/CompanyPanel/company-profile.aspx") %>" style="padding: 10px 18px; background: #ffffff; color: #334155; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 13.5px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 7px; transition: background 0.15s ease;">
                <i class="fa-solid fa-building"></i> View Profile
            </a>
        </div>
    </div>

    <!-- ===================== 1. TOP KPI STAT CARDS (2 ROWS OF 4 COLS = 8 CARDS) ===================== -->
    <div class="sims-stat-grid-v2">
        <!-- Card 1: Total Internships -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-blue">
                <i class="fa-solid fa-briefcase"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Total Internships</span>
                <span class="sims-stat-num-v2"><asp:Label ID="lblTotalInternships" runat="server"></asp:Label></span>
            </div>
        </div>

        <!-- Card 2: Active Internships -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-green">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Active Internships</span>
                <span class="sims-stat-num-v2"><asp:Label ID="lblActiveInternships" runat="server"></asp:Label></span>
            </div>
        </div>

        <!-- Card 3: Total Applications -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-purple">
                <i class="fa-solid fa-file-lines"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Total Applications</span>
                <span class="sims-stat-num-v2"><asp:Label ID="lblTotalApplications" runat="server"></asp:Label></span>
            </div>
        </div>

        <!-- Card 4: Shortlisted Students -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-orange">
                <i class="fa-solid fa-star"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Shortlisted</span>
                <span class="sims-stat-num-v2"><asp:Label ID="lblShortlistedCount" runat="server"></asp:Label></span>
            </div>
        </div>

        <!-- Card 5: Selected Students -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-teal">
                <i class="fa-solid fa-user-check"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Selected</span>
                <span class="sims-stat-num-v2"><asp:Label ID="lblSelectedCount" runat="server"></asp:Label></span>
            </div>
        </div>

        <!-- Card 6: Rejected Students -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-red">
                <i class="fa-solid fa-user-xmark"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Rejected</span>
                <span class="sims-stat-num-v2"><asp:Label ID="lblRejectedCount" runat="server"></asp:Label></span>
            </div>
        </div>

        <!-- Card 7: Interviews Scheduled -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-purple-light">
                <i class="fa-solid fa-calendar-check"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Interviews Scheduled</span>
                <span class="sims-stat-num-v2"><asp:Label ID="lblInterviewsCount" runat="server"></asp:Label></span>
            </div>
        </div>

        <!-- Card 8: Offer Letters Issued -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-yellow">
                <i class="fa-solid fa-file-signature"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Offers Issued</span>
                <span class="sims-stat-num-v2"><asp:Label ID="lblOffersCount" runat="server"></asp:Label></span>
            </div>
        </div>
    </div>

    <!-- ===================== 2. ANALYTICS CHARTS (APPLICATION STATUS + INTERVIEW STATUS IN 1 ROW 50% 50%) ===================== -->
    <div class="dash-analytics-grid">
        <!-- LEFT: APPLICATION STATUS OVERVIEW (DOUGHNUT CHART - 50%) -->
        <div class="dash-card">
            <div class="dash-card-header">
                <h2 class="dash-card-title">
                    <i class="fa-solid fa-chart-pie" style="color: #2563eb; font-size: 18px;"></i>
                    Application Status Overview
                </h2>
            </div>
            <div class="dash-chart-wrap">
                <asp:Chart ID="companyApplicationPieChart" runat="server"
                    Width="550px" Height="290px"
                    BackColor="White"
                    Palette="None"
                    AntiAliasing="All"
                    TextAntiAliasingQuality="High"
                    ImageType="Png"
                    RenderType="ImageTag">

                    <Series>
                        <asp:Series Name="Applications"
                            ChartType="Doughnut"
                            XValueMember="Status"
                            YValueMembers="Total"
                            IsValueShownAsLabel="false"
                            Font="Segoe UI, 10pt"
                            ChartArea="ApplicationArea"
                            Legend="ApplicationLegend"
                            CustomProperties="DoughnutRadius=62, PieLabelStyle=Disabled, PieStartAngle=270">
                        </asp:Series>
                    </Series>

                    <ChartAreas>
                        <asp:ChartArea Name="ApplicationArea" BackColor="White">
                            <Position Height="75" Width="94" X="3" Y="2" />
                        </asp:ChartArea>
                    </ChartAreas>

                    <Legends>
                        <asp:Legend Name="ApplicationLegend"
                            Docking="Bottom"
                            Alignment="Center"
                            BackColor="White"
                            Font="Segoe UI, 8.5pt, style=Bold"
                            ForeColor="#334155"
                            LegendStyle="Table"
                            TableStyle="Wide"
                            IsTextAutoFit="false">
                            <Position Height="20" Width="98" X="1" Y="78" />
                        </asp:Legend>
                    </Legends>
                </asp:Chart>
            </div>
        </div>

        <!-- RIGHT: INTERVIEW STATUS OVERVIEW (COLUMN CHART - 50%) -->
        <div class="dash-card">
            <div class="dash-card-header">
                <h2 class="dash-card-title">
                    <i class="fa-solid fa-chart-column" style="color: #7c3aed; font-size: 18px;"></i>
                    Interview Status Overview
                </h2>
            </div>
            <div class="dash-chart-wrap">
                <asp:Chart ID="companyInterviewBarChart" runat="server"
                    Width="550px" Height="290px"
                    BackColor="White"
                    Palette="None"
                    AntiAliasing="All"
                    TextAntiAliasingQuality="High"
                    ImageType="Png"
                    RenderType="ImageTag">

                    <Series>
                        <asp:Series Name="Interviews"
                            ChartType="Column"
                            XValueMember="Status"
                            YValueMembers="Total"
                            IsValueShownAsLabel="false"
                            Font="Segoe UI, 10pt, style=Bold"
                            ChartArea="InterviewArea"
                            CustomProperties="PointWidth=0.36, DrawSideBySide=True">
                        </asp:Series>
                    </Series>

                    <ChartAreas>
                        <asp:ChartArea Name="InterviewArea" BackColor="White">
                            <Position Height="85" Width="90" X="5" Y="5" />
                            <AxisX LineColor="#cbd5e1" Interval="1" IsLabelAutoFit="false">
                                <MajorGrid Enabled="false" />
                                <MajorTickMark Enabled="false" />
                                <LabelStyle Font="Segoe UI, 10pt, style=Bold" ForeColor="#475569" />
                            </AxisX>
                            <AxisY LineColor="Transparent" Interval="1" Minimum="0" IsLabelAutoFit="false">
                                <MajorGrid LineColor="#f1f5f9" LineWidth="1" />
                                <MajorTickMark Enabled="false" />
                                <LabelStyle Font="Segoe UI, 9.5pt" ForeColor="#94a3b8" />
                            </AxisY>
                        </asp:ChartArea>
                    </ChartAreas>
                </asp:Chart>
            </div>
        </div>
    </div>

    <!-- ===================== 3. RECENT APPLICATIONS (FULL WIDTH) ===================== -->
    <div class="co-panel" style="margin-bottom: 26px; width: 100%;">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-user-group" style="color: #2563eb; margin-right: 8px;"></i> Recent Applications</h3>
            <a href="<%= ResolveUrl("~/CompanyPanel/company-applicants.aspx") %>" style="display: inline-flex; align-items: center; gap: 6px; font-weight: 600;">
                View All <i class="fa-solid fa-arrow-right" style="font-size: 11px;"></i>
            </a>
        </div>
        <div style="overflow-x: auto; width: 100%;">
            <asp:GridView ID="gvRecentApps" runat="server" AutoGenerateColumns="False" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="Name" HeaderStyle-Width="20%">
                        <ItemTemplate>
                            <div class="co-applicant-cell">
                                <asp:Image ID="imgStudentPhoto" runat="server" CssClass="co-applicant-avatar" Width="36" Height="36" ImageUrl='<%# Eval("ProfilePhoto") %>' onerror="this.onerror=null;this.src='../student_images/default-avatar.png';" />
                                <asp:Label ID="lblFullName" runat="server" Style="font-weight: 700; color: #0f172a;" Text='<%# Eval("FullName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" HeaderStyle-Width="22%">
                        <ItemTemplate>
                            <asp:Label ID="lblStudentEmail" runat="server" Style="font-size: 13.5px; color: #475569;" Text='<%# Eval("StudentEmail") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Internship Title" HeaderStyle-Width="26%">
                        <ItemTemplate>
                            <asp:Label ID="lblInternshipTitle" runat="server" Style="font-weight: 600; color: #1e293b;" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date" HeaderStyle-Width="14%">
                        <ItemTemplate>
                            <asp:Label ID="lblAppliedDate" runat="server" Style="font-size: 13px; color: #64748b;" Text='<%# Eval("AppliedDate", "{0:dd MMM yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" HeaderStyle-Width="10%">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# GetStatusBadge(Eval("Status")) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" HeaderStyle-Width="8%" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                        <ItemTemplate>
                            <a href='<%= ResolveUrl("~/CompanyPanel/company-student-details.aspx") %>?id=<%# Eval("StudentId") %>&appId=<%# Eval("ApplicationId") %>'
                                style="padding: 6px 14px; font-size: 12.5px; text-decoration: none; border-radius: 8px; background: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe; font-weight: 600; display: inline-flex; align-items: center; gap: 5px; transition: all 0.15s ease;">
                                <i class="fa-solid fa-eye"></i> View
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoApps" runat="server" Visible="false">
                <div style="text-align:center; padding:30px 10px;">
                    <p style="font-size:13.5px; color:#64748b; margin:0;">No applications received yet.</p>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>

    <!-- ===================== 4. QUICK ACTIONS (LAST IN DASHBOARD, 1 ROW 5 COLS) ===================== -->
    <div class="dash-card dash-card-full" style="margin-bottom: 26px;">
        <div class="dash-card-header">
            <h2 class="dash-card-title">
                <i class="fa-solid fa-bolt" style="color: #f59e0b; font-size: 18px;"></i>
                Quick Actions
            </h2>
        </div>
        <p class="dash-subtitle" style="font-size: 13px; color: #64748b; margin: 0 0 16px 0;">Fast access to recruitment and management workflows</p>
        <div class="dash-quick-actions-row">
            <!-- 1. Post New Internship -->
            <a href="<%= ResolveUrl("~/CompanyPanel/company-post-internship.aspx") %>" class="dash-action dash-action-blue">
                <div class="dash-action-left">
                    <div class="dash-action-icon"><i class="fa-solid fa-circle-plus"></i></div>
                    <div>
                        <div class="dash-action-title">Post New Internship</div>
                        <div class="dash-action-desc">Create and publish new opportunities</div>
                    </div>
                </div>
                <div class="dash-action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
            </a>

            <!-- 2. Review Applicants -->
            <a href="<%= ResolveUrl("~/CompanyPanel/company-applicants.aspx") %>" class="dash-action dash-action-purple">
                <div class="dash-action-left">
                    <div class="dash-action-icon"><i class="fa-solid fa-users"></i></div>
                    <div>
                        <div class="dash-action-title">Review Applicants</div>
                        <div class="dash-action-desc">Shortlist, select or reject candidates</div>
                    </div>
                </div>
                <div class="dash-action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
            </a>

            <!-- 3. Manage Internships -->
            <a href="<%= ResolveUrl("~/CompanyPanel/company-internships.aspx") %>" class="dash-action dash-action-green">
                <div class="dash-action-left">
                    <div class="dash-action-icon"><i class="fa-solid fa-briefcase"></i></div>
                    <div>
                        <div class="dash-action-title">Manage Internships</div>
                        <div class="dash-action-desc">Edit, view status & track active posts</div>
                    </div>
                </div>
                <div class="dash-action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
            </a>

            <!-- 4. Schedule Interviews -->
            <a href="<%= ResolveUrl("~/CompanyPanel/company-interviews.aspx") %>" class="dash-action dash-action-amber">
                <div class="dash-action-left">
                    <div class="dash-action-icon"><i class="fa-solid fa-calendar-days"></i></div>
                    <div>
                        <div class="dash-action-title">Schedule Interviews</div>
                        <div class="dash-action-desc">Conduct and manage candidate interviews</div>
                    </div>
                </div>
                <div class="dash-action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
            </a>

            <!-- 5. Reports & Analytics -->
            <a href="<%= ResolveUrl("~/CompanyPanel/company-applicants.aspx") %>" class="dash-action dash-action-teal">
                <div class="dash-action-left">
                    <div class="dash-action-icon"><i class="fa-solid fa-chart-pie"></i></div>
                    <div>
                        <div class="dash-action-title">Reports & Analytics</div>
                        <div class="dash-action-desc">View recruitment data and export reports</div>
                    </div>
                </div>
                <div class="dash-action-arrow"><i class="fa-solid fa-arrow-right"></i></div>
            </a>
        </div>
    </div>
</asp:Content>

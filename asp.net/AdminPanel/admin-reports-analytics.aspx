<%@ Page Title="Reports & Analytics" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-reports-analytics.aspx.cs" Inherits="asp.net.ReportsAnalytics" %>
<%@ Register Assembly="System.Web.DataVisualization"
    Namespace="System.Web.UI.DataVisualization.Charting"
    TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-reports-analytics.css?v=100" />
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="reports-page-wrapper">
        <!-- Header -->
        <div class="reports-header">
            <h1 class="reports-title">Reports &amp; Analytics</h1>
            <p class="reports-subtitle">Real-time system analytics, student activity, placement trends, and platform performance.</p>
        </div>
        <!-- 8 DYNAMIC KPI STAT CARDS -->
        <div class="stats-grid-8">
            <!-- Card 1: Total Students -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper stat-icon-purple">
                    <i class="fa-solid fa-graduation-cap"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Total Students</span>
                    <span class="stat-value-modern"><asp:Label ID="lblTotalStudents" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 2: Total Companies -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper stat-icon-blue">
                    <i class="fa-solid fa-building"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Total Companies</span>
                    <span class="stat-value-modern"><asp:Label ID="lblTotalCompanies" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 3: Total Internships -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper stat-icon-green">
                    <i class="fa-solid fa-briefcase"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Total Internships</span>
                    <span class="stat-value-modern"><asp:Label ID="lblTotalInternships" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 4: Total Applications -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper stat-icon-orange">
                    <i class="fa-solid fa-file-lines"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Total Applications</span>
                    <span class="stat-value-modern"><asp:Label ID="lblTotalApplications" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 5: Average Rating -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper stat-icon-amber">
                    <i class="fa-solid fa-star"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Average Rating</span>
                    <span class="stat-value-modern"><asp:Label ID="lblAvgRating" runat="server">5.0 / 5</asp:Label></span>
                </div>
            </div>
            <!-- Card 6: Upcoming Interviews -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper stat-icon-indigo">
                    <i class="fa-solid fa-calendar-days"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Upcoming Interviews</span>
                    <span class="stat-value-modern"><asp:Label ID="lblInterviewsCount" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 7: Certificates Issued -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper stat-icon-teal">
                    <i class="fa-solid fa-certificate"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Certificates Issued</span>
                    <span class="stat-value-modern"><asp:Label ID="lblCertificatesCount" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 8: Total Inquiries -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper stat-icon-pink">
                    <i class="fa-solid fa-comments"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Total Inquiries</span>
                    <span class="stat-value-modern"><asp:Label ID="lblTotalInquiries" runat="server">0</asp:Label></span>
                </div>
            </div>
        </div>
        <!-- ================= 12 VISUAL CHARTS SECTION ================= -->
        <div class="charts-section-title">
            <h2><i class="fa-solid fa-chart-pie icon-chart-blue"></i> Interactive Analytics &amp; Visual Reports</h2>
            <span class="reports-live-badge"><i class="fa-solid fa-bolt icon-bolt-amber"></i> Live Data Synchronized</span>
        </div>
        <div class="charts-grid-container">
            <!-- Chart 1: Monthly Registrations (Line) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-chart-line icon-chart-blue"></i> 1. Monthly Registrations</h3>
                        <p class="chart-card-subtitle">Students vs Companies signup growth</p>
                    </div>
                    <span class="chart-type-badge">Line Chart</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart1" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="Students" ChartType="Line" XValueMember="Month" YValueMembers="Students" Color="#2563eb" BorderWidth="3" MarkerStyle="Circle" MarkerSize="7" Legend="Legend1" />
                            <asp:Series Name="Companies" ChartType="Line" XValueMember="Month" YValueMembers="Companies" Color="#16a34a" BorderWidth="3" MarkerStyle="Circle" MarkerSize="7" Legend="Legend1" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisX IsMarginVisible="true" LineColor="#cbd5e1">
                                    <MajorGrid Enabled="false" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisX>
                                <AxisY LineColor="#cbd5e1">
                                    <MajorGrid LineColor="#edf2f7" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" Docking="Top" Alignment="Center" Font="Segoe UI, 9.5pt" ForeColor="#334155" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 2: Applications per Month (Area) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-chart-area icon-chart-green"></i> 2. Applications per Month</h3>
                        <p class="chart-card-subtitle">Student application submission activity</p>
                    </div>
                    <span class="chart-type-badge">Area Chart</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart2" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="Applications" ChartType="SplineArea" XValueMember="Month" YValueMembers="Total" Color="#059669" BackSecondaryColor="#d1fae5" BackGradientStyle="TopBottom" BorderWidth="2" MarkerStyle="Circle" MarkerSize="6" Legend="Legend1" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisX IsMarginVisible="true" LineColor="#cbd5e1">
                                    <MajorGrid Enabled="false" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisX>
                                <AxisY LineColor="#cbd5e1">
                                    <MajorGrid LineColor="#edf2f7" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" Docking="Top" Alignment="Center" Font="Segoe UI, 9.5pt" ForeColor="#334155" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 3: Application Status (Doughnut) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-chart-pie icon-chart-purple"></i> 3. Application Status Split</h3>
                        <p class="chart-card-subtitle">Applied / Shortlisted / Selected / Rejected</p>
                    </div>
                    <span class="chart-type-badge">Doughnut</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart3" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="Status" ChartType="Doughnut" XValueMember="Status" YValueMembers="Total" IsValueShownAsLabel="true" Font="Segoe UI, 9pt" Legend="Legend1" Palette="BrightPastel" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" />
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" Docking="Bottom" Alignment="Center" Font="Segoe UI, 9pt" ForeColor="#334155" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 4: Internships by Domain (Vertical Bar) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-chart-column icon-chart-orange"></i> 4. Internships by Domain</h3>
                        <p class="chart-card-subtitle">Top technical domains with posted internships</p>
                    </div>
                    <span class="chart-type-badge">Vertical Bar</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart4" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="Domains" ChartType="Column" XValueMember="Domain" YValueMembers="Total" Color="#ea580c" IsValueShownAsLabel="true" Font="Segoe UI, 9pt" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisX Interval="1" LineColor="#cbd5e1">
                                    <MajorGrid Enabled="false" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 8.5pt" Angle="-20" />
                                </AxisX>
                                <AxisY LineColor="#cbd5e1">
                                    <MajorGrid LineColor="#edf2f7" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 5: Top 10 Companies by Applicants (Horizontal Bar) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-building-user icon-chart-sky"></i> 5. Top Companies by Applicants</h3>
                        <p class="chart-card-subtitle">Most popular companies attracting candidates</p>
                    </div>
                    <span class="chart-type-badge">Horizontal Bar</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart5" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="Companies" ChartType="Bar" XValueMember="Company" YValueMembers="AppCount" Color="#0284c7" IsValueShownAsLabel="true" Font="Segoe UI, 9pt" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisX Interval="1" LineColor="#cbd5e1">
                                    <MajorGrid Enabled="false" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 8.5pt" />
                                </AxisX>
                                <AxisY LineColor="#cbd5e1">
                                    <MajorGrid LineColor="#edf2f7" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 6: Work Mode Split (Pie) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-laptop-house icon-chart-emerald"></i> 6. Work Mode Split</h3>
                        <p class="chart-card-subtitle">Remote / On-site / Hybrid distribution</p>
                    </div>
                    <span class="chart-type-badge">Pie Chart</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart6" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="WorkMode" ChartType="Pie" XValueMember="WorkMode" YValueMembers="Total" IsValueShownAsLabel="true" Font="Segoe UI, 9pt" Legend="Legend1" Palette="BrightPastel" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" />
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" Docking="Bottom" Alignment="Center" Font="Segoe UI, 9pt" ForeColor="#334155" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 7: Status per Month (Stacked Bar) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-layer-group icon-chart-amber"></i> 7. Status per Month</h3>
                        <p class="chart-card-subtitle">Monthly hiring progression and pipeline trend</p>
                    </div>
                    <span class="chart-type-badge">Stacked Bar</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart7" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="Selected" ChartType="StackedColumn" XValueMember="Month" YValueMembers="Selected" Color="#10b981" Legend="Legend1" />
                            <asp:Series Name="Shortlisted" ChartType="StackedColumn" XValueMember="Month" YValueMembers="Shortlisted" Color="#3b82f6" Legend="Legend1" />
                            <asp:Series Name="Applied" ChartType="StackedColumn" XValueMember="Month" YValueMembers="Applied" Color="#f59e0b" Legend="Legend1" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisX LineColor="#cbd5e1">
                                    <MajorGrid Enabled="false" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisX>
                                <AxisY LineColor="#cbd5e1">
                                    <MajorGrid LineColor="#edf2f7" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" Docking="Top" Alignment="Center" Font="Segoe UI, 9pt" ForeColor="#334155" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 8: Domain: Internships vs Applications (Column) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-compass-drafting icon-chart-pink"></i> 8. Internships vs Applications</h3>
                        <p class="chart-card-subtitle">Supply vs student demand comparison across domains</p>
                    </div>
                    <span class="chart-type-badge">Column Chart</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart8" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="Internships Posted" ChartType="Column" XValueMember="Domain" YValueMembers="TotalInternships" Color="#2563eb" Legend="Legend1" />
                            <asp:Series Name="Applications Received" ChartType="Column" XValueMember="Domain" YValueMembers="TotalApps" Color="#ec4899" Legend="Legend1" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisX Interval="1" LineColor="#cbd5e1">
                                    <MajorGrid Enabled="false" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 8.5pt" Angle="-20" />
                                </AxisX>
                                <AxisY LineColor="#cbd5e1">
                                    <MajorGrid LineColor="#edf2f7" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" Docking="Top" Alignment="Center" Font="Segoe UI, 9pt" ForeColor="#334155" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 9: Hiring Funnel (Funnel) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-filter icon-chart-indigo"></i> 9. Hiring Funnel</h3>
                        <p class="chart-card-subtitle">Progression: Applied &rarr; Shortlisted &rarr; Interview &rarr; Selected &rarr; Certified</p>
                    </div>
                    <span class="chart-type-badge">Funnel Chart</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart9" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="Funnel" ChartType="Funnel" XValueMember="Stage" YValueMembers="Count" IsValueShownAsLabel="true" Font="Segoe UI, 9pt" Legend="Legend1" Palette="BrightPastel" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" />
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" Docking="Right" Alignment="Center" Font="Segoe UI, 9pt" ForeColor="#334155" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 10: Top Colleges (Doughnut) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-school icon-chart-teal"></i> 10. Top Colleges / Universities</h3>
                        <p class="chart-card-subtitle">Student representation across institutes</p>
                    </div>
                    <span class="chart-type-badge">Doughnut Chart</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart10" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="Colleges" ChartType="Doughnut" XValueMember="College" YValueMembers="Total" IsValueShownAsLabel="true" Font="Segoe UI, 9pt" Legend="Legend1" Palette="Pastel" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" />
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" Docking="Bottom" Alignment="Center" Font="Segoe UI, 8.5pt" ForeColor="#334155" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 11: Rating Distribution (Bar) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-star-half-stroke icon-chart-yellow"></i> 11. Rating Distribution</h3>
                        <p class="chart-card-subtitle">Feedback star ratings (1 Star to 5 Stars)</p>
                    </div>
                    <span class="chart-type-badge">Bar Chart</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart11" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="Ratings" ChartType="Column" XValueMember="Star" YValueMembers="Total" Color="#f59e0b" IsValueShownAsLabel="true" Font="Segoe UI, 9pt" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <AxisX Interval="1" LineColor="#cbd5e1">
                                    <MajorGrid Enabled="false" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisX>
                                <AxisY LineColor="#cbd5e1">
                                    <MajorGrid LineColor="#edf2f7" />
                                    <LabelStyle ForeColor="#64748b" Font="Segoe UI, 9pt" />
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </div>
            </div>
            <!-- Chart 12: Selection Rate % (Doughnut) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-gauge-high icon-chart-mint"></i> 12. Selection Rate %</h3>
                        <p class="chart-card-subtitle">Percentage of applicants selected for roles</p>
                    </div>
                    <span class="chart-type-badge">Doughnut Chart</span>
                </div>
                <div class="chart-body chart-body-asp">
                    <asp:Chart ID="Chart12" runat="server"
                        Width="600px" Height="300px"
                        BackColor="White"
                        AntiAliasing="All"
                        ImageType="Png"
                        RenderType="ImageTag">
                        <Series>
                            <asp:Series Name="SelectionRate" ChartType="Doughnut" XValueMember="Category" YValueMembers="Percentage" IsValueShownAsLabel="true" Font="Segoe UI, 9pt" Legend="Legend1" />
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" />
                        </ChartAreas>
                        <Legends>
                            <asp:Legend Name="Legend1" Docking="Bottom" Alignment="Center" Font="Segoe UI, 9pt" ForeColor="#334155" />
                        </Legends>
                    </asp:Chart>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

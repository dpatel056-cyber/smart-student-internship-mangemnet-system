<%@ Page Title="Recruitment Reports & Analytics" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-reports.aspx.cs" Inherits="asp.net.company_reports" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .page-header-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 24px;
        }
        .page-title h1 {
            font-size: 24px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 4px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .page-title p {
            font-size: 14px;
            color: #64748b;
            margin: 0;
        }
        /* Reports Grid */
        .reports-chart-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            margin-bottom: 28px;
        }
        @media (max-width: 991px) {
            .reports-chart-grid {
                grid-template-columns: 1fr;
            }
        }
        .report-chart-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 22px 24px;
            box-shadow: 0 4px 16px -2px rgba(15, 23, 42, 0.04);
            display: flex;
            flex-direction: column;
            min-height: 340px;
        }
        .report-chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
            padding-bottom: 12px;
            border-bottom: 1px solid #f1f5f9;
        }
        .report-chart-title {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .report-chart-badge {
            font-size: 11.5px;
            font-weight: 700;
            padding: 3px 10px;
            border-radius: 20px;
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
        }
        .chart-canvas-container {
            position: relative;
            flex: 1;
            width: 100%;
            height: 250px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        /* Bottom Applications Table */
        .filter-bar-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 16px 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }
        .form-select-ctrl {
            padding: 9px 14px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            color: #0f172a;
            outline: none;
            background: #f8fafc;
            min-width: 200px;
        }
        .form-select-ctrl:focus {
            border-color: #2563eb;
            background: #ffffff;
        }
        .apps-table-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 16px -2px rgba(15, 23, 42, 0.04);
            margin-bottom: 30px;
        }
        .apps-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13.5px;
            text-align: left;
        }
        .apps-table th {
            background: #f8fafc;
            padding: 14px 18px;
            font-weight: 700;
            color: #475569;
            border-bottom: 1.5px solid #e2e8f0;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .apps-table td {
            padding: 14px 18px;
            border-bottom: 1px solid #f1f5f9;
            color: #1e293b;
            vertical-align: middle;
        }
        .apps-table tr:hover td {
            background: #fafcff;
        }
        .badge-status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .status-applied { background: #eff6ff; color: #2563eb; }
        .status-shortlisted { background: #e0e7ff; color: #4338ca; }
        .status-selected { background: #dcfce7; color: #15803d; }
        .status-rejected { background: #fee2e2; color: #dc2626; }
        .btn-action-print {
            padding: 9px 16px;
            background: #ffffff;
            color: #334155;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.15s ease;
        }
        .btn-action-print:hover {
            background: #f8fafc;
            border-color: #94a3b8;
        }
        @media print {
            aside, header, .btn-action-print, .filter-bar-card {
                display: none !important;
            }
            body, .company-main {
                background: #ffffff !important;
                margin: 0 !important;
                padding: 0 !important;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0 40px 0;">
        <!-- Header -->
        <div class="page-header-box">
            <div class="page-title">
                <h1><i class="fa-solid fa-chart-line" style="color: #2563eb;"></i> Recruitment Reports &amp; Visual Analytics</h1>
                <p>Comprehensive recruitment funnel metrics, domain insights, trend distributions, and hiring reports.</p>
            </div>
            <div style="display: flex; gap: 10px;">
                <button type="button" class="btn-action-print" onclick="window.print();">
                    <i class="fa-solid fa-print"></i> Print / Export Report
                </button>
            </div>
        </div>
        <!-- ================= TOP 8 STAT CARDS (EXACT MATCHING DASHBOARD) ================= -->
        <div class="sims-stat-grid-v2" style="margin-bottom: 28px;">
            <!-- Card 1: Total Internships -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-blue">
                    <i class="fa-solid fa-briefcase"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-num-v2"><asp:Label ID="lblTotalInternships" runat="server" Text="0"></asp:Label></span>
                    <span class="sims-stat-title-v2">Total Internships Posted</span>
                </div>
            </div>
            <!-- Card 2: Active Internships -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-green">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-num-v2"><asp:Label ID="lblActiveInternships" runat="server" Text="0"></asp:Label></span>
                    <span class="sims-stat-title-v2">Active Internships</span>
                </div>
            </div>
            <!-- Card 3: Total Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-purple">
                    <i class="fa-solid fa-file-lines"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-num-v2"><asp:Label ID="lblTotalApplications" runat="server" Text="0"></asp:Label></span>
                    <span class="sims-stat-title-v2">Total Applications</span>
                </div>
            </div>
            <!-- Card 4: Shortlisted Students -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-orange">
                    <i class="fa-solid fa-star"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-num-v2"><asp:Label ID="lblShortlistedCount" runat="server" Text="0"></asp:Label></span>
                    <span class="sims-stat-title-v2">Shortlisted Students</span>
                </div>
            </div>
            <!-- Card 5: Selected Students -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-teal">
                    <i class="fa-solid fa-user-check"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-num-v2"><asp:Label ID="lblSelectedCount" runat="server" Text="0"></asp:Label></span>
                    <span class="sims-stat-title-v2">Selected Students</span>
                </div>
            </div>
            <!-- Card 6: Rejected Students -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-pink">
                    <i class="fa-solid fa-user-xmark"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-num-v2"><asp:Label ID="lblRejectedCount" runat="server" Text="0"></asp:Label></span>
                    <span class="sims-stat-title-v2">Rejected Students</span>
                </div>
            </div>
            <!-- Card 7: Interviews Scheduled -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-yellow">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-num-v2"><asp:Label ID="lblInterviewsCount" runat="server" Text="0"></asp:Label></span>
                    <span class="sims-stat-title-v2">Interviews Scheduled</span>
                </div>
            </div>
            <!-- Card 8: Offers Issued -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-purple-light">
                    <i class="fa-solid fa-file-signature"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-num-v2"><asp:Label ID="lblOffersCount" runat="server" Text="0"></asp:Label></span>
                    <span class="sims-stat-title-v2">Offers Issued</span>
                </div>
            </div>
        </div>
        <!-- ================= 8 VISUAL REPORT CHARTS GRID ================= -->
        <div class="reports-chart-grid">
            <!-- 1. Recruitment Funnel Chart (Horizontal Bars) -->
            <div class="report-chart-card">
                <div class="report-chart-header">
                    <div class="report-chart-title">
                        <i class="fa-solid fa-filter" style="color: #2563eb;"></i> 1. Recruitment Hiring Funnel
                    </div>
                    <span class="report-chart-badge">Applied &rarr; Completed</span>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="chartRecruitmentFunnel"></canvas>
                </div>
            </div>
            <!-- 2. Application Status Distribution (Donut Chart) -->
            <div class="report-chart-card">
                <div class="report-chart-header">
                    <div class="report-chart-title">
                        <i class="fa-solid fa-chart-pie" style="color: #10b981;"></i> 2. Application Status Distribution
                    </div>
                    <span class="report-chart-badge" style="background:#f0fdf4; color:#059669; border-color:#a7f3d0;">All Applications</span>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="chartStatusDistribution"></canvas>
                </div>
            </div>
            <!-- 3. Applications per Internship (Top 5-10 Bar Chart) -->
            <div class="report-chart-card">
                <div class="report-chart-header">
                    <div class="report-chart-title">
                        <i class="fa-solid fa-chart-simple" style="color: #6366f1;"></i> 3. Applications per Internship
                    </div>
                    <span class="report-chart-badge" style="background:#eef2ff; color:#4f46e5; border-color:#c7d2fe;">Top Opportunities</span>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="chartAppsPerInternship"></canvas>
                </div>
            </div>
            <!-- 4. Applications by Domain (Pie / PolarArea Chart) -->
            <div class="report-chart-card">
                <div class="report-chart-header">
                    <div class="report-chart-title">
                        <i class="fa-solid fa-layer-group" style="color: #f59e0b;"></i> 4. Applications by Domain
                    </div>
                    <span class="report-chart-badge" style="background:#fffbeb; color:#d97706; border-color:#fde68a;">Domain Breakdown</span>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="chartDomainDistribution"></canvas>
                </div>
            </div>
            <!-- 5. Applications Trend Over Time (Line Chart) -->
            <div class="report-chart-card">
                <div class="report-chart-header">
                    <div class="report-chart-title">
                        <i class="fa-solid fa-arrow-trend-up" style="color: #0284c7;"></i> 5. Applications Intake Trend
                    </div>
                    <span class="report-chart-badge" style="background:#f0f9ff; color:#0369a1; border-color:#bae6fd;">Timeline</span>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="chartApplicationsTrend"></canvas>
                </div>
            </div>
            <!-- 6. Interview Analytics (Donut Chart) -->
            <div class="report-chart-card">
                <div class="report-chart-header">
                    <div class="report-chart-title">
                        <i class="fa-solid fa-video" style="color: #8b5cf6;"></i> 6. Interview Analytics
                    </div>
                    <span class="report-chart-badge" style="background:#f5f3ff; color:#7c3aed; border-color:#ddd6fe;">Interviews</span>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="chartInterviewAnalytics"></canvas>
                </div>
            </div>
            <!-- 7. Offer Letter Status (Donut Chart) -->
            <div class="report-chart-card">
                <div class="report-chart-header">
                    <div class="report-chart-title">
                        <i class="fa-solid fa-file-signature" style="color: #ec4899;"></i> 7. Offer Letter Status
                    </div>
                    <span class="report-chart-badge" style="background:#fdf2f8; color:#db2777; border-color:#fbcfe8;">Offers</span>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="chartOfferLetterStatus"></canvas>
                </div>
            </div>
            <!-- 8. Intern Task & Challenge Progress (Bar Chart) -->
            <div class="report-chart-card">
                <div class="report-chart-header">
                    <div class="report-chart-title">
                        <i class="fa-solid fa-list-check" style="color: #14b8a6;"></i> 8. Intern Task & Quiz Progress
                    </div>
                    <span class="report-chart-badge" style="background:#f0fdfa; color:#0f766e; border-color:#99f6e4;">Task & Quizzes</span>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="chartTaskProgress"></canvas>
                </div>
            </div>
        </div>
        <!-- ================= DETAILED APPLICATIONS REPORT TABLE ================= -->
        <div class="page-title" style="margin-bottom: 16px;">
            <h2 style="font-size: 19px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0; display: flex; align-items: center; gap: 8px;">
                <i class="fa-solid fa-table-list" style="color: #2563eb;"></i> Detailed Candidate Applications Report
            </h2>
            <p style="font-size: 13.5px; color: #64748b; margin: 0;">Filter and review individual student applications across your internships.</p>
        </div>
        <!-- Filter Bar -->
        <div class="filter-bar-card">
            <div style="display:flex; align-items:center; gap:8px;">
                <label style="font-weight:600; font-size:13px; color:#475569;">Internship:</label>
                <asp:DropDownList ID="ddlInternshipFilter" runat="server" CssClass="form-select-ctrl" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            <div style="display:flex; align-items:center; gap:8px;">
                <label style="font-weight:600; font-size:13px; color:#475569;">Status:</label>
                <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select-ctrl" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged">
                    <asp:ListItem Text="All Statuses" Value="" />
                    <asp:ListItem Text="Applied / Pending" Value="Applied" />
                    <asp:ListItem Text="Shortlisted" Value="Shortlisted" />
                    <asp:ListItem Text="Selected" Value="Selected" />
                    <asp:ListItem Text="Rejected" Value="Rejected" />
                </asp:DropDownList>
            </div>
        </div>
        <!-- Applications Table -->
        <div class="apps-table-card">
            <asp:GridView ID="gvReport" runat="server" AutoGenerateColumns="False" CssClass="apps-table" GridLines="None" ShowHeaderWhenEmpty="true">
                <Columns>
                    <asp:BoundField DataField="ApplicationId" HeaderText="App ID" />
                    <asp:TemplateField HeaderText="Candidate Name">
                        <ItemTemplate>
                            <div style="font-weight: 600; color: #0f172a;"><%# Eval("FullName") %></div>
                            <div style="font-size: 12px; color: #64748b;"><%# Eval("StudentEmail") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="InternshipTitle" HeaderText="Internship Opportunity" />
                    <asp:BoundField DataField="College" HeaderText="College / University" />
                    <asp:TemplateField HeaderText="Applied Date">
                        <ItemTemplate>
                            <%# FormatDate(Eval("AppliedDate")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <%# GetStatusBadge(Eval("Status")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoReport" runat="server" Visible="false">
                <div style="text-align:center; padding:40px 20px;">
                    <i class="fa-solid fa-folder-open" style="font-size: 32px; color: #cbd5e1; margin-bottom: 8px; display: block;"></i>
                    <p style="color:#64748b; font-size:14px; margin:0;">No applications found matching the selected filters.</p>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
    <!-- ================= JAVASCRIPT CHARTS INITIALIZATION ================= -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Global Chart Defaults
            Chart.defaults.font.family = 'Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif';
            Chart.defaults.color = '#64748B';
            // Server-injected data
            const funnelJson = <%= FunnelChartJson %>;
            const statusJson = <%= StatusDistChartJson %>;
            const topIntJson = <%= TopInternshipsChartJson %>;
            const domainJson = <%= DomainChartJson %>;
            const trendJson = <%= TrendChartJson %>;
            const interviewJson = <%= InterviewChartJson %>;
            const offerJson = <%= OfferChartJson %>;
            const taskJson = <%= TaskChartJson %>;
            // ================= 1. RECRUITMENT FUNNEL CHART =================
            const ctxFunnel = document.getElementById('chartRecruitmentFunnel');
            if (ctxFunnel && funnelJson.labels) {
                new Chart(ctxFunnel, {
                    type: 'bar',
                    data: {
                        labels: funnelJson.labels,
                        datasets: [{
                            label: 'Candidates Count',
                            data: funnelJson.data,
                            backgroundColor: [
                                '#3B82F6', // Applied (Blue)
                                '#6366F1', // Shortlisted (Indigo)
                                '#8B5CF6', // Interviewed (Purple)
                                '#10B981', // Selected (Green)
                                '#EC4899', // Offer Sent (Pink)
                                '#14B8A6'  // Completed (Teal)
                            ],
                            borderRadius: 6,
                            barPercentage: 0.65
                        }]
                    },
                    options: {
                        indexAxis: 'y',
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { display: false },
                            tooltip: {
                                callbacks: {
                                    afterLabel: function(context) {
                                        const total = funnelJson.data[0] || 1;
                                        const pct = ((context.raw / total) * 100).toFixed(1);
                                        return pct + '% of total applicants';
                                    }
                                }
                            }
                        },
                        scales: {
                            x: {
                                beginAtZero: true,
                                grid: { color: '#F1F5F9' },
                                ticks: { precision: 0 }
                            },
                            y: {
                                grid: { display: false },
                                ticks: { font: { weight: '600' } }
                            }
                        }
                    }
                });
            }
            // ================= 2. APPLICATION STATUS DISTRIBUTION (DONUT) =================
            const ctxStatus = document.getElementById('chartStatusDistribution');
            if (ctxStatus && statusJson.labels) {
                new Chart(ctxStatus, {
                    type: 'doughnut',
                    data: {
                        labels: statusJson.labels,
                        datasets: [{
                            data: statusJson.data,
                            backgroundColor: [
                                '#F59E0B', // Pending (Amber)
                                '#6366F1', // Shortlisted (Indigo)
                                '#10B981', // Selected (Emerald)
                                '#EF4444'  // Rejected (Red)
                            ],
                            borderWidth: 2,
                            borderColor: '#FFFFFF'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        cutout: '68%',
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: { boxWidth: 12, padding: 14, font: { size: 12 } }
                            }
                        }
                    }
                });
            }
            // ================= 3. APPLICATIONS PER INTERNSHIP (BAR) =================
            const ctxTopInt = document.getElementById('chartAppsPerInternship');
            if (ctxTopInt && topIntJson.labels) {
                new Chart(ctxTopInt, {
                    type: 'bar',
                    data: {
                        labels: topIntJson.labels.length > 0 ? topIntJson.labels : ['No Internships'],
                        datasets: [{
                            label: 'Applicants',
                            data: topIntJson.data.length > 0 ? topIntJson.data : [0],
                            backgroundColor: '#2563EB',
                            borderRadius: 6,
                            barPercentage: 0.55
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: { color: '#F1F5F9' },
                                ticks: { precision: 0 }
                            },
                            x: {
                                grid: { display: false },
                                ticks: {
                                    maxRotation: 45,
                                    minRotation: 0,
                                    callback: function(val) {
                                        const label = this.getLabelForValue(val);
                                        return label.length > 18 ? label.substr(0, 18) + '...' : label;
                                    }
                                }
                            }
                        }
                    }
                });
            }
            // ================= 4. APPLICATIONS BY DOMAIN (POLAR / DOUGHNUT) =================
            const ctxDomain = document.getElementById('chartDomainDistribution');
            if (ctxDomain && domainJson.labels) {
                new Chart(ctxDomain, {
                    type: 'polarArea',
                    data: {
                        labels: domainJson.labels.length > 0 ? domainJson.labels : ['General'],
                        datasets: [{
                            data: domainJson.data.length > 0 ? domainJson.data : [0],
                            backgroundColor: [
                                'rgba(37, 99, 235, 0.75)',
                                'rgba(16, 185, 129, 0.75)',
                                'rgba(245, 158, 11, 0.75)',
                                'rgba(139, 92, 246, 0.75)',
                                'rgba(236, 72, 153, 0.75)',
                                'rgba(20, 184, 166, 0.75)',
                                'rgba(99, 102, 241, 0.75)'
                            ],
                            borderWidth: 1.5,
                            borderColor: '#FFFFFF'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: { boxWidth: 12, padding: 12, font: { size: 11.5 } }
                            }
                        },
                        scales: {
                            r: {
                                ticks: { display: false }
                            }
                        }
                    }
                });
            }
            // ================= 5. APPLICATIONS TREND OVER TIME (LINE) =================
            const ctxTrend = document.getElementById('chartApplicationsTrend');
            if (ctxTrend && trendJson.labels) {
                new Chart(ctxTrend, {
                    type: 'line',
                    data: {
                        labels: trendJson.labels,
                        datasets: [{
                            label: 'Applications Received',
                            data: trendJson.data,
                            borderColor: '#0284C7',
                            backgroundColor: 'rgba(2, 132, 199, 0.12)',
                            fill: true,
                            tension: 0.35,
                            pointBackgroundColor: '#0284C7',
                            pointBorderColor: '#FFFFFF',
                            pointBorderWidth: 2,
                            pointRadius: 5,
                            pointHoverRadius: 7
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: { color: '#F1F5F9' },
                                ticks: { precision: 0 }
                            },
                            x: {
                                grid: { display: false }
                            }
                        }
                    }
                });
            }
            // ================= 6. INTERVIEW ANALYTICS (DONUT) =================
            const ctxInterview = document.getElementById('chartInterviewAnalytics');
            if (ctxInterview && interviewJson.labels) {
                new Chart(ctxInterview, {
                    type: 'doughnut',
                    data: {
                        labels: interviewJson.labels,
                        datasets: [{
                            data: interviewJson.data,
                            backgroundColor: [
                                '#3B82F6', // Scheduled (Blue)
                                '#10B981', // Completed (Green)
                                '#EF4444'  // Cancelled (Red)
                            ],
                            borderWidth: 2,
                            borderColor: '#FFFFFF'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        cutout: '68%',
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: { boxWidth: 12, padding: 12, font: { size: 12 } }
                            }
                        }
                    }
                });
            }
            // ================= 7. OFFER LETTER STATUS (DONUT) =================
            const ctxOffer = document.getElementById('chartOfferLetterStatus');
            if (ctxOffer && offerJson.labels) {
                new Chart(ctxOffer, {
                    type: 'doughnut',
                    data: {
                        labels: offerJson.labels,
                        datasets: [{
                            data: offerJson.data,
                            backgroundColor: [
                                '#3B82F6', // Sent (Blue)
                                '#10B981', // Accepted (Green)
                                '#EF4444', // Rejected (Red)
                                '#F59E0B'  // Pending (Amber)
                            ],
                            borderWidth: 2,
                            borderColor: '#FFFFFF'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        cutout: '68%',
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: { boxWidth: 12, padding: 12, font: { size: 12 } }
                            }
                        }
                    }
                });
            }
            // ================= 8. INTERN TASK & CHALLENGE PROGRESS (BAR) =================
            const ctxTask = document.getElementById('chartTaskProgress');
            if (ctxTask && taskJson.labels) {
                new Chart(ctxTask, {
                    type: 'bar',
                    data: {
                        labels: taskJson.labels,
                        datasets: [{
                            label: 'Total',
                            data: taskJson.data,
                            backgroundColor: [
                                '#F59E0B', // Assigned / Pending (Amber)
                                '#10B981', // Passed & Completed (Emerald Green)
                                '#EF4444', // Failed / Revision (Coral Red)
                                '#8B5CF6'  // Certificates Issued (Purple)
                            ],
                            borderRadius: 6,
                            barPercentage: 0.55
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { display: false },
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        return ' Total: ' + context.parsed.y;
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: { color: '#F1F5F9' },
                                ticks: { precision: 0, stepSize: 1 }
                            },
                            x: {
                                grid: { display: false },
                                ticks: { font: { size: 11.5, weight: '500' } }
                            }
                        }
                    }
                });
            }
        });
    </script>
</asp:Content>

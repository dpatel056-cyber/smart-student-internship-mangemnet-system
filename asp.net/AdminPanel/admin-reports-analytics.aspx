<%@ Page Title="Reports & Analytics" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-reports-analytics.aspx.cs" Inherits="asp.net.ReportsAnalytics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-reports-new.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">

<div class="rpt-page">

    <!-- ============ PAGE HEADER ============ -->
    <div class="rpt-header">
        <div class="rpt-header-left">
            <h1 class="rpt-title">Reports &amp; Analytics</h1>
            <p class="rpt-subtitle">Track performance and generate detailed reports</p>
        </div>
        <div class="rpt-header-right">
            <div class="rpt-date-picker">
                <i class="fa-regular fa-calendar"></i>
                <span>01 Aug 2026 &ndash; 31 Aug 2026</span>
                <i class="fa-solid fa-chevron-down"></i>
            </div>
            <button class="rpt-btn rpt-btn-pdf" id="btnExportPDF">
                <i class="fa-solid fa-file-pdf"></i> Export PDF
            </button>
            <button class="rpt-btn rpt-btn-excel" id="btnExportExcel">
                <i class="fa-solid fa-file-excel"></i> Export Excel
            </button>
        </div>
    </div>

    <!-- ============ KPI ROW 1 ============ -->
    <div class="rpt-kpi-grid">

        <!-- Total Students -->
        <div class="rpt-kpi-card">
            <div class="rpt-kpi-icon rpt-icon-purple">
                <i class="fa-solid fa-user-graduate"></i>
            </div>
            <div class="rpt-kpi-body">
                <div class="rpt-kpi-label">Total Students</div>
                <div class="rpt-kpi-value">1,250</div>
                <div class="rpt-kpi-trend rpt-trend-up">
                    <i class="fa-solid fa-arrow-up"></i> 12.5% this month
                </div>
            </div>
        </div>

        <!-- Total Companies -->
        <div class="rpt-kpi-card">
            <div class="rpt-kpi-icon rpt-icon-blue">
                <i class="fa-solid fa-building"></i>
            </div>
            <div class="rpt-kpi-body">
                <div class="rpt-kpi-label">Total Companies</div>
                <div class="rpt-kpi-value">185</div>
                <div class="rpt-kpi-trend rpt-trend-up">
                    <i class="fa-solid fa-arrow-up"></i> 8.2% this month
                </div>
            </div>
        </div>

        <!-- Total Internships -->
        <div class="rpt-kpi-card">
            <div class="rpt-kpi-icon rpt-icon-teal">
                <i class="fa-solid fa-briefcase"></i>
            </div>
            <div class="rpt-kpi-body">
                <div class="rpt-kpi-label">Total Internships</div>
                <div class="rpt-kpi-value">320</div>
                <div class="rpt-kpi-trend rpt-trend-up">
                    <i class="fa-solid fa-arrow-up"></i> 15.4% this month
                </div>
            </div>
        </div>

        <!-- Total Applications (large card) -->
        <div class="rpt-kpi-card rpt-kpi-large rpt-kpi-orange">
            <div class="rpt-kpi-large-icon">
                <i class="fa-solid fa-file-lines"></i>
            </div>
            <div class="rpt-kpi-body">
                <div class="rpt-kpi-label">Total Applications</div>
                <div class="rpt-kpi-value rpt-value-big">2,840</div>
                <div class="rpt-kpi-trend rpt-trend-up">
                    <i class="fa-solid fa-arrow-up"></i> 10.8% this month
                </div>
            </div>
        </div>

        <!-- Selected Students -->
        <div class="rpt-kpi-card rpt-kpi-large rpt-kpi-rating">
            <div class="rpt-kpi-large-icon rpt-icon-star">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            <div class="rpt-kpi-body">
                <div class="rpt-kpi-label">Selected Students</div>
                <div class="rpt-kpi-value rpt-value-big">485</div>
                <div class="rpt-kpi-trend rpt-trend-up">
                    <i class="fa-solid fa-arrow-up"></i> 18% this month
                </div>
            </div>
        </div>

        <!-- Completed Internships -->
        <div class="rpt-kpi-card rpt-kpi-large rpt-kpi-rating">
            <div class="rpt-kpi-large-icon rpt-icon-star">
                <i class="fa-solid fa-graduation-cap"></i>
            </div>
            <div class="rpt-kpi-body">
                <div class="rpt-kpi-label">Completed Internships</div>
                <div class="rpt-kpi-value rpt-value-big">210</div>
                <div class="rpt-kpi-trend rpt-trend-up">
                    <i class="fa-solid fa-arrow-up"></i> 25% this month
                </div>
            </div>
        </div>

    </div>

    <!-- ============ KPI ROW 2 ============ -->
    <div class="rpt-kpi-row2">
        <!-- Pending Verification -->
        <div class="rpt-kpi-sm-card">
            <div class="rpt-kpi-sm-icon rpt-icon-orange-light">
                <i class="fa-solid fa-user-clock"></i>
            </div>
            <div class="rpt-kpi-sm-body">
                <div class="rpt-kpi-sm-label">Pending Verification</div>
                <div class="rpt-kpi-sm-value">12</div>
                <div class="rpt-kpi-sm-sub rpt-text-orange">Companies</div>
            </div>
        </div>

        <!-- Upcoming Interviews -->
        <div class="rpt-kpi-sm-card">
            <div class="rpt-kpi-sm-icon rpt-icon-purple-light">
                <i class="fa-solid fa-calendar-check"></i>
            </div>
            <div class="rpt-kpi-sm-body">
                <div class="rpt-kpi-sm-label">Upcoming Interviews</div>
                <div class="rpt-kpi-sm-value">84</div>
                <div class="rpt-kpi-sm-sub rpt-text-purple">
                    <i class="fa-solid fa-arrow-up"></i> 6 today
                </div>
            </div>
        </div>

        <!-- Certificates Issued -->
        <div class="rpt-kpi-sm-card">
            <div class="rpt-kpi-sm-icon rpt-icon-teal-light">
                <i class="fa-solid fa-certificate"></i>
            </div>
            <div class="rpt-kpi-sm-body">
                <div class="rpt-kpi-sm-label">Certificates Issued</div>
                <div class="rpt-kpi-sm-value">216</div>
                <div class="rpt-kpi-sm-sub rpt-text-teal">
                    <i class="fa-solid fa-arrow-up"></i> 18 this month
                </div>
            </div>
        </div>
    </div>

    <!-- ============ CHARTS ROW 1: Registration Overview + Application Status + Internship Overview ============ -->
    <div class="rpt-charts-row rpt-charts-row-1">

        <!-- Registration Overview (line chart) -->
        <div class="rpt-chart-card rpt-chart-reg">
            <div class="rpt-chart-header">
                <div class="rpt-chart-title">Registration Overview</div>
                <select class="rpt-select-sm" id="regPeriod">
                    <option>Last 6 Months</option>
                    <option>Last 3 Months</option>
                    <option>This Year</option>
                </select>
            </div>
            <div class="rpt-chart-legend-row">
                <span class="rpt-legend-item rpt-legend-purple"><span class="rpt-legend-line"></span> Students</span>
                <span class="rpt-legend-item rpt-legend-blue"><span class="rpt-legend-line rpt-line-blue"></span> Companies</span>
            </div>
            <div class="rpt-canvas-wrap">
                <canvas id="chartRegistration"></canvas>
            </div>
        </div>

        <!-- Application Status (donut) -->
        <div class="rpt-chart-card rpt-chart-donut">
            <div class="rpt-chart-header">
                <div class="rpt-chart-title">Application Status</div>
            </div>
            <div class="rpt-donut-wrap">
                <div class="rpt-donut-canvas-wrap">
                    <canvas id="chartAppStatus"></canvas>
                    <div class="rpt-donut-center">
                        <div class="rpt-donut-total-label">Total</div>
                        <div class="rpt-donut-total-val">2,840</div>
                    </div>
                </div>
                <div class="rpt-donut-legend">
                    <div class="rpt-dl-item">
                        <span class="rpt-dot rpt-dot-orange"></span>
                        <span class="rpt-dl-label">Applied</span>
                        <span class="rpt-dl-val">1,250 (44.0%)</span>
                    </div>
                    <div class="rpt-dl-item">
                        <span class="rpt-dot rpt-dot-blue"></span>
                        <span class="rpt-dl-label">Shortlisted</span>
                        <span class="rpt-dl-val">645 (22.7%)</span>
                    </div>
                    <div class="rpt-dl-item">
                        <span class="rpt-dot rpt-dot-purple"></span>
                        <span class="rpt-dl-label">Interview</span>
                        <span class="rpt-dl-val">485 (17.1%)</span>
                    </div>
                    <div class="rpt-dl-item">
                        <span class="rpt-dot rpt-dot-green"></span>
                        <span class="rpt-dl-label">Selected</span>
                        <span class="rpt-dl-val">325 (11.4%)</span>
                    </div>
                    <div class="rpt-dl-item">
                        <span class="rpt-dot rpt-dot-red"></span>
                        <span class="rpt-dl-label">Rejected</span>
                        <span class="rpt-dl-val">145 (5.0%)</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Internship Overview (progress list) -->
        <div class="rpt-chart-card rpt-chart-internship">
            <div class="rpt-chart-header">
                <div class="rpt-chart-title">Internship Overview</div>
            </div>
            <div class="rpt-internship-list">
                <div class="rpt-int-row">
                    <div class="rpt-int-top">
                        <span class="rpt-int-label">Active Internships</span>
                        <span class="rpt-int-num">120</span>
                    </div>
                    <div class="rpt-int-bar-track">
                        <div class="rpt-int-bar rpt-bar-blue" style="width:100%"></div>
                    </div>
                </div>
                <div class="rpt-int-row">
                    <div class="rpt-int-top">
                        <span class="rpt-int-label">Pending Approval</span>
                        <span class="rpt-int-num">35</span>
                    </div>
                    <div class="rpt-int-bar-track">
                        <div class="rpt-int-bar rpt-bar-orange" style="width:29%"></div>
                    </div>
                </div>
                <div class="rpt-int-row">
                    <div class="rpt-int-top">
                        <span class="rpt-int-label">Completed</span>
                        <span class="rpt-int-num">72</span>
                    </div>
                    <div class="rpt-int-bar-track">
                        <div class="rpt-int-bar rpt-bar-green" style="width:60%"></div>
                    </div>
                </div>
                <div class="rpt-int-row">
                    <div class="rpt-int-top">
                        <span class="rpt-int-label">Expired</span>
                        <span class="rpt-int-num">18</span>
                    </div>
                    <div class="rpt-int-bar-track">
                        <div class="rpt-int-bar rpt-bar-gray" style="width:15%"></div>
                    </div>
                </div>
                <div class="rpt-int-row">
                    <div class="rpt-int-top">
                        <span class="rpt-int-label">Rejected</span>
                        <span class="rpt-int-num">11</span>
                    </div>
                    <div class="rpt-int-bar-track">
                        <div class="rpt-int-bar rpt-bar-red" style="width:9%"></div>
                    </div>
                </div>
            </div>
            <a href="admin-internships.aspx" class="rpt-view-all-link">View All Internships <i class="fa-solid fa-arrow-right"></i></a>
        </div>

    </div>

    <!-- ============ CHARTS ROW 2: Category Wise + Company Performance + Top Skills ============ -->
    <div class="rpt-charts-row rpt-charts-row-2">

        <!-- Category Wise Internships (bar chart) -->
        <div class="rpt-chart-card rpt-chart-category">
            <div class="rpt-chart-header">
                <div class="rpt-chart-title">Category Wise Internships</div>
                <select class="rpt-select-sm" id="catPeriod">
                    <option>This Year</option>
                    <option>Last Year</option>
                </select>
            </div>
            <div class="rpt-canvas-wrap rpt-canvas-bar">
                <canvas id="chartCategory"></canvas>
            </div>
        </div>

        <!-- Company Performance (table) -->
        <div class="rpt-chart-card rpt-chart-company">
            <div class="rpt-chart-header">
                <div class="rpt-chart-title">Company Performance</div>
                <a href="admin-companies.aspx" class="rpt-view-all">View All</a>
            </div>
            <div class="rpt-perf-table-wrap">
                <table class="rpt-perf-table">
                    <thead>
                        <tr>
                            <th>Company</th>
                            <th>Internships</th>
                            <th>Applications</th>
                            <th>Selected</th>
                            <th>Success Rate</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>ABC Technologies</td>
                            <td>12</td>
                            <td>420</td>
                            <td>48</td>
                            <td><span class="rpt-rate rpt-rate-green">11.4%</span></td>
                        </tr>
                        <tr>
                            <td>XYZ Solutions</td>
                            <td>8</td>
                            <td>285</td>
                            <td>32</td>
                            <td><span class="rpt-rate rpt-rate-green">11.2%</span></td>
                        </tr>
                        <tr>
                            <td>TechSoft Pvt. Ltd.</td>
                            <td>10</td>
                            <td>310</td>
                            <td>35</td>
                            <td><span class="rpt-rate rpt-rate-green">11.3%</span></td>
                        </tr>
                        <tr>
                            <td>Infoways</td>
                            <td>6</td>
                            <td>210</td>
                            <td>22</td>
                            <td><span class="rpt-rate rpt-rate-orange">10.5%</span></td>
                        </tr>
                        <tr>
                            <td>CodeCraft</td>
                            <td>5</td>
                            <td>180</td>
                            <td>18</td>
                            <td><span class="rpt-rate rpt-rate-orange">10.0%</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Top Skills In Demand (bars) -->
        <div class="rpt-chart-card rpt-chart-skills">
            <div class="rpt-chart-header">
                <div class="rpt-chart-title">Top Skills In Demand</div>
            </div>
            <div class="rpt-skills-list">
                <div class="rpt-skill-row">
                    <div class="rpt-skill-top">
                        <span class="rpt-skill-name">ASP.NET</span>
                        <span class="rpt-skill-num">145</span>
                    </div>
                    <div class="rpt-skill-track">
                        <div class="rpt-skill-bar rpt-sb-blue" style="width:100%"></div>
                    </div>
                </div>
                <div class="rpt-skill-row">
                    <div class="rpt-skill-top">
                        <span class="rpt-skill-name">C#</span>
                        <span class="rpt-skill-num">120</span>
                    </div>
                    <div class="rpt-skill-track">
                        <div class="rpt-skill-bar rpt-sb-green" style="width:83%"></div>
                    </div>
                </div>
                <div class="rpt-skill-row">
                    <div class="rpt-skill-top">
                        <span class="rpt-skill-name">SQL</span>
                        <span class="rpt-skill-num">105</span>
                    </div>
                    <div class="rpt-skill-track">
                        <div class="rpt-skill-bar rpt-sb-purple" style="width:72%"></div>
                    </div>
                </div>
                <div class="rpt-skill-row">
                    <div class="rpt-skill-top">
                        <span class="rpt-skill-name">JavaScript</span>
                        <span class="rpt-skill-num">92</span>
                    </div>
                    <div class="rpt-skill-track">
                        <div class="rpt-skill-bar rpt-sb-orange" style="width:63%"></div>
                    </div>
                </div>
                <div class="rpt-skill-row">
                    <div class="rpt-skill-top">
                        <span class="rpt-skill-name">React</span>
                        <span class="rpt-skill-num">75</span>
                    </div>
                    <div class="rpt-skill-track">
                        <div class="rpt-skill-bar rpt-sb-red" style="width:52%"></div>
                    </div>
                </div>
                <div class="rpt-skill-row">
                    <div class="rpt-skill-top">
                        <span class="rpt-skill-name">Python</span>
                        <span class="rpt-skill-num">68</span>
                    </div>
                    <div class="rpt-skill-track">
                        <div class="rpt-skill-bar rpt-sb-gray" style="width:47%"></div>
                    </div>
                </div>
            </div>
            <a href="#" class="rpt-view-all-link">View All Skills <i class="fa-solid fa-arrow-right"></i></a>
        </div>

    </div>

    <!-- ============ BOTTOM ROW: Generate Report + Generated Report Table ============ -->
    <div class="rpt-bottom-row">

        <!-- Generate Report Form -->
        <div class="rpt-gen-card">
            <div class="rpt-gen-title">Generate Report</div>
            <div class="rpt-gen-form">
                <div class="rpt-gen-field">
                    <label class="rpt-gen-label">Report Type</label>
                    <select class="rpt-gen-select" id="genReportType">
                        <option>Application Report</option>
                        <option>Student Report</option>
                        <option>Company Report</option>
                        <option>Internship Report</option>
                        <option>Placement Report</option>
                        <option>Interview Report</option>
                        <option>Certificate Report</option>
                    </select>
                </div>
                <div class="rpt-gen-field">
                    <label class="rpt-gen-label">From Date</label>
                    <div class="rpt-date-field">
                        <input type="date" class="rpt-gen-input" id="genFromDate" value="2026-08-01" />
                        <i class="fa-regular fa-calendar rpt-date-icon"></i>
                    </div>
                </div>
                <div class="rpt-gen-field">
                    <label class="rpt-gen-label">To Date</label>
                    <div class="rpt-date-field">
                        <input type="date" class="rpt-gen-input" id="genToDate" value="2026-08-31" />
                        <i class="fa-regular fa-calendar rpt-date-icon"></i>
                    </div>
                </div>
                <div class="rpt-gen-field">
                    <label class="rpt-gen-label">Company</label>
                    <select class="rpt-gen-select" id="genCompany">
                        <option>All Companies</option>
                        <option>ABC Technologies</option>
                        <option>XYZ Solutions</option>
                        <option>TechSoft Pvt. Ltd.</option>
                        <option>Infoways</option>
                    </select>
                </div>
                <div class="rpt-gen-field">
                    <label class="rpt-gen-label">Internship</label>
                    <select class="rpt-gen-select" id="genInternship">
                        <option>All Internships</option>
                        <option>ASP.NET Intern</option>
                        <option>UI/UX Intern</option>
                        <option>Web Developer Intern</option>
                        <option>Python Intern</option>
                    </select>
                </div>
                <div class="rpt-gen-field">
                    <label class="rpt-gen-label">Status</label>
                    <select class="rpt-gen-select" id="genStatus">
                        <option>All Status</option>
                        <option>Applied</option>
                        <option>Shortlisted</option>
                        <option>Interview</option>
                        <option>Selected</option>
                        <option>Rejected</option>
                    </select>
                </div>
            </div>
            <button class="rpt-gen-btn" id="btnGenerate" onclick="generateReport()">
                <i class="fa-solid fa-magnifying-glass"></i> Generate Report
            </button>
        </div>

        <!-- Generated Report Table -->
        <div class="rpt-result-card" id="reportResultCard">
            <div class="rpt-result-header">
                <div class="rpt-result-title-wrap">
                    <span class="rpt-result-title">Generated Report &ndash; </span>
                    <span class="rpt-result-type rpt-text-blue">Application Report</span>
                    <div class="rpt-result-period">From 01 Aug 2026 To 31 Aug 2026</div>
                </div>
                <div class="rpt-result-total">Total Records: 128</div>
            </div>
            <div class="rpt-result-table-wrap">
                <table class="rpt-result-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Student Name</th>
                            <th>Internship</th>
                            <th>Company</th>
                            <th>Applied Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1</td>
                            <td>Rahul Patel</td>
                            <td>ASP.NET Intern</td>
                            <td>ABC Technologies</td>
                            <td>02 Aug 2026</td>
                            <td><span class="rpt-status rpt-status-applied">Applied</span></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Priya Shah</td>
                            <td>UI/UX Intern</td>
                            <td>XYZ Solutions</td>
                            <td>03 Aug 2026</td>
                            <td><span class="rpt-status rpt-status-shortlisted">Shortlisted</span></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>Jay Patel</td>
                            <td>Web Developer Intern</td>
                            <td>TechSoft Pvt. Ltd.</td>
                            <td>04 Aug 2026</td>
                            <td><span class="rpt-status rpt-status-interview">Interview</span></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>Meet Shah</td>
                            <td>Python Intern</td>
                            <td>Infoways</td>
                            <td>05 Aug 2026</td>
                            <td><span class="rpt-status rpt-status-selected">Selected</span></td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>Neha Joshi</td>
                            <td>Data Analyst Intern</td>
                            <td>DataTech</td>
                            <td>06 Aug 2026</td>
                            <td><span class="rpt-status rpt-status-rejected">Rejected</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <!-- Pagination -->
            <div class="rpt-pagination">
                <span class="rpt-page-info">Showing 1 to 5 of 128 entries</span>
                <div class="rpt-page-controls">
                    <button class="rpt-page-btn rpt-page-nav" disabled>&lt;</button>
                    <button class="rpt-page-btn rpt-page-active">1</button>
                    <button class="rpt-page-btn">2</button>
                    <button class="rpt-page-btn">3</button>
                    <button class="rpt-page-btn">4</button>
                    <button class="rpt-page-btn">5</button>
                    <span class="rpt-page-dots">...</span>
                    <button class="rpt-page-btn">26</button>
                    <button class="rpt-page-btn rpt-page-nav">&gt;</button>
                </div>
                <div class="rpt-page-size">
                    <select class="rpt-size-select" id="pageSize">
                        <option>5 / page</option>
                        <option>10 / page</option>
                        <option>25 / page</option>
                        <option>50 / page</option>
                    </select>
                </div>
            </div>
        </div>

    </div>

</div>

<script>
    // ---- Registration Overview Line Chart ----
    (function () {
        var ctx = document.getElementById('chartRegistration');
        if (!ctx) return;
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug'],
                datasets: [
                    {
                        label: 'Students',
                        data: [320, 420, 550, 680, 820, 1000],
                        borderColor: '#7C3AED',
                        backgroundColor: 'rgba(124,58,237,0.08)',
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: '#7C3AED',
                        pointRadius: 5,
                        borderWidth: 2.5
                    },
                    {
                        label: 'Companies',
                        data: [200, 230, 260, 285, 310, 345],
                        borderColor: '#3B82F6',
                        backgroundColor: 'rgba(59,130,246,0)',
                        tension: 0.4,
                        fill: false,
                        pointBackgroundColor: '#3B82F6',
                        pointRadius: 5,
                        borderWidth: 2.5
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { display: false } },
                scales: {
                    y: {
                        beginAtZero: false,
                        min: 0,
                        max: 1100,
                        ticks: { stepSize: 200, font: { size: 11 }, color: '#94A3B8' },
                        grid: { color: 'rgba(0,0,0,0.05)' }
                    },
                    x: {
                        ticks: { font: { size: 11 }, color: '#94A3B8' },
                        grid: { display: false }
                    }
                }
            }
        });
    })();

    // ---- Application Status Donut ----
    (function () {
        var ctx = document.getElementById('chartAppStatus');
        if (!ctx) return;
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Applied', 'Shortlisted', 'Interview', 'Selected', 'Rejected'],
                datasets: [{
                    data: [1245, 645, 485, 325, 145],
                    backgroundColor: ['#F59E0B', '#3B82F6', '#8B5CF6', '#10B981', '#EF4444'],
                    borderWidth: 0,
                    hoverOffset: 6
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '70%',
                plugins: { legend: { display: false }, tooltip: { enabled: true } }
            }
        });
    })();

    // ---- Category Wise Internships Bar Chart ----
    (function () {
        var ctx = document.getElementById('chartCategory');
        if (!ctx) return;
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Web Dev', 'App Dev', 'UI/UX', 'Data Sci.', 'Marketing', 'Other'],
                datasets: [{
                    label: 'Internships',
                    data: [85, 62, 45, 38, 31, 25],
                    backgroundColor: ['#3B82F6', '#8B5CF6', '#10B981', '#F59E0B', '#EF4444', '#94A3B8'],
                    borderRadius: 6,
                    borderSkipped: false,
                    maxBarThickness: 40
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    datalabels: { display: false }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100,
                        ticks: { stepSize: 20, font: { size: 11 }, color: '#94A3B8' },
                        grid: { color: 'rgba(0,0,0,0.05)' }
                    },
                    x: {
                        ticks: { font: { size: 11 }, color: '#64748B' },
                        grid: { display: false }
                    }
                }
            }
        });
    })();

    // ---- Generate Report button ----
    function generateReport() {
        var btn = document.getElementById('btnGenerate');
        var origText = btn.innerHTML;
        btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Generating...';
        btn.disabled = true;
        setTimeout(function () {
            btn.innerHTML = origText;
            btn.disabled = false;
            if (typeof renderReportRows === 'function') renderReportRows();
            // scroll to result
            var card = document.getElementById('reportResultCard');
            if (card) card.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }, 1200);
    }

    // Report filters and pagination
    var reportRows = document.querySelectorAll('.rpt-result-table tbody tr');
    var reportBody = document.querySelector('.rpt-result-table tbody');
    var reportData = Array.from(reportRows).map(function (row) {
        return {
            student: row.cells[1].textContent.trim(), internship: row.cells[2].textContent.trim(),
            company: row.cells[3].textContent.trim(), date: row.cells[4].textContent.trim(),
            status: row.cells[5].textContent.trim(), html: row.innerHTML
        };
    });
    var reportCompanies = ['ABC Technologies', 'XYZ Solutions', 'TechSoft Pvt. Ltd.', 'Infoways', 'DataTech'];
    var reportInternships = ['ASP.NET Intern', 'UI/UX Intern', 'Web Developer Intern', 'Python Intern', 'Data Analyst Intern'];
    var reportStatuses = ['Applied', 'Shortlisted', 'Interview', 'Selected', 'Rejected'];
    for (var reportIndex = reportData.length; reportIndex < 30; reportIndex++) {
        var day = String((reportIndex % 28) + 1).padStart(2, '0');
        reportData.push({
            student: ['Aarav Patel', 'Mansi Shah', 'Riya Joshi', 'Dev Mehta', 'Pooja Patel'][reportIndex % 5],
            internship: reportInternships[reportIndex % reportInternships.length],
            company: reportCompanies[reportIndex % reportCompanies.length],
            date: day + ' Aug 2026', status: reportStatuses[reportIndex % reportStatuses.length]
        });
    }
    var reportPage = 1;
    var reportPageSize = 5;
    function parseReportDate(value) {
        var parts = value.split(' ');
        var months = { Jan: 0, Feb: 1, Mar: 2, Apr: 3, May: 4, Jun: 5, Jul: 6, Aug: 7, Sep: 8, Oct: 9, Nov: 10, Dec: 11 };
        return new Date(Number(parts[2]), months[parts[1]], Number(parts[0]));
    }
    function renderReportRows() {
        var company = document.getElementById('genCompany').value;
        var internship = document.getElementById('genInternship').value;
        var status = document.getElementById('genStatus').value;
        var from = document.getElementById('genFromDate').value;
        var to = document.getElementById('genToDate').value;
        var filtered = reportData.filter(function (item) {
            var itemDate = parseReportDate(item.date);
            return (company === 'All Companies' || item.company === company) &&
                (internship === 'All Internships' || item.internship === internship) &&
                (status === 'All Status' || item.status === status) &&
                (!from || itemDate >= new Date(from + 'T00:00:00')) && (!to || itemDate <= new Date(to + 'T00:00:00'));
        });
        var totalPages = Math.max(1, Math.ceil(filtered.length / reportPageSize));
        if (reportPage > totalPages) reportPage = totalPages;
        var slice = filtered.slice((reportPage - 1) * reportPageSize, reportPage * reportPageSize);
        reportBody.innerHTML = slice.map(function (item, index) {
            var statusClass = item.status.toLowerCase();
            return '<tr><td>' + ((reportPage - 1) * reportPageSize + index + 1) + '</td><td>' + item.student + '</td><td>' + item.internship + '</td><td>' + item.company + '</td><td>' + item.date + '</td><td><span class="rpt-status rpt-status-' + statusClass + '">' + item.status + '</span></td></tr>';
        }).join('') || '<tr><td colspan="6" style="text-align:center;padding:28px;color:#64748b">No report records found.</td></tr>';
        document.querySelector('.rpt-result-total').textContent = 'Total Records: ' + filtered.length;
        document.querySelector('.rpt-page-info').textContent = 'Showing ' + (filtered.length ? ((reportPage - 1) * reportPageSize + 1) : 0) + ' to ' + Math.min(reportPage * reportPageSize, filtered.length) + ' of ' + filtered.length + ' entries';
        var controls = document.querySelector('.rpt-page-controls');
        controls.innerHTML = '';
        var previous = document.createElement('button'); previous.className = 'rpt-page-btn rpt-page-nav'; previous.textContent = '<'; previous.disabled = reportPage === 1; previous.onclick = function () { reportPage--; renderReportRows(); }; controls.appendChild(previous);
        for (var page = 1; page <= totalPages; page++) { var button = document.createElement('button'); button.className = 'rpt-page-btn ' + (page === reportPage ? 'rpt-page-active' : ''); button.textContent = page; button.onclick = (function (value) { return function () { reportPage = value; renderReportRows(); }; })(page); controls.appendChild(button); }
        var next = document.createElement('button'); next.className = 'rpt-page-btn rpt-page-nav'; next.textContent = '>'; next.disabled = reportPage === totalPages; next.onclick = function () { reportPage++; renderReportRows(); }; controls.appendChild(next);
    }
    ['genCompany', 'genInternship', 'genStatus', 'genFromDate', 'genToDate'].forEach(function (id) { document.getElementById(id).addEventListener('change', function () { reportPage = 1; renderReportRows(); }); });
    document.getElementById('pageSize').addEventListener('change', function () { reportPageSize = Number(this.value.split(' ')[0]) || 5; reportPage = 1; renderReportRows(); });
    renderReportRows();
</script>

</asp:Content>

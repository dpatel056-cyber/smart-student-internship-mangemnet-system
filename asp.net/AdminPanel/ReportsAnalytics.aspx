<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="ReportsAnalytics.aspx.cs" Inherits="asp.net.ReportsAnalytics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-reports.css" />
    <script src="../js/admin-reports.js" defer></script>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <div class="sims-analytics-page">

        <!-- ===================== 1. PAGE HEADER ===================== -->
        <div class="sims-analytics-header">
            <div class="sims-analytics-header-left">
                <div class="sims-analytics-breadcrumb">Dashboard / Reports &amp; Analytics</div>
                <h1 class="sims-analytics-title">Reports &amp; Analytics</h1>
                <p class="sims-analytics-subtitle">Analyze system performance, internship activity, applications and placement trends.</p>
            </div>
            <div class="sims-analytics-header-right">
                <button type="button" class="sims-analytics-btn sims-analytics-btn-secondary" id="btnScheduleReport">
                    <i class="fa-regular fa-clock"></i> Schedule Report
                </button>
                <div class="sims-analytics-export-wrap">
                    <button type="button" class="sims-analytics-btn sims-analytics-btn-outline" id="btnExportToggle">
                        <i class="fa-solid fa-file-export"></i> Export Report <i class="fa-solid fa-chevron-down sims-analytics-caret"></i>
                    </button>
                    <div class="sims-analytics-export-menu" id="exportMenu">
                        <a href="#" class="sims-analytics-export-item" data-export="pdf-dashboard"><i class="fa-solid fa-file-pdf"></i> Export Dashboard PDF</a>
                        <a href="#" class="sims-analytics-export-item" data-export="excel"><i class="fa-solid fa-file-excel"></i> Export Excel</a>
                        <a href="#" class="sims-analytics-export-item" data-export="csv"><i class="fa-solid fa-file-csv"></i> Export CSV</a>
                        <a href="#" class="sims-analytics-export-item" data-export="current"><i class="fa-solid fa-file-lines"></i> Export Current Report</a>
                        <a href="#" class="sims-analytics-export-item" data-export="selected"><i class="fa-solid fa-check-double"></i> Export Selected Data</a>
                    </div>
                </div>
                <button type="button" class="sims-analytics-btn sims-analytics-btn-primary" id="btnGenerateReport">
                    <i class="fa-solid fa-chart-line"></i> Generate Report
                </button>
            </div>
        </div>

        <!-- ===================== 2. GLOBAL FILTER BAR ===================== -->
        <div class="sims-analytics-filters">
            <div class="sims-analytics-filter-group">
                <label>Date Range</label>
                <select class="sims-analytics-select" id="filterDateRange">
                    <option>Today</option>
                    <option>This Week</option>
                    <option selected>This Month</option>
                    <option>Last Month</option>
                    <option>Last 3 Months</option>
                    <option>Last 6 Months</option>
                    <option>This Year</option>
                    <option>Last Year</option>
                    <option>Custom Range</option>
                </select>
            </div>
            <div class="sims-analytics-filter-group">
                <label>From Date</label>
                <input type="date" class="sims-analytics-input" id="filterFromDate" />
            </div>
            <div class="sims-analytics-filter-group">
                <label>To Date</label>
                <input type="date" class="sims-analytics-input" id="filterToDate" />
            </div>
            <div class="sims-analytics-filter-group">
                <label>Category</label>
                <select class="sims-analytics-select" id="filterCategory">
                    <option>All Categories</option>
                    <option>Web Development</option>
                    <option>Software Development</option>
                    <option>UI/UX Design</option>
                    <option>Data Analytics</option>
                    <option>Data Science</option>
                    <option>Mobile App Development</option>
                </select>
            </div>
            <div class="sims-analytics-filter-group">
                <label>Company</label>
                <select class="sims-analytics-select" id="filterCompany">
                    <option>All Companies</option>
                    <option>ABC Technologies</option>
                    <option>TechSoft Pvt Ltd</option>
                    <option>Innovate Labs</option>
                    <option>DataTech Solutions</option>
                </select>
            </div>
            <div class="sims-analytics-filter-group">
                <label>Status</label>
                <select class="sims-analytics-select" id="filterStatus">
                    <option>All Status</option>
                    <option>Active</option>
                    <option>Completed</option>
                    <option>Pending</option>
                    <option>Closed</option>
                </select>
            </div>
            <div class="sims-analytics-filter-actions">
                <button type="button" class="sims-analytics-btn sims-analytics-btn-primary" id="btnApplyFilters">
                    <i class="fa-solid fa-filter"></i> Apply Filters
                </button>
                <button type="button" class="sims-analytics-btn sims-analytics-btn-outline" id="btnResetFilters">
                    <i class="fa-solid fa-rotate-left"></i> Reset
                </button>
            </div>
            <div class="sims-analytics-filter-meta">
                <span>Last Updated:</span> <strong>20 Aug 2026, 10:30 AM</strong>
            </div>
        </div>

        <!-- ===================== 3. KPI CARDS ===================== -->
        <div class="sims-analytics-kpi-grid">
            <div class="sims-analytics-kpi-card">
                <div class="sims-analytics-kpi-icon sims-icon-blue"><i class="fa-solid fa-user-graduate"></i></div>
                <div class="sims-analytics-kpi-body">
                    <div class="sims-analytics-kpi-value">2,450</div>
                    <div class="sims-analytics-kpi-label">Total Students</div>
                    <div class="sims-analytics-kpi-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> 12.5% <span>vs last month</span></div>
                </div>
            </div>
            <div class="sims-analytics-kpi-card">
                <div class="sims-analytics-kpi-icon sims-icon-purple"><i class="fa-solid fa-building"></i></div>
                <div class="sims-analytics-kpi-body">
                    <div class="sims-analytics-kpi-value">185</div>
                    <div class="sims-analytics-kpi-label">Total Companies</div>
                    <div class="sims-analytics-kpi-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> 8.2% <span>vs last month</span></div>
                </div>
            </div>
            <div class="sims-analytics-kpi-card">
                <div class="sims-analytics-kpi-icon sims-icon-teal"><i class="fa-solid fa-briefcase"></i></div>
                <div class="sims-analytics-kpi-body">
                    <div class="sims-analytics-kpi-value">420</div>
                    <div class="sims-analytics-kpi-label">Total Internships</div>
                    <div class="sims-analytics-kpi-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> 15.4% <span>vs last month</span></div>
                </div>
            </div>
            <div class="sims-analytics-kpi-card">
                <div class="sims-analytics-kpi-icon sims-icon-orange"><i class="fa-solid fa-file-lines"></i></div>
                <div class="sims-analytics-kpi-body">
                    <div class="sims-analytics-kpi-value">3,850</div>
                    <div class="sims-analytics-kpi-label">Total Applications</div>
                    <div class="sims-analytics-kpi-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> 18.6% <span>vs last month</span></div>
                </div>
            </div>
            <div class="sims-analytics-kpi-card">
                <div class="sims-analytics-kpi-icon sims-icon-green"><i class="fa-solid fa-user-check"></i></div>
                <div class="sims-analytics-kpi-body">
                    <div class="sims-analytics-kpi-value">1,280</div>
                    <div class="sims-analytics-kpi-label">Selected Students</div>
                    <div class="sims-analytics-kpi-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> 14.2% <span>vs last month</span></div>
                </div>
            </div>
            <div class="sims-analytics-kpi-card">
                <div class="sims-analytics-kpi-icon sims-icon-blue"><i class="fa-solid fa-handshake"></i></div>
                <div class="sims-analytics-kpi-body">
                    <div class="sims-analytics-kpi-value">1,050</div>
                    <div class="sims-analytics-kpi-label">Placements</div>
                    <div class="sims-analytics-kpi-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> 11.8% <span>vs last month</span></div>
                </div>
            </div>
            <div class="sims-analytics-kpi-card">
                <div class="sims-analytics-kpi-icon sims-icon-purple"><i class="fa-solid fa-certificate"></i></div>
                <div class="sims-analytics-kpi-body">
                    <div class="sims-analytics-kpi-value">980</div>
                    <div class="sims-analytics-kpi-label">Certificates Issued</div>
                    <div class="sims-analytics-kpi-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> 9.5% <span>vs last month</span></div>
                </div>
            </div>
            <div class="sims-analytics-kpi-card">
                <div class="sims-analytics-kpi-icon sims-icon-orange"><i class="fa-solid fa-star"></i></div>
                <div class="sims-analytics-kpi-body">
                    <div class="sims-analytics-kpi-value">4.6 / 5</div>
                    <div class="sims-analytics-kpi-label">Average Rating</div>
                    <div class="sims-analytics-kpi-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> 0.3 <span>vs last month</span></div>
                </div>
            </div>
        </div>

        <!-- ===================== 4 & 5. APPLICATION ANALYTICS + STATUS BREAKDOWN ===================== -->
        <div class="sims-analytics-row sims-row-2-1">
            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header">
                    <div>
                        <h3>Internship Application Analytics</h3>
                        <p>Track internship application volume and outcomes over time.</p>
                    </div>
                    <a href="#" class="sims-analytics-link">View Detailed Report <i class="fa-solid fa-arrow-right"></i></a>
                </div>
                <div class="sims-analytics-chart-wrap">
                    <canvas id="chartApplicationTrend"></canvas>
                </div>
            </div>

            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header">
                    <div>
                        <h3>Application Status</h3>
                        <p>Current distribution of applications.</p>
                    </div>
                </div>
                <div class="sims-analytics-chart-wrap sims-chart-donut-wrap">
                    <canvas id="chartApplicationStatus"></canvas>
                </div>
                <div class="sims-analytics-donut-legend">
                    <div><span class="sims-dot sims-dot-blue"></span> Applied <strong>3,850</strong></div>
                    <div><span class="sims-dot sims-dot-green"></span> Selected <strong>1,280 (33%)</strong></div>
                    <div><span class="sims-dot sims-dot-orange"></span> Pending <strong>620 (16%)</strong></div>
                    <div><span class="sims-dot sims-dot-red"></span> Rejected <strong>1,950 (51%)</strong></div>
                </div>
            </div>
        </div>

        <!-- ===================== 6. INTERNSHIP ANALYTICS ===================== -->
        <div class="sims-analytics-row sims-row-1-1">
            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header">
                    <div>
                        <h3>Internship Performance</h3>
                        <p>Overview of internship listings by status.</p>
                    </div>
                </div>
                <div class="sims-analytics-mini-stats">
                    <div class="sims-analytics-mini-stat"><span>420</span><label>Total Internships</label></div>
                    <div class="sims-analytics-mini-stat sims-text-green"><span>285</span><label>Active</label></div>
                    <div class="sims-analytics-mini-stat sims-text-gray"><span>105</span><label>Closed</label></div>
                    <div class="sims-analytics-mini-stat sims-text-orange"><span>30</span><label>Pending Approval</label></div>
                </div>
            </div>

            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header">
                    <div>
                        <h3>Internship Category Distribution</h3>
                    </div>
                </div>
                <div class="sims-analytics-hbar-list">
                    <div class="sims-analytics-hbar-item">
                        <div class="sims-hbar-top"><span>Web Development</span><strong>120</strong></div>
                        <div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:100%"></div></div>
                    </div>
                    <div class="sims-analytics-hbar-item">
                        <div class="sims-hbar-top"><span>Software Development</span><strong>95</strong></div>
                        <div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:79%"></div></div>
                    </div>
                    <div class="sims-analytics-hbar-item">
                        <div class="sims-hbar-top"><span>UI/UX</span><strong>65</strong></div>
                        <div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:54%"></div></div>
                    </div>
                    <div class="sims-analytics-hbar-item">
                        <div class="sims-hbar-top"><span>Data Analytics</span><strong>55</strong></div>
                        <div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:46%"></div></div>
                    </div>
                    <div class="sims-analytics-hbar-item">
                        <div class="sims-hbar-top"><span>Data Science</span><strong>45</strong></div>
                        <div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:38%"></div></div>
                    </div>
                    <div class="sims-analytics-hbar-item">
                        <div class="sims-hbar-top"><span>Mobile Development</span><strong>40</strong></div>
                        <div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:33%"></div></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ===================== 7 & 8. STUDENT & COMPANY ANALYTICS ===================== -->
        <div class="sims-analytics-row sims-row-1-1">
            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header"><div><h3>Student Analytics</h3></div></div>
                <div class="sims-analytics-mini-stats sims-mini-stats-wrap">
                    <div class="sims-analytics-mini-stat"><span>2,450</span><label>Registered</label></div>
                    <div class="sims-analytics-mini-stat"><span>2,080</span><label>Profile Completed</label></div>
                    <div class="sims-analytics-mini-stat"><span>2,210</span><label>Resume Uploaded</label></div>
                    <div class="sims-analytics-mini-stat"><span>1,980</span><label>Applications Submitted</label></div>
                    <div class="sims-analytics-mini-stat sims-text-green"><span>1,280</span><label>Selected</label></div>
                    <div class="sims-analytics-mini-stat sims-text-blue"><span>1,050</span><label>Placed</label></div>
                </div>
                <div class="sims-analytics-progress-list">
                    <div class="sims-analytics-progress-item">
                        <div class="sims-progress-top"><span>Profile Completion</span><strong>85%</strong></div>
                        <div class="sims-progress-track"><div class="sims-progress-fill sims-fill-blue" style="width:85%"></div></div>
                    </div>
                    <div class="sims-analytics-progress-item">
                        <div class="sims-progress-top"><span>Resume Completion</span><strong>90%</strong></div>
                        <div class="sims-progress-track"><div class="sims-progress-fill sims-fill-green" style="width:90%"></div></div>
                    </div>
                    <div class="sims-analytics-progress-item">
                        <div class="sims-progress-top"><span>Internship Participation</span><strong>81%</strong></div>
                        <div class="sims-progress-track"><div class="sims-progress-fill sims-fill-teal" style="width:81%"></div></div>
                    </div>
                    <div class="sims-analytics-progress-item">
                        <div class="sims-progress-top"><span>Placement Rate</span><strong>43%</strong></div>
                        <div class="sims-progress-track"><div class="sims-progress-fill sims-fill-orange" style="width:43%"></div></div>
                    </div>
                </div>
            </div>

            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header"><div><h3>Company Analytics</h3></div></div>
                <div class="sims-analytics-mini-stats sims-mini-stats-wrap">
                    <div class="sims-analytics-mini-stat"><span>185</span><label>Total Companies</label></div>
                    <div class="sims-analytics-mini-stat sims-text-green"><span>165</span><label>Verified</label></div>
                    <div class="sims-analytics-mini-stat sims-text-orange"><span>15</span><label>Pending Verification</label></div>
                    <div class="sims-analytics-mini-stat sims-text-red"><span>5</span><label>Blocked</label></div>
                    <div class="sims-analytics-mini-stat sims-text-blue"><span>150</span><label>Active</label></div>
                </div>
                <div class="sims-analytics-chart-wrap sims-chart-small-wrap">
                    <canvas id="chartCompanyIndustry"></canvas>
                </div>
            </div>
        </div>

        <!-- ===================== 9. PLACEMENT ANALYTICS ===================== -->
        <div class="sims-analytics-chart-card">
            <div class="sims-analytics-chart-header">
                <div>
                    <h3>Placement Analytics</h3>
                    <p>Monthly placement trend and overall performance.</p>
                </div>
            </div>
            <div class="sims-analytics-mini-stats">
                <div class="sims-analytics-mini-stat"><span>1,280</span><label>Total Selected</label></div>
                <div class="sims-analytics-mini-stat"><span>1,150</span><label>Internships Completed</label></div>
                <div class="sims-analytics-mini-stat sims-text-green"><span>1,050</span><label>Placed</label></div>
                <div class="sims-analytics-mini-stat sims-text-blue"><span>43%</span><label>Placement Rate</label></div>
            </div>
            <div class="sims-analytics-chart-wrap">
                <canvas id="chartPlacementTrend"></canvas>
            </div>
        </div>

        <!-- ===================== 10. TOP PERFORMING COMPANIES ===================== -->
        <div class="sims-analytics-table-card">
            <div class="sims-analytics-chart-header"><div><h3>Top Performing Companies</h3></div></div>
            <div class="sims-analytics-table-scroll">
                <table class="sims-analytics-table">
                    <thead>
                        <tr>
                            <th>Rank</th><th>Company</th><th>Internships Posted</th><th>Applications</th><th>Students Selected</th><th>Placement Rate</th><th>Rating</th><th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><span class="sims-rank sims-rank-1">1</span></td>
                            <td>ABC Technologies</td><td>42</td><td>580</td><td>210</td><td>50%</td>
                            <td><i class="fa-solid fa-star sims-star"></i> 4.9</td>
                            <td><button class="sims-analytics-btn sims-analytics-btn-outline sims-btn-sm">View Company</button></td>
                        </tr>
                        <tr>
                            <td><span class="sims-rank sims-rank-2">2</span></td>
                            <td>TechSoft Pvt Ltd</td><td>35</td><td>460</td><td>185</td><td>47%</td>
                            <td><i class="fa-solid fa-star sims-star"></i> 4.8</td>
                            <td><button class="sims-analytics-btn sims-analytics-btn-outline sims-btn-sm">View Company</button></td>
                        </tr>
                        <tr>
                            <td><span class="sims-rank sims-rank-3">3</span></td>
                            <td>Innovate Labs</td><td>30</td><td>390</td><td>160</td><td>45%</td>
                            <td><i class="fa-solid fa-star sims-star"></i> 4.7</td>
                            <td><button class="sims-analytics-btn sims-analytics-btn-outline sims-btn-sm">View Company</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ===================== 11. TOP INTERNSHIP CATEGORIES ===================== -->
        <div class="sims-analytics-table-card">
            <div class="sims-analytics-chart-header"><div><h3>Top Internship Categories</h3></div></div>
            <div class="sims-analytics-table-scroll">
                <table class="sims-analytics-table">
                    <thead>
                        <tr><th>Category</th><th>Internships</th><th>Applications</th><th>Selected</th><th>Success Rate</th></tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Web Development</td><td>120</td><td>1,250</td><td>420</td>
                            <td class="sims-success-cell"><div class="sims-progress-track sims-progress-track-sm"><div class="sims-progress-fill sims-fill-blue" style="width:34%"></div></div><span>34%</span></td>
                        </tr>
                        <tr>
                            <td>Software Development</td><td>95</td><td>980</td><td>360</td>
                            <td class="sims-success-cell"><div class="sims-progress-track sims-progress-track-sm"><div class="sims-progress-fill sims-fill-green" style="width:37%"></div></div><span>37%</span></td>
                        </tr>
                        <tr>
                            <td>UI/UX Design</td><td>65</td><td>620</td><td>210</td>
                            <td class="sims-success-cell"><div class="sims-progress-track sims-progress-track-sm"><div class="sims-progress-fill sims-fill-teal" style="width:34%"></div></div><span>34%</span></td>
                        </tr>
                        <tr>
                            <td>Data Analytics</td><td>55</td><td>480</td><td>165</td>
                            <td class="sims-success-cell"><div class="sims-progress-track sims-progress-track-sm"><div class="sims-progress-fill sims-fill-orange" style="width:34%"></div></div><span>34%</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ===================== 12. STUDENT PERFORMANCE ANALYTICS ===================== -->
        <div class="sims-analytics-row sims-row-1-1">
            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header"><div><h3>Student Internship Performance</h3></div></div>
                <div class="sims-analytics-chart-wrap sims-chart-small-wrap">
                    <canvas id="chartStudentPerformance"></canvas>
                </div>
                <div class="sims-analytics-donut-legend">
                    <div><span class="sims-dot sims-dot-green"></span> High Performing <strong>450</strong></div>
                    <div><span class="sims-dot sims-dot-blue"></span> Average Performing <strong>1,280</strong></div>
                    <div><span class="sims-dot sims-dot-orange"></span> Needs Improvement <strong>320</strong></div>
                    <div><span class="sims-dot sims-dot-gray"></span> Not Participated <strong>400</strong></div>
                </div>
            </div>
            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header"><div><h3>Performance Summary</h3></div></div>
                <div class="sims-analytics-mini-stats sims-mini-stats-wrap">
                    <div class="sims-analytics-mini-stat"><span>1.57</span><label>Avg Applications / Student</label></div>
                    <div class="sims-analytics-mini-stat"><span>33.2%</span><label>Avg Selection Rate</label></div>
                    <div class="sims-analytics-mini-stat"><span>89%</span><label>Avg Internship Completion</label></div>
                </div>
            </div>
        </div>

        <!-- ===================== 13 & 14. INTERVIEW + CERTIFICATE ANALYTICS ===================== -->
        <div class="sims-analytics-row sims-row-1-1">
            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header"><div><h3>Interview Analytics</h3></div></div>
                <div class="sims-analytics-mini-stats sims-mini-stats-wrap">
                    <div class="sims-analytics-mini-stat"><span>1,850</span><label>Total Interviews</label></div>
                    <div class="sims-analytics-mini-stat sims-text-blue"><span>1,620</span><label>Scheduled</label></div>
                    <div class="sims-analytics-mini-stat sims-text-green"><span>1,420</span><label>Completed</label></div>
                    <div class="sims-analytics-mini-stat sims-text-red"><span>120</span><label>Cancelled</label></div>
                    <div class="sims-analytics-mini-stat sims-text-orange"><span>310</span><label>Pending</label></div>
                </div>
                <div class="sims-analytics-chart-wrap sims-chart-small-wrap">
                    <canvas id="chartInterviewStatus"></canvas>
                </div>
                <div class="sims-analytics-highlight">Interview Success Rate: <strong>62%</strong></div>
            </div>

            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header"><div><h3>Certificate Analytics</h3></div></div>
                <div class="sims-analytics-mini-stats sims-mini-stats-wrap">
                    <div class="sims-analytics-mini-stat"><span>980</span><label>Total Certificates</label></div>
                    <div class="sims-analytics-mini-stat sims-text-green"><span>950</span><label>Issued</label></div>
                    <div class="sims-analytics-mini-stat sims-text-blue"><span>890</span><label>Verified</label></div>
                    <div class="sims-analytics-mini-stat sims-text-orange"><span>25</span><label>Pending</label></div>
                    <div class="sims-analytics-mini-stat sims-text-red"><span>5</span><label>Revoked</label></div>
                </div>
                <div class="sims-analytics-chart-wrap sims-chart-small-wrap">
                    <canvas id="chartCertificateTrend"></canvas>
                </div>
                <div class="sims-analytics-highlight">Certificate Verification Rate: <strong>90.8%</strong></div>
            </div>
        </div>

        <!-- ===================== 15. FEEDBACK & RATING ANALYTICS ===================== -->
        <div class="sims-analytics-chart-card">
            <div class="sims-analytics-chart-header"><div><h3>Feedback &amp; Rating Analytics</h3></div></div>
            <div class="sims-analytics-mini-stats">
                <div class="sims-analytics-mini-stat"><span>856</span><label>Total Reviews</label></div>
                <div class="sims-analytics-mini-stat"><span>4.6 / 5</span><label>Average Rating</label></div>
                <div class="sims-analytics-mini-stat sims-text-green"><span>92%</span><label>Student Satisfaction</label></div>
                <div class="sims-analytics-mini-stat sims-text-blue"><span>89%</span><label>Company Satisfaction</label></div>
            </div>
            <div class="sims-analytics-rating-list">
                <div class="sims-rating-row"><span>?????</span><div class="sims-progress-track"><div class="sims-progress-fill sims-fill-green" style="width:72%"></div></div><strong>72% (620)</strong></div>
                <div class="sims-rating-row"><span>?????</span><div class="sims-progress-track"><div class="sims-progress-fill sims-fill-blue" style="width:19%"></div></div><strong>19% (164)</strong></div>
                <div class="sims-rating-row"><span>?????</span><div class="sims-progress-track"><div class="sims-progress-fill sims-fill-teal" style="width:5%"></div></div><strong>5% (42)</strong></div>
                <div class="sims-rating-row"><span>?????</span><div class="sims-progress-track"><div class="sims-progress-fill sims-fill-orange" style="width:2%"></div></div><strong>2% (18)</strong></div>
                <div class="sims-rating-row"><span>?????</span><div class="sims-progress-track"><div class="sims-progress-fill sims-fill-red" style="width:2%"></div></div><strong>2% (12)</strong></div>
            </div>
        </div>

        <!-- ===================== 16. MONTHLY PERFORMANCE OVERVIEW ===================== -->
        <div class="sims-analytics-chart-card">
            <div class="sims-analytics-chart-header">
                <div>
                    <h3>Monthly System Performance</h3>
                    <p>Compare students, companies, internships, applications, selections and placements.</p>
                </div>
            </div>
            <div class="sims-analytics-chart-wrap sims-chart-large-wrap">
                <canvas id="chartMonthlyPerformance"></canvas>
            </div>
        </div>

        <!-- ===================== 17. YEARLY COMPARISON ===================== -->
        <div class="sims-analytics-table-card">
            <div class="sims-analytics-chart-header"><div><h3>Yearly Performance Comparison</h3></div></div>
            <div class="sims-analytics-table-scroll">
                <table class="sims-analytics-table">
                    <thead>
                        <tr><th>Metric</th><th>2024</th><th>2025</th><th>2026</th></tr>
                    </thead>
                    <tbody>
                        <tr><td>Students</td><td>1,850</td><td>2,120</td><td>2,450</td></tr>
                        <tr><td>Companies</td><td>120</td><td>150</td><td>185</td></tr>
                        <tr><td>Internships</td><td>280</td><td>340</td><td>420</td></tr>
                        <tr><td>Applications</td><td>2,600</td><td>3,150</td><td>3,850</td></tr>
                        <tr><td>Selections</td><td>820</td><td>1,020</td><td>1,280</td></tr>
                        <tr><td>Placements</td><td>650</td><td>860</td><td>1,050</td></tr>
                        <tr><td>Certificates</td><td>610</td><td>790</td><td>980</td></tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ===================== 18. PLACEMENT SUCCESS RATE ===================== -->
        <div class="sims-analytics-chart-card sims-analytics-highlight-card">
            <div class="sims-analytics-chart-header"><div><h3>Overall Placement Success Rate</h3></div></div>
            <div class="sims-placement-rate-wrap">
                <div class="sims-circular-progress" style="--pct:43">
                    <div class="sims-circular-inner">43%</div>
                </div>
                <div class="sims-analytics-mini-stats sims-mini-stats-wrap">
                    <div class="sims-analytics-mini-stat"><span>2,450</span><label>Eligible Students</label></div>
                    <div class="sims-analytics-mini-stat"><span>1,980</span><label>Applied</label></div>
                    <div class="sims-analytics-mini-stat"><span>1,280</span><label>Selected</label></div>
                    <div class="sims-analytics-mini-stat"><span>1,150</span><label>Completed</label></div>
                    <div class="sims-analytics-mini-stat sims-text-green"><span>1,050</span><label>Placed</label></div>
                </div>
            </div>
        </div>

        <!-- ===================== 19 & 20. REPORT GENERATION + EXPORT ===================== -->
        <div class="sims-analytics-chart-card">
            <div class="sims-analytics-chart-header"><div><h3>Generate Reports</h3></div></div>
            <div class="sims-analytics-report-form">
                <div class="sims-analytics-filter-group">
                    <label>Report Type</label>
                    <select class="sims-analytics-select" id="reportType">
                        <option>Student Report</option>
                        <option>Company Report</option>
                        <option>Internship Report</option>
                        <option>Application Report</option>
                        <option>Placement Report</option>
                        <option>Interview Report</option>
                        <option>Certificate Report</option>
                        <option>Feedback Report</option>
                        <option selected>Overall System Report</option>
                    </select>
                </div>
                <div class="sims-analytics-filter-group">
                    <label>From</label>
                    <input type="date" class="sims-analytics-input" id="reportFromDate" />
                </div>
                <div class="sims-analytics-filter-group">
                    <label>To</label>
                    <input type="date" class="sims-analytics-input" id="reportToDate" />
                </div>
                <div class="sims-analytics-filter-group">
                    <label>Format</label>
                    <select class="sims-analytics-select" id="reportFormat">
                        <option>PDF</option>
                        <option>Excel</option>
                        <option>CSV</option>
                    </select>
                </div>
                <div class="sims-analytics-filter-actions">
                    <button type="button" class="sims-analytics-btn sims-analytics-btn-outline" id="btnPreviewReport">
                        <i class="fa-regular fa-eye"></i> Preview Report
                    </button>
                    <button type="button" class="sims-analytics-btn sims-analytics-btn-primary" id="btnGenerateReport2">
                        <i class="fa-solid fa-gears"></i> Generate Report
                    </button>
                </div>
            </div>
        </div>

        <!-- ===================== 23 & 24. RECENT REPORTS ===================== -->
        <div class="sims-analytics-table-card">
            <div class="sims-analytics-chart-header"><div><h3>Recent Reports</h3></div></div>
            <div class="sims-analytics-table-scroll">
                <table class="sims-analytics-table">
                    <thead>
                        <tr><th>Report Name</th><th>Generated By</th><th>Date</th><th>Format</th><th>Status</th><th>Action</th></tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Overall System Report</td><td>Admin</td><td>20 Aug 2026</td><td>PDF</td>
                            <td><span class="sims-badge sims-badge-ready"><i class="fa-solid fa-circle-check"></i> Ready</span></td>
                            <td class="sims-analytics-row-actions">
                                <button class="sims-icon-btn" title="View"><i class="fa-regular fa-eye"></i></button>
                                <button class="sims-icon-btn" title="Download"><i class="fa-solid fa-download"></i></button>
                                <button class="sims-icon-btn sims-icon-btn-danger" title="Delete"><i class="fa-regular fa-trash-can"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>Student Analytics Report</td><td>Admin</td><td>19 Aug 2026</td><td>Excel</td>
                            <td><span class="sims-badge sims-badge-ready"><i class="fa-solid fa-circle-check"></i> Ready</span></td>
                            <td class="sims-analytics-row-actions">
                                <button class="sims-icon-btn" title="View"><i class="fa-regular fa-eye"></i></button>
                                <button class="sims-icon-btn" title="Download"><i class="fa-solid fa-download"></i></button>
                                <button class="sims-icon-btn sims-icon-btn-danger" title="Delete"><i class="fa-regular fa-trash-can"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td>Placement Report</td><td>Admin</td><td>18 Aug 2026</td><td>PDF</td>
                            <td><span class="sims-badge sims-badge-ready"><i class="fa-solid fa-circle-check"></i> Ready</span></td>
                            <td class="sims-analytics-row-actions">
                                <button class="sims-icon-btn" title="View"><i class="fa-regular fa-eye"></i></button>
                                <button class="sims-icon-btn" title="Download"><i class="fa-solid fa-download"></i></button>
                                <button class="sims-icon-btn sims-icon-btn-danger" title="Delete"><i class="fa-regular fa-trash-can"></i></button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ===================== 25. SYSTEM HEALTH SUMMARY ===================== -->
        <div class="sims-analytics-chart-card">
            <div class="sims-analytics-chart-header"><div><h3>System Overview</h3></div></div>
            <div class="sims-analytics-mini-stats sims-mini-stats-wrap">
                <div class="sims-analytics-mini-stat"><span>12,850</span><label>Database Records</label></div>
                <div class="sims-analytics-mini-stat"><span>2,635</span><label>Active Users</label></div>
                <div class="sims-analytics-mini-stat"><span>285</span><label>Active Internships</label></div>
                <div class="sims-analytics-mini-stat"><span>620</span><label>Open Applications</label></div>
                <div class="sims-analytics-mini-stat sims-text-orange"><span>45</span><label>Pending Approvals</label></div>
                <div class="sims-analytics-mini-stat sims-text-red"><span>31</span><label>Open Support Requests</label></div>
            </div>
        </div>

        <!-- ===================== 26. INSIGHTS & RECOMMENDATIONS ===================== -->
        <div class="sims-analytics-insights">
            <h3 class="sims-analytics-section-title">Key Insights</h3>
            <div class="sims-analytics-insight-grid">
                <div class="sims-analytics-insight-card">
                    <div class="sims-insight-icon sims-icon-blue"><i class="fa-solid fa-arrow-trend-up"></i></div>
                    <div class="sims-insight-title">Application Growth</div>
                    <div class="sims-insight-desc">Applications increased by 18.6% compared to last month.</div>
                    <div class="sims-insight-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> Positive Trend</div>
                </div>
                <div class="sims-analytics-insight-card">
                    <div class="sims-insight-icon sims-icon-green"><i class="fa-solid fa-briefcase"></i></div>
                    <div class="sims-insight-title">Placement Performance</div>
                    <div class="sims-insight-desc">Placement rate improved by 4.2% this month.</div>
                    <div class="sims-insight-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> Positive Trend</div>
                </div>
                <div class="sims-analytics-insight-card">
                    <div class="sims-insight-icon sims-icon-purple"><i class="fa-solid fa-building-circle-check"></i></div>
                    <div class="sims-insight-title">Company Participation</div>
                    <div class="sims-insight-desc">15 new companies joined the platform this month.</div>
                    <div class="sims-insight-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> Growing</div>
                </div>
                <div class="sims-analytics-insight-card">
                    <div class="sims-insight-icon sims-icon-orange"><i class="fa-solid fa-star"></i></div>
                    <div class="sims-insight-title">Feedback</div>
                    <div class="sims-insight-desc">Average platform rating increased to 4.6 / 5.</div>
                    <div class="sims-insight-trend sims-trend-up"><i class="fa-solid fa-arrow-up"></i> Positive Trend</div>
                </div>
            </div>
        </div>

        <!-- ===================== 27 & 28. SKILLS + DEMAND ANALYTICS ===================== -->
        <div class="sims-analytics-row sims-row-1-1">
            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header"><div><h3>Most Requested Skills</h3></div></div>
                <div class="sims-analytics-hbar-list">
                    <div class="sims-analytics-hbar-item"><div class="sims-hbar-top"><span>JavaScript</span><strong>68%</strong></div><div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:68%"></div></div></div>
                    <div class="sims-analytics-hbar-item"><div class="sims-hbar-top"><span>Python</span><strong>62%</strong></div><div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:62%"></div></div></div>
                    <div class="sims-analytics-hbar-item"><div class="sims-hbar-top"><span>SQL</span><strong>58%</strong></div><div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:58%"></div></div></div>
                    <div class="sims-analytics-hbar-item"><div class="sims-hbar-top"><span>ASP.NET</span><strong>54%</strong></div><div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:54%"></div></div></div>
                    <div class="sims-analytics-hbar-item"><div class="sims-hbar-top"><span>React</span><strong>48%</strong></div><div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:48%"></div></div></div>
                    <div class="sims-analytics-hbar-item"><div class="sims-hbar-top"><span>Java</span><strong>45%</strong></div><div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:45%"></div></div></div>
                    <div class="sims-analytics-hbar-item"><div class="sims-hbar-top"><span>HTML/CSS</span><strong>42%</strong></div><div class="sims-hbar-track"><div class="sims-hbar-fill" style="width:42%"></div></div></div>
                </div>
            </div>

            <div class="sims-analytics-chart-card">
                <div class="sims-analytics-chart-header"><div><h3>Most Applied Internship Categories</h3></div></div>
                <div class="sims-analytics-ranking-list">
                    <div class="sims-analytics-ranking-item"><span class="sims-rank sims-rank-1">1</span><span class="sims-ranking-name">Web Development</span><strong>1,250 applications</strong></div>
                    <div class="sims-analytics-ranking-item"><span class="sims-rank sims-rank-2">2</span><span class="sims-ranking-name">Software Development</span><strong>980 applications</strong></div>
                    <div class="sims-analytics-ranking-item"><span class="sims-rank sims-rank-3">3</span><span class="sims-ranking-name">UI/UX Design</span><strong>620 applications</strong></div>
                    <div class="sims-analytics-ranking-item"><span class="sims-rank sims-rank-other">4</span><span class="sims-ranking-name">Data Analytics</span><strong>480 applications</strong></div>
                    <div class="sims-analytics-ranking-item"><span class="sims-rank sims-rank-other">5</span><span class="sims-ranking-name">Data Science</span><strong>350 applications</strong></div>
                </div>
            </div>
        </div>

        <!-- ===================== 29. RECENT SYSTEM ACTIVITY ===================== -->
        <div class="sims-analytics-chart-card">
            <div class="sims-analytics-chart-header"><div><h3>Recent Analytics Activity</h3></div></div>
            <div class="sims-analytics-timeline">
                <div class="sims-timeline-item">
                    <div class="sims-timeline-icon sims-icon-blue"><i class="fa-solid fa-file-lines"></i></div>
                    <div class="sims-timeline-body"><div class="sims-timeline-title">Monthly report generated</div><div class="sims-timeline-time">10 minutes ago</div></div>
                </div>
                <div class="sims-timeline-item">
                    <div class="sims-timeline-icon sims-icon-green"><i class="fa-solid fa-file-export"></i></div>
                    <div class="sims-timeline-body"><div class="sims-timeline-title">Placement report exported</div><div class="sims-timeline-time">30 minutes ago</div></div>
                </div>
                <div class="sims-timeline-item">
                    <div class="sims-timeline-icon sims-icon-purple"><i class="fa-solid fa-user-graduate"></i></div>
                    <div class="sims-timeline-body"><div class="sims-timeline-title">Student analytics viewed</div><div class="sims-timeline-time">1 hour ago</div></div>
                </div>
                <div class="sims-timeline-item">
                    <div class="sims-timeline-icon sims-icon-orange"><i class="fa-solid fa-building"></i></div>
                    <div class="sims-timeline-body"><div class="sims-timeline-title">Company report generated</div><div class="sims-timeline-time">2 hours ago</div></div>
                </div>
                <div class="sims-timeline-item">
                    <div class="sims-timeline-icon sims-icon-teal"><i class="fa-solid fa-certificate"></i></div>
                    <div class="sims-timeline-body"><div class="sims-timeline-title">Certificate report downloaded</div><div class="sims-timeline-time">3 hours ago</div></div>
                </div>
            </div>
        </div>

        <!-- ===================== 30. EMPTY STATE (hidden by default) ===================== -->
        <div class="sims-analytics-empty" id="simsAnalyticsEmptyState" style="display:none;">
            <div class="sims-analytics-empty-icon"><i class="fa-solid fa-chart-column"></i></div>
            <h3>No Data Available</h3>
            <p>No analytics data is available for the selected filters.</p>
            <button type="button" class="sims-analytics-btn sims-analytics-btn-primary" id="btnEmptyResetFilters">Reset Filters</button>
        </div>

    </div>

    <!-- ===================== 21. REPORT PREVIEW MODAL ===================== -->
    <div class="sims-analytics-modal-overlay" id="previewModalOverlay">
        <div class="sims-analytics-modal sims-modal-lg" id="previewModal">
            <div class="sims-analytics-modal-header">
                <h3><i class="fa-regular fa-eye"></i> Report Preview</h3>
                <button type="button" class="sims-modal-close" data-close="previewModalOverlay"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="sims-analytics-modal-body sims-analytics-modal-body-scroll">
                <div class="sims-preview-meta">
                    <div><label>Report Name</label><strong>Overall System Report</strong></div>
                    <div><label>Generated Date</label><strong>20 Aug 2026</strong></div>
                    <div><label>Date Range</label><strong>01 Aug 2026 – 20 Aug 2026</strong></div>
                    <div><label>Generated By</label><strong>Admin</strong></div>
                </div>
                <h4 class="sims-preview-subtitle">Overall System Report</h4>
                <div class="sims-preview-grid">
                    <div class="sims-preview-stat"><span>2,450</span><label>Total Students</label></div>
                    <div class="sims-preview-stat"><span>185</span><label>Total Companies</label></div>
                    <div class="sims-preview-stat"><span>420</span><label>Total Internships</label></div>
                    <div class="sims-preview-stat"><span>3,850</span><label>Total Applications</label></div>
                    <div class="sims-preview-stat"><span>1,280</span><label>Selected</label></div>
                    <div class="sims-preview-stat"><span>1,050</span><label>Placements</label></div>
                    <div class="sims-preview-stat sims-text-green"><span>43%</span><label>Placement Rate</label></div>
                </div>
                <div class="sims-analytics-chart-wrap sims-chart-small-wrap">
                    <canvas id="chartPreview"></canvas>
                </div>
            </div>
            <div class="sims-analytics-modal-footer">
                <button type="button" class="sims-analytics-btn sims-analytics-btn-outline" data-close="previewModalOverlay">Close</button>
                <button type="button" class="sims-analytics-btn sims-analytics-btn-outline" id="btnPrintReport"><i class="fa-solid fa-print"></i> Print Report</button>
                <button type="button" class="sims-analytics-btn sims-analytics-btn-outline" id="btnExportExcelModal"><i class="fa-solid fa-file-excel"></i> Export Excel</button>
                <button type="button" class="sims-analytics-btn sims-analytics-btn-primary" id="btnDownloadPdf"><i class="fa-solid fa-file-pdf"></i> Download PDF</button>
            </div>
        </div>
    </div>

    <!-- ===================== 22. SCHEDULE REPORT MODAL ===================== -->
    <div class="sims-analytics-modal-overlay" id="scheduleModalOverlay">
        <div class="sims-analytics-modal sims-modal-md" id="scheduleModal">
            <div class="sims-analytics-modal-header">
                <h3><i class="fa-regular fa-clock"></i> Schedule Report</h3>
                <button type="button" class="sims-modal-close" data-close="scheduleModalOverlay"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="sims-analytics-modal-body">
                <div class="sims-analytics-form-grid">
                    <div class="sims-analytics-filter-group">
                        <label>Report Type *</label>
                        <select class="sims-analytics-select sims-analytics-modal-dropdown">
                            <option>Student Report</option>
                            <option>Company Report</option>
                            <option>Internship Report</option>
                            <option>Application Report</option>
                            <option>Placement Report</option>
                            <option>Interview Report</option>
                            <option>Certificate Report</option>
                            <option>Feedback Report</option>
                            <option selected>Overall System Report</option>
                        </select>
                    </div>
                    <div class="sims-analytics-filter-group">
                        <label>Frequency</label>
                        <select class="sims-analytics-select sims-analytics-modal-dropdown">
                            <option>Daily</option>
                            <option>Weekly</option>
                            <option selected>Monthly</option>
                            <option>Quarterly</option>
                        </select>
                    </div>
                    <div class="sims-analytics-filter-group">
                        <label>Email</label>
                        <input type="email" class="sims-analytics-input" placeholder="admin@example.com" />
                    </div>
                    <div class="sims-analytics-filter-group">
                        <label>Format</label>
                        <select class="sims-analytics-select sims-analytics-modal-dropdown">
                            <option>PDF</option>
                            <option>Excel</option>
                        </select>
                    </div>
                    <div class="sims-analytics-filter-group">
                        <label>Schedule Date *</label>
                        <input type="date" class="sims-analytics-input" />
                    </div>
                    <div class="sims-analytics-filter-group">
                        <label>Schedule Time *</label>
                        <input type="time" class="sims-analytics-input" />
                    </div>
                </div>
                <label class="sims-analytics-checkbox">
                    <input type="checkbox" checked /> Send notification after report generation
                </label>
            </div>
            <div class="sims-analytics-modal-footer">
                <button type="button" class="sims-analytics-btn sims-analytics-btn-outline" data-close="scheduleModalOverlay">Cancel</button>
                <button type="button" class="sims-analytics-btn sims-analytics-btn-primary" id="btnConfirmSchedule"><i class="fa-regular fa-clock"></i> Schedule Report</button>
            </div>
        </div>
    </div>

    <!-- Toast Container -->
    <div class="sims-analytics-toast-container" id="simsAnalyticsToastContainer"></div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.4/chart.umd.min.js"></script>
</asp:Content>







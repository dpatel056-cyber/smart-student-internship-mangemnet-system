<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-dashboard.aspx.cs" Inherits="asp.net.admin_dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <div class="sims-dashboard">

    <!-- ===================== 1. WELCOME SECTION ===================== -->
    <div class="sims-dashboard-header">
        <div class="sims-dashboard-header-text">
            <h1 class="sims-dashboard-title">Dashboard</h1>
            <p class="sims-dashboard-subtitle">Welcome back, Admin. Here's what's happening with your internship management system.</p>
        </div>
        <div class="sims-dashboard-filter">
            <button type="button" class="sims-filter-btn" id="dashFilterBtn">
                <i class="fa-solid fa-calendar"></i>
                <span>This Month</span>
                <i class="fa-solid fa-chevron-down"></i>
            </button>
        </div>
    </div>

    <!-- ===================== 2. STATISTICS CARDS ===================== -->
    <div class="sims-stat-grid">

        <div class="sims-stat-card">
            <div class="sims-stat-icon sims-stat-icon-blue">
                <i class="fa-solid fa-user-graduate"></i>
            </div>
            <div class="sims-stat-body">
                <span class="sims-stat-label">Total Students</span>
                <span class="sims-stat-value">1,250</span>
                <div class="sims-stat-trend">
                    <span class="sims-trend-up"><i class="fa-solid fa-arrow-trend-up"></i> +12.5%</span>
                    <span class="sims-trend-note">vs last month</span>
                </div>
            </div>
        </div>

        <div class="sims-stat-card">
            <div class="sims-stat-icon sims-stat-icon-indigo">
                <i class="fa-solid fa-building"></i>
            </div>
            <div class="sims-stat-body">
                <span class="sims-stat-label">Total Companies</span>
                <span class="sims-stat-value">85</span>
                <div class="sims-stat-trend">
                    <span class="sims-trend-up"><i class="fa-solid fa-arrow-trend-up"></i> +8.2%</span>
                    <span class="sims-trend-note">vs last month</span>
                </div>
            </div>
        </div>

        <div class="sims-stat-card">
            <div class="sims-stat-icon sims-stat-icon-teal">
                <i class="fa-solid fa-briefcase"></i>
            </div>
            <div class="sims-stat-body">
                <span class="sims-stat-label">Active Internships</span>
                <span class="sims-stat-value">156</span>
                <div class="sims-stat-trend">
                    <span class="sims-trend-up"><i class="fa-solid fa-arrow-trend-up"></i> +15.4%</span>
                    <span class="sims-trend-note">vs last month</span>
                </div>
            </div>
        </div>

        <div class="sims-stat-card">
            <div class="sims-stat-icon sims-stat-icon-amber">
                <i class="fa-solid fa-file-lines"></i>
            </div>
            <div class="sims-stat-body">
                <span class="sims-stat-label">Applications</span>
                <span class="sims-stat-value">2,480</span>
                <div class="sims-stat-trend">
                    <span class="sims-trend-up"><i class="fa-solid fa-arrow-trend-up"></i> +18.7%</span>
                    <span class="sims-trend-note">vs last month</span>
                </div>
            </div>
        </div>

        <div class="sims-stat-card">
            <div class="sims-stat-icon sims-stat-icon-green">
                <i class="fa-solid fa-trophy"></i>
            </div>
            <div class="sims-stat-body">
                <span class="sims-stat-label">Placements</span>
                <span class="sims-stat-value">325</span>
                <div class="sims-stat-trend">
                    <span class="sims-trend-up"><i class="fa-solid fa-arrow-trend-up"></i> +10.3%</span>
                    <span class="sims-trend-note">vs last month</span>
                </div>
            </div>
        </div>

    </div>

    <!-- ===================== 3 & 4. ANALYTICS: LINE CHART + DOUGHNUT ===================== -->
    <div class="sims-analytics-grid">

        <div class="sims-chart-card sims-chart-card-large">
            <div class="sims-chart-card-header">
                <div>
                    <h2 class="sims-card-title">Applications Overview</h2>
                    <p class="sims-card-subtitle">Application activity over the selected period</p>
                </div>
            </div>
            <div class="sims-chart-legend-inline">
                <span class="sims-legend-dot sims-legend-applied"></span> Applied
                <span class="sims-legend-dot sims-legend-selected"></span> Selected
                <span class="sims-legend-dot sims-legend-rejected"></span> Rejected
                <span class="sims-legend-dot sims-legend-pending"></span> Pending
            </div>
            <div class="sims-chart-canvas-wrap">
                <canvas id="simsApplicationsChart"></canvas>
            </div>
        </div>

        <div class="sims-chart-card sims-chart-card-small">
            <div class="sims-chart-card-header">
                <div>
                    <h2 class="sims-card-title">Internship Statistics</h2>
                    <p class="sims-card-subtitle">Current internship distribution</p>
                </div>
            </div>
            <div class="sims-doughnut-wrap">
                <canvas id="simsInternshipDoughnut"></canvas>
                <div class="sims-doughnut-center">
                    <span class="sims-doughnut-total">156</span>
                    <span class="sims-doughnut-label">Total</span>
                </div>
            </div>
            <ul class="sims-doughnut-legend">
                <li><span class="sims-legend-dot sims-legend-active"></span> Active Internships <b>92</b></li>
                <li><span class="sims-legend-dot sims-legend-closed"></span> Closed Internships <b>48</b></li>
                <li><span class="sims-legend-dot sims-legend-approval"></span> Pending Approval <b>16</b></li>
            </ul>
        </div>

    </div>

    <!-- ===================== 5. APPLICATION STATUS SUMMARY ===================== -->
    <div class="sims-status-section">
        <h2 class="sims-section-title">Application Status</h2>
        <div class="sims-status-grid">

            <div class="sims-status-card">
                <div class="sims-status-icon sims-status-icon-pending"><i class="fa-solid fa-hourglass-half"></i></div>
                <div class="sims-status-body">
                    <span class="sims-status-name">Pending</span>
                    <span class="sims-status-count">450</span>
                    <div class="sims-status-bar"><div class="sims-status-bar-fill sims-fill-pending" style="width:56%;"></div></div>
                </div>
            </div>

            <div class="sims-status-card">
                <div class="sims-status-icon sims-status-icon-shortlisted"><i class="fa-solid fa-list-check"></i></div>
                <div class="sims-status-body">
                    <span class="sims-status-name">Shortlisted</span>
                    <span class="sims-status-count">280</span>
                    <div class="sims-status-bar"><div class="sims-status-bar-fill sims-fill-shortlisted" style="width:35%;"></div></div>
                </div>
            </div>

            <div class="sims-status-card">
                <div class="sims-status-icon sims-status-icon-selected"><i class="fa-solid fa-circle-check"></i></div>
                <div class="sims-status-body">
                    <span class="sims-status-name">Selected</span>
                    <span class="sims-status-count">325</span>
                    <div class="sims-status-bar"><div class="sims-status-bar-fill sims-fill-selected" style="width:41%;"></div></div>
                </div>
            </div>

            <div class="sims-status-card">
                <div class="sims-status-icon sims-status-icon-rejected"><i class="fa-solid fa-circle-xmark"></i></div>
                <div class="sims-status-body">
                    <span class="sims-status-name">Rejected</span>
                    <span class="sims-status-count">175</span>
                    <div class="sims-status-bar"><div class="sims-status-bar-fill sims-fill-rejected" style="width:22%;"></div></div>
                </div>
            </div>

        </div>
    </div>

    <!-- ===================== 6 & 7. TABLES: APPLICATIONS + COMPANIES ===================== -->
    <div class="sims-tables-grid">

        <div class="sims-table-card sims-table-card-large">
            <div class="sims-table-card-header">
                <div>
                    <h2 class="sims-card-title">Recent Applications</h2>
                    <p class="sims-card-subtitle">Latest internship applications submitted by students</p>
                </div>
                <a href="admin-student-applications.aspx" class="sims-view-all-link">View All Applications <i class="fa-solid fa-arrow-right"></i></a>
            </div>

            <div class="sims-table-scroll">
                <table class="sims-data-table">
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Internship</th>
                            <th>Company</th>
                            <th>Applied Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="sims-table-user">
                                    <span class="sims-table-avatar">DP</span>
                                    <span>Dhruvi Patel</span>
                                </div>
                            </td>
                            <td>Web Developer Intern</td>
                            <td>ABC Technologies</td>
                            <td>18 Aug 2026</td>
                            <td><span class="sims-badge sims-badge-pending">Pending</span></td>
                            <td><a href="#" class="sims-table-action" title="View"><i class="fa-solid fa-eye"></i></a></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="sims-table-user">
                                    <span class="sims-table-avatar">RS</span>
                                    <span>Rahul Shah</span>
                                </div>
                            </td>
                            <td>.NET Developer Intern</td>
                            <td>TechSoft Pvt Ltd</td>
                            <td>17 Aug 2026</td>
                            <td><span class="sims-badge sims-badge-selected">Selected</span></td>
                            <td><a href="#" class="sims-table-action" title="View"><i class="fa-solid fa-eye"></i></a></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="sims-table-user">
                                    <span class="sims-table-avatar">PM</span>
                                    <span>Priya Mehta</span>
                                </div>
                            </td>
                            <td>UI/UX Design Intern</td>
                            <td>Innovate Labs</td>
                            <td>17 Aug 2026</td>
                            <td><span class="sims-badge sims-badge-shortlisted">Shortlisted</span></td>
                            <td><a href="#" class="sims-table-action" title="View"><i class="fa-solid fa-eye"></i></a></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="sims-table-user">
                                    <span class="sims-table-avatar">AP</span>
                                    <span>Aarav Patel</span>
                                </div>
                            </td>
                            <td>Data Analyst Intern</td>
                            <td>DataTech Solutions</td>
                            <td>16 Aug 2026</td>
                            <td><span class="sims-badge sims-badge-rejected">Rejected</span></td>
                            <td><a href="#" class="sims-table-action" title="View"><i class="fa-solid fa-eye"></i></a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="sims-table-card sims-table-card-small">
            <div class="sims-table-card-header">
                <div>
                    <h2 class="sims-card-title">Recent Companies</h2>
                    <p class="sims-card-subtitle">Newly registered companies</p>
                </div>
                <a href="admin-companies.aspx" class="sims-view-all-link">View All Companies <i class="fa-solid fa-arrow-right"></i></a>
            </div>

            <ul class="sims-company-list">
                <li class="sims-company-item">
                    <div class="sims-company-icon"><i class="fa-solid fa-building"></i></div>
                    <div class="sims-company-info">
                        <span class="sims-company-name">ABC Technologies</span>
                        <span class="sims-company-meta">Information Technology &middot; 18 Aug 2026</span>
                    </div>
                    <span class="sims-badge sims-badge-verified">Verified</span>
                </li>
                <li class="sims-company-item">
                    <div class="sims-company-icon"><i class="fa-solid fa-building"></i></div>
                    <div class="sims-company-info">
                        <span class="sims-company-name">TechSoft Pvt Ltd</span>
                        <span class="sims-company-meta">Software Development &middot; 17 Aug 2026</span>
                    </div>
                    <span class="sims-badge sims-badge-verified">Verified</span>
                </li>
                <li class="sims-company-item">
                    <div class="sims-company-icon"><i class="fa-solid fa-building"></i></div>
                    <div class="sims-company-info">
                        <span class="sims-company-name">Innovate Labs</span>
                        <span class="sims-company-meta">Technology &middot; 16 Aug 2026</span>
                    </div>
                    <span class="sims-badge sims-badge-pending">Pending</span>
                </li>
                <li class="sims-company-item">
                    <div class="sims-company-icon"><i class="fa-solid fa-building"></i></div>
                    <div class="sims-company-info">
                        <span class="sims-company-name">DataTech Solutions</span>
                        <span class="sims-company-meta">Data Analytics &middot; 15 Aug 2026</span>
                    </div>
                    <span class="sims-badge sims-badge-verified">Verified</span>
                </li>
            </ul>
        </div>

    </div>

    <!-- ===================== 8 & 9. ACTIVITIES + QUICK ACTIONS ===================== -->
    <div class="sims-bottom-grid">

        <div class="sims-activity-card">
            <div class="sims-table-card-header">
                <div>
                    <h2 class="sims-card-title">Recent Activities</h2>
                    <p class="sims-card-subtitle">Latest actions across the system</p>
                </div>
            </div>

            <ul class="sims-activity-timeline">
                <li class="sims-activity-item">
                    <span class="sims-activity-icon sims-activity-icon-blue"><i class="fa-solid fa-building"></i></span>
                    <div class="sims-activity-content">
                        <span class="sims-activity-title">New company registered</span>
                        <span class="sims-activity-desc">ABC Technologies registered recently</span>
                        <span class="sims-activity-time">10 minutes ago</span>
                    </div>
                </li>
                <li class="sims-activity-item">
                    <span class="sims-activity-icon sims-activity-icon-teal"><i class="fa-solid fa-briefcase"></i></span>
                    <div class="sims-activity-content">
                        <span class="sims-activity-title">New internship posted</span>
                        <span class="sims-activity-desc">Web Developer Internship posted by TechSoft Pvt Ltd</span>
                        <span class="sims-activity-time">45 minutes ago</span>
                    </div>
                </li>
                <li class="sims-activity-item">
                    <span class="sims-activity-icon sims-activity-icon-indigo"><i class="fa-solid fa-user-graduate"></i></span>
                    <div class="sims-activity-content">
                        <span class="sims-activity-title">New student registered</span>
                        <span class="sims-activity-desc">Rahul Shah created a student account</span>
                        <span class="sims-activity-time">2 hours ago</span>
                    </div>
                </li>
                <li class="sims-activity-item">
                    <span class="sims-activity-icon sims-activity-icon-green"><i class="fa-solid fa-circle-check"></i></span>
                    <div class="sims-activity-content">
                        <span class="sims-activity-title">Company verification completed</span>
                        <span class="sims-activity-desc">XYZ Pvt Ltd has been verified</span>
                        <span class="sims-activity-time">4 hours ago</span>
                    </div>
                </li>
                <li class="sims-activity-item">
                    <span class="sims-activity-icon sims-activity-icon-amber"><i class="fa-solid fa-file-lines"></i></span>
                    <div class="sims-activity-content">
                        <span class="sims-activity-title">New application received</span>
                        <span class="sims-activity-desc">A student applied for Web Developer Intern</span>
                        <span class="sims-activity-time">6 hours ago</span>
                    </div>
                </li>
            </ul>
        </div>

        <div class="sims-quick-actions">
            <h2 class="sims-card-title">Quick Actions</h2>
            <div class="sims-quick-actions-list">
                <a href="admin-students.aspx" class="sims-quick-btn">
                    <i class="fa-solid fa-user-plus"></i> Add Student
                </a>
                <a href="admin-company-verification.aspx" class="sims-quick-btn">
                    <i class="fa-solid fa-building-circle-check"></i> Verify Company
                </a>
                <a href="admin-internships.aspx" class="sims-quick-btn">
                    <i class="fa-solid fa-briefcase"></i> Add Internship
                </a>
                <a href="admin-student-applications.aspx" class="sims-quick-btn">
                    <i class="fa-solid fa-file-lines"></i> View Applications
                </a>
                <a href="admin-reports-analytics.aspx" class="sims-quick-btn">
                    <i class="fa-solid fa-chart-column"></i> Generate Report
                </a>
            </div>
        </div>

    </div>

</div>
</asp:Content>






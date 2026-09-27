<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-dashboard.aspx.cs" Inherits="asp.net.admin_dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../js/admin-dashboard-charts.js" defer></script>
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
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
                <span class="sims-stat-num-v2">1,245</span>
            </div>
        </div>

        <!-- Card 2: Total Companies -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-blue">
                <i class="fa-solid fa-building"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Total Companies</span>
                <span class="sims-stat-num-v2">128</span>
            </div>
        </div>

        <!-- Card 3: Total Internships -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-green">
                <i class="fa-solid fa-briefcase"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Total Internships</span>
                <span class="sims-stat-num-v2">356</span>
            </div>
        </div>

        <!-- Card 4: Total Applications -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-orange">
                <i class="fa-solid fa-file-lines"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Total Applications</span>
                <span class="sims-stat-num-v2">2,845</span>
            </div>
        </div>

        <!-- Card 5: Pending Verification -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-yellow">
                <i class="fa-solid fa-user-clock"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Pending Verification</span>
                <span class="sims-stat-num-v2">12</span>
            </div>
        </div>

        <!-- Card 6: Upcoming Interviews -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-purple-light">
                <i class="fa-solid fa-calendar-days"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Upcoming Interviews</span>
                <span class="sims-stat-num-v2">84</span>
            </div>
        </div>

        <!-- Card 7: Certificates Issued -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-teal">
                <i class="fa-solid fa-certificate"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Certificates Issued</span>
                <span class="sims-stat-num-v2">216</span>
            </div>
        </div>

        <!-- Card 8: Average Rating -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-pink">
                <i class="fa-solid fa-star"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-title-v2">Average Rating</span>
                <span class="sims-stat-num-v2">4.6 / 5</span>
            </div>
        </div>

    </div>

    <!-- ===================== 3. MIDDLE WIDGETS ROW (3 COLUMNS) ===================== -->
    <div class="sims-widgets-grid-v2">

        <!-- Column 1: Registration Overview -->
        <div class="sims-widget-card-v2">
            <div class="sims-widget-header-v2">
                <h2 class="sims-widget-title-v2">Registration Overview</h2>
                <select class="sims-widget-select-v2">
                    <option>Last 6 Months</option>
                    <option>Last 3 Months</option>
                    <option>This Year</option>
                </select>
            </div>
            <div class="sims-widget-legend-v2">
                <span class="sims-legend-item-v2"><span class="sims-dot-v2 sims-dot-purple"></span> Students</span>
                <span class="sims-legend-item-v2"><span class="sims-dot-v2 sims-dot-cyan"></span> Companies</span>
            </div>
            <div class="sims-chart-container-v2">
                <canvas id="simsRegistrationChart"></canvas>
            </div>
        </div>

        <!-- Column 2: Application Status -->
        <div class="sims-widget-card-v2">
            <div class="sims-widget-header-v2">
                <h2 class="sims-widget-title-v2">Application Status</h2>
            </div>
            <div class="sims-status-donut-flex-v2">
                <div class="sims-donut-wrap-v2">
                    <canvas id="simsApplicationStatusDonut"></canvas>
                    <div class="sims-donut-center-v2">
                        <span class="sims-donut-total-v2">2,845</span>
                        <span class="sims-donut-lbl-v2">Total</span>
                    </div>
                </div>
                <ul class="sims-donut-legend-v2">
                    <li><span class="sims-dot-v2 sims-dot-yellow"></span> Applied <span class="sims-donut-val-v2">1,245 (43.8%)</span></li>
                    <li><span class="sims-dot-v2 sims-dot-blue"></span> Shortlisted <span class="sims-donut-val-v2">645 (22.7%)</span></li>
                    <li><span class="sims-dot-v2 sims-dot-purple"></span> Interview <span class="sims-donut-val-v2">485 (17.1%)</span></li>
                    <li><span class="sims-dot-v2 sims-dot-green"></span> Selected <span class="sims-donut-val-v2">325 (11.4%)</span></li>
                    <li><span class="sims-dot-v2 sims-dot-red"></span> Rejected <span class="sims-donut-val-v2">145 (5.0%)</span></li>
                </ul>
            </div>
        </div>

        <!-- Column 3: Internship Overview -->
        <div class="sims-widget-card-v2">
            <div class="sims-widget-header-v2">
                <h2 class="sims-widget-title-v2">Internship Overview</h2>
            </div>
            <div class="sims-progress-bars-v2">
                
                <div class="sims-pbar-item-v2">
                    <div class="sims-pbar-head-v2">
                        <span>Active Internships</span>
                        <strong>120</strong>
                    </div>
                    <div class="sims-pbar-track-v2">
                        <div class="sims-pbar-fill-v2 sims-fill-green-v2" style="width: 78%;"></div>
                    </div>
                </div>

                <div class="sims-pbar-item-v2">
                    <div class="sims-pbar-head-v2">
                        <span>Pending Approval</span>
                        <strong>35</strong>
                    </div>
                    <div class="sims-pbar-track-v2">
                        <div class="sims-pbar-fill-v2 sims-fill-orange-v2" style="width: 25%;"></div>
                    </div>
                </div>

                <div class="sims-pbar-item-v2">
                    <div class="sims-pbar-head-v2">
                        <span>Completed</span>
                        <strong>72</strong>
                    </div>
                    <div class="sims-pbar-track-v2">
                        <div class="sims-pbar-fill-v2 sims-fill-blue-v2" style="width: 48%;"></div>
                    </div>
                </div>

                <div class="sims-pbar-item-v2">
                    <div class="sims-pbar-head-v2">
                        <span>Expired</span>
                        <strong>18</strong>
                    </div>
                    <div class="sims-pbar-track-v2">
                        <div class="sims-pbar-fill-v2 sims-fill-red-v2" style="width: 15%;"></div>
                    </div>
                </div>

                <div class="sims-pbar-item-v2">
                    <div class="sims-pbar-head-v2">
                        <span>Rejected</span>
                        <strong>11</strong>
                    </div>
                    <div class="sims-pbar-track-v2">
                        <div class="sims-pbar-fill-v2 sims-fill-slate-v2" style="width: 9%;"></div>
                    </div>
                </div>

            </div>

            <div class="sims-widget-footer-v2">
                <a href="admin-internships.aspx" class="sims-footer-link-v2">View All Internships &rarr;</a>
            </div>
        </div>

    </div>

    <!-- ===================== 4. RECENT TABLES ROW ===================== -->
    <div class="sims-recent-row-v2">

        <!-- Recent Applications -->
        <div class="sims-widget-card-v2">
            <div class="sims-widget-header-v2">
                <h2 class="sims-widget-title-v2">Recent Applications</h2>
                <a href="admin-applications.aspx" class="sims-footer-link-v2">View All Applications &rarr;</a>
            </div>
            <p class="sims-recent-sub-v2">Latest internship applications submitted by students</p>
            <div class="sims-table-responsive-v2">
                <table class="sims-recent-table-v2">
                    <thead>
                        <tr>
                            <th>STUDENT</th>
                            <th>INTERNSHIP</th>
                            <th>COMPANY</th>
                            <th>APPLIED DATE</th>
                            <th>STATUS</th>
                            <th>ACTION</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="sims-avatar-cell-v2">
                                    <span class="sims-avatar-v2 sims-av-purple">DP</span>
                                    Dhruvi Patel
                                </div>
                            </td>
                            <td class="sims-link-cell-v2"><a href="#">Web Developer Intern</a></td>
                            <td>ABC Technologies</td>
                            <td>18 Aug 2026</td>
                            <td><span class="sims-badge-v2 sims-badge-pending">Pending</span></td>
                            <td><a href="#" class="sims-action-icon-v2" title="View"><i class="fa-regular fa-eye"></i></a></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="sims-avatar-cell-v2">
                                    <span class="sims-avatar-v2 sims-av-blue">RS</span>
                                    Rahul Shah
                                </div>
                            </td>
                            <td class="sims-link-cell-v2"><a href="#">.NET Developer Intern</a></td>
                            <td>TechSoft Pvt Ltd</td>
                            <td>17 Aug 2026</td>
                            <td><span class="sims-badge-v2 sims-badge-selected">Selected</span></td>
                            <td><a href="#" class="sims-action-icon-v2" title="View"><i class="fa-regular fa-eye"></i></a></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="sims-avatar-cell-v2">
                                    <span class="sims-avatar-v2 sims-av-green">PM</span>
                                    Priya Mehta
                                </div>
                            </td>
                            <td class="sims-link-cell-v2"><a href="#">UI/UX Design Intern</a></td>
                            <td>Innovate Labs</td>
                            <td>17 Aug 2026</td>
                            <td><span class="sims-badge-v2 sims-badge-shortlisted">Shortlisted</span></td>
                            <td><a href="#" class="sims-action-icon-v2" title="View"><i class="fa-regular fa-eye"></i></a></td>
                        </tr>
                        <tr>
                            <td>
                                <div class="sims-avatar-cell-v2">
                                    <span class="sims-avatar-v2 sims-av-orange">AP</span>
                                    Aarav Patel
                                </div>
                            </td>
                            <td class="sims-link-cell-v2"><a href="#">Data Analyst Intern</a></td>
                            <td>DataTech Solutions</td>
                            <td>16 Aug 2026</td>
                            <td><span class="sims-badge-v2 sims-badge-rejected">Rejected</span></td>
                            <td><a href="#" class="sims-action-icon-v2" title="View"><i class="fa-regular fa-eye"></i></a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Recent Companies -->
        <div class="sims-widget-card-v2 sims-recent-companies-v2">
            <div class="sims-widget-header-v2">
                <h2 class="sims-widget-title-v2">Recent Companies</h2>
                <a href="admin-companies.aspx" class="sims-footer-link-v2">View All Companies &rarr;</a>
            </div>
            <p class="sims-recent-sub-v2">Newly registered companies</p>
            <div class="sims-company-list-v2">

                <div class="sims-company-item-v2">
                    <div class="sims-company-logo-v2"><i class="fa-solid fa-building"></i></div>
                    <div class="sims-company-info-v2">
                        <span class="sims-company-name-v2">ABC Technologies</span>
                        <span class="sims-company-meta-v2">Information Technology &middot; 18 Aug 2026</span>
                    </div>
                    <span class="sims-badge-v2 sims-badge-selected">Verified</span>
                </div>

                <div class="sims-company-item-v2">
                    <div class="sims-company-logo-v2"><i class="fa-solid fa-building"></i></div>
                    <div class="sims-company-info-v2">
                        <span class="sims-company-name-v2">TechSoft Pvt Ltd</span>
                        <span class="sims-company-meta-v2">Software Development &middot; 17 Aug 2026</span>
                    </div>
                    <span class="sims-badge-v2 sims-badge-selected">Verified</span>
                </div>

                <div class="sims-company-item-v2">
                    <div class="sims-company-logo-v2"><i class="fa-solid fa-building"></i></div>
                    <div class="sims-company-info-v2">
                        <span class="sims-company-name-v2">Innovate Labs</span>
                        <span class="sims-company-meta-v2">Technology &middot; 16 Aug 2026</span>
                    </div>
                    <span class="sims-badge-v2 sims-badge-pending">Pending</span>
                </div>

                <div class="sims-company-item-v2">
                    <div class="sims-company-logo-v2"><i class="fa-solid fa-building"></i></div>
                    <div class="sims-company-info-v2">
                        <span class="sims-company-name-v2">DataTech Solutions</span>
                        <span class="sims-company-meta-v2">Data Analytics &middot; 15 Aug 2026</span>
                    </div>
                    <span class="sims-badge-v2 sims-badge-selected">Verified</span>
                </div>

            </div>
        </div>

    </div>

</div>
</asp:Content>

<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeFile="student-dashboard.aspx.cs" Inherits="asp.net.student_dashboard" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/student-dashboard.css") %>" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-dashboard">

        <!-- ===================== 1. PAGE HEADER ===================== -->
        <div class="student-dashboard-header">
            <div>
                <h1 class="student-dashboard-title">Student Dashboard</h1>
                <p class="student-dashboard-subtitle">Welcome back! Here's an overview of your internship activities.</p>
            </div>
            <div>
                <a href="student-profile.aspx" class="student-header-btn">
                    <i class="fa-solid fa-user"></i> View Profile
                </a>
            </div>
        </div>

        <!-- ===================== 2. WELCOME CARD & PROFILE COMPLETION ===================== -->
        <div class="student-welcome-card">
            <div class="student-welcome-top">
                <div>
                    <h2 class="student-welcome-greeting">
                        👋 Welcome back, <asp:Literal ID="litStudentName" runat="server" Text="Dhruvi Patel" />!
                    </h2>
                    <p class="student-welcome-desc">
                        Keep your profile updated to improve your internship opportunities and AI recommendations.
                    </p>
                </div>
                <span class="student-welcome-badge">
                    <i class="fa-solid fa-circle-check"></i> Account Verified
                </span>
            </div>

            <div class="student-progress-wrapper">
                <div class="student-progress-info">
                    <span>Profile Completion</span>
                    <span><asp:Literal ID="litProfileCompletion" runat="server" Text="85" />%</span>
                </div>
                <div class="student-progress-track">
                    <div class="student-progress-fill" id="profileProgressFill" style="width: 0%;" data-percentage="85%"></div>
                </div>
                <div class="student-progress-foot">
                    <span class="student-progress-note">
                        Complete your profile to improve internship opportunities. Missing: Resume, Secondary Skills.
                    </span>
                    <a href="student-profile-completion.aspx" class="student-welcome-btn">
                        <i class="fa-solid fa-user-pen"></i> Complete Profile
                    </a>
                </div>
            </div>
        </div>

        <!-- ===================== 3. QUICK STATISTICS ===================== -->
        <div class="student-statistics">
            
            <!-- CARD 1: Applied -->
            <a href="student-my-applications.aspx" class="student-stat-card">
                <div class="student-stat-info">
                    <span class="student-stat-label">Applied</span>
                    <span class="student-stat-value"><asp:Literal ID="litAppliedCount" runat="server" Text="12" /></span>
                    <span class="student-stat-desc">Total Applications</span>
                </div>
                <div class="student-stat-icon student-stat-icon-blue">
                    <i class="fa-solid fa-briefcase"></i>
                </div>
            </a>

            <!-- CARD 2: Selected -->
            <a href="student-my-applications.aspx" class="student-stat-card">
                <div class="student-stat-info">
                    <span class="student-stat-label">Selected</span>
                    <span class="student-stat-value"><asp:Literal ID="litSelectedCount" runat="server" Text="3" /></span>
                    <span class="student-stat-desc">Internship Offers</span>
                </div>
                <div class="student-stat-icon student-stat-icon-green">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
            </a>

            <!-- CARD 3: Interviews -->
            <a href="student-interviews.aspx" class="student-stat-card">
                <div class="student-stat-info">
                    <span class="student-stat-label">Interviews</span>
                    <span class="student-stat-value"><asp:Literal ID="litInterviewsCount" runat="server" Text="2" /></span>
                    <span class="student-stat-desc">Scheduled Dates</span>
                </div>
                <div class="student-stat-icon student-stat-icon-purple">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
            </a>

            <!-- CARD 4: Pending -->
            <a href="student-my-applications.aspx" class="student-stat-card">
                <div class="student-stat-info">
                    <span class="student-stat-label">Pending</span>
                    <span class="student-stat-value"><asp:Literal ID="litPendingCount" runat="server" Text="5" /></span>
                    <span class="student-stat-desc">Under Review</span>
                </div>
                <div class="student-stat-icon student-stat-icon-orange">
                    <i class="fa-solid fa-clock"></i>
                </div>
            </a>

        </div>

        <!-- ===================== 4. APPLICATION ANALYTICS (2 COLUMNS) ===================== -->
        <div class="student-analytics-grid">
            
            <!-- LEFT: APPLICATION OVERVIEW (DOUGHNUT CHART) -->
            <div class="student-dashboard-card">
                <div class="student-card-header">
                    <h3 class="student-card-title">
                        <i class="fa-solid fa-chart-pie"></i> Application Overview
                    </h3>
                </div>
                <div class="student-chart-container">
                    <canvas id="applicationOverviewChart" data-selected="3" data-pending="5" data-rejected="4"></canvas>
                </div>
            </div>

            <!-- RIGHT: APPLICATION STATUS SUMMARY -->
            <div class="student-dashboard-card">
                <div class="student-card-header">
                    <h3 class="student-card-title">
                        <i class="fa-solid fa-list-check"></i> Application Status
                    </h3>
                </div>
                <div class="student-status-list">
                    <div class="student-status-item">
                        <div class="student-status-left">
                            <span class="student-status-badge badge-selected">✓ Selected</span>
                            <span>Selected Internships</span>
                        </div>
                        <span class="student-status-count"><asp:Literal ID="litStatusSelected" runat="server" Text="3" /></span>
                    </div>

                    <div class="student-status-item">
                        <div class="student-status-left">
                            <span class="student-status-badge badge-pending">⏳ Pending</span>
                            <span>Applications Under Review</span>
                        </div>
                        <span class="student-status-count"><asp:Literal ID="litStatusPending" runat="server" Text="5" /></span>
                    </div>

                    <div class="student-status-item">
                        <div class="student-status-left">
                            <span class="student-status-badge badge-rejected">✕ Rejected</span>
                            <span>Not Shortlisted</span>
                        </div>
                        <span class="student-status-count"><asp:Literal ID="litStatusRejected" runat="server" Text="4" /></span>
                    </div>
                </div>
            </div>

        </div>

        <!-- ===================== 5. RECENT APPLICATIONS ===================== -->
        <div class="student-dashboard-card">
            <div class="student-card-header">
                <h3 class="student-card-title">
                    <i class="fa-solid fa-file-lines"></i> Recent Applications
                </h3>
                <a href="student-my-applications.aspx" class="student-card-link">View All Applications &rarr;</a>
            </div>

            <asp:Panel ID="pnlApplicationsTable" runat="server">
                <div class="student-table-responsive">
                    <table class="student-application-table">
                        <thead>
                            <tr>
                                <th>Company</th>
                                <th>Internship Position</th>
                                <th>Applied Date</th>
                                <th>Status</th>
                                <th style="text-align: right;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="student-company-cell">
                                        <div class="student-company-logo">TC</div>
                                        <span>TechCorp Ltd</span>
                                    </div>
                                </td>
                                <td><strong>Web Developer Intern</strong></td>
                                <td>20 Aug 2026</td>
                                <td><span class="student-status-badge badge-pending">Pending</span></td>
                                <td style="text-align: right;">
                                    <a href="student-application-status.aspx?id=1" class="student-btn-action">View</a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="student-company-cell">
                                        <div class="student-company-logo" style="background-color:#F0FDF4; color:#16A34A;">INF</div>
                                        <span>Infosys</span>
                                    </div>
                                </td>
                                <td><strong>Software Developer Intern</strong></td>
                                <td>18 Aug 2026</td>
                                <td><span class="student-status-badge badge-selected">Selected</span></td>
                                <td style="text-align: right;">
                                    <a href="student-application-status.aspx?id=2" class="student-btn-action">View</a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="student-company-cell">
                                        <div class="student-company-logo" style="background-color:#FEF2F2; color:#EF4444;">ABC</div>
                                        <span>ABC Technologies</span>
                                    </div>
                                </td>
                                <td><strong>UI/UX Intern</strong></td>
                                <td>15 Aug 2026</td>
                                <td><span class="student-status-badge badge-rejected">Rejected</span></td>
                                <td style="text-align: right;">
                                    <a href="student-application-status.aspx?id=3" class="student-btn-action">View</a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="student-company-cell">
                                        <div class="student-company-logo" style="background-color:#EFF6FF; color:#2563EB;">WIP</div>
                                        <span>Wipro Solutions</span>
                                    </div>
                                </td>
                                <td><strong>Data Analyst Intern</strong></td>
                                <td>10 Aug 2026</td>
                                <td><span class="student-status-badge badge-pending">Pending</span></td>
                                <td style="text-align: right;">
                                    <a href="student-application-status.aspx?id=4" class="student-btn-action">View</a>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="student-company-cell">
                                        <div class="student-company-logo" style="background-color:#F0FDF4; color:#16A34A;">TCS</div>
                                        <span>Tata Consultancy Services</span>
                                    </div>
                                </td>
                                <td><strong>Cloud Engineer Intern</strong></td>
                                <td>05 Aug 2026</td>
                                <td><span class="student-status-badge badge-selected">Selected</span></td>
                                <td style="text-align: right;">
                                    <a href="student-application-status.aspx?id=5" class="student-btn-action">View</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </asp:Panel>

            <!-- EMPTY STATE (Hidden by default, shown if no applications) -->
            <div class="student-empty-state" id="emptyApplications" runat="server" visible="false">
                <div class="student-empty-icon"><i class="fa-solid fa-folder-open"></i></div>
                <h4 class="student-empty-title">No internship applications found yet.</h4>
                <a href="student-internships.aspx" class="student-btn-browse">
                    <i class="fa-solid fa-magnifying-glass"></i> Browse Internships
                </a>
            </div>
        </div>

        <!-- ===================== 6. TWO-COLUMN GRID: INTERVIEWS & NOTIFICATIONS ===================== -->
        <div class="student-two-col-grid">
            
            <!-- LEFT: UPCOMING INTERVIEWS -->
            <div class="student-dashboard-card">
                <div class="student-card-header">
                    <h3 class="student-card-title">
                        <i class="fa-solid fa-calendar-check"></i> Upcoming Interviews
                    </h3>
                    <a href="student-interviews.aspx" class="student-card-link">View Schedule &rarr;</a>
                </div>

                <div class="student-interviews-list">
                    <div class="student-interview-card">
                        <div class="student-interview-date">
                            <span class="student-interview-day">25</span>
                            <span class="student-interview-month">AUG</span>
                        </div>
                        <div class="student-interview-details">
                            <h4 class="student-interview-title">Web Developer Interview</h4>
                            <p class="student-interview-company">TechCorp Ltd</p>
                            <div class="student-interview-meta">
                                <span><i class="fa-solid fa-clock"></i> 11:00 AM</span>
                                <span>&bull;</span>
                                <span><i class="fa-solid fa-video"></i> Online Interview</span>
                            </div>
                        </div>
                    </div>

                    <div class="student-interview-card">
                        <div class="student-interview-date" style="background-color:#F0FDF4; color:#16A34A;">
                            <span class="student-interview-day">28</span>
                            <span class="student-interview-month">AUG</span>
                        </div>
                        <div class="student-interview-details">
                            <h4 class="student-interview-title">Software Engineer Interview</h4>
                            <p class="student-interview-company">Infosys</p>
                            <div class="student-interview-meta">
                                <span><i class="fa-solid fa-clock"></i> 02:30 PM</span>
                                <span>&bull;</span>
                                <span><i class="fa-solid fa-building"></i> In-Person (Ahmedabad)</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- EMPTY STATE -->
                <div class="student-empty-state" id="emptyInterviews" runat="server" visible="false">
                    <div class="student-empty-icon"><i class="fa-solid fa-calendar-xmark"></i></div>
                    <h4 class="student-empty-title">No upcoming interviews scheduled.</h4>
                    <a href="student-internships.aspx" class="student-btn-browse">Browse Internships</a>
                </div>
            </div>

            <!-- RIGHT: RECENT NOTIFICATIONS -->
            <div class="student-dashboard-card">
                <div class="student-card-header">
                    <h3 class="student-card-title">
                        <i class="fa-solid fa-bell"></i> Recent Notifications
                    </h3>
                    <a href="student-notifications.aspx" class="student-card-link">View All &rarr;</a>
                </div>

                <div class="student-notifications-list">
                    <div class="student-notification-item is-unread">
                        <div class="student-notification-icon"><i class="fa-solid fa-circle-check"></i></div>
                        <div class="student-notification-content">
                            <p class="student-notification-text">Your application for <strong>TechCorp Ltd</strong> has been shortlisted.</p>
                            <span class="student-notification-time">10 minutes ago</span>
                        </div>
                    </div>

                    <div class="student-notification-item">
                        <div class="student-notification-icon"><i class="fa-solid fa-briefcase"></i></div>
                        <div class="student-notification-content">
                            <p class="student-notification-text">New internship matching your skills: <strong>React Developer</strong> at WebSoft.</p>
                            <span class="student-notification-time">2 hours ago</span>
                        </div>
                    </div>

                    <div class="student-notification-item">
                        <div class="student-notification-icon"><i class="fa-solid fa-calendar"></i></div>
                        <div class="student-notification-content">
                            <p class="student-notification-text">Interview scheduled with <strong>TechCorp Ltd</strong> for Web Developer role.</p>
                            <span class="student-notification-time">Yesterday</span>
                        </div>
                    </div>

                    <div class="student-notification-item">
                        <div class="student-notification-icon"><i class="fa-solid fa-user-check"></i></div>
                        <div class="student-notification-content">
                            <p class="student-notification-text">Your student profile was updated successfully.</p>
                            <span class="student-notification-time">2 days ago</span>
                        </div>
                    </div>
                </div>

                <!-- EMPTY STATE -->
                <div class="student-empty-state" id="emptyNotifications" runat="server" visible="false">
                    <div class="student-empty-icon"><i class="fa-solid fa-bell-slash"></i></div>
                    <h4 class="student-empty-title">You're all caught up! No new notifications.</h4>
                </div>
            </div>

        </div>

        <!-- ===================== 7. RECOMMENDED INTERNSHIPS ===================== -->
        <div class="student-dashboard-card">
            <div class="student-card-header">
                <h3 class="student-card-title">
                    <i class="fa-solid fa-thumbs-up"></i> Recommended Internships
                </h3>
                <a href="student-internships.aspx" class="student-card-link">Browse All Internships &rarr;</a>
            </div>

            <div class="student-recommended-grid">
                
                <!-- CARD 1 -->
                <div class="student-internship-card">
                    <div>
                        <div class="student-internship-head">
                            <div>
                                <h4 class="student-internship-title">Web Developer Intern</h4>
                                <span class="student-internship-company">TechCorp Ltd</span>
                            </div>
                            <span class="student-status-badge badge-selected" style="font-size:11px;">Full-time</span>
                        </div>

                        <div class="student-internship-tags">
                            <span><i class="fa-solid fa-location-dot"></i> Ahmedabad</span>
                            <span>&bull;</span>
                            <span><i class="fa-solid fa-clock"></i> 3 Months</span>
                        </div>

                        <div class="student-internship-skills">
                            <i class="fa-solid fa-code"></i>
                            <span>.NET</span> <span>C#</span> <span>SQL</span>
                        </div>
                    </div>

                    <div class="student-internship-foot">
                        <span class="student-internship-stipend">₹ 10,000 / mo</span>
                        <a href="student-internship-details.aspx?id=101" class="student-internship-btn">View Details</a>
                    </div>
                </div>

                <!-- CARD 2 -->
                <div class="student-internship-card">
                    <div>
                        <div class="student-internship-head">
                            <div>
                                <h4 class="student-internship-title">UI/UX Design Intern</h4>
                                <span class="student-internship-company">DesignHub Solutions</span>
                            </div>
                            <span class="student-status-badge badge-pending" style="font-size:11px;">Hybrid</span>
                        </div>

                        <div class="student-internship-tags">
                            <span><i class="fa-solid fa-location-dot"></i> Ahmedabad</span>
                            <span>&bull;</span>
                            <span><i class="fa-solid fa-clock"></i> 3 Months</span>
                        </div>

                        <div class="student-internship-skills">
                            <i class="fa-solid fa-code"></i>
                            <span>Figma</span> <span>Adobe XD</span> <span>CSS</span>
                        </div>
                    </div>

                    <div class="student-internship-foot">
                        <span class="student-internship-stipend">₹ 12,000 / mo</span>
                        <a href="student-internship-details.aspx?id=102" class="student-internship-btn">View Details</a>
                    </div>
                </div>

                <!-- CARD 3 -->
                <div class="student-internship-card">
                    <div>
                        <div class="student-internship-head">
                            <div>
                                <h4 class="student-internship-title">Software Developer Intern</h4>
                                <span class="student-internship-company">ABC Technologies</span>
                            </div>
                            <span class="student-status-badge badge-selected" style="font-size:11px;">Remote</span>
                        </div>

                        <div class="student-internship-tags">
                            <span><i class="fa-solid fa-location-dot"></i> Remote</span>
                            <span>&bull;</span>
                            <span><i class="fa-solid fa-clock"></i> 6 Months</span>
                        </div>

                        <div class="student-internship-skills">
                            <i class="fa-solid fa-code"></i>
                            <span>Python</span> <span>React</span> <span>Node.js</span>
                        </div>
                    </div>

                    <div class="student-internship-foot">
                        <span class="student-internship-stipend">₹ 15,000 / mo</span>
                        <a href="student-internship-details.aspx?id=103" class="student-internship-btn">View Details</a>
                    </div>
                </div>

            </div>

            <!-- EMPTY STATE -->
            <div class="student-empty-state" id="emptyRecommendations" runat="server" visible="false">
                <div class="student-empty-icon"><i class="fa-solid fa-lightbulb"></i></div>
                <h4 class="student-empty-title">No recommendations available right now. Update your profile skills to get matched!</h4>
                <a href="student-profile.aspx" class="student-btn-browse">Update Profile Skills</a>
            </div>
        </div>

    </div>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="<%= ResolveUrl("~/js/student-dashboard.js") %>"></script>
</asp:Content>

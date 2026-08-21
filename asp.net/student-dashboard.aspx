<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="student-dashboard.aspx.cs" Inherits="asp.net.student_dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Welcome banner -->
    <div class="welcome-banner">
        <div>
            <h2 id="welcomeHeading">Welcome back, <asp:Literal ID="litWelcomeStudentName" runat="server" Text="Student" />! 👋</h2>
            <p>You have 2 shortlisted applications and 1 interview coming up this week. Keep up the great work!</p>
            <div class="welcome-date" id="welcomeDate"><asp:Literal ID="litToday" runat="server" /></div>
        </div>
    </div>

    <!-- Profile card + Stat cards -->
    <div class="dashboard-grid-top">

        <!-- Student Profile Card -->
        <div class="profile-card">
            <div class="dash-avatar-lg" id="dashAvatarLg">ST</div>
            <h3 id="profileName"><asp:Literal ID="litProfileName" runat="server" Text="Student" /></h3>
            <span class="profile-role" id="profileEnrollment">Verified Student</span>
            <ul class="profile-meta-list">
                <li><i class="fa-solid fa-envelope"></i> <span id="profileEmail"><asp:Literal ID="litProfileEmail" runat="server" Text="student@sims.com" /></span></li>
                <li><i class="fa-solid fa-graduation-cap"></i> <span id="profileCourse">Computer Engineering</span></li>
                <li><i class="fa-solid fa-building-columns"></i> <span id="profileCollege">Main University</span></li>
                <li><i class="fa-solid fa-check-circle"></i> <span>Account Active</span></li>
            </ul>
            <a href="my-profile.aspx" class="btn btn-primary">View / Edit Profile</a>
        </div>

        <!-- Dashboard stat cards + Quick actions -->
        <div>
            <div class="stat-cards-grid" style="margin-bottom:20px; display:grid; grid-template-columns:repeat(auto-fit, minmax(140px, 1fr)); gap:16px;">
                <div class="dash-stat-card">
                    <span class="dash-stat-icon icon-blue"><i class="fa-solid fa-paper-plane"></i></span>
                    <h4 id="studentTotalApps">12</h4>
                    <p>Applications Sent</p>
                </div>
                <div class="dash-stat-card">
                    <span class="dash-stat-icon icon-green"><i class="fa-solid fa-circle-check"></i></span>
                    <h4 id="studentShortlisted">3</h4>
                    <p>Shortlisted</p>
                </div>
                <div class="dash-stat-card">
                    <span class="dash-stat-icon icon-purple"><i class="fa-solid fa-calendar-days"></i></span>
                    <h4 id="studentInterviewsScheduled">2</h4>
                    <p>Interviews Scheduled</p>
                </div>
                <div class="dash-stat-card">
                    <span class="dash-stat-icon icon-orange"><i class="fa-solid fa-award"></i></span>
                    <h4 id="studentCertificates">4</h4>
                    <p>Certificates Earned</p>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions-card">
                <h3>Quick Actions</h3>
                <div class="quick-actions-grid" style="display:grid; grid-template-columns:repeat(auto-fit, minmax(160px, 1fr)); gap:12px; margin-top:12px;">
                    <a href="internships.aspx" class="btn btn-outline" style="justify-content:flex-start; text-decoration:none;"><i class="fa-solid fa-magnifying-glass"></i> Browse Internships</a>
                    <a href="my-profile.aspx" class="btn btn-outline" style="justify-content:flex-start; text-decoration:none;"><i class="fa-solid fa-user-pen"></i> Update Profile</a>
                    <a href="my-applications.aspx" class="btn btn-outline" style="justify-content:flex-start; text-decoration:none;"><i class="fa-solid fa-clipboard-list"></i> My Applications</a>
                    <a href="certificates-documents.aspx" class="btn btn-outline" style="justify-content:flex-start; text-decoration:none;"><i class="fa-solid fa-certificate"></i> View Certificates</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Applications + Right rail (Interviews / Notifications) -->
    <div class="dashboard-grid-bottom" style="margin-top:24px; display:grid; grid-template-columns: 2fr 1fr; gap:24px;">

        <!-- Left: Recent Applications -->
        <div>
            <div class="dash-panel">
                <div class="dash-panel-header" style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                    <h3>Recent Applications</h3>
                    <a href="my-applications.aspx">View All</a>
                </div>
                <table class="applications-table" id="applicationsTable" style="width:100%;">
                    <thead>
                        <tr style="text-align:left; border-bottom:1px solid #e2e8f0;">
                            <th style="padding:10px;">Company</th>
                            <th style="padding:10px;">Role</th>
                            <th style="padding:10px;">Applied On</th>
                            <th style="padding:10px;">Status</th>
                        </tr>
                    </thead>
                    <tbody id="applicationsTableBody">
                        <tr style="border-bottom:1px solid #f1f5f9;">
                            <td style="padding:10px;"><strong>TechNova Pvt Ltd</strong></td>
                            <td style="padding:10px;">Frontend Developer Intern</td>
                            <td style="padding:10px;">15 Jul 2026</td>
                            <td style="padding:10px;"><span class="co-badge" style="background:#eff6ff; color:#2563eb;">Under Review</span></td>
                        </tr>
                        <tr style="border-bottom:1px solid #f1f5f9;">
                            <td style="padding:10px;"><strong>Bright Solutions</strong></td>
                            <td style="padding:10px;">Data Analyst Intern</td>
                            <td style="padding:10px;">14 Jul 2026</td>
                            <td style="padding:10px;"><span class="co-badge" style="background:#f0fdf4; color:#16a34a;">Shortlisted</span></td>
                        </tr>
                        <tr style="border-bottom:1px solid #f1f5f9;">
                            <td style="padding:10px;"><strong>DesignStudio Co.</strong></td>
                            <td style="padding:10px;">UI/UX Design Intern</td>
                            <td style="padding:10px;">10 Jul 2026</td>
                            <td style="padding:10px;"><span class="co-badge" style="background:#fefce8; color:#ca8a04;">Interview</span></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Right rail -->
        <div>
            <!-- Upcoming Interviews -->
            <div class="dash-panel" style="margin-bottom:20px;">
                <div class="dash-panel-header" style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                    <h3>Upcoming Interviews</h3>
                    <a href="interview-schedule.aspx">View All</a>
                </div>
                <div id="upcomingInterviewsList">
                    <div class="co-interview-item" style="display:flex; gap:12px; margin-bottom:12px;">
                        <div class="co-date-box" style="background:#eff6ff; padding:8px 12px; border-radius:8px; text-align:center;"><span class="day" style="display:block; font-weight:700;">22</span><span class="mon" style="font-size:11px;">Jul</span></div>
                        <div class="co-interview-info">
                            <h4 style="margin:0; font-size:14px;">Frontend Dev Interview</h4>
                            <p style="margin:2px 0; font-size:12px; color:#64748b;">TechNova Pvt Ltd &bull; 11:00 AM</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Notifications -->
            <div class="dash-panel">
                <div class="dash-panel-header" style="display:flex; justify-content:space-between; align-items:center; margin-bottom:16px;">
                    <h3>Notifications</h3>
                    <a href="notifications.aspx">View All</a>
                </div>
                <div id="dashNotificationsList">
                    <div class="co-notif-item" style="display:flex; gap:10px; margin-bottom:10px;">
                        <div class="co-notif-icon" style="background:#eff6ff; color:#2563eb; width:32px; height:32px; border-radius:50%; display:flex; align-items:center; justify-content:center;"><i class="fa-solid fa-bell"></i></div>
                        <div><p style="margin:0; font-size:12.5px;">Your application for <strong>TechNova Pvt Ltd</strong> was shortlisted.</p><span style="font-size:11px; color:#94a3b8;">2 hours ago</span></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>


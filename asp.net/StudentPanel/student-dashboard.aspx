<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-dashboard.aspx.cs" Inherits="asp.net.student_dashboard" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/student-dashboard.css") %>" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header (Identical to Company Dashboard with student actions) -->
    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 16px; margin-bottom: 24px;">
        <div>
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Dashboard</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Welcome back, <asp:Label ID="litWelcomeName" runat="server" Text="Student" />! Here's your internship & career progress overview.</p>
        </div>
        <div style="display: flex; gap: 10px; flex-wrap: wrap;">
            <a href="<%= ResolveUrl("~/StudentPanel/student-internships.aspx") %>" style="padding: 10px 18px; background: #2563eb; color: #fff; border-radius: 8px; font-size: 13.5px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 7px; transition: background 0.15s ease;">
                <i class="fa-solid fa-magnifying-glass"></i> Browse Internships
            </a>
            <a href="<%= ResolveUrl("~/StudentPanel/student-profile.aspx") %>" style="padding: 10px 18px; background: #ffffff; color: #334155; border: 1px solid #cbd5e1; border-radius: 8px; font-size: 13.5px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 7px; transition: background 0.15s ease;">
                <i class="fa-solid fa-user"></i> View Profile
            </a>
        </div>
    </div>
    <!-- 8 Top KPI Stat Cards Grid (Exactly same layout & styling as Company Panel `sims-stat-grid-v2`) -->
    <div class="sims-stat-grid-v2" style="margin-bottom: 24px;">
        <!-- Card 1: Total Applied -->
        <a href="student-my-applications.aspx" class="sims-stat-card-v2" style="text-decoration:none; color:inherit;">
            <div class="sims-stat-icon-v2 sims-bg-blue">
                <i class="fa-solid fa-paper-plane"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblTotalApplied" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Total Applications</span>
            </div>
        </a>
        <!-- Card 2: Under Review / Pending -->
        <a href="student-my-applications.aspx" class="sims-stat-card-v2" style="text-decoration:none; color:inherit;">
            <div class="sims-stat-icon-v2 sims-bg-orange">
                <i class="fa-solid fa-clock"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblPendingCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Under Review</span>
            </div>
        </a>
        <!-- Card 3: Shortlisted -->
        <a href="student-my-applications.aspx" class="sims-stat-card-v2" style="text-decoration:none; color:inherit;">
            <div class="sims-stat-icon-v2 sims-bg-purple">
                <i class="fa-solid fa-star"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblShortlistedCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Shortlisted</span>
            </div>
        </a>
        <!-- Card 4: Selected / Offers -->
        <a href="student-my-applications.aspx" class="sims-stat-card-v2" style="text-decoration:none; color:inherit;">
            <div class="sims-stat-icon-v2 sims-bg-green">
                <i class="fa-solid fa-user-check"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblSelectedCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Selected / Offers</span>
            </div>
        </a>
        <!-- Card 5: Interviews Scheduled -->
        <a href="student-interviews.aspx" class="sims-stat-card-v2" style="text-decoration:none; color:inherit;">
            <div class="sims-stat-icon-v2 sims-bg-yellow">
                <i class="fa-solid fa-calendar-check"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblInterviewsCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Interviews Scheduled</span>
            </div>
        </a>
        <!-- Card 6: Offers Received -->
        <a href="student-offer-letters.aspx" class="sims-stat-card-v2" style="text-decoration:none; color:inherit;">
            <div class="sims-stat-icon-v2 sims-bg-purple-light">
                <i class="fa-solid fa-file-signature"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblOffersCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Offer Letters</span>
            </div>
        </a>
        <!-- Card 7: Assigned Tasks / Quizzes -->
        <a href="student-tasks.aspx" class="sims-stat-card-v2" style="text-decoration:none; color:inherit;">
            <div class="sims-stat-icon-v2 sims-bg-teal">
                <i class="fa-solid fa-list-check"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblTasksCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Tasks & Quizzes</span>
            </div>
        </a>
        <!-- Card 8: Saved / Bookmarked Internships -->
        <a href="student-saved-internships.aspx" class="sims-stat-card-v2" style="text-decoration:none; color:inherit;">
            <div class="sims-stat-icon-v2 sims-bg-pink">
                <i class="fa-solid fa-bookmark"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblSavedCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Saved Internships</span>
            </div>
        </a>
    </div>
    <!-- Charts Row: 2 Column Panels (Application Status Overview & Interview Status Overview) -->
    <div class="co-grid-2" style="margin-bottom:26px;">
        <!-- Application Status Donut Chart -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-chart-pie" style="color:#2563eb; margin-right:8px;"></i> Application Status Overview</h3>
            </div>
            <div style="position:relative; height:240px; display:flex; justify-content:center; align-items:center; padding:10px 0;">
                <canvas id="studentStatusChart"
                        data-selected='<%= totalSelected %>'
                        data-pending='<%= totalPending %>'
                        data-rejected='<%= totalRejected %>'></canvas>
            </div>
        </div>
        <!-- Interview Status Overview Chart (Bar Chart) -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-chart-column" style="color:#7c3aed; margin-right:8px;"></i> Interview Status Overview</h3>
            </div>
            <div style="position:relative; height:240px; display:flex; justify-content:center; align-items:center; padding:10px 0;">
                <canvas id="studentInterviewChart"
                        data-scheduled='<%= intScheduled %>'
                        data-completed='<%= intCompleted %>'
                        data-cancelled='<%= intCancelled %>'></canvas>
            </div>
        </div>
    </div>
    <!-- ===================== RECENT APPLICATIONS (FULL WIDTH TABLE) ===================== -->
    <div class="co-panel" style="margin-bottom: 26px; width: 100%;">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-file-lines" style="color: #2563eb; margin-right: 8px;"></i> My Recent Applications</h3>
            <a href="<%= ResolveUrl("~/StudentPanel/student-my-applications.aspx") %>" style="display: inline-flex; align-items: center; gap: 6px; font-weight: 600;">
                View All <i class="fa-solid fa-arrow-right" style="font-size: 11px;"></i>
            </a>
        </div>
        <div style="overflow-x: auto; width: 100%;">
            <asp:GridView ID="gvRecentApps" runat="server" AutoGenerateColumns="False" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="Company" HeaderStyle-Width="25%">
                        <ItemTemplate>
                            <div class="co-applicant-cell">
                                <div class="co-applicant-avatar av1">
                                    <%# GetCompanyLogoHtml(Eval("c_logo"), Eval("c_company")) %>
                                </div>
                                <div>
                                    <div style="font-weight: 700; color: #0f172a;"><%# Server.HtmlEncode(Eval("c_company") != null ? Eval("c_company").ToString() : "Partner Company") %></div>
                                    <div style="font-size: 11.5px; color: #64748b;"><%# Server.HtmlEncode(Eval("Location") != null ? Eval("Location").ToString() : "Remote") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Internship Position" HeaderStyle-Width="27%">
                        <ItemTemplate>
                            <div style="font-weight: 600; color: #1e293b;"><%# Server.HtmlEncode(Eval("InternshipTitle") != null ? Eval("InternshipTitle").ToString() : "Internship") %></div>
                            <span style="font-size: 11.5px; color: #64748b;"><%# Server.HtmlEncode(Eval("WorkMode") != null ? Eval("WorkMode").ToString() : "Full Time") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Applied Date" HeaderStyle-Width="18%">
                        <ItemTemplate>
                            <span style="font-size: 13px; color: #64748b;"><i class="fa-regular fa-calendar" style="margin-right:4px;"></i><%# FormatDate(Eval("AppliedDate")) %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" HeaderStyle-Width="15%">
                        <ItemTemplate>
                            <%# GetStatusBadge(Eval("Status")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" HeaderStyle-Width="15%" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                        <ItemTemplate>
                            <a href='<%= ResolveUrl("~/StudentPanel/student-internship-details.aspx") %>?id=<%# Eval("InternshipId") %>'
                               style="padding: 6px 14px; font-size: 12.5px; text-decoration: none; border-radius: 8px; background: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe; font-weight: 600; display: inline-flex; align-items: center; gap: 5px; transition: all 0.15s ease;">
                                <i class="fa-solid fa-eye"></i> View Details
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoApps" runat="server" Visible="false">
                <div style="text-align:center; padding:35px 10px;">
                    <i class="fa-solid fa-folder-open" style="font-size: 32px; color: #cbd5e1; display: block; margin-bottom: 8px;"></i>
                    <p style="font-size:13.5px; color:#64748b; margin:0 0 12px 0;">No internship applications submitted yet.</p>
                    <a href="student-internships.aspx" style="display:inline-flex; align-items:center; gap:6px; padding:7px 16px; background:#2563eb; color:#fff; border-radius:8px; font-size:13px; font-weight:600; text-decoration:none;">
                        <i class="fa-solid fa-magnifying-glass"></i> Explore Internships
                    </a>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
    <!-- ===================== UPCOMING INTERVIEWS (50%) & QUICK ACTIONS (50%) ===================== -->
    <div class="co-grid-2" style="margin-bottom: 26px;">
        <!-- LEFT: UPCOMING INTERVIEWS -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-calendar-days" style="color: #7c3aed; margin-right: 8px;"></i> Upcoming Interviews</h3>
                <a href="<%= ResolveUrl("~/StudentPanel/student-interviews.aspx") %>" style="display: inline-flex; align-items: center; gap: 6px; font-weight: 600;">
                    View All <i class="fa-solid fa-arrow-right" style="font-size: 11px;"></i>
                </a>
            </div>
            <div style="flex: 1; display: flex; flex-direction: column; justify-content: flex-start;">
                <asp:DataList ID="dlInterviews" runat="server" Width="100%" RepeatLayout="Flow">
                    <ItemTemplate>
                        <div class="co-interview-item" style="margin-bottom: 12px;">
                            <div class="co-date-box"><span class="day"><asp:Label ID="lblDay" runat="server" Text='<%# FormatDay(Eval("InterviewDate")) %>'></asp:Label></span><span class="mon"><asp:Label ID="lblMon" runat="server" Text='<%# FormatMonth(Eval("InterviewDate")) %>'></asp:Label></span></div>
                            <div class="co-interview-info">
                                <h4><asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label></h4>
                                <p><asp:Label ID="lblTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label> &bull; <i class="fa-regular fa-clock" style="margin-left: 4px; margin-right: 2px;"></i><asp:Label ID="lblTime" runat="server" Text='<%# Eval("InterviewTime") %>'></asp:Label></p>
                                <div style="display:flex; align-items:center; gap:8px; margin-top:3px; flex-wrap:wrap;">
                                    <span class="co-mode"><i class="fa-solid fa-video"></i> <asp:Label ID="lblMode" runat="server" Text='<%# Eval("InterviewType") %>'></asp:Label></span>
                                    <asp:Label ID="litMeetingBtn" runat="server" Text='<%# FormatMeetingBtn(Eval("MeetingLink"), Eval("Location"), Eval("InterviewType")) %>'></asp:Label>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
                <asp:PlaceHolder ID="pnlNoInterviews" runat="server" Visible="false">
                    <div style="text-align:center; padding:35px 10px;">
                        <i class="fa-regular fa-calendar-xmark" style="font-size: 28px; color: #cbd5e1; display: block; margin-bottom: 8px;"></i>
                        <p style="font-size:13.5px; color:#64748b; margin:0;">No upcoming interviews scheduled.</p>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
        <!-- RIGHT: STUDENT QUICK ACTIONS (Same UI cards as Company Panel) -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-bolt" style="color: #f59e0b; margin-right: 8px;"></i> Quick Actions</h3>
            </div>
            <div style="display: flex; flex-direction: column; gap: 10px; flex: 1; justify-content: center;">
                <!-- Action 1: Browse Internships -->
                <a href="<%= ResolveUrl("~/StudentPanel/student-internships.aspx") %>" style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; text-decoration: none; transition: all 0.2s ease;" onmouseover="this.style.background='#eff6ff'; this.style.borderColor='#93c5fd';" onmouseout="this.style.background='#f8fafc'; this.style.borderColor='#e2e8f0';">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div style="width: 36px; height: 36px; border-radius: 8px; background: #dbeafe; color: #2563eb; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0;">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; font-size: 13.5px; color: #0f172a; line-height: 1.2;">Explore & Apply Internships</div>
                            <div style="font-size: 11.5px; color: #64748b;">Search by domain, location & skills</div>
                        </div>
                    </div>
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #2563eb; font-size: 11px;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 2: Track My Applications -->
                <a href="<%= ResolveUrl("~/StudentPanel/student-my-applications.aspx") %>" style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; text-decoration: none; transition: all 0.2s ease;" onmouseover="this.style.background='#f5f3ff'; this.style.borderColor='#c4b5fd';" onmouseout="this.style.background='#f8fafc'; this.style.borderColor='#e2e8f0';">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div style="width: 36px; height: 36px; border-radius: 8px; background: #ede9fe; color: #7c3aed; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0;">
                            <i class="fa-solid fa-file-lines"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; font-size: 13.5px; color: #0f172a; line-height: 1.2;">My Applications</div>
                            <div style="font-size: 11.5px; color: #64748b;">Track status, reviews & shortlist</div>
                        </div>
                    </div>
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #7c3aed; font-size: 11px;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 3: Tasks & Assessments -->
                <a href="<%= ResolveUrl("~/StudentPanel/student-tasks.aspx") %>" style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; text-decoration: none; transition: all 0.2s ease;" onmouseover="this.style.background='#f0fdf4'; this.style.borderColor='#86efac';" onmouseout="this.style.background='#f8fafc'; this.style.borderColor='#e2e8f0';">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div style="width: 36px; height: 36px; border-radius: 8px; background: #dcfce7; color: #16a34a; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0;">
                            <i class="fa-solid fa-list-check"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; font-size: 13.5px; color: #0f172a; line-height: 1.2;">Tasks & Skill Assessments</div>
                            <div style="font-size: 11.5px; color: #64748b;">Play quizzes, solve challenges & earn scores</div>
                        </div>
                    </div>
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #16a34a; font-size: 11px;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 4: View Offer Letters -->
                <a href="<%= ResolveUrl("~/StudentPanel/student-offer-letters.aspx") %>" style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; text-decoration: none; transition: all 0.2s ease;" onmouseover="this.style.background='#fff7ed'; this.style.borderColor='#fdba74';" onmouseout="this.style.background='#f8fafc'; this.style.borderColor='#e2e8f0';">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div style="width: 36px; height: 36px; border-radius: 8px; background: #ffedd5; color: #ea580c; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0;">
                            <i class="fa-solid fa-file-signature"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; font-size: 13.5px; color: #0f172a; line-height: 1.2;">Offer Letters & Responses</div>
                            <div style="font-size: 11.5px; color: #64748b;">Accept or review company internship offers</div>
                        </div>
                    </div>
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #ea580c; font-size: 11px;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 5: Certificates & Achievements -->
                <a href="<%= ResolveUrl("~/StudentPanel/student-certificates.aspx") %>" style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; text-decoration: none; transition: all 0.2s ease;" onmouseover="this.style.background='#ecfeff'; this.style.borderColor='#a5f3fc';" onmouseout="this.style.background='#f8fafc'; this.style.borderColor='#e2e8f0';">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div style="width: 36px; height: 36px; border-radius: 8px; background: #cffafe; color: #0891b2; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0;">
                            <i class="fa-solid fa-award"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; font-size: 13.5px; color: #0f172a; line-height: 1.2;">Internship Certificates</div>
                            <div style="font-size: 11.5px; color: #64748b;">Download verified completion credentials</div>
                        </div>
                    </div>
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #0891b2; font-size: 11px;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <!-- Charts JavaScript Engine (Exact match with Company Dashboard) -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            if (typeof Chart === 'undefined') return;
            // 1. Application Status Donut Chart
            var appCanvas = document.getElementById('studentStatusChart');
            if (appCanvas) {
                var appCtx = appCanvas.getContext('2d');
                var selectedCount = parseInt(appCanvas.getAttribute('data-selected') || '0', 10);
                var pendingCount = parseInt(appCanvas.getAttribute('data-pending') || '0', 10);
                var rejectedCount = parseInt(appCanvas.getAttribute('data-rejected') || '0', 10);
                var appTotal = selectedCount + pendingCount + rejectedCount;
                var appData = [selectedCount, pendingCount, rejectedCount];
                var appLabels = ['Selected', 'Pending', 'Rejected'];
                var appColors = ['#16a34a', '#f59e0b', '#ef4444'];
                if (appTotal === 0) {
                    appData = [1];
                    appLabels = ['No Applications Yet'];
                    appColors = ['#e2e8f0'];
                }
                new Chart(appCtx, {
                    type: 'doughnut',
                    data: {
                        labels: appLabels,
                        datasets: [{
                            data: appData,
                            backgroundColor: appColors,
                            borderWidth: 3,
                            borderColor: '#FFFFFF',
                            hoverOffset: appTotal > 0 ? 4 : 0
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    usePointStyle: true,
                                    pointStyle: 'circle',
                                    padding: 14,
                                    font: {
                                        family: "'Inter', sans-serif",
                                        size: 13,
                                        weight: '600'
                                    },
                                    color: '#1e293b'
                                }
                            },
                            tooltip: {
                                enabled: appTotal > 0,
                                callbacks: {
                                    label: function (context) {
                                        var label = context.label || '';
                                        var value = context.parsed || 0;
                                        var pct = appTotal > 0 ? Math.round((value / appTotal) * 100) : 0;
                                        return ' ' + label + ': ' + value + ' (' + pct + '%)';
                                    }
                                }
                            }
                        },
                        cutout: '70%'
                    }
                });
            }
            // 2. Interview Status Bar Chart
            var intCanvas = document.getElementById('studentInterviewChart');
            if (intCanvas) {
                var intCtx = intCanvas.getContext('2d');
                var schCount = parseInt(intCanvas.getAttribute('data-scheduled') || '0', 10);
                var compCount = parseInt(intCanvas.getAttribute('data-completed') || '0', 10);
                var cancCount = parseInt(intCanvas.getAttribute('data-cancelled') || '0', 10);
                var intTotal = schCount + compCount + cancCount;
                new Chart(intCtx, {
                    type: 'bar',
                    data: {
                        labels: ['Scheduled', 'Completed', 'Cancelled'],
                        datasets: [{
                            label: 'Interviews',
                            data: [schCount, compCount, cancCount],
                            backgroundColor: ['#2563eb', '#10b981', '#ef4444'],
                            borderRadius: 8,
                            borderSkipped: false,
                            maxBarThickness: 42
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        var val = context.raw || 0;
                                        var pct = intTotal > 0 ? Math.round((val / intTotal) * 100) : 0;
                                        return ' ' + context.dataset.label + ': ' + val + (intTotal > 0 ? ' (' + pct + '%)' : '');
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    precision: 0,
                                    font: {
                                        family: "'Inter', sans-serif",
                                        size: 11
                                    },
                                    color: '#64748b'
                                },
                                grid: {
                                    color: '#f1f5f9',
                                    drawBorder: false
                                }
                            },
                            x: {
                                ticks: {
                                    font: {
                                        family: "'Inter', sans-serif",
                                        size: 12,
                                        weight: '600'
                                    },
                                    color: '#334155'
                                },
                                grid: {
                                    display: false,
                                    drawBorder: false
                                }
                            }
                        }
                    }
                });
            }
        });
    </script>
</asp:Content>

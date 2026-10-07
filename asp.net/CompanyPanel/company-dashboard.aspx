<%@ Page Title="Company Dashboard" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-dashboard.aspx.cs" Inherits="asp.net.Companydashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header -->
    <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 16px; margin-bottom: 24px;">
        <div>
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Dashboard</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Overall stats, recent applicants, and upcoming interviews overview.</p>
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
    <!-- Stat Cards (Same structure & layout as Admin Panel) -->
    <div class="sims-stat-grid-v2" style="margin-bottom: 24px;">
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
    <!-- Charts Row: Donut + Quick Info -->
    <div class="co-grid-2" style="margin-bottom:26px;">
        <!-- Application Status Donut Chart -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-chart-pie" style="color:#2563eb; margin-right:8px;"></i> Application Status Overview</h3>
            </div>
            <div style="position:relative; height:240px; display:flex; justify-content:center; align-items:center; padding:10px 0;">
                <canvas id="companyStatusChart"
                        data-selected='<%= totalSelected %>'
                        data-pending='<%= totalPending %>'
                        data-rejected='<%= totalRejected %>'></canvas>
            </div>
        </div>
        <!-- Interview Status Overview Chart -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-chart-column" style="color:#7c3aed; margin-right:8px;"></i> Interview Status Overview</h3>
            </div>
            <div style="position:relative; height:240px; display:flex; justify-content:center; align-items:center; padding:10px 0;">
                <canvas id="companyInterviewChart"
                        data-scheduled='<%= intScheduled %>'
                        data-completed='<%= intCompleted %>'
                        data-cancelled='<%= intCancelled %>'></canvas>
            </div>
        </div>
    </div>
    <!-- ===================== RECENT APPLICATIONS (FULL WIDTH) ===================== -->
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
                                <div class="co-applicant-avatar av1"><%# GetInitials(Eval("FullName")) %></div>
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
                            <asp:Label ID="lblAppliedDate" runat="server" Style="font-size: 13px; color: #64748b;" Text='<%# FormatDate(Eval("AppliedDate")) %>'></asp:Label>
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
            <asp:PlaceHolder ID="pnlNoApps" runat="server" Visible="false"><div style="text-align:center; padding:30px 10px;">
                <p style="font-size:13.5px; color:#64748b; margin:0;">No applications received yet.</p>
            </div></asp:PlaceHolder>
        </div>
    </div>
    <!-- ===================== UPCOMING INTERVIEWS (50%) & QUICK ACTIONS (50%) ===================== -->
    <div class="co-grid-2" style="margin-bottom: 26px;">
        <!-- LEFT: UPCOMING INTERVIEWS -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-calendar-days" style="color: #7c3aed; margin-right: 8px;"></i> Upcoming Interviews</h3>
                <a href="<%= ResolveUrl("~/CompanyPanel/company-interviews.aspx") %>" style="display: inline-flex; align-items: center; gap: 6px; font-weight: 600;">
                    View All <i class="fa-solid fa-arrow-right" style="font-size: 11px;"></i>
                </a>
            </div>
            <div style="flex: 1; display: flex; flex-direction: column; justify-content: flex-start;">
                <asp:DataList ID="dlInterviews" runat="server" Width="100%" RepeatLayout="Flow">
                    <ItemTemplate>
                        <div class="co-interview-item" style="margin-bottom: 10px;">
                            <div class="co-date-box">
                                <span class="day"><asp:Label ID="lblDay" runat="server" Text='<%# FormatDay(Eval("InterviewDate")) %>'></asp:Label></span>
                                <span class="mon"><asp:Label ID="lblMonth" runat="server" Text='<%# FormatMonth(Eval("InterviewDate")) %>'></asp:Label></span>
                            </div>
                            <div class="co-interview-info">
                                <h4><asp:Label ID="lblCandidateName" runat="server" Text='<%# Eval("FullName") %>'></asp:Label></h4>
                                <p><asp:Label ID="lblInterviewInternship" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label> &bull; <i class="fa-regular fa-clock" style="margin-left: 4px; margin-right: 2px;"></i><asp:Label ID="lblInterviewTime" runat="server" Text='<%# Eval("InterviewTime") %>'></asp:Label></p>
                                <span class="co-mode"><i class="fa-solid fa-video"></i> <asp:Label ID="lblInterviewType" runat="server" Text='<%# Eval("InterviewType") %>'></asp:Label></span>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
                <asp:PlaceHolder ID="pnlNoInterviews" runat="server" Visible="false"><div style="text-align:center; padding:35px 10px;">
                    <i class="fa-regular fa-calendar-xmark" style="font-size: 28px; color: #cbd5e1; display: block; margin-bottom: 8px;"></i>
                    <p style="font-size:13.5px; color:#64748b; margin:0;">No upcoming interviews scheduled.</p>
                </div></asp:PlaceHolder>
            </div>
        </div>
        <!-- RIGHT: QUICK ACTIONS -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-bolt" style="color: #f59e0b; margin-right: 8px;"></i> Quick Actions</h3>
            </div>
            <div style="display: flex; flex-direction: column; gap: 10px; flex: 1; justify-content: center;">
                <!-- Action 1: Post Internship -->
                <a href="<%= ResolveUrl("~/CompanyPanel/company-post-internship.aspx") %>" style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; text-decoration: none; transition: all 0.2s ease;" onmouseover="this.style.background='#eff6ff'; this.style.borderColor='#93c5fd';" onmouseout="this.style.background='#f8fafc'; this.style.borderColor='#e2e8f0';">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div style="width: 36px; height: 36px; border-radius: 8px; background: #dbeafe; color: #2563eb; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0;">
                            <i class="fa-solid fa-circle-plus"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; font-size: 13.5px; color: #0f172a; line-height: 1.2;">Post New Internship</div>
                            <div style="font-size: 11.5px; color: #64748b;">Create and publish new opportunities</div>
                        </div>
                    </div>
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #2563eb; font-size: 11px;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 2: Review Applicants -->
                <a href="<%= ResolveUrl("~/CompanyPanel/company-applicants.aspx") %>" style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; text-decoration: none; transition: all 0.2s ease;" onmouseover="this.style.background='#f5f3ff'; this.style.borderColor='#c4b5fd';" onmouseout="this.style.background='#f8fafc'; this.style.borderColor='#e2e8f0';">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div style="width: 36px; height: 36px; border-radius: 8px; background: #ede9fe; color: #7c3aed; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0;">
                            <i class="fa-solid fa-user-group"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; font-size: 13.5px; color: #0f172a; line-height: 1.2;">Review Applicants</div>
                            <div style="font-size: 11.5px; color: #64748b;">Shortlist, select or reject candidates</div>
                        </div>
                    </div>
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #7c3aed; font-size: 11px;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 3: Manage Internships -->
                <a href="<%= ResolveUrl("~/CompanyPanel/company-internships.aspx") %>" style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; text-decoration: none; transition: all 0.2s ease;" onmouseover="this.style.background='#f0fdf4'; this.style.borderColor='#86efac';" onmouseout="this.style.background='#f8fafc'; this.style.borderColor='#e2e8f0';">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div style="width: 36px; height: 36px; border-radius: 8px; background: #dcfce7; color: #16a34a; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0;">
                            <i class="fa-solid fa-briefcase"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; font-size: 13.5px; color: #0f172a; line-height: 1.2;">Manage Internships</div>
                            <div style="font-size: 11.5px; color: #64748b;">Edit, view status & track active posts</div>
                        </div>
                    </div>
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #16a34a; font-size: 11px;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 4: Interviews Schedule -->
                <a href="<%= ResolveUrl("~/CompanyPanel/company-interviews.aspx") %>" style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; text-decoration: none; transition: all 0.2s ease;" onmouseover="this.style.background='#fff7ed'; this.style.borderColor='#fdba74';" onmouseout="this.style.background='#f8fafc'; this.style.borderColor='#e2e8f0';">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div style="width: 36px; height: 36px; border-radius: 8px; background: #ffedd5; color: #ea580c; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0;">
                            <i class="fa-solid fa-calendar-check"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; font-size: 13.5px; color: #0f172a; line-height: 1.2;">Schedule Interviews</div>
                            <div style="font-size: 11.5px; color: #64748b;">Conduct and manage candidate interviews</div>
                        </div>
                    </div>
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #ea580c; font-size: 11px;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 5: Reports & Analytics -->
                <a href="<%= ResolveUrl("~/CompanyPanel/company-reports.aspx") %>" style="display: flex; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 10px; background: #f8fafc; border: 1px solid #e2e8f0; text-decoration: none; transition: all 0.2s ease;" onmouseover="this.style.background='#ecfeff'; this.style.borderColor='#a5f3fc';" onmouseout="this.style.background='#f8fafc'; this.style.borderColor='#e2e8f0';">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div style="width: 36px; height: 36px; border-radius: 8px; background: #cffafe; color: #0891b2; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0;">
                            <i class="fa-solid fa-chart-pie"></i>
                        </div>
                        <div>
                            <div style="font-weight: 600; font-size: 13.5px; color: #0f172a; line-height: 1.2;">Reports & Analytics</div>
                            <div style="font-size: 11.5px; color: #64748b;">View recruitment data and export reports</div>
                        </div>
                    </div>
                    <div style="width: 28px; height: 28px; border-radius: 50%; background: #ffffff; border: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: center; color: #0891b2; font-size: 11px;">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            if (typeof Chart === 'undefined') return;
            // 1. Application Status Donut Chart
            var appCanvas = document.getElementById('companyStatusChart');
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
            // 2. Interview Status Bar Chart (Different type from Doughnut)
            var intCanvas = document.getElementById('companyInterviewChart');
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

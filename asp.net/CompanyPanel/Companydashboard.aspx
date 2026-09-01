<%@ Page Title="" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="Companydashboard.aspx.cs" Inherits="asp.net.Companydashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Breadcrumb -->
    <div class="pm-breadcrumb" id="breadcrumbNav"></div>

    <!-- Welcome Banner -->
    <div class="welcome-banner" style="margin-bottom:26px;">
        <div>
            <h2>Welcome back, <asp:Literal ID="litWelcomeCompanyName" runat="server" Text="Company Partner" />! 👋</h2>
            <p>You have <strong>5 new applications</strong> and <strong>2 interviews</strong> scheduled this week. Keep the momentum going!</p>
            <div class="welcome-date" id="welcomeDate"><asp:Literal ID="litToday" runat="server" /></div>
        </div>
        <div style="display:flex;gap:10px;flex-wrap:wrap;">
            <a href="<%= ResolveUrl("~/CompanyPanel/company-post-internship.aspx") %>" class="btn btn-primary" style="text-decoration:none;display:inline-flex;align-items:center;gap:8px;">
                <i class="fa-solid fa-plus"></i> Post Internship
            </a>
            <a href="<%= ResolveUrl("~/CompanyPanel/company-profile.aspx") %>" class="btn btn-ghost" style="text-decoration:none;display:inline-flex;align-items:center;gap:8px;">
                <i class="fa-solid fa-building"></i> View Profile
            </a>
        </div>
    </div>

    <!-- Stat Cards -->
    <div class="co-stat-grid">
        <div class="co-stat-card">
            <div class="co-stat-icon blue"><i class="fa-solid fa-briefcase"></i></div>
            <div class="co-stat-info">
                <h3>24</h3>
                <p>Total Internships Posted</p>
                <small class="up"><i class="fa-solid fa-arrow-trend-up"></i> 4 this month</small>
            </div>
        </div>
        <div class="co-stat-card">
            <div class="co-stat-icon green"><i class="fa-solid fa-circle-check"></i></div>
            <div class="co-stat-info">
                <h3>8</h3>
                <p>Active Internships</p>
                <small class="up"><i class="fa-solid fa-arrow-trend-up"></i> 2 new this week</small>
            </div>
        </div>
        <div class="co-stat-card">
            <div class="co-stat-icon purple"><i class="fa-solid fa-file-lines"></i></div>
            <div class="co-stat-info">
                <h3>312</h3>
                <p>Total Applications</p>
                <small class="up"><i class="fa-solid fa-arrow-trend-up"></i> 28 this week</small>
            </div>
        </div>
        <div class="co-stat-card">
            <div class="co-stat-icon orange"><i class="fa-solid fa-star"></i></div>
            <div class="co-stat-info">
                <h3>47</h3>
                <p>Shortlisted Students</p>
                <small class="up"><i class="fa-solid fa-arrow-trend-up"></i> 6 added today</small>
            </div>
        </div>
        <div class="co-stat-card">
            <div class="co-stat-icon teal"><i class="fa-solid fa-user-check"></i></div>
            <div class="co-stat-info">
                <h3>19</h3>
                <p>Selected Students</p>
                <small class="up"><i class="fa-solid fa-arrow-trend-up"></i> 3 this month</small>
            </div>
        </div>
        <div class="co-stat-card">
            <div class="co-stat-icon red"><i class="fa-solid fa-user-xmark"></i></div>
            <div class="co-stat-info">
                <h3>58</h3>
                <p>Rejected Students</p>
                <small class="down"><i class="fa-solid fa-arrow-trend-down"></i> -5 vs last month</small>
            </div>
        </div>
        <div class="co-stat-card">
            <div class="co-stat-icon indigo"><i class="fa-solid fa-calendar-check"></i></div>
            <div class="co-stat-info">
                <h3>14</h3>
                <p>Interviews Scheduled</p>
                <small class="up"><i class="fa-solid fa-arrow-trend-up"></i> 2 today</small>
            </div>
        </div>
        <div class="co-stat-card">
            <div class="co-stat-icon pink"><i class="fa-solid fa-chart-pie"></i></div>
            <div class="co-stat-info">
                <h3>92%</h3>
                <p>Hiring Success Rate</p>
                <small class="up"><i class="fa-solid fa-arrow-trend-up"></i> +4% this month</small>
            </div>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="co-panel" style="margin-bottom:26px;">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-bolt" style="color:#f59e0b;margin-right:8px;"></i>Quick Actions</h3>
        </div>
        <div class="co-quick-grid">
            <a href="<%= ResolveUrl("~/CompanyPanel/company-post-internship.aspx") %>" class="co-quick-card">
                <div class="co-quick-card-icon blue"><i class="fa-solid fa-plus-circle"></i></div>
                <span>Post Internship</span>
            </a>
            <a href="<%= ResolveUrl("~/CompanyPanel/company-manage-internships.aspx") %>" class="co-quick-card">
                <div class="co-quick-card-icon" style="background:#f0fdf4;color:#16a34a;"><i class="fa-solid fa-layer-group"></i></div>
                <span>Manage Internships</span>
            </a>
            <a href="<%= ResolveUrl("~/CompanyPanel/company-applications.aspx") %>" class="co-quick-card">
                <div class="co-quick-card-icon" style="background:#f5f3ff;color:#7c3aed;"><i class="fa-solid fa-file-lines"></i></div>
                <span>View Applications</span>
            </a>
            <a href="<%= ResolveUrl("~/CompanyPanel/company-profile.aspx") %>" class="co-quick-card">
                <div class="co-quick-card-icon" style="background:#fff7ed;color:#ea580c;"><i class="fa-solid fa-building"></i></div>
                <span>Company Profile</span>
            </a>
            <a href="<%= ResolveUrl("~/CompanyPanel/company-analytics.aspx") %>" class="co-quick-card">
                <div class="co-quick-card-icon" style="background:#f0fdfa;color:#0d9488;"><i class="fa-solid fa-chart-bar"></i></div>
                <span>Reports</span>
            </a>
        </div>
    </div>

    <!-- Charts Row -->
    <div class="co-grid-2-equal" style="margin-bottom:26px;">

        <!-- Monthly Applications Bar Chart -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3>Monthly Applications</h3>
                <span style="font-size:12px;color:var(--text-muted);">2026</span>
            </div>
            <div class="co-chart-container" id="barChart">
                <!-- Injected via JavaScript -->
            </div>
        </div>

        <!-- Selection Ratio Donut -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3>Student Selection Ratio</h3>
                <span style="font-size:12px;color:var(--text-muted);">Overall</span>
            </div>
            <div style="display:flex;align-items:center;gap:24px;flex-wrap:wrap;padding-top:10px;">
                <svg width="150" height="150" viewBox="0 0 150 150" class="co-donut-svg">
                    <circle cx="75" cy="75" r="60" fill="none" stroke="#f1f5f9" stroke-width="20"/>
                    <circle cx="75" cy="75" r="60" fill="none" stroke="#2563eb" stroke-width="20"
                        stroke-dasharray="90 287" stroke-dashoffset="0" stroke-linecap="round" transform="rotate(-90 75 75)"/>
                    <circle cx="75" cy="75" r="60" fill="none" stroke="#7c3aed" stroke-width="20"
                        stroke-dasharray="36 341" stroke-dashoffset="-90" stroke-linecap="round" transform="rotate(-90 75 75)"/>
                    <circle cx="75" cy="75" r="60" fill="none" stroke="#ef4444" stroke-width="20"
                        stroke-dasharray="111 266" stroke-dashoffset="-126" stroke-linecap="round" transform="rotate(-90 75 75)"/>
                    <text x="75" y="70" text-anchor="middle" font-size="20" font-weight="800" fill="#1e293b">312</text>
                    <text x="75" y="88" text-anchor="middle" font-size="11" fill="#64748b">Total</text>
                </svg>
                <div class="co-donut-legend">
                    <div class="co-donut-legend-item"><span class="co-legend-dot" style="background:#2563eb;"></span> Shortlisted <strong style="margin-left:auto;">47</strong></div>
                    <div class="co-donut-legend-item"><span class="co-legend-dot" style="background:#7c3aed;"></span> Selected <strong style="margin-left:auto;">19</strong></div>
                    <div class="co-donut-legend-item"><span class="co-legend-dot" style="background:#ef4444;"></span> Rejected <strong style="margin-left:auto;">58</strong></div>
                    <div class="co-donut-legend-item"><span class="co-legend-dot" style="background:#f1f5f9;border:1px solid #e2e8f0;"></span> Pending <strong style="margin-left:auto;">188</strong></div>
                </div>
            </div>
        </div>

    </div>

    <!-- Recent Applications + Upcoming Interviews -->
    <div class="co-grid-2" style="margin-bottom:26px;">

        <!-- Recent Applications Table -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3>Recent Applications</h3>
                <a href="<%= ResolveUrl("~/CompanyPanel/company-applications.aspx") %>">View All</a>
            </div>
            <div style="overflow-x:auto;">
                <table class="co-table">
                    <thead>
                        <tr>
                            <th>Applicant</th>
                            <th>Role</th>
                            <th>Applied</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><div class="co-applicant-cell"><div class="co-applicant-avatar av1">AP</div><div><div class="co-applicant-name">Aarav Patel</div><div class="co-applicant-email">aarav@sims.com</div></div></div></td>
                            <td>Frontend Developer Intern</td>
                            <td>15 Jul 2026</td>
                            <td><span class="co-badge co-badge-review">Under Review</span></td>
                            <td><button type="button" class="btn btn-ghost" style="padding:5px 12px;font-size:12px;">Review</button></td>
                        </tr>
                        <tr>
                            <td><div class="co-applicant-cell"><div class="co-applicant-avatar av2">PS</div><div><div class="co-applicant-name">Priya Shah</div><div class="co-applicant-email">priya@sims.com</div></div></div></td>
                            <td>Data Analyst Intern</td>
                            <td>14 Jul 2026</td>
                            <td><span class="co-badge co-badge-shortlist">Shortlisted</span></td>
                            <td><button type="button" class="btn btn-ghost" style="padding:5px 12px;font-size:12px;">Review</button></td>
                        </tr>
                        <tr>
                            <td><div class="co-applicant-cell"><div class="co-applicant-avatar av3">RK</div><div><div class="co-applicant-name">Rohit Kumar</div><div class="co-applicant-email">rohit@sims.com</div></div></div></td>
                            <td>Backend Developer Intern</td>
                            <td>13 Jul 2026</td>
                            <td><span class="co-badge co-badge-interview">Interview</span></td>
                            <td><button type="button" class="btn btn-ghost" style="padding:5px 12px;font-size:12px;">Review</button></td>
                        </tr>
                        <tr>
                            <td><div class="co-applicant-cell"><div class="co-applicant-avatar av4">MG</div><div><div class="co-applicant-name">Meera Gupta</div><div class="co-applicant-email">meera@sims.com</div></div></div></td>
                            <td>UI/UX Design Intern</td>
                            <td>12 Jul 2026</td>
                            <td><span class="co-badge co-badge-pending">Pending</span></td>
                            <td><button type="button" class="btn btn-ghost" style="padding:5px 12px;font-size:12px;">Review</button></td>
                        </tr>
                        <tr>
                            <td><div class="co-applicant-cell"><div class="co-applicant-avatar av5">NJ</div><div><div class="co-applicant-name">Neel Joshi</div><div class="co-applicant-email">neel@sims.com</div></div></div></td>
                            <td>Marketing Intern</td>
                            <td>11 Jul 2026</td>
                            <td><span class="co-badge co-badge-selected">Selected</span></td>
                            <td><button type="button" class="btn btn-ghost" style="padding:5px 12px;font-size:12px;">Review</button></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Right Rail: Interviews + Notifications -->
        <div>
            <!-- Upcoming Interviews -->
            <div class="co-panel" style="margin-bottom:20px;">
                <div class="co-panel-header">
                    <h3>Upcoming Interviews</h3>
                    <a href="<%= ResolveUrl("~/CompanyPanel/company-interview-schedule.aspx") %>">View All</a>
                </div>
                <div>
                    <div class="co-interview-item">
                        <div class="co-date-box"><span class="day">22</span><span class="mon">Jul</span></div>
                        <div class="co-interview-info">
                            <h4>Aarav Patel</h4>
                            <p>Frontend Developer Intern &bull; 11:00 AM</p>
                            <span class="co-mode"><i class="fa-solid fa-video"></i> Google Meet</span>
                        </div>
                    </div>
                    <div class="co-interview-item">
                        <div class="co-date-box"><span class="day">24</span><span class="mon">Jul</span></div>
                        <div class="co-interview-info">
                            <h4>Priya Shah</h4>
                            <p>Data Analyst Intern &bull; 3:00 PM</p>
                            <span class="co-mode"><i class="fa-solid fa-building"></i> In-person, Ahmedabad</span>
                        </div>
                    </div>
                    <div class="co-interview-item">
                        <div class="co-date-box"><span class="day">27</span><span class="mon">Jul</span></div>
                        <div class="co-interview-info">
                            <h4>Rohit Kumar</h4>
                            <p>Backend Developer Intern &bull; 10:30 AM</p>
                            <span class="co-mode"><i class="fa-solid fa-phone"></i> Phone Call</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Recent Notifications -->
            <div class="co-panel">
                <div class="co-panel-header">
                    <h3>Notifications</h3>
                    <a href="<%= ResolveUrl("~/CompanyPanel/company-notifications.aspx") %>">View All</a>
                </div>
                <div class="co-notif-list">
                    <div class="co-notif-item">
                        <div class="co-notif-icon" style="background:#eff6ff;color:#2563eb;"><i class="fa-solid fa-file-lines"></i></div>
                        <div><p><strong>5 new applications</strong> received for Frontend Developer Intern.</p><span>2 hours ago</span></div>
                    </div>
                    <div class="co-notif-item">
                        <div class="co-notif-icon" style="background:#f0fdf4;color:#16a34a;"><i class="fa-solid fa-calendar-check"></i></div>
                        <div><p>Interview with <strong>Priya Shah</strong> confirmed for 24 Jul.</p><span>5 hours ago</span></div>
                    </div>
                    <div class="co-notif-item">
                        <div class="co-notif-icon" style="background:#f5f3ff;color:#7c3aed;"><i class="fa-solid fa-star"></i></div>
                        <div><p><strong>Neel Joshi</strong> has been marked as Selected.</p><span>Yesterday</span></div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const barData = [
                { label: 'Jan', val: 28 }, { label: 'Feb', val: 35 }, { label: 'Mar', val: 42 },
                { label: 'Apr', val: 30 }, { label: 'May', val: 55 }, { label: 'Jun', val: 48 },
                { label: 'Jul', val: 62 }, { label: 'Aug', val: 38 }, { label: 'Sep', val: 70 },
                { label: 'Oct', val: 52 }, { label: 'Nov', val: 44 }, { label: 'Dec', val: 60 }
            ];
            const maxVal = Math.max(...barData.map(d => d.val));
            const container = document.getElementById('barChart');
            if (!container) return;
            container.innerHTML = barData.map(d => {
                const pct = Math.round((d.val / maxVal) * 120);
                return `<div class="co-bar-group">
            <div class="co-bar-val">${d.val}</div>
            <div class="co-bar" style="height:${pct}px;" title="${d.label}: ${d.val} applications"></div>
            <div class="co-bar-label">${d.label}</div>
          </div>`;
            }).join('');
        });
    </script>
</asp:Content>


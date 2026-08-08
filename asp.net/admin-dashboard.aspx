<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="admin-dashboard.aspx.cs" Inherits="asp.net.admin_dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Breadcrumb -->
    <div class="pm-breadcrumb" id="breadcrumbNav"></div>

    <!-- Welcome Banner -->
    <div class="welcome-banner" style="margin-bottom:24px;">
        <div>
            <h2 id="welcomeHeading">Welcome back, Admin! 🛡️</h2>
            <p>You have <strong>15 pending approvals</strong> and <strong>3 new notifications</strong>. Stay on top of it all!</p>
        </div>
        <div class="dash-quick-btns">
            <a href="admin-profile.aspx" class="btn btn-ghost" style="margin-right:10px;"><i class="fa-solid fa-user-shield"></i> My Profile</a>
            <a href="admin-analytics.aspx" class="btn btn-primary"><i class="fa-solid fa-chart-pie"></i> Analytics</a>
        </div>
    </div>

    <!-- ── 12 STAT CARDS ── -->
    <div class="adm-stat-grid">
        <a href="admin-students.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#eff6ff;color:#2563eb;"><i class="fa-solid fa-user-graduate"></i></div>
            <div><div class="adm-stat-num">1,248</div><div class="adm-stat-lbl">Total Students</div><div class="adm-stat-chg chg-up"><i class="fa-solid fa-arrow-up"></i> +34 this month</div></div>
        </a>
        <a href="admin-students.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#f0fdf4;color:#16a34a;"><i class="fa-solid fa-user-check"></i></div>
            <div><div class="adm-stat-num">1,180</div><div class="adm-stat-lbl">Active Students</div><div class="adm-stat-chg chg-up"><i class="fa-solid fa-arrow-up"></i> 94.5% active rate</div></div>
        </a>
        <a href="admin-companies.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#fefce8;color:#ca8a04;"><i class="fa-solid fa-building"></i></div>
            <div><div class="adm-stat-num">186</div><div class="adm-stat-lbl">Total Companies</div><div class="adm-stat-chg chg-up"><i class="fa-solid fa-arrow-up"></i> +7 this month</div></div>
        </a>
        <a href="admin-companies.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#f0fdf4;color:#16a34a;"><i class="fa-solid fa-circle-check"></i></div>
            <div><div class="adm-stat-num">171</div><div class="adm-stat-lbl">Verified Companies</div><div class="adm-stat-chg chg-up"><i class="fa-solid fa-arrow-up"></i> 91.9% verified</div></div>
        </a>
        <a href="admin-companies.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#fff7ed;color:#ea580c;"><i class="fa-solid fa-clock"></i></div>
            <div><div class="adm-stat-num">15</div><div class="adm-stat-lbl">Pending Companies</div><div class="adm-stat-chg chg-warn"><i class="fa-solid fa-triangle-exclamation"></i> Needs review</div></div>
        </a>
        <a href="admin-internships.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#f3e8ff;color:#9333ea;"><i class="fa-solid fa-briefcase"></i></div>
            <div><div class="adm-stat-num">342</div><div class="adm-stat-lbl">Total Internships</div><div class="adm-stat-chg chg-up"><i class="fa-solid fa-arrow-up"></i> +18 this month</div></div>
        </a>
        <a href="admin-internships.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#eff6ff;color:#3b82f6;"><i class="fa-solid fa-bolt"></i></div>
            <div><div class="adm-stat-num">298</div><div class="adm-stat-lbl">Active Internships</div><div class="adm-stat-chg chg-up"><i class="fa-solid fa-arrow-up"></i> 87% of total</div></div>
        </a>
        <a href="admin-internships.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#fef2f2;color:#ef4444;"><i class="fa-solid fa-hourglass-half"></i></div>
            <div><div class="adm-stat-num">44</div><div class="adm-stat-lbl">Pending Approval</div><div class="adm-stat-chg chg-warn"><i class="fa-solid fa-triangle-exclamation"></i> Action needed</div></div>
        </a>
        <a href="admin-applications.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#ecfdf5;color:#10b981;"><i class="fa-solid fa-file-lines"></i></div>
            <div><div class="adm-stat-num">4,912</div><div class="adm-stat-lbl">Total Applications</div><div class="adm-stat-chg chg-up"><i class="fa-solid fa-arrow-up"></i> +120 this week</div></div>
        </a>
        <a href="admin-interviews.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#e0f2fe;color:#0284c7;"><i class="fa-solid fa-calendar-check"></i></div>
            <div><div class="adm-stat-num">128</div><div class="adm-stat-lbl">Interviews Scheduled</div><div class="adm-stat-chg chg-up"><i class="fa-solid fa-arrow-up"></i> 22 this week</div></div>
        </a>
        <a href="admin-interviews.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#f0fdf4;color:#16a34a;"><i class="fa-solid fa-user-tie"></i></div>
            <div><div class="adm-stat-num">398</div><div class="adm-stat-lbl">Selected Students</div><div class="adm-stat-chg chg-up"><i class="fa-solid fa-arrow-up"></i> +12 this month</div></div>
        </a>
        <a href="admin-students.aspx" class="adm-stat-card">
            <div class="adm-stat-icon" style="background:#faf5ff;color:#7c3aed;"><i class="fa-solid fa-certificate"></i></div>
            <div><div class="adm-stat-num">284</div><div class="adm-stat-lbl">Certificates Generated</div><div class="adm-stat-chg chg-up"><i class="fa-solid fa-arrow-up"></i> +8 this month</div></div>
        </a>
    </div>

    <!-- ── QUICK ACTIONS ── -->
    <h3 style="font-size:15px;font-weight:700;color:var(--text-dark);margin-bottom:14px;">Quick Actions</h3>
    <div class="adm-qa-grid">
        <a href="admin-students.aspx" class="adm-qa-card"><div class="adm-qa-icon" style="background:#eff6ff;color:#2563eb;"><i class="fa-solid fa-user-graduate"></i></div><h4>Manage Students</h4></a>
        <a href="admin-companies.aspx" class="adm-qa-card"><div class="adm-qa-icon" style="background:#f0fdf4;color:#16a34a;"><i class="fa-solid fa-building"></i></div><h4>Manage Companies</h4></a>
        <a href="admin-internships.aspx" class="adm-qa-card"><div class="adm-qa-icon" style="background:#fefce8;color:#ca8a04;"><i class="fa-solid fa-briefcase"></i></div><h4>Manage Internships</h4></a>
        <a href="admin-companies.aspx" class="adm-qa-card"><div class="adm-qa-icon" style="background:#fff7ed;color:#ea580c;"><i class="fa-solid fa-stamp"></i></div><h4>Approve Companies</h4></a>
        <a href="admin-internships.aspx" class="adm-qa-card"><div class="adm-qa-icon" style="background:#f0fdf4;color:#16a34a;"><i class="fa-solid fa-check-double"></i></div><h4>Approve Internships</h4></a>
        <a href="admin-analytics.aspx" class="adm-qa-card"><div class="adm-qa-icon" style="background:#f3e8ff;color:#9333ea;"><i class="fa-solid fa-chart-bar"></i></div><h4>Reports</h4></a>
        <a href="admin-analytics.aspx" class="adm-qa-card"><div class="adm-qa-icon" style="background:#e0f2fe;color:#0284c7;"><i class="fa-solid fa-chart-pie"></i></div><h4>Analytics</h4></a>
        <a href="admin-settings.aspx" class="adm-qa-card"><div class="adm-qa-icon" style="background:#f1f5f9;color:#64748b;"><i class="fa-solid fa-gear"></i></div><h4>System Settings</h4></a>
    </div>

    <!-- ── CHARTS ROW 1 ── -->
    <div class="co-grid-2" style="margin-bottom:24px;">

        <!-- Student Registration Chart -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3>Student Registration Overview</h3>
                <span style="font-size:11px;color:var(--text-muted);">Jan – Jul 2026</span>
            </div>
            <div class="adm-bar-chart">
                <div class="adm-bar-col"><div class="adm-bar-val">85</div><div class="adm-bar" style="height:77%;background:linear-gradient(180deg,#3b82f6,#2563eb);"></div><div class="adm-bar-lbl">Jan</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">110</div><div class="adm-bar" style="height:100%;background:linear-gradient(180deg,#3b82f6,#2563eb);"></div><div class="adm-bar-lbl">Feb</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">95</div><div class="adm-bar" style="height:86%;background:linear-gradient(180deg,#3b82f6,#2563eb);"></div><div class="adm-bar-lbl">Mar</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">72</div><div class="adm-bar" style="height:65%;background:linear-gradient(180deg,#3b82f6,#2563eb);"></div><div class="adm-bar-lbl">Apr</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">100</div><div class="adm-bar" style="height:91%;background:linear-gradient(180deg,#3b82f6,#2563eb);"></div><div class="adm-bar-lbl">May</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">88</div><div class="adm-bar" style="height:80%;background:linear-gradient(180deg,#3b82f6,#2563eb);"></div><div class="adm-bar-lbl">Jun</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">34</div><div class="adm-bar" style="height:31%;background:linear-gradient(180deg,#93c5fd,#3b82f6);"></div><div class="adm-bar-lbl">Jul</div></div>
            </div>
        </div>

        <!-- Company Registration Chart -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3>Company Registration Overview</h3>
                <span style="font-size:11px;color:var(--text-muted);">Jan – Jul 2026</span>
            </div>
            <div class="adm-bar-chart">
                <div class="adm-bar-col"><div class="adm-bar-val">12</div><div class="adm-bar" style="height:60%;background:linear-gradient(180deg,#34d399,#16a34a);"></div><div class="adm-bar-lbl">Jan</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">20</div><div class="adm-bar" style="height:100%;background:linear-gradient(180deg,#34d399,#16a34a);"></div><div class="adm-bar-lbl">Feb</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">15</div><div class="adm-bar" style="height:75%;background:linear-gradient(180deg,#34d399,#16a34a);"></div><div class="adm-bar-lbl">Mar</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">10</div><div class="adm-bar" style="height:50%;background:linear-gradient(180deg,#34d399,#16a34a);"></div><div class="adm-bar-lbl">Apr</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">18</div><div class="adm-bar" style="height:90%;background:linear-gradient(180deg,#34d399,#16a34a);"></div><div class="adm-bar-lbl">May</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">14</div><div class="adm-bar" style="height:70%;background:linear-gradient(180deg,#34d399,#16a34a);"></div><div class="adm-bar-lbl">Jun</div></div>
                <div class="adm-bar-col"><div class="adm-bar-val">7</div><div class="adm-bar" style="height:35%;background:linear-gradient(180deg,#6ee7b7,#34d399);"></div><div class="adm-bar-lbl">Jul</div></div>
            </div>
        </div>

    </div>

    <!-- ── CHARTS ROW 2 ── -->
    <div class="co-grid-2" style="margin-bottom:24px;">

        <!-- Application Status Donut -->
        <div class="co-panel" style="text-align:center;">
            <div class="co-panel-header"><h3>Application Status Breakdown</h3></div>
            <div class="donut-ring" style="margin-top:16px;">
                <svg class="donut-svg" width="140" height="140" viewBox="0 0 140 140">
                    <circle cx="70" cy="70" r="52" fill="none" stroke="#f1f5f9" stroke-width="18"/>
                    <circle cx="70" cy="70" r="52" fill="none" stroke="#16a34a" stroke-width="18" stroke-dasharray="104 223" stroke-dashoffset="0"/>
                    <circle cx="70" cy="70" r="52" fill="none" stroke="#f59e0b" stroke-width="18" stroke-dasharray="65 262" stroke-dashoffset="-104"/>
                    <circle cx="70" cy="70" r="52" fill="none" stroke="#ef4444" stroke-width="18" stroke-dasharray="59 268" stroke-dashoffset="-169"/>
                    <circle cx="70" cy="70" r="52" fill="none" stroke="#3b82f6" stroke-width="18" stroke-dasharray="98 229" stroke-dashoffset="-228"/>
                </svg>
                <div class="donut-label">
                    <div class="num">4,912</div>
                    <div class="sub">Total</div>
                </div>
            </div>
            <div style="display:flex;gap:16px;justify-content:center;flex-wrap:wrap;">
                <div style="display:flex;align-items:center;gap:5px;font-size:12px;"><span style="width:9px;height:9px;border-radius:50%;background:#16a34a;flex-shrink:0;"></span> Selected 32%</div>
                <div style="display:flex;align-items:center;gap:5px;font-size:12px;"><span style="width:9px;height:9px;border-radius:50%;background:#f59e0b;flex-shrink:0;"></span> Shortlisted 20%</div>
                <div style="display:flex;align-items:center;gap:5px;font-size:12px;"><span style="width:9px;height:9px;border-radius:50%;background:#ef4444;flex-shrink:0;"></span> Rejected 18%</div>
                <div style="display:flex;align-items:center;gap:5px;font-size:12px;"><span style="width:9px;height:9px;border-radius:50%;background:#3b82f6;flex-shrink:0;"></span> Pending 30%</div>
            </div>
        </div>

        <!-- Placement Statistics bars -->
        <div class="co-panel">
            <div class="co-panel-header"><h3>Placement Statistics</h3></div>
            <div style="display:flex;flex-direction:column;gap:14px;padding-top:8px;">
                <div>
                    <div style="display:flex;justify-content:space-between;font-size:13px;margin-bottom:6px;"><span>Engineering</span><span style="font-weight:600;">65%</span></div>
                    <div style="height:8px;background:#f1f5f9;border-radius:4px;overflow:hidden;"><div style="height:100%;width:65%;background:linear-gradient(90deg,#3b82f6,#2563eb);border-radius:4px;"></div></div>
                </div>
                <div>
                    <div style="display:flex;justify-content:space-between;font-size:13px;margin-bottom:6px;"><span>Design</span><span style="font-weight:600;">20%</span></div>
                    <div style="height:8px;background:#f1f5f9;border-radius:4px;overflow:hidden;"><div style="height:100%;width:20%;background:linear-gradient(90deg,#a78bfa,#7c3aed);border-radius:4px;"></div></div>
                </div>
                <div>
                    <div style="display:flex;justify-content:space-between;font-size:13px;margin-bottom:6px;"><span>Data Science</span><span style="font-weight:600;">10%</span></div>
                    <div style="height:8px;background:#f1f5f9;border-radius:4px;overflow:hidden;"><div style="height:100%;width:10%;background:linear-gradient(90deg,#34d399,#16a34a);border-radius:4px;"></div></div>
                </div>
                <div>
                    <div style="display:flex;justify-content:space-between;font-size:13px;margin-bottom:6px;"><span>Marketing</span><span style="font-weight:600;">5%</span></div>
                    <div style="height:8px;background:#f1f5f9;border-radius:4px;overflow:hidden;"><div style="height:100%;width:5%;background:linear-gradient(90deg,#fbbf24,#f59e0b);border-radius:4px;"></div></div>
                </div>
            </div>
        </div>

    </div>

    <!-- ── RECENT ACTIVITIES + PENDING ── -->
    <div class="co-grid-2" style="margin-bottom:24px;">

        <!-- Recent Activity Feed -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3>Recent Activities</h3>
                <a href="admin-activity-logs.aspx" class="btn btn-ghost" style="padding:4px 10px;font-size:12px;">View All Logs</a>
            </div>
            <div>
                <div class="activity-item">
                    <div class="act-dot" style="background:#eff6ff;color:#2563eb;"><i class="fa-solid fa-user-plus"></i></div>
                    <div style="flex:1;">
                        <p style="font-size:13.5px;font-weight:500;color:var(--text-dark);margin:0 0 2px 0;">New Student Registration</p>
                        <p style="font-size:12px;color:var(--text-muted);margin:0;">Arjun Mehta — Silver Oak University</p>
                    </div>
                    <span style="font-size:11px;color:var(--text-muted);white-space:nowrap;">2 min ago</span>
                </div>
                <div class="activity-item">
                    <div class="act-dot" style="background:#f0fdf4;color:#16a34a;"><i class="fa-solid fa-building"></i></div>
                    <div style="flex:1;">
                        <p style="font-size:13.5px;font-weight:500;color:var(--text-dark);margin:0 0 2px 0;">New Company Registration</p>
                        <p style="font-size:12px;color:var(--text-muted);margin:0;">DataMind Analytics — Pending Verification</p>
                    </div>
                    <span style="font-size:11px;color:var(--text-muted);white-space:nowrap;">30 min ago</span>
                </div>
                <div class="activity-item">
                    <div class="act-dot" style="background:#fefce8;color:#ca8a04;"><i class="fa-solid fa-briefcase"></i></div>
                    <div style="flex:1;">
                        <p style="font-size:13.5px;font-weight:500;color:var(--text-dark);margin:0 0 2px 0;">New Internship Posted</p>
                        <p style="font-size:12px;color:var(--text-muted);margin:0;">Full-Stack Dev Intern — TechNova Pvt Ltd</p>
                    </div>
                    <span style="font-size:11px;color:var(--text-muted);white-space:nowrap;">1 hr ago</span>
                </div>
                <div class="activity-item">
                    <div class="act-dot" style="background:#fef2f2;color:#ef4444;"><i class="fa-solid fa-stamp"></i></div>
                    <div style="flex:1;">
                        <p style="font-size:13.5px;font-weight:500;color:var(--text-dark);margin:0 0 2px 0;">Company Approved</p>
                        <p style="font-size:12px;color:var(--text-muted);margin:0;">DesignStudio Co. — Verified by Admin</p>
                    </div>
                    <span style="font-size:11px;color:var(--text-muted);white-space:nowrap;">2 hr ago</span>
                </div>
                <div class="activity-item">
                    <div class="act-dot" style="background:#faf5ff;color:#7c3aed;"><i class="fa-solid fa-certificate"></i></div>
                    <div style="flex:1;">
                        <p style="font-size:13.5px;font-weight:500;color:var(--text-dark);margin:0 0 2px 0;">Certificate Generated</p>
                        <p style="font-size:12px;color:var(--text-muted);margin:0;">Anjali Desai — Data Analyst Intern</p>
                    </div>
                    <span style="font-size:11px;color:var(--text-muted);white-space:nowrap;">3 hr ago</span>
                </div>
            </div>
        </div>

        <!-- Pending Approvals -->
        <div class="co-panel" style="padding:0;overflow:hidden;">
            <div class="co-panel-header" style="padding:16px 20px;">
                <h3>Pending Approvals <span class="badge-count" style="font-size:12px;padding:2px 8px;">15</span></h3>
                <a href="admin-companies.aspx" class="btn btn-ghost" style="padding:4px 10px;font-size:12px;">View All</a>
            </div>
            <table class="table mb-0" style="font-size:13px;width:100%;">
                <thead style="background:#f8fafc;">
                    <tr>
                        <th style="padding:10px 16px;border:none;font-size:11.5px;color:var(--text-muted);font-weight:600;text-transform:uppercase;letter-spacing:.4px;">Name</th>
                        <th style="padding:10px 16px;border:none;font-size:11.5px;color:var(--text-muted);font-weight:600;text-transform:uppercase;letter-spacing:.4px;">Type</th>
                        <th style="padding:10px 16px;border:none;font-size:11.5px;color:var(--text-muted);font-weight:600;text-transform:uppercase;letter-spacing:.4px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="padding:12px 16px;border-color:var(--border-light);"><strong>Sneha Joshi</strong><div style="font-size:11px;color:var(--text-muted);">ENR2024015</div></td>
                        <td style="padding:12px 16px;border-color:var(--border-light);"><span class="co-badge" style="background:#eff6ff;color:#2563eb;border-color:#bfdbfe;">Student</span></td>
                        <td style="padding:12px 16px;border-color:var(--border-light);">
                            <button type="button" class="btn btn-ghost" style="padding:2px 8px;font-size:11.5px;background:#f0fdf4;color:#16a34a;border-color:#bbf7d0;" onclick="if(window.simsShowToast) window.simsShowToast('Student approved!','success')">Approve</button>
                            <button type="button" class="btn btn-ghost" style="padding:2px 8px;font-size:11.5px;background:#fef2f2;color:#ef4444;border-color:#fecaca;margin-left:6px;" onclick="if(window.simsShowToast) window.simsShowToast('Student rejected.','error')">Reject</button>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:12px 16px;border-color:var(--border-light);"><strong>DataMind Analytics</strong><div style="font-size:11px;color:var(--text-muted);">Company</div></td>
                        <td style="padding:12px 16px;border-color:var(--border-light);"><span class="co-badge" style="background:#f0fdf4;color:#16a34a;border-color:#bbf7d0;">Company</span></td>
                        <td style="padding:12px 16px;border-color:var(--border-light);">
                            <button type="button" class="btn btn-ghost" style="padding:2px 8px;font-size:11.5px;background:#f0fdf4;color:#16a34a;border-color:#bbf7d0;" onclick="if(window.simsShowToast) window.simsShowToast('Company verified!','success')">Verify</button>
                            <button type="button" class="btn btn-ghost" style="padding:2px 8px;font-size:11.5px;background:#fef2f2;color:#ef4444;border-color:#fecaca;margin-left:6px;" onclick="if(window.simsShowToast) window.simsShowToast('Company rejected.','error')">Reject</button>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:12px 16px;border-color:var(--border-light);"><strong>Full-Stack Dev Intern</strong><div style="font-size:11px;color:var(--text-muted);">TechNova</div></td>
                        <td style="padding:12px 16px;border-color:var(--border-light);"><span class="co-badge" style="background:#fefce8;color:#ca8a04;border-color:#fef08a;">Internship</span></td>
                        <td style="padding:12px 16px;border-color:var(--border-light);">
                            <button type="button" class="btn btn-ghost" style="padding:2px 8px;font-size:11.5px;background:#f0fdf4;color:#16a34a;border-color:#bbf7d0;" onclick="if(window.simsShowToast) window.simsShowToast('Internship approved!','success')">Approve</button>
                            <button type="button" class="btn btn-ghost" style="padding:2px 8px;font-size:11.5px;background:#fef2f2;color:#ef4444;border-color:#fecaca;margin-left:6px;" onclick="if(window.simsShowToast) window.simsShowToast('Rejected.','error')">Reject</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>
</asp:Content>

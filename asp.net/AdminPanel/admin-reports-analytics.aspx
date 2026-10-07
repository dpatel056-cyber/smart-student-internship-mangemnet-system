<%@ Page Title="Reports & Analytics" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-reports-analytics.aspx.cs" Inherits="asp.net.ReportsAnalytics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- ApexCharts CDN -->
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
    <style>
        .stats-grid-8 {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 30px;
        }
        @media (max-width: 1200px) {
            .stats-grid-8 {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 600px) {
            .stats-grid-8 {
                grid-template-columns: 1fr;
            }
        }
        .stat-card-modern {
            background: #FFFFFF;
            border: 1px solid #E2E8F0;
            border-radius: 14px;
            padding: 18px 20px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 1px 3px rgba(15, 23, 42, 0.03);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .stat-card-modern:hover {
            box-shadow: 0 4px 12px rgba(15, 23, 42, 0.06);
            transform: translateY(-2px);
        }
        .stat-icon-wrapper {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }
        .stat-content-modern {
            display: flex;
            flex-direction: column;
            min-width: 0;
        }
        .stat-label-modern {
            font-size: 13px;
            color: #64748B;
            font-weight: 500;
            margin-bottom: 2px;
            white-space: nowrap;
        }
        .stat-value-modern {
            font-size: 24px;
            font-weight: 700;
            color: #0F172A;
            line-height: 1.2;
        }
        /* ================= 12 CHARTS GRID ================= */
        .charts-section-title {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 12px;
        }
        .charts-section-title h2 {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .charts-grid-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 22px;
        }
        @media (max-width: 991px) {
            .charts-grid-container {
                grid-template-columns: 1fr;
            }
        }
        .chart-card {
            background: #FFFFFF;
            border: 1px solid #E2E8F0;
            border-radius: 16px;
            padding: 22px;
            box-shadow: 0 2px 8px rgba(15, 23, 42, 0.03);
            display: flex;
            flex-direction: column;
            transition: box-shadow 0.2s ease;
        }
        .chart-card:hover {
            box-shadow: 0 6px 18px rgba(15, 23, 42, 0.06);
        }
        .chart-card-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            margin-bottom: 16px;
            gap: 12px;
        }
        .chart-header-left {
            display: flex;
            flex-direction: column;
            gap: 3px;
        }
        .chart-card-title {
            font-size: 15.5px;
            font-weight: 700;
            color: #0F172A;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .chart-card-subtitle {
            font-size: 12.5px;
            color: #64748B;
            margin: 0;
        }
        .chart-type-badge {
            font-size: 11.5px;
            font-weight: 600;
            padding: 3px 9px;
            border-radius: 6px;
            background: #F1F5F9;
            color: #475569;
            white-space: nowrap;
        }
        .chart-body {
            min-height: 290px;
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div style="padding: 10px 0 50px 0;">
        <!-- Header -->
        <div style="margin-bottom: 24px;">
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Reports &amp; Analytics</h1>
            <p style="color: #64748b; margin: 0; font-size: 14px;">Real-time system analytics, student activity, placement trends, and platform performance.</p>
        </div>
        <!-- 8 DYNAMIC KPI STAT CARDS -->
        <div class="stats-grid-8">
            <!-- Card 1: Total Students -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper" style="background: #F3E8FF; color: #9333EA;">
                    <i class="fa-solid fa-graduation-cap"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Total Students</span>
                    <span class="stat-value-modern"><asp:Label ID="lblTotalStudents" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 2: Total Companies -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper" style="background: #EFF6FF; color: #2563EB;">
                    <i class="fa-solid fa-building"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Total Companies</span>
                    <span class="stat-value-modern"><asp:Label ID="lblTotalCompanies" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 3: Total Internships -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper" style="background: #D1FAE5; color: #059669;">
                    <i class="fa-solid fa-briefcase"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Total Internships</span>
                    <span class="stat-value-modern"><asp:Label ID="lblTotalInternships" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 4: Total Applications -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper" style="background: #FFEDD5; color: #EA580C;">
                    <i class="fa-solid fa-file-lines"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Total Applications</span>
                    <span class="stat-value-modern"><asp:Label ID="lblTotalApplications" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 5: Average Rating -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper" style="background: #FEF3C7; color: #D97706;">
                    <i class="fa-solid fa-star"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Average Rating</span>
                    <span class="stat-value-modern"><asp:Label ID="lblAvgRating" runat="server">5.0 / 5</asp:Label></span>
                </div>
            </div>
            <!-- Card 6: Upcoming Interviews -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper" style="background: #F5F3FF; color: #9333EA;">
                    <i class="fa-solid fa-calendar-days"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Upcoming Interviews</span>
                    <span class="stat-value-modern"><asp:Label ID="lblInterviewsCount" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 7: Certificates Issued -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper" style="background: #CCFBF1; color: #0D9488;">
                    <i class="fa-solid fa-certificate"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Certificates Issued</span>
                    <span class="stat-value-modern"><asp:Label ID="lblCertificatesCount" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 8: Total Inquiries -->
            <div class="stat-card-modern">
                <div class="stat-icon-wrapper" style="background: #FCE7F3; color: #DB2777;">
                    <i class="fa-solid fa-comments"></i>
                </div>
                <div class="stat-content-modern">
                    <span class="stat-label-modern">Total Inquiries</span>
                    <span class="stat-value-modern"><asp:Label ID="lblTotalInquiries" runat="server">0</asp:Label></span>
                </div>
            </div>
        </div>
        <!-- ================= 12 VISUAL CHARTS SECTION ================= -->
        <div class="charts-section-title">
            <h2><i class="fa-solid fa-chart-pie" style="color: #2563eb;"></i> Interactive Analytics &amp; Visual Reports</h2>
            <span style="font-size: 13px; color: #64748b;"><i class="fa-solid fa-bolt" style="color: #f59e0b;"></i> Live Data Synchronized</span>
        </div>
        <div class="charts-grid-container">
            <!-- Chart 1: Monthly Registrations (Line) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-chart-line" style="color: #2563eb;"></i> 1. Monthly Registrations</h3>
                        <p class="chart-card-subtitle">Students vs Companies signup growth</p>
                    </div>
                    <span class="chart-type-badge">Line Chart</span>
                </div>
                <div class="chart-body" id="chart1_monthly_reg"></div>
            </div>
            <!-- Chart 2: Applications per Month (Area) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-chart-area" style="color: #059669;"></i> 2. Applications per Month</h3>
                        <p class="chart-card-subtitle">Student application submission activity</p>
                    </div>
                    <span class="chart-type-badge">Area Chart</span>
                </div>
                <div class="chart-body" id="chart2_apps_month"></div>
            </div>
            <!-- Chart 3: Application Status (Doughnut) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-chart-pie" style="color: #7c3aed;"></i> 3. Application Status Split</h3>
                        <p class="chart-card-subtitle">Applied / Shortlisted / Selected / Rejected</p>
                    </div>
                    <span class="chart-type-badge">Doughnut</span>
                </div>
                <div class="chart-body" id="chart3_app_status"></div>
            </div>
            <!-- Chart 4: Internships by Domain (Vertical Bar) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-chart-column" style="color: #ea580c;"></i> 4. Internships by Domain</h3>
                        <p class="chart-card-subtitle">Top technical domains with posted internships</p>
                    </div>
                    <span class="chart-type-badge">Vertical Bar</span>
                </div>
                <div class="chart-body" id="chart4_internship_domains"></div>
            </div>
            <!-- Chart 5: Top 10 Companies by Applicants (Horizontal Bar) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-building-user" style="color: #0284c7;"></i> 5. Top Companies by Applicants</h3>
                        <p class="chart-card-subtitle">Most popular companies attracting candidates</p>
                    </div>
                    <span class="chart-type-badge">Horizontal Bar</span>
                </div>
                <div class="chart-body" id="chart5_top_companies"></div>
            </div>
            <!-- Chart 6: Work Mode Split (Pie) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-laptop-house" style="color: #16a34a;"></i> 6. Work Mode Split</h3>
                        <p class="chart-card-subtitle">Remote / On-site / Hybrid distribution</p>
                    </div>
                    <span class="chart-type-badge">Pie Chart</span>
                </div>
                <div class="chart-body" id="chart6_work_mode"></div>
            </div>
            <!-- Chart 7: Status per Month (Stacked Bar) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-layer-group" style="color: #d97706;"></i> 7. Status per Month</h3>
                        <p class="chart-card-subtitle">Monthly hiring progression and pipeline trend</p>
                    </div>
                    <span class="chart-type-badge">Stacked Bar</span>
                </div>
                <div class="chart-body" id="chart7_status_month"></div>
            </div>
            <!-- Chart 8: Domain: Internships vs Applications (Radar) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-compass-drafting" style="color: #db2777;"></i> 8. Internships vs Applications</h3>
                        <p class="chart-card-subtitle">Supply vs student demand comparison across domains</p>
                    </div>
                    <span class="chart-type-badge">Radar Chart</span>
                </div>
                <div class="chart-body" id="chart8_domain_radar"></div>
            </div>
            <!-- Chart 9: Hiring Funnel (Funnel) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-filter" style="color: #4f46e5;"></i> 9. Hiring Funnel</h3>
                        <p class="chart-card-subtitle">Progression: Applied &rarr; Shortlisted &rarr; Interview &rarr; Selected &rarr; Certified</p>
                    </div>
                    <span class="chart-type-badge">Funnel Chart</span>
                </div>
                <div class="chart-body" id="chart9_hiring_funnel"></div>
            </div>
            <!-- Chart 10: Top Colleges (Polar Area) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-school" style="color: #0d9488;"></i> 10. Top Colleges / Universities</h3>
                        <p class="chart-card-subtitle">Student representation across institutes</p>
                    </div>
                    <span class="chart-type-badge">Polar Area</span>
                </div>
                <div class="chart-body" id="chart10_top_colleges"></div>
            </div>
            <!-- Chart 11: Rating Distribution (Bar) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-star-half-stroke" style="color: #f59e0b;"></i> 11. Rating Distribution</h3>
                        <p class="chart-card-subtitle">Feedback star ratings (1 Star to 5 Stars)</p>
                    </div>
                    <span class="chart-type-badge">Bar Chart</span>
                </div>
                <div class="chart-body" id="chart11_rating_dist"></div>
            </div>
            <!-- Chart 12: Selection Rate % (Gauge) -->
            <div class="chart-card">
                <div class="chart-card-header">
                    <div class="chart-header-left">
                        <h3 class="chart-card-title"><i class="fa-solid fa-gauge-high" style="color: #10b981;"></i> 12. Selection Rate %</h3>
                        <p class="chart-card-subtitle">Percentage of applicants selected for roles</p>
                    </div>
                    <span class="chart-type-badge">Gauge Chart</span>
                </div>
                <div class="chart-body" id="chart12_selection_gauge"></div>
            </div>
        </div>
    </div>
    <!-- ================= APEXCHARTS INITIALIZATION SCRIPT ================= -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Server-injected JSON Data
            const c1Data = <%= Chart1Json %>;
            const c2Data = <%= Chart2Json %>;
            const c3Data = <%= Chart3Json %>;
            const c4Data = <%= Chart4Json %>;
            const c5Data = <%= Chart5Json %>;
            const c6Data = <%= Chart6Json %>;
            const c7Data = <%= Chart7Json %>;
            const c8Data = <%= Chart8Json %>;
            const c9Data = <%= Chart9Json %>;
            const c10Data = <%= Chart10Json %>;
            const c11Data = <%= Chart11Json %>;
            const c12Data = <%= Chart12Json %>;
            // 1. Monthly Registrations (Line Chart)
            new ApexCharts(document.querySelector("#chart1_monthly_reg"), {
                series: [
                    { name: 'Students', data: c1Data.studentSeries || [2, 3, 4, 6, 12, 15] },
                    { name: 'Companies', data: c1Data.companySeries || [1, 2, 3, 5, 10, 15] }
                ],
                chart: { height: 280, type: 'line', toolbar: { show: false }, zoom: { enabled: false } },
                colors: ['#2563EB', '#16A34A'],
                stroke: { width: [3, 3], curve: 'smooth' },
                xaxis: { categories: c1Data.categories || ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'] },
                markers: { size: 5 },
                legend: { position: 'top' },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 2. Applications per Month (Area Chart)
            new ApexCharts(document.querySelector("#chart2_apps_month"), {
                series: [{ name: 'Applications', data: c2Data.data || [0, 0, 1, 3, 12, 9] }],
                chart: { height: 280, type: 'area', toolbar: { show: false } },
                colors: ['#059669'],
                stroke: { curve: 'smooth', width: 2 },
                fill: { type: 'gradient', gradient: { shadeIntensity: 1, opacityFrom: 0.45, opacityTo: 0.05 } },
                xaxis: { categories: c2Data.categories || ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'] },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 3. Application Status (Doughnut Chart)
            new ApexCharts(document.querySelector("#chart3_app_status"), {
                series: c3Data.series || [1, 14, 6],
                labels: c3Data.labels || ['Pending', 'Selected', 'Shortlisted'],
                chart: { height: 280, type: 'donut' },
                colors: ['#F59E0B', '#10B981', '#3B82F6', '#EF4444'],
                legend: { position: 'bottom' },
                plotOptions: { pie: { donut: { size: '65%' } } }
            }).render();
            // 4. Internships by Domain (Vertical Column Bar)
            new ApexCharts(document.querySelector("#chart4_internship_domains"), {
                series: [{ name: 'Internships', data: c4Data.data || [8, 6, 6, 5, 5, 5, 5] }],
                chart: { height: 280, type: 'bar', toolbar: { show: false } },
                colors: ['#EA580C'],
                plotOptions: { bar: { borderRadius: 6, columnWidth: '45%' } },
                xaxis: { categories: c4Data.categories || ['Software Dev', 'Cloud', 'Web Dev', 'Data Science', 'Cyber Security', 'AI', 'Full Stack'] },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 5. Top 10 Companies by Applicants (Horizontal Bar)
            new ApexCharts(document.querySelector("#chart5_top_companies"), {
                series: [{ name: 'Applicants', data: c5Data.data || [3, 2, 2, 2, 2, 1, 1, 1, 1, 1] }],
                chart: { height: 280, type: 'bar', toolbar: { show: false } },
                colors: ['#0284C7'],
                plotOptions: { bar: { horizontal: true, borderRadius: 6, barHeight: '55%' } },
                xaxis: { categories: c5Data.categories || ['TechNova', 'Apex Web', 'CloudSphere', 'CyberPulse', 'InnovateX', 'BlueWave', 'CartSphere', 'DataCraft', 'EduVerse', 'FinVeda'] },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 6. Work Mode Split (Pie Chart)
            new ApexCharts(document.querySelector("#chart6_work_mode"), {
                series: c6Data.series || [25, 22, 13],
                labels: c6Data.labels || ['Hybrid', 'On-site', 'Remote'],
                chart: { height: 280, type: 'pie' },
                colors: ['#3B82F6', '#10B981', '#8B5CF6'],
                legend: { position: 'bottom' }
            }).render();
            // 7. Status per Month (Stacked Bar)
            new ApexCharts(document.querySelector("#chart7_status_month"), {
                series: [
                    { name: 'Selected', data: c7Data.selected || [0, 0, 0, 1, 5, 8] },
                    { name: 'Shortlisted', data: c7Data.shortlisted || [0, 0, 0, 1, 3, 2] },
                    { name: 'Applied / Pending', data: c7Data.applied || [0, 0, 1, 1, 4, 3] }
                ],
                chart: { height: 280, type: 'bar', stacked: true, toolbar: { show: false } },
                colors: ['#10B981', '#3B82F6', '#F59E0B'],
                xaxis: { categories: c7Data.categories || ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'] },
                legend: { position: 'top' },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 8. Domain: Internships vs Applications (Radar Chart)
            new ApexCharts(document.querySelector("#chart8_domain_radar"), {
                series: [
                    { name: 'Internships Posted', data: c8Data.internships || [8, 6, 6, 5, 5, 5] },
                    { name: 'Applications Received', data: c8Data.applications || [3, 3, 2, 2, 1, 1] }
                ],
                chart: {
                    height: 320,
                    type: 'radar',
                    toolbar: { show: false },
                    dropShadow: { enabled: true, blur: 2, left: 1, top: 1, opacity: 0.08 }
                },
                colors: ['#2563EB', '#EC4899'],
                stroke: { width: 2.5 },
                fill: { opacity: 0.25 },
                markers: { size: 4, hover: { size: 7 } },
                plotOptions: {
                    radar: {
                        size: 100,
                        polygons: {
                            strokeColors: '#E2E8F0',
                            strokeWidth: 1,
                            connectorColors: '#E2E8F0',
                            fill: { colors: ['#F8FAFC', '#FFFFFF'] }
                        }
                    }
                },
                yaxis: { show: false },
                xaxis: {
                    categories: c8Data.categories || ['Software Dev', 'Web Dev', 'Cloud', 'Cyber Sec', 'Data Science', 'Full Stack'],
                    labels: {
                        style: {
                            colors: ['#334155', '#334155', '#334155', '#334155', '#334155', '#334155'],
                            fontSize: '12px',
                            fontWeight: 600
                        }
                    }
                },
                legend: {
                    position: 'bottom',
                    fontSize: '13px',
                    markers: { radius: 6 }
                }
            }).render();
            // 9. Hiring Funnel (Funnel / Horizontal Bar)
            new ApexCharts(document.querySelector("#chart9_hiring_funnel"), {
                series: [{ name: 'Count', data: c9Data.data || [21, 6, 9, 14, 0] }],
                chart: { height: 280, type: 'bar', toolbar: { show: false } },
                colors: ['#4F46E5'],
                plotOptions: {
                    bar: {
                        horizontal: true,
                        borderRadius: 6,
                        barHeight: '55%',
                        distributed: true
                    }
                },
                colors: ['#3B82F6', '#6366F1', '#8B5CF6', '#10B981', '#06B6D4'],
                xaxis: { categories: c9Data.categories || ['1. Applied', '2. Shortlisted', '3. Interviewed', '4. Selected', '5. Certified'] },
                legend: { show: false },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 10. Top Colleges (Polar Area Chart)
            new ApexCharts(document.querySelector("#chart10_top_colleges"), {
                series: c10Data.series || [5, 1, 1, 1, 1, 1],
                labels: c10Data.labels || ['RK University', 'Gujarat Univ', 'GTU', 'Govt Poly', 'GLS Univ', 'DA-IICT'],
                chart: { height: 280, type: 'polarArea' },
                colors: ['#0D9488', '#3B82F6', '#8B5CF6', '#EC4899', '#F59E0B', '#10B981'],
                stroke: { colors: ['#fff'] },
                fill: { opacity: 0.85 },
                legend: { position: 'bottom' }
            }).render();
            // 11. Rating Distribution (Bar Chart)
            new ApexCharts(document.querySelector("#chart11_rating_dist"), {
                series: [{ name: 'Reviews', data: c11Data.data || [0, 0, 0, 2, 3] }],
                chart: { height: 280, type: 'bar', toolbar: { show: false } },
                colors: ['#F59E0B'],
                plotOptions: { bar: { borderRadius: 6, columnWidth: '45%', distributed: true } },
                colors: ['#EF4444', '#F97316', '#FBBF24', '#34D399', '#10B981'],
                xaxis: { categories: c11Data.categories || ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'] },
                legend: { show: false },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 12. Selection Rate % (Gauge / RadialBar Chart)
            new ApexCharts(document.querySelector("#chart12_selection_gauge"), {
                series: [c12Data.percentage || 66.7],
                chart: { height: 280, type: 'radialBar' },
                plotOptions: {
                    radialBar: {
                        startAngle: -135,
                        endAngle: 135,
                        hollow: { size: '70%' },
                        track: { background: '#F1F5F9', strokeWidth: '100%' },
                        dataLabels: {
                            name: { fontSize: '14px', color: '#64748B', offsetY: -10 },
                            value: { fontSize: '26px', fontWeight: 700, color: '#0F172A', offsetY: 5, formatter: val => val + '%' }
                        }
                    }
                },
                fill: {
                    type: 'gradient',
                    gradient: {
                        shade: 'dark',
                        type: 'horizontal',
                        shadeIntensity: 0.5,
                        gradientToColors: ['#10B981'],
                        stops: [0, 100]
                    }
                },
                colors: ['#3B82F6'],
                stroke: { dashArray: 4 },
                labels: ['Placement Rate']
            }).render();
        });
    </script>
</asp:Content>

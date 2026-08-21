<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-student-applications.aspx.cs" Inherits="asp.net.admin_student_applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-student-applications.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <div class="sims-applications-page">

        <!-- ===================== PAGE HEADER ===================== -->
        <div class="sims-application-header">
            <div class="sims-application-header-left">
                <div class="sims-application-breadcrumb">
                    <span>Dashboard</span>
                    <i class="fa-solid fa-chevron-right"></i>
                    <span>Student Management</span>
                    <i class="fa-solid fa-chevron-right"></i>
                    <span class="sims-application-breadcrumb-current">Applications</span>
                </div>
                <h1 class="sims-application-title">Student Applications</h1>
                <p class="sims-application-subtitle">Review, monitor and manage internship applications submitted by students.</p>
            </div>
            <div class="sims-application-header-right">
                <button type="button" class="sims-app-btn sims-app-btn-outline" id="btnAdvancedFilters">
                    <i class="fa-solid fa-sliders"></i>
                    <span>Advanced Filters</span>
                </button>
                <button type="button" class="sims-app-btn sims-app-btn-primary" id="btnExportApplications">
                    <i class="fa-solid fa-download"></i>
                    <span>Export Applications</span>
                </button>
            </div>
        </div>

        <!-- ===================== STATISTICS ===================== -->
        <div class="sims-application-stats">

            <div class="sims-application-stat-card">
                <div class="sims-application-stat-icon sims-stat-icon-total">
                    <i class="fa-solid fa-file-lines"></i>
                </div>
                <div class="sims-application-stat-info">
                    <span class="sims-application-stat-label">Total Applications</span>
                    <span class="sims-application-stat-number">2,480</span>
                    <span class="sims-application-stat-desc">All internship applications</span>
                </div>
            </div>

            <div class="sims-application-stat-card">
                <div class="sims-application-stat-icon sims-stat-icon-pending">
                    <i class="fa-solid fa-hourglass-half"></i>
                </div>
                <div class="sims-application-stat-info">
                    <span class="sims-application-stat-label">Pending</span>
                    <span class="sims-application-stat-number">450</span>
                    <span class="sims-application-stat-desc">Awaiting review</span>
                </div>
            </div>

            <div class="sims-application-stat-card">
                <div class="sims-application-stat-icon sims-stat-icon-shortlisted">
                    <i class="fa-solid fa-list-check"></i>
                </div>
                <div class="sims-application-stat-info">
                    <span class="sims-application-stat-label">Shortlisted</span>
                    <span class="sims-application-stat-number">280</span>
                    <span class="sims-application-stat-desc">Students shortlisted</span>
                </div>
            </div>

            <div class="sims-application-stat-card">
                <div class="sims-application-stat-icon sims-stat-icon-selected">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div class="sims-application-stat-info">
                    <span class="sims-application-stat-label">Selected</span>
                    <span class="sims-application-stat-number">325</span>
                    <span class="sims-application-stat-desc">Students selected</span>
                </div>
            </div>

            <div class="sims-application-stat-card">
                <div class="sims-application-stat-icon sims-stat-icon-rejected">
                    <i class="fa-solid fa-circle-xmark"></i>
                </div>
                <div class="sims-application-stat-info">
                    <span class="sims-application-stat-label">Rejected</span>
                    <span class="sims-application-stat-number">175</span>
                    <span class="sims-application-stat-desc">Applications rejected</span>
                </div>
            </div>

        </div>

        <!-- ===================== SEARCH & FILTER PANEL ===================== -->
        <div class="sims-application-filters" id="applicationFiltersPanel">
            <div class="sims-application-search">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" id="appSearchInput" placeholder="Search by student, internship or company..." />
            </div>

            <div class="sims-application-filter-group">
                <label>Application Status</label>
                <select id="filterStatus">
                    <option value="all">All Status</option>
                    <option value="pending">Pending</option>
                    <option value="shortlisted">Shortlisted</option>
                    <option value="selected">Selected</option>
                    <option value="rejected">Rejected</option>
                </select>
            </div>

            <div class="sims-application-filter-group">
                <label>Internship</label>
                <select id="filterInternship">
                    <option value="all">All Internships</option>
                    <option value="web-developer">Web Developer Intern</option>
                    <option value="dotnet-developer">.NET Developer Intern</option>
                    <option value="uiux-design">UI/UX Design Intern</option>
                    <option value="data-analyst">Data Analyst Intern</option>
                </select>
            </div>

            <div class="sims-application-filter-group">
                <label>Company</label>
                <select id="filterCompany">
                    <option value="all">All Companies</option>
                    <option value="abc-technologies">ABC Technologies</option>
                    <option value="techsoft">TechSoft Pvt Ltd</option>
                    <option value="innovate-labs">Innovate Labs</option>
                    <option value="datatech">DataTech Solutions</option>
                </select>
            </div>

            <div class="sims-application-filter-group">
                <label>Applied Date</label>
                <select id="filterDate">
                    <option value="all">All Dates</option>
                    <option value="today">Today</option>
                    <option value="week">This Week</option>
                    <option value="month">This Month</option>
                    <option value="custom">Custom Date</option>
                </select>
            </div>

            <div class="sims-application-filter-actions">
                <button type="button" class="sims-app-btn sims-app-btn-primary" id="btnApplyFilters">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <span>Search</span>
                </button>
                <button type="button" class="sims-app-btn sims-app-btn-outline" id="btnResetFilters">
                    <i class="fa-solid fa-rotate-left"></i>
                    <span>Reset</span>
                </button>
            </div>
        </div>

        <!-- ===================== MAIN LAYOUT: TABLE + ACTIVITY ===================== -->
        <div class="sims-application-main-layout">

            <!-- ============== TABLE CARD ============== -->
            <div class="sims-application-table-card">

                <div class="sims-application-table-header">
                    <div class="sims-application-table-title-group">
                        <h2>All Applications</h2>
                        <span class="sims-application-table-count">2,480 Applications</span>
                    </div>

                    <!-- Bulk action toolbar (hidden until selection) -->
                    <div class="sims-application-bulk-toolbar" id="bulkToolbar">
                        <span class="sims-application-bulk-count"><strong id="bulkSelectedCount">0</strong> Selected</span>
                        <button type="button" class="sims-app-btn sims-app-btn-sm sims-app-btn-outline" id="bulkShortlist">
                            <i class="fa-solid fa-list-check"></i> Shortlist Selected
                        </button>
                        <button type="button" class="sims-app-btn sims-app-btn-sm sims-app-btn-outline" id="bulkExport">
                            <i class="fa-solid fa-download"></i> Export Selected
                        </button>
                        <button type="button" class="sims-app-btn sims-app-btn-sm sims-app-btn-danger-outline" id="bulkReject">
                            <i class="fa-solid fa-ban"></i> Reject Selected
                        </button>
                        <button type="button" class="sims-app-btn sims-app-btn-sm sims-app-btn-danger-outline" id="bulkDelete">
                            <i class="fa-solid fa-trash"></i> Delete Selected
                        </button>
                    </div>
                </div>

                <div class="sims-application-table-scroll">
                    <table class="sims-application-table" id="applicationsTable">
                        <thead>
                            <tr>
                                <th class="sims-app-col-checkbox">
                                    <input type="checkbox" id="selectAllApplications" />
                                </th>
                                <th>Student</th>
                                <th>Internship</th>
                                <th>Company</th>
                                <th>Applied Date</th>
                                <th>Status</th>
                                <th>Interview</th>
                                <th>Resume</th>
                                <th class="sims-app-col-actions">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="applicationsTableBody">

                            <!-- ROW 1 : PENDING -->
                            <tr data-status="pending" data-app-id="APP-1001">
                                <td class="sims-app-col-checkbox"><input type="checkbox" class="sims-app-row-checkbox" /></td>
                                <td>
                                    <div class="sims-application-student-cell">
                                        <div class="sims-application-avatar">DP</div>
                                        <div>
                                            <div class="sims-application-student-name">Dhruvi Patel</div>
                                            <div class="sims-application-student-id">STU-1001</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="sims-application-internship-name">Web Developer Intern</div>
                                    <div class="sims-application-internship-category">Web Development</div>
                                </td>
                                <td>
                                    <div class="sims-application-company-name">ABC Technologies</div>
                                    <div class="sims-application-company-industry">Information Technology</div>
                                </td>
                                <td class="sims-application-date">18 Aug 2026</td>
                                <td><span class="sims-application-status sims-status-pending"><i class="fa-solid fa-hourglass-half"></i> Pending</span></td>
                                <td>
                                    <div class="sims-application-interview sims-interview-none">
                                        <i class="fa-regular fa-calendar"></i> Not Scheduled
                                    </div>
                                </td>
                                <td>
                                    <button type="button" class="sims-app-resume-btn"><i class="fa-solid fa-file-pdf"></i> View Resume</button>
                                </td>
                                <td class="sims-app-col-actions">
                                    <div class="sims-application-action-menu">
                                        <button type="button" class="sims-app-action-trigger"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <ul class="sims-app-action-dropdown">
                                            <li><a href="#" class="sims-app-action-view"><i class="fa-solid fa-eye"></i> View Application</a></li>
                                            <li><a href="#" class="sims-app-action-shortlist"><i class="fa-solid fa-list-check"></i> Shortlist</a></li>
                                            <li><a href="#" class="sims-app-action-schedule"><i class="fa-solid fa-calendar-plus"></i> Schedule Interview</a></li>
                                            <li><a href="#" class="sims-app-action-reject sims-app-action-danger"><i class="fa-solid fa-ban"></i> Reject Application</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>

                            <!-- ROW 2 : SHORTLISTED -->
                            <tr data-status="shortlisted" data-app-id="APP-1002">
                                <td class="sims-app-col-checkbox"><input type="checkbox" class="sims-app-row-checkbox" /></td>
                                <td>
                                    <div class="sims-application-student-cell">
                                        <div class="sims-application-avatar">RS</div>
                                        <div>
                                            <div class="sims-application-student-name">Rahul Shah</div>
                                            <div class="sims-application-student-id">STU-1002</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="sims-application-internship-name">.NET Developer Intern</div>
                                    <div class="sims-application-internship-category">Software Development</div>
                                </td>
                                <td>
                                    <div class="sims-application-company-name">TechSoft Pvt Ltd</div>
                                    <div class="sims-application-company-industry">Information Technology</div>
                                </td>
                                <td class="sims-application-date">16 Aug 2026</td>
                                <td><span class="sims-application-status sims-status-shortlisted"><i class="fa-solid fa-list-check"></i> Shortlisted</span></td>
                                <td>
                                    <div class="sims-application-interview sims-interview-none">
                                        <i class="fa-regular fa-calendar"></i> Not Scheduled
                                    </div>
                                </td>
                                <td>
                                    <button type="button" class="sims-app-resume-btn"><i class="fa-solid fa-file-pdf"></i> View Resume</button>
                                </td>
                                <td class="sims-app-col-actions">
                                    <div class="sims-application-action-menu">
                                        <button type="button" class="sims-app-action-trigger"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <ul class="sims-app-action-dropdown">
                                            <li><a href="#" class="sims-app-action-view"><i class="fa-solid fa-eye"></i> View Application</a></li>
                                            <li><a href="#" class="sims-app-action-schedule"><i class="fa-solid fa-calendar-plus"></i> Schedule Interview</a></li>
                                            <li><a href="#" class="sims-app-action-select"><i class="fa-solid fa-circle-check"></i> Select Student</a></li>
                                            <li><a href="#" class="sims-app-action-reject sims-app-action-danger"><i class="fa-solid fa-ban"></i> Reject Application</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>

                            <!-- ROW 3 : SELECTED -->
                            <tr data-status="selected" data-app-id="APP-1003">
                                <td class="sims-app-col-checkbox"><input type="checkbox" class="sims-app-row-checkbox" /></td>
                                <td>
                                    <div class="sims-application-student-cell">
                                        <div class="sims-application-avatar">PM</div>
                                        <div>
                                            <div class="sims-application-student-name">Priya Mehta</div>
                                            <div class="sims-application-student-id">STU-1003</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="sims-application-internship-name">UI/UX Design Intern</div>
                                    <div class="sims-application-internship-category">Design</div>
                                </td>
                                <td>
                                    <div class="sims-application-company-name">Innovate Labs</div>
                                    <div class="sims-application-company-industry">Product Design</div>
                                </td>
                                <td class="sims-application-date">10 Aug 2026</td>
                                <td><span class="sims-application-status sims-status-selected"><i class="fa-solid fa-circle-check"></i> Selected</span></td>
                                <td>
                                    <div class="sims-application-interview sims-interview-completed">
                                        <i class="fa-solid fa-calendar-check"></i> Completed
                                    </div>
                                </td>
                                <td>
                                    <button type="button" class="sims-app-resume-btn"><i class="fa-solid fa-file-pdf"></i> View Resume</button>
                                </td>
                                <td class="sims-app-col-actions">
                                    <div class="sims-application-action-menu">
                                        <button type="button" class="sims-app-action-trigger"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <ul class="sims-app-action-dropdown">
                                            <li><a href="#" class="sims-app-action-view"><i class="fa-solid fa-eye"></i> View Application</a></li>
                                            <li><a href="#" class="sims-app-action-resume"><i class="fa-solid fa-file-pdf"></i> View Resume</a></li>
                                            <li><a href="#" class="sims-app-action-student"><i class="fa-solid fa-user"></i> View Student</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>

                            <!-- ROW 4 : REJECTED -->
                            <tr data-status="rejected" data-app-id="APP-1004">
                                <td class="sims-app-col-checkbox"><input type="checkbox" class="sims-app-row-checkbox" /></td>
                                <td>
                                    <div class="sims-application-student-cell">
                                        <div class="sims-application-avatar">AV</div>
                                        <div>
                                            <div class="sims-application-student-name">Aarav Verma</div>
                                            <div class="sims-application-student-id">STU-1004</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="sims-application-internship-name">Data Analyst Intern</div>
                                    <div class="sims-application-internship-category">Data &amp; Analytics</div>
                                </td>
                                <td>
                                    <div class="sims-application-company-name">DataTech Solutions</div>
                                    <div class="sims-application-company-industry">Data Analytics</div>
                                </td>
                                <td class="sims-application-date">05 Aug 2026</td>
                                <td><span class="sims-application-status sims-status-rejected"><i class="fa-solid fa-circle-xmark"></i> Rejected</span></td>
                                <td>
                                    <div class="sims-application-interview sims-interview-cancelled">
                                        <i class="fa-solid fa-calendar-xmark"></i> Cancelled
                                    </div>
                                </td>
                                <td>
                                    <button type="button" class="sims-app-resume-btn"><i class="fa-solid fa-file-pdf"></i> View Resume</button>
                                </td>
                                <td class="sims-app-col-actions">
                                    <div class="sims-application-action-menu">
                                        <button type="button" class="sims-app-action-trigger"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <ul class="sims-app-action-dropdown">
                                            <li><a href="#" class="sims-app-action-view"><i class="fa-solid fa-eye"></i> View Application</a></li>
                                            <li><a href="#" class="sims-app-action-resume"><i class="fa-solid fa-file-pdf"></i> View Resume</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>

                            <!-- ROW 5 : PENDING -->
                            <tr data-status="pending" data-app-id="APP-1005">
                                <td class="sims-app-col-checkbox"><input type="checkbox" class="sims-app-row-checkbox" /></td>
                                <td>
                                    <div class="sims-application-student-cell">
                                        <div class="sims-application-avatar">MK</div>
                                        <div>
                                            <div class="sims-application-student-name">Meera Kapoor</div>
                                            <div class="sims-application-student-id">STU-1005</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="sims-application-internship-name">Web Developer Intern</div>
                                    <div class="sims-application-internship-category">Web Development</div>
                                </td>
                                <td>
                                    <div class="sims-application-company-name">ABC Technologies</div>
                                    <div class="sims-application-company-industry">Information Technology</div>
                                </td>
                                <td class="sims-application-date">19 Aug 2026</td>
                                <td><span class="sims-application-status sims-status-pending"><i class="fa-solid fa-hourglass-half"></i> Pending</span></td>
                                <td>
                                    <div class="sims-application-interview sims-interview-scheduled">
                                        <i class="fa-solid fa-calendar-days"></i>
                                        <div>
                                            <div>22 Aug 2026</div>
                                            <div class="sims-application-interview-time">10:30 AM</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <button type="button" class="sims-app-resume-btn"><i class="fa-solid fa-file-pdf"></i> View Resume</button>
                                </td>
                                <td class="sims-app-col-actions">
                                    <div class="sims-application-action-menu">
                                        <button type="button" class="sims-app-action-trigger"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <ul class="sims-app-action-dropdown">
                                            <li><a href="#" class="sims-app-action-view"><i class="fa-solid fa-eye"></i> View Application</a></li>
                                            <li><a href="#" class="sims-app-action-shortlist"><i class="fa-solid fa-list-check"></i> Shortlist</a></li>
                                            <li><a href="#" class="sims-app-action-schedule"><i class="fa-solid fa-calendar-plus"></i> Schedule Interview</a></li>
                                            <li><a href="#" class="sims-app-action-reject sims-app-action-danger"><i class="fa-solid fa-ban"></i> Reject Application</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>

                            <!-- ROW 6 : SHORTLISTED -->
                            <tr data-status="shortlisted" data-app-id="APP-1006">
                                <td class="sims-app-col-checkbox"><input type="checkbox" class="sims-app-row-checkbox" /></td>
                                <td>
                                    <div class="sims-application-student-cell">
                                        <div class="sims-application-avatar">KJ</div>
                                        <div>
                                            <div class="sims-application-student-name">Kunal Joshi</div>
                                            <div class="sims-application-student-id">STU-1006</div>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="sims-application-internship-name">Data Analyst Intern</div>
                                    <div class="sims-application-internship-category">Data &amp; Analytics</div>
                                </td>
                                <td>
                                    <div class="sims-application-company-name">DataTech Solutions</div>
                                    <div class="sims-application-company-industry">Data Analytics</div>
                                </td>
                                <td class="sims-application-date">14 Aug 2026</td>
                                <td><span class="sims-application-status sims-status-shortlisted"><i class="fa-solid fa-list-check"></i> Shortlisted</span></td>
                                <td>
                                    <div class="sims-application-interview sims-interview-none">
                                        <i class="fa-regular fa-calendar"></i> Not Scheduled
                                    </div>
                                </td>
                                <td>
                                    <button type="button" class="sims-app-resume-btn"><i class="fa-solid fa-file-pdf"></i> View Resume</button>
                                </td>
                                <td class="sims-app-col-actions">
                                    <div class="sims-application-action-menu">
                                        <button type="button" class="sims-app-action-trigger"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                        <ul class="sims-app-action-dropdown">
                                            <li><a href="#" class="sims-app-action-view"><i class="fa-solid fa-eye"></i> View Application</a></li>
                                            <li><a href="#" class="sims-app-action-schedule"><i class="fa-solid fa-calendar-plus"></i> Schedule Interview</a></li>
                                            <li><a href="#" class="sims-app-action-select"><i class="fa-solid fa-circle-check"></i> Select Student</a></li>
                                            <li><a href="#" class="sims-app-action-reject sims-app-action-danger"><i class="fa-solid fa-ban"></i> Reject Application</a></li>
                                        </ul>
                                    </div>
                                </td>
                            </tr>

                        </tbody>
                    </table>

                    <!-- ============== EMPTY STATE (hidden by default) ============== -->
                    <div class="sims-application-empty-state" id="applicationsEmptyState" style="display:none;">
                        <i class="fa-solid fa-folder-open"></i>
                        <h3>No applications found</h3>
                        <p>Try changing your search or filter criteria.</p>
                        <button type="button" class="sims-app-btn sims-app-btn-outline" id="btnClearFiltersEmpty">Clear Filters</button>
                    </div>
                </div>

                <!-- ============== PAGINATION ============== -->
                <div class="sims-application-pagination">
                    <div class="sims-application-pagination-info">
                        Showing 1&ndash;10 of 2,480 applications
                    </div>
                    <div class="sims-application-pagination-controls">
                        <button type="button" class="sims-app-page-btn" disabled><i class="fa-solid fa-chevron-left"></i> Previous</button>
                        <button type="button" class="sims-app-page-btn active">1</button>
                        <button type="button" class="sims-app-page-btn">2</button>
                        <button type="button" class="sims-app-page-btn">3</button>
                        <button type="button" class="sims-app-page-btn">4</button>
                        <button type="button" class="sims-app-page-btn">5</button>
                        <button type="button" class="sims-app-page-btn">Next <i class="fa-solid fa-chevron-right"></i></button>
                    </div>
                    <div class="sims-application-pagination-size">
                        <label for="pageSizeSelect">Show</label>
                        <select id="pageSizeSelect">
                            <option value="10">10</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                        </select>
                    </div>
                </div>

            </div>

            <!-- ============== RECENT ACTIVITY ============== -->
            <aside class="sims-application-activity-card">
                <h3 class="sims-application-activity-title">Recent Application Activity</h3>
                <ul class="sims-application-activity-list">
                    <li>
                        <span class="sims-application-activity-icon sims-activity-applied"><i class="fa-solid fa-file-circle-plus"></i></span>
                        <div>
                            <p><strong>Dhruvi Patel</strong> applied for Web Developer Intern</p>
                            <span class="sims-application-activity-time">10 minutes ago</span>
                        </div>
                    </li>
                    <li>
                        <span class="sims-application-activity-icon sims-activity-shortlisted"><i class="fa-solid fa-list-check"></i></span>
                        <div>
                            <p><strong>Rahul Shah</strong> was shortlisted</p>
                            <span class="sims-application-activity-time">25 minutes ago</span>
                        </div>
                    </li>
                    <li>
                        <span class="sims-application-activity-icon sims-activity-selected"><i class="fa-solid fa-circle-check"></i></span>
                        <div>
                            <p><strong>Priya Mehta</strong> was selected</p>
                            <span class="sims-application-activity-time">1 hour ago</span>
                        </div>
                    </li>
                    <li>
                        <span class="sims-application-activity-icon sims-activity-rejected"><i class="fa-solid fa-circle-xmark"></i></span>
                        <div>
                            <p><strong>Aarav Verma's</strong> application was rejected</p>
                            <span class="sims-application-activity-time">2 hours ago</span>
                        </div>
                    </li>
                    <li>
                        <span class="sims-application-activity-icon sims-activity-interview"><i class="fa-solid fa-calendar-check"></i></span>
                        <div>
                            <p>Interview scheduled for <strong>Meera Kapoor</strong></p>
                            <span class="sims-application-activity-time">3 hours ago</span>
                        </div>
                    </li>
                </ul>
            </aside>

        </div>
    </div>

    <!-- ===================== VIEW APPLICATION MODAL ===================== -->
    <div class="sims-application-modal-overlay" id="viewApplicationOverlay">
        <div class="sims-application-modal sims-application-modal-lg" role="dialog" aria-modal="true">
            <div class="sims-application-modal-header">
                <h3>Application Details</h3>
                <button type="button" class="sims-application-modal-close" data-close-modal="viewApplicationOverlay"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="sims-application-modal-body">

                <div class="sims-application-modal-profile">
                    <div class="sims-application-avatar sims-application-avatar-lg">DP</div>
                    <div>
                        <div class="sims-application-modal-profile-name">Dhruvi Patel</div>
                        <div class="sims-application-modal-profile-id">STU-1001</div>
                    </div>
                    <span class="sims-application-status sims-status-pending sims-application-modal-status"><i class="fa-solid fa-hourglass-half"></i> Pending</span>
                </div>

                <!-- Status Timeline -->
                <div class="sims-application-timeline">
                    <div class="sims-application-timeline-step completed">
                        <span class="sims-application-timeline-dot"><i class="fa-solid fa-check"></i></span>
                        <span class="sims-application-timeline-label">Applied</span>
                    </div>
                    <div class="sims-application-timeline-line completed"></div>
                    <div class="sims-application-timeline-step active">
                        <span class="sims-application-timeline-dot"><i class="fa-solid fa-magnifying-glass"></i></span>
                        <span class="sims-application-timeline-label">Under Review</span>
                    </div>
                    <div class="sims-application-timeline-line"></div>
                    <div class="sims-application-timeline-step">
                        <span class="sims-application-timeline-dot"><i class="fa-solid fa-list-check"></i></span>
                        <span class="sims-application-timeline-label">Shortlisted</span>
                    </div>
                    <div class="sims-application-timeline-line"></div>
                    <div class="sims-application-timeline-step">
                        <span class="sims-application-timeline-dot"><i class="fa-solid fa-calendar-check"></i></span>
                        <span class="sims-application-timeline-label">Interview</span>
                    </div>
                    <div class="sims-application-timeline-line"></div>
                    <div class="sims-application-timeline-step">
                        <span class="sims-application-timeline-dot"><i class="fa-solid fa-circle-check"></i></span>
                        <span class="sims-application-timeline-label">Selected</span>
                    </div>
                </div>

                <div class="sims-application-modal-grid">

                    <div class="sims-application-modal-section">
                        <h4>Student Information</h4>
                        <div class="sims-application-modal-detail-row"><span>Full Name</span><strong>Dhruvi Patel</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Email</span><strong>dhruvi.patel@example.com</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Phone</span><strong>+91 98765 43210</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Course</span><strong>B.Tech Computer Engineering</strong></div>
                        <div class="sims-application-modal-detail-row"><span>College</span><strong>L.D. College of Engineering</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Semester</span><strong>7th Semester</strong></div>
                        <div class="sims-application-modal-detail-row"><span>CGPA</span><strong>8.6 / 10</strong></div>
                    </div>

                    <div class="sims-application-modal-section">
                        <h4>Internship Information</h4>
                        <div class="sims-application-modal-detail-row"><span>Internship Title</span><strong>Web Developer Intern</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Category</span><strong>Web Development</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Company</span><strong>ABC Technologies</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Location</span><strong>Ahmedabad, Gujarat</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Duration</span><strong>6 Months</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Stipend</span><strong>&#8377;12,000 / month</strong></div>
                    </div>

                    <div class="sims-application-modal-section">
                        <h4>Application Information</h4>
                        <div class="sims-application-modal-detail-row"><span>Application ID</span><strong>APP-1001</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Applied Date</span><strong>18 Aug 2026</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Current Status</span><strong>Pending</strong></div>
                        <div class="sims-application-modal-detail-row"><span>Last Updated</span><strong>19 Aug 2026</strong></div>
                    </div>

                    <div class="sims-application-modal-section">
                        <h4>Skills</h4>
                        <div class="sims-application-skill-tags">
                            <span class="sims-application-skill-tag">HTML</span>
                            <span class="sims-application-skill-tag">CSS</span>
                            <span class="sims-application-skill-tag">JavaScript</span>
                            <span class="sims-application-skill-tag">ASP.NET</span>
                            <span class="sims-application-skill-tag">SQL</span>
                        </div>
                    </div>

                    <div class="sims-application-modal-section sims-application-modal-section-full">
                        <h4>Resume</h4>
                        <div class="sims-application-resume-actions">
                            <button type="button" class="sims-app-btn sims-app-btn-outline"><i class="fa-solid fa-file-pdf"></i> View Resume</button>
                            <button type="button" class="sims-app-btn sims-app-btn-outline"><i class="fa-solid fa-download"></i> Download Resume</button>
                        </div>
                    </div>

                </div>
            </div>
            <div class="sims-application-modal-footer">
                <button type="button" class="sims-app-btn sims-app-btn-outline" data-close-modal="viewApplicationOverlay">Close</button>
                <button type="button" class="sims-app-btn sims-app-btn-danger-outline" id="viewModalRejectBtn">Reject</button>
                <button type="button" class="sims-app-btn sims-app-btn-primary" id="viewModalShortlistBtn">Shortlist</button>
            </div>
        </div>
    </div>

    <!-- ===================== SCHEDULE INTERVIEW MODAL ===================== -->
    <div class="sims-application-modal-overlay" id="scheduleInterviewOverlay">
        <div class="sims-interview-modal" role="dialog" aria-modal="true">
            <div class="sims-application-modal-header">
                <h3>Schedule Interview</h3>
                <button type="button" class="sims-application-modal-close" data-close-modal="scheduleInterviewOverlay"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="sims-application-modal-body">

                <div class="sims-application-modal-mini-profile">
                    <div class="sims-application-avatar">DP</div>
                    <div>
                        <div class="sims-application-modal-profile-name">Dhruvi Patel</div>
                        <div class="sims-application-modal-profile-id">Web Developer Intern &middot; ABC Technologies</div>
                    </div>
                </div>

                <form class="sims-interview-form">
                    <div class="sims-interview-form-grid">
                        <div class="sims-interview-form-field">
                            <label>Interview Date</label>
                            <input type="date" />
                        </div>
                        <div class="sims-interview-form-field">
                            <label>Interview Time</label>
                            <input type="time" />
                        </div>
                        <div class="sims-interview-form-field">
                            <label>Interview Mode</label>
                            <select id="interviewModeSelect">
                                <option value="online">Online</option>
                                <option value="offline">Offline</option>
                            </select>
                        </div>
                        <div class="sims-interview-form-field">
                            <label>Interviewer</label>
                            <select>
                                <option>HR Manager</option>
                                <option>Technical Lead</option>
                                <option>Team Manager</option>
                            </select>
                        </div>
                        <div class="sims-interview-form-field sims-interview-mode-online" id="meetingLinkField">
                            <label>Meeting Link</label>
                            <input type="text" placeholder="https://meet.google.com/xxx-xxxx-xxx" />
                        </div>
                        <div class="sims-interview-form-field sims-interview-mode-offline" id="locationField" style="display:none;">
                            <label>Interview Location</label>
                            <input type="text" placeholder="Company office address" />
                        </div>
                        <div class="sims-interview-form-field sims-interview-form-field-full">
                            <label>Notes</label>
                            <textarea rows="3" placeholder="Any additional notes for the interview..."></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="sims-application-modal-footer">
                <button type="button" class="sims-app-btn sims-app-btn-outline" data-close-modal="scheduleInterviewOverlay">Cancel</button>
                <button type="button" class="sims-app-btn sims-app-btn-primary" id="confirmScheduleBtn">Schedule Interview</button>
            </div>
        </div>
    </div>

    <!-- ===================== REJECT APPLICATION MODAL ===================== -->
    <div class="sims-application-modal-overlay" id="rejectApplicationOverlay">
        <div class="sims-rejection-modal" role="dialog" aria-modal="true">
            <div class="sims-application-modal-header">
                <h3>Reject Application</h3>
                <button type="button" class="sims-application-modal-close" data-close-modal="rejectApplicationOverlay"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="sims-application-modal-body">
                <div class="sims-rejection-warning">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                    <p>Are you sure you want to reject this application?</p>
                </div>
                <div class="sims-application-modal-detail-row"><span>Student</span><strong>Dhruvi Patel</strong></div>
                <div class="sims-application-modal-detail-row"><span>Internship</span><strong>Web Developer Intern</strong></div>

                <div class="sims-interview-form-field sims-interview-form-field-full" style="margin-top:16px;">
                    <label>Rejection Reason <span class="sims-optional-tag">(optional)</span></label>
                    <textarea rows="3" placeholder="Add a reason for rejecting this application..."></textarea>
                </div>
            </div>
            <div class="sims-application-modal-footer">
                <button type="button" class="sims-app-btn sims-app-btn-outline" data-close-modal="rejectApplicationOverlay">Cancel</button>
                <button type="button" class="sims-app-btn sims-app-btn-danger" id="confirmRejectBtn">Reject Application</button>
            </div>
        </div>
    </div>

    <!-- ===================== DELETE CONFIRMATION MODAL ===================== -->
    <div class="sims-application-modal-overlay" id="deleteApplicationOverlay">
        <div class="sims-rejection-modal" role="dialog" aria-modal="true">
            <div class="sims-application-modal-header">
                <h3>Delete Application</h3>
                <button type="button" class="sims-application-modal-close" data-close-modal="deleteApplicationOverlay"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="sims-application-modal-body">
                <div class="sims-rejection-warning">
                    <i class="fa-solid fa-trash"></i>
                    <p>This action cannot be undone. Are you sure you want to permanently delete this application?</p>
                </div>
            </div>
            <div class="sims-application-modal-footer">
                <button type="button" class="sims-app-btn sims-app-btn-outline" data-close-modal="deleteApplicationOverlay">Cancel</button>
                <button type="button" class="sims-app-btn sims-app-btn-danger" id="confirmDeleteBtn">Delete Application</button>
            </div>
        </div>
    </div>
</asp:Content>





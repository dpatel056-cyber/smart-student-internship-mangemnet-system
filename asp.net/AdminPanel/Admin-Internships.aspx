<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-internships.aspx.cs" Inherits="asp.net.admin_internships" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link rel="stylesheet" href="../css/admin-internships.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <div class="sims-internship-page">

        <!-- =========================================================
             1. PAGE HEADER
        ========================================================== -->
        <div class="sims-internship-header">
            <div class="sims-internship-header-left">
                <nav class="sims-internship-breadcrumb" aria-label="breadcrumb">
                    <span>Dashboard</span>
                    <i class="fas fa-chevron-right"></i>
                    <span class="sims-internship-breadcrumb-current">Internship Management</span>
                </nav>
                <h1 class="sims-internship-title">Internship Management</h1>
                <p class="sims-internship-subtitle">Manage, review and monitor all internship opportunities posted by registered companies.</p>
            </div>
            <div class="sims-internship-header-right">
                <button type="button" class="sims-internship-btn sims-internship-btn-secondary" id="btnExportInternships">
                    <i class="fas fa-file-export"></i>
                    <span>Export Internships</span>
                </button>
                <button type="button" class="sims-internship-btn sims-internship-btn-primary" id="btnAddInternship">
                    <i class="fas fa-plus"></i>
                    <span>Add Internship</span>
                </button>
            </div>
        </div>

        <!-- =========================================================
             2. STATISTICS CARDS
        ========================================================== -->
        <div class="sims-internship-stats">

            <div class="sims-internship-stat-card">
                <div class="sims-internship-stat-icon sims-internship-stat-icon-total">
                    <i class="fas fa-briefcase"></i>
                </div>
                <div class="sims-internship-stat-body">
                    <span class="sims-internship-stat-number">320</span>
                    <span class="sims-internship-stat-label">Total Internships</span>
                    <span class="sims-internship-stat-desc">All internship postings</span>
                </div>
                <span class="sims-internship-stat-dot sims-internship-stat-dot-total"></span>
            </div>

            <div class="sims-internship-stat-card">
                <div class="sims-internship-stat-icon sims-internship-stat-icon-active">
                    <i class="fas fa-bolt"></i>
                </div>
                <div class="sims-internship-stat-body">
                    <span class="sims-internship-stat-number">245</span>
                    <span class="sims-internship-stat-label">Active Internships</span>
                    <span class="sims-internship-stat-desc">Currently accepting applications</span>
                </div>
                <span class="sims-internship-stat-dot sims-internship-stat-dot-active"></span>
            </div>

            <div class="sims-internship-stat-card">
                <div class="sims-internship-stat-icon sims-internship-stat-icon-pending">
                    <i class="fas fa-hourglass-half"></i>
                </div>
                <div class="sims-internship-stat-body">
                    <span class="sims-internship-stat-number">28</span>
                    <span class="sims-internship-stat-label">Pending Approval</span>
                    <span class="sims-internship-stat-desc">Awaiting admin review</span>
                </div>
                <span class="sims-internship-stat-dot sims-internship-stat-dot-pending"></span>
            </div>

            <div class="sims-internship-stat-card">
                <div class="sims-internship-stat-icon sims-internship-stat-icon-closed">
                    <i class="fas fa-lock"></i>
                </div>
                <div class="sims-internship-stat-body">
                    <span class="sims-internship-stat-number">35</span>
                    <span class="sims-internship-stat-label">Closed Internships</span>
                    <span class="sims-internship-stat-desc">No longer accepting applications</span>
                </div>
                <span class="sims-internship-stat-dot sims-internship-stat-dot-closed"></span>
            </div>

            <div class="sims-internship-stat-card">
                <div class="sims-internship-stat-icon sims-internship-stat-icon-rejected">
                    <i class="fas fa-ban"></i>
                </div>
                <div class="sims-internship-stat-body">
                    <span class="sims-internship-stat-number">12</span>
                    <span class="sims-internship-stat-label">Rejected</span>
                    <span class="sims-internship-stat-desc">Rejected internship postings</span>
                </div>
                <span class="sims-internship-stat-dot sims-internship-stat-dot-rejected"></span>
            </div>

            <div class="sims-internship-stat-card">
                <div class="sims-internship-stat-icon sims-internship-stat-icon-applications">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div class="sims-internship-stat-body">
                    <span class="sims-internship-stat-number">4,850</span>
                    <span class="sims-internship-stat-label">Total Applications</span>
                    <span class="sims-internship-stat-desc">Applications received</span>
                </div>
                <span class="sims-internship-stat-dot sims-internship-stat-dot-applications"></span>
            </div>

        </div>

        <!-- =========================================================
             3. SEARCH & FILTER PANEL
        ========================================================== -->
        <div class="sims-internship-filters">
            <div class="sims-internship-filters-search">
                <i class="fas fa-search"></i>
                <input type="text" id="txtInternshipSearch" placeholder="Search by internship title, company or internship ID..." />
            </div>

            <div class="sims-internship-filters-row">

                <div class="sims-internship-filter-group">
                    <label for="ddlStatus">Internship Status</label>
                    <select id="ddlStatus">
                        <option value="all">All Status</option>
                        <option value="pending">Pending</option>
                        <option value="approved">Approved</option>
                        <option value="active">Active</option>
                        <option value="closed">Closed</option>
                        <option value="rejected">Rejected</option>
                        <option value="draft">Draft</option>
                    </select>
                </div>

                <div class="sims-internship-filter-group">
                    <label for="ddlCompany">Company</label>
                    <select id="ddlCompany">
                        <option value="all">All Companies</option>
                        <option value="abc-technologies">ABC Technologies</option>
                        <option value="techsoft">TechSoft Pvt Ltd</option>
                        <option value="innovate-labs">Innovate Labs</option>
                        <option value="datatech">DataTech Solutions</option>
                        <option value="finserve">FinServe Pvt Ltd</option>
                    </select>
                </div>

                <div class="sims-internship-filter-group">
                    <label for="ddlCategory">Category</label>
                    <select id="ddlCategory">
                        <option value="all">All Categories</option>
                        <option value="web-development">Web Development</option>
                        <option value="software-development">Software Development</option>
                        <option value="uiux-design">UI/UX Design</option>
                        <option value="data-analytics">Data Analytics</option>
                        <option value="data-science">Data Science</option>
                        <option value="mobile-app-development">Mobile App Development</option>
                        <option value="digital-marketing">Digital Marketing</option>
                    </select>
                </div>

                <div class="sims-internship-filter-group">
                    <label for="ddlWorkMode">Work Mode</label>
                    <select id="ddlWorkMode">
                        <option value="all">All Modes</option>
                        <option value="remote">Remote</option>
                        <option value="onsite">On-site</option>
                        <option value="hybrid">Hybrid</option>
                    </select>
                </div>

                <div class="sims-internship-filter-group">
                    <label for="ddlType">Internship Type</label>
                    <select id="ddlType">
                        <option value="all">All Types</option>
                        <option value="full-time">Full Time</option>
                        <option value="part-time">Part Time</option>
                        <option value="paid">Paid</option>
                        <option value="unpaid">Unpaid</option>
                    </select>
                </div>

                <div class="sims-internship-filter-group">
                    <label for="ddlDatePosted">Date Posted</label>
                    <select id="ddlDatePosted">
                        <option value="all">All Dates</option>
                        <option value="today">Today</option>
                        <option value="week">This Week</option>
                        <option value="month">This Month</option>
                        <option value="custom">Custom Date</option>
                    </select>
                </div>

                <div class="sims-internship-filter-actions">
                    <button type="button" class="sims-internship-btn sims-internship-btn-primary" id="btnSearchInternships">
                        <i class="fas fa-search"></i>
                        <span>Search</span>
                    </button>
                    <button type="button" class="sims-internship-btn sims-internship-btn-outline" id="btnResetInternships">
                        <i class="fas fa-rotate-left"></i>
                        <span>Reset</span>
                    </button>
                </div>

            </div>
        </div>

        <!-- =========================================================
             22. BULK ACTIONS TOOLBAR (hidden until selection)
        ========================================================== -->
        <div class="sims-internship-bulk-toolbar" id="bulkToolbar" hidden>
            <span class="sims-internship-bulk-count"><strong id="bulkSelectedCount">0</strong> Selected</span>
            <div class="sims-internship-bulk-actions">
                <button type="button" class="sims-internship-bulk-btn" data-bulk-action="approve">
                    <i class="fas fa-check"></i> Approve Selected
                </button>
                <button type="button" class="sims-internship-bulk-btn" data-bulk-action="activate">
                    <i class="fas fa-bolt"></i> Activate Selected
                </button>
                <button type="button" class="sims-internship-bulk-btn" data-bulk-action="close">
                    <i class="fas fa-lock"></i> Close Selected
                </button>
                <button type="button" class="sims-internship-bulk-btn" data-bulk-action="export">
                    <i class="fas fa-file-export"></i> Export Selected
                </button>
                <button type="button" class="sims-internship-bulk-btn sims-internship-bulk-btn-danger" data-bulk-action="delete">
                    <i class="fas fa-trash"></i> Delete Selected
                </button>
            </div>
        </div>

        <!-- =========================================================
             4. MAIN INTERNSHIP TABLE
        ========================================================== -->
        <div class="sims-internship-table-card">
            <div class="sims-internship-table-header">
                <h2>All Internships</h2>
                <span class="sims-internship-table-count" id="internshipTotalCount">320 Internships</span>
            </div>

            <div class="sims-internship-table-scroll">
                <table class="sims-internship-table" id="internshipTable">
                    <thead>
                        <tr>
                            <th class="sims-internship-th-check">
                                <input type="checkbox" id="chkSelectAll" />
                            </th>
                            <th>Internship</th>
                            <th>Company</th>
                            <th>Category</th>
                            <th>Location</th>
                            <th>Work Mode</th>
                            <th>Applications</th>
                            <th>Deadline</th>
                            <th>Status</th>
                            <th class="sims-internship-th-actions">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="internshipTableBody">

                        <!-- ROW 1 - ACTIVE -->
                        <tr class="sims-internship-row" data-status="active" data-id="INT-1001">
                            <td><input type="checkbox" class="sims-internship-row-check" /></td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-avatar sims-internship-avatar-blue"><i class="fas fa-laptop-code"></i></div>
                                    <div>
                                        <span class="sims-internship-cell-title">Web Developer Intern</span>
                                        <span class="sims-internship-cell-sub">INT-1001</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-company-avatar">AT</div>
                                    <div>
                                        <a href="#" class="sims-internship-company-link" data-action="view-company">ABC Technologies</a>
                                        <span class="sims-internship-cell-sub">COM-1001</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="sims-internship-badge sims-internship-badge-webdev">Web Development</span></td>
                            <td>
                                <div class="sims-internship-location"><i class="fas fa-location-dot"></i> Ahmedabad, Gujarat</div>
                            </td>
                            <td><span class="sims-internship-mode sims-internship-mode-hybrid">Hybrid</span></td>
                            <td>
                                <a href="#" class="sims-internship-applications" data-action="view-applications">
                                    <span class="sims-internship-app-count">35</span> / 50
                                    <div class="sims-internship-app-bar"><span style="width:70%"></span></div>
                                </a>
                            </td>
                            <td>
                                <div class="sims-internship-deadline">
                                    <span>30 Aug 2026</span>
                                    <span class="sims-internship-deadline-sub sims-internship-deadline-soon">5 days left</span>
                                </div>
                            </td>
                            <td><span class="sims-internship-status sims-internship-status-active"><i class="fas fa-bolt"></i> Active</span></td>
                            <td class="sims-internship-td-actions">
                                <div class="sims-internship-action-menu">
                                    <button type="button" class="sims-internship-action-trigger" data-menu-trigger><i class="fas fa-ellipsis-vertical"></i></button>
                                    <div class="sims-internship-action-dropdown" data-status-menu="active">
                                        <a href="#" data-action="view"><i class="fas fa-eye"></i> View Internship</a>
                                        <a href="#" data-action="edit"><i class="fas fa-pen"></i> Edit Internship</a>
                                        <a href="#" data-action="view-applications"><i class="fas fa-file-alt"></i> View Applications</a>
                                        <a href="#" data-action="view-company"><i class="fas fa-building"></i> View Company</a>
                                        <div class="sims-internship-action-divider"></div>
                                        <a href="#" data-action="close" class="sims-internship-action-warn"><i class="fas fa-lock"></i> Close Internship</a>
                                    </div>
                                </div>
                            </td>
                        </tr>

                        <!-- ROW 2 - PENDING -->
                        <tr class="sims-internship-row" data-status="pending" data-id="INT-1002">
                            <td><input type="checkbox" class="sims-internship-row-check" /></td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-avatar sims-internship-avatar-purple"><i class="fas fa-code"></i></div>
                                    <div>
                                        <span class="sims-internship-cell-title">.NET Developer Intern</span>
                                        <span class="sims-internship-cell-sub">INT-1002</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-company-avatar">TS</div>
                                    <div>
                                        <a href="#" class="sims-internship-company-link" data-action="view-company">TechSoft Pvt Ltd</a>
                                        <span class="sims-internship-cell-sub">COM-1002</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="sims-internship-badge sims-internship-badge-softdev">Software Development</span></td>
                            <td>
                                <div class="sims-internship-location"><i class="fas fa-location-dot"></i> Surat, Gujarat</div>
                            </td>
                            <td><span class="sims-internship-mode sims-internship-mode-onsite">On-site</span></td>
                            <td>
                                <a href="#" class="sims-internship-applications" data-action="view-applications">
                                    <span class="sims-internship-app-count">12</span> / 40
                                    <div class="sims-internship-app-bar"><span style="width:30%"></span></div>
                                </a>
                            </td>
                            <td>
                                <div class="sims-internship-deadline">
                                    <span>05 Sep 2026</span>
                                    <span class="sims-internship-deadline-sub">17 days left</span>
                                </div>
                            </td>
                            <td><span class="sims-internship-status sims-internship-status-pending"><i class="fas fa-hourglass-half"></i> Pending</span></td>
                            <td class="sims-internship-td-actions">
                                <div class="sims-internship-action-menu">
                                    <button type="button" class="sims-internship-action-trigger" data-menu-trigger><i class="fas fa-ellipsis-vertical"></i></button>
                                    <div class="sims-internship-action-dropdown" data-status-menu="pending">
                                        <a href="#" data-action="view"><i class="fas fa-eye"></i> View Internship</a>
                                        <a href="#" data-action="edit"><i class="fas fa-pen"></i> Edit Internship</a>
                                        <a href="#" data-action="approve" class="sims-internship-action-success"><i class="fas fa-check"></i> Approve Internship</a>
                                        <a href="#" data-action="reject" class="sims-internship-action-danger"><i class="fas fa-xmark"></i> Reject Internship</a>
                                        <a href="#" data-action="view-company"><i class="fas fa-building"></i> View Company</a>
                                        <div class="sims-internship-action-divider"></div>
                                        <a href="#" data-action="delete" class="sims-internship-action-danger"><i class="fas fa-trash"></i> Delete Internship</a>
                                    </div>
                                </div>
                            </td>
                        </tr>

                        <!-- ROW 3 - APPROVED -->
                        <tr class="sims-internship-row" data-status="approved" data-id="INT-1003">
                            <td><input type="checkbox" class="sims-internship-row-check" /></td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-avatar sims-internship-avatar-pink"><i class="fas fa-pen-ruler"></i></div>
                                    <div>
                                        <span class="sims-internship-cell-title">UI/UX Designer Intern</span>
                                        <span class="sims-internship-cell-sub">INT-1003</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-company-avatar">IL</div>
                                    <div>
                                        <a href="#" class="sims-internship-company-link" data-action="view-company">Innovate Labs</a>
                                        <span class="sims-internship-cell-sub">COM-1003</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="sims-internship-badge sims-internship-badge-uiux">UI/UX Design</span></td>
                            <td>
                                <div class="sims-internship-location"><i class="fas fa-location-dot"></i> Remote</div>
                            </td>
                            <td><span class="sims-internship-mode sims-internship-mode-remote">Remote</span></td>
                            <td>
                                <a href="#" class="sims-internship-applications" data-action="view-applications">
                                    <span class="sims-internship-app-count">22</span> / 30
                                    <div class="sims-internship-app-bar"><span style="width:73%"></span></div>
                                </a>
                            </td>
                            <td>
                                <div class="sims-internship-deadline">
                                    <span>10 Sep 2026</span>
                                    <span class="sims-internship-deadline-sub">22 days left</span>
                                </div>
                            </td>
                            <td><span class="sims-internship-status sims-internship-status-approved"><i class="fas fa-circle-check"></i> Approved</span></td>
                            <td class="sims-internship-td-actions">
                                <div class="sims-internship-action-menu">
                                    <button type="button" class="sims-internship-action-trigger" data-menu-trigger><i class="fas fa-ellipsis-vertical"></i></button>
                                    <div class="sims-internship-action-dropdown" data-status-menu="approved">
                                        <a href="#" data-action="view"><i class="fas fa-eye"></i> View Internship</a>
                                        <a href="#" data-action="edit"><i class="fas fa-pen"></i> Edit Internship</a>
                                        <a href="#" data-action="activate" class="sims-internship-action-success"><i class="fas fa-bolt"></i> Activate Internship</a>
                                        <a href="#" data-action="view-applications"><i class="fas fa-file-alt"></i> View Applications</a>
                                        <a href="#" data-action="view-company"><i class="fas fa-building"></i> View Company</a>
                                        <div class="sims-internship-action-divider"></div>
                                        <a href="#" data-action="close" class="sims-internship-action-warn"><i class="fas fa-lock"></i> Close Internship</a>
                                    </div>
                                </div>
                            </td>
                        </tr>

                        <!-- ROW 4 - CLOSED -->
                        <tr class="sims-internship-row" data-status="closed" data-id="INT-1004">
                            <td><input type="checkbox" class="sims-internship-row-check" /></td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-avatar sims-internship-avatar-teal"><i class="fas fa-chart-line"></i></div>
                                    <div>
                                        <span class="sims-internship-cell-title">Data Analyst Intern</span>
                                        <span class="sims-internship-cell-sub">INT-1004</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-company-avatar">DT</div>
                                    <div>
                                        <a href="#" class="sims-internship-company-link" data-action="view-company">DataTech Solutions</a>
                                        <span class="sims-internship-cell-sub">COM-1004</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="sims-internship-badge sims-internship-badge-analytics">Data Analytics</span></td>
                            <td>
                                <div class="sims-internship-location"><i class="fas fa-location-dot"></i> Vadodara, Gujarat</div>
                            </td>
                            <td><span class="sims-internship-mode sims-internship-mode-hybrid">Hybrid</span></td>
                            <td>
                                <a href="#" class="sims-internship-applications" data-action="view-applications">
                                    <span class="sims-internship-app-count">50</span> / 50
                                    <div class="sims-internship-app-bar"><span style="width:100%"></span></div>
                                </a>
                            </td>
                            <td>
                                <div class="sims-internship-deadline">
                                    <span>01 Aug 2026</span>
                                    <span class="sims-internship-deadline-sub sims-internship-deadline-expired">Expired</span>
                                </div>
                            </td>
                            <td><span class="sims-internship-status sims-internship-status-closed"><i class="fas fa-lock"></i> Closed</span></td>
                            <td class="sims-internship-td-actions">
                                <div class="sims-internship-action-menu">
                                    <button type="button" class="sims-internship-action-trigger" data-menu-trigger><i class="fas fa-ellipsis-vertical"></i></button>
                                    <div class="sims-internship-action-dropdown" data-status-menu="closed">
                                        <a href="#" data-action="view"><i class="fas fa-eye"></i> View Internship</a>
                                        <a href="#" data-action="edit"><i class="fas fa-pen"></i> Edit Internship</a>
                                        <a href="#" data-action="view-applications"><i class="fas fa-file-alt"></i> View Applications</a>
                                        <a href="#" data-action="view-company"><i class="fas fa-building"></i> View Company</a>
                                        <a href="#" data-action="duplicate"><i class="fas fa-clone"></i> Duplicate Internship</a>
                                        <div class="sims-internship-action-divider"></div>
                                        <a href="#" data-action="delete" class="sims-internship-action-danger"><i class="fas fa-trash"></i> Delete Internship</a>
                                    </div>
                                </div>
                            </td>
                        </tr>

                        <!-- ROW 5 - REJECTED -->
                        <tr class="sims-internship-row" data-status="rejected" data-id="INT-1005">
                            <td><input type="checkbox" class="sims-internship-row-check" /></td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-avatar sims-internship-avatar-gray"><i class="fas fa-mobile-screen-button"></i></div>
                                    <div>
                                        <span class="sims-internship-cell-title">Mobile App Intern</span>
                                        <span class="sims-internship-cell-sub">INT-1005</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-company-avatar">FS</div>
                                    <div>
                                        <a href="#" class="sims-internship-company-link" data-action="view-company">FinServe Pvt Ltd</a>
                                        <span class="sims-internship-cell-sub">COM-1005</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="sims-internship-badge sims-internship-badge-mobile">Mobile App Development</span></td>
                            <td>
                                <div class="sims-internship-location"><i class="fas fa-location-dot"></i> Rajkot, Gujarat</div>
                            </td>
                            <td><span class="sims-internship-mode sims-internship-mode-onsite">On-site</span></td>
                            <td>
                                <a href="#" class="sims-internship-applications" data-action="view-applications">
                                    <span class="sims-internship-app-count">0</span> / 20
                                    <div class="sims-internship-app-bar"><span style="width:0%"></span></div>
                                </a>
                            </td>
                            <td>
                                <div class="sims-internship-deadline">
                                    <span>15 Sep 2026</span>
                                    <span class="sims-internship-deadline-sub">27 days left</span>
                                </div>
                            </td>
                            <td><span class="sims-internship-status sims-internship-status-rejected"><i class="fas fa-ban"></i> Rejected</span></td>
                            <td class="sims-internship-td-actions">
                                <div class="sims-internship-action-menu">
                                    <button type="button" class="sims-internship-action-trigger" data-menu-trigger><i class="fas fa-ellipsis-vertical"></i></button>
                                    <div class="sims-internship-action-dropdown" data-status-menu="rejected">
                                        <a href="#" data-action="view"><i class="fas fa-eye"></i> View Internship</a>
                                        <a href="#" data-action="edit"><i class="fas fa-pen"></i> Edit Internship</a>
                                        <a href="#" data-action="view-company"><i class="fas fa-building"></i> View Company</a>
                                        <div class="sims-internship-action-divider"></div>
                                        <a href="#" data-action="delete" class="sims-internship-action-danger"><i class="fas fa-trash"></i> Delete Internship</a>
                                    </div>
                                </div>
                            </td>
                        </tr>

                        <!-- ROW 6 - DRAFT -->
                        <tr class="sims-internship-row" data-status="draft" data-id="INT-1006">
                            <td><input type="checkbox" class="sims-internship-row-check" /></td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-avatar sims-internship-avatar-orange"><i class="fas fa-bullhorn"></i></div>
                                    <div>
                                        <span class="sims-internship-cell-title">Digital Marketing Intern</span>
                                        <span class="sims-internship-cell-sub">INT-1006</span>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="sims-internship-cell-main">
                                    <div class="sims-internship-company-avatar">AT</div>
                                    <div>
                                        <a href="#" class="sims-internship-company-link" data-action="view-company">ABC Technologies</a>
                                        <span class="sims-internship-cell-sub">COM-1001</span>
                                    </div>
                                </div>
                            </td>
                            <td><span class="sims-internship-badge sims-internship-badge-marketing">Digital Marketing</span></td>
                            <td>
                                <div class="sims-internship-location"><i class="fas fa-location-dot"></i> Ahmedabad, Gujarat</div>
                            </td>
                            <td><span class="sims-internship-mode sims-internship-mode-hybrid">Hybrid</span></td>
                            <td>
                                <a href="#" class="sims-internship-applications" data-action="view-applications">
                                    <span class="sims-internship-app-count">0</span> / 15
                                    <div class="sims-internship-app-bar"><span style="width:0%"></span></div>
                                </a>
                            </td>
                            <td>
                                <div class="sims-internship-deadline">
                                    <span>—</span>
                                    <span class="sims-internship-deadline-sub">Not published</span>
                                </div>
                            </td>
                            <td><span class="sims-internship-status sims-internship-status-draft"><i class="fas fa-file"></i> Draft</span></td>
                            <td class="sims-internship-td-actions">
                                <div class="sims-internship-action-menu">
                                    <button type="button" class="sims-internship-action-trigger" data-menu-trigger><i class="fas fa-ellipsis-vertical"></i></button>
                                    <div class="sims-internship-action-dropdown" data-status-menu="draft">
                                        <a href="#" data-action="view"><i class="fas fa-eye"></i> View Internship</a>
                                        <a href="#" data-action="edit"><i class="fas fa-pen"></i> Edit Internship</a>
                                        <a href="#" data-action="view-company"><i class="fas fa-building"></i> View Company</a>
                                        <div class="sims-internship-action-divider"></div>
                                        <a href="#" data-action="delete" class="sims-internship-action-danger"><i class="fas fa-trash"></i> Delete Internship</a>
                                    </div>
                                </div>
                            </td>
                        </tr>

                    </tbody>
                </table>

                <!-- =========================================================
                     24. EMPTY STATE
                ========================================================== -->
                <div class="sims-internship-empty" id="internshipEmptyState" hidden>
                    <div class="sims-internship-empty-icon"><i class="fas fa-inbox"></i></div>
                    <h3>No Internships Found</h3>
                    <p>Try changing your search or filter criteria.</p>
                    <button type="button" class="sims-internship-btn sims-internship-btn-outline" id="btnClearFilters">
                        <i class="fas fa-rotate-left"></i>
                        <span>Clear Filters</span>
                    </button>
                </div>
            </div>

            <!-- =========================================================
                 23. PAGINATION
            ========================================================== -->
            <div class="sims-internship-pagination">
                <div class="sims-internship-pagination-info">
                    Showing 1–10 of 320 internships
                </div>
                <div class="sims-internship-pagination-controls">
                    <button type="button" class="sims-internship-page-btn" disabled><i class="fas fa-chevron-left"></i> Previous</button>
                    <button type="button" class="sims-internship-page-btn sims-internship-page-btn-active">1</button>
                    <button type="button" class="sims-internship-page-btn">2</button>
                    <button type="button" class="sims-internship-page-btn">3</button>
                    <button type="button" class="sims-internship-page-btn">4</button>
                    <button type="button" class="sims-internship-page-btn">5</button>
                    <button type="button" class="sims-internship-page-btn">Next <i class="fas fa-chevron-right"></i></button>
                </div>
                <div class="sims-internship-pagination-size">
                    <label for="ddlPageSize">Rows per page</label>
                    <select id="ddlPageSize">
                        <option value="10">10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- =========================================================
             25 & 26. ACTIVITY + STATUS OVERVIEW
        ========================================================== -->
        <div class="sims-internship-bottom-grid">

            <div class="sims-internship-activity">
                <h3>Recent Internship Activity</h3>
                <ul class="sims-internship-activity-list">
                    <li>
                        <span class="sims-internship-activity-icon sims-internship-activity-icon-post"><i class="fas fa-plus"></i></span>
                        <div>
                            <p><strong>ABC Technologies</strong> posted Web Developer Intern</p>
                            <span>10 minutes ago</span>
                        </div>
                    </li>
                    <li>
                        <span class="sims-internship-activity-icon sims-internship-activity-icon-approve"><i class="fas fa-check"></i></span>
                        <div>
                            <p><strong>TechSoft Pvt Ltd</strong> internship was approved</p>
                            <span>25 minutes ago</span>
                        </div>
                    </li>
                    <li>
                        <span class="sims-internship-activity-icon sims-internship-activity-icon-reject"><i class="fas fa-xmark"></i></span>
                        <div>
                            <p><strong>Innovate Labs</strong> internship was rejected</p>
                            <span>1 hour ago</span>
                        </div>
                    </li>
                    <li>
                        <span class="sims-internship-activity-icon sims-internship-activity-icon-close"><i class="fas fa-lock"></i></span>
                        <div>
                            <p><strong>DataTech Solutions</strong> closed an internship</p>
                            <span>1 hour ago</span>
                        </div>
                    </li>
                    <li>
                        <span class="sims-internship-activity-icon sims-internship-activity-icon-app"><i class="fas fa-file-alt"></i></span>
                        <div>
                            <p>New application received for <strong>UI/UX Designer Intern</strong></p>
                            <span>2 hours ago</span>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="sims-internship-status-overview">
                <h3>Status Overview</h3>

                <div class="sims-internship-status-row">
                    <span class="sims-internship-status-row-label"><i class="fas fa-circle sims-internship-dot-active"></i> Active Internships</span>
                    <span class="sims-internship-status-row-value">245</span>
                </div>
                <div class="sims-internship-progress"><span class="sims-internship-progress-fill sims-internship-progress-active" style="width:76%"></span></div>

                <div class="sims-internship-status-row">
                    <span class="sims-internship-status-row-label"><i class="fas fa-circle sims-internship-dot-pending"></i> Pending Approval</span>
                    <span class="sims-internship-status-row-value">28</span>
                </div>
                <div class="sims-internship-progress"><span class="sims-internship-progress-fill sims-internship-progress-pending" style="width:9%"></span></div>

                <div class="sims-internship-status-row">
                    <span class="sims-internship-status-row-label"><i class="fas fa-circle sims-internship-dot-closed"></i> Closed</span>
                    <span class="sims-internship-status-row-value">35</span>
                </div>
                <div class="sims-internship-progress"><span class="sims-internship-progress-fill sims-internship-progress-closed" style="width:11%"></span></div>

                <div class="sims-internship-status-row">
                    <span class="sims-internship-status-row-label"><i class="fas fa-circle sims-internship-dot-rejected"></i> Rejected</span>
                    <span class="sims-internship-status-row-value">12</span>
                </div>
                <div class="sims-internship-progress"><span class="sims-internship-progress-fill sims-internship-progress-rejected" style="width:4%"></span></div>
            </div>

        </div>

    </div>

    <!-- =========================================================================================
         MODALS
    ========================================================================================== -->

    <!-- 13. VIEW INTERNSHIP MODAL -->
    <div class="sims-internship-modal-overlay" id="viewInternshipOverlay" hidden>
        <div class="sims-internship-modal sims-internship-profile-modal" role="dialog" aria-modal="true" aria-labelledby="viewInternshipTitle">
            <div class="sims-internship-modal-header">
                <div>
                    <h2 id="viewInternshipTitle">Internship Details</h2>
                    <div class="sims-internship-modal-subhead">
                        <span class="sims-internship-modal-subtitle">Web Developer Intern</span>
                        <span class="sims-internship-cell-sub">INT-1001</span>
                        <span class="sims-internship-status sims-internship-status-active"><i class="fas fa-bolt"></i> Active</span>
                    </div>
                    <span class="sims-internship-modal-company"><i class="fas fa-building"></i> ABC Technologies</span>
                </div>
                <button type="button" class="sims-internship-modal-close" data-close-modal><i class="fas fa-xmark"></i></button>
            </div>

            <div class="sims-internship-modal-body">

                <div class="sims-internship-detail-section">
                    <h4>Internship Information</h4>
                    <div class="sims-internship-detail-grid">
                        <div><label>Internship Title</label><span>Web Developer Intern</span></div>
                        <div><label>Internship ID</label><span>INT-1001</span></div>
                        <div><label>Category</label><span>Web Development</span></div>
                        <div><label>Internship Type</label><span>Full Time</span></div>
                        <div><label>Work Mode</label><span>Hybrid</span></div>
                        <div><label>Location</label><span>Ahmedabad, Gujarat</span></div>
                        <div><label>Duration</label><span>6 Months</span></div>
                        <div><label>Start Date</label><span>01 Sep 2026</span></div>
                        <div><label>End Date</label><span>28 Feb 2027</span></div>
                        <div><label>Application Deadline</label><span>30 Aug 2026</span></div>
                        <div><label>Number of Openings</label><span>5</span></div>
                    </div>
                </div>

                <div class="sims-internship-detail-section">
                    <h4>Company Information</h4>
                    <div class="sims-internship-detail-grid">
                        <div><label>Company Name</label><span>ABC Technologies</span></div>
                        <div><label>Company ID</label><span>COM-1001</span></div>
                        <div><label>Industry</label><span>Information Technology</span></div>
                        <div><label>Company Email</label><span>hr@abctechnologies.com</span></div>
                        <div><label>Website</label><span>www.abctechnologies.com</span></div>
                    </div>
                </div>

                <div class="sims-internship-detail-section">
                    <h4>Description</h4>
                    <p class="sims-internship-detail-text">ABC Technologies is looking for a motivated Web Developer Intern to work with the development team on modern web applications.</p>
                </div>

                <div class="sims-internship-detail-section">
                    <h4>Responsibilities</h4>
                    <ul class="sims-internship-detail-list">
                        <li>Develop responsive web pages</li>
                        <li>Work with development team</li>
                        <li>Fix bugs</li>
                        <li>Participate in code reviews</li>
                        <li>Prepare technical documentation</li>
                    </ul>
                </div>

                <div class="sims-internship-detail-section">
                    <h4>Required Skills</h4>
                    <div class="sims-internship-skill-tags">
                        <span>HTML</span>
                        <span>CSS</span>
                        <span>JavaScript</span>
                        <span>ASP.NET</span>
                        <span>SQL</span>
                    </div>
                </div>

                <div class="sims-internship-detail-section">
                    <h4>Eligibility</h4>
                    <div class="sims-internship-detail-grid">
                        <div><label>Course</label><span>B.Tech / BE - Computer / IT</span></div>
                        <div><label>Semester</label><span>6th Semester or above</span></div>
                        <div><label>Minimum CGPA</label><span>7.0</span></div>
                        <div><label>Graduation Year</label><span>2027</span></div>
                    </div>
                </div>

                <div class="sims-internship-detail-section">
                    <h4>Compensation</h4>
                    <div class="sims-internship-detail-grid">
                        <div><label>Stipend</label><span>?10,000 / Month</span></div>
                    </div>
                </div>

                <div class="sims-internship-detail-section">
                    <h4>Application Summary</h4>
                    <div class="sims-internship-app-summary">
                        <div><span class="sims-internship-app-summary-num">35</span><span>Total Applications</span></div>
                        <div><span class="sims-internship-app-summary-num sims-internship-app-summary-shortlisted">8</span><span>Shortlisted</span></div>
                        <div><span class="sims-internship-app-summary-num sims-internship-app-summary-selected">2</span><span>Selected</span></div>
                        <div><span class="sims-internship-app-summary-num sims-internship-app-summary-rejected">7</span><span>Rejected</span></div>
                    </div>
                </div>

            </div>

            <div class="sims-internship-modal-footer">
                <button type="button" class="sims-internship-btn sims-internship-btn-outline" data-close-modal>Close</button>
                <button type="button" class="sims-internship-btn sims-internship-btn-secondary" data-action="edit">Edit Internship</button>
                <button type="button" class="sims-internship-btn sims-internship-btn-primary" data-action="view-applications">View Applications</button>
            </div>
        </div>
    </div>

    <!-- 14 & 15. ADD / EDIT INTERNSHIP MODAL -->
    <div class="sims-internship-modal-overlay" id="internshipFormOverlay" hidden>
        <div class="sims-internship-modal sims-internship-form-modal" role="dialog" aria-modal="true" aria-labelledby="internshipFormTitle">
            <div class="sims-internship-modal-header">
                <h2 id="internshipFormTitle">Add Internship</h2>
                <button type="button" class="sims-internship-modal-close" data-close-modal><i class="fas fa-xmark"></i></button>
            </div>

            <div class="sims-internship-modal-body">
                <form class="sims-internship-form" id="internshipForm" onsubmit="return false;">

                    <div class="sims-internship-form-section">
                        <h4>Basic Information</h4>
                        <div class="sims-internship-form-grid">
                            <div class="sims-internship-form-field">
                                <label>Internship Title <span class="sims-internship-required">*</span></label>
                                <input type="text" id="fldTitle" placeholder="e.g. Web Developer Intern" required />
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Company <span class="sims-internship-required">*</span></label>
                                <select id="fldCompany" required>
                                    <option value="">Select Company</option>
                                    <option>ABC Technologies</option>
                                    <option>TechSoft Pvt Ltd</option>
                                    <option>Innovate Labs</option>
                                    <option>DataTech Solutions</option>
                                    <option>FinServe Pvt Ltd</option>
                                </select>
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Category <span class="sims-internship-required">*</span></label>
                                <select id="fldCategory" required>
                                    <option value="">Select Category</option>
                                    <option>Web Development</option>
                                    <option>Software Development</option>
                                    <option>UI/UX Design</option>
                                    <option>Data Analytics</option>
                                    <option>Data Science</option>
                                    <option>Mobile App Development</option>
                                    <option>Digital Marketing</option>
                                </select>
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Internship Type <span class="sims-internship-required">*</span></label>
                                <select id="fldType" required>
                                    <option value="">Select Type</option>
                                    <option>Full Time</option>
                                    <option>Part Time</option>
                                    <option>Paid</option>
                                    <option>Unpaid</option>
                                </select>
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Work Mode <span class="sims-internship-required">*</span></label>
                                <select id="fldWorkMode" required>
                                    <option value="">Select Mode</option>
                                    <option>Remote</option>
                                    <option>On-site</option>
                                    <option>Hybrid</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="sims-internship-form-section">
                        <h4>Location</h4>
                        <div class="sims-internship-form-grid">
                            <div class="sims-internship-form-field">
                                <label>Location</label>
                                <input type="text" id="fldLocation" placeholder="e.g. Ahmedabad, Gujarat" />
                            </div>
                            <div class="sims-internship-form-field">
                                <label>City</label>
                                <input type="text" id="fldCity" placeholder="City" />
                            </div>
                            <div class="sims-internship-form-field">
                                <label>State</label>
                                <input type="text" id="fldState" placeholder="State" />
                            </div>
                        </div>
                    </div>

                    <div class="sims-internship-form-section">
                        <h4>Internship Details</h4>
                        <div class="sims-internship-form-grid">
                            <div class="sims-internship-form-field">
                                <label>Duration <span class="sims-internship-required">*</span></label>
                                <input type="text" id="fldDuration" placeholder="e.g. 6 Months" required />
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Start Date <span class="sims-internship-required">*</span></label>
                                <input type="date" id="fldStartDate" required />
                            </div>
                            <div class="sims-internship-form-field">
                                <label>End Date</label>
                                <input type="date" id="fldEndDate" />
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Application Deadline <span class="sims-internship-required">*</span></label>
                                <input type="date" id="fldDeadline" required />
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Number of Openings <span class="sims-internship-required">*</span></label>
                                <input type="number" id="fldOpenings" min="1" placeholder="e.g. 5" required />
                            </div>
                        </div>
                    </div>

                    <div class="sims-internship-form-section">
                        <h4>Compensation</h4>
                        <div class="sims-internship-form-grid">
                            <div class="sims-internship-form-field">
                                <label>Stipend Type</label>
                                <select id="fldStipendType">
                                    <option>Paid</option>
                                    <option>Unpaid</option>
                                    <option>Performance Based</option>
                                </select>
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Stipend Amount</label>
                                <input type="text" id="fldStipendAmount" placeholder="e.g. ?10,000 / Month" />
                            </div>
                        </div>
                    </div>

                    <div class="sims-internship-form-section">
                        <h4>Eligibility</h4>
                        <div class="sims-internship-form-grid">
                            <div class="sims-internship-form-field">
                                <label>Course <span class="sims-internship-required">*</span></label>
                                <input type="text" id="fldCourse" placeholder="e.g. B.Tech Computer Engineering" required />
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Minimum Semester</label>
                                <input type="text" id="fldSemester" placeholder="e.g. 6th Semester" />
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Minimum CGPA</label>
                                <input type="number" step="0.1" id="fldCgpa" placeholder="e.g. 7.0" />
                            </div>
                            <div class="sims-internship-form-field">
                                <label>Graduation Year</label>
                                <input type="text" id="fldGradYear" placeholder="e.g. 2027" />
                            </div>
                        </div>
                    </div>

                    <div class="sims-internship-form-section">
                        <h4>Required Skills</h4>
                        <div class="sims-internship-skill-picker" id="skillPicker">
                            <span class="sims-internship-skill-chip sims-internship-skill-chip-active">HTML</span>
                            <span class="sims-internship-skill-chip sims-internship-skill-chip-active">CSS</span>
                            <span class="sims-internship-skill-chip sims-internship-skill-chip-active">JavaScript</span>
                            <span class="sims-internship-skill-chip sims-internship-skill-chip-active">ASP.NET</span>
                            <span class="sims-internship-skill-chip sims-internship-skill-chip-active">SQL</span>
                            <span class="sims-internship-skill-chip">React</span>
                            <span class="sims-internship-skill-chip">Python</span>
                        </div>
                    </div>

                    <div class="sims-internship-form-section">
                        <h4>Description</h4>
                        <textarea id="fldDescription" rows="4" placeholder="Describe the internship role..."></textarea>
                    </div>

                    <div class="sims-internship-form-section">
                        <h4>Responsibilities</h4>
                        <textarea id="fldResponsibilities" rows="4" placeholder="List the key responsibilities..."></textarea>
                    </div>

                    <div class="sims-internship-form-section">
                        <h4>Status</h4>
                        <div class="sims-internship-form-grid">
                            <div class="sims-internship-form-field">
                                <select id="fldStatus">
                                    <option>Draft</option>
                                    <option>Pending</option>
                                    <option>Approved</option>
                                    <option>Active</option>
                                </select>
                            </div>
                        </div>
                    </div>

                </form>
            </div>

            <div class="sims-internship-modal-footer">
                <button type="button" class="sims-internship-btn sims-internship-btn-outline" data-close-modal>Cancel</button>
                <button type="button" class="sims-internship-btn sims-internship-btn-primary" id="btnSaveInternship">Save Internship</button>
            </div>
        </div>
    </div>

    <!-- 16. APPROVE INTERNSHIP MODAL -->
    <div class="sims-internship-modal-overlay" id="approveInternshipOverlay" hidden>
        <div class="sims-internship-modal sims-internship-approve-modal" role="dialog" aria-modal="true" aria-labelledby="approveInternshipTitle">
            <div class="sims-internship-modal-header">
                <h2 id="approveInternshipTitle"><i class="fas fa-circle-check sims-internship-icon-success"></i> Approve Internship</h2>
                <button type="button" class="sims-internship-modal-close" data-close-modal><i class="fas fa-xmark"></i></button>
            </div>
            <div class="sims-internship-modal-body">
                <div class="sims-internship-confirm-summary">
                    <div><label>Internship</label><span>Web Developer Intern</span></div>
                    <div><label>Company</label><span>ABC Technologies</span></div>
                    <div><label>Internship ID</label><span>INT-1001</span></div>
                </div>
                <p class="sims-internship-confirm-message">Are you sure you want to approve this internship?</p>
                <div class="sims-internship-form-field">
                    <label>Approval Note (optional)</label>
                    <textarea rows="3" placeholder="Add a note for this approval..."></textarea>
                </div>
            </div>
            <div class="sims-internship-modal-footer">
                <button type="button" class="sims-internship-btn sims-internship-btn-outline" data-close-modal>Cancel</button>
                <button type="button" class="sims-internship-btn sims-internship-btn-success" id="btnConfirmApprove">Approve Internship</button>
            </div>
        </div>
    </div>

    <!-- 17. REJECT INTERNSHIP MODAL -->
    <div class="sims-internship-modal-overlay" id="rejectInternshipOverlay" hidden>
        <div class="sims-internship-modal sims-internship-reject-modal" role="dialog" aria-modal="true" aria-labelledby="rejectInternshipTitle">
            <div class="sims-internship-modal-header">
                <h2 id="rejectInternshipTitle"><i class="fas fa-circle-xmark sims-internship-icon-danger"></i> Reject Internship</h2>
                <button type="button" class="sims-internship-modal-close" data-close-modal><i class="fas fa-xmark"></i></button>
            </div>
            <div class="sims-internship-modal-body">
                <div class="sims-internship-confirm-summary">
                    <div><label>Internship</label><span>.NET Developer Intern</span></div>
                    <div><label>Company</label><span>TechSoft Pvt Ltd</span></div>
                    <div><label>Internship ID</label><span>INT-1002</span></div>
                </div>
                <div class="sims-internship-form-field">
                    <label>Rejection Reason <span class="sims-internship-required">*</span></label>
                    <select id="fldRejectReason">
                        <option value="">Select a reason</option>
                        <option>Incomplete information</option>
                        <option>Invalid internship details</option>
                        <option>Company verification issue</option>
                        <option>Duplicate internship</option>
                        <option>Policy violation</option>
                        <option>Other</option>
                    </select>
                </div>
                <div class="sims-internship-form-field">
                    <label>Additional Comments</label>
                    <textarea rows="3" placeholder="Explain the rejection in more detail..."></textarea>
                </div>
            </div>
            <div class="sims-internship-modal-footer">
                <button type="button" class="sims-internship-btn sims-internship-btn-outline" data-close-modal>Cancel</button>
                <button type="button" class="sims-internship-btn sims-internship-btn-danger" id="btnConfirmReject">Reject Internship</button>
            </div>
        </div>
    </div>

    <!-- 18. CLOSE INTERNSHIP MODAL -->
    <div class="sims-internship-modal-overlay" id="closeInternshipOverlay" hidden>
        <div class="sims-internship-modal sims-internship-close-modal" role="dialog" aria-modal="true" aria-labelledby="closeInternshipTitle">
            <div class="sims-internship-modal-header">
                <h2 id="closeInternshipTitle"><i class="fas fa-lock sims-internship-icon-warn"></i> Close Internship</h2>
                <button type="button" class="sims-internship-modal-close" data-close-modal><i class="fas fa-xmark"></i></button>
            </div>
            <div class="sims-internship-modal-body">
                <p class="sims-internship-confirm-message">Are you sure you want to close this internship?</p>
                <div class="sims-internship-confirm-summary">
                    <div><label>Current Applications</label><span>35</span></div>
                    <div><label>Selected Students</label><span>2</span></div>
                </div>
                <div class="sims-internship-alert sims-internship-alert-warn">
                    <i class="fas fa-triangle-exclamation"></i>
                    Closing this internship will stop new applications.
                </div>
            </div>
            <div class="sims-internship-modal-footer">
                <button type="button" class="sims-internship-btn sims-internship-btn-outline" data-close-modal>Cancel</button>
                <button type="button" class="sims-internship-btn sims-internship-btn-warn" id="btnConfirmClose">Close Internship</button>
            </div>
        </div>
    </div>

    <!-- 19. DELETE INTERNSHIP MODAL -->
    <div class="sims-internship-modal-overlay" id="deleteInternshipOverlay" hidden>
        <div class="sims-internship-modal sims-internship-delete-modal" role="dialog" aria-modal="true" aria-labelledby="deleteInternshipTitle">
            <div class="sims-internship-modal-header">
                <h2 id="deleteInternshipTitle"><i class="fas fa-trash sims-internship-icon-danger"></i> Delete Internship</h2>
                <button type="button" class="sims-internship-modal-close" data-close-modal><i class="fas fa-xmark"></i></button>
            </div>
            <div class="sims-internship-modal-body">
                <p class="sims-internship-confirm-message">Are you sure you want to permanently delete this internship?</p>
                <div class="sims-internship-confirm-summary">
                    <div><label>Internship</label><span>Web Developer Intern</span></div>
                    <div><label>ID</label><span>INT-1001</span></div>
                </div>
                <div class="sims-internship-alert sims-internship-alert-danger">
                    <i class="fas fa-triangle-exclamation"></i>
                    This action cannot be undone.
                </div>
            </div>
            <div class="sims-internship-modal-footer">
                <button type="button" class="sims-internship-btn sims-internship-btn-outline" data-close-modal>Cancel</button>
                <button type="button" class="sims-internship-btn sims-internship-btn-danger" id="btnConfirmDelete">Delete Internship</button>
            </div>
        </div>
    </div>

    <!-- 20. APPLICATION QUICK VIEW -->
    <div class="sims-internship-modal-overlay" id="applicationsQuickViewOverlay" hidden>
        <div class="sims-internship-modal sims-internship-applications-modal" role="dialog" aria-modal="true" aria-labelledby="applicationsQuickViewTitle">
            <div class="sims-internship-modal-header">
                <div>
                    <h2 id="applicationsQuickViewTitle">Web Developer Intern</h2>
                    <span class="sims-internship-modal-company"><i class="fas fa-building"></i> ABC Technologies</span>
                </div>
                <button type="button" class="sims-internship-modal-close" data-close-modal><i class="fas fa-xmark"></i></button>
            </div>
            <div class="sims-internship-modal-body">
                <div class="sims-internship-app-summary sims-internship-app-summary-wide">
                    <div><span class="sims-internship-app-summary-num">35</span><span>Total Applications</span></div>
                    <div><span class="sims-internship-app-summary-num sims-internship-app-summary-pending">18</span><span>Pending</span></div>
                    <div><span class="sims-internship-app-summary-num sims-internship-app-summary-shortlisted">8</span><span>Shortlisted</span></div>
                    <div><span class="sims-internship-app-summary-num sims-internship-app-summary-selected">2</span><span>Selected</span></div>
                    <div><span class="sims-internship-app-summary-num sims-internship-app-summary-rejected">7</span><span>Rejected</span></div>
                </div>
            </div>
            <div class="sims-internship-modal-footer">
                <button type="button" class="sims-internship-btn sims-internship-btn-outline" data-close-modal>Close</button>
                <button type="button" class="sims-internship-btn sims-internship-btn-primary" id="btnViewAllApplications">View All Applications</button>
            </div>
        </div>
    </div>

    <!-- 21. COMPANY QUICK VIEW -->
    <div class="sims-internship-modal-overlay" id="companyQuickViewOverlay" hidden>
        <div class="sims-internship-modal sims-internship-company-modal" role="dialog" aria-modal="true" aria-labelledby="companyQuickViewTitle">
            <div class="sims-internship-modal-header">
                <h2 id="companyQuickViewTitle">Company Profile</h2>
                <button type="button" class="sims-internship-modal-close" data-close-modal><i class="fas fa-xmark"></i></button>
            </div>
            <div class="sims-internship-modal-body">
                <div class="sims-internship-company-profile">
                    <div class="sims-internship-company-avatar sims-internship-company-avatar-lg">AT</div>
                    <div>
                        <h3>ABC Technologies</h3>
                        <span class="sims-internship-cell-sub">COM-1001</span>
                    </div>
                </div>
                <div class="sims-internship-detail-grid">
                    <div><label>Industry</label><span>Information Technology</span></div>
                    <div><label>Email</label><span>hr@abctechnologies.com</span></div>
                    <div><label>Phone</label><span>+91 98765 43210</span></div>
                    <div><label>Website</label><span>www.abctechnologies.com</span></div>
                    <div><label>Active Internships</label><span>6</span></div>
                </div>
            </div>
            <div class="sims-internship-modal-footer">
                <button type="button" class="sims-internship-btn sims-internship-btn-outline" data-close-modal>Close</button>
                <button type="button" class="sims-internship-btn sims-internship-btn-primary" id="btnViewFullCompany">View Company</button>
            </div>
        </div>
    </div>
</asp:Content>






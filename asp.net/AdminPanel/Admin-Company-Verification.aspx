<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-company-verification.aspx.cs" Inherits="asp.net.admin_company_verification" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link rel="stylesheet" href="../css/admin-company-verification.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <div class="sims-verification-page">

    <!-- ============================================================
         1. PAGE HEADER
    ============================================================ -->
    <div class="sims-verification-header">
        <div class="sims-verification-header-left">
            <nav class="sims-verification-breadcrumb" aria-label="Breadcrumb">
                <span>Dashboard</span>
                <i class="fas fa-chevron-right"></i>
                <span>Company Management</span>
                <i class="fas fa-chevron-right"></i>
                <span class="sims-verification-breadcrumb-current">Company Verification</span>
            </nav>
            <h1 class="sims-verification-title">Company Verification</h1>
            <p class="sims-verification-subtitle">Review and verify registered companies before allowing them to post internships.</p>
        </div>
        <div class="sims-verification-header-right">
            <button type="button" class="sims-verification-btn sims-verification-btn-outline" id="btnExportReport">
                <i class="fas fa-download"></i>
                <span>Export Report</span>
            </button>
            <button type="button" class="sims-verification-btn sims-verification-btn-primary" id="btnVerificationHistoryTop">
                <i class="fas fa-history"></i>
                <span>Verification History</span>
            </button>
        </div>
    </div>

    <!-- ============================================================
         2. VERIFICATION STATISTICS
    ============================================================ -->
    <div class="sims-verification-stats">
        <div class="sims-verification-stat-card sims-verification-stat-pending">
            <div class="sims-verification-stat-icon"><i class="fas fa-hourglass-half"></i></div>
            <div class="sims-verification-stat-info">
                <span class="sims-verification-stat-number">12</span>
                <span class="sims-verification-stat-label">Pending Verification</span>
                <span class="sims-verification-stat-desc">Companies awaiting review</span>
            </div>
        </div>

        <div class="sims-verification-stat-card sims-verification-stat-verified">
            <div class="sims-verification-stat-icon"><i class="fas fa-check-circle"></i></div>
            <div class="sims-verification-stat-info">
                <span class="sims-verification-stat-number">68</span>
                <span class="sims-verification-stat-label">Verified</span>
                <span class="sims-verification-stat-desc">Approved companies</span>
            </div>
        </div>

        <div class="sims-verification-stat-card sims-verification-stat-rejected">
            <div class="sims-verification-stat-icon"><i class="fas fa-times-circle"></i></div>
            <div class="sims-verification-stat-info">
                <span class="sims-verification-stat-number">4</span>
                <span class="sims-verification-stat-label">Rejected</span>
                <span class="sims-verification-stat-desc">Verification rejected</span>
            </div>
        </div>

        <div class="sims-verification-stat-card sims-verification-stat-docs">
            <div class="sims-verification-stat-icon"><i class="fas fa-file-circle-exclamation"></i></div>
            <div class="sims-verification-stat-info">
                <span class="sims-verification-stat-number">7</span>
                <span class="sims-verification-stat-label">Documents Pending</span>
                <span class="sims-verification-stat-desc">Missing or incomplete documents</span>
            </div>
        </div>

        <div class="sims-verification-stat-card sims-verification-stat-today">
            <div class="sims-verification-stat-icon"><i class="fas fa-calendar-check"></i></div>
            <div class="sims-verification-stat-info">
                <span class="sims-verification-stat-number">8</span>
                <span class="sims-verification-stat-label">Today's Reviews</span>
                <span class="sims-verification-stat-desc">Reviewed today</span>
            </div>
        </div>
    </div>

    <!-- ============================================================
         3. SEARCH & FILTER SECTION
    ============================================================ -->
    <div class="sims-verification-filters">
        <div class="sims-verification-search">
            <i class="fas fa-search"></i>
            <input type="text" id="verificationSearchInput" placeholder="Search company name, email or company ID..." />
        </div>

        <div class="sims-verification-filter-group">
            <label>Verification Status</label>
            <select id="filterStatus" class="sims-verification-select">
                <option value="all">All Status</option>
                <option value="pending">Pending</option>
                <option value="under-review">Under Review</option>
                <option value="verified">Verified</option>
                <option value="rejected">Rejected</option>
                <option value="docs-pending">Documents Pending</option>
            </select>
        </div>

        <div class="sims-verification-filter-group">
            <label>Industry</label>
            <select id="filterIndustry" class="sims-verification-select">
                <option value="all">All Industries</option>
                <option value="it">Information Technology</option>
                <option value="software">Software Development</option>
                <option value="finance">Finance</option>
                <option value="healthcare">Healthcare</option>
                <option value="education">Education</option>
                <option value="manufacturing">Manufacturing</option>
                <option value="other">Other</option>
            </select>
        </div>

        <div class="sims-verification-filter-group">
            <label>Registration Date</label>
            <select id="filterDate" class="sims-verification-select">
                <option value="all">All Dates</option>
                <option value="today">Today</option>
                <option value="week">This Week</option>
                <option value="month">This Month</option>
                <option value="custom">Custom Date</option>
            </select>
        </div>

        <div class="sims-verification-filter-group">
            <label>Priority</label>
            <select id="filterPriority" class="sims-verification-select">
                <option value="all">All</option>
                <option value="high">High Priority</option>
                <option value="normal">Normal Priority</option>
            </select>
        </div>

        <div class="sims-verification-filter-actions">
            <button type="button" class="sims-verification-btn sims-verification-btn-primary" id="btnFilterSearch">
                <i class="fas fa-search"></i><span>Search</span>
            </button>
            <button type="button" class="sims-verification-btn sims-verification-btn-outline" id="btnFilterReset">
                <i class="fas fa-rotate-left"></i><span>Reset</span>
            </button>
        </div>
    </div>

    <!-- ============================================================
         20. BULK VERIFICATION ACTIONS (hidden until selection)
    ============================================================ -->
    <div class="sims-verification-bulk-bar" id="bulkActionBar" style="display:none;">
        <div class="sims-verification-bulk-left">
            <i class="fas fa-square-check"></i>
            <span>Selected: <strong id="bulkSelectedCount">0</strong></span>
        </div>
        <div class="sims-verification-bulk-actions">
            <button type="button" class="sims-verification-bulk-btn" data-bulk="review"><i class="fas fa-magnifying-glass"></i> Start Review</button>
            <button type="button" class="sims-verification-bulk-btn sims-verification-bulk-approve" data-bulk="approve"><i class="fas fa-check"></i> Approve Selected</button>
            <button type="button" class="sims-verification-bulk-btn" data-bulk="request-docs"><i class="fas fa-file-circle-plus"></i> Request Documents</button>
            <button type="button" class="sims-verification-bulk-btn sims-verification-bulk-reject" data-bulk="reject"><i class="fas fa-xmark"></i> Reject Selected</button>
            <button type="button" class="sims-verification-bulk-btn" data-bulk="export"><i class="fas fa-download"></i> Export Selected</button>
        </div>
    </div>

    <!-- ============================================================
         4. PENDING VERIFICATION TABLE
    ============================================================ -->
    <div class="sims-verification-table-card" id="verificationTableCard">
        <div class="sims-verification-table-head">
            <h2>Companies Awaiting Verification</h2>
            <span class="sims-verification-count-badge">12 Pending Companies</span>
        </div>

        <div class="sims-verification-table-scroll">
        <table class="sims-verification-table" id="verificationTable">
            <thead>
                <tr>
                    <th class="sims-verification-th-check"><input type="checkbox" id="selectAllRows" /></th>
                    <th>Company</th>
                    <th>Company ID</th>
                    <th>Industry</th>
                    <th>Contact Person</th>
                    <th>Documents</th>
                    <th>Submitted Date</th>
                    <th>Verification Status</th>
                    <th>Priority</th>
                    <th class="sims-verification-th-actions">Actions</th>
                </tr>
            </thead>
            <tbody>

                <!-- ROW 1 - Pending, High Priority -->
                <tr data-status="pending" data-priority="high" data-company="Innovate Labs" data-companyid="COM-1003">
                    <td><input type="checkbox" class="sims-verification-row-check" /></td>
                    <td>
                        <div class="sims-verification-company">
                            <div class="sims-verification-avatar">IL</div>
                            <div class="sims-verification-company-info">
                                <span class="sims-verification-company-name">Innovate Labs</span>
                                <span class="sims-verification-company-sub">innovatelabs.com</span>
                            </div>
                        </div>
                    </td>
                    <td><span class="sims-verification-id">COM-1003</span></td>
                    <td>Information Technology</td>
                    <td>
                        <div class="sims-verification-contact">
                            <span class="sims-verification-contact-name">Rahul Mehta</span>
                            <span class="sims-verification-contact-email">rahul@innovatelabs.com</span>
                        </div>
                    </td>
                    <td>
                        <span class="sims-verification-doc-badge sims-verification-doc-incomplete">3/4 Documents</span>
                        <button type="button" class="sims-verification-link-btn sims-verification-view-docs">View Documents</button>
                    </td>
                    <td>19 Aug 2026</td>
                    <td><span class="sims-verification-status sims-verification-status-pending"><i class="fas fa-circle"></i> Pending</span></td>
                    <td><span class="sims-verification-priority sims-verification-priority-high"><i class="fas fa-arrow-up"></i> High</span></td>
                    <td class="sims-verification-actions-cell">
                        <button type="button" class="sims-verification-action-toggle"><i class="fas fa-ellipsis-vertical"></i></button>
                        <div class="sims-verification-action-menu">
                            <button data-action="view">View Company</button>
                            <button data-action="review-docs">Review Documents</button>
                            <button data-action="start-review">Start Verification</button>
                            <button data-action="approve">Approve</button>
                            <button data-action="reject">Reject</button>
                            <button data-action="request-docs">Request Documents</button>
                        </div>
                    </td>
                </tr>

                <!-- ROW 2 - Under Review, Normal -->
                <tr data-status="under-review" data-priority="normal" data-company="TechSoft Pvt Ltd" data-companyid="COM-1004">
                    <td><input type="checkbox" class="sims-verification-row-check" /></td>
                    <td>
                        <div class="sims-verification-company">
                            <div class="sims-verification-avatar">TS</div>
                            <div class="sims-verification-company-info">
                                <span class="sims-verification-company-name">TechSoft Pvt Ltd</span>
                                <span class="sims-verification-company-sub">techsoft.in</span>
                            </div>
                        </div>
                    </td>
                    <td><span class="sims-verification-id">COM-1004</span></td>
                    <td>Software Development</td>
                    <td>
                        <div class="sims-verification-contact">
                            <span class="sims-verification-contact-name">Sneha Kulkarni</span>
                            <span class="sims-verification-contact-email">sneha@techsoft.in</span>
                        </div>
                    </td>
                    <td>
                        <span class="sims-verification-doc-badge sims-verification-doc-complete">4/4 Documents</span>
                        <button type="button" class="sims-verification-link-btn sims-verification-view-docs">View Documents</button>
                    </td>
                    <td>18 Aug 2026</td>
                    <td><span class="sims-verification-status sims-verification-status-review"><i class="fas fa-circle"></i> Under Review</span></td>
                    <td><span class="sims-verification-priority sims-verification-priority-normal"><i class="fas fa-minus"></i> Normal</span></td>
                    <td class="sims-verification-actions-cell">
                        <button type="button" class="sims-verification-action-toggle"><i class="fas fa-ellipsis-vertical"></i></button>
                        <div class="sims-verification-action-menu">
                            <button data-action="view">View Company</button>
                            <button data-action="review-docs">Review Documents</button>
                            <button data-action="approve">Approve</button>
                            <button data-action="reject">Reject</button>
                            <button data-action="request-docs">Request Documents</button>
                            <button data-action="history">Verification History</button>
                        </div>
                    </td>
                </tr>

                <!-- ROW 3 - Documents Pending, High -->
                <tr data-status="docs-pending" data-priority="high" data-company="DataTech Solutions" data-companyid="COM-1005">
                    <td><input type="checkbox" class="sims-verification-row-check" /></td>
                    <td>
                        <div class="sims-verification-company">
                            <div class="sims-verification-avatar">DT</div>
                            <div class="sims-verification-company-info">
                                <span class="sims-verification-company-name">DataTech Solutions</span>
                                <span class="sims-verification-company-sub">datatechsolutions.co</span>
                            </div>
                        </div>
                    </td>
                    <td><span class="sims-verification-id">COM-1005</span></td>
                    <td>Information Technology</td>
                    <td>
                        <div class="sims-verification-contact">
                            <span class="sims-verification-contact-name">Aman Verma</span>
                            <span class="sims-verification-contact-email">aman@datatechsolutions.co</span>
                        </div>
                    </td>
                    <td>
                        <span class="sims-verification-doc-badge sims-verification-doc-missing">2/4 Documents</span>
                        <button type="button" class="sims-verification-link-btn sims-verification-view-docs">View Documents</button>
                    </td>
                    <td>17 Aug 2026</td>
                    <td><span class="sims-verification-status sims-verification-status-docs"><i class="fas fa-circle"></i> Documents Pending</span></td>
                    <td><span class="sims-verification-priority sims-verification-priority-high"><i class="fas fa-arrow-up"></i> High</span></td>
                    <td class="sims-verification-actions-cell">
                        <button type="button" class="sims-verification-action-toggle"><i class="fas fa-ellipsis-vertical"></i></button>
                        <div class="sims-verification-action-menu">
                            <button data-action="view">View Company</button>
                            <button data-action="review-docs">Review Documents</button>
                            <button data-action="start-review">Start Verification</button>
                            <button data-action="approve">Approve</button>
                            <button data-action="reject">Reject</button>
                            <button data-action="request-docs">Request Documents</button>
                        </div>
                    </td>
                </tr>

                <!-- ROW 4 - Verified -->
                <tr data-status="verified" data-priority="normal" data-company="ABC Technologies" data-companyid="COM-0997">
                    <td><input type="checkbox" class="sims-verification-row-check" /></td>
                    <td>
                        <div class="sims-verification-company">
                            <div class="sims-verification-avatar">AT</div>
                            <div class="sims-verification-company-info">
                                <span class="sims-verification-company-name">ABC Technologies</span>
                                <span class="sims-verification-company-sub">abctechnologies.com</span>
                            </div>
                        </div>
                    </td>
                    <td><span class="sims-verification-id">COM-0997</span></td>
                    <td>Software Development</td>
                    <td>
                        <div class="sims-verification-contact">
                            <span class="sims-verification-contact-name">Priya Nair</span>
                            <span class="sims-verification-contact-email">priya@abctechnologies.com</span>
                        </div>
                    </td>
                    <td>
                        <span class="sims-verification-doc-badge sims-verification-doc-complete">4/4 Documents</span>
                        <button type="button" class="sims-verification-link-btn sims-verification-view-docs">View Documents</button>
                    </td>
                    <td>10 Aug 2026</td>
                    <td><span class="sims-verification-status sims-verification-status-verified"><i class="fas fa-circle"></i> Verified</span></td>
                    <td><span class="sims-verification-priority sims-verification-priority-normal"><i class="fas fa-minus"></i> Normal</span></td>
                    <td class="sims-verification-actions-cell">
                        <button type="button" class="sims-verification-action-toggle"><i class="fas fa-ellipsis-vertical"></i></button>
                        <div class="sims-verification-action-menu">
                            <button data-action="view">View Company</button>
                            <button data-action="history">Verification History</button>
                        </div>
                    </td>
                </tr>

                <!-- ROW 5 - Rejected -->
                <tr data-status="rejected" data-priority="normal" data-company="FinServe Pvt Ltd" data-companyid="COM-0989">
                    <td><input type="checkbox" class="sims-verification-row-check" /></td>
                    <td>
                        <div class="sims-verification-company">
                            <div class="sims-verification-avatar">FS</div>
                            <div class="sims-verification-company-info">
                                <span class="sims-verification-company-name">FinServe Pvt Ltd</span>
                                <span class="sims-verification-company-sub">finservepvt.com</span>
                            </div>
                        </div>
                    </td>
                    <td><span class="sims-verification-id">COM-0989</span></td>
                    <td>Finance</td>
                    <td>
                        <div class="sims-verification-contact">
                            <span class="sims-verification-contact-name">Karan Shah</span>
                            <span class="sims-verification-contact-email">karan@finservepvt.com</span>
                        </div>
                    </td>
                    <td>
                        <span class="sims-verification-doc-badge sims-verification-doc-incomplete">3/4 Documents</span>
                        <button type="button" class="sims-verification-link-btn sims-verification-view-docs">View Documents</button>
                    </td>
                    <td>05 Aug 2026</td>
                    <td><span class="sims-verification-status sims-verification-status-rejected"><i class="fas fa-circle"></i> Rejected</span></td>
                    <td><span class="sims-verification-priority sims-verification-priority-normal"><i class="fas fa-minus"></i> Normal</span></td>
                    <td class="sims-verification-actions-cell">
                        <button type="button" class="sims-verification-action-toggle"><i class="fas fa-ellipsis-vertical"></i></button>
                        <div class="sims-verification-action-menu">
                            <button data-action="view">View Company</button>
                            <button data-action="rejection-reason">View Rejection Reason</button>
                            <button data-action="history">Verification History</button>
                        </div>
                    </td>
                </tr>

            </tbody>
        </table>
        </div>

        <!-- ============================================================
             22. EMPTY STATE (hidden by default, shown via demo toggle)
        ============================================================ -->
        <div class="sims-verification-empty" id="verificationEmptyState" style="display:none;">
            <div class="sims-verification-empty-icon"><i class="fas fa-clipboard-check"></i></div>
            <h3>No Companies Awaiting Verification</h3>
            <p>All registered companies have been reviewed.</p>
            <button type="button" class="sims-verification-btn sims-verification-btn-primary">View Verified Companies</button>
        </div>

        <!-- ============================================================
             21. PAGINATION
        ============================================================ -->
        <div class="sims-verification-pagination">
            <span class="sims-verification-pagination-info">Showing 1–10 of 12 pending companies</span>
            <div class="sims-verification-pagination-controls">
                <button type="button" class="sims-verification-page-btn" disabled>Previous</button>
                <button type="button" class="sims-verification-page-btn sims-verification-page-active">1</button>
                <button type="button" class="sims-verification-page-btn">2</button>
                <button type="button" class="sims-verification-page-btn">Next</button>
            </div>
            <div class="sims-verification-pagesize">
                <label>Show</label>
                <select id="pageSizeSelect" class="sims-verification-select sims-verification-select-sm">
                    <option value="10">10</option>
                    <option value="25">25</option>
                    <option value="50">50</option>
                </select>
            </div>
        </div>
    </div>

    <!-- ============================================================
         23. RECENT VERIFICATION ACTIVITY
    ============================================================ -->
    <div class="sims-verification-activity">
        <h3><i class="fas fa-clock-rotate-left"></i> Recent Verification Activity</h3>
        <ul class="sims-verification-activity-list">
            <li>
                <span class="sims-verification-activity-dot sims-verification-activity-verified"></span>
                <div class="sims-verification-activity-text">
                    <span><strong>ABC Technologies</strong> was verified</span>
                    <span class="sims-verification-activity-time">10 minutes ago</span>
                </div>
            </li>
            <li>
                <span class="sims-verification-activity-dot sims-verification-activity-docs"></span>
                <div class="sims-verification-activity-text">
                    <span><strong>Innovate Labs</strong> submitted documents</span>
                    <span class="sims-verification-activity-time">25 minutes ago</span>
                </div>
            </li>
            <li>
                <span class="sims-verification-activity-dot sims-verification-activity-review"></span>
                <div class="sims-verification-activity-text">
                    <span><strong>TechSoft Pvt Ltd</strong> verification started</span>
                    <span class="sims-verification-activity-time">1 hour ago</span>
                </div>
            </li>
            <li>
                <span class="sims-verification-activity-dot sims-verification-activity-docs"></span>
                <div class="sims-verification-activity-text">
                    <span><strong>DataTech Solutions</strong> GST certificate verified</span>
                    <span class="sims-verification-activity-time">2 hours ago</span>
                </div>
            </li>
            <li>
                <span class="sims-verification-activity-dot sims-verification-activity-rejected"></span>
                <div class="sims-verification-activity-text">
                    <span><strong>FinServe Pvt Ltd</strong> verification rejected</span>
                    <span class="sims-verification-activity-time">3 hours ago</span>
                </div>
            </li>
        </ul>
    </div>

</div>


<!-- ================================================================
     11. COMPANY VERIFICATION REVIEW MODAL
================================================================ -->
<div class="sims-verification-modal-overlay" id="reviewModalOverlay">
    <div class="sims-verification-modal sims-verification-modal-lg" id="reviewModal" role="dialog" aria-modal="true" aria-labelledby="reviewModalTitle">
        <div class="sims-verification-modal-header">
            <h3 id="reviewModalTitle"><i class="fas fa-building-shield"></i> Company Verification Review</h3>
            <button type="button" class="sims-verification-modal-close" data-close="reviewModalOverlay"><i class="fas fa-xmark"></i></button>
        </div>

        <div class="sims-verification-modal-body">

            <!-- Top summary -->
            <div class="sims-verification-review-top">
                <div class="sims-verification-avatar sims-verification-avatar-lg">IL</div>
                <div class="sims-verification-review-top-info">
                    <h2>Innovate Labs</h2>
                    <span class="sims-verification-id">COM-1003</span>
                </div>
                <div class="sims-verification-review-top-badges">
                    <span class="sims-verification-status sims-verification-status-pending"><i class="fas fa-circle"></i> Pending Verification</span>
                    <span class="sims-verification-priority sims-verification-priority-high"><i class="fas fa-arrow-up"></i> High</span>
                </div>
            </div>

            <!-- Tabs -->
            <div class="sims-verification-tabs">
                <button type="button" class="sims-verification-tab-btn sims-verification-tab-active" data-tab="tab-info">Company Info</button>
                <button type="button" class="sims-verification-tab-btn" data-tab="tab-docs">Documents</button>
                <button type="button" class="sims-verification-tab-btn" data-tab="tab-checklist">Checklist</button>
                <button type="button" class="sims-verification-tab-btn" data-tab="tab-timeline">Timeline</button>
            </div>

            <!-- TAB: Company Info -->
            <div class="sims-verification-tab-panel sims-verification-tab-active" id="tab-info">

                <div class="sims-verification-info-section">
                    <h4>Company Information</h4>
                    <div class="sims-verification-info-grid">
                        <div><span>Company Name</span><strong>Innovate Labs</strong></div>
                        <div><span>Company ID</span><strong>COM-1003</strong></div>
                        <div><span>Email</span><strong>contact@innovatelabs.com</strong></div>
                        <div><span>Phone</span><strong>+91 98765 43210</strong></div>
                        <div><span>Website</span><strong>www.innovatelabs.com</strong></div>
                        <div><span>Industry</span><strong>Information Technology</strong></div>
                        <div><span>Company Type</span><strong>Private Limited</strong></div>
                        <div><span>Year Established</span><strong>2019</strong></div>
                    </div>
                </div>

                <div class="sims-verification-info-section">
                    <h4>Company Address</h4>
                    <div class="sims-verification-info-grid">
                        <div><span>Address</span><strong>4th Floor, Tech Park Avenue</strong></div>
                        <div><span>City</span><strong>Ahmedabad</strong></div>
                        <div><span>State</span><strong>Gujarat</strong></div>
                        <div><span>Country</span><strong>India</strong></div>
                        <div><span>Pincode</span><strong>380015</strong></div>
                    </div>
                </div>

                <div class="sims-verification-info-section">
                    <h4>Contact Person</h4>
                    <div class="sims-verification-info-grid">
                        <div><span>HR Name</span><strong>Rahul Mehta</strong></div>
                        <div><span>HR Email</span><strong>rahul@innovatelabs.com</strong></div>
                        <div><span>HR Phone</span><strong>+91 91234 56789</strong></div>
                        <div><span>Designation</span><strong>HR Manager</strong></div>
                    </div>
                </div>

                <div class="sims-verification-info-section">
                    <h4>Company Description</h4>
                    <p class="sims-verification-description-text">Innovate Labs is a technology startup specializing in web applications, cloud solutions and digital products.</p>
                </div>

            </div>

            <!-- TAB: Documents -->
            <div class="sims-verification-tab-panel" id="tab-docs">
                <div class="sims-verification-documents">
                    <h4>Submitted Documents</h4>

                    <div class="sims-verification-document-row">
                        <div class="sims-verification-doc-left">
                            <i class="fas fa-file-lines"></i>
                            <div>
                                <span class="sims-verification-doc-name">Company Registration Certificate</span>
                                <span class="sims-verification-doc-date">Submitted 15 Aug 2026</span>
                            </div>
                        </div>
                        <span class="sims-verification-doc-status sims-verification-doc-status-verified">Verified</span>
                        <div class="sims-verification-doc-actions">
                            <button type="button" class="sims-verification-btn-icon sims-verification-doc-view" data-doc="Company Registration Certificate">View</button>
                            <button type="button" class="sims-verification-btn-icon">Download</button>
                        </div>
                    </div>

                    <div class="sims-verification-document-row">
                        <div class="sims-verification-doc-left">
                            <i class="fas fa-file-invoice"></i>
                            <div>
                                <span class="sims-verification-doc-name">GST Certificate</span>
                                <span class="sims-verification-doc-date">Submitted 15 Aug 2026</span>
                            </div>
                        </div>
                        <span class="sims-verification-doc-status sims-verification-doc-status-verified">Verified</span>
                        <div class="sims-verification-doc-actions">
                            <button type="button" class="sims-verification-btn-icon sims-verification-doc-view" data-doc="GST Certificate">View</button>
                            <button type="button" class="sims-verification-btn-icon">Download</button>
                        </div>
                    </div>

                    <div class="sims-verification-document-row">
                        <div class="sims-verification-doc-left">
                            <i class="fas fa-file-contract"></i>
                            <div>
                                <span class="sims-verification-doc-name">PAN / Tax Document</span>
                                <span class="sims-verification-doc-date">Submitted 16 Aug 2026</span>
                            </div>
                        </div>
                        <span class="sims-verification-doc-status sims-verification-doc-status-pending">Pending Review</span>
                        <div class="sims-verification-doc-actions">
                            <button type="button" class="sims-verification-btn-icon sims-verification-doc-view" data-doc="PAN / Tax Document">View</button>
                            <button type="button" class="sims-verification-btn-icon">Download</button>
                        </div>
                    </div>

                    <div class="sims-verification-document-row">
                        <div class="sims-verification-doc-left">
                            <i class="fas fa-file-circle-xmark"></i>
                            <div>
                                <span class="sims-verification-doc-name">Authorization Document</span>
                                <span class="sims-verification-doc-date">Not submitted</span>
                            </div>
                        </div>
                        <span class="sims-verification-doc-status sims-verification-doc-status-missing">Missing</span>
                        <div class="sims-verification-doc-actions">
                            <button type="button" class="sims-verification-btn-icon sims-verification-btn-icon-warn" id="btnRequestMissingDoc">Request Document</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- TAB: Checklist -->
            <div class="sims-verification-tab-panel" id="tab-checklist">
                <div class="sims-verification-checklist">
                    <h4>Verification Checklist</h4>
                    <label class="sims-verification-check-item">
                        <input type="checkbox" class="sims-verification-check" />
                        <span>Company information verified</span>
                    </label>
                    <label class="sims-verification-check-item">
                        <input type="checkbox" class="sims-verification-check" />
                        <span>Contact details verified</span>
                    </label>
                    <label class="sims-verification-check-item">
                        <input type="checkbox" class="sims-verification-check" />
                        <span>Registration certificate verified</span>
                    </label>
                    <label class="sims-verification-check-item">
                        <input type="checkbox" class="sims-verification-check" />
                        <span>GST certificate verified</span>
                    </label>
                    <label class="sims-verification-check-item">
                        <input type="checkbox" class="sims-verification-check" />
                        <span>PAN / tax document verified</span>
                    </label>
                    <label class="sims-verification-check-item">
                        <input type="checkbox" class="sims-verification-check" />
                        <span>Authorization document verified</span>
                    </label>
                    <label class="sims-verification-check-item">
                        <input type="checkbox" class="sims-verification-check" />
                        <span>Company website/profile reviewed</span>
                    </label>
                    <label class="sims-verification-check-item">
                        <input type="checkbox" class="sims-verification-check" />
                        <span>No duplicate company account found</span>
                    </label>
                    <p class="sims-verification-checklist-hint"><i class="fas fa-circle-info"></i> All checklist items must be completed before you can approve this company.</p>
                </div>
            </div>

            <!-- TAB: Timeline -->
            <div class="sims-verification-tab-panel" id="tab-timeline">
                <div class="sims-verification-timeline">
                    <div class="sims-verification-timeline-item sims-verification-timeline-done">
                        <div class="sims-verification-timeline-dot"><i class="fas fa-check"></i></div>
                        <div class="sims-verification-timeline-content">
                            <span class="sims-verification-timeline-title">Company Registered</span>
                            <span class="sims-verification-timeline-date">19 Aug 2026 &ndash; 09:30 AM</span>
                        </div>
                    </div>
                    <div class="sims-verification-timeline-item sims-verification-timeline-done">
                        <div class="sims-verification-timeline-dot"><i class="fas fa-check"></i></div>
                        <div class="sims-verification-timeline-content">
                            <span class="sims-verification-timeline-title">Documents Submitted</span>
                            <span class="sims-verification-timeline-date">19 Aug 2026 &ndash; 09:35 AM</span>
                        </div>
                    </div>
                    <div class="sims-verification-timeline-item sims-verification-timeline-done">
                        <div class="sims-verification-timeline-dot"><i class="fas fa-check"></i></div>
                        <div class="sims-verification-timeline-content">
                            <span class="sims-verification-timeline-title">Verification Started</span>
                            <span class="sims-verification-timeline-date">19 Aug 2026 &ndash; 10:10 AM</span>
                        </div>
                    </div>
                    <div class="sims-verification-timeline-item sims-verification-timeline-current">
                        <div class="sims-verification-timeline-dot"><i class="fas fa-hourglass-half"></i></div>
                        <div class="sims-verification-timeline-content">
                            <span class="sims-verification-timeline-title">Under Review</span>
                            <span class="sims-verification-timeline-date">Current Status</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="sims-verification-modal-footer">
            <button type="button" class="sims-verification-btn sims-verification-btn-outline" data-close="reviewModalOverlay">Close</button>
            <button type="button" class="sims-verification-btn sims-verification-btn-danger" id="btnOpenRejectFromReview">
                <i class="fas fa-xmark"></i> Reject Company
            </button>
            <button type="button" class="sims-verification-btn sims-verification-btn-success" id="btnOpenApproveFromReview" disabled>
                <i class="fas fa-check"></i> Approve Company
            </button>
        </div>
    </div>
</div>


<!-- ================================================================
     13. DOCUMENT PREVIEW MODAL
================================================================ -->
<div class="sims-verification-modal-overlay" id="docPreviewOverlay">
    <div class="sims-verification-modal sims-verification-modal-md" role="dialog" aria-modal="true">
        <div class="sims-verification-modal-header">
            <h3><i class="fas fa-file-lines"></i> Document Preview</h3>
            <button type="button" class="sims-verification-modal-close" data-close="docPreviewOverlay"><i class="fas fa-xmark"></i></button>
        </div>
        <div class="sims-verification-modal-body">
            <div class="sims-verification-doc-meta">
                <div><span>Document Name</span><strong id="docPreviewName">Company Registration Certificate</strong></div>
                <div><span>File Type</span><strong>PDF</strong></div>
                <div><span>File Size</span><strong>842 KB</strong></div>
                <div><span>Uploaded Date</span><strong>15 Aug 2026</strong></div>
            </div>
            <div class="sims-verification-doc-preview-area">
                <i class="fas fa-file-pdf"></i>
                <p>Preview not available in demo mode.</p>
                <span>This is a placeholder preview area for the uploaded document.</span>
            </div>
        </div>
        <div class="sims-verification-modal-footer">
            <button type="button" class="sims-verification-btn sims-verification-btn-outline" data-close="docPreviewOverlay">Close</button>
            <button type="button" class="sims-verification-btn sims-verification-btn-primary"><i class="fas fa-download"></i> Download</button>
        </div>
    </div>
</div>


<!-- ================================================================
     15. APPROVE COMPANY MODAL
================================================================ -->
<div class="sims-verification-modal-overlay" id="approveModalOverlay">
    <div class="sims-verification-modal sims-verification-modal-sm" role="dialog" aria-modal="true">
        <div class="sims-verification-modal-header">
            <h3><i class="fas fa-circle-check"></i> Approve Company</h3>
            <button type="button" class="sims-verification-modal-close" data-close="approveModalOverlay"><i class="fas fa-xmark"></i></button>
        </div>
        <div class="sims-verification-modal-body">
            <div class="sims-verification-confirm-summary">
                <span>Company</span><strong>Innovate Labs</strong>
                <span>Company ID</span><strong>COM-1003</strong>
            </div>
            <p class="sims-verification-confirm-message">Are you sure you want to approve this company?</p>
            <div class="sims-verification-form-group">
                <label>Approval Note</label>
                <textarea rows="3" placeholder="Add an optional note for this approval..."></textarea>
            </div>
        </div>
        <div class="sims-verification-modal-footer">
            <button type="button" class="sims-verification-btn sims-verification-btn-outline" data-close="approveModalOverlay">Cancel</button>
            <button type="button" class="sims-verification-btn sims-verification-btn-success" id="btnConfirmApprove"><i class="fas fa-check"></i> Approve Company</button>
        </div>
    </div>
</div>


<!-- ================================================================
     16. REJECT COMPANY MODAL
================================================================ -->
<div class="sims-verification-modal-overlay" id="rejectModalOverlay">
    <div class="sims-verification-modal sims-verification-modal-sm" role="dialog" aria-modal="true">
        <div class="sims-verification-modal-header">
            <h3><i class="fas fa-circle-xmark"></i> Reject Company Verification</h3>
            <button type="button" class="sims-verification-modal-close" data-close="rejectModalOverlay"><i class="fas fa-xmark"></i></button>
        </div>
        <div class="sims-verification-modal-body">
            <div class="sims-verification-confirm-summary">
                <span>Company</span><strong>Innovate Labs</strong>
                <span>Company ID</span><strong>COM-1003</strong>
            </div>
            <div class="sims-verification-form-group">
                <label>Rejection Reason <span class="sims-verification-required">*</span></label>
                <select class="sims-verification-select">
                    <option value="">Select a reason...</option>
                    <option>Invalid registration document</option>
                    <option>Incomplete company information</option>
                    <option>Invalid GST/PAN details</option>
                    <option>Duplicate company</option>
                    <option>Unverified organization</option>
                </select>
                <textarea rows="3" placeholder="Provide additional details about the rejection..." class="sims-verification-mt"></textarea>
            </div>
        </div>
        <div class="sims-verification-modal-footer">
            <button type="button" class="sims-verification-btn sims-verification-btn-outline" data-close="rejectModalOverlay">Cancel</button>
            <button type="button" class="sims-verification-btn sims-verification-btn-danger" id="btnConfirmReject"><i class="fas fa-xmark"></i> Reject Company</button>
        </div>
    </div>
</div>


<!-- ================================================================
     17. REQUEST DOCUMENTS MODAL
================================================================ -->
<div class="sims-verification-modal-overlay" id="requestDocsModalOverlay">
    <div class="sims-verification-modal sims-verification-modal-sm" role="dialog" aria-modal="true">
        <div class="sims-verification-modal-header">
            <h3><i class="fas fa-file-circle-plus"></i> Request Additional Documents</h3>
            <button type="button" class="sims-verification-modal-close" data-close="requestDocsModalOverlay"><i class="fas fa-xmark"></i></button>
        </div>
        <div class="sims-verification-modal-body">
            <div class="sims-verification-confirm-summary">
                <span>Company</span><strong>Innovate Labs</strong>
            </div>
            <div class="sims-verification-form-group">
                <label>Select Documents to Request</label>
                <label class="sims-verification-check-item"><input type="checkbox" class="sims-verification-check" /><span>Company Registration Certificate</span></label>
                <label class="sims-verification-check-item"><input type="checkbox" class="sims-verification-check" /><span>GST Certificate</span></label>
                <label class="sims-verification-check-item"><input type="checkbox" class="sims-verification-check" /><span>PAN / Tax Document</span></label>
                <label class="sims-verification-check-item"><input type="checkbox" class="sims-verification-check" checked /><span>Authorization Document</span></label>
                <label class="sims-verification-check-item"><input type="checkbox" class="sims-verification-check" /><span>Other</span></label>
            </div>
            <div class="sims-verification-form-group">
                <label>Message to Company</label>
                <textarea rows="3">Please upload the missing documents so that we can complete your company verification.</textarea>
            </div>
        </div>
        <div class="sims-verification-modal-footer">
            <button type="button" class="sims-verification-btn sims-verification-btn-outline" data-close="requestDocsModalOverlay">Cancel</button>
            <button type="button" class="sims-verification-btn sims-verification-btn-primary" id="btnConfirmRequestDocs"><i class="fas fa-paper-plane"></i> Send Request</button>
        </div>
    </div>
</div>


<!-- ================================================================
     19. VERIFICATION HISTORY MODAL
================================================================ -->
<div class="sims-verification-modal-overlay" id="historyModalOverlay">
    <div class="sims-verification-modal sims-verification-modal-lg" role="dialog" aria-modal="true">
        <div class="sims-verification-modal-header">
            <h3><i class="fas fa-clock-rotate-left"></i> Verification History</h3>
            <button type="button" class="sims-verification-modal-close" data-close="historyModalOverlay"><i class="fas fa-xmark"></i></button>
        </div>
        <div class="sims-verification-modal-body">
            <div class="sims-verification-table-scroll">
            <table class="sims-verification-history-table">
                <thead>
                    <tr>
                        <th>Date &amp; Time</th>
                        <th>Admin</th>
                        <th>Action</th>
                        <th>Status</th>
                        <th>Remarks</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>19 Aug 2026, 10:30 AM</td>
                        <td>Admin</td>
                        <td>Started Review</td>
                        <td><span class="sims-verification-status sims-verification-status-review"><i class="fas fa-circle"></i> Under Review</span></td>
                        <td>Documents checked</td>
                    </tr>
                    <tr>
                        <td>19 Aug 2026, 11:15 AM</td>
                        <td>Admin</td>
                        <td>Document Verified</td>
                        <td><span class="sims-verification-status sims-verification-status-review"><i class="fas fa-circle"></i> Under Review</span></td>
                        <td>GST verified</td>
                    </tr>
                    <tr>
                        <td>19 Aug 2026, 11:45 AM</td>
                        <td>Admin</td>
                        <td>Approved</td>
                        <td><span class="sims-verification-status sims-verification-status-verified"><i class="fas fa-circle"></i> Verified</span></td>
                        <td>All requirements completed</td>
                    </tr>
                </tbody>
            </table>
            </div>
        </div>
        <div class="sims-verification-modal-footer">
            <button type="button" class="sims-verification-btn sims-verification-btn-outline" data-close="historyModalOverlay">Close</button>
        </div>
    </div>
</div>
</asp:Content>






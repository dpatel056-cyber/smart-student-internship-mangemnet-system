<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-companies.aspx.cs" Inherits="asp.net.admin_companies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-companies.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
<div class="sims-company-main-container">

    <!-- 1. TOP HEADER -->
    <div class="cmp-page-header">
        <div class="cmp-page-header-left">
            <h1 class="cmp-page-title">Companies</h1>
            <p class="cmp-page-subtitle">Manage and monitor all registered companies.</p>
        </div>
        <div class="cmp-page-header-right">
            <button type="button" class="cmp-btn-outline" id="btnRefreshCompanies" title="Refresh Data">
                <i class="fa-solid fa-rotate-right"></i>
            </button>
            <button type="button" class="cmp-btn-outline" id="btnExportCompanies">
                <i class="fa-solid fa-arrow-up-from-bracket"></i> Export
            </button>
            <button type="button" class="cmp-btn-primary" id="btnOpenAddCompanyModal">
                <i class="fa-solid fa-plus"></i> Add Company
            </button>
        </div>
    </div>

    <!-- 2. 4 SUMMARY STATISTIC CARDS -->
    <div class="cmp-stats-grid">
        <div class="cmp-stat-card">
            <div class="cmp-stat-icon icon-blue">
                <i class="fa-solid fa-building"></i>
            </div>
            <div class="cmp-stat-body">
                <span class="cmp-stat-label">Total Companies</span>
                <div class="cmp-stat-num-wrap">
                    <h3 class="cmp-stat-number" id="statTotalCompanies">248</h3>
                    <span class="cmp-trend-badge trend-up"><i class="fa-solid fa-arrow-trend-up"></i> +12%</span>
                </div>
                <span class="cmp-stat-subtext">Overall registered</span>
            </div>
        </div>

        <div class="cmp-stat-card">
            <div class="cmp-stat-icon icon-green">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            <div class="cmp-stat-body">
                <span class="cmp-stat-label">Active Companies</span>
                <div class="cmp-stat-num-wrap">
                    <h3 class="cmp-stat-number" id="statActiveCompanies">210</h3>
                    <span class="cmp-trend-badge trend-up"><i class="fa-solid fa-arrow-trend-up"></i> 84.6%</span>
                </div>
                <span class="cmp-stat-subtext">Actively hiring</span>
            </div>
        </div>

        <div class="cmp-stat-card">
            <div class="cmp-stat-icon icon-orange">
                <i class="fa-solid fa-clock-rotate-left"></i>
            </div>
            <div class="cmp-stat-body">
                <span class="cmp-stat-label">Pending Approval</span>
                <div class="cmp-stat-num-wrap">
                    <h3 class="cmp-stat-number" id="statPendingCompanies">24</h3>
                    <span class="cmp-trend-badge trend-pending"><i class="fa-solid fa-hourglass-half"></i> 9.6%</span>
                </div>
                <span class="cmp-stat-subtext">Requires verification</span>
            </div>
        </div>

        <div class="cmp-stat-card">
            <div class="cmp-stat-icon icon-red">
                <i class="fa-solid fa-ban"></i>
            </div>
            <div class="cmp-stat-body">
                <span class="cmp-stat-label">Blocked Companies</span>
                <div class="cmp-stat-num-wrap">
                    <h3 class="cmp-stat-number" id="statBlockedCompanies">14</h3>
                    <span class="cmp-trend-badge trend-down"><i class="fa-solid fa-arrow-trend-down"></i> 5.8%</span>
                </div>
                <span class="cmp-stat-subtext">Access restricted</span>
            </div>
        </div>
    </div>

    <!-- 3. SEARCH AND FILTER SECTION -->
    <div class="cmp-filter-card">
        <div class="cmp-filter-group search-group">
            <div class="cmp-search-wrapper">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <input type="text" id="cmpSearchInput" class="cmp-input" placeholder="Search company name, email or ID..." />
            </div>
        </div>

        <div class="cmp-filter-group">
            <label class="cmp-filter-label">Status</label>
            <div class="cmp-select-wrapper">
                <select id="filterCmpStatus" class="cmp-select">
                    <option value="All">All Status</option>
                    <option value="Active">Active</option>
                    <option value="Pending">Pending</option>
                    <option value="Blocked">Blocked</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="cmp-filter-group">
            <label class="cmp-filter-label">Industry</label>
            <div class="cmp-select-wrapper">
                <select id="filterCmpIndustry" class="cmp-select">
                    <option value="All">All Industries</option>
                    <option value="Information Technology">Information Technology</option>
                    <option value="Finance">Finance</option>
                    <option value="Software">Software</option>
                    <option value="Education">Education</option>
                    <option value="Healthcare">Healthcare</option>
                    <option value="Manufacturing">Manufacturing</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="cmp-filter-group">
            <label class="cmp-filter-label">Location</label>
            <div class="cmp-select-wrapper">
                <select id="filterCmpLocation" class="cmp-select">
                    <option value="All">All Locations</option>
                    <option value="Rajkot">Rajkot</option>
                    <option value="Ahmedabad">Ahmedabad</option>
                    <option value="Surat">Surat</option>
                    <option value="Vadodara">Vadodara</option>
                    <option value="Gandhinagar">Gandhinagar</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="cmp-filter-group">
            <label class="cmp-filter-label">Company Type</label>
            <div class="cmp-select-wrapper">
                <select id="filterCmpType" class="cmp-select">
                    <option value="All">All Types</option>
                    <option value="Private Limited">Private Limited</option>
                    <option value="Public Limited">Public Limited</option>
                    <option value="Partnership">Partnership</option>
                    <option value="Proprietorship">Proprietorship</option>
                    <option value="Startup">Startup</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="cmp-filter-group">
            <label class="cmp-filter-label">Registration Date</label>
            <div class="cmp-select-wrapper">
                <select id="filterCmpRegDate" class="cmp-select">
                    <option value="All">All Time</option>
                    <option value="Today">Today</option>
                    <option value="This Month">This Month</option>
                    <option value="2026">2026</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="cmp-filter-group action-group">
            <button type="button" id="btnClearCmpFilters" class="cmp-btn-clear">
                <i class="fa-solid fa-xmark"></i> Clear Filters
            </button>
        </div>
    </div>

    <!-- 4. MAIN COMPANIES TABLE CARD -->
    <div class="cmp-table-card">
        <div class="cmp-table-responsive">
            <table class="cmp-data-table" id="companiesTable">
                <thead>
                    <tr>
                        <th>Company</th>
                        <th>Company ID</th>
                        <th>Email</th>
                        <th>Industry</th>
                        <th>Location</th>
                        <th>Registered Date</th>
                        <th>Status</th>
                        <th style="text-align: right; width: 60px;">Actions</th>
                    </tr>
                </thead>
                <tbody id="companyTableBody">
                    <!-- Dynamic sample data -->
                </tbody>
            </table>
        </div>

        <!-- 5. PAGINATION -->
        <div class="cmp-pagination-bar">
            <div class="cmp-entries-info" id="cmpEntriesInfo">
                Showing 1–10 of 248 companies
            </div>
            <div class="cmp-pagination-controls">
                <div class="cmp-rows-per-page">
                    <span>Rows per page:</span>
                    <div class="cmp-select-mini-wrap">
                        <select id="cmpPageSize" class="cmp-select-mini">
                            <option value="10" selected>10</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-mini-chevron"></i>
                    </div>
                </div>

                <div class="cmp-pagination-nav" id="cmpPaginationNav">
                </div>
            </div>
        </div>
    </div>

</div>

<!-- 6. VIEW COMPANY DETAIL DRAWER -->
<div class="cmp-drawer-overlay" id="cmpDrawerOverlay">
    <div class="cmp-drawer" id="cmpDrawer">
        <div class="cmp-drawer-header">
            <div class="cmp-drawer-user-header">
                <img src="" alt="" class="cmp-drawer-avatar" id="drawerCmpLogo" />
                <div class="cmp-drawer-title-meta">
                    <h3 id="drawerCmpName">ABC Technologies</h3>
                    <div class="cmp-drawer-tags">
                        <span class="cmp-id-tag" id="drawerCmpId">COM001</span>
                        <span class="cmp-status-pill status-active" id="drawerCmpStatusBadge">Active</span>
                    </div>
                </div>
            </div>
            <button type="button" class="cmp-drawer-close" id="btnCloseCmpDrawer">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>

        <div class="cmp-drawer-quick-actions">
            <button type="button" class="cmp-action-btn-drawer btn-edit-drawer" id="drawerBtnEditCmp">
                <i class="fa-regular fa-pen-to-square"></i> Edit
            </button>
            <button type="button" class="cmp-action-btn-drawer btn-approve-drawer" id="drawerBtnApproveCmp" style="display: none;">
                <i class="fa-solid fa-circle-check"></i> Approve Company
            </button>
            <button type="button" class="cmp-action-btn-drawer btn-block-drawer" id="drawerBtnBlockCmp">
                <i class="fa-solid fa-ban"></i> Block Company
            </button>
            <button type="button" class="cmp-action-btn-drawer btn-delete-drawer" id="drawerBtnDeleteCmp">
                <i class="fa-regular fa-trash-can"></i> Delete
            </button>
        </div>

        <!-- Tabs -->
        <div class="cmp-drawer-tabs">
            <button type="button" class="drawer-tab-btn active" data-tab="cmp-overview">Overview</button>
            <button type="button" class="drawer-tab-btn" data-tab="cmp-info">Company Information</button>
            <button type="button" class="drawer-tab-btn" data-tab="cmp-contact">Contact Person</button>
            <button type="button" class="drawer-tab-btn" data-tab="cmp-documents">Documents</button>
            <button type="button" class="drawer-tab-btn" data-tab="cmp-activity">Activity</button>
        </div>

        <div class="cmp-drawer-body">
            <!-- TAB 1: OVERVIEW -->
            <div class="drawer-tab-pane active" id="tab-cmp-overview">
                <div class="cmp-info-grid">
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Company Name</span>
                        <span class="cmp-info-value" id="dCmpName">ABC Technologies</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Company ID</span>
                        <span class="cmp-info-value" id="dCmpId">COM001</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Email</span>
                        <span class="cmp-info-value" id="dCmpEmail">abc@gmail.com</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Phone</span>
                        <span class="cmp-info-value" id="dCmpPhone">+91 98250 12345</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Website</span>
                        <span class="cmp-info-value" id="dCmpWebsite"><a href="https://abctechnologies.in" target="_blank" style="color:#2563eb; text-decoration:none;">abctechnologies.in</a></span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Industry</span>
                        <span class="cmp-info-value" id="dCmpIndustry">Information Technology</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Company Type</span>
                        <span class="cmp-info-value" id="dCmpType">Private Limited</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Founded Year</span>
                        <span class="cmp-info-value" id="dCmpFounded">2018</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Registration Date</span>
                        <span class="cmp-info-value" id="dCmpRegDate">21 Aug 2026</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Account Status</span>
                        <span class="cmp-info-value" id="dCmpStatus">Active</span>
                    </div>
                    <div class="cmp-info-item cmp-info-full">
                        <span class="cmp-info-label">Last Login</span>
                        <span class="cmp-info-value" id="dCmpLastLogin">21 Aug 2026, 11:20 AM (IP: 103.24.18.90)</span>
                    </div>
                </div>
            </div>

            <!-- TAB 2: COMPANY INFORMATION -->
            <div class="drawer-tab-pane" id="tab-cmp-info">
                <div class="cmp-info-grid">
                    <div class="cmp-info-item cmp-info-full">
                        <span class="cmp-info-label">Full Address</span>
                        <span class="cmp-info-value" id="dCmpFullAddress">401-404, Crystal Plaza, Kalawad Road</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">City</span>
                        <span class="cmp-info-value" id="dCmpCity">Rajkot</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">State</span>
                        <span class="cmp-info-value" id="dCmpState">Gujarat</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Country</span>
                        <span class="cmp-info-value" id="dCmpCountry">India</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Pincode</span>
                        <span class="cmp-info-value" id="dCmpPincode">360005</span>
                    </div>
                </div>
            </div>

            <!-- TAB 3: CONTACT PERSON -->
            <div class="drawer-tab-pane" id="tab-cmp-contact">
                <div class="cmp-info-grid">
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Contact Person Name</span>
                        <span class="cmp-info-value" id="dContactName">Rajesh Kumar</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Designation</span>
                        <span class="cmp-info-value" id="dContactDesignation">HR Manager</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Email</span>
                        <span class="cmp-info-value" id="dContactEmail">rajesh.hr@abc.com</span>
                    </div>
                    <div class="cmp-info-item">
                        <span class="cmp-info-label">Phone</span>
                        <span class="cmp-info-value" id="dContactPhone">+91 98980 54321</span>
                    </div>
                </div>
            </div>

            <!-- TAB 4: DOCUMENTS -->
            <div class="drawer-tab-pane" id="tab-cmp-documents">
                <div class="cmp-docs-list">
                    <div class="cmp-doc-item">
                        <i class="fa-solid fa-file-pdf icon-pdf"></i>
                        <div class="cmp-doc-info">
                            <span class="doc-name">Registration_Certificate.pdf</span>
                            <span class="doc-meta">PDF &bull; 1.8 MB &bull; Uploaded 21 Aug 2026</span>
                        </div>
                        <div class="doc-actions">
                            <button type="button" class="btn-doc-action" title="View Document"><i class="fa-regular fa-eye"></i></button>
                            <button type="button" class="btn-doc-action" title="Download Document"><i class="fa-solid fa-download"></i></button>
                        </div>
                    </div>

                    <div class="cmp-doc-item">
                        <i class="fa-solid fa-file-pdf icon-pdf"></i>
                        <div class="cmp-doc-info">
                            <span class="doc-name">GST_Tax_Document.pdf</span>
                            <span class="doc-meta">PDF &bull; 920 KB &bull; Verified</span>
                        </div>
                        <div class="doc-actions">
                            <button type="button" class="btn-doc-action" title="View Document"><i class="fa-regular fa-eye"></i></button>
                            <button type="button" class="btn-doc-action" title="Download Document"><i class="fa-solid fa-download"></i></button>
                        </div>
                    </div>

                    <div class="cmp-doc-item">
                        <i class="fa-solid fa-file-image icon-img"></i>
                        <div class="cmp-doc-info">
                            <span class="doc-name">Company_License.png</span>
                            <span class="doc-meta">PNG &bull; 1.1 MB &bull; Verified</span>
                        </div>
                        <div class="doc-actions">
                            <button type="button" class="btn-doc-action" title="View Document"><i class="fa-regular fa-eye"></i></button>
                            <button type="button" class="btn-doc-action" title="Download Document"><i class="fa-solid fa-download"></i></button>
                        </div>
                    </div>

                    <div class="cmp-doc-item">
                        <i class="fa-solid fa-file-lines icon-doc"></i>
                        <div class="cmp-doc-info">
                            <span class="doc-name">PAN_Card_Company.pdf</span>
                            <span class="doc-meta">PDF &bull; 450 KB &bull; Verified</span>
                        </div>
                        <div class="doc-actions">
                            <button type="button" class="btn-doc-action" title="View Document"><i class="fa-regular fa-eye"></i></button>
                            <button type="button" class="btn-doc-action" title="Download Document"><i class="fa-solid fa-download"></i></button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- TAB 5: ACTIVITY -->
            <div class="drawer-tab-pane" id="tab-cmp-activity">
                <div class="cmp-activity-timeline">
                    <div class="timeline-item">
                        <div class="timeline-dot dot-green"></div>
                        <div class="timeline-content">
                            <span class="timeline-title">Documents uploaded</span>
                            <span class="timeline-time">Today at 11:25 AM &bull; Registration &amp; GST docs</span>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-dot dot-blue"></div>
                        <div class="timeline-content">
                            <span class="timeline-title">Company logged in</span>
                            <span class="timeline-time">Today at 11:20 AM &bull; IP: 103.24.18.90</span>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-dot dot-purple"></div>
                        <div class="timeline-content">
                            <span class="timeline-title">Admin approved company</span>
                            <span class="timeline-time">21 Aug 2026 at 09:30 AM &bull; Admin</span>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-dot dot-orange"></div>
                        <div class="timeline-content">
                            <span class="timeline-title">Profile updated</span>
                            <span class="timeline-time">20 Aug 2026 at 04:15 PM &bull; Contact details updated</span>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-dot dot-blue"></div>
                        <div class="timeline-content">
                            <span class="timeline-title">Company registered</span>
                            <span class="timeline-time">20 Aug 2026 at 10:00 AM &bull; Self registration</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 7. ADD COMPANY MODAL -->
<div class="cmp-modal-overlay" id="modalAddCompany">
    <div class="cmp-modal-box cmp-modal-lg">
        <div class="cmp-modal-header">
            <h3 class="cmp-modal-title">Add New Company</h3>
            <button type="button" class="cmp-modal-close" data-close="modalAddCompany"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="cmp-modal-body">
            <!-- Section: Company Information -->
            <div class="cmp-form-section">
                <h4 class="cmp-form-section-title"><i class="fa-solid fa-building"></i> Company Information</h4>
                <div class="cmp-form-grid">
                    <div class="cmp-form-group cmp-form-full">
                        <label>Company Logo URL</label>
                        <input type="text" id="addCmpLogo" class="cmp-input" placeholder="https://images.unsplash.com/... or icon" />
                    </div>
                    <div class="cmp-form-group">
                        <label>Company Name <span class="req">*</span></label>
                        <input type="text" id="addCmpName" class="cmp-input" placeholder="Enter company name" required />
                    </div>
                    <div class="cmp-form-group">
                        <label>Company Email <span class="req">*</span></label>
                        <input type="email" id="addCmpEmail" class="cmp-input" placeholder="contact@company.com" required />
                    </div>
                    <div class="cmp-form-group">
                        <label>Phone Number <span class="req">*</span></label>
                        <input type="text" id="addCmpPhone" class="cmp-input" placeholder="+91 98250 12345" required />
                    </div>
                    <div class="cmp-form-group">
                        <label>Website</label>
                        <input type="text" id="addCmpWebsite" class="cmp-input" placeholder="https://company.com" />
                    </div>
                    <div class="cmp-form-group">
                        <label>Industry <span class="req">*</span></label>
                        <select id="addCmpIndustry" class="cmp-select">
                            <option value="Information Technology">Information Technology</option>
                            <option value="Finance">Finance</option>
                            <option value="Software">Software</option>
                            <option value="Education">Education</option>
                            <option value="Healthcare">Healthcare</option>
                            <option value="Manufacturing">Manufacturing</option>
                        </select>
                    </div>
                    <div class="cmp-form-group">
                        <label>Company Type</label>
                        <select id="addCmpType" class="cmp-select">
                            <option value="Private Limited">Private Limited</option>
                            <option value="Public Limited">Public Limited</option>
                            <option value="Partnership">Partnership</option>
                            <option value="Proprietorship">Proprietorship</option>
                            <option value="Startup">Startup</option>
                        </select>
                    </div>
                    <div class="cmp-form-group">
                        <label>Founded Year</label>
                        <input type="number" id="addCmpFounded" class="cmp-input" placeholder="2018" />
                    </div>
                    <div class="cmp-form-group">
                        <label>Company ID <span class="req">*</span></label>
                        <input type="text" id="addCmpId" class="cmp-input" placeholder="COM005" required />
                    </div>
                </div>
            </div>

            <!-- Section: Address -->
            <div class="cmp-form-section">
                <h4 class="cmp-form-section-title"><i class="fa-solid fa-location-dot"></i> Address</h4>
                <div class="cmp-form-grid">
                    <div class="cmp-form-group cmp-form-full">
                        <label>Full Address</label>
                        <input type="text" id="addCmpAddress" class="cmp-input" placeholder="Office / Building / Street address" />
                    </div>
                    <div class="cmp-form-group">
                        <label>City</label>
                        <input type="text" id="addCmpCity" class="cmp-input" placeholder="Rajkot" />
                    </div>
                    <div class="cmp-form-group">
                        <label>State</label>
                        <input type="text" id="addCmpState" class="cmp-input" placeholder="Gujarat" />
                    </div>
                    <div class="cmp-form-group">
                        <label>Country</label>
                        <input type="text" id="addCmpCountry" class="cmp-input" placeholder="India" />
                    </div>
                    <div class="cmp-form-group">
                        <label>Pincode</label>
                        <input type="text" id="addCmpPincode" class="cmp-input" placeholder="360005" />
                    </div>
                </div>
            </div>

            <!-- Section: Contact Person -->
            <div class="cmp-form-section">
                <h4 class="cmp-form-section-title"><i class="fa-solid fa-user-tie"></i> Contact Person</h4>
                <div class="cmp-form-grid">
                    <div class="cmp-form-group">
                        <label>Contact Person Name</label>
                        <input type="text" id="addContactName" class="cmp-input" placeholder="Rajesh Kumar" />
                    </div>
                    <div class="cmp-form-group">
                        <label>Email</label>
                        <input type="email" id="addContactEmail" class="cmp-input" placeholder="hr@company.com" />
                    </div>
                    <div class="cmp-form-group">
                        <label>Phone</label>
                        <input type="text" id="addContactPhone" class="cmp-input" placeholder="+91 98980 54321" />
                    </div>
                    <div class="cmp-form-group">
                        <label>Designation</label>
                        <input type="text" id="addContactDesignation" class="cmp-input" placeholder="HR Manager" />
                    </div>
                </div>
            </div>

            <!-- Section: Account -->
            <div class="cmp-form-section">
                <h4 class="cmp-form-section-title"><i class="fa-solid fa-shield-halved"></i> Account</h4>
                <div class="cmp-form-grid">
                    <div class="cmp-form-group">
                        <label>Username / Email</label>
                        <input type="text" id="addCmpUsername" class="cmp-input" placeholder="company_admin" />
                    </div>
                    <div class="cmp-form-group">
                        <label>Account Status</label>
                        <select id="addCmpStatus" class="cmp-select">
                            <option value="Active">Active</option>
                            <option value="Pending">Pending</option>
                            <option value="Blocked">Blocked</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="cmp-modal-footer">
            <button type="button" class="cmp-btn-outline" data-close="modalAddCompany">Cancel</button>
            <button type="button" class="cmp-btn-primary" id="btnSubmitAddCompany">
                <i class="fa-solid fa-plus"></i> Add Company
            </button>
        </div>
    </div>
</div>

<!-- 8. EDIT COMPANY MODAL -->
<div class="cmp-modal-overlay" id="modalEditCompany">
    <div class="cmp-modal-box cmp-modal-lg">
        <div class="cmp-modal-header">
            <h3 class="cmp-modal-title">Edit Company Profile</h3>
            <button type="button" class="cmp-modal-close" data-close="modalEditCompany"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="cmp-modal-body">
            <div class="cmp-form-grid">
                <div class="cmp-form-group">
                    <label>Company Name <span class="req">*</span></label>
                    <input type="text" id="editCmpName" class="cmp-input" />
                </div>
                <div class="cmp-form-group">
                    <label>Company Email <span class="req">*</span></label>
                    <input type="email" id="editCmpEmail" class="cmp-input" />
                </div>
                <div class="cmp-form-group">
                    <label>Phone Number <span class="req">*</span></label>
                    <input type="text" id="editCmpPhone" class="cmp-input" />
                </div>
                <div class="cmp-form-group">
                    <label>Website</label>
                    <input type="text" id="editCmpWebsite" class="cmp-input" />
                </div>
                <div class="cmp-form-group">
                    <label>Industry</label>
                    <select id="editCmpIndustry" class="cmp-select">
                        <option value="Information Technology">Information Technology</option>
                        <option value="Finance">Finance</option>
                        <option value="Software">Software</option>
                        <option value="Education">Education</option>
                        <option value="Healthcare">Healthcare</option>
                        <option value="Manufacturing">Manufacturing</option>
                    </select>
                </div>
                <div class="cmp-form-group">
                    <label>Company Type</label>
                    <select id="editCmpType" class="cmp-select">
                        <option value="Private Limited">Private Limited</option>
                        <option value="Public Limited">Public Limited</option>
                        <option value="Partnership">Partnership</option>
                        <option value="Proprietorship">Proprietorship</option>
                        <option value="Startup">Startup</option>
                    </select>
                </div>
                <div class="cmp-form-group">
                    <label>Founded Year</label>
                    <input type="number" id="editCmpFounded" class="cmp-input" />
                </div>
                <div class="cmp-form-group">
                    <label>Account Status</label>
                    <select id="editCmpStatus" class="cmp-select">
                        <option value="Active">Active</option>
                        <option value="Pending">Pending</option>
                        <option value="Blocked">Blocked</option>
                    </select>
                </div>
                <div class="cmp-form-group cmp-form-full">
                    <label>Address</label>
                    <input type="text" id="editCmpAddress" class="cmp-input" />
                </div>
                <div class="cmp-form-group">
                    <label>City</label>
                    <input type="text" id="editCmpCity" class="cmp-input" />
                </div>
                <div class="cmp-form-group">
                    <label>State</label>
                    <input type="text" id="editCmpState" class="cmp-input" />
                </div>
                <div class="cmp-form-group">
                    <label>Contact Person</label>
                    <input type="text" id="editContactName" class="cmp-input" />
                </div>
                <div class="cmp-form-group">
                    <label>Contact Designation</label>
                    <input type="text" id="editContactDesignation" class="cmp-input" />
                </div>
            </div>
        </div>
        <div class="cmp-modal-footer">
            <button type="button" class="cmp-btn-outline" data-close="modalEditCompany">Cancel</button>
            <button type="button" class="cmp-btn-primary" id="btnSaveEditCompany">
                <i class="fa-solid fa-check"></i> Save Changes
            </button>
        </div>
    </div>
</div>

<!-- 9. BLOCK COMPANY CONFIRMATION MODAL -->
<div class="cmp-modal-overlay" id="modalBlockCompany">
    <div class="cmp-modal-box cmp-modal-sm">
        <div class="cmp-modal-icon-header icon-warning">
            <i class="fa-solid fa-ban"></i>
        </div>
        <h3 class="cmp-modal-center-title" id="blockCmpModalTitle">Block Company?</h3>
        <p class="cmp-modal-center-text" id="blockCmpModalText">
            Are you sure you want to block <strong id="blockCompanyName">ABC Technologies</strong>? The company will no longer be able to access the platform.
        </p>
        <div class="cmp-modal-center-actions">
            <button type="button" class="cmp-btn-outline" data-close="modalBlockCompany">Cancel</button>
            <button type="button" class="cmp-btn-danger" id="btnConfirmBlockCompany">Block Company</button>
        </div>
    </div>
</div>

<!-- 10. DELETE COMPANY CONFIRMATION MODAL -->
<div class="cmp-modal-overlay" id="modalDeleteCompany">
    <div class="cmp-modal-box cmp-modal-sm">
        <div class="cmp-modal-icon-header icon-danger">
            <i class="fa-regular fa-trash-can"></i>
        </div>
        <h3 class="cmp-modal-center-title">Delete Company?</h3>
        <p class="cmp-modal-center-text">
            Are you sure you want to delete <strong id="deleteCompanyName">ABC Technologies</strong>?<br>
            <span style="color: #ef4444; font-weight: 600; font-size: 13px;">This action cannot be undone.</span>
        </p>
        <div class="cmp-modal-center-actions">
            <button type="button" class="cmp-btn-outline" data-close="modalDeleteCompany">Cancel</button>
            <button type="button" class="cmp-btn-danger" id="btnConfirmDeleteCompany">Delete Company</button>
        </div>
    </div>
</div>

<!-- Toast notification popup -->
<div id="cmpToast" class="cmp-toast" style="display: none;"></div>

<!-- Client side script -->
<script src="../js/admin-companies.js"></script>
</asp:Content>

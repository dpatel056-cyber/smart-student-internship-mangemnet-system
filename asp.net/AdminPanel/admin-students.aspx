<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-students.aspx.cs" Inherits="asp.net.admin_students" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-students.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
<div class="sims-student-main-container">

    <!-- 1. TOP HEADER -->
    <div class="stu-page-header">
        <div class="stu-page-header-left">
            <h1 class="stu-page-title">Student Management</h1>
            <p class="stu-page-subtitle">Manage registered students and their account information.</p>
        </div>
        <div class="stu-page-header-right">
            <button type="button" class="stu-btn-outline" id="btnRefreshStudents" title="Refresh Data">
                <i class="fa-solid fa-rotate-right"></i>
            </button>
            <button type="button" class="stu-btn-outline" id="btnExportStudents">
                <i class="fa-solid fa-arrow-up-from-bracket"></i> Export
            </button>
            <button type="button" class="stu-btn-primary" id="btnOpenAddStudentModal">
                <i class="fa-solid fa-plus"></i> Add Student
            </button>
        </div>
    </div>

    <!-- 2. 4 SUMMARY STATISTIC CARDS -->
    <div class="stu-stats-grid">
        <div class="stu-stat-card">
            <div class="stu-stat-icon icon-blue">
                <i class="fa-solid fa-user-graduate"></i>
            </div>
            <div class="stu-stat-body">
                <span class="stu-stat-label">Total Students</span>
                <div class="stu-stat-num-wrap">
                    <h3 class="stu-stat-number" id="statTotalStudents">1,248</h3>
                    <span class="stu-trend-badge trend-up"><i class="fa-solid fa-arrow-trend-up"></i> +8.4%</span>
                </div>
                <span class="stu-stat-subtext">Overall registered</span>
            </div>
        </div>

        <div class="stu-stat-card">
            <div class="stu-stat-icon icon-green">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            <div class="stu-stat-body">
                <span class="stu-stat-label">Active Students</span>
                <div class="stu-stat-num-wrap">
                    <h3 class="stu-stat-number" id="statActiveStudents">1,180</h3>
                    <span class="stu-trend-badge trend-up"><i class="fa-solid fa-arrow-trend-up"></i> 94.5%</span>
                </div>
                <span class="stu-stat-subtext">Eligible for internships</span>
            </div>
        </div>

        <div class="stu-stat-card">
            <div class="stu-stat-icon icon-red">
                <i class="fa-solid fa-ban"></i>
            </div>
            <div class="stu-stat-body">
                <span class="stu-stat-label">Blocked Students</span>
                <div class="stu-stat-num-wrap">
                    <h3 class="stu-stat-number" id="statBlockedStudents">68</h3>
                    <span class="stu-trend-badge trend-down"><i class="fa-solid fa-arrow-trend-down"></i> 5.5%</span>
                </div>
                <span class="stu-stat-subtext">Access restricted</span>
            </div>
        </div>

        <div class="stu-stat-card">
            <div class="stu-stat-icon icon-purple">
                <i class="fa-solid fa-user-plus"></i>
            </div>
            <div class="stu-stat-body">
                <span class="stu-stat-label">New Students</span>
                <div class="stu-stat-num-wrap">
                    <h3 class="stu-stat-number" id="statNewStudents">124</h3>
                    <span class="stu-trend-badge trend-up"><i class="fa-solid fa-arrow-trend-up"></i> +14%</span>
                </div>
                <span class="stu-stat-subtext">Enrolled this month</span>
            </div>
        </div>
    </div>

    <!-- 3. SEARCH AND FILTER BAR -->
    <div class="stu-filter-card">
        <div class="stu-filter-group search-group">
            <div class="stu-search-wrapper">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <input type="text" id="stuSearchInput" class="stu-input" placeholder="Search student name, email or ID..." />
            </div>
        </div>

        <div class="stu-filter-group">
            <label class="stu-filter-label">Status</label>
            <div class="stu-select-wrapper">
                <select id="filterStatus" class="stu-select">
                    <option value="All">All Status</option>
                    <option value="Active">Active</option>
                    <option value="Blocked">Blocked</option>
                    <option value="Pending">Pending</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="stu-filter-group">
            <label class="stu-filter-label">Course</label>
            <div class="stu-select-wrapper">
                <select id="filterCourse" class="stu-select">
                    <option value="All">All Courses</option>
                    <option value="BCA">BCA</option>
                    <option value="MCA">MCA</option>
                    <option value="B.Tech">B.Tech</option>
                    <option value="M.Tech">M.Tech</option>
                    <option value="B.Sc IT">B.Sc IT</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="stu-filter-group">
            <label class="stu-filter-label">Registration Date</label>
            <div class="stu-select-wrapper">
                <select id="filterRegDate" class="stu-select">
                    <option value="All">All Time</option>
                    <option value="Today">Today</option>
                    <option value="This Month">This Month</option>
                    <option value="2026">2026</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="stu-filter-group">
            <label class="stu-filter-label">Batch</label>
            <div class="stu-select-wrapper">
                <select id="filterBatch" class="stu-select">
                    <option value="All">All Batches</option>
                    <option value="2024-2027">2024-2027</option>
                    <option value="2023-2026">2023-2026</option>
                    <option value="2022-2025">2022-2025</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="stu-filter-group action-group">
            <button type="button" id="btnClearStuFilters" class="stu-btn-clear">
                <i class="fa-solid fa-xmark"></i> Clear Filters
            </button>
        </div>
    </div>

    <!-- 4. MAIN STUDENT TABLE CARD -->
    <div class="stu-table-card">
        <div class="stu-table-responsive">
            <table class="stu-data-table" id="studentTable">
                <thead>
                    <tr>
                        <th>Student</th>
                        <th>Student ID</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Course</th>
                        <th>Registration Date</th>
                        <th>Status</th>
                        <th style="text-align: right; width: 60px;">Actions</th>
                    </tr>
                </thead>
                <tbody id="studentTableBody">
                    <!-- Dynamic rendering -->
                </tbody>
            </table>
        </div>

        <!-- 5. PAGINATION -->
        <div class="stu-pagination-bar">
            <div class="stu-entries-info" id="stuEntriesInfo">
                Showing 1-10 of 1,248 students
            </div>
            <div class="stu-pagination-controls">
                <div class="stu-rows-per-page">
                    <span>Rows per page:</span>
                    <div class="stu-select-mini-wrap">
                        <select id="stuPageSize" class="stu-select-mini">
                            <option value="10" selected>10</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-mini-chevron"></i>
                    </div>
                </div>

                <div class="stu-pagination-nav" id="stuPaginationNav">
                </div>
            </div>
        </div>
    </div>

</div>

<!-- 6. VIEW STUDENT DETAIL DRAWER -->
<div class="stu-drawer-overlay" id="stuDrawerOverlay">
    <div class="stu-drawer" id="stuDrawer">
        <div class="stu-drawer-header">
            <div class="stu-drawer-user-header">
                <img src="" alt="" class="stu-drawer-avatar" id="drawerAvatar" />
                <div class="stu-drawer-title-meta">
                    <h3 id="drawerName">Dhruvi Patel</h3>
                    <div class="stu-drawer-tags">
                        <span class="stu-id-tag" id="drawerId">STU001</span>
                        <span class="stu-status-pill status-active" id="drawerStatusBadge">Active</span>
                    </div>
                </div>
            </div>
            <button type="button" class="stu-drawer-close" id="btnCloseDrawer">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>

        <div class="stu-drawer-quick-actions">
            <button type="button" class="stu-action-btn-drawer btn-edit-drawer" id="drawerBtnEdit">
                <i class="fa-regular fa-pen-to-square"></i> Edit
            </button>
            <button type="button" class="stu-action-btn-drawer btn-block-drawer" id="drawerBtnBlock">
                <i class="fa-solid fa-ban"></i> Block Student
            </button>
            <button type="button" class="stu-action-btn-drawer btn-delete-drawer" id="drawerBtnDelete">
                <i class="fa-regular fa-trash-can"></i> Delete
            </button>
        </div>

        <div class="stu-drawer-tabs">
            <button type="button" class="drawer-tab-btn active" data-tab="overview">Overview</button>
            <button type="button" class="drawer-tab-btn" data-tab="personal">Personal Info</button>
            <button type="button" class="drawer-tab-btn" data-tab="academic">Academic Info</button>
            <button type="button" class="drawer-tab-btn" data-tab="documents">Documents</button>
            <button type="button" class="drawer-tab-btn" data-tab="activity">Activity</button>
        </div>

        <div class="stu-drawer-body">
            <div class="drawer-tab-pane active" id="tab-overview">
                <div class="stu-info-grid">
                    <div class="stu-info-item">
                        <span class="stu-info-label">Full Name</span>
                        <span class="stu-info-value" id="dOverviewName">Dhruvi Patel</span>
                    </div>
                    <div class="stu-info-item">
                        <span class="stu-info-label">Student ID</span>
                        <span class="stu-info-value" id="dOverviewId">STU001</span>
                    </div>
                    <div class="stu-info-item">
                        <span class="stu-info-label">Email Address</span>
                        <span class="stu-info-value" id="dOverviewEmail">dhruvi@gmail.com</span>
                    </div>
                    <div class="stu-info-item">
                        <span class="stu-info-label">Phone Number</span>
                        <span class="stu-info-value" id="dOverviewPhone">9876543210</span>
                    </div>
                    <div class="stu-info-item">
                        <span class="stu-info-label">Course</span>
                        <span class="stu-info-value" id="dOverviewCourse">BCA</span>
                    </div>
                    <div class="stu-info-item">
                        <span class="stu-info-label">College / University</span>
                        <span class="stu-info-value" id="dOverviewCollege">Gujarat University</span>
                    </div>
                    <div class="stu-info-item">
                        <span class="stu-info-label">Enrollment Date</span>
                        <span class="stu-info-value" id="dOverviewEnrollDate">21 Aug 2026</span>
                    </div>
                    <div class="stu-info-item">
                        <span class="stu-info-label">Account Status</span>
                        <span class="stu-info-value" id="dOverviewStatus">Active</span>
                    </div>
                    <div class="stu-info-item stu-info-full">
                        <span class="stu-info-label">Last Login</span>
                        <span class="stu-info-value" id="dOverviewLastLogin">21 Aug 2026, 10:30 AM</span>
                    </div>
                </div>
            </div>

            <div class="drawer-tab-pane" id="tab-personal">
                <div class="stu-info-grid">
                    <div class="stu-info-item">
                        <span class="stu-info-label">Date of Birth</span>
                        <span class="stu-info-value" id="dPersonalDob">15 Oct 2004</span>
                    </div>
                    <div class="stu-info-item">
                        <span class="stu-info-label">Gender</span>
                        <span class="stu-info-value" id="dPersonalGender">Female</span>
                    </div>
                    <div class="stu-info-item stu-info-full">
                        <span class="stu-info-label">Residential Address</span>
                        <span class="stu-info-value" id="dPersonalAddress">A-402, Shivalik Heights, S.G. Highway, Ahmedabad, Gujarat - 380054</span>
                    </div>
                </div>
            </div>

            <div class="drawer-tab-pane" id="tab-academic">
                <div class="stu-info-grid">
                    <div class="stu-info-item">
                        <span class="stu-info-label">Course</span>
                        <span class="stu-info-value" id="dAcademicCourse">BCA</span>
                    </div>
                    <div class="stu-info-item">
                        <span class="stu-info-label">Batch</span>
                        <span class="stu-info-value" id="dAcademicBatch">2024-2027</span>
                    </div>
                    <div class="stu-info-item stu-info-full">
                        <span class="stu-info-label">College</span>
                        <span class="stu-info-value" id="dAcademicCollege">Gujarat University</span>
                    </div>
                </div>
            </div>

            <div class="drawer-tab-pane" id="tab-documents">
                <div class="stu-docs-list">
                    <div class="stu-doc-item">
                        <i class="fa-solid fa-file-pdf icon-pdf"></i>
                        <div class="stu-doc-info">
                            <span class="doc-name">Resume_Dhruvi_Patel.pdf</span>
                            <span class="doc-meta">PDF &bull; 1.2 MB &bull; Uploaded 21 Aug 2026</span>
                        </div>
                        <button type="button" class="btn-doc-download"><i class="fa-solid fa-download"></i></button>
                    </div>
                </div>
            </div>

            <div class="drawer-tab-pane" id="tab-activity">
                <div class="stu-activity-timeline">
                    <div class="timeline-item">
                        <div class="timeline-dot dot-green"></div>
                        <div class="timeline-content">
                            <span class="timeline-title">Applied for Web Development Internship</span>
                            <span class="timeline-time">Today at 10:45 AM &bull; TechSoft</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 7. ADD STUDENT MODAL -->
<div class="stu-modal-overlay" id="modalAddStudent">
    <div class="stu-modal-box stu-modal-lg">
        <div class="stu-modal-header">
            <h3 class="stu-modal-title">Add New Student</h3>
            <button type="button" class="stu-modal-close" data-close="modalAddStudent"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="stu-modal-body">
            <div class="stu-form-section">
                <h4 class="stu-form-section-title"><i class="fa-solid fa-user"></i> Personal Information</h4>
                <div class="stu-form-grid">
                    <div class="stu-form-group stu-form-full">
                        <label>Profile Photo URL</label>
                        <input type="text" id="addPhoto" class="stu-input" placeholder="https://images.unsplash.com/..." />
                    </div>
                    <div class="stu-form-group">
                        <label>Full Name <span class="req">*</span></label>
                        <input type="text" id="addFullName" class="stu-input" placeholder="Enter student full name" required />
                    </div>
                    <div class="stu-form-group">
                        <label>Email Address <span class="req">*</span></label>
                        <input type="email" id="addEmail" class="stu-input" placeholder="student@gmail.com" required />
                    </div>
                    <div class="stu-form-group">
                        <label>Phone Number <span class="req">*</span></label>
                        <input type="text" id="addPhone" class="stu-input" placeholder="9876543210" required />
                    </div>
                    <div class="stu-form-group">
                        <label>Date of Birth</label>
                        <input type="date" id="addDob" class="stu-input" />
                    </div>
                    <div class="stu-form-group">
                        <label>Gender</label>
                        <select id="addGender" class="stu-select">
                            <option value="Female">Female</option>
                            <option value="Male">Male</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="stu-form-section">
                <h4 class="stu-form-section-title"><i class="fa-solid fa-graduation-cap"></i> Academic Information</h4>
                <div class="stu-form-grid">
                    <div class="stu-form-group">
                        <label>Student ID <span class="req">*</span></label>
                        <input type="text" id="addStudentId" class="stu-input" placeholder="STU005" required />
                    </div>
                    <div class="stu-form-group">
                        <label>Course <span class="req">*</span></label>
                        <select id="addCourse" class="stu-select">
                            <option value="BCA">BCA</option>
                            <option value="MCA">MCA</option>
                            <option value="B.Tech">B.Tech</option>
                            <option value="M.Tech">M.Tech</option>
                            <option value="B.Sc IT">B.Sc IT</option>
                        </select>
                    </div>
                    <div class="stu-form-group">
                        <label>College / University</label>
                        <input type="text" id="addCollege" class="stu-input" placeholder="Gujarat University" />
                    </div>
                    <div class="stu-form-group">
                        <label>Batch</label>
                        <select id="addBatch" class="stu-select">
                            <option value="2024-2027">2024-2027</option>
                            <option value="2023-2026">2023-2026</option>
                            <option value="2022-2025">2022-2025</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="stu-form-section">
                <h4 class="stu-form-section-title"><i class="fa-solid fa-location-dot"></i> Address</h4>
                <div class="stu-form-grid">
                    <div class="stu-form-group stu-form-full">
                        <label>Address Line</label>
                        <input type="text" id="addAddress" class="stu-input" placeholder="Flat / House / Street" />
                    </div>
                    <div class="stu-form-group">
                        <label>City</label>
                        <input type="text" id="addCity" class="stu-input" placeholder="Ahmedabad" />
                    </div>
                    <div class="stu-form-group">
                        <label>State</label>
                        <input type="text" id="addState" class="stu-input" placeholder="Gujarat" />
                    </div>
                    <div class="stu-form-group">
                        <label>Pincode</label>
                        <input type="text" id="addPincode" class="stu-input" placeholder="380001" />
                    </div>
                    <div class="stu-form-group">
                        <label>Account Status</label>
                        <select id="addStatus" class="stu-select">
                            <option value="Active">Active</option>
                            <option value="Pending">Pending</option>
                            <option value="Blocked">Blocked</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="stu-modal-footer">
            <button type="button" class="stu-btn-outline" data-close="modalAddStudent">Cancel</button>
            <button type="button" class="stu-btn-primary" id="btnSubmitAddStudent">
                <i class="fa-solid fa-plus"></i> Add Student
            </button>
        </div>
    </div>
</div>

<!-- 8. EDIT STUDENT MODAL -->
<div class="stu-modal-overlay" id="modalEditStudent">
    <div class="stu-modal-box stu-modal-lg">
        <div class="stu-modal-header">
            <h3 class="stu-modal-title">Edit Student Profile</h3>
            <button type="button" class="stu-modal-close" data-close="modalEditStudent"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="stu-modal-body">
            <div class="stu-form-grid">
                <div class="stu-form-group">
                    <label>Full Name <span class="req">*</span></label>
                    <input type="text" id="editFullName" class="stu-input" />
                </div>
                <div class="stu-form-group">
                    <label>Email Address <span class="req">*</span></label>
                    <input type="email" id="editEmail" class="stu-input" />
                </div>
                <div class="stu-form-group">
                    <label>Phone Number <span class="req">*</span></label>
                    <input type="text" id="editPhone" class="stu-input" />
                </div>
                <div class="stu-form-group">
                    <label>Date of Birth</label>
                    <input type="date" id="editDob" class="stu-input" />
                </div>
                <div class="stu-form-group">
                    <label>Gender</label>
                    <select id="editGender" class="stu-select">
                        <option value="Female">Female</option>
                        <option value="Male">Male</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                <div class="stu-form-group">
                    <label>Course</label>
                    <select id="editCourse" class="stu-select">
                        <option value="BCA">BCA</option>
                        <option value="MCA">MCA</option>
                        <option value="B.Tech">B.Tech</option>
                        <option value="M.Tech">M.Tech</option>
                        <option value="B.Sc IT">B.Sc IT</option>
                    </select>
                </div>
                <div class="stu-form-group">
                    <label>College / University</label>
                    <input type="text" id="editCollege" class="stu-input" />
                </div>
                <div class="stu-form-group">
                    <label>Batch</label>
                    <select id="editBatch" class="stu-select">
                        <option value="2024-2027">2024-2027</option>
                        <option value="2023-2026">2023-2026</option>
                        <option value="2022-2025">2022-2025</option>
                    </select>
                </div>
                <div class="stu-form-group stu-form-full">
                    <label>Address</label>
                    <input type="text" id="editAddress" class="stu-input" />
                </div>
                <div class="stu-form-group">
                    <label>City</label>
                    <input type="text" id="editCity" class="stu-input" />
                </div>
                <div class="stu-form-group">
                    <label>State</label>
                    <input type="text" id="editState" class="stu-input" />
                </div>
                <div class="stu-form-group">
                    <label>Pincode</label>
                    <input type="text" id="editPincode" class="stu-input" />
                </div>
                <div class="stu-form-group">
                    <label>Account Status</label>
                    <select id="editStatus" class="stu-select">
                        <option value="Active">Active</option>
                        <option value="Blocked">Blocked</option>
                        <option value="Pending">Pending</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="stu-modal-footer">
            <button type="button" class="stu-btn-outline" data-close="modalEditStudent">Cancel</button>
            <button type="button" class="stu-btn-primary" id="btnSaveEditStudent">
                <i class="fa-solid fa-check"></i> Save Changes
            </button>
        </div>
    </div>
</div>

<!-- 9. BLOCK CONFIRMATION MODAL -->
<div class="stu-modal-overlay" id="modalBlockStudent">
    <div class="stu-modal-box stu-modal-sm">
        <div class="stu-modal-icon-header icon-warning">
            <i class="fa-solid fa-ban"></i>
        </div>
        <h3 class="stu-modal-center-title" id="blockModalTitle">Block Student?</h3>
        <p class="stu-modal-center-text" id="blockModalText">
            Are you sure you want to block <strong id="blockStudentName">Dhruvi Patel</strong>? The student will no longer be able to access their account.
        </p>
        <div class="stu-modal-center-actions">
            <button type="button" class="stu-btn-outline" data-close="modalBlockStudent">Cancel</button>
            <button type="button" class="stu-btn-danger" id="btnConfirmBlockStudent">Block Student</button>
        </div>
    </div>
</div>

<!-- 10. DELETE CONFIRMATION MODAL -->
<div class="stu-modal-overlay" id="modalDeleteStudent">
    <div class="stu-modal-box stu-modal-sm">
        <div class="stu-modal-icon-header icon-danger">
            <i class="fa-regular fa-trash-can"></i>
        </div>
        <h3 class="stu-modal-center-title">Delete Student?</h3>
        <p class="stu-modal-center-text">
            Are you sure you want to delete <strong id="deleteStudentName">Dhruvi Patel</strong>?<br>
            <span style="color: #ef4444; font-weight: 600; font-size: 13px;">This action cannot be undone.</span>
        </p>
        <div class="stu-modal-center-actions">
            <button type="button" class="stu-btn-outline" data-close="modalDeleteStudent">Cancel</button>
            <button type="button" class="stu-btn-danger" id="btnConfirmDeleteStudent">Delete Student</button>
        </div>
    </div>
</div>

<!-- Toast notification popup -->
<div id="stuToast" class="stu-toast" style="display: none;"></div>

<!-- Client side script -->
<script src="../js/admin-students.js"></script>
</asp:Content>

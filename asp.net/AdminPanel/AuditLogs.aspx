<%@ Page Title="Audit Logs" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <style>
        :root {
            --audit-bg: #f8fafc;
            --audit-card: #ffffff;
            --audit-border: #e2e8f0;
            --audit-text: #0f172a;
            --audit-muted: #64748b;
            --audit-primary: #2563eb;
            --audit-primary-soft: #eff6ff;
            --audit-success: #16a34a;
            --audit-success-soft: #f0fdf4;
            --audit-danger: #ef4444;
            --audit-danger-soft: #fef2f2;
            --audit-warning: #f59e0b;
            --audit-warning-soft: #fff7ed;
            --audit-shadow: 0 10px 30px rgba(15, 23, 42, 0.06);
        }

        .audit-page {
            display: flex;
            flex-direction: column;
            gap: 18px;
            padding-bottom: 10px;
        }

        .audit-hero {
            background: linear-gradient(135deg, #ffffff 0%, #f8fbff 100%);
            border: 1px solid var(--audit-border);
            border-radius: 18px;
            padding: 22px;
            box-shadow: var(--audit-shadow);
        }

        .audit-breadcrumb {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 12.5px;
            color: var(--audit-muted);
            margin-bottom: 12px;
            flex-wrap: wrap;
        }

        .audit-breadcrumb a {
            color: var(--audit-muted);
            text-decoration: none;
        }

        .audit-breadcrumb a:hover {
            color: var(--audit-primary);
        }

        .audit-title-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 18px;
            flex-wrap: wrap;
        }

        .audit-title {
            display: flex;
            gap: 14px;
            align-items: flex-start;
        }

        .audit-title-icon {
            width: 52px;
            height: 52px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #2563eb, #1d4ed8);
            color: #fff;
            font-size: 20px;
            box-shadow: 0 10px 24px rgba(37, 99, 235, 0.24);
            flex-shrink: 0;
        }

        .audit-title h2 {
            margin: 0;
            font-size: 28px;
            font-weight: 800;
            color: var(--audit-text);
            letter-spacing: -0.02em;
        }

        .audit-title p {
            margin: 6px 0 0;
            color: var(--audit-muted);
            font-size: 14px;
            line-height: 1.6;
            max-width: 760px;
        }

        .audit-top-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .audit-btn {
            border-radius: 12px;
            padding: 10px 14px;
            font-weight: 600;
            font-size: 13px;
            border: 1px solid var(--audit-border);
            background: #fff;
            color: var(--audit-text);
            transition: all .2s ease;
            text-decoration: none;
        }

        .audit-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 8px 18px rgba(15, 23, 42, 0.08);
        }

        .audit-btn-primary {
            background: var(--audit-primary);
            color: #fff;
            border-color: var(--audit-primary);
        }

        .audit-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 14px;
        }

        .audit-stat {
            background: var(--audit-card);
            border: 1px solid var(--audit-border);
            border-radius: 16px;
            padding: 18px;
            box-shadow: var(--audit-shadow);
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .audit-stat-icon {
            width: 46px;
            height: 46px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
        }

        .audit-stat-label {
            font-size: 12px;
            color: var(--audit-muted);
            margin-bottom: 4px;
        }

        .audit-stat-value {
            font-size: 25px;
            font-weight: 800;
            color: var(--audit-text);
            line-height: 1;
        }

        .audit-panel {
            background: var(--audit-card);
            border: 1px solid var(--audit-border);
            border-radius: 18px;
            box-shadow: var(--audit-shadow);
            overflow: hidden;
        }

        .audit-panel-header {
            padding: 18px 18px 14px;
            border-bottom: 1px solid var(--audit-border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .audit-panel-header h3 {
            margin: 0;
            font-size: 16px;
            font-weight: 800;
            color: var(--audit-text);
        }

        .audit-panel-header p {
            margin: 4px 0 0;
            color: var(--audit-muted);
            font-size: 12.5px;
        }

        .audit-filters {
            padding: 16px 18px 4px;
        }

        .audit-form .form-label {
            font-size: 12px;
            font-weight: 700;
            color: var(--audit-text);
            margin-bottom: 6px;
        }

        .audit-form .form-control,
        .audit-form .form-select {
            border-radius: 12px;
            border-color: var(--audit-border);
            padding: 10px 12px;
            font-size: 13px;
            box-shadow: none;
        }

        .audit-form .form-control:focus,
        .audit-form .form-select:focus {
            border-color: var(--audit-primary);
            box-shadow: 0 0 0 0.2rem rgba(37, 99, 235, 0.12);
        }

        .audit-table-wrap {
            padding: 10px 18px 18px;
        }

        .audit-table {
            width: 100%;
            min-width: 1020px;
            border-collapse: separate;
            border-spacing: 0;
        }

        .audit-table thead th {
            background: #f8fafc;
            color: var(--audit-muted);
            font-size: 11.5px;
            text-transform: uppercase;
            letter-spacing: .04em;
            font-weight: 800;
            padding: 14px 14px;
            border-top: none;
            border-bottom: 1px solid var(--audit-border);
            white-space: nowrap;
        }

        .audit-table tbody td {
            padding: 14px;
            border-bottom: 1px solid var(--audit-border);
            vertical-align: middle;
            font-size: 13.5px;
            color: var(--audit-text);
            background: #fff;
        }

        .audit-table tbody tr:hover td {
            background: #f8fbff;
        }

        .audit-username {
            font-weight: 700;
            color: var(--audit-text);
        }

        .audit-email {
            display: block;
            font-size: 12px;
            color: var(--audit-muted);
            margin-top: 2px;
            word-break: break-word;
        }

        .audit-role-badge,
        .audit-status-badge,
        .audit-action-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 11px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
            border: 1px solid transparent;
            white-space: nowrap;
        }

        .role-student {
            background: var(--audit-primary-soft);
            color: var(--audit-primary);
            border-color: #bfdbfe;
        }

        .role-company {
            background: var(--audit-success-soft);
            color: var(--audit-success);
            border-color: #bbf7d0;
        }

        .role-admin {
            background: #f3e8ff;
            color: #7c3aed;
            border-color: #e9d5ff;
        }

        .status-success {
            background: var(--audit-success-soft);
            color: var(--audit-success);
            border-color: #bbf7d0;
        }

        .status-failed {
            background: var(--audit-danger-soft);
            color: var(--audit-danger);
            border-color: #fecaca;
        }

        .action-login {
            background: #ecfeff;
            color: #0891b2;
            border-color: #a5f3fc;
        }

        .action-logout {
            background: #f8fafc;
            color: #334155;
            border-color: #e2e8f0;
        }

        .action-failed {
            background: var(--audit-warning-soft);
            color: #b45309;
            border-color: #fed7aa;
        }

        .audit-table .btn-view {
            border-radius: 10px;
            padding: 7px 11px;
            font-size: 12px;
            font-weight: 700;
            border: 1px solid #dbeafe;
            background: #eff6ff;
            color: var(--audit-primary);
        }

        .audit-pagination {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            padding: 0 18px 18px;
            color: var(--audit-muted);
            font-size: 12.5px;
        }

        .pagination .page-link {
            border-radius: 10px !important;
            margin: 0 3px;
            border-color: var(--audit-border);
            color: var(--audit-text);
        }

        .pagination .page-item.active .page-link {
            background: var(--audit-primary);
            border-color: var(--audit-primary);
        }

        .audit-empty,
        .audit-loading {
            display: none;
            padding: 40px 20px;
            text-align: center;
        }

        .audit-empty i,
        .audit-loading i {
            font-size: 34px;
            color: #94a3b8;
            margin-bottom: 12px;
        }

        .audit-empty h4,
        .audit-loading h4 {
            margin: 0 0 6px;
            font-size: 18px;
            color: var(--audit-text);
        }

        .audit-empty p,
        .audit-loading p {
            margin: 0;
            color: var(--audit-muted);
            font-size: 13px;
        }

        .audit-skeleton-row td {
            background: linear-gradient(90deg, #f8fafc 25%, #eef2ff 37%, #f8fafc 63%);
            background-size: 400% 100%;
            animation: auditShimmer 1.2s ease-in-out infinite;
            height: 58px;
        }

        @keyframes auditShimmer {
            0% { background-position: 100% 0; }
            100% { background-position: 0 0; }
        }

        .modal-content {
            border-radius: 18px;
            border: 1px solid var(--audit-border);
            overflow: hidden;
        }

        .modal-header {
            background: linear-gradient(135deg, #f8fbff, #ffffff);
            border-bottom: 1px solid var(--audit-border);
        }

        .audit-detail-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 12px;
        }

        .audit-detail-box {
            border: 1px solid var(--audit-border);
            border-radius: 14px;
            padding: 12px 14px;
            background: #fff;
        }

        .audit-detail-box .lbl {
            display: block;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: .04em;
            color: var(--audit-muted);
            margin-bottom: 4px;
            font-weight: 800;
        }

        .audit-detail-box .val {
            font-size: 13px;
            color: var(--audit-text);
            font-weight: 600;
            word-break: break-word;
        }

        @media (max-width: 991px) {
            .audit-title h2 { font-size: 24px; }
            .audit-detail-grid { grid-template-columns: 1fr; }
        }

        @media (max-width: 768px) {
            .audit-hero, .audit-panel-header, .audit-filters, .audit-table-wrap, .audit-pagination { padding-left: 14px; padding-right: 14px; }
            .audit-stat { padding: 16px; }
            .audit-title { width: 100%; }
            .audit-title-icon { width: 46px; height: 46px; border-radius: 14px; }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="audit-page">
        <section class="audit-hero">
            <div class="audit-breadcrumb" aria-label="Breadcrumb">
                <a href="admin-dashboard.aspx">Dashboard</a>
                <span><i class="fa-solid fa-chevron-right"></i></span>
                <a href="admin-settings.aspx">Settings</a>
                <span><i class="fa-solid fa-chevron-right"></i></span>
                <span>Audit Logs</span>
            </div>

            <div class="audit-title-row">
                <div class="audit-title">
                    <div class="audit-title-icon"><i class="fa-solid fa-clipboard-list"></i></div>
                    <div>
                        <h2>Audit Logs</h2>
                        <p>Track user login activity across students, companies, and admins with quick filters, status visibility, and detailed session history.</p>
                    </div>
                </div>

                <div class="audit-top-actions">
                    <button type="button" class="audit-btn" id="btnToggleLoading"><i class="fa-solid fa-spinner"></i> Loading State</button>
                    <button type="button" class="audit-btn audit-btn-primary" id="btnResetDemo"><i class="fa-solid fa-rotate"></i> Reset Demo</button>
                </div>
            </div>
        </section>

        <section class="audit-stats">
            <div class="audit-stat">
                <div class="audit-stat-icon" style="background:#eff6ff;color:#2563eb;"><i class="fa-solid fa-right-to-bracket"></i></div>
                <div><div class="audit-stat-label">Total Logins</div><div class="audit-stat-value" id="totalLoginsCount">1,284</div></div>
            </div>
            <div class="audit-stat">
                <div class="audit-stat-icon" style="background:#f0fdf4;color:#16a34a;"><i class="fa-solid fa-calendar-day"></i></div>
                <div><div class="audit-stat-label">Today's Logins</div><div class="audit-stat-value" id="todayLoginsCount">84</div></div>
            </div>
            <div class="audit-stat">
                <div class="audit-stat-icon" style="background:#eff6ff;color:#2563eb;"><i class="fa-solid fa-user-graduate"></i></div>
                <div><div class="audit-stat-label">Student Logins</div><div class="audit-stat-value" id="studentLoginsCount">862</div></div>
            </div>
            <div class="audit-stat">
                <div class="audit-stat-icon" style="background:#f0fdf4;color:#16a34a;"><i class="fa-solid fa-building"></i></div>
                <div><div class="audit-stat-label">Company Logins</div><div class="audit-stat-value" id="companyLoginsCount">312</div></div>
            </div>
            <div class="audit-stat">
                <div class="audit-stat-icon" style="background:#f3e8ff;color:#7c3aed;"><i class="fa-solid fa-user-shield"></i></div>
                <div><div class="audit-stat-label">Admin Logins</div><div class="audit-stat-value" id="adminLoginsCount">110</div></div>
            </div>
        </section>

        <section class="audit-panel">
            <div class="audit-panel-header">
                <div>
                    <h3><i class="fa-solid fa-filter"></i> Filters</h3>
                    <p>Search and narrow the log history by identity, role, action, status, and date.</p>
                </div>
                <button type="button" class="audit-btn" id="btnClearFilters"><i class="fa-solid fa-xmark"></i> Clear Filters</button>
            </div>

            <div class="audit-filters">
                <div class="row g-3 audit-form">
                    <div class="col-12 col-md-6 col-xl-3">
                        <label for="txtSearch" class="form-label">Search Username / Email</label>
                        <input type="text" class="form-control" id="txtSearch" placeholder="student@gmail.com">
                    </div>
                    <div class="col-12 col-md-6 col-xl-2">
                        <label for="ddlRole" class="form-label">Role</label>
                        <select class="form-select" id="ddlRole">
                            <option value="All">All</option>
                            <option value="Student">Student</option>
                            <option value="Company">Company</option>
                            <option value="Admin">Admin</option>
                        </select>
                    </div>
                    <div class="col-12 col-md-6 col-xl-2">
                        <label for="ddlAction" class="form-label">Action</label>
                        <select class="form-select" id="ddlAction">
                            <option value="All">All</option>
                            <option value="Login">Login</option>
                            <option value="Logout">Logout</option>
                            <option value="Failed Login">Failed Login</option>
                        </select>
                    </div>
                    <div class="col-12 col-md-6 col-xl-2">
                        <label for="ddlStatus" class="form-label">Status</label>
                        <select class="form-select" id="ddlStatus">
                            <option value="All">All</option>
                            <option value="Success">Success</option>
                            <option value="Failed">Failed</option>
                        </select>
                    </div>
                    <div class="col-12 col-md-6 col-xl-2">
                        <label for="dtFilter" class="form-label">Date</label>
                        <input type="date" class="form-control" id="dtFilter">
                    </div>
                    <div class="col-12 col-md-6 col-xl-1 d-flex align-items-end">
                        <button type="button" class="audit-btn audit-btn-primary w-100" id="btnApplyFilters"><i class="fa-solid fa-magnifying-glass"></i></button>
                    </div>
                </div>
            </div>

            <div class="audit-table-wrap">
                <div class="table-responsive">
                    <table class="audit-table" id="auditTable">
                        <thead>
                            <tr>
                                <th>Date &amp; Time</th>
                                <th>Username / Email</th>
                                <th>Role</th>
                                <th>Action</th>
                                <th>Status</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody id="auditTableBody"></tbody>
                    </table>
                </div>

                <div class="audit-loading" id="auditLoading">
                    <i class="fa-solid fa-spinner fa-spin"></i>
                    <h4>Loading audit logs</h4>
                    <p>Preparing the latest login activity records.</p>
                </div>

                <div class="audit-empty" id="auditEmpty">
                    <i class="fa-regular fa-folder-open"></i>
                    <h4>No audit logs found</h4>
                    <p>Try changing the filters or clear them to view all sample activity.</p>
                </div>
            </div>

            <div class="audit-pagination">
                <div>Showing <span id="pageRangeText">1-5</span> of <span id="totalFilteredCount">5</span> records</div>
                <nav aria-label="Audit log pagination">
                    <ul class="pagination pagination-sm mb-0" id="paginationList"></ul>
                </nav>
            </div>
        </section>
    </div>

    <div class="modal fade" id="auditDetailModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <div>
                        <h5 class="modal-title mb-1">Audit Log Details</h5>
                        <div class="text-muted small">Session activity and metadata snapshot</div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="audit-detail-grid">
                        <div class="audit-detail-box"><span class="lbl">Date &amp; Time</span><span class="val" id="detailDate"></span></div>
                        <div class="audit-detail-box"><span class="lbl">Username / Email</span><span class="val" id="detailUser"></span></div>
                        <div class="audit-detail-box"><span class="lbl">Role</span><span class="val" id="detailRole"></span></div>
                        <div class="audit-detail-box"><span class="lbl">Action</span><span class="val" id="detailAction"></span></div>
                        <div class="audit-detail-box"><span class="lbl">Status</span><span class="val" id="detailStatus"></span></div>
                        <div class="audit-detail-box"><span class="lbl">IP Address</span><span class="val" id="detailIp"></span></div>
                    </div>
                    <div class="audit-detail-box mt-3">
                        <span class="lbl">Details</span>
                        <span class="val" id="detailNotes"></span>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="audit-btn" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        (function () {
            var logs = [
                { date: '2026-08-10 09:10 AM', isoDate: '2026-08-10', user: 'student@gmail.com', role: 'Student', action: 'Login', status: 'Success', ip: '103.48.22.11', details: 'Student signed in successfully from Chrome on Windows.' },
                { date: '2026-08-10 08:45 AM', isoDate: '2026-08-10', user: 'company@gmail.com', role: 'Company', action: 'Login', status: 'Success', ip: '103.48.22.26', details: 'Company recruiter authenticated and opened dashboard.' },
                { date: '2026-08-10 08:32 AM', isoDate: '2026-08-10', user: 'admin@sims.com', role: 'Admin', action: 'Login', status: 'Success', ip: '103.48.22.03', details: 'Admin session started with elevated access.' },
                { date: '2026-08-09 11:14 PM', isoDate: '2026-08-09', user: 'student@gmail.com', role: 'Student', action: 'Failed Login', status: 'Failed', ip: '103.48.22.11', details: 'Incorrect password attempt recorded for student account.' },
                { date: '2026-08-09 07:50 PM', isoDate: '2026-08-09', user: 'company@gmail.com', role: 'Company', action: 'Logout', status: 'Success', ip: '103.48.22.26', details: 'Company user logged out after posting a new internship.' },
                { date: '2026-08-09 06:25 PM', isoDate: '2026-08-09', user: 'student2@gmail.com', role: 'Student', action: 'Login', status: 'Success', ip: '103.48.22.19', details: 'Student accessed profile and application history.' },
                { date: '2026-08-09 05:10 PM', isoDate: '2026-08-09', user: 'hr@technova.com', role: 'Company', action: 'Failed Login', status: 'Failed', ip: '103.48.22.74', details: 'Multiple failed attempts triggered account verification.' },
                { date: '2026-08-08 02:40 PM', isoDate: '2026-08-08', user: 'admin2@sims.com', role: 'Admin', action: 'Logout', status: 'Success', ip: '103.48.22.04', details: 'Admin session ended after approval review.' },
                { date: '2026-08-08 01:05 PM', isoDate: '2026-08-08', user: 'student3@gmail.com', role: 'Student', action: 'Login', status: 'Success', ip: '103.48.22.28', details: 'Student logged in from mobile browser.' },
                { date: '2026-08-07 10:18 AM', isoDate: '2026-08-07', user: 'company2@gmail.com', role: 'Company', action: 'Login', status: 'Success', ip: '103.48.22.41', details: 'Company account reviewed internship applicants.' }
            ];

            var filtered = logs.slice();
            var pageSize = 5;
            var currentPage = 1;
            var tableBody = document.getElementById('auditTableBody');
            var emptyState = document.getElementById('auditEmpty');
            var loadingState = document.getElementById('auditLoading');
            var paginationList = document.getElementById('paginationList');
            var pageRangeText = document.getElementById('pageRangeText');
            var totalFilteredCount = document.getElementById('totalFilteredCount');
            var modalEl = document.getElementById('auditDetailModal');
            var modal = window.bootstrap ? new bootstrap.Modal(modalEl) : null;
            var loadingTimer = null;
            var loadingVisible = false;

            function roleClass(role) {
                return role === 'Student' ? 'role-student' : role === 'Company' ? 'role-company' : 'role-admin';
            }

            function actionClass(action) {
                if (action === 'Login') return 'action-login';
                if (action === 'Logout') return 'action-logout';
                return 'action-failed';
            }

            function statusClass(status) {
                return status === 'Success' ? 'status-success' : 'status-failed';
            }

            function setLoading(show) {
                loadingVisible = show;
                loadingState.style.display = show ? 'block' : 'none';
                tableBody.parentElement.style.display = show ? 'none' : 'block';
                paginationList.parentElement.style.display = show ? 'none' : 'block';
                document.querySelector('.audit-pagination div').style.display = show ? 'none' : 'block';
            }

            function renderPagination(totalPages) {
                var html = '';
                var prevDisabled = currentPage <= 1 ? ' disabled' : '';
                var nextDisabled = currentPage >= totalPages ? ' disabled' : '';
                html += '<li class="page-item' + prevDisabled + '"><a class="page-link" href="#" data-page="' + (currentPage - 1) + '">Prev</a></li>';
                for (var i = 1; i <= totalPages; i++) {
                    html += '<li class="page-item' + (i === currentPage ? ' active' : '') + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
                }
                html += '<li class="page-item' + nextDisabled + '"><a class="page-link" href="#" data-page="' + (currentPage + 1) + '">Next</a></li>';
                paginationList.innerHTML = html;
            }

            function renderTable() {
                var start = (currentPage - 1) * pageSize;
                var pageItems = filtered.slice(start, start + pageSize);
                var totalPages = Math.max(1, Math.ceil(filtered.length / pageSize));

                if (!pageItems.length) {
                    tableBody.innerHTML = '';
                    emptyState.style.display = 'block';
                    pageRangeText.textContent = '0-0';
                    totalFilteredCount.textContent = '0';
                    paginationList.innerHTML = '';
                    return;
                }

                emptyState.style.display = 'none';
                var rows = '';
                pageItems.forEach(function (item, index) {
                    var detailId = 'd' + (start + index);
                    rows += '<tr>' +
                        '<td>' + item.date + '</td>' +
                        '<td><span class="audit-username">' + item.user + '</span><span class="audit-email">' + item.user + '</span></td>' +
                        '<td><span class="audit-role-badge ' + roleClass(item.role) + '">' + item.role + '</span></td>' +
                        '<td><span class="audit-action-badge ' + actionClass(item.action) + '">' + item.action + '</span></td>' +
                        '<td><span class="audit-status-badge ' + statusClass(item.status) + '">' + item.status + '</span></td>' +
                        '<td><button type="button" class="btn btn-view" data-detail="' + detailId + '">View Details</button></td>' +
                        '</tr>';
                });
                tableBody.innerHTML = rows;
                totalFilteredCount.textContent = filtered.length.toString();
                pageRangeText.textContent = (start + 1) + '-' + Math.min(start + pageSize, filtered.length);
                renderPagination(totalPages);
            }

            function applyFilters() {
                var q = document.getElementById('txtSearch').value.toLowerCase().trim();
                var role = document.getElementById('ddlRole').value;
                var action = document.getElementById('ddlAction').value;
                var status = document.getElementById('ddlStatus').value;
                var date = document.getElementById('dtFilter').value;

                filtered = logs.filter(function (item) {
                    var matchSearch = !q || item.user.toLowerCase().indexOf(q) > -1;
                    var matchRole = role === 'All' || item.role === role;
                    var matchAction = action === 'All' || item.action === action;
                    var matchStatus = status === 'All' || item.status === status;
                    var matchDate = !date || item.isoDate === date;
                    return matchSearch && matchRole && matchAction && matchStatus && matchDate;
                });
                currentPage = 1;
                renderTable();
            }

            function resetDemo() {
                document.getElementById('txtSearch').value = '';
                document.getElementById('ddlRole').value = 'All';
                document.getElementById('ddlAction').value = 'All';
                document.getElementById('ddlStatus').value = 'All';
                document.getElementById('dtFilter').value = '';
                filtered = logs.slice();
                currentPage = 1;
                renderTable();
            }

            document.getElementById('btnApplyFilters').addEventListener('click', applyFilters);
            document.getElementById('btnClearFilters').addEventListener('click', resetDemo);
            document.getElementById('btnResetDemo').addEventListener('click', resetDemo);

            document.getElementById('btnToggleLoading').addEventListener('click', function () {
                if (loadingTimer) { window.clearTimeout(loadingTimer); loadingTimer = null; }
                setLoading(!loadingVisible);
                if (loadingVisible) {
                    loadingTimer = window.setTimeout(function () {
                        setLoading(false);
                        loadingVisible = false;
                    }, 1800);
                }
            });

            paginationList.addEventListener('click', function (e) {
                var target = e.target.closest('a.page-link');
                if (!target) return;
                e.preventDefault();
                var page = parseInt(target.getAttribute('data-page'), 10);
                var totalPages = Math.max(1, Math.ceil(filtered.length / pageSize));
                if (isNaN(page) || page < 1 || page > totalPages) return;
                currentPage = page;
                renderTable();
            });

            tableBody.addEventListener('click', function (e) {
                var btn = e.target.closest('[data-detail]');
                if (!btn) return;
                var rowIndex = Array.prototype.indexOf.call(tableBody.querySelectorAll('button[data-detail]'), btn);
                var item = filtered[(currentPage - 1) * pageSize + rowIndex];
                if (!item) return;
                document.getElementById('detailDate').textContent = item.date;
                document.getElementById('detailUser').textContent = item.user;
                document.getElementById('detailRole').innerHTML = '<span class="audit-role-badge ' + roleClass(item.role) + '">' + item.role + '</span>';
                document.getElementById('detailAction').innerHTML = '<span class="audit-action-badge ' + actionClass(item.action) + '">' + item.action + '</span>';
                document.getElementById('detailStatus').innerHTML = '<span class="audit-status-badge ' + statusClass(item.status) + '">' + item.status + '</span>';
                document.getElementById('detailIp').textContent = item.ip;
                document.getElementById('detailNotes').textContent = item.details;
                if (modal) modal.show();
            });

            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape' && loadingVisible) {
                    setLoading(false);
                    loadingVisible = false;
                }
            });

            setLoading(false);
            renderTable();
        })();
    </script>
</asp:Content>



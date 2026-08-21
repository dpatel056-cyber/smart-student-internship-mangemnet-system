<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-audit-logs.aspx.cs" Inherits="asp.net.admin_audit_logs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-audit-logs.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
<div class="sims-audit-page-container">

    <!-- ============ 1. TOP SUMMARY STATS ============ -->
    <div class="audit-stats-grid">
        <!-- Total Users -->
        <div class="audit-stat-card">
            <div class="audit-stat-icon icon-users">
                <i class="fa-solid fa-user-group"></i>
            </div>
            <div class="audit-stat-details">
                <span class="audit-stat-title">Total Users</span>
                <h3 class="audit-stat-number" id="statTotalUsers">248</h3>
                <span class="audit-stat-sub">All registered users</span>
            </div>
        </div>

        <!-- Active Now -->
        <div class="audit-stat-card">
            <div class="audit-stat-icon icon-active">
                <i class="fa-solid fa-user-check"></i>
            </div>
            <div class="audit-stat-details">
                <span class="audit-stat-title">Active Now</span>
                <h3 class="audit-stat-number" id="statActiveNow">32</h3>
                <span class="audit-stat-sub">Currently logged in</span>
            </div>
        </div>

        <!-- Logged Out -->
        <div class="audit-stat-card">
            <div class="audit-stat-icon icon-logout">
                <i class="fa-solid fa-arrow-right-from-bracket"></i>
            </div>
            <div class="audit-stat-details">
                <span class="audit-stat-title">Logged Out</span>
                <h3 class="audit-stat-number" id="statLoggedOut">210</h3>
                <span class="audit-stat-sub">Users logged out</span>
            </div>
        </div>

        <!-- Failed Login -->
        <div class="audit-stat-card">
            <div class="audit-stat-icon icon-failed">
                <i class="fa-solid fa-shield-halved"></i>
            </div>
            <div class="audit-stat-details">
                <span class="audit-stat-title">Failed Login</span>
                <h3 class="audit-stat-number" id="statFailedLogin">6</h3>
                <span class="audit-stat-sub">Failed login attempts</span>
            </div>
        </div>
    </div>

    <!-- ============ 2. FILTER BAR ============ -->
    <div class="audit-filter-card">
        <div class="audit-filter-group search-group">
            <div class="audit-search-wrapper">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <input type="text" id="auditSearchInput" class="audit-input" placeholder="Search user name or email..." />
            </div>
        </div>

        <div class="audit-filter-group">
            <label class="audit-filter-label">Role</label>
            <div class="audit-select-wrapper">
                <select id="filterRole" class="audit-select">
                    <option value="All">All Roles</option>
                    <option value="Admin">Admin</option>
                    <option value="Company">Company</option>
                    <option value="Student">Student</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="audit-filter-group">
            <label class="audit-filter-label">Status</label>
            <div class="audit-select-wrapper">
                <select id="filterStatus" class="audit-select">
                    <option value="All">All Status</option>
                    <option value="Active">Active</option>
                    <option value="Logged Out">Logged Out</option>
                    <option value="Failed">Failed</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="audit-filter-group">
            <label class="audit-filter-label">Date Range</label>
            <div class="audit-select-wrapper">
                <select id="filterDateRange" class="audit-select">
                    <option value="Today">Today</option>
                    <option value="Yesterday">Yesterday</option>
                    <option value="Last 7 Days">Last 7 Days</option>
                    <option value="Custom">Custom</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <!-- Custom Date Range Inputs -->
        <div class="audit-filter-group custom-date-group" id="customDateGroup" style="display: none;">
            <label class="audit-filter-label">Select Dates</label>
            <div class="audit-custom-dates-wrap">
                <input type="date" id="customStartDate" class="audit-input custom-date-input" />
                <span class="custom-date-sep">to</span>
                <input type="date" id="customEndDate" class="audit-input custom-date-input" />
            </div>
        </div>

        <div class="audit-filter-group action-group">
            <div class="audit-btn-actions">
                <button type="button" id="btnSearchAudit" class="audit-btn-search">
                    <i class="fa-solid fa-magnifying-glass"></i> Search
                </button>
                <button type="button" id="btnResetAuditFilters" class="audit-btn-reset">
                    <i class="fa-solid fa-rotate-left"></i> Reset
                </button>
            </div>
        </div>
    </div>

    <!-- ============ 3. TABLE CARD ============ -->
    <div class="audit-table-card">
        <div class="audit-table-responsive">
            <table class="audit-data-table" id="auditLogsTable">
                <thead>
                    <tr>
                        <th>User Name</th>
                        <th>Email ID</th>
                        <th>Role</th>
                        <th>Login Date</th>
                        <th>Login Time</th>
                        <th>Logout Time</th>
                        <th>Duration</th>
                        <th>IP Address</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="auditTableBody">
                    <!-- Populated dynamically via JavaScript for real pagination -->
                </tbody>
            </table>
        </div>

        <!-- ============ 4. PAGINATION FOOTER ============ -->
        <div class="audit-pagination-bar">
            <div class="audit-entries-info" id="auditEntriesInfo">
                Showing 1 to 10 of 248 entries
            </div>
            <div class="audit-pagination-controls">
                <div class="audit-rows-per-page">
                    <span>Rows per page:</span>
                    <div class="audit-select-mini-wrap">
                        <select id="auditPageSize" class="audit-select-mini">
                            <option value="10" selected>10</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-mini-chevron"></i>
                    </div>
                </div>

                <div class="audit-pagination-nav" id="auditPaginationNav">
                    <!-- Rendered dynamically via JavaScript -->
                </div>
            </div>
        </div>
    </div>

</div>

<!-- Client side script for dynamic pagination, search & filters -->
<script src="../js/admin-audit-logs.js"></script>
</asp:Content>
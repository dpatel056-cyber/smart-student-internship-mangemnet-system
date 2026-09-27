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
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                CssClass="cmp-data-table" UseAccessibleHeader="true"
                GridLines="None"
                Width="100%"
                OnRowCommand="GridView1_RowCommand">
                <HeaderStyle CssClass="cmp-table-header" />
                <RowStyle CssClass="cmp-table-row" />
                <AlternatingRowStyle CssClass="cmp-table-row-alt" />
                <Columns>
                    <asp:BoundField DataField="CompanyId" HeaderText="ID" />
                    <asp:BoundField DataField="c_company" HeaderText="Company Name" />
                    <asp:BoundField DataField="c_email" HeaderText="Email" />
                    <asp:BoundField DataField="c_contact" HeaderText="Mobile" />
                    <asp:BoundField DataField="c_website" HeaderText="Website" />
                    <asp:BoundField DataField="c_industry" HeaderText="Industry" />
                    <asp:BoundField DataField="c_size" HeaderText="Size" />
                    <asp:BoundField DataField="c_location" HeaderText="Location" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div style="display:flex; gap:10px; align-items:center;">
                                <asp:LinkButton ID="btnView" runat="server" CommandArgument='<%# Eval("CompanyId") %>' CommandName="cmd_view" CssClass="btn-action-view" CausesValidation="false">
                                    <i class="fa-regular fa-eye"></i> View
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandArgument='<%# Eval("CompanyId") %>' CommandName="cmd_del" CssClass="btn-action-delete" CausesValidation="false">
                                    <i class="fa-solid fa-trash-can"></i> Delete
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>



        <!-- 5. PAGINATION -->
        <div class="cmp-pagination-bar">
            <div class="cmp-entries-info" id="cmpEntriesInfo">
                Showing 1â€“10 of 248 companies
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



<!-- Toast notification popup -->
<div id="cmpToast" class="cmp-toast" style="display: none;"></div>


<!-- Client side script -->
<script src="../js/admin-companies.js"></script>
</asp:Content>


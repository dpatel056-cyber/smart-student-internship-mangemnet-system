<%@ Page Title="Admin - Internships" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-internships.aspx.cs" Inherits="asp.net.admin_internships" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-internships.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sims-internship-page">
        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title">Internship Management</h1>
            <p class="page-subtitle">Manage, review, search and filter all internship opportunities posted by registered companies.</p>
        </div>

        <!-- Search & Filter Bar -->
        <div class="admin-filter-bar">
            <div class="filter-search-wrap">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search role, skills, company..." />
            </div>

            <div class="filter-select-wrap wrap-domain">
                <i class="fa-solid fa-layer-group prefix-icon"></i>
                <asp:DropDownList ID="ddlDomain" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDomain_SelectedIndexChanged">
                    <asp:ListItem Text="All Domains" Value="" />
                    <asp:ListItem Text="Web Development" Value="Web Development" />
                    <asp:ListItem Text="Data Science" Value="Data Science" />
                    <asp:ListItem Text="Cyber Security" Value="Cyber Security" />
                    <asp:ListItem Text="Cloud Computing" Value="Cloud Computing" />
                    <asp:ListItem Text="Machine Learning" Value="Machine Learning" />
                    <asp:ListItem Text="Mobile Development" Value="Mobile Development" />
                    <asp:ListItem Text="DevOps" Value="DevOps" />
                    <asp:ListItem Text="Design" Value="Design" />
                    <asp:ListItem Text="Management" Value="Management" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="filter-select-wrap wrap-location">
                <i class="fa-solid fa-location-dot prefix-icon"></i>
                <asp:DropDownList ID="ddlLocation" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged">
                    <asp:ListItem Text="All Locations" Value="" />
                    <asp:ListItem Text="Ahmedabad" Value="Ahmedabad" />
                    <asp:ListItem Text="Bangalore" Value="Bangalore" />
                    <asp:ListItem Text="Gandhinagar" Value="Gandhinagar" />
                    <asp:ListItem Text="Hyderabad" Value="Hyderabad" />
                    <asp:ListItem Text="Pune" Value="Pune" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="filter-select-wrap wrap-workmode">
                <i class="fa-solid fa-laptop-code prefix-icon"></i>
                <asp:DropDownList ID="ddlWorkMode" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlWorkMode_SelectedIndexChanged">
                    <asp:ListItem Text="All Work Modes" Value="" />
                    <asp:ListItem Text="On-site" Value="On-site" />
                    <asp:ListItem Text="Remote" Value="Remote" />
                    <asp:ListItem Text="Hybrid" Value="Hybrid" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="filter-select-wrap wrap-type">
                <i class="fa-solid fa-briefcase prefix-icon"></i>
                <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
                    <asp:ListItem Text="All Types" Value="" />
                    <asp:ListItem Text="Full-time" Value="Full-time" />
                    <asp:ListItem Text="Part-time" Value="Part-time" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="filter-select-wrap wrap-status">
                <i class="fa-solid fa-toggle-on prefix-icon"></i>
                <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                    <asp:ListItem Text="All Status" Value="" />
                    <asp:ListItem Text="Active" Value="Active" />
                    <asp:ListItem Text="Inactive" Value="Inactive" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="filter-actions">
                <asp:ImageButton ID="btnSearch" runat="server" CausesValidation="false" OnClick="btnSearch_Click" ImageUrl="~/image_button/btn_admin_search.png" Height="40" CssClass="admin-img-btn admin-img-btn-search" />
                <asp:ImageButton ID="btnClearFilters" runat="server" CausesValidation="false" OnClick="btnClearFilters_Click" ImageUrl="~/image_button/btn_admin_clear_filters.png" Height="40" CssClass="admin-img-btn admin-img-btn-clear" />
                <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" CssClass="btn-report" OnClick="btnGenerateReport_Click" CausesValidation="false" style="background: linear-gradient(135deg, #0155e3 0%, #1e40af 100%) !important; color: #ffffff !important; height: 40px !important; padding: 0 16px !important; border: none !important; border-radius: 8px !important; font-weight: 600 !important; font-size: 13px !important; cursor: pointer !important; white-space: nowrap !important; display: inline-flex !important; align-items: center !important; justify-content: center !important; box-shadow: 0 2px 6px rgba(1, 85, 227, 0.28) !important; flex-shrink: 0 !important; outline: none !important; text-decoration: none !important; line-height: 40px !important;" />
            </div>
        </div>

        <!-- Internships List -->
        <div class="list-card">
            <div class="list-card-header">
                <h2 class="list-card-title">All Posted Internships</h2>
                <asp:Label ID="lblResultCount" runat="server" CssClass="result-count" />
            </div>

            <asp:DataList ID="DataListAdminInternships" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal"
                CssClass="admin-internships-grid" OnItemCommand="DataListAdminInternships_ItemCommand">
                <ItemTemplate>
                    <div class="admin-internship-card">
                        <!-- Header: Logo, Title, Company, Status -->
                        <div class="admin-card-header">
                            <div class="admin-card-main">
                                <asp:Image ID="imgCompanyLogo" runat="server" CssClass="admin-company-logo-avatar" ImageUrl='<%# Eval("c_logo") %>' />

<div class="admin-card-title-wrap">
                                    <h3 class="admin-card-title">
                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("InternshipTitle") %>' />
                                    </h3>
                                    <div class="admin-company-name">
                                        <i class="fa-solid fa-building"></i>
                                        <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>' />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Info List -->
                        <div class="admin-info-list">
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-location-dot"></i> Location:</span>
                                <span class="admin-info-val"><asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-clock"></i> Duration:</span>
                                <span class="admin-info-val"><asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-tag"></i> Domain:</span>
                                <span class="admin-info-val"><asp:Label ID="lblDomain" runat="server" Text='<%# Eval("InternshipDomain") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-laptop-code"></i> Work Mode:</span>
                                <span class="admin-info-val"><asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-money-bill-wave"></i> Stipend:</span>
                                <span class="admin-info-val stipend"><%# Eval("StipendAmount") %></span>
                            </div>
                        </div>

                        <!-- Actions -->
                        <div class="admin-card-actions">
                            <asp:ImageButton ID="btnView" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("Id") %>'
                                ImageUrl="~/image_button/btn_admin_view.png" CssClass="admin-img-btn admin-img-btn-view"
                                Height="32" />

                            <asp:ImageButton ID="btnDelete" runat="server" CommandName="cmd_delete" CommandArgument='<%# Eval("Id") %>'
                                ImageUrl="~/image_button/btn_admin_delete.png" CssClass="admin-img-btn admin-img-btn-delete"
                                Height="32" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>

            <!-- Empty State -->
            <div id="pnlNoInternships" runat="server" visible="false">
                <div class="empty-state-box-admin">
                    <div class="empty-state-icon"><i class="fas fa-briefcase"></i></div>
                    <h3 class="empty-state-title">No Internships Found</h3>
                    <p class="empty-state-text">There are currently no internship postings available.</p>
                </div>
            </div>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <asp:ImageButton ID="btnPrevious" runat="server" ImageUrl="~/image_button/btn_previous.png" Height="42" OnClick="btnPrevious_Click" CssClass="admin-img-btn" />
            <asp:Label ID="lblPages" runat="server" CssClass="pagination-pages" />
            <asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/image_button/btn_next.png" Height="42" OnClick="btnNext_Click" CssClass="admin-img-btn" />
        </div>
    </div>
</asp:Content>

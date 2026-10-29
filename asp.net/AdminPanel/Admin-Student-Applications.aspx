<%@ Page Title="Student Applications" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-student-applications.aspx.cs" Inherits="asp.net.admin_student_applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-student-applications.css?v=205" />
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="sims-applications-page">
        <!-- ===================== PAGE HEADER ===================== -->
        <div class="sims-application-header">
            <div class="sims-application-header-left">
                <h1 class="sims-application-title">Student Applications</h1>
                <p class="sims-application-subtitle">Review, monitor and manage internship applications submitted by students.</p>
            </div>
        </div>
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        <!-- ===================== STATISTICS (1 ROW 5 COLUMNS) ===================== -->
        <div class="sims-stats-grid">
            <!-- Card 1: Total Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-orange">
                    <i class="fa-solid fa-file-lines"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Total Applications</span>
                    <span class="sims-stat-num-v2"><asp:Label ID="lblTotalApps" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 2: Pending Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-yellow">
                    <i class="fa-solid fa-hourglass-half"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Pending</span>
                    <span class="sims-stat-num-v2"><asp:Label ID="lblPendingApps" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 3: Shortlisted Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-blue">
                    <i class="fa-solid fa-list-check"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Shortlisted</span>
                    <span class="sims-stat-num-v2"><asp:Label ID="lblShortlistedApps" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 4: Selected Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-green">
                    <i class="fa-solid fa-check"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Selected</span>
                    <span class="sims-stat-num-v2"><asp:Label ID="lblSelectedApps" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 5: Rejected Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-pink">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Rejected</span>
                    <span class="sims-stat-num-v2"><asp:Label ID="lblRejectedApps" runat="server">0</asp:Label></span>
                </div>
            </div>
        </div>
        <!-- ===================== SEARCH & FILTER PANEL ===================== -->
        <div class="sims-application-filters">
            <!-- Search Box with Icon -->
            <div class="sims-filter-search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="sims-search-input" placeholder="Search by student, email, internship or company..."></asp:TextBox>
            </div>
            <!-- Status Dropdown with wrapper -->
            <div class="sims-filter-select-box">
                <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged" CssClass="sims-select-status">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                    <asp:ListItem Text="Shortlisted" Value="Shortlisted"></asp:ListItem>
                    <asp:ListItem Text="Selected" Value="Selected"></asp:ListItem>
                    <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down"></i>
            </div>
            <!-- Action Buttons: Search, Clear & Generate Report -->
            <div class="sims-filter-actions">
                <asp:ImageButton ID="btnSearch" runat="server" CausesValidation="false" OnClick="btnSearch_Click" ImageUrl="~/image_button/btn_admin_search.png" Height="40" CssClass="admin-img-btn admin-img-btn-search" />
                <asp:ImageButton ID="btnClearFilters" runat="server" CausesValidation="false" OnClick="btnClearFilters_Click" ImageUrl="~/image_button/btn_admin_clear_filters.png" Height="40" CssClass="admin-img-btn admin-img-btn-clear" />
                <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" CssClass="btn-report" OnClick="btnGenerateReport_Click" CausesValidation="false" style="background: linear-gradient(135deg, #0155e3 0%, #1e40af 100%) !important; color: #ffffff !important; height: 40px !important; padding: 0 16px !important; border: none !important; border-radius: 8px !important; font-weight: 600 !important; font-size: 13px !important; cursor: pointer !important; white-space: nowrap !important; display: inline-flex !important; align-items: center !important; justify-content: center !important; box-shadow: 0 2px 6px rgba(1, 85, 227, 0.28) !important; flex-shrink: 0 !important; outline: none !important; text-decoration: none !important; line-height: 40px !important;" />
            </div>
        </div>
        <!-- ===================== TABLE CARD ===================== -->
        <div class="sims-table-card">
            <div class="sims-table-responsive-v2">
                <asp:GridView ID="gvApplications" runat="server" AutoGenerateColumns="False" OnRowCommand="gvApplications_RowCommand" CssClass="sims-recent-table-v2" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%">
                    <HeaderStyle CssClass="sims-table-header" />
                    <RowStyle CssClass="sims-table-row" />
                    <AlternatingRowStyle CssClass="sims-table-row-alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="STUDENT" HeaderStyle-CssClass="col-student" ItemStyle-CssClass="col-student">
                            <ItemTemplate>
                                <div class="cell-student">
                                    <asp:Image ID="imgStudentPhoto" runat="server" CssClass="cell-student-avatar" Width="38" Height="38" ImageUrl='<%# Eval("ProfilePhoto") %>' />
                                    <asp:Label ID="lblStudentName" runat="server" Text='<%# Eval("FullName") %>' CssClass="cell-student-name"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="EMAIL" HeaderStyle-CssClass="col-email" ItemStyle-CssClass="col-email">
                            <ItemTemplate>
                                <div class="cell-email">
                                    <i class="fa-regular fa-envelope cell-email-icon"></i>
                                    <asp:Label ID="lblStudentEmail" runat="server" Text='<%# Eval("StudentEmail") %>' CssClass="cell-email-text"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="INTERNSHIP" HeaderStyle-CssClass="col-internship" ItemStyle-CssClass="col-internship">
                            <ItemTemplate>
                                <div class="cell-internship">
                                    <i class="fa-solid fa-laptop-code cell-internship-icon"></i>
                                    <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>' CssClass="cell-internship-title"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="COMPANY" HeaderStyle-CssClass="col-company" ItemStyle-CssClass="col-company">
                            <ItemTemplate>
                                <div class="cell-company">
                                    <i class="fa-solid fa-building cell-company-icon"></i>
                                    <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>' CssClass="cell-company-name"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="APPLIED DATE" HeaderStyle-CssClass="col-date" ItemStyle-CssClass="col-date">
                            <ItemTemplate>
                                <div class="cell-date">
                                    <i class="fa-regular fa-calendar cell-date-icon"></i>
                                    <asp:Label ID="lblAppliedDate" runat="server"
                                        Text='<%# Convert.ToDateTime(Eval("AppliedDate")).ToString("dd MMM yyyy") %>' CssClass="cell-date-text">
                                    </asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="STATUS" HeaderStyle-CssClass="col-status" ItemStyle-CssClass="col-status">
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server"
                                    Text='<%# GetStatusBadge(Eval("Status")) %>'>
                                </asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ACTION" HeaderStyle-CssClass="col-action" ItemStyle-CssClass="col-action">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnDeleteApplication" runat="server" CommandName="cmd_delete" CommandArgument='<%# Eval("ApplicationId") %>'
                                    ImageUrl="~/image_button/btn_admin_delete.png" CausesValidation="false" CssClass="admin-img-btn admin-img-btn-delete"
                                    Height="30" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="empty-data-container">
                            <i class="fa-regular fa-folder-open empty-data-icon"></i>
                            No applications found.
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
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

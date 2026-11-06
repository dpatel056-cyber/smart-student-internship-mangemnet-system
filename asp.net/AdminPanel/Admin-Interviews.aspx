<%@ Page Title="Interview Management" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-interviews.aspx.cs" Inherits="asp.net.css.admin_interviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-interviews.css?v=206" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="interview-page-wrap">
        <!-- Header -->
        <div class="page-header">
            <h1 class="page-title">Interviews</h1>
            <p class="page-subtitle">Monitor and manage student interview schedules across companies.</p>
        </div>

        <asp:Label ID="lblMsg" runat="server" Visible="false" />

        <!-- Stats -->
        <div class="iv-stats">
            <div class="iv-stat-card">
                <div class="iv-stat-icon blue"><i class="fa-solid fa-calendar-days"></i></div>
                <div>
                    <div class="iv-stat-value"><asp:Label ID="lblTotalInterviews" runat="server" /></div>
                    <div class="iv-stat-label">Total Interviews</div>
                </div>
            </div>
            <div class="iv-stat-card">
                <div class="iv-stat-icon yellow"><i class="fa-solid fa-clock"></i></div>
                <div>
                    <div class="iv-stat-value"><asp:Label ID="lblScheduled" runat="server" /></div>
                    <div class="iv-stat-label">Scheduled</div>
                </div>
            </div>
            <div class="iv-stat-card">
                <div class="iv-stat-icon green"><i class="fa-solid fa-circle-check"></i></div>
                <div>
                    <div class="iv-stat-value"><asp:Label ID="lblCompleted" runat="server" /></div>
                    <div class="iv-stat-label">Completed</div>
                </div>
            </div>
            <div class="iv-stat-card">
                <div class="iv-stat-icon red"><i class="fa-solid fa-circle-xmark"></i></div>
                <div>
                    <div class="iv-stat-value"><asp:Label ID="lblCancelled" runat="server" /></div>
                    <div class="iv-stat-label">Cancelled</div>
                </div>
            </div>
        </div>

        <!-- Filter Bar -->
        <div class="iv-filter-bar">
            <div class="iv-search-wrap">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by candidate, email, internship or company..." />
            </div>

            <div class="iv-select-wrap">
                <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                    <asp:ListItem Text="All Status" Value="" />
                    <asp:ListItem Text="Scheduled" Value="Scheduled" />
                    <asp:ListItem Text="Completed" Value="Completed" />
                    <asp:ListItem Text="Cancelled" Value="Cancelled" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down chevron-icon"></i>
            </div>

            <div class="iv-filter-actions">
                <asp:ImageButton ID="btnSearch" runat="server" CausesValidation="false" OnClick="btnSearch_Click" ImageUrl="~/image_button/btn_admin_search.png" Height="40" CssClass="admin-img-btn admin-img-btn-search" />
                <asp:ImageButton ID="btnClearFilters" runat="server" CausesValidation="false" OnClick="btnClearFilters_Click" ImageUrl="~/image_button/btn_admin_clear_filters.png" Height="40" CssClass="admin-img-btn admin-img-btn-clear" />
                <asp:ImageButton ID="btnGenerateReport" runat="server" OnClick="btnGenerateReport_Click" ImageUrl="~/image_button/btn_admin_generate_report.png?v=2" Height="40" CssClass="admin-img-btn admin-img-btn-report" CausesValidation="false" />
            </div>
        </div>

        <!-- Interviews List -->
        <div class="iv-list">
            <asp:DataList ID="dlInterviews" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="admin-interviews-grid">
                <ItemTemplate>
                    <div class="admin-interview-card">
                        <!-- Header: Logo, Title, Company -->
                        <div class="admin-card-header">
                            <asp:Image ID="imgLogo" runat="server" CssClass="admin-company-logo-avatar" ImageUrl='<%# Eval("c_logo") %>' />
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

                        <!-- Info List -->
                        <div class="admin-info-list">
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-user"></i> Candidate:</span>
                                <span class="admin-info-val"><asp:Label ID="lblCandidate" runat="server" Text='<%# Eval("FullName") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-envelope"></i> Email:</span>
                                <span class="admin-info-val"><asp:Label ID="lblEmail" runat="server" Text='<%# Eval("StudentEmail") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-calendar-days"></i> Date:</span>
                                <span class="admin-info-val"><asp:Label ID="lblDate" runat="server" Text='<%# Eval("InterviewDate", "{0:dd MMM yyyy}") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-clock"></i> Time:</span>
                                <span class="admin-info-val"><asp:Label ID="lblTime" runat="server" Text='<%# Eval("InterviewTime") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-laptop-code"></i> Type:</span>
                                <span class="admin-info-val"><asp:Label ID="lblType" runat="server" Text='<%# Eval("InterviewType") %>' /></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-circle-info"></i> Status:</span>
                                <span class="admin-info-val"><asp:Label ID="lblStatus" runat="server" Text='<%# GetStatusBadge(Eval("Status")) %>' /></span>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <asp:ImageButton ID="btnPrevious" runat="server" ImageUrl="~/image_button/btn_previous.png" Height="42" OnClick="btnPrevious_Click" CssClass="admin-img-btn" />
            <asp:Label ID="lblPages" runat="server" CssClass="pagination-pages" />
            <asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/image_button/btn_next.png" Height="42" OnClick="btnNext_Click" CssClass="admin-img-btn" />
        </div>
        <CR:CrystalReportViewer ID="CrystalReportViewer6" runat="server" AutoDataBind="true" />
    </div>
</asp:Content>

<%@ Page Title="Applicants" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-applicants.aspx.cs" Inherits="asp.net.company_applicants" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <link rel="stylesheet" href="../css/company-applicants.css?v=209" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header -->
    <div class="page-header-box">
        <div>
            <h1 class="page-header-title">Applicants</h1>
            <p class="page-header-desc">Review, shortlist, select or reject candidate applications.</p>
        </div>
    </div>
    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

    <!-- ===================== SEARCH & FILTER PANEL (ADMIN PANEL STYLE) ===================== -->
    <div class="co-filter-bar">
        <!-- Search Box with Icon inside -->
        <div class="co-search-wrap">
            <i class="fa-solid fa-magnifying-glass search-icon"></i>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by student name, email, or internship..." CssClass="co-search-input" />
        </div>

        <!-- Status Filter with Chevron -->
        <div class="co-select-wrap co-status-wrap">
            <asp:DropDownList ID="ddlStatusFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged" CssClass="co-select">
                <asp:ListItem Text="All Statuses" Value="" />
                <asp:ListItem Text="Applied" Value="Applied" />
                <asp:ListItem Text="Shortlisted" Value="Shortlisted" />
                <asp:ListItem Text="Selected" Value="Selected" />
                <asp:ListItem Text="Rejected" Value="Rejected" />
            </asp:DropDownList>
            <i class="fa-solid fa-chevron-down chevron-icon"></i>
        </div>

        <!-- Action Buttons: Search, Clear & Generate Report -->
        <div class="co-filter-actions">
            <asp:ImageButton ID="btnSearch" runat="server" CausesValidation="false" OnClick="btnSearch_Click" ImageUrl="~/image_button/btn_admin_search.png" Height="40" CssClass="admin-img-btn admin-img-btn-search" />
            <asp:ImageButton ID="btnClearFilters" runat="server" CausesValidation="false" OnClick="btnClearFilters_Click" ImageUrl="~/image_button/btn_admin_clear_filters.png" Height="40" CssClass="admin-img-btn admin-img-btn-clear" />
            <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" CssClass="btn-report" OnClick="btnGenerateReport_Click" CausesValidation="false" />
        </div>
    </div>

    <!-- Applicants Panel & GridView -->
    <div class="co-panel">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-user-group" style="color: #2563eb; margin-right: 8px;"></i> All Applications</h3>
        </div>
        <div style="overflow-x: auto; width: 100%;">
            <asp:GridView ID="gvApplicants" runat="server" AutoGenerateColumns="False" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%" DataKeyNames="ApplicationId" OnRowEditing="gvApplicants_RowEditing" OnRowCancelingEdit="gvApplicants_RowCancelingEdit" OnRowUpdating="gvApplicants_RowUpdating">
                <Columns>
                    <asp:TemplateField HeaderText="Name" HeaderStyle-Width="18%">
                        <ItemTemplate>
                            <div class="co-applicant-cell">
                                <asp:Image ID="imgStudentLogo" runat="server" CssClass="co-applicant-avatar" ImageUrl='<%# Eval("ProfilePhoto") %>' onerror="this.onerror=null;this.src='../student_images/default-avatar.png';" />
                                <asp:Label ID="lblFullName" runat="server" CssClass="applicant-name" Text='<%# Eval("FullName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" HeaderStyle-Width="20%">
                        <ItemTemplate>
                            <asp:Label ID="lblStudentEmail" runat="server" CssClass="applicant-email" Text='<%# Eval("StudentEmail") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Internship Title" HeaderStyle-Width="20%">
                        <ItemTemplate>
                            <asp:Label ID="lblInternshipTitle" runat="server" CssClass="internship-title-text" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date" HeaderStyle-Width="12%">
                        <ItemTemplate>
                            <asp:Label ID="lblAppliedDate" runat="server"
                                CssClass="applied-date-text"
                                Text='<%# Convert.ToDateTime(Eval("AppliedDate")).ToString("dd MMM yyyy") %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" HeaderStyle-Width="12%">
                        <ItemTemplate>
                            <%# GetStatusBadge(Eval("Status")) %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlChangeStatus" runat="server" CssClass="table-status-select">
                                <asp:ListItem Value="Applied">Applied</asp:ListItem>
                                <asp:ListItem Value="Shortlisted">Shortlisted</asp:ListItem>
                                <asp:ListItem Value="Selected">Selected</asp:ListItem>
                                <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:CommandField HeaderText="Modify Status" ShowEditButton="True" ButtonType="Link" EditText="&lt;i class='fa-solid fa-pen-to-square'&gt;&lt;/i&gt; Edit" UpdateText="&lt;i class='fa-solid fa-check'&gt;&lt;/i&gt; Update" CancelText="&lt;i class='fa-solid fa-xmark'&gt;&lt;/i&gt; Cancel" ControlStyle-CssClass="action-link edit-btn" HeaderStyle-Width="12%" />
                    <asp:TemplateField HeaderText="Action" HeaderStyle-Width="6%" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlViewStudent" runat="server"
                                           NavigateUrl='<%# "~/CompanyPanel/company-student-details.aspx?id=" + Eval("StudentId") + "&appId=" + Eval("ApplicationId") %>'
                                           CssClass="btn-view-applicant">
                                <i class="fa-solid fa-eye"></i> View
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoApplicants" runat="server" Visible="false">
                <div class="empty-applicants-box">
                    <i class="fa-solid fa-users-slash empty-applicants-icon"></i>
                    <h3 class="empty-applicants-title">No Applications Found</h3>
                    <p class="empty-applicants-desc">Students applying to your posted internships will appear here.</p>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>

    <!-- Pagination -->
    <div class="pagination">
        <asp:ImageButton ID="btnPrevious" runat="server" ImageUrl="~/image_button/btn_previous.png" Height="42" OnClick="btnPrevious_Click" CssClass="admin-img-btn" />
        <asp:Label ID="lblPages" runat="server" CssClass="pagination-pages" />
        <asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/image_button/btn_next.png" Height="42" OnClick="btnNext_Click" CssClass="admin-img-btn" />
    </div>

    <!-- Page Specific Script -->
    <script src="../js/company-applicants.js"></script>
</asp:Content>

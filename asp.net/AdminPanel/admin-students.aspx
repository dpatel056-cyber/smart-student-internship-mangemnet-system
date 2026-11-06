<%@ Page Title="Students" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-students.aspx.cs" Inherits="asp.net.admin_students" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-students.css?v=205" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sims-student-main-container">
        <!-- Header -->
        <div class="stu-page-header">
            <h1 class="stu-page-title">Student Management</h1>
            <p class="stu-page-subtitle">Manage, search, monitor and block/unblock registered students.</p>
        </div>

        <!-- Search & Filter Card -->
        <div class="stu-filter-card">
            <div class="stu-search-wrapper">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="stu-input" placeholder="Search by name, email, ID, enrollment, phone, college..." />
            </div>

            <div class="stu-select-wrapper">
                <asp:DropDownList ID="ddlCourse" runat="server" CssClass="stu-select" AutoPostBack="true" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
                    <asp:ListItem Text="All Courses" Value="" />
                    <asp:ListItem Text="B.Tech" Value="B.Tech" />
                    <asp:ListItem Text="BCA" Value="BCA" />
                    <asp:ListItem Text="MCA" Value="MCA" />
                    <asp:ListItem Text="M.Tech" Value="M.Tech" />
                    <asp:ListItem Text="B.Sc IT" Value="B.Sc IT" />
                    <asp:ListItem Text="M.Sc IT" Value="M.Sc IT" />
                    <asp:ListItem Text="B.Sc CS" Value="B.Sc CS" />
                    <asp:ListItem Text="M.Sc CS" Value="M.Sc CS" />
                    <asp:ListItem Text="Diploma Engineering" Value="Diploma Engineering" />
                    <asp:ListItem Text="MBA" Value="MBA" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>

            <div class="stu-select-wrapper">
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="stu-select" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">
                    <asp:ListItem Text="All Status" Value="" />
                    <asp:ListItem Text="Active" Value="Active" />
                    <asp:ListItem Text="Blocked" Value="Blocked" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>

            <div class="stu-action-buttons">
                <asp:ImageButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" ImageUrl="~/image_button/btn_admin_search.png" Height="40" CssClass="admin-img-btn admin-img-btn-search" />
                <asp:ImageButton ID="btnClearFilters" runat="server" OnClick="btnClearFilters_Click" ImageUrl="~/image_button/btn_admin_clear_filters.png" Height="40" CssClass="admin-img-btn admin-img-btn-clear" />
                <asp:ImageButton ID="btnGenerateReport" runat="server" OnClick="btnGenerateReport_Click" ImageUrl="~/image_button/btn_admin_generate_report.png?v=2" Height="40" CssClass="admin-img-btn admin-img-btn-report" CausesValidation="false" />
            </div>
        </div>

        <!-- Students Table Card -->
        <div class="stu-table-card">
            <div class="stu-table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="stu-data-table" UseAccessibleHeader="true" GridLines="None" Width="100%" ShowHeaderWhenEmpty="true" OnRowCommand="GridView1_RowCommand">
                    <HeaderStyle CssClass="stu-table-header" />
                    <RowStyle CssClass="stu-table-row" />
                    <AlternatingRowStyle CssClass="stu-table-row-alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="Student ID">
                            <ItemTemplate>
                                <asp:Label ID="lblStudentId" runat="server" Text='<%# Eval("StudentId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Full Name">
                            <ItemTemplate>
                                <asp:Label ID="lblFullName" runat="server" Text='<%# Eval("FullName") %>' Font-Bold="true"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Course">
                            <ItemTemplate>
                                <asp:Label ID="lblCourse" runat="server" Text='<%# Eval("Course") %>' Font-Bold="true"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="College">
                            <ItemTemplate>
                                <asp:Label ID="lblCollege" runat="server" Text='<%# Eval("College") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='<%# Convert.ToBoolean(Eval("IsBlocked")) ? "status-badge-blocked" : "status-badge-active" %>'>
                                    <%# Convert.ToBoolean(Eval("IsBlocked")) ? "Blocked" : "Active" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <div class="stu-actions">
                                    <asp:ImageButton ID="btnViewStudent" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("StudentId") %>'
                                        ImageUrl="~/image_button/btn_admin_view.png" CssClass="admin-img-btn admin-img-btn-view"
                                        CausesValidation="false" Height="30" />

                                    <asp:ImageButton ID="btnBlockStudent" runat="server" CommandName="cmd_toggle_block" CommandArgument='<%# Eval("StudentId") %>' ImageUrl='<%# Eval("IsBlocked").ToString() == "True" ? "~/image_button/btn_admin_unblock.png" : "~/image_button/btn_admin_block.png" %>' CausesValidation="false" Height="30" CssClass="admin-img-btn" />

                                    <asp:ImageButton ID="btnDeleteStudent" runat="server" CommandName="cmd_del" CommandArgument='<%# Eval("StudentId") %>'
                                        ImageUrl="~/image_button/btn_admin_delete.png" CssClass="admin-img-btn admin-img-btn-delete"
                                        CausesValidation="false" Height="30" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <EmptyDataTemplate>
                        <div class="empty-students-box">
                            <i class="fa-solid fa-user-slash"></i>
                            <h3>No students found</h3>
                            <p>There are currently no registered students.</p>
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
        <CR:CrystalReportViewer ID="CrystalReportViewer2" runat="server" AutoDataBind="true" />
    </div>
</asp:Content>

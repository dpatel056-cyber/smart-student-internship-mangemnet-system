<%@ Page Title="Certificates" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-certificates.aspx.cs" Inherits="asp.net.css.admin_certificates" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-certificates.css?v=205" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cert-page-container">
        <!-- Page Header -->
        <div class="cert-page-header">
            <div>
                <h1 class="cert-page-title">
                    <i class="fa-solid fa-award cert-header-icon"></i>
                    Certificate Management
                </h1>
                <p class="cert-page-desc">View, search, filter and manage student internship completion certificates.</p>
            </div>
        </div>
        <!-- Search & Filter Bar -->
        <div class="cert-search-filter">
            <div class="cert-search-box">
                <i class="fa-solid fa-magnifying-glass search-prefix-icon"></i>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="cert-search-input" placeholder="Quick search certificates by student, certificate no, company, internship..." />
            </div>
            <div class="cert-search-actions">
                <asp:ImageButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" ImageUrl="~/image_button/btn_admin_search.png" Height="40" CssClass="admin-img-btn admin-img-btn-search" />
                <asp:ImageButton ID="btnClearFilters" runat="server" OnClick="btnClearFilters_Click" ImageUrl="~/image_button/btn_admin_clear_filters.png" Height="40" CssClass="admin-img-btn admin-img-btn-clear" />
                <asp:ImageButton ID="btnGenerateReport" runat="server" OnClick="btnGenerateReport_Click" ImageUrl="~/image_button/btn_admin_generate_report.png?v=2" Height="40" CssClass="admin-img-btn admin-img-btn-report" CausesValidation="false" />
            </div>
        </div>
        <!-- Certificates Table Card -->
        <div class="cert-table-card">
            <div class="cert-table-wrap">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="cert-table" UseAccessibleHeader="true" GridLines="None" Width="100%" ShowHeaderWhenEmpty="true" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Certificate No">
                            <ItemTemplate>
                                <asp:Label ID="lblCertNo" runat="server" Text='<%# Eval("CertificateNo") %>' CssClass="cert-no-label"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Student Name">
                            <ItemTemplate>
                                <div class="cert-student-name-wrapper">
                                    <asp:Label ID="lblFullName" runat="server" Text='<%# Eval("FullName") %>'></asp:Label>
                                </div>
                                <div class="cert-student-email-wrapper">
                                    <asp:Label ID="lblStudentEmail" runat="server" Text='<%# Eval("StudentEmail") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Certificate Title">
                            <ItemTemplate>
                                <asp:Label ID="lblCertTitle" runat="server" Text='<%# Eval("CertificateTitle") %>' CssClass="cert-title-label"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Company">
                            <ItemTemplate>
                                <span class="cert-company-label">
                                    <i class="fa-solid fa-building"></i>
                                    <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Internship">
                            <ItemTemplate>
                                <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>' CssClass="cert-internship-label"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Issue Date">
                            <ItemTemplate>
                                <asp:Label ID="lblIssueDate" runat="server" Text='<%# Eval("IssueDate", "{0:dd MMM yyyy}") %>' CssClass="cert-date-label"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Actions" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <div class="cert-actions-wrap">
                                    <asp:ImageButton ID="btnViewDetails" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("CertificateId") %>' ImageUrl="~/image_button/btn_admin_view.png" CausesValidation="false" Height="30" CssClass="admin-img-btn admin-img-btn-view" />
                                    <asp:ImageButton ID="btnDelete" runat="server" CommandName="cmd_delete" CommandArgument='<%# Eval("CertificateId") %>' ImageUrl="~/image_button/btn_admin_delete.png" CausesValidation="false" Height="30" CssClass="admin-img-btn admin-img-btn-delete" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="cert-empty-state">
                            <i class="fa-solid fa-certificate"></i>
                            <h3>No Certificates Found</h3>
                            <p>No student internship certificates have been issued yet.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
        <!-- Pagination -->
        <div class="pagination">
            <asp:ImageButton ID="btnPrevious" runat="server" ImageUrl="~/assets/btn_previous.png" Height="42" OnClick="btnPrevious_Click" CssClass="admin-img-btn" />
            <asp:Label ID="lblPages" runat="server" CssClass="pagination-pages" />
            <asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/assets/btn_next.png" Height="42" OnClick="btnNext_Click" CssClass="admin-img-btn" />
        </div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
    </div>
</asp:Content>

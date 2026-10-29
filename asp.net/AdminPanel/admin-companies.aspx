<%@ Page Title="Companies" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-companies.aspx.cs" Inherits="asp.net.admin_companies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-companies.css?v=205" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sims-company-main-container">
        <!-- 1. TOP HEADER -->
        <div class="cmp-page-header">
            <div class="cmp-page-header-left">
                <h1 class="cmp-page-title">Companies</h1>
                <p class="cmp-page-subtitle">Manage, monitor and block/unblock registered companies.</p>
            </div>
        </div>
        <!-- 2. SEARCH AND FILTER SECTION -->
        <div class="cmp-filter-card">
            <!-- Search Input -->
            <div class="cmp-search-box">
                <i class="fa-solid fa-magnifying-glass"></i>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="cmp-input-search" placeholder="Search company name, email, contact..."></asp:TextBox>
            </div>
            <!-- Industry Filter Dropdown -->
            <div class="cmp-select-box">
                <asp:DropDownList ID="ddlIndustry" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlIndustry_SelectedIndexChanged" CssClass="cmp-select">
                    <asp:ListItem Text="All Industries" Value="" />
                    <asp:ListItem Text="Artificial Intelligence &amp; Data" Value="Artificial Intelligence &amp; Data" />
                    <asp:ListItem Text="Cloud Infrastructure" Value="Cloud Infrastructure" />
                    <asp:ListItem Text="Cyber Security" Value="Cyber Security" />
                    <asp:ListItem Text="Information Technology" Value="Information Technology" />
                    <asp:ListItem Text="Product Development" Value="Product Development" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down"></i>
            </div>
            <!-- Location Filter Dropdown -->
            <div class="cmp-select-box">
                <asp:DropDownList ID="ddlLocation" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged" CssClass="cmp-select">
                    <asp:ListItem Text="All Locations" Value="" />
                    <asp:ListItem Text="Ahmedabad" Value="Ahmedabad" />
                    <asp:ListItem Text="Bangalore" Value="Bangalore" />
                    <asp:ListItem Text="Gandhinagar" Value="Gandhinagar" />
                    <asp:ListItem Text="Hyderabad" Value="Hyderabad" />
                    <asp:ListItem Text="Pune" Value="Pune" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down"></i>
            </div>
            <!-- Status Filter Dropdown -->
            <div class="cmp-select-box">
                <asp:DropDownList ID="ddlStatus" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" CssClass="cmp-select">
                    <asp:ListItem Text="All Status" Value="" />
                    <asp:ListItem Text="Active" Value="Active" />
                    <asp:ListItem Text="Blocked" Value="Blocked" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down"></i>
            </div>
            <!-- Action Buttons: Search & Clear -->
            <div class="cmp-filter-actions">
                <asp:ImageButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" ImageUrl="~/image_button/btn_admin_search.png" Height="40" CssClass="admin-img-btn admin-img-btn-search" />
                <asp:ImageButton ID="btnClearFilters" runat="server" OnClick="btnClearFilters_Click" ImageUrl="~/image_button/btn_admin_clear_filters.png" Height="40" CssClass="admin-img-btn admin-img-btn-clear" />
                <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" CssClass="btn-report" OnClick="btnGenerateReport_Click" CausesValidation="false" style="background: linear-gradient(135deg, #0155e3 0%, #1e40af 100%) !important; color: #ffffff !important; height: 40px !important; padding: 0 16px !important; border: none !important; border-radius: 8px !important; font-weight: 600 !important; font-size: 13px !important; cursor: pointer !important; white-space: nowrap !important; display: inline-flex !important; align-items: center !important; justify-content: center !important; box-shadow: 0 2px 6px rgba(1, 85, 227, 0.28) !important; flex-shrink: 0 !important; outline: none !important; text-decoration: none !important; line-height: 40px !important;" />
            </div>
        </div>
        <!-- 3. MAIN COMPANIES TABLE CARD -->
        <div class="cmp-table-card">
            <div class="cmp-table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="cmp-data-table" UseAccessibleHeader="true" GridLines="None" Width="100%" ShowHeaderWhenEmpty="true" OnRowCommand="GridView1_RowCommand">
                    <HeaderStyle CssClass="cmp-table-header" />
                    <RowStyle CssClass="cmp-table-row" />
                    <AlternatingRowStyle CssClass="cmp-table-row-alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="ID" HeaderStyle-CssClass="col-id" ItemStyle-CssClass="col-id">
                            <ItemTemplate>
                                <asp:Label ID="lblCompanyId" runat="server" Text='<%# Eval("CompanyId") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="COMPANY NAME" HeaderStyle-CssClass="col-name" ItemStyle-CssClass="col-name">
                            <ItemTemplate>
                                <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>' CssClass="cmp-company-name"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="EMAIL" HeaderStyle-CssClass="col-email" ItemStyle-CssClass="col-email">
                            <ItemTemplate>
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("c_email") %>' CssClass="cmp-email-text"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="INDUSTRY" HeaderStyle-CssClass="col-industry" ItemStyle-CssClass="col-industry">
                            <ItemTemplate>
                                <asp:Label ID="lblIndustry" runat="server" Text='<%# Eval("c_industry") %>' CssClass="cmp-industry-text"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="LOCATION" HeaderStyle-CssClass="col-location" ItemStyle-CssClass="col-location">
                            <ItemTemplate>
                                <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("c_location") %>' CssClass="cmp-location-text"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="STATUS" HeaderStyle-CssClass="col-status" ItemStyle-CssClass="col-status">
                            <ItemTemplate>
                                <span class='<%# (bool)Eval("IsBlocked") ? "status-badge-blocked" : "status-badge-active" %>'>
                                    <i class='<%# (bool)Eval("IsBlocked") ? "fa-solid fa-ban" : "fa-solid fa-circle-check" %>'></i>
                                    <%# (bool)Eval("IsBlocked") ? "Blocked" : "Active" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ACTIONS" HeaderStyle-CssClass="col-actions" ItemStyle-CssClass="col-actions">
                            <ItemTemplate>
                                <div class="cmp-actions-wrap">
                                    <asp:ImageButton ID="btnView" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("CompanyId") %>' ImageUrl="~/image_button/btn_admin_view.png" CausesValidation="false" Height="25" CssClass="admin-img-btn admin-img-btn-view" />

                                    <asp:ImageButton ID="btnBlockCompany" runat="server"
                                        CommandName="cmd_toggle_block"
                                        CommandArgument='<%# Eval("CompanyId") %>'
                                        ImageUrl='<%# Convert.ToBoolean(Eval("IsBlocked")) ? "~/image_button/btn_admin_unblock.png" : "~/image_button/btn_admin_block.png" %>'

                                        CausesValidation="false"
                                        Height="25"
                                        CssClass="admin-img-btn" />

                                    <asp:ImageButton ID="btnDelete" runat="server" CommandName="cmd_del" CommandArgument='<%# Eval("CompanyId") %>' ImageUrl="~/image_button/btn_admin_delete.png" CausesValidation="false" Height="25" CssClass="admin-img-btn admin-img-btn-delete" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <EmptyDataTemplate>
                        <div class="empty-companies-box">
                            <div class="empty-companies-icon">
                                <i class="fa-solid fa-building-circle-xmark"></i>
                            </div>
                            <h3 class="empty-companies-title">No Companies Found</h3>
                            <p class="empty-companies-desc">There are no registered companies at the moment.</p>
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

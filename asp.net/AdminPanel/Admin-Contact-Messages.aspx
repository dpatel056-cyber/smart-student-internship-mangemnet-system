<%@ Page Title="Contact Messages" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-contact-messages.aspx.cs" Inherits="asp.net.AdminPanel.Admin_Contact_Messages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-contact-messages.css?v=25" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cm-container">
        <!-- Page Header -->
        <div class="cm-header-section">
            <div class="cm-title-area">
                <h1>Contact Messages</h1>
                <p>Manage enquiries and messages submitted through the contact form.</p>
            </div>
        </div>

        <!-- Content Card -->
        <div class="cm-content-card">
            <!-- Search Bar -->
            <div class="cm-filters-bar">
                <div class="cm-search-wrapper">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="cm-search-input" placeholder="Search by student name, email or subject..."></asp:TextBox>
                </div>
                <div class="cm-filter-actions">
                    <asp:ImageButton ID="btnSearch" runat="server" CausesValidation="false" OnClick="btnSearch_Click" ImageUrl="~/image_button/btn_admin_search.png" Height="40" CssClass="admin-img-btn admin-img-btn-search" />
                    <asp:ImageButton ID="btnClearFilters" runat="server" CausesValidation="false" OnClick="btnClearFilters_Click" ImageUrl="~/image_button/btn_admin_clear_filters.png" Height="40" CssClass="admin-img-btn admin-img-btn-clear" />
                </div>
            </div>

            <!-- Messages Table -->
            <div class="cm-table-container">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" Width="100%" CssClass="cm-table" UseAccessibleHeader="true" GridLines="None" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Student">
                            <ItemTemplate>
                                <asp:Label ID="lblStudent" runat="server" Text='<%# Eval("c_name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("c_email") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Subject">
                            <ItemTemplate>
                                <asp:Label ID="lblSubject" runat="server" Text='<%# Eval("c_subject") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Submitted Date">
                            <ItemTemplate>
                                <asp:Label ID="lblSubmittedDate" runat="server" Text='<%# Eval("c_date", "{0:dd MMM yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Submitted Time">
                            <ItemTemplate>
                                <asp:Label ID="lblSubmittedTime" runat="server" Text='<%# Eval("c_date", "{0:hh:mm tt}") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ACTION">
                            <ItemTemplate>
                                <div class="cm-table-actions">
                                    <asp:ImageButton ID="btnView" runat="server" CommandName="ViewContact" CommandArgument='<%# Eval("Id") %>' ImageUrl="~/image_button/btn_admin_view.png" CausesValidation="false" Height="30" CssClass="admin-img-btn admin-img-btn-view" />
                                    <asp:ImageButton ID="btnDelete" runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("Id") %>' ImageUrl="~/image_button/btn_admin_delete.png" CausesValidation="false" Height="30" CssClass="admin-img-btn admin-img-btn-delete" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <asp:ImageButton ID="btnPrevious" runat="server" ImageUrl="~/image_button/btn_previous.png" Height="42" OnClick="btnPrevious_Click" CssClass="admin-img-btn" />
            <asp:Label ID="lblPages" runat="server" CssClass="pagination-pages" />
            <asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/image_button/btn_next.png" Height="42" OnClick="btnNext_Click" CssClass="admin-img-btn" />
        </div>

        <!-- Drawer Overlay -->
        <div class="cm-drawer-overlay" id="cmDrawerOverlay" onclick="closeDrawer()"></div>
        <!-- Details Drawer -->
        <div class="cm-drawer" id="cmDetailDrawer">
            <asp:HiddenField ID="hfContactId" runat="server" />
            <div class="cm-drawer-header">
                <h2 class="cm-drawer-title">Contact Details</h2>
                <div class="cm-drawer-header-actions">
                    <button type="button" class="cm-drawer-close" onclick="closeDrawer()">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
            </div>
            <div class="cm-drawer-body">
                <div class="cm-detail-grid">
                    <!-- Student -->
                    <div class="cm-detail-item">
                        <span class="cm-detail-label">Student</span>
                        <asp:Label ID="lblDetailName" runat="server" CssClass="cm-detail-value"></asp:Label>
                    </div>
                    <!-- Email -->
                    <div class="cm-detail-item">
                        <span class="cm-detail-label">Email</span>
                        <asp:Label ID="lblDetailEmail" runat="server" CssClass="cm-detail-value"></asp:Label>
                    </div>
                    <!-- Submitted Date -->
                    <div class="cm-detail-item">
                        <span class="cm-detail-label">Submitted Date</span>
                        <asp:Label ID="lblDetailDate" runat="server" CssClass="cm-detail-value"></asp:Label>
                    </div>
                    <!-- Submitted Time -->
                    <div class="cm-detail-item">
                        <span class="cm-detail-label">Submitted Time</span>
                        <asp:Label ID="lblDetailTime" runat="server" CssClass="cm-detail-value"></asp:Label>
                    </div>
                </div>
                <!-- Subject -->
                <div class="cm-subject-section">
                    <span class="cm-detail-label">Subject</span>
                    <asp:Label ID="lblDetailSubject" runat="server" CssClass="cm-subject-value"></asp:Label>
                </div>
                <br />
                <!-- Message -->
                <div class="cm-message-section">
                    <span class="cm-detail-label">Message</span>
                    <div class="cm-message-box">
                        <asp:Label ID="lblDetailMessage" runat="server" CssClass="cm-message-text"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/admin-contact-messages.js"></script>
</asp:Content>

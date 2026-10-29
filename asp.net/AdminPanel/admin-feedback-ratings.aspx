<%@ Page Title="Feedback & Ratings" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-feedback-ratings.aspx.cs" Inherits="asp.net.css.admin_feedback_ratings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-feedback-ratings.css?v=205" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sims-feedback-main-container">
        <!-- Page Header -->
        <div class="fb-page-header">
            <div class="fb-page-header-left">
                <h1 class="fb-page-title">Feedback &amp; Ratings</h1>
                <p class="fb-page-subtitle">Manage user feedback, ratings and reviews across students and companies.</p>
            </div>
        </div>

        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

        <!-- 4 SUMMARY STATS CARDS -->
        <div class="fb-stats-grid">
            <div class="fb-stat-card">
                <div class="fb-stat-icon icon-gold"><i class="fa-solid fa-star"></i></div>
                <div class="fb-stat-body">
                    <span class="fb-stat-label">Average Rating</span>
                    <h3 class="fb-stat-number"><asp:Label ID="lblAvgRating" runat="server"></asp:Label></h3>
                </div>
            </div>

            <div class="fb-stat-card">
                <div class="fb-stat-icon icon-blue"><i class="fa-solid fa-comments"></i></div>
                <div class="fb-stat-body">
                    <span class="fb-stat-label">Total Feedback</span>
                    <h3 class="fb-stat-number"><asp:Label ID="lblTotalFeedback" runat="server"></asp:Label></h3>
                </div>
            </div>

            <div class="fb-stat-card">
                <div class="fb-stat-icon icon-purple"><i class="fa-solid fa-user-graduate"></i></div>
                <div class="fb-stat-body">
                    <span class="fb-stat-label">Student Feedback</span>
                    <h3 class="fb-stat-number"><asp:Label ID="lblStudentFeedback" runat="server"></asp:Label></h3>
                </div>
            </div>

            <div class="fb-stat-card">
                <div class="fb-stat-icon icon-green"><i class="fa-solid fa-building"></i></div>
                <div class="fb-stat-body">
                    <span class="fb-stat-label">Company Feedback</span>
                    <h3 class="fb-stat-number"><asp:Label ID="lblCompanyFeedback" runat="server"></asp:Label></h3>
                </div>
            </div>
        </div>

        <!-- SEARCH & FILTER BAR -->
        <div class="fb-filter-card">
            <div class="fb-search-wrap">
                <i class="fa-solid fa-magnifying-glass"></i>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="fb-input-search" placeholder="Search feedback by user, email, company, internship or comments..."></asp:TextBox>
            </div>

            <div class="fb-select-wrap">
                <asp:DropDownList ID="ddlFilterType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterType_SelectedIndexChanged" CssClass="fb-select">
                    <asp:ListItem Text="All Feedback Types" Value=""></asp:ListItem>
                    <asp:ListItem Text="Student -> Company Reviews" Value="StudentCompany"></asp:ListItem>
                    <asp:ListItem Text="Student -> General Platform" Value="StudentGeneral"></asp:ListItem>
                    <asp:ListItem Text="Company -> Admin Feedback" Value="CompanyGeneral"></asp:ListItem>
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down"></i>
            </div>

            <div class="fb-filter-actions">
                <asp:ImageButton ID="btnSearch" runat="server" CausesValidation="false" OnClick="btnSearch_Click" ImageUrl="~/image_button/btn_admin_search.png" Height="40" CssClass="admin-img-btn admin-img-btn-search" />
                <asp:ImageButton ID="btnClear" runat="server" CausesValidation="false" OnClick="btnClear_Click" ImageUrl="~/image_button/btn_admin_clear_filters.png" Height="40" CssClass="admin-img-btn admin-img-btn-clear" />
                <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" CssClass="btn-report" OnClick="btnGenerateReport_Click" CausesValidation="false" style="background: linear-gradient(135deg, #0155e3 0%, #1e40af 100%) !important; color: #ffffff !important; height: 40px !important; padding: 0 16px !important; border: none !important; border-radius: 8px !important; font-weight: 600 !important; font-size: 13px !important; cursor: pointer !important; white-space: nowrap !important; display: inline-flex !important; align-items: center !important; justify-content: center !important; box-shadow: 0 2px 6px rgba(1, 85, 227, 0.28) !important; flex-shrink: 0 !important; outline: none !important; text-decoration: none !important; line-height: 40px !important;" />
            </div>
        </div>

        <!-- MAIN FEEDBACK GRID -->
        <div class="fb-table-card">
            <div class="fb-table-responsive">
                <asp:GridView ID="gvFeedback" runat="server" AutoGenerateColumns="False" OnRowCommand="gvFeedback_RowCommand"
                    CssClass="fb-data-table" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%">
                    <HeaderStyle CssClass="fb-table-header" />
                    <RowStyle CssClass="fb-table-row" />
                    <AlternatingRowStyle CssClass="fb-table-row-alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="NAME">
                            <ItemTemplate>
                                <asp:Label ID="lblSenderName" runat="server" Text='<%# Eval("SenderName") %>' CssClass="fb-sender-name"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="EMAIL">
                            <ItemTemplate>
                                <asp:Label ID="lblSenderEmail" runat="server" Text='<%# Eval("SenderEmail") %>' CssClass="fb-sender-email"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ROLE">
                            <ItemTemplate>
                                <%# Eval("SenderType") != null && Eval("SenderType").ToString() == "Company"
                                    ? "<span class='badge-role-co'><i class='fa-solid fa-building'></i> Company</span>"
                                    : "<span class='badge-role-st'><i class='fa-solid fa-user-graduate'></i> Student</span>" %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="RATING">
                            <ItemTemplate>
                                <span class="fb-rating-badge">
                                    <i class="fa-solid fa-star"></i> <%# Eval("Rating") %> / 5
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="SUBMITTED DATE">
                            <ItemTemplate>
                                <span class="fb-date-cell">
                                    <i class="fa-regular fa-calendar"></i>
                                    <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="SUBMITTED TIME">
                            <ItemTemplate>
                                <span class="fb-time-cell">
                                    <i class="fa-regular fa-clock"></i>
                                    <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("hh:mm tt") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ACTIONS">
                            <ItemTemplate>
                                <div class="fb-actions-wrap">
                                    <asp:ImageButton ID="btnView" runat="server" CommandName="ViewFeedback" CommandArgument='<%# Eval("FeedbackId") %>' ImageUrl="~/image_button/btn_admin_view.png" CausesValidation="false" Height="30" CssClass="admin-img-btn admin-img-btn-view" />
                                    <asp:ImageButton ID="btnDelete" runat="server" CommandName="cmd_delete" CommandArgument='<%# Eval("FeedbackId") %>' ImageUrl="~/image_button/btn_admin_delete.png" CausesValidation="false" Height="30" CssClass="admin-img-btn admin-img-btn-delete" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="empty-feedback-box">
                            <i class="fa-solid fa-star-half-stroke empty-feedback-icon"></i>
                            <h3 class="empty-feedback-title">No Feedback Found</h3>
                            <p class="empty-feedback-desc">No user ratings or feedback comments recorded for the selected filter.</p>
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

    <!-- ================= CENTER MODAL DRAWER ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>

    <div class="feedback-drawer" id="feedbackDrawer">
        <div class="drawer-header">
            <h3>Feedback Details</h3>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();">&times;</button>
        </div>

        <div class="drawer-body">
            <!-- Details Grid -->
            <div class="cm-detail-grid">
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SENDER TYPE</span>
                    <span class="cm-detail-value"><asp:Label ID="drSenderLabel" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">FULL NAME</span>
                    <span class="cm-detail-value"><asp:Label ID="drSenderName" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">EMAIL</span>
                    <span class="cm-detail-value"><asp:Label ID="drSenderEmail" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">RATING</span>
                    <span class="cm-detail-value dr-rating-score">
                        <i class="fa-solid fa-star"></i>
                        <asp:Label ID="drRatingScore" runat="server"></asp:Label>
                    </span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SUBMITTED DATE</span>
                    <span class="cm-detail-value"><asp:Label ID="drSubmittedDate" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SUBMITTED TIME</span>
                    <span class="cm-detail-value"><asp:Label ID="drSubmittedTime" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item cm-detail-item-full">
                    <span class="cm-detail-label">CATEGORY &amp; TARGET</span>
                    <span class="cm-detail-value dr-target-value"><asp:Label ID="drTarget" runat="server"></asp:Label></span>
                </div>
            </div>

            <!-- Subject Section -->
            <div class="cm-subject-section">
                <span class="cm-detail-label">SUBJECT</span>
                <span class="cm-subject-value"><asp:Label ID="drSubject" runat="server"></asp:Label></span>
            </div>

            <!-- Message Section -->
            <div class="cm-message-section">
                <span class="cm-detail-label">MESSAGE</span>
                <div class="cm-message-box">
                    <span class="cm-message-text"><asp:Label ID="drMessage" runat="server"></asp:Label></span>
                </div>
            </div>
        </div>
    </div>

    <script src="../js/admin-feedback-ratings.js"></script>
</asp:Content>

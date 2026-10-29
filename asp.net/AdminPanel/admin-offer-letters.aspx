<%@ Page Title="Offer Letters Management" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-offer-letters.aspx.cs" Inherits="asp.net.admin_offer_letters" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-offer-letters.css?v=205" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="offer-page-container">

        <!-- Page Header -->
        <div class="offer-page-header">
            <div>
                <h1 class="offer-page-title">
                    <i class="fa-solid fa-file-signature"></i>
                    Offer Letters Management
                </h1>
                <p class="offer-page-desc">
                    Track, inspect and manage candidate internship offers, stipends, joining schedules, and placement status.
                </p>
            </div>
        </div>

        <!-- Statistics -->
        <div class="stats-datalist">
            <div class="stat-card stat-card-total">
                <div class="stat-icon-wrap">
                    <i class="fa-solid fa-file-signature"></i>
                </div>
                <div class="stat-content">
                    <span class="stat-label">Total Offer Letters</span>
                    <asp:Label ID="lblTotalOffers" runat="server" CssClass="stat-value" Text="0" />
                </div>
            </div>

            <div class="stat-card stat-card-accepted">
                <div class="stat-icon-wrap">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div class="stat-content">
                    <span class="stat-label">Accepted Placements</span>
                    <asp:Label ID="lblAcceptedOffers" runat="server" CssClass="stat-value" Text="0" />
                </div>
            </div>

            <div class="stat-card stat-card-pending">
                <div class="stat-icon-wrap">
                    <i class="fa-solid fa-clock"></i>
                </div>
                <div class="stat-content">
                    <span class="stat-label">Pending Decisions</span>
                    <asp:Label ID="lblPendingOffers" runat="server" CssClass="stat-value" Text="0" />
                </div>
            </div>

            <div class="stat-card stat-card-rejected">
                <div class="stat-icon-wrap">
                    <i class="fa-solid fa-circle-xmark"></i>
                </div>
                <div class="stat-content">
                    <span class="stat-label">Rejected / Declined</span>
                    <asp:Label ID="lblRejectedOffers" runat="server" CssClass="stat-value" Text="0" />
                </div>
            </div>
        </div>

        <!-- Search & Filter -->
        <div class="offer-filter-bar">

            <div class="offer-search-wrap">
                <i class="fa-solid fa-magnifying-glass search-icon-prefix"></i>

                <asp:TextBox ID="txtSearch" runat="server"
                    CssClass="offer-search-input"
                    placeholder="Quick search offer letters by student, company, position, stipend, college..." />
            </div>

            <div class="offer-select-wrap">
                <asp:DropDownList ID="ddlStatus" runat="server"
                    CssClass="offer-select-filter"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged">

                    <asp:ListItem Text="All Statuses" Value="All" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Accepted" Value="Accepted"></asp:ListItem>
                    <asp:ListItem Text="Offered / Pending" Value="Offered"></asp:ListItem>
                    <asp:ListItem Text="Rejected / Declined" Value="Rejected"></asp:ListItem>

                </asp:DropDownList>
            </div>

            <div class="offer-filter-actions">
                <asp:ImageButton ID="btnSearch" runat="server"
                    OnClick="btnSearch_Click"
                    ImageUrl="~/image_button/btn_admin_search.png"
                    Height="40"
                    CssClass="admin-img-btn admin-img-btn-search" />

                <asp:ImageButton ID="btnClearFilters" runat="server"
                    OnClick="btnClearFilters_Click"
                    ImageUrl="~/image_button/btn_admin_clear_filters.png"
                    Height="40"
                    CssClass="admin-img-btn admin-img-btn-clear" />

                <asp:Button ID="btnGenerateReport" runat="server" Text="Generate Report" CssClass="btn-report" OnClick="btnGenerateReport_Click" CausesValidation="false" style="background: linear-gradient(135deg, #0155e3 0%, #1e40af 100%) !important; color: #ffffff !important; height: 40px !important; padding: 0 16px !important; border: none !important; border-radius: 8px !important; font-weight: 600 !important; font-size: 13px !important; cursor: pointer !important; white-space: nowrap !important; display: inline-flex !important; align-items: center !important; justify-content: center !important; box-shadow: 0 2px 6px rgba(1, 85, 227, 0.28) !important; flex-shrink: 0 !important; outline: none !important; text-decoration: none !important; line-height: 40px !important;" />
            </div>

        </div>

        <!-- Offer Letters Cards -->
        <asp:DataList ID="DataListOfferLetters" runat="server"
            RepeatLayout="Flow"
            RepeatDirection="Horizontal"
            CssClass="offer-cards-grid"
            OnItemCommand="DataListOfferLetters_ItemCommand">

            <ItemTemplate>

                <div class="offer-box-card">

                    <!-- Date & Status -->
                    <div class="offer-card-top">

                        <div class="offer-date-badge">
                            <span class="day">
                                <asp:Label ID="lblDay" runat="server"
                                    Text='<%# Eval("IssuedDate", "{0:dd}") %>' />
                            </span>

                            <span class="mon">
                                <asp:Label ID="lblMonth" runat="server"
                                    Text='<%# Eval("IssuedDate", "{0:MMM}") %>' />
                            </span>
                        </div>

                        <span class='offer-status-top offer-status-top-<%# Eval("Status").ToString().ToLower() %>'>
                            <asp:Label ID="lblStatusTop" runat="server"
                                Text='<%# Eval("Status").ToString() == "Accepted" ? "Accepted" : Eval("Status").ToString() == "Rejected" ? "Rejected" : "Offered / Pending" %>' />
                        </span>

                    </div>

                    <!-- Company Header & Logo -->
                    <div class="offer-company-header">

                        <div class="offer-company-avatar">
                            <asp:Image ID="imgCompanyLogo" runat="server"
                                CssClass="offer-company-img"
                                ImageUrl='<%# Eval("c_logo") %>' />
                        </div>

                        <div class="offer-company-info">

                            <h3 class="offer-company-name">
                                <asp:Label ID="lblCompany" runat="server"
                                    Text='<%# Eval("c_company") %>' />
                            </h3>

                            <p class="offer-company-loc">
                                <i class="fa-solid fa-location-dot"></i>

                                <asp:Label ID="lblCompanyLoc" runat="server"
                                    Text='<%# Eval("c_location") != DBNull.Value && !string.IsNullOrEmpty(Eval("c_location").ToString()) ? Eval("c_location") : Eval("WorkLocation") != DBNull.Value && !string.IsNullOrEmpty(Eval("WorkLocation").ToString()) ? Eval("WorkLocation") : "Headquarters" %>' />
                            </p>

                        </div>
                    </div>

                    <!-- Offer Title -->
                    <div class="offer-role-badge">
                        <i class="fa-solid fa-briefcase"></i>

                        <asp:Label ID="lblOfferTitle" runat="server"
                            Text='<%# Eval("OfferTitle") %>' />
                    </div>

                    <!-- Candidate & Offer Details -->
                    <div class="offer-card-details">

                        <div class="detail-row">
                            <span class="detail-label">
                                <i class="fa-solid fa-user-graduate icon-student"></i>
                                Candidate:
                            </span>

                            <span class="detail-val">
                                <asp:Label ID="lblCandidate" runat="server"
                                    Text='<%# Eval("FullName") %>' />
                            </span>
                        </div>

                        <div class="detail-row">
                            <span class="detail-label">
                                <i class="fa-solid fa-graduation-cap icon-college"></i>
                                College:
                            </span>

                            <span class="detail-val">
                                <asp:Label ID="lblCollege" runat="server"
                                    Text='<%# Eval("College") %>' />
                            </span>
                        </div>

                        <div class="detail-row">
                            <span class="detail-label">
                                <i class="fa-solid fa-indian-rupee-sign icon-stipend"></i>
                                Stipend:
                            </span>

                            <span class="detail-val">
                                <asp:Label ID="lblStipend" runat="server"
                                    Text='<%# Eval("Stipend") %>' />
                            </span>
                        </div>

                        <div class="detail-row">
                            <span class="detail-label">
                                <i class="fa-regular fa-calendar-check icon-joining"></i>
                                Joining:
                            </span>

                            <span class="detail-val">
                                <asp:Label ID="lblJoining" runat="server"
                                    Text='<%# Eval("JoiningDate", "{0:dd MMM yyyy}") %>' />
                            </span>
                        </div>

                        <div class="detail-row">
                            <span class="detail-label">
                                <i class="fa-regular fa-clock icon-duration"></i>
                                Duration:
                            </span>

                            <span class="detail-val">
                                <asp:Label ID="lblDuration" runat="server"
                                    Text='<%# Eval("Duration") %>' />
                            </span>
                        </div>

                        <div class="detail-row">
                            <span class="detail-label">
                                <i class="fa-solid fa-map-pin icon-location"></i>
                                Location:
                            </span>

                            <span class="detail-val">
                                <asp:Label ID="lblWorkLocation" runat="server"
                                    Text='<%# Eval("WorkLocation") %>' />
                            </span>
                        </div>

                    </div>

                    <!-- Bottom Actions -->
                    <div class="offer-card-actions">

                        <div class="offer-btn-row">

                            <asp:ImageButton ID="btnViewOffer" runat="server"
                                CommandName="cmd_view"
                                CommandArgument='<%# Eval("OfferId") %>'
                                ImageUrl="~/assets/btn_view_print_letter.png"
                                Height="36"
                                CssClass="admin-img-btn" />

                            <asp:ImageButton ID="btnDeleteOffer" runat="server"
                                CommandName="cmd_delete"
                                CommandArgument='<%# Eval("OfferId") %>'
                                ImageUrl="~/image_button/btn_admin_delete.png"
                                Height="36"
                                CssClass="admin-img-btn admin-img-btn-delete" />

                        </div>

                        <div class='offer-status-badge-bottom status-bottom-<%# Eval("Status").ToString().ToLower() %>'>

                            <i class='<%# Eval("Status").ToString() == "Accepted" ? "fa-solid fa-circle-check" : Eval("Status").ToString() == "Rejected" ? "fa-solid fa-circle-xmark" : "fa-solid fa-clock" %>'></i>

                            <asp:Label ID="lblStatusBottom" runat="server"
                                Text='<%# Eval("Status").ToString() == "Accepted" ? "Accepted" : Eval("Status").ToString() == "Rejected" ? "Rejected" : "Offered / Pending" %>' />

                        </div>

                    </div>

                </div>

            </ItemTemplate>

        </asp:DataList>

        <!-- Empty State -->
        <asp:Panel ID="pnlNoData" runat="server"
            Visible="false"
            CssClass="empty-state-box">

            <i class="fa-solid fa-file-circle-xmark"></i>
            <h3>No Offer Letters Found</h3>
            <p>No student internship offer letters match your current filters.</p>

        </asp:Panel>

        <!-- Pagination -->
        <div class="pagination">

            <asp:ImageButton ID="btnPrevious" runat="server"
                ImageUrl="~/image_button/btn_previous.png"
                Height="42"
                OnClick="btnPrevious_Click"
                CssClass="admin-img-btn" />

            <asp:Label ID="lblPages" runat="server"
                CssClass="pagination-pages" />

            <asp:ImageButton ID="btnNext" runat="server"
                ImageUrl="~/image_button/btn_next.png"
                Height="42"
                OnClick="btnNext_Click"
                CssClass="admin-img-btn" />

        </div>

    </div>

</asp:Content>

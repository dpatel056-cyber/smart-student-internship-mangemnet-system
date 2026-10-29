<%@ Page Title="Browse Internships" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-internships.aspx.cs" Inherits="asp.net.student_internships" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-internships.css?v=2" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- ============ INTERNSHIPS BANNER ============ -->
    <section class="internships-banner">
        <div class="internships-dots"></div>
        <div class="container">
            <div class="internships-banner-inner">
                <div class="internships-banner-text">
                    <h1>Find the Perfect Internship<br>
                        <span>Kickstart Your Career Journey</span>
                    </h1>
                    <p>Explore 10,000+ internships from top companies and find the right opportunity that matches your skills and interests.</p>
                </div>
                <div class="internships-banner-media">
                    <div class="page-banner-media banner-shape-internships">
                        <div class="banner-blob"></div>
                        <asp:Image ID="imgInternshipsBanner" runat="server" ImageUrl="~/assets/banner_internships.png" CssClass="banner-image" />
                    </div>
                </div>
            </div>

            <!-- Search & quick filters -->
            <div class="internships-searchbar">
                <div class="companies-search-input">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <asp:TextBox ID="searchInput" runat="server" placeholder="Job title, role or keyword"></asp:TextBox>
                </div>

                <div class="companies-select-wrap">
                    <i class="fa-solid fa-layer-group select-prefix-icon"></i>
                    <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                        <asp:ListItem Text="All Categories" Value="" />
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
                    <i class="fa-solid fa-chevron-down select-caret"></i>
                </div>

                <div class="companies-select-wrap">
                    <i class="fa-solid fa-location-dot select-prefix-icon"></i>
                    <asp:DropDownList ID="ddlLocation" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLocation_SelectedIndexChanged">
                        <asp:ListItem Text="All Locations" Value="" />
                        <asp:ListItem Text="Ahmedabad" Value="Ahmedabad" />
                        <asp:ListItem Text="Bangalore" Value="Bangalore" />
                        <asp:ListItem Text="Gandhinagar" Value="Gandhinagar" />
                        <asp:ListItem Text="Hyderabad" Value="Hyderabad" />
                        <asp:ListItem Text="Pune" Value="Pune" />
                    </asp:DropDownList>
                    <i class="fa-solid fa-chevron-down select-caret"></i>
                </div>

                <div class="companies-select-wrap">
                    <i class="fa-regular fa-clock select-prefix-icon"></i>
                    <asp:DropDownList ID="ddlDuration" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlDuration_SelectedIndexChanged">
                        <asp:ListItem Text="All Durations" Value="" />
                        <asp:ListItem Text="3 Months" Value="3 Months" />
                        <asp:ListItem Text="4 Months" Value="4 Months" />
                        <asp:ListItem Text="5 Months" Value="5 Months" />
                        <asp:ListItem Text="6 Months" Value="6 Months" />
                    </asp:DropDownList>
                    <i class="fa-solid fa-chevron-down select-caret"></i>
                </div>

                <asp:ImageButton ID="ImageButton1" Height="46px" runat="server" ImageUrl="~/assets/internship.png" CssClass="btn-img-action" OnClick="ImageButton1_Click" />
                <asp:ImageButton ID="btnReset" Height="46px" runat="server" ImageUrl="~/assets/btn_reset.png" OnClick="btnReset_Click" CssClass="btn-img-action" />
            </div>
        </div>
    </section>

    <!-- ============ INTERNSHIPS SECTION ============ -->
    <section class="internships-section">
        <div class="container">
            <div class="internships-layout" id="internshipsResultsTop">

                <!-- ============ RESULTS ============ -->
                <div class="internships-results">
                    <div class="internships-results-top">
                        <div class="results-count-wrap">
                            <span class="results-count-icon"><i class="fa-solid fa-briefcase"></i></span>
                            <asp:Label ID="lblTotalInternships" runat="server" CssClass="results-count-text"></asp:Label>
                        </div>
                        <div class="sort-by-wrap">
                            <span>Sort by:</span>
                            <asp:DropDownList ID="ddlSortBy" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged">
                                <asp:ListItem Text="Sort By" Value="select" />
                                <asp:ListItem Text="Stipend: High to Low" Value="stipend-desc" />
                                <asp:ListItem Text="Stipend: Low to High" Value="stipend-asc" />
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="internship-datalist-wrapper">
                        <asp:DataList ID="DataListPublicInternships" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="internship-card-grid" OnItemCommand="DataListPublicInternships_ItemCommand">
                            <ItemTemplate>
                                <div class="internship-card-box" onclick="window.location.href='student-internship-details.aspx?id=<%# Eval("Id") %>';">

                                    <!-- Top Row -->
                                    <div class="card-top-row">
                                        <div class="company-logo-wrap">
                                            <asp:Image ID="imgCompanyLogo" runat="server" ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' CssClass="company-logo-img" />
                                        </div>
                                        <div class="title-company-wrap">
                                            <h3 class="internship-card-title">
                                                <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                                            </h3>
                                            <span class="company-card-name">
                                                <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                            </span>
                                        </div>
                                        <asp:LinkButton ID="btnBookmark" runat="server" CommandName="Bookmark" CommandArgument='<%# Eval("Id") %>' CssClass="bookmark-btn" OnClientClick="event.stopPropagation();">
                                            <i class='<%# IsInternshipSaved(Eval("Id")) ? "fa-solid fa-bookmark bookmarked" : "fa-regular fa-bookmark" %>'></i>
                                        </asp:LinkButton>
                                    </div>

                                    <!-- Details Row -->
                                    <div class="card-details-row">
                                        <span class="detail-item">
                                            <i class="fa-solid fa-location-dot"></i>
                                            <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                        </span>
                                        <span class="detail-item">
                                            <i class="fa-solid fa-building"></i>
                                            <asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label>
                                        </span>
                                    </div>

                                    <!-- Stipend Row -->
                                    <div class="card-stipend-row">
                                        <span class='<%# Eval("PaymentStatus") != null && Eval("PaymentStatus").ToString().ToLower() == "unpaid" ? "badge-unpaid" : "badge-paid" %>'>
                                            <asp:Label ID="lblPaymentStatus" runat="server" Text='<%# Eval("PaymentStatus") %>'></asp:Label>
                                        </span>
                                        <span class="stipend-amount">
                                            <i class="fa-solid fa-indian-rupee-sign"></i> <asp:Label ID="lblStipendAmount" runat="server" Text='<%# Eval("StipendAmount") %>'></asp:Label>
                                        </span>
                                    </div>

                                    <!-- Footer Row -->
                                    <div class="card-footer-row">
                                        <span class="footer-meta">
                                            <i class="fa-regular fa-clock"></i>
                                            <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>'></asp:Label>
                                        </span>
                                        <span class="footer-meta posted-time">
                                            <i class="fa-regular fa-calendar-days"></i> Posted
                                            <asp:Label ID="lblPostedDate" runat="server" Text='<%# Eval("PostedDate") != DBNull.Value ? Convert.ToDateTime(Eval("PostedDate")).ToString("dd-MM-yyyy") : "Recently" %>' />
                                        </span>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                    </div>

                    <!-- Pagination -->
                    <div class="pagination">
                        <asp:ImageButton ID="btnPrevious" runat="server" ImageUrl="~/assets/btn_previous.png" Height="36px" OnClick="btnPrevious_Click" CssClass="btn-img-action" />
                        <asp:Label ID="lblPages" runat="server" CssClass="pagination-pages" />
                        <asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/assets/btn_next.png" Height="36px" OnClick="btnNext_Click" CssClass="btn-img-action" />
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>

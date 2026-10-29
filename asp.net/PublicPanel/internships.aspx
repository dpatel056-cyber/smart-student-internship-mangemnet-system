<%@ Page Title="" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeFile="internships.aspx.cs" Inherits="asp.net.internships" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/internships.css") %>" />
</asp:Content>

<asp:Content ID="Content4" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/internship-module.css">

    <div id="public-header-root"></div>

    <!-- ============ HEADER ============ -->
    <header class="site-header">

        <!-- Top bar -->
        <div class="topbar">
            <div class="container topbar-inner">
                <p class="topbar-tagline">
                    <i class="fa-solid fa-graduation-cap"></i>Empowering Students. Connecting Companies. Building Careers.
                </p>
                <div class="topbar-right">
                    <a href="tel:+918849900762" class="topbar-link"><i class="fa-solid fa-phone"></i>88499 00762</a>
                    <a href="mailto:support@sims.com" class="topbar-link"><i class="fa-solid fa-envelope"></i>support@sims.com</a>
                    <div class="topbar-socials">
                        <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                        <a href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
                        <a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
                        <a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main nav -->
        <div class="navbar">
            <div class="container navbar-inner">
                <a href="index.aspx" class="brand">
                    <span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span>
                    <span class="brand-text">
                        <span class="brand-name">SIMS</span>
                        <span class="brand-sub">Smart Student Internship Management System</span>
                    </span>
                </a>
                <nav class="main-nav" id="mainNav">
                    <ul>
                        <li><a href="index.aspx" data-nav-page="index.aspx">Home</a></li>
                        <li><a href="internships.aspx" class="active" data-nav-page="internships.aspx">Internships</a></li>
                        <li><a href="companies.aspx" data-nav-page="companies.aspx">Companies</a></li>
                        <li><a href="stories.aspx" data-nav-page="stories.aspx">Success Stories</a></li>
                        <li><a href="about.aspx" data-nav-page="about.aspx">About Us</a></li>
                        <li><a href="contact.aspx" data-nav-page="contact.aspx">Contact Us</a></li>
                        <li><a href="faq.aspx" data-nav-page="faq.aspx">FAQ</a></li>
                    </ul>
                </nav>
                <div class="navbar-actions">
                    <asp:ImageButton ID="ImageButton3" runat="server" PostBackUrl="~/PublicPanel/login.aspx" ImageUrl="~/assets/login register.png" Width="150px" />
                </div>
            </div>
        </div>
    </header>
</asp:Content>

<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <main>

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
                            <asp:DataList ID="DataListPublicInternships" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="internship-card-grid">
                                <ItemTemplate>
                                    <div class="internship-card-box" onclick="window.location.href='internship-details.aspx?id=<%# Eval("Id") %>';">

                                        <!-- Top Row -->
                                        <div class="card-top-row">
                                            <div class="company-logo-wrap">
                                                <asp:Image ID="imgCompanyLogo" runat="server" ImageUrl='<%# Eval("c_logo") %>' CssClass="company-logo-img" />
                                            </div>
                                            <div class="title-company-wrap">
                                                <h3 class="internship-card-title">
                                                    <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                                                </h3>
                                                <span class="company-card-name">
                                                    <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                                </span>
                                            </div>
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
                                            <span class="badge-paid">
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
                                                <asp:Label ID="lblPostedDate" runat="server" Text='<%# Convert.ToDateTime(Eval("PostedDate")).ToString("dd-MM-yyyy") %>' />
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

                <!-- ============ STATS BAR ============ -->
                <div class="internships-stats-bar">
                    <div class="stat-item">
                        <span class="stat-icon"><i class="fa-solid fa-briefcase"></i></span>
                        <div>
                            <p class="stat-value">10K+</p>
                            <p class="stat-label">Active Internships</p>
                        </div>
                    </div>
                    <div class="stat-item">
                        <span class="stat-icon"><i class="fa-solid fa-building"></i></span>
                        <div>
                            <p class="stat-value">1K+</p>
                            <p class="stat-label">Top Companies</p>
                        </div>
                    </div>
                    <div class="stat-item">
                        <span class="stat-icon"><i class="fa-solid fa-user-group"></i></span>
                        <div>
                            <p class="stat-value">25K+</p>
                            <p class="stat-label">Students Placed</p>
                        </div>
                    </div>
                    <div class="stat-item">
                        <span class="stat-icon"><i class="fa-solid fa-star"></i></span>
                        <div>
                            <p class="stat-value">95%</p>
                            <p class="stat-label">Satisfaction Rate</p>
                        </div>
                    </div>
                    <div class="internships-help-block">
                        <div>
                            <h5>Need Help?</h5>
                            <p>We're here to help you find the right opportunity.</p>
                        </div>
                        <asp:ImageButton ID="btnContactUs" runat="server" ImageUrl="~/assets/btn_contact_us.png" PostBackUrl="~/PublicPanel/contact.aspx" Height="38px" CssClass="btn-img-action" />
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Toast notification -->
    <div class="login-toast" id="loginToast">
        <i class="fa-solid fa-circle-check"></i>
        <span id="loginToastMsg">Notice</span>
    </div>

    <script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/script.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/internships.js") %>"></script>
</asp:Content>

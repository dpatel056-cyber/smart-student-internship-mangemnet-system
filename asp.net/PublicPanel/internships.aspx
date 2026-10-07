<%@ Page Title="" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeFile="internships.aspx.cs" Inherits="asp.net.internships" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .internship-datalist-wrapper {
            width: 100%;
        }
        .internship-card-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            width: 100%;
        }
        @media (max-width: 1200px) {
            .internship-card-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 640px) {
            .internship-card-grid {
                grid-template-columns: 1fr;
            }
        }
        .internship-card-box {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 24px 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 260px;
        }
        .internship-card-box:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.12);
            border-color: #cbd5e1;
        }
        .card-top-row {
            display: flex;
            align-items: flex-start;
            gap: 14px;
            margin-bottom: 16px;
            position: relative;
            padding-right: 30px;
        }
        .company-logo-wrap {
            width: 54px;
            height: 54px;
            border-radius: 14px;
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
            padding: 6px;
            box-sizing: border-box;
            box-shadow: 0 2px 8px rgba(15, 23, 42, 0.04);
        }
        .company-logo-wrap img,
        .company-logo-wrap .company-logo-img {
            width: 100% !important;
            height: 100% !important;
            max-width: 100% !important;
            max-height: 100% !important;
            object-fit: contain !important;
            border-radius: 8px !important;
            display: block !important;
            margin: 0 !important;
            padding: 0 !important;
        }
        .title-company-wrap {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }
        .internship-card-title {
            font-size: 17px;
            font-weight: 700;
            color: #0f172a;
            line-height: 1.3;
            margin: 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .company-card-name {
            font-size: 14px;
            font-weight: 600;
            color: #2563eb;
        }
        .bookmark-btn {
            position: absolute;
            right: 0;
            top: 0;
            color: #cbd5e1;
            font-size: 18px;
            background: transparent;
            border: none;
            cursor: pointer;
            transition: color 0.2s ease;
        }
        .bookmark-btn:hover {
            color: #2563eb;
        }
        .card-details-row {
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
            margin-bottom: 16px;
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }
        .detail-item {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .detail-item i {
            color: #2563eb;
            font-size: 14px;
        }
        .card-stipend-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }
        .badge-paid {
            background: #dcfce7;
            color: #16a34a;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        .badge-unpaid {
            background: #f1f5f9;
            color: #64748b;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }
        .stipend-amount {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
        }
        .card-footer-row {
            border-top: 1px solid #f1f5f9;
            padding-top: 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }
        .footer-meta {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .footer-meta i {
            color: #94a3b8;
            font-size: 14px;
        }
        .posted-time {
            color: #64748b;
        }
        .empty-state-box {
            background: #ffffff;
            border: 2px dashed #cbd5e1;
            border-radius: 16px;
            padding: 50px 20px;
            text-align: center;
            margin-top: 20px;
            width: 100%;
        }
        .empty-state-icon {
            font-size: 48px;
            color: #94a3b8;
            margin-bottom: 16px;
        }
        .empty-state-box h3 {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 8px 0;
        }
        .empty-state-box p {
            font-size: 14px;
            color: #64748b;
            margin: 0;
        }
        /* Pagination Styling */
        .pg-wrap {
            display: flex !important;
            justify-content: center !important;
            align-items: center !important;
            gap: 10px !important;
            margin-top: 40px !important;
            margin-bottom: 24px !important;
            width: 100% !important;
        }
        .pg-link {
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            min-width: 42px !important;
            height: 42px !important;
            padding: 0 14px !important;
            border-radius: 10px !important;
            border: 1px solid #e2e8f0 !important;
            background: #ffffff !important;
            color: #334155 !important;
            font-size: 14px !important;
            font-weight: 600 !important;
            text-decoration: none !important;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04) !important;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
        }
        .pg-link i {
            color: inherit !important;
        }
        .pg-link:hover:not(.pg-active):not(.pg-disabled) {
            background: #f8fafc !important;
            color: #2563eb !important;
            border-color: #93c5fd !important;
            transform: translateY(-2px) !important;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.12) !important;
            text-decoration: none !important;
        }
        .pg-link.pg-active {
            background: #2563eb !important;
            color: #ffffff !important;
            border-color: #2563eb !important;
            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.3) !important;
            cursor: default !important;
        }
        .pg-link.pg-active i {
            color: #ffffff !important;
        }
        .pg-link.pg-disabled {
            background: #f8fafc !important;
            color: #cbd5e1 !important;
            border-color: #f1f5f9 !important;
            cursor: not-allowed !important;
            box-shadow: none !important;
            pointer-events: none !important;
        }
        .pg-link.pg-disabled i {
            color: #cbd5e1 !important;
        }
        .pg-nav {
            padding: 0 18px !important;
            font-weight: 600 !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content4" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/internship-module.css">
    </head>
    <body>
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
                        <a href="tel:+918849900762" class="topbar-link"><i class="fa-solid fa-phone"></i>88499 00762 </a>
                        <a href="mailto:support@sims.com" class="topbar-link"><i class="fa-solid fa-envelope"></i>support@sims.com </a>
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
<%--                        <a href="login.aspx" class="btn btn-primary">Login / Register</a>--%>
                        <asp:ImageButton ID="ImageButton3" runat="server" PostBackUrl="~/PublicPanel/login.aspx" ImageUrl="~/assets/login register.png" Width="150px" />
                        <button class="hamburger" id="hamburgerBtn" type="button" aria-label="Menu">
                            <i class="fa-solid fa-bars"></i>
                        </button>
                    </div>
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
                            <span>Kickstart Your Career Journey</span></h1>
                        <p>Explore 10,000+ internships from top companies and find the right opportunity that matches your skills and interests.</p>
                    </div>
                    <div class="internships-banner-media">
                        <div class="page-banner-media banner-shape-internships">
                            <div class="banner-blob"></div>
                            <img src="<%= ResolveUrl("~/assets/banner_internships.png") %>" alt="Find internships" class="banner-image">
                        </div>
                    </div>
                </div>
                <!-- Search & quick filters -->
                <div class="internships-searchbar">
                    <div class="companies-search-input" style="flex: 2; min-width: 220px;">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <input type="text" id="topKeywordInput" placeholder="Job title, role or keyword">
                    </div>
                    <div class="companies-select-wrap">
                        <i class="fa-solid fa-layer-group select-prefix-icon"></i>
                        <select id="topCategory">
                            <option value="">All Categories</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-caret"></i>
                    </div>
                    <div class="companies-select-wrap">
                        <i class="fa-solid fa-location-dot select-prefix-icon"></i>
                        <select id="topLocation">
                            <option value="">All Locations</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-caret"></i>
                    </div>
                    <div class="companies-select-wrap">
                        <i class="fa-regular fa-clock select-prefix-icon"></i>
                        <select id="topDuration">
                            <option value="">All Durations</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-caret"></i>
                    </div>
                    <%--<button type="button" class="btn btn-primary btn-search-companies" id="topSearchBtn">
                        <i class="fa-solid fa-magnifying-glass"></i>Search Internships
                    </button>--%>
                    <asp:ImageButton ID="ImageButton1" Height="40" Width="200" runat="server" ImageUrl="~/assets/internship.png" />
                </div>
            </div>
        </section>
        <!-- ============ INTERNSHIPS SECTION ============ -->
        <section class="internships-section">
            <div class="container">
                <div class="internships-layout" id="internshipsResultsTop">
                    <!-- ============ FILTER SIDEBAR ============ -->
                    <aside class="filters-sidebar">
                        <div class="internships-filters-head">
                            <h3><i class="fa-solid fa-sliders"></i>Filter Internships</h3>
                            <button type="button" class="clear-all-btn" id="clearAllBtn">Clear All</button>
                        </div>
                        <div class="filter-block">
                            <label class="block-label">Keywords</label>
                            <input type="text" id="sideKeywordInput" placeholder="Job title, skills, or company">
                        </div>
                        <div class="filter-block">
                            <label class="block-label">Category</label>
                            <select id="sideCategory">
                                <option value="">Select Category</option>
                            </select>
                        </div>
                        <div class="filter-block">
                            <label class="block-label">Location</label>
                            <select id="sideLocation">
                                <option value="">Select Location</option>
                            </select>
                        </div>
                        <div class="filter-block">
                            <label class="block-label">Duration</label>
                            <div class="checkbox-grid" id="durationChecks"></div>
                        </div>
                        <div class="filter-block">
                            <label class="block-label">Stipend</label>
                            <div class="checkbox-grid" id="stipendChecks">
                                <label class="checkbox-item">
                                    <input type="checkbox" data-group="stipend" data-value="paid">
                                    Paid
                                </label>
                                <label class="checkbox-item">
                                    <input type="checkbox" data-group="stipend" data-value="unpaid">
                                    Unpaid
                                </label>
                            </div>
                        </div>
                        <div class="filter-block">
                            <label class="block-label">Mode</label>
                            <div class="checkbox-grid" id="modeChecks"></div>
                        </div>
                        <div class="filter-block">
                            <%--<button type="button" class="btn btn-primary btn-apply-filters" id="applyFiltersBtn">
                                <i class="fa-solid fa-filter"></i>Apply Filters
                            </button>--%>
                            <asp:ImageButton ID="ImageButton2" runat="server" Height="40" Width="220" ImageUrl="~/assets/filter_button.png"  />
                        </div>
                    </aside>
                    <!-- ============ RESULTS ============ -->
                    <div class="internships-results">
                        <div class="internships-results-top">
                            <asp:Label ID="lblResultCount" runat="server" CssClass="results-count">Showing internships...</asp:Label>
                            <div class="sort-by-wrap">
                                <span>Sort by:</span>
                                <select id="sortBySelect">
                                    <option value="newest">Newest First</option>
                                    <option value="stipend-desc">Stipend: High to Low</option>
                                    <option value="stipend-asc">Stipend: Low to High</option>
                                    <option value="duration-asc">Duration: Short to Long</option>
                                </select>
                            </div>
                        </div>
                        <div class="internship-datalist-wrapper">
                                                  <asp:DataList ID="DataListPublicInternships" runat="server"
    RepeatLayout="Flow"
    RepeatDirection="Horizontal"
    CssClass="internship-card-grid">
    <ItemTemplate>
        <div class="internship-card-box"
            onclick="window.location.href='internship-details.aspx?id=<%# Eval("Id") %>';">
            <!-- Top Row -->
            <div class="card-top-row">
                <div class="company-logo-wrap">
                    <asp:Image ID="imgCompanyLogo" runat="server"
                        ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>'
                        CssClass="company-logo-img"
                        AlternateText="Company Logo" />
                </div>
                <div class="title-company-wrap">
                    <h3 class="internship-card-title">
                        <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                    </h3>
                    <span class="company-card-name">
                        <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                    </span>
                </div>
                <button type="button"
                    class="bookmark-btn"
                    onclick="event.stopPropagation();"
                    title="Bookmark">
                    <i class="fa-regular fa-bookmark"></i>
                </button>
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
    <i class="fa-regular fa-calendar-days"></i>
    Posted
    <asp:Label ID="lblPostedDate" runat="server"
        Text='<%# Convert.ToDateTime(Eval("PostedDate")).ToString("dd-MM-yyyy") %>'>
    </asp:Label>
</span>
            </div>
        </div>
    </ItemTemplate>
</asp:DataList>
                        </div>
                        <div class="no-results" id="noResults">
                            <i class="fa-solid fa-briefcase"></i>
                            <p>No internships match your filters. Try adjusting your search or filters.</p>
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
                        <a href="contact.aspx" class="btn-contact-us-small">
                            <i class="fa-regular fa-comment-dots"></i>Contact Us
                        </a>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <div id="public-footer-root"></div>
    <!-- Toast notification -->
    <div class="login-toast" id="loginToast">
        <i class="fa-solid fa-circle-check"></i>
        <span id="loginToastMsg">Notice</span>
    </div>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/internship-module.css") %>">
    <script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/script.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/companies-data.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/internships-data.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/internships.js") %>"></script>
</asp:Content>

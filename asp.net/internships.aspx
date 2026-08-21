<%@ Page Title="" Language="C#" MasterPageFile="~/public.Master" AutoEventWireup="true" CodeBehind="internships.aspx.cs" Inherits="asp.net.internships" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                        <button class="icon-btn" id="searchBtn" type="button" aria-label="Search">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                        <button class="icon-btn" id="notifBtn" type="button" aria-label="Notifications">
                            <i class="fa-regular fa-bell"></i><span class="badge">1</span>
                        </button>
<%--                        <a href="login.aspx" class="btn btn-primary">Login / Register</a>--%>
                        <asp:ImageButton ID="ImageButton3" runat="server" PostBackUrl="~/login.aspx" ImageUrl="~/login register.png" Width="150px" />

                        <button class="hamburger" id="hamburgerBtn" type="button" aria-label="Menu">
                            <i class="fa-solid fa-bars"></i>
                        </button>
                    </div>
                </div>

                <!-- Expandable search bar -->
                <div class="search-panel" id="searchPanel">
                    <div class="container search-panel-inner">
                        <i class="fa-solid fa-magnifying-glass"></i>
                        <asp:TextBox ID="searchInput" ClientIDMode="Static" runat="server" placeholder="Search internships, companies, students..."></asp:TextBox>
                        <button class="search-close" id="searchClose" type="button" aria-label="Close search">
                            <i class="fa-solid fa-xmark"></i>
                        </button>
                    </div>
                </div>

                <!-- Notification dropdown -->
                <div class="notif-panel" id="notifPanel">
                    <div class="notif-header">
                        <h4>Notifications</h4>
                        <span class="notif-count">1 New</span>
                    </div>
                    <ul class="notif-list">
                        <li class="notif-item unread">
                            <span class="notif-icon"><i class="fa-solid fa-briefcase"></i></span>
                            <div>
                                <p>Your internship application at <strong>TechNova Pvt Ltd</strong> was shortlisted.</p>
                                <span class="notif-time">2 hours ago</span>
                            </div>
                        </li>
                        <li class="notif-item">
                            <span class="notif-icon"><i class="fa-solid fa-certificate"></i></span>
                            <div>
                                <p>Your completion certificate is ready to download.</p>
                                <span class="notif-time">Yesterday</span>
                            </div>
                        </li>
                        <li class="notif-item">
                            <span class="notif-icon"><i class="fa-solid fa-building"></i></span>
                            <div>
                                <p>New internship posted by <strong>Bright Solutions</strong>.</p>
                                <span class="notif-time">2 days ago</span>
                            </div>
                        </li>
                    </ul>
                    <a href="#" class="notif-viewall">View All Notifications</a>
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
                        <div class="page-banner-media about-banner-media">
                            <div class="banner-blob"></div>
                            <img src="../assets/hero-student.png" alt="Find internships" class="banner-image">
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
                    <asp:ImageButton ID="ImageButton1" Height="40" Width="200" runat="server" ImageUrl="~/internship.png" />
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
                            <asp:ImageButton ID="ImageButton2" runat="server" Height="40" Width="220" ImageUrl="~/filter_button.png"  />
                        </div>
                    </aside>

                    <!-- ============ RESULTS ============ -->
                    <div class="internships-results">
                        <div class="internships-results-top">
                            <p class="results-count" id="resultCount">Showing internships...</p>
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

                        <div class="internships-grid" id="internshipsGrid"></div>

                        <div class="no-results" id="noResults">
                            <i class="fa-solid fa-briefcase"></i>
                            <p>No internships match your filters. Try adjusting your search or filters.</p>
                        </div>

                        <div class="pagination" id="pagination"></div>
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



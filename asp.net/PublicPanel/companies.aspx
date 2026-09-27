<%@ Page Title="Companies" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeFile="companies.aspx.cs" Inherits="asp.net.companies" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder1">
                <!-- ============ HEADER ============ -->
                <header class="site-header">

                    <!-- Top bar -->
                    <div class="topbar">
                        <div class="container topbar-inner">
                            <p class="topbar-tagline">
                                <i class="fa-solid fa-graduation-cap"></i>Empowering Students. Connecting Companies. Building Careers.
                            </p>
                            <div class="topbar-right">
                                <a href="tel:+918849900762" class="topbar-link"><i class="fa-solid fa-phone"></i>88499 00762 </a><a href="mailto:support@sims.com" class="topbar-link"><i class="fa-solid fa-envelope"></i>support@sims.com </a>
                                <div class="topbar-socials">
                                    <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a><a href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a><a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a><a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Main nav -->
                    <div class="navbar">
                        <div class="container navbar-inner">
                            <a href="index.aspx" class="brand"><span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span><span class="brand-text"><span class="brand-name">SIMS</span> <span class="brand-sub">Smart Student Internship Management System</span> </span></a>
                            <nav class="main-nav" id="mainNav">
                                <ul>
                                    <li><a href="index.aspx"  data-nav-page="index.aspx">Home</a></li>
                                    <li><a href="internships.aspx" data-nav-page="internships.aspx">Internships</a></li>
                                    <li><a href="companies.aspx" class="active" data-nav-page="companies.aspx">Companies</a></li>
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
<%--                                <a href="login.aspx" class="btn btn-primary">Login / Register</a>--%>
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/assets/login register.png" PostBackUrl="~/login.aspx" Width="150px" />                              
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
                                <li class="notif-item unread"><span class="notif-icon"><i class="fa-solid fa-briefcase"></i></span>
                                    <div>
                                        <p>
                                            Your internship application at <strong>TechNova Pvt Ltd</strong> was shortlisted.</p>
                                        <span class="notif-time">2 hours ago</span>
                                    </div>
                                </li>
                                <li class="notif-item"><span class="notif-icon"><i class="fa-solid fa-certificate"></i></span>
                                    <div>
                                        <p>
                                            Your completion certificate is ready to download.</p>
                                        <span class="notif-time">Yesterday</span>
                                    </div>
                                </li>
                                <li class="notif-item"><span class="notif-icon"><i class="fa-solid fa-building"></i></span>
                                    <div>
                                        <p>
                                            New internship posted by <strong>Bright Solutions</strong>.</p>
                                        <span class="notif-time">2 days ago</span>
                                    </div>
                                </li>
                            </ul>
                            <a href="#" class="notif-viewall">View All Notifications</a>
                        </div>
                    </div>
    </header>
</asp:Content>

<asp:Content ID="Content4" runat="server" contentplaceholderid="ContentPlaceHolder2">
                <main>

  <!-- ============ COMPANIES BANNER ============ -->
  <section class="companies-banner">
    <div class="companies-dots"></div>


    <div class="container companies-banner-inner">
      <div class="companies-banner-text">
        <h1>Companies</h1>
        <p class="about-desc">
          Explore top companies offering amazing internship opportunities.<br>
          Find the right company to kickstart your career.
        </p>
      </div>

      <div class="companies-banner-media">
        <div class="page-banner-media about-banner-media">
          <div class="banner-blob"></div>
          <img src="../assets/hero-student.png" alt="Explore companies" class="banner-image">
        </div>
      </div>
    </div>
  </section>

  <!-- ============ COMPANIES SECTION ============ -->
  <section class="companies-section">
    <div class="container">

      <!-- Search & quick filters -->
      <div class="companies-searchbar">
        <div class="companies-search-input">
          <i class="fa-solid fa-magnifying-glass"></i>
          <input type="text" id="companySearchInput" placeholder="Search companies by name, industry...">
        </div>

        <div class="companies-select-wrap">
          <i class="fa-solid fa-industry select-prefix-icon"></i>
          <select id="topIndustry">
            <option value="">All Industries</option>
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
          <i class="fa-solid fa-users select-prefix-icon"></i>
          <select id="topSize">
            <option value="">Company Size</option>
          </select>
          <i class="fa-solid fa-chevron-down select-caret"></i>
        </div>

       <%-- <button type="button" class="btn btn-primary btn-search-companies" id="companySearchBtn">
          <i class="fa-solid fa-magnifying-glass"></i> Search Companies
        </button>--%>
          <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/assets/search companies.png" Width="200px" />
      </div>

      <div class="companies-layout" id="companiesResultsTop">

        <!-- ============ FILTER SIDEBAR ============ -->
        <aside class="filters-sidebar">
          <div class="filters-sidebar-head">
            <h3><i class="fa-solid fa-sliders"></i> Filter Companies</h3>
            <button type="button" class="reset-filters-btn" id="resetFiltersBtn">Reset</button>
          </div>

          <div class="filter-section" id="industrySection">
            <div class="filter-accordion-head">
              <span>Industry</span>
              <i class="fa-solid fa-chevron-down"></i>
            </div>
            <div class="filter-check-list" id="industryList"></div>
          </div>

          <div class="filter-section collapsed">
            <div class="filter-accordion-head">
              <span>Location</span>
              <i class="fa-solid fa-chevron-down"></i>
            </div>
            <div class="filter-check-list" id="locationList"></div>
          </div>

          <div class="filter-section collapsed">
            <div class="filter-accordion-head">
              <span>Company Size</span>
              <i class="fa-solid fa-chevron-down"></i>
            </div>
            <div class="filter-check-list" id="sizeList"></div>
          </div>

          <div class="filter-section collapsed">
            <div class="filter-accordion-head">
              <span>Founded Year</span>
              <i class="fa-solid fa-chevron-down"></i>
            </div>
            <div class="filter-check-list" id="foundedList"></div>
          </div>
        </aside>

        <!-- ============ RESULTS ============ -->
        <div class="companies-results">
          <div class="companies-results-top">
            <p class="results-count" id="resultCount">Showing companies...</p>
            <div class="sort-by-wrap">
              <span>Sort by:</span>
              <select id="sortBySelect">
                <option value="popularity">Popularity</option>
                <option value="name-asc">Name (A-Z)</option>
                <option value="openings-desc">Most Openings</option>
                <option value="newest">Newest First</option>
              </select>
            </div>
          </div>

          <div class="companies-datalist-wrapper">
              <asp:DataList ID="DataListPublicCompanies" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="companies-grid">
                  <ItemTemplate>
                      <div class="company-card" onclick="window.location.href='<%= ResolveUrl("~/company-details.aspx") %>?CompanyId=<%# Eval("CompanyId") %>';" style="cursor:pointer;">
                          <img src='<%# GetCompanyLogo(Eval("c_logo")) %>' alt="Company Logo" class="company-logo-img" onerror="this.onerror=null; this.src='<%= ResolveUrl("~/assets/default-company.png") %>';" />
                          <h3 class="company-name"><%# GetCompanyName(Eval("c_company")) %></h3>
                          <p class="company-tag"><%# GetCompanyIndustry(Eval("c_industry"), Eval("c_business_domain")) %></p>
                          <div class="company-meta">
                              <i class="fa-solid fa-location-dot"></i>
                              <span><%# GetCompanyLocation(Eval("c_location"), Eval("c_city"), Eval("c_state")) %></span>
                          </div>
                          <div class="company-meta">
                              <i class="fa-solid fa-briefcase"></i>
                              <span><%# Eval("TotalOpenings") %> Openings</span>
                          </div>
                      </div>
                  </ItemTemplate>
              </asp:DataList>
              <asp:Panel ID="pnlNoCompanies" runat="server" Visible="false">
                  <div class="empty-state-box" style="text-align:center; padding: 40px 20px;">
                      <div class="empty-state-icon" style="font-size: 40px; color: #94a3b8; margin-bottom: 12px;">
                          <i class="fa-solid fa-building"></i>
                      </div>
                      <h3>No Companies Registered Yet</h3>
                      <p style="color:#64748b;">Registered companies will appear here once available.</p>
                  </div>
              </asp:Panel>
          </div>

          <div class="no-results" id="noResults">
            <i class="fa-solid fa-building-circle-xmark"></i>
            <p>No companies match your filters. Try adjusting your search or filters.</p>
          </div>

          <div class="pagination" id="pagination"></div>
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

<script src="../js/global-store.js"></script>
<script src="../js/public-layout.js"></script>
<script src="../js/script.js"></script>
<script src="../js/companies-data.js"></script>
<script src="../js/companies.js"></script>
</body>
</html>

</asp:Content>




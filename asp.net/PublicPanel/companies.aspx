<%@ Page Title="Companies" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeFile="companies.aspx.cs" Inherits="asp.net.companies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/companies.css") %>" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
                        <li><a href="internships.aspx" data-nav-page="internships.aspx">Internships</a></li>
                        <li><a href="companies.aspx" class="active" data-nav-page="companies.aspx">Companies</a></li>
                        <li><a href="stories.aspx" data-nav-page="stories.aspx">Success Stories</a></li>
                        <li><a href="about.aspx" data-nav-page="about.aspx">About Us</a></li>
                        <li><a href="contact.aspx" data-nav-page="contact.aspx">Contact Us</a></li>
                        <li><a href="faq.aspx" data-nav-page="faq.aspx">FAQ</a></li>
                    </ul>
                </nav>
                <div class="navbar-actions">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/assets/login register.png" PostBackUrl="~/PublicPanel/login.aspx" Width="150px" />
                </div>
            </div>
        </div>
    </header>
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <main>
        <!-- ============ COMPANIES BANNER ============ -->
        <section class="companies-banner">
            <div class="companies-dots"></div>
            <div class="container companies-banner-inner">
                <div class="companies-banner-text">
                    <h1>Companies</h1>
                    <p class="about-desc">
                        Explore top companies offering amazing internship opportunities.<br />
                        Find the right company to kickstart your career.
                    </p>
                </div>
                <div class="companies-banner-media">
                    <div class="page-banner-media banner-shape-companies">
                        <div class="banner-blob"></div>
                        <asp:Image ID="imgCompaniesBanner" runat="server" ImageUrl="~/assets/banner_companies.png" CssClass="banner-image" />
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
                        <asp:TextBox ID="searchInput" runat="server" placeholder="Search companies by name, industry..."></asp:TextBox>
                    </div>
                    <div class="companies-select-wrap">
                        <i class="fa-solid fa-industry select-prefix-icon"></i>
                        <asp:DropDownList ID="ddlIndustry" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlIndustry_SelectedIndexChanged">
                            <asp:ListItem Text="All Industries" Value="" />
                            <asp:ListItem Text="Artificial Intelligence &amp; Data" Value="Artificial Intelligence &amp; Data" />
                            <asp:ListItem Text="Cloud Infrastructure" Value="Cloud Infrastructure" />
                            <asp:ListItem Text="Cyber Security" Value="Cyber Security" />
                            <asp:ListItem Text="Information Technology" Value="Information Technology" />
                            <asp:ListItem Text="Product Development" Value="Product Development" />
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
                        <i class="fa-solid fa-users select-prefix-icon"></i>
                        <asp:DropDownList ID="ddlSize" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSize_SelectedIndexChanged">
                            <asp:ListItem Text="All Sizes" Value="" />
                            <asp:ListItem Text="50-100 Employees" Value="50-100 Employees" />
                            <asp:ListItem Text="100-500 Employees" Value="100-500 Employees" />
                            <asp:ListItem Text="500+ Employees" Value="500+ Employees" />
                        </asp:DropDownList>
                        <i class="fa-solid fa-chevron-down select-caret"></i>
                    </div>
                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/assets/search companies.png" Height="46px" CssClass="btn-img-action" OnClick="ImageButton2_Click" />
                    <asp:ImageButton ID="btnReset" runat="server" ImageUrl="~/assets/btn_reset.png" Height="46px" OnClick="btnReset_Click" CssClass="btn-img-action" />
                </div>
                <div class="companies-layout" id="companiesResultsTop">
                    <!-- ============ RESULTS ============ -->
                    <div class="companies-results">
                        <div class="companies-results-top">
                            <div class="results-count-wrap">
                                <span class="results-count-icon"><i class="fa-solid fa-building"></i></span>
                                <asp:Label ID="lblTotalCompanies" runat="server" CssClass="results-count-text"></asp:Label>
                            </div>
                            <div class="sort-by-wrap">
                                <span>Sort by:</span>
                                <asp:DropDownList ID="ddlSortBy" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged">
                                    <asp:ListItem Text="Sort By" Value="select" />
                                    <asp:ListItem Text="Name (A-Z)" Value="name-asc" />
                                    <asp:ListItem Text="Name (Z-A)" Value="name-desc" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="companies-datalist-wrapper">
                            <asp:DataList ID="DataListPublicCompanies" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="companies-grid">
                                <ItemTemplate>
                                    <div class="company-card" onclick="window.location.href='company-details.aspx?CompanyId=<%# Eval("CompanyId") %>';">
                                        <asp:Image ID="imgCompanyLogo" runat="server" CssClass="company-logo-img" ImageUrl='<%# Eval("c_logo") %>' />
                                        <h3 class="company-name">
                                            <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                        </h3>
                                        <p class="company-tag">
                                            <asp:Label ID="lblCompanyIndustry" runat="server" Text='<%# Eval("c_industry") %>'></asp:Label>
                                        </p>
                                        <div class="company-meta">
                                            <i class="fa-solid fa-location-dot"></i>
                                            <asp:Label ID="lblCompanyLocation" runat="server" Text='<%# Eval("c_location") %>'></asp:Label>
                                        </div>
                                        <div class="company-meta">
                                            <i class="fa-solid fa-briefcase"></i>
                                            <asp:Label ID="lblCompanyOpenings" runat="server" Text='<%# Eval("TotalOpenings") %>'></asp:Label>
                                            Openings
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
    </main>
    <script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/script.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/companies.js") %>"></script>
</asp:Content>

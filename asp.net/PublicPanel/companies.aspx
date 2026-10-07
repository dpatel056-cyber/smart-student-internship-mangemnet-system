<%@ Page Title="Companies" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeFile="companies.aspx.cs" Inherits="asp.net.companies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
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
            transition: all 0.2s ease !important;
            cursor: pointer !important;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02) !important;
        }

        .pg-link:hover:not(.pg-active):not(.pg-disabled) {
            background: #eff6ff !important;
            color: #2563eb !important;
            border-color: #bfdbfe !important;
            transform: translateY(-1px) !important;
        }

        .pg-link.pg-active {
            background: #2563eb !important;
            color: #ffffff !important;
            border-color: #2563eb !important;
            cursor: default !important;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25) !important;
        }

        .pg-link.pg-disabled {
            background: #f8fafc !important;
            color: #cbd5e1 !important;
            border-color: #f1f5f9 !important;
            cursor: not-allowed !important;
            pointer-events: none !important;
        }

        .companies-grid {
            display: grid !important;
            grid-template-columns: repeat(3, 1fr) !important;
            gap: 22px !important;
            width: 100% !important;
        }

        @media (max-width: 992px) {
            .companies-grid {
                grid-template-columns: repeat(2, 1fr) !important;
            }
        }

        @media (max-width: 600px) {
            .companies-grid {
                grid-template-columns: 1fr !important;
            }
        }
    </style>
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
                    <a href="tel:+918849900762" class="topbar-link">
                        <i class="fa-solid fa-phone"></i>88499 00762
                    </a>
                    <a href="mailto:support@sims.com" class="topbar-link">
                        <i class="fa-solid fa-envelope"></i>support@sims.com
                    </a>
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
                    <%-- <a href="login.aspx" class="btn btn-primary">Login / Register</a> --%>
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/assets/login register.png" PostBackUrl="~/PublicPanel/login.aspx" Width="150px" />
                    <button class="hamburger" id="hamburgerBtn" type="button" aria-label="Menu">
                        <i class="fa-solid fa-bars"></i>
                    </button>
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
                        Explore top companies offering amazing internship opportunities.<br>
                        Find the right company to kickstart your career.
                    </p>
                </div>
                <div class="companies-banner-media">
                    <div class="page-banner-media banner-shape-companies">
                        <div class="banner-blob"></div>
                        <img src="<%= ResolveUrl("~/assets/banner_companies.png") %>" alt="Explore companies" class="banner-image">
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
                            <option value="Information Technology">Information Technology</option>
                            <option value="Software Development">Software Development</option>
                            <option value="Artificial Intelligence">Artificial Intelligence</option>
                            <option value="Cyber Security">Cyber Security</option>
                            <option value="Cloud Computing">Cloud Computing</option>
                            <option value="Data Science">Data Science</option>
                            <option value="Web Development">Web Development</option>
                            <option value="Digital Marketing">Digital Marketing</option>
                            <option value="Robotics &amp; IoT">Robotics &amp; IoT</option>
                            <option value="Enterprise Software">Enterprise Software</option>
                            <option value="Full Stack Development">Full Stack Development</option>
                            <option value="Finance">Finance</option>
                            <option value="Marketing">Marketing</option>
                            <option value="Design">Design</option>
                            <option value="Education">Education</option>
                            <option value="Healthcare">Healthcare</option>
                            <option value="Manufacturing">Manufacturing</option>
                            <option value="Consulting">Consulting</option>
                            <option value="E-commerce">E-commerce</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-caret"></i>
                    </div>

                    <div class="companies-select-wrap">
                        <i class="fa-solid fa-location-dot select-prefix-icon"></i>
                        <select id="topLocation">
                            <option value="">All Locations</option>
                            <option value="Ahmedabad">Ahmedabad</option>
                            <option value="Bengaluru">Bengaluru</option>
                            <option value="Chennai">Chennai</option>
                            <option value="Gandhinagar">Gandhinagar</option>
                            <option value="Gurugram">Gurugram</option>
                            <option value="Hyderabad">Hyderabad</option>
                            <option value="Mumbai">Mumbai</option>
                            <option value="Noida">Noida</option>
                            <option value="Pune">Pune</option>
                            <option value="Rajkot">Rajkot</option>
                            <option value="Surat">Surat</option>
                            <option value="Vadodara">Vadodara</option>
                            <option value="Remote">Remote</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-caret"></i>
                    </div>

                    <div class="companies-select-wrap">
                        <i class="fa-solid fa-users select-prefix-icon"></i>
                        <select id="topSize">
                            <option value="">Company Size</option>
                            <option value="1-10">1-10 employees</option>
                            <option value="11-50">11-50 employees</option>
                            <option value="51-200">51-200 employees</option>
                            <option value="201-500">201-500 employees</option>
                            <option value="501-1000">501-1000 employees</option>
                            <option value="1000+">1000+ employees</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-caret"></i>
                    </div>

                    <%--
                    <button type="button" class="btn btn-primary btn-search-companies" id="companySearchBtn">
                        <i class="fa-solid fa-magnifying-glass"></i> Search Companies
                    </button>
                    --%>
                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/assets/search companies.png" Width="200px" />
                </div>

                <div class="companies-layout" id="companiesResultsTop">

                    <!-- ============ FILTER SIDEBAR ============ -->
                    <aside class="filters-sidebar">
                        <div class="filters-sidebar-head">
                            <h3><i class="fa-solid fa-sliders"></i>Filter Companies</h3>
                            <button type="button" class="reset-filters-btn" id="resetFiltersBtn">Reset</button>
                        </div>

                        <!-- Industry -->
                        <div class="filter-section" id="industrySection">
                            <div class="filter-accordion-head">
                                <span>Industry</span>
                                <i class="fa-solid fa-chevron-down"></i>
                            </div>
                            <div class="filter-check-list" id="industryList">
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Information Technology"> Information Technology</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Software Development"> Software Development</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Artificial Intelligence"> Artificial Intelligence</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Cyber Security"> Cyber Security</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Cloud Computing"> Cloud Computing</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Data Science"> Data Science</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Web Development"> Web Development</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Digital Marketing"> Digital Marketing</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Robotics &amp; IoT"> Robotics &amp; IoT</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Finance"> Finance</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Design"> Design</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Education"> Education</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="Healthcare"> Healthcare</label>
                                <label class="filter-check"><input type="checkbox" name="indCheck" value="E-commerce"> E-commerce</label>
                            </div>
                        </div>

                        <!-- Location -->
                        <div class="filter-section collapsed">
                            <div class="filter-accordion-head">
                                <span>Location</span>
                                <i class="fa-solid fa-chevron-down"></i>
                            </div>
                            <div class="filter-check-list" id="locationList">
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Ahmedabad"> Ahmedabad</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Bengaluru"> Bengaluru</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Chennai"> Chennai</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Gandhinagar"> Gandhinagar</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Gurugram"> Gurugram</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Hyderabad"> Hyderabad</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Mumbai"> Mumbai</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Noida"> Noida</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Pune"> Pune</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Rajkot"> Rajkot</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Surat"> Surat</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Vadodara"> Vadodara</label>
                                <label class="filter-check"><input type="checkbox" name="locCheck" value="Remote"> Remote</label>
                            </div>
                        </div>

                        <!-- Company Size -->
                        <div class="filter-section collapsed">
                            <div class="filter-accordion-head">
                                <span>Company Size</span>
                                <i class="fa-solid fa-chevron-down"></i>
                            </div>
                            <div class="filter-check-list" id="sizeList">
                                <label class="filter-check"><input type="checkbox" name="sizeCheck" value="1-10"> 1-10 employees</label>
                                <label class="filter-check"><input type="checkbox" name="sizeCheck" value="11-50"> 11-50 employees</label>
                                <label class="filter-check"><input type="checkbox" name="sizeCheck" value="51-200"> 51-200 employees</label>
                                <label class="filter-check"><input type="checkbox" name="sizeCheck" value="201-500"> 201-500 employees</label>
                                <label class="filter-check"><input type="checkbox" name="sizeCheck" value="501-1000"> 501-1000 employees</label>
                                <label class="filter-check"><input type="checkbox" name="sizeCheck" value="1000+"> 1000+ employees</label>
                            </div>
                        </div>
                    </aside>

                    <!-- ============ RESULTS ============ -->
                    <div class="companies-results">
                        <div class="companies-results-top">
                            <p class="results-count" id="resultCount">
                                <asp:Label ID="lblResultCount" runat="server">Showing companies...</asp:Label>
                            </p>
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
                                    <div class="company-card"
                                        data-name='<%# Eval("c_company") %>'
                                        data-industry='<%# Eval("c_industry") %>'
                                        data-location='<%# Eval("c_location") %>'
                                        data-size='<%# Eval("c_size") %>'
                                        onclick="window.location.href='company-details.aspx?CompanyId=<%# Eval("CompanyId") %>';"
                                        style="cursor: pointer;">

                                        <asp:Image ID="imgCompanyLogo" runat="server" CssClass="company-logo-img" ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' />

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

                        <div class="no-results" id="noResults" style="display: none;">
                            <i class="fa-solid fa-building-circle-xmark"></i>
                            <p>No companies match your filters. Try adjusting your search or filters.</p>
                        </div>
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

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const searchInput = document.getElementById('companySearchInput');
            const topIndustry = document.getElementById('topIndustry');
            const topLocation = document.getElementById('topLocation');
            const topSize = document.getElementById('topSize');
            const resetBtn = document.getElementById('resetFiltersBtn');
            const noResultsEl = document.getElementById('noResults');
            const pnlPagination = document.querySelector('.pg-wrap');

            // Accordion expand/collapse
            document.querySelectorAll('.filter-accordion-head').forEach(head => {
                head.addEventListener('click', function () {
                    const section = this.closest('.filter-section');
                    if (section) {
                        section.classList.toggle('collapsed');
                    }
                });
            });

            // Checkboxes
            const indChecks = document.querySelectorAll('input[name="indCheck"]');
            const locChecks = document.querySelectorAll('input[name="locCheck"]');
            const sizeChecks = document.querySelectorAll('input[name="sizeCheck"]');

            function applyFilters() {
                const query = (searchInput ? searchInput.value : '').trim().toLowerCase();
                const selectedTopInd = topIndustry ? topIndustry.value.trim().toLowerCase() : '';
                const selectedTopLoc = topLocation ? topLocation.value.trim().toLowerCase() : '';
                const selectedTopSize = topSize ? topSize.value.trim().toLowerCase() : '';

                const selectedInds = Array.from(indChecks).filter(c => c.checked).map(c => c.value.toLowerCase());
                const selectedLocs = Array.from(locChecks).filter(c => c.checked).map(c => c.value.toLowerCase());
                const selectedSizes = Array.from(sizeChecks).filter(c => c.checked).map(c => c.value.toLowerCase());

                const cards = document.querySelectorAll('.company-card');
                let visibleCount = 0;

                cards.forEach(card => {
                    const name = (card.getAttribute('data-name') || '').toLowerCase();
                    const industry = (card.getAttribute('data-industry') || '').toLowerCase();
                    const location = (card.getAttribute('data-location') || '').toLowerCase();
                    const size = (card.getAttribute('data-size') || '').toLowerCase();

                    let matchesSearch = true;
                    if (query) {
                        matchesSearch = name.includes(query) || industry.includes(query) || location.includes(query);
                    }

                    let matchesIndustry = true;
                    if (selectedTopInd && !industry.includes(selectedTopInd)) {
                        matchesIndustry = false;
                    }
                    if (selectedInds.length > 0 && !selectedInds.some(ind => industry.includes(ind))) {
                        matchesIndustry = false;
                    }

                    let matchesLocation = true;
                    if (selectedTopLoc && !location.includes(selectedTopLoc)) {
                        matchesLocation = false;
                    }
                    if (selectedLocs.length > 0 && !selectedLocs.some(loc => location.includes(loc))) {
                        matchesLocation = false;
                    }

                    let matchesSize = true;
                    if (selectedTopSize && !size.includes(selectedTopSize)) {
                        matchesSize = false;
                    }
                    if (selectedSizes.length > 0 && !selectedSizes.some(s => size.includes(s))) {
                        matchesSize = false;
                    }

                    if (matchesSearch && matchesIndustry && matchesLocation && matchesSize) {
                        card.style.display = '';
                        visibleCount++;
                    } else {
                        card.style.display = 'none';
                    }
                });

                if (noResultsEl) {
                    noResultsEl.style.display = (visibleCount === 0 && cards.length > 0) ? 'block' : 'none';
                }

                // Hide pagination if filtering is active
                const isFiltering = query || selectedTopInd || selectedTopLoc || selectedTopSize ||
                    selectedInds.length || selectedLocs.length || selectedSizes.length;

                if (pnlPagination) {
                    pnlPagination.style.display = isFiltering ? 'none' : '';
                }
            }

            if (searchInput) {
                searchInput.addEventListener('input', applyFilters);
            }

            if (topIndustry) {
                topIndustry.addEventListener('change', function () {
                    // Sync with checkbox
                    indChecks.forEach(c => {
                        c.checked = (topIndustry.value && c.value.toLowerCase() === topIndustry.value.toLowerCase());
                    });
                    applyFilters();
                });
            }

            if (topLocation) {
                topLocation.addEventListener('change', function () {
                    locChecks.forEach(c => {
                        c.checked = (topLocation.value && c.value.toLowerCase() === topLocation.value.toLowerCase());
                    });
                    applyFilters();
                });
            }

            if (topSize) {
                topSize.addEventListener('change', function () {
                    sizeChecks.forEach(c => {
                        c.checked = (topSize.value && c.value.toLowerCase() === topSize.value.toLowerCase());
                    });
                    applyFilters();
                });
            }

            indChecks.forEach(c => c.addEventListener('change', applyFilters));
            locChecks.forEach(c => c.addEventListener('change', applyFilters));
            sizeChecks.forEach(c => c.addEventListener('change', applyFilters));

            if (resetBtn) {
                resetBtn.addEventListener('click', function () {
                    if (searchInput) searchInput.value = '';
                    if (topIndustry) topIndustry.selectedIndex = 0;
                    if (topLocation) topLocation.selectedIndex = 0;
                    if (topSize) topSize.selectedIndex = 0;

                    indChecks.forEach(c => c.checked = false);
                    locChecks.forEach(c => c.checked = false);
                    sizeChecks.forEach(c => c.checked = false);

                    applyFilters();
                });
            }
        });
    </script>
</asp:Content>
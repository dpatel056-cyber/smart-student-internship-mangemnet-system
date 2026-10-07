<%@ Page Title="Success Stories - SIMS" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="stories.aspx.cs" Inherits="asp.net.stories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .stories-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
            margin-top: 30px;
        }

        .story-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 24px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.04);
            transition: transform 0.25s ease, box-shadow 0.25s ease, border-color 0.25s ease;
        }

        .story-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(37, 99, 235, 0.1);
            border-color: #bfdbfe;
        }

        .story-quote-icon {
            position: absolute;
            top: 20px;
            right: 20px;
            font-size: 26px;
            color: #e2e8f0;
            transition: color 0.25s;
        }

        .story-card:hover .story-quote-icon {
            color: #bfdbfe;
        }

        .story-head {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 16px;
        }

        .story-avatar {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            object-fit: cover;
            border: 2.5px solid #2563eb;
            background: #eff6ff;
            flex-shrink: 0;
        }

        .story-name {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 2px;
        }

        .story-role {
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }

        .story-quote {
            font-size: 14px;
            line-height: 1.65;
            color: #334155;
            margin-bottom: 18px;
            flex-grow: 1;
            font-style: italic;
        }

        .story-footer {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 14px;
            border-top: 1px dashed #e2e8f0;
            margin-bottom: 12px;
        }

        .story-placed {
            font-size: 12px;
            color: #64748b;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .story-company-logo {
            height: 24px;
            max-width: 90px;
            object-fit: contain;
        }

        .story-badge-row {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .story-badge {
            font-size: 11.5px;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 6px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .badge-fulltime {
            background: #dcfce7;
            color: #15803d;
        }

        .badge-ppo {
            background: #e0e7ff;
            color: #4338ca;
        }

        .badge-top {
            background: #fef3c7;
            color: #b45309;
        }

        .badge-growth {
            background: #fae8ff;
            color: #86198f;
        }

        .hidden-story {
            display: none !important;
        }

        @media (max-width: 992px) {
            .stories-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {
            .stories-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <!-- ============ HEADER ============ -->
    <header class="site-header">
        <!-- Top bar -->
        <div class="topbar">
            <div class="container topbar-inner">
                <p class="topbar-tagline"><i class="fa-solid fa-graduation-cap"></i>Empowering Students. Connecting Companies. Building Careers.</p>
                <div class="topbar-right">
                    <a href="tel:+918849900762" class="topbar-link"><i class="fa-solid fa-phone"></i>88499 00762</a>
                    <a href="mailto:support@sims.com" class="topbar-link"><i class="fa-solid fa-envelope"></i>support@sims.com</a>
                    <div class="topbar-socials">
                        <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a><a href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a><a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a><a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main nav -->
        <div class="navbar">
            <div class="container navbar-inner">
                <a href="index.aspx" class="brand">
                    <span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span>
                    <span class="brand-text"><span class="brand-name">SIMS</span> <span class="brand-sub">Smart Student Internship Management System</span></span>
                </a>
                <nav class="main-nav" id="mainNav">
                    <ul>
                        <li><a href="index.aspx" data-nav-page="index.aspx">Home</a></li>
                        <li><a href="internships.aspx" data-nav-page="internships.aspx">Internships</a></li>
                        <li><a href="companies.aspx" data-nav-page="companies.aspx">Companies</a></li>
                        <li><a href="stories.aspx" class="active" data-nav-page="stories.aspx">Success Stories</a></li>
                        <li><a href="about.aspx" data-nav-page="about.aspx">About Us</a></li>
                        <li><a href="contact.aspx" data-nav-page="contact.aspx">Contact Us</a></li>
                        <li><a href="faq.aspx" data-nav-page="faq.aspx">FAQ</a></li>
                    </ul>
                </nav>
                <div class="navbar-actions">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/assets/login register.png" PostBackUrl="~/PublicPanel/login.aspx" Width="150px" />
                    <button class="hamburger" id="hamburgerBtn" type="button" aria-label="Menu"><i class="fa-solid fa-bars"></i></button>
                </div>
            </div>
        </div>
    </header>
</asp:Content>

<asp:Content ID="Content6" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- ============ STORIES BANNER ============ -->
    <section class="stories-banner">
        <div class="about-dots"></div>
        <div class="container stories-banner-inner">
            <div class="stories-banner-text">
                <h1>Success Stories</h1>
                <p class="stories-tagline">Real students. Real opportunities. Real success.</p>
                <p class="stories-desc">
                    Discover how SIMS has helped ambitious students find high-impact internships, clear technical assessments, receive prestigious offer letters, and fast-track their professional careers.
                </p>
            </div>
            <div class="stories-banner-media banner-shape-stories">
                <div class="banner-blob"></div>
                <img src="<%= ResolveUrl("~/assets/banner_stories.png") %>" alt="SIMS student success" class="banner-image">
            </div>
        </div>
    </section>

    <!-- ============ FILTER TABS ============ -->
    <section class="story-filters-wrap">
        <div class="container">
            <div class="story-filters" id="storyFilters">
                <button type="button" class="filter-tab active" data-filter="all"><i class="fa-solid fa-star"></i>All Stories</button>
                <button type="button" class="filter-tab" data-filter="students"><i class="fa-solid fa-user-graduate"></i>For Students</button>
                <button type="button" class="filter-tab" data-filter="companies"><i class="fa-solid fa-building"></i>For Companies</button>
                <button type="button" class="filter-tab" data-filter="experiences"><i class="fa-solid fa-briefcase"></i>Internship Experiences</button>
                <button type="button" class="filter-tab" data-filter="growth"><i class="fa-solid fa-arrow-trend-up"></i>Career Growth</button>
            </div>
        </div>
    </section>

    <!-- ============ STORIES GRID ============ -->
    <section class="stories-section">
        <div class="container">
            <div class="stories-grid" id="storiesGrid">

                <!-- Story 1 -->
                <div class="story-card" data-category="students experiences">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="Aarav Sharma" class="story-avatar" />
                        <div>
                            <div class="story-name">Aarav Sharma</div>
                            <div class="story-role">Full Stack Developer Intern</div>
                        </div>
                    </div>
                    <p class="story-quote">"SIMS made applying to top-tier companies frictionless. I took the coding quiz, had an online interview, and within a week received my official offer letter with TechNova Solutions!"</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <img src="<%= ResolveUrl("~/assets/technova.png") %>" alt="TechNova" class="story-company-logo" onerror="this.outerHTML='<span style=\'font-weight:700;color:#2563eb;font-size:13px;\'>TechNova</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i>Full-time Offer</span>
                    </div>
                </div>

                <!-- Story 2 -->
                <div class="story-card" data-category="students growth">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="Diya Mehta" class="story-avatar" />
                        <div>
                            <div class="story-name">Diya Mehta</div>
                            <div class="story-role">Data Analyst Intern</div>
                        </div>
                    </div>
                    <p class="story-quote">"The verified certificate and recommendation from SIMS helped me convert my 6-month internship into a high-paying Pre-Placement Offer (PPO) at CloudNova."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <img src="<%= ResolveUrl("~/assets/cloudnova.png") %>" alt="CloudNova" class="story-company-logo" onerror="this.outerHTML='<span style=\'font-weight:700;color:#2563eb;font-size:13px;\'>CloudNova</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-ppo"><i class="fa-solid fa-award"></i>PPO Conversion</span>
                    </div>
                </div>

                <!-- Story 3 -->
                <div class="story-card" data-category="companies experiences">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="Harsh Varma" class="story-avatar" />
                        <div>
                            <div class="story-name">Harsh Varma</div>
                            <div class="story-role">Cloud DevOps Engineer</div>
                        </div>
                    </div>
                    <p class="story-quote">"The interview scheduling and live task module gave me a structured roadmap to showcase my AWS skills. It's the most transparent platform for students."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <img src="<%= ResolveUrl("~/assets/logo-amazon.png") %>" alt="Amazon" class="story-company-logo" onerror="this.outerHTML='<span style=\'font-weight:700;color:#2563eb;font-size:13px;\'>Amazon AWS</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-top"><i class="fa-solid fa-star"></i>Top Performer</span>
                    </div>
                </div>

                <!-- Story 4 -->
                <div class="story-card" data-category="students growth experiences">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="Rohan Joshi" class="story-avatar" />
                        <div>
                            <div class="story-name">Rohan Joshi</div>
                            <div class="story-role">UI/UX Designer</div>
                        </div>
                    </div>
                    <p class="story-quote">"From portfolio submission to the design assessment round, everything was super organized. Now I work with a passionate team crafting mobile user experiences."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <img src="<%= ResolveUrl("~/assets/logo-adobe.svg") %>" alt="Adobe" class="story-company-logo" onerror="this.outerHTML='<span style=\'font-weight:700;color:#2563eb;font-size:13px;\'>Adobe</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-growth"><i class="fa-solid fa-chart-line"></i>Career Growth</span>
                    </div>
                </div>

                <!-- Story 5 -->
                <div class="story-card" data-category="companies students">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="Pooja Trivedi" class="story-avatar" />
                        <div>
                            <div class="story-name">Pooja Trivedi</div>
                            <div class="story-role">AI / ML Research Intern</div>
                        </div>
                    </div>
                    <p class="story-quote">"The quality of internship openings here is unmatched. SIMS connected me directly with engineering leads working on cutting-edge generative AI models."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <img src="<%= ResolveUrl("~/assets/logo-google.png") %>" alt="Google" class="story-company-logo" onerror="this.outerHTML='<span style=\'font-weight:700;color:#2563eb;font-size:13px;\'>Google</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i>Full-time Offer</span>
                    </div>
                </div>

                <!-- Story 6 -->
                <div class="story-card" data-category="companies growth">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="Kavya Nair" class="story-avatar" />
                        <div>
                            <div class="story-name">Kavya Nair</div>
                            <div class="story-role">Software Engineer Intern</div>
                        </div>
                    </div>
                    <p class="story-quote">"SIMS eliminated recruiter middle-men. My quiz scores spoke for themselves, and I secured an offer letter with Microsoft within 10 days of applying."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <img src="<%= ResolveUrl("~/assets/logo-microsoft.png") %>" alt="Microsoft" class="story-company-logo" onerror="this.outerHTML='<span style=\'font-weight:700;color:#2563eb;font-size:13px;\'>Microsoft</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-ppo"><i class="fa-solid fa-award"></i>PPO Conversion</span>
                    </div>
                </div>

                <!-- Story 7 -->
                <div class="story-card" data-category="experiences students">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="Siddharth Dave" class="story-avatar" />
                        <div>
                            <div class="story-name">Siddharth Dave</div>
                            <div class="story-role">Cybersecurity Analyst</div>
                        </div>
                    </div>
                    <p class="story-quote">"I worked on live vulnerability assessments during my internship. The completion certificate with verification QR code made my resume stand out in every interview."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <img src="<%= ResolveUrl("~/assets/logo-tcs.svg") %>" alt="TCS" class="story-company-logo" onerror="this.outerHTML='<span style=\'font-weight:700;color:#2563eb;font-size:13px;\'>TCS Cyber</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-top"><i class="fa-solid fa-star"></i>Top Performer</span>
                    </div>
                </div>

                <!-- Story 8 -->
                <div class="story-card" data-category="companies growth">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="Ananya Reddy" class="story-avatar" />
                        <div>
                            <div class="story-name">Ananya Reddy</div>
                            <div class="story-role">Frontend Engineer</div>
                        </div>
                    </div>
                    <p class="story-quote">"Through SIMS, I got exposed to React.js and modern web architectures. The hands-on mentoring turned my internship into a full-time engineering role."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <img src="<%= ResolveUrl("~/assets/logo-infosys.png") %>" alt="Infosys" class="story-company-logo" onerror="this.outerHTML='<span style=\'font-weight:700;color:#2563eb;font-size:13px;\'>Infosys</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i>Full-time Offer</span>
                    </div>
                </div>

                <!-- Story 9 -->
                <div class="story-card" data-category="students growth">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="Yashraj Solanki" class="story-avatar" />
                        <div>
                            <div class="story-name">Yashraj Solanki</div>
                            <div class="story-role">Backend Engineer</div>
                        </div>
                    </div>
                    <p class="story-quote">"The transparent tracking system kept me updated at every stage. I landed my dream role at Flipkart thanks to SIMS verified internship program."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <img src="<%= ResolveUrl("~/assets/logo-flipkart.svg") %>" alt="Flipkart" class="story-company-logo" onerror="this.outerHTML='<span style=\'font-weight:700;color:#2563eb;font-size:13px;\'>Flipkart</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-ppo"><i class="fa-solid fa-award"></i>PPO Conversion</span>
                    </div>
                </div>

            </div>

            <p class="faq-empty" id="storiesEmpty" style="display: none; text-align: center; padding: 40px; color: #64748b; font-size: 15px;">No stories found in this category yet.</p>

            <div class="view-more-wrap" style="text-align: center; margin-top: 36px;">
                <button type="button" class="btn btn-ghost view-more-btn" id="viewMoreBtn">
                    View More Stories <i class="fa-solid fa-chevron-down"></i>
                </button>
            </div>
        </div>
    </section>

    <!-- ============ STATS BAR ============ -->
    <section class="stories-stats-section">
        <div class="container">
            <div class="stories-stats-bar">
                <div class="stat-item">
                    <span class="stat-icon icon-blue"><i class="fa-solid fa-user-group"></i></span>
                    <div>
                        <strong>25K+</strong>
                        <p>Students Benefited</p>
                    </div>
                </div>
                <div class="stat-item">
                    <span class="stat-icon icon-green"><i class="fa-solid fa-building"></i></span>
                    <div>
                        <strong>1K+</strong>
                        <p>Companies Trust Us</p>
                    </div>
                </div>
                <div class="stat-item">
                    <span class="stat-icon icon-orange"><i class="fa-solid fa-graduation-cap"></i></span>
                    <div>
                        <strong>10K+</strong>
                        <p>Internships Completed</p>
                    </div>
                </div>
                <div class="stat-item">
                    <span class="stat-icon icon-purple"><i class="fa-solid fa-file-signature"></i></span>
                    <div>
                        <strong>5K+</strong>
                        <p>Full-time Offers</p>
                    </div>
                </div>
                <div class="stat-item">
                    <span class="stat-icon icon-blue"><i class="fa-solid fa-star"></i></span>
                    <div>
                        <strong>95%</strong>
                        <p>Student Satisfaction</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="Content7" runat="server" ContentPlaceHolderID="ContentPlaceHolder3">
    <!-- ============ FOOTER ============ -->
    <footer class="site-footer">
        <div class="container footer-grid">

            <div class="footer-col footer-about">
                <a href="index.aspx" class="brand brand-footer">
                    <span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span>
                    <span class="brand-text"><span class="brand-name">SIMS</span> <span class="brand-sub">Smart Student Internship Management System</span></span>
                </a>
                <p class="footer-desc">We bridge the gap between aspiring students and innovative companies by providing the best internship opportunities.</p>
                <div class="footer-socials">
                    <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a><a href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a><a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a><a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
                </div>
            </div>

            <div class="footer-col">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="index.aspx"><i class="fa-solid fa-angle-right"></i>Home</a></li>
                    <li><a href="about.aspx"><i class="fa-solid fa-angle-right"></i>About Us</a></li>
                    <li><a href="internships.aspx"><i class="fa-solid fa-angle-right"></i>Internships</a></li>
                    <li><a href="companies.aspx"><i class="fa-solid fa-angle-right"></i>Companies</a></li>
                    <li><a href="stories.aspx"><i class="fa-solid fa-angle-right"></i>Success Stories</a></li>
                    <li><a href="contact.aspx"><i class="fa-solid fa-angle-right"></i>Contact Us</a></li>
                    <li><a href="faq.aspx"><i class="fa-solid fa-angle-right"></i>FAQ</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>For Students</h4>
                <ul>
                    <li><a href="internships.aspx"><i class="fa-solid fa-angle-right"></i>Browse Internships</a></li>
                    <li><a href="apply-internship.aspx"><i class="fa-solid fa-angle-right"></i>Apply Internship</a></li>
                    <li><a href="upload-resume.aspx"><i class="fa-solid fa-angle-right"></i>Upload Resume</a></li>
                    <li><a href="my-applications.aspx"><i class="fa-solid fa-angle-right"></i>My Applications</a></li>
                    <li><a href="certificates-documents.aspx"><i class="fa-solid fa-angle-right"></i>Certificates</a></li>
                    <li><a href="notifications.aspx"><i class="fa-solid fa-angle-right"></i>Notifications</a></li>
                    <li><a href="<%= ResolveUrl("~/StudentPanel/student-dashboard.aspx") %>"><i class="fa-solid fa-angle-right"></i>Student Dashboard</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>For Companies</h4>
                <ul>
                    <li><a href="<%= ResolveUrl("~/CompanyPanel/company-post-internship.aspx") %>"><i class="fa-solid fa-angle-right"></i>Post Internship</a></li>
                    <li><a href="<%= ResolveUrl("~/CompanyPanel/company-internships.aspx") %>"><i class="fa-solid fa-angle-right"></i>Manage Internships</a></li>
                    <li><a href="<%= ResolveUrl("~/CompanyPanel/company-internships.aspx") %>"><i class="fa-solid fa-angle-right"></i>View Applications</a></li>
                    <li><a href="<%= ResolveUrl("~/AdminPanel/admin-students.aspx") %>"><i class="fa-solid fa-angle-right"></i>Find Talents</a></li>
                    <li><a href="<%= ResolveUrl("~/CompanyPanel/company-dashboard.aspx") %>"><i class="fa-solid fa-angle-right"></i>Company Dashboard</a></li>
                    <li><a href="company-reports.aspx"><i class="fa-solid fa-angle-right"></i>Reports</a></li>
                    <li><a href="company-profile.aspx"><i class="fa-solid fa-angle-right"></i>Company Profile</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Contact Us</h4>
                <ul class="footer-contact">
                    <li><i class="fa-solid fa-location-dot"></i>RK University Main Campus, Rajkot</li>
                    <li><i class="fa-solid fa-phone"></i>+91 88499 00762</li>
                    <li><i class="fa-solid fa-envelope"></i>support@sims.com</li>
                    <li><i class="fa-solid fa-clock"></i>Mon - Sat (9:00 AM - 6:00 PM)</li>
                </ul>
            </div>

            <div class="footer-col footer-newsletter">
                <h4>Subscribe to our Newsletter</h4>
                <p>Get the latest updates about internships, career tips and more.</p>
                <div class="newsletter-form">
                    <asp:TextBox ID="TextBox1" runat="server" TextMode="Email" CssClass="newsletter-input" placeholder="Enter your email address" Height="45px" Width="200px"></asp:TextBox>
                    <button type="submit" class="newsletter-btn" style="height:45px; width:60px;"><i class="fa-solid fa-paper-plane"></i></button>
                </div>
            </div>

        </div>

        <div class="footer-bottom">
            <div class="container footer-bottom-inner">
                <p>&copy; 2026 SIMS - Smart Student Internship Management System. All rights reserved.</p>
                <div class="footer-bottom-links">
                    <a href="privacy-security.aspx">Privacy Policy</a> <span>|</span>
                    <a href="privacy-security.aspx">Terms &amp; Conditions</a> <span>|</span>
                    <a href="privacy-security.aspx">Refund Policy</a> <span>|</span>
                    <a href="help-support.aspx">Support</a>
                </div>
            </div>
        </div>

        <button class="scroll-top" id="scrollTopBtn" type="button" aria-label="Scroll to top"><i class="fa-solid fa-chevron-up"></i></button>
    </footer>

    <script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/script.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/stories.js") %>"></script>
</asp:Content>

<%@ Page Title="Success Stories - SIMS" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="stories.aspx.cs" Inherits="asp.net.stories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/stories.css") %>" />
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
                        <li><a href="companies.aspx" data-nav-page="companies.aspx">Companies</a></li>
                        <li><a href="stories.aspx" class="active" data-nav-page="stories.aspx">Success Stories</a></li>
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
                <asp:Image ID="imgBannerStories" runat="server" ImageUrl="~/assets/banner_stories.png" CssClass="banner-image" />
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
                        <asp:Image ID="imgStoryAvatar1" runat="server" ImageUrl="~/assets/student-aarav.jpg" CssClass="story-avatar" />
                        <div>
                            <div class="story-name">Aarav Sharma</div>
                            <div class="story-role">Full Stack Developer Intern</div>
                        </div>
                    </div>
                    <p class="story-quote">"SIMS made applying to top-tier companies frictionless. I took the coding quiz, had an online interview, and within a week received my official offer letter with TechNova Solutions!"</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <asp:Image ID="imgCompanyLogo1" runat="server" ImageUrl="~/assets/technova.png" CssClass="story-company-logo" onerror="this.outerHTML='<span class=\'story-logo-fallback\'>TechNova</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i>Full-time Offer</span>
                    </div>
                </div>

                <!-- Story 2 -->
                <div class="story-card" data-category="students growth">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <asp:Image ID="imgStoryAvatar2" runat="server" ImageUrl="~/assets/student-diya.jpg" CssClass="story-avatar" />
                        <div>
                            <div class="story-name">Diya Mehta</div>
                            <div class="story-role">Data Analyst Intern</div>
                        </div>
                    </div>
                    <p class="story-quote">"The verified certificate and recommendation from SIMS helped me convert my 6-month internship into a high-paying Pre-Placement Offer (PPO) at CloudNova."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <asp:Image ID="imgCompanyLogo2" runat="server" ImageUrl="~/assets/cloudnova.png" CssClass="story-company-logo" onerror="this.outerHTML='<span class=\'story-logo-fallback\'>CloudNova</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-ppo"><i class="fa-solid fa-award"></i>PPO Conversion</span>
                    </div>
                </div>

                <!-- Story 3 -->
                <div class="story-card" data-category="companies experiences">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <asp:Image ID="imgStoryAvatar3" runat="server" ImageUrl="~/assets/student-harsh.jpg" CssClass="story-avatar" />
                        <div>
                            <div class="story-name">Harsh Varma</div>
                            <div class="story-role">Cloud DevOps Engineer</div>
                        </div>
                    </div>
                    <p class="story-quote">"The interview scheduling and live task module gave me a structured roadmap to showcase my AWS skills. It's the most transparent platform for students."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <asp:Image ID="imgCompanyLogo3" runat="server" ImageUrl="~/assets/logo-amazon.png" CssClass="story-company-logo" onerror="this.outerHTML='<span class=\'story-logo-fallback\'>Amazon AWS</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-top"><i class="fa-solid fa-star"></i>Top Performer</span>
                    </div>
                </div>

                <!-- Story 4 -->
                <div class="story-card" data-category="students growth experiences">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <asp:Image ID="imgStoryAvatar4" runat="server" ImageUrl="~/assets/student-rohan.jpg" CssClass="story-avatar" />
                        <div>
                            <div class="story-name">Rohan Joshi</div>
                            <div class="story-role">UI/UX Designer</div>
                        </div>
                    </div>
                    <p class="story-quote">"From portfolio submission to the design assessment round, everything was super organized. Now I work with a passionate team crafting mobile user experiences."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <asp:Image ID="imgCompanyLogo4" runat="server" ImageUrl="~/assets/logo-adobe.svg" CssClass="story-company-logo" onerror="this.outerHTML='<span class=\'story-logo-fallback\'>Adobe</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-growth"><i class="fa-solid fa-chart-line"></i>Career Growth</span>
                    </div>
                </div>

                <!-- Story 5 -->
                <div class="story-card" data-category="companies students">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <asp:Image ID="imgStoryAvatar5" runat="server" ImageUrl="~/assets/student-pooja.jpg" CssClass="story-avatar" />
                        <div>
                            <div class="story-name">Pooja Trivedi</div>
                            <div class="story-role">AI / ML Research Intern</div>
                        </div>
                    </div>
                    <p class="story-quote">"The quality of internship openings here is unmatched. SIMS connected me directly with engineering leads working on cutting-edge generative AI models."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <asp:Image ID="imgCompanyLogo5" runat="server" ImageUrl="~/assets/logo-google.png" CssClass="story-company-logo" onerror="this.outerHTML='<span class=\'story-logo-fallback\'>Google</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i>Full-time Offer</span>
                    </div>
                </div>

                <!-- Story 6 -->
                <div class="story-card" data-category="companies growth">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <asp:Image ID="imgStoryAvatar6" runat="server" ImageUrl="~/assets/student-kavya.jpg" CssClass="story-avatar" />
                        <div>
                            <div class="story-name">Kavya Nair</div>
                            <div class="story-role">Software Engineer Intern</div>
                        </div>
                    </div>
                    <p class="story-quote">"SIMS eliminated recruiter middle-men. My quiz scores spoke for themselves, and I secured an offer letter with Microsoft within 10 days of applying."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <asp:Image ID="imgCompanyLogo6" runat="server" ImageUrl="~/assets/logo-microsoft.png" CssClass="story-company-logo" onerror="this.outerHTML='<span class=\'story-logo-fallback\'>Microsoft</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-ppo"><i class="fa-solid fa-award"></i>PPO Conversion</span>
                    </div>
                </div>

                <!-- Story 7 -->
                <div class="story-card" data-category="experiences students">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <asp:Image ID="imgStoryAvatar7" runat="server" ImageUrl="~/assets/student-siddharth.jpg" CssClass="story-avatar" />
                        <div>
                            <div class="story-name">Siddharth Dave</div>
                            <div class="story-role">Cybersecurity Analyst</div>
                        </div>
                    </div>
                    <p class="story-quote">"I worked on live vulnerability assessments during my internship. The completion certificate with verification QR code made my resume stand out in every interview."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <asp:Image ID="imgCompanyLogo7" runat="server" ImageUrl="~/assets/logo-tcs.svg" CssClass="story-company-logo" onerror="this.outerHTML='<span class=\'story-logo-fallback\'>TCS Cyber</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-top"><i class="fa-solid fa-star"></i>Top Performer</span>
                    </div>
                </div>

                <!-- Story 8 -->
                <div class="story-card" data-category="companies growth">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <asp:Image ID="imgStoryAvatar8" runat="server" ImageUrl="~/assets/student-ananya.jpg" CssClass="story-avatar" />
                        <div>
                            <div class="story-name">Ananya Reddy</div>
                            <div class="story-role">Frontend Engineer</div>
                        </div>
                    </div>
                    <p class="story-quote">"Through SIMS, I got exposed to React.js and modern web architectures. The hands-on mentoring turned my internship into a full-time engineering role."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <asp:Image ID="imgCompanyLogo8" runat="server" ImageUrl="~/assets/logo-infosys.png" CssClass="story-company-logo" onerror="this.outerHTML='<span class=\'story-logo-fallback\'>Infosys</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i>Full-time Offer</span>
                    </div>
                </div>

                <!-- Story 9 -->
                <div class="story-card" data-category="students growth">
                    <i class="fa-solid fa-quote-right story-quote-icon"></i>
                    <div class="story-head">
                        <asp:Image ID="imgStoryAvatar9" runat="server" ImageUrl="~/assets/student-yashraj.jpg" CssClass="story-avatar" />
                        <div>
                            <div class="story-name">Yashraj Solanki</div>
                            <div class="story-role">Backend Engineer</div>
                        </div>
                    </div>
                    <p class="story-quote">"The transparent tracking system kept me updated at every stage. I landed my dream role at Flipkart thanks to SIMS verified internship program."</p>
                    <div class="story-footer">
                        <span class="story-placed"><i class="fa-solid fa-location-dot"></i>Placed at</span>
                        <asp:Image ID="imgCompanyLogo9" runat="server" ImageUrl="~/assets/logo-flipkart.svg" CssClass="story-company-logo" onerror="this.outerHTML='<span class=\'story-logo-fallback\'>Flipkart</span>'" />
                    </div>
                    <div class="story-badge-row">
                        <span class="story-badge badge-ppo"><i class="fa-solid fa-award"></i>PPO Conversion</span>
                    </div>
                </div>
            </div>

            <p class="faq-empty stories-empty-msg" id="storiesEmpty">No stories found in this category yet.</p>

            <div class="view-more-wrap">
                <asp:ImageButton ID="ImageButton2" ClientIDMode="Static" runat="server" ImageUrl="~/assets/view more stories.png" CssClass="view-more-img-btn stories-btn-visible" Height="48px" OnClientClick="if(window.handleToggleStories){window.handleToggleStories(event, 'more');} return false;" />
                <asp:ImageButton ID="btnViewLessStories" ClientIDMode="Static" runat="server" ImageUrl="~/assets/view less stories.png" CssClass="view-more-img-btn stories-btn-hidden" Height="48px" OnClientClick="if(window.handleToggleStories){window.handleToggleStories(event, 'less');} return false;" />
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
                    <span class="brand-text">
                        <span class="brand-name">SIMS</span>
                        <span class="brand-sub">Smart Student Internship Management System</span>
                    </span>
                </a>
                <p class="footer-desc">We bridge the gap between aspiring students and innovative companies by providing the best internship opportunities.</p>
                <div class="footer-socials">
                    <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
                    <a href="#" aria-label="Instagram"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#" aria-label="YouTube"><i class="fa-brands fa-youtube"></i></a>
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
                    <asp:ImageButton ID="btnNewsletter" runat="server" ImageUrl="~/assets/btn_send_newsletter.png" Width="52px" Height="46px" CssClass="newsletter-img-btn" />
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="container footer-bottom-inner">
                <p>&copy; 2026 SIMS - Smart Student Internship Management System. All rights reserved.</p>
                <div class="footer-bottom-links">
                    <a href="#">Privacy Policy</a>
                    <span>|</span>
                    <a href="#">Terms &amp; Conditions</a>
                    <span>|</span>
                    <a href="#">Refund Policy</a>
                    <span>|</span>
                    <a href="#">Support</a>
                </div>
            </div>
        </div>

        <asp:ImageButton ID="scrollTopBtn" ClientIDMode="Static" runat="server" ImageUrl="~/assets/btn_scroll_top.png" CssClass="scroll-top" Width="44px" Height="44px" OnClientClick="window.scrollTo({top:0, behavior:'smooth'}); return false;" />
    </footer>

    <script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/script.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/stories.js") %>"></script>
</asp:Content>

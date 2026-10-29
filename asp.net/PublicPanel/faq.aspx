<%@ Page Title="Frequently Asked Questions - SIMS" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="faq.aspx.cs" Inherits="asp.net.faq" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/faq.css") %>" />
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
                        <li><a href="stories.aspx" data-nav-page="stories.aspx">Success Stories</a></li>
                        <li><a href="about.aspx" data-nav-page="about.aspx">About Us</a></li>
                        <li><a href="contact.aspx" data-nav-page="contact.aspx">Contact Us</a></li>
                        <li><a href="faq.aspx" class="active" data-nav-page="faq.aspx">FAQ</a></li>
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
    <!-- ============ PAGE BANNER ============ -->
    <section class="page-banner">
        <div class="container page-banner-inner">
            <div class="page-banner-text">
                <h1>Frequently Asked Questions</h1>
                <p class="page-banner-desc">Find quick answers to common questions about SIMS, student applications, company postings, interviews, and verified certificates.</p>
            </div>
            <div class="page-banner-media banner-shape-faq">
                <div class="banner-blob"></div>
                <asp:Image ID="imgFaqBanner" runat="server" ImageUrl="~/assets/banner_faq.png" CssClass="banner-image" />
            </div>
        </div>
    </section>

    <!-- ============ FAQ CONTENT ============ -->
    <section class="faq-section">
        <div class="container faq-grid">

            <!-- Sidebar categories -->
            <aside class="faq-sidebar">
                <h3>FAQ Categories</h3>
                <div class="faq-cat-list">
                    <button type="button" class="faq-cat-btn active" data-cat="all">
                        <span class="faq-cat-icon cat-all"><i class="fa-solid fa-layer-group"></i></span>
                        <span class="faq-cat-name">All Questions</span>
                        <span class="faq-cat-count" id="countAll">14</span>
                    </button>
                    <button type="button" class="faq-cat-btn" data-cat="general">
                        <span class="faq-cat-icon cat-blue"><i class="fa-solid fa-circle-question"></i></span>
                        <span class="faq-cat-name">General</span>
                        <span class="faq-cat-count">3</span>
                    </button>
                    <button type="button" class="faq-cat-btn" data-cat="students">
                        <span class="faq-cat-icon cat-green"><i class="fa-solid fa-user-graduate"></i></span>
                        <span class="faq-cat-name">For Students</span>
                        <span class="faq-cat-count">3</span>
                    </button>
                    <button type="button" class="faq-cat-btn" data-cat="companies">
                        <span class="faq-cat-icon cat-purple"><i class="fa-solid fa-building"></i></span>
                        <span class="faq-cat-name">For Companies</span>
                        <span class="faq-cat-count">3</span>
                    </button>
                    <button type="button" class="faq-cat-btn" data-cat="applications">
                        <span class="faq-cat-icon cat-orange"><i class="fa-solid fa-file-lines"></i></span>
                        <span class="faq-cat-name">Applications &amp; Interviews</span>
                        <span class="faq-cat-count">3</span>
                    </button>
                    <button type="button" class="faq-cat-btn" data-cat="security">
                        <span class="faq-cat-icon cat-skyblue"><i class="fa-solid fa-shield-halved"></i></span>
                        <span class="faq-cat-name">Security &amp; Account</span>
                        <span class="faq-cat-count">2</span>
                    </button>
                </div>
            </aside>

            <!-- FAQ list -->
            <div class="faq-list-wrap">
                <div id="faqItemsContainer">

                    <!-- GENERAL -->
                    <div class="faq-item" data-category="general">
                        <button type="button" class="faq-question">
                            <span>What is SIMS (Smart Student Internship Management System)?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>SIMS is a centralized web platform that connects students with reputable companies. It streamlines the complete internship lifecycle: discovering verified internships, submitting online applications, taking quizzes or technical tasks, attending scheduled interviews, receiving offer letters, and generating digitally verifiable completion certificates.</p>
                        </div>
                    </div>
                    <div class="faq-item" data-category="general">
                        <button type="button" class="faq-question">
                            <span>Is SIMS free for students?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Yes, registration, browsing internships, applying to companies, taking quizzes, receiving offer letters, and downloading verified internship certificates on SIMS is completely 100% free of charge for all registered students.</p>
                        </div>
                    </div>
                    <div class="faq-item" data-category="general">
                        <button type="button" class="faq-question">
                            <span>How do I contact SIMS support if I face an issue?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>You can reach our dedicated support team via email at <strong>support@sims.com</strong> or call our helpline at <strong>+91 88499 00762</strong> (Monday to Saturday, 9:00 AM to 6:00 PM). You can also send a message via our <a href="contact.aspx" class="faq-link">Contact Us</a> page.</p>
                        </div>
                    </div>

                    <!-- STUDENTS -->
                    <div class="faq-item" data-category="students">
                        <button type="button" class="faq-question">
                            <span>How do I create a student account and apply for internships?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Click on the <strong>Login / Register</strong> button, choose 'Student Registration', fill in your profile information, and verify your email. Once logged in, upload your latest PDF resume in your Student Dashboard and browse through active openings on the Internships page to apply with a single click.</p>
                        </div>
                    </div>
                    <div class="faq-item" data-category="students">
                        <button type="button" class="faq-question">
                            <span>Can I apply for multiple internships at the same time?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Yes! You can apply for multiple internship openings across different domains and companies. You can monitor the real-time progress and review status of every application from your <strong>My Applications</strong> section in the Student Panel.</p>
                        </div>
                    </div>
                    <div class="faq-item" data-category="students">
                        <button type="button" class="faq-question">
                            <span>How do I receive and download my completion certificate?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Upon successfully concluding your internship period and getting your performance approved by the hiring company, a verified digital certificate is automatically generated. You can view, download, or print it anytime with a verifiable QR code from your <strong>Certificates</strong> page.</p>
                        </div>
                    </div>

                    <!-- COMPANIES -->
                    <div class="faq-item" data-category="companies">
                        <button type="button" class="faq-question">
                            <span>How do companies register and post new internship openings?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Companies can register with their organization name, official email, and website. After logging into the Company Panel, you can navigate to <strong>Post Internship</strong> to create new postings with custom role descriptions, required skills, stipends, location/remote type, and durations.</p>
                        </div>
                    </div>
                    <div class="faq-item" data-category="companies">
                        <button type="button" class="faq-question">
                            <span>How can companies screen applicants and review resumes?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Within the Company Panel under <strong>Internships &gt; View Applications</strong>, recruiters can inspect student profiles, download their submitted PDF resumes, check academic backgrounds, and update application statuses (Shortlisted, Interview, Selected, or Rejected).</p>
                        </div>
                    </div>
                    <div class="faq-item" data-category="companies">
                        <button type="button" class="faq-question">
                            <span>Can companies issue offer letters directly from the system?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Yes! The platform includes a built-in Offer Letter and Certificate generator. Once a student is selected, companies can set the stipend, joining date, and terms, and issue a formal digital offer letter that students can view and accept from their portal.</p>
                        </div>
                    </div>

                    <!-- APPLICATIONS & INTERVIEWS -->
                    <div class="faq-item" data-category="applications">
                        <button type="button" class="faq-question">
                            <span>How will I know if my application is shortlisted or an interview is scheduled?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Whenever a company shortlists your application or schedules an interview round, you receive immediate dashboard notifications and an entry in your <strong>My Interviews</strong> tab with date, time, interview mode, and meeting links.</p>
                        </div>
                    </div>
                    <div class="faq-item" data-category="applications">
                        <button type="button" class="faq-question">
                            <span>How do online quizzes and task assessments work?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Companies may assign domain-specific skill quizzes or practical assignments. Students can launch the quiz directly from the Student Panel, complete the timed multiple-choice or practical test, and results are instantly recorded for recruiter evaluation.</p>
                        </div>
                    </div>
                    <div class="faq-item" data-category="applications">
                        <button type="button" class="faq-question">
                            <span>Can I update my resume after submitting an application?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>You can update your default profile resume anytime in your Student Profile. For previously submitted applications, companies review the resume that was attached at the time of submission.</p>
                        </div>
                    </div>

                    <!-- SECURITY & ACCOUNT -->
                    <div class="faq-item" data-category="security">
                        <button type="button" class="faq-question">
                            <span>Is my personal and academic data secure on SIMS?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Yes, all student data, resumes, and company credentials are kept confidential using secure password hashing, authenticated sessions, and role-based permissions. Only verified companies can view candidate application details.</p>
                        </div>
                    </div>
                    <div class="faq-item" data-category="security">
                        <button type="button" class="faq-question">
                            <span>What should I do if I forget my login password?</span>
                            <i class="fa-solid fa-plus"></i>
                        </button>
                        <div class="faq-answer">
                            <p>Click on the <a href="forgot_password.aspx" class="faq-link">Forgot Password</a> link on the Login page, provide your registered email address, and follow the simple OTP verification steps to reset your password safely.</p>
                        </div>
                    </div>
                </div>

                <!-- Empty State -->
                <div id="faqEmptyState" class="faq-empty-state">
                    <div class="faq-empty-icon">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </div>
                    <h4 class="faq-empty-title">No matching questions found</h4>
                    <p class="faq-empty-sub">Try searching with different keywords or switch categories.</p>
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
    <script src="<%= ResolveUrl("~/js/faq.js") %>"></script>
</asp:Content>

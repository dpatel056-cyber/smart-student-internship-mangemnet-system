<%@ Page Title="Frequently Asked Questions - SIMS" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="faq.aspx.cs" Inherits="asp.net.faq" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .faq-sidebar {
            padding: 22px 18px !important;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid #e2e8f0;
        }
        .faq-sidebar h3 {
            margin-bottom: 14px !important;
            font-size: 16px !important;
            font-weight: 700;
            color: #0f172a;
        }
        .faq-cat-list {
            display: flex !important;
            flex-direction: column !important;
            gap: 6px !important;
            margin: 0 !important;
            padding: 0 !important;
            list-style: none !important;
            width: 100% !important;
        }
        .faq-cat-btn {
            width: 100% !important;
            display: flex !important;
            align-items: center !important;
            gap: 12px !important;
            padding: 10px 14px !important;
            border-radius: 10px !important;
            background: transparent !important;
            text-decoration: none !important;
            transition: all .2s ease !important;
            box-sizing: border-box !important;
            margin: 0 !important;
            cursor: pointer;
            border: 1px solid transparent;
        }
        .faq-cat-btn:hover {
            background: #f1f5f9 !important;
        }
        .faq-cat-btn.active {
            background: #eff6ff !important;
            border-color: #bfdbfe !important;
            box-shadow: 0 2px 8px rgba(37,99,235,0.08) !important;
        }
        .faq-cat-icon {
            width: 32px !important;
            height: 32px !important;
            border-radius: 8px !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            color: #fff !important;
            font-size: 13px !important;
            flex-shrink: 0 !important;
        }
        .cat-all { background: #475569 !important; }
        .cat-blue { background: #2563eb !important; }
        .cat-green { background: #16a34a !important; }
        .cat-purple { background: #9333ea !important; }
        .cat-orange { background: #ea580c !important; }
        .cat-pink { background: #db2777 !important; }
        .cat-teal { background: #0d9488 !important; }
        .cat-skyblue { background: #0284c7 !important; }

        .faq-cat-name {
            flex: 1 !important;
            font-size: 14px !important;
            font-weight: 600 !important;
            color: #334155 !important;
            line-height: 1.2 !important;
        }
        .faq-cat-btn.active .faq-cat-name {
            color: #2563eb !important;
            font-weight: 700 !important;
        }
        .faq-cat-count {
            background: #e2e8f0 !important;
            color: #475569 !important;
            font-size: 11.5px !important;
            font-weight: 700 !important;
            min-width: 22px !important;
            height: 20px !important;
            border-radius: 6px !important;
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            padding: 0 6px !important;
            flex-shrink: 0 !important;
            transition: all .2s ease;
        }
        .faq-cat-btn.active .faq-cat-count {
            background: #2563eb !important;
            color: #fff !important;
        }

        /* Search input bar on FAQ page */
        .faq-search-box {
            position: relative;
            margin-bottom: 24px;
        }
        .faq-search-box input {
            width: 100%;
            height: 50px;
            padding: 10px 18px 10px 48px;
            border: 1.5px solid #cbd5e1;
            border-radius: 12px;
            font-size: 14.5px;
            outline: none;
            transition: border-color .2s, box-shadow .2s;
            background: #ffffff;
            box-sizing: border-box;
        }
        .faq-search-box input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 4px rgba(37,99,235,0.12);
        }
        .faq-search-box i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 16px;
        }

        .faq-item {
            background: #ffffff;
            border-radius: 12px;
            margin-bottom: 14px;
            border: 1px solid #e2e8f0;
            overflow: hidden;
            transition: border-color .2s, box-shadow .2s;
        }
        .faq-item:hover {
            border-color: #cbd5e1;
        }
        .faq-item.open {
            border-color: #93c5fd;
            box-shadow: 0 4px 16px rgba(37,99,235,0.06);
        }
        .faq-question {
            width: 100%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 18px 20px;
            background: transparent;
            border: none;
            cursor: pointer;
            text-align: left;
            gap: 16px;
        }
        .faq-question span {
            font-size: 15.5px;
            font-weight: 700;
            color: #1e293b;
            line-height: 1.4;
        }
        .faq-item.open .faq-question span {
            color: #2563eb;
        }
        .faq-question i {
            font-size: 14px;
            color: #64748b;
            flex-shrink: 0;
            transition: transform 0.25s ease;
        }
        .faq-item.open .faq-question i {
            color: #2563eb;
        }
        .faq-answer {
            display: none;
            padding: 0 20px 20px 20px;
            color: #475569;
            font-size: 14px;
            line-height: 1.65;
        }
        .faq-item.open .faq-answer {
            display: block;
        }
        .faq-empty-state {
            display: none;
            text-align: center;
            padding: 50px 20px;
            background: #ffffff;
            border-radius: 14px;
            border: 1px dashed #cbd5e1;
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
                        <li><a href="stories.aspx" data-nav-page="stories.aspx">Success Stories</a></li>
                        <li><a href="about.aspx" data-nav-page="about.aspx">About Us</a></li>
                        <li><a href="contact.aspx" data-nav-page="contact.aspx">Contact Us</a></li>
                        <li><a href="faq.aspx" class="active" data-nav-page="faq.aspx">FAQ</a></li>
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
    <!-- ============ PAGE BANNER ============ -->
    <section class="page-banner">
        <div class="container page-banner-inner">
            <div class="page-banner-text">
                <h1>Frequently Asked Questions</h1>
                <p class="page-banner-desc">Find quick answers to common questions about SIMS, student applications, company postings, interviews, and verified certificates.</p>
            </div>
            <div class="page-banner-media banner-shape-faq">
                <div class="banner-blob"></div>
                <img src="<%= ResolveUrl("~/assets/banner_faq.png") %>" alt="FAQ" class="banner-image">
            </div>
        </div>
    </section>

    <!-- ============ FAQ CONTENT ============ -->
    <section class="faq-section" style="padding: 40px 0 70px 0;">
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
                <!-- Search Box -->
                <div class="faq-search-box">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" id="faqSearchInput" placeholder="Search questions or keywords (e.g., certificate, apply, resume, interview)..." onkeyup="filterFaqs();" />
                </div>

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
                            <p>You can reach our dedicated support team via email at <strong>support@sims.com</strong> or call our helpline at <strong>+91 88499 00762</strong> (Monday to Saturday, 9:00 AM to 6:00 PM). You can also send a message via our <a href="contact.aspx" style="color:#2563eb; font-weight:600; text-decoration:underline;">Contact Us</a> page.</p>
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
                            <p>Click on the <a href="forgot_password.aspx" style="color:#2563eb; font-weight:600; text-decoration:underline;">Forgot Password</a> link on the Login page, provide your registered email address, and follow the simple OTP verification steps to reset your password safely.</p>
                        </div>
                    </div>
                </div>

                <!-- Empty State -->
                <div id="faqEmptyState" class="faq-empty-state">
                    <div style="width: 54px; height: 54px; background: #eff6ff; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; color: #2563eb; font-size: 22px; margin-bottom: 12px;">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </div>
                    <h4 style="font-size: 16px; font-weight: 700; color: #1e293b; margin-bottom: 4px;">No matching questions found</h4>
                    <p style="font-size: 13.5px; color: #64748b; margin: 0;">Try searching with different keywords or switch categories.</p>
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
    <script>
        var currentCategory = 'all';

        function initFaqAccordion() {
            document.querySelectorAll('.faq-question').forEach(function (btn) {
                btn.addEventListener('click', function () {
                    var item = this.closest('.faq-item');
                    var icon = this.querySelector('i');
                    var isOpen = item.classList.contains('open');

                    // Close sibling open items
                    document.querySelectorAll('.faq-item.open').forEach(function (openItem) {
                        if (openItem !== item) {
                            openItem.classList.remove('open');
                            var openIcon = openItem.querySelector('.faq-question i');
                            if (openIcon) {
                                openIcon.classList.remove('fa-minus');
                                openIcon.classList.add('fa-plus');
                            }
                        }
                    });

                    item.classList.toggle('open', !isOpen);
                    if (icon) {
                        icon.classList.toggle('fa-plus', isOpen);
                        icon.classList.toggle('fa-minus', !isOpen);
                    }
                });
            });
        }

        function filterFaqs() {
            var searchVal = (document.getElementById('faqSearchInput').value || '').trim().toLowerCase();
            var items = document.querySelectorAll('.faq-item');
            var visibleCount = 0;

            items.forEach(function (item) {
                var cat = item.getAttribute('data-category');
                var text = item.innerText.toLowerCase();

                var matchesCat = (currentCategory === 'all' || cat === currentCategory);
                var matchesSearch = (searchVal === '' || text.indexOf(searchVal) > -1);

                if (matchesCat && matchesSearch) {
                    item.style.display = '';
                    visibleCount++;
                } else {
                    item.style.display = 'none';
                }
            });

            var emptyEl = document.getElementById('faqEmptyState');
            if (emptyEl) {
                emptyEl.style.display = visibleCount === 0 ? 'block' : 'none';
            }
        }

        document.addEventListener('DOMContentLoaded', function () {
            initFaqAccordion();

            // Open first FAQ item by default
            var firstItem = document.querySelector('.faq-item');
            if (firstItem) {
                firstItem.classList.add('open');
                var firstIcon = firstItem.querySelector('.faq-question i');
                if (firstIcon) {
                    firstIcon.classList.remove('fa-plus');
                    firstIcon.classList.add('fa-minus');
                }
            }

            // Category Tab Clicks
            document.querySelectorAll('.faq-cat-btn').forEach(function (btn) {
                btn.addEventListener('click', function () {
                    document.querySelectorAll('.faq-cat-btn').forEach(function (b) { b.classList.remove('active'); });
                    this.classList.add('active');
                    currentCategory = this.getAttribute('data-cat') || 'all';
                    filterFaqs();
                });
            });
        });
    </script>
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="faq.aspx.cs" Inherits="asp.net.faq" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" contentplaceholderid="ContentPlaceHolder1">
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
                                <button class="icon-btn" id="searchBtn" type="button" aria-label="Search">
                                    <i class="fa-solid fa-magnifying-glass"></i>
                                </button>
                                <button class="icon-btn" id="notifBtn" type="button" aria-label="Notifications">
                                    <i class="fa-regular fa-bell"></i><span class="badge">1</span>
                                </button>
                              <%--  <a href="login.aspx" class="btn btn-primary">Login / Register</a>--%>
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
<asp:Content ID="Content6" runat="server" contentplaceholderid="ContentPlaceHolder2">
  <!-- ============ PAGE BANNER ============ -->
  <section class="page-banner">
    <div class="container page-banner-inner">
      <div class="page-banner-text">
        <h1>Frequently Asked Questions</h1>
        <p class="page-banner-desc">Find answers to common questions about SIMS and how it helps students and companies connect for better opportunities.</p>
      </div>
      <div class="page-banner-media">
        <div class="banner-blob"></div>
        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="FAQ" class="banner-image">
      </div>
    </div>

  </section>

  <!-- ============ FAQ CONTENT ============ -->
  <section class="faq-section">
    <div class="container faq-grid">

      <!-- Sidebar categories -->
      <aside class="faq-sidebar">
        <h3>FAQ Categories</h3>
        <ul class="faq-cat-list" id="faqCatList">
          <!-- Populated by JS -->
        </ul>
      </aside>

      <!-- FAQ list -->
      <div class="faq-list-wrap">
        <ul class="faq-list" id="faqList">
          <!-- Populated by JS -->
        </ul>
        <p class="faq-empty" id="faqEmpty" style="display:none;">No questions found in this category yet.</p>
      </div>

    </div>
  </section>
</asp:Content>

<asp:Content ID="Content7" runat="server" contentplaceholderid="ContentPlaceHolder3">

                <!-- ============ FOOTER ============ -->
                <footer class="site-footer">
                    <div class="container footer-grid">
                        <div class="footer-col footer-about">
                            <a href="index.aspx" class="brand brand-footer"><span class="brand-icon"><i class="fa-solid fa-graduation-cap"></i></span><span class="brand-text"><span class="brand-name">SIMS</span> <span class="brand-sub">Smart Student Internship Management System</span> </span></a>
                            <p class="footer-desc">
                                We bridge the gap between aspiring students and innovative companies by providing the best internship opportunities.
                            </p>
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
                                <li><a href="student-dashboard.aspx"><i class="fa-solid fa-angle-right"></i>Student Dashboard</a></li>
                            </ul>
                        </div>
                        <div class="footer-col">
                            <h4>For Companies</h4>
                            <ul>
                                <li><a href="company-post-internship.aspx"><i class="fa-solid fa-angle-right"></i>Post Internship</a></li>
                                <li><a href="company-manage-internships.aspx"><i class="fa-solid fa-angle-right"></i>Manage Internships</a></li>
                                <li><a href="company-applications.aspx"><i class="fa-solid fa-angle-right"></i>View Applications</a></li>
                                <li><a href="AdminPanel/admin-students.aspx"><i class="fa-solid fa-angle-right"></i>Find Talents</a></li>
                                <li><a href="company-dashboard.aspx"><i class="fa-solid fa-angle-right"></i>Company Dashboard</a></li>
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
                            <p>
                                Get the latest updates about internships, career tips and more.
                            </p>
                            <div class="newsletter-form">
                                <asp:TextBox
                                    ID="TextBox1"
                                    runat="server"
                                    TextMode="Email"
                                    CssClass="newsletter-input"
                                    placeholder="Enter your email address" Height="45px" Width="200px"></asp:TextBox>
                                <button type="submit" class="newsletter-btn" style="height: 45px; width: 60px">
                                    <i class="fa-solid fa-paper-plane"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <div class="container footer-bottom-inner">
                            <p>
                                &copy; 2026 SIMS - Smart Student Internship Management System. All rights reserved.
                            </p>
                            <div class="footer-bottom-links">
                                <a href="privacy-security.aspx">Privacy Policy</a> <span>|</span> <a href="privacy-security.aspx">Terms &amp; Conditions</a> <span>|</span> <a href="privacy-security.aspx">Refund Policy</a> <span>|</span> <a href="help-support.aspx">Support</a>
                            </div>
                        </div>
                    </div>
                    <button class="scroll-top" id="scrollTopBtn" type="button" aria-label="Scroll to top">
                        <i class="fa-solid fa-chevron-up"></i>
                    </button>
                </footer>

                <script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
                <script src="<%= ResolveUrl("~/js/script.js") %>"></script>
            

    <script src="<%= ResolveUrl("~/js/faq-data.js") %>"></script>
</asp:Content>




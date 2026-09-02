<%@ Page Title="" Language="C#" MasterPageFile="~/public.Master" AutoEventWireup="true" CodeBehind="stories.aspx.cs" Inherits="asp.net.stories" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content6" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <!-- ============ STORIES BANNER ============ -->
  <section class="stories-banner">
    <div class="about-dots"></div>


    <div class="container stories-banner-inner">
      <div class="stories-banner-text">
        <h1>Success Stories</h1>
        <p class="stories-tagline">Real students. Real opportunities. Real success.</p>
        <p class="stories-desc">
          Discover how SIMS has helped students like you find the right internships, gain valuable experience and build a successful career.
        </p>
      </div>

      <div class="stories-banner-media">
        <div class="banner-blob"></div>
        <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="SIMS student success" class="banner-image">
      </div>
    </div>
  </section>

  <!-- ============ FILTER TABS ============ -->
  <section class="story-filters-wrap">
    <div class="container">
      <div class="story-filters" id="storyFilters">
        <button type="button" class="filter-tab active" data-filter="all"><i class="fa-solid fa-star"></i> All Stories</button>
        <button type="button" class="filter-tab" data-filter="students"><i class="fa-solid fa-user-graduate"></i> For Students</button>
        <button type="button" class="filter-tab" data-filter="companies"><i class="fa-solid fa-building"></i> For Companies</button>
        <button type="button" class="filter-tab" data-filter="experiences"><i class="fa-solid fa-briefcase"></i> Internship Experiences</button>
        <button type="button" class="filter-tab" data-filter="growth"><i class="fa-solid fa-arrow-trend-up"></i> Career Growth</button>
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
            <img src="https://randomuser.me/api/portraits/women/68.jpg" alt="Riya Patel" class="story-avatar">
            <div>
              <div class="story-name">Riya Patel</div>
              <div class="story-role">Web Development Intern</div>
            </div>
          </div>
          <p class="story-quote">SIMS helped me find the perfect internship where I learned so much and grew my skills. The platform made the whole process so easy!</p>
          <div class="story-footer">
            <span class="story-placed"><i class="fa-solid fa-location-dot"></i> Placed at</span>
            <img src="<%= ResolveUrl("~/assets/logo-tcs.svg") %>" alt="TCS" class="story-company-logo">
          </div>
          <div class="story-badge-row">
            <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i> Full-time Offer</span>
          </div>
        </div>

        <!-- Story 2 -->
        <div class="story-card" data-category="students growth">
          <i class="fa-solid fa-quote-right story-quote-icon"></i>
          <div class="story-head">
            <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Devansh Shah" class="story-avatar">
            <div>
              <div class="story-name">Devansh Shah</div>
              <div class="story-role">Data Analyst Intern</div>
            </div>
          </div>
          <p class="story-quote">Thanks to SIMS, I got an opportunity to work with amazing team and real-time projects. It was a turning point in my career.</p>
          <div class="story-footer">
            <span class="story-placed"><i class="fa-solid fa-location-dot"></i> Placed at</span>
            <img src="<%= ResolveUrl("~/assets/logo-deloitte.svg") %>" alt="Deloitte" class="story-company-logo">
          </div>
          <div class="story-badge-row">
            <span class="story-badge badge-ppo"><i class="fa-solid fa-circle-check"></i> Pre-Placement Offer</span>
          </div>
        </div>

        <!-- Story 3 -->
        <div class="story-card" data-category="students experiences">
          <i class="fa-solid fa-quote-right story-quote-icon"></i>
          <div class="story-head">
            <img src="https://randomuser.me/api/portraits/women/65.jpg" alt="Neha Singh" class="story-avatar">
            <div>
              <div class="story-name">Neha Singh</div>
              <div class="story-role">UI/UX Design Intern</div>
            </div>
          </div>
          <p class="story-quote">The internship I found on SIMS helped me build my portfolio and confidence. I am now working as a designer at a great company!</p>
          <div class="story-footer">
            <span class="story-placed"><i class="fa-solid fa-location-dot"></i> Placed at</span>
            <img src="<%= ResolveUrl("~/assets/logo-google.png") %>" alt="Google" class="story-company-logo">
          </div>
          <div class="story-badge-row">
            <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i> Full-time Offer</span>
          </div>
        </div>

        <!-- Story 4 -->
        <div class="story-card" data-category="students growth">
          <i class="fa-solid fa-quote-right story-quote-icon"></i>
          <div class="story-head">
            <img src="https://randomuser.me/api/portraits/men/45.jpg" alt="Aman Verma" class="story-avatar">
            <div>
              <div class="story-name">Aman Verma</div>
              <div class="story-role">Marketing Intern</div>
            </div>
          </div>
          <p class="story-quote">The SIMS platform is user-friendly and has many opportunities. I found the right internship that matched my skills and goals.</p>
          <div class="story-footer">
            <span class="story-placed"><i class="fa-solid fa-location-dot"></i> Placed at</span>
            <img src="<%= ResolveUrl("~/assets/logo-amazon.png") %>" alt="Amazon" class="story-company-logo">
          </div>
          <div class="story-badge-row">
            <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i> Full-time Offer</span>
          </div>
        </div>

        <!-- Story 5 -->
        <div class="story-card hidden-story" data-category="students companies">
          <i class="fa-solid fa-quote-right story-quote-icon"></i>
          <div class="story-head">
            <img src="https://randomuser.me/api/portraits/women/50.jpg" alt="Priya Mehta" class="story-avatar">
            <div>
              <div class="story-name">Priya Mehta</div>
              <div class="story-role">Software Engineer Intern</div>
            </div>
          </div>
          <p class="story-quote">SIMS made it simple to apply and track my applications. Within weeks I had an offer from a company I truly wanted to work at.</p>
          <div class="story-footer">
            <span class="story-placed"><i class="fa-solid fa-location-dot"></i> Placed at</span>
            <img src="<%= ResolveUrl("~/assets/logo-infosys.png") %>" alt="Infosys" class="story-company-logo">
          </div>
          <div class="story-badge-row">
            <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i> Full-time Offer</span>
          </div>
        </div>

        <!-- Story 6 -->
        <div class="story-card hidden-story" data-category="companies growth">
          <i class="fa-solid fa-quote-right story-quote-icon"></i>
          <div class="story-head">
            <img src="https://randomuser.me/api/portraits/men/76.jpg" alt="Karan Joshi" class="story-avatar">
            <div>
              <div class="story-name">Karan Joshi</div>
              <div class="story-role">Business Analyst Intern</div>
            </div>
          </div>
          <p class="story-quote">The mentorship and real project exposure I got through my SIMS internship gave my career the head start I was looking for.</p>
          <div class="story-footer">
            <span class="story-placed"><i class="fa-solid fa-location-dot"></i> Placed at</span>
            <img src="<%= ResolveUrl("~/assets/logo-wipro.svg") %>" alt="Wipro" class="story-company-logo">
          </div>
          <div class="story-badge-row">
            <span class="story-badge badge-ppo"><i class="fa-solid fa-circle-check"></i> Pre-Placement Offer</span>
          </div>
        </div>

        <!-- Story 7 -->
        <div class="story-card hidden-story" data-category="experiences growth">
          <i class="fa-solid fa-quote-right story-quote-icon"></i>
          <div class="story-head">
            <img src="https://randomuser.me/api/portraits/women/33.jpg" alt="Sanya Kapoor" class="story-avatar">
            <div>
              <div class="story-name">Sanya Kapoor</div>
              <div class="story-role">Content Writer Intern</div>
            </div>
          </div>
          <p class="story-quote">My SIMS internship experience taught me discipline and creativity. It shaped the way I approach every project even today.</p>
          <div class="story-footer">
            <span class="story-placed"><i class="fa-solid fa-location-dot"></i> Placed at</span>
            <img src="<%= ResolveUrl("~/assets/logo-flipkart.svg") %>" alt="Flipkart" class="story-company-logo">
          </div>
          <div class="story-badge-row">
            <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i> Full-time Offer</span>
          </div>
        </div>

        <!-- Story 8 -->
        <div class="story-card hidden-story" data-category="students experiences">
          <i class="fa-solid fa-quote-right story-quote-icon"></i>
          <div class="story-head">
            <img src="https://randomuser.me/api/portraits/men/86.jpg" alt="Rohan Iyer" class="story-avatar">
            <div>
              <div class="story-name">Rohan Iyer</div>
              <div class="story-role">Backend Developer Intern</div>
            </div>
          </div>
          <p class="story-quote">I applied through SIMS on a whim and it changed everything. The internship turned into a full-time offer within three months.</p>
          <div class="story-footer">
            <span class="story-placed"><i class="fa-solid fa-location-dot"></i> Placed at</span>
            <img src="<%= ResolveUrl("~/assets/logo-microsoft.png") %>" alt="Microsoft" class="story-company-logo">
          </div>
          <div class="story-badge-row">
            <span class="story-badge badge-fulltime"><i class="fa-solid fa-circle-check"></i> Full-time Offer</span>
          </div>
        </div>

      </div>

      <p class="faq-empty" id="storiesEmpty" style="display:none;">No stories found in this category yet.</p>

      <div class="view-more-wrap">
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




<asp:Content ID="Content8" runat="server" contentplaceholderid="ContentPlaceHolder3">
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
                                Get the latest updates about internships, career tips and more.</p>
                            <div class="newsletter-form">
                                <asp:TextBox
                                    ID="TextBox1"
                                    runat="server"
                                    TextMode="Email"
                                    CssClass="newsletter-input"
                                    placeholder="Enter your email address" Height="45px" Width="200px"></asp:TextBox>
                                <button type="submit" class="newsletter-btn" style="height:45px; width:60px">
                                    <i class="fa-solid fa-paper-plane"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <div class="container footer-bottom-inner">
                            <p>
                                &copy; 2026 SIMS - Smart Student Internship Management System. All rights reserved.</p>
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
                <script src="<%= ResolveUrl("~/js/public-layout.js") %>"></script>
                <script src="<%= ResolveUrl("~/js/script.js") %>"></script>
                <script src="<%= ResolveUrl("~/js/stories.js") %>"></script>
            </asp:Content>
<asp:Content ID="Content9" runat="server" contentplaceholderid="ContentPlaceHolder1">
                <!-- ============ HEADER ============ -->
                <header class="site-header">
                    <!-- Top bar -->
                    <div class="topbar">
                        <div class="container topbar-inner">
                            <p class="topbar-tagline">
                                <i class="fa-solid fa-graduation-cap"></i>Empowering Students. Connecting Companies. Building Careers.
                            </p>
                            <div class="topbar-right">
                                <a href="tel:+918849900762" class="topbar-link"><i class="fa-solid fa-phone"></i>88499 00762 </a><a href="support@sims.com" class="topbar-link"><i class="fa-solid fa-envelope"></i>support@sims.com </a>
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
                                    <li><a href="stories.aspx" class="active" data-nav-page="stories.aspx">Success Stories</a></li>
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
                                            Your internship application at <strong>TechNova Pvt Ltd</strong> was shortlisted.
                                        </p>
                                        <span class="notif-time">2 hours ago</span>
                                    </div>
                                </li>
                                <li class="notif-item"><span class="notif-icon"><i class="fa-solid fa-certificate"></i></span>
                                    <div>
                                        <p>
                                            Your completion certificate is ready to download.
                                        </p>
                                        <span class="notif-time">Yesterday</span>
                                    </div>
                                </li>
                                <li class="notif-item"><span class="notif-icon"><i class="fa-solid fa-building"></i></span>
                                    <div>
                                        <p>
                                            New internship posted by <strong>Bright Solutions</strong>.
                                        </p>
                                        <span class="notif-time">2 days ago</span>
                                    </div>
                                </li>
                            </ul>
                            <a href="#" class="notif-viewall">View All Notifications</a>
                        </div>
                    </div>
                </header>
</asp:Content>




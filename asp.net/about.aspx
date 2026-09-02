<%@ Page Title="" Language="C#" MasterPageFile="~/public.Master" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="asp.net.about" %>
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
                                    <li><a href="companies.aspx" data-nav-page="companies.aspx">Companies</a></li>
                                    <li><a href="stories.aspx" data-nav-page="stories.aspx">Success Stories</a></li>
                                    <li><a href="about.aspx" class="active" data-nav-page="about.aspx">About Us</a></li>
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
<asp:Content ID="Content6" runat="server" contentplaceholderid="ContentPlaceHolder2">
          <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>About Us - SIMS</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
</head>
<body>

<div id="public-header-root"></div>

<main>

  <!-- ============ ABOUT BANNER ============ -->
  <section class="about-banner">
    <div class="about-dots"></div>


    <div class="container about-banner-inner">
      <div class="about-banner-text">
        <h1>About SIMS</h1>
        <p class="about-tagline">Building Connections. Creating Opportunities. Shaping Futures.</p>
        <p class="about-desc">
          SIMS (Smart Student Internship Management System) is a platform that bridges the gap between students and companies by providing the best internship opportunities. We aim to empower students to learn, grow and achieve their career goals.
        </p>
      </div>

      <div class="page-banner-media about-banner-media">
        <div class="banner-blob"></div>
        <img src="../assets/hero-student.png" alt="About SIMS" class="banner-image">
      </div>
    </div>

    <div class="container">
      <div class="about-stats-bar">
        <div class="stat-item">
          <span class="stat-icon icon-blue"><i class="fa-solid fa-user-group"></i></span>
          <div>
            <strong>25K+</strong>
            <p>Students Registered</p>
          </div>
        </div>
        <div class="stat-item">
          <span class="stat-icon icon-purple"><i class="fa-solid fa-building"></i></span>
          <div>
            <strong>1K+</strong>
            <p>Companies Onboarded</p>
          </div>
        </div>
        <div class="stat-item">
          <span class="stat-icon icon-blue"><i class="fa-solid fa-briefcase"></i></span>
          <div>
            <strong>10K+</strong>
            <p>Active Internships</p>
          </div>
        </div>
        <div class="stat-item">
          <span class="stat-icon icon-blue"><i class="fa-solid fa-file-lines"></i></span>
          <div>
            <strong>50K+</strong>
            <p>Applications Submitted</p>
          </div>
        </div>
        <div class="stat-item">
          <span class="stat-icon icon-purple"><i class="fa-solid fa-medal"></i></span>
          <div>
            <strong>95%</strong>
            <p>Student Satisfaction</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- ============ MISSION / VISION / VALUES ============ -->
  <section class="mvv-section">
    <div class="container mvv-grid">

      <div class="mvv-card mvv-mission">
        <span class="mvv-icon"><i class="fa-solid fa-bullseye"></i></span>
        <div>
          <h4>Our Mission</h4>
          <p>To provide a smart, transparent and efficient platform where students can discover the right internships and companies can find the right talent.</p>
        </div>
      </div>

      <div class="mvv-card mvv-vision">
        <span class="mvv-icon"><i class="fa-solid fa-eye"></i></span>
        <div>
          <h4>Our Vision</h4>
          <p>To become the most trusted internship platform that contributes to building a skilled, confident and future-ready generation.</p>
        </div>
      </div>

      <div class="mvv-card mvv-values">
        <span class="mvv-icon"><i class="fa-solid fa-gem"></i></span>
        <div>
          <h4>Our Values</h4>
          <ul class="mvv-values-list">
            <li><i class="fa-solid fa-circle"></i> Transparency</li>
            <li><i class="fa-solid fa-circle"></i> Trust &amp; Integrity</li>
            <li><i class="fa-solid fa-circle"></i> Innovation</li>
            <li><i class="fa-solid fa-circle"></i> Student Success</li>
            <li><i class="fa-solid fa-circle"></i> Excellence</li>
          </ul>
        </div>
      </div>

    </div>
  </section>

  <!-- ============ WHY CHOOSE SIMS ============ -->
  <section class="why-section">
    <div class="container">
      <div class="section-heading">
        <h2>Why Choose SIMS?</h2>
      </div>

      <div class="why-grid">
        <div class="why-item">
          <span class="why-icon icon-blue"><i class="fa-solid fa-shield-halved"></i></span>
          <div>
            <h4>Verified Opportunities</h4>
            <p>All internships are verified by our team for authenticity.</p>
          </div>
        </div>

        <div class="why-item">
          <span class="why-icon icon-blue"><i class="fa-solid fa-paper-plane"></i></span>
          <div>
            <h4>Easy Application</h4>
            <p>Simple and quick application process in just a few clicks.</p>
          </div>
        </div>

        <div class="why-item">
          <span class="why-icon icon-blue"><i class="fa-solid fa-brain"></i></span>
          <div>
            <h4>Smart Matching</h4>
            <p>AI-powered recommendations that match your skills.</p>
          </div>
        </div>

        <div class="why-item">
          <span class="why-icon icon-blue"><i class="fa-solid fa-chart-line"></i></span>
          <div>
            <h4>Career Growth</h4>
            <p>Learn, grow and build your career with the right start.</p>
          </div>
        </div>

        <div class="why-image-wrap">
          <div class="why-dots"></div>
          <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=500&q=80" alt="Students collaborating" class="why-image">
          <span class="hero-dot why-dot"></span>
        </div>
      </div>
    </div>
  </section>

</main>

<div id="public-footer-root"></div>

<script src="../js/global-store.js"></script>
<script src="../js/public-layout.js"></script>
<script src="../js/script.js"></script>
</body>
</html>

</asp:Content>


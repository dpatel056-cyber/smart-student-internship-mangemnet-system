<%@ Page Title="" Language="C#" MasterPageFile="~/public.Master" AutoEventWireup="true" CodeBehind="internship-details.aspx.cs" Inherits="asp.net.internship_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
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
                                    <li><a href="index.aspx" data-nav-page="index.aspx">Home</a></li>
                                    <li><a href="internships.aspx" data-nav-page="internships.aspx">Internships</a></li>
                                    <li><a href="companies.aspx" data-nav-page="companies.aspx">Companies</a></li>
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
                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/login register.png" PostBackUrl="~/login.aspx" Width="150px" />      
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
<title>Internship Details - SIMS | Smart Student Internship Management System</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/internship-module.css">
</head>
<body>

<div id="public-header-root"></div>

<main class="site-main" style="background:#f1f5f9; min-height:80vh;">
  <div class="container" style="padding-top:40px; padding-bottom:60px;">
    <div class="imd-header">
        <div class="imd-cover"></div>
        <div class="imd-content">
          <div class="imd-logo" id="imdLogo">
            <!-- Logo Injected Here -->
          </div>
          
          <h1 class="imd-title" id="imdTitle">Internship Title</h1>
          <div class="imd-company">
            <i class="fa-solid fa-building"></i> <a href="#" id="imdCompanyName">Company Name</a>
            <i class="fa-solid fa-circle-check cp-verified" style="color:#16a34a; font-size:14px; margin-left:4px;"></i>
          </div>
          
          <div class="imd-quick-info">
            <div class="imd-info-pill"><i class="fa-solid fa-location-dot"></i> <span id="imdLocation">Location</span></div>
            <div class="imd-info-pill"><i class="fa-solid fa-briefcase"></i> <span id="imdMode">Mode</span></div>
            <div class="imd-info-pill"><i class="fa-solid fa-indian-rupee-sign"></i> <span id="imdStipend">Stipend</span></div>
            <div class="imd-info-pill"><i class="fa-regular fa-clock"></i> <span id="imdDuration">Duration</span></div>
          </div>
        </div>
      </div>

      <!-- Internship Details Layout -->
      <div class="imd-layout">
        
        <!-- Main Content -->
        <div class="imd-main">
          
          <div class="imd-section" id="overview-section">
            <h3 class="imd-section-title">Overview</h3>
            <p class="imd-text" id="imdOverview">Loading overview...</p>
          </div>
          
          <div class="imd-section" id="responsibilities-section">
            <h3 class="imd-section-title">Responsibilities</h3>
            <ul class="imd-list" id="imdResponsibilities">
              <!-- List injected here -->
            </ul>
          </div>
          
          <div class="imd-section" id="requirements-section">
            <h3 class="imd-section-title">Requirements</h3>
            <ul class="imd-list" id="imdRequirements">
              <!-- List injected here -->
            </ul>
          </div>
          
          <div class="imd-section" id="benefits-section">
            <h3 class="imd-section-title">Benefits &amp; Perks</h3>
            <div class="imd-skills" id="imdBenefits">
              <!-- Badges injected here -->
            </div>
          </div>
          
        </div>
        
        <!-- Sidebar Content -->
        <aside class="imd-sidebar">
          
          <div class="imd-side-card">
            <h3 class="imd-side-title">Quick Actions</h3>
            <div class="imd-actions">
             <%-- <a href="#" class="btn btn-primary imd-btn-apply" id="applyBtn"><i class="fa-solid fa-paper-plane"></i> Apply Now</a>--%>
                <asp:ImageButton ID="ImageButton1" runat="server" Height="50px" ImageUrl="~/apply now.png" Width="300px" />             
                <button class="btn imd-btn-save" id="saveBtn"><i class="fa-regular fa-bookmark"></i> Save Internship</button>
            </div>
          </div>
          
          <div class="imd-side-card">
            <h3 class="imd-side-title">Job Details</h3>
            <ul class="imd-meta-list">
              <li>
                <span class="imd-meta-label">Job Title</span>
                <span class="imd-meta-value" id="jdTitle">-</span>
              </li>
              <li>
                <span class="imd-meta-label">Industry</span>
                <span class="imd-meta-value" id="jdIndustry">-</span>
              </li>
              <li>
                <span class="imd-meta-label">Job Type</span>
                <span class="imd-meta-value" id="jdType">Internship</span>
              </li>
              <li>
                <span class="imd-meta-label">Experience</span>
                <span class="imd-meta-value" id="jdExperience">Fresher / Student</span>
              </li>
              <li>
                <span class="imd-meta-label">Openings</span>
                <span class="imd-meta-value" id="jdOpenings">-</span>
              </li>
              <li>
                <span class="imd-meta-label">Start Date</span>
                <span class="imd-meta-value" id="jdStartDate">Immediate</span>
              </li>
              <li>
                <span class="imd-meta-label">Apply By</span>
                <span class="imd-meta-value" id="jdDeadline">-</span>
              </li>
            </ul>
          </div>
          
          <div class="imd-side-card">
            <h3 class="imd-side-title">Skills Required</h3>
            <div class="imd-skills" id="imdSkills">
              <!-- Skills injected here -->
            </div>
          </div>
          
          <div class="imd-side-card" style="text-align: center;">
            <h3 class="imd-side-title">Share Internship</h3>
            <div class="imd-share-links">
              <button class="imd-share-btn" aria-label="Share on LinkedIn"><i class="fa-brands fa-linkedin-in"></i></button>
              <button class="imd-share-btn" aria-label="Share on Twitter"><i class="fa-brands fa-x-twitter"></i></button>
              <button class="imd-share-btn" aria-label="Share on Facebook"><i class="fa-brands fa-facebook-f"></i></button>
              <button class="imd-share-btn" aria-label="Copy Link"><i class="fa-solid fa-link"></i></button>
            </div>
          </div>
          
        </aside>
      </div>
  </div>
</main>

<div id="public-footer-root"></div>

<script src="../js/global-store.js"></script>
<script src="../js/public-layout.js"></script>
<script src="../js/script.js"></script>
<script src="../js/companies-data.js"></script>
<script src="../js/internships-data.js"></script>
<script src="../js/internship-details.js"></script>
</body>
</html>

</asp:Content>

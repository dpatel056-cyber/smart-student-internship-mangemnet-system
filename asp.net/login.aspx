<%@ Page Title="" Language="C#" MasterPageFile="~/public.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="asp.net.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" contentplaceholderid="ContentPlaceHolder2">
               <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - SIMS | Smart Student Internship Management System</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<div id="public-header-root"></div>


<div class="login-page">
  <div class="login-main">

    <!-- ============ LEFT BRAND PANEL ============ -->
    <div class="login-left">

      

      <h1 class="login-welcome-title">Welcome Back!</h1>
      <p class="login-welcome-desc">
        Login to your account &amp; continue your journey with SIMS.
      </p>

      <div class="login-features">
        <div class="login-feature">
          <span class="login-feature-icon icon-blue"><i class="fa-solid fa-briefcase"></i></span>
          <div>
            <h4>Find the Best Internships</h4>
            <p>Explore thousands of opportunities from top companies.</p>
          </div>
        </div>
        <div class="login-feature">
          <span class="login-feature-icon icon-green"><i class="fa-solid fa-chart-simple"></i></span>
          <div>
            <h4>Track Your Progress</h4>
            <p>Manage applications and track progress in one place.</p>
          </div>
        </div>
        <div class="login-feature">
          <span class="login-feature-icon icon-purple"><i class="fa-solid fa-award"></i></span>
          <div>
            <h4>Learn &amp; Grow</h4>
            <p>Gain real-world experience and build your future.</p>
          </div>
        </div>
      </div>

    </div>

    <!-- ============ RIGHT LOGIN PANEL ============ -->
    <div class="login-right">
      <div class="login-card">

        <h2 class="login-card-title">Login to SIMS</h2>
        <p class="login-card-sub">Please enter your credentials to access your account</p>

        <!-- Hidden field for active login role -->
        <asp:HiddenField ID="hfSelectedRole" runat="server" ClientIDMode="Static" Value="student" />

        <!-- Role tabs -->
        <div class="role-tabs" id="roleTabs">
          <div class="role-tab active" data-role="student">
            <i class="fa-solid fa-user-graduate"></i> Student
          </div>
          <div class="role-tab" data-role="company">
            <i class="fa-solid fa-building"></i> Company
          </div>
          <div class="role-tab" data-role="admin">
            <i class="fa-solid fa-shield-halved"></i> Admin
          </div>
        </div>

        <div id="loginForm" class="login-form-wrapper">
          <div class="login-form-group">
            <label for="email">Email / Enrollment Number</label>
            <div class="login-input-wrap">
              <i class="fa-solid fa-user input-icon"></i>
              <asp:TextBox ID="txtemail" ClientIDMode="Static" runat="server" placeholder="Enter your email or enrollment number" autocomplete="username" required="required"></asp:TextBox>
            </div>
            <span class="field-error" id="emailError">Please enter a valid email address or enrollment number.</span>
          </div>

          <div class="login-form-group">
            <label for="password">Password</label>
            <div class="login-input-wrap">
              <i class="fa-solid fa-lock input-icon"></i>
              <asp:TextBox ID="txtpassword" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Enter your password" autocomplete="current-password" required="required"></asp:TextBox>
              <i class="fa-regular fa-eye toggle-password" id="togglePassword"></i>
            </div>
            <span class="field-error" id="passwordError">Password must be at least 6 characters.</span>
          </div>

          <div class="login-row-between">
            <div class="remember-me-wrap" style="display: flex; align-items: center; gap: 8px;">
                <asp:CheckBox ID="rememberMe" ClientIDMode="Static" runat="server" Checked="true" Text="Remember Me" CssClass="remember-me-chk" />
            </div>
            <a href="forgot_password.aspx" class="forgot-link" id="forgotPasswordLink">Forgot Password?</a>
          </div>

            <%-- <asp:LinkButton ID="loginBtn" ClientIDMode="Static" runat="server" CssClass="btn btn-primary btn-login" OnClick="loginBtn_Click">
            <span class="btn-spinner" id="loginSpinner"></span>
            <span class="btn-text">Login</span> <i class="fa-solid fa-arrow-right btn-arrow-icon"></i>
          </asp:LinkButton>--%>
            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/login.png" Width="450px" OnClick="ImageButton2_Click" />
          <asp:Label ID="lblMsg" runat="server" Style="display:block; margin-top:12px; font-weight:600;"></asp:Label>
        </div>

        <div class="login-divider">or</div>

        <p class="login-register-text">
          Don't have an account? <a href="register.aspx" id="registerLink">Register Now</a>
        </p>

        <div class="login-secure-note">
          <i class="fa-solid fa-shield-halved"></i> Your data is protected and secure with us.
        </div>

        <div class="login-demo-hint" id="demoHint" data-role="student">
          <span id="demoHintStudent"><strong>Demo Student Login:</strong> student@sims.com or ENR2024001 &nbsp;|&nbsp; Password: student123</span>
          <span id="demoHintCompany" style="display:none;"><strong>Demo Company Login:</strong> company@sims.com &nbsp;|&nbsp; Password: company123</span>
          <span id="demoHintAdmin" style="display:none;"><strong>Admin Login:</strong> admin@sims.com &nbsp;|&nbsp; Password: admin123</span>
        </div>

      </div>
    </div>

  </div>

  <div id="public-footer-root"></div>
</div>

<!-- Toast notification -->
<div class="login-toast" id="loginToast">
  <i class="fa-solid fa-circle-check"></i>
  <span id="loginToastMsg">Login successful!</span>
</div>



<script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
<script src="<%= ResolveUrl("~/js/script.js") %>"></script>
<script src="<%= ResolveUrl("~/js/login.js?v=2") %>"></script>
</body>
</html>
</asp:Content>

<asp:Content ID="Content6" runat="server" contentplaceholderid="ContentPlaceHolder1">
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
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/login register.png" PostBackUrl="~/login.aspx" Width="150px" />      
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

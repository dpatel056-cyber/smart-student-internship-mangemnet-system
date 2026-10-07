<%@ Page Title="" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="asp.net.login" %>
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
<link rel="stylesheet" href="../css/style.css">
</head>
<body>
<div id="public-header-root"></div>
<div class="login-page">
  <div class="login-main">
    <!-- ============ LEFT BRAND PANEL ============ -->
    <div class="login-left">
      <div class="auth-pill-badge">
        <i class="fa-solid fa-graduation-cap"></i> <span>Smart Internship Ecosystem</span>
      </div>
      <h1 class="login-welcome-title">Welcome Back to <span>SIMS</span></h1>
      <p class="login-welcome-desc">
        Login to your account &amp; continue your internship journey with leading companies across India.
      </p>
      <div class="login-features">
        <div class="login-feature">
          <span class="login-feature-icon icon-blue"><i class="fa-solid fa-briefcase"></i></span>
          <div>
            <h4>Find Top Internships</h4>
            <p>Explore thousands of verified opportunities from top companies.</p>
          </div>
        </div>
        <div class="login-feature">
          <span class="login-feature-icon icon-green"><i class="fa-solid fa-chart-line"></i></span>
          <div>
            <h4>Track Live Progress</h4>
            <p>Manage applications and interview updates in one place.</p>
          </div>
        </div>
        <div class="login-feature">
          <span class="login-feature-icon icon-purple"><i class="fa-solid fa-award"></i></span>
          <div>
            <h4>Learn &amp; Get Placed</h4>
            <p>Gain real-world experience and build your dream career.</p>
          </div>
        </div>
      </div>
      <!-- Website Related Illustration & Floating Cards -->
      <div class="login-illustration-wrap login-shape-auth">
        <div class="login-blob"></div>
        <img src="<%= ResolveUrl("~/assets/banner_login.png") %>" alt="SIMS Secure Login" class="login-illustration-img" />
        <div class="login-float-card pos-1">
          <span class="login-float-icon icon-blue"><i class="fa-solid fa-briefcase"></i></span>
          <div>
            <strong>10K+</strong>
            <span>Active Internships</span>
          </div>
        </div>
        <div class="login-float-card pos-2">
          <span class="login-float-icon icon-green"><i class="fa-solid fa-user-graduate"></i></span>
          <div>
            <strong>25K+</strong>
            <span>Placed Students</span>
          </div>
        </div>
      </div>
      <!-- Trusted Recruiter Logos -->
      <div class="auth-trusted-strip">
        <span>Trusted by Top Recruiters</span>
        <div class="auth-trusted-logos">
          <img src="<%= ResolveUrl("~/assets/logo-google.png") %>" alt="Google" />
          <img src="<%= ResolveUrl("~/assets/logo-microsoft.png") %>" alt="Microsoft" />
          <img src="<%= ResolveUrl("~/assets/logo-tcs.svg") %>" alt="TCS" />
          <img src="<%= ResolveUrl("~/assets/logo-infosys.png") %>" alt="Infosys" />
          <img src="<%= ResolveUrl("~/assets/logo-amazon.png") %>" alt="Amazon" />
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
            <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/assets/login.png" Width="450px" OnClick="ImageButton2_Click" />
          <asp:Label ID="lblMsg" runat="server" Style="display:block; margin-top:12px; font-weight:600;"></asp:Label>
        </div>
        <div class="login-divider">or</div>
        <p class="login-register-text">
          Don't have an account? <a href="register.aspx" id="registerLink">Register Now</a>
        </p>
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
                                <%--                                <a href="login.aspx" class="btn btn-primary">Login / Register</a>--%>
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/assets/login register.png" PostBackUrl="~/PublicPanel/login.aspx" Width="150px" />
                                <button class="hamburger" id="hamburgerBtn" type="button" aria-label="Menu">
                                    <i class="fa-solid fa-bars"></i>
                                </button>
                            </div>
                        </div>
                        </div>
                        </div>
    </header>
</asp:Content>

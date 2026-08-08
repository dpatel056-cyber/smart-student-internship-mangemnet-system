<%@ Page Title="" Language="C#" MasterPageFile="~/public.Master" AutoEventWireup="true" CodeBehind="forgot_password.aspx.cs" Inherits="asp.net.forgot_password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
                <!-- ============================================================
     FORGOT PASSWORD FLOW (Modal)
     Forgot Password -> OTP Verification -> Reset Password -> Back to Student Login
     Kept as a modal overlay on the SAME login page as requested
     ("Navo Login page banavvano nathi" - no separate/new page created).
     ASP.NET NOTE: this modal can equally be split into three
     UpdatePanels inside the same ContentPlaceHolder, or wired to
     Web API endpoints (SendOtp / VerifyOtp / ResetPassword) called
     from fp.js's fetch() calls without changing any markup below.
============================================================ -->
<style>
  .fp-page-wrapper {
      background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
      padding: 60px 20px;
      min-height: calc(100vh - 200px);
      display: flex;
      align-items: center;
      justify-content: center;
      position: relative;
  }
  .fp-page-wrapper::before {
      content: '';
      position: absolute;
      top: -50%; left: -50%;
      width: 200%; height: 200%;
      background: radial-gradient(circle, rgba(37,99,235,0.03) 0%, rgba(255,255,255,0) 70%);
      pointer-events: none;
  }
  .fp-premium-card {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 24px;
      box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.1), 0 0 0 1px rgba(226, 232, 240, 0.8);
      width: 100%;
      max-width: 500px;
      padding: 40px;
      position: relative;
      overflow: hidden;
      z-index: 10;
  }
  .fp-premium-card::before {
      content: '';
      position: absolute;
      top: 0; left: 0; right: 0; height: 6px;
      background: linear-gradient(90deg, #2563eb, #7c3aed, #db2777);
  }
  .fp-steps {
      margin-bottom: 40px;
      background: #f1f5f9;
      padding: 10px 20px;
      border-radius: 50px;
      box-shadow: inset 0 2px 4px rgba(0,0,0,0.04);
  }
  .fp-step-circle {
      width: 32px; height: 32px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      transition: all 0.3s ease;
  }
  .fp-step.active .fp-step-circle {
      transform: scale(1.1);
  }
  .modal-icon {
      width: 70px; height: 70px;
      font-size: 32px;
      margin: 0 auto 25px;
      box-shadow: 0 15px 30px -5px rgba(37, 99, 235, 0.2);
      transition: transform 0.3s ease;
  }
  .modal-icon:hover {
      transform: translateY(-5px);
  }
  .modal-title {
      font-size: 26px;
      font-weight: 800;
      color: #0f172a;
      margin-bottom: 12px;
      letter-spacing: -0.5px;
  }
  .modal-sub {
      font-size: 15px;
      color: #475569;
      margin-bottom: 35px;
      line-height: 1.6;
  }
  .login-input-wrap input {
      border-radius: 12px;
      padding: 14px 14px 14px 45px;
      border: 2px solid #e2e8f0;
      background: #f8fafc;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  }
  .login-input-wrap input:focus {
      border-color: #2563eb;
      background: #fff;
      box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
  }
  .btn-login {
      border-radius: 12px;
      padding: 15px;
      font-size: 16px;
      font-weight: 700;
      letter-spacing: 0.5px;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      text-transform: uppercase;
  }
  .btn-login:hover {
      transform: translateY(-3px);
      box-shadow: 0 15px 25px -5px rgba(37, 99, 235, 0.3);
  }
  .otp-box {
      width: 54px; height: 64px;
      font-size: 28px;
      font-weight: 700;
      border-radius: 14px;
      border: 2px solid #cbd5e1;
      background: #f8fafc;
      margin: 0 6px;
      transition: all 0.3s ease;
      color: #1e293b;
  }
  .otp-box:focus {
      border-color: #7c3aed;
      background: #fff;
      box-shadow: 0 0 0 4px rgba(124, 58, 237, 0.15);
      transform: translateY(-4px);
  }
  .forgot-link-btn {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      font-weight: 600;
      color: #64748b;
      transition: color 0.2s ease;
  }
  .forgot-link-btn:hover {
      color: #2563eb;
  }
</style>

<div class="fp-page-wrapper" id="fpModalOverlay">
  <div class="fp-premium-card" id="fpModalBox">

    <button type="button" class="modal-close" id="fpCloseBtn" aria-label="Close" style="display: none;">
      <i class="fa-solid fa-xmark"></i>
    </button>

    <!-- Step indicator -->
    <div class="fp-steps">
      <div class="fp-step active" data-step-indicator="1">
        <span class="fp-step-circle">1</span><span class="fp-step-label">Email</span>
      </div>
      <div class="fp-step-line"></div>
      <div class="fp-step" data-step-indicator="2">
        <span class="fp-step-circle">2</span><span class="fp-step-label">OTP</span>
      </div>
      <div class="fp-step-line"></div>
      <div class="fp-step" data-step-indicator="3">
        <span class="fp-step-circle">3</span><span class="fp-step-label">Reset</span>
      </div>
    </div>

    <!-- ===== STEP 1: Forgot Password - enter email/enrollment ===== -->
    <div class="fp-panel active" id="fpStep1">
      <div class="modal-icon icon-blue"><i class="fa-solid fa-key"></i></div>
      <h3 class="modal-title" style="text-align: center;">Forgot Password?</h3>
      <p class="modal-sub" style="text-align: center;">Enter your registered email or enrollment number. We'll send you a One-Time Password (OTP) to verify it's you.</p>

      <div class="login-form-group">
        <label for="fpEmail" style="font-weight: 600; color: #334155;">Email / Enrollment Number</label>
        <div class="login-input-wrap">
          <i class="fa-solid fa-envelope input-icon"></i>
          <asp:TextBox ID="fpEmail" ClientIDMode="Static" runat="server" placeholder="Enter your email or enrollment number"></asp:TextBox>
        </div>
        <span class="field-error" id="fpEmailError">Please enter a valid registered email or enrollment number.</span>
      </div>

      <asp:ImageButton ID="fpSendOtpBtn" ClientIDMode="Static" runat="server" ImageUrl="~/otp1.png" AlternateText="Send OTP" OnClientClick="return false;" style="margin-top: 15px; width: 100%; max-height: 55px; object-fit: contain; cursor: pointer; display: block; background: transparent; border: none;" />
      
      <div style="text-align: center; margin-top: 25px;">
        <a href="login.aspx" class="forgot-link-btn"><i class="fa-solid fa-arrow-left"></i> Back to Login</a>
      </div>
    </div>

    </div>

  </div>
</div>
<script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
<script src="<%= ResolveUrl("~/js/fp-multi.js") %>"></script>
</body>
</html>
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="ContentPlaceHolder1">
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


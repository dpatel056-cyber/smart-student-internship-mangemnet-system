<%@ Page Title="" Language="C#" MasterPageFile="~/public.Master" AutoEventWireup="true" CodeBehind="reset_password.aspx.cs" Inherits="asp.net.reset_password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" contentplaceholderid="ContentPlaceHolder2">
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

<div class="fp-page-wrapper">
  <div class="fp-premium-card" id="fpModalBox">
    <!-- Step indicator -->
    <div class="fp-steps" id="resetStepsIndicator" style="display:flex; justify-content:space-between; align-items:center;">
      <div class="fp-step">
        <span class="fp-step-circle" style="background:#2563eb; color:white; display:flex; align-items:center; justify-content:center; border-radius:50%;"><i class="fa-solid fa-check"></i></span><span class="fp-step-label">Email</span>
      </div>
      <div class="fp-step-line" style="flex:1; height:2px; background:#cbd5e1; margin:0 10px;"></div>
      <div class="fp-step">
        <span class="fp-step-circle" style="background:#7c3aed; color:white; display:flex; align-items:center; justify-content:center; border-radius:50%;"><i class="fa-solid fa-check"></i></span><span class="fp-step-label">OTP</span>
      </div>
      <div class="fp-step-line" style="flex:1; height:2px; background:#cbd5e1; margin:0 10px;"></div>
      <div class="fp-step active">
        <span class="fp-step-circle" style="background:#10b981; color:white; display:flex; align-items:center; justify-content:center; border-radius:50%;">3</span><span class="fp-step-label">Reset</span>
      </div>
    </div>

    <!-- ===== STEP 3: Reset Password ===== -->
    <div class="fp-panel active" id="fpStep3">
      <div class="modal-icon icon-green" style="display:flex; align-items:center; justify-content:center; border-radius:50%; background:#dcfce7; color:#10b981;"><i class="fa-solid fa-lock-open"></i></div>
      <h3 class="modal-title" style="text-align: center;">New Password</h3>
      <p class="modal-sub" style="text-align: center;">Create a strong new password for your SIMS account.</p>

      <div class="login-form-group">
        <label for="fpNewPassword" style="font-weight: 600; color: #334155;">New Password</label>
        <div class="login-input-wrap">
          <i class="fa-solid fa-lock input-icon"></i>
          <asp:TextBox ID="fpNewPassword" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Enter new password" autocomplete="new-password"></asp:TextBox>
          <i class="fa-regular fa-eye toggle-password" data-target="fpNewPassword"></i>
        </div>
        <span class="field-error" id="fpNewPasswordError" style="display:none; color:#ef4444;">Password must be at least 6 characters.</span>
      </div>

      <div class="login-form-group">
        <label for="fpConfirmPassword" style="font-weight: 600; color: #334155;">Confirm New Password</label>
        <div class="login-input-wrap">
          <i class="fa-solid fa-lock input-icon"></i>
          <asp:TextBox ID="fpConfirmPassword" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Re-enter new password" autocomplete="new-password"></asp:TextBox>
          <i class="fa-regular fa-eye toggle-password" data-target="fpConfirmPassword"></i>
        </div>
        <span class="field-error" id="fpConfirmPasswordError" style="display:none; color:#ef4444;">Passwords do not match.</span>
      </div>

            <asp:ImageButton ID="fpResetPasswordBtn" ClientIDMode="Static" runat="server" ImageUrl="~/otp3.png" AlternateText="Reset Password" OnClientClick="return false;" style="margin-top: 20px; width: 100%; max-height: 55px; object-fit: contain; cursor: pointer; display: block; background: transparent; border: none;" />
    </div>

    <!-- ===== STEP 4: Success ===== -->
    <div class="fp-panel" id="fpStepSuccess" style="display: none;">
      <div class="modal-icon icon-green" style="display:flex; align-items:center; justify-content:center; border-radius:50%; background:#dcfce7; color:#10b981;"><i class="fa-solid fa-circle-check"></i></div>
      <h3 class="modal-title" style="text-align: center;">Reset Successful!</h3>
      <p class="modal-sub" style="text-align: center;">Your password has been changed successfully. You can now login with your new credentials.</p>
      
            <asp:ImageButton ID="btnLoginSuccess" runat="server" ImageUrl="~/login.png" PostBackUrl="~/login.aspx" AlternateText="Login Now" style="margin-top: 30px; width: 100%; max-height: 55px; object-fit: contain; cursor: pointer; display: block; background: transparent; border: none;" />
    </div>

  </div>
</div>
<script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
<script src="<%= ResolveUrl("~/js/fp-multi.js") %>"></script>       
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

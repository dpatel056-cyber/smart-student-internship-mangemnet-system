<%@ Page Title="Forgot Password - SIMS" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="forgot_password.aspx.cs" Inherits="asp.net.forgot_password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/forgot-password.css") %>" />
</asp:Content>

<asp:Content ID="Content3" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <!-- ============ HEADER ============ -->
    <header class="site-header">

        <!-- Top bar -->
        <div class="topbar">
            <div class="container topbar-inner">
                <p class="topbar-tagline">
                    <i class="fa-solid fa-graduation-cap"></i>Empowering Students. Connecting Companies. Building Careers.
                </p>
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
                        <li><a href="faq.aspx" data-nav-page="faq.aspx">FAQ</a></li>
                    </ul>
                </nav>
                <div class="navbar-actions">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/assets/login register.png" PostBackUrl="~/PublicPanel/login.aspx" Width="150px" />
                </div>
            </div>
        </div>
    </header>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="fp-page-wrapper" id="fpModalOverlay">
        <div class="fp-premium-card" id="fpModalBox">
            <asp:ImageButton ID="fpCloseBtn" ClientIDMode="Static" runat="server" ImageUrl="~/assets/btn_modal_close.png" CssClass="modal-close modal-close-hidden" OnClientClick="return false;" />

            <!-- Step indicator -->
            <div class="fp-steps">
                <div class="fp-step active" data-step-indicator="1">
                    <span class="fp-step-circle">1</span>
                    <span class="fp-step-label">Email</span>
                </div>
                <div class="fp-step-line"></div>
                <div class="fp-step" data-step-indicator="2">
                    <span class="fp-step-circle">2</span>
                    <span class="fp-step-label">OTP</span>
                </div>
                <div class="fp-step-line"></div>
                <div class="fp-step" data-step-indicator="3">
                    <span class="fp-step-circle">3</span>
                    <span class="fp-step-label">Reset</span>
                </div>
            </div>

            <!-- ===== STEP 1: Forgot Password - enter email/enrollment ===== -->
            <div class="fp-panel active" id="fpStep1">
                <div class="modal-icon icon-blue"><i class="fa-solid fa-key"></i></div>
                <h3 class="modal-title modal-title-center">Forgot Password?</h3>
                <p class="modal-sub modal-sub-center">Enter your registered email or enrollment number. We'll send you a One-Time Password (OTP) to verify it's you.</p>

                <div class="login-form-group">
                    <label for="fpEmail" class="fp-form-label">Email / Enrollment Number</label>
                    <div class="login-input-wrap">
                        <i class="fa-solid fa-envelope input-icon"></i>
                        <asp:TextBox ID="fpEmail" ClientIDMode="Static" runat="server" placeholder="Enter your email or enrollment number"></asp:TextBox>
                    </div>
                    <span class="field-error" id="fpEmailError">Please enter a valid registered email or enrollment number.</span>
                </div>

                <asp:Label ID="lblMsg" runat="server" CssClass="fp-error-msg"></asp:Label>
                <asp:ImageButton ID="fpSendOtpBtn" ClientIDMode="Static" runat="server" ImageUrl="~/assets/otp1.png" OnClick="fpSendOtpBtn_Click" CssClass="fp-action-submit-btn" />

                <div class="fp-back-link-wrap">
                    <asp:ImageButton ID="btnBackLogin" runat="server" ImageUrl="~/assets/btn_back_login.png" PostBackUrl="~/PublicPanel/login.aspx" Height="40px" CssClass="btn-img-action" />
                </div>
            </div>

        </div>
    </div>

    <script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/fp-multi.js") %>"></script>
</asp:Content>

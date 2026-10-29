<%@ Page Title="" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="verify_otp.aspx.cs" Inherits="asp.net.verify_otp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/forgot-password.css") %>" />
</asp:Content>

<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
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

<asp:Content ID="Content6" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="fp-page-wrapper">
        <div class="fp-premium-card" id="fpModalBox">

            <!-- Step indicator -->
            <div class="fp-steps fp-steps-row">
                <div class="fp-step">
                    <span class="fp-step-circle circle-blue"><i class="fa-solid fa-check"></i></span>
                    <span class="fp-step-label">Email</span>
                </div>
                <div class="fp-step-line"></div>
                <div class="fp-step active">
                    <span class="fp-step-circle circle-purple">2</span>
                    <span class="fp-step-label">OTP</span>
                </div>
                <div class="fp-step-line"></div>
                <div class="fp-step">
                    <span class="fp-step-circle circle-gray">3</span>
                    <span class="fp-step-label">Reset</span>
                </div>
            </div>

            <!-- ===== STEP 2: Verify OTP ===== -->
            <div class="fp-panel active" id="fpStep2">
                <div class="modal-icon icon-purple">
                    <i class="fa-solid fa-shield-halved"></i>
                </div>
                <h3 class="modal-title modal-title-center">Verify OTP</h3>
                <p class="modal-sub modal-sub-center">Enter the 6-digit OTP sent to <strong id="fpMaskedTarget" class="target-email-text"><asp:Label ID="litMaskedEmail" runat="server">your email</asp:Label></strong>.</p>

                <div class="otp-inputs otp-inputs-centered" id="otpInputs">
                    <asp:TextBox ID="otp0" ClientIDMode="Static" runat="server" MaxLength="1" CssClass="otp-box"></asp:TextBox>
                    <asp:TextBox ID="otp1" ClientIDMode="Static" runat="server" MaxLength="1" CssClass="otp-box"></asp:TextBox>
                    <asp:TextBox ID="otp2" ClientIDMode="Static" runat="server" MaxLength="1" CssClass="otp-box"></asp:TextBox>
                    <asp:TextBox ID="otp3" ClientIDMode="Static" runat="server" MaxLength="1" CssClass="otp-box"></asp:TextBox>
                    <asp:TextBox ID="otp4" ClientIDMode="Static" runat="server" MaxLength="1" CssClass="otp-box"></asp:TextBox>
                    <asp:TextBox ID="otp5" ClientIDMode="Static" runat="server" MaxLength="1" CssClass="otp-box"></asp:TextBox>
                </div>

                <asp:Label ID="lblOtpError" runat="server" CssClass="fp-error-msg"></asp:Label>

                <div class="otp-resend-row otp-resend-row-centered">
                    <span id="otpTimerText">Resend OTP in <strong id="otpTimerSeconds" class="otp-timer-highlight">30</strong>s</span>
                    <a href="forgot_password.aspx" id="otpResendLink" class="forgot-link otp-resend-link-hidden">Resend OTP</a>
                </div>

                <div class="login-demo-hint login-demo-hint-box" id="demoOtpHint">
                    <strong>Demo OTP:</strong> <span id="demoOtpValue" class="demo-otp-highlight"><asp:Label ID="litDemoOtp" runat="server">123456</asp:Label></span>
                </div>

                <asp:ImageButton ID="fpVerifyOtpBtn" ClientIDMode="Static" runat="server" ImageUrl="~/assets/otp2.png" OnClick="fpVerifyOtpBtn_Click" CssClass="fp-action-submit-btn" />

                <div class="fp-back-link-wrap-20">
                    <asp:ImageButton ID="btnChangeEmail" runat="server" ImageUrl="~/assets/btn_change_email.png" PostBackUrl="~/PublicPanel/forgot_password.aspx" Height="40px" CssClass="btn-img-action" />
                </div>
            </div>

        </div>
    </div>

    <script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/fp-multi.js") %>"></script>
</asp:Content>

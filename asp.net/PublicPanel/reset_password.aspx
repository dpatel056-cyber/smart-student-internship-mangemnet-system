<%@ Page Title="" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="reset_password.aspx.cs" Inherits="asp.net.reset_password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/forgot-password.css") %>" />
</asp:Content>

<asp:Content ID="Content6" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
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

<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <div class="fp-page-wrapper">
        <div class="fp-premium-card" id="fpModalBox">

            <!-- Step indicator -->
            <div class="fp-steps fp-steps-row" id="resetStepsIndicator">
                <div class="fp-step">
                    <span class="fp-step-circle circle-blue"><i class="fa-solid fa-check"></i></span>
                    <span class="fp-step-label">Email</span>
                </div>
                <div class="fp-step-line"></div>
                <div class="fp-step">
                    <span class="fp-step-circle circle-purple"><i class="fa-solid fa-check"></i></span>
                    <span class="fp-step-label">OTP</span>
                </div>
                <div class="fp-step-line"></div>
                <div class="fp-step active">
                    <span id="step3Circle" runat="server" class="fp-step-circle circle-green">3</span>
                    <span class="fp-step-label">Reset</span>
                </div>
            </div>

            <!-- ===== STEP 3: Reset Password ===== -->
            <div id="divResetForm" runat="server" class="fp-panel active">
                <div class="modal-icon icon-green">
                    <i class="fa-solid fa-lock-open"></i>
                </div>
                <h3 class="modal-title modal-title-center">New Password</h3>
                <p class="modal-sub modal-sub-center">Create a strong new password for your SIMS account (<asp:Label ID="litTargetEmail" runat="server"></asp:Label>).</p>

                <div class="login-form-group">
                    <label for="fpNewPassword" class="fp-form-label">New Password</label>
                    <div class="login-input-wrap">
                        <i class="fa-solid fa-lock input-icon"></i>
                        <asp:TextBox ID="fpNewPassword" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Enter new password" autocomplete="new-password"></asp:TextBox>
                        <i class="fa-regular fa-eye toggle-password" data-target="fpNewPassword"></i>
                    </div>
                </div>

                <div class="login-form-group">
                    <label for="fpConfirmPassword" class="fp-form-label">Confirm New Password</label>
                    <div class="login-input-wrap">
                        <i class="fa-solid fa-lock input-icon"></i>
                        <asp:TextBox ID="fpConfirmPassword" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Re-enter new password" autocomplete="new-password"></asp:TextBox>
                        <i class="fa-regular fa-eye toggle-password" data-target="fpConfirmPassword"></i>
                    </div>
                </div>

                <asp:Label ID="lblResetMsg" runat="server" CssClass="fp-error-msg"></asp:Label>
                <asp:ImageButton ID="fpResetPasswordBtn" ClientIDMode="Static" runat="server" ImageUrl="~/assets/otp3.png" OnClick="fpResetPasswordBtn_Click" CssClass="fp-action-submit-btn" />
            </div>

            <!-- ===== STEP 4: Success ===== -->
            <div id="divResetSuccess" runat="server" class="fp-panel active panel-reset-success" visible="false">
                <div class="modal-icon icon-success-large">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <h3 class="modal-title success-title">Reset Successful!</h3>
                <p class="modal-sub success-sub">Your password has been changed successfully. You can now log in with your new credentials.</p>
                <asp:ImageButton ID="btnLoginSuccess" runat="server" ImageUrl="~/assets/login.png" PostBackUrl="~/PublicPanel/login.aspx" CssClass="fp-action-submit-btn-center" />
            </div>

        </div>
    </div>

    <script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/fp-multi.js") %>"></script>
</asp:Content>

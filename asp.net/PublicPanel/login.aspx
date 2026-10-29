<%@ Page Title="Login - SIMS" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="asp.net.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                    <asp:Image ID="imgLoginBanner" runat="server" ImageUrl="~/assets/banner_login.png" CssClass="login-illustration-img" />
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
                        <asp:Image ID="imgLoginLogoGoogle" runat="server" ImageUrl="~/assets/logo-google.png" />
                        <asp:Image ID="imgLoginLogoMicrosoft" runat="server" ImageUrl="~/assets/logo-microsoft.png" />
                        <asp:Image ID="imgLoginLogoTcs" runat="server" ImageUrl="~/assets/logo-tcs.svg" />
                        <asp:Image ID="imgLoginLogoInfosys" runat="server" ImageUrl="~/assets/logo-infosys.png" />
                        <asp:Image ID="imgLoginLogoAmazon" runat="server" ImageUrl="~/assets/logo-amazon.png" />
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
                        <br />
                        <div class="login-row-between">
                            <div class="remember-me-wrap">
                                <asp:CheckBox ID="rememberMe" ClientIDMode="Static" runat="server" Checked="true" Text="Remember Me" CssClass="remember-me-chk" />
                            </div>
                            <a href="forgot_password.aspx" class="forgot-link" id="forgotPasswordLink">Forgot Password?</a>
                        </div>
                        <br />
                        <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/assets/login.png" CssClass="auth-submit-btn" OnClick="ImageButton2_Click" />
                        <asp:Label ID="lblMsg" runat="server" CssClass="auth-msg-label"></asp:Label>
                    </div>

                    <div class="login-divider">or</div>

                    <p class="login-register-text">
                        Don't have an account? <a href="register.aspx" id="registerLink">Register Now</a>
                    </p>
                </div>
            </div>

        </div>
    </div>

    <!-- Toast notification -->
    <div class="login-toast" id="loginToast">
        <i class="fa-solid fa-circle-check"></i>
        <span id="loginToastMsg">Login successful!</span>
    </div>

    <script src="<%= ResolveUrl("~/js/global-store.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/script.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/login.js?v=2") %>"></script>
</asp:Content>

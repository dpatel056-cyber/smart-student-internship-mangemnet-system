<%@ Page Title="" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="asp.net.register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content5" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
    <!-- ============ PAGE CONTENT ============ -->
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - SIMS | Smart Student Internship Management System</title>
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
                        <i class="fa-solid fa-graduation-cap"></i> <span>Get Started in 2 Minutes</span>
                    </div>
                    <h1 class="login-welcome-title">Start Your Journey with <span>SIMS</span></h1>
                    <p class="login-welcome-desc">
                        Create your account and explore thousands of verified internships from top companies.
                    </p>
                    <div class="login-features">
                        <div class="login-feature">
                            <span class="login-feature-icon icon-blue"><i class="fa-solid fa-compass"></i></span>
                            <div>
                                <h4>Discover Top Opportunities</h4>
                                <p>Filter by domain, stipend, mode and dream roles easily.</p>
                            </div>
                        </div>
                        <div class="login-feature">
                            <span class="login-feature-icon icon-green"><i class="fa-solid fa-bolt"></i></span>
                            <div>
                                <h4>1-Click Direct Applications</h4>
                                <p>Apply instantly with your auto-generated student profile.</p>
                            </div>
                        </div>
                        <div class="login-feature">
                            <span class="login-feature-icon icon-purple"><i class="fa-solid fa-award"></i></span>
                            <div>
                                <h4>Verified Experience Certificates</h4>
                                <p>Industry-accredited credentials ready for LinkedIn.</p>
                            </div>
                        </div>
                    </div>
                    <!-- Website Related Illustration & Floating Cards -->
                    <div class="login-illustration-wrap login-shape-register">
                        <div class="login-blob"></div>
                        <img src="<%= ResolveUrl("~/assets/banner_register.png") %>" alt="SIMS Student Registration" class="login-illustration-img" />
                        <div class="login-float-card pos-1">
                            <span class="login-float-icon icon-blue"><i class="fa-solid fa-building"></i></span>
                            <div>
                                <strong>1.2K+</strong>
                                <span>Top Companies</span>
                            </div>
                        </div>
                        <div class="login-float-card pos-2">
                            <span class="login-float-icon icon-green"><i class="fa-solid fa-circle-check"></i></span>
                            <div>
                                <strong>100%</strong>
                                <span>Verified &amp; Free</span>
                            </div>
                        </div>
                    </div>
                    <!-- Safe & Free Guarantee -->
                    <div class="register-safe-box" style="margin-top: 16px;">
                        <span class="login-feature-icon icon-blue"><i class="fa-solid fa-shield-halved"></i></span>
                        <div>
                            <h4>100% Free &amp; Secure Platform</h4>
                            <p>End-to-end data privacy with bank-grade encryption.</p>
                        </div>
                    </div>
                </div>
                <!-- ============ RIGHT REGISTER PANEL ============ -->
                <div class="login-right register-right">
                    <div class="login-card register-card">
                        <h2 class="login-card-title">Create Your Account</h2>
                        <p class="login-card-sub">Join SIMS and kickstart your career journey</p>
                        <!-- Hidden field for active role -->
                        <asp:HiddenField ID="hfSelectedRole" runat="server" ClientIDMode="Static" Value="student" />
                        <!-- Role tabs -->
                        <div class="role-tabs" id="roleTabs">
                            <div class="role-tab active" data-role="student">
                                <i class="fa-solid fa-user-graduate"></i>Student
                            </div>
                            <div class="role-tab" data-role="company">
                                <i class="fa-solid fa-building"></i>Company
                            </div>
                        </div>
                        <div id="registerForm">
                            <!-- ================= STUDENT FIELDS ================= -->
                            <div class="role-fields active" data-role-fields="student">
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="FullName">Full Name</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-user input-icon"></i>
                                            <asp:TextBox ID="FullName" ClientIDMode="Static" runat="server" placeholder="Enter your full name"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your full name.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="DateOfBirth">Date of Birth</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-regular fa-calendar input-icon"></i>
                                            <asp:TextBox ID="DateOfBirth" ClientIDMode="Static" runat="server" TextMode="Date" placeholder="DD / MM / YYYY"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please select your date of birth.</span>
                                    </div>
                                </div>
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="Email">Email Address</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-envelope input-icon"></i>
                                            <asp:TextBox ID="Email" ClientIDMode="Static" runat="server" TextMode="Email" placeholder="Enter your email address"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter a valid email address.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="ContactNo">Mobile Number</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-phone input-icon"></i>
                                            <asp:TextBox ID="ContactNo" ClientIDMode="Static" runat="server" TextMode="Phone" placeholder="Enter mobile number"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter a valid mobile number.</span>
                                    </div>
                                </div>
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="EnrollmentNo">Enrollment Number</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-id-card input-icon"></i>
                                            <asp:TextBox ID="EnrollmentNo" ClientIDMode="Static" runat="server" placeholder="e.g. 24FOTCA11001"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your enrollment number.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="Password">Password</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-lock input-icon"></i>
                                            <asp:TextBox ID="Password" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Create a password"></asp:TextBox>
                                            <i class="fa-regular fa-eye toggle-password" data-target="s_password"></i>
                                        </div>
                                        <span class="field-error">Password must be at least 6 characters.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="ConfirmPassword">Confirm Password</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-lock input-icon"></i>
                                            <asp:TextBox ID="ConfirmPassword" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Confirm your password"></asp:TextBox>
                                            <i class="fa-regular fa-eye toggle-password" data-target="s_confirm"></i>
                                        </div>
                                        <span class="field-error">Passwords do not match.</span>
                                    </div>
                                </div>
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="College">College / University</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-building-columns input-icon"></i>
                                            <asp:TextBox ID="College" ClientIDMode="Static" runat="server" placeholder="Enter your college or university name"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your college / university.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="Course">Course / Degree</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-graduation-cap input-icon"></i>
                                            <asp:DropDownList ID="Course" ClientIDMode="Static" runat="server">
                                                <asp:ListItem Value="">Select your course</asp:ListItem>
                                                <asp:ListItem Value="BCA" Text="BCA"></asp:ListItem>
                                                <asp:ListItem Value="MCA" Text="MCA"></asp:ListItem>
                                                <asp:ListItem Value="B.Tech" Text="B.Tech"></asp:ListItem>
                                                <asp:ListItem Value="M.Tech" Text="M.Tech"></asp:ListItem>
                                                <asp:ListItem Value="B.Sc IT" Text="B.Sc IT"></asp:ListItem>
                                                <asp:ListItem Value="M.Sc IT" Text="M.Sc IT"></asp:ListItem>
                                                <asp:ListItem Value="B.Sc CS" Text="B.Sc CS"></asp:ListItem>
                                                <asp:ListItem Value="M.Sc CS" Text="M.Sc CS"></asp:ListItem>
                                                <asp:ListItem Value="Diploma Engineering" Text="Diploma Engineering"></asp:ListItem>
                                                <asp:ListItem Value="MBA" Text="MBA"></asp:ListItem>
                                            </asp:DropDownList>
                                            <i class="fa-solid fa-chevron-down select-caret"></i>
                                        </div>
                                        <span class="field-error">Please select your course.</span>
                                    </div>
                                </div>
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="GraduationYear">Graduation Year</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-regular fa-calendar input-icon"></i>
                                            <asp:DropDownList ID="GraduationYear" ClientIDMode="Static" runat="server">
                                                <asp:ListItem Value="">Select year</asp:ListItem>
                                                <asp:ListItem>2024</asp:ListItem>
                                                <asp:ListItem>2025</asp:ListItem>
                                                <asp:ListItem>2026</asp:ListItem>
                                                <asp:ListItem>2027</asp:ListItem>
                                                <asp:ListItem>2028</asp:ListItem>
                                                <asp:ListItem>2029</asp:ListItem>
                                                <asp:ListItem>2030</asp:ListItem>
                                            </asp:DropDownList>
                                            <i class="fa-solid fa-chevron-down select-caret"></i>
                                        </div>
                                        <span class="field-error">Please select your graduation year.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="CGPA">CGPA</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-graduation-cap input-icon"></i>
                                            <asp:TextBox ID="CGPA" ClientIDMode="Static" runat="server" placeholder="Enter your CGPA"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your CGPA.</span>
                                    </div>
                                </div>
                            </div>
                            <!-- ================= COMPANY FIELDS ================= -->
                            <div class="role-fields" data-role-fields="company">
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="c_company">Company Name</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-building input-icon"></i>
                                            <asp:TextBox ID="c_company" ClientIDMode="Static" runat="server" placeholder="Enter your company name"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your company name.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="c_contact">Contact Person Name</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-user input-icon"></i>
                                            <asp:TextBox ID="c_contact" ClientIDMode="Static" runat="server" placeholder="Enter HR / contact person name"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter the contact person's name.</span>
                                    </div>
                                </div>
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="c_email">Email Address</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-envelope input-icon"></i>
                                            <asp:TextBox ID="c_email" ClientIDMode="Static" runat="server" TextMode="Email" placeholder="Enter your company email address"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter a valid email address.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="c_mobile">Mobile Number</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-phone input-icon"></i>
                                            <asp:TextBox ID="c_mobile" ClientIDMode="Static" runat="server" TextMode="Phone" placeholder="Enter mobile number"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter a valid mobile number.</span>
                                    </div>
                                </div>
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="c_password">Password</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-lock input-icon"></i>
                                            <asp:TextBox ID="c_password" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Create a password"></asp:TextBox>
                                            <i class="fa-regular fa-eye toggle-password" data-target="c_password"></i>
                                        </div>
                                        <span class="field-error">Password must be at least 6 characters.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="c_confirm">Confirm Password</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-lock input-icon"></i>
                                            <asp:TextBox ID="c_confirm" ClientIDMode="Static" runat="server" TextMode="Password" placeholder="Confirm your password"></asp:TextBox>
                                            <i class="fa-regular fa-eye toggle-password" data-target="c_confirm"></i>
                                        </div>
                                        <span class="field-error">Passwords do not match.</span>
                                    </div>
                                </div>
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="c_website">Company Website</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-globe input-icon"></i>
                                            <asp:TextBox ID="c_website" ClientIDMode="Static" runat="server" placeholder="www.yourcompany.com"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your company website.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="c_industry">Industry Type</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-industry input-icon"></i>
                                            <asp:DropDownList ID="c_industry" ClientIDMode="Static" runat="server">
                                                <asp:ListItem Value="">Select industry type</asp:ListItem>
                                                <asp:ListItem>IT / Software</asp:ListItem>
                                                <asp:ListItem>Finance</asp:ListItem>
                                                <asp:ListItem>Healthcare</asp:ListItem>
                                                <asp:ListItem>Education</asp:ListItem>
                                                <asp:ListItem>Manufacturing</asp:ListItem>
                                                <asp:ListItem>Retail</asp:ListItem>
                                                <asp:ListItem>E-commerce</asp:ListItem>
                                                <asp:ListItem>Other</asp:ListItem>
                                            </asp:DropDownList>
                                            <i class="fa-solid fa-chevron-down select-caret"></i>
                                        </div>
                                        <span class="field-error">Please select an industry type.</span>
                                    </div>
                                </div>
                                <div class="form-row-two">
                                    <div class="login-form-group">
                                        <label for="c_size">Company Size</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-users input-icon"></i>
                                            <asp:DropDownList ID="c_size" ClientIDMode="Static" runat="server">
                                                <asp:ListItem Value="">Select company size</asp:ListItem>
                                                <asp:ListItem>1 - 10 Employees</asp:ListItem>
                                                <asp:ListItem>11 - 50 Employees</asp:ListItem>
                                                <asp:ListItem>51 - 200 Employees</asp:ListItem>
                                                <asp:ListItem>201 - 500 Employees</asp:ListItem>
                                                <asp:ListItem>500+ Employees</asp:ListItem>
                                            </asp:DropDownList>
                                            <i class="fa-solid fa-chevron-down select-caret"></i>
                                        </div>
                                        <span class="field-error">Please select your company size.</span>
                                    </div>
                                    <div class="login-form-group">
                                        <label for="c_location">Location</label>
                                        <div class="login-input-wrap">
                                            <i class="fa-solid fa-location-dot input-icon"></i>
                                            <asp:TextBox ID="c_location" ClientIDMode="Static" runat="server" placeholder="Enter your city"></asp:TextBox>
                                        </div>
                                        <span class="field-error">Please enter your city.</span>
                                    </div>
                                </div>
                            </div>
                            <div class="terms-row" style="margin-top: 15px;">
                                <asp:CheckBox ID="agreeTerms" ClientIDMode="Static" runat="server" Checked="true" />
                                <label for="agreeTerms">I agree to the <a href="#">Terms &amp; Conditions</a> and <a href="#">Privacy Policy</a></label>
                            </div>
                            <div style="margin-top: 15px; margin-bottom: 20px;">
                                <%--            <asp:Button ID="btnRegister" ClientIDMode="Static" runat="server" Text="Register Now" CssClass="btn btn-primary btn-login" OnClick="btnRegister_Click" />--%>
                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/assets/register.png" Width="650px" OnClick="ImageButton2_Click" />
                                <asp:Label ID="Label1" runat="server" Style="display: block; margin-top: 10px; font-weight: 600;"></asp:Label>
                            </div>
                        </div>
                        <div class="login-divider">or</div>
                        <div class="social-row">
                            <asp:LinkButton ID="googleBtn" ClientIDMode="Static" runat="server" CssClass="btn-social" OnClientClick="return false;"><i class="fa-brands fa-google google"></i> Continue with Google</asp:LinkButton>
                            <asp:LinkButton ID="linkedinBtn" ClientIDMode="Static" runat="server" CssClass="btn-social" OnClientClick="return false;"><i class="fa-brands fa-linkedin linkedin"></i> Continue with LinkedIn</asp:LinkButton>
                        </div>
                        <p class="login-register-text">
                            Already have an account? <a href="login.aspx">Login Now</a>
                        </p>
                    </div>
                </div>
            </div>
            <div id="public-footer-root"></div>
            <!-- Toast notification -->
            <div class="login-toast" id="loginToast">
                <i class="fa-solid fa-circle-check"></i>
                <span id="loginToastMsg">Registration successful!</span>
            </div>
            <script src="../js/global-store.js"></script>
            <script src="../js/public-layout.js"></script>
            <script src="../js/script.js"></script>
            <script src="../js/register.js"></script>
    </body>
    </html>
    </div>
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

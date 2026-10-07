<%@ Page Title="" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="asp.net.index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder2">
    <main>
    <section class="hero">
        <div class="hero-bg-shape">
        </div>
        <div class="container hero-inner">
            <div class="hero-content">
                <span class="hero-badge">Find. Learn. Grow.</span>
                <h1 class="hero-title">Find The Perfect<br><span class="text-blue">Internship Opportunity</span> </h1>
                <p class="hero-desc">
                    SIMS helps students discover real-world internships that match their skills and career goals. Start your journey today!
                </p>
                <%--<div class="hero-btns">
                    <a href="internships.aspx" class="btn btn-primary btn-lg">Explore Internships <i class="fa-solid fa-arrow-right"></i></a>
                </div>--%>
                <asp:ImageButton ID="homeimagebtn" runat="server" ImageUrl="~/assets/home.png" PostBackUrl="~/PublicPanel/internships.aspx" />
                <div class="hero-trusted">
                    <span>Trusted by Students &amp; Top Companies</span>
                    <div class="trusted-logos">
                        <img src="<%= ResolveUrl("~/assets/logo-google.png") %>" alt="Google" class="trusted-logo-img">
                        <img src="<%= ResolveUrl("~/assets/logo-microsoft.png") %>" alt="Microsoft" class="trusted-logo-img">
                        <img src="<%= ResolveUrl("~/assets/logo-tcs.svg") %>" alt="TCS" class="trusted-logo-img">
                        <img src="<%= ResolveUrl("~/assets/logo-infosys.png") %>" alt="Infosys" class="trusted-logo-img">
                        <img src="<%= ResolveUrl("~/assets/logo-wipro.svg") %>" alt="Wipro" class="trusted-logo-img">
                        <img src="<%= ResolveUrl("~/assets/logo-amazon.png") %>" alt="Amazon" class="trusted-logo-img">
                    </div>
                </div>
            </div>
            <div class="hero-media">
                <div class="hero-blob">
                </div>
                <img src="<%= ResolveUrl("~/assets/hero-student.png") %>" alt="Student using laptop" class="hero-image">
                <div class="float-card float-card-1">
                    <span class="float-icon icon-blue"><i class="fa-solid fa-briefcase"></i></span>
                    <div>
                        <strong>10K+</strong>
                        <p>
                            Active Internships</p>
                    </div>
                </div>
                <div class="float-card float-card-2">
                    <span class="float-icon icon-green"><i class="fa-solid fa-user-group"></i></span>
                    <div>
                        <strong>25K+</strong>
                        <p>
                            Students</p>
                    </div>
                </div>
                <div class="float-card float-card-3">
                    <span class="float-icon icon-orange"><i class="fa-solid fa-building"></i></span>
                    <div>
                        <strong>1K+</strong>
                        <p>
                            Top Companies</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="stats-bar">
                <div class="stat-item">
                    <span class="stat-icon icon-blue"><i class="fa-solid fa-briefcase"></i></span>
                    <div>
                        <strong>10,000+</strong>
                        <p>
                            Active Internships</p>
                    </div>
                </div>
                <div class="stat-item">
                    <span class="stat-icon icon-green"><i class="fa-solid fa-user-group"></i></span>
                    <div>
                        <strong>25,000+</strong>
                        <p>
                            Registered Students</p>
                    </div>
                </div>
                <div class="stat-item">
                    <span class="stat-icon icon-purple"><i class="fa-solid fa-building"></i></span>
                    <div>
                        <strong>1,200+</strong>
                        <p>
                            Top Companies</p>
                    </div>
                </div>
                <div class="stat-item">
                    <span class="stat-icon icon-red"><i class="fa-solid fa-award"></i></span>
                    <div>
                        <strong>95%</strong>
                        <p>
                            Success Rate</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </main>
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
                                <a href="tel:+918849900762" class="topbar-link"><i class="fa-solid fa-phone"></i>88499 00762 </a><a href="support@sims.com" class="topbar-link"><i class="fa-solid fa-envelope"></i>support@sims.com </a>
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
                                    <li><a href="index.aspx" class="active" data-nav-page="index.aspx">Home</a></li>
                                    <li><a href="internships.aspx" data-nav-page="internships.aspx">Internships</a></li>
                                    <li><a href="companies.aspx" data-nav-page="companies.aspx">Companies</a></li>
                                    <li><a href="stories.aspx" data-nav-page="stories.aspx">Success Stories</a></li>
                                    <li><a href="about.aspx" data-nav-page="about.aspx">About Us</a></li>
                                    <li><a href="contact.aspx" data-nav-page="contact.aspx">Contact Us</a></li>
                                    <li><a href="faq.aspx" data-nav-page="faq.aspx">FAQ</a></li>
                                </ul>
                            </nav>
                            <div class="navbar-actions">
                                <%-- <a href="login.aspx" class="btn btn-primary">Login / Register</a> --%>
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

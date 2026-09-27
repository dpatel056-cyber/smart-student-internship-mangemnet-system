<%@ Page Title="Company Details" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="viewCompanyDetails.aspx.cs" Inherits="asp.net.viewCompanyDetails" %>

<asp:Content ID="Content0" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/company-profile.css") %>" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        .company-profile-page { max-width: 1180px; margin: 0 auto; padding: 24px 28px 56px; color: #172554; }
        .back-nav { margin-bottom: 20px; }
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            padding: 10px 18px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            color: #334155;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            box-shadow: 0 2px 8px rgba(15,23,42,.05);
            transition: all .2s ease;
        }
        .back-link:hover {
            background: #f8fafc;
            color: #2563eb;
            border-color: #cbd5e1;
            transform: translateX(-3px);
            box-shadow: 0 4px 12px rgba(37,99,235,.1);
            text-decoration: none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="company-profile-page">

    <!-- Back Button -->
    <div class="back-nav">
        <a href="admin-companies.aspx" class="back-link">
            <i class="fa-solid fa-arrow-left"></i> Back to Companies List
        </a>
    </div>

    <asp:Panel ID="pnlNotFound" runat="server" Visible="false" CssClass="profile-section-card" style="text-align:center; padding: 50px;">
        <i class="fa-solid fa-building-circle-xmark" style="font-size:48px; color:#ef4444; margin-bottom:15px;"></i>
        <h2>Company Not Found</h2>
        <p style="color:#64748b;">The requested company details could not be found or the ID is invalid.</p>
    </asp:Panel>

    <asp:Panel ID="pnlDetails" runat="server" Visible="true">

        <!-- ===================== HEADER CARD ===================== -->
        <asp:Panel ID="pnlHero" runat="server" CssClass="profile-header-card">
            <div class="profile-header-top">
                <div class="profile-main-info">
                    <div class="profile-photo" aria-label="Company logo" style="border-radius: 50% !important; overflow: hidden !important;">
                        <asp:Image ID="imgCompanyLogo" runat="server" CssClass="company-profile-logo" Visible="false" AlternateText="Company Logo" Style="width:100%; height:100%; border-radius:50% !important; object-fit:cover; display:block;" />
                        <asp:Panel ID="pnlLogoInitials" runat="server" Style="display: flex; align-items: center; justify-content: center; width: 100%; height: 100%; border-radius: 50%;">
                            <asp:Label ID="lblCompanyInitials" runat="server" Text="TC" />
                        </asp:Panel>
                    </div>
                    <div class="profile-info-2x2">
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-building"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">Company Name</span>
                                <asp:Label ID="lblCompanyName" runat="server" CssClass="contact-value" Text="-" />
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-laptop-code"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">Industry</span>
                                <asp:Label ID="lblIndustry" runat="server" CssClass="contact-value" Text="-" />
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-location-dot"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">Location</span>
                                <asp:Label ID="lblLocation" runat="server" CssClass="contact-value" Text="-" />
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-globe"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">Website</span>
                                <asp:HyperLink ID="hlWebsite" runat="server" CssClass="contact-value" Target="_blank" NavigateUrl="#">-</asp:HyperLink>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="profile-contact-row">
                <div class="contact-item">
                    <div class="contact-icon"><i class="fa-solid fa-user"></i></div>
                    <div class="contact-text">
                        <span class="contact-label">Contact Person</span>
                        <asp:Label ID="lblHeroContactPerson" runat="server" CssClass="contact-value" Text="-" />
                    </div>
                </div>
                <div class="contact-item">
                    <div class="contact-icon"><i class="fa-solid fa-envelope"></i></div>
                    <div class="contact-text">
                        <span class="contact-label">Official Email</span>
                        <asp:Label ID="lblHeroEmail" runat="server" CssClass="contact-value" Text="-" />
                    </div>
                </div>
                <div class="contact-item">
                    <div class="contact-icon"><i class="fa-solid fa-phone"></i></div>
                    <div class="contact-text">
                        <span class="contact-label">Phone Number</span>
                        <asp:Label ID="lblHeroPhone" runat="server" CssClass="contact-value" Text="-" />
                    </div>
                </div>
            </div>

            <div class="social-links">
                <asp:HyperLink ID="hlWebsiteSocial" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#">
                    <i class="fa-solid fa-globe"></i> Website
                </asp:HyperLink>
                <asp:HyperLink ID="hlEmailSocial" runat="server" CssClass="social-link" NavigateUrl="#">
                    <i class="fa-solid fa-envelope"></i> Email Us
                </asp:HyperLink>
                <asp:HyperLink ID="hlCallSocial" runat="server" CssClass="social-link" NavigateUrl="#">
                    <i class="fa-solid fa-phone"></i> Call Us
                </asp:HyperLink>
            </div>
        </asp:Panel>

        <!-- ===================== STATISTICS CARDS ===================== -->
        <div class="profile-stats-grid">
            <div class="profile-stat-card">
                <div class="stat-icon stat-icon-blue"><i class="fa-solid fa-briefcase" aria-hidden="true"></i></div>
                <div class="stat-text">
                    <asp:Label ID="lblTotalInternships" runat="server" CssClass="stat-value" Text="0" />
                    <span class="stat-label">Total Internships</span>
                </div>
            </div>
            <div class="profile-stat-card">
                <div class="stat-icon stat-icon-green"><i class="fa-solid fa-circle-check" aria-hidden="true"></i></div>
                <div class="stat-text">
                    <asp:Label ID="lblActiveInternships" runat="server" CssClass="stat-value" Text="0" />
                    <span class="stat-label">Active Internships</span>
                </div>
            </div>
            <div class="profile-stat-card">
                <div class="stat-icon stat-icon-purple"><i class="fa-solid fa-file-lines" aria-hidden="true"></i></div>
                <div class="stat-text">
                    <asp:Label ID="lblTotalApplications" runat="server" CssClass="stat-value" Text="0" />
                    <span class="stat-label">Total Applications</span>
                </div>
            </div>
            <div class="profile-stat-card">
                <div class="stat-icon stat-icon-orange"><i class="fa-solid fa-user-check" aria-hidden="true"></i></div>
                <div class="stat-text">
                    <asp:Label ID="lblStudentsSelected" runat="server" CssClass="stat-value" Text="0" />
                    <span class="stat-label">Students Selected</span>
                </div>
            </div>
        </div>

        <!-- ===================== TABS NAVIGATION ===================== -->
        <section class="profile-tabs-card" aria-label="Company Profile sections">
            <div class="profile-tabs" role="tablist">
                <button type="button" class="profile-tab active" onclick="openCompanyTab('company-info', this)"><i class="fa-solid fa-gauge-high"></i><span>Overview</span></button>
                <button type="button" class="profile-tab" onclick="openCompanyTab('about-company', this)"><i class="fa-solid fa-building"></i><span>Company Information</span></button>
                <button type="button" class="profile-tab" onclick="openCompanyTab('contact-info', this)"><i class="fa-solid fa-address-book"></i><span>Contact</span></button>
                <button type="button" class="profile-tab" onclick="openCompanyTab('verification-status', this)"><i class="fa-solid fa-briefcase"></i><span>Internship Preferences</span></button>
                <button type="button" class="profile-tab" onclick="openCompanyTab('profile-completion', this)"><i class="fa-solid fa-chart-line"></i><span>Activity</span></button>
            </div>
        </section>

        <!-- ===================== TAB 1: OVERVIEW ===================== -->
        <section id="company-info" class="profile-tab-content active">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-gauge-high"></i>Overview</h2>
                        <p>View key organizational overview and company specs</p>
                    </div>
                </div>

                <div class="profile-subtitle"><i class="fa-solid fa-id-card"></i>Company Overview</div>
                <div class="profile-info-grid">
                    <div class="info-field">
                        <span class="info-label">Company Name</span>
                        <asp:Label ID="lblFieldCompanyName" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Industry</span>
                        <asp:Label ID="lblFieldIndustry" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Company Type</span>
                        <asp:Label ID="lblCompanyType" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Company Size</span>
                        <asp:Label ID="lblCompanySize" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Founded Year</span>
                        <asp:Label ID="lblFoundedYear" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">About Company</span>
                        <asp:Label ID="lblDescription" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Headquarters</span>
                        <asp:Label ID="lblHeadquarters" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Website</span>
                        <asp:Label ID="lblWebsiteField" runat="server" CssClass="info-value" Text="-" />
                    </div>
                </div>
            </div>
        </section>

        <!-- ===================== TAB 2: COMPANY INFORMATION ===================== -->
        <section id="about-company" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-building"></i>Company Information</h2>
                        <p>Overview, specialization, mission, and vision of your company</p>
                    </div>
                </div>

                <div class="profile-subtitle"><i class="fa-solid fa-bullseye"></i>Company Specialization &amp; Vision</div>
                <div class="profile-info-grid">
                    <div class="info-field">
                        <span class="info-label">Business Domain / Specialization</span>
                        <asp:Label ID="lblBusinessDomain" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Products / Services</span>
                        <asp:Label ID="lblProductsServices" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Mission</span>
                        <asp:Label ID="lblMission" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Vision</span>
                        <asp:Label ID="lblVision" runat="server" CssClass="info-value" Text="-" />
                    </div>
                </div>
            </div>
        </section>

        <!-- ===================== TAB 3: CONTACT ===================== -->
        <section id="contact-info" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-address-book"></i>Contact Details</h2>
                        <p>Company contact information, HR details, and online presence</p>
                    </div>
                </div>

                <div class="profile-subtitle"><i class="fa-solid fa-building"></i>Company Contact</div>
                <div class="profile-info-grid">
                    <div class="info-field">
                        <span class="info-label">Official Email</span>
                        <asp:Label ID="lblEmail" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Official Contact Number</span>
                        <asp:Label ID="lblPhone" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Address</span>
                        <asp:Label ID="lblAddress" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">City</span>
                        <asp:Label ID="lblCity" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">State</span>
                        <asp:Label ID="lblState" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Pincode</span>
                        <asp:Label ID="lblPincode" runat="server" CssClass="info-value" Text="-" />
                    </div>
                </div>

                <div class="profile-subtitle"><i class="fa-solid fa-user-tie"></i>HR / Recruiter</div>
                <div class="profile-info-grid">
                    <div class="info-field">
                        <span class="info-label">HR / Recruiter Name</span>
                        <asp:Label ID="lblContactPerson" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">HR Designation</span>
                        <asp:Label ID="lblHRDesignation" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">HR Email</span>
                        <asp:Label ID="lblAlternateEmail" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">HR Contact Number</span>
                        <asp:Label ID="lblHRContactNumber" runat="server" CssClass="info-value" Text="-" />
                    </div>
                </div>

                <div class="profile-subtitle"><i class="fa-solid fa-globe"></i>Online Presence</div>
                <div class="profile-info-grid" style="grid-template-columns: 1fr;">
                    <div class="info-field">
                        <span class="info-label">LinkedIn</span>
                        <asp:HyperLink ID="hlLinkedIn" runat="server" CssClass="info-value" NavigateUrl="#" Target="_blank">-</asp:HyperLink>
                    </div>
                </div>
            </div>
        </section>

        <!-- ===================== TAB 4: INTERNSHIP PREFERENCES ===================== -->
        <section id="verification-status" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-briefcase"></i>Internship Preferences</h2>
                        <p>Hiring criteria, preferred domains, qualifications, and work modes</p>
                    </div>
                </div>

                <div class="profile-subtitle"><i class="fa-solid fa-sliders"></i>Preferences &amp; Eligibility Criteria</div>
                <div class="profile-info-grid">
                    <div class="info-field">
                        <span class="info-label">Internship Domains</span>
                        <asp:Label ID="lblInternshipDomains" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Internship Type</span>
                        <asp:Label ID="lblInternshipType" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Preferred Work Mode</span>
                        <asp:Label ID="lblPreferredWorkMode" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Preferred Duration</span>
                        <asp:Label ID="lblPreferredDuration" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Required Skills / Technologies</span>
                        <asp:Label ID="lblRequiredSkills" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Preferred Courses</span>
                        <asp:Label ID="lblPreferredCourses" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Preferred Semester</span>
                        <asp:Label ID="lblPreferredSemester" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Minimum CGPA</span>
                        <asp:Label ID="lblMinimumCGPA" runat="server" CssClass="info-value" Text="-" />
                    </div>
                </div>
            </div>
        </section>

        <!-- ===================== TAB 5: ACTIVITY ===================== -->
        <section id="profile-completion" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-chart-line"></i>Activity Overview</h2>
                        <p>Summary of internship postings, student applications, and placement metrics</p>
                    </div>
                </div>

                <div class="profile-subtitle"><i class="fa-solid fa-chart-pie"></i>Activity Metrics &amp; Engagement</div>
                <div class="profile-info-grid">
                    <div class="info-field">
                        <span class="info-label">Total Internship Posts</span>
                        <asp:Label ID="lblActivityTotalPosts" runat="server" CssClass="info-value" Text="0" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Active Internships</span>
                        <asp:Label ID="lblActivityActiveInternships" runat="server" CssClass="info-value" Text="0" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Total Applications</span>
                        <asp:Label ID="lblActivityTotalApplications" runat="server" CssClass="info-value" Text="0" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Students Selected</span>
                        <asp:Label ID="lblActivityStudentsSelected" runat="server" CssClass="info-value" Text="0" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Current Interns</span>
                        <asp:Label ID="lblActivityCurrentInterns" runat="server" CssClass="info-value" Text="0" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Completed Internships</span>
                        <asp:Label ID="lblActivityCompletedInternships" runat="server" CssClass="info-value" Text="0" />
                    </div>
                </div>
            </div>
        </section>

    </asp:Panel>

</div>

<script>
    function openCompanyTab(tabId, tabBtn) {
        var contents = document.querySelectorAll('.profile-tab-content');
        contents.forEach(function(content) {
            content.classList.remove('active');
        });
        var tabs = document.querySelectorAll('.profile-tab');
        tabs.forEach(function(tab) {
            tab.classList.remove('active');
        });
        var target = document.getElementById(tabId);
        if (target) {
            target.classList.add('active');
        }
        if (tabBtn) {
            tabBtn.classList.add('active');
        }
    }
</script>
</asp:Content>

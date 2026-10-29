<%@ Page Title="Company Details" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-company-details.aspx.cs" Inherits="asp.net.student_company_details" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-company-details.css" />
    <link rel="stylesheet" href="../css/company-profile.css" />
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="company-profile-page">
    <!-- Back Button -->
    <div class="back-nav">
        <asp:ImageButton ID="btnBackCompanies" runat="server" ImageUrl="~/assets/btn_back_companies.png" PostBackUrl="~/StudentPanel/student-internships.aspx" Height="38px" CssClass="btn-img-action" />
    </div>
    <asp:PlaceHolder ID="pnlNotFound" runat="server" Visible="false">
        <div class="profile-section-card scmp-u1" >
            <i class="fa-solid fa-building-circle-xmark scmp-u2" ></i>
            <h2>Company Not Found</h2>
            <p  class="scmp-u3">The requested company details could not be found or the ID is invalid.</p>
            <div  class="scmp-u4">
                <asp:ImageButton ID="btnExploreOther" runat="server" ImageUrl="~/assets/btn_browse_internships.png" PostBackUrl="~/StudentPanel/student-internships.aspx" Height="38px" CssClass="btn-img-action" />
            </div>
        </div>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="pnlDetails" runat="server" Visible="true">
        <!-- ===================== HEADER CARD ===================== -->
        <asp:PlaceHolder ID="pnlHero" runat="server">
            <div class="profile-header-card">
            <div class="profile-header-top">
                <div class="profile-main-info">
                    <div class="profile-photo scmp-u5" aria-label="Company logo" >
                        <asp:Image ID="imgCompanyLogo" runat="server" CssClass="company-profile-logo scmp-u6" Visible="false"  onerror="this.onerror=null; this.src='../assets/default-company.png';" />
                        <asp:PlaceHolder ID="pnlLogoInitials" runat="server">
                            <div  class="scmp-u7">
                                <asp:Label ID="lblCompanyInitials" runat="server" Text="C" />
                            </div>
                        </asp:PlaceHolder>
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
            </div>
        </asp:PlaceHolder>
        <!-- ===================== TABS NAVIGATION ===================== -->
        <section class="profile-tabs-card" aria-label="Company Profile sections">
            <div class="profile-tabs" role="tablist">
                <button type="button" class="profile-tab active" onclick="openCompanyTab('company-info', this)"><i class="fa-solid fa-gauge-high"></i><span>Overview</span></button>
                <button type="button" class="profile-tab" onclick="openCompanyTab('about-company', this)"><i class="fa-solid fa-building"></i><span>Company Information</span></button>
                <button type="button" class="profile-tab" onclick="openCompanyTab('contact-info', this)"><i class="fa-solid fa-address-book"></i><span>Contact Info</span></button>
                <button type="button" class="profile-tab" onclick="openCompanyTab('active-internships', this)"><i class="fa-solid fa-briefcase"></i><span>Internships</span></button>
            </div>
        </section>
        <!-- ===================== TAB 1: OVERVIEW ===================== -->
        <section id="company-info" class="profile-tab-content active">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-gauge-high"></i>Overview</h2>
                        <p>Key organizational details and company specs</p>
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
                        <span class="info-label">Headquarters</span>
                        <asp:Label ID="lblHeadquarters" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field scmp-u8" >
                        <span class="info-label">About Company</span>
                        <asp:Label ID="lblDescription" runat="server" CssClass="info-value" Text="-" />
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
                        <p>Specialization, products, mission, and vision</p>
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
                    <div class="info-field scmp-u8" >
                        <span class="info-label">Mission</span>
                        <asp:Label ID="lblMission" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field scmp-u8" >
                        <span class="info-label">Vision</span>
                        <asp:Label ID="lblVision" runat="server" CssClass="info-value" Text="-" />
                    </div>
                </div>
            </div>
        </section>
        <!-- ===================== TAB 3: CONTACT INFO ===================== -->
        <section id="contact-info" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-address-book"></i>Contact Information</h2>
                        <p>Official communication details and corporate address</p>
                    </div>
                </div>
                <div class="profile-subtitle"><i class="fa-solid fa-location-arrow"></i>Corporate Address</div>
                <div class="profile-info-grid">
                    <div class="info-field scmp-u8" >
                        <span class="info-label">Street Address</span>
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
                <div class="profile-subtitle scmp-u9" ><i class="fa-solid fa-user-tie"></i>Representative / HR Details</div>
                <div class="profile-info-grid">
                    <div class="info-field">
                        <span class="info-label">Contact Person</span>
                        <asp:Label ID="lblContactPerson" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Designation</span>
                        <asp:Label ID="lblHRDesignation" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Official Email</span>
                        <asp:Label ID="lblEmail" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field">
                        <span class="info-label">Contact Phone</span>
                        <asp:Label ID="lblPhone" runat="server" CssClass="info-value" Text="-" />
                    </div>
                    <div class="info-field scmp-u8" >
                        <span class="info-label">LinkedIn Profile</span>
                        <asp:HyperLink ID="hlLinkedIn" runat="server" CssClass="info-value" Target="_blank" NavigateUrl="#">-</asp:HyperLink>
                    </div>
                </div>
            </div>
        </section>
        <!-- ===================== TAB 4: ACTIVE INTERNSHIPS ===================== -->
        <section id="active-internships" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-briefcase"></i>Active Internship Openings</h2>
                        <p>Current opportunities posted by this company</p>
                    </div>
                </div>
                <asp:DataList ID="DataListCompanyInternships" runat="server" Width="100%">
                    <ItemTemplate>
                        <div class="internship-item-card">
                            <div>
                                <div class="internship-title"><asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label></div>
                                <div class="internship-meta-row">
                                    <div class="internship-meta-item">
                                        <i class="fa-solid fa-laptop-code scmp-u10" ></i>
                                        <span><asp:Label ID="lblDomain" runat="server" Text='<%# Eval("InternshipDomain") %>'></asp:Label></span>
                                    </div>
                                    <div class="internship-meta-item">
                                        <i class="fa-solid fa-location-dot scmp-u10" ></i>
                                        <span><asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>'></asp:Label></span>
                                    </div>
                                    <div class="internship-meta-item">
                                        <i class="fa-solid fa-indian-rupee-sign scmp-u11" ></i>
                                        <span><asp:Label ID="lblStipend" runat="server" Text='<%# Eval("StipendAmount") %>'></asp:Label></span>
                                    </div>
                                    <div class="internship-meta-item">
                                        <i class="fa-regular fa-clock scmp-u12" ></i>
                                        <span><asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>'></asp:Label></span>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <asp:ImageButton ID="btnViewInternship" runat="server" ImageUrl="~/assets/btn_view_details.png" PostBackUrl='<%# "~/StudentPanel/student-internship-details.aspx?id=" + Eval("Id") %>' Height="38px" CssClass="btn-img-action" />
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
                <asp:PlaceHolder ID="pnlNoInternships" runat="server" Visible="false">
                    <div  class="scmp-u13">
                        <i class="fa-solid fa-briefcase scmp-u14" ></i>
                        <p  class="scmp-u15">No active internships currently available for this company.</p>
                    </div>
                </asp:PlaceHolder>
            </div>
        </section>
    </asp:PlaceHolder>
</div>
</asp:Content>
<asp:Content ID="ScriptContent_scmp" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="../js/student-company-details.js"></script>
</asp:Content>

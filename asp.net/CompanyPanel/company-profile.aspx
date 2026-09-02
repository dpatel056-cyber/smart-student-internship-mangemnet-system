<%@ Page Title="Company Profile" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-profile.aspx.cs" Inherits="asp.net.company_profile" %>

<asp:Content ID="Content0" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="css/company-profile.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="company-profile-page">

    <!-- ===================== PAGE HEADER ===================== -->
    <div class="company-profile-header">
        <div>
            <h1 class="company-profile-title">Company Profile</h1>
            <p class="company-profile-subtitle">View and manage your company information and profile details.</p>
        </div>
        <div class="company-profile-actions">
            <asp:HyperLink ID="hlEditProfile" runat="server" CssClass="btn-primary-sims" NavigateUrl="~/company-edit-profile.aspx">
                <i class="fa-solid fa-pen-to-square" aria-hidden="true"></i>
                <span>Edit Profile</span>
            </asp:HyperLink>
        </div>
    </div>

    <!-- ===================== COMPANY HERO CARD ===================== -->
    <asp:Panel ID="pnlHero" runat="server" CssClass="company-profile-hero">
        <div class="company-profile-logo-wrap">
            <asp:Image ID="imgCompanyLogo" runat="server" CssClass="company-profile-logo" Visible="false" AlternateText="Company Logo" />
            <asp:Panel ID="pnlLogoInitials" runat="server" CssClass="company-profile-logo company-profile-logo-initials">
                <asp:Label ID="lblCompanyInitials" runat="server" Text="TC" />
            </asp:Panel>
        </div>

        <div class="company-profile-info">
            <div class="company-profile-name-row">
                <asp:Label ID="lblCompanyName" runat="server" CssClass="company-profile-name" Text="TechCorp Ltd" />
                <asp:Label ID="lblVerifiedBadge" runat="server" CssClass="badge-verification badge-verified">
                    <i class="fa-solid fa-circle-check" aria-hidden="true"></i> Verified
                </asp:Label>
            </div>
            <asp:Label ID="lblIndustry" runat="server" CssClass="company-profile-industry" Text="Information Technology" />

            <div class="company-profile-meta">
                <span class="company-profile-location">
                    <i class="fa-solid fa-location-dot" aria-hidden="true"></i>
                    <asp:Label ID="lblLocation" runat="server" Text="Ahmedabad, Gujarat" />
                </span>
                <asp:HyperLink ID="hlWebsite" runat="server" CssClass="company-profile-website" NavigateUrl="https://www.techcorp.com" Target="_blank">
                    <i class="fa-solid fa-globe" aria-hidden="true"></i> www.techcorp.com
                </asp:HyperLink>
            </div>
        </div>

        <div class="company-profile-hero-action">
            <asp:HyperLink ID="hlEditProfileHero" runat="server" CssClass="btn-primary-sims btn-outline-sims" NavigateUrl="~/company-edit-profile.aspx">
                <i class="fa-solid fa-pen-to-square" aria-hidden="true"></i> Edit Profile
            </asp:HyperLink>
        </div>
    </asp:Panel>

    <!-- ===================== STATISTICS ===================== -->
    <div class="company-profile-stats">
        <div class="company-profile-stat-card">
            <div class="stat-icon stat-icon-blue"><i class="fa-solid fa-briefcase" aria-hidden="true"></i></div>
            <div class="stat-text">
                <asp:Label ID="lblTotalInternships" runat="server" CssClass="stat-value" Text="12" />
                <span class="stat-label">Total Internships</span>
            </div>
        </div>
        <div class="company-profile-stat-card">
            <div class="stat-icon stat-icon-green"><i class="fa-solid fa-circle-check" aria-hidden="true"></i></div>
            <div class="stat-text">
                <asp:Label ID="lblActiveInternships" runat="server" CssClass="stat-value" Text="5" />
                <span class="stat-label">Active Internships</span>
            </div>
        </div>
        <div class="company-profile-stat-card">
            <div class="stat-icon stat-icon-purple"><i class="fa-solid fa-file-lines" aria-hidden="true"></i></div>
            <div class="stat-text">
                <asp:Label ID="lblTotalApplications" runat="server" CssClass="stat-value" Text="148" />
                <span class="stat-label">Total Applications</span>
            </div>
        </div>
        <div class="company-profile-stat-card">
            <div class="stat-icon stat-icon-orange"><i class="fa-solid fa-user-check" aria-hidden="true"></i></div>
            <div class="stat-text">
                <asp:Label ID="lblStudentsSelected" runat="server" CssClass="stat-value" Text="18" />
                <span class="stat-label">Students Selected</span>
            </div>
        </div>
    </div>

    <!-- ===================== INFO + CONTACT (2 COLUMN) ===================== -->
    <div class="company-profile-grid-2col">

        <!-- COMPANY INFORMATION -->
        <div class="company-profile-section">
            <h2 class="section-title">Company Information</h2>
            <div class="company-profile-grid">
                <div class="company-profile-field">
                    <span class="company-profile-label">Company Name</span>
                    <asp:Label ID="lblFieldCompanyName" runat="server" CssClass="company-profile-value" Text="TechCorp Ltd" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label">Industry</span>
                    <asp:Label ID="lblFieldIndustry" runat="server" CssClass="company-profile-value" Text="Information Technology" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label">Company Type</span>
                    <asp:Label ID="lblCompanyType" runat="server" CssClass="company-profile-value" Text="Private Limited" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label">Company Size</span>
                    <asp:Label ID="lblCompanySize" runat="server" CssClass="company-profile-value" Text="51-200 Employees" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label">Founded Year</span>
                    <asp:Label ID="lblFoundedYear" runat="server" CssClass="company-profile-value" Text="2018" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label">Registration Number</span>
                    <asp:Label ID="lblRegistrationNumber" runat="server" CssClass="company-profile-value" Text="REG-123456" />
                </div>
            </div>
        </div>

        <!-- CONTACT INFORMATION -->
        <div class="company-profile-section">
            <h2 class="section-title">Contact Information</h2>
            <div class="company-profile-grid">
                <div class="company-profile-field">
                    <span class="company-profile-label"><i class="fa-solid fa-user" aria-hidden="true"></i> Contact Person</span>
                    <asp:Label ID="lblContactPerson" runat="server" CssClass="company-profile-value" Text="Dhruvi Patel" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label"><i class="fa-solid fa-envelope" aria-hidden="true"></i> Official Email</span>
                    <asp:Label ID="lblEmail" runat="server" CssClass="company-profile-value" Text="hr@techcorp.com" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label"><i class="fa-solid fa-phone" aria-hidden="true"></i> Phone Number</span>
                    <asp:Label ID="lblPhone" runat="server" CssClass="company-profile-value" Text="+91 XXXXX XXXXX" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label"><i class="fa-solid fa-envelope" aria-hidden="true"></i> Alternate Email</span>
                    <asp:Label ID="lblAlternateEmail" runat="server" CssClass="company-profile-value" Text="info@techcorp.com" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label"><i class="fa-solid fa-globe" aria-hidden="true"></i> Website</span>
                    <asp:Label ID="lblWebsiteField" runat="server" CssClass="company-profile-value" Text="www.techcorp.com" />
                </div>
            </div>
        </div>

    </div>

    <!-- ===================== ABOUT COMPANY ===================== -->
    <div class="company-profile-section company-profile-about">
        <h2 class="section-title">About Company</h2>
        <asp:Label ID="lblDescription" runat="server" CssClass="about-text"
            Text="TechCorp Ltd is a technology company providing innovative software solutions and internship opportunities for students." />
    </div>

    <!-- ===================== ADDRESS + VERIFICATION (2 COLUMN) ===================== -->
    <div class="company-profile-grid-2col">

        <!-- COMPANY ADDRESS -->
        <div class="company-profile-section company-profile-address">
            <h2 class="section-title">Company Address</h2>
            <div class="company-profile-grid">
                <div class="company-profile-field field-full">
                    <span class="company-profile-label"><i class="fa-solid fa-location-dot" aria-hidden="true"></i> Address</span>
                    <asp:Label ID="lblAddress" runat="server" CssClass="company-profile-value" Text="123, Technology Park" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label">City</span>
                    <asp:Label ID="lblCity" runat="server" CssClass="company-profile-value" Text="Ahmedabad" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label">State</span>
                    <asp:Label ID="lblState" runat="server" CssClass="company-profile-value" Text="Gujarat" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label">Country</span>
                    <asp:Label ID="lblCountry" runat="server" CssClass="company-profile-value" Text="India" />
                </div>
                <div class="company-profile-field">
                    <span class="company-profile-label">Pincode</span>
                    <asp:Label ID="lblPincode" runat="server" CssClass="company-profile-value" Text="380001" />
                </div>
            </div>
        </div>

        <!-- VERIFICATION STATUS -->
        <div class="company-profile-section company-profile-verification">
            <h2 class="section-title">Verification Status</h2>

            <asp:Panel ID="pnlStatusVerified" runat="server" CssClass="verification-box verification-verified">
                <div class="verification-heading">
                    <i class="fa-solid fa-circle-check" aria-hidden="true"></i>
                    <span>Verified</span>
                </div>
                <p class="verification-message">Your company profile is verified by the administrator.</p>
                <p class="verification-date">Verified On: <asp:Label ID="lblVerifiedDate" runat="server" Text="15 Aug 2026" /></p>
            </asp:Panel>

            <asp:Panel ID="pnlStatusPending" runat="server" CssClass="verification-box verification-pending" Visible="false">
                <div class="verification-heading">
                    <i class="fa-solid fa-hourglass-half" aria-hidden="true"></i>
                    <span>Pending Verification</span>
                </div>
                <p class="verification-message">Your company profile is currently waiting for administrator approval.</p>
            </asp:Panel>

            <asp:Panel ID="pnlStatusRejected" runat="server" CssClass="verification-box verification-rejected" Visible="false">
                <div class="verification-heading">
                    <i class="fa-solid fa-circle-xmark" aria-hidden="true"></i>
                    <span>Verification Rejected</span>
                </div>
                <p class="verification-message">Your company verification was rejected. Please update your company information.</p>
            </asp:Panel>
        </div>

    </div>

    <!-- ===================== PROFILE COMPLETION ===================== -->
    <div class="company-profile-section company-profile-completion">
        <div class="completion-header">
            <h2 class="section-title">Profile Completion</h2>
            <asp:Label ID="lblCompletionPercent" runat="server" CssClass="completion-percent" Text="85%" />
        </div>
        <div class="completion-bar-track">
            <asp:Panel ID="pnlCompletionBar" runat="server" CssClass="completion-bar-fill" Style="width:85%;"></asp:Panel>
        </div>
        <p class="completion-subtext">Complete your company profile to improve visibility to students.</p>

        <div class="completion-missing">
            <span class="completion-missing-label">Missing information:</span>
            <ul class="completion-missing-list">
                <asp:Repeater ID="rptMissingFields" runat="server">
                    <ItemTemplate>
                        <li><%# Eval("FieldName") %></li>
                    </ItemTemplate>
                </asp:Repeater>
                <%-- Sample static fallback for UI preview --%>
                <li>Company Logo</li>
                <li>Alternate Email</li>
            </ul>
        </div>

        <asp:HyperLink ID="hlCompleteProfile" runat="server" CssClass="btn-primary-sims" NavigateUrl="~/company-edit-profile.aspx">
            Complete Profile
        </asp:HyperLink>
    </div>

</div>

</asp:Content>

<asp:Content ID="ContentScript" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="js/company-profile.js"></script>
</asp:Content>

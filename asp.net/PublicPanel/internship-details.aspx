<%@ Page Title="Internship Details" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="internship-details.aspx.cs" Inherits="asp.net.internship_details" %>

<asp:Content ID="Content0" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/internship-module.css") %>" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/internship-details.css") %>" />
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <main class="site-main imd-page-main">
        <div class="container imd-container">
            <br />
            <!-- Back Navigation -->
            <div class="back-nav">
                <asp:ImageButton ID="btnBackInternships" runat="server" ImageUrl="~/assets/btn_back_internships.png" PostBackUrl="~/PublicPanel/internships.aspx" Height="42px" CssClass="asp-img-btn btn-img-action" />
            </div>

            <!-- Not Found Panel -->
            <div id="divNotFound" runat="server" visible="false" class="imd-not-found-box">
                <i class="fa-solid fa-file-circle-xmark imd-not-found-icon"></i>
                <asp:ImageButton ID="btnExploreOther" runat="server" ImageUrl="~/assets/btn_explore_other.png" PostBackUrl="~/PublicPanel/internships.aspx" Height="42px" CssClass="btn-img-action" />
            </div>

            <asp:DataList ID="DataListInternshipDetail" runat="server" Width="100%">
                <ItemTemplate>

                    <!-- Header -->
                    <div class="imd-header imd-header-wrap">
                        <div class="imd-cover"></div>
                        <div class="imd-content">
                            <asp:HyperLink ID="hlCompanyLogo" runat="server" NavigateUrl='<%# ResolveUrl("~/PublicPanel/company-details.aspx?CompanyId=" + Eval("CompanyId")) %>' CssClass="imd-logo imd-logo-link">
                                <asp:Image ID="imgCompanyLogo" runat="server" ImageUrl='<%# Eval("c_logo") %>' CssClass="imd-logo-img" />
                            </asp:HyperLink>
                            <h1 class="imd-title imd-title-spaced">
                                <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                            </h1>
                            <div class="imd-company imd-company-wrap">
                                <asp:HyperLink ID="hlCompany" runat="server" NavigateUrl='<%# ResolveUrl("~/PublicPanel/company-details.aspx?CompanyId=" + Eval("CompanyId")) %>' CssClass="imd-company-link">
                                    <i class="fa-solid fa-building"></i>
                                    <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                    <i class="fa-solid fa-circle-check cp-verified imd-verified-icon"></i>
                                </asp:HyperLink>
                            </div>
                            <div class="imd-quick-info">
                                <div class="imd-info-pill">
                                    <i class="fa-solid fa-location-dot"></i>
                                    <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                </div>
                                <div class="imd-info-pill">
                                    <i class="fa-solid fa-briefcase"></i>
                                    <asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label>
                                </div>
                                <div class="imd-info-pill">
                                    <i class="fa-solid fa-indian-rupee-sign"></i>
                                    <asp:Label ID="lblStipendAmount" runat="server" Text='<%# Eval("StipendAmount") %>'></asp:Label>
                                </div>
                                <div class="imd-info-pill">
                                    <i class="fa-regular fa-clock"></i>
                                    <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>'></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Main Layout -->
                    <div class="imd-layout">

                        <!-- LEFT -->
                        <div class="imd-main">
                            <div class="imd-section">
                                <h3 class="imd-section-title">
                                    <i class="fa-solid fa-align-left imd-section-icon"></i>
                                    Overview
                                </h3>
                                <p class="imd-text">
                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("InternshipDescription") %>'></asp:Label>
                                </p>
                            </div>

                            <div class="imd-section">
                                <h3 class="imd-section-title">
                                    <i class="fa-solid fa-list-check imd-section-icon"></i>
                                    Key Responsibilities
                                </h3>
                                <div class="imd-text">
                                    <asp:Label ID="lblResponsibilities" runat="server" Text='<%# Eval("Responsibilities") %>'></asp:Label>
                                </div>
                            </div>

                            <div class="imd-section">
                                <h3 class="imd-section-title">
                                    <i class="fa-solid fa-user-graduate imd-section-icon"></i>
                                    Requirements &amp; Qualifications
                                </h3>
                                <div class="imd-text">
                                    <asp:Label ID="lblQualifications" runat="server" Text='<%# Eval("RequiredQualifications") %>'></asp:Label>
                                </div>
                            </div>

                            <div class="imd-section">
                                <h3 class="imd-section-title">
                                    <i class="fa-solid fa-lightbulb imd-section-icon"></i>
                                    Skills Required
                                </h3>
                                <div class="imd-skills">
                                    <span class="imd-skill-badge">
                                        <asp:Label ID="lblSkills" runat="server" Text='<%# Eval("RequiredSkills") %>'></asp:Label>
                                    </span>
                                </div>
                            </div>

                            <div class="imd-section">
                                <h3 class="imd-section-title">
                                    <i class="fa-solid fa-gift imd-section-icon"></i>
                                    Benefits &amp; Perks
                                </h3>
                                <div class="imd-skills">
                                    <span class="imd-skill-badge">
                                        <i class="fa-solid fa-circle-check imd-check-icon"></i>
                                        <asp:Label ID="lblBenefits" runat="server" Text='<%# Eval("Benefits") %>'></asp:Label>
                                    </span>
                                    <span class="imd-skill-badge">
                                        <asp:Label ID="lblOtherBenefits" runat="server" Text='<%# Eval("OtherBenefits") %>'></asp:Label>
                                    </span>
                                </div>
                            </div>

                            <!-- Company Information -->
                            <div class="company-info-box">
                                <div class="company-info-header">
                                    <asp:Image ID="imgCompanyLogo2" runat="server" ImageUrl='<%# Eval("c_logo") %>' CssClass="company-logo-avatar" />
                                    <div>
                                        <h3 class="imd-apply-title">
                                            <asp:Label ID="lblCompanyBoxName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                        </h3>
                                        <p class="imd-apply-sub">
                                            <i class="fa-solid fa-industry"></i>
                                            <asp:Label ID="lblCompanyIndustry" runat="server" Text='<%# Eval("c_industry") %>'></asp:Label>
                                            &nbsp;|&nbsp;
                                            <i class="fa-solid fa-location-dot"></i>
                                            <asp:Label ID="lblCompanyLocation" runat="server" Text='<%# Eval("c_location") %>'></asp:Label>
                                        </p>
                                    </div>
                                </div>
                                <p class="imd-apply-desc">
                                    <asp:Label ID="lblCompanyAbout" runat="server" Text='<%# Eval("c_about") %>'></asp:Label>
                                </p>
                                <asp:ImageButton ID="btnViewCompany" runat="server" ImageUrl="~/assets/btn_view_company.png" PostBackUrl='<%# "company-details.aspx?CompanyId=" + Eval("CompanyId") %>' Height="42px" CssClass="btn-img-action" />
                            </div>
                        </div>

                        <!-- RIGHT SIDEBAR -->
                        <aside class="imd-sidebar">

                            <!-- Quick Actions -->
                            <div class="imd-side-card">
                                <h3 class="imd-side-title">Quick Actions</h3>
                                <div class="imd-actions">
                                    <asp:ImageButton ID="btnApplyNow" runat="server" ImageUrl="~/assets/btn_apply_internship.png" PostBackUrl='<%# "~/StudentPanel/student-internship-details.aspx?id=" + Eval("Id") + "&apply=1" %>' Height="45px" CssClass="imd-action-btn" />
                                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/assets/btn_save_internship.png" PostBackUrl='<%# "~/StudentPanel/student-internship-details.aspx?id=" + Eval("Id") %>' Height="45px" CssClass="imd-action-btn" />
                                </div>
                            </div>

                            <!-- Internship Details -->
                            <div class="imd-side-card">
                                <h3 class="imd-side-title">Internship Details</h3>
                                <ul class="imd-meta-list">
                                    <li>
                                        <span class="imd-meta-label">Domain</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblDomain" runat="server" Text='<%# Eval("InternshipDomain") %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Type</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblType" runat="server" Text='<%# Eval("InternshipType") %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Work Mode</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblSidebarWorkMode" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Openings</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblOpenings" runat="server" Text='<%# Eval("NumberOfOpenings") %>'></asp:Label> Positions
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Start Date</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("StartDate") %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Apply Deadline</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblDeadline" runat="server" Text='<%# Eval("ApplicationDeadline") %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Eligible Courses</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblCourses" runat="server" Text='<%# Eval("EligibleCourses") %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Min CGPA</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblCGPA" runat="server" Text='<%# Eval("MinimumCGPA") %>'></asp:Label>
                                        </span>
                                    </li>
                                </ul>
                            </div>

                            <!-- Share -->
                            <div class="imd-side-card imd-side-card-centered">
                                <h3 class="imd-side-title">Share Internship</h3>
                                <div class="imd-share-links">
                                    <asp:ImageButton ID="btnShareLinkedIn" runat="server" ImageUrl="~/assets/share_linkedin.png" CssClass="imd-share-btn" OnClientClick="return false;" />
                                    <asp:ImageButton ID="btnShareTwitter" runat="server" ImageUrl="~/assets/share_twitter.png" CssClass="imd-share-btn" OnClientClick="return false;" />
                                    <asp:ImageButton ID="btnShareFacebook" runat="server" ImageUrl="~/assets/share_facebook.png" CssClass="imd-share-btn" OnClientClick="return false;" />
                                    <asp:ImageButton ID="btnShareLink" runat="server" ImageUrl="~/assets/share_link.png" CssClass="imd-share-btn" OnClientClick="return false;" />
                                </div>
                            </div>
                        </aside>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </main>

    <script src="<%= ResolveUrl("~/js/internship-details.js") %>"></script>
</asp:Content>

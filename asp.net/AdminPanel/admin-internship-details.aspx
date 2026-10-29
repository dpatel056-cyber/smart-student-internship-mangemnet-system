<%@ Page Title="Admin - Internship Details" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-internship-details.aspx.cs" Inherits="asp.net.admin_internship_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet" href="../css/internship-module.css" />

    <link rel="stylesheet" href="../css/admin-internship-details.css" />

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="imd-wrapper">

        <!-- Back Navigation -->

        <div class="back-nav">

            <asp:HyperLink ID="hlBackToInternships" runat="server" NavigateUrl="admin-internships.aspx"

                ImageUrl="~/image_button/btn_back_internships.png"

                Height="38" CssClass="admin-img-btn"  />

        </div>

        <asp:DataList ID="DataListInternshipDetail" runat="server" Width="100%" OnItemCommand="DataListInternshipDetail_ItemCommand">

            <ItemTemplate>

                <!-- Header Banner -->

                <div class="imd-header">

                    <div class="imd-cover"></div>

                    <div class="imd-content">

                        <div class="imd-logo">

                            <asp:Image ID="imgHeaderCompanyLogo" runat="server" CssClass="company-logo-avatar"

                                ImageUrl='<%# Eval("c_logo") %>' />

                        </div>

                        <h1 class="imd-title">

                            <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>' />

                        </h1>

                        <div class="imd-company">

                            <asp:HyperLink ID="hlCompanyDetails" runat="server" CssClass="company-link"

                                NavigateUrl='<%# "viewCompanyDetails.aspx?id=" + Eval("CompanyId") %>'>

                                <i class="fa-solid fa-building"></i>

                                <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>' />

                            </asp:HyperLink>

                        </div>

                        <!-- Quick Info Pills -->

                        <div class="imd-quick-info">

                            <div class="imd-info-pill">

                                <i class="fa-solid fa-location-dot"></i>

                                <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>' />

                            </div>

                            <div class="imd-info-pill">

                                <i class="fa-solid fa-laptop-code"></i>

                                <asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") %>' />

                            </div>

                            <div class="imd-info-pill">

                                <i class="fa-solid fa-indian-rupee-sign"></i>

                                <asp:Label ID="lblStipendAmount" runat="server" Text='<%# Eval("StipendAmount") %>' />

                            </div>

                            <div class="imd-info-pill">

                                <i class="fa-regular fa-clock"></i>

                                <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>' />

                            </div>

                        </div>

                    </div>

                </div>

                <!-- Main Layout -->

                <div class="imd-layout">

                    <!-- Left Section -->

                    <div class="imd-main">

                        <div class="imd-section">

                            <h3 class="imd-section-title"><i class="fa-solid fa-align-left"></i>Overview</h3>

                            <p class="imd-text">

                                <asp:Label ID="lblInternshipDescription" runat="server" Text='<%# Eval("InternshipDescription") %>' />

                            </p>

                        </div>

                        <div class="imd-section">

                            <h3 class="imd-section-title"><i class="fa-solid fa-list-check"></i>Key Responsibilities</h3>

                            <div class="imd-text">

                                <asp:Label ID="lblResponsibilities" runat="server" Text='<%# Eval("Responsibilities") %>' />

                            </div>

                        </div>

                        <div class="imd-section">

                            <h3 class="imd-section-title"><i class="fa-solid fa-user-graduate"></i>Requirements &amp; Qualifications</h3>

                            <div class="imd-text">

                                <asp:Label ID="lblRequiredQualifications" runat="server" Text='<%# Eval("RequiredQualifications") %>' />

                            </div>

                        </div>

                        <div class="imd-section">

                            <h3 class="imd-section-title"><i class="fa-solid fa-lightbulb"></i>Skills Required</h3>

                            <div class="imd-skills">

                                <asp:Label ID="lblRequiredSkills" runat="server" Text='<%# Eval("RequiredSkills") %>' />

                            </div>

                        </div>

                        <div class="imd-section">

                            <h3 class="imd-section-title"><i class="fa-solid fa-gift"></i>Benefits &amp; Perks</h3>

                            <div class="imd-skills">

                                <asp:Label ID="lblBenefits" runat="server" Text='<%# Eval("Benefits") %>' />

                            </div>

                        </div>

                        <!-- Company Information -->

                        <div class="company-info-box">

                            <div class="company-info-header">

                                <asp:Image ID="imgBoxCompanyLogo" runat="server" CssClass="company-logo-avatar"

                                    ImageUrl='<%# Eval("c_logo") %>' />

                                <div>

                                    <h3 class="company-name">

                                        <asp:Label ID="lblBoxCompanyName" runat="server" Text='<%# Eval("c_company") %>' />

                                    </h3>

                                    <p class="company-meta">

                                        <i class="fa-solid fa-industry"></i>

                                        <asp:Label ID="lblBoxIndustry" runat="server" Text='<%# Eval("c_industry") %>' />

                                        &nbsp;|&nbsp;

                                        <i class="fa-solid fa-location-dot"></i>

                                        <asp:Label ID="lblBoxLocation" runat="server" Text='<%# Eval("c_location") %>' />

                                    </p>

                                </div>

                            </div>

                            <p class="company-about">

                                <asp:Label ID="lblCompanyAbout" runat="server" Text='<%# Eval("c_about") %>' />

                            </p>

                            <asp:HyperLink ID="hlViewCompanyDetailsBtn" runat="server"

                                NavigateUrl='<%# "viewCompanyDetails.aspx?id=" + Eval("CompanyId") %>'

                                ImageUrl="~/assets/btn_view_company_details.png"

                                Height="42" CssClass="admin-img-btn" />

                        </div>

                    </div>

                    <!-- Right Sidebar -->

                    <aside class="imd-sidebar">

                        <!-- Admin Actions -->

                        <div class="imd-side-card">

                            <h3 class="imd-side-title">Admin Actions</h3>

                            <div class="imd-actions">

                                <asp:ImageButton ID="btnDeleteInternship" runat="server" CommandName="DeleteInternship"

                                    CommandArgument='<%# Eval("Id") %>'

                                    ImageUrl="~/image_button/btn_admin_delete_internship.png" CausesValidation="false" Height="44" CssClass="admin-img-btn admin-img-btn-delete" />

                            </div>

                        </div>

                        <!-- Internship Details -->

                        <div class="imd-side-card">

                            <h3 class="imd-side-title">Internship Details</h3>

                            <ul class="imd-meta-list">

                                <li>

                                    <span class="imd-meta-label">Domain</span>

                                    <span class="imd-meta-value"><asp:Label ID="lblSideDomain" runat="server" Text='<%# Eval("InternshipDomain") %>' /></span>

                                </li>

                                <li>

                                    <span class="imd-meta-label">Type</span>

                                    <span class="imd-meta-value"><asp:Label ID="lblSideType" runat="server" Text='<%# Eval("InternshipType") %>' /></span>

                                </li>

                                <li>

                                    <span class="imd-meta-label">Work Mode</span>

                                    <span class="imd-meta-value"><asp:Label ID="lblSideWorkMode" runat="server" Text='<%# Eval("WorkMode") %>' /></span>

                                </li>

                                <li>

                                    <span class="imd-meta-label">Openings</span>

                                    <span class="imd-meta-value"><asp:Label ID="lblSideOpenings" runat="server" Text='<%# Eval("NumberOfOpenings") %>' /></span>

                                </li>

                                <li>

                                    <span class="imd-meta-label">Start Date</span>

                                    <span class="imd-meta-value"><asp:Label ID="lblSideStartDate" runat="server" Text='<%# Eval("StartDate") %>' /></span>

                                </li>

                                <li>

                                    <span class="imd-meta-label">Apply Deadline</span>

                                    <span class="imd-meta-value"><asp:Label ID="lblSideDeadline" runat="server" Text='<%# Eval("ApplicationDeadline") %>' /></span>

                                </li>

                                <li>

                                    <span class="imd-meta-label">Eligible Courses</span>

                                    <span class="imd-meta-value"><asp:Label ID="lblSideEligibleCourses" runat="server" Text='<%# Eval("EligibleCourses") %>' /></span>

                                </li>

                                <li>

                                    <span class="imd-meta-label">Min CGPA</span>

                                    <span class="imd-meta-value"><asp:Label ID="lblSideMinimumCGPA" runat="server" Text='<%# Eval("MinimumCGPA") %>' /></span>

                                </li>

                            </ul>

                        </div>

                    </aside>

                </div>

            </ItemTemplate>

        </asp:DataList>

    </div>

</asp:Content>

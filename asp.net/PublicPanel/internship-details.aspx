<%@ Page Title="Internship Details" Language="C#" MasterPageFile="~/PublicPanel/public.Master" AutoEventWireup="true" CodeBehind="internship-details.aspx.cs" Inherits="asp.net.internship_details" %>
<asp:Content ID="Content0" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/internship-module.css") %>" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        .back-nav { margin-bottom: 24px; }
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
        .company-info-box {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 28px;
            margin-top: 24px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.03);
        }
        .company-info-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 20px;
        }
        .company-logo-avatar {
            width: 64px;
            height: 64px;
            border-radius: 50% !important;
            overflow: hidden !important;
            border: 2px solid #e2e8f0;
            object-fit: contain;
            padding: 4px;
            display: block;
        }
        .btn-view-company {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            background: #2563eb;
            color: #ffffff !important;
            font-weight: 600;
            font-size: 14px;
            border-radius: 10px;
            text-decoration: none !important;
            box-shadow: 0 4px 12px rgba(37,99,235,0.2);
            transition: all 0.2s ease;
        }
        .btn-view-company:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(37,99,235,0.3);
        }
        .btn-apply-now {
            display: block;
            width: 100%;
            text-align: center;
            padding: 14px 24px;
            background: #16a34a;
            color: #ffffff !important;
            font-weight: 700;
            font-size: 16px;
            border-radius: 10px;
            text-decoration: none !important;
            box-shadow: 0 4px 14px rgba(22,163,74,0.25);
            transition: all 0.2s ease;
        }
        .btn-apply-now:hover {
            background: #15803d;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(22,163,74,0.35);
        }
    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
<main class="site-main" style="background:#f8fafc; min-height:80vh;">
  <div class="container" style="padding-top:30px; padding-bottom:60px;">
    <!-- Back Navigation -->
    <div class="back-nav">
        <a href="internships.aspx" class="back-link">
            <i class="fa-solid fa-arrow-left"></i> Back to Internships
        </a>
    </div>
    <!-- Not Found Panel -->
    <div id="divNotFound" runat="server" visible="false" style="background:#fff; border-radius:16px; padding:60px; text-align:center; border:1px solid #e2e8f0; box-shadow:0 4px 12px rgba(0,0,0,0.03);">
        <i class="fa-solid fa-file-circle-xmark" style="font-size:56px; color:#ef4444; margin-bottom:16px;"></i>
        <h2 style="font-size:24px; font-weight:700; color:#0f172a; margin-bottom:8px;">Internship Not Found</h2>
        <p style="color:#64748b; font-size:15px; margin-bottom:20px;">The requested internship details could not be found or the link has expired.</p>
        <a href="internships.aspx" class="btn-view-company" style="background:#2563eb;">Explore Other Internships</a>
    </div>
    <asp:DataList ID="DataListInternshipDetail" runat="server" Width="100%">
    <ItemTemplate>
        <div class="imd-header" style="margin-bottom:28px;">
            <div class="imd-cover"></div>
            <div class="imd-content">
                <asp:HyperLink ID="hlCompanyLogo" runat="server"
                    NavigateUrl='<%# ResolveUrl("~/PublicPanel/company-details.aspx?CompanyId=" + Eval("CompanyId")) %>'
                    CssClass="imd-logo"
                    style="border-radius:16px; overflow:hidden; width:80px; height:80px; background:#fff; border:1.5px solid #e2e8f0; padding:8px; display:inline-flex; align-items:center; justify-content:center; box-shadow:0 4px 12px rgba(15,23,42,0.06);"
                    ToolTip="View Company Profile">
                    <asp:Image ID="imgCompanyLogo" runat="server"
                        ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>'
                        AlternateText="Company Logo"
                        style="width:100%; height:100%; max-width:100%; max-height:100%; border-radius:8px; object-fit:contain; display:block;" />
                </asp:HyperLink>
                <h1 class="imd-title" style="margin-top:12px;">
                    <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                </h1>
                <div class="imd-company" style="margin-bottom:16px;">
                    <asp:HyperLink ID="hlCompany" runat="server"
                        NavigateUrl='<%# ResolveUrl("~/PublicPanel/company-details.aspx?CompanyId=" + Eval("CompanyId")) %>'
                        style="color: #2563eb; text-decoration: none !important; font-weight: 600; display: inline-flex; align-items: center; gap: 6px;"
                        ToolTip="Click to view company profile">
                        <i class="fa-solid fa-building"></i>
                        <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                        <i class="fa-solid fa-circle-check cp-verified"
                            style="color:#16a34a; font-size:14px; margin-left:4px;">
                        </i>
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
                        <i class="fa-solid fa-align-left"
                            style="color:#2563eb; margin-right:8px;"></i>
                        Overview
                    </h3>
                    <p class="imd-text">
                        <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("InternshipDescription") %>'></asp:Label>
                    </p>
                </div>
                <div class="imd-section">
                    <h3 class="imd-section-title">
                        <i class="fa-solid fa-list-check"
                            style="color:#2563eb; margin-right:8px;"></i>
                        Key Responsibilities
                    </h3>
                    <div class="imd-text">
                        <asp:Label ID="lblResponsibilities" runat="server" Text='<%# Eval("Responsibilities") %>'></asp:Label>
                    </div>
                </div>
                <div class="imd-section">
                    <h3 class="imd-section-title">
                        <i class="fa-solid fa-user-graduate"
                            style="color:#2563eb; margin-right:8px;"></i>
                        Requirements &amp; Qualifications
                    </h3>
                    <div class="imd-text">
                        <asp:Label ID="lblQualifications" runat="server" Text='<%# Eval("RequiredQualifications") %>'></asp:Label>
                    </div>
                </div>
                <div class="imd-section">
                    <h3 class="imd-section-title">
                        <i class="fa-solid fa-lightbulb"
                            style="color:#2563eb; margin-right:8px;"></i>
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
                        <i class="fa-solid fa-gift"
                            style="color:#2563eb; margin-right:8px;"></i>
                        Benefits &amp; Perks
                    </h3>
                    <div class="imd-skills">
                        <span class="imd-skill-badge">
                            <i class="fa-solid fa-circle-check"
                                style="color:#16a34a; margin-right:4px;"></i>
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
                        <asp:Image ID="imgCompanyLogo2" runat="server"
                            ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>'
                            AlternateText="Company Logo"
                            CssClass="company-logo-avatar" />
                        <div>
                            <h3 style="font-size:20px; font-weight:700; color:#0f172a; margin:0;">
                                <asp:Label ID="lblCompanyBoxName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                            </h3>
                            <p style="color:#64748b; font-size:14px; margin:4px 0 0 0;">
                                <i class="fa-solid fa-industry"></i>
                                <asp:Label ID="lblCompanyIndustry" runat="server" Text='<%# Eval("c_industry") %>'></asp:Label>
                                &nbsp;|&nbsp;
                                <i class="fa-solid fa-location-dot"></i>
                                <asp:Label ID="lblCompanyLocation" runat="server" Text='<%# Eval("c_location") %>'></asp:Label>
                            </p>
                        </div>
                    </div>
                    <p style="color:#334155; font-size:14px; line-height:1.6; margin-bottom:20px;">
                        <asp:Label ID="lblCompanyAbout" runat="server" Text='<%# Eval("c_about") %>'></asp:Label>
                    </p>
                    <asp:HyperLink ID="hlViewCompanyDetails" runat="server"
                        NavigateUrl='<%# "company-details.aspx?CompanyId=" + Eval("CompanyId") %>'
                        CssClass="btn-view-company">
                        <i class="fa-solid fa-building"></i>
                        View Company Details
                    </asp:HyperLink>
                </div>
            </div>
            <!-- RIGHT SIDEBAR -->
            <aside class="imd-sidebar">
                <!-- Quick Actions -->
                <div class="imd-side-card">
                    <h3 class="imd-side-title">
                        Quick Actions
                    </h3>
                    <div class="imd-actions">
                        <asp:HyperLink ID="hlApply" runat="server"
                            NavigateUrl='<%# ResolveUrl("~/StudentPanel/student-internship-details.aspx?id=" + Eval("Id") + "&apply=1") %>'
                            CssClass="btn-apply-now">
                            <i class="fa-solid fa-paper-plane"></i>
                            Apply Internship
                        </asp:HyperLink>
                        <asp:HyperLink ID="hlSave" runat="server"
                            NavigateUrl='<%# ResolveUrl("~/StudentPanel/student-internship-details.aspx?id=" + Eval("Id")) %>'
                            CssClass="btn imd-btn-save"
                            style="width:100%; display:inline-flex; align-items:center; justify-content:center; gap:8px; padding:12px; border:1px solid #cbd5e1; border-radius:10px; background:#fff; font-weight:600; cursor:pointer; text-decoration:none; color:#334155;">
                            <i class="fa-regular fa-bookmark"></i>
                            Save Internship
                        </asp:HyperLink>
                    </div>
                </div>
                <!-- Internship Details -->
                <div class="imd-side-card">
                    <h3 class="imd-side-title">
                        Internship Details
                    </h3>
                    <ul class="imd-meta-list">
                        <li>
                            <span class="imd-meta-label">
                                Domain
                            </span>
                            <span class="imd-meta-value">
                                <asp:Label ID="lblDomain" runat="server" Text='<%# Eval("InternshipDomain") %>'></asp:Label>
                            </span>
                        </li>
                        <li>
                            <span class="imd-meta-label">
                                Type
                            </span>
                            <span class="imd-meta-value">
                                <asp:Label ID="lblType" runat="server" Text='<%# Eval("InternshipType") %>'></asp:Label>
                            </span>
                        </li>
                        <li>
                            <span class="imd-meta-label">
                                Work Mode
                            </span>
                            <span class="imd-meta-value">
                                <asp:Label ID="lblSidebarWorkMode" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label>
                            </span>
                        </li>
                        <li>
                            <span class="imd-meta-label">
                                Openings
                            </span>
                            <span class="imd-meta-value">
                                <asp:Label ID="lblOpenings" runat="server" Text='<%# Eval("NumberOfOpenings") %>'></asp:Label> Positions
                            </span>
                        </li>
                        <li>
                            <span class="imd-meta-label">
                                Start Date
                            </span>
                            <span class="imd-meta-value">
                                <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("StartDate") %>'></asp:Label>
                            </span>
                        </li>
                        <li>
                            <span class="imd-meta-label">
                                Apply Deadline
                            </span>
                            <span class="imd-meta-value">
                                <asp:Label ID="lblDeadline" runat="server" Text='<%# Eval("ApplicationDeadline") %>'></asp:Label>
                            </span>
                        </li>
                        <li>
                            <span class="imd-meta-label">
                                Eligible Courses
                            </span>
                            <span class="imd-meta-value">
                                <asp:Label ID="lblCourses" runat="server" Text='<%# Eval("EligibleCourses") %>'></asp:Label>
                            </span>
                        </li>
                        <li>
                            <span class="imd-meta-label">
                                Min CGPA
                            </span>
                            <span class="imd-meta-value">
                                <asp:Label ID="lblCGPA" runat="server" Text='<%# Eval("MinimumCGPA") %>'></asp:Label>
                            </span>
                        </li>
                    </ul>
                </div>
                <!-- Share -->
                <div class="imd-side-card" style="text-align:center;">
                    <h3 class="imd-side-title">
                        Share Internship
                    </h3>
                    <div class="imd-share-links">
                        <button type="button" class="imd-share-btn">
                            <i class="fa-brands fa-linkedin-in"></i>
                        </button>
                        <button type="button" class="imd-share-btn">
                            <i class="fa-brands fa-x-twitter"></i>
                        </button>
                        <button type="button" class="imd-share-btn">
                            <i class="fa-brands fa-facebook-f"></i>
                        </button>
                        <button type="button" class="imd-share-btn">
                            <i class="fa-solid fa-link"></i>
                        </button>
                    </div>
                </div>
            </aside>
        </div>
    </ItemTemplate>
</asp:DataList>
  </div>
</main>
</asp:Content>

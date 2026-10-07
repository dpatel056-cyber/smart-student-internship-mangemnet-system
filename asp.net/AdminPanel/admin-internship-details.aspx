<%@ Page Title="Admin - Internship Details" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-internship-details.aspx.cs" Inherits="asp.net.admin_internship_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/internship-module.css" />
    <style>
        .back-nav { margin-bottom: 24px; }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            padding: 10px 18px;
            background: #fff;
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

        /* Header */
        .imd-header { margin-bottom: 28px; }
        .imd-logo {
            width: 86px;
            height: 86px;
            padding: 3px;
            background: #fff;
            border-radius: 50% !important;
            overflow: hidden !important;
            box-shadow: 0 4px 12px rgba(0,0,0,.08);
        }
        .imd-title { margin-top: 12px; }
        .imd-company {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 16px;
        }
        .company-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
        }
        .imd-section-title i { color: #2563eb; margin-right: 8px; }

        /* Company logo + info box */
        .company-logo-avatar {
            display: block;
            width: 60px;
            height: 60px;
            border: 2px solid #e2e8f0;
            border-radius: 50% !important;
            overflow: hidden !important;
            object-fit: cover;
            background: #f8fafc;
        }
        .company-info-box {
            margin-top: 24px;
            padding: 24px;
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            box-shadow: 0 4px 14px rgba(0,0,0,.03);
        }
        .company-info-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 16px;
        }
        .company-name { margin: 0; font-size: 19px; font-weight: 700; color: #0f172a; }
        .company-meta { margin: 4px 0 0; font-size: 13.5px; color: #64748b; }
        .company-about { margin-bottom: 20px; font-size: 14px; line-height: 1.6; color: #334155; }

        /* Buttons */
        .btn-view-company {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 11px 22px;
            background: #2563eb;
            color: #fff !important;
            font-size: 14px;
            font-weight: 600;
            border-radius: 10px;
            text-decoration: none !important;
            box-shadow: 0 4px 12px rgba(37,99,235,.2);
            transition: all .2s ease;
        }
        .btn-view-company:hover {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(37,99,235,.3);
        }

        .imd-actions { display: flex; flex-direction: column; gap: 12px; }

        .btn-admin-danger,
        .btn-admin-toggle-active,
        .btn-admin-toggle-inactive {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            padding: 12px 20px;
            font-size: 14px;
            font-weight: 700;
            border-radius: 10px;
            text-decoration: none !important;
            cursor: pointer;
            transition: all .2s ease;
        }
        .btn-admin-danger {
            background: #ef4444;
            color: #fff !important;
            border: none;
            box-shadow: 0 4px 14px rgba(239,68,68,.25);
        }
        .btn-admin-danger:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(239,68,68,.35);
        }
        .btn-admin-toggle-active {
            background: #f0fdf4;
            color: #16a34a !important;
            border: 1px solid #bbf7d0;
        }
        .btn-admin-toggle-active:hover { background: #16a34a; color: #fff !important; }
        .btn-admin-toggle-inactive {
            background: #fff1f2;
            color: #e11d48 !important;
            border: 1px solid #fecdd3;
        }
        .btn-admin-toggle-inactive:hover { background: #e11d48; color: #fff !important; }

        /* Status badges */
        .status-badge-active,
        .status-badge-inactive {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
        }
        .status-badge-active { background: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; }
        .status-badge-inactive { background: #fee2e2; color: #dc2626; border: 1px solid #fecaca; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0;">

        <!-- Back Navigation -->
        <div class="back-nav">
            <a href="admin-internships.aspx" class="back-link">
                <i class="fa-solid fa-arrow-left"></i>Back to Internships Management
            </a>
        </div>

        <asp:DataList ID="DataListInternshipDetail" runat="server" Width="100%" OnItemCommand="DataListInternshipDetail_ItemCommand">
            <ItemTemplate>

                <!-- Header Banner -->
                <div class="imd-header">
                    <div class="imd-cover"></div>
                    <div class="imd-content">
                        <div class="imd-logo">
                            <asp:Image ID="imgHeaderCompanyLogo" runat="server" CssClass="company-logo-avatar"
                                ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' AlternateText="Company Logo" />
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

                            <%# IsInternshipActive(Eval("Status"))
                                ? "<span class='status-badge-active'><i class='fa-solid fa-circle-check'></i> Active</span>"
                                : "<span class='status-badge-inactive'><i class='fa-solid fa-circle-xmark'></i> Inactive</span>" %>
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
                                    ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' AlternateText="Company Logo" />
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

                            <asp:HyperLink ID="hlViewCompanyDetailsBtn" runat="server" CssClass="btn-view-company"
                                NavigateUrl='<%# "viewCompanyDetails.aspx?id=" + Eval("CompanyId") %>'>
                                <i class="fa-solid fa-building"></i> View Company Details
                            </asp:HyperLink>
                        </div>
                    </div>

                    <!-- Right Sidebar -->
                    <aside class="imd-sidebar">

                        <!-- Admin Actions -->
                        <div class="imd-side-card">
                            <h3 class="imd-side-title">Admin Actions</h3>
                            <div class="imd-actions">
                                <asp:LinkButton ID="btnToggleStatus" runat="server" CommandName="ToggleStatus"
                                    CommandArgument='<%# Eval("Id") + "|" + (Eval("Status") != null ? Eval("Status").ToString() : "Active") %>'
                                    CssClass='<%# IsInternshipActive(Eval("Status")) ? "btn-admin-toggle-active" : "btn-admin-toggle-inactive" %>'>
                                    <%# IsInternshipActive(Eval("Status"))
                                        ? "<i class='fa-solid fa-toggle-on'></i> Active"
                                        : "<i class='fa-solid fa-toggle-off'></i> Inactive" %>
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnDeleteInternship" runat="server" CommandName="DeleteInternship"
                                    CommandArgument='<%# Eval("Id") %>' CssClass="btn-admin-danger" CausesValidation="false">
                                    <i class="fa-solid fa-trash"></i> Delete Internship
                                </asp:LinkButton>
                            </div>
                        </div>

                        <!-- Internship Details -->
                        <div class="imd-side-card">
                            <h3 class="imd-side-title">Internship Details</h3>
                            <ul class="imd-meta-list">
                                <li>
                                    <span class="imd-meta-label">Status</span>
                                    <span class="imd-meta-value">
                                        <%# IsInternshipActive(Eval("Status"))
                                            ? "<span class='status-badge-active'><i class='fa-solid fa-circle-check'></i> Active</span>"
                                            : "<span class='status-badge-inactive'><i class='fa-solid fa-circle-xmark'></i> Inactive</span>" %>
                                    </span>
                                </li>
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
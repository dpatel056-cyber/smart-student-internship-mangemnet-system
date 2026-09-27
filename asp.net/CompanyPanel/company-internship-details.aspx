<%@ Page Title="Company - Internship Details" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-internship-details.aspx.cs" Inherits="asp.net.company_internship_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/internship-module.css" />
    <style>
        .back-nav {
            margin-bottom: 24px;
        }

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
            padding: 24px;
            margin-top: 24px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.03);
        }

        .company-info-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 16px;
        }

        .company-logo-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50% !important;
            overflow: hidden !important;
            border: 2px solid #e2e8f0;
            object-fit: cover;
            display: block;
            background: #f8fafc;
        }

        .btn-view-company {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 11px 22px;
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
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0;">

        <!-- Back Navigation -->
        <div class="back-nav">
            <a href="company-internships.aspx" class="back-link">
                <i class="fa-solid fa-arrow-left"></i> Back to My Internships
            </a>
        </div>

        <!-- DataList for Internship Details -->
        <asp:DataList ID="DataListInternshipDetail" runat="server" Width="100%">
            <ItemTemplate>

                <!-- Header Banner Card -->
                <div class="imd-header" style="margin-bottom: 28px;">
                    <div class="imd-cover"></div>
                    <div class="imd-content">
                        <div class="imd-logo" style="border-radius: 50% !important; overflow: hidden !important; width: 86px; height: 86px; background: #fff; padding: 3px; box-shadow: 0 4px 12px rgba(0,0,0,0.08);">
                            <asp:Image ID="Image1" runat="server"
                                CssClass="company-logo-avatar"
                                ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' />
                        </div>

                        <h1 class="imd-title" style="margin-top: 12px;">
                            <%# Eval("InternshipTitle") %>
                        </h1>

                        <div class="imd-company" style="margin-bottom: 16px;">
                            <span style="color: #2563eb; font-weight: 600; display: inline-flex; align-items: center; gap: 6px;">
                                <i class="fa-solid fa-building"></i>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                            </span>
                        </div>

                        <!-- Quick Info Pills -->
                        <div class="imd-quick-info">
                            <div class="imd-info-pill">
                                <i class="fa-solid fa-location-dot"></i>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                            </div>

                            <div class="imd-info-pill">
                                <i class="fa-solid fa-laptop-code"></i>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label>
                            </div>

                            <div class="imd-info-pill">
                                <i class="fa-solid fa-indian-rupee-sign"></i>
                                &#8377; <asp:Label ID="Label4" runat="server" Text='<%# Eval("StipendAmount") %>'></asp:Label> / month
                            </div>

                            <div class="imd-info-pill">
                                <i class="fa-regular fa-clock"></i>
                                <asp:Label ID="Label5" runat="server" Text='<%# Eval("Duration") %>'></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Layout Grid -->
                <div class="imd-layout">

                    <!-- Left Main Section -->
                    <div class="imd-main">

                        <!-- Overview -->
                        <div class="imd-section">
                            <h3 class="imd-section-title">
                                <i class="fa-solid fa-align-left" style="color: #2563eb; margin-right: 8px;"></i> Overview
                            </h3>
                            <p class="imd-text">
                                <%# Eval("InternshipDescription") %>
                            </p>
                        </div>

                        <!-- Key Responsibilities -->
                        <div class="imd-section">
                            <h3 class="imd-section-title">
                                <i class="fa-solid fa-list-check" style="color: #2563eb; margin-right: 8px;"></i> Key Responsibilities
                            </h3>
                            <div class="imd-text">
                                <%# Eval("Responsibilities") %>
                            </div>
                        </div>

                        <!-- Qualifications -->
                        <div class="imd-section">
                            <h3 class="imd-section-title">
                                <i class="fa-solid fa-user-graduate" style="color: #2563eb; margin-right: 8px;"></i> Requirements &amp; Qualifications
                            </h3>
                            <div class="imd-text">
                                <%# Eval("RequiredQualifications") %>
                            </div>
                        </div>

                        <!-- Required Skills -->
                        <div class="imd-section">
                            <h3 class="imd-section-title">
                                <i class="fa-solid fa-lightbulb" style="color: #2563eb; margin-right: 8px;"></i> Skills Required
                            </h3>
                            <div class="imd-skills">
                                <%# Eval("RequiredSkills") %>
                            </div>
                        </div>

                        <!-- Benefits & Perks -->
                        <div class="imd-section">
                            <h3 class="imd-section-title">
                                <i class="fa-solid fa-gift" style="color: #2563eb; margin-right: 8px;"></i> Benefits &amp; Perks
                            </h3>
                            <div class="imd-skills">
                                <%# Eval("Benefits") %>
                            </div>
                        </div>

                    </div>

                    <!-- Right Sidebar Section -->
                    <aside class="imd-sidebar">

                        <!-- Quick Actions Card -->
                        <div class="imd-side-card">
                            <h3 class="imd-side-title">Company Actions</h3>
                            <div class="imd-actions" style="display: flex; flex-direction: column; gap: 12px;">
                                <a href="company-internships.aspx" class="btn-view-company" style="width: 100%; text-align: center; justify-content: center;">
                                    <i class="fa-solid fa-list"></i> Back to My Internships
                                </a>
                            </div>
                        </div>

                        <!-- Internship Details Card -->
                        <div class="imd-side-card">
                            <h3 class="imd-side-title">Internship Details</h3>
                            <ul class="imd-meta-list">
                                <li>
                                    <span class="imd-meta-label">Domain</span>
                                    <span class="imd-meta-value"><%# Eval("InternshipDomain") %></span>
                                </li>
                                <li>
                                    <span class="imd-meta-label">Type</span>
                                    <span class="imd-meta-value"><%# Eval("InternshipType") %></span>
                                </li>
                                <li>
                                    <span class="imd-meta-label">Work Mode</span>
                                    <span class="imd-meta-value"><%# Eval("WorkMode") %></span>
                                </li>
                                <li>
                                    <span class="imd-meta-label">Openings</span>
                                    <span class="imd-meta-value"><%# Eval("NumberOfOpenings") %></span>
                                </li>
                                <li>
                                    <span class="imd-meta-label">Start Date</span>
                                    <span class="imd-meta-value"><%# Eval("StartDate") %></span>
                                </li>
                                <li>
                                    <span class="imd-meta-label">Apply Deadline</span>
                                    <span class="imd-meta-value"><%# Eval("ApplicationDeadline") %></span>
                                </li>
                                <li>
                                    <span class="imd-meta-label">Eligible Courses</span>
                                    <span class="imd-meta-value"><%# Eval("EligibleCourses") %></span>
                                </li>
                                <li>
                                    <span class="imd-meta-label">Min CGPA</span>
                                    <span class="imd-meta-value"><%# Eval("MinimumCGPA") %></span>
                                </li>
                            </ul>
                        </div>

                    </aside>

                </div>

            </ItemTemplate>
        </asp:DataList>

    </div>
</asp:Content>

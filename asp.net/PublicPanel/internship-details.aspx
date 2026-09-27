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
            object-fit: cover;
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
    <asp:Panel ID="pnlNotFound" runat="server" Visible="false" style="background:#fff; border-radius:16px; padding:60px; text-align:center; border:1px solid #e2e8f0; box-shadow:0 4px 12px rgba(0,0,0,0.03);">
        <i class="fa-solid fa-file-circle-xmark" style="font-size:56px; color:#ef4444; margin-bottom:16px;"></i>
        <h2 style="font-size:24px; font-weight:700; color:#0f172a; margin-bottom:8px;">Internship Not Found</h2>
        <p style="color:#64748b; font-size:15px; margin-bottom:20px;">The requested internship details could not be found or the link has expired.</p>
        <a href="internships.aspx" class="btn-view-company" style="background:#2563eb;">Explore Other Internships</a>
    </asp:Panel>

    <!-- DataList for Internship Details -->
    <asp:DataList ID="DataListInternshipDetail" runat="server" Width="100%">
        <ItemTemplate>

            <!-- Header Banner Card -->
            <div class="imd-header" style="margin-bottom:28px;">
                <div class="imd-cover"></div>
                <div class="imd-content">
                  <div class="imd-logo" style="border-radius:50% !important; overflow:hidden !important; width:90px; height:90px; background:#fff; padding:3px; box-shadow:0 4px 12px rgba(0,0,0,0.08);">
                      <img src='<%# GetCompanyLogo(Eval("c_logo")) %>' alt="Company Logo" style="width:100%; height:100%; border-radius:50% !important; object-fit:cover; display:block;" onerror="this.onerror=null; this.src='<%= ResolveUrl("~/assets/default-company.png") %>';" />
                  </div>
                  
                  <h1 class="imd-title" style="margin-top:12px;"><%# Eval("InternshipTitle") %></h1>
                  <div class="imd-company" style="margin-bottom:16px;">
                    <i class="fa-solid fa-building"></i> <span><%# GetCompanyName(Eval("c_company")) %></span>
                    <i class="fa-solid fa-circle-check cp-verified" style="color:#16a34a; font-size:14px; margin-left:6px;" title="Verified Company"></i>
                  </div>
                  
                  <div class="imd-quick-info">
                    <div class="imd-info-pill"><i class="fa-solid fa-location-dot"></i> <span><%# GetValueOrFallback(Eval("Location"), "India") %></span></div>
                    <div class="imd-info-pill"><i class="fa-solid fa-briefcase"></i> <span><%# GetValueOrFallback(Eval("WorkMode"), "In-Office") %></span></div>
                    <div class="imd-info-pill"><i class="fa-solid fa-indian-rupee-sign"></i> <span><%# GetStipend(Eval("PaymentStatus"), Eval("StipendAmount")) %></span></div>
                    <div class="imd-info-pill"><i class="fa-regular fa-clock"></i> <span><%# GetValueOrFallback(Eval("Duration"), "3 Months") %></span></div>
                  </div>
                </div>
            </div>

            <!-- Main Layout Grid -->
            <div class="imd-layout">
                
                <!-- Left Main Section -->
                <div class="imd-main">
                  
                  <div class="imd-section">
                    <h3 class="imd-section-title"><i class="fa-solid fa-align-left" style="color:#2563eb; margin-right:8px;"></i> Overview</h3>
                    <p class="imd-text"><%# GetFormattedText(Eval("InternshipDescription")) %></p>
                  </div>
                  
                  <div class="imd-section">
                    <h3 class="imd-section-title"><i class="fa-solid fa-list-check" style="color:#2563eb; margin-right:8px;"></i> Key Responsibilities</h3>
                    <div class="imd-text"><%# GetBulletList(Eval("Responsibilities")) %></div>
                  </div>
                  
                  <div class="imd-section">
                    <h3 class="imd-section-title"><i class="fa-solid fa-user-graduate" style="color:#2563eb; margin-right:8px;"></i> Requirements &amp; Qualifications</h3>
                    <div class="imd-text"><%# GetBulletList(Eval("RequiredQualifications")) %></div>
                  </div>

                  <div class="imd-section">
                    <h3 class="imd-section-title"><i class="fa-solid fa-lightbulb" style="color:#2563eb; margin-right:8px;"></i> Skills Required</h3>
                    <div class="imd-skills">
                        <%# GetSkillBadges(Eval("RequiredSkills")) %>
                    </div>
                  </div>
                  
                  <div class="imd-section">
                    <h3 class="imd-section-title"><i class="fa-solid fa-gift" style="color:#2563eb; margin-right:8px;"></i> Benefits &amp; Perks</h3>
                    <div class="imd-skills">
                        <%# GetBenefitBadges(Eval("Benefits"), Eval("OtherBenefits")) %>
                    </div>
                  </div>

                  <!-- Company Information Box (User Request) -->
                  <div class="company-info-box">
                    <div class="company-info-header">
                        <img src='<%# GetCompanyLogo(Eval("c_logo")) %>' alt="Company Logo" class="company-logo-avatar" onerror="this.onerror=null; this.src='<%= ResolveUrl("~/assets/default-company.png") %>';" />
                        <div>
                            <h3 style="font-size:20px; font-weight:700; color:#0f172a; margin:0;"><%# GetCompanyName(Eval("c_company")) %></h3>
                            <p style="color:#64748b; font-size:14px; margin:4px 0 0 0;">
                                <i class="fa-solid fa-industry"></i> <%# GetValueOrFallback(Eval("c_industry"), "Information Technology") %> &nbsp;|&nbsp; 
                                <i class="fa-solid fa-location-dot"></i> <%# GetCompanyLocation(Eval("c_location"), Eval("c_city"), Eval("c_state")) %>
                            </p>
                        </div>
                    </div>
                    
                    <p style="color:#334155; font-size:14px; line-height:1.6; margin-bottom:20px;">
                        <%# GetValueOrFallback(Eval("c_about"), "Leading company offering professional internship opportunities and career development programs.") %>
                    </p>

                    <!-- View Company Button -->
                    <a href='<%# ResolveUrl("~/company-details.aspx") %>?CompanyId=<%# Eval("CompanyId") %>' class="btn-view-company">
                        <i class="fa-solid fa-building"></i> View Company Details
                    </a>
                  </div>
                  
                </div>
                
                <!-- Right Sidebar Section -->
                <aside class="imd-sidebar">
                  
                  <!-- Quick Actions -->
                  <div class="imd-side-card">
                    <h3 class="imd-side-title">Quick Actions</h3>
                    <div class="imd-actions">
                        <!-- Apply Internship Button -->
                        <a href='<%# GetApplyUrl(Eval("Id")) %>' class="btn-apply-now">
                            <i class="fa-solid fa-paper-plane"></i> Apply Internship
                        </a>
                        <button type="button" class="btn imd-btn-save" style="width:100%; display:inline-flex; align-items:center; justify-content:center; gap:8px; padding:12px; border:1px solid #cbd5e1; border-radius:10px; background:#fff; font-weight:600; cursor:pointer;">
                            <i class="fa-regular fa-bookmark"></i> Save Internship
                        </button>
                    </div>
                  </div>
                  
                  <!-- Job Details Card -->
                  <div class="imd-side-card">
                    <h3 class="imd-side-title">Internship Details</h3>
                    <ul class="imd-meta-list">
                      <li>
                        <span class="imd-meta-label">Domain</span>
                        <span class="imd-meta-value"><%# GetValueOrFallback(Eval("InternshipDomain"), "Software") %></span>
                      </li>
                      <li>
                        <span class="imd-meta-label">Type</span>
                        <span class="imd-meta-value"><%# GetValueOrFallback(Eval("InternshipType"), "Full-time") %></span>
                      </li>
                      <li>
                        <span class="imd-meta-label">Work Mode</span>
                        <span class="imd-meta-value"><%# GetValueOrFallback(Eval("WorkMode"), "In-Office") %></span>
                      </li>
                      <li>
                        <span class="imd-meta-label">Openings</span>
                        <span class="imd-meta-value"><%# GetValueOrFallback(Eval("NumberOfOpenings"), "1") %> Positions</span>
                      </li>
                      <li>
                        <span class="imd-meta-label">Start Date</span>
                        <span class="imd-meta-value"><%# GetValueOrFallback(Eval("StartDate"), "Immediate") %></span>
                      </li>
                      <li>
                        <span class="imd-meta-label">Apply Deadline</span>
                        <span class="imd-meta-value"><%# GetValueOrFallback(Eval("ApplicationDeadline"), "Open") %></span>
                      </li>
                      <li>
                        <span class="imd-meta-label">Eligible Courses</span>
                        <span class="imd-meta-value"><%# GetValueOrFallback(Eval("EligibleCourses"), "All Graduates") %></span>
                      </li>
                      <li>
                        <span class="imd-meta-label">Min CGPA</span>
                        <span class="imd-meta-value"><%# GetValueOrFallback(Eval("MinimumCGPA"), "N/A") %></span>
                      </li>
                    </ul>
                  </div>
                  
                  <!-- Share Card -->
                  <div class="imd-side-card" style="text-align: center;">
                    <h3 class="imd-side-title">Share Internship</h3>
                    <div class="imd-share-links">
                      <button type="button" class="imd-share-btn" aria-label="Share on LinkedIn"><i class="fa-brands fa-linkedin-in"></i></button>
                      <button type="button" class="imd-share-btn" aria-label="Share on Twitter"><i class="fa-brands fa-x-twitter"></i></button>
                      <button type="button" class="imd-share-btn" aria-label="Share on Facebook"><i class="fa-brands fa-facebook-f"></i></button>
                      <button type="button" class="imd-share-btn" aria-label="Copy Link"><i class="fa-solid fa-link"></i></button>
                    </div>
                  </div>
                  
                </aside>

            </div>

        </ItemTemplate>
    </asp:DataList>

  </div>
</main>

</asp:Content>

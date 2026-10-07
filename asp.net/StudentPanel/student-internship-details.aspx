<%@ Page Title="Internship Details" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-internship-details.aspx.cs" Inherits="asp.net.student_internship_details" %>
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
        .company-logo-avatar {
            width: 76px;
            height: 76px;
            border-radius: 50% !important;
            overflow: hidden !important;
            border: 2px solid #e2e8f0;
            object-fit: cover;
            display: block;
            background: #f8fafc;
        }
        .btn-apply-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            padding: 12px 24px;
            background: #2563eb;
            color: #ffffff !important;
            font-weight: 700;
            font-size: 15px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            text-decoration: none !important;
            box-shadow: 0 4px 12px rgba(37,99,235,0.25);
            transition: all 0.2s ease;
        }
        .btn-apply-action:hover:not(:disabled) {
            background: #1d4ed8;
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(37,99,235,0.35);
        }
        .btn-apply-action.applied {
            background: #10B981;
            box-shadow: 0 4px 12px rgba(16,185,129,0.25);
            cursor: default;
        }
        .btn-save-action {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            width: 100%;
            padding: 10px 24px;
            background: #eff6ff;
            color: #2563eb !important;
            font-weight: 600;
            font-size: 14px;
            border-radius: 10px;
            border: 1px solid #bfdbfe;
            cursor: pointer;
            text-decoration: none !important;
            transition: all 0.2s ease;
        }
        .btn-save-action:hover {
            background: #dbeafe;
        }
        /* Apply Modal Overlay & Box */
        .app-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 9999;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 20px;
            overflow-y: auto;
        }
        .app-modal-box {
            background: #ffffff;
            border-radius: 20px;
            width: 100%;
            max-width: 680px;
            max-height: 90vh;
            display: flex;
            flex-direction: column;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            animation: modalFadeIn 0.25s ease-out;
            overflow: hidden;
        }
        @keyframes modalFadeIn {
            from { opacity: 0; transform: scale(0.96) translateY(10px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }
        .app-modal-header {
            padding: 20px 28px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f8fafc;
        }
        .app-modal-header h3 {
            margin: 0;
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .app-modal-close {
            background: transparent;
            border: none;
            font-size: 22px;
            color: #64748b;
            cursor: pointer;
            padding: 4px 8px;
            border-radius: 6px;
            transition: all 0.2s;
        }
        .app-modal-close:hover {
            color: #ef4444;
            background: #fee2e2;
        }
        .app-modal-body {
            padding: 24px 28px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .app-form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }
        @media (max-width: 640px) {
            .app-form-grid {
                grid-template-columns: 1fr;
            }
        }
        .app-form-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }
        .app-form-label {
            font-size: 13px;
            font-weight: 600;
            color: #334155;
        }
        .app-form-label .req {
            color: #ef4444;
            margin-left: 2px;
        }
        .app-form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1.5px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            color: #0f172a;
            outline: none;
            transition: all 0.2s;
            font-family: inherit;
            background: #ffffff;
            box-sizing: border-box;
        }
        .app-form-control:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.12);
        }
        .app-form-control[readonly] {
            background: #f8fafc;
            color: #64748b;
            cursor: not-allowed;
        }
        .app-file-box {
            background: #f8fafc;
            border: 1.5px dashed #cbd5e1;
            border-radius: 12px;
            padding: 16px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .app-modal-footer {
            padding: 18px 28px;
            border-top: 1px solid #e2e8f0;
            background: #f8fafc;
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 12px;
        }
        .btn-cancel-modal {
            padding: 10px 20px;
            background: #ffffff;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            color: #475569;
            cursor: pointer;
            transition: all 0.2s;
        }
        .btn-cancel-modal:hover {
            background: #f1f5f9;
            color: #0f172a;
        }
        .btn-submit-app {
            padding: 10px 24px;
            background: #2563eb;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 700;
            color: #ffffff;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
            transition: all 0.2s;
        }
        .company-link-badge {
            color: #2563eb !important;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none !important;
            transition: all 0.2s ease;
            cursor: pointer;
        }
        .company-link-badge:hover {
            color: #1d4ed8 !important;
            text-decoration: none !important;
            opacity: 0.9;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0;">
        <!-- Back Navigation -->
        <div class="back-nav">
            <asp:HyperLink ID="hlBackToInternships" runat="server" NavigateUrl="student-internships.aspx" CssClass="back-link">
                <i class="fa-solid fa-arrow-left"></i> Back to Internships
            </asp:HyperLink>
        </div>
        <asp:Label ID="lblActionMsg" runat="server" Visible="false"></asp:Label>
        <!-- Main Details Container -->
        <asp:PlaceHolder ID="pnlInternshipContent" runat="server">
            <!-- Header Banner Card -->
            <div class="imd-header" style="margin-bottom: 28px;">
                <div class="imd-cover"></div>
                <div class="imd-content">
                    <div class="imd-logo" style="border-radius: 50% !important; overflow: hidden !important; width: 86px; height: 86px; background: #fff; padding: 3px; box-shadow: 0 4px 12px rgba(0,0,0,0.08);">
                        <asp:HyperLink ID="hlCompanyLogo" runat="server" ToolTip="View Company Profile">
                            <asp:Image ID="imgCompanyLogo" runat="server" CssClass="company-logo-avatar" />
                        </asp:HyperLink>
                    </div>
                    <h1 class="imd-title" style="margin-top: 12px;">
                        <asp:Label ID="lblTitle" runat="server"></asp:Label>
                    </h1>
                    <div class="imd-company" style="margin-bottom: 16px;">
                        <asp:HyperLink ID="hlCompany" runat="server" CssClass="company-link-badge" ToolTip="Click to view company profile">
                            <i class="fa-solid fa-building"></i>
                            <asp:Label ID="lblCompany" runat="server"></asp:Label>
                        </asp:HyperLink>
                    </div>
                    <!-- Quick Info Pills -->
                    <div class="imd-quick-info">
                        <div class="imd-info-pill">
                            <i class="fa-solid fa-location-dot"></i>
                            <asp:Label ID="lblLocation" runat="server"></asp:Label>
                        </div>
                        <div class="imd-info-pill">
                            <i class="fa-solid fa-laptop-code"></i>
                            <asp:Label ID="lblWorkMode" runat="server"></asp:Label>
                        </div>
                        <div class="imd-info-pill">
                            <i class="fa-solid fa-indian-rupee-sign"></i>
                            <asp:Label ID="lblStipend" runat="server"></asp:Label>
                        </div>
                        <div class="imd-info-pill">
                            <i class="fa-regular fa-clock"></i>
                            <asp:Label ID="lblDuration" runat="server"></asp:Label>
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
                            <asp:Label ID="lblOverview" runat="server"></asp:Label>
                        </p>
                    </div>
                    <!-- Key Responsibilities -->
                    <div class="imd-section">
                        <h3 class="imd-section-title">
                            <i class="fa-solid fa-list-check" style="color: #2563eb; margin-right: 8px;"></i> Key Responsibilities
                        </h3>
                        <div class="imd-text">
                            <asp:Label ID="lblResponsibilities" runat="server"></asp:Label>
                        </div>
                    </div>
                    <!-- Qualifications -->
                    <div class="imd-section">
                        <h3 class="imd-section-title">
                            <i class="fa-solid fa-user-graduate" style="color: #2563eb; margin-right: 8px;"></i> Requirements &amp; Qualifications
                        </h3>
                        <div class="imd-text">
                            <asp:Label ID="lblQualifications" runat="server"></asp:Label>
                        </div>
                    </div>
                    <!-- Required Skills -->
                    <div class="imd-section">
                        <h3 class="imd-section-title">
                            <i class="fa-solid fa-lightbulb" style="color: #2563eb; margin-right: 8px;"></i> Skills Required
                        </h3>
                        <div class="imd-skills">
                            <asp:Label ID="lblSkills" runat="server"></asp:Label>
                        </div>
                    </div>
                    <!-- Benefits & Perks -->
                    <div class="imd-section">
                        <h3 class="imd-section-title">
                            <i class="fa-solid fa-gift" style="color: #2563eb; margin-right: 8px;"></i> Benefits &amp; Perks
                        </h3>
                        <div class="imd-skills">
                            <asp:Label ID="lblBenefits" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <!-- Right Sidebar Section -->
                <aside class="imd-sidebar">
                    <!-- Apply Card -->
                    <div class="imd-side-card">
                        <div style="display: flex; flex-direction: column; gap: 12px;">
                            <asp:PlaceHolder ID="pnlApplyBtn" runat="server">
                                <button type="button" class="btn-apply-action" onclick="openApplyModal()">
                                    <i class="fa-solid fa-paper-plane"></i> Apply Now
                                </button>
                            </asp:PlaceHolder>
                            <asp:PlaceHolder ID="pnlAlreadyApplied" runat="server" Visible="false">
                                <div style="background: #ecfdf5; border: 1px solid #a7f3d0; border-radius: 10px; padding: 14px; text-align: center;">
                                    <div style="color: #059669; font-weight: 700; font-size: 14px; margin-bottom: 4px;">
                                        <i class="fa-solid fa-circle-check"></i> Already Applied
                                    </div>
                                    <p style="font-size: 12.5px; color: #047857; margin: 0 0 10px 0;">
                                        You have submitted an application for this internship.
                                    </p>
                                    <asp:HyperLink ID="hlMyApplications" runat="server" NavigateUrl="~/StudentPanel/student-my-applications.aspx" CssClass="btn-save-action" Style="background: #ffffff; border-color: #a7f3d0; color: #059669 !important;">
                                        <i class="fa-solid fa-list-check"></i> Track in My Applications
                                    </asp:HyperLink>
                                </div>
                            </asp:PlaceHolder>
                            <asp:LinkButton ID="btnSave" runat="server" CssClass="btn-save-action" OnClick="btnSave_Click">
                                <i class="fa-solid fa-bookmark"></i>
                                <span>Save Internship</span>
                            </asp:LinkButton>
                        </div>
                    </div>
                    <!-- About Company Card -->
                    <div class="imd-side-card">
                        <h3 class="imd-side-title">
                            <i class="fa-solid fa-building" style="color: #2563eb; margin-right: 6px;"></i> About Company
                        </h3>
                        <p style="font-size: 13.5px; color: #64748b; line-height: 1.5; margin: 0 0 16px 0;">
                            <asp:Label ID="lblCompanyAbout" runat="server"></asp:Label>
                        </p>
                        <asp:HyperLink ID="hlViewCompanyProfile" runat="server" CssClass="btn-save-action" Style="text-align: center; justify-content: center; background: #eff6ff; color: #2563eb !important; border-color: #bfdbfe;">
                            <i class="fa-solid fa-arrow-up-right-from-square"></i> View Company Profile
                        </asp:HyperLink>
                    </div>
                    <!-- Internship Details Card -->
                    <div class="imd-side-card">
                        <h3 class="imd-side-title">Internship Details</h3>
                        <ul class="imd-meta-list">
                            <li>
                                <span class="imd-meta-label">Domain</span>
                                <span class="imd-meta-value"><asp:Label ID="lblDomain" runat="server"></asp:Label></span>
                            </li>
                            <li>
                                <span class="imd-meta-label">Type</span>
                                <span class="imd-meta-value"><asp:Label ID="lblType" runat="server"></asp:Label></span>
                            </li>
                            <li>
                                <span class="imd-meta-label">Work Mode</span>
                                <span class="imd-meta-value"><asp:Label ID="lblSideWorkMode" runat="server"></asp:Label></span>
                            </li>
                            <li>
                                <span class="imd-meta-label">Openings</span>
                                <span class="imd-meta-value"><asp:Label ID="lblOpenings" runat="server"></asp:Label></span>
                            </li>
                            <li>
                                <span class="imd-meta-label">Start Date</span>
                                <span class="imd-meta-value"><asp:Label ID="lblStartDate" runat="server"></asp:Label></span>
                            </li>
                            <li>
                                <span class="imd-meta-label">Apply Deadline</span>
                                <span class="imd-meta-value"><asp:Label ID="lblDeadline" runat="server"></asp:Label></span>
                            </li>
                            <li>
                                <span class="imd-meta-label">Eligible Courses</span>
                                <span class="imd-meta-value"><asp:Label ID="lblEligibleCourses" runat="server"></asp:Label></span>
                            </li>
                            <li>
                                <span class="imd-meta-label">Min CGPA</span>
                                <span class="imd-meta-value"><asp:Label ID="lblMinCGPA" runat="server"></asp:Label></span>
                            </li>
                        </ul>
                    </div>
                </aside>
            </div>
        </asp:PlaceHolder>
    </div>
    <!-- Apply Internship Modal -->
    <div id="applyModalOverlay" class="app-modal-overlay">
        <div class="app-modal-box">
            <!-- Modal Header -->
            <div class="app-modal-header">
                <h3><i class="fa-solid fa-briefcase" style="color: #2563eb;"></i> Apply for Internship</h3>
                <button type="button" class="app-modal-close" onclick="closeApplyModal()">&times;</button>
            </div>
            <!-- Modal Body Form -->
            <div class="app-modal-body">
                <div style="background: #eff6ff; border: 1px solid #bfdbfe; border-radius: 12px; padding: 12px 16px; display: flex; align-items: center; gap: 12px;">
                    <div style="width: 40px; height: 40px; border-radius: 8px; background: #2563eb; color: #fff; display: flex; align-items: center; justify-content: center; font-size: 18px; flex-shrink: 0;">
                        <i class="fa-solid fa-building"></i>
                    </div>
                    <div>
                        <div style="font-size: 14px; font-weight: 700; color: #1e293b;">
                            <asp:Label ID="lblModalRoleTitle" runat="server"></asp:Label>
                        </div>
                        <div style="font-size: 12.5px; color: #2563eb; font-weight: 600;">
                            <asp:Label ID="lblModalCompanyName" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <asp:Label ID="lblModalError" runat="server" Visible="false" CssClass="alert-error" Style="color: #dc2626; font-size: 13px; font-weight: 600; background: #fef2f2; border: 1px solid #fecaca; padding: 10px 14px; border-radius: 8px;"></asp:Label>
                <div class="app-form-grid">
                    <div class="app-form-group">
                        <label class="app-form-label">Full Name <span class="req">*</span></label>
                        <asp:TextBox ID="txtApplicantName" runat="server" CssClass="app-form-control" placeholder="Your Full Name"></asp:TextBox>
                    </div>
                    <div class="app-form-group">
                        <label class="app-form-label">Email Address <span class="req">*</span></label>
                        <asp:TextBox ID="txtApplicantEmail" runat="server" CssClass="app-form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="app-form-group">
                        <label class="app-form-label">Contact Number <span class="req">*</span></label>
                        <asp:TextBox ID="txtApplicantMobile" runat="server" CssClass="app-form-control" placeholder="10-digit mobile number"></asp:TextBox>
                    </div>
                    <div class="app-form-group">
                        <label class="app-form-label">College / Institute <span class="req">*</span></label>
                        <asp:TextBox ID="txtApplicantCollege" runat="server" CssClass="app-form-control" placeholder="Your College Name"></asp:TextBox>
                    </div>
                    <div class="app-form-group">
                        <label class="app-form-label">Course / Degree <span class="req">*</span></label>
                        <asp:TextBox ID="txtApplicantCourse" runat="server" CssClass="app-form-control" placeholder="e.g. BCA, B.Tech, MCA"></asp:TextBox>
                    </div>
                    <div class="app-form-group">
                        <label class="app-form-label">Current Semester / Year <span class="req">*</span></label>
                        <asp:TextBox ID="txtApplicantSemester" runat="server" CssClass="app-form-control" placeholder="e.g. Sem 5, 3rd Year"></asp:TextBox>
                    </div>
                    <div class="app-form-group">
                        <label class="app-form-label">Current CGPA / Percentage <span class="req">*</span></label>
                        <asp:TextBox ID="txtApplicantCGPA" runat="server" CssClass="app-form-control" placeholder="e.g. 8.5 CGPA"></asp:TextBox>
                    </div>
                    <div class="app-form-group">
                        <label class="app-form-label">Joining Availability <span class="req">*</span></label>
                        <asp:DropDownList ID="ddlApplicantAvailability" runat="server" CssClass="app-form-control">
                            <asp:ListItem Text="Immediate (Within 3 days)" Value="Immediate"></asp:ListItem>
                            <asp:ListItem Text="Within 1 Week" Value="Within 1 Week"></asp:ListItem>
                            <asp:ListItem Text="Within 15 Days" Value="Within 15 Days"></asp:ListItem>
                            <asp:ListItem Text="Within 1 Month" Value="Within 1 Month"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <!-- Resume Upload Section -->
                <div class="app-form-group">
                    <label class="app-form-label">Resume / CV (PDF or DOC) <span class="req">*</span></label>
                    <div class="app-file-box">
                        <asp:HiddenField ID="hfProfileResume" runat="server" />
                        <div id="divCurrentResume" runat="server" visible="false" style="font-size: 13px; color: #16a34a; font-weight: 600; display: flex; align-items: center; gap: 6px;">
                            <i class="fa-solid fa-file-pdf"></i>
                            <span>Attached Profile Resume: <asp:Label ID="lblCurrentResumeName" runat="server"></asp:Label></span>
                        </div>
                        <div style="font-size: 12.5px; color: #64748b;">
                            <asp:Label ID="lblUploadResumePrompt" runat="server" Text="Upload a new resume if you want to replace it for this application:"></asp:Label>
                        </div>
                        <asp:FileUpload ID="fuApplicantResume" runat="server" CssClass="app-form-control" accept=".pdf,.doc,.docx" />
                    </div>
                </div>
                <!-- Cover Letter / Notes -->
                <div class="app-form-group">
                    <label class="app-form-label">Why should you be hired for this role? (Cover Note)</label>
                    <asp:TextBox ID="txtApplicantCoverLetter" runat="server" TextMode="MultiLine" Rows="3" CssClass="app-form-control" placeholder="Briefly highlight your relevant skills, projects, and why you are interested in this position..."></asp:TextBox>
                </div>
            </div>
            <!-- Modal Footer -->
            <div class="app-modal-footer">
                <button type="button" class="btn-cancel-modal" onclick="closeApplyModal()">Cancel</button>
                <asp:Button ID="btnSubmitApplication" runat="server" Text="Submit Application" CssClass="btn-submit-app" OnClick="btnSubmitApplication_Click" />
            </div>
        </div>
    </div>
    <script type="text/javascript">
        function openApplyModal() {
            var modal = document.getElementById('applyModalOverlay');
            if (modal) {
                modal.style.display = 'flex';
            }
        }
        function closeApplyModal() {
            var modal = document.getElementById('applyModalOverlay');
            if (modal) {
                modal.style.display = 'none';
            }
        }
        // Close on clicking outside
        window.onclick = function (event) {
            var modal = document.getElementById('applyModalOverlay');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        };
    </script>
</asp:Content>

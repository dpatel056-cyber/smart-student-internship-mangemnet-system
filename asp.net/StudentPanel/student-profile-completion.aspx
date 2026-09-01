<%@ Page Title="Profile Completion" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeFile="student-profile-completion.aspx.cs" Inherits="asp.net.student_profile_completion" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/student-profile-completion.css") %>" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-profile-completion">

        <!-- ===================== 1. PAGE HEADER ===================== -->
        <div class="profile-completion-header">
            <div>
                <h1 class="profile-completion-title">Profile Completion</h1>
                <p class="profile-completion-subtitle">Complete your profile to improve your internship opportunities and visibility to companies.</p>
            </div>
            <div>
                <a href="student-edit-profile.aspx" class="profile-completion-header-btn">
                    <i class="fa-solid fa-pen-to-square"></i> Edit Profile
                </a>
            </div>
        </div>

        <!-- ===================== 2. HERO CARD WITH CIRCULAR PROGRESS ===================== -->
        <div class="profile-completion-hero">
            <div class="profile-completion-hero-left">
                <span class="profile-completion-hero-tag">
                    <i class="fa-solid fa-chart-pie"></i> SIMS Profile Status
                </span>
                <h2 class="profile-completion-hero-title">
                    <asp:Literal ID="litStatusHeading" runat="server" Text="Good progress! Complete a few more details." />
                </h2>
                <p class="profile-completion-hero-desc">
                    A fully completed profile receives up to 3&times; more interview invitations from top recruiting companies and improved AI recommendations.
                </p>
                <div class="profile-completion-mobile-bar">
                    <div class="profile-completion-mobile-fill" style="width: 85%;"></div>
                </div>
            </div>

            <!-- Circular Progress Ring (Desktop) -->
            <div class="profile-completion-ring-wrap">
                <svg class="profile-completion-ring-svg" viewBox="0 0 140 140">
                    <circle class="profile-completion-ring-bg" cx="70" cy="70" r="60"></circle>
                    <circle id="ringFillCircle" class="profile-completion-ring-fill" cx="70" cy="70" r="60" data-percentage="85"></circle>
                </svg>
                <div class="profile-completion-ring-text">
                    <span class="profile-completion-percentage" id="ringPercentageText">
                        <asp:Literal ID="litOverallPercentage" runat="server" Text="85" />%
                    </span>
                    <span class="profile-completion-percentage-label">Complete</span>
                </div>
            </div>
        </div>

        <!-- ===================== 3. PROFILE SECTIONS CHECKLIST ===================== -->
        <div class="profile-completion-card">
            <div class="profile-completion-card-header">
                <h3 class="profile-completion-card-title">
                    <i class="fa-solid fa-list-check"></i> Profile Sections Checklist
                </h3>
            </div>

            <div class="profile-completion-sections-grid">
                
                <!-- SECTION 1: Basic Information -->
                <div class="profile-completion-section-item">
                    <div class="profile-completion-section-left">
                        <div class="profile-completion-icon-box icon-completed">
                            <i class="fa-solid fa-user"></i>
                        </div>
                        <div class="profile-completion-section-info">
                            <h4 class="profile-completion-section-name">
                                Basic Information
                                <span class="profile-completion-badge badge-green">✓ Completed</span>
                            </h4>
                            <p class="profile-completion-section-desc">Name, date of birth and personal details</p>
                        </div>
                    </div>
                    <a href="student-edit-profile.aspx" class="profile-completion-action-btn btn-edit">Edit</a>
                </div>

                <!-- SECTION 2: Contact Information -->
                <div class="profile-completion-section-item">
                    <div class="profile-completion-section-left">
                        <div class="profile-completion-icon-box icon-warning">
                            <i class="fa-solid fa-phone"></i>
                        </div>
                        <div class="profile-completion-section-info">
                            <h4 class="profile-completion-section-name">
                                Contact Information
                                <span class="profile-completion-badge badge-orange">80% Complete</span>
                            </h4>
                            <p class="profile-completion-section-desc">Phone number, address and pincode</p>
                        </div>
                    </div>
                    <a href="student-edit-profile.aspx" class="profile-completion-action-btn btn-complete">Complete</a>
                </div>

                <!-- SECTION 3: Profile Photo -->
                <div class="profile-completion-section-item">
                    <div class="profile-completion-section-left">
                        <div class="profile-completion-icon-box icon-danger">
                            <i class="fa-solid fa-camera"></i>
                        </div>
                        <div class="profile-completion-section-info">
                            <h4 class="profile-completion-section-name">
                                Profile Photo
                                <span class="profile-completion-badge badge-red">Incomplete</span>
                            </h4>
                            <p class="profile-completion-section-desc">⚠ Professional profile photo missing</p>
                        </div>
                    </div>
                    <a href="student-edit-profile.aspx" class="profile-completion-action-btn btn-complete">Upload Photo</a>
                </div>

                <!-- SECTION 4: Education Details -->
                <div class="profile-completion-section-item">
                    <div class="profile-completion-section-left">
                        <div class="profile-completion-icon-box icon-completed">
                            <i class="fa-solid fa-graduation-cap"></i>
                        </div>
                        <div class="profile-completion-section-info">
                            <h4 class="profile-completion-section-name">
                                Education Details
                                <span class="profile-completion-badge badge-green">90% Complete</span>
                            </h4>
                            <p class="profile-completion-section-desc">College, course, branch, semester & CGPA</p>
                        </div>
                    </div>
                    <a href="student-education.aspx" class="profile-completion-action-btn btn-edit">Edit</a>
                </div>

                <!-- SECTION 5: Skills -->
                <div class="profile-completion-section-item">
                    <div class="profile-completion-section-left">
                        <div class="profile-completion-icon-box icon-completed">
                            <i class="fa-solid fa-code"></i>
                        </div>
                        <div class="profile-completion-section-info">
                            <h4 class="profile-completion-section-name">
                                Technical Skills
                                <span class="profile-completion-badge badge-green">✓ Completed</span>
                            </h4>
                            <p class="profile-completion-section-desc">6 technical skills added</p>
                        </div>
                    </div>
                    <a href="student-skills.aspx" class="profile-completion-action-btn btn-edit">Manage Skills</a>
                </div>

                <!-- SECTION 6: Resume -->
                <div class="profile-completion-section-item">
                    <div class="profile-completion-section-left">
                        <div class="profile-completion-icon-box icon-completed">
                            <i class="fa-solid fa-file-pdf"></i>
                        </div>
                        <div class="profile-completion-section-info">
                            <h4 class="profile-completion-section-name">
                                Resume / CV
                                <span class="profile-completion-badge badge-green">✓ Uploaded</span>
                            </h4>
                            <p class="profile-completion-section-desc">Dhruvi_Patel_Resume.pdf (Uploaded)</p>
                        </div>
                    </div>
                    <a href="student-resume.aspx" class="profile-completion-action-btn btn-edit">View Resume</a>
                </div>

                <!-- SECTION 7: Career Preferences -->
                <div class="profile-completion-section-item">
                    <div class="profile-completion-section-left">
                        <div class="profile-completion-icon-box icon-completed">
                            <i class="fa-solid fa-bullseye"></i>
                        </div>
                        <div class="profile-completion-section-info">
                            <h4 class="profile-completion-section-name">
                                Career Preferences
                                <span class="profile-completion-badge badge-green">80% Complete</span>
                            </h4>
                            <p class="profile-completion-section-desc">Category: Web Dev &bull; Location: Ahmedabad</p>
                        </div>
                    </div>
                    <a href="student-edit-profile.aspx" class="profile-completion-action-btn btn-edit">Edit Preferences</a>
                </div>

                <!-- SECTION 8: Professional Links -->
                <div class="profile-completion-section-item">
                    <div class="profile-completion-section-left">
                        <div class="profile-completion-icon-box icon-warning">
                            <i class="fa-solid fa-link"></i>
                        </div>
                        <div class="profile-completion-section-info">
                            <h4 class="profile-completion-section-name">
                                Professional Links
                                <span class="profile-completion-badge badge-orange">67% Complete</span>
                            </h4>
                            <p class="profile-completion-section-desc">LinkedIn ✓ &bull; Portfolio ✓ &bull; GitHub ✕</p>
                        </div>
                    </div>
                    <a href="student-edit-profile.aspx" class="profile-completion-action-btn btn-complete">Add Links</a>
                </div>

            </div>
        </div>

        <!-- ===================== 4. COMPLETION BREAKDOWN ===================== -->
        <div class="profile-completion-card">
            <div class="profile-completion-card-header">
                <h3 class="profile-completion-card-title">
                    <i class="fa-solid fa-chart-bar"></i> Profile Completion Breakdown
                </h3>
            </div>

            <div class="profile-completion-breakdown-list">
                
                <div class="profile-completion-row">
                    <span class="profile-completion-row-label">Basic Information</span>
                    <div class="profile-completion-row-track">
                        <div class="profile-completion-row-fill fill-success" style="width: 0%;" data-percentage="100%"></div>
                    </div>
                    <span class="profile-completion-row-val">100%</span>
                </div>

                <div class="profile-completion-row">
                    <span class="profile-completion-row-label">Contact Information</span>
                    <div class="profile-completion-row-track">
                        <div class="profile-completion-row-fill fill-blue" style="width: 0%;" data-percentage="80%"></div>
                    </div>
                    <span class="profile-completion-row-val">80%</span>
                </div>

                <div class="profile-completion-row">
                    <span class="profile-completion-row-label">Profile Photo</span>
                    <div class="profile-completion-row-track">
                        <div class="profile-completion-row-fill fill-danger" style="width: 0%;" data-percentage="0%"></div>
                    </div>
                    <span class="profile-completion-row-val">0%</span>
                </div>

                <div class="profile-completion-row">
                    <span class="profile-completion-row-label">Education Details</span>
                    <div class="profile-completion-row-track">
                        <div class="profile-completion-row-fill fill-blue" style="width: 0%;" data-percentage="90%"></div>
                    </div>
                    <span class="profile-completion-row-val">90%</span>
                </div>

                <div class="profile-completion-row">
                    <span class="profile-completion-row-label">Technical Skills</span>
                    <div class="profile-completion-row-track">
                        <div class="profile-completion-row-fill fill-success" style="width: 0%;" data-percentage="100%"></div>
                    </div>
                    <span class="profile-completion-row-val">100%</span>
                </div>

                <div class="profile-completion-row">
                    <span class="profile-completion-row-label">Resume / CV</span>
                    <div class="profile-completion-row-track">
                        <div class="profile-completion-row-fill fill-success" style="width: 0%;" data-percentage="100%"></div>
                    </div>
                    <span class="profile-completion-row-val">100%</span>
                </div>

                <div class="profile-completion-row">
                    <span class="profile-completion-row-label">Career Preferences</span>
                    <div class="profile-completion-row-track">
                        <div class="profile-completion-row-fill fill-blue" style="width: 0%;" data-percentage="80%"></div>
                    </div>
                    <span class="profile-completion-row-val">80%</span>
                </div>

                <div class="profile-completion-row">
                    <span class="profile-completion-row-label">Professional Links</span>
                    <div class="profile-completion-row-track">
                        <div class="profile-completion-row-fill fill-warning" style="width: 0%;" data-percentage="67%"></div>
                    </div>
                    <span class="profile-completion-row-val">67%</span>
                </div>

            </div>
        </div>

        <!-- ===================== 5. TWO-COLUMN: WHAT TO COMPLETE & BENEFITS ===================== -->
        <div class="profile-completion-two-col">
            
            <!-- LEFT: WHAT YOU NEED TO COMPLETE -->
            <div class="profile-completion-card">
                <div class="profile-completion-card-header">
                    <h3 class="profile-completion-card-title">
                        <i class="fa-solid fa-triangle-exclamation" style="color:var(--student-warning);"></i> What You Need To Complete
                    </h3>
                </div>

                <div class="profile-completion-missing-list">
                    <div class="profile-completion-missing-item">
                        <i class="fa-solid fa-camera"></i>
                        <span>Upload a professional profile photo</span>
                    </div>

                    <div class="profile-completion-missing-item">
                        <i class="fa-brands fa-github"></i>
                        <span>Add your GitHub profile URL</span>
                    </div>

                    <div class="profile-completion-missing-item">
                        <i class="fa-solid fa-map-pin"></i>
                        <span>Complete missing address pincode details</span>
                    </div>
                </div>

                <div style="margin-top: 8px;">
                    <a href="student-edit-profile.aspx" class="profile-completion-action-btn btn-complete" style="display:inline-block; padding:10px 20px; font-weight:700;">
                        <i class="fa-solid fa-circle-arrow-right"></i> Complete Now
                    </a>
                </div>
            </div>

            <!-- RIGHT: WHY COMPLETE YOUR PROFILE? -->
            <div class="profile-completion-card">
                <div class="profile-completion-card-header">
                    <h3 class="profile-completion-card-title">
                        <i class="fa-solid fa-lightbulb" style="color:#EAB308;"></i> Why Complete Your Profile?
                    </h3>
                </div>

                <div class="profile-completion-benefits-list">
                    <div class="profile-completion-benefit-item">
                        <i class="fa-solid fa-circle-check"></i>
                        <span>Better & personalized internship recommendations</span>
                    </div>

                    <div class="profile-completion-benefit-item">
                        <i class="fa-solid fa-eye"></i>
                        <span>3&times; higher visibility to recruiting companies</span>
                    </div>

                    <div class="profile-completion-benefit-item">
                        <i class="fa-solid fa-bolt"></i>
                        <span>Faster 1-click application submission process</span>
                    </div>

                    <div class="profile-completion-benefit-item">
                        <i class="fa-solid fa-award"></i>
                        <span>Companies can quickly verify your skills & education</span>
                    </div>
                </div>
            </div>

        </div>

        <!-- ===================== 6. QUICK ACTIONS FOOTER ===================== -->
        <div class="profile-completion-actions-bar">
            <span style="font-weight: 700; font-size: 14px; margin-right: 8px;">Quick Actions:</span>
            <a href="student-edit-profile.aspx" class="profile-completion-btn-quick">
                <i class="fa-solid fa-user-pen"></i> Edit Profile
            </a>
            <a href="student-skills.aspx" class="profile-completion-btn-quick">
                <i class="fa-solid fa-code"></i> Manage Skills
            </a>
            <a href="student-education.aspx" class="profile-completion-btn-quick">
                <i class="fa-solid fa-graduation-cap"></i> Education Details
            </a>
            <a href="student-resume.aspx" class="profile-completion-btn-quick">
                <i class="fa-solid fa-file-pdf"></i> Upload Resume
            </a>
        </div>

    </div>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="<%= ResolveUrl("~/js/student-profile-completion.js") %>"></script>
</asp:Content>

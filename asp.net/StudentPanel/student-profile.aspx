<%@ Page Title="" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true"
    CodeBehind="student-profile.aspx.cs" Inherits="asp.net.js.student_profile" %>
    <asp:Content ID="HeadContentProfile" ContentPlaceHolderID="head" runat="server">
        <link rel="stylesheet" href="<%= ResolveUrl("~/css/student-profile.css") %>" />
    </asp:Content>

    <asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <div class="student-profile-page">

            <!-- ================= PAGE HEADER ================= -->
            <div class="student-profile-page-header">
                <div>
                    <h1 class="student-profile-page-title">My Profile</h1>
                    <p class="student-profile-page-subtitle">View and manage your personal information, academic details
                        and professional profile.</p>
                </div>
                <asp:HyperLink ID="hlEditProfile" runat="server"
                    CssClass="student-profile-btn student-profile-btn-primary"
                    NavigateUrl="~/student-edit-profile.aspx">
                    <i class="fa-solid fa-user-pen"></i> Edit Profile
                </asp:HyperLink>
            </div>

            <!-- ================= PROFILE OVERVIEW ================= -->
            <div class="student-profile-card student-profile-overview">

                <div class="student-profile-overview-left">
                    <div class="student-profile-avatar-wrap">
                        <asp:Image ID="imgProfilePhoto" runat="server" CssClass="student-profile-avatar"
                            ImageUrl="~/Assets/Images/students/default-avatar.png" AlternateText="Student profile photo"
                            Visible="false" />
                        <asp:Panel ID="pnlAvatarFallback" runat="server" CssClass="student-profile-avatar-fallback">
                            <i class="fa-solid fa-user"></i>
                        </asp:Panel>
                    </div>

                    <div>
                        <h2 class="student-profile-name">
                            <asp:Label ID="lblFullName" runat="server" Text="Dhruvi Patel"></asp:Label>
                        </h2>
                        <p class="student-profile-meta">
                            Student ID: <strong>
                                <asp:Label ID="lblStudentId" runat="server" Text="STU-1001"></asp:Label>
                            </strong>
                        </p>
                        <p class="student-profile-meta">
                            <asp:Label ID="lblCourseDept" runat="server" Text="BCA • Computer Science"></asp:Label>
                        </p>
                        <p class="student-profile-meta">
                            <asp:Label ID="lblCollegeName" runat="server" Text="ABC College"></asp:Label>
                        </p>

                        <div class="student-profile-badges">
                            <span class="student-profile-badge student-profile-badge-active">
                                <span class="student-profile-dot"></span>
                                <asp:Label ID="lblStatusBadge" runat="server" Text="Active"></asp:Label>
                            </span>
                            <span class="student-profile-badge student-profile-badge-verified">
                                <i class="fa-solid fa-circle-check"></i>
                                <asp:Label ID="lblVerifiedBadge" runat="server" Text="Verified"></asp:Label>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="student-profile-overview-right">
                    <div class="student-profile-completion-label">
                        <span>Profile Completion</span>
                        <span class="student-profile-completion-percent">
                            <asp:Label ID="lblCompletionPercent" runat="server" Text="85%"></asp:Label>
                        </span>
                    </div>

                    <div class="student-profile-progress-track">
                        <div class="student-profile-progress-fill" id="profileCompletionFill" data-percent="85"
                            runat="server"></div>
                    </div>

                    <asp:Panel ID="pnlIncompleteProfile" runat="server">
                        <p class="student-profile-completion-hint">Complete your profile to improve your internship
                            opportunities.</p>
                        <asp:HyperLink ID="hlCompleteProfile" runat="server"
                            CssClass="student-profile-btn student-profile-btn-outline student-profile-btn-sm"
                            NavigateUrl="~/student-profile-completion.aspx">
                            <i class="fa-solid fa-chart-pie"></i> Complete Profile
                        </asp:HyperLink>
                    </asp:Panel>

                    <asp:Panel ID="pnlCompleteProfile" runat="server" Visible="false">
                        <div class="student-profile-completion-complete">
                            <i class="fa-solid fa-circle-check"></i> Your profile is complete.
                        </div>
                    </asp:Panel>
                </div>
            </div>

            <!-- ================= PERSONAL INFORMATION ================= -->
            <div class="student-profile-card">
                <h3 class="student-profile-section-title"><i class="fa-solid fa-id-card"></i> Personal Information</h3>

                <div class="student-profile-info-grid">
                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-user"></i>
                        <div>
                            <span class="student-profile-label">Full Name</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblInfoFullName" runat="server" Text="Dhruvi Patel"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-envelope"></i>
                        <div>
                            <span class="student-profile-label">Email Address</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblEmail" runat="server" Text="student@sims.com"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-phone"></i>
                        <div>
                            <span class="student-profile-label">Mobile Number</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblMobile" runat="server" Text="+91 XXXXX XXXXX"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-venus-mars"></i>
                        <div>
                            <span class="student-profile-label">Gender</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblGender" runat="server" Text="Female"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-cake-candles"></i>
                        <div>
                            <span class="student-profile-label">Date of Birth</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblDob" runat="server" Text="DD/MM/YYYY"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-city"></i>
                        <div>
                            <span class="student-profile-label">City</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblCity" runat="server" Text="Ahmedabad"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-map"></i>
                        <div>
                            <span class="student-profile-label">State</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblState" runat="server" Text="Gujarat"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item student-profile-full-width">
                        <i class="fa-solid fa-location-dot"></i>
                        <div>
                            <span class="student-profile-label">Address</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblAddress" runat="server" Text="Student address"></asp:Label>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ================= ACADEMIC INFORMATION ================= -->
            <div class="student-profile-card">
                <h3 class="student-profile-section-title"><i class="fa-solid fa-graduation-cap"></i> Academic
                    Information</h3>

                <div class="student-profile-info-grid">
                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-school"></i>
                        <div>
                            <span class="student-profile-label">College / University</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblCollege" runat="server" Text="ABC College"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-book"></i>
                        <div>
                            <span class="student-profile-label">Course / Degree</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblCourse" runat="server" Text="BCA"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-layer-group"></i>
                        <div>
                            <span class="student-profile-label">Department</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblDepartment" runat="server" Text="Computer Science"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-id-badge"></i>
                        <div>
                            <span class="student-profile-label">Student ID / Enrollment No.</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblEnrollmentNo" runat="server" Text="STU-1001"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-calendar"></i>
                        <div>
                            <span class="student-profile-label">Semester / Year</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblSemester" runat="server" Text="5th Semester"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-chart-simple"></i>
                        <div>
                            <span class="student-profile-label">CGPA / Percentage</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblCgpa" runat="server" Text="8.5 / 10"></asp:Label>
                            </span>
                        </div>
                    </div>

                    <div class="student-profile-info-item">
                        <i class="fa-solid fa-calendar-check"></i>
                        <div>
                            <span class="student-profile-label">Expected Graduation Year</span>
                            <span class="student-profile-value">
                                <asp:Label ID="lblGraduationYear" runat="server" Text="2027"></asp:Label>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ================= ABOUT ME ================= -->
            <div class="student-profile-card">
                <h3 class="student-profile-section-title"><i class="fa-solid fa-address-card"></i> About Me</h3>
                <p class="student-profile-about-text">
                    <asp:Label ID="lblAboutMe" runat="server"
                        Text="Passionate computer science student interested in software development, web technologies and internship opportunities.">
                    </asp:Label>
                </p>
            </div>

            <!-- ================= SKILLS ================= -->
            <div class="student-profile-card">
                <h3 class="student-profile-section-title"><i class="fa-solid fa-code"></i> Skills</h3>

                <asp:Panel ID="pnlSkillsHasData" runat="server">
                    <div class="student-profile-skills">
                        <asp:Repeater ID="rptSkills" runat="server">
                            <ItemTemplate>
                                <span class="student-profile-skill-tag">
                                    <%# Eval("SkillName") %>
                                </span>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlSkillsEmpty" runat="server" CssClass="student-profile-empty-state" Visible="false">
                    <i class="fa-solid fa-code"></i>
                    <p>No skills added yet.</p>
                    <asp:HyperLink ID="hlAddSkills" runat="server"
                        CssClass="student-profile-btn student-profile-btn-outline student-profile-btn-sm"
                        NavigateUrl="~/student-skills.aspx">
                        <i class="fa-solid fa-plus"></i> Add Skills
                    </asp:HyperLink>
                </asp:Panel>
            </div>

            <!-- ================= PROJECTS & EXPERIENCE ================= -->
            <div class="student-profile-card">
                <h3 class="student-profile-section-title"><i class="fa-solid fa-diagram-project"></i> Projects &amp;
                    Experience</h3>

                <asp:Panel ID="pnlProjectsHasData" runat="server">
                    <asp:Repeater ID="rptProjects" runat="server">
                        <ItemTemplate>
                            <div class="student-profile-project">
                                <h4 class="student-profile-project-title">
                                    <%# Eval("ProjectTitle") %>
                                </h4>
                                <p class="student-profile-project-tech">
                                    <%# Eval("Technologies") %>
                                </p>
                                <p class="student-profile-project-desc">
                                    <%# Eval("Description") %>
                                </p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </asp:Panel>

                <asp:Panel ID="pnlProjectsEmpty" runat="server" CssClass="student-profile-empty-state" Visible="false">
                    <i class="fa-solid fa-diagram-project"></i>
                    <p>No projects added yet.</p>
                    <asp:HyperLink ID="hlAddProject" runat="server"
                        CssClass="student-profile-btn student-profile-btn-outline student-profile-btn-sm"
                        NavigateUrl="~/student-experience.aspx">
                        <i class="fa-solid fa-plus"></i> Add Project
                    </asp:HyperLink>
                </asp:Panel>
            </div>

            <!-- ================= CERTIFICATIONS & ACHIEVEMENTS ================= -->
            <div class="student-profile-card">
                <h3 class="student-profile-section-title"><i class="fa-solid fa-certificate"></i> Certifications &amp;
                    Achievements</h3>

                <asp:Panel ID="pnlCertificationsHasData" runat="server">
                    <asp:Repeater ID="rptCertifications" runat="server">
                        <ItemTemplate>
                            <div class="student-profile-certificate">
                                <div class="student-profile-certificate-icon">
                                    <i class="fa-solid fa-award"></i>
                                </div>
                                <div>
                                    <h4 class="student-profile-certificate-title">
                                        <%# Eval("CertificateTitle") %>
                                    </h4>
                                    <p class="student-profile-certificate-meta">
                                        Issued By: <%# Eval("IssuedBy") %> &nbsp;•&nbsp; Year: <%# Eval("Year") %>
                                    </p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </asp:Panel>

                <asp:Panel ID="pnlCertificationsEmpty" runat="server" CssClass="student-profile-empty-state"
                    Visible="false">
                    <i class="fa-solid fa-certificate"></i>
                    <p>No certifications or achievements added yet.</p>
                    <asp:HyperLink ID="hlAddAchievement" runat="server"
                        CssClass="student-profile-btn student-profile-btn-outline student-profile-btn-sm"
                        NavigateUrl="~/student-achievements.aspx">
                        <i class="fa-solid fa-plus"></i> Add Achievement
                    </asp:HyperLink>
                </asp:Panel>
            </div>

            <!-- ================= MY RESUME ================= -->
            <div class="student-profile-card">
                <h3 class="student-profile-section-title"><i class="fa-solid fa-file-pdf"></i> My Resume</h3>

                <asp:Panel ID="pnlResumeHasData" runat="server">
                    <div class="student-profile-resume">
                        <div class="student-profile-resume-info">
                            <div class="student-profile-resume-icon">
                                <i class="fa-solid fa-file-pdf"></i>
                            </div>
                            <div>
                                <p class="student-profile-resume-name">
                                    <asp:Label ID="lblResumeFileName" runat="server" Text="Dhruvi_Patel_Resume.pdf">
                                    </asp:Label>
                                </p>
                                <p class="student-profile-resume-date">
                                    Uploaded: <asp:Label ID="lblResumeUploadDate" runat="server" Text="20 August 2026">
                                    </asp:Label>
                                </p>
                            </div>
                        </div>

                        <div class="student-profile-resume-actions">
                            <asp:HyperLink ID="hlPreviewResume" runat="server"
                                CssClass="student-profile-btn student-profile-btn-outline"
                                NavigateUrl="~/student-resume-preview.aspx">
                                <i class="fa-solid fa-eye"></i> Preview Resume
                            </asp:HyperLink>
                            <asp:HyperLink ID="hlDownloadResume" runat="server"
                                CssClass="student-profile-btn student-profile-btn-primary" NavigateUrl="#"
                                Target="_blank">
                                <i class="fa-solid fa-download"></i> Download Resume
                            </asp:HyperLink>
                        </div>
                    </div>
                </asp:Panel>

                <asp:Panel ID="pnlResumeEmpty" runat="server" CssClass="student-profile-empty-state" Visible="false">
                    <i class="fa-solid fa-file-circle-plus"></i>
                    <p>No resume uploaded yet.</p>
                    <asp:HyperLink ID="hlUploadResume" runat="server"
                        CssClass="student-profile-btn student-profile-btn-outline student-profile-btn-sm"
                        NavigateUrl="~/student-upload-resume.aspx">
                        <i class="fa-solid fa-upload"></i> Upload Resume
                    </asp:HyperLink>
                </asp:Panel>
            </div>

            <!-- ================= PROFILE STATUS ================= -->
            <div class="student-profile-card">
                <h3 class="student-profile-section-title"><i class="fa-solid fa-shield-halved"></i> Profile Status</h3>

                <div class="student-profile-status-grid">
                    <div class="student-profile-status-item">
                        <span class="student-profile-label">Email Verification</span>
                        <span class="student-profile-status-value is-success">
                            <i class="fa-solid fa-circle-check"></i>
                            <asp:Label ID="lblEmailVerification" runat="server" Text="Verified"></asp:Label>
                        </span>
                    </div>

                    <div class="student-profile-status-item">
                        <span class="student-profile-label">Profile Status</span>
                        <span class="student-profile-status-value is-success">
                            <span class="student-profile-dot"></span>
                            <asp:Label ID="lblProfileStatus" runat="server" Text="Active"></asp:Label>
                        </span>
                    </div>

                    <div class="student-profile-status-item">
                        <span class="student-profile-label">Account Created</span>
                        <span class="student-profile-status-value">
                            <asp:Label ID="lblCreatedDate" runat="server" Text="20 August 2026"></asp:Label>
                        </span>
                    </div>

                    <div class="student-profile-status-item">
                        <span class="student-profile-label">Last Updated</span>
                        <span class="student-profile-status-value">
                            <asp:Label ID="lblUpdatedDate" runat="server" Text="22 August 2026"></asp:Label>
                        </span>
                    </div>
                </div>
            </div>

        </div>

    </asp:Content>

    <asp:Content ID="ScriptContentProfile" ContentPlaceHolderID="ScriptContent" runat="server">
        <script src="<%= ResolveUrl("~/js/student-profile.js") %>"></script>
    </asp:Content>
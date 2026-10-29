<%@ Page Title="Student Profile" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="viewStudentDetails.aspx.cs" Inherits="asp.net.viewStudentDetails" %>
<asp:Content ID="ProfileHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/viewStudentDetails.css" />
</asp:Content>
<asp:Content ID="ProfileMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-view-page">
        <div class="back-nav-bar">
            <asp:HyperLink ID="hlBackToStudents" runat="server" NavigateUrl="admin-students.aspx" ImageUrl="~/assets/btn_back_students.png" CssClass="admin-img-btn" Height="38" />
        </div>

        <div id="pnlNotFound" runat="server" visible="false" class="profile-header-card">
            <div class="not-found">
                <div class="not-found-icon"><i class="fa-solid fa-user-slash"></i></div>
                <h2>Student Not Found</h2>
                <p>The requested student record could not be found.</p>
            </div>
        </div>
        <div id="pnlDetails" runat="server">
            <asp:Label ID="lblStudentId" runat="server" Visible="false"></asp:Label>
            <div class="profile-header-card">
                <div class="profile-header-top">
                    <div class="profile-main-info">
                        <div class="profile-photo" aria-label="Student profile photo">
                            <asp:DataList ID="DataListStudentPhoto" runat="server" RepeatLayout="Flow" ShowHeader="false" ShowFooter="false">
                                <ItemTemplate>
                                    <asp:Image ID="imgStudentPhoto" runat="server" CssClass="student-profile-photo-img" ImageUrl='<%# Eval("ProfilePhoto") %>' />
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <div class="profile-info-2x2">
                            <div class="contact-item">
                                <div class="contact-icon"><i class="fa-solid fa-user"></i></div>
                                <div class="contact-text">
                                    <span class="contact-label">Full Name</span>
                                    <asp:Label ID="lblFullName" runat="server" CssClass="contact-value">-</asp:Label>
                                </div>
                            </div>
                            <div class="contact-item">
                                <div class="contact-icon"><i class="fa-solid fa-book"></i></div>
                                <div class="contact-text">
                                    <span class="contact-label">Course</span>
                                    <asp:Label ID="lblCourseHeader" runat="server" CssClass="contact-value">-</asp:Label>
                                </div>
                            </div>
                            <div class="contact-item">
                                <div class="contact-icon"><i class="fa-solid fa-building-columns"></i></div>
                                <div class="contact-text">
                                    <span class="contact-label">College</span>
                                    <asp:Label ID="lblCollegeHeader" runat="server" CssClass="contact-value">-</asp:Label>
                                </div>
                            </div>
                            <div class="contact-item">
                                <div class="contact-icon"><i class="fa-solid fa-star"></i></div>
                                <div class="contact-text">
                                    <span class="contact-label">CGPA</span>
                                    <asp:Label ID="lblCgpa" runat="server" CssClass="contact-value">-</asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="profile-contact-row">
                    <div class="contact-item">
                        <div class="contact-icon"><i class="fa-solid fa-envelope"></i></div>
                        <div class="contact-text">
                            <span class="contact-label">Email Address</span>
                            <asp:Label ID="lblEmail" runat="server" CssClass="contact-value">-</asp:Label>
                        </div>
                    </div>
                    <div class="contact-item">
                        <div class="contact-icon"><i class="fa-solid fa-phone"></i></div>
                        <div class="contact-text">
                            <span class="contact-label">Contact Number</span>
                            <asp:Label ID="lblContact" runat="server" CssClass="contact-value">-</asp:Label>
                        </div>
                    </div>
                    <div class="contact-item">
                        <div class="contact-icon"><i class="fa-solid fa-id-card"></i></div>
                        <div class="contact-text">
                            <span class="contact-label">Enrollment Number</span>
                            <asp:Label ID="lblEnrollment" runat="server" CssClass="contact-value">-</asp:Label>
                        </div>
                    </div>
                </div>
                <div class="social-links">
                    <asp:HyperLink ID="hlHeaderLinkedIn" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-brands fa-linkedin"></i>LinkedIn</asp:HyperLink>
                    <asp:HyperLink ID="hlHeaderGitHub" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-brands fa-github"></i>GitHub</asp:HyperLink>
                    <asp:HyperLink ID="hlHeaderPortfolio" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-solid fa-globe"></i>Portfolio</asp:HyperLink>
                </div>
            </div>
            <section class="profile-tabs-card" aria-label="Profile sections">
                <div class="profile-tabs" role="tablist">
                    <button type="button" class="profile-tab active" onclick="openTab('personal', this)"><i class="fa-solid fa-user"></i><span>Personal</span></button>
                    <button type="button" class="profile-tab" onclick="openTab('education', this)"><i class="fa-solid fa-graduation-cap"></i><span>Education</span></button>
                    <button type="button" class="profile-tab" onclick="openTab('skills', this)"><i class="fa-solid fa-code"></i><span>Skills</span></button>
                    <button type="button" class="profile-tab" onclick="openTab('projects', this)"><i class="fa-solid fa-diagram-project"></i><span>Projects</span></button>
                    <button type="button" class="profile-tab" onclick="openTab('resume', this)"><i class="fa-solid fa-file-pdf"></i><span>Resume</span></button>
                </div>
            </section>
            <section id="personal" class="tab-content active">
                <div class="profile-section-card">
                    <div class="section-header">
                        <div>
                            <h2><i class="fa-solid fa-user"></i>Personal Information</h2>
                            <p>Manage your basic and professional personal details</p>
                        </div>
                    </div>
                    <div class="profile-subtitle"><i class="fa-solid fa-id-card"></i>Basic Information</div>
                    <div class="profile-info-grid">
                        <div class="info-field"><span class="info-label">Full Name</span><asp:Label ID="lblFullNameInfo" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Date of Birth</span><asp:Label ID="lblDob" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Gender</span><asp:Label ID="lblGender" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Email Address</span><asp:Label ID="lblEmailInfo" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Contact Number</span><asp:Label ID="lblContactInfo" runat="server" CssClass="info-value">-</asp:Label></div>
                    </div>
                    <div class="profile-subtitle"><i class="fa-solid fa-location-dot"></i>Address Information</div>
                    <div class="profile-info-grid">
                        <div class="info-field"><span class="info-label">Address</span><asp:Label ID="lblAddress" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">City</span><asp:Label ID="lblCity" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">State</span><asp:Label ID="lblState" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Pincode</span><asp:Label ID="lblPincode" runat="server" CssClass="info-value">-</asp:Label></div>
                    </div>
                    <div class="profile-subtitle"><i class="fa-solid fa-user-pen"></i>About Me</div>
                    <div class="about-box">
                        <p>
                            <asp:Label ID="lblAboutMe" runat="server" CssClass="info-value">-</asp:Label>
                        </p>
                    </div>
                    <div class="profile-subtitle"><i class="fa-solid fa-briefcase"></i>Internship Preferences</div>
                    <div class="profile-info-grid">
                        <div class="info-field"><span class="info-label">Preferred Domain</span><asp:Label ID="lblPreferredDomain" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Preferred Role</span><asp:Label ID="lblPreferredRole" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Preferred Location</span><asp:Label ID="lblPreferredLocation" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Work Mode</span><asp:Label ID="lblWorkMode" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Availability</span><asp:Label ID="lblAvailability" runat="server" CssClass="info-value">-</asp:Label></div>
                    </div>
                    <div class="profile-subtitle"><i class="fa-solid fa-link"></i>Professional Links</div>
                    <div class="professional-links-grid">
                        <asp:HyperLink ID="hlLinkedIn" runat="server" Target="_blank" Rel="noopener" CssClass="professional-link-card" NavigateUrl="#">
                            <span class="professional-link-icon linkedin"><i class="fa-brands fa-linkedin-in"></i></span>
                            <span><strong>LinkedIn</strong><small><asp:Label ID="lblLinkedInText" runat="server">-</asp:Label></small></span>
                            <i class="fa-solid fa-arrow-up-right-from-square link-arrow"></i>
                        </asp:HyperLink>
                        <asp:HyperLink ID="hlGitHub" runat="server" Target="_blank" Rel="noopener" CssClass="professional-link-card" NavigateUrl="#">
                            <span class="professional-link-icon github"><i class="fa-brands fa-github"></i></span>
                            <span><strong>GitHub</strong><small><asp:Label ID="lblGitHubText" runat="server">-</asp:Label></small></span>
                            <i class="fa-solid fa-arrow-up-right-from-square link-arrow"></i>
                        </asp:HyperLink>
                        <asp:HyperLink ID="hlPortfolio" runat="server" Target="_blank" Rel="noopener" CssClass="professional-link-card" NavigateUrl="#">
                            <span class="professional-link-icon portfolio"><i class="fa-solid fa-globe"></i></span>
                            <span><strong>Portfolio</strong><small><asp:Label ID="lblPortfolioText" runat="server">-</asp:Label></small></span>
                            <i class="fa-solid fa-arrow-up-right-from-square link-arrow"></i>
                        </asp:HyperLink>
                    </div>
                </div>
            </section>
            <section id="education" class="tab-content">
                <div class="profile-section-card">
                    <div class="section-header">
                        <div>
                            <h2><i class="fa-solid fa-graduation-cap"></i>Education</h2>
                            <p>Manage your academic and educational information</p>
                        </div>
                    </div>
                    <div class="profile-subtitle"><i class="fa-solid fa-school"></i>Academic Information</div>
                    <div class="profile-info-grid">
                        <div class="info-field"><span class="info-label">Enrollment Number</span><asp:Label ID="lblEnrollmentInfo" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">College / University</span><asp:Label ID="lblCollege" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Course / Degree</span><asp:Label ID="lblCourse" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Department</span><asp:Label ID="lblDepartment" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Current Year / Semester</span><asp:Label ID="lblSemester" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">CGPA / Percentage</span><asp:Label ID="lblCgpaInfo" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Graduation Year</span><asp:Label ID="lblGraduationYear" runat="server" CssClass="info-value">-</asp:Label></div>
                    </div>
                </div>
            </section>
            <section id="skills" class="tab-content">
                <div class="profile-section-card">
                    <div class="section-header">
                        <div>
                            <h2><i class="fa-solid fa-code"></i>Skills</h2>
                            <p>Showcase your technical and professional skills</p>
                        </div>
                    </div>
                    <!-- Technical Skills -->
                    <div class="skill-category-box technical-box">
                        <div class="skill-category-title">
                            <div class="category-icon technical-icon"><i class="fa-solid fa-laptop-code"></i></div>
                            <h3>Technical Skills</h3>
                        </div>
                        <div class="skills-list">
                            <asp:GridView ID="gvTechSkills" runat="server" AutoGenerateColumns="False" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="skill-pill technical-pill"><span><asp:Label ID="lblTechSkill" runat="server" Text='<%# Eval("SkillName") %>'></asp:Label></span></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:Label ID="lblNoTechSkills" runat="server" CssClass="no-skill-text" Text="No technical skills added yet."></asp:Label>
                        </div>
                    </div>
                    <!-- Soft Skills -->
                    <div class="skill-category-box soft-box">
                        <div class="skill-category-title">
                            <div class="category-icon soft-icon"><i class="fa-solid fa-people-group"></i></div>
                            <h3>Soft Skills</h3>
                        </div>
                        <div class="skills-list">
                            <asp:GridView ID="gvSoftSkills" runat="server" AutoGenerateColumns="False" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="skill-pill soft-pill"><span><asp:Label ID="lblSoftSkill" runat="server" Text='<%# Eval("SkillName") %>'></asp:Label></span></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:Label ID="lblNoSoftSkills" runat="server" CssClass="no-skill-text" Text="No soft skills added yet."></asp:Label>
                        </div>
                    </div>
                    <!-- Other Skills -->
                    <div class="skill-category-box other-box">
                        <div class="skill-category-title">
                            <div class="category-icon other-icon"><i class="fa-solid fa-layer-group"></i></div>
                            <h3>Other Skills</h3>
                        </div>
                        <div class="skills-list">
                            <asp:GridView ID="gvOtherSkills" runat="server" AutoGenerateColumns="False" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="skill-pill other-pill"><span><asp:Label ID="lblOtherSkill" runat="server" Text='<%# Eval("SkillName") %>'></asp:Label></span></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:Label ID="lblNoOtherSkills" runat="server" CssClass="no-skill-text" Text="No other skills added yet."></asp:Label>
                        </div>
                    </div>
                </div>
            </section>
            <section id="projects" class="tab-content">
                <div class="profile-section-card">
                    <div class="section-header">
                        <div>
                            <h2><i class="fa-solid fa-diagram-project"></i>Projects</h2>
                            <p>Showcase your academic and personal projects</p>
                        </div>
                    </div>
                    <asp:GridView ID="gvProjects" runat="server" AutoGenerateColumns="False" CssClass="projects-gridview" GridLines="None" ShowHeader="False">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="project-card">
                                        <div class="project-card-header">
                                            <div class="project-title-area">
                                                <div class="project-icon">
                                                    <i class="fa-solid fa-diagram-project"></i>
                                                </div>
                                                <div>
                                                    <h3><asp:Label ID="lblProjectName" runat="server" Text='<%# Eval("ProjectName") %>'></asp:Label></h3>
                                                    <span class="project-type-badge"><asp:Label ID="lblProjectType" runat="server" Text='<%# Eval("ProjectType") %>'></asp:Label></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="project-description">
                                            <p><asp:Label ID="lblDescription" runat="server" Text='<%# Eval("Description") %>'></asp:Label></p>
                                        </div>
                                        <div class="project-info">
                                            <div class="project-info-label">
                                                <i class="fa-solid fa-microchip"></i>
                                                Technologies Used
                                            </div>
                                            <div class="technology-tags">
                                                <asp:Label ID="lblTechUsed" runat="server" Text='<%# Eval("TechnologiesUsed") %>'></asp:Label>
                                            </div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:Label ID="lblNoProjects" runat="server" CssClass="no-projects-text" Text="No projects available."></asp:Label>
                </div>
            </section>
            <section id="resume" class="tab-content">
                <div class="profile-section-card">
                    <div class="section-header">
                        <div>
                            <h2><i class="fa-solid fa-file-pdf"></i>Resume</h2>
                            <p>View student's uploaded resume for internship applications</p>
                        </div>
                    </div>
                    <div id="pnlResumeData" runat="server" visible="false">
                        <div class="resume-current-card">
                            <div class="resume-file-left">
                                <div class="resume-pdf-icon"><i class="fa-solid fa-file-pdf"></i></div>
                                <div class="resume-file-info">
                                    <h3>
                                        <asp:Label ID="lblResumeFileName" runat="server"></asp:Label></h3>
                                    <div class="resume-meta">
                                        <span><i class="fa-regular fa-file"></i>PDF Document</span>
                                        <span><i class="fa-regular fa-calendar"></i>Uploaded:
                                            <asp:Label ID="lblResumeDate" runat="server"></asp:Label></span>
                                    </div>
                                </div>
                            </div>
                            <div class="resume-actions">
                                <asp:HyperLink ID="hlViewResume" runat="server" Target="_blank" ImageUrl="~/assets/btn_resume_view.png" CssClass="admin-img-btn" Height="34" />
                                <asp:HyperLink ID="hlDownloadResume" runat="server" ImageUrl="~/assets/btn_resume_download.png" CssClass="admin-img-btn" Height="34" />
                            </div>
                        </div>
                    </div>
                    <asp:Label ID="lblNoResume" runat="server" CssClass="empty" Text="No resume uploaded by the student."></asp:Label>
                </div>
            </section>
        </div>
    </div>
    <script src="../js/viewStudentDetails.js"></script>
</asp:Content>

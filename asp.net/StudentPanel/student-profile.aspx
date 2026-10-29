<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeFile="student-profile.aspx.cs" Inherits="asp.net.js.student_profile" %>
<asp:Content ID="ProfileHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-profile.css" />
</asp:Content>
<asp:Content ID="ProfileMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="student-profile-page">
        <section class="profile-header-card">
            <div class="profile-header-top">
                <div class="profile-main-info">
                    <div class="profile-photo" aria-label="Student profile photo">
                        <asp:Label ID="lblAvatarInitials" runat="server">-</asp:Label>
                        <asp:Image ID="imgStudentPhoto" runat="server" Visible="false"   CssClass="sprof-u1" />
                    </div>
                    <div class="profile-info-2x2">
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-user"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">Full Name</span>
                                <asp:Label ID="lblName" runat="server" CssClass="contact-value"></asp:Label>
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-book"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">Course</span>
                                <asp:Label ID="lblCourse" runat="server" CssClass="contact-value"></asp:Label>
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-building-columns"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">College</span>
                                <asp:Label ID="lblCollege" runat="server" CssClass="contact-value"></asp:Label>
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-star"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">CGPA</span>
                                <asp:Label ID="lblHeaderCGPA" runat="server" CssClass="contact-value"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
                <asp:HyperLink ID="btnEditProfile" runat="server" CssClass="edit-profile-btn" NavigateUrl="~/StudentPanel/student-edit-profile.aspx">
                    <i class="fa-solid fa-pen"></i> Edit Profile
                </asp:HyperLink>
            </div>
            <div class="profile-contact-row">
                <div class="contact-item">
                    <div class="contact-icon"><i class="fa-solid fa-envelope"></i></div>
                    <div class="contact-text">
                        <span class="contact-label">Email Address</span>
                        <asp:Label ID="lblEmail" runat="server" CssClass="contact-value"></asp:Label>
                    </div>
                </div>
                <div class="contact-item">
                    <div class="contact-icon"><i class="fa-solid fa-phone"></i></div>
                    <div class="contact-text">
                        <span class="contact-label">Contact Number</span>
                        <asp:Label ID="lblMobile" runat="server" CssClass="contact-value"></asp:Label>
                    </div>
                </div>
                <div class="contact-item">
                    <div class="contact-icon"><i class="fa-solid fa-id-card"></i></div>
                    <div class="contact-text">
                        <span class="contact-label">Enrollment Number</span>
                        <asp:Label ID="lblEnrollment" runat="server" CssClass="contact-value"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="social-links">
                <asp:HyperLink ID="hlHeaderLinkedIn" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-brands fa-linkedin"></i>LinkedIn</asp:HyperLink>
                <asp:HyperLink ID="hlHeaderGitHub" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-brands fa-github"></i>GitHub</asp:HyperLink>
                <asp:HyperLink ID="hlHeaderPortfolio" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-solid fa-globe"></i>Portfolio</asp:HyperLink>
            </div>
        </section>
        <section class="profile-tabs-card" aria-label="Profile sections">
            <div class="profile-tabs" role="tablist">
                <button type="button" class="profile-tab active" onclick="openProfileTab('personal', this)"><i class="fa-solid fa-user"></i><span>Personal</span></button>
                <button type="button" class="profile-tab" onclick="openProfileTab('education', this)"><i class="fa-solid fa-graduation-cap"></i><span>Education</span></button>
                <button type="button" class="profile-tab" onclick="openProfileTab('skills', this)"><i class="fa-solid fa-code"></i><span>Skills</span></button>
                <button type="button" class="profile-tab" onclick="openProfileTab('projects', this)"><i class="fa-solid fa-diagram-project"></i><span>Projects</span></button>
                <button type="button" class="profile-tab" onclick="openProfileTab('resume', this)"><i class="fa-solid fa-file-pdf"></i><span>Resume</span></button>
            </div>
        </section>
        <section id="personal" class="profile-tab-content active">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-user"></i>Personal Information</h2>
                        <p>Manage your basic and professional personal details</p>
                    </div>
                </div>
                <div class="profile-subtitle"><i class="fa-solid fa-id-card"></i>Basic Information</div>
                <div class="profile-info-grid">
                    <div class="info-field">
                        <span class="info-label">Full Name</span>
                        <asp:Label ID="lblFullName" runat="server" CssClass="info-value"></asp:Label>
                    </div>
                    <div class="info-field">
                        <span class="info-label">Date of Birth</span>
                        <asp:Label ID="lblDob" runat="server" CssClass="info-value"></asp:Label>
                    </div>
                    <div class="info-field">
                        <span class="info-label">Gender</span>
                        <asp:Label ID="lblGender" runat="server" CssClass="info-value">-</asp:Label>
                    </div>
                    <div class="info-field">
                        <span class="info-label">Email Address</span>
                        <asp:Label ID="lblPersonalEmail" runat="server" CssClass="info-value"></asp:Label>
                    </div>
                    <div class="info-field">
                        <span class="info-label">Contact Number</span>
                        <asp:Label ID="lblPersonalMobile" runat="server" CssClass="info-value"></asp:Label>
                    </div>
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
        <section id="education" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-graduation-cap"></i>Education</h2>
                        <p>Manage your academic and educational information</p>
                    </div>
                </div>
                <div class="profile-subtitle"><i class="fa-solid fa-school"></i>Academic Information</div>
                <div class="profile-info-grid">
                    <div class="info-field">
                        <span class="info-label">Enrollment Number</span>
                        <asp:Label ID="lblEduEnrollment" runat="server" CssClass="info-value"></asp:Label>
                    </div>
                    <div class="info-field">
                        <span class="info-label">College / University</span>
                        <asp:Label ID="lblEduCollege" runat="server" CssClass="info-value"></asp:Label>
                    </div>
                    <div class="info-field">
                        <span class="info-label">Course / Degree</span>
                        <asp:Label ID="lblEduCourse" runat="server" CssClass="info-value"></asp:Label>
                    </div>
                    <div class="info-field">
                        <span class="info-label">Department</span>
                        <asp:Label ID="lblEduDepartment" runat="server" CssClass="info-value"></asp:Label>
                    </div>
                    <div class="info-field">
                        <span class="info-label">Current Year / Semester</span>
                        <asp:Label ID="lblEduSemester" runat="server" CssClass="info-value"></asp:Label>
                    </div>
                    <div class="info-field">
                        <span class="info-label">CGPA / Percentage</span>
                        <asp:Label ID="lblEduCgpa" runat="server" CssClass="info-value"></asp:Label>
                    </div>
                    <div class="info-field">
                        <span class="info-label">Graduation Year</span>
                        <asp:Label ID="lblEduGraduationYear" runat="server" CssClass="info-value"></asp:Label>
                    </div>
                </div>
            </div>
        </section>
        <section id="skills" class="profile-tab-content">
            <div class="skills-main-card">
                <!-- Header -->
                <div class="skills-header">
                    <div class="skills-title-area">
                        <div class="skills-icon">
                            <i class="fa-solid fa-code"></i>
                        </div>
                        <div>
                            <h2>Skills</h2>
                            <p>Showcase your technical and professional skills</p>
                        </div>
                    </div>
                    <button type="button" class="add-skill-btn" onclick="addProfileSkill()">
                        <i class="fa-solid fa-plus"></i>Add Skill
                    </button>
                </div>
                <!-- ================= TECHNICAL SKILLS ================= -->
                <div class="skill-category-box technical-box">
                    <div class="skill-category-title">
                        <div class="category-icon technical-icon">
                            <i class="fa-solid fa-laptop-code"></i>
                        </div>
                        <h3>Technical Skills</h3>
                    </div>
                    <div class="skills-list">
                        <asp:GridView ID="gvTechSkills" runat="server" AutoGenerateColumns="False" OnRowCommand="gvSkills_RowCommand" DataKeyNames="SkillId" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="SkillName" ItemStyle-CssClass="skill-name-col" />
                                <asp:TemplateField ItemStyle-CssClass="skill-action-col">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbDeleteTech" runat="server" CommandName="DeleteSkill" CommandArgument='<%# Eval("SkillId") %>' CssClass="skill-delete-btn"><i class="fa-solid fa-trash-can"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Label ID="lblNoTechSkills" runat="server" CssClass="no-skill-text" Text="No technical skills added yet.">
                        </asp:Label>
                    </div>
                </div>
                <!-- ================= SOFT SKILLS ================= -->
                <div class="skill-category-box soft-box">
                    <div class="skill-category-title">
                        <div class="category-icon soft-icon">
                            <i class="fa-solid fa-people-group"></i>
                        </div>
                        <h3>Soft Skills</h3>
                    </div>
                    <div class="skills-list">
                        <asp:GridView ID="gvSoftSkills" runat="server" AutoGenerateColumns="False" OnRowCommand="gvSkills_RowCommand" DataKeyNames="SkillId" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="SkillName" ItemStyle-CssClass="skill-name-col" />
                                <asp:TemplateField ItemStyle-CssClass="skill-action-col">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbDeleteSoft" runat="server" CommandName="DeleteSkill" CommandArgument='<%# Eval("SkillId") %>' CssClass="skill-delete-btn"><i class="fa-solid fa-trash-can"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Label ID="lblNoSoftSkills" runat="server" CssClass="no-skill-text" Text="No soft skills added yet.">
                        </asp:Label>
                    </div>
                </div>
                <!-- ================= OTHER SKILLS ================= -->
                <div class="skill-category-box other-box">
                    <div class="skill-category-title">
                        <div class="category-icon other-icon">
                            <i class="fa-solid fa-layer-group"></i>
                        </div>
                        <h3>Other Skills</h3>
                    </div>
                    <div class="skills-list">
                        <asp:GridView ID="gvOtherSkills" runat="server" AutoGenerateColumns="False" OnRowCommand="gvSkills_RowCommand" DataKeyNames="SkillId" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="SkillName" ItemStyle-CssClass="skill-name-col" />
                                <asp:TemplateField ItemStyle-CssClass="skill-action-col">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbDeleteOther" runat="server" CommandName="DeleteSkill" CommandArgument='<%# Eval("SkillId") %>' CssClass="skill-delete-btn"><i class="fa-solid fa-trash-can"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:Label ID="lblNoOtherSkills" runat="server" CssClass="no-skill-text" Text="No other skills added yet.">
                        </asp:Label>
                    </div>
                </div>
            </div>
        </section>
        <section id="projects" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-diagram-project"></i>Projects</h2>
                        <p>Showcase your academic and personal projects</p>
                    </div>
                    <button type="button" class="add-project-btn" onclick="openAddProjectForm()"><i class="fa-solid fa-plus"></i>Add Project</button>
                </div>
                <asp:GridView ID="gvProjects" runat="server" AutoGenerateColumns="False" OnRowCommand="gvProjects_RowCommand" DataKeyNames="ProjectId" CssClass="projects-gridview" GridLines="None" ShowHeader="False">
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
                                                <h3><%# Eval("ProjectName") %></h3>
                                                <span class="project-type-badge"><%# Eval("ProjectType") %></span>
                                            </div>
                                        </div>
                                        <div class="project-actions">
                                            <button type="button" class="project-action-btn edit-btn" onclick="openEditProjectForm(this)"
                                                data-id='<%# Eval("ProjectId") %>'
                                                data-name='<%# HttpUtility.HtmlAttributeEncode(Eval("ProjectName") as string ?? "") %>'
                                                data-type='<%# HttpUtility.HtmlAttributeEncode(Eval("ProjectType") as string ?? "") %>'
                                                data-desc='<%# HttpUtility.HtmlAttributeEncode(Eval("Description") as string ?? "") %>'
                                                data-tech='<%# HttpUtility.HtmlAttributeEncode(Eval("TechnologiesUsed") as string ?? "") %>'
                                                data-link='<%# HttpUtility.HtmlAttributeEncode(Eval("ProjectLink") as string ?? "") %>'>
                                                <i class="fa-solid fa-pen"></i>
                                            </button>
                                            <asp:LinkButton ID="btnDeleteProject" runat="server" CommandName="DeleteProject" CommandArgument='<%# Eval("ProjectId") %>' CssClass="project-action-btn delete-btn" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this project?');">
                                                <i class="fa-solid fa-trash"></i>
                                            </asp:LinkButton>

                                        </div>
                                    </div>
                                    <div class="project-description">
                                        <p><%# Eval("Description") %></p>
                                    </div>
                                    <div class="project-info">
                                        <div class="project-info-label">
                                            <i class="fa-solid fa-microchip"></i>
                                            Technologies Used
                                        </div>
                                        <div class="technology-tags">
                                            <%# Eval("TechnologiesUsed") %>
                                        </div>
                                    </div>
                                    <asp:PlaceHolder ID="phProjectLink" runat="server" Visible='<%# !string.IsNullOrWhiteSpace(Eval("ProjectLink") as string) %>'>
                                        <div class="project-links">
                                            <a href='<%# Eval("ProjectLink") %>' target="_blank" class="project-link-btn" rel="noopener noreferrer">
                                                <i class="fa-solid fa-arrow-up-right-from-square"></i> View Project Link
                                            </a>
                                        </div>
                                    </asp:PlaceHolder>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblNoProjects" runat="server" CssClass="no-projects-text" Text="No projects added yet."></asp:Label>
            </div>
        </section>
        <section id="resume" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-file-pdf"></i>Resume</h2>
                        <p>Manage your latest resume for internship applications.</p>
                    </div>
                </div>
                <asp:PlaceHolder ID="pnlResumeData" runat="server" Visible="false">
                    <div class="resume-current-card">
                        <div class="resume-file-left">
                            <div class="resume-pdf-icon"><i class="fa-solid fa-file-pdf"></i></div>
                            <div class="resume-file-info">
                                <h3>
                                    <asp:Label ID="lblResumeFileName" runat="server"></asp:Label></h3>
                                <div class="resume-meta">
                                    <span><i class="fa-regular fa-file"></i>PDF Document</span>
                                    <span><i class="fa-regular fa-calendar"></i>
                                    <asp:Label ID="lblResumeDate" runat="server"></asp:Label></span>
                                </div>
                            </div>
                        </div>
                        <div class="resume-actions">
                            <asp:HyperLink ID="hlViewResume" runat="server" Target="_blank" CssClass="resume-action-btn primary"><i class="fa-solid fa-eye"></i> View</asp:HyperLink>
                            <asp:LinkButton ID="btnDownloadResume" runat="server" OnClick="btnDownloadResume_Click" CssClass="resume-action-btn" CausesValidation="false"><i class="fa-solid fa-download"></i> Download</asp:LinkButton>
                            <asp:LinkButton ID="btnDeleteResume" runat="server" OnClick="btnDeleteResume_Click" CssClass="resume-delete-btn" CausesValidation="false" ><i class="fa-solid fa-trash"></i></asp:LinkButton>
                        </div>
                    </div>
                </asp:PlaceHolder>

                <!-- Resume Upload Table in Resume Tab -->
                <div class="resume-upload-card sprof-u2" >
                    <h3  class="sprof-u3">
                        <i class="fa-solid fa-cloud-arrow-up sprof-u4" ></i> Upload / Replace Resume
                    </h3>
                    <table class="upload-table sprof-u5" >
                        <tr>
                            <td  class="sprof-u6">Resume (PDF):</td>
                            <td  class="sprof-u7">
                                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control-file" accept=".pdf" />
                                <asp:ImageButton ID="btnUploadResume" runat="server" ImageUrl="~/assets/btn_upload_resume.png" Height="40" CssClass="student-img-btn" OnClick="btnUploadResume_Click" CausesValidation="false" />
                            </td>
                        </tr>
                    </table>
                    <small  class="sprof-u9">
                        <i class="fa-solid fa-circle-info sprof-u10" ></i> Only <strong>.pdf</strong> files are allowed. Files will be uploaded to the <strong>resume_upload</strong> folder.
                    </small>
                </div>
            </div>
        </section>
    </main>
    <script src="../js/student-profile.js"></script>
    <div id="editProfileModal" class="edit-profile-modal" role="dialog" aria-modal="true" aria-labelledby="editProfileTitle">
        <div class="edit-profile-box">
            <div class="edit-modal-header">
                <div>
                    <h2 id="editProfileTitle">Edit Profile</h2>
                    <p>Update your personal and professional information.</p>
                </div>
                <button type="button" class="close-edit-modal" onclick="closeEditProfile()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="edit-profile-form">
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-user"></i>Basic Information</h3>
                    <div class="edit-form-grid">
                        <div class="edit-field">
                            <label>Full Name</label><%--<input type="text" value="Dhruvi Patel">--%>
                            <asp:TextBox ID="txtEditFullName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Date of Birth</label><%--<input type="date" value="2005-06-15">--%>
                            <asp:TextBox ID="txtEditDob" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Gender</label>
                            <asp:DropDownList ID="ddlEditGender" runat="server" CssClass="form-control">
                                <asp:ListItem Text="-" Value=""></asp:ListItem>
                                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="edit-field">
                            <label>Email Address</label><%--<input type="email" value="dhruvi@example.com">--%>
                            <asp:TextBox ID="txtEditEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Contact Number</label><%--<input type="text" value="9876543210">--%>
                            <asp:TextBox ID="txtEditMobile" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Enrollment Number</label><%--<input type="text" value="BCA2024001">--%>
                            <asp:TextBox ID="txtEditEnrollment" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-location-dot"></i>Address Information</h3>
                    <div class="edit-form-grid">
                        <div class="edit-field full-width">
                            <label>Address</label><asp:TextBox ID="txtEditAddress" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>City</label><asp:TextBox ID="txtEditCity" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>State</label><asp:TextBox ID="txtEditState" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Pincode</label><asp:TextBox ID="txtEditPincode" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-graduation-cap"></i>Education</h3>
                    <div class="edit-form-grid">
                        <div class="edit-field">
                            <label>College / University</label>
                            <asp:TextBox ID="txtEditCollege" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Course / Degree</label>
                            <asp:TextBox ID="txtEditCourse" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Department</label>
                            <asp:TextBox ID="txtEditDepartment" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Current Semester</label>
                            <asp:TextBox ID="txtEditSemester" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Graduation Year</label>
                            <asp:TextBox ID="txtEditGraduationYear" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>CGPA / Percentage</label>
                            <asp:TextBox ID="txtEditCgpa" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-briefcase"></i>Internship Preferences</h3>
                    <div class="edit-form-grid">
                        <div class="edit-field">
                            <label>Preferred Domain</label>
                            <asp:TextBox ID="txtEditPreferredDomain" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Preferred Role</label>
                            <asp:TextBox ID="txtEditPreferredRole" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Preferred Location</label>
                            <asp:TextBox ID="txtEditPreferredLocation" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Work Mode</label>
                            <asp:DropDownList ID="ddlEditWorkMode" runat="server" CssClass="form-control">
                                <asp:ListItem Text="-" Value=""></asp:ListItem>
                                <asp:ListItem Text="Hybrid" Value="Hybrid"></asp:ListItem>
                                <asp:ListItem Text="On-site" Value="On-site"></asp:ListItem>
                                <asp:ListItem Text="Remote" Value="Remote"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="edit-field">
                            <label>Availability</label>
                            <asp:DropDownList ID="ddlEditAvailability" runat="server" CssClass="form-control">
                                <asp:ListItem Text="-" Value=""></asp:ListItem>
                                <asp:ListItem Text="Available" Value="Available"></asp:ListItem>
                                <asp:ListItem Text="Not Available" Value="Not Available"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-user-pen"></i>About Me</h3>
                    <div class="edit-field">
                        <label>Career Objective / About Me</label>
                        <asp:TextBox ID="txtEditAboutMe" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-link"></i>Professional Links</h3>
                    <div class="edit-form-grid">
                        <div class="edit-field">
                            <label>LinkedIn</label>
                            <asp:TextBox ID="txtEditLinkedIn" runat="server" CssClass="form-control" placeholder="https://linkedin.com/in/yourprofile"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>GitHub</label>
                            <asp:TextBox ID="txtEditGitHub" runat="server" CssClass="form-control" placeholder="https://github.com/yourusername"></asp:TextBox>
                        </div>
                        <div class="edit-field full-width">
                            <label>Portfolio Website</label>
                            <asp:TextBox ID="txtEditPortfolio" runat="server" CssClass="form-control" placeholder="https://yourportfolio.com"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="edit-modal-footer">
                <button type="button" class="cancel-edit-btn" onclick="closeEditProfile()">Cancel</button>
                <%--                <button type="button" class="save-profile-btn" onclick="saveProfile()"><i class="fa-solid fa-check"></i>Save Changes</button>--%>
                <asp:ImageButton ID="btnSaveProfile" runat="server" ImageUrl="~/assets/btn_save_changes.png" Height="42" CssClass="student-img-btn" OnClick="btnSaveProfile_Click" />
            </div>
        </div>
    </div>
    <div id="profileCrudModal" class="edit-profile-modal" role="dialog" aria-modal="true" aria-labelledby="crudModalTitle">
        <div class="edit-profile-box">
            <div class="edit-modal-header">
                <div>
                    <h2 id="crudModalTitle">Add Details</h2>
                    <p id="crudModalSubtitle">Enter information below.</p>
                </div>
                <button type="button" class="close-edit-modal" onclick="closeCrudForm()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <form id="profileCrudForm" class="edit-profile-form">
                <div id="crudFields" class="edit-form-grid"></div>
            </form>
            <div class="edit-modal-footer">
                <button type="button" class="cancel-edit-btn" onclick="closeCrudForm()">Cancel</button>
                <button type="button" class="save-profile-btn" onclick="saveCrudForm()"><i class="fa-solid fa-check"></i>Save</button>
            </div>
        </div>
    </div>
    <div id="skillModal" class="edit-profile-modal" role="dialog">
        <div class="edit-profile-box skill-modal-box">
            <div class="edit-modal-header">
                <div>
                    <h2>Add Skill</h2>
                    <p>Add your skill</p>
                </div>
                <button type="button"
                    class="close-edit-modal"
                    onclick="closeSkillForm()">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>
            <div class="edit-profile-form">
                <!-- Category -->
                <div class="edit-field">
                    <label>Skill Category</label>
                    <asp:DropDownList ID="ddlSkillCategory"
                        runat="server"
                        CssClass="form-input">
                        <asp:ListItem Text="Technical Skills" Value="technical" />
                        <asp:ListItem Text="Soft Skills" Value="soft" />
                        <asp:ListItem Text="Other Skills" Value="other" />
                    </asp:DropDownList>
                </div>
                <br />
                <br />
                <!-- Skill Name -->
                <div class="edit-field">
                    <label>
                        Skill Name <span class="required-mark">*</span>
                    </label>
                    <asp:TextBox ID="txtNewSkillName"
                        runat="server"
                        CssClass="form-input"
                        placeholder="Enter skill name" />
                </div>
            </div>
            <div class="edit-modal-footer">
                <button type="button"
                    class="cancel-edit-btn"
                    onclick="closeSkillForm()">
                    Cancel
                </button>
                <asp:ImageButton ID="btnAddSkill" runat="server" ImageUrl="~/assets/btn_add_skill.png" Height="40" CssClass="student-img-btn" OnClick="btnAddSkill_Click" CausesValidation="false" />
            </div>
        </div>
    </div>
    <div id="projectModal" class="edit-profile-modal" role="dialog" aria-modal="true" aria-labelledby="lblProjectModalTitle">
        <div class="edit-profile-box">
            <div class="edit-modal-header">
                <div class="project-modal-header-left">
                    <div class="project-header-icon"><i class="fa-solid fa-code"></i></div>
                    <div>
                        <h2>
                            <asp:Label ID="lblProjectModalTitle" runat="server" Text="Add Project"></asp:Label></h2>
                        <p>Enter the details of your project below.</p>
                    </div>
                </div>
                <button type="button" class="close-edit-modal" onclick="closeProjectForm()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="edit-profile-form">
                <asp:HiddenField ID="hdnProjectId" runat="server" />
                <div class="edit-form-grid">
                    <div class="edit-field">
                        <label>Project Name <span class="required-mark">*</span></label>
                        <div class="input-with-icon">
                            <i class="fa-regular fa-file-lines field-icon"></i>
                            <asp:TextBox ID="txtProjectName" runat="server" CssClass="form-control" placeholder="e.g. Smart Student Internship Management System"></asp:TextBox>
                        </div>
                    </div>
                    <div class="edit-field">
                        <label>Project Type <span class="required-mark">*</span></label>
                        <div class="input-with-icon select-with-icon">
                            <i class="fa-solid fa-tag field-icon"></i>
                            <asp:DropDownList ID="ddlProjectType" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select project type" Value="" Disabled="true" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Academic Project" Value="Academic Project"></asp:ListItem>
                                <asp:ListItem Text="Personal Project" Value="Personal Project"></asp:ListItem>
                                <asp:ListItem Text="Internship Project" Value="Internship Project"></asp:ListItem>
                                <asp:ListItem Text="Client Project" Value="Client Project"></asp:ListItem>
                                <asp:ListItem Text="Open Source" Value="Open Source"></asp:ListItem>
                                <asp:ListItem Text="Web Application" Value="Web Application"></asp:ListItem>
                                <asp:ListItem Text="Mobile App" Value="Mobile App"></asp:ListItem>
                                <asp:ListItem Text="Machine Learning" Value="Machine Learning"></asp:ListItem>
                                <asp:ListItem Text="Cloud / DevOps" Value="Cloud / DevOps"></asp:ListItem>
                                <asp:ListItem Text="Security Tool" Value="Security Tool"></asp:ListItem>
                                <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="edit-field full-width desc-field-wrapper">
                        <label>Description <span class="required-mark">*</span></label>
                        <div class="textarea-with-icon">
                            <i class="fa-regular fa-file-lines field-icon"></i>
                            <asp:TextBox ID="txtProjectDesc" runat="server" TextMode="MultiLine" Rows="4" MaxLength="1000" CssClass="form-control" placeholder="Describe your project, its purpose, key features and what you built..." oninput="updateProjectCharCount(this)"></asp:TextBox>
                            <div class="char-count" id="projectDescCharCount">0/1000</div>
                        </div>
                    </div>
                    <div class="edit-field full-width">
                        <label>Technologies Used <span class="required-mark">*</span></label>
                        <div class="input-with-icon">
                            <i class="fa-solid fa-code field-icon"></i>
                            <asp:TextBox ID="txtProjectTech" runat="server" CssClass="form-control" placeholder="e.g. ASP.NET, C#, SQL Server, HTML, CSS, JavaScript"></asp:TextBox>
                        </div>
                    </div>
                    <div class="edit-field full-width">
                        <label>Project Link <span class="optional-mark">(Optional)</span></label>
                        <div class="input-with-icon">
                            <i class="fa-solid fa-link field-icon"></i>
                            <asp:TextBox ID="txtProjectLink" runat="server" CssClass="form-control" placeholder="e.g. https://github.com/username/project"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="edit-modal-footer">
                <button type="button" class="cancel-edit-btn" onclick="closeProjectForm()">Cancel</button>
                <asp:ImageButton ID="btnSaveProject" runat="server" ImageUrl="~/assets/btn_save_project.png" Height="40" CssClass="student-img-btn" OnClick="btnSaveProject_Click" CausesValidation="false" OnClientClick="return validateProjectForm();" />
            </div>
        </div>
    </div>
    <div id="deleteConfirmModal" class="delete-confirm-modal" role="dialog" aria-modal="true" aria-labelledby="deleteConfirmTitle">
        <div class="delete-confirm-box">
            <div class="delete-confirm-icon"><i class="fa-solid fa-trash"></i></div>
            <h2 id="deleteConfirmTitle">Delete Confirmation</h2>
            <p id="deleteConfirmMessage">Are you sure you want to delete this item?</p>
            <div class="delete-confirm-actions">
                <button type="button" class="delete-cancel-btn" onclick="closeDeleteConfirm()">Cancel</button>
                <button type="button" class="delete-confirm-btn" onclick="executeCustomDelete()"><i class="fa-solid fa-trash"></i>Yes, Delete</button>
            </div>
        </div>
    </div>
    </asp:Content>

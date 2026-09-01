<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true"
    CodeFile="student-edit-profile.aspx.cs" Inherits="asp.net.student_edit_profile" %>

    <asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
        <link rel="stylesheet" href="<%= ResolveUrl(" ~/css/student-edit-profile.css") %>" />
    </asp:Content>

    <asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="student-edit-profile">

            <!-- ===================== 1. PAGE HEADER ===================== -->
            <div class="student-edit-header">
                <div>
                    <h1 class="student-edit-title">Edit Profile</h1>
                    <p class="student-edit-subtitle">Update your personal, academic and professional information.</p>
                </div>
                <div>
                    <a href="student-profile.aspx" class="student-edit-header-btn">
                        <i class="fa-solid fa-arrow-left"></i> Back to Profile
                    </a>
                </div>
            </div>

            <!-- Notification Alert (Backend Status Message) -->
            <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="student-edit-card"
                style="border-left: 4px solid #16A34A; background:#F0FDF4;">
                <div style="display:flex; align-items:center; gap:12px; color:#16A34A; font-weight:600;">
                    <i class="fa-solid fa-circle-check" style="font-size:20px;"></i>
                    <asp:Label ID="lblAlertMessage" runat="server" Text="Profile updated successfully." />
                </div>
            </asp:Panel>

            <!-- ===================== 2. PROFILE COMPLETION ===================== -->
            <div class="student-edit-progress-card">
                <div class="student-edit-progress-head">
                    <span><i class="fa-solid fa-chart-line"></i> Profile Completion</span>
                    <span>
                        <asp:Literal ID="litCompletionPercentage" runat="server" Text="85" />%
                    </span>
                </div>
                <div class="student-edit-progress-track">
                    <div class="student-edit-progress-fill" style="width: 85%;"></div>
                </div>
                <p class="student-edit-progress-missing">
                    Complete your profile to improve internship opportunities. Missing: Profile Photo, GitHub Profile
                    link.
                </p>
            </div>

            <!-- ===================== 3. PROFILE PHOTO SECTION ===================== -->
            <div class="student-edit-card">
                <h3 class="student-edit-card-title">
                    <i class="fa-solid fa-image"></i> Profile Photo
                </h3>
                <div class="student-edit-photo-container">
                    <div class="student-edit-photo-preview-wrap">
                        <asp:Image ID="imgProfilePreview" runat="server" ClientIDMode="Static"
                            CssClass="student-edit-photo-img" Visible="false" ImageUrl="~/images/default-avatar.png" />
                        <span ID="txtInitialsFallback" runat="server" ClientIDMode="Static"
                            class="student-edit-photo-initials">DP</span>
                    </div>
                    <div class="student-edit-photo-controls">
                        <div class="student-edit-upload-btn-wrap">
                            <label class="student-edit-file-btn">
                                <i class="fa-solid fa-camera"></i> Change Photo
                                <asp:FileUpload ID="fuProfilePhoto" runat="server" ClientIDMode="Static"
                                    CssClass="student-edit-hidden-file" />
                            </label>
                        </div>
                        <p class="student-edit-file-note">JPG, JPEG or PNG &bull; Maximum size: 2 MB &bull; Recommended:
                            400 &times; 400 px</p>
                    </div>
                </div>
            </div>

            <!-- ===================== 4. PERSONAL INFORMATION ===================== -->
            <div class="student-edit-card">
                <h3 class="student-edit-card-title">
                    <i class="fa-solid fa-user"></i> Personal Information
                </h3>

                <div class="student-edit-form-grid">
                    <!-- First Name -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">First Name <span class="student-edit-req">*</span></label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="student-edit-input" Text="Dhruvi" />
                        <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName"
                            ErrorMessage="First Name is required." CssClass="student-validator-error"
                            Display="Dynamic" />
                    </div>

                    <!-- Last Name -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Last Name <span class="student-edit-req">*</span></label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="student-edit-input" Text="Patel" />
                        <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName"
                            ErrorMessage="Last Name is required." CssClass="student-validator-error"
                            Display="Dynamic" />
                    </div>

                    <!-- Date of Birth -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Date of Birth</label>
                        <asp:TextBox ID="txtDOB" runat="server" TextMode="Date" CssClass="student-edit-input"
                            Text="2004-08-15" />
                    </div>

                    <!-- Gender -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Gender</label>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="student-edit-select">
                            <asp:ListItem Text="Select Gender" Value="" />
                            <asp:ListItem Text="Female" Value="Female" Selected="True" />
                            <asp:ListItem Text="Male" Value="Male" />
                            <asp:ListItem Text="Other" Value="Other" />
                            <asp:ListItem Text="Prefer not to say" Value="PreferNotToSay" />
                        </asp:DropDownList>
                    </div>

                    <!-- Email (Verified) -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">
                            Email Address <span class="student-edit-req">*</span>
                            <span class="student-edit-verified-badge"><i class="fa-solid fa-circle-check"></i>
                                Verified</span>
                        </label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="student-edit-input"
                            Text="dhruvi@example.com" ReadOnly="true" style="background-color:#F8FAFC;" />
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Email address is required." CssClass="student-validator-error"
                            Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
                            ErrorMessage="Please enter a valid email address." CssClass="student-validator-error"
                            Display="Dynamic" />
                    </div>

                    <!-- Phone Number -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Phone Number <span class="student-edit-req">*</span></label>
                        <div class="student-edit-input-icon-wrap">
                            <i class="fa-solid fa-phone"></i>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="student-edit-input"
                                Text="+91 98765 43210" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone"
                            ErrorMessage="Phone number is required." CssClass="student-validator-error"
                            Display="Dynamic" />
                    </div>

                    <!-- Alternate Phone -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Alternate Phone</label>
                        <div class="student-edit-input-icon-wrap">
                            <i class="fa-solid fa-mobile"></i>
                            <asp:TextBox ID="txtAltPhone" runat="server" CssClass="student-edit-input"
                                Text="+91 91234 56789" />
                        </div>
                    </div>

                    <!-- Profile Headline -->
                    <div class="student-edit-field student-edit-field-full">
                        <label class="student-edit-label">Profile Headline</label>
                        <asp:TextBox ID="txtHeadline" runat="server" CssClass="student-edit-input"
                            Text="Aspiring .NET Developer | Computer Engineering Student" />
                        <span class="student-edit-file-note">A short professional title shown below your name on profile
                            views.</span>
                    </div>
                </div>
            </div>

            <!-- ===================== 5. CONTACT INFORMATION ===================== -->
            <div class="student-edit-card">
                <h3 class="student-edit-card-title">
                    <i class="fa-solid fa-location-dot"></i> Contact Information
                </h3>

                <div class="student-edit-form-grid">
                    <!-- Address -->
                    <div class="student-edit-field student-edit-field-full">
                        <label class="student-edit-label">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="student-edit-input"
                            Text="123, Student Residency, University Road" />
                    </div>

                    <!-- City -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">City</label>
                        <div class="student-edit-input-icon-wrap">
                            <i class="fa-solid fa-city"></i>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="student-edit-input" Text="Ahmedabad" />
                        </div>
                    </div>

                    <!-- State -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">State</label>
                        <asp:TextBox ID="txtState" runat="server" CssClass="student-edit-input" Text="Gujarat" />
                    </div>

                    <!-- Country -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Country</label>
                        <asp:TextBox ID="txtCountry" runat="server" CssClass="student-edit-input" Text="India" />
                    </div>

                    <!-- Pincode -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Pincode</label>
                        <asp:TextBox ID="txtPincode" runat="server" CssClass="student-edit-input" Text="380001" />
                        <asp:RegularExpressionValidator ID="revPincode" runat="server" ControlToValidate="txtPincode"
                            ValidationExpression="^\d{6}$" ErrorMessage="Pincode must be 6 digits."
                            CssClass="student-validator-error" Display="Dynamic" />
                    </div>
                </div>
            </div>

            <!-- ===================== 6. ACADEMIC INFORMATION ===================== -->
            <div class="student-edit-card">
                <h3 class="student-edit-card-title">
                    <i class="fa-solid fa-graduation-cap"></i> Academic Information
                </h3>

                <div class="student-edit-form-grid">
                    <!-- College -->
                    <div class="student-edit-field student-edit-field-full">
                        <label class="student-edit-label">College / University <span
                                class="student-edit-req">*</span></label>
                        <asp:TextBox ID="txtCollege" runat="server" CssClass="student-edit-input"
                            Text="ABC College of Engineering & Technology" />
                        <asp:RequiredFieldValidator ID="rfvCollege" runat="server" ControlToValidate="txtCollege"
                            ErrorMessage="College name is required." CssClass="student-validator-error"
                            Display="Dynamic" />
                    </div>

                    <!-- Course -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Course / Degree <span
                                class="student-edit-req">*</span></label>
                        <asp:DropDownList ID="ddlCourse" runat="server" CssClass="student-edit-select">
                            <asp:ListItem Text="Select Course" Value="" />
                            <asp:ListItem Text="Bachelor of Engineering (B.E.)" Value="BE" Selected="True" />
                            <asp:ListItem Text="Bachelor of Technology (B.Tech)" Value="BTech" />
                            <asp:ListItem Text="Bachelor of Computer Applications (BCA)" Value="BCA" />
                            <asp:ListItem Text="Master of Computer Applications (MCA)" Value="MCA" />
                            <asp:ListItem Text="Diploma Engineering" Value="Diploma" />
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCourse" runat="server" ControlToValidate="ddlCourse"
                            ErrorMessage="Course selection is required." CssClass="student-validator-error"
                            Display="Dynamic" />
                    </div>

                    <!-- Branch -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Branch / Department</label>
                        <asp:TextBox ID="txtBranch" runat="server" CssClass="student-edit-input"
                            Text="Computer Engineering" />
                    </div>

                    <!-- Semester -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Current Semester</label>
                        <asp:DropDownList ID="ddlSemester" runat="server" CssClass="student-edit-select">
                            <asp:ListItem Text="1st Semester" Value="1" />
                            <asp:ListItem Text="2nd Semester" Value="2" />
                            <asp:ListItem Text="3rd Semester" Value="3" />
                            <asp:ListItem Text="4th Semester" Value="4" />
                            <asp:ListItem Text="5th Semester" Value="5" />
                            <asp:ListItem Text="6th Semester" Value="6" Selected="True" />
                            <asp:ListItem Text="7th Semester" Value="7" />
                            <asp:ListItem Text="8th Semester" Value="8" />
                        </asp:DropDownList>
                    </div>

                    <!-- Passing Year -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Passing Year</label>
                        <asp:TextBox ID="txtPassingYear" runat="server" CssClass="student-edit-input" Text="2027" />
                    </div>

                    <!-- CGPA -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">CGPA / Percentage</label>
                        <asp:TextBox ID="txtCGPA" runat="server" CssClass="student-edit-input" Text="8.45" />
                        <asp:RegularExpressionValidator ID="revCGPA" runat="server" ControlToValidate="txtCGPA"
                            ValidationExpression="^(10(\.0{1,2})?|[0-9](\.[0-9]{1,2})?)$"
                            ErrorMessage="Enter CGPA between 0.0 and 10.0" CssClass="student-validator-error"
                            Display="Dynamic" />
                    </div>
                </div>
            </div>

            <!-- ===================== 7. PROFESSIONAL INFORMATION ===================== -->
            <div class="student-edit-card">
                <h3 class="student-edit-card-title">
                    <i class="fa-solid fa-briefcase"></i> Professional Information
                </h3>

                <div class="student-edit-form-grid">
                    <!-- Career Objective -->
                    <div class="student-edit-field student-edit-field-full">
                        <label class="student-edit-label">Career Objective</label>
                        <asp:TextBox ID="txtCareerObjective" runat="server" TextMode="MultiLine" Rows="3"
                            CssClass="student-edit-textarea"
                            Text="Looking for an internship opportunity where I can apply my technical skills in web development and gain practical industry experience in ASP.NET and database design." />
                    </div>

                    <!-- Preferred Internship Category -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Preferred Internship Category</label>
                        <asp:DropDownList ID="ddlPreferredCategory" runat="server" CssClass="student-edit-select">
                            <asp:ListItem Text="Software Development" Value="SoftwareDev" Selected="True" />
                            <asp:ListItem Text="Web Development" Value="WebDev" />
                            <asp:ListItem Text="UI/UX Design" Value="UIUX" />
                            <asp:ListItem Text="Data Science / Analytics" Value="DataScience" />
                            <asp:ListItem Text="Cyber Security" Value="Security" />
                            <asp:ListItem Text="Cloud Computing" Value="Cloud" />
                        </asp:DropDownList>
                    </div>

                    <!-- Preferred Location -->
                    <div class="student-edit-field">
                        <label class="student-edit-label">Preferred Location</label>
                        <asp:TextBox ID="txtPreferredLocation" runat="server" CssClass="student-edit-input"
                            Text="Ahmedabad" />
                    </div>

                    <!-- Work Preference -->
                    <div class="student-edit-field student-edit-field-full">
                        <label class="student-edit-label">Work Preference</label>
                        <asp:DropDownList ID="ddlWorkPreference" runat="server" CssClass="student-edit-select">
                            <asp:ListItem Text="Hybrid (On-site & Remote)" Value="Hybrid" Selected="True" />
                            <asp:ListItem Text="On-site Only" Value="OnSite" />
                            <asp:ListItem Text="Remote Only" Value="Remote" />
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <!-- ===================== 8. SKILLS SECTION ===================== -->
            <div class="student-edit-card">
                <h3 class="student-edit-card-title">
                    <i class="fa-solid fa-code"></i> Technical Skills
                </h3>

                <div class="student-skills-container">
                    <div class="student-skills-list" id="skillsContainer">
                        <div class="student-skill-chip"><span class="student-skill-chip-text">C#</span><i
                                class="fa-solid fa-xmark student-skill-remove"></i></div>
                        <div class="student-skill-chip"><span class="student-skill-chip-text">ASP.NET</span><i
                                class="fa-solid fa-xmark student-skill-remove"></i></div>
                        <div class="student-skill-chip"><span class="student-skill-chip-text">SQL</span><i
                                class="fa-solid fa-xmark student-skill-remove"></i></div>
                        <div class="student-skill-chip"><span class="student-skill-chip-text">HTML</span><i
                                class="fa-solid fa-xmark student-skill-remove"></i></div>
                        <div class="student-skill-chip"><span class="student-skill-chip-text">CSS</span><i
                                class="fa-solid fa-xmark student-skill-remove"></i></div>
                        <div class="student-skill-chip"><span class="student-skill-chip-text">JavaScript</span><i
                                class="fa-solid fa-xmark student-skill-remove"></i></div>
                    </div>

                    <div class="student-skill-add-wrap">
                        <asp:TextBox ID="txtNewSkill" runat="server" ClientIDMode="Static" CssClass="student-edit-input"
                            placeholder="Enter new skill (e.g. React)..." />
                        <button type="button" id="btnAddSkill" class="student-skill-add-btn">
                            <i class="fa-solid fa-plus"></i> Add
                        </button>
                    </div>

                    <!-- Hidden field to sync skill array with backend -->
                    <asp:HiddenField ID="hdnSkillsList" runat="server" ClientIDMode="Static"
                        Value="C#,ASP.NET,SQL,HTML,CSS,JavaScript" />
                </div>
            </div>

            <!-- ===================== 9. RESUME SECTION ===================== -->
            <div class="student-edit-card">
                <h3 class="student-edit-card-title">
                    <i class="fa-solid fa-file-pdf"></i> Resume / CV
                </h3>

                <div class="student-resume-preview-box">
                    <div class="student-resume-info">
                        <div class="student-resume-icon">
                            <i class="fa-solid fa-file-pdf"></i>
                        </div>
                        <div>
                            <h4 class="student-resume-filename" id="lblResumeFilename">Dhruvi_Patel_Resume.pdf</h4>
                            <p class="student-resume-date">Uploaded on: 20 Aug 2026 &bull; PDF File (1.2 MB)</p>
                        </div>
                    </div>

                    <div class="student-resume-actions">
                        <a href="#" target="_blank" class="student-btn-outline">
                            <i class="fa-solid fa-eye"></i> Preview
                        </a>
                        <label class="student-edit-file-btn" style="padding: 8px 16px; font-size:13px;">
                            <i class="fa-solid fa-arrow-up-from-bracket"></i> Replace Resume
                            <asp:FileUpload ID="fuResume" runat="server" ClientIDMode="Static"
                                CssClass="student-edit-hidden-file" />
                        </label>
                    </div>
                </div>
                <p class="student-edit-file-note">Accepted format: PDF only &bull; Maximum file size: 5 MB</p>
            </div>

            <!-- ===================== 10. PROFESSIONAL LINKS ===================== -->
            <div class="student-edit-card">
                <h3 class="student-edit-card-title">
                    <i class="fa-solid fa-link"></i> Professional Links
                </h3>

                <div class="student-edit-form-grid">
                    <!-- LinkedIn -->
                    <div class="student-edit-field">
                        <label class="student-edit-label"><i class="fa-brands fa-linkedin" style="color:#0A66C2;"></i>
                            LinkedIn Profile</label>
                        <asp:TextBox ID="txtLinkedIn" runat="server" CssClass="student-edit-input"
                            placeholder="https://linkedin.com/in/username" Text="https://linkedin.com/in/dhruvipatel" />
                        <asp:RegularExpressionValidator ID="revLinkedIn" runat="server" ControlToValidate="txtLinkedIn"
                            ValidationExpression="^http(s)?://([\w-]+.)+[\w-]+(/[\w- ./?%&=]*)?$"
                            ErrorMessage="Please enter a valid URL." CssClass="student-validator-error"
                            Display="Dynamic" />
                    </div>

                    <!-- GitHub -->
                    <div class="student-edit-field">
                        <label class="student-edit-label"><i class="fa-brands fa-github" style="color:#171515;"></i>
                            GitHub Profile</label>
                        <asp:TextBox ID="txtGitHub" runat="server" CssClass="student-edit-input"
                            placeholder="https://github.com/username" Text="https://github.com/dhruvipatel" />
                        <asp:RegularExpressionValidator ID="revGitHub" runat="server" ControlToValidate="txtGitHub"
                            ValidationExpression="^http(s)?://([\w-]+.)+[\w-]+(/[\w- ./?%&=]*)?$"
                            ErrorMessage="Please enter a valid URL." CssClass="student-validator-error"
                            Display="Dynamic" />
                    </div>

                    <!-- Portfolio -->
                    <div class="student-edit-field student-edit-field-full">
                        <label class="student-edit-label"><i class="fa-solid fa-globe" style="color:#2F6FED;"></i>
                            Portfolio Website</label>
                        <asp:TextBox ID="txtPortfolio" runat="server" CssClass="student-edit-input"
                            placeholder="https://yourportfolio.com" Text="https://dhruvipatel.dev" />
                        <asp:RegularExpressionValidator ID="revPortfolio" runat="server"
                            ControlToValidate="txtPortfolio"
                            ValidationExpression="^http(s)?://([\w-]+.)+[\w-]+(/[\w- ./?%&=]*)?$"
                            ErrorMessage="Please enter a valid URL." CssClass="student-validator-error"
                            Display="Dynamic" />
                    </div>
                </div>
            </div>

            <!-- ===================== 11. SAVE / CANCEL ACTION BAR ===================== -->
            <div class="student-edit-actions-bar">
                <a href="student-profile.aspx" class="student-edit-btn-cancel">Cancel</a>
                <asp:Button ID="btnSaveProfile" runat="server" ClientIDMode="Static" Text="Save Changes"
                    OnClick="btnSaveProfile_Click" CssClass="student-edit-btn-save" />
            </div>

        </div>
    </asp:Content>

    <asp:Content ID="ContentScripts" ContentPlaceHolderID="ScriptContent" runat="server">
        <link rel="stylesheet" href="<%= ResolveUrl(" ~/css/student-edit-profile.css") %>" />
    </asp:Content>
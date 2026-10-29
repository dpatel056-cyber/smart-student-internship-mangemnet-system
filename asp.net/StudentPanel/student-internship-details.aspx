<%@ Page Title="Internship Details" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-internship-details.aspx.cs" Inherits="asp.net.student_internship_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/internship-module.css" />
    <link rel="stylesheet" href="../css/internship-details.css" />
    <link rel="stylesheet" href="../css/student-internship-details.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="site-main imd-page-main">
        <div class="container imd-container">
            <br />
            <!-- Back Navigation -->
            <div class="back-nav">
                <asp:ImageButton ID="btnBackInternships" runat="server" ImageUrl="~/assets/btn_back_internships.png" PostBackUrl="~/StudentPanel/student-internships.aspx" Height="42px" CssClass="asp-img-btn btn-img-action" />
            </div>

            <!-- Not Found Panel -->
            <div id="divNotFound" runat="server" visible="false" class="imd-not-found-box">
                <i class="fa-solid fa-file-circle-xmark imd-not-found-icon"></i>
                <asp:ImageButton ID="btnExploreOther" runat="server" ImageUrl="~/assets/btn_explore_other.png" PostBackUrl="~/StudentPanel/student-internships.aspx" Height="42px" CssClass="btn-img-action" />
            </div>

            <asp:DataList ID="DataListInternshipDetail" runat="server" Width="100%">
                <ItemTemplate>

                    <!-- Header -->
                    <div class="imd-header imd-header-wrap">
                        <div class="imd-cover"></div>
                        <div class="imd-content">
                            <asp:HyperLink ID="hlCompanyLogo" runat="server" NavigateUrl='<%# ResolveUrl("~/StudentPanel/student-company-details.aspx?CompanyId=" + Eval("CompanyId")) %>' CssClass="imd-logo imd-logo-link">
                                <asp:Image ID="imgCompanyLogo" runat="server" ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' CssClass="imd-logo-img" />
                            </asp:HyperLink>
                            <h1 class="imd-title imd-title-spaced">
                                <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                            </h1>
                            <div class="imd-company imd-company-wrap">
                                <asp:HyperLink ID="hlCompany" runat="server" NavigateUrl='<%# ResolveUrl("~/StudentPanel/student-company-details.aspx?CompanyId=" + Eval("CompanyId")) %>' CssClass="imd-company-link">
                                    <i class="fa-solid fa-building"></i>
                                    <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                    <i class="fa-solid fa-circle-check cp-verified imd-verified-icon"></i>
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
                                    <i class="fa-solid fa-align-left imd-section-icon"></i>
                                    Overview
                                </h3>
                                <p class="imd-text">
                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("InternshipDescription") %>'></asp:Label>
                                </p>
                            </div>

                            <div class="imd-section">
                                <h3 class="imd-section-title">
                                    <i class="fa-solid fa-list-check imd-section-icon"></i>
                                    Key Responsibilities
                                </h3>
                                <div class="imd-text">
                                    <asp:Label ID="lblResponsibilities" runat="server" Text='<%# Eval("Responsibilities") %>'></asp:Label>
                                </div>
                            </div>

                            <div class="imd-section">
                                <h3 class="imd-section-title">
                                    <i class="fa-solid fa-user-graduate imd-section-icon"></i>
                                    Requirements &amp; Qualifications
                                </h3>
                                <div class="imd-text">
                                    <asp:Label ID="lblQualifications" runat="server" Text='<%# Eval("RequiredQualifications") %>'></asp:Label>
                                </div>
                            </div>

                            <div class="imd-section">
                                <h3 class="imd-section-title">
                                    <i class="fa-solid fa-lightbulb imd-section-icon"></i>
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
                                    <i class="fa-solid fa-gift imd-section-icon"></i>
                                    Benefits &amp; Perks
                                </h3>
                                <div class="imd-skills">
                                    <span class="imd-skill-badge">
                                        <i class="fa-solid fa-circle-check imd-check-icon"></i>
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
                                    <asp:Image ID="imgCompanyLogo2" runat="server" ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' CssClass="company-logo-avatar" />
                                    <div>
                                        <h3 class="imd-apply-title">
                                            <asp:Label ID="lblCompanyBoxName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                        </h3>
                                        <p class="imd-apply-sub">
                                            <i class="fa-solid fa-industry"></i>
                                            <asp:Label ID="lblCompanyIndustry" runat="server" Text='<%# Eval("c_industry") %>'></asp:Label>
                                            &nbsp;|&nbsp;
                                            <i class="fa-solid fa-location-dot"></i>
                                            <asp:Label ID="lblCompanyLocation" runat="server" Text='<%# Eval("c_location") %>'></asp:Label>
                                        </p>
                                    </div>
                                </div>
                                <p class="imd-apply-desc">
                                    <asp:Label ID="lblCompanyAbout" runat="server" Text='<%# Eval("c_about") %>'></asp:Label>
                                </p>
                                <asp:ImageButton ID="btnViewCompany" runat="server" ImageUrl="~/assets/btn_view_company.png" PostBackUrl='<%# "student-company-details.aspx?CompanyId=" + Eval("CompanyId") %>' Height="42px" CssClass="btn-img-action" />
                            </div>
                        </div>

                        <!-- RIGHT SIDEBAR -->
                        <aside class="imd-sidebar">

                            <!-- Quick Actions -->
                            <div class="imd-side-card">
                                <h3 class="imd-side-title">Quick Actions</h3>
                                <div class="imd-actions">
                                    <asp:ImageButton ID="btnApplyNow" runat="server" ImageUrl="~/assets/btn_apply_internship.png" Height="45px" CssClass="imd-action-btn" OnClientClick="openApplyModal(); return false;" />
                                    <asp:ImageButton ID="btnSave" runat="server" ImageUrl="~/assets/btn_save_internship.png" Height="45px" CssClass="imd-action-btn" OnClick="btnSave_Click" />
                                </div>
                            </div>

                            <!-- Internship Details -->
                            <div class="imd-side-card">
                                <h3 class="imd-side-title">Internship Details</h3>
                                <ul class="imd-meta-list">
                                    <li>
                                        <span class="imd-meta-label">Domain</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblDomain" runat="server" Text='<%# Eval("InternshipDomain") %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Type</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblType" runat="server" Text='<%# Eval("InternshipType") %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Work Mode</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblSidebarWorkMode" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Openings</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblOpenings" runat="server" Text='<%# Eval("NumberOfOpenings") %>'></asp:Label> Positions
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Start Date</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("StartDate") != DBNull.Value ? Convert.ToDateTime(Eval("StartDate")).ToString("dd-MM-yyyy") : "Immediate" %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Apply Deadline</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblDeadline" runat="server" Text='<%# Eval("ApplicationDeadline") != DBNull.Value ? Convert.ToDateTime(Eval("ApplicationDeadline")).ToString("dd-MM-yyyy") : "Open until filled" %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Eligible Courses</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblCourses" runat="server" Text='<%# Eval("EligibleCourses") %>'></asp:Label>
                                        </span>
                                    </li>
                                    <li>
                                        <span class="imd-meta-label">Min CGPA</span>
                                        <span class="imd-meta-value">
                                            <asp:Label ID="lblCGPA" runat="server" Text='<%# Eval("MinimumCGPA") %>'></asp:Label>
                                        </span>
                                    </li>
                                </ul>
                            </div>

                            <!-- Share -->
                            <div class="imd-side-card imd-side-card-centered">
                                <h3 class="imd-side-title">Share Internship</h3>
                                <div class="imd-share-links">
                                    <asp:ImageButton ID="btnShareLinkedIn" runat="server" ImageUrl="~/assets/share_linkedin.png" CssClass="imd-share-btn" OnClientClick="return false;" />
                                    <asp:ImageButton ID="btnShareTwitter" runat="server" ImageUrl="~/assets/share_twitter.png" CssClass="imd-share-btn" OnClientClick="return false;" />
                                    <asp:ImageButton ID="btnShareFacebook" runat="server" ImageUrl="~/assets/share_facebook.png" CssClass="imd-share-btn" OnClientClick="return false;" />
                                    <asp:ImageButton ID="btnShareLink" runat="server" ImageUrl="~/assets/share_link.png" CssClass="imd-share-btn" OnClientClick="return false;" />
                                </div>
                            </div>
                        </aside>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
    </main>

    <!-- Apply Internship Modal -->
    <div id="applyModalOverlay" class="app-modal-overlay">
        <div class="app-modal-box">
            <!-- Modal Header -->
            <div class="app-modal-header">
                <h3><i class="fa-solid fa-briefcase sintd-u15"></i> Apply for Internship</h3>
                <button type="button" class="app-modal-close" onclick="closeApplyModal()">&times;</button>
            </div>
            <!-- Modal Body Form -->
            <div class="app-modal-body">
                <div class="sintd-u16">
                    <div class="sintd-u17">
                        <i class="fa-solid fa-building"></i>
                    </div>
                    <div>
                        <div class="sintd-u18">
                            <asp:Label ID="lblModalRoleTitle" runat="server"></asp:Label>
                        </div>
                        <div class="sintd-u19">
                            <asp:Label ID="lblModalCompanyName" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <asp:Label ID="lblModalError" runat="server" Visible="false" CssClass="alert-error sintd-u20"></asp:Label>
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
                        <div id="divCurrentResume" runat="server" visible="false" class="sintd-u21">
                            <i class="fa-solid fa-file-pdf"></i>
                            <span>Attached Profile Resume: <asp:Label ID="lblCurrentResumeName" runat="server"></asp:Label></span>
                        </div>
                        <div class="sintd-u22">
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
                <asp:ImageButton ID="btnSubmitApplication" runat="server" ImageUrl="~/assets/btn_submit_application.png" Height="44" CssClass="student-img-btn" OnClick="btnSubmitApplication_Click" />
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ScriptContent_sintd" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="../js/student-internship-details.js"></script>
</asp:Content>

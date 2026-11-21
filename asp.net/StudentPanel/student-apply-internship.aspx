<%@ Page Title="Apply for Internship" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-apply-internship.aspx.cs" Inherits="asp.net.student_apply_internship" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/internship-module.css" />
    <link rel="stylesheet" href="../css/internship-details.css" />
    <link rel="stylesheet" href="../css/student-internship-details.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="site-main imd-page-main">
        <div class="container imd-container" style="max-width: 900px; margin: 30px auto;">
            <!-- Back Navigation -->
            <div class="back-nav" style="margin-bottom: 20px;">
                <asp:HyperLink ID="hlBack" runat="server" CssClass="btn-action-sm">
                    <i class="fa-solid fa-arrow-left"></i> Back to Internship Details
                </asp:HyperLink>
            </div>

            <!-- Internship Summary Card -->
            <div class="company-info-box" style="margin-bottom: 24px; padding: 20px 24px; background: #ffffff; border-radius: 16px; border: 1.5px solid #e2e8f0; box-shadow: 0 4px 12px rgba(15,23,42,0.04);">
                <div class="company-info-header" style="display: flex; align-items: center; gap: 16px;">
                    <asp:Image ID="imgCompanyLogo" runat="server" Width="55px" Height="55px" Style="border-radius: 12px; object-fit: contain; border: 1px solid #e2e8f0; padding: 4px;" />
                    <div>
                        <h2 style="font-size: 20px; font-weight: 800; color: #0f172a; margin: 0 0 4px 0;">
                            <asp:Label ID="lblRoleTitle" runat="server"></asp:Label>
                        </h2>
                        <p style="margin: 0; color: #64748b; font-size: 14px; display: flex; align-items: center; gap: 12px; flex-wrap: wrap;">
                            <span><i class="fa-solid fa-building" style="color: #2563eb;"></i> <asp:Label ID="lblCompanyName" runat="server"></asp:Label></span>
                            <span>&bull;</span>
                            <span><i class="fa-solid fa-location-dot" style="color: #64748b;"></i> <asp:Label ID="lblLocation" runat="server"></asp:Label></span>
                            <span>&bull;</span>
                            <span><i class="fa-solid fa-indian-rupee-sign" style="color: #10b981;"></i> <asp:Label ID="lblStipend" runat="server"></asp:Label></span>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Application Form Card -->
            <div class="apply-card" style="background: #ffffff; border-radius: 16px; border: 1.5px solid #e2e8f0; padding: 28px 32px; box-shadow: 0 4px 12px rgba(15,23,42,0.04);">
                <div style="border-bottom: 1.5px solid #f1f5f9; padding-bottom: 16px; margin-bottom: 24px;">
                    <h3 style="font-size: 18px; font-weight: 800; color: #0f172a; margin: 0 0 6px 0;">
                        <i class="fa-solid fa-file-pen" style="color: #2563eb;"></i> Candidate Application Form
                    </h3>
                    <p style="margin: 0; font-size: 13.5px; color: #64748b;">Please review your profile details below and submit your internship application.</p>
                </div>

                <asp:Label ID="lblError" runat="server" Visible="false" CssClass="alert-error" Style="display: block; padding: 12px 16px; background: #fee2e2; color: #b91c1c; border-radius: 10px; margin-bottom: 20px; font-size: 14px; font-weight: 600;"></asp:Label>

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
                <div class="app-form-group" style="margin-top: 20px;">
                    <label class="app-form-label">Resume / CV (PDF) <span class="req">*</span></label>
                    <div class="app-file-box">
                        <asp:HiddenField ID="hfProfileResume" runat="server" />
                        <div id="divCurrentResume" runat="server" visible="false" style="display: flex; align-items: center; gap: 8px; font-weight: 600; color: #2563eb; font-size: 13.5px;">
                            <i class="fa-solid fa-file-pdf" style="font-size: 18px; color: #ef4444;"></i>
                            <span>Attached Profile Resume: <asp:Label ID="lblCurrentResumeName" runat="server"></asp:Label></span>
                        </div>
                        <div style="font-size: 13px; color: #64748b; margin-top: 4px;">
                            <asp:Label ID="lblUploadResumePrompt" runat="server" Text="Upload a new resume if you want to replace it for this application:"></asp:Label>
                        </div>
                        <asp:FileUpload ID="fuApplicantResume" runat="server" CssClass="app-form-control" accept=".pdf" />
                    </div>
                </div>

                <!-- Cover Letter / Notes -->
                <div class="app-form-group" style="margin-top: 20px;">
                    <label class="app-form-label">Why should you be hired for this role? (Cover Note)</label>
                    <asp:TextBox ID="txtApplicantCoverLetter" runat="server" TextMode="MultiLine" Rows="4" CssClass="app-form-control" placeholder="Briefly highlight your relevant skills, projects, and why you are interested in this position..."></asp:TextBox>
                </div>

                <!-- Form Actions -->
                <div style="margin-top: 28px; padding-top: 20px; border-top: 1.5px solid #f1f5f9; display: flex; justify-content: flex-end; align-items: center; gap: 14px;">
                    <asp:HyperLink ID="hlCancel" runat="server" CssClass="btn-cancel-modal">Cancel</asp:HyperLink>
                    <asp:ImageButton ID="btnSubmitApplication" runat="server" ImageUrl="~/assets/btn_submit_application.png" Height="44" CssClass="student-img-btn" OnClick="btnSubmitApplication_Click" />
                </div>
            </div>
        </div>
    </main>
</asp:Content>

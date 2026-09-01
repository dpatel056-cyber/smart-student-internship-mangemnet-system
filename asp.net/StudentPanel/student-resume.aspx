<%@ Page Title="My Resume" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeFile="student-resume.aspx.cs" Inherits="asp.net.student_resume" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/student-resume.css") %>" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-resume-page">

        <!-- ===================== 1. PAGE HEADER ===================== -->
        <div class="student-resume-header">
            <div>
                <h1 class="student-resume-title">My Resume</h1>
                <p class="student-resume-subtitle">Upload and manage your latest resume for internship applications.</p>
            </div>
            <div>
                <a href="student-resume-preview.aspx" class="student-resume-header-btn">
                    <i class="fa-solid fa-eye"></i> Preview Resume
                </a>
            </div>
        </div>

        <!-- Notification Alert (Backend Feedback) -->
        <asp:Panel ID="pnlAlert" runat="server" Visible="false" CssClass="student-resume-card" style="border-left: 4px solid #16A34A; background:#F0FDF4; padding:16px 20px;">
            <div style="display:flex; align-items:center; gap:12px; color:#16A34A; font-weight:600; font-size:14px;">
                <i class="fa-solid fa-circle-check" style="font-size:18px;"></i>
                <asp:Label ID="lblAlertMessage" runat="server" Text="Resume operation completed successfully." />
            </div>
        </asp:Panel>

        <!-- ===================== 2. CURRENT RESUME CARD ===================== -->
        <asp:Panel ID="pnlCurrentResume" runat="server" CssClass="student-resume-card">
            <div class="student-resume-card-title">
                <i class="fa-solid fa-file-pdf"></i> Current Active Resume
            </div>

            <div class="student-resume-current-box">
                <div class="student-resume-file-info-wrap">
                    <div class="student-resume-file-icon">
                        <i class="fa-solid fa-file-pdf"></i>
                    </div>
                    <div class="student-resume-file-details">
                        <h3 class="student-resume-file-name">
                            <asp:Label ID="lblCurrentFileName" runat="server" Text="Dhruvi_Patel_Resume.pdf" />
                        </h3>
                        <p class="student-resume-file-meta">
                            <span>Uploaded: <asp:Label ID="lblUploadDate" runat="server" Text="20 Aug 2026" /></span>
                            &bull;
                            <span>Size: <asp:Label ID="lblFileSize" runat="server" Text="1.8 MB" /></span>
                            &bull;
                            <span class="student-resume-status-badge badge-active">
                                <i class="fa-solid fa-circle-check"></i> Active
                            </span>
                        </p>
                    </div>
                </div>

                <div class="student-resume-actions">
                    <a href="student-resume-preview.aspx" class="btn-action-outline">
                        <i class="fa-solid fa-eye"></i> Preview
                    </a>
                    <asp:LinkButton ID="btnDownloadResume" runat="server" OnClick="btnDownloadResume_Click" CssClass="btn-action-outline">
                        <i class="fa-solid fa-download"></i> Download
                    </asp:LinkButton>
                    <button type="button" id="btnTriggerReplaceModal" class="btn-action-outline">
                        <i class="fa-solid fa-rotate"></i> Replace
                    </button>
                    <button type="button" id="btnTriggerDeleteModal" class="btn-action-outline btn-action-danger">
                        <i class="fa-solid fa-trash"></i> Delete
                    </button>
                </div>
            </div>
        </asp:Panel>

        <!-- Fallback Panel when no resume is uploaded -->
        <asp:Panel ID="pnlNoResume" runat="server" Visible="false" CssClass="student-resume-card" style="border-left:4px solid #F59E0B; background:#FFFBEB;">
            <div style="display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:12px;">
                <div style="display:flex; align-items:center; gap:12px; color:#B45309; font-weight:600;">
                    <i class="fa-solid fa-triangle-exclamation" style="font-size:20px;"></i>
                    <span>⚠ Resume Not Uploaded. Upload your resume to start applying for internships.</span>
                </div>
                <span class="student-resume-status-badge badge-missing">Missing</span>
            </div>
        </asp:Panel>

        <!-- ===================== 3. UPLOAD RESUME SECTION ===================== -->
        <div class="student-resume-card">
            <div class="student-resume-card-title">
                <i class="fa-solid fa-cloud-arrow-up"></i> Upload New Resume
            </div>

            <div class="student-resume-dropzone" id="resumeDropzone">
                <i class="fa-solid fa-cloud-arrow-up student-resume-dropzone-icon"></i>
                <h4 class="student-resume-dropzone-title">Drag & Drop your resume here</h4>
                <p class="student-resume-dropzone-sub">or click below to browse from your device</p>
                
                <span class="student-resume-browse-btn">
                    <i class="fa-solid fa-folder-open"></i> Browse File
                </span>

                <!-- Hidden ASP.NET FileUpload -->
                <asp:FileUpload ID="fuResumeUpload" runat="server" ClientIDMode="Static" />

                <!-- Selected File Display -->
                <div class="student-resume-file-selected-box" id="selectedFileBox">
                    <div class="student-resume-file-selected-info">
                        <i class="fa-solid fa-file-pdf" style="color:#EF4444; font-size:18px;"></i>
                        <span id="lblSelectedFileName">Dhruvi_Patel_Resume.pdf (1.8 MB)</span>
                    </div>
                    <i class="fa-solid fa-xmark student-resume-file-remove" id="btnRemoveSelectedFile" title="Remove selected file"></i>
                </div>

                <p class="student-resume-dropzone-sub" style="font-size:12px; margin-top:6px;">
                    Supported format: <strong>PDF only</strong> &bull; Maximum file size: <strong>5 MB</strong>
                </p>
            </div>

            <asp:Button ID="btnUploadResume" runat="server" ClientIDMode="Static" Text="Upload Resume" OnClick="btnUploadResume_Click" CssClass="student-resume-upload-btn" />
        </div>

        <!-- ===================== 4. TWO-COLUMN: REQUIREMENTS & PROFILE CONNECTION ===================== -->
        <div class="student-resume-two-col">
            
            <!-- LEFT: RESUME REQUIREMENTS -->
            <div class="student-resume-card">
                <div class="student-resume-card-title">
                    <i class="fa-solid fa-circle-check"></i> Resume Requirements
                </div>
                <div class="student-resume-req-list">
                    <div class="student-resume-req-item">
                        <i class="fa-solid fa-circle-check"></i>
                        <span>PDF format only (.pdf)</span>
                    </div>
                    <div class="student-resume-req-item">
                        <i class="fa-solid fa-circle-check"></i>
                        <span>Maximum file size: 5 MB</span>
                    </div>
                    <div class="student-resume-req-item">
                        <i class="fa-solid fa-circle-check"></i>
                        <span>Clear and professional format with readable font</span>
                    </div>
                    <div class="student-resume-req-item">
                        <i class="fa-solid fa-circle-check"></i>
                        <span>Keep your resume updated with latest skills & project experience</span>
                    </div>
                </div>
            </div>

            <!-- RIGHT: PROFILE COMPLETION CONNECTION -->
            <div class="student-resume-card">
                <div class="student-resume-card-title">
                    <i class="fa-solid fa-chart-line"></i> Profile Completion Impact
                </div>
                <div class="student-resume-completion-info">
                    <div style="display:flex; align-items:center; gap:10px;">
                        <span class="student-resume-status-badge badge-active" style="font-size:14px; padding:6px 14px;">
                            <i class="fa-solid fa-circle-check"></i> Resume Uploaded (+15% Completion)
                        </span>
                    </div>
                    <p style="font-size:13.5px; color:var(--student-muted); margin:0; line-height:1.5;">
                        Uploading an active resume significantly increases your chances of getting shortlisted by companies. Your resume is accessible to verified hiring managers when you apply.
                    </p>
                </div>
            </div>

        </div>

        <!-- ===================== 5. RESUME HISTORY TABLE ===================== -->
        <div class="student-resume-card">
            <div class="student-resume-card-title">
                <i class="fa-solid fa-clock-rotate-left"></i> Resume Upload History
            </div>

            <div class="student-resume-table-wrap">
                <table class="student-resume-table">
                    <thead>
                        <tr>
                            <th>File Name</th>
                            <th>Uploaded Date</th>
                            <th>File Size</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>Dhruvi_Patel_Resume_v3.pdf</strong></td>
                            <td>20 Aug 2026</td>
                            <td>1.8 MB</td>
                            <td><span class="student-resume-status-badge badge-active">Active</span></td>
                            <td><a href="student-resume-preview.aspx" class="btn-action-outline" style="padding:4px 10px; font-size:12px;"><i class="fa-solid fa-eye"></i> View</a></td>
                        </tr>
                        <tr>
                            <td>Dhruvi_Patel_Resume_v2.pdf</td>
                            <td>10 Aug 2026</td>
                            <td>1.6 MB</td>
                            <td><span class="student-resume-status-badge" style="background:#F1F5F9; color:#64748B;">Archived</span></td>
                            <td><a href="#" class="btn-action-outline" style="padding:4px 10px; font-size:12px;"><i class="fa-solid fa-eye"></i> View</a></td>
                        </tr>
                        <tr>
                            <td>Dhruvi_Patel_Resume_v1.pdf</td>
                            <td>01 Aug 2026</td>
                            <td>1.4 MB</td>
                            <td><span class="student-resume-status-badge" style="background:#F1F5F9; color:#64748B;">Archived</span></td>
                            <td><a href="#" class="btn-action-outline" style="padding:4px 10px; font-size:12px;"><i class="fa-solid fa-eye"></i> View</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <!-- ===================== MODAL 1: REPLACE CONFIRMATION ===================== -->
    <div class="student-resume-modal-overlay" id="modalReplaceResume">
        <div class="student-resume-modal-box">
            <div class="student-resume-modal-icon modal-icon-warning">
                <i class="fa-solid fa-rotate"></i>
            </div>
            <h3 class="student-resume-modal-title">Replace Current Resume?</h3>
            <p class="student-resume-modal-desc">
                Are you sure you want to replace your current resume? Your existing resume will be archived and the new file will become your active resume for all internship applications.
            </p>
            <div class="student-resume-modal-actions">
                <button type="button" class="btn-modal-cancel" id="btnCancelReplace">Cancel</button>
                <button type="button" class="btn-modal-primary" id="btnConfirmReplace">Select & Replace File</button>
            </div>
        </div>
    </div>

    <!-- ===================== MODAL 2: DELETE CONFIRMATION ===================== -->
    <div class="student-resume-modal-overlay" id="modalDeleteResume">
        <div class="student-resume-modal-box">
            <div class="student-resume-modal-icon modal-icon-danger">
                <i class="fa-solid fa-triangle-exclamation"></i>
            </div>
            <h3 class="student-resume-modal-title">Delete Resume?</h3>
            <p class="student-resume-modal-desc">
                Are you sure you want to delete your current resume? You will not be able to apply for internships until you upload a new resume.
            </p>
            <div class="student-resume-modal-actions">
                <button type="button" class="btn-modal-cancel" id="btnCancelDelete">Cancel</button>
                <asp:Button ID="btnConfirmDelete" runat="server" Text="Delete Resume" OnClick="btnConfirmDelete_Click" CssClass="btn-modal-danger" />
            </div>
        </div>
    </div>

</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="<%= ResolveUrl("~/js/student-resume.js") %>"></script>
</asp:Content>

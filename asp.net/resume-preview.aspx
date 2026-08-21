<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="resume-preview.aspx.cs" Inherits="asp.net.resume_preview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/profile-module.css">
<link rel="stylesheet" href="../css/resume-module.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
          <div class="pm-breadcrumb">
        <a href="student-dashboard.html">Dashboard</a>
        <i class="fa-solid fa-chevron-right"></i>
        <a href="resume-dashboard.html">Resume &amp; Documents</a>
        <i class="fa-solid fa-chevron-right"></i>
        <span class="current">Resume Preview</span>
      </div>

      <!-- Shown when a resume exists -->
      <div id="rdPreviewContent" style="display:none;">
        <div class="rd-preview-layout">

          <!-- PDF preview card -->
          <div class="rd-pdf-card">
            <div class="rd-pdf-frame-wrap" id="rdPdfFrameWrap">
              <div class="rd-pdf-placeholder" id="rdPdfPlaceholder">
                <i class="fa-solid fa-file-pdf"></i>
                <p>Live preview isn't available for this demo file, but the resume has been saved to your profile.</p>
              </div>
            </div>
            <div class="rd-pdf-name" id="rdPdfName">-</div>
            <div class="rd-pdf-meta" id="rdPdfMeta">-</div>
          </div>

          <!-- Resume information -->
          <div>
            <div class="pm-card">
              <div class="pm-card-header">
                <div>
                  <h3>Resume Information</h3>
                  <p>Details of your currently uploaded resume</p>
                </div>
                <span class="pm-resume-status uploaded"><i class="fa-solid fa-circle-check"></i> Uploaded</span>
              </div>

              <div class="rd-info-list">
                <div class="pm-info-item">
                  <span class="pm-info-icon"><i class="fa-solid fa-file-lines"></i></span>
                  <div>
                    <div class="pm-info-label">File Name</div>
                    <div class="pm-info-value" id="rdInfoFileName">-</div>
                  </div>
                </div>
                <div class="pm-info-item">
                  <span class="pm-info-icon"><i class="fa-solid fa-weight-hanging"></i></span>
                  <div>
                    <div class="pm-info-label">File Size</div>
                    <div class="pm-info-value" id="rdInfoFileSize">-</div>
                  </div>
                </div>
                <div class="pm-info-item">
                  <span class="pm-info-icon"><i class="fa-solid fa-calendar-plus"></i></span>
                  <div>
                    <div class="pm-info-label">First Uploaded</div>
                    <div class="pm-info-value" id="rdInfoUploadedDate">-</div>
                  </div>
                </div>
                <div class="pm-info-item">
                  <span class="pm-info-icon"><i class="fa-solid fa-clock-rotate-left"></i></span>
                  <div>
                    <div class="pm-info-label">Last Updated</div>
                    <div class="pm-info-value" id="rdInfoUpdatedDate">-</div>
                  </div>
                </div>
                <div class="pm-info-item">
                  <span class="pm-info-icon"><i class="fa-solid fa-code-branch"></i></span>
                  <div>
                    <div class="pm-info-label">Version</div>
                    <div class="pm-info-value" id="rdInfoVersion">-</div>
                  </div>
                </div>
                <div class="pm-info-item">
                  <span class="pm-info-icon"><i class="fa-solid fa-user"></i></span>
                  <div>
                    <div class="pm-info-label">Owner</div>
                    <div class="pm-info-value" id="rdInfoOwner">-</div>
                  </div>
                </div>
              </div>
            </div>

            <div class="pm-card">
              <div class="pm-card-header">
                <div>
                  <h3>Manage This Resume</h3>
                  <p>Download, replace or remove your uploaded resume</p>
                </div>
              </div>
              <div class="quick-actions-grid">
                <button type="button" class="quick-action-btn" id="rdPreviewDownloadBtn"><i class="fa-solid fa-download"></i> Download Resume</button>
                <a href="upload-resume.html?mode=replace" class="quick-action-btn"><i class="fa-solid fa-rotate"></i> Replace Resume</a>
                <button type="button" class="quick-action-btn" id="rdPreviewDeleteBtn" style="color:#ef4444;"><i class="fa-solid fa-trash"></i> Delete Resume</button>
                <a href="certificates-documents.html" class="quick-action-btn"><i class="fa-solid fa-award"></i> Certificates &amp; Documents</a>
              </div>
            </div>
          </div>

        </div>
      </div>

      <!-- Shown when no resume exists -->
      <div id="rdEmptyContent" style="display:none;">
        <div class="rd-empty-resume">
          <i class="fa-solid fa-file-circle-xmark"></i>
          <h3>No Resume Uploaded Yet</h3>
          <p>You haven't uploaded a resume to your SIMS profile. Upload one now so recruiters can view it while you apply for internships.</p>
          <a href="upload-resume.html" class="btn btn-primary"><i class="fa-solid fa-cloud-arrow-up"></i> Upload Resume</a>
        </div>
      </div>


   

<!-- Delete confirmation modal -->
<div class="modal-overlay" id="rdDeleteModalOverlay">
  <div class="modal-box" style="max-width:380px; text-align:center;">
    <div class="modal-icon icon-red"><i class="fa-solid fa-trash"></i></div>
    <h3 class="modal-title">Delete Resume?</h3>
    <p class="modal-sub">This will permanently remove <strong id="rdDeleteFileName">your resume</strong> from your SIMS profile. This action cannot be undone.</p>
    <div style="display:flex; gap:12px;">
      <button type="button" class="btn btn-ghost" id="rdDeleteNoBtn" style="flex:1; justify-content:center;">Cancel</button>
      <button type="button" class="btn btn-primary" id="rdDeleteYesBtn" style="flex:1; justify-content:center; background:linear-gradient(135deg,#ef4444,#dc2626); box-shadow:0 4px 14px rgba(239,68,68,.3);">Yes, Delete</button>
    </div>
  </div>
</div>

<!-- Logout confirmation modal -->
<div class="modal-overlay" id="logoutModalOverlay">
  <div class="modal-box" style="max-width:380px; text-align:center;">
    <div class="modal-icon icon-red"><i class="fa-solid fa-right-from-bracket"></i></div>
    <h3 class="modal-title">Logout Confirmation</h3>
    <p class="modal-sub">Are you sure you want to logout from SIMS Student Dashboard?</p>
    <div style="display:flex; gap:12px;">
      <button type="button" class="btn btn-ghost" id="logoutNoBtn" style="flex:1; justify-content:center;">No, Stay</button>
      <button type="button" class="btn btn-primary" id="logoutYesBtn" style="flex:1; justify-content:center;">Yes, Logout</button>
    </div>
  </div>
</div>

<!-- Toast notification -->
<div class="login-toast" id="dashToast">
  <i class="fa-solid fa-circle-check"></i>
  <span id="dashToastMsg">Done!</span>
</div>

<script src="../js/global-store.js"></script>
<script src="../js/student-layout.js"></script>
<script src="../js/profile-shared.js"></script>
<script src="../js/resume-shared.js"></script>
<script src="../js/resume-preview.js"></script>
</asp:Content>


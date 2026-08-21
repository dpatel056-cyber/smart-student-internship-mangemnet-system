<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="upload-resume.aspx.cs" Inherits="asp.net.upload_resume" %>
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
        <a href="student-dashboard.aspx">Dashboard</a>
        <i class="fa-solid fa-chevron-right"></i>
        <a href="resume-dashboard.aspx">Resume &amp; Documents</a>
        <i class="fa-solid fa-chevron-right"></i>
        <span class="current" id="uploadBreadcrumbCurrent">Upload Resume</span>
      </div>

      <div class="pm-card">
        <div class="pm-card-header">
          <div>
            <h3 id="uploadCardTitle">Upload Your Resume</h3>
            <p>PDF format only &middot; Maximum file size 5 MB</p>
          </div>
        </div>

        <!-- Drag & Drop zone -->
        <div class="rd-dropzone" id="rdDropzone">
          <div class="rd-dropzone-icon"><i class="fa-solid fa-cloud-arrow-up"></i></div>
          <h3 id="rdDropzoneTitle">Drag &amp; drop your resume here</h3>
          <p>or <span class="rd-browse-link" id="rdBrowseLink">browse from your device</span> to upload</p>
          <input type="file" id="rdFileInput" accept="application/pdf,.pdf" hidden>
        </div>

        <div class="rd-upload-rules">
          <div class="rd-upload-rule"><i class="fa-solid fa-circle-check"></i> Only PDF files are allowed</div>
          <div class="rd-upload-rule"><i class="fa-solid fa-circle-check"></i> Maximum file size: 5 MB</div>
          <div class="rd-upload-rule"><i class="fa-solid fa-circle-check"></i> File name should include your full name</div>
        </div>

        <!-- Selected file preview -->
        <div class="rd-file-row" id="rdFileRow" style="display:none;">
          <div class="rd-file-icon"><i class="fa-solid fa-file-pdf"></i></div>
          <div class="rd-file-info">
            <div class="rd-file-name" id="rdFileName">-</div>
            <div class="rd-file-size" id="rdFileSize">-</div>
          </div>
          <button type="button" class="rd-file-remove" id="rdFileRemoveBtn" aria-label="Remove file"><i class="fa-solid fa-xmark"></i></button>
        </div>

        <!-- Upload progress -->
        <div class="rd-progress-wrap" id="rdProgressWrap">
          <div class="rd-progress-top">
            <span>Uploading&hellip;</span>
            <strong id="rdProgressPercent">0%</strong>
          </div>
          <div class="rd-progress-track">
            <div class="rd-progress-fill" id="rdProgressFill"></div>
          </div>
        </div>

        <div class="rd-upload-actions">
          <a href="resume-dashboard.html" class="btn btn-ghost">Cancel</a>
          <button type="button" class="btn btn-primary" id="rdUploadBtn" disabled><i class="fa-solid fa-cloud-arrow-up"></i> <span id="rdUploadBtnLabel">Upload Resume</span></button>
        </div>
      </div>

   
<!-- Success popup -->
<div class="modal-overlay" id="rdSuccessModalOverlay">
  <div class="modal-box" style="max-width:400px; text-align:center;">
    <div class="modal-icon icon-green"><i class="fa-solid fa-circle-check"></i></div>
    <h3 class="modal-title" id="rdSuccessTitle">Resume Uploaded Successfully!</h3>
    <p class="modal-sub" id="rdSuccessSub">Your resume is now visible to recruiters on your SIMS profile.</p>
    <div style="display:flex; gap:12px;">
      <a href="resume-dashboard.aspx" class="btn btn-ghost" style="flex:1; justify-content:center;">Back to Dashboard</a>
      <a href="resume-preview.aspx" class="btn btn-primary" style="flex:1; justify-content:center;">View Resume</a>
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
<script src="../js/upload-resume.js"></script>


</asp:Content>


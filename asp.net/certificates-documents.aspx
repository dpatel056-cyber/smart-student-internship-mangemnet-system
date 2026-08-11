<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="certificates-documents.aspx.cs" Inherits="asp.net.certificates_documents" %>
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
   <span class="current">Certificates &amp; Documents</span>
 </div>

 <div class="pm-card">

   <!-- Tabs + toolbar -->
   <div class="pm-tabs" id="rdDocTabs">
     <button type="button" class="pm-tab-btn active" data-filter="all">All Documents <span class="pm-tab-count" id="countAll">0</span></button>
     <button type="button" class="pm-tab-btn" data-filter="certificate">Certificates <span class="pm-tab-count" id="countCertificate">0</span></button>
     <button type="button" class="pm-tab-btn" data-filter="academic">Academic Documents <span class="pm-tab-count" id="countAcademic">0</span></button>
   </div>

   <div class="rd-doc-toolbar">
     <div class="pm-search-box">
       <i class="fa-solid fa-magnifying-glass"></i>
       <input type="text" id="rdDocSearchInput" placeholder="Search by title or issuer&hellip;">
     </div>
     <div class="rd-doc-toolbar-actions">
       <button type="button" class="btn btn-ghost" id="uploadCertificateBtn"><i class="fa-solid fa-award"></i> Upload Certificate</button>
       <button type="button" class="btn btn-primary" id="uploadAcademicBtn"><i class="fa-solid fa-graduation-cap"></i> Upload Academic Documents</button>
     </div>
   </div>

   <!-- Document grid -->
   <div class="rd-doc-grid" id="rdDocGrid"></div>

   <!-- Empty state -->
   <div class="pm-empty-state" id="rdDocEmptyState" style="display:none;">
     <i class="fa-solid fa-folder-open"></i>
     <p>No documents found. Try a different search or upload a new document.</p>
   </div>

 </div>

    
   
<!-- Upload document modal (handles both Certificate + Academic Document, single or multiple files) -->
<div class="modal-overlay" id="rdDocModalOverlay">
  <div class="modal-box" style="max-width:520px; text-align:left;">
    <button type="button" class="modal-close" id="rdDocModalCloseBtn"><i class="fa-solid fa-xmark"></i></button>
    <h3 class="modal-title" id="rdDocModalTitle" style="text-align:left; margin-bottom:4px;">Upload Certificate</h3>
    <p class="modal-sub" style="text-align:left; margin-bottom:20px;">Fill in the details below. PDF, JPG or PNG &middot; Max 5 MB per file.</p>

    <div class="rd-radio-cards">
      <label class="rd-radio-card" id="rdCatCertificateCard">
        <input type="radio" name="rdDocCategory" value="certificate" id="rdCatCertificate">
        <span><i class="fa-solid fa-award" style="margin-right:6px;"></i> Certificate</span>
      </label>
      <label class="rd-radio-card" id="rdCatAcademicCard">
        <input type="radio" name="rdDocCategory" value="academic" id="rdCatAcademic">
        <span><i class="fa-solid fa-graduation-cap" style="margin-right:6px;"></i> Academic Document</span>
      </label>
    </div>

    <div class="pm-form-group">
      <label for="rdDocTitleInput">Title <span class="pm-optional">(required)</span></label>
      <input type="text" id="rdDocTitleInput" placeholder="e.g. AWS Cloud Practitioner">
      <div class="pm-field-error" id="rdDocTitleError">Please enter a title.</div>
    </div>

    <div class="pm-form-row">
      <div class="pm-form-group">
        <label for="rdDocIssuerInput">Issuer / Organization <span class="pm-optional">(optional)</span></label>
        <input type="text" id="rdDocIssuerInput" placeholder="e.g. Amazon Web Services">
      </div>
      <div class="pm-form-group">
        <label for="rdDocDateInput">Date <span class="pm-optional">(optional)</span></label>
        <input type="date" id="rdDocDateInput">
      </div>
    </div>

    <div class="pm-form-group pm-full">
      <label for="rdDocFileInput">Select File(s)</label>
      <input type="file" id="rdDocFileInput" accept="application/pdf,.pdf,image/png,image/jpeg" multiple>
      <div class="pm-field-hint" id="rdDocFileHint">You can select multiple files at once for academic documents.</div>
      <div class="pm-field-error" id="rdDocFileError">Please select at least one valid file (PDF/JPG/PNG, under 5 MB).</div>
    </div>

    <div id="rdDocFileList" style="display:flex; flex-direction:column; gap:8px; margin-bottom:6px;"></div>

    <div class="pm-form-actions">
      <button type="button" class="btn btn-ghost" id="rdDocCancelBtn">Cancel</button>
      <button type="button" class="btn btn-primary" id="rdDocSaveBtn"><i class="fa-solid fa-cloud-arrow-up"></i> Upload</button>
    </div>
  </div>
</div>

<!-- View document modal -->
<div class="modal-overlay" id="rdDocViewModalOverlay">
  <div class="modal-box" style="max-width:420px; text-align:center;">
    <button type="button" class="modal-close" id="rdDocViewCloseBtn"><i class="fa-solid fa-xmark"></i></button>
    <div class="modal-icon icon-blue"><i class="fa-solid fa-file-pdf"></i></div>
    <h3 class="modal-title" id="rdDocViewTitle">Document</h3>
    <p class="modal-sub" id="rdDocViewSub">Details</p>
    <div style="display:flex; gap:12px;">
      <button type="button" class="btn btn-ghost" id="rdDocViewCloseBtn2" style="flex:1; justify-content:center;">Close</button>
      <button type="button" class="btn btn-primary" id="rdDocViewDownloadBtn" style="flex:1; justify-content:center;"><i class="fa-solid fa-download"></i> Download</button>
    </div>
  </div>
</div>

<!-- Delete document confirmation -->
<div class="modal-overlay" id="rdDocDeleteModalOverlay">
  <div class="modal-box" style="max-width:380px; text-align:center;">
    <div class="modal-icon icon-red"><i class="fa-solid fa-trash"></i></div>
    <h3 class="modal-title">Delete Document?</h3>
    <p class="modal-sub">This will permanently remove <strong id="rdDocDeleteName">this document</strong>. This action cannot be undone.</p>
    <div style="display:flex; gap:12px;">
      <button type="button" class="btn btn-ghost" id="rdDocDeleteNoBtn" style="flex:1; justify-content:center;">Cancel</button>
      <button type="button" class="btn btn-primary" id="rdDocDeleteYesBtn" style="flex:1; justify-content:center; background:linear-gradient(135deg,#ef4444,#dc2626); box-shadow:0 4px 14px rgba(239,68,68,.3);">Yes, Delete</button>
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

<%--<script src="../js/global-store.js"></script>
<script src="../js/student-layout.js"></script>
<script src="../js/profile-shared.js"></script>
<script src="../js/resume-shared.js"></script>
<script src="../js/certificates-documents.js"></script>--%>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="resume-dashboard.aspx.cs" Inherits="asp.net.resume_dashboard" %>
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
        <span class="current">Resume &amp; Documents</span>
      </div>

      <!-- Resume status hero -->
      <div class="rd-hero">
        <div class="rd-hero-left">
          <div class="rd-hero-icon"><i class="fa-solid fa-file-lines"></i></div>
          <div>
            <h2 id="rdHeroTitle">Loading your resume status&hellip;</h2>
            <p id="rdHeroSub">Please wait a moment.</p>
          </div>
        </div>
        <div class="rd-hero-right">
          <div style="margin-bottom:10px;"><span class="rd-status-pill" id="rdHeroStatusPill"><i class="fa-solid fa-circle-notch"></i> Checking&hellip;</span></div>
          <a href="upload-resume.html" class="btn btn-primary" id="rdHeroActionBtn"><i class="fa-solid fa-cloud-arrow-up"></i> Upload Resume</a>
        </div>
      </div>

      <!-- Action cards -->
      <div class="rd-card-grid">

        <div class="rd-action-card">
          <div class="rd-action-icon icon-blue"><i class="fa-solid fa-cloud-arrow-up"></i></div>
          <h3>Upload Resume</h3>
          <p>Add your resume as a PDF so recruiters and the placement cell can review it during internship applications.</p>
          <a href="upload-resume.aspx" class="btn btn-primary">Upload Now</a>
        </div>

        <div class="rd-action-card">
          <div class="rd-action-icon icon-purple"><i class="fa-solid fa-file-pdf"></i></div>
          <h3>Resume Preview</h3>
          <p>Preview your uploaded resume exactly as recruiters will see it, along with file details and version history.</p>
          <a href="resume-preview.aspx" class="btn btn-ghost">Preview Resume</a>
        </div>

        <div class="rd-action-card">
          <div class="rd-action-icon icon-green"><i class="fa-solid fa-download"></i></div>
          <h3>Download Resume</h3>
          <p>Download a copy of your currently uploaded resume to your device anytime you need it.</p>
          <button type="button" class="btn btn-ghost" id="rdDownloadBtn">Download</button>
        </div>

        <div class="rd-action-card">
          <div class="rd-action-icon icon-orange"><i class="fa-solid fa-rotate"></i></div>
          <h3>Replace Resume</h3>
          <p>Uploaded an outdated version? Replace your existing resume with an updated PDF in just a few clicks.</p>
          <a href="upload-resume.aspx?mode=replace" class="btn btn-ghost">Replace</a>
        </div>

        <div class="rd-action-card">
          <div class="rd-action-icon icon-red"><i class="fa-solid fa-trash"></i></div>
          <h3>Delete Resume</h3>
          <p>Permanently remove your resume from SIMS. You can always upload a new one later.</p>
          <button type="button" class="btn btn-danger" id="rdDeleteBtn">Delete Resume</button>
        </div>

        <div class="rd-action-card">
          <div class="rd-action-icon icon-blue"><i class="fa-solid fa-circle-info"></i></div>
          <h3>Resume Status</h3>
          <p id="rdStatusCardText">Checking your current resume status&hellip;</p>
          <span class="pm-resume-status" id="rdStatusCardPill"><i class="fa-solid fa-circle-notch"></i> Checking</span>
        </div>

      </div>

      <!-- Certificates & Internship certificate quick links -->
      <div class="pm-card">
        <div class="pm-card-header">
          <div>
            <h3>Certificates &amp; Documents</h3>
            <p>Manage internship certificates, achievement certificates and academic documents</p>
          </div>
        </div>
        <div class="quick-actions-grid">
          <a href="certificates-documents.html" class="quick-action-btn"><i class="fa-solid fa-award"></i> Certificates &amp; Documents</a>
          <a href="internship-certificate.html" class="quick-action-btn"><i class="fa-solid fa-certificate"></i> Internship Certificate</a>
          <a href="my-profile.html" class="quick-action-btn"><i class="fa-solid fa-user"></i> Back to My Profile</a>
          <a href="student-dashboard.html" class="quick-action-btn"><i class="fa-solid fa-house"></i> Back to Dashboard</a>
        </div>
      </div>
</asp:Content>

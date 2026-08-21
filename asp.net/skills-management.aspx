<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="skills-management.aspx.cs" Inherits="asp.net.skills_management" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/profile-module.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="pm-breadcrumb">
   <a href="student-dashboard.aspx">Dashboard</a>
   <i class="fa-solid fa-chevron-right"></i>
   <a href="my-profile.aspx">My Profile</a>
   <i class="fa-solid fa-chevron-right"></i>
   <span class="current">Skills Management</span>
 </div>

 <div class="pm-card">
   <div class="pm-card-header">
     <div>
       <h3>Your Skills</h3>
       <p id="skillsCountLabel">0 skills added</p>
     </div>
   </div>

   <div class="pm-skills-toolbar">
     <div class="pm-search-box">
       <i class="fa-solid fa-magnifying-glass"></i>
       <input type="text" id="skillSearchInput" placeholder="Search skills...">
     </div>
     <button type="button" class="btn btn-primary" id="addSkillBtn"><i class="fa-solid fa-plus"></i> Add Skill</button>
   </div>

   <div class="pm-tags-wrap" id="skillsWrap"></div>

   <div class="pm-empty-state" id="skillsEmptyState" style="display:none;">
     <i class="fa-solid fa-code"></i>
     <p>No skills found. Try a different search or add a new skill.</p>
   </div>
 </div>
 



<!-- Add / Edit skill modal -->
<div class="modal-overlay" id="skillModalOverlay">
  <div class="modal-box" style="max-width:400px;">
    <button type="button" class="modal-close" id="skillModalCloseBtn"><i class="fa-solid fa-xmark"></i></button>
    <div class="modal-icon icon-blue"><i class="fa-solid fa-code"></i></div>
    <h3 class="modal-title" id="skillModalTitle">Add Skill</h3>
    <p class="modal-sub">Add a technology, tool or soft skill to showcase on your profile.</p>
    <div class="pm-form-group">
      <label for="skillNameInput">Skill Name</label>
      <input type="text" id="skillNameInput" placeholder="e.g. Python, Communication, Figma">
      <div class="pm-field-error" id="skillNameError">Please enter a skill name.</div>
    </div>
    <div style="display:flex; gap:12px;">
      <button type="button" class="btn btn-ghost" id="skillCancelBtn" style="flex:1; justify-content:center;">Cancel</button>
      <button type="button" class="btn btn-primary" id="skillSaveBtn" style="flex:1; justify-content:center;">Save Skill</button>
    </div>
  </div>
</div>

<!-- Delete skill confirmation modal -->
<div class="modal-overlay" id="deleteSkillModalOverlay">
  <div class="modal-box" style="max-width:380px; text-align:center;">
    <div class="modal-icon icon-red"><i class="fa-solid fa-trash"></i></div>
    <h3 class="modal-title">Remove Skill?</h3>
    <p class="modal-sub">Are you sure you want to remove "<strong id="deleteSkillName">this skill</strong>" from your profile?</p>
    <div style="display:flex; gap:12px;">
      <button type="button" class="btn btn-ghost" id="deleteSkillNoBtn" style="flex:1; justify-content:center;">Cancel</button>
      <button type="button" class="btn btn-primary" id="deleteSkillYesBtn" style="flex:1; justify-content:center; background:linear-gradient(135deg,#ef4444,#dc2626);">Remove</button>
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
<script src="../js/skills-management.js"></script>

</asp:Content>


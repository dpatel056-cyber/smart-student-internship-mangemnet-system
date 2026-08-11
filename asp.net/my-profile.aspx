<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="my-profile.aspx.cs" Inherits="asp.net.my_profile" %>
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
   <span class="current" class="sidebar-link">My Profile</span>
 </div>

 <div class="pm-profile-layout">

   <!-- ============ LEFT: Profile summary card ============ -->
   <div class="pm-profile-card">
     <div class="pm-avatar-wrap">
       <div class="pm-avatar-lg" id="pmAvatarLg">AP</div>
     </div>
     <h2 id="pmName">Student</h2>
     <span class="pm-enrollment" id="pmEnrollment">ENR2024001</span>
     <div class="pm-course-line" id="pmCourseLine">B.Tech, Computer Engineering</div>
     <div class="pm-college-line" id="pmCollegeLine">L.D. College of Engineering</div>

     <div class="pm-mini-completion">
       <div class="pm-mini-completion-top">
         <span>Profile Completion</span>
         <strong id="pmMiniPercent">0%</strong>
       </div>
       <div class="pm-progress-track" style="height:9px;">
         <div class="pm-progress-fill" id="pmMiniBar" style="width:0%;"></div>
       </div>
       <a href="profile-completion.aspx">View Details <i class="fa-solid fa-arrow-right"></i></a>
     </div>

     <div class="pm-card-btns">
       <a href="edit-profile.aspx" class="btn btn-primary"><i class="fa-solid fa-user-pen"></i> Edit Profile</a>
       <button type="button" class="btn btn-ghost" id="viewResumeBtn"><i class="fa-solid fa-file-lines"></i> View Resume</button>
     </div>
   </div>

   <!-- ============ RIGHT: Details ============ -->
   <div>
     <div class="pm-card">
       <div class="pm-card-header">
         <div>
           <h3>Personal &amp; Academic Details</h3>
           <p>Information visible to recruiters and placement cell</p>
         </div>
       </div>

       <div class="pm-info-grid">
         <div class="pm-info-item">
           <span class="pm-info-icon"><i class="fa-solid fa-envelope"></i></span>
           <div>
             <div class="pm-info-label">Email</div>
             <div class="pm-info-value" id="pmEmail">student@sims.com</div>
           </div>
         </div>
         <div class="pm-info-item">
           <span class="pm-info-icon"><i class="fa-solid fa-phone"></i></span>
           <div>
             <div class="pm-info-label">Mobile Number</div>
             <div class="pm-info-value" id="pmMobile">+91 98765 43210</div>
           </div>
         </div>
         <div class="pm-info-item">
           <span class="pm-info-icon"><i class="fa-solid fa-building-columns"></i></span>
           <div>
             <div class="pm-info-label">Department</div>
             <div class="pm-info-value" id="pmDepartment">Computer Engineering</div>
           </div>
         </div>
         <div class="pm-info-item">
           <span class="pm-info-icon"><i class="fa-solid fa-book"></i></span>
           <div>
             <div class="pm-info-label">Course</div>
             <div class="pm-info-value" id="pmCourse">B.Tech</div>
           </div>
         </div>
         <div class="pm-info-item">
           <span class="pm-info-icon"><i class="fa-solid fa-layer-group"></i></span>
           <div>
             <div class="pm-info-label">Semester</div>
             <div class="pm-info-value" id="pmSemester">6th Semester</div>
           </div>
         </div>
         <div class="pm-info-item">
           <span class="pm-info-icon"><i class="fa-solid fa-school"></i></span>
           <div>
             <div class="pm-info-label">College Name</div>
             <div class="pm-info-value" id="pmCollege">L.D. College of Engineering</div>
           </div>
         </div>
         <div class="pm-info-item pm-info-full">
           <span class="pm-info-icon"><i class="fa-solid fa-location-dot"></i></span>
           <div>
             <div class="pm-info-label">Address</div>
             <div class="pm-info-value" id="pmAddress">Not added yet</div>
           </div>
         </div>
         <div class="pm-info-item">
           <span class="pm-info-icon"><i class="fa-solid fa-file-lines"></i></span>
           <div>
             <div class="pm-info-label">Resume Status</div>
             <div class="pm-info-value"><span class="pm-resume-status" id="pmResumeStatus"><i class="fa-solid fa-circle-check"></i> Uploaded</span></div>
           </div>
         </div>
         <div class="pm-info-item">
           <span class="pm-info-icon"><i class="fa-solid fa-chart-simple"></i></span>
           <div>
             <div class="pm-info-label">Profile Completion</div>
             <div class="pm-info-value" id="pmCompletionValue">0% Complete</div>
           </div>
         </div>
         <div class="pm-info-item pm-info-full">
           <span class="pm-info-icon"><i class="fa-solid fa-code"></i></span>
           <div>
             <div class="pm-info-label">Skills</div>
             <div class="pm-skills-inline" id="pmSkillsInline"></div>
           </div>
         </div>
       </div>
     </div>

     <!-- Quick links into the other Module 2 pages -->
     <div class="pm-card">
       <div class="pm-card-header">
         <div>
           <h3>Manage Your Profile</h3>
           <p>Jump straight to a section</p>
         </div>
       </div>
       <div class="quick-actions-grid">
         <a href="edit-profile.aspx" class="quick-action-btn"><i class="fa-solid fa-user-pen"></i> Edit Profile</a>
         <a href="skills-management.aspx" class="quick-action-btn"><i class="fa-solid fa-code"></i> Manage Skills</a>
         <a href="education-details.aspx" class="quick-action-btn"><i class="fa-solid fa-graduation-cap"></i> Education Details</a>
         <a href="experience-projects.aspx" class="quick-action-btn"><i class="fa-solid fa-briefcase"></i> Experience &amp; Projects</a>
         <a href="saved-internships.aspx" class="quick-action-btn"><i class="fa-solid fa-bookmark"></i> Saved Internships</a>
         <a href="change-password.aspx" class="quick-action-btn"><i class="fa-solid fa-shield-halved"></i> Change Password</a>
       </div>
     </div>
   </div>

 </div>

</asp:Content>

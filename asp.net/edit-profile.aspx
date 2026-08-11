<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="edit-profile.aspx.cs" Inherits="asp.net.edit_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/profile-module.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="pm-breadcrumb">
   <a href="student-dashboard.html">Dashboard</a>
   <i class="fa-solid fa-chevron-right"></i>
   <a href="my-profile.aspx">My Profile</a>
   <i class="fa-solid fa-chevron-right"></i>
   <span class="current">Edit Profile</span>
 </div>

 <form id="editProfileForm" class="pm-card" novalidate>

   <!-- Photo upload -->
   <div class="pm-section-title"><i class="fa-solid fa-image"></i> Profile Photo</div>
   <div class="pm-photo-upload">
     <div class="pm-photo-preview" id="pmPhotoPreview">AP</div>
     <div class="pm-photo-actions">
       <label class="btn btn-ghost" for="photoInput" style="cursor:pointer;"><i class="fa-solid fa-upload"></i> Change Photo</label>
       <input type="file" id="photoInput" accept="image/*" style="display:none;">
       <button type="button" class="btn btn-ghost" id="removePhotoBtn" style="color:#ef4444;"><i class="fa-solid fa-trash"></i> Remove</button>
       <span class="pm-photo-hint">JPG or PNG, max 2MB. Square image recommended.</span>
     </div>
   </div>

   <!-- Personal info -->
   <div class="pm-section-title"><i class="fa-solid fa-id-card"></i> Personal Information</div>
   <div class="pm-form-row">
     <div class="pm-form-group">
       <label for="fullNameInput">Full Name</label>
       <input type="text" id="fullNameInput" placeholder="Enter your full name">
       <div class="pm-field-error" id="fullNameError">Full name is required.</div>
     </div>
     <div class="pm-form-group">
       <label for="enrollmentInput">Enrollment Number</label>
       <input type="text" id="enrollmentInput" placeholder="Enter your enrollment number">
     </div>
     <div class="pm-form-group">
       <label for="emailInput">Email</label>
       <input type="email" id="emailInput" placeholder="you@example.com">
       <div class="pm-field-error" id="emailError">Enter a valid email address.</div>
     </div>
     <div class="pm-form-group">
       <label for="mobileInput">Mobile Number</label>
       <input type="tel" id="mobileInput" placeholder="+91 98765 43210">
       <div class="pm-field-error" id="mobileError">Enter a valid 10-digit mobile number.</div>
     </div>
     <div class="pm-form-group pm-full">
       <label for="addressInput">Address</label>
       <textarea id="addressInput" placeholder="House no., street, city, state, PIN code"></textarea>
     </div>
   </div>

   <!-- Academic info -->
   <div class="pm-section-title"><i class="fa-solid fa-building-columns"></i> Academic Information</div>
   <div class="pm-form-row">
     <div class="pm-form-group">
       <label for="departmentInput">Department</label>
       <select id="departmentInput">
         <option value="Computer Engineering">Computer Engineering</option>
         <option value="Information Technology">Information Technology</option>
         <option value="Electronics &amp; Communication">Electronics &amp; Communication</option>
         <option value="Mechanical Engineering">Mechanical Engineering</option>
         <option value="Civil Engineering">Civil Engineering</option>
         <option value="Electrical Engineering">Electrical Engineering</option>
       </select>
     </div>
     <div class="pm-form-group">
       <label for="courseInput">Course</label>
       <select id="courseInput">
         <option value="B.Tech">B.Tech</option>
         <option value="B.E.">B.E.</option>
         <option value="Diploma">Diploma</option>
         <option value="M.Tech">M.Tech</option>
         <option value="MCA">MCA</option>
         <option value="BCA">BCA</option>
       </select>
     </div>
     <div class="pm-form-group">
       <label for="semesterInput">Semester</label>
       <select id="semesterInput">
         <option>1st Semester</option>
         <option>2nd Semester</option>
         <option>3rd Semester</option>
         <option>4th Semester</option>
         <option>5th Semester</option>
         <option>6th Semester</option>
         <option>7th Semester</option>
         <option>8th Semester</option>
       </select>
     </div>
     <div class="pm-form-group">
       <label for="collegeInput">College Name</label>
       <input type="text" id="collegeInput" placeholder="Enter college name">
     </div>
   </div>

   <!-- Additional info -->
   <div class="pm-section-title"><i class="fa-solid fa-circle-info"></i> Additional Information</div>
   <div class="pm-form-row">
     <div class="pm-form-group">
       <label for="dobInput">Date of Birth</label>
       <input type="date" id="dobInput">
     </div>
     <div class="pm-form-group">
       <label for="genderInput">Gender</label>
       <select id="genderInput">
         <option value="">Select Gender</option>
         <option value="Male">Male</option>
         <option value="Female">Female</option>
         <option value="Other">Other</option>
         <option value="Prefer not to say">Prefer not to say</option>
       </select>
     </div>
     <div class="pm-form-group">
       <label for="linkedinInput">LinkedIn <span class="pm-optional">(optional)</span></label>
       <input type="url" id="linkedinInput" placeholder="https://linkedin.com/in/username">
     </div>
     <div class="pm-form-group">
       <label for="githubInput">GitHub <span class="pm-optional">(optional)</span></label>
       <input type="url" id="githubInput" placeholder="https://github.com/username">
     </div>
   </div>

   <div class="pm-form-actions">
     <button type="button" class="btn btn-ghost" id="cancelEditBtn">Cancel</button>
     <button type="submit" class="btn btn-primary" id="saveChangesBtn"><i class="fa-solid fa-check"></i> Save Changes</button>
   </div>
 </form>
</asp:Content>

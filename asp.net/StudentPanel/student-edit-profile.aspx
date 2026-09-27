<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeFile="student-edit-profile.aspx.cs" Inherits="asp.net.js.student_edit_profile" %>
<asp:Content ID="HeadContentEditProfile" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/student-edit-profile.css") %>" />
</asp:Content>
<asp:Content ID="MainContentEditProfile" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<section class="student-edit-page" aria-labelledby="editProfileTitle">
  <header class="edit-page-header">
      <div>

          <h1 id="editProfileTitle">Edit Profile</h1>
          <p>Keep your personal and academic details up to date.</p>
      </div>
      <asp:HyperLink ID="hlBackToProfile" runat="server" NavigateUrl="~/StudentPanel/student-profile.aspx" CssClass="edit-btn edit-btn-secondary">
          <i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Back to Profile
      </asp:HyperLink>
  </header>

  <div class="edit-form-stack">

    <!-- Personal Information Card -->
    <article class="edit-card">
      <header class="edit-card-header">
          <div>
              <h2><i class="fa-solid fa-user"></i>Personal Information</h2>
              <p>Manage your basic and professional personal details</p>
          </div>
      </header>

      <!-- Profile Photo Upload -->
      <div class="photo-upload-row">
          <div class="photo-preview-wrap">
              <asp:Image ID="imgProfilePreview" runat="server" ImageUrl="~/Assets/Images/students/default-avatar.png" AlternateText="Profile photo preview" CssClass="photo-preview" />
          </div>
          <div class="photo-upload-copy">
              <h3>Profile Photo</h3>
              <p>Use a clear JPG, PNG or WebP image up to 2 MB.</p>
              <label class="photo-upload-trigger" for="<%= fileProfilePhoto.ClientID %>">
                  <i class="fa-solid fa-camera" aria-hidden="true"></i> Choose photo
              </label>
              <asp:FileUpload ID="fileProfilePhoto" runat="server" CssClass="file-input-hidden" accept="image/png,image/jpeg,image/webp" />
          </div>
      </div>

      <!-- 1. Basic Information -->
      <div class="edit-section-subtitle">
          <i class="fa-solid fa-id-card" aria-hidden="true"></i> Basic Information
      </div>
      <div class="field-grid">
        <div class="form-field">
            <asp:Label ID="lblFullNameField" runat="server" AssociatedControlID="txtFullName" CssClass="field-label">FULL NAME <span>*</span></asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-user" aria-hidden="true"></i>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-input" placeholder="Enter full name" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblDateOfBirthField" runat="server" AssociatedControlID="txtDateOfBirth" CssClass="field-label">DATE OF BIRTH</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-calendar-days" aria-hidden="true"></i>
                <asp:TextBox ID="txtDateOfBirth" runat="server" TextMode="Date" CssClass="form-input" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblGenderField" runat="server" AssociatedControlID="ddlGender" CssClass="field-label">GENDER</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-venus-mars" aria-hidden="true"></i>
                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-input form-select">
                    <asp:ListItem Text="Select Gender" Value="" />
                    <asp:ListItem Text="Female" Value="Female" />
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Other" Value="Other" />
                </asp:DropDownList>
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblEmailAddressField" runat="server" AssociatedControlID="txtEmailAddress" CssClass="field-label">EMAIL ADDRESS <span>*</span></asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-envelope" aria-hidden="true"></i>
                <asp:TextBox ID="txtEmailAddress" runat="server" TextMode="Email" CssClass="form-input" placeholder="you@example.com" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblContactNumberField" runat="server" AssociatedControlID="txtContactNumber" CssClass="field-label">CONTACT NUMBER <span>*</span></asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-phone" aria-hidden="true"></i>
                <asp:TextBox ID="txtContactNumber" runat="server" CssClass="form-input" placeholder="Enter contact number" />
            </div>
        </div>
        
      </div>

      <!-- 2. Address Information -->
      <div class="edit-section-subtitle">
          <i class="fa-solid fa-location-dot" aria-hidden="true"></i> Address Information
      </div>
      <div class="field-grid">
        <div class="form-field">
            <asp:Label ID="lblAddressField" runat="server" AssociatedControlID="txtAddress" CssClass="field-label">ADDRESS</asp:Label>
            <div class="input-shell textarea-shell">
                <i class="fa-solid fa-house" aria-hidden="true"></i>
                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-input form-textarea" placeholder="Enter full address" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblCityField" runat="server" AssociatedControlID="txtCity" CssClass="field-label">CITY</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-city" aria-hidden="true"></i>
                <asp:TextBox ID="txtCity" runat="server" CssClass="form-input" placeholder="Enter city" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblStateField" runat="server" AssociatedControlID="txtState" CssClass="field-label">STATE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-map" aria-hidden="true"></i>
                <asp:TextBox ID="txtState" runat="server" CssClass="form-input" placeholder="Enter state" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblPincodeField" runat="server" AssociatedControlID="txtPincode" CssClass="field-label">PINCODE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-map-pin" aria-hidden="true"></i>
                <asp:TextBox ID="txtPincode" runat="server" CssClass="form-input" placeholder="Enter pincode" />
            </div>
        </div>
      </div>

      <!-- 3. About Me -->
      <div class="edit-section-subtitle">
          <i class="fa-solid fa-user-pen" aria-hidden="true"></i> About Me
      </div>
      <div class="field-grid">
        <div class="form-field field-wide">
            <div class="input-shell textarea-shell">
                <i class="fa-solid fa-align-left" aria-hidden="true"></i>
                <asp:TextBox ID="txtAboutMe" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-input form-textarea" placeholder="Write a short introduction about yourself..." />
            </div>
        </div>
      </div>

      <!-- 4. Internship Preferences -->
      <div class="edit-section-subtitle">
          <i class="fa-solid fa-briefcase" aria-hidden="true"></i> Internship Preferences
      </div>
      <div class="field-grid">
        <div class="form-field">
            <asp:Label ID="lblPreferredDomainField" runat="server" AssociatedControlID="txtPreferredDomain" CssClass="field-label">PREFERRED DOMAIN</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-layer-group" aria-hidden="true"></i>
                <asp:TextBox ID="txtPreferredDomain" runat="server" CssClass="form-input" placeholder="e.g. Web Development" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblPreferredRoleField" runat="server" AssociatedControlID="txtPreferredRole" CssClass="field-label">PREFERRED ROLE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-user-gear" aria-hidden="true"></i>
                <asp:TextBox ID="txtPreferredRole" runat="server" CssClass="form-input" placeholder="e.g. Full Stack Developer" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblPreferredLocationField" runat="server" AssociatedControlID="txtPreferredLocation" CssClass="field-label">PREFERRED LOCATION</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-location-arrow" aria-hidden="true"></i>
                <asp:TextBox ID="txtPreferredLocation" runat="server" CssClass="form-input" placeholder="e.g. Ahmedabad, Remote" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblWorkModeField" runat="server" AssociatedControlID="ddlWorkMode" CssClass="field-label">WORK MODE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-laptop-house" aria-hidden="true"></i>
                <asp:DropDownList ID="ddlWorkMode" runat="server" CssClass="form-input form-select">
                    <asp:ListItem Text="Select Work Mode" Value="" />
                    <asp:ListItem Text="Hybrid" Value="Hybrid" />
                    <asp:ListItem Text="On-site" Value="On-site" />
                    <asp:ListItem Text="Remote" Value="Remote" />
                </asp:DropDownList>
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblAvailabilityField" runat="server" AssociatedControlID="ddlAvailability" CssClass="field-label">AVAILABILITY</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-clock" aria-hidden="true"></i>
                <asp:DropDownList ID="ddlAvailability" runat="server" CssClass="form-input form-select">
                    <asp:ListItem Text="Select Availability" Value="" />
                    <asp:ListItem Text="Available" Value="Available" />
                    <asp:ListItem Text="Not Available" Value="Not Available" />
                </asp:DropDownList>
            </div>
        </div>
      </div>

      <!-- 5. Professional Links -->
      <div class="edit-section-subtitle">
          <i class="fa-solid fa-link" aria-hidden="true"></i> Professional Links
      </div>
      <div class="field-grid">
        <div class="form-field">
            <asp:Label ID="lblLinkedInField" runat="server" AssociatedControlID="txtLinkedIn" CssClass="field-label">LINKEDIN URL</asp:Label>
            <div class="input-shell">
                <i class="fa-brands fa-linkedin" aria-hidden="true"></i>
                <asp:TextBox ID="txtLinkedIn" runat="server" CssClass="form-input" placeholder="https://linkedin.com/in/username" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblGitHubField" runat="server" AssociatedControlID="txtGitHub" CssClass="field-label">GITHUB URL</asp:Label>
            <div class="input-shell">
                <i class="fa-brands fa-github" aria-hidden="true"></i>
                <asp:TextBox ID="txtGitHub" runat="server" CssClass="form-input" placeholder="https://github.com/username" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblPortfolioField" runat="server" AssociatedControlID="txtPortfolio" CssClass="field-label">PORTFOLIO WEBSITE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-globe" aria-hidden="true"></i>
                <asp:TextBox ID="txtPortfolio" runat="server" CssClass="form-input" placeholder="https://yourportfolio.com" />
            </div>
        </div>
      </div>
    </article>

    <!-- Academic Information Card -->
    <article class="edit-card">
      <header class="edit-card-header">
          <div>
              <h2><i class="fa-solid fa-graduation-cap"></i>Education</h2>
              <p>Manage your academic and educational information</p>
          </div>
      </header>
      <div class="edit-section-subtitle">
          <i class="fa-solid fa-building-columns" aria-hidden="true"></i> Academic Information
      </div>
      <div class="field-grid">
        <div class="form-field">
            <asp:Label ID="lblEnrollmentNumberField" runat="server" AssociatedControlID="txtEnrollmentNumber" CssClass="field-label">ENROLLMENT NUMBER</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-id-card" aria-hidden="true"></i>
                <asp:TextBox ID="txtEnrollmentNumber" runat="server" CssClass="form-input" placeholder="Enter enrollment number" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblCollegeNameField" runat="server" AssociatedControlID="txtCollegeName" CssClass="field-label">COLLEGE / UNIVERSITY <span>*</span></asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-school" aria-hidden="true"></i>
                <asp:TextBox ID="txtCollegeName" runat="server" CssClass="form-input" placeholder="Enter college name" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblCourseField" runat="server" AssociatedControlID="txtCourse" CssClass="field-label">COURSE / DEGREE <span>*</span></asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-graduation-cap" aria-hidden="true"></i>
                <asp:TextBox ID="txtCourse" runat="server" CssClass="form-input" placeholder="e.g. BCA, BTech" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblDepartmentField" runat="server" AssociatedControlID="txtDepartment" CssClass="field-label">DEPARTMENT</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-diagram-project" aria-hidden="true"></i>
                <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-input" placeholder="e.g. Computer Science" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblSemesterField" runat="server" AssociatedControlID="txtSemester" CssClass="field-label">CURRENT SEMESTER</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-list-ol" aria-hidden="true"></i>
                <asp:TextBox ID="txtSemester" runat="server" CssClass="form-input" placeholder="e.g. 5th Semester" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblGraduationYearField" runat="server" AssociatedControlID="txtGraduationYear" CssClass="field-label">GRADUATION YEAR</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-calendar-check" aria-hidden="true"></i>
                <asp:TextBox ID="txtGraduationYear" runat="server" CssClass="form-input" placeholder="e.g. 2026" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblCGPAField" runat="server" AssociatedControlID="txtCGPA" CssClass="field-label">CGPA / PERCENTAGE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-chart-line" aria-hidden="true"></i>
                <asp:TextBox ID="txtCGPA" runat="server" CssClass="form-input" placeholder="e.g. 9.30" />
            </div>
        </div>
      </div>
    </article>

  </div>

  <footer class="edit-actions">
      <asp:HyperLink ID="hlCancel" runat="server" NavigateUrl="~/StudentPanel/student-profile.aspx" CssClass="edit-btn edit-btn-secondary">Cancel</asp:HyperLink>
      <asp:Button ID="btnSaveChanges" runat="server" CssClass="edit-btn edit-btn-primary" Text="Save Changes" OnClick="btnSaveChanges_Click" />
  </footer>
</section>

<script>
(function(){
    var i = document.getElementById('<%= fileProfilePhoto.ClientID %>'),
        p = document.getElementById('<%= imgProfilePreview.ClientID %>');
    if(!i || !p) return;
    i.addEventListener('change', function(){
        var f = this.files && this.files[0];
        if(!f || !/^image\//i.test(f.type)) return;
        var r = new FileReader();
        r.onload = function(e){ p.src = e.target.result; };
        r.readAsDataURL(f);
    });
}());
</script>
</asp:Content>


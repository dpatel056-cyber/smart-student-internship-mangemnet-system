<%@ Page Title="Edit Company Profile" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeFile="company-edit-profile.aspx.cs" Inherits="asp.net.company_edit_profile" %>
<asp:Content ID="HeadContentEditProfile" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/company-edit-profile.css?v=" + DateTime.Now.Ticks) %>" />
    <style>
        .photo-upload-row {
            display: flex;
            align-items: center;
            gap: 22px;
            padding: 20px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            margin-bottom: 24px;
        }
        .photo-preview-wrap {
            width: 84px !important;
            height: 84px !important;
            flex: 0 0 84px !important;
            border-radius: 50% !important;
            overflow: hidden !important;
            background: #2563eb !important;
            color: #ffffff !important;
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            border: 3px solid #dbeafe !important;
            position: relative !important;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.18) !important;
        }
        .photo-preview {
            width: 100% !important;
            height: 100% !important;
            object-fit: cover !important;
            border-radius: 50% !important;
        }
        .photo-preview-initials {
            font-size: 30px !important;
            font-weight: 700 !important;
            color: #ffffff !important;
            line-height: 1 !important;
            align-items: center !important;
            justify-content: center !important;
            text-transform: uppercase !important;
            width: 100% !important;
            height: 100% !important;
            text-align: center !important;
            letter-spacing: 1px !important;
        }
        .photo-upload-copy h3 {
            font-size: 15px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 4px;
        }
        .photo-upload-copy p {
            font-size: 13px;
            color: #64748b;
            margin: 0 0 14px;
        }
        .photo-upload-buttons {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        .photo-upload-trigger {
            display: inline-flex !important;
            align-items: center !important;
            gap: 8px !important;
            padding: 9px 18px !important;
            background-color: #2563eb !important;
            color: #ffffff !important;
            border: 1px solid #2563eb !important;
            border-radius: 8px !important;
            font-size: 13px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            text-decoration: none !important;
            transition: all 0.2s ease !important;
            line-height: 1.4 !important;
        }
        .photo-upload-trigger i {
            color: #ffffff !important;
            font-size: 14px !important;
        }
        .photo-upload-trigger:hover {
            background-color: #1d4ed8 !important;
            border-color: #1d4ed8 !important;
            color: #ffffff !important;
        }
        .photo-remove-btn {
            display: inline-flex !important;
            align-items: center !important;
            gap: 8px !important;
            padding: 9px 18px !important;
            background-color: #fee2e2 !important;
            color: #dc2626 !important;
            border: 1px solid #fecaca !important;
            border-radius: 8px !important;
            font-size: 13px !important;
            font-weight: 600 !important;
            cursor: pointer !important;
            text-decoration: none !important;
            transition: all 0.2s ease !important;
            line-height: 1.4 !important;
        }
        .photo-remove-btn i {
            color: #dc2626 !important;
            font-size: 14px !important;
        }
        .photo-remove-btn:hover {
            background-color: #fecaca !important;
            color: #b91c1c !important;
            border-color: #f87171 !important;
            text-decoration: none !important;
        }
        .photo-remove-btn:hover i {
            color: #b91c1c !important;
        }
    </style>
</asp:Content>
<asp:Content ID="MainContentEditProfile" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<section class="company-edit-page" aria-labelledby="editProfileTitle">
  <header class="edit-page-header">
      <div>
          <h1 id="editProfileTitle">Edit Company Profile</h1>
          <p>Update your company details to attract top talent.</p>
      </div>
      <asp:HyperLink ID="hlBackToProfile" runat="server" NavigateUrl="~/CompanyPanel/company-profile.aspx" CssClass="edit-btn edit-btn-secondary">
          <i class="fa-solid fa-arrow-left" aria-hidden="true"></i> Back to Profile
      </asp:HyperLink>
  </header>
  <div class="edit-form-stack">
    <!-- Basic Company Details Card -->
    <article class="edit-card">
      <header class="edit-card-header">
          <div>
              <h2><i class="fa-solid fa-building"></i>Basic Company Details</h2>
              <p>General information about your company</p>
          </div>
      </header>
      <!-- Profile Photo Upload -->
      <div class="photo-upload-row">
          <div class="photo-preview-wrap">
              <asp:Image ID="imgProfilePreview" runat="server" AlternateText="Company logo preview" CssClass="photo-preview" Style="display:none;" />
              <asp:Label ID="lblProfileInitials" runat="server" CssClass="photo-preview-initials" Text="CO" Style="display:flex;"></asp:Label>
          </div>
          <div class="photo-upload-copy">
              <h3>Company Logo</h3>
              <p>Use a clear JPG, PNG or WebP image up to 2 MB.</p>
              <div class="photo-upload-buttons">
                  <label class="photo-upload-trigger" for="<%= fileProfilePhoto.ClientID %>">
                      <i class="fa-solid fa-camera" aria-hidden="true"></i> Choose photo
                  </label>
                  <asp:LinkButton ID="btnRemovePhoto" runat="server" CssClass="photo-remove-btn" OnClick="btnRemovePhoto_Click" CausesValidation="false">
                      <i class="fa-solid fa-trash-can" aria-hidden="true"></i> Remove Photo
                  </asp:LinkButton>
              </div>
              <asp:FileUpload ID="fileProfilePhoto" runat="server" CssClass="file-input-hidden" accept="image/png,image/jpeg,image/webp" />
          </div>
      </div>
      <div class="field-grid">
        <div class="form-field">
            <asp:Label ID="lblCompanyNameField" runat="server" AssociatedControlID="txtCompanyName" CssClass="field-label">COMPANY NAME <span>*</span></asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-building" aria-hidden="true"></i>
                <asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-input" placeholder="Enter company name" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblIndustryField" runat="server" AssociatedControlID="txtIndustry" CssClass="field-label">INDUSTRY</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-industry" aria-hidden="true"></i>
                <asp:TextBox ID="txtIndustry" runat="server" CssClass="form-input" placeholder="e.g. Information Technology" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblCompanyTypeField" runat="server" AssociatedControlID="ddlCompanyType" CssClass="field-label">COMPANY TYPE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-sitemap" aria-hidden="true"></i>
                <asp:DropDownList ID="ddlCompanyType" runat="server" CssClass="form-input form-select">
                    <asp:ListItem Text="Select Type" Value="" />
                    <asp:ListItem Text="Private" Value="Private" />
                    <asp:ListItem Text="Public" Value="Public" />
                    <asp:ListItem Text="Startup" Value="Startup" />
                    <asp:ListItem Text="MNC" Value="MNC" />
                </asp:DropDownList>
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblCompanySizeField" runat="server" AssociatedControlID="ddlCompanySize" CssClass="field-label">COMPANY SIZE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-users" aria-hidden="true"></i>
                <asp:DropDownList ID="ddlCompanySize" runat="server" CssClass="form-input form-select">
                    <asp:ListItem Text="Select Size" Value="" />
                    <asp:ListItem Text="1-50 Employees" Value="1-50" />
                    <asp:ListItem Text="51-200 Employees" Value="51-200" />
                    <asp:ListItem Text="201-500 Employees" Value="201-500" />
                    <asp:ListItem Text="500+ Employees" Value="500+" />
                </asp:DropDownList>
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblFoundedYearField" runat="server" AssociatedControlID="txtFoundedYear" CssClass="field-label">FOUNDED YEAR</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-calendar-days" aria-hidden="true"></i>
                <asp:TextBox ID="txtFoundedYear" runat="server" CssClass="form-input" placeholder="e.g. 2010" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblHeadquartersField" runat="server" AssociatedControlID="txtHeadquarters" CssClass="field-label">HEADQUARTERS</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-map-location-dot" aria-hidden="true"></i>
                <asp:TextBox ID="txtHeadquarters" runat="server" CssClass="form-input" placeholder="e.g. Mumbai, India" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblWebsiteField" runat="server" AssociatedControlID="txtWebsite" CssClass="field-label">WEBSITE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-globe" aria-hidden="true"></i>
                <asp:TextBox ID="txtWebsite" runat="server" CssClass="form-input" placeholder="krishna.com or https://www.krishna.com" />
            </div>
        </div>
        <div class="form-field field-wide">
            <asp:Label ID="lblAboutCompanyField" runat="server" AssociatedControlID="txtAboutCompany" CssClass="field-label">ABOUT COMPANY</asp:Label>
            <div class="input-shell textarea-shell">
                <i class="fa-solid fa-align-left" aria-hidden="true"></i>
                <asp:TextBox ID="txtAboutCompany" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-input form-textarea" placeholder="Write a short description about the company..." />
            </div>
        </div>
      </div>
    </article>
    <!-- Company Information Card -->
    <article class="edit-card">
      <header class="edit-card-header">
          <div>
              <h2><i class="fa-solid fa-circle-info"></i>Company Information</h2>
              <p>Details about your business domain and vision</p>
          </div>
      </header>
      <div class="field-grid">
        <div class="form-field field-wide">
            <asp:Label ID="lblBusinessDomainField" runat="server" AssociatedControlID="txtBusinessDomain" CssClass="field-label">BUSINESS DOMAIN / SPECIALIZATION</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-briefcase" aria-hidden="true"></i>
                <asp:TextBox ID="txtBusinessDomain" runat="server" CssClass="form-input" placeholder="e.g. E-commerce, FinTech" />
            </div>
        </div>
        <div class="form-field field-wide">
            <asp:Label ID="lblProductsServicesField" runat="server" AssociatedControlID="txtProductsServices" CssClass="field-label">PRODUCTS / SERVICES</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-box-open" aria-hidden="true"></i>
                <asp:TextBox ID="txtProductsServices" runat="server" CssClass="form-input" placeholder="Core products or services offered" />
            </div>
        </div>
        <div class="form-field field-wide">
            <asp:Label ID="lblMissionField" runat="server" AssociatedControlID="txtMission" CssClass="field-label">MISSION</asp:Label>
            <div class="input-shell textarea-shell">
                <i class="fa-solid fa-bullseye" aria-hidden="true"></i>
                <asp:TextBox ID="txtMission" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-input form-textarea" placeholder="Company mission statement" />
            </div>
        </div>
        <div class="form-field field-wide">
            <asp:Label ID="lblVisionField" runat="server" AssociatedControlID="txtVision" CssClass="field-label">VISION</asp:Label>
            <div class="input-shell textarea-shell">
                <i class="fa-solid fa-eye" aria-hidden="true"></i>
                <asp:TextBox ID="txtVision" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-input form-textarea" placeholder="Company vision statement" />
            </div>
        </div>
      </div>
    </article>
    <!-- Contact Details Card -->
    <article class="edit-card">
      <header class="edit-card-header">
          <div>
              <h2><i class="fa-solid fa-address-book"></i>Contact Details</h2>
              <p>Communication information for the company and HR</p>
          </div>
      </header>
      <div class="edit-section-subtitle">
          <i class="fa-solid fa-building" aria-hidden="true"></i> Company Contact
      </div>
      <div class="field-grid">
        <div class="form-field">
            <asp:Label ID="lblOfficialEmailField" runat="server" AssociatedControlID="txtOfficialEmail" CssClass="field-label">OFFICIAL EMAIL</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-envelope" aria-hidden="true"></i>
                <asp:TextBox ID="txtOfficialEmail" runat="server" TextMode="Email" CssClass="form-input" placeholder="contact@company.com" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblOfficialContactField" runat="server" AssociatedControlID="txtOfficialContact" CssClass="field-label">OFFICIAL CONTACT NUMBER</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-phone" aria-hidden="true"></i>
                <asp:TextBox ID="txtOfficialContact" runat="server" CssClass="form-input" placeholder="e.g. +91 9876543210" />
            </div>
        </div>
        <div class="form-field field-wide">
            <asp:Label ID="lblCompanyAddressField" runat="server" AssociatedControlID="txtCompanyAddress" CssClass="field-label">ADDRESS</asp:Label>
            <div class="input-shell textarea-shell">
                <i class="fa-solid fa-location-dot" aria-hidden="true"></i>
                <asp:TextBox ID="txtCompanyAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-input form-textarea" placeholder="Full office address" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblCompanyCityField" runat="server" AssociatedControlID="txtCompanyCity" CssClass="field-label">CITY</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-city" aria-hidden="true"></i>
                <asp:TextBox ID="txtCompanyCity" runat="server" CssClass="form-input" placeholder="City" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblCompanyStateField" runat="server" AssociatedControlID="txtCompanyState" CssClass="field-label">STATE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-map" aria-hidden="true"></i>
                <asp:TextBox ID="txtCompanyState" runat="server" CssClass="form-input" placeholder="State" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblCompanyPincodeField" runat="server" AssociatedControlID="txtCompanyPincode" CssClass="field-label">PINCODE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-map-pin" aria-hidden="true"></i>
                <asp:TextBox ID="txtCompanyPincode" runat="server" CssClass="form-input" placeholder="Pincode" />
            </div>
        </div>
      </div>
      <div class="edit-section-subtitle">
          <i class="fa-solid fa-user-tie" aria-hidden="true"></i> HR / Recruiter
      </div>
      <div class="field-grid">
        <div class="form-field">
            <asp:Label ID="lblHrNameField" runat="server" AssociatedControlID="txtHrName" CssClass="field-label">HR / RECRUITER NAME</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-user" aria-hidden="true"></i>
                <asp:TextBox ID="txtHrName" runat="server" CssClass="form-input" placeholder="HR Name" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblHrDesignationField" runat="server" AssociatedControlID="txtHrDesignation" CssClass="field-label">HR DESIGNATION</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-id-badge" aria-hidden="true"></i>
                <asp:TextBox ID="txtHrDesignation" runat="server" CssClass="form-input" placeholder="e.g. Talent Acquisition Lead" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblHrEmailField" runat="server" AssociatedControlID="txtHrEmail" CssClass="field-label">HR EMAIL</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-envelope" aria-hidden="true"></i>
                <asp:TextBox ID="txtHrEmail" runat="server" TextMode="Email" CssClass="form-input" placeholder="hr@company.com" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblHrContactField" runat="server" AssociatedControlID="txtHrContact" CssClass="field-label">HR CONTACT NUMBER</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-phone" aria-hidden="true"></i>
                <asp:TextBox ID="txtHrContact" runat="server" CssClass="form-input" placeholder="HR Phone Number" />
            </div>
        </div>
      </div>
      <div class="edit-section-subtitle">
          <i class="fa-solid fa-globe" aria-hidden="true"></i> Online Presence
      </div>
      <div class="field-grid">
        <div class="form-field">
            <asp:Label ID="lblLinkedInField" runat="server" AssociatedControlID="txtLinkedIn" CssClass="field-label">LINKEDIN</asp:Label>
            <div class="input-shell">
                <i class="fa-brands fa-linkedin" aria-hidden="true"></i>
                <asp:TextBox ID="txtLinkedIn" runat="server" CssClass="form-input" placeholder="LinkedIn Profile URL" />
            </div>
        </div>
      </div>
    </article>
    <!-- Internship Preferences Card -->
    <article class="edit-card">
      <header class="edit-card-header">
          <div>
              <h2><i class="fa-solid fa-sliders"></i>Internship Preferences</h2>
              <p>Set your criteria for hiring interns</p>
          </div>
      </header>
      <div class="field-grid">
        <div class="form-field">
            <asp:Label ID="lblInternshipDomainsField" runat="server" AssociatedControlID="txtInternshipDomains" CssClass="field-label">INTERNSHIP DOMAINS</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-layer-group" aria-hidden="true"></i>
                <asp:TextBox ID="txtInternshipDomains" runat="server" CssClass="form-input" placeholder="e.g. Web Development, AI" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblInternshipTypeField" runat="server" AssociatedControlID="ddlInternshipType" CssClass="field-label">INTERNSHIP TYPE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-money-bill-wave" aria-hidden="true"></i>
                <asp:DropDownList ID="ddlInternshipType" runat="server" CssClass="form-input form-select">
                    <asp:ListItem Text="Select Type" Value="" />
                    <asp:ListItem Text="Paid" Value="Paid" />
                    <asp:ListItem Text="Unpaid" Value="Unpaid" />
                    <asp:ListItem Text="Both" Value="Both" />
                </asp:DropDownList>
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblPreferredWorkModeField" runat="server" AssociatedControlID="ddlPreferredWorkMode" CssClass="field-label">PREFERRED WORK MODE</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-laptop-house" aria-hidden="true"></i>
                <asp:DropDownList ID="ddlPreferredWorkMode" runat="server" CssClass="form-input form-select">
                    <asp:ListItem Text="Select Mode" Value="" />
                    <asp:ListItem Text="On-site" Value="On-site" />
                    <asp:ListItem Text="Remote" Value="Remote" />
                    <asp:ListItem Text="Hybrid" Value="Hybrid" />
                </asp:DropDownList>
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblPreferredDurationField" runat="server" AssociatedControlID="txtPreferredDuration" CssClass="field-label">PREFERRED DURATION</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-clock" aria-hidden="true"></i>
                <asp:TextBox ID="txtPreferredDuration" runat="server" CssClass="form-input" placeholder="e.g. 3 - 6 Months" />
            </div>
        </div>
        <div class="form-field field-wide">
            <asp:Label ID="lblRequiredSkillsField" runat="server" AssociatedControlID="txtRequiredSkills" CssClass="field-label">REQUIRED SKILLS / TECHNOLOGIES</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-code" aria-hidden="true"></i>
                <asp:TextBox ID="txtRequiredSkills" runat="server" CssClass="form-input" placeholder="e.g. C#, ASP.NET, React" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblPreferredCoursesField" runat="server" AssociatedControlID="txtPreferredCourses" CssClass="field-label">PREFERRED COURSES</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-graduation-cap" aria-hidden="true"></i>
                <asp:TextBox ID="txtPreferredCourses" runat="server" CssClass="form-input" placeholder="e.g. B.Tech, MCA" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblPreferredSemesterField" runat="server" AssociatedControlID="txtPreferredSemester" CssClass="field-label">PREFERRED SEMESTER</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-book-open" aria-hidden="true"></i>
                <asp:TextBox ID="txtPreferredSemester" runat="server" CssClass="form-input" placeholder="e.g. 6th, 7th & 8th" />
            </div>
        </div>
        <div class="form-field">
            <asp:Label ID="lblMinimumCGPAField" runat="server" AssociatedControlID="txtMinimumCGPA" CssClass="field-label">MINIMUM CGPA</asp:Label>
            <div class="input-shell">
                <i class="fa-solid fa-star" aria-hidden="true"></i>
                <asp:TextBox ID="txtMinimumCGPA" runat="server" CssClass="form-input" placeholder="e.g. 6.5" />
            </div>
        </div>
      </div>
    </article>
    <!-- Save Button Container -->
    <div class="save-actions">
        <asp:Label ID="lblSaveMessage" runat="server" Visible="false" CssClass="save-message"></asp:Label>
        <asp:Button ID="btnSaveProfile" runat="server" Text="Save Changes" CssClass="edit-btn edit-btn-primary" OnClick="btnSaveProfile_Click" />
    </div>
  </div>
</section>
<script>
(function(){
    var i = document.getElementById('<%= fileProfilePhoto.ClientID %>'),
        p = document.getElementById('<%= imgProfilePreview.ClientID %>'),
        init = document.getElementById('<%= lblProfileInitials.ClientID %>');
    if(!i) return;
    i.addEventListener('change', function(){
        var f = this.files && this.files[0];
        if(!f || !/^image\//i.test(f.type)) return;
        var r = new FileReader();
        r.onload = function(e){
            if (p) {
                p.src = e.target.result;
                p.style.display = 'block';
            }
            if (init) {
                init.style.display = 'none';
            }
        };
        r.readAsDataURL(f);
    });
}());
</script>
</asp:Content>

<%@ Page Title="Add New Internship" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeFile="company-post-internship.aspx.cs" Inherits="asp.net.company_post_internship" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/company-post-internship.css") %>" />
    <style>
        .radio-group, .checkbox-group { display: flex; gap: 20px; flex-wrap: wrap; margin-top: 8px; }
        .radio-group label, .checkbox-group label { display: flex; align-items: center; gap: 8px; cursor: pointer; font-size: 14px; color: #334155; font-weight: 500; }
        .radio-group input[type="radio"], .checkbox-group input[type="checkbox"] { width: 18px; height: 18px; cursor: pointer; accent-color: #2563eb; }
        .bottom-actions { display: flex; gap: 15px; justify-content: flex-end; margin-top: 30px; }
        .btn-cancel { padding: 12px 24px; background: white; border: 1px solid #cbd5e1; color: #475569; border-radius: 8px; font-weight: 600; cursor: pointer; text-decoration: none; }
        .btn-draft { padding: 12px 24px; background: #f1f5f9; border: 1px solid #cbd5e1; color: #0f172a; border-radius: 8px; font-weight: 600; cursor: pointer; }
        .btn-publish { padding: 12px 24px; background: #2563eb; color: white; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; box-shadow: 0 4px 6px -1px rgba(37,99,235,0.2); }
        .btn-publish:hover { background: #1d4ed8; }
        #stipendAmountField { transition: all 0.3s ease; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<section class="company-edit-page">
    <header class="edit-page-header">
        <div>
            <h1>Add New Internship</h1>
            <p>Post a new internship opportunity to attract top talent.</p>
        </div>
    </header>

    <div class="edit-form-stack">
        <!-- 1. Internship Basic Details -->
        <article class="edit-card">
            <header class="edit-card-header">
                <div>
                    <h2><i class="fa-solid fa-briefcase"></i>1. Internship Basic Details</h2>
                </div>
            </header>
            <div class="field-grid">
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtTitle" runat="server" CssClass="field-label">INTERNSHIP TITLE <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtTitle" runat="server" CssClass="form-input" placeholder="e.g. Software Developer Intern" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="ddlDomain" runat="server" CssClass="field-label">INTERNSHIP DOMAIN <span>*</span></asp:Label>
                    <div class="input-shell">
                        <asp:DropDownList ID="ddlDomain" runat="server" CssClass="form-input form-select">
                            <asp:ListItem Text="Select Domain" Value="" />
                            <asp:ListItem Text="Software Development" Value="Software Development" />
                            <asp:ListItem Text="Web Development" Value="Web Development" />
                            <asp:ListItem Text="App Development" Value="App Development" />
                            <asp:ListItem Text="Data Science" Value="Data Science" />
                            <asp:ListItem Text="AI / ML" Value="AI / ML" />
                            <asp:ListItem Text="UI/UX Design" Value="UI/UX Design" />
                            <asp:ListItem Text="Cyber Security" Value="Cyber Security" />
                            <asp:ListItem Text="Digital Marketing" Value="Digital Marketing" />
                            <asp:ListItem Text="Other" Value="Other" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-field field-wide">
                    <asp:Label AssociatedControlID="txtDescription" runat="server" CssClass="field-label">INTERNSHIP DESCRIPTION <span>*</span></asp:Label>
                    <div class="input-shell textarea-shell">
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-input form-textarea" placeholder="Detail the core duties, environment, and goals..." />
                    </div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="ddlInternshipType" runat="server" CssClass="field-label">INTERNSHIP TYPE <span>*</span></asp:Label>
                    <div class="input-shell">
                        <asp:DropDownList ID="ddlInternshipType" runat="server" CssClass="form-input form-select">
                            <asp:ListItem Text="Internship" Value="Internship" />
                            <asp:ListItem Text="Apprenticeship" Value="Apprenticeship" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="ddlWorkMode" runat="server" CssClass="field-label">WORK MODE <span>*</span></asp:Label>
                    <div class="input-shell">
                        <asp:DropDownList ID="ddlWorkMode" runat="server" CssClass="form-input form-select">
                            <asp:ListItem Text="On-site" Value="On-site" />
                            <asp:ListItem Text="Remote" Value="Remote" />
                            <asp:ListItem Text="Hybrid" Value="Hybrid" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtLocation" runat="server" CssClass="field-label">LOCATION <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtLocation" runat="server" CssClass="form-input" placeholder="e.g. Ahmedabad, Gujarat" /></div>
                </div>
            </div>
        </article>

        <!-- 2. Duration & Schedule -->
        <article class="edit-card">
            <header class="edit-card-header">
                <div>
                    <h2><i class="fa-regular fa-clock"></i>2. Duration & Schedule</h2>
                </div>
            </header>
            <div class="field-grid">
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtStartDate" runat="server" CssClass="field-label">START DATE</asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" CssClass="form-input" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtEndDate" runat="server" CssClass="field-label">END DATE</asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" CssClass="form-input" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="ddlDuration" runat="server" CssClass="field-label">DURATION</asp:Label>
                    <div class="input-shell">
                        <asp:DropDownList ID="ddlDuration" runat="server" CssClass="form-input form-select">
                            <asp:ListItem Text="1 Month" Value="1 Month" />
                            <asp:ListItem Text="2 Months" Value="2 Months" />
                            <asp:ListItem Text="3 Months" Value="3 Months" />
                            <asp:ListItem Text="6 Months" Value="6 Months" />
                            <asp:ListItem Text="Other" Value="Other" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtWorkingHours" runat="server" CssClass="field-label">WORKING HOURS</asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtWorkingHours" runat="server" CssClass="form-input" placeholder="e.g. 9 AM - 5 PM or 4 Hrs/Day" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtWorkingDays" runat="server" CssClass="field-label">WORKING DAYS</asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtWorkingDays" runat="server" CssClass="form-input" placeholder="e.g. Monday to Friday" /></div>
                </div>
            </div>
        </article>

        <!-- 3. Stipend & Openings -->
        <article class="edit-card">
            <header class="edit-card-header">
                <div>
                    <h2><i class="fa-solid fa-money-bill-wave"></i>3. Stipend & Openings</h2>
                </div>
            </header>
            <div class="field-grid">
                <div class="form-field">
                    <span class="field-label">PAID / UNPAID <span>*</span></span>
                    <div class="radio-group" id="stipendTypeGroup">
                        <asp:RadioButton ID="rbPaid" runat="server" GroupName="StipendType" Text="Paid" Checked="true" onclick="toggleStipend(true)" />
                        <asp:RadioButton ID="rbUnpaid" runat="server" GroupName="StipendType" Text="Unpaid" onclick="toggleStipend(false)" />
                    </div>
                </div>
                <div class="form-field" id="stipendAmountField">
                    <asp:Label AssociatedControlID="txtStipendAmount" runat="server" CssClass="field-label">STIPEND AMOUNT</asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtStipendAmount" runat="server" CssClass="form-input" placeholder="e.g. ₹10,000 / Month" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtOpenings" runat="server" CssClass="field-label">NUMBER OF OPENINGS <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtOpenings" runat="server" TextMode="Number" CssClass="form-input" placeholder="e.g. 5" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtDeadline" runat="server" CssClass="field-label">APPLICATION DEADLINE <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtDeadline" runat="server" TextMode="Date" CssClass="form-input" /></div>
                </div>
            </div>
            <script>
                function toggleStipend(isPaid) {
                    var stipendField = document.getElementById('stipendAmountField');
                    if(stipendField) {
                        stipendField.style.display = isPaid ? 'block' : 'none';
                    }
                }
            </script>
        </article>

        <!-- 4. Eligibility -->
        <article class="edit-card">
            <header class="edit-card-header">
                <div>
                    <h2><i class="fa-solid fa-user-graduate"></i>4. Eligibility</h2>
                </div>
            </header>
            <div class="field-grid">
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtEligibleCourses" runat="server" CssClass="field-label">ELIGIBLE COURSES <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtEligibleCourses" runat="server" CssClass="form-input" placeholder="e.g. B.Tech, MCA, BCA" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtEligibleDepts" runat="server" CssClass="field-label">ELIGIBLE DEPARTMENTS</asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtEligibleDepts" runat="server" CssClass="form-input" placeholder="e.g. Computer Science, IT" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtPreferredSemester" runat="server" CssClass="field-label">PREFERRED SEMESTER</asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtPreferredSemester" runat="server" CssClass="form-input" placeholder="e.g. 6th or 8th" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtMinCGPA" runat="server" CssClass="field-label">MINIMUM CGPA</asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtMinCGPA" runat="server" CssClass="form-input" placeholder="e.g. 6.5" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="ddlExperience" runat="server" CssClass="field-label">EXPERIENCE</asp:Label>
                    <div class="input-shell">
                        <asp:DropDownList ID="ddlExperience" runat="server" CssClass="form-input form-select">
                            <asp:ListItem Text="Fresher" Value="Fresher" />
                            <asp:ListItem Text="Experienced" Value="Experienced" />
                            <asp:ListItem Text="Both" Value="Both" />
                        </asp:DropDownList>
                    </div>
                </div>
            </div>
        </article>

        <!-- 5. Skills & Responsibilities -->
        <article class="edit-card">
            <header class="edit-card-header">
                <div>
                    <h2><i class="fa-solid fa-code"></i>5. Skills & Responsibilities</h2>
                </div>
            </header>
            <div class="field-grid">
                <div class="form-field field-wide">
                    <asp:Label AssociatedControlID="txtRequiredSkills" runat="server" CssClass="field-label">REQUIRED SKILLS / TECHNOLOGIES <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtRequiredSkills" runat="server" CssClass="form-input" placeholder="e.g. HTML, CSS, JavaScript, React, Git" /></div>
                </div>
                <div class="form-field field-wide">
                    <asp:Label AssociatedControlID="txtResponsibilities" runat="server" CssClass="field-label">RESPONSIBILITIES <span>*</span></asp:Label>
                    <div class="input-shell textarea-shell">
                        <asp:TextBox ID="txtResponsibilities" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-input form-textarea" placeholder="e.g.&#10;• Develop and maintain web applications&#10;• Work with development team" />
                    </div>
                </div>
                <div class="form-field field-wide">
                    <asp:Label AssociatedControlID="txtQualifications" runat="server" CssClass="field-label">REQUIRED QUALIFICATIONS</asp:Label>
                    <div class="input-shell textarea-shell">
                        <asp:TextBox ID="txtQualifications" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-input form-textarea" placeholder="Detail any other qualifications..." />
                    </div>
                </div>
            </div>
        </article>

        <!-- 6. Benefits & Perks -->
        <article class="edit-card">
            <header class="edit-card-header">
                <div>
                    <h2><i class="fa-solid fa-gift"></i>6. Benefits & Perks</h2>
                </div>
            </header>
            <div class="field-grid">
                <div class="form-field field-wide">
                    <span class="field-label">SELECT PERKS</span>
                    <div class="checkbox-group">
                        <asp:CheckBox ID="chkCert" runat="server" Text="Internship Certificate" />
                        <asp:CheckBox ID="chkLOR" runat="server" Text="Letter of Recommendation" />
                        <asp:CheckBox ID="chkMentorship" runat="server" Text="Mentorship" />
                        <asp:CheckBox ID="chkFlexTime" runat="server" Text="Flexible Working Hours" />
                        <asp:CheckBox ID="chkWFH" runat="server" Text="Work From Home" />
                        <asp:CheckBox ID="chkPPO" runat="server" Text="PPO Opportunity" />
                        <asp:CheckBox ID="chkLearning" runat="server" Text="Learning & Training" />
                    </div>
                </div>
                <div class="form-field field-wide">
                    <asp:Label AssociatedControlID="txtOtherBenefits" runat="server" CssClass="field-label">OTHER BENEFITS (OPTIONAL)</asp:Label>
                    <div class="input-shell textarea-shell">
                        <asp:TextBox ID="txtOtherBenefits" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-input form-textarea" placeholder="Any additional perks?" />
                    </div>
                </div>
            </div>
        </article>

        <!-- 7. Company Information -->
        <article class="edit-card">
            <header class="edit-card-header">
                <div>
                    <h2><i class="fa-solid fa-building"></i>7. Company Information</h2>
                </div>
            </header>
            <div class="field-grid">
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtCompanyName" runat="server" CssClass="field-label">COMPANY NAME <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtCompanyName" runat="server" CssClass="form-input" placeholder="e.g. TechCorp Solutions" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="fuCompanyLogo" runat="server" CssClass="field-label">COMPANY LOGO</asp:Label>
                    <div class="input-shell"><asp:FileUpload ID="fuCompanyLogo" runat="server" CssClass="form-input" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtIndustry" runat="server" CssClass="field-label">INDUSTRY <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtIndustry" runat="server" CssClass="form-input" placeholder="e.g. Information Technology" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtCompanyLocation" runat="server" CssClass="field-label">COMPANY LOCATION <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtCompanyLocation" runat="server" CssClass="form-input" placeholder="e.g. Ahmedabad, Gujarat" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtContactPerson" runat="server" CssClass="field-label">CONTACT PERSON / HR NAME <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtContactPerson" runat="server" CssClass="form-input" placeholder="e.g. John Doe (HR Manager)" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtCompanyEmail" runat="server" CssClass="field-label">COMPANY EMAIL <span>*</span></asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtCompanyEmail" runat="server" TextMode="Email" CssClass="form-input" placeholder="e.g. hr@company.com" /></div>
                </div>
                <div class="form-field">
                    <asp:Label AssociatedControlID="txtCompanyWebsite" runat="server" CssClass="field-label">COMPANY WEBSITE</asp:Label>
                    <div class="input-shell"><asp:TextBox ID="txtCompanyWebsite" runat="server" CssClass="form-input" placeholder="e.g. https://www.company.com" /></div>
                </div>
            </div>
        </article>

        <!-- Bottom Action -->
        <div class="bottom-actions">
            <asp:HyperLink ID="hlCancel" runat="server" NavigateUrl="~/CompanyPanel/company-dashboard.aspx" CssClass="btn-cancel">Cancel</asp:HyperLink>
            <asp:Button ID="btnSaveDraft" runat="server" Text="Save as Draft" CssClass="btn-draft" OnClick="btnSaveDraft_Click" />
            <asp:Button ID="btnPublish" runat="server" Text="Publish Internship" CssClass="btn-publish" OnClick="btnPublish_Click" />
        </div>
        <asp:Label ID="lblMessage" runat="server" Visible="false" CssClass="save-message" style="margin-top: 15px; display: block; text-align: right; color: #16a34a; font-weight: 600;"></asp:Label>

    </div>
</section>
</asp:Content>

<%@ Page Title="Student Profile"
    Language="C#"
    MasterPageFile="~/AdminPanel/admin.Master"
    AutoEventWireup="true"
    CodeBehind="viewStudentDetails.aspx.cs"
    Inherits="asp.net.viewStudentDetails" %>

<asp:Content ID="ProfileHead" ContentPlaceHolderID="head" runat="server">
    <style>
        .student-view-page {
            max-width: 1280px;
            margin: 0 auto;
            padding: 24px;
            color: #172554;
        }

        /* Profile Header Card */
        .profile-header-card {
            background: #fff;
            border: 1px solid #e8edf5;
            border-radius: 18px;
            padding: 28px;
            margin-bottom: 25px;
            box-shadow: 0 6px 25px rgba(15,23,42,.08);
        }

        .profile-header-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 25px;
        }

        .profile-main-info {
            display: flex;
            align-items: center;
            gap: 22px;
            flex: 1;
        }

        .profile-photo {
            width: 105px;
            height: 105px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg,#2563eb,#172554);
            color: #fff;
            font-size: 28px;
            font-weight: 800;
            border: 4px solid #e8f0ff;
            overflow: hidden;
            position: relative;
            flex-shrink: 0;
        }

        .profile-info-2x2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 5px;
            flex: 1;
        }

        .profile-contact-row {
            display: grid;
            grid-template-columns: repeat(3,1fr);
            gap: 15px;
            margin-top: 25px;
            padding-top: 22px;
            border-top: 1px solid #edf1f7;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 11px;
            padding: 13px 15px;
            background: #f8fafc;
            border-radius: 11px;
            min-width: 0;
        }

        .contact-icon {
            width: 35px;
            height: 35px;
            border-radius: 9px;
            display: grid;
            place-items: center;
            background: #e8f0ff;
            color: #2563eb;
            flex-shrink: 0;
        }

        .contact-text {
            min-width: 0;
        }

        .contact-label {
            display: block;
            font-size: 11px;
            color: #94a3b8;
            margin-bottom: 2px;
        }

        .contact-value {
            display: block;
            font-size: 13px;
            color: #334155;
            font-weight: 500;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .social-links {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }

        .social-link {
            text-decoration: none;
            padding: 9px 14px;
            border: 1px solid #e2e8f0;
            border-radius: 9px;
            color: #475569;
            font-size: 13px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 7px;
        }

            .social-link:hover {
                border-color: #2563eb;
                color: #2563eb;
                background: #f8fbff;
            }

        /* Profile Tabs Card */
        .profile-tabs-card {
            background: #fff;
            border: 1px solid #e8edf5;
            border-radius: 16px;
            padding: 8px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(15,23,42,.06);
        }

        .profile-tabs {
            display: flex;
            gap: 5px;
            overflow-x: auto;
        }

        .profile-tab {
            flex: 1;
            min-width: 140px;
            border: 0;
            background: transparent;
            color: #64748b;
            padding: 13px 16px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            white-space: nowrap;
        }

            .profile-tab:hover {
                background: #f1f5f9;
                color: #2563eb;
            }

            .profile-tab.active {
                background: #2563eb;
                color: #fff;
                box-shadow: 0 4px 10px rgba(37,99,235,.2);
            }

        .tab-content {
            display: none;
        }

            .tab-content.active {
                display: block;
            }

        /* Section Cards & Fields */
        .profile-section-card {
            background: #fff;
            border: 1px solid #e8edf5;
            border-radius: 18px;
            padding: 28px;
            box-shadow: 0 6px 25px rgba(15,23,42,.06);
        }

        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            padding-bottom: 22px;
            border-bottom: 1px solid #edf1f7;
        }

            .section-header h2 {
                margin: 0 0 6px;
                color: #172554;
                font-size: 21px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

                .section-header h2 i, .profile-subtitle i {
                    color: #2563eb;
                    margin-right: 8px;
                }

            .section-header p {
                margin: 0;
                color: #64748b;
                font-size: 13px;
            }

        .profile-subtitle {
            margin: 27px 0 16px;
            color: #334155;
            font-size: 15px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .profile-info-grid {
            display: grid;
            grid-template-columns: repeat(2,1fr);
            gap: 14px;
        }

        .info-field {
            background: #f8fafc;
            border: 1px solid #edf1f5;
            border-radius: 11px;
            padding: 14px 16px;
            min-height: 62px;
        }

        .info-label {
            display: block;
            color: #94a3b8;
            font-size: 11px;
            font-weight: 600;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: .3px;
        }

        .info-value {
            display: block;
            color: #334155;
            font-size: 14px;
            font-weight: 500;
        }

        .full-width {
            grid-column: 1/-1;
        }

        .about-box {
            background: #f8fafc;
            border: 1px solid #edf1f5;
            border-radius: 11px;
            padding: 17px 18px;
        }

            .about-box p {
                margin: 0;
                color: #475569;
                font-size: 14px;
                line-height: 1.7;
            }

        /* Professional Links */
        .professional-links-grid {
            display: grid;
            grid-template-columns: repeat(3,1fr);
            gap: 12px;
        }

        .professional-link-card {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 13px;
            border: 1px solid #dfe7f1;
            border-radius: 11px;
            background: #f8fafc;
            color: #334155;
            text-decoration: none;
            transition: .2s;
        }

            .professional-link-card:hover {
                border-color: #93b8f7;
                background: #eff6ff;
                transform: translateY(-1px);
            }

        .professional-link-icon {
            width: 34px;
            height: 34px;
            min-width: 34px;
            display: grid;
            place-items: center;
            border-radius: 9px;
            background: #e8f0ff;
            color: #2563eb;
        }

            .professional-link-icon.linkedin {
                background: #e8f3ff;
                color: #0a66c2;
            }

            .professional-link-icon.github {
                background: #eef0f3;
                color: #24292f;
            }

            .professional-link-icon.portfolio {
                background: #eaf8f4;
                color: #0a9b72;
            }

        .professional-link-card strong {
            display: block;
            font-size: 13px;
            color: #1e293b;
        }

        .professional-link-card small {
            display: block;
            margin-top: 3px;
            color: #94a3b8;
            font-size: 10px;
            word-break: break-all;
        }

        .link-arrow {
            margin-left: auto;
            color: #94a3b8;
            font-size: 11px;
        }

        /* Skills & Lists */
        .skill-category-box {
            border: 1px solid #e5eaf2;
            border-radius: 13px;
            padding: 20px;
            margin-bottom: 16px;
            background: #ffffff;
        }

        .skill-category-title {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 17px;
        }

            .skill-category-title h3 {
                margin: 0;
                font-size: 15px;
                font-weight: 700;
                color: #172033;
            }

        .category-icon {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }

        .technical-icon {
            background: #e8f1ff;
            color: #2563eb;
        }

        .soft-icon {
            background: #e1f8f3;
            color: #15967e;
        }

        .other-icon {
            background: #eee8ff;
            color: #7048d8;
        }

        .skills-list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .skills-gridview {
            width: 100%;
            border-collapse: collapse;
        }

            .skills-gridview > tbody {
                display: flex !important;
                flex-wrap: wrap !important;
                gap: 10px !important;
            }

                .skills-gridview > tbody > tr > td {
                    padding: 0 !important;
                    border: none !important;
                    background: transparent !important;
                }

        .skill-pill {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .technical-pill {
            background: #eff6ff;
            border: 1px solid #dbeafe;
            color: #1d4ed8;
        }

        .soft-pill {
            background: #f0fdf4;
            border: 1px solid #dcfce7;
            color: #15803d;
        }

        .other-pill {
            background: #faf5ff;
            border: 1px solid #f3e8ff;
            color: #7e22ce;
        }

        .no-skill-text {
            color: #94a3b8;
            font-size: 13px;
            font-style: italic;
            padding: 4px 0;
        }
        /* Projects GridView & Card Styling */
        .projects-gridview {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 16px;
            margin-top: 10px;
        }

            .projects-gridview > tbody > tr > td {
                padding: 0;
                border: none;
                background: transparent;
            }

        .project-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 22px;
            box-shadow: 0 4px 14px rgba(15, 23, 42, 0.03);
            transition: all 0.2s ease;
        }

            .project-card:hover {
                border-color: #bfdbfe;
                box-shadow: 0 8px 24px rgba(37, 99, 235, 0.08);
            }

        .project-card-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 15px;
        }

        .project-title-area {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .project-icon {
            width: 48px;
            height: 48px;
            min-width: 48px;
            border-radius: 12px;
            background: #eff6ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .project-title-area h3 {
            margin: 0 0 4px;
            color: #172554;
            font-size: 17px;
            font-weight: 700;
        }

        .project-type-badge {
            display: inline-block;
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #dbeafe;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }

        .project-description {
            margin-top: 16px;
        }

            .project-description p {
                margin: 0;
                color: #475569;
                font-size: 14px;
                line-height: 1.6;
            }

        .project-info {
            margin-top: 16px;
        }

        .project-info-label {
            color: #64748b;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

            .project-info-label i {
                color: #2563eb;
            }

        .technology-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .tech-tag {
            padding: 6px 12px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            color: #334155;
            font-size: 12px;
            font-weight: 500;
        }

        .project-links {
            margin-top: 18px;
            padding-top: 14px;
            border-top: 1px solid #f1f5f9;
        }

        .project-link-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 9px 16px;
            background: #eff6ff;
            border: 1px solid #dbeafe;
            border-radius: 9px;
            color: #2563eb;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

            .project-link-btn:hover {
                background: #2563eb;
                color: #ffffff;
                border-color: #2563eb;
            }

        .no-projects-text {
            display: block;
            margin-top: 20px;
            padding: 30px;
            text-align: center;
            background: #f8fafc;
            border: 1.5px dashed #cbd5e1;
            border-radius: 12px;
            color: #64748b;
            font-size: 14px;
            font-weight: 500;
        }
        /* Certificate Cards */
        .certificate-card {
            background: #f8fafc;
            border: 1px solid #e4eaf2;
            border-radius: 14px;
            padding: 20px;
            margin-top: 20px;
        }

        .certificate-main {
            display: flex;
            align-items: flex-start;
            gap: 17px;
        }

        .certificate-icon {
            width: 52px;
            height: 52px;
            min-width: 52px;
            border-radius: 12px;
            background: #eff6ff;
            color: #2563eb;
            display: grid;
            place-items: center;
            font-size: 21px;
        }

        .certificate-content {
            flex: 1;
            min-width: 0;
        }

        .certificate-title-row {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 15px;
        }

            .certificate-title-row h3 {
                margin: 0 0 5px;
                color: #172554;
                font-size: 16px;
                font-weight: 700;
            }

        .certificate-issuer {
            margin: 0;
            color: #64748b;
            font-size: 12px;
        }

        .certificate-details {
            display: flex;
            flex-wrap: wrap;
            gap: 35px;
            margin-top: 16px;
            padding-top: 14px;
            border-top: 1px solid #e5eaf1;
        }

        .certificate-detail {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

            .certificate-detail span {
                color: #94a3b8;
                font-size: 10px;
                text-transform: uppercase;
                font-weight: 600;
            }

            .certificate-detail strong {
                color: #334155;
                font-size: 12px;
                font-weight: 600;
            }

        .certificate-actions {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 16px;
        }

        .certificate-action {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 8px 12px;
            border-radius: 8px;
            border: 1px solid #dbe5f0;
            background: #fff;
            color: #475569;
            text-decoration: none;
            font-size: 11px;
            font-weight: 600;
        }

            .certificate-action:hover, .certificate-action.primary {
                color: #2563eb;
                border-color: #bfdbfe;
                background: #eff6ff;
            }

        .not-found {
            padding: 60px 20px;
            text-align: center;
        }

        .not-found-icon {
            font-size: 46px;
            color: #94a3b8;
            margin-bottom: 14px;
        }

        .not-found h2 {
            margin: 0 0 8px;
            color: #334155;
        }

        .not-found p {
            margin: 0;
            color: #94a3b8;
        }

        /* Resume Styles */
        .resume-current-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            background: #f8fafc;
            border: 1px solid #e4eaf2;
            border-radius: 14px;
            padding: 20px;
            margin-top: 20px;
        }

        .resume-file-left {
            display: flex;
            align-items: center;
            gap: 15px;
            min-width: 0;
        }

        .resume-pdf-icon {
            width: 52px;
            height: 52px;
            min-width: 52px;
            display: grid;
            place-items: center;
            border-radius: 12px;
            background: #fff0f0;
            color: #dc2626;
            font-size: 23px;
        }

        .resume-file-info {
            min-width: 0;
        }

            .resume-file-info h3 {
                margin: 0 0 9px;
                color: #172554;
                font-size: 16px;
                overflow-wrap: anywhere;
            }

        .resume-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 8px 16px;
            color: #64748b;
            font-size: 11px;
        }

            .resume-meta i {
                color: #2563eb;
                margin-right: 4px;
            }

        .resume-actions {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
            justify-content: flex-end;
        }

        .resume-action-btn {
            border: 1px solid #dbe5f0;
            background: #fff;
            color: #475569;
            border-radius: 8px;
            padding: 8px 11px;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

            .resume-action-btn.primary {
                color: #2563eb;
                border-color: #bfdbfe;
                background: #eff6ff;
            }

            .resume-action-btn:hover {
                color: #2563eb;
                border-color: #bfdbfe;
                background: #eff6ff;
            }

        @media(max-width:850px) {
            .profile-header-top {
                align-items: flex-start;
                flex-direction: column;
            }

            .profile-info-2x2 {
                grid-template-columns: 1fr 1fr;
                width: 100%;
            }

            .profile-contact-row {
                grid-template-columns: 1fr;
            }

            .professional-links-grid {
                grid-template-columns: 1fr;
            }
        }

        @media(max-width:650px) {
            .student-view-page {
                padding: 12px;
            }

            .profile-main-info {
                align-items: flex-start;
                flex-direction: column;
            }

            .profile-info-2x2 {
                grid-template-columns: 1fr;
            }

            .profile-photo {
                width: 80px;
                height: 80px;
                font-size: 22px;
            }

            .profile-section-card {
                padding: 18px;
            }

            .profile-tab {
                padding: 10px 13px;
                min-width: auto;
            }

            .profile-info-grid {
                grid-template-columns: 1fr;
            }

            .resume-current-card {
                flex-direction: column;
                align-items: flex-start;
            }

            .resume-actions {
                width: 100%;
                justify-content: flex-start;
                margin-top: 10px;
            }
        }

        /* Back Button */
        .back-nav-bar {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .back-to-students-btn {
            display: inline-flex;
            align-items: center;
            gap: 9px;
            padding: 10px 18px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            color: #334155;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            box-shadow: 0 2px 8px rgba(15,23,42,.05);
            transition: all .2s ease;
        }

            .back-to-students-btn:hover {
                background: #f8fafc;
                color: #2563eb;
                border-color: #cbd5e1;
                transform: translateX(-3px);
                box-shadow: 0 4px 12px rgba(37,99,235,.1);
            }
    </style>
</asp:Content>

<asp:Content ID="ProfileMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-view-page">

        <div class="back-nav-bar">
            <a href="admin-students.aspx" class="back-to-students-btn">
                <i class="fa-solid fa-arrow-left"></i>Back to Students
            </a>
        </div>

        <asp:Panel ID="pnlNotFound" runat="server" Visible="false" CssClass="profile-header-card">
            <div class="not-found">
                <div class="not-found-icon"><i class="fa-solid fa-user-slash"></i></div>
                <h2>Student Not Found</h2>
                <p>The requested student record could not be found.</p>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlDetails" runat="server">
            <asp:Label ID="lblStudentId" runat="server" Visible="false"></asp:Label>

            <div class="profile-header-card">
                <div class="profile-header-top">
                    <div class="profile-main-info">
                        <div class="profile-photo" aria-label="Student profile photo">
                            <asp:Label ID="lblInitials" runat="server">S</asp:Label>
                            <asp:Image ID="imgStudentPhoto" runat="server" Visible="false" Style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;" />
                        </div>
                        <div class="profile-info-2x2">
                            <div class="contact-item">
                                <div class="contact-icon"><i class="fa-solid fa-user"></i></div>
                                <div class="contact-text">
                                    <span class="contact-label">Full Name</span>
                                    <asp:Label ID="lblFullName" runat="server" CssClass="contact-value">-</asp:Label>
                                </div>
                            </div>
                            <div class="contact-item">
                                <div class="contact-icon"><i class="fa-solid fa-book"></i></div>
                                <div class="contact-text">
                                    <span class="contact-label">Course</span>
                                    <asp:Label ID="lblCourseHeader" runat="server" CssClass="contact-value">-</asp:Label>
                                </div>
                            </div>
                            <div class="contact-item">
                                <div class="contact-icon"><i class="fa-solid fa-building-columns"></i></div>
                                <div class="contact-text">
                                    <span class="contact-label">College</span>
                                    <asp:Label ID="lblCollegeHeader" runat="server" CssClass="contact-value">-</asp:Label>
                                </div>
                            </div>
                            <div class="contact-item">
                                <div class="contact-icon"><i class="fa-solid fa-star"></i></div>
                                <div class="contact-text">
                                    <span class="contact-label">CGPA</span>
                                    <asp:Label ID="lblCgpa" runat="server" CssClass="contact-value">-</asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="profile-contact-row">
                    <div class="contact-item">
                        <div class="contact-icon"><i class="fa-solid fa-envelope"></i></div>
                        <div class="contact-text">
                            <span class="contact-label">Email Address</span>
                            <asp:Label ID="lblEmail" runat="server" CssClass="contact-value">-</asp:Label>
                        </div>
                    </div>
                    <div class="contact-item">
                        <div class="contact-icon"><i class="fa-solid fa-phone"></i></div>
                        <div class="contact-text">
                            <span class="contact-label">Contact Number</span>
                            <asp:Label ID="lblContact" runat="server" CssClass="contact-value">-</asp:Label>
                        </div>
                    </div>
                    <div class="contact-item">
                        <div class="contact-icon"><i class="fa-solid fa-id-card"></i></div>
                        <div class="contact-text">
                            <span class="contact-label">Enrollment Number</span>
                            <asp:Label ID="lblEnrollment" runat="server" CssClass="contact-value">-</asp:Label>
                        </div>
                    </div>
                </div>

                <div class="social-links">
                    <asp:HyperLink ID="hlHeaderLinkedIn" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-brands fa-linkedin"></i>LinkedIn</asp:HyperLink>
                    <asp:HyperLink ID="hlHeaderGitHub" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-brands fa-github"></i>GitHub</asp:HyperLink>
                    <asp:HyperLink ID="hlHeaderPortfolio" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-solid fa-globe"></i>Portfolio</asp:HyperLink>
                </div>
            </div>

            <section class="profile-tabs-card" aria-label="Profile sections">
                <div class="profile-tabs" role="tablist">
                    <button type="button" class="profile-tab active" onclick="openTab('personal', this)"><i class="fa-solid fa-user"></i><span>Personal</span></button>
                    <button type="button" class="profile-tab" onclick="openTab('education', this)"><i class="fa-solid fa-graduation-cap"></i><span>Education</span></button>
                    <button type="button" class="profile-tab" onclick="openTab('skills', this)"><i class="fa-solid fa-code"></i><span>Skills</span></button>
                    <button type="button" class="profile-tab" onclick="openTab('projects', this)"><i class="fa-solid fa-diagram-project"></i><span>Projects</span></button>
                    <button type="button" class="profile-tab" onclick="openTab('resume', this)"><i class="fa-solid fa-file-pdf"></i><span>Resume</span></button>
                </div>
            </section>

            <section id="personal" class="tab-content active">
                <div class="profile-section-card">
                    <div class="section-header">
                        <div>
                            <h2><i class="fa-solid fa-user"></i>Personal Information</h2>
                            <p>Manage your basic and professional personal details</p>
                        </div>
                    </div>

                    <div class="profile-subtitle"><i class="fa-solid fa-id-card"></i>Basic Information</div>
                    <div class="profile-info-grid">
                        <div class="info-field"><span class="info-label">Full Name</span><asp:Label ID="lblFullNameInfo" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Date of Birth</span><asp:Label ID="lblDob" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Gender</span><asp:Label ID="lblGender" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Email Address</span><asp:Label ID="lblEmailInfo" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Contact Number</span><asp:Label ID="lblContactInfo" runat="server" CssClass="info-value">-</asp:Label></div>
                    </div>

                    <div class="profile-subtitle"><i class="fa-solid fa-location-dot"></i>Address Information</div>
                    <div class="profile-info-grid">
                        <div class="info-field"><span class="info-label">Address</span><asp:Label ID="lblAddress" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">City</span><asp:Label ID="lblCity" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">State</span><asp:Label ID="lblState" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Pincode</span><asp:Label ID="lblPincode" runat="server" CssClass="info-value">-</asp:Label></div>
                    </div>

                    <div class="profile-subtitle"><i class="fa-solid fa-user-pen"></i>About Me</div>
                    <div class="about-box">
                        <p>
                            <asp:Label ID="lblAboutMe" runat="server" CssClass="info-value">-</asp:Label>
                        </p>
                    </div>

                    <div class="profile-subtitle"><i class="fa-solid fa-briefcase"></i>Internship Preferences</div>
                    <div class="profile-info-grid">
                        <div class="info-field"><span class="info-label">Preferred Domain</span><asp:Label ID="lblPreferredDomain" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Preferred Role</span><asp:Label ID="lblPreferredRole" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Preferred Location</span><asp:Label ID="lblPreferredLocation" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Work Mode</span><asp:Label ID="lblWorkMode" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Availability</span><asp:Label ID="lblAvailability" runat="server" CssClass="info-value">-</asp:Label></div>
                    </div>

                    <div class="profile-subtitle"><i class="fa-solid fa-link"></i>Professional Links</div>
                    <div class="professional-links-grid">
                        <asp:HyperLink ID="hlLinkedIn" runat="server" Target="_blank" Rel="noopener" CssClass="professional-link-card" NavigateUrl="#">
                            <span class="professional-link-icon linkedin"><i class="fa-brands fa-linkedin-in"></i></span>
                            <span><strong>LinkedIn</strong><small><asp:Label ID="lblLinkedInText" runat="server">-</asp:Label></small></span>
                            <i class="fa-solid fa-arrow-up-right-from-square link-arrow"></i>
                        </asp:HyperLink>
                        <asp:HyperLink ID="hlGitHub" runat="server" Target="_blank" Rel="noopener" CssClass="professional-link-card" NavigateUrl="#">
                            <span class="professional-link-icon github"><i class="fa-brands fa-github"></i></span>
                            <span><strong>GitHub</strong><small><asp:Label ID="lblGitHubText" runat="server">-</asp:Label></small></span>
                            <i class="fa-solid fa-arrow-up-right-from-square link-arrow"></i>
                        </asp:HyperLink>
                        <asp:HyperLink ID="hlPortfolio" runat="server" Target="_blank" Rel="noopener" CssClass="professional-link-card" NavigateUrl="#">
                            <span class="professional-link-icon portfolio"><i class="fa-solid fa-globe"></i></span>
                            <span><strong>Portfolio</strong><small><asp:Label ID="lblPortfolioText" runat="server">-</asp:Label></small></span>
                            <i class="fa-solid fa-arrow-up-right-from-square link-arrow"></i>
                        </asp:HyperLink>
                    </div>
                </div>
            </section>

            <section id="education" class="tab-content">
                <div class="profile-section-card">
                    <div class="section-header">
                        <div>
                            <h2><i class="fa-solid fa-graduation-cap"></i>Education</h2>
                            <p>Manage your academic and educational information</p>
                        </div>
                    </div>
                    <div class="profile-subtitle"><i class="fa-solid fa-school"></i>Academic Information</div>
                    <div class="profile-info-grid">
                        <div class="info-field"><span class="info-label">Enrollment Number</span><asp:Label ID="lblEnrollmentInfo" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">College / University</span><asp:Label ID="lblCollege" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Course / Degree</span><asp:Label ID="lblCourse" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Department</span><asp:Label ID="lblDepartment" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Current Year / Semester</span><asp:Label ID="lblSemester" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">CGPA / Percentage</span><asp:Label ID="lblCgpaInfo" runat="server" CssClass="info-value">-</asp:Label></div>
                        <div class="info-field"><span class="info-label">Graduation Year</span><asp:Label ID="lblGraduationYear" runat="server" CssClass="info-value">-</asp:Label></div>
                    </div>
                </div>
            </section>

            <section id="skills" class="tab-content">
                <div class="profile-section-card">
                    <div class="section-header">
                        <div>
                            <h2><i class="fa-solid fa-code"></i>Skills</h2>
                            <p>Showcase your technical and professional skills</p>
                        </div>
                    </div>

                    <!-- Technical Skills -->
                    <div class="skill-category-box technical-box" style="margin-top: 20px;">
                        <div class="skill-category-title">
                            <div class="category-icon technical-icon"><i class="fa-solid fa-laptop-code"></i></div>
                            <h3>Technical Skills</h3>
                        </div>
                        <div class="skills-list">
                            <asp:GridView ID="gvTechSkills" runat="server" AutoGenerateColumns="False" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="skill-pill technical-pill"><span><%# Eval("SkillName") %></span></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:Label ID="lblNoTechSkills" runat="server" CssClass="no-skill-text" Text="No technical skills added yet."></asp:Label>
                        </div>
                    </div>

                    <!-- Soft Skills -->
                    <div class="skill-category-box soft-box">
                        <div class="skill-category-title">
                            <div class="category-icon soft-icon"><i class="fa-solid fa-people-group"></i></div>
                            <h3>Soft Skills</h3>
                        </div>
                        <div class="skills-list">
                            <asp:GridView ID="gvSoftSkills" runat="server" AutoGenerateColumns="False" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="skill-pill soft-pill"><span><%# Eval("SkillName") %></span></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:Label ID="lblNoSoftSkills" runat="server" CssClass="no-skill-text" Text="No soft skills added yet."></asp:Label>
                        </div>
                    </div>

                    <!-- Other Skills -->
                    <div class="skill-category-box other-box">
                        <div class="skill-category-title">
                            <div class="category-icon other-icon"><i class="fa-solid fa-layer-group"></i></div>
                            <h3>Other Skills</h3>
                        </div>
                        <div class="skills-list">
                            <asp:GridView ID="gvOtherSkills" runat="server" AutoGenerateColumns="False" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="skill-pill other-pill"><span><%# Eval("SkillName") %></span></div>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:Label ID="lblNoOtherSkills" runat="server" CssClass="no-skill-text" Text="No other skills added yet."></asp:Label>
                        </div>
                    </div>

                </div>
            </section>

            <section id="projects" class="tab-content">
                <div class="profile-section-card">
                    <div class="section-header">
                        <div>
                            <h2><i class="fa-solid fa-diagram-project"></i>Projects</h2>
                            <p>Showcase your academic and personal projects</p>
                        </div>
                    </div>
                    <asp:GridView ID="gvProjects" runat="server" AutoGenerateColumns="False" CssClass="projects-gridview" GridLines="None" ShowHeader="False">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div class="project-card">
                                        <div class="project-card-header">
                                            <div class="project-title-area">
                                                <div class="project-icon">
                                                    <i class="fa-solid fa-diagram-project"></i>
                                                </div>
                                                <div>
                                                    <h3><%# Eval("ProjectName") %></h3>
                                                    <span class="project-type-badge"><%# Eval("ProjectType") %></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="project-description">
                                            <p><%# Eval("Description") %></p>
                                        </div>

                                        <div class="project-info">
                                            <div class="project-info-label">
                                                <i class="fa-solid fa-microchip"></i>
                                                Technologies Used
                                            </div>

                                            <div class="technology-tags">
                                                <%# Eval("TechnologiesUsed") %>
                                            </div>
                                        </div>

                                        <div class="project-links">
                                            <a href='<%# Eval("ProjectLink") %>'
                                                target="_blank"
                                                class="project-link-btn">

                                                <i class="fa-solid fa-arrow-up-right-from-square"></i>
                                                View Project

                                            </a>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:Label ID="lblNoProjects" runat="server" CssClass="no-projects-text" Text="No projects available."></asp:Label>
                </div>
            </section>

            <section id="resume" class="tab-content">
                <div class="profile-section-card">
                    <div class="section-header">
                        <div>
                            <h2><i class="fa-solid fa-file-pdf"></i>Resume</h2>
                            <p>View student's uploaded resume for internship applications</p>
                        </div>
                    </div>
                    <asp:Panel ID="pnlResumeData" runat="server" Visible="false">
                        <div class="resume-current-card">
                            <div class="resume-file-left">
                                <div class="resume-pdf-icon"><i class="fa-solid fa-file-pdf"></i></div>
                                <div class="resume-file-info">
                                    <h3>
                                        <asp:Label ID="lblResumeFileName" runat="server"></asp:Label></h3>
                                    <div class="resume-meta">
                                        <span><i class="fa-regular fa-file"></i>PDF Document</span>
                                        <span><i class="fa-regular fa-calendar"></i>Uploaded:
                                            <asp:Label ID="lblResumeDate" runat="server"></asp:Label></span>
                                    </div>
                                </div>
                            </div>
                            <div class="resume-actions">
                                <asp:HyperLink ID="hlViewResume" runat="server" Target="_blank" CssClass="resume-action-btn primary"><i class="fa-solid fa-eye"></i> View</asp:HyperLink>
                                <asp:HyperLink ID="hlDownloadResume" runat="server" CssClass="resume-action-btn"><i class="fa-solid fa-download"></i> Download</asp:HyperLink>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Label ID="lblNoResume" runat="server" CssClass="empty" Text="No resume uploaded by the student."></asp:Label>
                </div>
            </section>

        </asp:Panel>
    </div>

    <script>
        function openTab(id, button) {
            document.querySelectorAll('.tab-content').forEach(function (x) { x.classList.remove('active'); });
            document.querySelectorAll('.profile-tab').forEach(function (x) { x.classList.remove('active'); });
            var section = document.getElementById(id);
            if (section) section.classList.add('active');
            if (button) button.classList.add('active');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    </script>
</asp:Content>











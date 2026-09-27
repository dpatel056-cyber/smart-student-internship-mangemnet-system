<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeFile="student-profile.aspx.cs" Inherits="asp.net.js.student_profile" %>

<asp:Content ID="ProfileHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/student-profile.css") %>" />
</asp:Content>
<asp:Content ID="ProfileMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .student-profile-page {
            max-width: 1180px;
            margin: 0 auto;
            padding: 34px 28px 56px;
            color: #172554
        }

        .profile-header-card {
            background: #fff;
            border: 1px solid #e8edf5;
            border-radius: 18px;
            padding: 28px;
            margin-bottom: 25px;
            box-shadow: 0 6px 25px rgba(15,23,42,.08)
        }

        .profile-header-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 25px
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

        .profile-name {
            font-size: 27px;
            font-weight: 700;
            margin: 0 0 7px
        }

        .profile-info-2x2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 5px;
            flex: 1;
        }

        .profile-course {
            font-size: 15px;
            color: #475569;
            margin-bottom: 5px
        }

        .profile-college, .profile-cgpa {
            font-size: 14px;
            color: #64748b;
            margin-bottom: 7px
        }

        .profile-cgpa {
            font-size: 13px
        }

            .profile-cgpa i {
                color: #2563eb;
                margin-right: 5px
            }

        .edit-profile-btn {
            background: #2563eb;
            color: #fff;
            border: 0;
            padding: 12px 21px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

            .edit-profile-btn i {
                margin-right: 4px;
            }

        .profile-contact-row {
            display: grid;
            grid-template-columns: repeat(3,1fr);
            gap: 15px;
            margin-top: 25px;
            padding-top: 22px;
            border-top: 1px solid #edf1f7
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 11px;
            padding: 13px 15px;
            background: #f8fafc;
            border-radius: 11px
        }

        .contact-icon {
            width: 35px;
            height: 35px;
            border-radius: 9px;
            display: grid;
            place-items: center;
            background: #e8f0ff;
            color: #2563eb
        }

        .contact-text {
            min-width: 0
        }

        .contact-label {
            display: block;
            font-size: 11px;
            color: #94a3b8;
            margin-bottom: 2px
        }

        .contact-value {
            display: block;
            font-size: 13px;
            color: #334155;
            font-weight: 500;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap
        }

        .social-links {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px
        }

        .social-link {
            text-decoration: none;
            padding: 9px 14px;
            border: 1px solid #e2e8f0;
            border-radius: 9px;
            color: #475569;
            font-size: 13px;
            font-weight: 500
        }

            .social-link:hover {
                border-color: #2563eb;
                color: #2563eb;
                background: #f8fbff
            }

        @media(max-width:850px) {
            .profile-header-top {
                align-items: flex-start;
                flex-direction: column
            }

            .profile-contact-row {
                grid-template-columns: 1fr
            }
        }

        @media(max-width:550px) {
            .student-profile-page {
                padding: 22px 15px
            }

            .profile-main-info {
                align-items: flex-start;
                flex-direction: column
            }

            .profile-name {
                font-size: 23px
            }

            .edit-profile-btn {
                width: 100%
            }
        }
    </style>
    <style>
        .profile-tabs-card {
            background: #fff;
            border: 1px solid #e8edf5;
            border-radius: 16px;
            padding: 8px;
            margin-bottom: 25px;
            box-shadow: 0 5px 20px rgba(15,23,42,.06)
        }

        .profile-tabs {
            display: flex;
            gap: 5px;
            overflow-x: auto
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
            white-space: nowrap
        }

            .profile-tab:hover {
                background: #f1f5f9;
                color: #2563eb
            }

            .profile-tab.active {
                background: #2563eb;
                color: #fff;
                box-shadow: 0 4px 10px rgba(37,99,235,.2)
            }

        .profile-tab-content {
            display: none
        }

            .profile-tab-content.active {
                display: block
            }

        .profile-tab-placeholder {
            background: #fff;
            border: 1px solid #e8edf5;
            border-radius: 16px;
            padding: 42px 24px;
            text-align: center;
            box-shadow: 0 5px 20px rgba(15,23,42,.05)
        }

            .profile-tab-placeholder i {
                display: inline-grid;
                place-items: center;
                width: 48px;
                height: 48px;
                border-radius: 14px;
                background: #e8f0ff;
                color: #2563eb;
                font-size: 20px
            }

            .profile-tab-placeholder h2 {
                margin: 16px 0 6px;
                font-size: 20px
            }

            .profile-tab-placeholder p {
                margin: 0;
                color: #64748b
            }
    </style>
    <style>
        .profile-section-card {
            background: #fff;
            border: 1px solid #e8edf5;
            border-radius: 18px;
            padding: 28px;
            box-shadow: 0 6px 25px rgba(15,23,42,.06)
        }

        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            padding-bottom: 22px;
            border-bottom: 1px solid #edf1f7
        }

            .section-header h2 {
                margin: 0 0 6px;
                color: #172554;
                font-size: 21px
            }

                .section-header h2 i, .profile-subtitle i {
                    color: #2563eb;
                    margin-right: 8px
                }

            .section-header p {
                margin: 0;
                color: #64748b;
                font-size: 13px
            }

        .section-edit-btn {
            border: 1px solid #dbe5f3;
            background: #f8fafc;
            color: #2563eb;
            padding: 10px 17px;
            border-radius: 9px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer
        }

        .profile-subtitle {
            margin: 27px 0 16px;
            color: #334155;
            font-size: 15px;
            font-weight: 700
        }

        .profile-info-grid {
            display: grid;
            grid-template-columns: repeat(2,1fr);
            gap: 14px
        }

        .info-field {
            background: #f8fafc;
            border: 1px solid #edf1f5;
            border-radius: 11px;
            padding: 14px 16px;
            min-height: 62px
        }

        .info-label {
            display: block;
            color: #94a3b8;
            font-size: 11px;
            font-weight: 600;
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: .3px
        }

        .info-value {
            display: block;
            color: #334155;
            font-size: 14px;
            font-weight: 500
        }

        .full-width {
            grid-column: 1/-1
        }

        .about-box {
            background: #f8fafc;
            border: 1px solid #edf1f5;
            border-radius: 11px;
            padding: 17px 18px
        }

            .about-box p {
                margin: 0;
                color: #475569;
                font-size: 14px;
                line-height: 1.7
            }

        @media(max-width:700px) {
            .profile-section-card {
                padding: 20px
            }

            .section-header {
                align-items: flex-start;
                flex-direction: column
            }

            .profile-info-grid {
                grid-template-columns: 1fr
            }

            .full-width {
                grid-column: auto
            }
        }
    </style>
    <style>
        .education-summary {
            display: flex;
            align-items: center;
            gap: 18px;
            background: #f8fafc;
            border: 1px solid #e7edf5;
            border-radius: 13px;
            padding: 18px
        }

        .education-icon, .mini-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            background: #e8f0ff;
            color: #2563eb
        }

        .education-icon {
            width: 52px;
            height: 52px;
            min-width: 52px;
            border-radius: 12px;
            font-size: 21px
        }

        .education-details {
            flex: 1
        }

            .education-details h3 {
                margin: 0 0 5px;
                font-size: 16px;
                color: #172554
            }

            .education-details p {
                margin: 0 0 5px;
                font-size: 13px;
                color: #64748b
            }

            .education-details span {
                font-size: 12px;
                color: #94a3b8
            }

        .education-status {
            margin-left: auto
        }

        .status-badge {
            display: inline-block;
            background: #ecfdf5;
            color: #15803d;
            border: 1px solid #bbf7d0;
            padding: 7px 11px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            white-space: nowrap
        }

        .previous-education-grid {
            display: grid;
            grid-template-columns: repeat(2,1fr);
            gap: 15px
        }

        .education-mini-card {
            display: flex;
            align-items: center;
            gap: 14px;
            background: #f8fafc;
            border: 1px solid #e7edf5;
            border-radius: 12px;
            padding: 16px
        }

        .mini-icon {
            width: 42px;
            height: 42px;
            min-width: 42px;
            border-radius: 10px
        }

        .education-mini-card h4 {
            margin: 0 0 4px;
            color: #334155;
            font-size: 14px
        }

        .education-mini-card p {
            margin: 0 0 4px;
            color: #64748b;
            font-size: 12px
        }

        .education-mini-card span {
            color: #94a3b8;
            font-size: 11px
        }

        @media(max-width:700px) {
            .education-summary {
                align-items: flex-start;
                flex-wrap: wrap
            }

            .education-status {
                width: 100%;
                margin-left: 70px
            }

            .previous-education-grid {
                grid-template-columns: 1fr
            }
        }
    </style>
    <style>
        .add-skill-btn {
            border: 0;
            background: #2563eb;
            color: #fff;
            padding: 10px 17px;
            border-radius: 9px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

            .add-skill-btn i {
                margin-right: 4px;
            }

            .add-skill-btn:hover {
                background: #1d4ed8
            }

        .skills-container {
            display: grid;
            grid-template-columns: repeat(2,1fr);
            gap: 15px
        }

        .skill-card {
            background: #f8fafc;
            border: 1px solid #e7edf5;
            border-radius: 12px;
            padding: 17px
        }

        .skill-card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 15px
        }

        .skill-name {
            display: flex;
            align-items: center;
            gap: 9px;
            color: #334155;
            font-size: 14px;
            font-weight: 600
        }

            .skill-name i {
                color: #2563eb;
                font-size: 18px
            }

        .skill-level {
            background: #eff6ff;
            color: #2563eb;
            border-radius: 20px;
            padding: 5px 9px;
            font-size: 10px;
            font-weight: 600
        }

        .skill-progress {
            width: 100%;
            height: 7px;
            background: #e2e8f0;
            border-radius: 20px;
            overflow: hidden
        }

        .skill-progress-bar {
            height: 100%;
            background: #2563eb;
            border-radius: 20px
        }

        .skill-percentage {
            margin-top: 7px;
            text-align: right;
            font-size: 11px;
            color: #64748b
        }

        .soft-skill-title, .category-title {
            margin-top: 30px
        }

        .soft-skills-container, .skill-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 10px
        }

        .soft-skill-tag {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 9px 13px;
            background: #f8fafc;
            border: 1px solid #dfe7f1;
            color: #475569;
            border-radius: 9px;
            font-size: 12px;
            font-weight: 500
        }

            .soft-skill-tag i {
                color: #2563eb
            }

        .skill-tag {
            padding: 9px 14px;
            background: #eff6ff;
            border: 1px solid #dbeafe;
            color: #1d4ed8;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600
        }

        @media(max-width:700px) {
            .skills-container {
                grid-template-columns: 1fr
            }
        }
    </style>
    <style>
        .add-project-btn {
            border: 0;
            background: #2563eb;
            color: #fff;
            padding: 10px 17px;
            border-radius: 9px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer
        }

            .add-project-btn:hover {
                background: #1d4ed8
            }

        .project-card {
            background: #f8fafc;
            border: 1px solid #e4eaf2;
            border-radius: 14px;
            padding: 20px;
            margin-top: 20px
        }

        .project-card-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 15px
        }

        .project-title-area {
            display: flex;
            align-items: center;
            gap: 14px
        }

        .project-icon {
            width: 48px;
            height: 48px;
            min-width: 48px;
            border-radius: 11px;
            background: #e8f0ff;
            color: #2563eb;
            display: grid;
            place-items: center;
            font-size: 19px
        }

        .project-title-area h3 {
            margin: 0 0 5px;
            color: #172554;
            font-size: 16px
        }

        .project-type {
            color: #64748b;
            font-size: 11px
        }

        .project-actions {
            display: flex;
            gap: 7px
        }

            .project-actions button {
                width: 34px;
                height: 34px;
                border: 1px solid #dfe6ef;
                background: #fff;
                color: #64748b;
                border-radius: 8px;
                cursor: pointer
            }

                .project-actions button:hover {
                    color: #2563eb;
                    border-color: #bfdbfe;
                    background: #eff6ff
                }

        .project-description {
            margin-top: 18px
        }

            .project-description p {
                margin: 0;
                color: #475569;
                font-size: 13px;
                line-height: 1.7
            }

        .project-info {
            margin-top: 18px
        }

        .project-info-label {
            color: #475569;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 10px
        }

            .project-info-label i {
                color: #2563eb;
                margin-right: 5px
            }

        .technology-tags, .project-links {
            display: flex;
            flex-wrap: wrap;
            gap: 8px
        }

            .technology-tags span {
                padding: 7px 11px;
                background: #fff;
                border: 1px solid #dbe5f0;
                border-radius: 7px;
                color: #475569;
                font-size: 11px
            }

        .project-details-grid {
            display: grid;
            grid-template-columns: repeat(3,1fr);
            gap: 12px;
            margin-top: 20px;
            padding-top: 18px;
            border-top: 1px solid #e5eaf1
        }

            .project-details-grid > div {
                display: flex;
                flex-direction: column;
                gap: 5px
            }

        .project-label {
            color: #94a3b8;
            font-size: 10px;
            font-weight: 600;
            text-transform: uppercase
        }

        .project-value {
            color: #334155;
            font-size: 12px;
            font-weight: 600
        }

        .project-links {
            margin-top: 18px
        }

        .project-link {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            text-decoration: none;
            padding: 8px 12px;
            background: #fff;
            border: 1px solid #dbe5f0;
            border-radius: 8px;
            color: #2563eb;
            font-size: 11px;
            font-weight: 600
        }

            .project-link:hover {
                background: #eff6ff;
                border-color: #bfdbfe
            }

        .add-project-placeholder {
            margin-top: 20px;
            padding: 25px;
            border: 1.5px dashed #cbd5e1;
            border-radius: 13px;
            text-align: center
        }

        .placeholder-icon {
            width: 42px;
            height: 42px;
            margin: 0 auto 10px;
            border-radius: 50%;
            background: #eff6ff;
            color: #2563eb;
            display: grid;
            place-items: center
        }

        .add-project-placeholder h4 {
            margin: 0 0 5px;
            color: #334155;
            font-size: 14px
        }

        .add-project-placeholder p {
            margin: 0;
            color: #94a3b8;
            font-size: 11px
        }

        @media(max-width:700px) {
            .project-card-header {
                flex-direction: column
            }

            .project-actions {
                align-self: flex-end
            }

            .project-details-grid {
                grid-template-columns: 1fr
            }
        }
    </style>
    <style>
        .add-certificate-btn, .add-project-btn {
            border: 0;
            background: #2563eb;
            color: #fff;
            padding: 10px 17px;
            border-radius: 9px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

            .add-certificate-btn i, .add-project-btn i {
                margin-right: 4px;
            }

            .add-certificate-btn:hover, .add-project-btn:hover {
                background: #1d4ed8
            }

        .certificate-card {
            background: #f8fafc;
            border: 1px solid #e4eaf2;
            border-radius: 14px;
            padding: 20px;
            margin-top: 20px
        }

        .certificate-main {
            display: flex;
            align-items: flex-start;
            gap: 17px
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
            font-size: 21px
        }

        .certificate-content {
            flex: 1;
            min-width: 0
        }

        .certificate-title-row {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 15px
        }

            .certificate-title-row h3 {
                margin: 0 0 5px;
                color: #172554;
                font-size: 16px
            }

        .certificate-issuer {
            margin: 0;
            color: #64748b;
            font-size: 12px
        }

        .certificate-status {
            background: #ecfdf5;
            color: #15803d;
            border: 1px solid #bbf7d0;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 10px;
            font-weight: 600;
            white-space: nowrap
        }

        .certificate-details {
            display: flex;
            flex-wrap: wrap;
            gap: 35px;
            margin-top: 16px;
            padding-top: 14px;
            border-top: 1px solid #e5eaf1
        }

        .certificate-detail {
            display: flex;
            flex-direction: column;
            gap: 4px
        }

            .certificate-detail span {
                color: #94a3b8;
                font-size: 10px;
                text-transform: uppercase;
                font-weight: 600
            }

            .certificate-detail strong {
                color: #475569;
                font-size: 12px
            }

        .certificate-actions {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
            margin-top: 16px
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
            font-weight: 600
        }

            .certificate-action:hover, .certificate-action.primary {
                color: #2563eb;
                border-color: #bfdbfe;
                background: #eff6ff
            }

        .certificate-icon-btn {
            width: 34px;
            height: 34px;
            border: 1px solid #dbe5f0;
            background: #fff;
            color: #64748b;
            border-radius: 8px;
            cursor: pointer
        }

            .certificate-icon-btn:hover {
                color: #2563eb;
                border-color: #bfdbfe;
                background: #eff6ff
            }

            .certificate-icon-btn.delete:hover {
                color: #dc2626;
                border-color: #fecaca;
                background: #fef2f2
            }

        .add-certificate-placeholder {
            margin-top: 20px;
            padding: 25px;
            border: 1.5px dashed #cbd5e1;
            border-radius: 13px;
            text-align: center
        }

        .certificate-placeholder-icon {
            width: 42px;
            height: 42px;
            margin: 0 auto 10px;
            border-radius: 50%;
            background: #eff6ff;
            color: #2563eb;
            display: grid;
            place-items: center
        }

        .add-certificate-placeholder h4 {
            margin: 0 0 5px;
            color: #334155;
            font-size: 14px
        }

        .add-certificate-placeholder p {
            margin: 0;
            color: #94a3b8;
            font-size: 11px
        }

        @media(max-width:650px) {
            .certificate-main {
                flex-direction: column
            }

            .certificate-title-row {
                flex-direction: column
            }

            .certificate-status {
                align-self: flex-start
            }

            .certificate-details {
                gap: 18px
            }
        }

        .upload-resume-btn {
            border: 0;
            background: #2563eb;
            color: #fff;
            padding: 10px 17px;
            border-radius: 9px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

            .upload-resume-btn i {
                margin-right: 4px;
            }

            .upload-resume-btn:hover {
                background: #1d4ed8;
            }

        .resume-current-card {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            background: #f8fafc;
            border: 1px solid #e4eaf2;
            border-radius: 14px;
            padding: 20px;
            margin-top: 20px
        }

        .resume-file-left {
            display: flex;
            align-items: center;
            gap: 15px;
            min-width: 0
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
            font-size: 23px
        }

        .resume-file-info {
            min-width: 0
        }

            .resume-file-info h3 {
                margin: 0 0 9px;
                color: #172554;
                font-size: 16px;
                overflow-wrap: anywhere
            }

        .resume-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 8px 16px;
            color: #64748b;
            font-size: 11px
        }

            .resume-meta i {
                color: #2563eb;
                margin-right: 4px
            }

        .resume-actions {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
            justify-content: flex-end
        }

        .resume-action-btn, .resume-delete-btn {
            border: 1px solid #dbe5f0;
            background: #fff;
            color: #475569;
            border-radius: 8px;
            padding: 8px 11px;
            font-size: 11px;
            font-weight: 600;
            cursor: pointer
        }

            .resume-action-btn.primary {
                color: #2563eb;
                border-color: #bfdbfe;
                background: #eff6ff
            }

        .resume-delete-btn {
            width: 34px;
            height: 34px;
            padding: 0;
            color: #dc2626
        }

        .resume-upload-area {
            margin-top: 20px;
            padding: 28px;
            border: 1.5px dashed #cbd5e1;
            border-radius: 14px;
            text-align: center
        }

        .resume-upload-icon {
            width: 48px;
            height: 48px;
            margin: 0 auto 12px;
            display: grid;
            place-items: center;
            border-radius: 14px;
            background: #eff6ff;
            color: #2563eb;
            font-size: 21px
        }

        .resume-upload-area h3 {
            margin: 0 0 6px;
            color: #172554;
            font-size: 17px
        }

        .resume-upload-area p {
            margin: 0 0 16px;
            color: #64748b;
            font-size: 13px
        }

        .browse-resume-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 9px 14px;
            border-radius: 9px;
            background: #2563eb;
            color: #fff;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer
        }

            .browse-resume-btn input {
                display: none
            }

        .resume-upload-note {
            display: block;
            margin-top: 12px;
            color: #94a3b8;
            font-size: 11px
        }

        .resume-tips-box {
            display: flex;
            gap: 13px;
            margin-top: 20px;
            padding: 16px;
            background: #fffbeb;
            border: 1px solid #fde68a;
            border-radius: 12px
        }

        .resume-tip-icon {
            color: #d97706;
            font-size: 19px
        }

        .resume-tips-box h4 {
            margin: 0 0 5px;
            color: #92400e;
            font-size: 14px
        }

        .resume-tips-box p {
            margin: 0;
            color: #92400e;
            font-size: 12px;
            line-height: 1.6
        }

        @media(max-width:700px) {
            .resume-current-card {
                align-items: flex-start;
                flex-direction: column
            }

            .resume-actions {
                justify-content: flex-start
            }

            .resume-tips-box {
                align-items: flex-start
            }
        }

        @media(max-width:550px) {
            .section-header {
                align-items: flex-start;
                flex-direction: column
            }

            .upload-resume-btn {
                width: 100%
            }
        }
    </style>
    <style>
        .edit-profile-modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(15,23,42,.55);
            z-index: 9999;
            padding: 30px 20px;
            overflow-y: auto
        }

            .edit-profile-modal.show {
                display: flex;
                align-items: flex-start;
                justify-content: center
            }

        .edit-profile-box {
            width: 100%;
            max-width: 900px;
            background: #fff;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(15,23,42,.2)
        }

        .edit-modal-header {
            padding: 20px 25px;
            border-bottom: 1px solid #e5eaf2;
            display: flex;
            align-items: center;
            justify-content: space-between
        }

            .edit-modal-header h2 {
                margin: 0 0 5px;
                font-size: 20px;
                color: #0f172a
            }

            .edit-modal-header p {
                margin: 0;
                color: #64748b;
                font-size: 12px
            }

        .close-edit-modal {
            width: 36px;
            height: 36px;
            border: 0;
            background: #f1f5f9;
            color: #475569;
            border-radius: 8px;
            cursor: pointer;
            font-size: 17px
        }

        .edit-profile-form {
            padding: 25px;
            max-height: 65vh;
            overflow-y: auto
        }

        .edit-form-section {
            margin-bottom: 25px
        }

            .edit-form-section h3 {
                margin: 0 0 16px;
                padding-bottom: 10px;
                border-bottom: 1px solid #e8edf5;
                color: #1e293b;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 8px
            }

                .edit-form-section h3 i {
                    color: #2563eb
                }

        .edit-form-grid {
            display: grid;
            grid-template-columns: repeat(2,1fr);
            gap: 16px
        }

        .edit-field {
            display: flex;
            flex-direction: column;
            gap: 6px
        }

            .edit-field.full-width {
                grid-column: 1/-1
            }

            .edit-field label {
                color: #475569;
                font-size: 12px;
                font-weight: 600
            }

            .edit-field input, .edit-field select, .edit-field textarea {
                width: 100%;
                box-sizing: border-box;
                border: 1px solid #dbe2ea;
                background: #fff;
                color: #1e293b;
                border-radius: 8px;
                padding: 10px 12px;
                font-size: 13px;
                font-family: inherit;
                outline: none
            }

                .edit-field input:focus, .edit-field select:focus, .edit-field textarea:focus {
                    border-color: #2563eb;
                    box-shadow: 0 0 0 3px rgba(37,99,235,.08)
                }

            .edit-field textarea {
                resize: vertical
            }

        .edit-modal-footer {
            padding: 16px 25px;
            border-top: 1px solid #e5eaf2;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            background: #f8fafc
        }

        .cancel-edit-btn, .save-profile-btn {
            border: 0;
            padding: 10px 17px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer
        }

        .cancel-edit-btn {
            background: #fff;
            border: 1px solid #dbe2ea;
            color: #475569
        }

        .save-profile-btn {
            background: #2563eb;
            color: #fff
        }

            .save-profile-btn:hover {
                background: #1d4ed8
            }

        @media(max-width:650px) {
            .edit-profile-modal {
                padding: 10px
            }

            .edit-form-grid {
                grid-template-columns: 1fr
            }

            .edit-field.full-width {
                grid-column: auto
            }

            .edit-profile-form {
                padding: 18px
            }

            .edit-modal-footer {
                padding: 14px 18px
            }
        }
    </style>
    <style>
        .skill-delete-btn {
            margin-left: auto;
            border: 0;
            background: transparent;
            color: #ef4444 !important;
            cursor: pointer;
            font-size: 13px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 22px;
            height: 22px;
            border-radius: 50%;
            transition: all 0.2s ease;
            text-decoration: none;
            line-height: 1;
        }

            .skill-delete-btn:hover {
                color: #ffffff !important;
                background-color: #ef4444 !important;
                transform: scale(1.1);
            }

        .soft-skill-tag, .skill-tag {
            position: relative;
            padding-right: 32px !important;
            display: inline-flex;
            align-items: center;
        }

            .skill-tag .skill-delete-btn,
            .soft-skill-tag .skill-delete-btn {
                position: absolute;
                right: 6px;
                top: 50%;
                transform: translateY(-50%);
            }

                .skill-tag .skill-delete-btn:hover,
                .soft-skill-tag .skill-delete-btn:hover {
                    transform: translateY(-50%) scale(1.1);
                }


        .skill-card {
            position: relative
        }

            .skill-card .skill-delete-btn {
                position: absolute;
                right: 10px;
                bottom: 10px
            }

            .skill-card .skill-card-top {
                padding-right: 22px
            }
    </style>
    <style>
        .profile-subtitle {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap
        }

        .education-add-btn {
            margin-left: auto;
            padding: 7px 11px;
            font-size: 11px
        }

        .education-mini-card {
            position: relative;
            padding-right: 90px
        }

        .education-card-actions {
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            display: flex;
            gap: 5px
        }

            .education-card-actions button {
                width: 28px;
                height: 28px;
                border: 1px solid #dbe5f0;
                background: #fff;
                color: #64748b;
                border-radius: 7px;
                cursor: pointer
            }

                .education-card-actions button:hover {
                    color: #2563eb
                }

                .education-card-actions button[title="Delete"]:hover {
                    color: #dc2626
                }
    </style>
    <style>
        .delete-confirm-modal {
            display: none;
            position: fixed;
            inset: 0;
            z-index: 10001;
            background: rgba(15,23,42,.55);
            align-items: center;
            justify-content: center;
            padding: 20px
        }

            .delete-confirm-modal.show {
                display: flex
            }

        .delete-confirm-box {
            width: 100%;
            max-width: 410px;
            background: #fff;
            border-radius: 22px;
            padding: 30px 25px 24px;
            text-align: center;
            box-shadow: 0 20px 60px rgba(15,23,42,.22)
        }

        .delete-confirm-icon {
            width: 68px;
            height: 68px;
            margin: 0 auto 18px;
            display: grid;
            place-items: center;
            border-radius: 18px;
            background: #fee8e8;
            color: #ef4444;
            font-size: 27px
        }

        .delete-confirm-box h2 {
            margin: 0 0 8px;
            color: #172554;
            font-size: 21px
        }

        .delete-confirm-box p {
            margin: 0 0 24px;
            color: #64748b;
            font-size: 14px
        }

        .delete-confirm-actions {
            display: flex;
            gap: 12px
        }

        .delete-cancel-btn, .delete-confirm-btn {
            flex: 1;
            border: 0;
            border-radius: 11px;
            padding: 12px 10px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer
        }

        .delete-cancel-btn {
            background: #eff6ff;
            color: #2563eb
        }

        .delete-confirm-btn {
            background: #ef4444;
            color: #fff
        }

            .delete-confirm-btn:hover {
                background: #dc2626
            }

        @media(max-width:480px) {
            .delete-confirm-actions {
                flex-direction: column
            }
        }
    </style>
    <style>
        .required-mark {
            color: #ef4444;
            margin-left: 3px
        }

        .edit-field input::placeholder, .edit-field textarea::placeholder {
            color: #a5b3c7
        }

        .edit-profile-box input[type="number"] {
            appearance: textfield
        }
    </style>
    <style>
        .professional-links-grid {
            display: grid;
            grid-template-columns: repeat(3,1fr);
            gap: 12px
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
            transition: .2s
        }

            .professional-link-card:hover {
                border-color: #93b8f7;
                background: #eff6ff;
                transform: translateY(-1px)
            }

        .professional-link-icon {
            width: 34px;
            height: 34px;
            min-width: 34px;
            display: grid;
            place-items: center;
            border-radius: 9px;
            background: #e8f0ff;
            color: #2563eb
        }

            .professional-link-icon.linkedin {
                background: #e8f3ff;
                color: #0a66c2
            }

            .professional-link-icon.github {
                background: #eef0f3;
                color: #24292f
            }

            .professional-link-icon.portfolio {
                background: #eaf8f4;
                color: #0a9b72
            }

        .professional-link-card strong {
            display: block;
            font-size: 13px
        }

        .professional-link-card small {
            display: block;
            margin-top: 3px;
            color: #94a3b8;
            font-size: 10px
        }

        .link-arrow {
            margin-left: auto;
            color: #94a3b8;
            font-size: 11px
        }

        @media(max-width:800px) {
            .professional-links-grid {
                grid-template-columns: 1fr
            }
        }
    </style>
    <style>
        #profileCrudModal .edit-profile-box {
            max-width: 1125px;
            border-radius: 20px
        }

        #profileCrudModal .edit-modal-header {
            padding: 22px 30px
        }

            #profileCrudModal .edit-modal-header h2 {
                text-transform: capitalize;
                font-size: 25px
            }

            #profileCrudModal .edit-modal-header p {
                font-size: 15px
            }

        #profileCrudModal .edit-profile-form {
            padding: 26px 30px;
            max-height: none
        }

        #profileCrudModal .edit-form-grid {
            gap: 20px
        }

        #profileCrudModal .edit-field {
            gap: 7px
        }

            #profileCrudModal .edit-field label {
                font-size: 14px
            }

            #profileCrudModal .edit-field input, #profileCrudModal .edit-field textarea, #profileCrudModal .edit-field select {
                min-height: 46px;
                border-radius: 10px;
                font-size: 15px;
                padding: 11px 14px
            }

        #profileCrudModal .edit-modal-footer {
            padding: 20px 30px
        }

        #profileCrudModal .cancel-edit-btn, #profileCrudModal .save-profile-btn {
            min-width: 100px;
            padding: 12px 18px;
            font-size: 14px
        }

        @media(max-width:650px) {
            #profileCrudModal .edit-modal-header, #profileCrudModal .edit-profile-form, #profileCrudModal .edit-modal-footer {
                padding-left: 18px;
                padding-right: 18px
            }
        }
    </style>
    <style>
        .education-summary {
            display: block
        }

        .education-summary-top {
            display: flex;
            align-items: center;
            gap: 18px
        }

        .education-summary-grid {
            display: grid;
            grid-template-columns: repeat(3,1fr);
            gap: 12px;
            margin-top: 20px;
            padding-top: 18px;
            border-top: 1px solid #e5eaf1
        }

            .education-summary-grid div {
                display: flex;
                flex-direction: column;
                gap: 5px
            }

            .education-summary-grid span {
                color: #94a3b8;
                font-size: 10px;
                font-weight: 600;
                text-transform: uppercase
            }

            .education-summary-grid strong {
                color: #334155;
                font-size: 13px
            }

        @media(max-width:700px) {
            .education-summary-top {
                align-items: flex-start;
                flex-wrap: wrap
            }

            .education-summary-grid {
                grid-template-columns: repeat(2,1fr)
            }
        }

        @media(max-width:480px) {
            .education-summary-grid {
                grid-template-columns: 1fr
            }

            .education-status {
                width: auto;
                margin-left: auto
            }
        }
    </style>
    <style>
        #profileCrudModal.education-crud .edit-form-grid {
            grid-template-columns: 1fr
        }
    </style>
    <style>
        .skill-category-choice {
            display: grid;
            grid-template-columns: repeat(3,1fr);
            gap: 12px;
            margin-bottom: 25px
        }

        .skill-category-card {
            border: 1px solid #dbe5f0;
            background: #f8fafc;
            color: #475569;
            border-radius: 12px;
            padding: 16px 12px;
            text-align: left;
            cursor: pointer;
            display: grid;
            gap: 6px
        }

            .skill-category-card i {
                color: #2563eb;
                font-size: 20px
            }

            .skill-category-card strong {
                font-size: 13px
            }

            .skill-category-card small {
                color: #94a3b8;
                font-size: 11px
            }

            .skill-category-card.active {
                border-color: #2563eb;
                background: #eff6ff;
                box-shadow: 0 0 0 2px #dbeafe
            }

        .skill-name-field {
            max-width: 100%
        }

        @media(max-width:650px) {
            .skill-category-choice {
                grid-template-columns: 1fr
            }

            .skill-category-card {
                grid-template-columns: auto 1fr;
                align-items: center
            }

                .skill-category-card small {
                    grid-column: 2
                }
        }
    </style>
    <style>
        #skillModal {
            position: fixed;
            inset: 0;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 20px;
            overflow-y: auto
        }

            #skillModal.show {
                display: flex
            }

            #skillModal .skill-modal-box {
                width: min(720px,100%);
                max-height: calc(100vh - 40px);
                margin: 0
            }

        @media(max-width:650px) {
            #skillModal {
                padding: 12px
            }

                #skillModal .skill-modal-box {
                    max-height: calc(100vh - 24px)
                }
        }
    </style>
    <style>
        #profileCrudModal.education-crud {
            align-items: center;
            justify-content: center;
            padding: 24px;
            background: rgba(15,23,42,.58)
        }

            #profileCrudModal.education-crud .edit-profile-box {
                width: min(720px,100%);
                max-width: 720px;
                max-height: calc(100vh - 48px);
                margin: 0;
                border-radius: 20px;
                display: flex;
                flex-direction: column
            }

            #profileCrudModal.education-crud .edit-modal-header {
                padding: 22px 36px
            }

            #profileCrudModal.education-crud .edit-profile-form {
                padding: 30px 36px;
                overflow-y: auto;
                max-height: calc(100vh - 190px)
            }

            #profileCrudModal.education-crud .edit-form-grid {
                gap: 18px
            }

            #profileCrudModal.education-crud .edit-modal-footer {
                margin-top: auto;
                padding: 18px 36px;
                justify-content: flex-end
            }

        .education-add-btn {
            margin-left: auto;
            white-space: nowrap
        }

        @media(max-width:650px) {
            #profileCrudModal.education-crud {
                padding: 12px
            }

                #profileCrudModal.education-crud .edit-profile-box {
                    max-height: calc(100vh - 24px)
                }

                #profileCrudModal.education-crud .edit-modal-header, #profileCrudModal.education-crud .edit-profile-form, #profileCrudModal.education-crud .edit-modal-footer {
                    padding-left: 22px;
                    padding-right: 22px
                }

                #profileCrudModal.education-crud .edit-profile-form {
                    padding-top: 24px;
                    padding-bottom: 24px;
                    max-height: calc(100vh - 175px)
                }

            .education-add-btn {
                margin-left: 0;
                width: 100%
            }
        }
    </style>
    <style>
        .skills-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px
        }

            .skills-container .skill-card {
                position: relative;
                display: inline-flex;
                align-items: center;
                width: auto;
                min-width: 0;
                padding: 9px 34px 9px 14px;
                border: 1px solid #dbeafe;
                border-radius: 22px;
                background: #eff6ff
            }

            .skills-container .skill-card-top {
                margin: 0;
                padding: 0
            }

            .skills-container .skill-name {
                color: #1d4ed8;
                font-size: 13px
            }

                .skills-container .skill-name i {
                    display: none
                }

            .skills-container .skill-level, .skills-container .skill-progress, .skills-container .skill-percentage {
                display: none
            }

            .skills-container .skill-delete-btn {
                right: 9px;
                bottom: auto;
                top: 50%;
                transform: translateY(-50%);
                margin: 0;
                color: #ef4444 !important;
            }

                .skills-container .skill-delete-btn:hover {
                    color: #ffffff !important;
                    background-color: #ef4444 !important;
                }

        .skill-modal-box {
            max-width: 720px !important
        }
    </style>
    <style>
        .add-education-btn {
            margin-left: auto;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            border: 0;
            border-radius: 9px;
            background: #2563eb;
            color: #fff;
            padding: 10px 16px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 5px 12px rgba(37,99,235,.18)
        }

            .add-education-btn:hover {
                background: #1d4ed8;
                transform: translateY(-1px)
            }

        #profileCrudModal.education-crud .edit-profile-form {
            padding: 28px 30px
        }

        #profileCrudModal.education-crud .edit-modal-footer {
            padding: 18px 30px
        }

        @media(max-width:650px) {
            .add-education-btn {
                margin-left: 0;
                width: 100%;
                justify-content: center
            }

            #profileCrudModal.education-crud .edit-profile-form {
                padding: 22px 18px
            }
        }
        /* ================= SKILLS MAIN ================= */

        .skills-main-card {
            background: #ffffff;
            border-radius: 24px;
            padding: 28px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.05);
        }


        /* ================= HEADER ================= */

        .skills-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
        }

        .skills-title-area {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .skills-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: #eaf2ff;
            color: #2563eb;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 21px;
        }

        .skills-title-area h2 {
            margin: 0;
            font-size: 22px;
            font-weight: 700;
            color: #172033;
        }

        .skills-title-area p {
            margin: 4px 0 0;
            font-size: 12px;
            color: #7b8495;
        }


        /* ================= ADD BUTTON ================= */

        .add-skill-btn {
            border: none;
            background: #2563eb;
            color: white;
            padding: 11px 18px;
            border-radius: 9px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 7px;
            transition: 0.2s;
        }

            .add-skill-btn:hover {
                background: #1d4ed8;
            }


        /* ================= CATEGORY BOX ================= */

        .skill-category-box {
            border: 1px solid #e5eaf2;
            border-radius: 13px;
            padding: 20px;
            margin-bottom: 16px;
            background: #ffffff;
        }


        /* ================= CATEGORY TITLE ================= */

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


        /* Technical */

        .technical-icon {
            background: #e8f1ff;
            color: #2563eb;
        }


        /* Soft */

        .soft-icon {
            background: #e1f8f3;
            color: #15967e;
        }


        /* Other */

        .other-icon {
            background: #eee8ff;
            color: #7048d8;
        }


        /* ================= SKILLS LIST ================= */

        .skills-list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }


        /* ================= SKILL PILL ================= */

        .skill-pill {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 8px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }


        /* Technical */

        .technical-pill {
            background: #eaf2ff;
            color: #24559d;
        }


        /* Soft */

        .soft-pill {
            background: #e1f8f3;
            color: #147c6c;
        }


        /* Other */

        .other-pill {
            background: #eee8ff;
            color: #6845bd;
        }


        /* ================= DELETE ================= */

        .skill-delete-btn {
            color: #ff4d67 !important;
            text-decoration: none !important;
            font-size: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s;
        }

            .skill-delete-btn:hover {
                color: #dc263f !important;
                transform: scale(1.15);
            }


        /* ================= EMPTY MESSAGE ================= */

        .no-skill-text {
            color: #9aa2b1;
            font-size: 12px;
            display: none;
        }


        /* ================= MOBILE ================= */

        @media (max-width: 768px) {

            .skills-main-card {
                padding: 18px;
                border-radius: 18px;
            }

            .skills-header {
                align-items: flex-start;
                gap: 15px;
            }

            .skills-title-area h2 {
                font-size: 19px;
            }

            .skills-title-area p {
                font-size: 11px;
            }

            .add-skill-btn {
                padding: 9px 12px;
                font-size: 11px;
            }

            .skill-category-box {
                padding: 15px;
            }

            .skill-pill {
                font-size: 11px;
                padding: 7px 10px;
            }
        }
    </style>

    <style>
        #projects .add-project-placeholder, #certifications .add-certificate-placeholder {
            display: none !important
        }
    </style>
    <style>
        #projectModal,
        #profileCrudModal.project-crud {
            align-items: center;
            justify-content: center;
            padding: 30px 20px;
            background: rgba(15, 23, 42, 0.45);
            backdrop-filter: blur(4px);
            position: fixed;
            inset: 0;
            display: none;
            z-index: 9999;
            overflow-y: auto;
        }

            #projectModal.show,
            #profileCrudModal.project-crud.show {
                display: flex;
            }

            #projectModal .edit-profile-box,
            #profileCrudModal.project-crud .edit-profile-box {
                width: min(840px, 100%);
                max-width: 840px;
                max-height: 90vh;
                margin: 0 auto;
                padding: 10px 8px 14px;
                border-radius: 20px;
                display: flex;
                flex-direction: column;
                background: #ffffff;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                border: 1px solid #e2e8f0;
                overflow: hidden;
                box-sizing: border-box;
            }

            #projectModal .edit-modal-header,
            #profileCrudModal.project-crud .edit-modal-header {
                padding: 24px 32px 18px;
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                border-bottom: none;
                box-sizing: border-box;
            }

            #projectModal .project-modal-header-left,
            #profileCrudModal.project-crud .project-modal-header-left {
                display: flex;
                align-items: center;
                gap: 16px;
            }

            #projectModal .project-header-icon,
            #profileCrudModal.project-crud .project-header-icon {
                width: 52px;
                height: 52px;
                background: #eef4ff;
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #2563eb;
                font-size: 22px;
                font-weight: 700;
                flex-shrink: 0;
            }

            #projectModal .edit-modal-header h2,
            #profileCrudModal.project-crud .edit-modal-header h2 {
                font-size: 24px;
                font-weight: 800;
                color: #0f172a;
                margin: 0 0 4px 0;
                letter-spacing: -0.02em;
            }

            #projectModal .edit-modal-header p,
            #profileCrudModal.project-crud .edit-modal-header p {
                font-size: 14px;
                color: #64748b;
                margin: 0;
            }

            #projectModal .close-edit-modal,
            #profileCrudModal.project-crud .close-edit-modal {
                width: 36px;
                height: 36px;
                border-radius: 10px;
                background: #f1f5f9;
                color: #475569;
                border: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 15px;
                transition: all 0.2s ease;
                margin-top: 4px;
            }

                #projectModal .close-edit-modal:hover,
                #profileCrudModal.project-crud .close-edit-modal:hover {
                    background: #e2e8f0;
                    color: #0f172a;
                }

            #projectModal .edit-profile-form,
            #profileCrudModal.project-crud .edit-profile-form {
                padding: 10px 32px 24px;
                overflow-y: auto;
                box-sizing: border-box;
            }

            #projectModal .edit-form-grid,
            #profileCrudModal.project-crud .edit-form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                box-sizing: border-box;
            }

            #projectModal .edit-field,
            #profileCrudModal.project-crud .edit-field {
                display: flex;
                flex-direction: column;
                gap: 8px;
                box-sizing: border-box;
            }

                #projectModal .edit-field.full-width,
                #profileCrudModal.project-crud .edit-field.full-width {
                    grid-column: 1 / -1;
                }

                #projectModal .edit-field label,
                #profileCrudModal.project-crud .edit-field label {
                    font-size: 14px;
                    font-weight: 700;
                    color: #1e293b;
                }

            #projectModal .required-mark,
            #profileCrudModal.project-crud .required-mark {
                color: #ef4444;
                margin-left: 2px;
            }

            #projectModal .optional-mark,
            #profileCrudModal.project-crud .optional-mark {
                font-size: 13px;
                font-weight: 500;
                color: #64748b;
                margin-left: 4px;
            }

            #projectModal .input-with-icon,
            #profileCrudModal.project-crud .input-with-icon {
                position: relative;
                display: flex;
                align-items: center;
                width: 100%;
                box-sizing: border-box;
            }

                #projectModal .input-with-icon .field-icon,
                #profileCrudModal.project-crud .input-with-icon .field-icon {
                    position: absolute;
                    left: 16px;
                    color: #64748b;
                    font-size: 16px;
                    pointer-events: none;
                    z-index: 1;
                }

                #projectModal .input-with-icon input,
                #projectModal .input-with-icon select,
                #profileCrudModal.project-crud .input-with-icon input,
                #profileCrudModal.project-crud .input-with-icon select {
                    width: 100%;
                    min-height: 52px;
                    padding: 12px 16px 12px 46px;
                    border: 1.5px solid #e2e8f0;
                    border-radius: 12px;
                    background: #ffffff;
                    color: #1e293b;
                    font-size: 14px;
                    transition: all 0.2s ease;
                    outline: none;
                    box-sizing: border-box;
                }

                    #projectModal .input-with-icon input:focus,
                    #projectModal .input-with-icon select:focus,
                    #projectModal .textarea-with-icon textarea:focus,
                    #profileCrudModal.project-crud .input-with-icon input:focus,
                    #profileCrudModal.project-crud .input-with-icon select:focus,
                    #profileCrudModal.project-crud .textarea-with-icon textarea:focus {
                        border-color: #3b82f6;
                        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.12);
                    }

                    #projectModal .input-with-icon input::placeholder,
                    #projectModal .textarea-with-icon textarea::placeholder,
                    #profileCrudModal.project-crud .input-with-icon input::placeholder,
                    #profileCrudModal.project-crud .textarea-with-icon textarea::placeholder {
                        color: #94a3b8;
                        font-size: 14px;
                    }

                #projectModal .input-with-icon select,
                #profileCrudModal.project-crud .input-with-icon select {
                    appearance: none;
                    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%23475569'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'%3E%3C/path%3E%3C/svg%3E");
                    background-repeat: no-repeat;
                    background-position: right 16px center;
                    background-size: 16px;
                    cursor: pointer;
                }

            #projectModal .textarea-with-icon,
            #profileCrudModal.project-crud .textarea-with-icon {
                position: relative;
                display: flex;
                flex-direction: column;
                width: 100%;
                box-sizing: border-box;
            }

                #projectModal .textarea-with-icon .field-icon,
                #profileCrudModal.project-crud .textarea-with-icon .field-icon {
                    position: absolute;
                    left: 16px;
                    top: 16px;
                    color: #64748b;
                    font-size: 16px;
                    pointer-events: none;
                }

                #projectModal .textarea-with-icon textarea,
                #profileCrudModal.project-crud .textarea-with-icon textarea {
                    width: 100%;
                    min-height: 120px;
                    padding: 14px 16px 28px 46px;
                    border: 1.5px solid #e2e8f0;
                    border-radius: 12px;
                    background: #ffffff;
                    color: #1e293b;
                    font-size: 14px;
                    font-family: inherit;
                    line-height: 1.5;
                    resize: vertical;
                    outline: none;
                    box-sizing: border-box;
                }

            #projectModal .char-count,
            #profileCrudModal.project-crud .char-count {
                position: absolute;
                right: 14px;
                bottom: 10px;
                font-size: 12px;
                color: #64748b;
                pointer-events: none;
                font-weight: 500;
            }

            #projectModal .edit-modal-footer,
            #profileCrudModal.project-crud .edit-modal-footer {
                padding: 16px 32px 26px;
                display: flex;
                align-items: center;
                justify-content: flex-end;
                gap: 12px;
                border-top: none;
                box-sizing: border-box;
            }

            #projectModal .cancel-edit-btn,
            #profileCrudModal.project-crud .cancel-edit-btn {
                min-width: 90px;
                height: 44px;
                padding: 0 20px;
                border-radius: 10px;
                border: 1px solid #e2e8f0;
                background: #ffffff;
                color: #334155;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
            }

                #projectModal .cancel-edit-btn:hover,
                #profileCrudModal.project-crud .cancel-edit-btn:hover {
                    background: #f8fafc;
                    border-color: #cbd5e1;
                }

            #projectModal .save-profile-btn,
            #profileCrudModal.project-crud .save-profile-btn {
                min-width: 100px;
                height: 44px;
                padding: 0 22px;
                border-radius: 10px;
                border: none;
                background: #2563eb;
                color: #ffffff;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
                transition: all 0.2s ease;
            }

                #projectModal .save-profile-btn:hover,
                #profileCrudModal.project-crud .save-profile-btn:hover {
                    background: #1d4ed8;
                    box-shadow: 0 6px 16px rgba(37, 99, 235, 0.35);
                }

        @media(max-width:650px) {
            #projectModal,
            #profileCrudModal.project-crud {
                padding: 12px;
            }

                #projectModal .edit-modal-header,
                #projectModal .edit-profile-form,
                #projectModal .edit-modal-footer,
                #profileCrudModal.project-crud .edit-modal-header,
                #profileCrudModal.project-crud .edit-profile-form,
                #profileCrudModal.project-crud .edit-modal-footer {
                    padding-left: 18px;
                    padding-right: 18px;
                }

                #projectModal .edit-form-grid,
                #profileCrudModal.project-crud .edit-form-grid {
                    grid-template-columns: 1fr;
                }
        }
    </style>
    <style>
        #certificateModal,
        #profileCrudModal.certificate-crud {
            align-items: center;
            justify-content: center;
            padding: 30px 20px;
            background: rgba(15, 23, 42, 0.45);
            backdrop-filter: blur(4px);
            position: fixed;
            inset: 0;
            display: none;
            z-index: 9999;
            overflow-y: auto;
        }

            #certificateModal.show,
            #profileCrudModal.certificate-crud.show {
                display: flex;
            }

            #certificateModal .edit-profile-box,
            #profileCrudModal.certificate-crud .edit-profile-box {
                width: min(840px, 100%);
                max-width: 840px;
                max-height: 90vh;
                margin: 0 auto;
                padding: 10px 8px 14px;
                border-radius: 20px;
                display: flex;
                flex-direction: column;
                background: #ffffff;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                border: 1px solid #e2e8f0;
                overflow: hidden;
                box-sizing: border-box;
            }

            #certificateModal .edit-modal-header,
            #profileCrudModal.certificate-crud .edit-modal-header {
                padding: 24px 32px 18px;
                display: flex;
                align-items: flex-start;
                justify-content: space-between;
                border-bottom: none;
                box-sizing: border-box;
            }

            #certificateModal .certificate-modal-header-left,
            #profileCrudModal.certificate-crud .project-modal-header-left {
                display: flex;
                align-items: center;
                gap: 16px;
            }

            #certificateModal .certificate-header-icon,
            #profileCrudModal.certificate-crud .project-header-icon {
                width: 52px;
                height: 52px;
                background: #eef4ff;
                border-radius: 14px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #2563eb;
                font-size: 22px;
                font-weight: 700;
                flex-shrink: 0;
            }

            #certificateModal .edit-modal-header h2,
            #profileCrudModal.certificate-crud .edit-modal-header h2 {
                font-size: 24px;
                font-weight: 800;
                color: #0f172a;
                margin: 0 0 4px 0;
                letter-spacing: -0.02em;
            }

            #certificateModal .edit-modal-header p,
            #profileCrudModal.certificate-crud .edit-modal-header p {
                font-size: 14px;
                color: #64748b;
                margin: 0;
            }

            #certificateModal .close-edit-modal,
            #profileCrudModal.certificate-crud .close-edit-modal {
                width: 36px;
                height: 36px;
                border-radius: 10px;
                background: #f1f5f9;
                color: #475569;
                border: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 15px;
                transition: all 0.2s ease;
                margin-top: 4px;
            }

                #certificateModal .close-edit-modal:hover,
                #profileCrudModal.certificate-crud .close-edit-modal:hover {
                    background: #e2e8f0;
                    color: #0f172a;
                }

            #certificateModal .edit-profile-form,
            #profileCrudModal.certificate-crud .edit-profile-form {
                padding: 10px 32px 24px;
                overflow-y: auto;
                box-sizing: border-box;
            }

            #certificateModal .edit-form-grid,
            #profileCrudModal.certificate-crud .edit-form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                box-sizing: border-box;
            }

            #certificateModal .edit-field,
            #profileCrudModal.certificate-crud .edit-field {
                display: flex;
                flex-direction: column;
                gap: 8px;
                box-sizing: border-box;
            }

                #certificateModal .edit-field.full-width,
                #profileCrudModal.certificate-crud .edit-field.full-width {
                    grid-column: 1 / -1;
                }

                #certificateModal .edit-field label,
                #profileCrudModal.certificate-crud .edit-field label {
                    font-size: 14px;
                    font-weight: 700;
                    color: #1e293b;
                }

            #certificateModal .required-mark,
            #profileCrudModal.certificate-crud .required-mark {
                color: #ef4444;
                margin-left: 2px;
            }

            #certificateModal .optional-mark,
            #profileCrudModal.certificate-crud .optional-mark {
                font-size: 13px;
                font-weight: 500;
                color: #64748b;
                margin-left: 4px;
            }

            #certificateModal .input-with-icon,
            #profileCrudModal.certificate-crud .input-with-icon {
                position: relative;
                display: flex;
                align-items: center;
                width: 100%;
                box-sizing: border-box;
            }

                #certificateModal .input-with-icon .field-icon,
                #profileCrudModal.certificate-crud .input-with-icon .field-icon {
                    position: absolute;
                    left: 16px;
                    color: #64748b;
                    font-size: 16px;
                    pointer-events: none;
                    z-index: 1;
                }

                #certificateModal .input-with-icon input,
                #profileCrudModal.certificate-crud .input-with-icon input {
                    width: 100%;
                    min-height: 52px;
                    padding: 12px 16px 12px 46px;
                    border: 1.5px solid #e2e8f0;
                    border-radius: 12px;
                    background: #ffffff;
                    color: #1e293b;
                    font-size: 14px;
                    transition: all 0.2s ease;
                    outline: none;
                    box-sizing: border-box;
                }

                    #certificateModal .input-with-icon input:focus,
                    #certificateModal .textarea-with-icon textarea:focus,
                    #profileCrudModal.certificate-crud .input-with-icon input:focus,
                    #profileCrudModal.certificate-crud .textarea-with-icon textarea:focus {
                        border-color: #3b82f6;
                        box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.12);
                    }

                    #certificateModal .input-with-icon input::placeholder,
                    #certificateModal .textarea-with-icon textarea::placeholder,
                    #profileCrudModal.certificate-crud .input-with-icon input::placeholder,
                    #profileCrudModal.certificate-crud .textarea-with-icon textarea::placeholder {
                        color: #94a3b8;
                        font-size: 14px;
                    }

            #certificateModal .textarea-with-icon,
            #profileCrudModal.certificate-crud .textarea-with-icon {
                position: relative;
                display: flex;
                flex-direction: column;
                width: 100%;
                box-sizing: border-box;
            }

                #certificateModal .textarea-with-icon .field-icon,
                #profileCrudModal.certificate-crud .textarea-with-icon .field-icon {
                    position: absolute;
                    left: 16px;
                    top: 16px;
                    color: #64748b;
                    font-size: 16px;
                    pointer-events: none;
                }

                #certificateModal .textarea-with-icon textarea,
                #profileCrudModal.certificate-crud .textarea-with-icon textarea {
                    width: 100%;
                    min-height: 120px;
                    padding: 14px 16px 28px 46px;
                    border: 1.5px solid #e2e8f0;
                    border-radius: 12px;
                    background: #ffffff;
                    color: #1e293b;
                    font-size: 14px;
                    font-family: inherit;
                    line-height: 1.5;
                    resize: vertical;
                    outline: none;
                    box-sizing: border-box;
                }

            #certificateModal .char-count,
            #profileCrudModal.certificate-crud .char-count {
                position: absolute;
                right: 14px;
                bottom: 10px;
                font-size: 12px;
                color: #64748b;
                pointer-events: none;
                font-weight: 500;
            }

            #certificateModal .cert-upload-wrapper {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
                align-items: stretch;
                width: 100%;
                box-sizing: border-box;
            }

            #certificateModal .cert-upload-dropzone {
                position: relative;
                border: 1.5px dashed #93c5fd;
                background: #f8fafc;
                border-radius: 12px;
                padding: 14px 18px;
                display: flex;
                align-items: center;
                gap: 14px;
                cursor: pointer;
                transition: all 0.2s ease;
                min-height: 72px;
                box-sizing: border-box;
            }

                #certificateModal .cert-upload-dropzone:hover {
                    border-color: #3b82f6;
                    background: #eff6ff;
                }

            #certificateModal .cert-file-input {
                display: none !important;
            }

            #certificateModal .cert-upload-drop-icon {
                width: 42px;
                height: 42px;
                border-radius: 10px;
                background: #eff6ff;
                color: #2563eb;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
                flex-shrink: 0;
            }

            #certificateModal .cert-upload-drop-text {
                display: flex;
                flex-direction: column;
                font-size: 13px;
                color: #334155;
            }

                #certificateModal .cert-upload-drop-text strong {
                    color: #2563eb;
                }

                #certificateModal .cert-upload-drop-text small {
                    color: #64748b;
                    font-size: 11px;
                    margin-top: 2px;
                }

            #certificateModal .cert-file-selected-box {
                border: 1.5px solid #e2e8f0;
                background: #ffffff;
                border-radius: 12px;
                padding: 12px 16px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                gap: 12px;
                min-height: 72px;
                box-sizing: border-box;
            }

            #certificateModal .cert-file-preview-left {
                display: flex;
                align-items: center;
                gap: 12px;
                min-width: 0;
            }

            #certificateModal .cert-file-type-icon {
                width: 40px;
                height: 40px;
                border-radius: 10px;
                background: #ecfdf5;
                color: #10b981;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
                flex-shrink: 0;
            }

            #certificateModal .cert-file-meta {
                display: flex;
                flex-direction: column;
                min-width: 0;
            }

            #certificateModal .cert-filename {
                font-size: 13px;
                font-weight: 600;
                color: #1e293b;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                max-width: 200px;
            }

            #certificateModal .cert-filesize {
                font-size: 11px;
                color: #64748b;
            }

            #certificateModal .cert-file-remove-btn {
                border: none;
                background: #f1f5f9;
                color: #64748b;
                cursor: pointer;
                font-size: 14px;
                width: 28px;
                height: 28px;
                border-radius: 7px;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s ease;
                flex-shrink: 0;
            }

                #certificateModal .cert-file-remove-btn:hover {
                    color: #ef4444;
                    background: #fee2e2;
                }

            #certificateModal .edit-modal-footer,
            #profileCrudModal.certificate-crud .edit-modal-footer {
                padding: 16px 32px 26px;
                display: flex;
                align-items: center;
                justify-content: flex-end;
                gap: 12px;
                border-top: none;
                box-sizing: border-box;
            }

            #certificateModal .cancel-edit-btn,
            #profileCrudModal.certificate-crud .cancel-edit-btn {
                min-width: 90px;
                height: 44px;
                padding: 0 20px;
                border-radius: 10px;
                border: 1px solid #e2e8f0;
                background: #ffffff;
                color: #334155;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
            }

                #certificateModal .cancel-edit-btn:hover,
                #profileCrudModal.certificate-crud .cancel-edit-btn:hover {
                    background: #f8fafc;
                    border-color: #cbd5e1;
                }

            #certificateModal .save-profile-btn,
            #profileCrudModal.certificate-crud .save-profile-btn {
                min-width: 100px;
                height: 44px;
                padding: 0 22px;
                border-radius: 10px;
                border: none;
                background: #2563eb;
                color: #ffffff;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
                transition: all 0.2s ease;
            }

                #certificateModal .save-profile-btn:hover,
                #profileCrudModal.certificate-crud .save-profile-btn:hover {
                    background: #1d4ed8;
                    box-shadow: 0 6px 16px rgba(37, 99, 235, 0.35);
                }

        @media(max-width:650px) {
            #certificateModal,
            #profileCrudModal.certificate-crud {
                padding: 12px;
            }

                #certificateModal .edit-modal-header,
                #certificateModal .edit-profile-form,
                #certificateModal .edit-modal-footer,
                #profileCrudModal.certificate-crud .edit-modal-header,
                #profileCrudModal.certificate-crud .edit-profile-form,
                #profileCrudModal.certificate-crud .edit-modal-footer {
                    padding-left: 18px;
                    padding-right: 18px;
                }

                #certificateModal .edit-form-grid,
                #profileCrudModal.certificate-crud .edit-form-grid {
                    grid-template-columns: 1fr;
                }

                #certificateModal .cert-upload-wrapper {
                    grid-template-columns: 1fr;
                }
        }
    </style>
    <style>
        /* ================= SKILLS CHIPS & GRIDVIEW STYLING ================= */
        .skills-gridview {
            width: 100%;
            border-collapse: collapse;
        }

        .skills-gridview > tbody {
            display: flex !important;
            flex-wrap: wrap !important;
            gap: 10px !important;
        }

        .skills-gridview > tbody > tr {
            display: inline-flex !important;
            align-items: center !important;
            gap: 8px !important;
            padding: 8px 14px 8px 16px !important;
            border-radius: 20px !important;
            font-size: 13px !important;
            font-weight: 600 !important;
            transition: all 0.2s ease !important;
        }

        .technical-box .skills-gridview > tbody > tr {
            background: #eff6ff !important;
            border: 1px solid #dbeafe !important;
            color: #1d4ed8 !important;
        }

        .soft-box .skills-gridview > tbody > tr {
            background: #f0fdf4 !important;
            border: 1px solid #dcfce7 !important;
            color: #15803d !important;
        }

        .other-box .skills-gridview > tbody > tr {
            background: #faf5ff !important;
            border: 1px solid #f3e8ff !important;
            color: #7e22ce !important;
        }

        .skills-gridview > tbody > tr > td {
            padding: 0 !important;
            border: none !important;
            background: transparent !important;
            display: inline-flex !important;
            align-items: center !important;
        }

        .skill-name-col {
            white-space: nowrap !important;
        }

        .skill-delete-btn {
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            width: 22px !important;
            height: 22px !important;
            border-radius: 50% !important;
            border: none !important;
            background: transparent !important;
            color: #94a3b8 !important;
            cursor: pointer !important;
            text-decoration: none !important;
            font-size: 12px !important;
            transition: all 0.2s ease !important;
            margin-left: 6px !important;
            padding: 0 !important;
        }

        .skill-delete-btn:hover {
            background: #fee2e2 !important;
            color: #ef4444 !important;
        }

        .no-skill-text {
            display: block;
            color: #94a3b8;
            font-size: 13px;
            font-style: italic;
            padding: 6px 0;
        }
    </style>
    <style>
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

        .project-actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .project-action-btn {
            width: 36px;
            height: 36px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #dbe5f0;
            background: #fff;
            color: #64748b;
            border-radius: 9px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .project-action-btn.edit-btn:hover {
            color: #2563eb;
            border-color: #bfdbfe;
            background: #eff6ff;
        }

        .project-action-btn.delete-btn {
            color: #ef4444;
            border-color: #fee2e2;
        }

        .project-action-btn.delete-btn:hover {
            color: #dc2626;
            border-color: #fca5a5;
            background: #fee2e2;
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
    </style>
    <main class="student-profile-page">
        <section class="profile-header-card">
            <div class="profile-header-top">
                <div class="profile-main-info">
                    <div class="profile-photo" aria-label="Student profile photo">
                        <asp:Label ID="lblAvatarInitials" runat="server">-</asp:Label>
                        <asp:Image ID="imgStudentPhoto" runat="server" Visible="false" Style="width:100%; height:100%; border-radius:50%; object-fit:cover; display:block;" />
                    </div>
                    <div class="profile-info-2x2">
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-user"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">Full Name</span>
                                <asp:Label ID="lblName" runat="server" CssClass="contact-value"></asp:Label>
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-book"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">Course</span>
                                <asp:Label ID="lblCourse" runat="server" CssClass="contact-value"></asp:Label>
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-building-columns"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">College</span>
                                <asp:Label ID="lblCollege" runat="server" CssClass="contact-value"></asp:Label>
                            </div>
                        </div>
                        <div class="contact-item">
                            <div class="contact-icon"><i class="fa-solid fa-star"></i></div>
                            <div class="contact-text">
                                <span class="contact-label">CGPA</span>
                                <asp:Label ID="lblHeaderCGPA" runat="server" CssClass="contact-value"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
                <asp:HyperLink ID="btnEditProfile" runat="server" CssClass="edit-profile-btn" NavigateUrl="~/StudentPanel/student-edit-profile.aspx">
                    <i class="fa-solid fa-pen"></i> Edit Profile
                </asp:HyperLink>
            </div>
            <div class="profile-contact-row">
                <div class="contact-item">
                    <div class="contact-icon"><i class="fa-solid fa-envelope"></i></div>
                    <div class="contact-text">
                        <span class="contact-label">Email Address</span>
                        <asp:Label ID="lblEmail" runat="server" CssClass="contact-value"></asp:Label>
                    </div>
                </div>
                <div class="contact-item">
                    <div class="contact-icon"><i class="fa-solid fa-phone"></i></div>
                    <div class="contact-text">
                        <span class="contact-label">Contact Number</span>
                        <asp:Label ID="lblMobile" runat="server" CssClass="contact-value"></asp:Label>
                    </div>
                </div>
                <div class="contact-item">
                    <div class="contact-icon"><i class="fa-solid fa-id-card"></i></div>
                    <div class="contact-text">
                        <span class="contact-label">Enrollment Number</span>
                        <asp:Label ID="lblEnrollment" runat="server" CssClass="contact-value"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="social-links">
                <asp:HyperLink ID="hlHeaderLinkedIn" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-brands fa-linkedin"></i>LinkedIn</asp:HyperLink>
                <asp:HyperLink ID="hlHeaderGitHub" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-brands fa-github"></i>GitHub</asp:HyperLink>
                <asp:HyperLink ID="hlHeaderPortfolio" runat="server" Target="_blank" Rel="noopener" CssClass="social-link" NavigateUrl="#"><i class="fa-solid fa-globe"></i>Portfolio</asp:HyperLink>
            </div>
        </section>
        <section class="profile-tabs-card" aria-label="Profile sections">
            <div class="profile-tabs" role="tablist">
                <button type="button" class="profile-tab active" onclick="openProfileTab('personal', this)"><i class="fa-solid fa-user"></i><span>Personal</span></button>
                <button type="button" class="profile-tab" onclick="openProfileTab('education', this)"><i class="fa-solid fa-graduation-cap"></i><span>Education</span></button>
                <button type="button" class="profile-tab" onclick="openProfileTab('skills', this)"><i class="fa-solid fa-code"></i><span>Skills</span></button>
                <button type="button" class="profile-tab" onclick="openProfileTab('projects', this)"><i class="fa-solid fa-diagram-project"></i><span>Projects</span></button>
                <button type="button" class="profile-tab" onclick="openProfileTab('resume', this)"><i class="fa-solid fa-file-pdf"></i><span>Resume</span></button>
            </div>
        </section>
        <section id="personal" class="profile-tab-content active">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-user"></i>Personal Information</h2>
                        <p>Manage your basic and professional personal details</p>
                    </div>
                </div>
                <div class="profile-subtitle"><i class="fa-solid fa-id-card"></i>Basic Information</div>
                <div class="profile-info-grid">
                    <div class="info-field">
                        <span class="info-label">Full Name</span>
                        <asp:Label ID="lblFullName" runat="server" CssClass="info-value"></asp:Label>
                    </div>

                    <div class="info-field">
                        <span class="info-label">Date of Birth</span>
                        <asp:Label ID="lblDob" runat="server" CssClass="info-value"></asp:Label>
                    </div>

                    <div class="info-field">
                        <span class="info-label">Gender</span>
                        <asp:Label ID="lblGender" runat="server" CssClass="info-value">-</asp:Label>
                    </div>

                    <div class="info-field">
                        <span class="info-label">Email Address</span>
                        <asp:Label ID="lblPersonalEmail" runat="server" CssClass="info-value"></asp:Label>
                    </div>

                    <div class="info-field">
                        <span class="info-label">Contact Number</span>
                        <asp:Label ID="lblPersonalMobile" runat="server" CssClass="info-value"></asp:Label>
                    </div>

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
        <section id="education" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-graduation-cap"></i>Education</h2>
                        <p>Manage your academic and educational information</p>
                    </div>
                </div>
                <div class="profile-subtitle"><i class="fa-solid fa-school"></i>Academic Information</div>
                <div class="profile-info-grid">

                    <div class="info-field">
                        <span class="info-label">Enrollment Number</span>
                        <asp:Label ID="lblEduEnrollment" runat="server" CssClass="info-value"></asp:Label>
                    </div>

                    <div class="info-field">
                        <span class="info-label">College / University</span>
                        <asp:Label ID="lblEduCollege" runat="server" CssClass="info-value"></asp:Label>
                    </div>

                    <div class="info-field">
                        <span class="info-label">Course / Degree</span>
                        <asp:Label ID="lblEduCourse" runat="server" CssClass="info-value"></asp:Label>
                    </div>

                    <div class="info-field">
                        <span class="info-label">Department</span>
                        <asp:Label ID="lblEduDepartment" runat="server" CssClass="info-value"></asp:Label>
                    </div>

                    <div class="info-field">
                        <span class="info-label">Current Year / Semester</span>
                        <asp:Label ID="lblEduSemester" runat="server" CssClass="info-value"></asp:Label>
                    </div>

                    <div class="info-field">
                        <span class="info-label">CGPA / Percentage</span>
                        <asp:Label ID="lblEduCgpa" runat="server" CssClass="info-value"></asp:Label>
                    </div>

                    <div class="info-field">
                        <span class="info-label">Graduation Year</span>
                        <asp:Label ID="lblEduGraduationYear" runat="server" CssClass="info-value"></asp:Label>
                    </div>



                </div>


            </div>
        </section>

        <section id="skills" class="profile-tab-content">

            <div class="skills-main-card">

                <!-- Header -->
                <div class="skills-header">

                    <div class="skills-title-area">
                        <div class="skills-icon">
                            <i class="fa-solid fa-code"></i>
                        </div>

                        <div>
                            <h2>Skills</h2>
                            <p>Showcase your technical and professional skills</p>
                        </div>
                    </div>

                    <button type="button" class="add-skill-btn" onclick="addProfileSkill()">
                        <i class="fa-solid fa-plus"></i>Add Skill
                    </button>

                </div>


                <!-- ================= TECHNICAL SKILLS ================= -->

                <div class="skill-category-box technical-box">

                    <div class="skill-category-title">
                        <div class="category-icon technical-icon">
                            <i class="fa-solid fa-laptop-code"></i>
                        </div>

                        <h3>Technical Skills</h3>
                    </div>


                    <div class="skills-list">

                        <asp:GridView ID="gvTechSkills" runat="server" AutoGenerateColumns="False" OnRowCommand="gvSkills_RowCommand" DataKeyNames="SkillId" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="SkillName" ItemStyle-CssClass="skill-name-col" />
                                <asp:TemplateField ItemStyle-CssClass="skill-action-col">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbDeleteTech" runat="server" CommandName="DeleteSkill" CommandArgument='<%# Eval("SkillId") %>' CssClass="skill-delete-btn" ToolTip="Delete"><i class="fa-solid fa-trash-can"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>


                        <asp:Label ID="lblNoTechSkills" runat="server" CssClass="no-skill-text" Text="No technical skills added yet.">
                        </asp:Label>

                    </div>

                </div>


                <!-- ================= SOFT SKILLS ================= -->

                <div class="skill-category-box soft-box">

                    <div class="skill-category-title">

                        <div class="category-icon soft-icon">
                            <i class="fa-solid fa-people-group"></i>
                        </div>

                        <h3>Soft Skills</h3>

                    </div>


                    <div class="skills-list">

                        <asp:GridView ID="gvSoftSkills" runat="server" AutoGenerateColumns="False" OnRowCommand="gvSkills_RowCommand" DataKeyNames="SkillId" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="SkillName" ItemStyle-CssClass="skill-name-col" />
                                <asp:TemplateField ItemStyle-CssClass="skill-action-col">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbDeleteSoft" runat="server" CommandName="DeleteSkill" CommandArgument='<%# Eval("SkillId") %>' CssClass="skill-delete-btn" ToolTip="Delete"><i class="fa-solid fa-trash-can"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>


                        <asp:Label ID="lblNoSoftSkills" runat="server" CssClass="no-skill-text" Text="No soft skills added yet.">
                        </asp:Label>

                    </div>

                </div>


                <!-- ================= OTHER SKILLS ================= -->

                <div class="skill-category-box other-box">

                    <div class="skill-category-title">

                        <div class="category-icon other-icon">
                            <i class="fa-solid fa-layer-group"></i>
                        </div>

                        <h3>Other Skills</h3>

                    </div>


                    <div class="skills-list">

                        <asp:GridView ID="gvOtherSkills" runat="server" AutoGenerateColumns="False" OnRowCommand="gvSkills_RowCommand" DataKeyNames="SkillId" CssClass="skills-gridview" GridLines="None" ShowHeader="False">
                            <Columns>
                                <asp:BoundField DataField="SkillName" ItemStyle-CssClass="skill-name-col" />
                                <asp:TemplateField ItemStyle-CssClass="skill-action-col">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lbDeleteOther" runat="server" CommandName="DeleteSkill" CommandArgument='<%# Eval("SkillId") %>' CssClass="skill-delete-btn" ToolTip="Delete"><i class="fa-solid fa-trash-can"></i></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>


                        <asp:Label ID="lblNoOtherSkills" runat="server" CssClass="no-skill-text" Text="No other skills added yet.">
                        </asp:Label>

                    </div>

                </div>

            </div>

        </section>
        <section id="projects" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2><i class="fa-solid fa-diagram-project"></i>Projects</h2>
                        <p>Showcase your academic and personal projects</p>
                    </div>
                    <button type="button" class="add-project-btn" onclick="openAddProjectForm()"><i class="fa-solid fa-plus"></i>Add Project</button>
                </div>
                <asp:GridView ID="gvProjects" runat="server" AutoGenerateColumns="False" OnRowCommand="gvProjects_RowCommand" DataKeyNames="ProjectId" CssClass="projects-gridview" GridLines="None" ShowHeader="False">
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
                                        <div class="project-actions">
                                            <asp:LinkButton ID="lbEditProject" runat="server" CommandName="EditProject" CommandArgument='<%# Eval("ProjectId") %>' CssClass="project-action-btn edit-btn" ToolTip="Edit Project" CausesValidation="false"><i class="fa-solid fa-pen"></i></asp:LinkButton>
                                            <asp:LinkButton ID="lbDeleteProject" runat="server" CommandName="DeleteProject" CommandArgument='<%# Eval("ProjectId") %>' CssClass="project-action-btn delete-btn" ToolTip="Delete Project" CausesValidation="false"><i class="fa-solid fa-trash-can"></i></asp:LinkButton>
                                        </div>
                                    </div>
                                    <%# !string.IsNullOrWhiteSpace(Eval("Description") as string) ? "<div class=\"project-description\"><p>" + HttpUtility.HtmlEncode(Eval("Description").ToString()) + "</p></div>" : "" %>
                                    <%# FormatTechTags(Eval("TechnologiesUsed")) %>
                                    <%# FormatProjectLink(Eval("ProjectLink")) %>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lblNoProjects" runat="server" CssClass="no-projects-text" Text="No projects added yet."></asp:Label>
            </div>
        </section>
        <section id="resume" class="profile-tab-content">
            <div class="profile-section-card">
                <div class="section-header">
                    <div>
                        <h2>Resume</h2>
                        <p>Manage your latest resume for internship applications.</p>
                    </div>
                    <button type="button" class="upload-resume-btn" onclick="openResumeUpload()"><i class="fa-solid fa-cloud-arrow-up"></i>Upload Resume</button>
                </div>
                <asp:Panel ID="pnlResumeData" runat="server" Visible="false">
                    <div class="resume-current-card">
                        <div class="resume-file-left">
                            <div class="resume-pdf-icon"><i class="fa-solid fa-file-pdf"></i></div>
                            <div class="resume-file-info">
                                <h3>
                                    <asp:Label ID="lblResumeFileName" runat="server"></asp:Label></h3>
                                <div class="resume-meta">
                                    <span><i class="fa-regular fa-file"></i>PDF Document</span><span><i class="fa-regular fa-calendar"></i> Uploaded:
                                    <asp:Label ID="lblResumeDate" runat="server"></asp:Label></span>
                                </div>
                            </div>
                        </div>
                        <div class="resume-actions">
                            <button type="button" class="resume-action-btn primary" onclick="viewResume()"><i class="fa-solid fa-eye"></i>View</button>
                            <button type="button" class="resume-action-btn" onclick="downloadResume()"><i class="fa-solid fa-download"></i>Download</button>
                            <button type="button" class="resume-action-btn" onclick="replaceResume()"><i class="fa-solid fa-rotate"></i>Replace</button>
                            <button type="button" class="resume-delete-btn" onclick="deleteResume()"><i class="fa-solid fa-trash"></i></button>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Label ID="lblNoResume" runat="server" CssClass="info-value" Text="-"></asp:Label>
                <div class="resume-upload-area">
                    <div class="resume-upload-icon"><i class="fa-solid fa-cloud-arrow-up"></i></div>
                    <h3>Upload Your Resume</h3>
                    <p>Drag and drop your resume here or click to browse</p>
                    <label class="browse-resume-btn"><i class="fa-solid fa-folder-open"></i>Browse Resume<input type="file" id="resumeFile" accept=".pdf,application/pdf" onchange="validateResume(this)"></label><span class="resume-upload-note">PDF format only - Maximum file size: 5 MB</span>
                </div>
            </div>
        </section>
    </main>
    <script src="<%= ResolveUrl("~/js/student-profile.js") %>"></script>
    <div id="editProfileModal" class="edit-profile-modal" role="dialog" aria-modal="true" aria-labelledby="editProfileTitle">
        <div class="edit-profile-box">
            <div class="edit-modal-header">
                <div>
                    <h2 id="editProfileTitle">Edit Profile</h2>
                    <p>Update your personal and professional information.</p>
                </div>
                <button type="button" class="close-edit-modal" onclick="closeEditProfile()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="edit-profile-form">
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-user"></i>Basic Information</h3>
                    <div class="edit-form-grid">
                        <div class="edit-field">
                            <label>Full Name</label><%--<input type="text" value="Dhruvi Patel">--%>
                            <asp:TextBox ID="txtEditFullName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Date of Birth</label><%--<input type="date" value="2005-06-15">--%>
                            <asp:TextBox ID="txtEditDob" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Gender</label>
                            <asp:DropDownList ID="ddlEditGender" runat="server" CssClass="form-control">
                                <asp:ListItem Text="-" Value=""></asp:ListItem>
                                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="edit-field">
                            <label>Email Address</label><%--<input type="email" value="dhruvi@example.com">--%>
                            <asp:TextBox ID="txtEditEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Contact Number</label><%--<input type="text" value="9876543210">--%>
                            <asp:TextBox ID="txtEditMobile" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Enrollment Number</label><%--<input type="text" value="BCA2024001">--%>
                            <asp:TextBox ID="txtEditEnrollment" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-location-dot"></i>Address Information</h3>
                    <div class="edit-form-grid">
                        <div class="edit-field full-width">
                            <label>Address</label><asp:TextBox ID="txtEditAddress" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>City</label><asp:TextBox ID="txtEditCity" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>State</label><asp:TextBox ID="txtEditState" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Pincode</label><asp:TextBox ID="txtEditPincode" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-graduation-cap"></i>Education</h3>
                    <div class="edit-form-grid">
                        <div class="edit-field">
                            <label>College / University</label>
                            <asp:TextBox ID="txtEditCollege" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Course / Degree</label>
                            <asp:TextBox ID="txtEditCourse" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Department</label>
                            <asp:TextBox ID="txtEditDepartment" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Current Semester</label>
                            <asp:TextBox ID="txtEditSemester" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Graduation Year</label>
                            <asp:TextBox ID="txtEditGraduationYear" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>CGPA / Percentage</label>
                            <asp:TextBox ID="txtEditCgpa" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-briefcase"></i>Internship Preferences</h3>
                    <div class="edit-form-grid">
                        <div class="edit-field">
                            <label>Preferred Domain</label>
                            <asp:TextBox ID="txtEditPreferredDomain" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Preferred Role</label>
                            <asp:TextBox ID="txtEditPreferredRole" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Preferred Location</label>
                            <asp:TextBox ID="txtEditPreferredLocation" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>Work Mode</label>
                            <asp:DropDownList ID="ddlEditWorkMode" runat="server" CssClass="form-control">
                                <asp:ListItem Text="-" Value=""></asp:ListItem>
                                <asp:ListItem Text="Hybrid" Value="Hybrid"></asp:ListItem>
                                <asp:ListItem Text="On-site" Value="On-site"></asp:ListItem>
                                <asp:ListItem Text="Remote" Value="Remote"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="edit-field">
                            <label>Availability</label>
                            <asp:DropDownList ID="ddlEditAvailability" runat="server" CssClass="form-control">
                                <asp:ListItem Text="-" Value=""></asp:ListItem>
                                <asp:ListItem Text="Available" Value="Available"></asp:ListItem>
                                <asp:ListItem Text="Not Available" Value="Not Available"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-user-pen"></i>About Me</h3>
                    <div class="edit-field">
                        <label>Career Objective / About Me</label>
                        <asp:TextBox ID="txtEditAboutMe" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="edit-form-section">
                    <h3><i class="fa-solid fa-link"></i>Professional Links</h3>
                    <div class="edit-form-grid">
                        <div class="edit-field">
                            <label>LinkedIn</label>
                            <asp:TextBox ID="txtEditLinkedIn" runat="server" CssClass="form-control" placeholder="https://linkedin.com/in/yourprofile"></asp:TextBox>
                        </div>
                        <div class="edit-field">
                            <label>GitHub</label>
                            <asp:TextBox ID="txtEditGitHub" runat="server" CssClass="form-control" placeholder="https://github.com/yourusername"></asp:TextBox>
                        </div>
                        <div class="edit-field full-width">
                            <label>Portfolio Website</label>
                            <asp:TextBox ID="txtEditPortfolio" runat="server" CssClass="form-control" placeholder="https://yourportfolio.com"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="edit-modal-footer">
                <button type="button" class="cancel-edit-btn" onclick="closeEditProfile()">Cancel</button>
                <%--                <button type="button" class="save-profile-btn" onclick="saveProfile()"><i class="fa-solid fa-check"></i>Save Changes</button>--%>
                <asp:Button ID="btnSaveProfile" runat="server" CssClass="save-profile-btn" Text="Save Changes" OnClick="btnSaveProfile_Click" />
            </div>
        </div>
    </div>
    <div id="profileCrudModal" class="edit-profile-modal" role="dialog" aria-modal="true" aria-labelledby="crudModalTitle">
        <div class="edit-profile-box">
            <div class="edit-modal-header">
                <div>
                    <h2 id="crudModalTitle">Add Details</h2>
                    <p id="crudModalSubtitle">Enter information below.</p>
                </div>
                <button type="button" class="close-edit-modal" onclick="closeCrudForm()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <form id="profileCrudForm" class="edit-profile-form">
                <div id="crudFields" class="edit-form-grid"></div>
            </form>
            <div class="edit-modal-footer">
                <button type="button" class="cancel-edit-btn" onclick="closeCrudForm()">Cancel</button>
                <button type="button" class="save-profile-btn" onclick="saveCrudForm()"><i class="fa-solid fa-check"></i>Save</button>
            </div>
        </div>
    </div>

    <div id="skillModal" class="edit-profile-modal" role="dialog">

        <div class="edit-profile-box skill-modal-box">

            <div class="edit-modal-header">
                <div>
                    <h2>Add Skill</h2>
                    <p>Add your skill</p>
                </div>

                <button type="button"
                    class="close-edit-modal"
                    onclick="closeSkillForm()">
                    <i class="fa-solid fa-xmark"></i>
                </button>
            </div>

            <div class="edit-profile-form">

                <!-- Category -->
                <div class="edit-field">
                    <label>Skill Category</label>

                    <asp:DropDownList ID="ddlSkillCategory"
                        runat="server"
                        CssClass="form-input">

                        <asp:ListItem Text="Technical Skills" Value="technical" />
                        <asp:ListItem Text="Soft Skills" Value="soft" />
                        <asp:ListItem Text="Other Skills" Value="other" />

                    </asp:DropDownList>
                </div>
                <br />
                <br />
                <!-- Skill Name -->
                <div class="edit-field">
                    <label>
                        Skill Name <span class="required-mark">*</span>
                    </label>

                    <asp:TextBox ID="txtNewSkillName"
                        runat="server"
                        CssClass="form-input"
                        placeholder="Enter skill name" />
                </div>

            </div>

            <div class="edit-modal-footer">

                <button type="button"
                    class="cancel-edit-btn"
                    onclick="closeSkillForm()">
                    Cancel
                </button>

                <asp:Button ID="btnAddSkill" runat="server" CssClass="save-profile-btn" Text="Add Skill" OnClick="btnAddSkill_Click" CausesValidation="false" />

            </div>

        </div>

    </div>
    <div id="projectModal" class="edit-profile-modal" role="dialog" aria-modal="true" aria-labelledby="lblProjectModalTitle">
        <div class="edit-profile-box">
            <div class="edit-modal-header">
                <div class="project-modal-header-left">
                    <div class="project-header-icon"><i class="fa-solid fa-code"></i></div>
                    <div>
                        <h2>
                            <asp:Label ID="lblProjectModalTitle" runat="server" Text="Add Project"></asp:Label></h2>
                        <p>Enter the details of your project below.</p>
                    </div>
                </div>
                <button type="button" class="close-edit-modal" onclick="closeProjectForm()"><i class="fa-solid fa-xmark"></i></button>
            </div>
            <div class="edit-profile-form">
                <asp:HiddenField ID="hdnProjectId" runat="server" />
                <div class="edit-form-grid">
                    <div class="edit-field">
                        <label>Project Name <span class="required-mark">*</span></label>
                        <div class="input-with-icon">
                            <i class="fa-regular fa-file-lines field-icon"></i>
                            <asp:TextBox ID="txtProjectName" runat="server" CssClass="form-control" placeholder="e.g. Smart Student Internship Management System"></asp:TextBox>
                        </div>
                    </div>
                    <div class="edit-field">
                        <label>Project Type <span class="required-mark">*</span></label>
                        <div class="input-with-icon select-with-icon">
                            <i class="fa-solid fa-tag field-icon"></i>
                            <asp:DropDownList ID="ddlProjectType" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Select project type" Value="" Disabled="true" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Academic Project" Value="Academic Project"></asp:ListItem>
                                <asp:ListItem Text="Personal Project" Value="Personal Project"></asp:ListItem>
                                <asp:ListItem Text="Internship Project" Value="Internship Project"></asp:ListItem>
                                <asp:ListItem Text="Client Project" Value="Client Project"></asp:ListItem>
                                <asp:ListItem Text="Open Source" Value="Open Source"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="edit-field full-width desc-field-wrapper">
                        <label>Description <span class="required-mark">*</span></label>
                        <div class="textarea-with-icon">
                            <i class="fa-regular fa-file-lines field-icon"></i>
                            <asp:TextBox ID="txtProjectDesc" runat="server" TextMode="MultiLine" Rows="4" MaxLength="1000" CssClass="form-control" placeholder="Describe your project, its purpose, key features and what you built..." oninput="updateProjectCharCount(this)"></asp:TextBox>
                            <div class="char-count" id="projectDescCharCount">0/1000</div>
                        </div>
                    </div>
                    <div class="edit-field full-width">
                        <label>Technologies Used <span class="required-mark">*</span></label>
                        <div class="input-with-icon">
                            <i class="fa-solid fa-code field-icon"></i>
                            <asp:TextBox ID="txtProjectTech" runat="server" CssClass="form-control" placeholder="e.g. ASP.NET, C#, SQL Server, HTML, CSS, JavaScript"></asp:TextBox>
                        </div>
                    </div>
                    <div class="edit-field full-width">
                        <label>Project Link <span class="optional-mark">(Optional)</span></label>
                        <div class="input-with-icon">
                            <i class="fa-solid fa-link field-icon"></i>
                            <asp:TextBox ID="txtProjectLink" runat="server" CssClass="form-control" placeholder="e.g. https://github.com/username/project"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="edit-modal-footer">
                <button type="button" class="cancel-edit-btn" onclick="closeProjectForm()">Cancel</button>
                <asp:Button ID="btnSaveProject" runat="server" CssClass="save-profile-btn" Text="Save" OnClick="btnSaveProject_Click" CausesValidation="false" />
            </div>
        </div>
    </div>
    <div id="deleteConfirmModal" class="delete-confirm-modal" role="dialog" aria-modal="true" aria-labelledby="deleteConfirmTitle">
        <div class="delete-confirm-box">
            <div class="delete-confirm-icon"><i class="fa-solid fa-trash"></i></div>
            <h2 id="deleteConfirmTitle">Delete Confirmation</h2>
            <p>Are you sure you want to delete this item?</p>
            <div class="delete-confirm-actions">
                <button type="button" class="delete-cancel-btn" onclick="closeDeleteConfirm()">Cancel</button>
                <button type="button" class="delete-confirm-btn" onclick="confirmDeleteCard()"><i class="fa-solid fa-trash"></i>Yes, Delete</button>
            </div>
        </div>
    </div>
    <script>function editProfile() { openEditProfile(); }</script>
</asp:Content>







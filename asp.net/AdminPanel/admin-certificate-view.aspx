<%@ Page Title="View Certificate" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-certificate-view.aspx.cs" Inherits="asp.net.admin_certificate_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cert-view-container {
            padding: 24px;
            max-width: 1000px;
            margin: 0 auto;
        }

        .cert-action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .btn-cert-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 18px;
            background: #ffffff;
            color: #334155;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .btn-cert-back:hover {
            background: #f1f5f9;
            color: #0f172a;
            text-decoration: none;
        }

        .btn-cert-print {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: #2563eb;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 2px 6px rgba(37, 99, 235, 0.25);
            transition: all 0.2s ease;
        }

        .btn-cert-print:hover {
            background: #1d4ed8;
        }

        /* Printable Certificate Canvas */
        .cert-sheet-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
            padding: 28px;
            position: relative;
        }

        .cert-inner-box {
            border: 3px dashed #d97706;
            padding: 40px;
            background: #ffffff;
            position: relative;
            text-align: center;
        }

        .cert-top-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 18px;
            margin-bottom: 24px;
        }

        .cert-company-wrap {
            display: flex;
            align-items: center;
            gap: 14px;
            text-align: left;
        }

        .cert-company-logo {
            width: 55px;
            height: 55px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            background: #f8fafc;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .cert-company-logo img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .cert-logo-placeholder {
            color: #2563eb;
            font-size: 22px;
        }

        .cert-company-name {
            font-size: 17px;
            font-weight: 800;
            color: #0f172a;
            text-transform: uppercase;
        }

        .cert-company-division {
            font-size: 11px;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .cert-header-right {
            text-align: right;
            font-size: 11px;
            color: #64748b;
        }

        .cert-no {
            font-family: monospace;
            font-weight: 700;
            color: #2563eb;
        }

        .cert-badge-tag {
            font-size: 12px;
            font-weight: 700;
            color: #d97706;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 8px;
        }

        .cert-title-main {
            font-size: 26px;
            font-weight: 800;
            color: #1e3a8a;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 12px;
        }

        .cert-present-lead {
            font-size: 13px;
            color: #64748b;
            font-style: italic;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 8px;
        }

        .cert-student-name {
            font-size: 28px;
            font-weight: 800;
            color: #0f172a;
            font-family: 'Georgia', serif;
            margin: 6px 0;
            padding-bottom: 6px;
            display: inline-block;
            border-bottom: 2px solid #d97706;
            min-width: 260px;
        }

        .cert-college {
            font-size: 13px;
            color: #475569;
            margin-top: 4px;
        }

        .cert-desc-text {
            font-size: 14px;
            line-height: 1.75;
            color: #334155;
            max-width: 720px;
            margin: 20px auto;
        }

        .hl-blue {
            color: #1e3a8a;
        }

        .hl-dark {
            color: #0f172a;
        }

        .hl-orange {
            color: #d97706;
        }

        .cert-bottom-grid {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 30px;
            padding-top: 18px;
            border-top: 1px solid #f1f5f9;
        }

        .cert-meta-left {
            text-align: left;
            font-size: 12px;
            color: #475569;
            line-height: 1.7;
        }

        .cert-medal {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: 2px solid #d97706;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #d97706;
            font-size: 20px;
        }

        .cert-sign-right {
            text-align: right;
        }

        .cert-sign-line {
            font-weight: 700;
            color: #0f172a;
            font-size: 13px;
            border-top: 1px solid #94a3b8;
            padding-top: 6px;
            display: inline-block;
            min-width: 150px;
        }

        .cert-sign-name {
            font-size: 11px;
            color: #64748b;
            margin-top: 2px;
        }

        @media print {
            body * {
                visibility: hidden;
            }

            .cert-sheet-card,
            .cert-sheet-card * {
                visibility: visible;
            }

            .cert-sheet-card {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                border: none;
                box-shadow: none;
                padding: 0;
            }

            .cert-action-bar,
            .sims-sidebar,
            .sims-header {
                display: none !important;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cert-view-container">

        <!-- Action Bar -->
        <div class="cert-action-bar">
            <a href="admin-certificates.aspx" class="btn-cert-back">
                <i class="fa-solid fa-arrow-left"></i>Back to Certificates
            </a>
            <button type="button" class="btn-cert-print" onclick="window.print();">
                <i class="fa-solid fa-print"></i>Print / Save PDF
            </button>
        </div>

        <!-- Certificate Card -->
        <div class="cert-sheet-card">
            <div class="cert-inner-box">

                <!-- Header -->
                <div class="cert-top-header">
                    <div class="cert-company-wrap">
                        <div class="cert-company-logo">
                            <asp:Image ID="imgCompanyLogo" runat="server" Visible="false" />
                            <div id="pnlLogoPlaceholder" runat="server" class="cert-logo-placeholder">
                                <i class="fa-solid fa-building"></i>
                            </div>
                        </div>
                        <div>
                            <div class="cert-company-name">
                                <asp:Label ID="lblCompany" runat="server"></asp:Label>
                            </div>
                            <div class="cert-company-division">
                                Internship &amp; Talent Acquisition Division
                            </div>
                        </div>
                    </div>
                    <div class="cert-header-right">
                        <div>Official Verified Certificate</div>
                        <div class="cert-no">
                            <asp:Label ID="lblCertNo" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

                <!-- Tag -->
                <div class="cert-badge-tag">
                    <i class="fa-solid fa-award"></i>Verified Completion
                </div>

                <!-- Title -->
                <div class="cert-title-main">
                    <asp:Label ID="lblCertTitle" runat="server"></asp:Label>
                </div>
                <div class="cert-present-lead">This is proudly presented to</div>

                <!-- Student -->
                <div>
                    <asp:Label ID="lblStudentName" runat="server" CssClass="cert-student-name"></asp:Label>
                </div>
                <div class="cert-college">
                    <asp:Label ID="lblCollege" runat="server"></asp:Label>
                </div>

                <!-- Description -->
                <p class="cert-desc-text">
                    For successfully completing the professional internship program as
                    <strong class="hl-blue"><asp:Label ID="lblInternship" runat="server"></asp:Label></strong>
                    for a duration of
                    <strong class="hl-dark"><asp:Label ID="lblDuration" runat="server"></asp:Label></strong>.
                    During this tenure, the candidate demonstrated exemplary professionalism, technical capability, and
                    <strong class="hl-orange"><asp:Label ID="lblPerformance" runat="server"></asp:Label></strong>.
                </p>

                <!-- Footer -->
                <div class="cert-bottom-grid">
                    <div class="cert-meta-left">
                        <div>
                            <strong>Issue Date:</strong>
                            <asp:Label ID="lblIssueDate" runat="server"></asp:Label>
                        </div>
                        <div>
                            <strong>Student Email:</strong>
                            <asp:Label ID="lblStudentEmail" runat="server"></asp:Label>
                        </div>
                    </div>

                    <div class="cert-medal">
                        <i class="fa-solid fa-medal"></i>
                    </div>

                    <div class="cert-sign-right">
                        <div class="cert-sign-line">Authorized Signatory</div>
                        <div class="cert-sign-name">
                            <asp:Label ID="lblSignatoryName" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
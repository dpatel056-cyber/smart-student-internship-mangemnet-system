<%@ Page Title="Certificates & Documents" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-certificates.aspx.cs" Inherits="asp.net.student_certificates" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 24px;
        }
        .page-title h1 {
            font-size: 24px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 4px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .page-title p {
            font-size: 14px;
            color: #64748b;
            margin: 0;
        }
        /* Stats Grid */
        .task-stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin-bottom: 28px;
        }
        .stat-card-task {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 18px;
            padding: 18px 20px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 4px 12px rgba(15,23,42,0.03);
            transition: all 0.2s;
        }
        .stat-card-task:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.06);
        }
        .stat-icon-task {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            flex-shrink: 0;
        }
        /* Certificates Cards Grid */
        .doc-cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 24px;
            width: 100%;
        }
        @media (max-width: 520px) {
            .doc-cards-grid {
                grid-template-columns: 1fr;
            }
        }
        .doc-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 20px;
            padding: 22px 24px;
            box-shadow: 0 4px 16px rgba(15,23,42,0.04);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            position: relative;
            overflow: hidden;
        }
        .doc-card:hover {
            border-color: #cbd5e1;
            transform: translateY(-4px);
            box-shadow: 0 14px 30px rgba(37,99,235,0.08);
        }
        .doc-card.is-revoked {
            border-color: #fecaca;
            background: #fffafa;
        }
        .doc-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 16px;
        }
        .doc-brand-wrap {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 0;
            flex: 1;
        }
        .doc-icon-wrap {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
            color: #d97706;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            flex-shrink: 0;
            box-shadow: 0 4px 10px rgba(217,119,6,0.15);
            border: 1px solid #fef08a;
        }
        .doc-icon-wrap.revoked {
            background: #fee2e2;
            color: #dc2626;
            border-color: #fecaca;
            box-shadow: none;
        }
        .doc-title {
            font-size: 16px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 3px 0;
            line-height: 1.3;
        }
        .doc-meta {
            font-size: 13px;
            color: #475569;
            font-weight: 600;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 6px;
        }
        /* Certificate Details Table/Box */
        .cert-info-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 14px 16px;
            margin-bottom: 14px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .cert-info-role-row {
            padding-bottom: 9px;
            border-bottom: 1px dashed #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
        }
        .cert-info-role-lbl {
            font-size: 12px;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            display: flex;
            align-items: center;
            gap: 6px;
            flex-shrink: 0;
        }
        .cert-info-role-val {
            font-size: 13.5px;
            font-weight: 800;
            color: #0f172a;
            text-align: right;
        }
        .cert-info-subgrid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px 14px;
        }
        .cert-subgrid-cell {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }
        .cert-subgrid-lbl {
            font-size: 11px;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        .cert-subgrid-val {
            font-size: 13px;
            font-weight: 700;
            color: #1e293b;
        }
        .cert-subgrid-val.perf {
            color: #d97706;
        }
        /* Credentials Pill Bar */
        .cert-cred-bar {
            background: #ffffff;
            border: 1.5px dashed #cbd5e1;
            border-radius: 10px;
            padding: 9px 14px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12px;
            margin-bottom: 16px;
        }
        .cert-code-pill {
            font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace;
            font-weight: 700;
            color: #2563eb;
            background: #eff6ff;
            padding: 3px 8px;
            border-radius: 6px;
            letter-spacing: 0.5px;
        }
        /* Action Buttons */
        .doc-btn-group {
            margin-top: auto;
        }
        .btn-doc-action {
            width: 100%;
            padding: 12px 18px;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #ffffff;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 700;
            text-align: center;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            cursor: pointer;
            box-shadow: 0 4px 14px rgba(37,99,235,0.25);
            transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .btn-doc-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(37,99,235,0.35);
            color: #ffffff;
        }
        .btn-doc-revoked {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
            border-radius: 12px;
            padding: 10px 14px;
            font-size: 12.5px;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }
        /* Certificate Modal & Styles (100% Identical) */
        .print-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.65);
            backdrop-filter: blur(4px);
            z-index: 1050;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .print-modal-container {
            background: #f8fafc;
            width: 100%;
            max-width: 850px;
            max-height: 92vh;
            border-radius: 16px;
            overflow-y: auto;
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            display: flex;
            flex-direction: column;
        }
        .print-modal-bar {
            padding: 14px 24px;
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        .btn-print-btn {
            padding: 8px 16px;
            background: #2563eb;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-print-btn:hover {
            background: #1d4ed8;
        }
        .btn-close-modal {
            background: none;
            border: none;
            font-size: 22px;
            color: #64748b;
            cursor: pointer;
        }
        .btn-close-modal:hover {
            color: #0f172a;
        }
        /* Certificate Document */
        .cert-canvas-doc {
            background: #ffffff;
            border: 10px solid #1e3a8a;
            border-image: linear-gradient(135deg, #1e3a8a, #d97706, #1e3a8a) 10;
            padding: 36px 40px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.06);
            position: relative;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
            text-align: center;
            box-sizing: border-box;
            background-image: radial-gradient(#f8fafc 15%, transparent 16%);
            background-size: 20px 20px;
        }
        .cert-inner-border {
            border: 2px dashed #d97706;
            padding: 24px 30px;
            position: relative;
            background: rgba(255, 255, 255, 0.96);
        }
        .cert-top-brand {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 12px;
            margin-bottom: 16px;
        }
        .cert-brand-left {
            text-align: left;
        }
        .cert-brand-left h3 {
            font-size: 17px;
            font-weight: 800;
            color: #0f172a;
            margin: 0;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .cert-brand-left p {
            font-size: 11px;
            color: #64748b;
            margin: 2px 0 0 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .cert-brand-meta {
            text-align: right;
            font-size: 11px;
            color: #64748b;
        }
        .cert-header-tag {
            font-size: 12px;
            font-weight: 700;
            color: #d97706;
            letter-spacing: 3px;
            text-transform: uppercase;
            margin-bottom: 6px;
        }
        .cert-main-title {
            font-size: 24px;
            font-weight: 900;
            color: #1e3a8a;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            margin: 0 0 12px 0;
        }
        .cert-present-text {
            font-size: 12.5px;
            color: #64748b;
            font-style: italic;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 8px;
        }
        .cert-candidate-name {
            font-size: 26px;
            font-weight: 800;
            color: #0f172a;
            font-family: 'Georgia', serif;
            margin: 4px 0 2px 0;
            padding-bottom: 4px;
            display: inline-block;
            border-bottom: 2px solid #d97706;
            min-width: 250px;
        }
        .cert-college-name {
            font-size: 13px;
            color: #475569;
            margin-bottom: 14px;
        }
        .cert-body-desc {
            font-size: 13px;
            line-height: 1.7;
            color: #334155;
            max-width: 650px;
            margin: 0 auto 20px auto;
        }
        .cert-body-desc strong {
            color: #0f172a;
        }
        .cert-footer-grid {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 24px;
            padding-top: 14px;
            border-top: 1px solid #f1f5f9;
        }
        .cert-meta-col {
            text-align: left;
            font-size: 11px;
            color: #64748b;
            line-height: 1.5;
        }
        .cert-seal-col {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .cert-seal-badge {
            width: 68px;
            height: 68px;
            border-radius: 50%;
            background: radial-gradient(circle, #fef3c7, #fde68a);
            border: 3px double #d97706;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #b45309;
            box-shadow: 0 4px 10px rgba(217, 119, 6, 0.2);
            font-size: 9px;
            font-weight: 800;
            text-transform: uppercase;
            text-align: center;
            line-height: 1.1;
        }
        .cert-seal-badge i {
            font-size: 18px;
            margin-bottom: 2px;
        }
        .cert-sign-col {
            text-align: right;
        }
        .cert-sign-name {
            font-weight: 700;
            color: #0f172a;
            font-size: 13px;
            border-top: 1px solid #94a3b8;
            padding-top: 4px;
            display: inline-block;
            min-width: 140px;
        }
        .cert-sign-title {
            font-size: 11px;
            color: #64748b;
        }
        @media print {
            body * {
                visibility: hidden;
            }
            #printableCertDoc, #printableCertDoc * {
                visibility: visible;
            }
            #printableCertDoc {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                box-shadow: none !important;
                border-width: 8px !important;
                padding: 20px !important;
            }
            .print-modal-bar, .student-sidebar, .student-topbar, .btn-print-btn, .btn-close-modal {
                display: none !important;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0 40px 0;">
        <div class="page-header-box">
            <div class="page-title">
                <h1><i class="fa-solid fa-award" style="color: #2563eb;"></i> Certificates &amp; Documents</h1>
                <p>View, download, and print your verified internship completion certificates.</p>
            </div>
        </div>
        <!-- Top Stats Row -->
        <div class="task-stats-grid">
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #eff6ff; color: #2563eb;">
                    <i class="fa-solid fa-award"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblTotalCerts" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Total Certificates</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #f0fdf4; color: #16a34a;">
                    <i class="fa-solid fa-shield-halved"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblVerifiedCerts" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Verified &amp; Active</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #fdf4ff; color: #c026d3;">
                    <i class="fa-solid fa-building"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblCompaniesCount" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Partner Companies</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #fffbeb; color: #d97706;">
                    <i class="fa-regular fa-calendar-check"></i>
                </div>
                <div>
                    <div style="font-size: 15px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblLatestDate" runat="server">-</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Latest Issue Date</div>
                </div>
            </div>
        </div>
        <asp:DataList ID="dlCertificates" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="doc-cards-grid">
            <ItemTemplate>
                <div class='doc-card <%# IsRevoked(Eval("Status")) ? "is-revoked" : "" %>'>
                    <div>
                        <div class="doc-top">
                            <div class="doc-brand-wrap">
                                <div class='doc-icon-wrap <%# IsRevoked(Eval("Status")) ? "revoked" : "" %>'>
                                    <i class='<%# IsRevoked(Eval("Status")) ? "fa-solid fa-ban" : "fa-solid fa-award" %>'></i>
                                </div>
                                <div>
                                    <h3 class="doc-title"><%# Eval("CertificateTitle") %></h3>
                                    <div class="doc-meta">
                                        <i class="fa-solid fa-building" style="color: #2563eb;"></i> <%# Eval("c_company") %>
                                        <%# Eval("c_location") != null && !string.IsNullOrEmpty(Eval("c_location").ToString()) ? "<span style='color:#cbd5e1;'>&bull;</span> <span style='color:#64748b; font-weight:500;'>" + Eval("c_location") + "</span>" : "" %>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <%# GetStudentStatusBadge(Eval("Status")) %>
                            </div>
                        </div>
                        <!-- Certificate Info Box -->
                        <div class="cert-info-box">
                            <div class="cert-info-role-row">
                                <span class="cert-info-role-lbl"><i class="fa-solid fa-user-tie" style="color:#2563eb;"></i> Role:</span>
                                <span class="cert-info-role-val"><%# Eval("RoleName") %></span>
                            </div>
                            <div class="cert-info-subgrid">
                                <div class="cert-subgrid-cell">
                                    <span class="cert-subgrid-lbl"><i class="fa-regular fa-clock" style="color:#6366f1;"></i> Duration</span>
                                    <span class="cert-subgrid-val"><%# Eval("CertDuration") %></span>
                                </div>
                                <div class="cert-subgrid-cell">
                                    <span class="cert-subgrid-lbl"><i class="fa-regular fa-calendar-check" style="color:#10b981;"></i> Issued Date</span>
                                    <span class="cert-subgrid-val"><%# FormatDate(Eval("IssueDate")) %></span>
                                </div>
                                <div class="cert-subgrid-cell" style="grid-column: 1 / -1; margin-top: 2px;">
                                    <span class="cert-subgrid-lbl"><i class="fa-solid fa-star" style="color:#f59e0b;"></i> Performance Rating</span>
                                    <span class="cert-subgrid-val perf"><%# Eval("Performance") != null && !string.IsNullOrEmpty(Eval("Performance").ToString()) ? Eval("Performance") : "Outstanding Performance & Dedication" %></span>
                                </div>
                            </div>
                        </div>
                        <!-- Credentials Monospace Bar -->
                        <div class="cert-cred-bar">
                            <div>
                                <span style="color:#64748b; font-weight:700; text-transform:uppercase; font-size:11px;">CERT NO:</span>
                                <span class="cert-code-pill" style="color:#0f172a; background:#f1f5f9; margin-left:4px;"><%# Eval("CertificateNo") %></span>
                            </div>
                            <div>
                                <span style="color:#64748b; font-weight:700; text-transform:uppercase; font-size:11px;">VERIFY:</span>
                                <span class="cert-code-pill" style="margin-left:4px;"><%# Eval("VerificationCode") %></span>
                            </div>
                        </div>
                    </div>
                    <div class="doc-btn-group">
                        <asp:PlaceHolder ID="phActiveDoc" runat="server" Visible='<%# !IsRevoked(Eval("Status")) %>'>
                            <button type="button" class="btn-doc-action"
                                    onclick='openStudentCertModal("<%# Eval("c_company") %>", "<%# Eval("c_location") %>", "<%# Eval("CompEmail") %>", "<%# GetResolvedLogoUrl(Eval("c_logo")) %>", "<%# Eval("FullName") %>", "<%# Eval("College") %>", "<%# Eval("CertificateTitle") %>", "<%# Eval("RoleName") %>", "<%# Eval("CertDuration") %>", "<%# FormatDate(Eval("IssueDate")) %>", "<%# Eval("Performance") %>", "<%# Eval("SignatoryName") != null && !string.IsNullOrEmpty(Eval("SignatoryName").ToString()) ? Eval("SignatoryName") : Eval("c_hr_name") %>", "<%# Eval("CertificateNo") %>", "<%# Eval("VerificationCode") %>");'>
                                <i class="fa-solid fa-file-pdf"></i> View &amp; Print Certificate
                            </button>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="phRevokedDoc" runat="server" Visible='<%# IsRevoked(Eval("Status")) %>'>
                            <div class="btn-doc-revoked">
                                <i class="fa-solid fa-circle-exclamation"></i> This certificate has been revoked.
                            </div>
                        </asp:PlaceHolder>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:PlaceHolder ID="pnlNoCerts" runat="server" Visible="false">
            <div style="text-align:center; padding: 60px 20px; background:#fff; border-radius:16px; border:1px solid #e2e8f0;">
                <i class="fa-solid fa-award" style="font-size: 48px; color: #94a3b8; margin-bottom: 16px;"></i>
                <h3 style="font-size: 18px; color: #0f172a; margin-bottom: 8px;">No Certificates Issued Yet</h3>
                <p style="font-size: 14px; color: #64748b; margin-bottom: 20px;">Upon successful completion of your internships, your verified certificates will appear here.</p>
                <asp:HyperLink ID="hlBrowse" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-doc-action" Style="width:auto; padding:10px 20px; display:inline-flex;">
                    <i class="fa-solid fa-briefcase"></i> Browse Internships
                </asp:HyperLink>
            </div>
        </asp:PlaceHolder>
    </div>
    <!-- ================= FULLSCREEN PRINT / VIEW MODAL FOR STUDENT ================= -->
    <div class="print-modal-overlay" id="studentPrintModal" onclick="closeStudentModal(event);">
        <div class="print-modal-container" onclick="event.stopPropagation();">
            <div class="print-modal-bar">
                <div style="font-weight:700; color:#0f172a; font-size:15px;">
                    <i class="fa-solid fa-award" style="color:#d97706;"></i> Official Verified Internship Certificate
                </div>
                <div style="display:flex; gap:10px; align-items:center;">
                    <button type="button" class="btn-print-btn" onclick="window.print();">
                        <i class="fa-solid fa-print"></i> Print / Save PDF
                    </button>
                    <button type="button" class="btn-close-modal" onclick="closeStudentModal();">&times;</button>
                </div>
            </div>
            <div style="padding: 24px;">
                <div class="cert-canvas-doc" id="printableCertDoc">
                    <div class="cert-inner-border">
                        <!-- Top Brand -->
                        <div class="cert-top-brand">
                            <div class="cert-brand-left">
                                <div id="sModalLogoWrap" style="display:flex; align-items:center; gap:10px; margin-bottom:6px;">
                                    <div id="sModalLogoIcon" style="width:38px; height:38px; border-radius:10px; background: linear-gradient(135deg,#1e3a8a,#2563eb); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                                        <i class="fa-solid fa-building" style="color:#fff; font-size:16px;"></i>
                                    </div>
                                    <img id="sModalCompLogo" src="" alt="" style="height:38px; max-width:130px; object-fit:contain; display:none; border-radius:6px;" />
                                </div>
                                <h3 id="sModalCompName">Company Name</h3>
                                <p>Internship &amp; Talent Acquisition Division</p>
                            </div>
                            <div class="cert-brand-meta">
                                <div id="sModalCompLoc">City, State</div>
                                <div id="sModalCompEmail">hr@company.com</div>
                            </div>
                        </div>
                        <!-- Certificate Title & Header -->
                        <div class="cert-header-tag"><i class="fa-solid fa-award"></i> Verified Completion</div>
                        <h2 class="cert-main-title" id="sModalCertTitle">Certificate of Internship Excellence</h2>
                        <div class="cert-present-text">This is proudly presented to</div>
                        <!-- Candidate Name -->
                        <div class="cert-candidate-name" id="sModalCandName">[Candidate Full Name]</div>
                        <div class="cert-college-name" id="sModalCandCollege">[College / Institute Name]</div>
                        <!-- Certificate Body -->
                        <p class="cert-body-desc">
                            For successfully completing the professional internship program as <strong id="sModalCertRole" style="color:#1e3a8a;">[Internship Role]</strong> at <strong id="sModalBodyComp">Company Name</strong> for a duration of <strong id="sModalCertDuration">3 Months</strong>. During this tenure, the candidate demonstrated exemplary professionalism, technical capability, and <strong id="sModalCertPerformance" style="color:#d97706;">Outstanding Performance &amp; Dedication</strong>.
                        </p>
                        <!-- Footer -->
                        <div class="cert-footer-grid">
                            <div class="cert-meta-col">
                                <div><strong>Issue Date:</strong> <span id="sModalCertDate"><%= DateTime.Now.ToString("dd MMMM yyyy") %></span></div>
                                <div><strong>Certificate No:</strong> <span id="sModalCertNo">CERT-2026-0001</span></div>
                                <div><strong>Verification:</strong> <span id="sModalVerifyCode">8F9B2C1A</span></div>
                            </div>
                            <div class="cert-seal-col">
                                <div class="cert-seal-badge">
                                    <i class="fa-solid fa-medal"></i>
                                    <span>Official<br />Verified</span>
                                </div>
                            </div>
                            <div class="cert-sign-col">
                                <div class="cert-sign-name" id="sModalSignatoryName">HR &amp; Talent Team</div>
                                <div class="cert-sign-title">Authorized Signatory &bull; <span id="sModalSignComp">Company</span></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function openStudentCertModal(comp, loc, email, logo, name, college, title, role, duration, issueDate, performance, signatory, certNo, verifyCode) {
            document.getElementById('sModalCompName').innerText = comp || 'Company';
            document.getElementById('sModalBodyComp').innerText = comp || 'Company';
            document.getElementById('sModalSignComp').innerText = comp || 'Company';
            document.getElementById('sModalCompLoc').innerText = loc || '';
            document.getElementById('sModalCompEmail').innerText = email || '';
            var logoEl = document.getElementById('sModalCompLogo');
            var logoIcon = document.getElementById('sModalLogoIcon');
            var cleanLogo = (logo && logo.trim() !== '' && logo.trim() !== 'undefined') ? logo.trim() : '';
            
            if (cleanLogo) {
                if (cleanLogo.indexOf('~/') === 0) {
                    cleanLogo = cleanLogo.replace('~/', '/');
                }
                if (!cleanLogo.startsWith('http') && !cleanLogo.startsWith('/') && !cleanLogo.startsWith('.')) {
                    cleanLogo = '../CompanyUploads/' + cleanLogo;
                }
                var testImg = new Image();
                testImg.onload = function () {
                    logoEl.src = cleanLogo;
                    logoEl.style.display = 'block';
                    logoIcon.style.display = 'none';
                };
                testImg.onerror = function () {
                    var altPath = cleanLogo.indexOf('CompanyUploads') !== -1 ? 
                        cleanLogo.replace('CompanyUploads', 'uploads/company_logos') : 
                        cleanLogo.replace('uploads/company_logos', 'CompanyUploads');
                    var altImg = new Image();
                    altImg.onload = function () {
                        logoEl.src = altPath;
                        logoEl.style.display = 'block';
                        logoIcon.style.display = 'none';
                    };
                    altImg.onerror = function () {
                        logoEl.style.display = 'none';
                        logoIcon.style.display = 'flex';
                    };
                    altImg.src = altPath;
                };
                testImg.src = cleanLogo;
            } else {
                logoEl.style.display = 'none';
                logoIcon.style.display = 'flex';
            }
            document.getElementById('sModalCandName').innerText = name || '[Candidate Full Name]';
            document.getElementById('sModalCandCollege').innerText = college || '';
            document.getElementById('sModalCertTitle').innerText = title || 'Certificate of Internship Excellence';
            document.getElementById('sModalCertRole').innerText = role || '[Internship Role]';
            document.getElementById('sModalCertDuration').innerText = duration || '3 Months';
            document.getElementById('sModalCertPerformance').innerText = performance || 'Outstanding Performance & Dedication';
            document.getElementById('sModalSignatoryName').innerText = signatory || 'HR & Talent Team';
            document.getElementById('sModalCertNo').innerText = certNo || 'CERT-2026-0001';
            document.getElementById('sModalVerifyCode').innerText = verifyCode || '8F9B2C1A';
            if (issueDate) {
                document.getElementById('sModalCertDate').innerText = issueDate;
            }
            document.getElementById('studentPrintModal').style.display = 'flex';
        }
        function closeStudentModal(e) {
            document.getElementById('studentPrintModal').style.display = 'none';
        }
    </script>
</asp:Content>

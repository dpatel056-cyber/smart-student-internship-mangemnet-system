<%@ Page Title="Internship Certificates" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-certificates.aspx.cs" Inherits="asp.net.company_certificates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <link rel="stylesheet" href="../css/company-certificates.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Header -->
    <div class="page-header-box">
        <div>
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Internship Certificates</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Automated company-branded completion certificate generator and candidate issuance.</p>
        </div>
        <button type="button" class="btn-open-drawer" onclick="openDrawer();">
            <i class="fa-solid fa-award"></i> Generate New Certificate
        </button>
    </div>
    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

    <!-- Stats Summary Cards -->
    <div class="task-stats-grid">
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#eff6ff; color:#2563eb; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-award"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblTotalCerts" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Total Certificates Issued</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#f0fdf4; color:#16a34a; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-user-check"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblEligibleInterns" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Eligible / Completed Interns</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#faf5ff; color:#9333ea; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-user-graduate"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblCertifiedInterns" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Certified Students</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#fef9c3; color:#ca8a04; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-clock-rotate-left"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblPendingCertificates" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Pending Issuance</div>
            </div>
        </div>
    </div>

    <!-- ================= ISSUED CERTIFICATES GRIDVIEW ================= -->
    <div class="co-panel" style="margin-bottom: 30px; width: 100%;">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-award" style="color: #d97706; margin-right: 8px;"></i> Issued Internship Certificates</h3>
        </div>
        <div class="co-table-responsive">
            <asp:GridView ID="gvCerts" runat="server" AutoGenerateColumns="False" OnRowCommand="gvCerts_RowCommand" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true">
                <Columns>
                    <asp:TemplateField HeaderText="Photo" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" ItemStyle-Width="60px">
                        <ItemTemplate>
                            <%# GetProfileAvatarHtml(Eval("ProfilePhoto"), Eval("FullName")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" ItemStyle-Width="15%">
                        <ItemTemplate>
                            <div style="min-width: 140px;">
                                <asp:Label ID="lblFullName" runat="server" Style="font-weight: 700; color: #0f172a; font-size: 13.5px;" Text='<%# Eval("FullName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" ItemStyle-Width="16%">
                        <ItemTemplate>
                            <div style="min-width: 160px;">
                                <asp:Label ID="lblStudentEmail" runat="server" Style="font-size: 12.5px; color: #64748b;" Text='<%# Eval("StudentEmail") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Certificate Title" ItemStyle-Width="18%">
                        <ItemTemplate>
                            <div style="min-width: 170px;">
                                <asp:Label ID="lblCertTitle" runat="server" Style="font-weight: 600; color: #1e293b; font-size: 13px;" Text='<%# Eval("CertificateTitle") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Role" ItemStyle-Width="15%">
                        <ItemTemplate>
                            <div style="min-width: 150px;">
                                <asp:Label ID="lblRole" runat="server" Style="font-size: 12.5px; color: #2563eb; font-weight: 600;" Text='<%# Eval("InternshipRole") != null && !string.IsNullOrEmpty(Eval("InternshipRole").ToString()) ? Eval("InternshipRole") : Eval("InternshipTitle") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ID / Code" ItemStyle-Width="13%">
                        <ItemTemplate>
                            <div style="min-width: 130px; white-space: nowrap;">
                                <asp:Label ID="lblCertNo" runat="server" Style="font-weight: 700; font-size: 12.5px; color: #0f172a; display: block;" Text='<%# Eval("CertificateNo") %>'></asp:Label>
                                <div style="font-size: 11.5px; color: #64748b;">Code: <asp:Label ID="lblVerificationCode" runat="server" Style="font-family: monospace; font-weight: 600;" Text='<%# Eval("VerificationCode") %>'></asp:Label></div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Date" ItemStyle-Width="9%">
                        <ItemTemplate>
                            <asp:Label ID="lblIssueDate" runat="server" Style="font-size: 12.5px; color: #475569; font-weight: 500; white-space: nowrap;" Text='<%# FormatDate(Eval("IssueDate")) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="8%">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# GetCertStatusBadge(Eval("Status")) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end" ItemStyle-Width="12%">
                        <ItemTemplate>
                            <div style="display: flex; align-items: center; justify-content: flex-end; gap: 6px; flex-wrap: nowrap; min-width: 175px;">
                                <button type="button" class="btn-table-action btn-action-view"
                                        onclick='openCertModal("<%# Eval("FullName") %>", "<%# Eval("College") %>", "<%# Eval("CertificateTitle") %>", "<%# Eval("InternshipRole") != null && !string.IsNullOrEmpty(Eval("InternshipRole").ToString()) ? Eval("InternshipRole") : Eval("InternshipTitle") %>", "<%# Eval("Duration") %>", "<%# FormatDate(Eval("IssueDate")) %>", "<%# Eval("Performance") %>", "<%# Eval("SignatoryName") %>", "<%# Eval("CertificateNo") %>", "<%# Eval("VerificationCode") %>");'
>
                                    <i class="fa-solid fa-print"></i> View &amp; Print
                                </button>
                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("CertificateId") %>' CssClass="btn-table-action btn-action-edit">
                                    <i class="fa-solid fa-pen"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("CertificateId") %>' OnClientClick="return confirm('Are you sure you want to delete this certificate?');" CssClass="btn-table-action btn-action-delete">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoCerts" runat="server" Visible="false">
                <div style="text-align: center; padding: 50px 20px; color: #64748b;">
                    <i class="fa-solid fa-certificate" style="font-size: 42px; color: #cbd5e1; margin-bottom: 12px; display: block;"></i>
                    <h4 style="font-size: 16px; font-weight: 600; color: #1e293b; margin-bottom: 4px;">No Certificates Issued Yet</h4>
                    <p style="font-size: 13px; margin: 0;">Click on <strong>Generate New Certificate</strong> above to issue a verified completion certificate for a student.</p>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>

    <!-- ================= MODAL DRAWER: CERTIFICATE GENERATOR & LIVE PREVIEW ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>
    <div class="drawer-panel" id="drawerPanel">
        <div class="drawer-header">
            <h2><i class="fa-solid fa-award" style="color: #d97706;"></i> Generate Internship Certificate</h2>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();">&times;</button>
        </div>
        <div class="drawer-body">
            <div class="cert-builder-grid">
                <!-- Left: Quick Details Fill Form -->
                <div class="builder-form-card">
                    <h2><i class="fa-solid fa-file-pen" style="color: #2563eb;"></i> Certificate Details Form</h2>
                    <div class="form-item">
                        <label><i class="fa-solid fa-user-check" style="color:#2563eb; margin-right:4px;"></i> Select Candidate with Completed Tasks / Quizzes <span style="color:#ef4444;">*</span></label>
                        <asp:DropDownList ID="ddlCandidate" runat="server" CssClass="form-input-ctrl" AutoPostBack="true" OnSelectedIndexChanged="ddlCandidate_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Candidate Full Name</label>
                            <asp:TextBox ID="txtCandidateName" runat="server" placeholder="Candidate Name" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Candidate College / Inst.</label>
                            <asp:TextBox ID="txtCandidateCollege" runat="server" placeholder="College / Institute" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-item">
                        <label>Certificate Title <span style="color:#ef4444;">*</span></label>
                        <asp:TextBox ID="txtCertTitle" runat="server" placeholder="e.g. Certificate of Internship Excellence" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Internship Role / Position <span style="color:#ef4444;">*</span></label>
                            <asp:TextBox ID="txtInternshipRole" runat="server" placeholder="e.g. Full Stack Developer" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Duration / Period</label>
                            <asp:TextBox ID="txtDuration" runat="server" placeholder="e.g. 3 Months" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Issue Date <span style="color:#ef4444;">*</span></label>
                            <asp:TextBox ID="txtIssueDate" runat="server" TextMode="Date" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Performance / Remarks</label>
                            <asp:TextBox ID="txtPerformance" runat="server" placeholder="e.g. Outstanding Performance & Dedication" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-item">
                        <label>Authorized Signatory Name</label>
                        <asp:TextBox ID="txtSignatoryName" runat="server" placeholder="e.g. HR / Founder Name" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                    </div>
                </div>

                <!-- Right: Live Branded Certificate Preview (Auto-Updates in Real-Time) -->
                <div class="preview-wrapper">
                    <div class="preview-header-bar">
                        <div style="display:flex; align-items:center; gap:8px;">
                            <span style="font-weight:700; color:#0f172a; font-size:14px;"><i class="fa-solid fa-eye" style="color:#2563eb;"></i> Live Certificate Template Preview</span>
                        </div>
                        <div class="live-badge">
                            <span class="live-dot"></span> Live Real-Time
                        </div>
                    </div>
                    <div class="cert-scroll-box">
                        <div class="cert-canvas-doc" id="certPreview">
                            <div class="cert-inner-border">
                                <!-- Top Brand -->
                                <div class="cert-top-brand">
                                    <div class="cert-brand-left">
                                        <% if (!string.IsNullOrEmpty(CompLogo)) { %>
                                            <img src="<%= CompLogo %>" style="height: 34px; max-width: 130px; object-fit: contain; margin-bottom: 4px; display: block;" />
                                        <% } %>
                                        <h3><%= CompName %></h3>
                                        <p>Internship &amp; Talent Acquisition Division</p>
                                    </div>
                                    <div class="cert-brand-meta">
                                        <div><%= CompLocation %></div>
                                        <div><%= CompEmail %></div>
                                    </div>
                                </div>

                                <!-- Certificate Title & Header -->
                                <div class="cert-header-tag"><i class="fa-solid fa-award"></i> Verified Completion</div>
                                <h2 class="cert-main-title" id="prevCertTitle"><%= SelectedCertTitle %></h2>
                                <div class="cert-present-text">This is proudly presented to</div>
                                <!-- Candidate Name -->
                                <div class="cert-candidate-name" id="prevCandName"><%= SelectedCandName %></div>
                                <div class="cert-college-name" id="prevCandCollege"><%= SelectedCandCollege %></div>
                                <!-- Certificate Body -->
                                <p class="cert-body-desc">
                                    For successfully completing the professional internship program as <strong id="prevCertRole" style="color:#1e3a8a;"><%= SelectedRole %></strong> at <strong><%= CompName %></strong> for a duration of <strong id="prevCertDuration"><%= SelectedDuration %></strong>. During this tenure, the candidate demonstrated exemplary professionalism, technical capability, and <strong id="prevCertPerformance" style="color:#d97706;"><%= SelectedPerformance %></strong>.
                                </p>

                                <!-- Footer -->
                                <div class="cert-footer-grid">
                                    <div class="cert-meta-col">
                                        <div><strong>Issue Date:</strong> <span id="prevCertDate"><%= FormattedIssueDate %></span></div>
                                        <div><strong>Certificate No:</strong> <span id="prevCertNo"><%= PreviewCertNo %></span></div>
                                        <div><strong>Verification:</strong> <span id="prevVerifyCode"><%= PreviewVerifyCode %></span></div>
                                    </div>
                                    <div class="cert-seal-col">
                                        <div class="cert-seal-badge">
                                            <i class="fa-solid fa-medal"></i>
                                            <span>Official<br />Verified</span>
                                        </div>
                                    </div>
                                    <div class="cert-sign-col">
                                        <div class="cert-sign-name" id="prevSignatoryName"><%= SelectedSignatory %></div>
                                        <div class="cert-sign-title">Authorized Signatory &bull; <%= CompName %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="drawer-footer">
            <button type="button" class="btn-drawer-cancel" onclick="closeDrawer();">Cancel</button>
            <asp:Button ID="btnResetForm" runat="server" Text="Reset Form" CssClass="btn-reset-form" OnClick="btnResetForm_Click" CausesValidation="false" />
            <asp:LinkButton ID="btnIssueCert" runat="server" CssClass="btn-issue-cert" OnClick="btnIssueCert_Click">
                <i class="fa-solid fa-award"></i> Issue Certificate to Student
            </asp:LinkButton>
        </div>
    </div>

    <!-- ================= FULLSCREEN PRINT / VIEW MODAL (100% IDENTICAL TO PREVIEW) ================= -->
    <div class="print-modal-overlay" id="printModal" onclick="closePrintModal(event);">
        <div class="print-modal-container" onclick="event.stopPropagation();">
            <div class="print-modal-bar">
                <div style="font-weight:700; color:#0f172a; font-size:15px;">
                    <i class="fa-solid fa-award" style="color:#d97706;"></i> Official Verified Certificate
                </div>
                <div style="display:flex; gap:10px; align-items:center;">
                    <button type="button" class="btn-print-btn" onclick="window.print();">
                        <i class="fa-solid fa-print"></i> Print / Save PDF
                    </button>
                    <button type="button" class="btn-close-modal" onclick="closePrintModal();">&times;</button>
                </div>
            </div>
            <div style="padding: 24px;">
                <div class="cert-canvas-doc" id="printableCertDoc">
                    <div class="cert-inner-border">
                        <!-- Top Brand -->
                        <div class="cert-top-brand">
                            <div class="cert-brand-left">
                                <% if (!string.IsNullOrEmpty(CompLogo)) { %>
                                    <img src="<%= CompLogo %>" style="height: 34px; max-width: 130px; object-fit: contain; margin-bottom: 4px; display: block;" />
                                <% } %>
                                <h3><%= CompName %></h3>
                                <p>Internship &amp; Talent Acquisition Division</p>
                            </div>
                            <div class="cert-brand-meta">
                                <div><%= CompLocation %></div>
                                <div><%= CompEmail %></div>
                            </div>
                        </div>

                        <!-- Certificate Title & Header -->
                        <div class="cert-header-tag"><i class="fa-solid fa-award"></i> Verified Completion</div>
                        <h2 class="cert-main-title" id="modalCertTitle">Certificate of Internship Excellence</h2>
                        <div class="cert-present-text">This is proudly presented to</div>
                        <!-- Candidate Name -->
                        <div class="cert-candidate-name" id="modalCandName">[Candidate Full Name]</div>
                        <div class="cert-college-name" id="modalCandCollege">[College / Institute Name]</div>
                        <!-- Certificate Body -->
                        <p class="cert-body-desc">
                            For successfully completing the professional internship program as <strong id="modalCertRole" style="color:#1e3a8a;">[Internship Role]</strong> at <strong><%= CompName %></strong> for a duration of <strong id="modalCertDuration">3 Months</strong>. During this tenure, the candidate demonstrated exemplary professionalism, technical capability, and <strong id="modalCertPerformance" style="color:#d97706;">Outstanding Performance &amp; Dedication</strong>.
                        </p>

                        <!-- Footer -->
                        <div class="cert-footer-grid">
                            <div class="cert-meta-col">
                                <div><strong>Issue Date:</strong> <span id="modalCertDate"><%= DateTime.Now.ToString("dd MMMM yyyy") %></span></div>
                                <div><strong>Certificate No:</strong> <span id="modalCertNo">CERT-2026-0001</span></div>
                                <div><strong>Verification:</strong> <span id="modalVerifyCode">8F9B2C1A</span></div>
                            </div>
                            <div class="cert-seal-col">
                                <div class="cert-seal-badge">
                                    <i class="fa-solid fa-medal"></i>
                                    <span>Official<br />Verified</span>
                                </div>
                            </div>
                            <div class="cert-sign-col">
                                <div class="cert-sign-name" id="modalSignatoryName"><%= CompHr %></div>
                                <div class="cert-sign-title">Authorized Signatory &bull; <%= CompName %></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Live Sync & Drawer Scripts -->
    <script>var COMP_HR = '<%= CompHr %>';</script>
    <script src="../js/company-certificates.js"></script>
</asp:Content>

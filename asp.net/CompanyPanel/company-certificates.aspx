<%@ Page Title="Internship Certificates" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-certificates.aspx.cs" Inherits="asp.net.company_certificates" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <link rel="stylesheet" href="../css/company-certificates.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Header -->
    <div class="page-header-box">
        <div>
            <h1 class="cert-page-title">Internship Certificates</h1>
            <p class="cert-page-subtitle">Automated company-branded completion certificate generator and candidate issuance.</p>
        </div>
        <button type="button" class="btn-open-drawer" onclick="openDrawer();">
            <i class="fa-solid fa-award"></i> Generate New Certificate
        </button>
    </div>
    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

    <!-- ===================== TOP KPI STAT CARDS (ADMIN DASHBOARD STYLE) ===================== -->
    <div class="sims-stat-grid-v2">
        <!-- Card 1: Total Certificates Issued -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-blue">
                <i class="fa-solid fa-award"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2">
                    <asp:Label ID="lblTotalCerts" runat="server"></asp:Label></span>
                <span class="sims-stat-title-v2">Total Certificates Issued</span>
            </div>
        </div>

        <!-- Card 2: Eligible / Completed Interns -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-green">
                <i class="fa-solid fa-user-check"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2">
                    <asp:Label ID="lblEligibleInterns" runat="server"></asp:Label></span>
                <span class="sims-stat-title-v2">Eligible / Completed Interns</span>
            </div>
        </div>

        <!-- Card 3: Certified Students -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-purple">
                <i class="fa-solid fa-user-graduate"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2">
                    <asp:Label ID="lblCertifiedInterns" runat="server"></asp:Label></span>
                <span class="sims-stat-title-v2">Certified Students</span>
            </div>
        </div>

        <!-- Card 4: Pending Issuance -->
        <div class="sims-stat-card-v2">
            <div class="sims-stat-icon-v2 sims-bg-yellow">
                <i class="fa-solid fa-clock-rotate-left"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2">
                    <asp:Label ID="lblPendingCertificates" runat="server"></asp:Label></span>
                <span class="sims-stat-title-v2">Pending Issuance</span>
            </div>
        </div>
    </div>

    <!-- ===================== SEARCH & FILTER BAR (ADMIN PANEL STYLE) ===================== -->
    <div class="co-filter-bar">
        <div class="co-search-wrap">
            <i class="fa-solid fa-magnifying-glass search-icon"></i>
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by candidate name, certificate no, role or title..." CssClass="co-search-input" />
        </div>
        <div class="co-filter-actions">
            <asp:ImageButton ID="btnSearch" runat="server" CausesValidation="false" OnClick="btnSearch_Click" ImageUrl="~/image_button/btn_admin_search.png" Height="40" CssClass="admin-img-btn admin-img-btn-search" />
            <asp:ImageButton ID="btnClearFilters" runat="server" CausesValidation="false" OnClick="btnClearFilters_Click" ImageUrl="~/image_button/btn_admin_clear_filters.png" Height="40" CssClass="admin-img-btn admin-img-btn-clear" />
            <asp:ImageButton ID="btnGenerateReport" runat="server" OnClick="btnGenerateReport_Click" ImageUrl="~/image_button/btn_admin_generate_report.png?v=2" Height="40" CssClass="admin-img-btn admin-img-btn-report" CausesValidation="false" />
        </div>
    </div>

    <!-- ================= ISSUED CERTIFICATES GRIDVIEW ================= -->
    <div class="co-panel co-panel-cert">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-award cert-header-icon"></i> Issued Internship Certificates</h3>
        </div>
        <div class="co-table-responsive">
            <asp:GridView ID="gvCerts" runat="server" AutoGenerateColumns="False" OnRowCommand="gvCerts_RowCommand" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true">
                <Columns>
                    <asp:TemplateField HeaderText="Candidate" ItemStyle-Width="24%">
                        <ItemTemplate>
                            <div class="co-applicant-cell applicant-cell-wrap">
                                <asp:Image ID="imgStudentLogo" runat="server" CssClass="co-applicant-avatar" ImageUrl='<%# Eval("ProfilePhoto") %>' onerror="this.onerror=null;this.src='../student_images/default-avatar.png';" />
                                <div>
                                    <div class="applicant-name"><%# Eval("FullName") %></div>
                                    <div class="applicant-email"><%# Eval("StudentEmail") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Certificate Title" ItemStyle-Width="18%">
                        <ItemTemplate>
                            <div class="cert-title-cell">
                                <asp:Label ID="lblCertTitle" runat="server" CssClass="lbl-cert-title" Text='<%# Eval("CertificateTitle") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Role" ItemStyle-Width="15%">
                        <ItemTemplate>
                            <div class="cert-role-cell">
                                <asp:Label ID="lblRole" runat="server" CssClass="lbl-role" Text='<%# Eval("InternshipRole") != null && !string.IsNullOrEmpty(Eval("InternshipRole").ToString()) ? Eval("InternshipRole") : Eval("InternshipTitle") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ID / Code" ItemStyle-Width="13%">
                        <ItemTemplate>
                            <div class="cert-code-cell">
                                <asp:Label ID="lblCertNo" runat="server" CssClass="lbl-cert-no" Text='<%# Eval("CertificateNo") %>'></asp:Label>
                                <div class="lbl-code-sub">Code: <asp:Label ID="lblVerificationCode" runat="server" CssClass="lbl-verify-code" Text='<%# Eval("VerificationCode") %>'></asp:Label></div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issue Date" ItemStyle-Width="9%">
                        <ItemTemplate>
                            <asp:Label ID="lblIssueDate" runat="server" CssClass="lbl-issue-date" Text='<%# Eval("IssueDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="8%">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# GetCertStatusBadge(Eval("Status")) %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end" ItemStyle-Width="12%">
                        <ItemTemplate>
                            <div class="table-actions-cell">
                                <button type="button" class="btn-table-action btn-action-view"
                                        onclick='openCertModal("<%# Eval("FullName") %>", "<%# Eval("College") %>", "<%# Eval("CertificateTitle") %>", "<%# Eval("InternshipRole") != null && !string.IsNullOrEmpty(Eval("InternshipRole").ToString()) ? Eval("InternshipRole") : Eval("InternshipTitle") %>", "<%# Eval("Duration") %>", "<%# Eval("IssueDate") %>", "<%# Eval("Performance") %>", "<%# Eval("SignatoryName") %>", "<%# Eval("CertificateNo") %>", "<%# Eval("VerificationCode") %>");'>
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
                <div class="empty-cert-state">
                    <i class="fa-solid fa-certificate empty-cert-icon"></i>
                    <h4 class="empty-cert-title">No Certificates Issued Yet</h4>
                    <p class="empty-cert-desc">Click on <strong>Generate New Certificate</strong> above to issue a verified completion certificate for a student.</p>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>

    <!-- Pagination -->
    <div class="pagination">
        <asp:ImageButton ID="btnPrevious" runat="server" ImageUrl="~/assets/btn_previous.png" Height="42" OnClick="btnPrevious_Click" CssClass="admin-img-btn" CausesValidation="false" />
        <asp:Label ID="lblPages" runat="server" CssClass="pagination-pages" />
        <asp:ImageButton ID="btnNext" runat="server" ImageUrl="~/assets/btn_next.png" Height="42" OnClick="btnNext_Click" CssClass="admin-img-btn" CausesValidation="false" />
    </div>
    <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />

    <!-- ================= MODAL DRAWER: CERTIFICATE GENERATOR & LIVE PREVIEW ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>
    <div class="drawer-panel" id="drawerPanel">
        <div class="drawer-header">
            <h2><i class="fa-solid fa-award drawer-title-icon"></i> Generate Internship Certificate</h2>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();">&times;</button>
        </div>
        <div class="drawer-body">
            <div class="cert-builder-grid">
                <!-- Left: Quick Details Fill Form -->
                <div class="builder-form-card">
                    <h2><i class="fa-solid fa-file-pen form-title-icon"></i> Certificate Details Form</h2>
                    <div class="form-item">
                        <label><i class="fa-solid fa-user-check label-icon-blue"></i> Select Candidate with Completed Tasks / Quizzes <span class="required-star">*</span></label>
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
                        <label>Certificate Title <span class="required-star">*</span></label>
                        <asp:TextBox ID="txtCertTitle" runat="server" placeholder="e.g. Certificate of Internship Excellence" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Internship Role / Position <span class="required-star">*</span></label>
                            <asp:TextBox ID="txtInternshipRole" runat="server" placeholder="e.g. Full Stack Developer" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Duration / Period</label>
                            <asp:TextBox ID="txtDuration" runat="server" placeholder="e.g. 3 Months" CssClass="form-input-ctrl" oninput="updateCertPreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Issue Date <span class="required-star">*</span></label>
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
                        <div class="preview-title-wrap">
                            <span class="preview-title-text"><i class="fa-solid fa-eye preview-eye-icon"></i> Live Certificate Template Preview</span>
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
                                            <img src="<%= CompLogo %>" class="cert-brand-logo" />
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
                                    For successfully completing the professional internship program as <strong id="prevCertRole" class="cert-role-highlight"><%= SelectedRole %></strong> at <strong><%= CompName %></strong> for a duration of <strong id="prevCertDuration"><%= SelectedDuration %></strong>. During this tenure, the candidate demonstrated exemplary professionalism, technical capability, and <strong id="prevCertPerformance" class="cert-perf-highlight"><%= SelectedPerformance %></strong>.
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
                <div class="modal-title-text">
                    <i class="fa-solid fa-award modal-icon-award"></i> Official Verified Certificate
                </div>
                <div class="modal-btn-wrap">
                    <button type="button" class="btn-print-btn" onclick="window.print();">
                        <i class="fa-solid fa-print"></i> Print / Save PDF
                    </button>
                    <button type="button" class="btn-close-modal" onclick="closePrintModal();">&times;</button>
                </div>
            </div>
            <div class="modal-body-container">
                <div class="cert-canvas-doc" id="printableCertDoc">
                    <div class="cert-inner-border">
                        <!-- Top Brand -->
                        <div class="cert-top-brand">
                            <div class="cert-brand-left">
                                <% if (!string.IsNullOrEmpty(CompLogo)) { %>
                                    <img src="<%= CompLogo %>" class="cert-brand-logo" />
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
                            For successfully completing the professional internship program as <strong id="modalCertRole" class="cert-role-highlight">[Internship Role]</strong> at <strong><%= CompName %></strong> for a duration of <strong id="modalCertDuration">3 Months</strong>. During this tenure, the candidate demonstrated exemplary professionalism, technical capability, and <strong id="modalCertPerformance" class="cert-perf-highlight">Outstanding Performance &amp; Dedication</strong>.
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

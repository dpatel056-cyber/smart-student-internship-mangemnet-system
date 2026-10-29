<%@ Page Title="Offer Letters" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-offer-letters.aspx.cs" Inherits="asp.net.company_offer_letters" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <link rel="stylesheet" href="../css/company-offer-letters.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header -->
    <div class="page-header-box">
        <div>
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Offer Letters</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Generate, preview, issue, and manage official internship offer letters for selected candidates.</p>
        </div>
        <button type="button" class="btn-open-drawer" onclick="openDrawer();">
            <i class="fa-solid fa-file-circle-plus"></i> Generate New Offer Letter
        </button>
    </div>
    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    <!-- Stats Summary Cards -->
    <div class="task-stats-grid">
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#eff6ff; color:#2563eb; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-file-signature"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblTotalOffers" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Total Offers Issued</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#f0fdf4; color:#16a34a; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-circle-check"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblAcceptedOffers" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Accepted Offers</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#fef9c3; color:#ca8a04; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-paper-plane"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblSentOffers" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Sent / Pending Response</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div style="width:44px; height:44px; border-radius:12px; background:#fee2e2; color:#dc2626; display:flex; align-items:center; justify-content:center; font-size:18px;"><i class="fa-solid fa-circle-xmark"></i></div>
            <div>
                <div style="font-size:20px; font-weight:700; color:#0f172a;"><asp:Label ID="lblRejectedOffers" runat="server">0</asp:Label></div>
                <div style="font-size:13px; color:#64748b;">Declined / Rejected</div>
            </div>
        </div>
    </div>
    <!-- ================= ISSUED OFFER LETTERS GRIDVIEW ================= -->
    <div class="co-panel" style="margin-bottom: 30px; width: 100%;">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-file-signature" style="color: #2563eb; margin-right: 8px;"></i> Issued Offer Letters</h3>
        </div>
        <div class="co-table-responsive">
            <asp:GridView ID="gvOffers" runat="server" AutoGenerateColumns="False" OnRowCommand="gvOffers_RowCommand" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true">
                <Columns>
                    <asp:TemplateField HeaderText="Candidate" ItemStyle-Width="25%">
                        <ItemTemplate>
                            <div class="co-applicant-cell" style="min-width: 210px;">
                                <asp:Image ID="imgStudentLogo" runat="server" CssClass="co-applicant-avatar" ImageUrl='<%# Eval("ProfilePhoto") %>' onerror="this.onerror=null;this.src='../student_images/default-avatar.png';" />
                                <div>
                                    <div style="font-weight: 700; color: #0f172a; font-size: 13.5px;"><%# Eval("FullName") %></div>
                                    <div style="font-size: 12px; color: #64748b;"><%# Eval("StudentEmail") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Offer Designation & Stipend" ItemStyle-Width="26%">
                        <ItemTemplate>
                            <div style="min-width: 210px;">
                                <div style="font-weight: 600; color: #1e293b; font-size: 13px;"><%# Eval("OfferTitle") %></div>
                                <div style="font-size: 12.5px; color: #15803d; font-weight: 600; margin-top: 2px;"><%# FormatStipend(Eval("Stipend")) %></div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Joining Date" ItemStyle-Width="14%">
                        <ItemTemplate>
                            <span style="font-size: 13px; color: #334155; font-weight: 600; white-space: nowrap;"><%# Eval("JoiningDate") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Issued Date" ItemStyle-Width="12%">
                        <ItemTemplate>
                            <span style="font-size: 12.5px; color: #64748b; font-weight: 500; white-space: nowrap;"><%# FormatDate(Eval("IssuedDate")) %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="10%">
                        <ItemTemplate>
                            <div style="white-space: nowrap;">
                                <%# GetOfferStatusBadge(Eval("Status")) %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end" ItemStyle-Width="13%">
                        <ItemTemplate>
                            <div style="display: flex; align-items: center; justify-content: flex-end; gap: 6px; flex-wrap: nowrap; min-width: 180px;">
                                <button type="button" class="btn-table-action btn-action-view"
                                        onclick='openLetterModal("<%# Eval("FullName") %>", "<%# Eval("College") %>", "<%# Eval("OfferTitle") %>", "<%# Eval("Stipend") %>", "<%# Eval("JoiningDate") %>", "<%# Eval("Duration") %>", "<%# Eval("Location") %>", "<%# Eval("OfferId") %>", "<%# FormatDate(Eval("IssuedDate")) %>");'
>
                                    <i class="fa-solid fa-print"></i> View &amp; Print
                                </button>
                                <asp:LinkButton ID="lnkEdit" runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("OfferId") %>' CssClass="btn-table-action btn-action-edit">
                                    <i class="fa-solid fa-pen"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkDelete" runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("OfferId") %>' OnClientClick="return confirm('Are you sure you want to delete this offer letter?');" CssClass="btn-table-action btn-action-delete">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoOffers" runat="server" Visible="false">
                <div style="text-align: center; padding: 50px 20px; color: #64748b;">
                    <i class="fa-solid fa-file-circle-xmark" style="font-size: 46px; color: #cbd5e1; margin-bottom: 14px; display: block;"></i>
                    <h4 style="font-size: 17px; font-weight: 700; color: #1e293b; margin-bottom: 6px;">No Offer Letters Issued Yet</h4>
                    <p style="font-size: 13.5px; margin: 0 0 16px 0;">Click the button below to issue an official offer letter to a selected student.</p>
                    <button type="button" class="btn-open-drawer" onclick="openDrawer();">
                        <i class="fa-solid fa-file-circle-plus"></i> Generate New Offer Letter
                    </button>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
    <!-- ================= CENTER MODAL DIALOG FOR OFFER LETTER GENERATION & LIVE PREVIEW ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>
    <div class="drawer-panel" id="drawerPanel">
        <div class="drawer-header">
            <h2><i class="fa-solid fa-file-signature" style="color: #2563eb;"></i> Generate Internship Offer Letter</h2>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();">&times;</button>
        </div>
        <div class="drawer-body">
            <!-- Two-Column Offer Letter Builder & Live Letterhead Preview -->
            <div class="offer-builder-grid">
                <!-- Left: Quick Details Fill Form -->
                <div class="builder-form-card">
                    <h2><i class="fa-solid fa-file-pen" style="color: #2563eb;"></i> Offer Details Form</h2>
                    <div class="form-item">
                        <label><i class="fa-solid fa-user-check" style="color:#2563eb; margin-right:4px;"></i> Select Selected Candidate <span style="color:#ef4444;">*</span></label>
                        <asp:DropDownList ID="ddlCandidate" runat="server" CssClass="form-input-ctrl" AutoPostBack="true" OnSelectedIndexChanged="ddlCandidate_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Candidate Full Name</label>
                            <asp:TextBox ID="txtCandidateName" runat="server" placeholder="Candidate Name" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Candidate College / Inst.</label>
                            <asp:TextBox ID="txtCandidateCollege" runat="server" placeholder="College / Institute" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Offer Issue Date</label>
                            <asp:TextBox ID="txtOfferDate" runat="server" TextMode="Date" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Offer Designation / Role <span style="color:#ef4444;">*</span></label>
                            <asp:TextBox ID="txtOfferTitle" runat="server" placeholder="e.g. Frontend Developer Intern" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Monthly Stipend (&#8377;)</label>
                            <asp:TextBox ID="txtStipend" runat="server" placeholder="e.g. 15,000 / month" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Internship Duration</label>
                            <asp:TextBox ID="txtDuration" runat="server" placeholder="e.g. 3 Months" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row-2">
                        <div class="form-item">
                            <label>Joining Date <span style="color:#ef4444;">*</span></label>
                            <asp:TextBox ID="txtJoiningDate" runat="server" TextMode="Date" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                        <div class="form-item">
                            <label>Acceptance Deadline</label>
                            <asp:TextBox ID="txtValidTill" runat="server" TextMode="Date" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-item">
                        <label>Work Location / Office Address</label>
                        <asp:TextBox ID="txtWorkLocation" runat="server" placeholder="e.g. Ahmedabad, Gujarat" CssClass="form-input-ctrl" oninput="updateTemplatePreview();"></asp:TextBox>
                    </div>
                </div>
                <!-- Right: Live Letterhead Preview (Auto-Updates in Real-Time) -->
                <div class="preview-wrapper">
                    <div class="preview-header-bar">
                        <div style="font-weight: 700; color: #0f172a; font-size: 14px;">
                            <i class="fa-solid fa-eye" style="color: #2563eb; margin-right: 6px;"></i> Live Letterhead Preview
                        </div>
                        <div class="live-badge">
                            <span class="live-dot"></span> Live Real-Time
                        </div>
                    </div>
                    <div class="letterhead-scroll-box">
                        <!-- Live Letterhead Box -->
                        <div class="letterhead-doc">
                            <!-- Header -->
                            <div class="lh-header">
                                <div class="lh-brand-info">
                                    <% if (!string.IsNullOrEmpty(CompLogo)) { %>
                                        <img src="<%= CompLogo %>" style="height: 32px; max-width: 120px; object-fit: contain; margin-bottom: 4px; display: block;" />
                                    <% } %>
                                    <h2 class="lh-brand-name"><%= CompName %></h2>
                                    <p class="lh-brand-sub">Internship & Talent Acquisition Division</p>
                                </div>
                                <div class="lh-company-meta">
                                    <div><%= CompLocation %></div>
                                    <div><%= CompEmail %></div>
                                    <div><%= CompPhone %></div>
                                    <% if (!string.IsNullOrEmpty(CompWebsite)) { %><div><%= CompWebsite %></div><% } %>
                                </div>
                            </div>
                            <!-- Date & Ref -->
                            <div class="lh-date-ref">
                                <span>REF: <%= DateTime.Now.Year %>/OFFER/<span id="prevRefCode">001</span></span>
                                <span>Date: <span id="prevOfferDate"><%= FormattedOfferDate %></span></span>
                            </div>
                            <!-- Candidate To Box -->
                            <div class="lh-recipient-box">
                                <p style="font-weight: 700; color: #0f172a;">To,</p>
                                <p style="font-weight: 700; color: #2563eb; font-size: 13.5px;" id="prevCandidateName"><%= SelectedCandName %></p>
                                <p id="prevCandidateCollege"><%= SelectedCandCollege %></p>
                            </div>
                            <!-- Subject -->
                            <div class="lh-subject">
                                Subject: Formal Internship Offer Letter - <span id="prevSubjectRole" style="color: #2563eb;"><%= SelectedRole %></span>
                            </div>
                            <!-- Letter Body -->
                            <p style="margin-bottom: 10px;">
                                Dear <strong id="prevSalutationName"><%= SelectedCandName %></strong>,
                            </p>
                            <p style="margin-bottom: 10px;">
                                On behalf of <strong><%= CompName %></strong>, we are pleased to offer you an internship position as <strong id="prevBodyRole" style="color: #2563eb;"><%= SelectedRole %></strong>. We were very impressed by your qualifications and performance during the selection process.
                            </p>
                            <!-- Offer Terms Matrix Table -->
                            <table class="lh-terms-table">
                                <tr>
                                    <th>Position / Role</th>
                                    <td id="prevTableRole"><%= SelectedRole %></td>
                                </tr>
                                <tr>
                                    <th>Internship Duration</th>
                                    <td id="prevTableDuration"><%= SelectedDuration %></td>
                                </tr>
                                <tr>
                                    <th>Monthly Stipend</th>
                                    <td id="prevTableStipend" style="color: #15803d;"><%= SelectedStipend %></td>
                                </tr>
                                <tr>
                                    <th>Expected Joining Date</th>
                                    <td id="prevTableJoiningDate"><%= SelectedJoining %></td>
                                </tr>
                                <tr>
                                    <th>Work Location / Mode</th>
                                    <td id="prevTableLocation"><%= SelectedLocation %></td>
                                </tr>
                                <tr>
                                    <th>Offer Acceptance Deadline</th>
                                    <td id="prevTableValidTill"><%= SelectedValidTill %></td>
                                </tr>
                            </table>
                            <p style="margin-bottom: 14px; font-size: 12px; color: #475569;">
                                Please confirm your acceptance of this offer by signing and returning a copy of this letter or confirming directly on the portal before the acceptance deadline.
                            </p>
                            <!-- Signatory Section -->
                            <div class="lh-sign-section">
                                <div>
                                    <div style="font-weight: 700; color: #0f172a;"><%= CompHr %></div>
                                    <div style="font-size: 11.5px; color: #64748b;">Authorized Signatory &bull; <%= CompName %></div>
                                </div>
                                <div class="lh-seal-badge">
                                    <i class="fa-solid fa-certificate"></i> Official Verified Offer
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="drawer-footer">
            <button type="button" class="btn-drawer-cancel" onclick="closeDrawer();">Cancel</button>
            <asp:Button ID="btnReset" runat="server" Text="Reset Form" CssClass="btn-reset-form" OnClick="btnResetForm_Click" CausesValidation="false" />
            <asp:LinkButton ID="btnIssueOffer" runat="server" CssClass="btn-send-offer" OnClick="btnIssueOffer_Click">
                <i class="fa-solid fa-paper-plane"></i> Send Offer Letter to Student
            </asp:LinkButton>
        </div>
    </div>
    <!-- ================= FULLSCREEN PRINT / VIEW MODAL (100% IDENTICAL TO PREVIEW) ================= -->
    <div class="print-modal-overlay" id="printModal" onclick="closePrintModal(event);">
        <div class="print-modal-container" onclick="event.stopPropagation();">
            <div class="print-modal-bar">
                <div style="font-weight:700; color:#0f172a; font-size:15px;">
                    <i class="fa-solid fa-file-signature" style="color:#2563eb;"></i> Official Company Offer Letter
                </div>
                <div style="display:flex; gap:10px; align-items:center;">
                    <button type="button" class="btn-print-btn" onclick="window.print();">
                        <i class="fa-solid fa-print"></i> Print / Save PDF
                    </button>
                    <button type="button" class="btn-close-modal" onclick="closePrintModal();">&times;</button>
                </div>
            </div>
            <div style="padding: 24px;">
                <div class="letterhead-doc" id="printableLetterhead" style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:32px 36px;">
                    <!-- Company Header -->
                    <div class="lh-company-header">
                        <div>
                            <% if (!string.IsNullOrEmpty(CompLogo)) { %>
                                <img src="<%= CompLogo %>" style="height: 38px; max-width: 140px; object-fit: contain; margin-bottom: 6px; display: block;" />
                            <% } %>
                            <h2 class="lh-brand-name"><%= CompName %></h2>
                            <p class="lh-brand-sub">Internship & Talent Acquisition Division</p>
                        </div>
                        <div class="lh-company-meta">
                            <div><%= CompLocation %></div>
                            <div><%= CompEmail %></div>
                            <div><%= CompPhone %></div>
                            <% if (!string.IsNullOrEmpty(CompWebsite)) { %><div><%= CompWebsite %></div><% } %>
                        </div>
                    </div>
                    <!-- Date & Ref -->
                    <div class="lh-date-ref">
                        <span>REF: <%= DateTime.Now.Year %>/OFFER/<span id="modalRef">001</span></span>
                        <span>Date: <span id="modalOfferDate"><%= DateTime.Now.ToString("dd MMMM yyyy") %></span></span>
                    </div>
                    <!-- Candidate To Box -->
                    <div class="lh-recipient-box">
                        <p style="font-weight: 700; color: #0f172a;">To,</p>
                        <p style="font-weight: 700; color: #2563eb; font-size: 13.5px;" id="modalCandName">[Candidate Full Name]</p>
                        <p id="modalCandCollege">[College / University Name]</p>
                    </div>
                    <!-- Subject -->
                    <div class="lh-subject">
                        Subject: Formal Internship Offer Letter - <span id="modalSubjectRole" style="color: #2563eb;">[Internship Role]</span>
                    </div>
                    <!-- Letter Body -->
                    <p style="margin-bottom: 10px;">
                        Dear <strong id="modalSalutation">[Candidate Name]</strong>,
                    </p>
                    <p style="margin-bottom: 10px;">
                        On behalf of <strong><%= CompName %></strong>, we are pleased to offer you an internship position as <strong id="modalBodyRole" style="color: #2563eb;">[Internship Role]</strong>. We were very impressed by your qualifications and performance during the selection process.
                    </p>
                    <!-- Offer Terms Matrix Table (All 6 Rows) -->
                    <table class="lh-terms-table">
                        <tr>
                            <th>Position / Role</th>
                            <td id="modalTableRole">[Internship Role]</td>
                        </tr>
                        <tr>
                            <th>Internship Duration</th>
                            <td id="modalTableDuration">3 Months</td>
                        </tr>
                        <tr>
                            <th>Monthly Stipend</th>
                            <td id="modalTableStipend" style="color: #15803d;">&#8377; 15,000 / month</td>
                        </tr>
                        <tr>
                            <th>Expected Joining Date</th>
                            <td id="modalTableJoiningDate"><%= DateTime.Now.AddDays(7).ToString("dd MMM yyyy") %></td>
                        </tr>
                        <tr>
                            <th>Work Location / Mode</th>
                            <td id="modalTableLocation"><%= CompLocation %></td>
                        </tr>
                        <tr>
                            <th>Offer Acceptance Deadline</th>
                            <td id="modalTableValidTill"><%= DateTime.Now.AddDays(14).ToString("dd MMM yyyy") %></td>
                        </tr>
                    </table>
                    <p style="margin-bottom: 14px; font-size: 12px; color: #475569;">
                        Please confirm your acceptance of this offer by signing and returning a copy of this letter or confirming directly on the portal before the acceptance deadline.
                    </p>
                    <!-- Signatory Section -->
                    <div class="lh-sign-section">
                        <div>
                            <div style="font-weight: 700; color: #0f172a;"><%= CompHr %></div>
                            <div style="font-size: 11.5px; color: #64748b;">Authorized Signatory &bull; <%= CompName %></div>
                        </div>
                        <div class="lh-seal-badge">
                            <i class="fa-solid fa-certificate"></i> Official Verified Offer
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Live Sync & Drawer Scripts -->
    <script>
        var COMP_LOCATION = '<%= CompLocation %>';
        var DEFAULT_JOINING_DATE = '<%= DateTime.Now.AddDays(7).ToString("dd MMM yyyy") %>';
        var DEFAULT_VALID_TILL = '<%= DateTime.Now.AddDays(14).ToString("dd MMM yyyy") %>';
    </script>
    <script src="../js/company-offer-letters.js"></script>
</asp:Content>

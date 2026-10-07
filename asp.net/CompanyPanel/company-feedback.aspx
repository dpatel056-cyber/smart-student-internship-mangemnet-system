<%@ Page Title="Feedback & Ratings" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-feedback.aspx.cs" Inherits="asp.net.company_feedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --fb-primary: #2563EB;
            --fb-primary-hover: #1D4ED8;
            --fb-bg: #F8FAFC;
            --fb-card-bg: #FFFFFF;
            --fb-text-main: #0F172A;
            --fb-text-muted: #64748B;
            --fb-border: #E2E8F0;
            --fb-shadow: 0 4px 20px rgba(15, 23, 42, 0.06);
            --fb-radius: 16px;
        }
        .feedback-page-wrapper {
            width: 100%;
            padding: 10px 0 50px 0;
        }
        .feedback-container {
            width: 100%;
            max-width: 100%;
        }
        .page-header-box {
            margin-bottom: 24px;
        }
        .page-title h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--fb-text-main);
            margin: 0 0 4px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .page-title h1 i {
            color: #F59E0B;
        }
        .page-title p {
            font-size: 14px;
            color: var(--fb-text-muted);
            margin: 0;
            line-height: 1.5;
        }
        .feedback-card {
            background: #ffffff;
            border: 1px solid var(--fb-border);
            border-radius: var(--fb-radius);
            padding: 28px 30px;
            box-shadow: var(--fb-shadow);
            box-sizing: border-box;
            max-width: 560px;
            margin: 0 auto;
        }
        @media (max-width: 600px) {
            .feedback-card {
                padding: 24px 20px;
            }
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            display: block;
            font-size: 13.5px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
        }
        .form-control-select, .form-control-textarea, .form-control-input {
            width: 100%;
            padding: 11px 14px;
            border: 1.5px solid #CBD5E1;
            border-radius: 10px;
            font-size: 14px;
            color: #0F172A;
            outline: none;
            box-sizing: border-box;
            background: #F8FAFC;
            transition: all 0.2s ease;
            font-family: inherit;
        }
        .form-control-select:focus, .form-control-textarea:focus, .form-control-input:focus {
            background: #ffffff;
            border-color: var(--fb-primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }
        /* Interactive Star Rating Area */
        .rating-stars-wrapper {
            display: flex;
            align-items: center;
            gap: 12px;
            background: #F8FAFC;
            border: 1px solid var(--fb-border);
            border-radius: 10px;
            padding: 12px 16px;
            margin-bottom: 10px;
        }
        .stars-container {
            display: flex;
            gap: 8px;
            font-size: 24px;
            color: #CBD5E1;
            cursor: pointer;
        }
        .stars-container i {
            transition: color 0.15s ease, transform 0.15s ease;
        }
        .stars-container i:hover {
            transform: scale(1.15);
        }
        .stars-container i.active {
            color: #F59E0B;
        }
        .rating-text-label {
            font-size: 13.5px;
            font-weight: 600;
            color: #475569;
            margin-left: auto;
        }
        .btn-submit-feedback {
            background: var(--fb-primary);
            color: #ffffff;
            border: none;
            width: 100%;
            padding: 13px 24px;
            font-size: 15px;
            font-weight: 600;
            border-radius: 10px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: background 0.2s, transform 0.1s;
        }
        .btn-submit-feedback:hover {
            background: var(--fb-primary-hover);
        }
        .btn-submit-feedback:active {
            transform: scale(0.99);
        }
        /* ================= GRID TABLE STYLES (MATCHING STUDENT & ADMIN PANELS) ================= */
        .fb-custom-table { width: 100%; border-collapse: collapse; }
        .fb-custom-table th { background: #f8fafc; padding: 14px 16px; font-size: 12.5px; font-weight: 700; color: #475569; text-transform: uppercase; border-bottom: 2px solid #e2e8f0; text-align: left; }
        .fb-custom-table td { padding: 14px 16px; border-bottom: 1px solid #f1f5f9; font-size: 13.5px; vertical-align: middle; }
        .fb-custom-table tr:hover td { background: #fafcff; }
        .btn-action-view {
            padding: 7px 14px;
            background: #ffffff;
            color: #2563eb;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            border: 1.5px solid #bfdbfe;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 1px 2px rgba(37, 99, 235, 0.05);
        }
        .btn-action-view:hover {
            background: #eff6ff;
            border-color: #93c5fd;
            color: #1d4ed8;
            transform: translateY(-1px);
        }
        .btn-action-delete {
            padding: 7px 14px;
            background: #ffffff;
            color: #ef4444;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            border: 1.5px solid #fecaca;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 1px 2px rgba(239, 68, 68, 0.05);
        }
        .btn-action-delete:hover {
            background: #fef2f2;
            border-color: #fca5a5;
            color: #dc2626;
            transform: translateY(-1px);
        }
        /* ================= CENTER DRAWER MODAL STYLES ================= */
        .drawer-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.40);
            backdrop-filter: blur(2px);
            z-index: 1040;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s ease, visibility 0.3s ease;
        }
        .drawer-overlay.is-active {
            opacity: 1;
            visibility: visible;
        }
        .feedback-drawer {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0.95);
            width: 600px;
            max-width: 92vw;
            max-height: 85vh;
            background: #ffffff;
            z-index: 1050;
            display: flex;
            flex-direction: column;
            border-radius: 16px;
            border: 1px solid #E2E8F0;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
            opacity: 0;
            visibility: hidden;
            transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1), opacity 0.3s cubic-bezier(0.16, 1, 0.3, 1), visibility 0.3s;
        }
        .feedback-drawer.is-open {
            transform: translate(-50%, -50%) scale(1);
            opacity: 1;
            visibility: visible;
        }
        .drawer-header {
            min-height: 74px;
            padding: 0 28px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #ffffff;
            border-bottom: 1px solid #E2E8F0;
            flex-shrink: 0;
            border-radius: 16px 16px 0 0;
        }
        .drawer-header h3 {
            font-size: 18px;
            font-weight: 700;
            color: #0F172A;
            margin: 0;
        }
        .drawer-close-btn {
            width: 36px;
            height: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: transparent;
            border: none;
            color: #94A3B8;
            font-size: 21px;
            border-radius: 8px;
            cursor: pointer;
            transition: all .2s ease;
        }
        .drawer-close-btn:hover {
            background: #F1F5F9;
            color: #475569;
        }
        .drawer-body {
            flex: 1;
            overflow-y: auto;
            padding: 26px 28px 35px;
            background: #fff;
            box-sizing: border-box;
            border-radius: 0 0 16px 16px;
        }
        /* Details Grid */
        .cm-detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            column-gap: 38px;
            row-gap: 22px;
            margin-bottom: 22px;
        }
        .cm-detail-item {
            display: flex;
            flex-direction: column;
            gap: 6px;
            min-width: 0;
        }
        .cm-detail-label {
            display: block;
            font-size: 11px;
            font-weight: 700;
            color: #7890AD;
            text-transform: uppercase;
            letter-spacing: .08em;
        }
        .cm-detail-value {
            display: block;
            font-size: 15px;
            line-height: 1.45;
            font-weight: 600;
            color: #172554;
            overflow-wrap: anywhere;
        }
        .cm-subject-section {
            display: flex;
            flex-direction: column;
            gap: 6px;
            margin-bottom: 22px;
        }
        .cm-subject-value {
            display: block;
            font-size: 17px;
            line-height: 1.4;
            font-weight: 700;
            color: #172554;
            overflow-wrap: anywhere;
        }
        .cm-message-section {
            margin-bottom: 5px;
        }
        .cm-message-box {
            width: 100%;
            box-sizing: border-box;
            padding: 17px 18px;
            background: #F8FAFC;
            border: 1px solid #E2E8F0;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(15,23,42,.03);
        }
        .cm-message-text {
            display: block;
            font-size: 14px;
            line-height: 1.65;
            color: #334155;
            overflow-wrap: anywhere;
            white-space: pre-wrap;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="feedback-page-wrapper">
        <div class="feedback-container">
            <!-- Page Header -->
            <div class="page-header-box">
                <div class="page-title">
                    <h1><i class="fa-solid fa-star"></i> Feedback &amp; Ratings</h1>
                    <p>Provide general platform suggestions to administrators, and view reviews submitted by students for your internships.</p>
                </div>
            </div>
            <!-- Form Card: General Feedback to Admin -->
            <div class="feedback-card">
                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                <div class="form-group">
                    <label class="form-label">Feedback Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control-select">
                        <asp:ListItem Text="Portal Experience &amp; Features" Value="Portal Experience" />
                        <asp:ListItem Text="Student Candidate Quality" Value="Candidate Quality" />
                        <asp:ListItem Text="Internship Application Management" Value="Recruitment Process" />
                        <asp:ListItem Text="Admin Support &amp; Verification" Value="Support" />
                        <asp:ListItem Text="General Suggestions &amp; Improvements" Value="General Suggestions" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="form-label">Overall Platform Rating</label>
                    <!-- Interactive Visual Stars -->
                    <div class="rating-stars-wrapper">
                        <div class="stars-container" id="starsContainer">
                            <i class="fa-solid fa-star active" data-val="1"></i>
                            <i class="fa-solid fa-star active" data-val="2"></i>
                            <i class="fa-solid fa-star active" data-val="3"></i>
                            <i class="fa-solid fa-star active" data-val="4"></i>
                            <i class="fa-solid fa-star active" data-val="5"></i>
                        </div>
                        <span class="rating-text-label" id="ratingTextLabel">5 - Excellent</span>
                    </div>
                    <!-- Clean Standard DropDown -->
                    <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-control-select" onchange="syncRatingFromDropdown(this.value);">
                        <asp:ListItem Text="5 - Excellent" Value="5" Selected="True" />
                        <asp:ListItem Text="4 - Very Good" Value="4" />
                        <asp:ListItem Text="3 - Good" Value="3" />
                        <asp:ListItem Text="2 - Fair" Value="2" />
                        <asp:ListItem Text="1 - Needs Improvement" Value="1" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="form-label">Subject / Title <span style="color:#ef4444;">*</span></label>
                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control-input" placeholder="e.g. Great hiring experience on the portal"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Your Detailed Review / Comments <span style="color:#ef4444;">*</span></label>
                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control-textarea" placeholder="Share your detailed feedback, highlights, or suggestions for the admin team..."></asp:TextBox>
                </div>
                <asp:Button ID="btnSubmitFeedback" runat="server" Text="Submit Feedback" CssClass="btn-submit-feedback" OnClick="btnSubmitFeedback_Click" />
            </div>
            <!-- SECTION 1: Student Reviews on Company Internships -->
            <div style="margin-top: 36px; background: #ffffff; border: 1px solid var(--fb-border); border-radius: var(--fb-radius); overflow: hidden; box-shadow: var(--fb-shadow);">
                <div style="padding: 18px 24px; border-bottom: 1px solid var(--fb-border); font-weight: 700; color: #0f172a; font-size: 16px; display: flex; align-items: center; justify-content: space-between; background: #ffffff;">
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <i class="fa-solid fa-star" style="color:#f59e0b;"></i>
                        <span>Student Reviews on Your Internships</span>
                        <asp:Label ID="lblStudentReviewCount" runat="server" style="font-size: 13px; color: #64748b; font-weight: 500; margin-left: 4px;"></asp:Label>
                    </div>
                </div>
                <div style="overflow-x: auto;">
                    <asp:GridView ID="gvStudentReviews" runat="server" AutoGenerateColumns="False" CssClass="fb-custom-table" GridLines="None" ShowHeaderWhenEmpty="true">
                        <Columns>
                            <asp:TemplateField HeaderText="STUDENT">
                                <ItemTemplate>
                                    <div style="font-weight: 600; color: #0f172a; font-size: 14px;"><%# Eval("SenderName") %></div>
                                    <div style="font-size: 12px; color: #64748b;"><%# Eval("SenderEmail") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="INTERNSHIP">
                                <ItemTemplate>
                                    <span style="font-size: 13px; color: #2563eb; font-weight: 600;"><%# Eval("InternshipTitle") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CATEGORY">
                                <ItemTemplate>
                                    <span style="font-size: 12.5px; color: #475569; background: #f1f5f9; padding: 4px 10px; border-radius: 6px; font-weight: 600; display: inline-block;">
                                        <%# Eval("FeedbackCategory") %>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RATING">
                                <HeaderStyle Width="150px" />
                                <ItemStyle Width="150px" Wrap="False" />
                                <ItemTemplate>
                                    <div style="display: inline-flex; align-items: center; gap: 8px; white-space: nowrap;">
                                        <%# GetStars(Eval("Rating")) %>
                                        <span style="font-size: 12.5px; font-weight: 700; color: #334155; white-space: nowrap;"><%# Eval("Rating") %> / 5</span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SUBMITTED DATE">
                                <ItemTemplate>
                                    <span style="color: #475569; font-size: 13px; white-space: nowrap;"><i class="fa-regular fa-calendar" style="color: #94a3b8; margin-right: 4px;"></i><%# FormatDate(Eval("CreatedDate")) %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SUBMITTED TIME">
                                <ItemTemplate>
                                    <span style="color: #64748b; font-size: 13px; white-space: nowrap;"><i class="fa-regular fa-clock" style="color: #94a3b8; margin-right: 4px;"></i><%# FormatTime(Eval("CreatedDate")) %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ACTIONS">
                                <ItemTemplate>
                                    <button type="button" class="btn-action-view"
                                            onclick="openReviewDrawer('<%# CleanJsString(Eval("SenderName")) %>', '<%# CleanJsString(Eval("SenderEmail")) %>', '<%# CleanJsString(Eval("InternshipTitle")) %>', '<%# CleanJsString(Eval("FeedbackCategory")) %>', '<%# Eval("Rating") %>', '<%# CleanJsString(Eval("Subject")) %>', '<%# CleanJsString(Eval("Message")) %>', '<%# FormatDate(Eval("CreatedDate")) %>', '<%# FormatTime(Eval("CreatedDate")) %>');">
                                        <i class="fa-solid fa-eye"></i> View
                                    </button>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <asp:PlaceHolder ID="pnlNoStudentReviews" runat="server" Visible="false"><div style="text-align:center; padding:40px 20px;">
                    <i class="fa-solid fa-star-half-stroke" style="font-size: 36px; color: #cbd5e1; margin-bottom: 10px; display: block;"></i>
                    <h4 style="color:#475569; font-size:16px; font-weight:600; margin:0 0 4px 0;">No Student Reviews Yet</h4>
                    <p style="color:#94a3b8; font-size:13.5px; margin:0;">Reviews submitted by students regarding your internships will appear here.</p>
                </div></asp:PlaceHolder>
            </div>
            <!-- SECTION 2: Feedback Sent by Company to Admin -->
            <div style="margin-top: 36px; background: #ffffff; border: 1px solid var(--fb-border); border-radius: var(--fb-radius); overflow: hidden; box-shadow: var(--fb-shadow);">
                <div style="padding: 18px 24px; border-bottom: 1px solid var(--fb-border); font-weight: 700; color: #0f172a; font-size: 16px; display: flex; align-items: center; justify-content: space-between; background: #ffffff;">
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <i class="fa-solid fa-clock-rotate-left" style="color:#2563eb;"></i>
                        <span>Your Submitted Feedback History</span>
                    </div>
                </div>
                <div style="overflow-x: auto;">
                    <asp:GridView ID="gvSentFeedbacks" runat="server" AutoGenerateColumns="False" OnRowCommand="gvSentFeedbacks_RowCommand" CssClass="fb-custom-table" GridLines="None" ShowHeaderWhenEmpty="true">
                        <Columns>
                            <asp:TemplateField HeaderText="CATEGORY &amp; SUBJECT">
                                <ItemTemplate>
                                    <div style="font-weight: 600; color: #0f172a; font-size: 14px; margin-bottom: 2px;"><%# Eval("Subject") %></div>
                                    <div style="font-size: 12px; color: #2563eb; font-weight: 500;"><%# Eval("FeedbackCategory") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RATING">
                                <HeaderStyle Width="150px" />
                                <ItemStyle Width="150px" Wrap="False" />
                                <ItemTemplate>
                                    <div style="display: inline-flex; align-items: center; gap: 8px; white-space: nowrap;">
                                        <%# GetStars(Eval("Rating")) %>
                                        <span style="font-size: 12.5px; font-weight: 700; color: #334155; white-space: nowrap;"><%# Eval("Rating") %> / 5</span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SUBMITTED DATE">
                                <ItemTemplate>
                                    <span style="color: #475569; font-size: 13px; white-space: nowrap;"><i class="fa-regular fa-calendar" style="color: #94a3b8; margin-right: 4px;"></i><%# FormatDate(Eval("CreatedDate")) %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SUBMITTED TIME">
                                <ItemTemplate>
                                    <span style="color: #64748b; font-size: 13px; white-space: nowrap;"><i class="fa-regular fa-clock" style="color: #94a3b8; margin-right: 4px;"></i><%# FormatTime(Eval("CreatedDate")) %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ACTIONS">
                                <ItemTemplate>
                                    <div style="display: flex; gap: 8px; align-items: center;">
                                        <button type="button" class="btn-action-view"
                                                onclick="openCompanyFeedbackDrawer('Platform Administrator', '<%# CleanJsString(Eval("FeedbackCategory")) %>', '<%# Eval("Rating") %>', '<%# CleanJsString(Eval("Subject")) %>', '<%# CleanJsString(Eval("Message")) %>', '<%# FormatDate(Eval("CreatedDate")) %>', '<%# FormatTime(Eval("CreatedDate")) %>');">
                                            <i class="fa-solid fa-eye"></i> View
                                        </button>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="cmd_delete" CommandArgument='<%# Eval("FeedbackId") %>' CssClass="btn-action-delete">
                                            <i class="fa-solid fa-trash-can"></i> Delete
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <asp:PlaceHolder ID="pnlNoFeedback" runat="server" Visible="false"><div style="text-align:center; padding:40px 20px;">
                    <i class="fa-solid fa-star-half-stroke" style="font-size: 36px; color: #cbd5e1; margin-bottom: 10px; display: block;"></i>
                    <h4 style="color:#475569; font-size:16px; font-weight:600; margin:0 0 4px 0;">No Feedback Sent Yet</h4>
                    <p style="color:#94a3b8; font-size:13.5px; margin:0;">You have not sent any feedback to the admin team yet.</p>
                </div></asp:PlaceHolder>
            </div>
        </div>
    </div>
    <!-- ================= CENTER MODAL DRAWER ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>
    <div class="feedback-drawer" id="feedbackDrawer">
        <div class="drawer-header">
            <h3 id="drHeaderTitle">Review &amp; Feedback Details</h3>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();" title="Close Details">&times;</button>
        </div>
        <div class="drawer-body">
            <!-- Details Grid -->
            <div class="cm-detail-grid">
                <div class="cm-detail-item">
                    <span class="cm-detail-label" id="drSenderLabel">STUDENT</span>
                    <span class="cm-detail-value" id="drSenderName">-</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label" id="drTargetLabel">INTERNSHIP</span>
                    <span class="cm-detail-value" id="drTargetVal" style="color: #2563EB;">-</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">CATEGORY</span>
                    <span class="cm-detail-value" id="drCategory">-</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">RATING</span>
                    <span class="cm-detail-value" style="display: flex; align-items: center; gap: 6px;">
                        <span id="drStars" style="color: #f59e0b;"></span>
                        <span id="drRatingScore" style="font-weight: 700;">5 / 5</span>
                    </span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SUBMITTED DATE</span>
                    <span class="cm-detail-value" id="drSubmittedDate">-</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SUBMITTED TIME</span>
                    <span class="cm-detail-value" id="drSubmittedTime">-</span>
                </div>
            </div>
            <!-- Subject Section -->
            <div class="cm-subject-section">
                <span class="cm-detail-label">SUBJECT</span>
                <span class="cm-subject-value" id="drSubject">-</span>
            </div>
            <!-- Message Section -->
            <div class="cm-message-section">
                <span class="cm-detail-label" style="margin-bottom: 8px;">MESSAGE / REVIEW COMMENTS</span>
                <div class="cm-message-box">
                    <span class="cm-message-text" id="drMessage">-</span>
                </div>
            </div>
        </div>
    </div>
    <script>
        const ratingLabels = {
            '5': '5 - Excellent',
            '4': '4 - Very Good',
            '3': '3 - Good',
            '2': '2 - Fair',
            '1': '1 - Needs Improvement'
        };
        function setStars(rating) {
            const stars = document.querySelectorAll('#starsContainer i');
            stars.forEach(star => {
                const val = parseInt(star.getAttribute('data-val'));
                if (val <= rating) {
                    star.classList.add('active');
                } else {
                    star.classList.remove('active');
                }
            });
            const textEl = document.getElementById('ratingTextLabel');
            if (textEl && ratingLabels[rating]) {
                textEl.innerText = ratingLabels[rating];
            }
        }
        function syncRatingFromDropdown(val) {
            setStars(parseInt(val));
        }
        document.addEventListener('DOMContentLoaded', function () {
            const stars = document.querySelectorAll('#starsContainer i');
            const ddl = document.getElementById('<%= ddlRating.ClientID %>');
            stars.forEach(star => {
                star.addEventListener('click', function () {
                    const val = this.getAttribute('data-val');
                    setStars(parseInt(val));
                    if (ddl) {
                        ddl.value = val;
                    }
                });
            });
            if (ddl) {
                setStars(parseInt(ddl.value) || 5);
            }
        });
        function openReviewDrawer(studentName, studentEmail, internship, category, rating, subject, message, date, time) {
            document.getElementById('drHeaderTitle').innerText = 'Student Review Details';
            document.getElementById('drSenderLabel').innerText = 'STUDENT';
            document.getElementById('drSenderName').innerText = studentName + (studentEmail ? ' (' + studentEmail + ')' : '');
            document.getElementById('drTargetLabel').innerText = 'INTERNSHIP';
            document.getElementById('drTargetVal').innerText = internship || 'Internship Review';
            document.getElementById('drCategory').innerText = category || 'General';
            populateCommonDrawer(rating, subject, message, date, time);
        }
        function openCompanyFeedbackDrawer(recipient, category, rating, subject, message, date, time) {
            document.getElementById('drHeaderTitle').innerText = 'Feedback Sent to Admin';
            document.getElementById('drSenderLabel').innerText = 'SENT TO';
            document.getElementById('drSenderName').innerText = recipient || 'Platform Administrator';
            document.getElementById('drTargetLabel').innerText = 'FEEDBACK TYPE';
            document.getElementById('drTargetVal').innerText = 'Platform Suggestion';
            document.getElementById('drCategory').innerText = category || 'General';
            populateCommonDrawer(rating, subject, message, date, time);
        }
        function populateCommonDrawer(rating, subject, message, date, time) {
            // Rating Stars
            const r = parseInt(rating) || 5;
            let starHtml = '';
            for (let i = 1; i <= 5; i++) {
                if (i <= r) {
                    starHtml += '<i class="fa-solid fa-star" style="color: #f59e0b; margin-right: 2px;"></i>';
                } else {
                    starHtml += '<i class="fa-regular fa-star" style="color: #cbd5e1; margin-right: 2px;"></i>';
                }
            }
            document.getElementById('drStars').innerHTML = starHtml;
            document.getElementById('drRatingScore').innerText = r + ' / 5';
            document.getElementById('drSubmittedDate').innerText = date || '-';
            document.getElementById('drSubmittedTime').innerText = time || '-';
            document.getElementById('drSubject').innerText = subject || '-';
            document.getElementById('drMessage').innerText = message || '-';
            // Show Drawer Modal
            document.getElementById('drawerOverlay').classList.add('is-active');
            document.getElementById('feedbackDrawer').classList.add('is-open');
        }
        function closeDrawer() {
            document.getElementById('drawerOverlay').classList.remove('is-active');
            document.getElementById('feedbackDrawer').classList.remove('is-open');
        }
        // Close on Escape key
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                closeDrawer();
            }
        });
    </script>
</asp:Content>

<%@ Page Title="Feedback & Ratings" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-feedback.aspx.cs" Inherits="asp.net.company_feedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-feedback.css" />
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
                <asp:Label ID="lblMsg" runat="server" Visible="false" Style="display: block; margin-bottom: 14px; font-weight: 600;"></asp:Label>
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
                    <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-control-select">
                        <asp:ListItem Text="5 - Excellent" Value="5" Selected="True" />
                        <asp:ListItem Text="4 - Very Good" Value="4" />
                        <asp:ListItem Text="3 - Good" Value="3" />
                        <asp:ListItem Text="2 - Fair" Value="2" />
                        <asp:ListItem Text="1 - Needs Improvement" Value="1" />
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label class="form-label">Subject / Title <span style="color: #ef4444;">*</span></label>
                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control-input" placeholder="e.g. Great hiring experience on the portal"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label class="form-label">Your Detailed Review / Comments <span style="color: #ef4444;">*</span></label>
                    <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control-textarea" placeholder="Share your detailed feedback, highlights, or suggestions for the admin team..."></asp:TextBox>
                </div>

                <asp:Button ID="btnSubmitFeedback" runat="server" Text="Submit Feedback" CssClass="btn-submit-feedback" OnClick="btnSubmitFeedback_Click" />
            </div>

            <!-- SECTION 1: Student Reviews on Company Internships -->
            <div style="margin-top: 36px; background: #ffffff; border: 1px solid var(--fb-border); border-radius: var(--fb-radius); overflow: hidden; box-shadow: var(--fb-shadow);">
                <div style="padding: 18px 24px; border-bottom: 1px solid var(--fb-border); font-weight: 700; color: #0f172a; font-size: 16px; display: flex; align-items: center; justify-content: space-between; background: #ffffff;">
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <i class="fa-solid fa-star" style="color: #f59e0b;"></i>
                        <span>Student Reviews on Your Internships</span>
                        <asp:Label ID="lblStudentReviewCount" runat="server" Style="font-size: 13px; color: #64748b; font-weight: 500; margin-left: 4px;"></asp:Label>
                    </div>
                </div>

                <div style="overflow-x: auto;">
                    <asp:GridView ID="gvStudentReviews" runat="server" AutoGenerateColumns="False" OnRowCommand="gvStudentReviews_RowCommand" CssClass="fb-custom-table" GridLines="None" ShowHeaderWhenEmpty="true">
                        <Columns>
                            <asp:TemplateField HeaderText="STUDENT">
                                <ItemTemplate>
                                    <div style="font-weight: 600; color: #0f172a; font-size: 14px;">
                                        <asp:Label ID="lblSenderName" runat="server" Text='<%# Eval("SenderName") %>'></asp:Label>
                                    </div>
                                    <div style="font-size: 12px; color: #64748b;">
                                        <asp:Label ID="lblSenderEmail" runat="server" Text='<%# Eval("SenderEmail") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="INTERNSHIP">
                                <ItemTemplate>
                                    <asp:Label ID="lblInternshipTitle" runat="server" Style="font-size: 13px; color: #2563eb; font-weight: 600;" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="CATEGORY">
                                <ItemTemplate>
                                    <asp:Label ID="lblCategory" runat="server" Style="font-size: 12.5px; color: #475569; background: #f1f5f9; padding: 4px 10px; border-radius: 6px; font-weight: 600; display: inline-block;" Text='<%# Eval("FeedbackCategory") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="RATING">
                                <ItemTemplate>
                                    <asp:Label ID="lblRating" runat="server" Text='<%# Eval("Rating") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="SUBMITTED DATE">
                                <ItemTemplate>
                                    <i class="fa-regular fa-calendar" style="color: #94a3b8; margin-right: 4px;"></i>
                                    <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Eval("CreatedDate", "{0:dd MMM yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="SUBMITTED TIME">
                                <ItemTemplate>
                                    <i class="fa-regular fa-clock" style="color: #94a3b8; margin-right: 4px;"></i>
                                    <asp:Label ID="lblCreatedTime" runat="server" Text='<%# Eval("CreatedDate", "{0:hh:mm tt}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="ACTIONS">
                                <HeaderStyle Width="100px" />
                                <ItemStyle Width="100px" Wrap="False" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnViewStudentReview" runat="server" CommandName="ViewReview" CommandArgument='<%# Eval("FeedbackId") %>' CssClass="btn-action-view">
                                        <i class="fa-solid fa-eye"></i> View
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <asp:PlaceHolder ID="pnlNoStudentReviews" runat="server" Visible="false">
                    <div style="text-align: center; padding: 40px 20px;">
                        <i class="fa-solid fa-star-half-stroke" style="font-size: 36px; color: #cbd5e1; margin-bottom: 10px; display: block;"></i>
                        <h4 style="color: #475569; font-size: 16px; font-weight: 600; margin: 0 0 4px 0;">No Student Reviews Yet</h4>
                        <p style="color: #94a3b8; font-size: 13.5px; margin: 0;">Reviews submitted by students regarding your internships will appear here.</p>
                    </div>
                </asp:PlaceHolder>
            </div>

            <!-- SECTION 2: Feedback Sent by Company to Admin -->
            <div style="margin-top: 36px; background: #ffffff; border: 1px solid var(--fb-border); border-radius: var(--fb-radius); overflow: hidden; box-shadow: var(--fb-shadow);">
                <div style="padding: 18px 24px; border-bottom: 1px solid var(--fb-border); font-weight: 700; color: #0f172a; font-size: 16px; display: flex; align-items: center; justify-content: space-between; background: #ffffff;">
                    <div style="display: flex; align-items: center; gap: 8px;">
                        <i class="fa-solid fa-clock-rotate-left" style="color: #2563eb;"></i>
                        <span>Your Submitted Feedback History</span>
                    </div>
                </div>

                <div style="overflow-x: auto;">
                    <asp:GridView ID="gvSentFeedbacks" runat="server" AutoGenerateColumns="False" OnRowCommand="gvSentFeedbacks_RowCommand" CssClass="fb-custom-table" GridLines="None" ShowHeaderWhenEmpty="true">
                        <Columns>
                            <asp:TemplateField HeaderText="CATEGORY &amp; SUBJECT">
                                <ItemTemplate>
                                    <div style="font-weight: 600; color: #0f172a; font-size: 14px; margin-bottom: 2px;">
                                        <asp:Label ID="lblSentSubject" runat="server" Text='<%# Eval("Subject") %>'></asp:Label>
                                    </div>
                                    <div style="font-size: 12px; color: #2563eb; font-weight: 500;">
                                        <asp:Label ID="lblSentCategory" runat="server" Text='<%# Eval("FeedbackCategory") %>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="RATING">
                                <ItemTemplate>
                                    <asp:Label ID="lblSentRating" runat="server" Text='<%# Eval("Rating") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="SUBMITTED DATE">
                                <ItemTemplate>
                                    <i class="fa-regular fa-calendar" style="color: #94a3b8; margin-right: 4px;"></i>
                                    <asp:Label ID="lblSentDate" runat="server" Text='<%# Eval("CreatedDate", "{0:dd MMM yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="SUBMITTED TIME">
                                <ItemTemplate>
                                    <i class="fa-regular fa-clock" style="color: #94a3b8; margin-right: 4px;"></i>
                                    <asp:Label ID="lblSentTime" runat="server" Text='<%# Eval("CreatedDate", "{0:hh:mm tt}") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="ACTIONS">
                                <HeaderStyle Width="180px" />
                                <ItemStyle Width="180px" Wrap="False" />
                                <ItemTemplate>
                                    <div style="display: inline-flex; align-items: center; gap: 8px; white-space: nowrap;">
                                        <asp:LinkButton ID="btnViewSent" runat="server" CommandName="ViewSentFeedback" CommandArgument='<%# Eval("FeedbackId") %>' CssClass="btn-action-view">
                                            <i class="fa-solid fa-eye"></i> View
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="cmd_delete" CommandArgument='<%# Eval("FeedbackId") %>' CssClass="btn-action-delete" OnClientClick="return confirm('Are you sure you want to delete this feedback?');">
                                            <i class="fa-solid fa-trash-can"></i> Delete
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>

                <asp:PlaceHolder ID="pnlNoFeedback" runat="server" Visible="false">
                    <div style="text-align: center; padding: 40px 20px;">
                        <i class="fa-solid fa-star-half-stroke" style="font-size: 36px; color: #cbd5e1; margin-bottom: 10px; display: block;"></i>
                        <h4 style="color: #475569; font-size: 16px; font-weight: 600; margin: 0 0 4px 0;">No Feedback Sent Yet</h4>
                        <p style="color: #94a3b8; font-size: 13.5px; margin: 0;">You have not sent any feedback to the admin team yet.</p>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
    </div>

    <!-- ================= CENTER MODAL DRAWER ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>
    <div class="feedback-drawer" id="feedbackDrawer">
        <div class="drawer-header">
            <h3><asp:Label ID="drHeaderTitle" runat="server"></asp:Label></h3>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();">&times;</button>
        </div>
        <div class="drawer-body">
            <!-- Details Grid -->
            <div class="cm-detail-grid">
                <div class="cm-detail-item">
                    <span class="cm-detail-label"><asp:Label ID="drSenderLabel" runat="server"></asp:Label></span>
                    <span class="cm-detail-value"><asp:Label ID="drSenderName" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label"><asp:Label ID="drTargetLabel" runat="server"></asp:Label></span>
                    <span class="cm-detail-value" style="color: #2563EB;"><asp:Label ID="drTargetVal" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">CATEGORY</span>
                    <span class="cm-detail-value"><asp:Label ID="drCategory" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">RATING</span>
                    <span class="cm-detail-value">
                        <asp:Label ID="drRatingScore" runat="server"></asp:Label>
                    </span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SUBMITTED DATE</span>
                    <span class="cm-detail-value"><asp:Label ID="drSubmittedDate" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SUBMITTED TIME</span>
                    <span class="cm-detail-value"><asp:Label ID="drSubmittedTime" runat="server"></asp:Label></span>
                </div>
            </div>
            <!-- Subject Section -->
            <div class="cm-subject-section">
                <span class="cm-detail-label">SUBJECT</span>
                <span class="cm-subject-value"><asp:Label ID="drSubject" runat="server"></asp:Label></span>
            </div>
            <!-- Message Section -->
            <div class="cm-message-section">
                <span class="cm-detail-label" style="margin-bottom: 8px;">MESSAGE / REVIEW COMMENTS</span>
                <div class="cm-message-box">
                    <span class="cm-message-text"><asp:Label ID="drMessage" runat="server"></asp:Label></span>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/company-feedback.js"></script>
</asp:Content>

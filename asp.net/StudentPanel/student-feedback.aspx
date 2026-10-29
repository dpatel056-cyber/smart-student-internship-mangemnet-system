<%@ Page Title="Feedback & Ratings" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-feedback.aspx.cs" Inherits="asp.net.student_feedback" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-feedback.css" />
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="feedback-page-wrapper">
        <div class="feedback-container">
            <div class="page-header-box">
                <div class="page-title">
                    <h1><i class="fa-solid fa-star"></i> Feedback &amp; Ratings</h1>
                    <p>Share your review for your completed internship &amp; company, or provide general suggestions for the SIMS portal.</p>
                </div>
            </div>
            <div class="feedback-card">
                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                <!-- Feedback Type (Target) -->
                <div class="form-group">
                    <label class="form-label">Feedback Type / Target</label>
                    <asp:DropDownList ID="ddlFeedbackType" runat="server" CssClass="form-control-select" AutoPostBack="true" OnSelectedIndexChanged="ddlFeedbackType_SelectedIndexChanged">
                        <asp:ListItem Text="Review Specific Company &amp; Internship" Value="Company" Selected="True" />
                        <asp:ListItem Text="General Platform Feedback (for Admin)" Value="General" />
                    </asp:DropDownList>
                </div>
                <!-- Company & Internship Selector (Visible if Company selected) -->
                <asp:PlaceHolder ID="pnlCompanySelect" runat="server">
                    <div class="form-group">
                        <label class="form-label">Select Company &amp; Internship <span  class="sfb-u1">*</span></label>
                        <asp:DropDownList ID="ddlCompanyInternship" runat="server" CssClass="form-control-select">
                        </asp:DropDownList>
                        <span  class="sfb-u2">This feedback will be shared with the company and the administrator.</span>
                    </div>
                </asp:PlaceHolder>
                <div class="form-group">
                    <label class="form-label">Feedback Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control-select">
                        <asp:ListItem Text="Internship Work &amp; Learning Experience" Value="Internship Experience" />
                        <asp:ListItem Text="Mentorship, Guidance &amp; Support" Value="Mentorship & Guidance" />
                        <asp:ListItem Text="Workplace Culture &amp; Environment" Value="Work Culture" />
                        <asp:ListItem Text="Task Clarity &amp; Project Quality" Value="Project Quality" />
                        <asp:ListItem Text="Portal Usability &amp; Application Process" Value="Portal Usability" />
                        <asp:ListItem Text="General Feedback &amp; Suggestions" Value="General Suggestions" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="form-label">Overall Rating</label>
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
                    <asp:DropDownList ID="ddlRating" ClientIDMode="Static" runat="server" CssClass="form-control-select" onchange="syncRatingFromDropdown(this.value);">
                        <asp:ListItem Text="5 - Excellent" Value="5" Selected="True" />
                        <asp:ListItem Text="4 - Very Good" Value="4" />
                        <asp:ListItem Text="3 - Good" Value="3" />
                        <asp:ListItem Text="2 - Fair" Value="2" />
                        <asp:ListItem Text="1 - Needs Improvement" Value="1" />
                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label class="form-label">Subject / Title <span  class="sfb-u1">*</span></label>
                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control-input" placeholder="e.g. Great learning experience during my internship"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="form-label">Your Detailed Review / Comments <span  class="sfb-u1">*</span></label>
                    <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control-textarea" placeholder="Share your detailed feedback, highlights, or suggestions..."></asp:TextBox>
                </div>
                <asp:ImageButton ID="btnSubmitFeedback" runat="server" ImageUrl="~/assets/btn_submit_feedback.png" Height="44" CssClass="student-img-btn" OnClick="btnSubmitFeedback_Click" />
            </div>
            <!-- Previous Feedbacks Grid (Exact Admin Panel Style) -->
            <div  class="sfb-u3">
                <div  class="sfb-u4">
                    <div  class="sfb-u5">
                        <i class="fa-solid fa-clock-rotate-left sfb-u6" ></i>
                        <span>Your Feedback History</span>
                    </div>
                </div>
                <div  class="sfb-u7">
                    <asp:GridView ID="gvFeedback" runat="server" AutoGenerateColumns="False" OnRowCommand="gvFeedback_RowCommand" CssClass="fb-custom-table" GridLines="None" ShowHeaderWhenEmpty="true">
                        <Columns>
                            <asp:TemplateField HeaderText="RECIPIENT &amp; INTERNSHIP">
                                <ItemTemplate>
                                    <div  class="sfb-u8">
                                        <%# Eval("FeedbackType").ToString() == "Company" && Eval("c_company") != DBNull.Value ? Eval("c_company") : "SIMS Portal (Admin)" %>
                                    </div>
                                    <div  class="sfb-u9">
                                        <%# Eval("FeedbackType").ToString() == "Company" && Eval("InternshipTitle") != DBNull.Value ? Eval("InternshipTitle") : "General Platform Feedback" %>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="CATEGORY &amp; SUBJECT">
                                <ItemTemplate>
                                    <div  class="sfb-u8"><%# Eval("Subject") %></div>
                                    <div  class="sfb-u9"><%# Eval("FeedbackCategory") %></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RATING">
                                <HeaderStyle Width="150px" />
                                <ItemStyle Width="150px" Wrap="False" />
                                <ItemTemplate>
                                    <div  class="sfb-u10">
                                        <%# GetStars(Eval("Rating")) %>
                                        <span  class="sfb-u11"><%# Eval("Rating") %> / 5</span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SUBMITTED DATE">
                                <ItemTemplate>
                                    <span  class="sfb-u12"><i class="fa-regular fa-calendar sfb-u13" ></i><%# FormatDate(Eval("CreatedDate")) %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SUBMITTED TIME">
                                <ItemTemplate>
                                    <span  class="sfb-u14"><i class="fa-regular fa-clock sfb-u13" ></i><%# FormatTime(Eval("CreatedDate")) %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ACTIONS">
                                <ItemTemplate>
                                    <div  class="sfb-u5">
                                        <button type="button" class="btn-action-view"
                                                onclick="openDrawer('<%# Eval("FeedbackId") %>', '<%# CleanJsString(Eval("FeedbackType")) %>', '<%# CleanJsString(Eval("c_company")) %>', '<%# CleanJsString(Eval("InternshipTitle")) %>', '<%# CleanJsString(Eval("FeedbackCategory")) %>', '<%# Eval("Rating") %>', '<%# CleanJsString(Eval("Subject")) %>', '<%# CleanJsString(Eval("Message")) %>', '<%# FormatDate(Eval("CreatedDate")) %>', '<%# FormatTime(Eval("CreatedDate")) %>');">
                                            <i class="fa-solid fa-eye"></i> View
                                        </button>
                                        <asp:LinkButton ID="lnkDelete" runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("FeedbackId") %>' CssClass="btn-action-delete">
                                            <i class="fa-solid fa-trash-can"></i> Delete
                                        </asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <asp:PlaceHolder ID="pnlNoFeedback" runat="server" Visible="false">
                    <div  class="sfb-u15">
                        <i class="fa-solid fa-star-half-stroke sfb-u16" ></i>
                        <h4  class="sfb-u17">No Feedback Found</h4>
                        <p  class="sfb-u18">You have not submitted any feedback yet.</p>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
    </div>
    <!-- ================= CENTER MODAL DRAWER ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>
    <div class="feedback-drawer" id="feedbackDrawer">
        <div class="drawer-header">
            <h3>Feedback Details</h3>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();" >&times;</button>
        </div>
        <div class="drawer-body">
            <!-- Details Grid -->
            <div class="cm-detail-grid">
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SUBMITTED TO</span>
                    <span class="cm-detail-value sfb-u19" id="drTarget" >-</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">CATEGORY</span>
                    <span class="cm-detail-value" id="drCategory">-</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SUBMITTED DATE</span>
                    <span class="cm-detail-value" id="drSubmittedDate">-</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SUBMITTED TIME</span>
                    <span class="cm-detail-value" id="drSubmittedTime">-</span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">RATING</span>
                    <span class="cm-detail-value sfb-u20" >
                        <span id="drStars"  class="sfb-u21"></span>
                        <span id="drRatingScore"  class="sfb-u22">5 / 5</span>
                    </span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">STATUS</span>
                    <span class="cm-detail-value sfb-u23" ><i class="fa-solid fa-circle-check"></i> Submitted</span>
                </div>
            </div>
            <!-- Subject Section -->
            <div class="cm-subject-section">
                <span class="cm-detail-label">SUBJECT</span>
                <span class="cm-subject-value" id="drSubject">-</span>
            </div>
            <!-- Message Section -->
            <div class="cm-message-section">
                <span class="cm-detail-label sfb-u24" >YOUR MESSAGE / COMMENTS</span>
                <div class="cm-message-box">
                    <span class="cm-message-text" id="drMessage">-</span>
                </div>
            </div>
        </div>
    </div>
    </asp:Content>
<asp:Content ID="ScriptContent_sfb" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="../js/student-feedback.js"></script>
</asp:Content>

<%@ Page Title="Schedule Interview" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-interviews.aspx.cs" Inherits="asp.net.company_interviews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <link rel="stylesheet" href="../css/company-interviews.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header -->
    <div class="page-header-box">
        <div>
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Schedule Interviews</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Schedule, conduct, and manage candidate interview rounds.</p>
        </div>
        <button type="button" class="btn-open-drawer" onclick="openDrawer();">
            <i class="fa-solid fa-calendar-plus"></i> Schedule New Interview
        </button>
    </div>
    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    <!-- Scheduled Interviews DataList (Box / Card Grid) -->
    <div style="margin-bottom: 30px;">
        <asp:DataList ID="dlInterviews" runat="server" RepeatLayout="Flow" CssClass="interview-cards-grid" OnItemCommand="dlInterviews_ItemCommand">
            <ItemTemplate>
                <div class="interview-box-card">
                    <!-- Top Row: Date Box + Status Badge -->
                    <div class="interview-card-top">
                        <div class="interview-date-badge">
                            <span class="day"><asp:Label ID="lblDay" runat="server" Text='<%# Eval("InterviewDate", "{0:dd}") %>'></asp:Label></span>
                            <span class="mon"><asp:Label ID="lblMonth" runat="server" Text='<%# Eval("InterviewDate", "{0:MMM}") %>'></asp:Label></span>
                        </div>
                        <div>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# GetStatusBadge(Eval("Status")) %>'></asp:Label>
                        </div>
                    </div>
                    <!-- Candidate & Role Info -->
                    <div class="interview-card-candidate">
                        <asp:Image ID="imgStudentLogo" runat="server" CssClass="interview-candidate-avatar" ImageUrl='<%# Eval("ProfilePhoto") %>' onerror="this.onerror=null;this.src='../student_images/default-avatar.png';" />
                        <div style="min-width: 0; flex: 1;">
                            <h3 class="interview-candidate-name"><asp:Label ID="lblFullName" runat="server" Text='<%# Eval("FullName") %>'></asp:Label></h3>
                            <p class="interview-candidate-email"><asp:Label ID="lblStudentEmail" runat="server" Text='<%# Eval("StudentEmail") %>'></asp:Label></p>
                        </div>
                    </div>
                    <div class="interview-role-badge">
                        <i class="fa-solid fa-briefcase" style="color: #2563eb; font-size: 11px;"></i>
                        <span><asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label></span>
                    </div>
                    <!-- Interview Details List -->
                    <div class="interview-card-details">
                        <div class="detail-row">
                            <span class="detail-label"><i class="fa-regular fa-clock" style="color: #f59e0b;"></i> Time:</span>
                            <span class="detail-val"><asp:Label ID="lblInterviewTime" runat="server" Text='<%# Eval("InterviewTime") %>'></asp:Label></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label"><i class="fa-solid fa-video" style="color: #7c3aed;"></i> Mode:</span>
                            <span class="detail-val"><asp:Label ID="lblInterviewType" runat="server" Text='<%# Eval("InterviewType") %>'></asp:Label></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label"><i class="fa-solid fa-link" style="color: #059669;"></i> Location/Link:</span>
                            <span class="detail-val">
                                <asp:HyperLink ID="hlMeetingLink" runat="server" NavigateUrl='<%# Eval("MeetingLink") %>' Target="_blank" style="color:#2563eb; font-weight:600; text-decoration:none;">
                                    <i class="fa-solid fa-arrow-up-right-from-square"></i> Join Meeting
                                </asp:HyperLink>
                            </span>
                        </div>
                        <%# !string.IsNullOrEmpty(Eval("Notes")?.ToString()) ? "<div class='detail-notes'><i class='fa-regular fa-note-sticky'></i> " + Eval("Notes") + "</div>" : "" %>
                    </div>
                    <!-- Card Actions (Always Visible) -->
                    <div class="interview-card-actions">
                        <asp:LinkButton ID="btnComplete" runat="server" CommandName="MarkComplete" CommandArgument='<%# Eval("InterviewId") %>'
                                        CssClass="btn-box-action btn-box-complete"
>
                            <i class="fa-solid fa-check"></i> Completed
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelInterview" CommandArgument='<%# Eval("InterviewId") %>'
                                        CssClass="btn-box-action btn-box-cancel"
>
                            <i class="fa-solid fa-xmark"></i> Cancel
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:PlaceHolder ID="pnlNoInterviews" runat="server" Visible="false"><div style="text-align:center; padding:60px 20px; background:#fff; border:1px solid #e2e8f0; border-radius:16px;">
            <i class="fa-solid fa-calendar-xmark" style="font-size:46px; color:#cbd5e1; margin-bottom:14px; display:block;"></i>
            <h3 style="font-size:17px; color:#0f172a; margin-bottom:6px;">No Interviews Scheduled</h3>
            <p style="font-size:14px; color:#64748b; margin:0 0 16px 0;">Click "Schedule New Interview" to schedule an interview with a shortlisted candidate.</p>
            <button type="button" class="btn-open-drawer" onclick="openDrawer();">
                <i class="fa-solid fa-calendar-plus"></i> Schedule New Interview
            </button>
        </div></asp:PlaceHolder>
    </div>
    <!-- ================= CENTER MODAL DIALOG FOR INTERVIEW FORM ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>
    <div class="drawer-panel" id="drawerPanel">
        <div class="drawer-header">
            <h2><i class="fa-solid fa-calendar-plus" style="color:#2563eb;"></i> Schedule Interview</h2>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();">&times;</button>
        </div>
        <div class="drawer-body">
            <div class="form-group-item">
                <label><i class="fa-solid fa-user-check" style="color:#2563eb; margin-right:4px;"></i> Select Shortlisted Candidate <span style="color:#ef4444;">*</span></label>
                <asp:DropDownList ID="ddlCandidate" runat="server" CssClass="form-ctrl"></asp:DropDownList>
            </div>
            <div class="form-group-item">
                <label><i class="fa-regular fa-calendar" style="color:#7c3aed; margin-right:4px;"></i> Interview Date <span style="color:#ef4444;">*</span></label>
                <asp:TextBox ID="txtDate" runat="server" TextMode="Date" CssClass="form-ctrl"></asp:TextBox>
            </div>
            <div class="form-group-item">
                <label><i class="fa-regular fa-clock" style="color:#f59e0b; margin-right:4px;"></i> Interview Time <span style="color:#ef4444;">*</span></label>
                <asp:TextBox ID="txtTime" runat="server" placeholder="e.g. 11:00 AM - 12:00 PM" CssClass="form-ctrl"></asp:TextBox>
            </div>
            <div class="form-group-item">
                <label><i class="fa-solid fa-video" style="color:#059669; margin-right:4px;"></i> Interview Mode <span style="color:#ef4444;">*</span></label>
                <asp:DropDownList ID="ddlType" runat="server" CssClass="form-ctrl">
                    <asp:ListItem Text="Online (Google Meet / Zoom)" Value="Online" />
                    <asp:ListItem Text="In-Person (Office)" Value="In-Person" />
                    <asp:ListItem Text="Telephonic" Value="Telephonic" />
                </asp:DropDownList>
            </div>
            <div class="form-group-item">
                <label><i class="fa-solid fa-link" style="color:#2563eb; margin-right:4px;"></i> Meeting Link / Location</label>
                <asp:TextBox ID="txtLinkLocation" runat="server" placeholder="e.g. https://meet.google.com/xyz or Office Address" CssClass="form-ctrl"></asp:TextBox>
            </div>
            <div class="form-group-item">
                <label><i class="fa-regular fa-note-sticky" style="color:#64748b; margin-right:4px;"></i> Notes / Instructions</label>
                <asp:TextBox ID="txtNotes" runat="server" TextMode="MultiLine" Rows="3" placeholder="e.g. Bring updated resume and portfolio" CssClass="form-ctrl"></asp:TextBox>
            </div>
        </div>
        <div class="drawer-footer">
            <button type="button" class="btn-drawer-cancel" onclick="closeDrawer();">Cancel</button>
            <asp:Button ID="btnSchedule" runat="server" Text="Schedule Interview" CssClass="btn-drawer-submit" OnClick="btnSchedule_Click" />
        </div>
    </div>
    <script src="../js/company-interviews.js"></script>
</asp:Content>

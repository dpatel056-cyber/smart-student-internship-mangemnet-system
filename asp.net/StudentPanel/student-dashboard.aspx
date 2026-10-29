<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-dashboard.aspx.cs" Inherits="asp.net.student_dashboard" %>
<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-dashboard.css" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>
<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header (Identical to Company Dashboard with student actions) -->
    <div  class="sdash-u1">
        <div>
            <h1  class="sdash-u2">Dashboard</h1>
            <p  class="sdash-u3">Welcome back, <asp:Label ID="litWelcomeName" runat="server" Text="Student" />! Here's your internship & career progress overview.</p>
        </div>
        <div  class="sdash-u4">
            <a href="<%= ResolveUrl("~/StudentPanel/student-internships.aspx") %>"  class="sdash-nav-btn-1">
                <i class="fa-solid fa-magnifying-glass"></i> Browse Internships
            </a>
            <a href="<%= ResolveUrl("~/StudentPanel/student-profile.aspx") %>"  class="sdash-nav-btn-2">
                <i class="fa-solid fa-user"></i> View Profile
            </a>
        </div>
    </div>
    <!-- 8 Top KPI Stat Cards Grid (Exactly same layout & styling as Company Panel `sims-stat-grid-v2`) -->
    <div class="sims-stat-grid-v2 sdash-u5" >
        <!-- Card 1: Total Applied -->
        <a href="student-my-applications.aspx" class="sims-stat-card-v2 sdash-u6" >
            <div class="sims-stat-icon-v2 sims-bg-blue">
                <i class="fa-solid fa-paper-plane"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblTotalApplied" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Total Applications</span>
            </div>
        </a>
        <!-- Card 2: Under Review / Pending -->
        <a href="student-my-applications.aspx" class="sims-stat-card-v2 sdash-u6" >
            <div class="sims-stat-icon-v2 sims-bg-orange">
                <i class="fa-solid fa-clock"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblPendingCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Under Review</span>
            </div>
        </a>
        <!-- Card 3: Shortlisted -->
        <a href="student-my-applications.aspx" class="sims-stat-card-v2 sdash-u6" >
            <div class="sims-stat-icon-v2 sims-bg-purple">
                <i class="fa-solid fa-star"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblShortlistedCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Shortlisted</span>
            </div>
        </a>
        <!-- Card 4: Selected / Offers -->
        <a href="student-my-applications.aspx" class="sims-stat-card-v2 sdash-u6" >
            <div class="sims-stat-icon-v2 sims-bg-green">
                <i class="fa-solid fa-user-check"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblSelectedCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Selected / Offers</span>
            </div>
        </a>
        <!-- Card 5: Interviews Scheduled -->
        <a href="student-interviews.aspx" class="sims-stat-card-v2 sdash-u6" >
            <div class="sims-stat-icon-v2 sims-bg-yellow">
                <i class="fa-solid fa-calendar-check"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblInterviewsCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Interviews Scheduled</span>
            </div>
        </a>
        <!-- Card 6: Offers Received -->
        <a href="student-offer-letters.aspx" class="sims-stat-card-v2 sdash-u6" >
            <div class="sims-stat-icon-v2 sims-bg-purple-light">
                <i class="fa-solid fa-file-signature"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblOffersCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Offer Letters</span>
            </div>
        </a>
        <!-- Card 7: Assigned Tasks / Quizzes -->
        <a href="student-tasks.aspx" class="sims-stat-card-v2 sdash-u6" >
            <div class="sims-stat-icon-v2 sims-bg-teal">
                <i class="fa-solid fa-list-check"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblTasksCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Tasks & Quizzes</span>
            </div>
        </a>
        <!-- Card 8: Saved / Bookmarked Internships -->
        <a href="student-saved-internships.aspx" class="sims-stat-card-v2 sdash-u6" >
            <div class="sims-stat-icon-v2 sims-bg-pink">
                <i class="fa-solid fa-bookmark"></i>
            </div>
            <div class="sims-stat-info-v2">
                <span class="sims-stat-num-v2"><asp:Label ID="lblSavedCount" runat="server" Text="0"></asp:Label></span>
                <span class="sims-stat-title-v2">Saved Internships</span>
            </div>
        </a>
    </div>
    <!-- Charts Row: 2 Column Panels (Application Status Overview & Interview Status Overview) -->
    <div class="co-grid-2 sdash-u7" >
        <!-- Application Status Donut Chart -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-chart-pie sdash-u8" ></i> Application Status Overview</h3>
            </div>
            <div  class="sdash-u9">
                <canvas id="studentStatusChart"
                        data-selected='<%= totalSelected %>'
                        data-pending='<%= totalPending %>'
                        data-rejected='<%= totalRejected %>'></canvas>
            </div>
        </div>
        <!-- Interview Status Overview Chart (Bar Chart) -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-chart-column sdash-u10" ></i> Interview Status Overview</h3>
            </div>
            <div  class="sdash-u9">
                <canvas id="studentInterviewChart"
                        data-scheduled='<%= intScheduled %>'

                        data-cancelled='<%= intCancelled %>'></canvas>
            </div>
        </div>
    </div>
    <!-- ===================== RECENT APPLICATIONS (FULL WIDTH TABLE) ===================== -->
    <div class="co-panel sdash-u11" >
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-file-lines sdash-u12" ></i> My Recent Applications</h3>
            <a href="<%= ResolveUrl("~/StudentPanel/student-my-applications.aspx") %>"  class="sdash-nav-btn-3">
                View All <i class="fa-solid fa-arrow-right sdash-u13" ></i>
            </a>
        </div>
        <div  class="sdash-u14">
            <asp:GridView ID="gvRecentApps" runat="server" AutoGenerateColumns="False" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="Company" HeaderStyle-Width="25%">
                        <ItemTemplate>
                            <div class="co-applicant-cell">
                                <div class="co-applicant-avatar av1">
                                    <%# GetCompanyLogoHtml(Eval("c_logo"), Eval("c_company")) %>
                                </div>
                                <div>
                                    <div  class="sdash-u15"><%# Server.HtmlEncode(Eval("c_company") != null ? Eval("c_company").ToString() : "Partner Company") %></div>
                                    <div  class="sdash-u16"><%# Server.HtmlEncode(Eval("Location") != null ? Eval("Location").ToString() : "Remote") %></div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Internship Position" HeaderStyle-Width="27%">
                        <ItemTemplate>
                            <div  class="sdash-u17"><%# Server.HtmlEncode(Eval("InternshipTitle") != null ? Eval("InternshipTitle").ToString() : "Internship") %></div>
                            <span  class="sdash-u16"><%# Server.HtmlEncode(Eval("WorkMode") != null ? Eval("WorkMode").ToString() : "Full Time") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Applied Date" HeaderStyle-Width="18%">
                        <ItemTemplate>
                            <span  class="sdash-u18"><i class="fa-regular fa-calendar sdash-u19" ></i><%# FormatDate(Eval("AppliedDate")) %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" HeaderStyle-Width="15%">
                        <ItemTemplate>
                            <%# GetStatusBadge(Eval("Status")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action" HeaderStyle-Width="15%" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                        <ItemTemplate>
                            <a href='<%= ResolveUrl("~/StudentPanel/student-internship-details.aspx") %>?id=<%# Eval("InternshipId") %>'
                                class="sdash-nav-btn-4">
                                <i class="fa-solid fa-eye"></i> View Details
                            </a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoApps" runat="server" Visible="false">
                <div  class="sdash-u20">
                    <i class="fa-solid fa-folder-open sdash-u21" ></i>
                    <p  class="sdash-u22">No internship applications submitted yet.</p>
                    <a href="student-internships.aspx"  class="sdash-u23">
                        <i class="fa-solid fa-magnifying-glass"></i> Explore Internships
                    </a>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
    <!-- ===================== UPCOMING INTERVIEWS (50%) & QUICK ACTIONS (50%) ===================== -->
    <div class="co-grid-2 sdash-u24" >
        <!-- LEFT: UPCOMING INTERVIEWS -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-calendar-days sdash-u25" ></i> Upcoming Interviews</h3>
                <a href="<%= ResolveUrl("~/StudentPanel/student-interviews.aspx") %>"  class="sdash-nav-btn-5">
                    View All <i class="fa-solid fa-arrow-right sdash-u13" ></i>
                </a>
            </div>
            <div  class="sdash-u26">
                <asp:DataList ID="dlInterviews" runat="server" Width="100%" RepeatLayout="Flow">
                    <ItemTemplate>
                        <div class="co-interview-item sdash-u27" >
                            <div class="co-date-box"><span class="day"><asp:Label ID="lblDay" runat="server" Text='<%# FormatDay(Eval("InterviewDate")) %>'></asp:Label></span><span class="mon"><asp:Label ID="lblMon" runat="server" Text='<%# FormatMonth(Eval("InterviewDate")) %>'></asp:Label></span></div>
                            <div class="co-interview-info">
                                <h4><asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label></h4>
                                <p><asp:Label ID="lblTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label> &bull; <i class="fa-regular fa-clock sdash-u28" ></i><asp:Label ID="lblTime" runat="server" Text='<%# Eval("InterviewTime") %>'></asp:Label></p>
                                <div  class="sdash-u29">
                                    <span class="co-mode"><i class="fa-solid fa-video"></i> <asp:Label ID="lblMode" runat="server" Text='<%# Eval("InterviewType") %>'></asp:Label></span>
                                    <asp:Label ID="litMeetingBtn" runat="server" Text='<%# FormatMeetingBtn(Eval("MeetingLink"), Eval("Location"), Eval("InterviewType")) %>'></asp:Label>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:DataList>
                <asp:PlaceHolder ID="pnlNoInterviews" runat="server" Visible="false">
                    <div  class="sdash-u20">
                        <i class="fa-regular fa-calendar-xmark sdash-u30" ></i>
                        <p  class="sdash-u31">No upcoming interviews scheduled.</p>
                    </div>
                </asp:PlaceHolder>
            </div>
        </div>
        <!-- RIGHT: STUDENT QUICK ACTIONS -->
        <div class="co-panel">
            <div class="co-panel-header">
                <h3><i class="fa-solid fa-bolt bolt-icon-gold"></i> Quick Actions</h3>
            </div>
            <div class="dash-quick-actions-list">
                <!-- Action 1: Browse Internships -->
                <a href="<%= ResolveUrl("~/StudentPanel/student-internships.aspx") %>" class="dash-quick-action-item action-blue">
                    <div class="dash-quick-action-left">
                        <div class="dash-quick-action-icon icon-blue">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </div>
                        <div>
                            <div class="dash-quick-action-title">Explore &amp; Apply Internships</div>
                            <div class="dash-quick-action-desc">Search by domain, location &amp; skills</div>
                        </div>
                    </div>
                    <div class="dash-quick-action-arrow">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 2: Track My Applications -->
                <a href="<%= ResolveUrl("~/StudentPanel/student-my-applications.aspx") %>" class="dash-quick-action-item action-purple">
                    <div class="dash-quick-action-left">
                        <div class="dash-quick-action-icon icon-purple">
                            <i class="fa-solid fa-file-lines"></i>
                        </div>
                        <div>
                            <div class="dash-quick-action-title">My Applications</div>
                            <div class="dash-quick-action-desc">Track status, reviews &amp; shortlist</div>
                        </div>
                    </div>
                    <div class="dash-quick-action-arrow">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 3: Tasks & Assessments -->
                <a href="<%= ResolveUrl("~/StudentPanel/student-tasks.aspx") %>" class="dash-quick-action-item action-green">
                    <div class="dash-quick-action-left">
                        <div class="dash-quick-action-icon icon-green">
                            <i class="fa-solid fa-list-check"></i>
                        </div>
                        <div>
                            <div class="dash-quick-action-title">Tasks &amp; Skill Assessments</div>
                            <div class="dash-quick-action-desc">Play quizzes, solve challenges &amp; earn scores</div>
                        </div>
                    </div>
                    <div class="dash-quick-action-arrow">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 4: View Offer Letters -->
                <a href="<%= ResolveUrl("~/StudentPanel/student-offer-letters.aspx") %>" class="dash-quick-action-item action-orange">
                    <div class="dash-quick-action-left">
                        <div class="dash-quick-action-icon icon-orange">
                            <i class="fa-solid fa-file-signature"></i>
                        </div>
                        <div>
                            <div class="dash-quick-action-title">Offer Letters &amp; Responses</div>
                            <div class="dash-quick-action-desc">Accept or review company internship offers</div>
                        </div>
                    </div>
                    <div class="dash-quick-action-arrow">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
                <!-- Action 5: Certificates & Achievements -->
                <a href="<%= ResolveUrl("~/StudentPanel/student-certificates.aspx") %>" class="dash-quick-action-item action-cyan">
                    <div class="dash-quick-action-left">
                        <div class="dash-quick-action-icon icon-cyan">
                            <i class="fa-solid fa-award"></i>
                        </div>
                        <div>
                            <div class="dash-quick-action-title">Internship Certificates</div>
                            <div class="dash-quick-action-desc">Download verified completion credentials</div>
                        </div>
                    </div>
                    <div class="dash-quick-action-arrow">
                        <i class="fa-solid fa-arrow-right"></i>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <!-- Charts JavaScript Engine (Exact match with Company Dashboard) -->
    </asp:Content>
<asp:Content ID="ScriptContent_sdash" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="../js/student-dashboard.js"></script>
</asp:Content>

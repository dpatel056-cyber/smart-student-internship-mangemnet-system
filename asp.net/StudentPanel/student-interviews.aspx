<%@ Page Title="Interview Schedule" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-interviews.aspx.cs" Inherits="asp.net.student_interviews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-interviews.css" />
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div  class="siv-u1">
        <!-- Page Header -->
        <div class="page-header-box">
            <div class="page-title">
                <h1><i class="fa-solid fa-calendar-check siv-u2" ></i> Interview Schedule</h1>
                <p>View your scheduled virtual and in-person interviews with hiring managers.</p>
            </div>
        </div>
        <!-- Stats Grid -->
        <div class="interview-stats-grid">
            <div class="stat-card-task">
                <div class="stat-icon-task siv-u3" >
                    <i class="fa-solid fa-calendar-days"></i>
                </div>
                <div>
                    <div  class="siv-u4"><asp:Label ID="lblTotalInterviews" runat="server">0</asp:Label></div>
                    <div  class="siv-u5">Total Interviews</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task siv-u6" >
                    <i class="fa-solid fa-clock"></i>
                </div>
                <div>
                    <div  class="siv-u4"><asp:Label ID="lblScheduledCount" runat="server">0</asp:Label></div>
                    <div  class="siv-u5">Upcoming / Scheduled</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task siv-u7" >
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div>
                    <div  class="siv-u4"><asp:Label ID="lblCompletedCount" runat="server">0</asp:Label></div>
                    <div  class="siv-u5">Completed Rounds</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task siv-u8" >
                    <i class="fa-solid fa-building"></i>
                </div>
                <div>
                    <div  class="siv-u4"><asp:Label ID="lblCompanyCount" runat="server">0</asp:Label></div>
                    <div  class="siv-u5">Companies</div>
                </div>
            </div>
        </div>
        <!-- 3-Column DataList Card Grid -->
        <asp:DataList ID="dlInterviews" runat="server" RepeatLayout="Flow" CssClass="interview-cards-grid">
            <ItemTemplate>
                <div class="interview-box-card">
                    <div>
                        <!-- Top Row: Date Badge + Status Badge -->
                        <div class="interview-card-top">
                            <div class="interview-date-badge">
                                <span class="day"><asp:Label ID="lblDay" runat="server" Text='<%# FormatDay(Eval("InterviewDate")) %>'></asp:Label></span>
                                <span class="mon"><asp:Label ID="lblMon" runat="server" Text='<%# FormatMonth(Eval("InterviewDate")) %>'></asp:Label></span>
                            </div>
                            <div>
                                <asp:Label ID="litStatus" runat="server" Text='<%# GetStatusBadge(Eval("Status")) %>'></asp:Label>
                            </div>
                        </div>
                        <!-- Company Header & Avatar -->
                        <div class="interview-company-header">
                            <div class="interview-company-avatar">
                                <asp:Label ID="litCompanyLogo" runat="server" Text='<%# FormatCompanyLogo(Eval("c_logo"), Eval("c_company")) %>'></asp:Label>
                            </div>
                            <div  class="siv-u9">
                                <h3 class="interview-company-name"><asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label></h3>
                                <p class="interview-company-loc">
                                    <i class="fa-solid fa-location-dot siv-u10" ></i>
                                    <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("InternshipLocation") != null && !string.IsNullOrEmpty(Eval("InternshipLocation").ToString()) ? Eval("InternshipLocation") : "Headquarters" %>'></asp:Label>
                                </p>
                            </div>
                        </div>
                        <!-- Applied Role Badge -->
                        <div class="interview-role-badge">
                            <i class="fa-solid fa-briefcase siv-u11" ></i>
                            <span><asp:Label ID="lblRole" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label></span>
                        </div>
                        <!-- Interview Details Box -->
                        <div class="interview-card-details">
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-regular fa-clock siv-u12" ></i> Time:</span>
                                <span class="detail-val"><asp:Label ID="lblTime" runat="server" Text='<%# Eval("InterviewTime") %>'></asp:Label></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-solid fa-video siv-u13" ></i> Mode:</span>
                                <span class="detail-val"><asp:Label ID="lblMode" runat="server" Text='<%# Eval("InterviewType") %>'></asp:Label></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-solid fa-laptop-code siv-u14" ></i> Work Mode:</span>
                                <span class="detail-val"><asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") != null && !string.IsNullOrEmpty(Eval("WorkMode").ToString()) ? Eval("WorkMode") : "Full Time" %>'></asp:Label></span>
                            </div>
                            <asp:Label ID="litNotes" runat="server" Text='<%# !string.IsNullOrEmpty(Eval("Notes") as string) ? "<div class=\"detail-notes\"><i class=\"fa-regular fa-note-sticky siv-note-icon\"></i> <strong>Notes:</strong> " + Eval("Notes") + "</div>" : "" %>'></asp:Label>
                        </div>
                    </div>
                    <!-- Bottom Action Button -->
                    <div class="interview-card-actions">
                        <asp:Label ID="litActionBtn" runat="server" Text='<%# FormatMeetingBtn(Eval("MeetingLink"), Eval("Location"), Eval("InterviewType")) %>'></asp:Label>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:PlaceHolder ID="pnlNoInterviews" runat="server" Visible="false">
            <div  class="siv-u15">
                <div  class="siv-u16">
                    <i class="fa-regular fa-calendar-xmark"></i>
                </div>
                <h3  class="siv-u17">No Interviews Scheduled Yet</h3>
                <p  class="siv-u18">Once companies review and shortlist your internship applications, your scheduled interview rounds will appear here.</p>
                <asp:HyperLink ID="hlBrowse" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-join-meeting-full siv-u19" >
                    <i class="fa-solid fa-briefcase"></i> Explore Available Internships
                </asp:HyperLink>
            </div>
        </asp:PlaceHolder>
    </div>
</asp:Content>

<%@ Page Title="Interview Schedule" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-interviews.aspx.cs" Inherits="asp.net.student_interviews" %>
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
        .interview-stats-grid {
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
        /* 3 Columns in 1 Row Grid for Interviews */
        .interview-cards-grid {
            display: grid !important;
            grid-template-columns: repeat(3, 1fr) !important;
            gap: 22px !important;
            width: 100% !important;
        }
        .interview-cards-grid br {
            display: none !important;
        }
        .interview-cards-grid > span,
        .interview-cards-grid > div {
            display: block !important;
            width: 100% !important;
            min-width: 0 !important;
            height: 100% !important;
        }
        @media (max-width: 1100px) {
            .interview-cards-grid {
                grid-template-columns: repeat(2, 1fr) !important;
            }
        }
        @media (max-width: 700px) {
            .interview-cards-grid {
                grid-template-columns: 1fr !important;
            }
        }
        .interview-box-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 4px 14px rgba(15, 23, 42, 0.03);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            box-sizing: border-box;
            position: relative;
        }
        .interview-box-card:hover {
            border-color: #cbd5e1;
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.08);
        }
        .interview-card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
            padding-bottom: 12px;
            border-bottom: 1px solid #f1f5f9;
        }
        .interview-date-badge {
            width: 50px;
            height: 52px;
            background: #eff6ff;
            border: 1.5px solid #bfdbfe;
            border-radius: 12px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .interview-date-badge .day {
            font-size: 18px;
            font-weight: 800;
            color: #2563eb;
            line-height: 1;
        }
        .interview-date-badge .mon {
            font-size: 10px;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            margin-top: 2px;
            letter-spacing: 0.5px;
        }
        .interview-company-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }
        .interview-company-avatar {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: linear-gradient(135deg, #eff6ff, #dbeafe);
            color: #2563eb;
            border: 1px solid #bfdbfe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 15px;
            flex-shrink: 0;
        }
        .interview-company-avatar img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            border-radius: 12px;
        }
        .interview-company-name {
            font-size: 15.5px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 2px 0;
            line-height: 1.3;
        }
        .interview-company-loc {
            font-size: 12px;
            color: #64748b;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        .interview-role-badge {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 8px 12px;
            font-size: 13px;
            font-weight: 700;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 14px;
        }
        .interview-card-details {
            display: flex;
            flex-direction: column;
            gap: 9px;
            flex: 1;
            margin-bottom: 16px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 12px 14px;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12.5px;
        }
        .detail-label {
            color: #64748b;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .detail-val {
            color: #0f172a;
            font-weight: 700;
            text-align: right;
        }
        .detail-notes {
            font-size: 12px;
            color: #475569;
            background: #ffffff;
            padding: 8px 10px;
            border-radius: 8px;
            border: 1px dashed #cbd5e1;
            margin-top: 4px;
            line-height: 1.4;
        }
        .interview-card-actions {
            border-top: 1px solid #f1f5f9;
            padding-top: 14px;
            margin-top: auto;
        }
        .btn-join-meeting-full {
            width: 100%;
            padding: 11px 16px;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #ffffff !important;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            text-align: center;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            box-shadow: 0 4px 12px rgba(37,99,235,0.22);
            transition: all 0.2s ease;
            box-sizing: border-box;
        }
        .btn-join-meeting-full:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(37,99,235,0.32);
            color: #ffffff !important;
        }
        .btn-offline-badge {
            width: 100%;
            padding: 10px 14px;
            background: #f1f5f9;
            color: #334155;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            font-size: 12.5px;
            font-weight: 600;
            text-align: center;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            box-sizing: border-box;
        }
        /* Status Badges */
        .interview-status-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 11px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 700;
            letter-spacing: 0.2px;
            line-height: 1;
            white-space: nowrap;
        }
        .interview-status-badge i {
            font-size: 11px;
        }
        .interview-status-badge.status-completed {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        .interview-status-badge.status-scheduled {
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }
        .interview-status-badge.status-cancelled {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0 40px 0;">
        <!-- Page Header -->
        <div class="page-header-box">
            <div class="page-title">
                <h1><i class="fa-solid fa-calendar-check" style="color: #2563eb;"></i> Interview Schedule</h1>
                <p>View your scheduled virtual and in-person interviews with hiring managers.</p>
            </div>
        </div>
        <!-- Stats Grid -->
        <div class="interview-stats-grid">
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #eff6ff; color: #2563eb;">
                    <i class="fa-solid fa-calendar-days"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblTotalInterviews" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Total Interviews</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #eff6ff; color: #1d4ed8;">
                    <i class="fa-solid fa-clock"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblScheduledCount" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Upcoming / Scheduled</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #f0fdf4; color: #16a34a;">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblCompletedCount" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Completed Rounds</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #fdf4ff; color: #c026d3;">
                    <i class="fa-solid fa-building"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblCompanyCount" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Companies</div>
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
                            <div style="min-width: 0; flex: 1;">
                                <h3 class="interview-company-name"><asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label></h3>
                                <p class="interview-company-loc">
                                    <i class="fa-solid fa-location-dot" style="color:#2563eb;"></i>
                                    <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("InternshipLocation") != null && !string.IsNullOrEmpty(Eval("InternshipLocation").ToString()) ? Eval("InternshipLocation") : "Headquarters" %>'></asp:Label>
                                </p>
                            </div>
                        </div>
                        <!-- Applied Role Badge -->
                        <div class="interview-role-badge">
                            <i class="fa-solid fa-briefcase" style="color: #2563eb; font-size: 12px;"></i>
                            <span><asp:Label ID="lblRole" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label></span>
                        </div>
                        <!-- Interview Details Box -->
                        <div class="interview-card-details">
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-regular fa-clock" style="color: #f59e0b;"></i> Time:</span>
                                <span class="detail-val"><asp:Label ID="lblTime" runat="server" Text='<%# Eval("InterviewTime") %>'></asp:Label></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-solid fa-video" style="color: #7c3aed;"></i> Mode:</span>
                                <span class="detail-val"><asp:Label ID="lblMode" runat="server" Text='<%# Eval("InterviewType") %>'></asp:Label></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-solid fa-laptop-code" style="color: #059669;"></i> Work Mode:</span>
                                <span class="detail-val"><asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") != null && !string.IsNullOrEmpty(Eval("WorkMode").ToString()) ? Eval("WorkMode") : "Full Time" %>'></asp:Label></span>
                            </div>
                            <asp:Label ID="litNotes" runat="server" Text='<%# !string.IsNullOrEmpty(Eval("Notes") as string) ? "<div class=\"detail-notes\"><i class=\"fa-regular fa-note-sticky\" style=\"color:#2563eb;\"></i> <strong>Notes:</strong> " + Eval("Notes") + "</div>" : "" %>'></asp:Label>
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
            <div style="text-align:center; padding: 60px 20px; background:#fff; border-radius:18px; border:1px solid #e2e8f0; box-shadow: 0 4px 12px rgba(15,23,42,0.02);">
                <div style="width:68px; height:68px; background:#eff6ff; color:#2563eb; border-radius:50%; display:inline-flex; align-items:center; justify-content:center; font-size:28px; margin-bottom:16px;">
                    <i class="fa-regular fa-calendar-xmark"></i>
                </div>
                <h3 style="font-size: 18px; font-weight:800; color: #0f172a; margin-bottom: 8px;">No Interviews Scheduled Yet</h3>
                <p style="font-size: 14px; color: #64748b; margin-bottom: 22px; max-width:480px; margin-left:auto; margin-right:auto;">Once companies review and shortlist your internship applications, your scheduled interview rounds will appear here.</p>
                <asp:HyperLink ID="hlBrowse" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-join-meeting-full" Style="width:auto; padding:12px 24px; display:inline-flex;">
                    <i class="fa-solid fa-briefcase"></i> Explore Available Internships
                </asp:HyperLink>
            </div>
        </asp:PlaceHolder>
    </div>
</asp:Content>

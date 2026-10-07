<%@ Page Title="Schedule Interview" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-interviews.aspx.cs" Inherits="asp.net.company_interviews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <style>
        .page-header-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 24px;
        }
        .btn-open-drawer {
            padding: 10px 18px;
            background: #2563eb;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            transition: all 0.15s ease;
            box-shadow: 0 2px 6px rgba(37, 99, 235, 0.2);
        }
        .btn-open-drawer:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
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
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 20px;
            box-shadow: 0 4px 14px rgba(15, 23, 42, 0.03);
            display: flex;
            flex-direction: column;
            transition: all 0.2s ease;
            box-sizing: border-box;
        }
        .interview-box-card:hover {
            border-color: #cbd5e1;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.07);
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
            width: 48px;
            height: 50px;
            background: #eff6ff;
            border: 1.5px solid #bfdbfe;
            border-radius: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .interview-date-badge .day {
            font-size: 17px;
            font-weight: 800;
            color: #2563eb;
            line-height: 1;
        }
        .interview-date-badge .mon {
            font-size: 10px;
            font-weight: 700;
            color: #64748b;
            text-transform: uppercase;
            margin-top: 2px;
        }
        .interview-status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 0.2px;
            line-height: 1;
            white-space: nowrap;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
        }
        .interview-status-badge i {
            font-size: 11.5px;
        }
        .interview-status-badge.status-completed, .status-completed {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        .interview-status-badge.status-completed i, .status-completed i {
            color: #16a34a;
        }
        .interview-status-badge.status-scheduled, .status-scheduled {
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }
        .interview-status-badge.status-scheduled i, .status-scheduled i {
            color: #2563eb;
        }
        .interview-status-badge.status-cancelled, .status-cancelled {
            background: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }
        .interview-status-badge.status-cancelled i, .status-cancelled i {
            color: #dc2626;
        }
        .interview-card-candidate {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }
        .interview-candidate-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2563eb, #3b82f6);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 13.5px;
            flex-shrink: 0;
        }
        .interview-candidate-name {
            font-size: 15px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 2px 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .interview-candidate-email {
            font-size: 12px;
            color: #64748b;
            margin: 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .interview-role-badge {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 7px 10px;
            font-size: 12.5px;
            font-weight: 600;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 7px;
            margin-bottom: 14px;
        }
        .interview-card-details {
            display: flex;
            flex-direction: column;
            gap: 9px;
            flex: 1;
            margin-bottom: 16px;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12.5px;
        }
        .detail-label {
            color: #64748b;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .detail-val {
            color: #0f172a;
            font-weight: 600;
            text-align: right;
        }
        .detail-notes {
            font-size: 12px;
            color: #475569;
            background: #f8fafc;
            padding: 8px 10px;
            border-radius: 6px;
            border: 1px dashed #cbd5e1;
            margin-top: 4px;
            line-height: 1.4;
        }
        .interview-card-actions {
            display: flex;
            gap: 8px;
            border-top: 1px solid #f1f5f9;
            padding-top: 14px;
            margin-top: auto;
        }
        .btn-box-action {
            flex: 1;
            padding: 7px 10px;
            font-size: 12px;
            font-weight: 600;
            border-radius: 8px;
            text-align: center;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            transition: all 0.15s ease;
            cursor: pointer;
            border: 1px solid transparent;
            white-space: nowrap;
        }
        .btn-box-complete {
            background: #f0fdf4;
            color: #16a34a;
            border-color: #bbf7d0;
        }
        .btn-box-complete:hover {
            background: #16a34a;
            color: #ffffff;
        }
        .btn-box-cancel {
            background: #fef2f2;
            color: #dc2626;
            border-color: #fecaca;
        }
        .btn-box-cancel:hover {
            background: #dc2626;
            color: #ffffff;
        }
        /* Center Modal Dialog */
        .drawer-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.45);
            backdrop-filter: blur(3px);
            z-index: 1040;
            display: none;
        }
        .drawer-panel {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) scale(0.95);
            width: 580px;
            max-width: 92vw;
            max-height: 90vh;
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #E2E8F0;
            box-shadow: 0 25px 50px -12px rgba(15, 23, 42, 0.25);
            z-index: 1050;
            display: flex;
            flex-direction: column;
            opacity: 0;
            visibility: hidden;
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.3s cubic-bezier(0.4, 0, 0.2, 1), visibility 0.3s;
        }
        .drawer-panel.open {
            transform: translate(-50%, -50%) scale(1);
            opacity: 1;
            visibility: visible;
        }
        .drawer-header {
            padding: 20px 26px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #f8fafc;
            border-radius: 16px 16px 0 0;
        }
        .drawer-header h2 {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .drawer-close-btn {
            width: 34px;
            height: 34px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #ffffff;
            border: 1px solid #cbd5e1;
            font-size: 20px;
            line-height: 1;
            color: #64748b;
            cursor: pointer;
            border-radius: 8px;
            transition: all 0.15s ease;
        }
        .drawer-close-btn:hover {
            background: #f1f5f9;
            color: #0f172a;
            border-color: #94a3b8;
        }
        .drawer-body {
            padding: 24px 26px;
            overflow-y: auto;
            flex: 1;
        }
        .form-group-item {
            margin-bottom: 18px;
        }
        .form-group-item label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 6px;
        }
        .form-ctrl {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            color: #0f172a;
            outline: none;
            background: #f8fafc;
            box-sizing: border-box;
            transition: all 0.15s ease;
        }
        .form-ctrl:focus {
            border-color: #2563eb;
            background: #ffffff;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.08);
        }
        .drawer-footer {
            padding: 16px 26px;
            border-top: 1px solid #e2e8f0;
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            background: #f8fafc;
            border-radius: 0 0 16px 16px;
        }
        .btn-drawer-cancel {
            padding: 10px 18px;
            background: #ffffff;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            color: #475569;
            cursor: pointer;
            transition: all 0.15s ease;
        }
        .btn-drawer-cancel:hover {
            background: #f1f5f9;
            color: #0f172a;
        }
        .btn-drawer-submit {
            padding: 10px 22px;
            background: #2563eb;
            border: none;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            color: #ffffff;
            cursor: pointer;
            transition: all 0.15s ease;
        }
        .btn-drawer-submit:hover {
            background: #1d4ed8;
        }
    </style>
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
                            <span class="day"><%# FormatDay(Eval("InterviewDate")) %></span>
                            <span class="mon"><%# FormatMonth(Eval("InterviewDate")) %></span>
                        </div>
                        <div>
                            <%# GetStatusBadge(Eval("Status")) %>
                        </div>
                    </div>
                    <!-- Candidate & Role Info -->
                    <div class="interview-card-candidate">
                        <div class="interview-candidate-avatar"><%# GetInitials(Eval("FullName")) %></div>
                        <div style="min-width: 0; flex: 1;">
                            <h3 class="interview-candidate-name"><%# Eval("FullName") %></h3>
                            <p class="interview-candidate-email"><%# Eval("StudentEmail") %></p>
                        </div>
                    </div>
                    <div class="interview-role-badge">
                        <i class="fa-solid fa-briefcase" style="color: #2563eb; font-size: 11px;"></i>
                        <span><%# Eval("InternshipTitle") %></span>
                    </div>
                    <!-- Interview Details List -->
                    <div class="interview-card-details">
                        <div class="detail-row">
                            <span class="detail-label"><i class="fa-regular fa-clock" style="color: #f59e0b;"></i> Time:</span>
                            <span class="detail-val"><%# Eval("InterviewTime") %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label"><i class="fa-solid fa-video" style="color: #7c3aed;"></i> Mode:</span>
                            <span class="detail-val"><%# Eval("InterviewType") %></span>
                        </div>
                        <div class="detail-row">
                            <span class="detail-label"><i class="fa-solid fa-link" style="color: #059669;"></i> Location/Link:</span>
                            <span class="detail-val"><%# FormatMeetingLink(Eval("MeetingLink"), Eval("Location")) %></span>
                        </div>
                        <%# !string.IsNullOrEmpty(Eval("Notes")?.ToString()) ? "<div class='detail-notes'><i class='fa-regular fa-note-sticky'></i> " + Eval("Notes") + "</div>" : "" %>
                    </div>
                    <!-- Card Actions (Always Visible) -->
                    <div class="interview-card-actions">
                        <asp:LinkButton ID="btnComplete" runat="server" CommandName="MarkComplete" CommandArgument='<%# Eval("InterviewId") %>'
                                        CssClass="btn-box-action btn-box-complete"
                                        title="Mark as Completed">
                            <i class="fa-solid fa-check"></i> Completed
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="CancelInterview" CommandArgument='<%# Eval("InterviewId") %>'
                                        CssClass="btn-box-action btn-box-cancel"
                                        title="Cancel Interview">
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
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();" title="Close">&times;</button>
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
    <script>
        function openDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var panel = document.getElementById('drawerPanel');
            if (overlay && panel) {
                overlay.style.display = 'block';
                setTimeout(function () {
                    panel.classList.add('open');
                }, 10);
                document.body.style.overflow = 'hidden';
            }
        }
        function closeDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var panel = document.getElementById('drawerPanel');
            if (overlay && panel) {
                panel.classList.remove('open');
                setTimeout(function () {
                    overlay.style.display = 'none';
                }, 250);
                document.body.style.overflow = '';
            }
        }
    </script>
</asp:Content>

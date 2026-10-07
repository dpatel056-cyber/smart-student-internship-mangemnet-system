<%@ Page Title="Feedback & Ratings" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-feedback-ratings.aspx.cs" Inherits="asp.net.css.admin_feedback_ratings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-feedback-ratings.css" />
    <style>
        /* ===== TABLE ===== */
        .fb-custom-table {
            width: 100%;
            border-collapse: collapse;
        }
        .fb-custom-table th {
            background: #f8fafc;
            padding: 14px 16px;
            font-size: 12.5px;
            font-weight: 700;
            color: #475569;
            text-transform: uppercase;
            border-bottom: 2px solid #e2e8f0;
            text-align: left;
        }
        .fb-custom-table td {
            padding: 14px 16px;
            border-bottom: 1px solid #f1f5f9;
            font-size: 13.5px;
            vertical-align: middle;
        }
        .fb-custom-table tr:hover td {
            background: #fafcff;
        }

        /* ===== ROLE BADGES ===== */
        .badge-role-st {
            background: #eff6ff;
            color: #2563eb;
            font-size: 11.5px;
            font-weight: 700;
            padding: 3px 9px;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            border: 1px solid #bfdbfe;
        }
        .badge-role-co {
            background: #f0fdf4;
            color: #16a34a;
            font-size: 11.5px;
            font-weight: 700;
            padding: 3px 9px;
            border-radius: 12px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            border: 1px solid #bbf7d0;
        }

        /* ===== ACTION BUTTONS ===== */
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

        /* ===== CENTER DRAWER MODAL ===== */
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

        /* ===== DETAILS GRID ===== */
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
            box-shadow: 0 3px 12px rgba(15, 23, 42, .03);
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
    <div class="sims-feedback-main-container">

        <!-- Page Header -->
        <div class="fb-page-header">
            <div class="fb-page-header-left">
                <h1 class="fb-page-title">Feedback &amp; Ratings</h1>
                <p class="fb-page-subtitle">Manage user feedback, ratings and reviews across students and companies.</p>
            </div>
        </div>

        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

        <!-- 4 SUMMARY STATS CARDS -->
        <div class="fb-stats-grid">

            <div class="fb-stat-card">
                <div class="fb-stat-icon icon-gold"><i class="fa-solid fa-star"></i></div>
                <div class="fb-stat-body">
                    <span class="fb-stat-label">Average Rating</span>
                    <h3 class="fb-stat-number"><asp:Label ID="lblAvgRating" runat="server"></asp:Label></h3>
                </div>
            </div>

            <div class="fb-stat-card">
                <div class="fb-stat-icon icon-blue"><i class="fa-solid fa-comments"></i></div>
                <div class="fb-stat-body">
                    <span class="fb-stat-label">Total Feedback</span>
                    <h3 class="fb-stat-number"><asp:Label ID="lblTotalFeedback" runat="server"></asp:Label></h3>
                </div>
            </div>

            <div class="fb-stat-card">
                <div class="fb-stat-icon icon-purple"><i class="fa-solid fa-user-graduate"></i></div>
                <div class="fb-stat-body">
                    <span class="fb-stat-label">Student Feedback</span>
                    <h3 class="fb-stat-number"><asp:Label ID="lblStudentFeedback" runat="server"></asp:Label></h3>
                </div>
            </div>

            <div class="fb-stat-card">
                <div class="fb-stat-icon icon-green"><i class="fa-solid fa-building"></i></div>
                <div class="fb-stat-body">
                    <span class="fb-stat-label">Company Feedback</span>
                    <h3 class="fb-stat-number"><asp:Label ID="lblCompanyFeedback" runat="server"></asp:Label></h3>
                </div>
            </div>

        </div>

        <!-- SEARCH & FILTER BAR -->
        <div style="display: flex; gap: 14px; align-items: center; background: #fff; padding: 18px 24px; border-radius: 12px; margin-bottom: 24px; border: 1px solid #e2e8f0; flex-wrap: wrap;">

            <div style="flex: 1; min-width: 240px;">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search feedback by user, email, company, internship or comments..."
                    Style="width: 100%; padding: 10px 14px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-size: 13.5px; outline: none;">
                </asp:TextBox>
            </div>

            <div style="min-width: 170px;">
                <asp:DropDownList ID="ddlFilterType" runat="server"
                    Style="width: 100%; padding: 10px 14px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-size: 13.5px; outline: none; background: #fff;">
                    <asp:ListItem Text="All Feedback Types" Value=""></asp:ListItem>
                    <asp:ListItem Text="Student -> Company Reviews" Value="StudentCompany"></asp:ListItem>
                    <asp:ListItem Text="Student -> General Platform" Value="StudentGeneral"></asp:ListItem>
                    <asp:ListItem Text="Company -> Admin Feedback" Value="CompanyGeneral"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div style="display: flex; gap: 8px;">
                <asp:LinkButton ID="btnSearch" runat="server" CausesValidation="false"
                    Style="padding: 10px 18px; background: #2563eb; color: #fff; border-radius: 8px; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; font-weight: 600; font-size: 13.5px;">
                    <i class="fa-solid fa-magnifying-glass"></i> Search
                </asp:LinkButton>
                <asp:LinkButton ID="btnClear" runat="server" CausesValidation="false"
                    Style="padding: 10px 16px; background: #f1f5f9; color: #475569; border-radius: 8px; text-decoration: none; display: inline-flex; align-items: center; gap: 5px; font-weight: 600; font-size: 13.5px; border: 1px solid #e2e8f0;">
                    <i class="fa-solid fa-xmark"></i> Clear
                </asp:LinkButton>
            </div>

        </div>

        <!-- MAIN FEEDBACK GRID -->
        <div style="background: #fff; border-radius: 14px; border: 1px solid #e2e8f0; overflow: hidden; padding: 20px;">
            <div style="overflow-x: auto;">
                <asp:GridView ID="gvFeedback" runat="server" AutoGenerateColumns="False" OnRowCommand="gvFeedback_RowCommand"
                    CssClass="fb-custom-table" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%">
                    <Columns>

                        <asp:TemplateField HeaderText="NAME">
                            <ItemTemplate>
                                <asp:Label ID="lblSenderName" runat="server" Text='<%# Eval("SenderName") %>' Style="font-weight: 700; color: #0f172a; font-size: 13.5px;"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="EMAIL">
                            <ItemTemplate>
                                <span style="color: #475569; font-size: 13px;"><asp:Label ID="lblSenderEmail" runat="server" Text='<%# Eval("SenderEmail") %>'></asp:Label></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ROLE">
                            <ItemTemplate>
                                <%# Eval("SenderType") != null && Eval("SenderType").ToString() == "Company"
                                    ? "<span class='badge-role-co'><i class='fa-solid fa-building'></i> Company</span>"
                                    : "<span class='badge-role-st'><i class='fa-solid fa-user-graduate'></i> Student</span>" %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="RATING">
                            <ItemTemplate>
                                <span style="color: #f59e0b; font-weight: 700; font-size: 13px;">
                                    <i class="fa-solid fa-star"></i> <%# Eval("Rating") %> / 5
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="SUBMITTED DATE">
                            <ItemTemplate>
                                <span style="color: #475569; font-size: 13px;">
                                    <i class="fa-regular fa-calendar"></i>
                                    <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("dd MMM yyyy") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="SUBMITTED TIME">
                            <ItemTemplate>
                                <span style="color: #64748b; font-size: 13px;">
                                    <i class="fa-regular fa-clock"></i>
                                    <%# Convert.ToDateTime(Eval("CreatedDate")).ToString("hh:mm tt") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ACTIONS">
                            <ItemTemplate>
                                <div style="display: flex; gap: 8px; align-items: center;">
                                    <asp:LinkButton ID="btnView" runat="server" CommandName="ViewFeedback" CommandArgument='<%# Eval("FeedbackId") %>'
                                        CssClass="btn-action-view" CausesValidation="false">
                                        <i class="fa-solid fa-eye"></i> View
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="cmd_delete" CommandArgument='<%# Eval("FeedbackId") %>'
                                        ToolTip="Delete Feedback" CssClass="btn-action-delete" CausesValidation="false">
                                        <i class="fa-solid fa-trash-can"></i> Delete
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                    <EmptyDataTemplate>
                        <div style="text-align: center; padding: 48px 20px;">
                            <i class="fa-solid fa-star-half-stroke" style="font-size: 48px; color: #cbd5e1; margin-bottom: 12px; display: block;"></i>
                            <h3 style="color: #475569; font-size: 18px; font-weight: 600; margin: 0 0 6px 0;">No Feedback Found</h3>
                            <p style="color: #94a3b8; font-size: 14px; margin: 0;">No user ratings or feedback comments recorded for the selected filter.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>

    </div>

    <!-- ================= CENTER MODAL DRAWER ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>

    <div class="feedback-drawer" id="feedbackDrawer">

        <div class="drawer-header">
            <h3>Feedback Details</h3>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();" title="Close Details">&times;</button>
        </div>

        <div class="drawer-body">

            <!-- Details Grid -->
            <div class="cm-detail-grid">
                <div class="cm-detail-item">
                    <span class="cm-detail-label">SENDER TYPE</span>
                    <span class="cm-detail-value"><asp:Label ID="drSenderLabel" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">FULL NAME</span>
                    <span class="cm-detail-value"><asp:Label ID="drSenderName" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">EMAIL</span>
                    <span class="cm-detail-value"><asp:Label ID="drSenderEmail" runat="server"></asp:Label></span>
                </div>
                <div class="cm-detail-item">
                    <span class="cm-detail-label">RATING</span>
                    <span class="cm-detail-value" style="display: flex; align-items: center; gap: 6px; color: #f59e0b; font-weight: 700;">
                        <i class="fa-solid fa-star"></i>
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
                <div class="cm-detail-item" style="grid-column: 1 / -1;">
                    <span class="cm-detail-label">CATEGORY &amp; TARGET</span>
                    <span class="cm-detail-value" style="color: #2563EB;"><asp:Label ID="drTarget" runat="server"></asp:Label></span>
                </div>
            </div>

            <!-- Subject Section -->
            <div class="cm-subject-section">
                <span class="cm-detail-label">SUBJECT</span>
                <span class="cm-subject-value"><asp:Label ID="drSubject" runat="server"></asp:Label></span>
            </div>

            <!-- Message Section -->
            <div class="cm-message-section">
                <span class="cm-detail-label" style="margin-bottom: 8px;">MESSAGE</span>
                <div class="cm-message-box">
                    <span class="cm-message-text"><asp:Label ID="drMessage" runat="server"></asp:Label></span>
                </div>
            </div>

        </div>
    </div>

    <script>
        function openDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var drawer = document.getElementById('feedbackDrawer');
            if (overlay && drawer) {
                overlay.classList.add('is-active');
                drawer.classList.add('is-open');
            }
        }

        function closeDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var drawer = document.getElementById('feedbackDrawer');
            if (overlay && drawer) {
                overlay.classList.remove('is-active');
                drawer.classList.remove('is-open');
            }
        }

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') {
                closeDrawer();
            }
        });
    </script>
</asp:Content>
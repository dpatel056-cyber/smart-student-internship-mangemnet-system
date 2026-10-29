<%@ Page Title="Internship Tasks & Gamified Challenges" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-tasks.aspx.cs" Inherits="asp.net.company_tasks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <link rel="stylesheet" href="../css/company-tasks.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header -->
    <div class="page-header-box">
        <div>
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Internship Tasks &amp; Gamified Challenges</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Assign interactive skill quizzes to interns, evaluate real-time scores, and issue verified completion certificates.</p>
        </div>
        <button type="button" class="btn-open-drawer" onclick="openDrawer();">
            <i class="fa-solid fa-gamepad"></i> Assign Quiz Challenge
        </button>
    </div>
    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    <!-- Stats Summary Cards -->
    <div class="task-stats-grid">
        <div class="stat-card-task">
            <div class="stat-icon-task" style="background: #f3e8ff; color: #7c3aed;"><i class="fa-solid fa-gamepad"></i></div>
            <div>
                <div style="font-size: 20px; font-weight: 700; color: #0f172a;"><asp:Label ID="lblActiveQuizzes" runat="server">0</asp:Label></div>
                <div style="font-size: 13px; color: #64748b;">Total Assigned Challenges</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div class="stat-icon-task" style="background: #f0fdf4; color: #16a34a;"><i class="fa-solid fa-trophy"></i></div>
            <div>
                <div style="font-size: 20px; font-weight: 700; color: #0f172a;"><asp:Label ID="lblPassedQuizzes" runat="server">0</asp:Label></div>
                <div style="font-size: 13px; color: #64748b;">Passed &amp; Completed</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div class="stat-icon-task" style="background: #fef9c3; color: #ca8a04;"><i class="fa-solid fa-clock"></i></div>
            <div>
                <div style="font-size: 20px; font-weight: 700; color: #0f172a;"><asp:Label ID="lblTotalTasks" runat="server">0</asp:Label></div>
                <div style="font-size: 13px; color: #64748b;">Pending / In Progress</div>
            </div>
        </div>
        <div class="stat-card-task">
            <div class="stat-icon-task" style="background: #ecfdf5; color: #059669;"><i class="fa-solid fa-user-graduate"></i></div>
            <div>
                <div style="font-size: 20px; font-weight: 700; color: #0f172a;"><asp:Label ID="lblCompletedTasks" runat="server">0</asp:Label></div>
                <div style="font-size: 13px; color: #64748b;">Eligible for Certificate</div>
            </div>
        </div>
    </div>
    <!-- ================= ASSIGNED QUIZZES GRIDVIEW ================= -->
    <div class="co-panel" style="margin-bottom: 30px; width: 100%;">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-ranking-star" style="color: #7c3aed; margin-right: 8px;"></i> Assigned Quiz Challenges &amp; Performance Tracking</h3>
        </div>
        <div class="co-table-responsive">
            <asp:GridView ID="gvQuizAssignments" runat="server" AutoGenerateColumns="False" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true" OnRowCommand="gvQuizAssignments_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="Photo" HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" ItemStyle-Width="60px">
                        <ItemTemplate>
                            <%# GetProfileAvatarHtml(Eval("ProfilePhoto"), Eval("FullName")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name" ItemStyle-Width="16%">
                        <ItemTemplate>
                            <div style="min-width: 140px; font-weight: 700; color: #0f172a; font-size: 13.5px;">
                                <%# Eval("FullName") %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" ItemStyle-Width="18%">
                        <ItemTemplate>
                            <div style="min-width: 160px; font-size: 12.5px; color: #64748b;">
                                <%# Eval("StudentEmail") %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Intern" ItemStyle-Width="16%">
                        <ItemTemplate>
                            <div style="min-width: 150px; font-size: 12.5px; color: #7c3aed; font-weight: 600;">
                                <i class="fa-solid fa-briefcase"></i> <%# Eval("InternshipTitle") %>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Quiz Challenges Details" ItemStyle-Width="22%">
                        <ItemTemplate>
                            <div style="min-width: 200px;">
                                <div style="font-weight: 700; color: #1e293b; font-size: 13px;"><%# Eval("QuizTitle") %></div>
                                <div style="font-size: 12px; color: #64748b; margin-top: 3px; display: flex; align-items: center; gap: 6px; flex-wrap: wrap;">
                                    <span style="background: #f3e8ff; color: #7c3aed; padding: 2px 7px; border-radius: 4px; font-weight: 600; font-size: 11px;"><%# Eval("Topic") %></span>
                                    <span><i class="fa-solid fa-clock" style="color: #64748b; font-size: 11px;"></i> <%# Eval("DurationMinutes") %>m</span>
                                    <span><i class="fa-solid fa-bullseye" style="color: #10b981; font-size: 11px;"></i> Pass: <%# Eval("PassingScore") %>%</span>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status &amp; Score" ItemStyle-Width="14%">
                        <ItemTemplate>
                            <div style="white-space: nowrap; min-width: 140px;">
                                <%# GetQuizStatusBadge(Eval("Status"), Eval("Score")) %>
                                <div style="font-size: 11.5px; color: #94a3b8; margin-top: 4px;">
                                    <%# Eval("CompletedDate") != DBNull.Value ? "Completed: " + Convert.ToDateTime(Eval("CompletedDate")).ToString("dd MMM, hh:mm tt") : "Assigned: " + Convert.ToDateTime(Eval("AssignedDate")).ToString("dd MMM yyyy") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end" ItemStyle-Width="14%">
                        <ItemTemplate>
                            <div style="display: flex; align-items: center; justify-content: flex-end; gap: 6px; flex-wrap: nowrap; min-width: 170px;">
                                <%# GetCertificateActionBtn(Eval("Status"), Eval("ApplicationId"), Eval("CertificateIssued")) %>
                                <asp:LinkButton ID="btnDeleteQuiz" runat="server" CommandName="DeleteAssignment" CommandArgument='<%# Eval("AssignmentId") %>' OnClientClick="return confirm('Are you sure you want to remove this quiz assignment?');" CssClass="btn-table-action btn-action-delete">
                                    <i class="fa-solid fa-trash"></i> Delete
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoQuizAssignments" runat="server" Visible="false">
                <div style="text-align: center; padding: 50px 20px;">
                    <div style="width: 64px; height: 64px; background: #f3e8ff; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; color: #7c3aed; font-size: 26px; margin-bottom: 12px;">
                        <i class="fa-solid fa-gamepad"></i>
                    </div>
                    <h4 style="font-size: 16px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">No Quiz Challenges Assigned Yet</h4>
                    <p style="font-size: 13.5px; color: #64748b; margin: 0 0 16px 0;">Click the button above to assign a gamified quiz challenge to your selected interns.</p>
                    <button type="button" class="btn-open-drawer" onclick="openDrawer();" style="display: inline-flex; margin: 0 auto;">
                        <i class="fa-solid fa-plus"></i> Assign Quiz Challenge
                    </button>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
    <!-- ================= MODAL DRAWER FORM ================= -->
    <div class="drawer-overlay" id="drawerOverlay" onclick="closeDrawer();"></div>
    <div class="drawer-panel" id="drawerPanel">
        <!-- Drawer Header -->
        <div class="drawer-header">
            <h2>
                <i class="fa-solid fa-trophy" style="color: #7c3aed;"></i> Assign Quiz Challenge
            </h2>
            <button type="button" class="drawer-close-btn" onclick="closeDrawer();">&times;</button>
        </div>
        <!-- Drawer Body -->
        <div class="drawer-body">
            <p style="font-size: 13.5px; color: #64748b; margin: 0 0 20px 0;">
                Select an intern and assign a timed gamified quiz challenge. When they pass the test, you can issue their verified certificate!
            </p>
            <div class="form-group-item">
                <label>Select Candidate / Intern <span style="color:#ef4444;">*</span></label>
                <asp:DropDownList ID="ddlQuizCandidate" runat="server" CssClass="form-ctrl">
                </asp:DropDownList>
            </div>
            <div class="form-group-item">
                <label>Select Quiz Challenge <span style="color:#ef4444;">*</span></label>
                <asp:DropDownList ID="ddlQuizSelect" runat="server" CssClass="form-ctrl">
                </asp:DropDownList>
            </div>
            <!-- Informational Challenge Box -->
            <div style="background: #faf5ff; border: 1.5px solid #e9d5ff; border-radius: 12px; padding: 16px; margin-top: 20px;">
                <div style="display: flex; gap: 12px; align-items: flex-start;">
                    <div style="width: 36px; height: 36px; border-radius: 10px; background: #f3e8ff; color: #7c3aed; display: flex; align-items: center; justify-content: center; font-size: 16px; flex-shrink: 0;">
                        <i class="fa-solid fa-wand-magic-sparkles"></i>
                    </div>
                    <div>
                        <div style="font-weight: 700; color: #581c87; font-size: 13.5px; margin-bottom: 2px;">Gamified Challenge Guidelines</div>
                        <div style="font-size: 12.5px; color: #6b21a8; line-height: 1.5;">
                            • Quizzes feature 5 multiple-choice questions with a 10-minute timer.<br />
                            • Intern requires a score of 20%+ to successfully pass.<br />
                            • Passing this test unlocks immediate Certificate Generation.
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Drawer Footer -->
        <div class="drawer-footer">
            <button type="button" class="btn-drawer-cancel" onclick="closeDrawer();">Cancel</button>
            <asp:LinkButton ID="btnAssignQuiz" runat="server" CssClass="btn-send-offer" OnClick="btnAssignQuiz_Click">
                <i class="fa-solid fa-bullseye"></i> Assign Quiz Challenge
            </asp:LinkButton>
        </div>
    </div>
    <!-- JavaScript for Drawer Control -->
    <script src="../js/company-tasks.js"></script>
</asp:Content>

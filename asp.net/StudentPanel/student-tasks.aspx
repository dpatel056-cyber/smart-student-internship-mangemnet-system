<%@ Page Title="My Internship Tasks & Quizzes" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-tasks.aspx.cs" Inherits="asp.net.student_tasks" %>
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
        .task-stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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
        .section-header-wrap {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            margin-bottom: 18px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f1f5f9;
        }
        .section-header-wrap h2 {
            font-size: 18px;
            font-weight: 800;
            color: #0f172a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        /* Quiz Challenge Cards Grid */
        .quiz-cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        .quiz-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 18px;
            padding: 22px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 14px rgba(15, 23, 42, 0.03);
            transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .quiz-card:hover {
            transform: translateY(-4px);
            border-color: #cbd5e1;
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.08);
        }
        .quiz-card-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 12px;
            margin-bottom: 14px;
        }
        .quiz-topic-tag {
            background: #eff6ff;
            color: #2563eb;
            font-size: 11.5px;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 20px;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: 1px solid #bfdbfe;
        }
        /* Quiz Status Badges */
        .quiz-badge {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 700;
            white-space: nowrap;
        }
        .badge-passed {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        .badge-failed {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }
        .badge-in-progress {
            background: #fef3c7;
            color: #b45309;
            border: 1px solid #fde68a;
        }
        .badge-ready {
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }
        /* Alert Message */
        .task-alert-msg {
            padding: 14px 20px;
            border-radius: 12px;
            margin-bottom: 22px;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .task-alert-success {
            background: #f0fdf4;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        .task-alert-info {
            background: #eff6ff;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }
        .btn-play-arena {
            width: 100%;
            padding: 12px 18px;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #ffffff;
            border: none;
            border-radius: 10px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.22);
            margin-top: 14px;
        }
        .btn-play-arena:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 18px rgba(37, 99, 235, 0.32);
        }
        .btn-arena-passed {
            background: linear-gradient(135deg, #16a34a 0%, #15803d 100%);
            box-shadow: 0 4px 12px rgba(22,163,74,0.22);
        }
        .btn-arena-passed:hover {
            box-shadow: 0 6px 18px rgba(22,163,74,0.32);
        }
        .btn-arena-retry {
            background: linear-gradient(135deg, #d97706 0%, #b45309 100%);
            box-shadow: 0 4px 12px rgba(217,119,6,0.22);
        }
        .btn-arena-retry:hover {
            box-shadow: 0 6px 18px rgba(217,119,6,0.32);
        }
        /* ================= FULLSCREEN QUIZ ARENA OVERLAY ================= */
        #quizArenaOverlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100vw;
            height: 100vh;
            background: rgba(15, 23, 42, 0.7);
            backdrop-filter: blur(8px);
            z-index: 99999;
            align-items: center;
            justify-content: center;
            padding: 16px;
            box-sizing: border-box;
        }
        .arena-modal-card {
            background: #ffffff;
            border-radius: 20px;
            width: 100%;
            max-width: 680px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 25px 50px -12px rgba(15, 23, 42, 0.25);
            overflow: hidden;
            position: relative;
            animation: modalFadeIn 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }
        @keyframes modalFadeIn {
            0% { transform: scale(0.94); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }
        .arena-header {
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            color: #ffffff;
            padding: 18px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
        }
        .arena-mascot {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: rgba(255,255,255,0.18);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 18px;
            flex-shrink: 0;
        }
        .arena-timer-pill {
            background: rgba(255, 255, 255, 0.2);
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 700;
            font-size: 13.5px;
            display: flex;
            align-items: center;
            gap: 7px;
            border: 1px solid rgba(255,255,255,0.3);
            color: #ffffff;
        }
        .arena-body {
            padding: 22px 26px;
            background: #f8fafc;
        }
        /* Toolbar */
        .lifelines-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            margin-bottom: 16px;
            padding: 10px 14px;
            background: #ffffff;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.02);
        }
        .btn-lifeline {
            background: #eff6ff;
            border: 1px solid #bfdbfe;
            padding: 6px 14px;
            border-radius: 8px;
            font-size: 12.5px;
            font-weight: 700;
            color: #2563eb;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-lifeline:hover:not(:disabled) {
            background: #dbeafe;
            border-color: #93c5fd;
            color: #1d4ed8;
        }
        .btn-lifeline:disabled {
            opacity: 0.35;
            cursor: not-allowed;
            text-decoration: line-through;
        }
        .arena-progress-wrap {
            width: 100%;
            height: 8px;
            background: #e2e8f0;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 18px;
        }
        .arena-progress-bar {
            height: 100%;
            background: linear-gradient(90deg, #3b82f6, #2563eb, #1d4ed8);
            width: 20%;
            transition: width 0.3s ease;
            border-radius: 8px;
        }
        .arena-question-text {
            font-size: 16.5px;
            font-weight: 800;
            color: #0f172a;
            line-height: 1.5;
            margin-bottom: 18px;
            text-align: left;
            background: #ffffff;
            padding: 16px 20px;
            border-radius: 14px;
            border: 1.5px solid #e2e8f0;
            box-shadow: 0 2px 8px rgba(15, 23, 42, 0.02);
        }
        .arena-options-grid {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 18px;
        }
        .arena-opt-btn {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            padding: 13px 18px;
            font-size: 14px;
            font-weight: 700;
            color: #1e293b;
            text-align: left;
            cursor: pointer;
            transition: all 0.15s ease;
            display: flex;
            align-items: center;
            gap: 12px;
            outline: none;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.02);
        }
        .arena-opt-btn:hover:not(:disabled) {
            border-color: #2563eb;
            background: #eff6ff;
            color: #1d4ed8;
            transform: translateX(4px);
        }
        .arena-opt-btn.correct {
            border-color: #10b981 !important;
            background: #ecfdf5 !important;
            color: #065f46 !important;
        }
        .arena-opt-btn.wrong {
            border-color: #ef4444 !important;
            background: #fef2f2 !important;
            color: #991b1b !important;
            animation: shake 0.3s ease;
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        .arena-opt-btn.faded-out {
            opacity: 0.25;
            pointer-events: none;
        }
        .opt-letter {
            width: 32px;
            height: 32px;
            border-radius: 8px;
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 13px;
            flex-shrink: 0;
            transition: all 0.15s;
        }
        .arena-opt-btn:hover .opt-letter {
            background: #2563eb;
            color: #ffffff;
            border-color: #2563eb;
        }
        .arena-opt-btn.correct .opt-letter {
            background: #10b981;
            color: #ffffff;
            border-color: #10b981;
        }
        .arena-opt-btn.wrong .opt-letter {
            background: #ef4444;
            color: #ffffff;
            border-color: #ef4444;
        }
        /* Praise Bubble Pop */
        #praiseBubble {
            display: none;
            text-align: center;
            font-size: 15px;
            font-weight: 800;
            color: #15803d;
            margin-bottom: 12px;
        }
        .arena-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #e2e8f0;
            padding-top: 14px;
        }
        .arena-streak-badge {
            font-size: 13px;
            font-weight: 700;
            color: #ea580c;
            display: flex;
            align-items: center;
            gap: 6px;
            background: #fff7ed;
            padding: 6px 14px;
            border-radius: 10px;
            border: 1px solid #fed7aa;
        }
        .btn-next-q {
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 7px;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
        }
        .btn-next-q:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(37, 99, 235, 0.35);
        }
        /* Result View */
        .arena-result-view {
            display: none;
            text-align: center;
            padding: 34px 24px;
            background: #f8fafc;
        }
        .score-circle {
            width: 130px;
            height: 130px;
            border-radius: 50%;
            background: linear-gradient(135deg, #1e3a8a 0%, #2563eb 100%);
            color: #ffffff;
            display: inline-flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-size: 34px;
            font-weight: 900;
            margin-bottom: 18px;
            box-shadow: 0 10px 25px rgba(37, 99, 235, 0.3);
            border: 4px solid #ffffff;
        }
        .score-circle span {
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 1px;
            opacity: 0.95;
        }
        .rank-badge-pill {
            display: inline-block;
            background: #eff6ff;
            color: #1d4ed8;
            font-weight: 800;
            font-size: 13.5px;
            padding: 6px 18px;
            border-radius: 20px;
            border: 1px solid #bfdbfe;
            margin-bottom: 14px;
        }
        #confettiCanvas {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 10;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0;">
        <!-- Header -->
        <div class="page-header-box">
            <div class="page-title">
                <h1><i class="fa-solid fa-list-check" style="color: #2563eb;"></i> My Internship Tasks &amp; Quizzes</h1>
                <p>Complete your assigned technical quizzes and internship assessments to test your skills and unlock your verified certificate!</p>
            </div>
        </div>
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        <!-- Stats Grid -->
        <div class="task-stats-grid">
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #eff6ff; color: #2563eb;"><i class="fa-solid fa-clipboard-question"></i></div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblTotalQuizzes" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Total Assigned</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #f0fdf4; color: #16a34a;"><i class="fa-solid fa-circle-check"></i></div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblPassedQuizzes" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Passed &amp; Completed</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #eff6ff; color: #1d4ed8;"><i class="fa-solid fa-clock"></i></div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblTotalTasks" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Pending / In Progress</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #eff6ff; color: #2563eb;"><i class="fa-solid fa-award"></i></div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblCompletedTasks" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Certificate Eligible</div>
                </div>
            </div>
        </div>
        <!-- SECTION 1: QUIZ ASSESSMENTS -->
        <div class="section-header-wrap">
            <h2><i class="fa-solid fa-clipboard-question" style="color: #2563eb;"></i> Assigned Quiz Assessments</h2>
            <span style="font-size: 12px; color: #2563eb; font-weight: 700; background: #eff6ff; padding: 5px 14px; border-radius: 20px; border: 1px solid #bfdbfe;"><i class="fa-solid fa-laptop-code"></i> Interactive Assessment Arena</span>
        </div>
        <div class="quiz-cards-grid">
            <asp:DataList ID="rptStudentQuizzes" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                <ItemTemplate>
                    <div class="quiz-card">
                        <div>
                            <div class="quiz-card-top">
                                <span class="quiz-topic-tag"><asp:Label ID="lblTopic" runat="server" Text='<%# Eval("Topic") %>'></asp:Label></span>
                                <asp:Label ID="litStatusBadge" runat="server" Text='<%# GetQuizStatusBadge(Eval("Status"), Eval("Score")) %>'></asp:Label>
                            </div>
                            <h3 style="font-size: 17.5px; font-weight: 800; color: #0f172a; margin: 0 0 6px 0;"><asp:Label ID="lblQuizTitle" runat="server" Text='<%# Eval("QuizTitle") %>'></asp:Label></h3>
                            <div style="font-size: 13px; color: #64748b; margin-bottom: 14px;">
                                <i class="fa-solid fa-building" style="color: #2563eb;"></i> <strong><asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("CompanyName") %>'></asp:Label></strong> (<asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>)
                            </div>
                            <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 12px; padding: 10px 14px; display: flex; justify-content: space-between; font-size: 12.5px; color: #475569; margin-bottom: 12px;">
                                <span><i class="fa-regular fa-clock" style="color: #2563eb;"></i> <strong><asp:Label ID="lblDuration" runat="server" Text='<%# Eval("DurationMinutes") %>'></asp:Label> mins</strong></span>
                                <span><i class="fa-solid fa-bullseye" style="color: #16a34a;"></i> Pass: <strong><asp:Label ID="lblPassScore" runat="server" Text='<%# Eval("PassingScore") %>'></asp:Label>%</strong></span>
                                <span><i class="fa-solid fa-circle-question" style="color: #3b82f6;"></i> <strong><asp:Label ID="lblTotalQ" runat="server" Text='<%# Eval("TotalQuestions") %>'></asp:Label> Qs</strong></span>
                            </div>
                        </div>
                        <div>
                            <asp:Label ID="litPlayBtn" runat="server" Text='<%# GetQuizPlayBtn(Eval("AssignmentId"), Eval("QuizId"), Eval("QuizTitle"), Eval("DurationMinutes"), Eval("PassingScore"), Eval("Status")) %>'></asp:Label>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
            <asp:PlaceHolder ID="pnlNoQuizzes" runat="server" Visible="false">
                <div style="grid-column: 1 / -1; background: #ffffff; border: 1.5px dashed #cbd5e1; border-radius: 18px; text-align: center; padding: 40px 20px;">
                    <div style="width: 64px; height: 64px; background: #eff6ff; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; color: #2563eb; font-size: 26px; margin-bottom: 12px;">
                        <i class="fa-solid fa-clipboard-question"></i>
                    </div>
                    <h3 style="font-size: 17px; font-weight: 800; color: #0f172a; margin: 0 0 4px 0;">No Quizzes Assigned Yet</h3>
                    <p style="font-size: 14px; color: #64748b; margin: 0;">When your internship company assigns an assessment quiz challenge, it will appear here!</p>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
    <!-- Hidden fields for submitting Quiz Score back to ASP.NET -->
    <asp:HiddenField ID="hfQuizAssignmentId" runat="server" />
    <asp:HiddenField ID="hfQuizScore" runat="server" />
    <asp:HiddenField ID="hfQuizCorrectCount" runat="server" />
    <asp:HiddenField ID="hfQuizTotalQuestions" runat="server" />
    <asp:Button ID="btnHiddenSubmitQuiz" runat="server" style="display:none;" OnClick="btnHiddenSubmitQuiz_Click" />
    <!-- FULLSCREEN QUIZ ARENA MODAL -->
    <div id="quizArenaOverlay">
        <div class="arena-modal-card">
            <canvas id="confettiCanvas"></canvas>
            <!-- Header -->
            <div class="arena-header">
                <div style="display:flex; align-items:center; gap:12px;">
                    <div class="arena-mascot" id="arenaAvatar"><i class="fa-solid fa-graduation-cap"></i></div>
                    <div>
                        <h3 id="modalQuizTitle" style="margin: 0; font-size: 17.5px; font-weight: 800;">Quiz Assessment</h3>
                        <div id="modalQuizSubtitle" style="font-size: 12px; opacity: 0.9; margin-top: 2px;">Technical Skills Assessment</div>
                    </div>
                </div>
                <div style="display:flex; align-items:center; gap:10px;">
                    <div class="arena-timer-pill">
                        <i class="fa-solid fa-stopwatch"></i>
                        <span id="arenaTimer">10:00</span>
                    </div>
                    <button type="button" onclick="closeQuizArena();" style="background: rgba(255,255,255,0.2); border: none; color: #fff; width:32px; height:32px; border-radius:50%; display:flex; align-items:center; justify-content:center; font-size: 15px; cursor: pointer;">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
            </div>
            <!-- Quiz Play Screen -->
            <div id="arenaPlayScreen" class="arena-body">
                <!-- Lifelines Bar -->
                <div class="lifelines-bar">
                    <div style="display:flex; gap:8px;">
                        <button type="button" id="btn5050" class="btn-lifeline" onclick="use5050Lifeline();" title="Remove 2 wrong choices">
                            <i class="fa-solid fa-bolt" style="color:#2563eb;"></i> 50:50
                        </button>
                        <button type="button" id="btnHint" class="btn-lifeline" onclick="useHintLifeline();" title="Get a hint">
                            <i class="fa-solid fa-lightbulb" style="color:#d97706;"></i> Hint
                        </button>
                    </div>
                    <div style="display:flex; align-items:center; gap:6px;">
                        <button type="button" id="btnSoundToggle" class="btn-lifeline" onclick="toggleSound();" title="Mute/Unmute Audio">
                            <i class="fa-solid fa-volume-high"></i> Sound: ON
                        </button>
                    </div>
                </div>
                <!-- Live Score & Tracker -->
                <div style="display: flex; justify-content: space-between; font-size: 13.5px; font-weight: 700; color: #64748b; margin-bottom: 8px;">
                    <span id="arenaQTracker">Question 1 of 5</span>
                    <span id="arenaScoreLive" style="color: #2563eb; font-weight:800;">0 Points</span>
                </div>
                <div class="arena-progress-wrap">
                    <div id="arenaProgressBar" class="arena-progress-bar"></div>
                </div>
                <!-- Praise Bubble Toast -->
                <div id="praiseBubble">Correct Answer!</div>
                <div id="arenaQuestionText" class="arena-question-text">Loading question...</div>
                <div id="arenaHintBox" style="display:none; background:#fefce8; color:#854d0e; padding:12px 16px; border-radius:10px; font-size:13.5px; font-weight:600; margin-bottom:14px; border:1px solid #fef08a;">
                    <i class="fa-solid fa-lightbulb" style="color:#d97706;"></i> <strong>Hint:</strong> <span id="arenaHintText">Here is a hint</span>
                </div>
                <div class="arena-options-grid">
                    <button type="button" id="btnOptA" class="arena-opt-btn" onclick="selectAnswer('A');">
                        <span class="opt-letter">A</span>
                        <span id="optAText">Option A</span>
                    </button>
                    <button type="button" id="btnOptB" class="arena-opt-btn" onclick="selectAnswer('B');">
                        <span class="opt-letter">B</span>
                        <span id="optBText">Option B</span>
                    </button>
                    <button type="button" id="btnOptC" class="arena-opt-btn" onclick="selectAnswer('C');">
                        <span class="opt-letter">C</span>
                        <span id="optCText">Option C</span>
                    </button>
                    <button type="button" id="btnOptD" class="arena-opt-btn" onclick="selectAnswer('D');">
                        <span class="opt-letter">D</span>
                        <span id="optDText">Option D</span>
                    </button>
                </div>
                <div class="arena-footer">
                    <div id="arenaStreak" class="arena-streak-badge">
                        <i class="fa-solid fa-fire" style="color:#ea580c;"></i> <span>Streak: 0</span>
                    </div>
                    <button type="button" id="btnNextQuestion" class="btn-next-q" onclick="nextQuestion();" style="visibility: hidden;">
                        Next Question <i class="fa-solid fa-arrow-right"></i>
                    </button>
                </div>
            </div>
            <!-- Result Screen -->
            <div id="arenaResultScreen" class="arena-result-view">
                <div class="rank-badge-pill" id="resRankBadge">EXCELLENT PERFORMANCE</div>
                <div class="score-circle">
                    <div id="resScorePct">100%</div>
                    <span>SCORE</span>
                </div>
                <h2 id="resTitle" style="font-size: 22px; font-weight: 800; color: #0f172a; margin: 0 0 6px 0;">Assessment Completed</h2>
                <p id="resDesc" style="font-size: 14px; color: #64748b; margin: 0 0 20px 0; max-width: 440px; margin-left: auto; margin-right: auto; line-height: 1.5;">
                    Your quiz assessment results are ready to be submitted to the company.
                </p>
                <div style="background: #ffffff; border-radius: 12px; padding: 12px 22px; display: inline-flex; gap: 24px; margin-bottom: 22px; font-size: 13.5px; border: 1px solid #e2e8f0; box-shadow: 0 2px 8px rgba(0,0,0,0.02);">
                    <div><span style="color:#64748b;">Correct:</span> <strong id="resCorrectCount" style="color:#16a34a;">5 / 5</strong></div>
                    <div><span style="color:#64748b;">Status:</span> <strong id="resStatusBadge" style="color:#2563eb;">PASSED</strong></div>
                </div>
                <div>
                    <button type="button" class="btn-play-arena" onclick="finalizeQuizSubmission();" style="max-width: 320px; margin: 0 auto; font-size:14px; padding:13px 20px;">
                        <i class="fa-solid fa-cloud-arrow-up"></i> Submit Score to Company
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- Web Audio Sound Engine & Child-Friendly Game Controller -->
    <script>
        let soundEnabled = true;
        const AudioFX = {
            ctx: null,
            init() {
                if (!this.ctx) {
                    const AudioContext = window.AudioContext || window.webkitAudioContext;
                    if (AudioContext) this.ctx = new AudioContext();
                }
            },
            playPop() {
                if (!soundEnabled) return;
                try {
                    this.init();
                    if (!this.ctx) return;
                    let osc = this.ctx.createOscillator();
                    let gain = this.ctx.createGain();
                    osc.connect(gain);
                    gain.connect(this.ctx.destination);
                    osc.type = 'sine';
                    osc.frequency.setValueAtTime(600, this.ctx.currentTime);
                    osc.frequency.exponentialRampToValueAtTime(1100, this.ctx.currentTime + 0.09);
                    gain.gain.setValueAtTime(0.3, this.ctx.currentTime);
                    gain.gain.exponentialRampToValueAtTime(0.01, this.ctx.currentTime + 0.09);
                    osc.start(this.ctx.currentTime);
                    osc.stop(this.ctx.currentTime + 0.09);
                } catch(e) {}
            },
            playCorrect() {
                if (!soundEnabled) return;
                try {
                    this.init();
                    if (!this.ctx) return;
                    // Joyful musical xylophone chime
                    [523.25, 659.25, 783.99, 1046.50, 1318.51].forEach((freq, i) => {
                        let osc = this.ctx.createOscillator();
                        let gain = this.ctx.createGain();
                        osc.connect(gain);
                        gain.connect(this.ctx.destination);
                        osc.type = 'triangle';
                        osc.frequency.value = freq;
                        let start = this.ctx.currentTime + (i * 0.06);
                        gain.gain.setValueAtTime(0.25, start);
                        gain.gain.exponentialRampToValueAtTime(0.001, start + 0.28);
                        osc.start(start);
                        osc.stop(start + 0.28);
                    });
                } catch(e) {}
            },
            playZap() {
                if (!soundEnabled) return;
                try {
                    this.init();
                    if (!this.ctx) return;
                    let osc = this.ctx.createOscillator();
                    let gain = this.ctx.createGain();
                    osc.connect(gain);
                    gain.connect(this.ctx.destination);
                    osc.type = 'sawtooth';
                    osc.frequency.setValueAtTime(900, this.ctx.currentTime);
                    osc.frequency.exponentialRampToValueAtTime(250, this.ctx.currentTime + 0.18);
                    gain.gain.setValueAtTime(0.3, this.ctx.currentTime);
                    gain.gain.exponentialRampToValueAtTime(0.01, this.ctx.currentTime + 0.18);
                    osc.start(this.ctx.currentTime);
                    osc.stop(this.ctx.currentTime + 0.18);
                } catch(e) {}
            },
            playWrong() {
                if (!soundEnabled) return;
                try {
                    this.init();
                    if (!this.ctx) return;
                    // Funny cartoon boing
                    let osc = this.ctx.createOscillator();
                    let gain = this.ctx.createGain();
                    osc.connect(gain);
                    gain.connect(this.ctx.destination);
                    osc.type = 'sine';
                    osc.frequency.setValueAtTime(300, this.ctx.currentTime);
                    osc.frequency.exponentialRampToValueAtTime(160, this.ctx.currentTime + 0.25);
                    gain.gain.setValueAtTime(0.3, this.ctx.currentTime);
                    gain.gain.exponentialRampToValueAtTime(0.01, this.ctx.currentTime + 0.25);
                    osc.start(this.ctx.currentTime);
                    osc.stop(this.ctx.currentTime + 0.25);
                } catch(e) {}
            },
            playFanfare() {
                if (!soundEnabled) return;
                try {
                    this.init();
                    if (!this.ctx) return;
                    const notes = [
                        { f: 523.25, d: 0.15 }, { f: 659.25, d: 0.15 }, { f: 783.99, d: 0.15 },
                        { f: 1046.50, d: 0.35 }, { f: 880.00, d: 0.15 }, { f: 1046.50, d: 0.6 }
                    ];
                    let curr = this.ctx.currentTime;
                    notes.forEach(n => {
                        let osc = this.ctx.createOscillator();
                        let gain = this.ctx.createGain();
                        osc.connect(gain);
                        gain.connect(this.ctx.destination);
                        osc.type = 'triangle';
                        osc.frequency.value = n.f;
                        gain.gain.setValueAtTime(0.25, curr);
                        gain.gain.exponentialRampToValueAtTime(0.001, curr + n.d);
                        osc.start(curr);
                        osc.stop(curr + n.d);
                        curr += n.d;
                    });
                } catch(e) {}
            }
        };
        function toggleSound() {
            soundEnabled = !soundEnabled;
            document.getElementById('btnSoundToggle').innerText = soundEnabled ? '🔊 Sound: ON' : '🔇 Sound: OFF';
            if (soundEnabled) AudioFX.playPop();
        }
        // Quiz Game State
        let currentAssignmentId = 0;
        let currentQuizId = 0;
        let passingScore = 20;
        let questions = [];
        let currentQIndex = 0;
        let correctCount = 0;
        let streak = 0;
        let timerSeconds = 600;
        let timerInterval = null;
        let answeredCurrent = false;
        let used5050 = false;
        let usedHint = false;
        const praises = [
            '🌟 YAHOO! THAT IS RIGHT! 🎉',
            '🍭 SWEET AS CANDY! 🍬',
            '🚀 SUPER DUPER AWESOME! 🌈',
            '🦁 BRAVE & SMART! 👑',
            '🦄 PURE MAGIC! ⭐'
        ];
        function openQuizArena(assignmentId, quizId, title, durationMinutes, passScore) {
            AudioFX.init();
            currentAssignmentId = assignmentId;
            currentQuizId = quizId;
            passingScore = passScore || 20;
            timerSeconds = (durationMinutes || 10) * 60;
            used5050 = false;
            usedHint = false;
            document.getElementById('btn5050').disabled = false;
            document.getElementById('btnHint').disabled = false;
            document.getElementById('arenaHintBox').style.display = 'none';
            document.getElementById('praiseBubble').style.display = 'none';
            document.getElementById('modalQuizTitle').innerText = title;
            document.getElementById('arenaPlayScreen').style.display = 'block';
            document.getElementById('arenaResultScreen').style.display = 'none';
            document.getElementById('quizArenaOverlay').style.display = 'flex';
            // Fetch questions from backend WebMethod
            fetch('student-tasks.aspx/GetQuizQuestions', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json; charset=utf-8' },
                body: JSON.stringify({ quizId: quizId })
            })
            .then(res => res.json())
            .then(data => {
                let list = typeof data.d === 'string' ? JSON.parse(data.d) : data.d;
                if (list && list.length > 0) {
                    questions = list;
                    currentQIndex = 0;
                    correctCount = 0;
                    streak = 0;
                    startQuizSession();
                } else {
                    alert('No questions found for this quiz.');
                    closeQuizArena();
                }
            })
            .catch(err => {
                console.error(err);
                alert('Could not load quiz questions.');
                closeQuizArena();
            });
        }
        function startQuizSession() {
            renderQuestion();
            clearInterval(timerInterval);
            timerInterval = setInterval(() => {
                timerSeconds--;
                let m = Math.floor(timerSeconds / 60);
                let s = timerSeconds % 60;
                document.getElementById('arenaTimer').innerText = `${m < 10 ? '0' : ''}${m}:${s < 10 ? '0' : ''}${s}`;
                if (timerSeconds <= 0) {
                    clearInterval(timerInterval);
                    finishQuiz();
                }
            }, 1000);
        }
        function renderQuestion() {
            answeredCurrent = false;
            let q = questions[currentQIndex];
            document.getElementById('arenaQTracker').innerText = `🎈 Question ${currentQIndex + 1} of ${questions.length}`;
            document.getElementById('arenaProgressBar').style.width = `${((currentQIndex + 1) / questions.length) * 100}%`;
            document.getElementById('arenaQuestionText').innerText = q.QuestionText;
            document.getElementById('optAText').innerText = q.OptionA;
            document.getElementById('optBText').innerText = q.OptionB;
            document.getElementById('optCText').innerText = q.OptionC;
            document.getElementById('optDText').innerText = q.OptionD;
            document.getElementById('arenaHintBox').style.display = 'none';
            document.getElementById('praiseBubble').style.display = 'none';
            // Update Mascot
            const mascots = ['🐼', '🐱', '🦄', '🦁', '👑'];
            let mIndex = Math.min(streak, mascots.length - 1);
            document.getElementById('arenaAvatar').innerText = mascots[mIndex];
            document.getElementById('arenaStreak').innerHTML = streak >= 2 ?
                `<i class="fa-solid fa-fire" style="color:#ea580c;"></i> <strong style="color:#ea580c;">${streak}X SUPER COMBO!</strong>` :
                `<i class="fa-solid fa-fire" style="color:#ea580c;"></i> <span>Streak: ${streak}</span>`;
            document.getElementById('arenaScoreLive').innerText = `⭐ ${correctCount * 20} XP`;
            // Reset buttons
            ['A', 'B', 'C', 'D'].forEach(letter => {
                let btn = document.getElementById('btnOpt' + letter);
                btn.className = 'arena-opt-btn';
                btn.disabled = false;
            });
            document.getElementById('btnNextQuestion').style.visibility = 'hidden';
        }
        function use5050Lifeline() {
            if (used5050 || answeredCurrent) return;
            used5050 = true;
            document.getElementById('btn5050').disabled = true;
            AudioFX.playZap();
            let q = questions[currentQIndex];
            let correctLetter = q.CorrectOption.toUpperCase();
            let all = ['A', 'B', 'C', 'D'];
            let wrongOptions = all.filter(l => l !== correctLetter);
            wrongOptions.sort(() => Math.random() - 0.5);
            let toRemove = wrongOptions.slice(0, 2);
            toRemove.forEach(letter => {
                let btn = document.getElementById('btnOpt' + letter);
                btn.classList.add('faded-out');
                btn.disabled = true;
            });
        }
        function useHintLifeline() {
            if (usedHint || answeredCurrent) return;
            usedHint = true;
            document.getElementById('btnHint').disabled = true;
            AudioFX.playPop();
            let q = questions[currentQIndex];
            let correctLetter = q.CorrectOption.toUpperCase();
            let optText = q['Option' + correctLetter];
            document.getElementById('arenaHintText').innerText = `Look for: "${optText}"! It is the right one!`;
            document.getElementById('arenaHintBox').style.display = 'block';
        }
        function selectAnswer(selected) {
            if (answeredCurrent) return;
            answeredCurrent = true;
            let q = questions[currentQIndex];
            let isCorrect = selected.toUpperCase() === q.CorrectOption.toUpperCase();
            ['A', 'B', 'C', 'D'].forEach(letter => {
                let btn = document.getElementById('btnOpt' + letter);
                btn.disabled = true;
            });
            let chosenBtn = document.getElementById('btnOpt' + selected.toUpperCase());
            let correctBtn = document.getElementById('btnOpt' + q.CorrectOption.toUpperCase());
            if (isCorrect) {
                chosenBtn.classList.add('correct');
                correctCount++;
                streak++;
                AudioFX.playCorrect();
                // Show praise
                let p = praises[Math.floor(Math.random() * praises.length)];
                let pBubble = document.getElementById('praiseBubble');
                pBubble.innerText = p;
                pBubble.style.display = 'block';
            } else {
                chosenBtn.classList.add('wrong');
                if (correctBtn) correctBtn.classList.add('correct');
                streak = 0;
                AudioFX.playWrong();
            }
            const mascots = ['🐼', '🐱', '🦄', '🦁', '👑'];
            let mIndex = Math.min(streak, mascots.length - 1);
            document.getElementById('arenaAvatar').innerText = mascots[mIndex];
            document.getElementById('arenaStreak').innerHTML = streak >= 2 ?
                `<i class="fa-solid fa-fire" style="color:#ea580c;"></i> <strong style="color:#ea580c;">${streak}X SUPER COMBO!</strong>` :
                `<i class="fa-solid fa-fire" style="color:#ea580c;"></i> <span>Streak: ${streak}</span>`;
            document.getElementById('arenaScoreLive').innerText = `⭐ ${correctCount * 20} XP`;
            let btnNext = document.getElementById('btnNextQuestion');
            btnNext.style.visibility = 'visible';
            if (currentQIndex === questions.length - 1) {
                btnNext.innerHTML = `Finish Game 🏆`;
            } else {
                btnNext.innerHTML = `Next Fun Question <i class="fa-solid fa-arrow-right"></i>`;
            }
        }
        function nextQuestion() {
            AudioFX.playPop();
            if (currentQIndex < questions.length - 1) {
                currentQIndex++;
                renderQuestion();
            } else {
                finishQuiz();
            }
        }
        function finishQuiz() {
            clearInterval(timerInterval);
            document.getElementById('arenaPlayScreen').style.display = 'none';
            document.getElementById('arenaResultScreen').style.display = 'block';
            let totalQ = questions.length;
            let scorePct = Math.round((correctCount / totalQ) * 100);
            let isPassed = scorePct >= passingScore;
            document.getElementById('resScorePct').innerText = `${scorePct}%`;
            document.getElementById('resCorrectCount').innerText = `${correctCount} / ${totalQ}`;
            let rankBadge = document.getElementById('resRankBadge');
            if (scorePct === 100) {
                rankBadge.innerText = '👑 SUPER DUPER CHAMPION!';
            } else if (scorePct >= 60) {
                rankBadge.innerText = '🌟 STAR MASTER!';
            } else {
                rankBadge.innerText = '🎈 SMART PLAYER!';
            }
            if (isPassed) {
                document.getElementById('resTitle').innerText = '🎉 You Won the Game!';
                document.getElementById('resDesc').innerText = `Hooray! You earned ${correctCount * 20} XP with ${scorePct}% score. You did super great!`;
                document.getElementById('resStatusBadge').innerText = 'PASSED 🎉';
                document.getElementById('resStatusBadge').style.color = '#10b981';
                AudioFX.playFanfare();
                triggerConfetti();
            } else {
                document.getElementById('resTitle').innerText = '⚡ Play Again!';
                document.getElementById('resDesc').innerText = `You scored ${scorePct}%. Try once more, it's super easy!`;
                document.getElementById('resStatusBadge').innerText = 'RETRY';
                document.getElementById('resStatusBadge').style.color = '#ef4444';
            }
        }
        function finalizeQuizSubmission() {
            let totalQ = questions.length;
            let scorePct = Math.round((correctCount / totalQ) * 100);
            // Populate hidden ASP.NET postback fields and trigger form submission
            document.getElementById('<%= hfQuizAssignmentId.ClientID %>').value = currentAssignmentId;
            document.getElementById('<%= hfQuizScore.ClientID %>').value = scorePct;
            document.getElementById('<%= hfQuizCorrectCount.ClientID %>').value = correctCount;
            document.getElementById('<%= hfQuizTotalQuestions.ClientID %>').value = totalQ;
            document.getElementById('<%= btnHiddenSubmitQuiz.ClientID %>').click();
        }
        function closeQuizArena() {
            clearInterval(timerInterval);
            document.getElementById('quizArenaOverlay').style.display = 'none';
        }
        // Lightweight Colorful Confetti Particles Engine
        function triggerConfetti() {
            const canvas = document.getElementById('confettiCanvas');
            const ctx = canvas.getContext('2d');
            canvas.width = canvas.parentElement.offsetWidth;
            canvas.height = canvas.parentElement.offsetHeight;
            const particles = [];
            const colors = ['#ec4899', '#8b5cf6', '#3b82f6', '#10b981', '#f59e0b', '#06b6d4', '#f43f5e', '#a855f7'];
            for (let i = 0; i < 90; i++) {
                particles.push({
                    x: canvas.width / 2,
                    y: canvas.height / 2,
                    vx: (Math.random() - 0.5) * 16,
                    vy: (Math.random() - 0.7) * 18,
                    color: colors[Math.floor(Math.random() * colors.length)],
                    size: Math.random() * 10 + 4,
                    rotation: Math.random() * 360,
                    rSpeed: (Math.random() - 0.5) * 12
                });
            }
            let frame = 0;
            function animateConfetti() {
                ctx.clearRect(0, 0, canvas.width, canvas.height);
                particles.forEach(p => {
                    p.x += p.vx;
                    p.y += p.vy;
                    p.vy += 0.32; // gravity
                    p.rotation += p.rSpeed;
                    ctx.save();
                    ctx.translate(p.x, p.y);
                    ctx.rotate((p.rotation * Math.PI) / 180);
                    ctx.fillStyle = p.color;
                    ctx.fillRect(-p.size / 2, -p.size / 2, p.size, p.size);
                    ctx.restore();
                });
                frame++;
                if (frame < 150) {
                    requestAnimationFrame(animateConfetti);
                } else {
                    ctx.clearRect(0, 0, canvas.width, canvas.height);
                }
            }
            animateConfetti();
        }
    </script>
</asp:Content>

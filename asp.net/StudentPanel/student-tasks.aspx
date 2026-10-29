<%@ Page Title="My Internship Tasks & Quizzes" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-tasks.aspx.cs" Inherits="asp.net.student_tasks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-tasks.css" />
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div  class="stask-u1">
        <!-- Header -->
        <div class="page-header-box">
            <div class="page-title">
                <h1><i class="fa-solid fa-list-check stask-u2" ></i> My Internship Tasks &amp; Quizzes</h1>
                <p>Complete your assigned technical quizzes and internship assessments to test your skills and unlock your verified certificate!</p>
            </div>
        </div>
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        <!-- Stats Grid -->
        <div class="task-stats-grid">
            <div class="stat-card-task">
                <div class="stat-icon-task stask-u3" ><i class="fa-solid fa-clipboard-question"></i></div>
                <div>
                    <div  class="stask-u4"><asp:Label ID="lblTotalQuizzes" runat="server">0</asp:Label></div>
                    <div  class="stask-u5">Total Assigned</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task stask-u6" ><i class="fa-solid fa-circle-check"></i></div>
                <div>
                    <div  class="stask-u4"><asp:Label ID="lblPassedQuizzes" runat="server">0</asp:Label></div>
                    <div  class="stask-u5">Passed &amp; Completed</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task stask-u7" ><i class="fa-solid fa-clock"></i></div>
                <div>
                    <div  class="stask-u4"><asp:Label ID="lblTotalTasks" runat="server">0</asp:Label></div>
                    <div  class="stask-u5">Pending / In Progress</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task stask-u3" ><i class="fa-solid fa-award"></i></div>
                <div>
                    <div  class="stask-u4"><asp:Label ID="lblCompletedTasks" runat="server">0</asp:Label></div>
                    <div  class="stask-u5">Certificate Eligible</div>
                </div>
            </div>
        </div>
        <!-- SECTION 1: QUIZ ASSESSMENTS -->
        <div class="section-header-wrap">
            <h2><i class="fa-solid fa-clipboard-question stask-u2" ></i> Assigned Quiz Assessments</h2>
            <span  class="stask-u8"><i class="fa-solid fa-laptop-code"></i> Interactive Assessment Arena</span>
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
                            <h3  class="stask-u9"><asp:Label ID="lblQuizTitle" runat="server" Text='<%# Eval("QuizTitle") %>'></asp:Label></h3>
                            <div  class="stask-u10">
                                <i class="fa-solid fa-building stask-u2" ></i> <strong><asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("CompanyName") %>'></asp:Label></strong> (<asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>)
                            </div>
                            <div  class="stask-u11">
                                <span><i class="fa-regular fa-clock stask-u2" ></i> <strong><asp:Label ID="lblDuration" runat="server" Text='<%# Eval("DurationMinutes") %>'></asp:Label> mins</strong></span>
                                <span><i class="fa-solid fa-bullseye stask-u12" ></i> Pass: <strong><asp:Label ID="lblPassScore" runat="server" Text='<%# Eval("PassingScore") %>'></asp:Label>%</strong></span>
                                <span><i class="fa-solid fa-circle-question stask-u13" ></i> <strong><asp:Label ID="lblTotalQ" runat="server" Text='<%# Eval("TotalQuestions") %>'></asp:Label> Qs</strong></span>
                            </div>
                        </div>
                        <div>
                            <asp:Label ID="litPlayBtn" runat="server" Text='<%# GetQuizPlayBtn(Eval("AssignmentId"), Eval("QuizId"), Eval("QuizTitle"), Eval("DurationMinutes"), Eval("PassingScore"), Eval("Status")) %>'></asp:Label>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
            <asp:PlaceHolder ID="pnlNoQuizzes" runat="server" Visible="false">
                <div  class="stask-u14">
                    <div  class="stask-u15">
                        <i class="fa-solid fa-clipboard-question"></i>
                    </div>
                    <h3  class="stask-u16">No Quizzes Assigned Yet</h3>
                    <p  class="stask-u17">When your internship company assigns an assessment quiz challenge, it will appear here!</p>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
    <!-- Hidden fields for submitting Quiz Score back to ASP.NET -->
    <asp:HiddenField ID="hfQuizAssignmentId" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfQuizScore" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfQuizCorrectCount" ClientIDMode="Static" runat="server" />
    <asp:HiddenField ID="hfQuizTotalQuestions" ClientIDMode="Static" runat="server" />
    <asp:Button ID="btnHiddenSubmitQuiz" ClientIDMode="Static" runat="server"  OnClick="btnHiddenSubmitQuiz_Click"  CssClass="stask-u18" />
    <!-- FULLSCREEN QUIZ ARENA MODAL -->
    <div id="quizArenaOverlay">
        <div class="arena-modal-card">
            <canvas id="confettiCanvas"></canvas>
            <!-- Header -->
            <div class="arena-header">
                <div  class="stask-u19">
                    <div class="arena-mascot" id="arenaAvatar"><i class="fa-solid fa-graduation-cap"></i></div>
                    <div>
                        <h3 id="modalQuizTitle"  class="stask-u20">Quiz Assessment</h3>
                        <div id="modalQuizSubtitle"  class="stask-u21">Technical Skills Assessment</div>
                    </div>
                </div>
                <div  class="stask-u22">
                    <div class="arena-timer-pill">
                        <i class="fa-solid fa-stopwatch"></i>
                        <span id="arenaTimer">10:00</span>
                    </div>
                    <button type="button" onclick="closeQuizArena();"  class="stask-u23">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                </div>
            </div>
            <!-- Quiz Play Screen -->
            <div id="arenaPlayScreen" class="arena-body">
                <!-- Lifelines Bar -->
                <div class="lifelines-bar">
                    <div  class="stask-u24">
                        <button type="button" id="btn5050" class="btn-lifeline" onclick="use5050Lifeline();" >
                            <i class="fa-solid fa-bolt stask-u25" ></i> 50:50
                        </button>
                        <button type="button" id="btnHint" class="btn-lifeline" onclick="useHintLifeline();" >
                            <i class="fa-solid fa-lightbulb stask-u26" ></i> Hint
                        </button>
                    </div>
                    <div  class="stask-u27">
                        <button type="button" id="btnSoundToggle" class="btn-lifeline" onclick="toggleSound();" >
                            <i class="fa-solid fa-volume-high"></i> Sound: ON
                        </button>
                    </div>
                </div>
                <!-- Live Score & Tracker -->
                <div  class="stask-u28">
                    <span id="arenaQTracker">Question 1 of 5</span>
                    <span id="arenaScoreLive"  class="stask-u29">0 Points</span>
                </div>
                <div class="arena-progress-wrap">
                    <div id="arenaProgressBar" class="arena-progress-bar"></div>
                </div>
                <!-- Praise Bubble Toast -->
                <div id="praiseBubble">Correct Answer!</div>
                <div id="arenaQuestionText" class="arena-question-text">Loading question...</div>
                <div id="arenaHintBox"  class="stask-u30">
                    <i class="fa-solid fa-lightbulb stask-u26" ></i> <strong>Hint:</strong> <span id="arenaHintText">Here is a hint</span>
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
                        <i class="fa-solid fa-fire stask-u31" ></i> <span>Streak: 0</span>
                    </div>
                    <button type="button" id="btnNextQuestion" class="btn-next-q stask-u32" onclick="nextQuestion();" >
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
                <h2 id="resTitle"  class="stask-u33">Assessment Completed</h2>
                <p id="resDesc"  class="stask-u34">
                    Your quiz assessment results are ready to be submitted to the company.
                </p>
                <div  class="stask-u35">
                    <div><span  class="stask-u36">Correct:</span> <strong id="resCorrectCount"  class="stask-u37">5 / 5</strong></div>
                    <div><span  class="stask-u36">Status:</span> <strong id="resStatusBadge"  class="stask-u25">PASSED</strong></div>
                </div>
                <div>
                    <button type="button" class="btn-play-arena stask-u38" onclick="finalizeQuizSubmission();" >
                        <i class="fa-solid fa-cloud-arrow-up"></i> Submit Score to Company
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- Web Audio Sound Engine & Child-Friendly Game Controller -->
    </asp:Content>
<asp:Content ID="ScriptContent_stask" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="../js/student-tasks.js"></script>
</asp:Content>

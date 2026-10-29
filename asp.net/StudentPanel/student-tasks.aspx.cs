using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace asp.net
{
    public partial class student_tasks : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    bindStudentQuizzes();
                    loadStats();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void loadStats()
        {
            getcon();

            string student = Session["student"].ToString();
            string filter = " WHERE sqa.ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + student + "') OR sqa.StudentId=(SELECT StudentId FROM Students WHERE Email='" + student + "' OR EnrollmentNo='" + student + "')";

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentQuizAssignments sqa" + filter, con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalQuizzes.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentQuizAssignments sqa" + filter + " AND sqa.Status='Passed'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblPassedQuizzes.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentQuizAssignments sqa" + filter + " AND (sqa.Status IS NULL OR sqa.Status='Assigned' OR sqa.Status='InProgress')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalTasks.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentQuizAssignments sqa" + filter + " AND sqa.Status='Passed'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblCompletedTasks.Text = ds.Tables[0].Rows[0][0].ToString();
        }

        void bindStudentQuizzes()
        {
            getcon();
            string student = Session["student"].ToString();
            da = new SqlDataAdapter("SELECT sqa.*, q.QuizTitle, q.Topic, q.DurationMinutes, q.PassingScore, ISNULL(c.c_company, 'Internship Partner') AS CompanyName, ISNULL(i.InternshipTitle, 'Internship') AS InternshipTitle FROM StudentQuizAssignments sqa INNER JOIN CompanyQuizzes q ON sqa.QuizId=q.QuizId LEFT JOIN c_registration c ON sqa.CompanyId=c.CompanyId LEFT JOIN StudentApplications a ON sqa.ApplicationId=a.ApplicationId LEFT JOIN internship i ON a.InternshipId=i.Id WHERE sqa.ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + student + "') OR sqa.StudentId=(SELECT StudentId FROM Students WHERE Email='" + student + "' OR EnrollmentNo='" + student + "') ORDER BY sqa.AssignmentId DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                rptStudentQuizzes.DataSource = ds;
                rptStudentQuizzes.DataBind();

                rptStudentQuizzes.Visible = true;
                pnlNoQuizzes.Visible = false;
            }
            else
            {
                rptStudentQuizzes.Visible = false;
                pnlNoQuizzes.Visible = true;
            }
        }

        protected void btnHiddenSubmitQuiz_Click(object sender, EventArgs e)
        {
            int assignmentId = Convert.ToInt32(hfQuizAssignmentId.Value);
            int score = Convert.ToInt32(hfQuizScore.Value);
            int correctCount = Convert.ToInt32(hfQuizCorrectCount.Value);
            int totalQuestions = Convert.ToInt32(hfQuizTotalQuestions.Value);

            getcon();

            da = new SqlDataAdapter("SELECT q.PassingScore FROM StudentQuizAssignments sqa " + "INNER JOIN CompanyQuizzes q ON sqa.QuizId=q.QuizId " + " WHERE sqa.AssignmentId=" + assignmentId, con);

            ds = new DataSet();
            da.Fill(ds);

            int passingScore = Convert.ToInt32(ds.Tables[0].Rows[0]["PassingScore"]);

            string status;

            if (score >= passingScore)
                status = "Passed";
            else
                status = "Failed";

            cmd = new SqlCommand( "UPDATE StudentQuizAssignments SET Score=" + score + ", CorrectCount=" + correctCount + ", TotalQuestions=" + totalQuestions + ", Status='" + status + "', CompletedDate=GETDATE() WHERE AssignmentId=" + assignmentId, con);
            cmd.ExecuteNonQuery();

            if (status == "Passed")
            {
                lblMsg.CssClass = "task-alert-msg task-alert-success";
                lblMsg.Text = "<i class='fa-solid fa-circle-check'></i> Congratulations! You passed the quiz with a score of " + score + "%!";
            }
            else
            {
                lblMsg.CssClass = "task-alert-msg task-alert-info";
                lblMsg.Text = "<i class='fa-solid fa-circle-info'></i> Quiz Completed. Your score is " + score + "% (Passing score is " + passingScore + "%).";
            }

            lblMsg.Visible = true;

            bindStudentQuizzes();
            loadStats();
        }

        [System.Web.Services.WebMethod]
        public static object GetQuizQuestions(int quizId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;
            using (SqlConnection c = new SqlConnection(connStr))
            {
                c.Open();
                using (SqlDataAdapter a = new SqlDataAdapter("SELECT QuestionId, QuizId, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectOption FROM QuizQuestions WHERE QuizId = " + quizId + " ORDER BY QuestionId ASC", c))
                {
                    DataTable dt = new DataTable();
                    a.Fill(dt);
                    var list = new System.Collections.Generic.List<object>();
                    foreach (DataRow row in dt.Rows)
                    {
                        list.Add(new
                        {
                            QuestionId = row["QuestionId"],
                            QuizId = row["QuizId"],
                            QuestionText = row["QuestionText"] != null ? row["QuestionText"].ToString() : "",
                            OptionA = row["OptionA"] != null ? row["OptionA"].ToString() : "",
                            OptionB = row["OptionB"] != null ? row["OptionB"].ToString() : "",
                            OptionC = row["OptionC"] != null ? row["OptionC"].ToString() : "",
                            OptionD = row["OptionD"] != null ? row["OptionD"].ToString() : "",
                            CorrectOption = row["CorrectOption"] != null ? row["CorrectOption"].ToString().Trim() : "",
                            Hint = "Think carefully about the core concepts of this topic.",
                            FunFact = "Great learning opportunity!"
                        });
                    }
                    return list;
                }
            }
        }

        public string GetQuizStatusBadge(object statusObj, object scoreObj)
        {
            string status = statusObj != null ? statusObj.ToString().Trim() : "Assigned";
            string score = scoreObj != null ? scoreObj.ToString().Trim() : "0";

            if (status == "Passed")
                return "<span class='quiz-badge badge-passed'><i class='fa-solid fa-circle-check'></i> Passed (" + score + "%)</span>";

            if (status == "Failed")
                return "<span class='quiz-badge badge-failed'><i class='fa-solid fa-circle-xmark'></i> Failed (" + score + "%)</span>";

            if (status == "InProgress")
                return "<span class='quiz-badge badge-in-progress'><i class='fa-solid fa-spinner fa-spin'></i> In Progress</span>";

            return "<span class='quiz-badge badge-ready'><i class='fa-solid fa-gamepad'></i> Ready to Play</span>";
        }

        public string GetQuizPlayBtn(object assignmentId, object quizId,
            object quizTitle, object duration, object passingScore, object status)
        {
            string cleanTitle = quizTitle != null ? quizTitle.ToString().Replace("'", "\\'") : "Quiz Challenge";
            int dur = duration != null && int.TryParse(duration.ToString(), out int d) ? d : 10;
            int pass = passingScore != null && int.TryParse(passingScore.ToString(), out int p) ? p : 60;
            string st = status != null ? status.ToString().Trim() : "Assigned";

            if (st == "Passed")
            {
                return string.Format("<button type='button' class='btn-play-arena btn-arena-passed' onclick=\"openQuizArena({0}, {1}, '{2}', {3}, {4});\"><i class='fa-solid fa-rotate-right'></i> Replay Game</button>",
                    assignmentId, quizId, cleanTitle, dur, pass);
            }

            if (st == "Failed")
            {
                return string.Format("<button type='button' class='btn-play-arena btn-arena-retry' onclick=\"openQuizArena({0}, {1}, '{2}', {3}, {4});\"><i class='fa-solid fa-rotate-right'></i> Retry Challenge</button>",
                    assignmentId, quizId, cleanTitle, dur, pass);
            }

            return string.Format("<button type='button' class='btn-play-arena' onclick=\"openQuizArena({0}, {1}, '{2}', {3}, {4});\"><i class='fa-solid fa-gamepad'></i> Play Quiz</button>",
                assignmentId, quizId, cleanTitle, dur, pass);
        }
    }
}
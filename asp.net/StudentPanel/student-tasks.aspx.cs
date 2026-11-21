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
                    totalAssigned();
                    totalPassedQuizes();
                    totalTasks();
                    totalComplatedTasks();
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

        void totalAssigned() {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentQuizAssignments sqa WHERE sqa.ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR sqa.StudentId=(SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalQuizzes.Text = i.ToString();
        }

        void totalPassedQuizes() {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentQuizAssignments sqa WHERE sqa.ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR sqa.StudentId=(SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "' AND sqa.Status='Passed')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblPassedQuizzes.Text = i.ToString();
        }

        void totalTasks()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentQuizAssignments sqa WHERE sqa.ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR sqa.StudentId=(SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "' AND (sqa.Status IS NULL OR sqa.Status='Assigned' OR sqa.Status='InProgress')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalTasks.Text = i.ToString();
        }

        void totalComplatedTasks()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentQuizAssignments sqa WHERE sqa.ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR sqa.StudentId=(SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "' AND sqa.Status='Passed')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblCompletedTasks.Text = i.ToString();
        }

        void bindStudentQuizzes()
        {
            getcon();
            da = new SqlDataAdapter("SELECT sqa.*, q.QuizTitle, q.Topic, q.DurationMinutes, q.PassingScore, ISNULL(c.c_company, 'Internship Partner') AS CompanyName, ISNULL(i.InternshipTitle, 'Internship') AS InternshipTitle FROM StudentQuizAssignments sqa INNER JOIN CompanyQuizzes q ON sqa.QuizId=q.QuizId LEFT JOIN c_registration c ON sqa.CompanyId=c.CompanyId LEFT JOIN StudentApplications a ON sqa.ApplicationId=a.ApplicationId LEFT JOIN internship i ON a.InternshipId=i.Id WHERE sqa.ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR sqa.StudentId=(SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "') ORDER BY sqa.AssignmentId DESC", con);
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
            {
                status = "Passed";
            }
            else
            {
                status = "Failed";
            }

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
            totalAssigned();
            totalPassedQuizes();
            totalTasks();
            totalComplatedTasks();

        }

        [System.Web.Services.WebMethod]
        public static object GetQuizQuestions(int quizId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString))
            {
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM QuizQuestions WHERE QuizId = " + quizId + " ORDER BY QuestionId ASC", con);
                da.Fill(dt);

                var list = new System.Collections.Generic.List<object>();

                foreach (DataRow row in dt.Rows)
                {
                    list.Add(new
                    {
                        QuestionId = row["QuestionId"],
                        QuizId = row["QuizId"],
                        QuestionText = row["QuestionText"].ToString(),
                        OptionA = row["OptionA"].ToString(),
                        OptionB = row["OptionB"].ToString(),
                        OptionC = row["OptionC"].ToString(),
                        OptionD = row["OptionD"].ToString(),
                        CorrectOption = row["CorrectOption"].ToString(),
                        Hint = "Think carefully about the core concepts of this topic.",
                        FunFact = "Great learning opportunity!"
                    });
                }
                return list;
            }
        }

        public string GetQuizStatusBadge(object statusObj, object scoreObj)
        {
            string status = Convert.ToString(statusObj);
            string score = Convert.ToString(scoreObj);

            if (status == "Passed")
            {
                return "<span class='quiz-badge badge-passed'><i class='fa-solid fa-circle-check'></i> Passed (" + score + "%)</span>";
            }
            if (status == "Failed")
            {
                return "<span class='quiz-badge badge-failed'><i class='fa-solid fa-circle-xmark'></i> Failed (" + score + "%)</span>";
            }
            if (status == "InProgress")
            {
                return "<span class='quiz-badge badge-in-progress'><i class='fa-solid fa-spinner fa-spin'></i> In Progress</span>";
            }
            return "<span class='quiz-badge badge-ready'><i class='fa-solid fa-gamepad'></i> Ready to Play</span>";
        }

        public string GetQuizPlayBtn(object assignmentId, object quizId, object quizTitle, object duration, object passingScore, object status)
        {
            string btn = "Play Quiz";
            string css = "btn-play-arena";
            string icon = "fa-gamepad";

            if (Convert.ToString(status) == "Passed")
            {
                btn = "Replay Game";
                css += " btn-arena-passed";
                icon = "fa-rotate-right";
            }
            else if (Convert.ToString(status) == "Failed")
            {
                btn = "Retry Challenge";
                css += " btn-arena-retry";
                icon = "fa-rotate-right";
            }

            return "<button type='button' class='" + css + "' onclick=\"openQuizArena(" + assignmentId + ", " + quizId + ", '" + quizTitle + "', " + duration + ", " + passingScore + ");\"><i class='fa-solid " + icon + "'></i> " + btn + "</button>";
        }
    }
}

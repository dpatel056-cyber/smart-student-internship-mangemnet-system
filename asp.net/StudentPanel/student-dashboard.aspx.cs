using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.DataVisualization.Charting;

namespace asp.net
{
    public partial class student_dashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        public int totalSelected = 0;
        public int totalPending = 0;
        public int totalRejected = 0;
        public int intScheduled = 0;
        public int intCancelled = 0;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

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
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        litWelcomeName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                    }

                    LoadRecentApplications();
                    loadApplicationChart();
                    loadInterviewChart();
                    TotalApplications();
                    TotalPendingReview();
                    TotalShortlist();
                    TotalSelected();
                    TotalInterview();
                    TotalOfferLetter();
                    TotalTasks();
                    TotalSavedInternships();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void loadApplicationChart()
        {
            getcon();
            da = new SqlDataAdapter("SELECT CASE WHEN Status IS NULL OR Status='' THEN 'Pending' ELSE Status END AS Status, COUNT(*) AS Total FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "') GROUP BY CASE WHEN Status IS NULL OR Status='' THEN 'Pending' ELSE Status END", con);
            ds = new DataSet();
            da.Fill(ds);

            studentApplicationPieChart.DataSource = ds.Tables[0];
            studentApplicationPieChart.DataBind();

            foreach (DataPoint p in studentApplicationPieChart.Series["Applications"].Points)
            {
                p.LegendText = p.AxisLabel + " (" + p.YValues[0] + ")";

                p.Color = p.AxisLabel == "Selected" ? Color.Green :
                          p.AxisLabel == "Shortlisted" ? Color.Blue :
                          p.AxisLabel == "Rejected" ? Color.Red : Color.Orange;
            }
        }

        void loadInterviewChart()
        {
            getcon();
            da = new SqlDataAdapter("SELECT CASE WHEN Status IS NULL OR Status='' THEN 'Scheduled' ELSE Status END AS Status, COUNT(*) AS Total FROM CompanyInterviews WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')) GROUP BY CASE WHEN Status IS NULL OR Status='' THEN 'Scheduled' ELSE Status END", con);
            ds = new DataSet();
            da.Fill(ds);

            studentInterviewBarChart.DataSource = ds.Tables[0];
            studentInterviewBarChart.DataBind();

            foreach (DataPoint p in studentInterviewBarChart.Series["Interviews"].Points)
            {
                p.Color = p.AxisLabel == "Scheduled" ? Color.Blue :
                          p.AxisLabel == "Completed" ? Color.Green :
                          p.AxisLabel == "Cancelled" ? Color.Red : Color.Purple;

                p.IsValueShownAsLabel = p.YValues[0] > 0;
            }

            studentInterviewBarChart.ChartAreas["InterviewArea"].AxisY.Interval = 1;
        }

        void TotalApplications()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalApplied.Text = i.ToString();
        }

        void TotalPendingReview()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE(Status = 'Applied' OR Status = 'Under Review' OR Status = 'Pending') AND(StudentEmail = '" + Session["student"].ToString() + "' OR StudentId IN(SELECT StudentId FROM Students WHERE Email = '" + Session["student"].ToString() + "' OR EnrollmentNo = '" + Session["student"].ToString() + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblPendingCount.Text = i.ToString();
        }

        void TotalShortlist()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE Status='Shortlisted' AND (StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblShortlistedCount.Text = i.ToString();
        }

        void TotalSelected()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE (Status='Selected' OR Status='Offer Accepted' OR Status='Accepted') AND (StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblSelectedCount.Text = i.ToString();
        }

        void TotalInterview()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyInterviews WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblInterviewsCount.Text = i.ToString();
        }

        void TotalOfferLetter()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyOfferLetters WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblOffersCount.Text = i.ToString();
        }

        void TotalTasks()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentQuizAssignments WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTasksCount.Text = i.ToString();
        }

        void TotalSavedInternships()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentSavedInternships WHERE StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblSavedCount.Text = i.ToString();
        }

        void LoadRecentApplications()
        {
            getcon();
            da = new SqlDataAdapter("SELECT TOP 5 sa.ApplicationId, sa.InternshipId, sa.Status, sa.AppliedDate, i.InternshipTitle, i.Location, i.WorkMode, i.StipendAmount, c.c_company, c.c_logo FROM StudentApplications sa INNER JOIN internship i ON sa.InternshipId = i.Id INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE sa.StudentEmail='" + Session["student"].ToString() + "' OR sa.StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "') ORDER BY sa.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvRecentApps.DataSource = ds;
                gvRecentApps.DataBind();
                gvRecentApps.Visible = true;
                pnlNoApps.Visible = false;
            }
            else
            {
                gvRecentApps.Visible = false;
                pnlNoApps.Visible = true;
            }
        }

        public string GetStatusBadge(object status)
        {
            string st = "Applied";

            if (status != null && status != DBNull.Value)
            {
                st = status.ToString();
            }

            if (st == "Selected" || st == "Accepted" || st == "Offer Accepted")
            {
                return "<span class='badge-status-chip st-selected'><i class='fa-solid fa-circle-check'></i> Selected</span>";
            }
            else if (st == "Shortlisted")
            {
                return "<span class='badge-status-chip st-shortlisted'><i class='fa-solid fa-star'></i> Shortlisted</span>";
            }
            else if (st == "Rejected")
            {
                return "<span class='badge-status-chip st-rejected'><i class='fa-solid fa-circle-xmark'></i> Rejected</span>";
            }
            else if (st == "Completed")
            {
                return "<span class='badge-status-chip st-completed'><i class='fa-solid fa-award'></i> Completed</span>";
            }
            else if (st == "Pending" || st == "Under Review")
            {
                return "<span class='badge-status-chip st-pending'><i class='fa-solid fa-clock'></i> " + st + "</span>";
            }
            else
            {
                return "<span class='badge-status-chip st-applied'><i class='fa-solid fa-paper-plane'></i> " + st + "</span>";
            }
        }
    }
}

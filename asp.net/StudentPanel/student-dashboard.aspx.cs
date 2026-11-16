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
                con.Close();

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
            con.Close();

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
            con.Close();

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
            con.Close();
        }

        void TotalPendingReview()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE(Status = 'Applied' OR Status = 'Under Review' OR Status = 'Pending') AND(StudentEmail = '" + Session["student"].ToString() + "' OR StudentId IN(SELECT StudentId FROM Students WHERE Email = '" + Session["student"].ToString() + "' OR EnrollmentNo = '" + Session["student"].ToString() + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblPendingCount.Text = i.ToString();
            con.Close();
        }

        void TotalShortlist()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE Status='Shortlisted' AND (StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblShortlistedCount.Text = i.ToString();
            con.Close();
        }

        void TotalSelected()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE (Status='Selected' OR Status='Offer Accepted' OR Status='Accepted') AND (StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblSelectedCount.Text = i.ToString();
            con.Close();
        }

        void TotalInterview()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyInterviews WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblInterviewsCount.Text = i.ToString();
            con.Close();
        }

        void TotalOfferLetter()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyOfferLetters WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblOffersCount.Text = i.ToString();
            con.Close();
        }

        void TotalTasks()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentQuizAssignments WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTasksCount.Text = i.ToString();
            con.Close();
        }

        void TotalSavedInternships()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentSavedInternships WHERE StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblSavedCount.Text = i.ToString();
            con.Close();
        }

        void LoadRecentApplications()
        {
            getcon();
            da = new SqlDataAdapter("SELECT TOP 5 sa.ApplicationId, sa.InternshipId, sa.Status, sa.AppliedDate, i.InternshipTitle, i.Location, i.WorkMode, i.StipendAmount, c.c_company, c.c_logo FROM StudentApplications sa INNER JOIN internship i ON sa.InternshipId = i.Id INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE sa.StudentEmail='" + Session["student"].ToString() + "' OR sa.StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "') ORDER BY sa.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

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
            if (status == null || status == DBNull.Value)
                status = "Applied";

            string st = status.ToString().Trim();

            if (st.Equals("Selected", StringComparison.OrdinalIgnoreCase) ||
                st.Equals("Accepted", StringComparison.OrdinalIgnoreCase) ||
                st.Equals("Offer Accepted", StringComparison.OrdinalIgnoreCase))
            {
                return "<span class='badge-status-chip st-selected' style='display:inline-flex; align-items:center; gap:5px; padding:4px 10px; border-radius:20px; font-size:11.5px; font-weight:700; background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; white-space:nowrap;'><i class='fa-solid fa-circle-check' style='color:#16a34a;'></i> Selected</span>";
            }

            if (st.Equals("Shortlisted", StringComparison.OrdinalIgnoreCase))
            {
                return "<span class='badge-status-chip st-shortlisted' style='display:inline-flex; align-items:center; gap:5px; padding:4px 10px; border-radius:20px; font-size:11.5px; font-weight:700; background:#ede9fe; color:#6d28d9; border:1px solid #ddd6fe; white-space:nowrap;'><i class='fa-solid fa-star' style='color:#7c3aed;'></i> Shortlisted</span>";
            }

            if (st.Equals("Rejected", StringComparison.OrdinalIgnoreCase))
            {
                return "<span class='badge-status-chip st-rejected' style='display:inline-flex; align-items:center; gap:5px; padding:4px 10px; border-radius:20px; font-size:11.5px; font-weight:700; background:#fee2e2; color:#b91c1c; border:1px solid #fecaca; white-space:nowrap;'><i class='fa-solid fa-circle-xmark' style='color:#dc2626;'></i> Rejected</span>";
            }

            if (st.Equals("Completed", StringComparison.OrdinalIgnoreCase))
            {
                return "<span class='badge-status-chip st-completed' style='display:inline-flex; align-items:center; gap:5px; padding:4px 10px; border-radius:20px; font-size:11.5px; font-weight:700; background:#ecfeff; color:#0891b2; border:1px solid #a5f3fc; white-space:nowrap;'><i class='fa-solid fa-award' style='color:#0891b2;'></i> Completed</span>";
            }

            if (st.Equals("Pending", StringComparison.OrdinalIgnoreCase) ||
                st.Equals("Under Review", StringComparison.OrdinalIgnoreCase))
            {
                return "<span class='badge-status-chip st-pending' style='display:inline-flex; align-items:center; gap:5px; padding:4px 10px; border-radius:20px; font-size:11.5px; font-weight:700; background:#fef3c7; color:#b45309; border:1px solid #fde68a; white-space:nowrap;'><i class='fa-solid fa-clock' style='color:#d97706;'></i> " + st + "</span>";
            }

            return "<span class='badge-status-chip st-applied' style='display:inline-flex; align-items:center; gap:5px; padding:4px 10px; border-radius:20px; font-size:11.5px; font-weight:700; background:#eff6ff; color:#2563eb; border:1px solid #bfdbfe; white-space:nowrap;'><i class='fa-solid fa-paper-plane' style='color:#2563eb;'></i> " + st + "</span>";
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_interviews : System.Web.UI.Page
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
                   LoadInterviews();
                   TotalInterviews();
                   ScheduledInterviews();
                   CompletedInterviews();
                   InterviewCompanies();
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

        void LoadInterviews()
        {
            getcon();

            da = new SqlDataAdapter("select civ.InterviewId, civ.ApplicationId, civ.InternshipId, civ.StudentId, civ.CompanyId, ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 120), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 23), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate), civ.CreatedDate))) as InterviewDate, civ.InterviewTime, civ.InterviewType, civ.MeetingLink, civ.Location, civ.Notes, civ.Status, civ.CreatedDate, ISNULL(i.InternshipTitle,'Internship Interview') as InternshipTitle, ISNULL(i.Location,'Headquarters') as InternshipLocation, ISNULL(i.WorkMode,'Full Time') as WorkMode, c.c_company, c.c_logo, c.c_location, c.c_email as CompEmail from CompanyInterviews civ inner join StudentApplications sa on civ.ApplicationId=sa.ApplicationId inner join internship i on civ.InternshipId=i.Id inner join c_registration c on civ.CompanyId=c.CompanyId where sa.StudentEmail='" + Session["student"] + "' order by civ.InterviewId desc", con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                dlInterviews.DataSource = ds;
                dlInterviews.DataBind();

                dlInterviews.Visible = true;
                pnlNoInterviews.Visible = false;
            }
            else
            {
                dlInterviews.Visible = false;
                pnlNoInterviews.Visible = true;
            }
        }

        void TotalInterviews()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyInterviews WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalInterviews.Text = i.ToString();
        }

        void ScheduledInterviews()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyInterviews WHERE (Status IS NULL OR Status='' OR Status='Scheduled') AND (ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblScheduledCount.Text = i.ToString();
        }

        void CompletedInterviews()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyInterviews WHERE Status='Completed' AND (ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblCompletedCount.Text = i.ToString();
        }

        void InterviewCompanies()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(DISTINCT CompanyId) FROM CompanyInterviews WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"].ToString() + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblCompanyCount.Text = i.ToString();
        }

        public string FormatMeetingBtn(object linkObj, object locObj, object typeObj)
        {
            string value = linkObj.ToString();

            if (value == "")
                value = locObj.ToString();

            if (value.StartsWith("http://") || value.StartsWith("https://"))
                return "<a href='" + value + "' target='_blank' class='btn-join-meeting-full'><i class='fa-solid fa-video'></i> Join Virtual Interview</a>";

            if (value != "")
                return "<div class='btn-offline-badge'><i class='fa-solid fa-location-dot'></i> " + value + "</div>";

            return "<div class='btn-offline-badge'><i class='fa-solid fa-circle-info'></i> " + typeObj.ToString() + "</div>";
        }

        public string GetStatusBadge(object statusObj)
        {
            string status = statusObj.ToString();

            if (status == "Completed")
                return "<span class='interview-status-badge status-completed'><i class='fa-solid fa-circle-check'></i> Completed</span>";

            if (status == "Cancelled")
                return "<span class='interview-status-badge status-cancelled'><i class='fa-solid fa-circle-xmark'></i> Cancelled</span>";

            return "<span class='interview-status-badge status-scheduled'><i class='fa-solid fa-calendar-check'></i> Scheduled</span>";
        }

    }
}

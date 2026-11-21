using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace asp.net
{
    public partial class student_my_applications : System.Web.UI.Page
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
                    if (Request.QueryString["applied"] == "1")
                    {
                        pnlSuccessMsg.Visible = true;
                    }
                    LoadApplications();
                    TotalApplications();
                    TotalPendingReview();
                    TotalShortlist();
                    TotalSelected();
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

        void LoadApplications()
        {
            getcon();

            da = new SqlDataAdapter("select sa.ApplicationId, sa.InternshipId, sa.Status, sa.AppliedDate, i.InternshipTitle, i.InternshipDomain, i.WorkMode, i.Location, i.StipendAmount, i.Duration, c.c_company, c.c_logo from StudentApplications sa inner join internship i on sa.InternshipId=i.Id inner join c_registration c on i.CompanyId=c.CompanyId where sa.StudentEmail='" + Session["student"] + "' or sa.StudentId in (select StudentId from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "') order by sa.ApplicationId desc", con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvApplications.DataSource = ds;
                gvApplications.DataBind();

                gvApplications.Visible = true;
                pnlNoApps.Visible = false;
            }
            else
            {
                gvApplications.Visible = false;
                pnlNoApps.Visible = true;
            }
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
            lblUnderReview.Text = i.ToString();
        }

        void TotalShortlist()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE Status='Shortlisted' AND (StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblShortlisted.Text = i.ToString();
        }

        void TotalSelected()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE (Status='Selected' OR Status='Offer Accepted' OR Status='Accepted') AND (StudentEmail='" + Session["student"].ToString() + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"].ToString() + "' OR EnrollmentNo='" + Session["student"].ToString() + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblSelected.Text = i.ToString();
        }

        public string GetStatusBadge(object statusObj)
        {
            string status = "Applied";

            if (statusObj != null && statusObj != DBNull.Value)
                status = statusObj.ToString();

            if (status == "Under Review")
                return "<span class='badge-status status-under-review'><i class='fa-solid fa-clock-rotate-left'></i> Under Review</span>";

            if (status == "Shortlisted")
                return "<span class='badge-status status-shortlisted'><i class='fa-solid fa-user-check'></i> Shortlisted</span>";

            if (status == "Selected" || status == "Accepted" || status == "Offer Accepted")
                return "<span class='badge-status status-selected'><i class='fa-solid fa-circle-check'></i> Offer Accepted</span>";

            if (status == "Rejected")
                return "<span class='badge-status status-rejected'><i class='fa-solid fa-circle-xmark'></i> Rejected</span>";

            return "<span class='badge-status status-applied'><i class='fa-solid fa-paper-plane'></i> Applied</span>";
        }

    }
}

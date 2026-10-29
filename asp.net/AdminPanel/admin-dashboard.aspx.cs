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
    public partial class admin_dashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from admin_registration where Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (!IsPostBack)
                {
                    totalstudents();
                    totalcompanies();
                    totalinternships();
                    totalapplications();
                    pendingapplications();
                    upcominginterviews();
                    certificatesissued();
                    totalfeedback();
                    shortlistedapplications();
                    selectedapplications();
                    rejectedapplications();
                    loadRecentApplications();
                    loadApplicationChart();
                    loadRecentCompanies();
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

            da = new SqlDataAdapter("SELECT Status, COUNT(*) AS Total FROM StudentApplications WHERE Status IS NOT NULL AND Status != '' AND Status != 'Completed' GROUP BY Status", con);
            ds = new DataSet();
            da.Fill(ds);

            adminApplicationPieChart.DataSource = ds.Tables[0];
            adminApplicationPieChart.DataBind();

            foreach (DataPoint p in adminApplicationPieChart.Series["Applications"].Points)
            {
                p.LegendText = p.AxisLabel + " (" + p.YValues[0] + ")";

                p.Color = p.AxisLabel == "Selected" ? Color.Green :
                          p.AxisLabel == "Shortlisted" ? Color.Blue :
                          p.AxisLabel == "Rejected" ? Color.Red : Color.Orange;
            }
        }

        void totalstudents()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from Students", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalStudents.Text = i.ToString();
        }

        void totalcompanies()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from c_registration", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalCompanies.Text = i.ToString();
        }

        void totalinternships()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from internship", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalInternships.Text = i.ToString();
        }

        void totalapplications()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalApplications.Text = i.ToString();
        }

        void pendingapplications()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications where Status='Pending' or Status='Applied' or Status='Interview Scheduled' or Status is null", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblPendingApps.Text = i.ToString();
            lblStatusPending.Text = i.ToString();
        }

        void upcominginterviews()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from CompanyInterviews where Status!='Cancelled'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblUpcomingInterviews.Text = i.ToString();
        }

        void certificatesissued()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from CompanyCertificates", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblCertificatesIssued.Text = i.ToString();
        }

        void totalfeedback()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from cont", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalFeedback.Text = i.ToString();
        }

        void shortlistedapplications()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications where Status='Shortlisted'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblStatusShortlisted.Text = i.ToString();
        }

        void selectedapplications()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications where Status='Selected'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblStatusSelected.Text = i.ToString();
        }

        void rejectedapplications()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications where Status='Rejected'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblStatusRejected.Text = i.ToString();
        }

        void loadRecentApplications()
        {
            getcon();
            da = new SqlDataAdapter("SELECT TOP 5 a.*, i.InternshipTitle, ISNULL(c.c_company, 'N/A') AS c_company, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/images/default-avatar.png' END AS ProfilePhoto FROM StudentApplications a LEFT JOIN internship i ON a.InternshipId = i.Id LEFT JOIN c_registration c ON i.CompanyId = c.CompanyId LEFT JOIN Students s ON a.StudentId = s.StudentId ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            gvRecentApplications.DataSource = ds;
            gvRecentApplications.DataBind();
        }

        void loadRecentCompanies()
        {
            getcon();
            da = new SqlDataAdapter("SELECT TOP 4 CompanyId, c_company, c_industry, c_location, CASE WHEN c_logo LIKE '~/%' THEN c_logo WHEN c_logo IS NOT NULL AND c_logo <> '' THEN '~/compnay_images/' + c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo FROM c_registration ORDER BY CompanyId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            gvRecentCompanies.DataSource = ds;
            gvRecentCompanies.DataBind();
        }

        public string GetStatusBadge(string status)
        {
            if (status == "Shortlisted")
                return "<span class='status-shortlisted'>Shortlisted</span>";
            if (status == "Selected")
                return "<span class='status-selected'>Selected</span>";
            if (status == "Rejected")
                return "<span class='status-rejected'>Rejected</span>";
            return "<span class='status-pending'>Pending</span>";
        }
    }
}

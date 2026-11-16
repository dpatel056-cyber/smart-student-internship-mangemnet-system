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
    public partial class Companydashboard : System.Web.UI.Page
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
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    loadApplicationChart();
                    loadInterviewChart();
                    totalinternships();
                    activeinternships();
                    totalapplications();
                    shortlistedapplications();
                    selectedapplications();
                    rejectedapplications();
                    upcominginterviews();
                    totaloffers();
                    bindRecentApps();
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
            da = new SqlDataAdapter("SELECT CASE WHEN Status IS NULL OR Status='' THEN 'Pending' ELSE Status END AS Status, COUNT(*) AS Total FROM StudentApplications WHERE InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"] + "')) GROUP BY CASE WHEN Status IS NULL OR Status='' THEN 'Pending' ELSE Status END", con);
            ds = new DataSet();
            da.Fill(ds);
            companyApplicationPieChart.DataSource = ds.Tables[0];
            companyApplicationPieChart.DataBind();

            foreach (DataPoint p in companyApplicationPieChart.Series["Applications"].Points)
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
            da = new SqlDataAdapter("SELECT Status, COUNT(*) AS Total FROM CompanyInterviews WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"] + "') GROUP BY Status", con);
            ds = new DataSet();
            da.Fill(ds);
            companyInterviewBarChart.DataSource = ds.Tables[0];
            companyInterviewBarChart.DataBind();

            foreach (DataPoint p in companyInterviewBarChart.Series["Interviews"].Points)
            {
                p.Color = p.AxisLabel == "Scheduled" ? Color.Blue :
                          p.AxisLabel == "Completed" ? Color.Green :
                          p.AxisLabel == "Cancelled" ? Color.Red : Color.Purple;

                p.IsValueShownAsLabel = p.YValues[0] > 0;
            }

            companyInterviewBarChart.ChartAreas["InterviewArea"].AxisY.Interval = 1;
        }

        void totalinternships()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from internship where CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalInternships.Text = i.ToString();
        }

        void activeinternships()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from internship where (Status is null or (Status != 'Inactive' and Status != 'Draft' and Status != 'Closed' and Status != 'Expired')) and CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblActiveInternships.Text = i.ToString();
        }

        void totalapplications()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications where InternshipId in (select Id from internship where CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalApplications.Text = i.ToString();
        }

        void shortlistedapplications()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications where Status='Shortlisted' and InternshipId in (select Id from internship where CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblShortlistedCount.Text = i.ToString();
        }

        void selectedapplications()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications where Status='Selected' and InternshipId in (select Id from internship where CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblSelectedCount.Text = i.ToString();
        }

        void rejectedapplications()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications where Status='Rejected' and InternshipId in (select Id from internship where CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblRejectedCount.Text = i.ToString();
        }

        void upcominginterviews()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from CompanyInterviews where CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "') and (Status='Scheduled' or Status is null)", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblInterviewsCount.Text = i.ToString();
        }

        void totaloffers()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from CompanyOfferLetters where CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblOffersCount.Text = i.ToString();
        }

        void bindRecentApps()
        {
            getcon();
            da = new SqlDataAdapter("SELECT TOP 5 a.*, i.InternshipTitle, s.ProfilePhoto FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id LEFT JOIN Students s ON a.StudentId = s.StudentId WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"] + "') ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvRecentApps.DataSource = ds.Tables[0];
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

        public string GetStatusBadge(object statusObj)
        {
            string st = Convert.ToString(statusObj);

            if (st == "Shortlisted")
                return "<span class='badge-status-chip st-shortlisted'>Shortlisted</span>";

            if (st == "Selected")
                return "<span class='badge-status-chip st-selected'>Selected</span>";

            if (st == "Rejected")
                return "<span class='badge-status-chip st-rejected'>Rejected</span>";

            return "<span class='badge-status-chip st-applied'>" + (st == "" ? "Applied" : st) + "</span>";
        }
    }
}

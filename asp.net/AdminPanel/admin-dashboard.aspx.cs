using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class admin_dashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        public int totalPending = 0;
        public int totalShortlisted = 0;
        public int totalSelected = 0;
        public int totalRejected = 0;

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
                    loadDashboardStats();
                    loadRecentApplications();
                    loadRecentCompanies();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void loadDashboardStats()
        {
            getcon();

            // 1. Students Count
            da = new SqlDataAdapter("SELECT COUNT(*) FROM Students", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalStudents.Text = ds.Tables[0].Rows[0][0].ToString();

            // 2. Companies Count
            da = new SqlDataAdapter("SELECT COUNT(*) FROM c_registration", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalCompanies.Text = ds.Tables[0].Rows[0][0].ToString();

            // 3. Internships Count
            da = new SqlDataAdapter("SELECT COUNT(*) FROM internship", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalInternships.Text = ds.Tables[0].Rows[0][0].ToString();

            // 4. Applications Count
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalApplications.Text = ds.Tables[0].Rows[0][0].ToString();

            // 5. Pending / In Progress Applications
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Pending' OR Status='Applied' OR Status='Interview Scheduled' OR Status IS NULL", con);
            ds = new DataSet();
            da.Fill(ds);
            lblPendingApps.Text = ds.Tables[0].Rows[0][0].ToString();
            lblStatusPending.Text = ds.Tables[0].Rows[0][0].ToString();

            // 6. Upcoming Interviews
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews WHERE Status!='Cancelled'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblUpcomingInterviews.Text = ds.Tables[0].Rows[0][0].ToString();

            // 7. Certificates Issued
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyCertificates", con);
            ds = new DataSet();
            da.Fill(ds);
            lblCertificatesIssued.Text = ds.Tables[0].Rows[0][0].ToString();

            // 8. Inquiries / Contact count
            da = new SqlDataAdapter("SELECT COUNT(*) FROM cont", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalFeedback.Text = ds.Tables[0].Rows[0][0].ToString();

            // Application Status
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Shortlisted'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblStatusShortlisted.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Selected'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblStatusSelected.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Rejected'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblStatusRejected.Text = ds.Tables[0].Rows[0][0].ToString();

            totalPending = Convert.ToInt32(lblStatusPending.Text);
            totalShortlisted = Convert.ToInt32(lblStatusShortlisted.Text);
            totalSelected = Convert.ToInt32(lblStatusSelected.Text);
            totalRejected = Convert.ToInt32(lblStatusRejected.Text);
        }

        void loadRecentApplications()
        {
            getcon();
            da = new SqlDataAdapter("SELECT TOP 5 a.*, i.InternshipTitle, ISNULL(c.c_company, 'N/A') AS c_company, s.ProfilePhoto FROM StudentApplications a LEFT JOIN internship i ON a.InternshipId = i.Id LEFT JOIN c_registration c ON i.CompanyId = c.CompanyId LEFT JOIN Students s ON a.StudentId = s.StudentId ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            gvRecentApplications.DataSource = ds;
            gvRecentApplications.DataBind();
        }
        void loadRecentCompanies()
        {
            getcon();
            da = new SqlDataAdapter("SELECT TOP 4 * FROM c_registration ORDER BY CompanyId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            gvRecentCompanies.DataSource = ds;
            gvRecentCompanies.DataBind();
        }
        //------------------------------------------------
        public string GetStatusBadge(object status)
        {
            if (status == null || status == DBNull.Value)
                return "<span class='status-pending'>Pending</span>";

            string st = status.ToString().Trim();

            if (string.Equals(st, "Shortlisted", StringComparison.OrdinalIgnoreCase))
                return "<span class='status-shortlisted'>Shortlisted</span>";

            if (string.Equals(st, "Selected", StringComparison.OrdinalIgnoreCase))
                return "<span class='status-selected'>Selected</span>";

            if (string.Equals(st, "Rejected", StringComparison.OrdinalIgnoreCase))
                return "<span class='status-rejected'>Rejected</span>";

            return "<span class='status-pending'>Pending</span>";
        }

        public string GetCompanyLogoUrl(object logo)
        {
            if (logo == null || logo == DBNull.Value || string.IsNullOrEmpty(logo.ToString().Trim()))
                return ResolveUrl("~/CompanyUploads/default-company.png");

            string l = logo.ToString().Trim();
            if (l.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || l.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                return l;

            if (l.StartsWith("~") || l.StartsWith("/"))
                return ResolveUrl(l);

            string uploadsPath = Server.MapPath("~/uploads/company_logos/" + l);
            if (System.IO.File.Exists(uploadsPath))
            {
                return ResolveUrl("~/uploads/company_logos/" + l);
            }

            return ResolveUrl("~/CompanyUploads/" + l);
        }
    }
}

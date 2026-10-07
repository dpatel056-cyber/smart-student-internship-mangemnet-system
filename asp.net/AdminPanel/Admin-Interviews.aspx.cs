using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net.css
{
    public partial class admin_interviews : System.Web.UI.Page
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
                    loadStats();
                    bindInterviews();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void loadStats()
        {
            getcon();
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalInterviews.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews WHERE Status='Scheduled'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblScheduled.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews WHERE Status='Completed'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblCompleted.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews WHERE Status='Cancelled'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblCancelled.Text = ds.Tables[0].Rows[0][0].ToString();
        }

        void bindInterviews()
        {
            getcon();
            da = new SqlDataAdapter("SELECT civ.*, s.FullName, s.Email AS StudentEmail, i.InternshipTitle, c.c_company, c.c_logo FROM CompanyInterviews civ INNER JOIN Students s ON civ.StudentId = s.StudentId INNER JOIN internship i ON civ.InternshipId = i.Id INNER JOIN c_registration c ON civ.CompanyId = c.CompanyId ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            dlInterviews.DataSource = ds.Tables[0];
            dlInterviews.DataBind();
        }
        //-----------------------------------------------
        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj != null && logoObj != DBNull.Value && !string.IsNullOrEmpty(logoObj.ToString().Trim()))
            {
                string logo = logoObj.ToString().Trim();
                if (logo.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || logo.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                {
                    return logo;
                }
                if (logo.StartsWith("~") || logo.StartsWith("/"))
                {
                    return ResolveUrl(logo);
                }

                return ResolveUrl("~/CompanyUploads/" + logo);
            }
            return ResolveUrl("~/CompanyUploads/default-company.png");
        }

        public string GetStatusBadge(object status)
        {
            if (status == null || status == DBNull.Value)
                return "<span class='status-scheduled'><i class='fa-solid fa-calendar-check'></i> Scheduled</span>";

            string st = status.ToString().Trim();
            if (st.Equals("Completed", StringComparison.OrdinalIgnoreCase))
                return "<span class='status-completed'><i class='fa-solid fa-circle-check'></i> Completed</span>";

            if (st.Equals("Cancelled", StringComparison.OrdinalIgnoreCase))
                return "<span class='status-cancelled'><i class='fa-solid fa-ban'></i> Cancelled</span>";

            return "<span class='status-scheduled'><i class='fa-solid fa-calendar-check'></i> Scheduled</span>";
        }
    }
}

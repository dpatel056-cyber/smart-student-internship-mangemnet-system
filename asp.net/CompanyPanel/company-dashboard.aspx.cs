using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class Companydashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        public int totalSelected = 0;
        public int totalPending = 0;
        public int totalRejected = 0;
        public int totalApplied = 0;
        public int intScheduled = 0;
        public int intCompleted = 0;
        public int intCancelled = 0;
        public int intTotal = 0;

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

                if (litToday != null)
                {
                    litToday.Text = DateTime.Now.ToString("dddd, dd MMMM yyyy");
                }

                if (!IsPostBack)
                {
                    loadCompanyInfo();
                    loadStats();
                    bindRecentApps();
                    bindUpcomingInterviews();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void loadCompanyInfo()
        {
            getcon();
            da = new SqlDataAdapter("SELECT c_company FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                if (litWelcomeCompanyName != null)
                {
                    litWelcomeCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                }
            }
        }

        void loadStats()
        {
            getcon();
            // Total Internships
            da = new SqlDataAdapter("SELECT COUNT(*) FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalInternships.Text = ds.Tables[0].Rows[0][0].ToString();

            // Active Internships
            da = new SqlDataAdapter("SELECT COUNT(*) FROM internship WHERE (Status IS NULL OR (Status <> 'Inactive' AND Status <> 'Draft' AND Status <> 'Closed' AND Status <> 'Expired')) AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblActiveInternships.Text = ds.Tables[0].Rows[0][0].ToString();

            // Total Applications
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            totalApplied = Convert.ToInt32(ds.Tables[0].Rows[0][0]);
            lblTotalApplications.Text = totalApplied.ToString();

            // Shortlisted
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Shortlisted' AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            lblShortlistedCount.Text = ds.Tables[0].Rows[0][0].ToString();

            // Selected
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Selected' AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            totalSelected = Convert.ToInt32(ds.Tables[0].Rows[0][0]);
            lblSelectedCount.Text = totalSelected.ToString();

            // Rejected
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Rejected' AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            totalRejected = Convert.ToInt32(ds.Tables[0].Rows[0][0]);
            lblRejectedCount.Text = totalRejected.ToString();

            // Pending (Applied / Under Review / Shortlisted)
            totalPending = totalApplied - totalSelected - totalRejected;
            if (totalPending < 0) totalPending = 0;

            // Interviews
            intScheduled = 0; intCompleted = 0; intCancelled = 0;
            da = new SqlDataAdapter("SELECT Status, COUNT(*) AS Cnt FROM CompanyInterviews WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "') GROUP BY Status", con);
            ds = new DataSet();
            da.Fill(ds);
            foreach (DataRow r in ds.Tables[0].Rows)
            {
                string st = r["Status"].ToString().Trim();
                int cnt = Convert.ToInt32(r["Cnt"]);
                if (st.Equals("Completed", StringComparison.OrdinalIgnoreCase)) intCompleted += cnt;
                else if (st.Equals("Cancelled", StringComparison.OrdinalIgnoreCase)) intCancelled += cnt;
                else intScheduled += cnt;
            }
            intTotal = intScheduled + intCompleted + intCancelled;
            lblInterviewsCount.Text = intTotal.ToString();

            // Offers
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyOfferLetters WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblOffersCount.Text = ds.Tables[0].Rows[0][0].ToString();
        }

        void bindRecentApps()
        {
            getcon();
            da = new SqlDataAdapter("SELECT TOP 5 a.*, i.InternshipTitle FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "') ORDER BY a.ApplicationId DESC", con);
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

        void bindUpcomingInterviews()
        {
            getcon();
            da = new SqlDataAdapter("SELECT TOP 3 civ.*, a.FullName, i.InternshipTitle FROM CompanyInterviews civ INNER JOIN StudentApplications a ON civ.ApplicationId = a.ApplicationId INNER JOIN internship i ON civ.InternshipId = i.Id WHERE civ.Status='Scheduled' AND civ.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "') ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                dlInterviews.DataSource = ds.Tables[0];
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

        public string GetInitials(object nameObj)
        {
            if (nameObj == null) return "ST";
            string name = nameObj.ToString().Trim();
            if (string.IsNullOrEmpty(name)) return "ST";
            string[] parts = name.Split(' ');
            if (parts.Length > 1 && parts[1].Length > 0)
                return (parts[0][0].ToString() + parts[1][0].ToString()).ToUpper();
            return name.Length > 1 ? name.Substring(0, 2).ToUpper() : name.ToUpper();
        }

        public string FormatDate(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return "";
            DateTime dt;
            if (DateTime.TryParse(dateObj.ToString(), out dt))
            {
                return dt.ToString("dd MMM yyyy");
            }
            return dateObj.ToString();
        }

        public string FormatDay(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return "01";
            DateTime dt;
            if (DateTime.TryParse(dateObj.ToString(), out dt)) return dt.ToString("dd");
            return "01";
        }

        public string FormatMonth(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return "MMM";
            DateTime dt;
            if (DateTime.TryParse(dateObj.ToString(), out dt)) return dt.ToString("MMM");
            return "MMM";
        }

        public string GetStatusBadge(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value) return "<span class='badge-status-chip st-applied'>Applied</span>";
            string st = statusObj.ToString().Trim();
            if (st.Equals("Shortlisted", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-status-chip st-shortlisted'>Shortlisted</span>";
            if (st.Equals("Selected", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-status-chip st-selected'>Selected</span>";
            if (st.Equals("Rejected", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-status-chip st-rejected'>Rejected</span>";
            return "<span class='badge-status-chip st-applied'>" + st + "</span>";
        }
    }
}

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_reports : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        // Chart JSON variables accessible in aspx
        public string FunnelChartJson = "{}";
        public string StatusDistChartJson = "{}";
        public string TopInternshipsChartJson = "{}";
        public string DomainChartJson = "{}";
        public string TrendChartJson = "{}";
        public string InterviewChartJson = "{}";
        public string OfferChartJson = "{}";
        public string TaskChartJson = "{}";

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
                    loadStats();
                    loadChartsData();
                    bindInternshipDropdown();
                    bindReport();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void loadStats()
        {
            string compEmail = Session["company"].ToString();
            getcon();

            // 1. Total Internships
            da = new SqlDataAdapter("SELECT COUNT(*) FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalInternships.Text = ds.Tables[0].Rows[0][0].ToString();

            // 2. Active Internships
            da = new SqlDataAdapter("SELECT COUNT(*) FROM internship WHERE (Status IS NULL OR (Status <> 'Inactive' AND Status <> 'Draft' AND Status <> 'Closed' AND Status <> 'Expired')) AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblActiveInternships.Text = ds.Tables[0].Rows[0][0].ToString();

            // 3. Total Applications
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            int totalApps = Convert.ToInt32(ds.Tables[0].Rows[0][0]);
            lblTotalApplications.Text = totalApps.ToString();

            // 4. Shortlisted
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Shortlisted' AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            lblShortlistedCount.Text = ds.Tables[0].Rows[0][0].ToString();

            // 5. Selected
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status IN ('Selected', 'Offer Accepted', 'Accepted') AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            lblSelectedCount.Text = ds.Tables[0].Rows[0][0].ToString();

            // 6. Rejected
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Rejected' AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            lblRejectedCount.Text = ds.Tables[0].Rows[0][0].ToString();

            // 7. Interviews Scheduled
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblInterviewsCount.Text = ds.Tables[0].Rows[0][0].ToString();

            // 8. Offers Issued
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyOfferLetters WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblOffersCount.Text = ds.Tables[0].Rows[0][0].ToString();

        }

        void loadChartsData()
        {
            string compEmail = Session["company"].ToString();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            getcon();

            // ================= 1. RECRUITMENT FUNNEL =================
            // Applied -> Shortlisted -> Interviewed -> Selected -> Offer Sent -> Completed
            int fApplied = 0, fShortlisted = 0, fInterviewed = 0, fSelected = 0, fOfferSent = 0, fCompleted = 0;

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0) fApplied = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Shortlisted' AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0) fShortlisted = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0) fInterviewed = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status IN ('Selected', 'Offer Accepted', 'Accepted') AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0) fSelected = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyOfferLetters WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0) fOfferSent = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyCertificates WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0) fCompleted = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            FunnelChartJson = serializer.Serialize(new
            {
                labels = new string[] { "1. Applied", "2. Shortlisted", "3. Interviewed", "4. Selected", "5. Offer Sent", "6. Completed" },
                data = new int[] { fApplied, fShortlisted, fInterviewed, fSelected, fOfferSent, fCompleted }
            });

            // ================= 2. APPLICATION STATUS DISTRIBUTION =================
            int sSelected = fSelected;
            int sShortlisted = fShortlisted;
            int sRejected = 0;
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Rejected' AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0) sRejected = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            int sPending = fApplied - (sSelected + sShortlisted + sRejected);
            if (sPending < 0) sPending = 0;

            StatusDistChartJson = serializer.Serialize(new
            {
                labels = new string[] { "Pending Review", "Shortlisted", "Selected", "Rejected" },
                data = new int[] { sPending, sShortlisted, sSelected, sRejected }
            });

            // ================= 3. APPLICATIONS PER INTERNSHIP (TOP 5-10) =================
            string topIntSql = @"SELECT TOP 8 i.InternshipTitle, COUNT(a.ApplicationId) AS AppCount
                                 FROM internship i
                                 LEFT JOIN StudentApplications a ON i.Id = a.InternshipId
                                 WHERE i.CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"')
                                 GROUP BY i.Id, i.InternshipTitle
                                 ORDER BY AppCount DESC";
            da = new SqlDataAdapter(topIntSql, con);
            ds = new DataSet();
            da.Fill(ds);
            var topIntLabels = new List<string>();
            var topIntCounts = new List<int>();
            foreach (DataRow r in ds.Tables[0].Rows)
            {
                topIntLabels.Add(r["InternshipTitle"].ToString());
                topIntCounts.Add(Convert.ToInt32(r["AppCount"]));
            }
            TopInternshipsChartJson = serializer.Serialize(new { labels = topIntLabels, data = topIntCounts });

            // ================= 4. APPLICATIONS BY DOMAIN =================
            string domainSql = @"SELECT ISNULL(NULLIF(i.InternshipDomain, ''), 'General / Other') AS DomainName, COUNT(a.ApplicationId) AS AppCount
                                 FROM internship i
                                 LEFT JOIN StudentApplications a ON i.Id = a.InternshipId
                                 WHERE i.CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"')
                                 GROUP BY i.InternshipDomain
                                 ORDER BY AppCount DESC";
            da = new SqlDataAdapter(domainSql, con);
            ds = new DataSet();
            da.Fill(ds);
            var domainLabels = new List<string>();
            var domainCounts = new List<int>();
            foreach (DataRow r in ds.Tables[0].Rows)
            {
                domainLabels.Add(r["DomainName"].ToString());
                domainCounts.Add(Convert.ToInt32(r["AppCount"]));
            }
            DomainChartJson = serializer.Serialize(new { labels = domainLabels, data = domainCounts });

            // ================= 5. APPLICATIONS TREND (OVER TIME) =================
            string trendSql = @"SELECT FORMAT(a.AppliedDate, 'MMM yyyy') AS MonthName,
                                       MIN(a.AppliedDate) AS MinDate,
                                       COUNT(*) AS AppCount
                                FROM StudentApplications a
                                INNER JOIN internship i ON a.InternshipId = i.Id
                                WHERE i.CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"')
                                GROUP BY FORMAT(a.AppliedDate, 'MMM yyyy'), YEAR(a.AppliedDate), MONTH(a.AppliedDate)
                                ORDER BY MIN(a.AppliedDate) ASC";
            da = new SqlDataAdapter(trendSql, con);
            ds = new DataSet();
            da.Fill(ds);
            var trendLabels = new List<string>();
            var trendCounts = new List<int>();
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow r in ds.Tables[0].Rows)
                {
                    trendLabels.Add(r["MonthName"].ToString());
                    trendCounts.Add(Convert.ToInt32(r["AppCount"]));
                }
            }
            else
            {
                // Default fallback labels if no dates
                trendLabels.Add(DateTime.Now.AddMonths(-2).ToString("MMM yyyy"));
                trendCounts.Add(0);
                trendLabels.Add(DateTime.Now.AddMonths(-1).ToString("MMM yyyy"));
                trendCounts.Add(0);
                trendLabels.Add(DateTime.Now.ToString("MMM yyyy"));
                trendCounts.Add(fApplied);
            }
            TrendChartJson = serializer.Serialize(new { labels = trendLabels, data = trendCounts });

            // ================= 6. INTERVIEW ANALYTICS (Scheduled / Completed / Cancelled) =================
            int intScheduled = 0, intCompleted = 0, intCancelled = 0;
            string intSql = @"SELECT Status, COUNT(*) AS Cnt
                              FROM CompanyInterviews
                              WHERE CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"')
                              GROUP BY Status";
            da = new SqlDataAdapter(intSql, con);
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
            InterviewChartJson = serializer.Serialize(new
            {
                labels = new string[] { "Scheduled / Upcoming", "Completed", "Cancelled" },
                data = new int[] { intScheduled, intCompleted, intCancelled }
            });

            // ================= 7. OFFER LETTER STATUS (Sent / Accepted / Rejected / Pending) =================
            int offSent = 0, offAccepted = 0, offRejected = 0, offPending = 0;
            string offSql = @"SELECT Status, COUNT(*) AS Cnt
                              FROM CompanyOfferLetters
                              WHERE CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"')
                              GROUP BY Status";
            da = new SqlDataAdapter(offSql, con);
            ds = new DataSet();
            da.Fill(ds);
            foreach (DataRow r in ds.Tables[0].Rows)
            {
                string st = r["Status"].ToString().Trim();
                int cnt = Convert.ToInt32(r["Cnt"]);
                if (st.Equals("Accepted", StringComparison.OrdinalIgnoreCase)) offAccepted += cnt;
                else if (st.Equals("Rejected", StringComparison.OrdinalIgnoreCase)) offRejected += cnt;
                else if (st.Equals("Pending", StringComparison.OrdinalIgnoreCase)) offPending += cnt;
                else offSent += cnt;
            }
            OfferChartJson = serializer.Serialize(new
            {
                labels = new string[] { "Sent", "Accepted", "Rejected", "Pending" },
                data = new int[] { offSent, offAccepted, offRejected, offPending }
            });

            // ================= 8. INTERN TASK & CHALLENGE PROGRESS =================
            int taskPending = 0, taskPassed = 0, taskFailed = 0, certsIssued = 0;
            string taskSql = @"
                SELECT
                    (
                        (SELECT COUNT(*) FROM StudentQuizAssignments WHERE CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"') AND (Status IN ('Assigned', 'Pending', 'In Progress') OR Status IS NULL OR Status = ''))
                        + (SELECT COUNT(*) FROM StudentTasks WHERE CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"') AND Status IN ('Assigned', 'Pending'))
                    ) AS PendingCnt,
                    (
                        (SELECT COUNT(*) FROM StudentQuizAssignments WHERE CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"') AND Status = 'Passed')
                        + (SELECT COUNT(*) FROM StudentTasks WHERE CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"') AND Status = 'Completed')
                    ) AS PassedCnt,
                    (
                        (SELECT COUNT(*) FROM StudentQuizAssignments WHERE CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"') AND Status = 'Failed')
                        + (SELECT COUNT(*) FROM StudentTasks WHERE CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"') AND Status IN ('Needs Revision', 'Revision'))
                    ) AS FailedCnt,
                    (
                        SELECT COUNT(*) FROM StudentQuizAssignments WHERE CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + compEmail + @"') AND CertificateIssued = 1
                    ) AS CertCnt";

            da = new SqlDataAdapter(taskSql, con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow r = ds.Tables[0].Rows[0];
                if (r["PendingCnt"] != DBNull.Value) taskPending = Convert.ToInt32(r["PendingCnt"]);
                if (r["PassedCnt"] != DBNull.Value) taskPassed = Convert.ToInt32(r["PassedCnt"]);
                if (r["FailedCnt"] != DBNull.Value) taskFailed = Convert.ToInt32(r["FailedCnt"]);
                if (r["CertCnt"] != DBNull.Value) certsIssued = Convert.ToInt32(r["CertCnt"]);
            }
            TaskChartJson = serializer.Serialize(new
            {
                labels = new string[] { "Assigned / Pending", "Passed & Completed", "Failed / Revision", "Certificates Issued" },
                data = new int[] { taskPending, taskPassed, taskFailed, certsIssued }
            });

        }

        void bindInternshipDropdown()
        {
            getcon();
            da = new SqlDataAdapter("SELECT Id, InternshipTitle FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "') ORDER BY Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            ddlInternshipFilter.Items.Clear();
            ddlInternshipFilter.Items.Add(new ListItem("All Internships", ""));
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    ddlInternshipFilter.Items.Add(new ListItem(row["InternshipTitle"].ToString(), row["Id"].ToString()));
                }
            }
        }

        void bindReport()
        {
            getcon();
            string query = "SELECT a.*, i.InternshipTitle FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "') ORDER BY a.ApplicationId DESC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvReport.DataSource = ds.Tables[0];
                gvReport.DataBind();
                gvReport.Visible = true;
                pnlNoReport.Visible = false;
            }
            else
            {
                gvReport.Visible = false;
                pnlNoReport.Visible = true;
            }
        }

        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            bindReport();
        }

        public string FormatDate(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return "N/A";
            DateTime dt;
            if (DateTime.TryParse(dateObj.ToString(), out dt))
            {
                return dt.ToString("dd MMM yyyy");
            }
            return dateObj.ToString();
        }

        public string GetStatusBadge(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value) return "<span class='badge-status status-applied'>Applied</span>";
            string st = statusObj.ToString().Trim();
            if (st.Equals("Shortlisted", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-status status-shortlisted'><i class='fa-solid fa-star'></i> Shortlisted</span>";
            if (st.Equals("Selected", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-status status-selected'><i class='fa-solid fa-circle-check'></i> Selected</span>";
            if (st.Equals("Rejected", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-status status-rejected'><i class='fa-solid fa-circle-xmark'></i> Rejected</span>";
            return "<span class='badge-status status-applied'><i class='fa-solid fa-clock'></i> " + st + "</span>";
        }
    }
}

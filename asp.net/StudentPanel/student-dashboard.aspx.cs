using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

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
        public int intCompleted = 0;
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

                    LoadStats();
                    LoadRecentApplications();
                    LoadUpcomingInterviews();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void LoadStats()
        {
            string studentKey = Session["student"].ToString();
            getcon();

            // Total Applications
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE StudentEmail='" + studentKey + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalApplied.Text = ds.Tables[0].Rows[0][0].ToString();

            // Pending / Under Review
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE (Status='Applied' OR Status='Under Review' OR Status='Pending') AND (StudentEmail='" + studentKey + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            lblPendingCount.Text = ds.Tables[0].Rows[0][0].ToString();
            int.TryParse(lblPendingCount.Text, out totalPending);

            // Shortlisted
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Shortlisted' AND (StudentEmail='" + studentKey + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            lblShortlistedCount.Text = ds.Tables[0].Rows[0][0].ToString();

            // Selected / Offers
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE (Status='Selected' OR Status='Offer Accepted' OR Status='Accepted') AND (StudentEmail='" + studentKey + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            lblSelectedCount.Text = ds.Tables[0].Rows[0][0].ToString();
            int.TryParse(lblSelectedCount.Text, out totalSelected);

            // Rejected
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE (Status='Rejected') AND (StudentEmail='" + studentKey + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            totalRejected = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            // Total Interviews
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + studentKey + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblInterviewsCount.Text = ds.Tables[0].Rows[0][0].ToString();

            // Interviews Scheduled
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews WHERE (Status='Scheduled' OR Status IS NULL OR Status='') AND (ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + studentKey + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            intScheduled = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            // Interviews Completed
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews WHERE Status='Completed' AND (ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + studentKey + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            intCompleted = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            // Interviews Cancelled
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyInterviews WHERE Status='Cancelled' AND (ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + studentKey + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            intCancelled = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            // Offer Letters
            da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyOfferLetters WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + studentKey + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblOffersCount.Text = ds.Tables[0].Rows[0][0].ToString();

            // Tasks / Quizzes
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentQuizAssignments WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + studentKey + "') OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTasksCount.Text = ds.Tables[0].Rows[0][0].ToString();

            // Saved Internships
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentSavedInternships WHERE StudentEmail='" + studentKey + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            lblSavedCount.Text = ds.Tables[0].Rows[0][0].ToString();
        }

        void LoadRecentApplications()
        {
            string studentKey = Session["student"].ToString();
            getcon();

            da = new SqlDataAdapter("SELECT TOP 5 sa.ApplicationId, sa.InternshipId, sa.Status, sa.AppliedDate, i.InternshipTitle, i.Location, i.WorkMode, i.StipendAmount, c.c_company, c.c_logo FROM StudentApplications sa INNER JOIN internship i ON sa.InternshipId = i.Id INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE sa.StudentEmail='" + studentKey + "' OR sa.StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "') ORDER BY sa.ApplicationId DESC", con);
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

        void LoadUpcomingInterviews()
        {
            string studentKey = Session["student"].ToString();
            getcon();

            da = new SqlDataAdapter("SELECT TOP 4 civ.*, i.InternshipTitle, i.Location AS InternshipLocation, c.c_company, c.c_logo FROM CompanyInterviews civ INNER JOIN StudentApplications sa ON civ.ApplicationId = sa.ApplicationId INNER JOIN internship i ON civ.InternshipId = i.Id INNER JOIN c_registration c ON civ.CompanyId = c.CompanyId WHERE sa.StudentEmail='" + studentKey + "' OR sa.StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "') ORDER BY civ.InterviewId DESC", con);
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

        public string GetCompanyLogoHtml(object logoObj, object nameObj)
        {
            string logo = logoObj != null && logoObj != DBNull.Value ? logoObj.ToString().Trim() : "";
            string name = nameObj != null && nameObj != DBNull.Value ? nameObj.ToString().Trim() : "Company";

            if (!string.IsNullOrEmpty(logo))
            {
                string logoUrl = "";
                if (logo.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || logo.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                {
                    logoUrl = logo;
                }
                else if (logo.StartsWith("~") || logo.StartsWith("/"))
                {
                    logoUrl = ResolveUrl(logo);
                }
                else
                {
                    logoUrl = ResolveUrl("~/CompanyUploads/" + logo);
                }
                return "<img src='" + logoUrl + "' alt='" + Server.HtmlEncode(name) + "' style='width: 100%; height: 100%; object-fit: cover; border-radius: 50%;' onerror=\"this.onerror=null; this.src='" + ResolveUrl("~/CompanyUploads/default-company.png") + "';\" />";
            }

            return "<i class='fa-solid fa-building' style='color: #2563eb;'></i>";
        }

        public string FormatDate(object dateObj)
        {
            if (dateObj != null && dateObj != DBNull.Value)
            {
                DateTime dt;
                if (DateTime.TryParse(dateObj.ToString(), out dt))
                {
                    return dt.ToString("dd MMM yyyy");
                }
            }
            return "-";
        }

        public string GetStatusBadge(object statusObj)
        {
            string status = statusObj != null && statusObj != DBNull.Value ? statusObj.ToString().Trim() : "Applied";

            if (status.Equals("Selected", StringComparison.OrdinalIgnoreCase) || status.Equals("Accepted", StringComparison.OrdinalIgnoreCase) || status.Equals("Offer Accepted", StringComparison.OrdinalIgnoreCase))
            {
                return "<span style='display:inline-flex;align-items:center;gap:4px;padding:3px 10px;border-radius:20px;font-size:11.5px;font-weight:700;background:#dcfce7;color:#15803d;border:1px solid #bbf7d0;'><i class='fa-solid fa-circle-check'></i> " + status + "</span>";
            }
            else if (status.Equals("Shortlisted", StringComparison.OrdinalIgnoreCase))
            {
                return "<span style='display:inline-flex;align-items:center;gap:4px;padding:3px 10px;border-radius:20px;font-size:11.5px;font-weight:700;background:#eff6ff;color:#1d4ed8;border:1px solid #bfdbfe;'><i class='fa-solid fa-star'></i> " + status + "</span>";
            }
            else if (status.Equals("Rejected", StringComparison.OrdinalIgnoreCase))
            {
                return "<span style='display:inline-flex;align-items:center;gap:4px;padding:3px 10px;border-radius:20px;font-size:11.5px;font-weight:700;background:#fee2e2;color:#dc2626;border:1px solid #fecaca;'><i class='fa-solid fa-ban'></i> " + status + "</span>";
            }
            else
            {
                return "<span style='display:inline-flex;align-items:center;gap:4px;padding:3px 10px;border-radius:20px;font-size:11.5px;font-weight:700;background:#fef3c7;color:#b45309;border:1px solid #fde68a;'><i class='fa-solid fa-clock'></i> " + status + "</span>";
            }
        }

        public string FormatDay(object dateObj)
        {
            if (dateObj != null && dateObj != DBNull.Value)
            {
                DateTime dt;
                if (DateTime.TryParse(dateObj.ToString(), out dt))
                {
                    return dt.ToString("dd");
                }
            }
            return DateTime.Now.ToString("dd");
        }

        public string FormatMonth(object dateObj)
        {
            if (dateObj != null && dateObj != DBNull.Value)
            {
                DateTime dt;
                if (DateTime.TryParse(dateObj.ToString(), out dt))
                {
                    return dt.ToString("MMM").ToUpper();
                }
            }
            return DateTime.Now.ToString("MMM").ToUpper();
        }

        public string FormatMeetingBtn(object linkObj, object locObj, object typeObj)
        {
            string link = linkObj != null && linkObj != DBNull.Value ? linkObj.ToString().Trim() : "";
            string loc = locObj != null && locObj != DBNull.Value ? locObj.ToString().Trim() : "";
            string type = typeObj != null && typeObj != DBNull.Value ? typeObj.ToString().Trim() : "Virtual / Online";

            string val = !string.IsNullOrEmpty(link) ? link : loc;
            if (val.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || val.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
            {
                return "<a href='" + val + "' target='_blank' style='padding: 6px 12px; border-radius: 8px; font-size: 12px; font-weight: 600; background: #2563eb; color: #ffffff; text-decoration: none; display: inline-flex; align-items: center; gap: 5px;'><i class='fa-solid fa-video'></i> Join Meeting</a>";
            }
            if (!string.IsNullOrEmpty(val))
            {
                return "<span style='font-size: 12px; color: #64748b;'><i class='fa-solid fa-location-dot'></i> " + Server.HtmlEncode(val) + "</span>";
            }
            return "<span style='font-size: 12px; color: #64748b;'><i class='fa-solid fa-circle-info'></i> " + Server.HtmlEncode(type) + "</span>";
        }
    }
}

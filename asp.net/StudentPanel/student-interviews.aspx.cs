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

            da = new SqlDataAdapter("select civ.*, ISNULL(i.InternshipTitle,'Internship Interview') as InternshipTitle, ISNULL(i.Location,'Headquarters') as InternshipLocation, ISNULL(i.WorkMode,'Full Time') as WorkMode, c.c_company,c.c_logo,c.c_location,c.c_email as CompEmail from CompanyInterviews civ inner join StudentApplications sa on civ.ApplicationId=sa.ApplicationId inner join internship i on civ.InternshipId=i.Id inner join c_registration c on civ.CompanyId=c.CompanyId where sa.StudentEmail='" + Session["student"] + "' order by civ.InterviewId desc", con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                dlInterviews.DataSource = ds;
                dlInterviews.DataBind();

                dlInterviews.Visible = true;
                pnlNoInterviews.Visible = false;

                LoadStats();
            }
            else
            {
                dlInterviews.Visible = false;
                pnlNoInterviews.Visible = true;

                lblTotalInterviews.Text = "0";
                lblScheduledCount.Text = "0";
                lblCompletedCount.Text = "0";
                lblCompanyCount.Text = "0";
            }
        }

        void LoadStats()
        {
            int total = ds.Tables[0].Rows.Count;
            int scheduled = 0;
            int completed = 0;
            int companies = 0;

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string status = ds.Tables[0].Rows[i]["Status"].ToString();

                if (status == "Scheduled")
                {
                    scheduled++;
                }

                if (status == "Completed")
                {
                    completed++;
                }
            }

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string company = ds.Tables[0].Rows[i]["c_company"].ToString();
                bool found = false;

                for (int j = 0; j < i; j++)
                {
                    if (company == ds.Tables[0].Rows[j]["c_company"].ToString())
                    {
                        found = true;
                        break;
                    }
                }

                if (company != "" && !found)
                {
                    companies++;
                }
            }

            lblTotalInterviews.Text = total.ToString();
            lblScheduledCount.Text = scheduled.ToString();
            lblCompletedCount.Text = completed.ToString();
            lblCompanyCount.Text = companies.ToString();
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

        public string GetResolvedLogoUrl(object logoObj)
        {
            if (logoObj == null || logoObj == DBNull.Value)
                return ResolveUrl("~/CompanyUploads/default-company.png");

            string logo = logoObj.ToString().Trim();
            if (string.IsNullOrEmpty(logo))
                return ResolveUrl("~/CompanyUploads/default-company.png");

            if (logo.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || logo.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                return logo;

            if (logo.StartsWith("~"))
                return ResolveUrl(logo);

            if (logo.StartsWith("/"))
                return ResolveUrl("~" + logo);

            return ResolveUrl("~/CompanyUploads/" + logo);
        }

        public string FormatCompanyLogo(object logoObj, object nameObj)
        {
            string name = "Company";

            if (nameObj != null && !string.IsNullOrEmpty(nameObj.ToString()))
            {
                name = nameObj.ToString();
            }

            string resolvedUrl = GetResolvedLogoUrl(logoObj);
            if (!string.IsNullOrEmpty(resolvedUrl))
            {
                return "<img src='" + resolvedUrl + "' alt='" + Server.HtmlEncode(name) + "' onerror=\"this.style.display='none'; this.parentElement.innerHTML='<i class=\\\'fa-solid fa-building\\\'></i>';\" />";
            }

            return "<i class='fa-solid fa-building'></i>";
        }

        public string FormatMeetingBtn(object linkObj, object locObj, object typeObj)
        {
            string link = "";
            string location = "";
            string type = "Virtual / Online";

            if (linkObj != null)
                link = linkObj.ToString();

            if (locObj != null)
                location = locObj.ToString();

            if (typeObj != null)
                type = typeObj.ToString();

            string value = link;

            if (value == "")
            {
                value = location;
            }

            if (value.StartsWith("http://") || value.StartsWith("https://"))
            {
                return "<a href='" + value +
                       "' target='_blank' class='btn-join-meeting-full'>" +
                       "<i class='fa-solid fa-video'></i> Join Virtual Interview</a>";
            }

            if (value != "")
            {
                return "<div class='btn-offline-badge'>" +
                       "<i class='fa-solid fa-location-dot'></i> " +
                       value + "</div>";
            }

            return "<div class='btn-offline-badge'>" +
                   "<i class='fa-solid fa-circle-info'></i> " +
                   type + "</div>";
        }

        public string GetStatusBadge(object statusObj)
        {
            string status = "Scheduled";

            if (statusObj != null && statusObj != DBNull.Value)
            {
                status = statusObj.ToString();
            }

            if (status == "Completed")
            {
                return "<span class='interview-status-badge status-completed'>" +
                       "<i class='fa-solid fa-circle-check'></i> Completed</span>";
            }

            if (status == "Cancelled")
            {
                return "<span class='interview-status-badge status-cancelled'>" +
                       "<i class='fa-solid fa-circle-xmark'></i> Cancelled</span>";
            }

            return "<span class='interview-status-badge status-scheduled'>" +
                   "<i class='fa-solid fa-calendar-check'></i> Scheduled</span>";
        }
    }
}
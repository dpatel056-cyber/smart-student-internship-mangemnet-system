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

                int total = ds.Tables[0].Rows.Count;
                int underReview = 0;
                int shortlisted = 0;
                int selected = 0;

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string status = ds.Tables[0].Rows[i]["Status"].ToString();

                    if (status == "Under Review" || status == "Applied")
                    {
                        underReview++;
                    }

                    if (status == "Shortlisted")
                    {
                        shortlisted++;
                    }

                    if (status == "Selected" ||
                        status == "Accepted" ||
                        status == "Offer Accepted")
                    {
                        selected++;
                    }
                }

                lblTotalApplied.Text = total.ToString();
                lblUnderReview.Text = underReview.ToString();
                lblShortlisted.Text = shortlisted.ToString();
                lblSelected.Text = selected.ToString();
            }
            else
            {
                gvApplications.Visible = false;
                pnlNoApps.Visible = true;

                lblTotalApplied.Text = "0";
                lblUnderReview.Text = "0";
                lblShortlisted.Text = "0";
                lblSelected.Text = "0";
            }
        }

        public string GetCompanyLogo(object logoObj)
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

            return "Recently";
        }

        public string GetStatusBadge(object statusObj)
        {
            string status = "Applied";

            if (statusObj != null && statusObj != DBNull.Value)
            {
                status = statusObj.ToString();
            }

            if (status == "Under Review")
            {
                return "<span class='badge-status status-under-review'>" +
                       "<i class='fa-solid fa-clock-rotate-left'></i> Under Review</span>";
            }

            if (status == "Shortlisted")
            {
                return "<span class='badge-status status-shortlisted'>" +
                       "<i class='fa-solid fa-user-check'></i> Shortlisted</span>";
            }

            if (status == "Selected" ||
                status == "Accepted" ||
                status == "Offer Accepted")
            {
                return "<span class='badge-status status-selected'>" +
                       "<i class='fa-solid fa-circle-check'></i> Offer Accepted</span>";
            }

            if (status == "Rejected")
            {
                return "<span class='badge-status status-rejected'>" +
                       "<i class='fa-solid fa-circle-xmark'></i> Rejected</span>";
            }

            return "<span class='badge-status status-applied'>" +
                   "<i class='fa-solid fa-paper-plane'></i> Applied</span>";
        }
    }
}
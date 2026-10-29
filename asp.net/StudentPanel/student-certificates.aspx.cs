using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_certificates : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
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
                    LoadCertificates();
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

        void LoadCertificates()
        {
            string studentKey = Session["student"].ToString();
            getcon();
            da = new SqlDataAdapter("SELECT cc.*, ISNULL(NULLIF(cc.CandidateName, ''), ISNULL(sa.FullName, s.FullName)) AS FullName, ISNULL(sa.StudentEmail, s.Email) AS StudentEmail, ISNULL(NULLIF(cc.CandidateCollege, ''), ISNULL(sa.College, s.College)) AS College, ISNULL(NULLIF(cc.InternshipRole, ''), i.InternshipTitle) AS RoleName, ISNULL(NULLIF(cc.Duration, ''), i.Duration) AS CertDuration, c.c_company, c.c_logo, c.c_location, c.c_email AS CompEmail, c.c_hr_name FROM CompanyCertificates cc LEFT JOIN StudentApplications sa ON cc.ApplicationId = sa.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR sa.StudentId = s.StudentId OR sa.StudentEmail = s.Email) LEFT JOIN internship i ON cc.InternshipId = i.Id LEFT JOIN c_registration c ON cc.CompanyId = c.CompanyId WHERE (sa.StudentEmail='" + studentKey + "' OR s.Email='" + studentKey + "' OR s.EnrollmentNo='" + studentKey + "') AND (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) ORDER BY cc.CertificateId DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                dlCertificates.DataSource = ds.Tables[0];
                dlCertificates.DataBind();
                dlCertificates.Visible = true;
                pnlNoCerts.Visible = false;
                LoadStats(ds.Tables[0]);
            }
            else
            {
                dlCertificates.Visible = false;
                pnlNoCerts.Visible = true;
                lblTotalCerts.Text = "0";
                lblVerifiedCerts.Text = "0";
                lblCompaniesCount.Text = "0";
                lblLatestDate.Text = "-";
            }
        }

        protected void dlCertificates_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                Response.Redirect("student-certificate-view.aspx?id=" + e.CommandArgument);
            }
        }

        //----------------------------------------
        void LoadStats(DataTable dt)
        {
            int total = dt.Rows.Count;
            int verified = total;
            string latestDate = "-";
            System.Collections.Generic.HashSet<string> compSet = new System.Collections.Generic.HashSet<string>();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow r = dt.Rows[i];
                if (r["c_company"] != null && !string.IsNullOrEmpty(r["c_company"].ToString()))
                {
                    compSet.Add(r["c_company"].ToString().Trim());
                }
                if (i == 0 && r["IssueDate"] != null && r["IssueDate"] != DBNull.Value)
                {
                    latestDate = FormatDate(r["IssueDate"]);
                }
            }

            lblTotalCerts.Text = total.ToString();
            lblVerifiedCerts.Text = verified.ToString();
            lblCompaniesCount.Text = compSet.Count.ToString();
            lblLatestDate.Text = latestDate;
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

        public string GetStudentStatusBadge(object statusObj)
        {
            return "<span style='display:inline-flex; align-items:center; gap:4px; padding:4px 10px; border-radius:20px; font-size:11px; font-weight:700; background:#dcfce7; color:#16a34a; border:1px solid #bbf7d0;'><i class='fa-solid fa-circle-check'></i> Verified Completion</span>";
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

            if (System.IO.File.Exists(Server.MapPath("~/company_images/" + logo)))
                return ResolveUrl("~/company_images/" + logo);
            if (System.IO.File.Exists(Server.MapPath("~/compnay_images/" + logo)))
                return ResolveUrl("~/compnay_images/" + logo);
            return ResolveUrl("~/CompanyUploads/" + logo);
        }
    }
}

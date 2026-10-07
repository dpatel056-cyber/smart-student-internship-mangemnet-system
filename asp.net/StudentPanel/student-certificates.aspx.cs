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
            da = new SqlDataAdapter("SELECT cc.*, ISNULL(NULLIF(cc.CandidateName, ''), sa.FullName) AS FullName, sa.StudentEmail, ISNULL(NULLIF(cc.CandidateCollege, ''), sa.College) AS College, ISNULL(NULLIF(cc.InternshipRole, ''), i.InternshipTitle) AS RoleName, ISNULL(NULLIF(cc.Duration, ''), i.Duration) AS CertDuration, c.c_company, c.c_logo, c.c_location, c.c_email AS CompEmail, c.c_hr_name FROM CompanyCertificates cc INNER JOIN StudentApplications sa ON cc.ApplicationId = sa.ApplicationId INNER JOIN internship i ON cc.InternshipId = i.Id INNER JOIN c_registration c ON cc.CompanyId = c.CompanyId WHERE sa.StudentEmail='" + studentKey + "' AND (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) ORDER BY cc.CertificateId DESC",con);
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

        //----------------------------------------
        void LoadStats(DataTable dt)
        {
            int total = dt.Rows.Count;
            int verified = 0;
            string latestDate = "-";
            System.Collections.Generic.HashSet<string> compSet = new System.Collections.Generic.HashSet<string>();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                DataRow r = dt.Rows[i];
                string status = r["Status"] != null ? r["Status"].ToString() : "";
                if (!status.Equals("Revoked", StringComparison.OrdinalIgnoreCase))
                {
                    verified++;
                }
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

        public bool IsRevoked(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value) return false;
            return statusObj.ToString().Equals("Revoked", StringComparison.OrdinalIgnoreCase);
        }

        public string GetStudentStatusBadge(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value) return "";
            string st = statusObj.ToString().Trim();
            if (st.Equals("Revoked", StringComparison.OrdinalIgnoreCase))
            {
                return "<span style='display:inline-flex; align-items:center; gap:4px; padding:4px 10px; border-radius:20px; font-size:11px; font-weight:700; background:#fee2e2; color:#dc2626; border:1px solid #fecaca;'><i class='fa-solid fa-circle-xmark'></i> Revoked</span>";
            }
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

            return ResolveUrl("~/CompanyUploads/" + logo);
        }
    }
}

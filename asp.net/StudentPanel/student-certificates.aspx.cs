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
                    TotalCertificate();
                    TotalVerified();
                    TotalPartnerCompanies();
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
            getcon();
            da = new SqlDataAdapter("SELECT cc.*, ISNULL(NULLIF(cc.CandidateName, ''), ISNULL(sa.FullName, s.FullName)) AS FullName, ISNULL(sa.StudentEmail, s.Email) AS StudentEmail, ISNULL(NULLIF(cc.CandidateCollege, ''), ISNULL(sa.College, s.College)) AS College, ISNULL(NULLIF(cc.InternshipRole, ''), i.InternshipTitle) AS RoleName, ISNULL(NULLIF(cc.Duration, ''), i.Duration) AS CertDuration, c.c_company, c.c_logo, c.c_location, c.c_email AS CompEmail, c.c_hr_name FROM CompanyCertificates cc LEFT JOIN StudentApplications sa ON cc.ApplicationId = sa.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR sa.StudentId = s.StudentId OR sa.StudentEmail = s.Email) LEFT JOIN internship i ON cc.InternshipId = i.Id LEFT JOIN c_registration c ON cc.CompanyId = c.CompanyId WHERE (sa.StudentEmail='" + Session["student"].ToString() + "' OR s.Email='" + Session["student"].ToString() + "' OR s.EnrollmentNo='" + Session["student"].ToString() + "') AND (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) ORDER BY cc.CertificateId DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                dlCertificates.DataSource = ds.Tables[0];
                dlCertificates.DataBind();
                dlCertificates.Visible = true;
                pnlNoCerts.Visible = false;

            }
            else
            {
                dlCertificates.Visible = false;
                pnlNoCerts.Visible = true;

            }
        }

        protected void dlCertificates_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                Response.Redirect("student-certificate-view.aspx?id=" + e.CommandArgument);
            }
        }

        void TotalCertificate()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyCertificates cc LEFT JOIN StudentApplications sa ON cc.ApplicationId = sa.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR sa.StudentId = s.StudentId OR sa.StudentEmail = s.Email) WHERE (sa.StudentEmail='" + Session["student"].ToString() + "' OR s.Email='" + Session["student"].ToString() + "' OR s.EnrollmentNo='" + Session["student"].ToString() + "') AND (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL)", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalCerts.Text = i.ToString();
        }

        void TotalVerified()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyCertificates cc LEFT JOIN StudentApplications sa ON cc.ApplicationId = sa.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR sa.StudentId = s.StudentId OR sa.StudentEmail = s.Email) WHERE (sa.StudentEmail='" + Session["student"].ToString() + "' OR s.Email='" + Session["student"].ToString() + "' OR s.EnrollmentNo='" + Session["student"].ToString() + "') AND (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) AND (cc.Status = 'Issued' OR cc.Status = 'Active' OR cc.Status = 'Verified' OR (cc.VerificationCode IS NOT NULL AND cc.VerificationCode <> ''))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblVerifiedCerts.Text = i.ToString();
        }

        void TotalPartnerCompanies()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(DISTINCT cc.CompanyId) FROM CompanyCertificates cc LEFT JOIN StudentApplications sa ON cc.ApplicationId = sa.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR sa.StudentId = s.StudentId OR sa.StudentEmail = s.Email) WHERE (sa.StudentEmail='" + Session["student"].ToString() + "' OR s.Email='" + Session["student"].ToString() + "' OR s.EnrollmentNo='" + Session["student"].ToString() + "') AND (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) AND cc.CompanyId IS NOT NULL", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblCompaniesCount.Text = i.ToString();
        }

        public string GetStudentStatusBadge(object statusObj)
        {
            return "<span class='cert-status-badge' style='display:inline-flex; align-items:center; gap:6px; padding:6px 14px; border-radius:999px; font-size:11.5px; font-weight:700; background:#dcfce7; color:#15803d; border:1px solid #86efac; box-shadow:0 1px 3px rgba(22,163,74,0.1); white-space:nowrap;'><i class='fa-solid fa-circle-check' style='font-size:13px; color:#16a34a; line-height:1;'></i> Verified Completion</span>";
        }
    }
}

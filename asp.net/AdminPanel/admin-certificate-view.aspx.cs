using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace asp.net
{
    public partial class admin_certificate_view : System.Web.UI.Page
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
                    if (Request.QueryString["id"] != null)
                    {
                        loadCertificate();
                    }
                    else
                    {
                        Response.Redirect("admin-certificates.aspx");
                    }
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void loadCertificate()
        {
            getcon();
            da = new SqlDataAdapter("SELECT cc.*, s.FullName, s.Email AS StudentEmail, s.College, i.InternshipTitle, i.Duration, comp.c_company, comp.c_logo FROM CompanyCertificates cc LEFT JOIN Students s ON cc.StudentId = s.StudentId LEFT JOIN internship i ON cc.InternshipId = i.Id LEFT JOIN c_registration comp ON cc.CompanyId = comp.CompanyId WHERE cc.CertificateId='" + Request.QueryString["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            lblCertNo.Text = ds.Tables[0].Rows[0]["CertificateNo"].ToString();
            lblStudentName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
            lblCollege.Text = ds.Tables[0].Rows[0]["College"].ToString();
            lblCertTitle.Text = ds.Tables[0].Rows[0]["CertificateTitle"].ToString();
            lblInternship.Text = ds.Tables[0].Rows[0]["InternshipTitle"].ToString();
            lblDuration.Text = ds.Tables[0].Rows[0]["Duration"].ToString();
            lblIssueDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["IssueDate"]).ToString("dd MMMM yyyy");
            lblPerformance.Text = ds.Tables[0].Rows[0]["Performance"].ToString();
            lblSignatoryName.Text = ds.Tables[0].Rows[0]["SignatoryName"].ToString();
            lblCompany.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
            lblStudentEmail.Text = ds.Tables[0].Rows[0]["StudentEmail"].ToString();

            //LOGO 
            string logo = ds.Tables[0].Rows[0]["c_logo"] != null ? ds.Tables[0].Rows[0]["c_logo"].ToString().Trim() : "";
            if (!string.IsNullOrEmpty(logo))
            {
                if (logo.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || logo.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                {
                    imgCompanyLogo.ImageUrl = logo;
                }
                else if (logo.StartsWith("~") || logo.StartsWith("/"))
                {
                    imgCompanyLogo.ImageUrl = ResolveUrl(logo);
                }
                else
                {
                    imgCompanyLogo.ImageUrl = ResolveUrl("~/CompanyUploads/" + logo);
                }
                imgCompanyLogo.Visible = true;
                pnlLogoPlaceholder.Visible = false;
            }
            else
            {
                imgCompanyLogo.Visible = false;
                pnlLogoPlaceholder.Visible = true;
            }
        }
    }
}

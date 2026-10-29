using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace asp.net
{

    public partial class student_certificate_view : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

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
                    if (Request.QueryString["id"] != null)
                    {
                        loadCertificate();
                    }
                    else
                    {
                        Response.Redirect("student-certificates.aspx");
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
            da = new SqlDataAdapter("SELECT cc.*, s.FullName, s.Email AS StudentEmail, s.College, i.InternshipTitle, i.Duration, comp.c_company, CASE WHEN comp.c_logo LIKE '~/%' THEN comp.c_logo WHEN comp.c_logo IS NOT NULL AND comp.c_logo <> '' THEN '~/compnay_images/' + comp.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo FROM CompanyCertificates cc LEFT JOIN Students s ON cc.StudentId = s.StudentId LEFT JOIN internship i ON cc.InternshipId = i.Id LEFT JOIN c_registration comp ON cc.CompanyId = comp.CompanyId WHERE cc.CertificateId='" + Request.QueryString["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
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
                dlCompanyLogo.DataSource = ds.Tables[0];
                dlCompanyLogo.DataBind();
            }
            else
            {
                Response.Redirect("student-certificates.aspx");
            }
        }

        protected void btnBackCertificates_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("student-certificates.aspx");
        }
    }
}

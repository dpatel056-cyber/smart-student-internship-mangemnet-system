using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace asp.net
{
    public partial class admin_offer_letter_view : System.Web.UI.Page
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
            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("SELECT * FROM admin_registration WHERE Email='" + Session["admin"].ToString() + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    getcon();
                    da = new SqlDataAdapter("SELECT col.*, ISNULL(NULLIF(col.OfferTitle,''), ISNULL(i.InternshipTitle,'Internship Offer')) AS OfferTitle, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.College, s.College) AS College, comp.c_company, comp.c_location, comp.c_email AS CompanyEmail, comp.c_contact AS CompanyContact, comp.c_website AS CompanyWebsite, ISNULL(comp.c_hr_name, 'Talent Acquisition Team') AS CompanyHrName, CASE WHEN comp.c_logo LIKE '~/%' THEN comp.c_logo WHEN comp.c_logo IS NOT NULL AND comp.c_logo <> '' THEN '~/compnay_images/' + comp.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo FROM CompanyOfferLetters col LEFT JOIN StudentApplications a ON col.ApplicationId = a.ApplicationId LEFT JOIN Students s ON (col.StudentId = s.StudentId OR a.StudentId = s.StudentId) LEFT JOIN internship i ON col.InternshipId = i.Id LEFT JOIN c_registration comp ON col.CompanyId = comp.CompanyId WHERE col.OfferId='" + Request.QueryString["id"].ToString() + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        dlCompanyLogo.DataSource = ds.Tables[0];
                        dlCompanyLogo.DataBind();

                        lblOfferRef.Text = DateTime.Now.Year + "/OFFER/" + ds.Tables[0].Rows[0]["OfferId"].ToString().PadLeft(3, '0');

                        lblStudentName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                        lblCandidateFirst.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                        lblCollege.Text = ds.Tables[0].Rows[0]["College"].ToString();

                        lblCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                        lblCompanyBody.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                        lblCompanySign.Text = ds.Tables[0].Rows[0]["c_company"].ToString();

                        lblCompanyLocation.Text = ds.Tables[0].Rows[0]["c_location"].ToString();
                        lblCompanyEmail.Text = ds.Tables[0].Rows[0]["CompanyEmail"].ToString();
                        lblCompanyPhone.Text = ds.Tables[0].Rows[0]["CompanyContact"].ToString();

                        lblCompanyWebsite.Text = ds.Tables[0].Rows[0]["CompanyWebsite"].ToString();

                        lblOfferTitle.Text = ds.Tables[0].Rows[0]["OfferTitle"].ToString();
                        lblPosition.Text = ds.Tables[0].Rows[0]["OfferTitle"].ToString();
                        lblInternshipRole.Text = ds.Tables[0].Rows[0]["OfferTitle"].ToString();

                        lblStipend.Text = ds.Tables[0].Rows[0]["Stipend"].ToString();

                        lblDuration.Text = ds.Tables[0].Rows[0]["Duration"].ToString();
                        lblJoiningDate.Text = ds.Tables[0].Rows[0]["JoiningDate"].ToString();
                        lblWorkLocation.Text = ds.Tables[0].Rows[0]["WorkLocation"].ToString();

                        lblIssuedDate.Text = ds.Tables[0].Rows[0]["IssuedDate"].ToString();
                        lblValidTill.Text = ds.Tables[0].Rows[0]["ValidTill"].ToString();
                        lblSignatoryName.Text = ds.Tables[0].Rows[0]["CompanyHrName"].ToString();
                    }
                    else
                    {
                        Response.Redirect("admin-offer-letters.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/PublicPanel/login.aspx");
                }
            }
        }

        protected void btnBackOffers_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            Response.Redirect("admin-offer-letters.aspx");
        }
    }
}

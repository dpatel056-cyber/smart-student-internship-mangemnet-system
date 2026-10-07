using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class company_details : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                companyfilldata();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void companyfilldata()
        {
            getcon();
            string id = Request.QueryString["CompanyId"];
            da = new SqlDataAdapter("select * from c_registration where CompanyId='" + id + "' and (IsBlocked = 0 OR IsBlocked IS NULL) and (Status != 'Blocked' OR Status IS NULL)", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                divNotFound.Visible = false;
                divDetails.Visible = true;

                lblCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblCompanyInitials.Text = ds.Tables[0].Rows[0]["c_company"].ToString().Substring(0, 1).ToUpper();
                lblIndustry.Text = ds.Tables[0].Rows[0]["c_industry"].ToString();
                lblLocation.Text = ds.Tables[0].Rows[0]["c_city"].ToString() + ", " + ds.Tables[0].Rows[0]["c_state"].ToString();

                // Logo
                string logo = ds.Tables[0].Rows[0]["c_logo"] != DBNull.Value ? ds.Tables[0].Rows[0]["c_logo"].ToString().Trim() : "";
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
                        string uploadsPath = Server.MapPath("~/uploads/company_logos/" + logo);
                        if (System.IO.File.Exists(uploadsPath))
                        {
                            imgCompanyLogo.ImageUrl = ResolveUrl("~/uploads/company_logos/" + logo);
                        }
                        else
                        {
                            imgCompanyLogo.ImageUrl = ResolveUrl("~/CompanyUploads/" + logo);
                        }
                    }
                    imgCompanyLogo.Visible = true;
                    divLogoInitials.Visible = false;
                }
                else
                {
                    imgCompanyLogo.ImageUrl = ResolveUrl("~/CompanyUploads/default-company.png");
                    imgCompanyLogo.Visible = true;
                    divLogoInitials.Visible = false;
                }

                // Website
                hlWebsite.Text = ds.Tables[0].Rows[0]["c_website"].ToString();
                hlWebsite.NavigateUrl = ds.Tables[0].Rows[0]["c_website"].ToString();

                // Hero Contact
                lblHeroContactPerson.Text = ds.Tables[0].Rows[0]["c_hr_name"].ToString();
                lblHeroEmail.Text = ds.Tables[0].Rows[0]["c_email"].ToString();
                lblHeroPhone.Text = ds.Tables[0].Rows[0]["c_contact"].ToString();

                // Social Links
                hlWebsiteSocial.NavigateUrl = ds.Tables[0].Rows[0]["c_website"].ToString();
                hlEmailSocial.NavigateUrl = "mailto:" + ds.Tables[0].Rows[0]["c_email"].ToString();
                hlCallSocial.NavigateUrl = "tel:" + ds.Tables[0].Rows[0]["c_contact"].ToString();

                // Overview
                lblFieldCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblFieldIndustry.Text = ds.Tables[0].Rows[0]["c_industry"].ToString();
                lblCompanyType.Text = ds.Tables[0].Rows[0]["c_type"].ToString();
                lblCompanySize.Text = ds.Tables[0].Rows[0]["c_size"].ToString();
                lblFoundedYear.Text = ds.Tables[0].Rows[0]["c_founded_year"].ToString();
                lblDescription.Text = ds.Tables[0].Rows[0]["c_about"].ToString();
                lblHeadquarters.Text = ds.Tables[0].Rows[0]["c_headquarters"].ToString();

                // Company Information
                lblBusinessDomain.Text = ds.Tables[0].Rows[0]["c_business_domain"].ToString();
                lblProductsServices.Text = ds.Tables[0].Rows[0]["c_products"].ToString();
                lblMission.Text = ds.Tables[0].Rows[0]["c_mission"].ToString();
                lblVision.Text = ds.Tables[0].Rows[0]["c_vision"].ToString();

                // HR / Contact
                lblEmail.Text = ds.Tables[0].Rows[0]["c_email"].ToString();
                lblPhone.Text = ds.Tables[0].Rows[0]["c_contact"].ToString();
                lblAddress.Text = ds.Tables[0].Rows[0]["c_address"].ToString();
                lblCity.Text = ds.Tables[0].Rows[0]["c_city"].ToString();
                lblState.Text = ds.Tables[0].Rows[0]["c_state"].ToString();
                lblPincode.Text = ds.Tables[0].Rows[0]["c_pincode"].ToString();
                lblContactPerson.Text = ds.Tables[0].Rows[0]["c_hr_name"].ToString();
                lblHRDesignation.Text = ds.Tables[0].Rows[0]["c_hr_designation"].ToString();

                // LinkedIn
                hlLinkedIn.Text = ds.Tables[0].Rows[0]["c_linkedin"].ToString();
                hlLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["c_linkedin"].ToString();

                // Internships
                loadCompanyInternships(id);
            }
            else
            {
                divNotFound.Visible = true;
                divDetails.Visible = false;
            }
        }

        void loadCompanyInternships(string companyId)
        {
            da = new SqlDataAdapter("select * from internship where CompanyId='" + companyId + "' and Status<>'Inactive' and Status<>'Draft' order by Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            DataListCompanyInternships.DataSource = ds;
            DataListCompanyInternships.DataBind();

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListCompanyInternships.Visible = true;
                divNoInternships.Visible = false;
            }
            else
            {
                DataListCompanyInternships.Visible = false;
                divNoInternships.Visible = true;
            }
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class student_company_details : System.Web.UI.Page
    {
        StudentClass stu = new StudentClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] != null)
            {
                if (!IsPostBack)
                {
                    companyfilldata();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void companyfilldata()
        {
            stu = new StudentClass();
            string companyId = Request.QueryString["CompanyId"] ?? Request.QueryString["id"];

            if (string.IsNullOrEmpty(companyId))
            {
                pnlNotFound.Visible = true;
                pnlDetails.Visible = false;
                return;
            }

            DataSet ds = stu.select_company_details(companyId);

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                pnlNotFound.Visible = false;
                pnlDetails.Visible = true;

                // Company Details
                lblCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblIndustry.Text = ds.Tables[0].Rows[0]["c_industry"].ToString();
                lblLocation.Text = ds.Tables[0].Rows[0]["c_city"].ToString() + ", " + ds.Tables[0].Rows[0]["c_state"].ToString();
                hlWebsite.Text = ds.Tables[0].Rows[0]["c_website"].ToString();
                hlWebsite.NavigateUrl = ds.Tables[0].Rows[0]["c_website"].ToString();

                // Company Logo
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
                        if (System.IO.File.Exists(Server.MapPath("~/company_images/" + logo)))
                            imgCompanyLogo.ImageUrl = ResolveUrl("~/company_images/" + logo);
                        else if (System.IO.File.Exists(Server.MapPath("~/compnay_images/" + logo)))
                            imgCompanyLogo.ImageUrl = ResolveUrl("~/compnay_images/" + logo);
                        else
                            imgCompanyLogo.ImageUrl = ResolveUrl("~/CompanyUploads/" + logo);
                    }

                    imgCompanyLogo.Visible = true;
                    pnlLogoInitials.Visible = false;
                }
                else
                {
                    imgCompanyLogo.Visible = false;
                    pnlLogoInitials.Visible = true;
                    lblCompanyInitials.Text = GetInitials(lblCompanyName.Text);
                }

                // Hero Contact
                lblHeroContactPerson.Text = ds.Tables[0].Rows[0]["c_hr_name"].ToString();
                lblHeroEmail.Text = ds.Tables[0].Rows[0]["c_email"].ToString();
                lblHeroPhone.Text = ds.Tables[0].Rows[0]["c_contact"].ToString();

                // Social Links
                hlWebsiteSocial.NavigateUrl = ds.Tables[0].Rows[0]["c_website"].ToString();
                hlEmailSocial.NavigateUrl = "mailto:" + ds.Tables[0].Rows[0]["c_email"].ToString();
                hlCallSocial.NavigateUrl = "tel:" + ds.Tables[0].Rows[0]["c_contact"].ToString();

                // Company Information
                lblFieldCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblFieldIndustry.Text = ds.Tables[0].Rows[0]["c_industry"].ToString();
                lblCompanyType.Text = ds.Tables[0].Rows[0]["c_type"].ToString();
                lblCompanySize.Text = ds.Tables[0].Rows[0]["c_size"].ToString();
                lblFoundedYear.Text = ds.Tables[0].Rows[0]["c_founded_year"].ToString();
                lblDescription.Text = ds.Tables[0].Rows[0]["c_about"].ToString();
                lblHeadquarters.Text = ds.Tables[0].Rows[0]["c_headquarters"].ToString();

                // Business Information
                lblBusinessDomain.Text = ds.Tables[0].Rows[0]["c_business_domain"].ToString();
                lblProductsServices.Text = ds.Tables[0].Rows[0]["c_products"].ToString();
                lblMission.Text = ds.Tables[0].Rows[0]["c_mission"].ToString();
                lblVision.Text = ds.Tables[0].Rows[0]["c_vision"].ToString();

                // HR Details
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
                loadCompanyInternships(companyId);
            }
            else
            {
                pnlNotFound.Visible = true;
                pnlDetails.Visible = false;
            }
        }

        void loadCompanyInternships(string companyId)
        {
            stu = new StudentClass();
            DataSet ds = stu.select_company_internships(companyId);

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataListCompanyInternships.DataSource = ds;
                DataListCompanyInternships.DataBind();
                DataListCompanyInternships.Visible = true;
                pnlNoInternships.Visible = false;
            }
            else
            {
                DataListCompanyInternships.Visible = false;
                pnlNoInternships.Visible = true;
            }
        }

        // LOGO
        private string GetInitials(string name)
        {
            if (string.IsNullOrEmpty(name))
                return "CO";

            string[] parts = name.Split(' ');
            if (parts.Length > 1)
                return (parts[0][0].ToString() + parts[1][0].ToString()).ToUpper();

            return name.Length > 1 ? name.Substring(0, 2).ToUpper() : name.ToUpper();
        }
    }
}

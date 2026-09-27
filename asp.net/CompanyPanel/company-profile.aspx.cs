using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }

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

            da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                // Hero Header Details
                lblCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblIndustry.Text = ds.Tables[0].Rows[0]["c_industry"].ToString();
                lblLocation.Text = ds.Tables[0].Rows[0]["c_city"].ToString() + ", " + ds.Tables[0].Rows[0]["c_state"].ToString();

                hlWebsite.NavigateUrl = ds.Tables[0].Rows[0]["c_website"].ToString();
                hlWebsite.Text = ds.Tables[0].Rows[0]["c_website"].ToString();

                lblHeroContactPerson.Text = ds.Tables[0].Rows[0]["c_hr_name"].ToString();
                lblHeroEmail.Text = ds.Tables[0].Rows[0]["c_email"].ToString();
                lblHeroPhone.Text = ds.Tables[0].Rows[0]["c_contact"].ToString();

                string logo = ds.Tables[0].Rows[0]["c_logo"].ToString();
                if (!string.IsNullOrEmpty(logo))
                {
                    if (!logo.StartsWith("~") && !logo.StartsWith("/"))
                    {
                        logo = "~/CompanyUploads/" + logo;
                    }
                    imgCompanyLogo.ImageUrl = ResolveUrl(logo);
                    imgCompanyLogo.Visible = true;
                    pnlLogoInitials.Visible = false;
                }

                // Tab 1: Overview
                lblFieldCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblFieldIndustry.Text = ds.Tables[0].Rows[0]["c_industry"].ToString();
                lblCompanyType.Text = ds.Tables[0].Rows[0]["c_type"].ToString();
                lblCompanySize.Text = ds.Tables[0].Rows[0]["c_size"].ToString();
                lblFoundedYear.Text = ds.Tables[0].Rows[0]["c_founded_year"].ToString();
                lblDescription.Text = ds.Tables[0].Rows[0]["c_about"].ToString();
                lblHeadquarters.Text = ds.Tables[0].Rows[0]["c_headquarters"].ToString();
                lblWebsiteField.Text = ds.Tables[0].Rows[0]["c_website"].ToString();

                // Tab 2: Company Information
                lblBusinessDomain.Text = ds.Tables[0].Rows[0]["c_business_domain"].ToString();
                lblProductsServices.Text = ds.Tables[0].Rows[0]["c_products"].ToString();
                lblMission.Text = ds.Tables[0].Rows[0]["c_mission"].ToString();
                lblVision.Text = ds.Tables[0].Rows[0]["c_vision"].ToString();

                // Tab 3: Contact Details
                lblEmail.Text = ds.Tables[0].Rows[0]["c_email"].ToString();
                lblPhone.Text = ds.Tables[0].Rows[0]["c_contact"].ToString();
                lblAddress.Text = ds.Tables[0].Rows[0]["c_address"].ToString();
                lblCity.Text = ds.Tables[0].Rows[0]["c_city"].ToString();
                lblState.Text = ds.Tables[0].Rows[0]["c_state"].ToString();
                lblPincode.Text = ds.Tables[0].Rows[0]["c_pincode"].ToString();

                lblContactPerson.Text = ds.Tables[0].Rows[0]["c_hr_name"].ToString();
                lblHRDesignation.Text = ds.Tables[0].Rows[0]["c_hr_designation"].ToString();
                lblAlternateEmail.Text = ds.Tables[0].Rows[0]["c_hr_email"].ToString();
                lblHRContactNumber.Text = ds.Tables[0].Rows[0]["c_hr_contact"].ToString();

                hlLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["c_linkedin"].ToString();
                hlLinkedIn.Text = ds.Tables[0].Rows[0]["c_linkedin"].ToString();

                // Tab 4: Internship Preferences
                lblInternshipDomains.Text = ds.Tables[0].Rows[0]["c_internship_domains"].ToString();
                lblInternshipType.Text = ds.Tables[0].Rows[0]["c_internship_type"].ToString();
                lblPreferredWorkMode.Text = ds.Tables[0].Rows[0]["c_work_mode"].ToString();
                lblPreferredDuration.Text = ds.Tables[0].Rows[0]["c_preferred_duration"].ToString();
                lblRequiredSkills.Text = ds.Tables[0].Rows[0]["c_required_skills"].ToString();
                lblPreferredCourses.Text = ds.Tables[0].Rows[0]["c_preferred_courses"].ToString();
                lblPreferredSemester.Text = ds.Tables[0].Rows[0]["c_preferred_semester"].ToString();
                lblMinimumCGPA.Text = ds.Tables[0].Rows[0]["c_min_cgpa"].ToString();

                //// Tab 5: Activity Overview
                //lblActivityTotalPosts.Text = ds.Tables[0].Rows[0]["c_total_posts"].ToString();
                //lblActivityActiveInternships.Text = ds.Tables[0].Rows[0]["c_active_posts"].ToString();
                //lblActivityTotalApplications.Text = ds.Tables[0].Rows[0]["c_total_apps"].ToString();
                //lblActivityStudentsSelected.Text = ds.Tables[0].Rows[0]["c_selected_apps"].ToString();
                //lblActivityCurrentInterns.Text = ds.Tables[0].Rows[0]["c_current_interns"].ToString();
                //lblActivityCompletedInternships.Text = ds.Tables[0].Rows[0]["c_completed_interns"].ToString();
            }

        }
    }
}

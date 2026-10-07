using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class company_profile : System.Web.UI.Page
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
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

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

        private string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "CO";
            var parts = name.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 1)
            {
                return parts[0].Length >= 2 ? parts[0].Substring(0, 2).ToUpper() : parts[0].ToUpper();
            }
            return (parts[0][0].ToString() + parts[parts.Length - 1][0].ToString()).ToUpper();
        }

        void companyfilldata()
        {
            getcon();

            da = new SqlDataAdapter("SELECT * FROM c_registration WHERE c_email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                int cId = Convert.ToInt32(ds.Tables[0].Rows[0]["CompanyId"]);

                lblCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblIndustry.Text = ds.Tables[0].Rows[0]["c_industry"].ToString();
                lblLocation.Text = ds.Tables[0].Rows[0]["c_city"].ToString() + ", " + ds.Tables[0].Rows[0]["c_state"].ToString();

                hlWebsite.NavigateUrl = ds.Tables[0].Rows[0]["c_website"].ToString();
                hlWebsite.Text = ds.Tables[0].Rows[0]["c_website"].ToString();

                lblHeroContactPerson.Text = ds.Tables[0].Rows[0]["c_hr_name"].ToString();
                lblHeroEmail.Text = ds.Tables[0].Rows[0]["c_email"].ToString();
                lblHeroPhone.Text = ds.Tables[0].Rows[0]["c_contact"].ToString();

                // Logo
                string logo = ds.Tables[0].Rows[0]["c_logo"] != DBNull.Value ? ds.Tables[0].Rows[0]["c_logo"].ToString().Trim() : "";
                if (!string.IsNullOrEmpty(logo))
                {
                    if (logo.StartsWith("http://") || logo.StartsWith("https://"))
                    {
                        imgCompanyLogo.ImageUrl = logo;
                    }
                    else
                    {
                        if (!logo.StartsWith("~") && !logo.StartsWith("/"))
                        {
                            logo = "~/CompanyUploads/" + logo;
                        }
                        imgCompanyLogo.ImageUrl = ResolveUrl(logo);
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
                // ==========================================
                // DYNAMIC STAT CARDS & ACTIVITY CALCULATIONS
                // ==========================================

                // 1. Total Internships
                da = new SqlDataAdapter("SELECT COUNT(*) FROM internship WHERE CompanyId = " + cId, con);
                ds = new DataSet();
                da.Fill(ds);
                string totalInternships = ds.Tables[0].Rows[0][0].ToString();
                lblTotalInternships.Text = totalInternships;
                lblActivityTotalPosts.Text = totalInternships;

                // 2. Active Internships
                da = new SqlDataAdapter("SELECT COUNT(*) FROM internship WHERE CompanyId = " + cId + " AND (Status IS NULL OR (Status <> 'Inactive' AND Status <> 'Draft'))", con);
                ds = new DataSet();
                da.Fill(ds);
                string activeInternships = ds.Tables[0].Rows[0][0].ToString();
                lblActiveInternships.Text = activeInternships;
                lblActivityActiveInternships.Text = activeInternships;

                // 3. Total Applications
                da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE i.CompanyId = " + cId, con);
                ds = new DataSet();
                da.Fill(ds);
                string totalApps = ds.Tables[0].Rows[0][0].ToString();
                lblTotalApplications.Text = totalApps;
                lblActivityTotalApplications.Text = totalApps;

                // 4. Students Selected
                da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE i.CompanyId = " + cId + " AND (a.Status = 'Selected' OR a.Status = 'Accepted')", con);
                ds = new DataSet();
                da.Fill(ds);
                string selectedCount = ds.Tables[0].Rows[0][0].ToString();
                lblStudentsSelected.Text = selectedCount;
                lblActivityStudentsSelected.Text = selectedCount;

                // 5. Current Interns
                lblActivityCurrentInterns.Text = selectedCount;

                // 6. Completed Internships
                da = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyCertificates WHERE CompanyId = " + cId, con);
                ds = new DataSet();
                da.Fill(ds);
                lblActivityCompletedInternships.Text = ds.Tables[0].Rows[0][0].ToString();
            }

        }
    }
}

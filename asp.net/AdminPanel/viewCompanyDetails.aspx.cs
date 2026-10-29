using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class viewCompanyDetails : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

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
                    companyfilldata();
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

        void companyfilldata()
        {
            getcon();
            string companyId = Request.QueryString["id"];
            da = new SqlDataAdapter("SELECT * FROM c_registration WHERE CompanyId='" + companyId + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                pnlNotFound.Visible = false;
                pnlDetails.Visible = true;
                int cId = Convert.ToInt32(ds.Tables[0].Rows[0]["CompanyId"]);
                // Company Details
                lblCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblIndustry.Text = ds.Tables[0].Rows[0]["c_industry"].ToString();
                lblLocation.Text = ds.Tables[0].Rows[0]["c_city"].ToString() + ", " + ds.Tables[0].Rows[0]["c_state"].ToString();
                hlWebsite.Text = ds.Tables[0].Rows[0]["c_website"].ToString();
                hlWebsite.NavigateUrl = ds.Tables[0].Rows[0]["c_website"].ToString();
                // Company Logo DataList
                DataListCompanyLogo.DataSource = ds;
                DataListCompanyLogo.DataBind();
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
                lblWebsiteField.Text = ds.Tables[0].Rows[0]["c_website"].ToString();
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
                lblAlternateEmail.Text = ds.Tables[0].Rows[0]["c_hr_email"].ToString();
                lblHRContactNumber.Text = ds.Tables[0].Rows[0]["c_hr_contact"].ToString();
                // LinkedIn
                hlLinkedIn.Text = ds.Tables[0].Rows[0]["c_linkedin"].ToString();
                hlLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["c_linkedin"].ToString();
                // Internship Preferences
                lblInternshipDomains.Text = ds.Tables[0].Rows[0]["c_internship_domains"].ToString();
                lblInternshipType.Text = ds.Tables[0].Rows[0]["c_internship_type"].ToString();
                lblPreferredWorkMode.Text = ds.Tables[0].Rows[0]["c_work_mode"].ToString();
                lblPreferredDuration.Text = ds.Tables[0].Rows[0]["c_preferred_duration"].ToString();
                lblRequiredSkills.Text = ds.Tables[0].Rows[0]["c_required_skills"].ToString();
                lblPreferredCourses.Text = ds.Tables[0].Rows[0]["c_preferred_courses"].ToString();
                lblPreferredSemester.Text = ds.Tables[0].Rows[0]["c_preferred_semester"].ToString();
                lblMinimumCGPA.Text = ds.Tables[0].Rows[0]["c_min_cgpa"].ToString();
                totalinternships(cId);
                activeinternships(cId);
                totalapplications(cId);
                selectedstudents(cId);
                completedinternships(cId);
            }
            else
            {
                pnlNotFound.Visible = true;
                pnlDetails.Visible = false;
            }
        }

        void totalinternships(int cId)
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM internship WHERE CompanyId=" + cId, con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalInternships.Text = i.ToString();
            lblActivityTotalPosts.Text = i.ToString();
        }

        void activeinternships(int cId)
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM internship WHERE CompanyId=" + cId + " AND (Status IS NULL OR (Status <> 'Inactive' AND Status <> 'Draft'))", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblActiveInternships.Text = i.ToString();
            lblActivityActiveInternships.Text = i.ToString();
        }

        void totalapplications(int cId)
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications a INNER JOIN internship i ON a.InternshipId=i.Id WHERE i.CompanyId=" + cId, con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalApplications.Text = i.ToString();
            lblActivityTotalApplications.Text = i.ToString();
        }

        void selectedstudents(int cId)
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications a INNER JOIN internship i ON a.InternshipId=i.Id WHERE i.CompanyId=" + cId + " AND (a.Status='Selected' OR a.Status='Accepted')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblStudentsSelected.Text = i.ToString();
            lblActivityStudentsSelected.Text = i.ToString();
            lblActivityCurrentInterns.Text = i.ToString();
        }

        void completedinternships(int cId)
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyCertificates WHERE CompanyId=" + cId, con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblActivityCompletedInternships.Text = i.ToString();
        }
    }
}

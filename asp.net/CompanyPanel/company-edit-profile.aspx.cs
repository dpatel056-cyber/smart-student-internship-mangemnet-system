using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_edit_profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string fnm;

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

        void imgupload()
        {
            if (fileProfilePhoto.HasFile)
            {
                string path = Server.MapPath("~/CompanyUploads/");
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }
                fnm = "~/CompanyUploads/" + fileProfilePhoto.FileName;
                fileProfilePhoto.SaveAs(Server.MapPath(fnm));
            }
            else
            {
                fnm = null;
            }
        }

        void companyfilldata()
        {
            getcon();

            da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                // Basic Details
                txtCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                txtIndustry.Text = ds.Tables[0].Rows[0]["c_industry"].ToString();


                ddlCompanyType.SelectedValue = ds.Tables[0].Rows[0]["c_type"].ToString();


                ddlCompanySize.SelectedValue = ds.Tables[0].Rows[0]["c_size"].ToString();

                txtFoundedYear.Text = ds.Tables[0].Rows[0]["c_founded_year"].ToString();
                txtHeadquarters.Text = ds.Tables[0].Rows[0]["c_headquarters"].ToString();
                txtWebsite.Text = ds.Tables[0].Rows[0]["c_website"].ToString();
                txtAboutCompany.Text = ds.Tables[0].Rows[0]["c_about"].ToString();

                // Company Information
                txtBusinessDomain.Text = ds.Tables[0].Rows[0]["c_business_domain"].ToString();
                txtProductsServices.Text = ds.Tables[0].Rows[0]["c_products"].ToString();
                txtMission.Text = ds.Tables[0].Rows[0]["c_mission"].ToString();
                txtVision.Text = ds.Tables[0].Rows[0]["c_vision"].ToString();

                // Contact Details
                txtOfficialEmail.Text = ds.Tables[0].Rows[0]["c_email"].ToString();
                txtOfficialContact.Text = ds.Tables[0].Rows[0]["c_contact"].ToString();
                txtCompanyAddress.Text = ds.Tables[0].Rows[0]["c_address"].ToString();
                txtCompanyCity.Text = ds.Tables[0].Rows[0]["c_city"].ToString();
                txtCompanyState.Text = ds.Tables[0].Rows[0]["c_state"].ToString();
                txtCompanyPincode.Text = ds.Tables[0].Rows[0]["c_pincode"].ToString();

                txtHrName.Text = ds.Tables[0].Rows[0]["c_hr_name"].ToString();
                txtHrDesignation.Text = ds.Tables[0].Rows[0]["c_hr_designation"].ToString();
                txtHrEmail.Text = ds.Tables[0].Rows[0]["c_hr_email"].ToString();
                txtHrContact.Text = ds.Tables[0].Rows[0]["c_hr_contact"].ToString();

                txtLinkedIn.Text = ds.Tables[0].Rows[0]["c_linkedin"].ToString();

                // Internship Preferences
                txtInternshipDomains.Text = ds.Tables[0].Rows[0]["c_internship_domains"].ToString();


                ddlInternshipType.SelectedValue = ds.Tables[0].Rows[0]["c_internship_type"].ToString();


                ddlPreferredWorkMode.SelectedValue = ds.Tables[0].Rows[0]["c_work_mode"].ToString();

                txtPreferredDuration.Text = ds.Tables[0].Rows[0]["c_preferred_duration"].ToString();
                txtRequiredSkills.Text = ds.Tables[0].Rows[0]["c_required_skills"].ToString();
                txtPreferredCourses.Text = ds.Tables[0].Rows[0]["c_preferred_courses"].ToString();
                txtPreferredSemester.Text = ds.Tables[0].Rows[0]["c_preferred_semester"].ToString();
                txtMinimumCGPA.Text = ds.Tables[0].Rows[0]["c_min_cgpa"].ToString();

                string logo = ds.Tables[0].Rows[0]["c_logo"].ToString();
                if (!string.IsNullOrEmpty(logo))
                {
                    if (!logo.StartsWith("~") && !logo.StartsWith("/"))
                    {
                        logo = "~/CompanyUploads/" + logo;
                    }
                    imgProfilePreview.ImageUrl = ResolveUrl(logo);
                }
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            getcon();
            imgupload();

            if (fnm != null)
            {
                cmd = new SqlCommand("update c_registration set c_company='" + txtCompanyName.Text + "',c_industry='" + txtIndustry.Text + "',c_type='" + ddlCompanyType.SelectedValue + "',c_size='" + ddlCompanySize.SelectedValue + "',c_founded_year='" + txtFoundedYear.Text + "',c_headquarters='" + txtHeadquarters.Text + "',c_website='" + txtWebsite.Text + "',c_about='" + txtAboutCompany.Text + "',c_business_domain='" + txtBusinessDomain.Text + "',c_products='" + txtProductsServices.Text + "',c_mission='" + txtMission.Text + "',c_vision='" + txtVision.Text + "',c_email='" + txtOfficialEmail.Text + "',c_contact='" + txtOfficialContact.Text + "',c_address='" + txtCompanyAddress.Text + "',c_city='" + txtCompanyCity.Text + "',c_state='" + txtCompanyState.Text + "',c_pincode='" + txtCompanyPincode.Text + "',c_hr_name='" + txtHrName.Text + "',c_hr_designation='" + txtHrDesignation.Text + "',c_hr_email='" + txtHrEmail.Text + "',c_hr_contact='" + txtHrContact.Text + "',c_linkedin='" + txtLinkedIn.Text + "',c_internship_domains='" + txtInternshipDomains.Text + "',c_internship_type='" + ddlInternshipType.SelectedValue + "',c_work_mode='" + ddlPreferredWorkMode.SelectedValue + "',c_preferred_duration='" + txtPreferredDuration.Text + "',c_required_skills='" + txtRequiredSkills.Text + "',c_preferred_courses='" + txtPreferredCourses.Text + "',c_preferred_semester='" + txtPreferredSemester.Text + "',c_min_cgpa='" + txtMinimumCGPA.Text + "',c_logo='" + fnm + "' where c_email='" + Session["company"] + "'", con);
            }
            else
            {
                cmd = new SqlCommand("update c_registration set c_company='" + txtCompanyName.Text + "',c_industry='" + txtIndustry.Text + "',c_type='" + ddlCompanyType.SelectedValue + "',c_size='" + ddlCompanySize.SelectedValue + "',c_founded_year='" + txtFoundedYear.Text + "',c_headquarters='" + txtHeadquarters.Text + "',c_website='" + txtWebsite.Text + "',c_about='" + txtAboutCompany.Text + "',c_business_domain='" + txtBusinessDomain.Text + "',c_products='" + txtProductsServices.Text + "',c_mission='" + txtMission.Text + "',c_vision='" + txtVision.Text + "',c_email='" + txtOfficialEmail.Text + "',c_contact='" + txtOfficialContact.Text + "',c_address='" + txtCompanyAddress.Text + "',c_city='" + txtCompanyCity.Text + "',c_state='" + txtCompanyState.Text + "',c_pincode='" + txtCompanyPincode.Text + "',c_hr_name='" + txtHrName.Text + "',c_hr_designation='" + txtHrDesignation.Text + "',c_hr_email='" + txtHrEmail.Text + "',c_hr_contact='" + txtHrContact.Text + "',c_linkedin='" + txtLinkedIn.Text + "',c_internship_domains='" + txtInternshipDomains.Text + "',c_internship_type='" + ddlInternshipType.SelectedValue + "',c_work_mode='" + ddlPreferredWorkMode.SelectedValue + "',c_preferred_duration='" + txtPreferredDuration.Text + "',c_required_skills='" + txtRequiredSkills.Text + "',c_preferred_courses='" + txtPreferredCourses.Text + "',c_preferred_semester='" + txtPreferredSemester.Text + "',c_min_cgpa='" + txtMinimumCGPA.Text + "' where c_email='" + Session["company"] + "'", con);
            }

            cmd.ExecuteNonQuery();

            Session["company"] = txtOfficialEmail.Text;
            Response.Redirect("company-profile.aspx");
        }
    }
}
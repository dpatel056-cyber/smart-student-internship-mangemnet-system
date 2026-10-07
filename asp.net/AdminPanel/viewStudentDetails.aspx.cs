using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace asp.net
{
    public partial class viewStudentDetails : System.Web.UI.Page
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
                    studentfilldata();
                    LoadSkills();
                    LoadProjects();
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

        void studentfilldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from Students where StudentId='" + Request.QueryString["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            lblStudentId.Text = ds.Tables[0].Rows[0]["StudentId"].ToString();
            lblFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
            lblFullNameInfo.Text = ds.Tables[0].Rows[0]["FullName"].ToString();

            // Photo
            string photo = ds.Tables[0].Rows[0]["ProfilePhoto"].ToString().Trim();
            if (!string.IsNullOrEmpty(photo))
            {
                if (photo.StartsWith("http://") || photo.StartsWith("https://"))
                {
                    imgStudentPhoto.ImageUrl = photo;
                }
                else if (photo.StartsWith("~") || photo.StartsWith("/"))
                {
                    imgStudentPhoto.ImageUrl = ResolveUrl(photo);
                }
                else
                {
                    imgStudentPhoto.ImageUrl = ResolveUrl("~/StudentUploads/" + photo);
                }

                imgStudentPhoto.Visible = true;
                lblInitials.Visible = false;
            }
            else
            {
                imgStudentPhoto.Visible = false;
                lblInitials.Visible = true;
                lblInitials.Text = GetInitials(lblFullName.Text);
            }

            // Basic Details
            lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            lblEmailInfo.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            lblContact.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
            lblContactInfo.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
            if (ds.Tables[0].Rows[0]["DateOfBirth"] != DBNull.Value && !string.IsNullOrEmpty(ds.Tables[0].Rows[0]["DateOfBirth"].ToString()))
            {
                DateTime dob;
                if (DateTime.TryParse(ds.Tables[0].Rows[0]["DateOfBirth"].ToString(), out dob))
                {
                    lblDob.Text = dob.ToString("dd MMM yyyy");
                }
                else
                {
                    lblDob.Text = ds.Tables[0].Rows[0]["DateOfBirth"].ToString();
                }
            }
            else
            {
                lblDob.Text = "-";
            }
            lblGender.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
            lblAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();

            // Education
            lblEnrollment.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();
            lblEnrollmentInfo.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();
            lblCollege.Text = ds.Tables[0].Rows[0]["College"].ToString();
            lblCollegeHeader.Text = ds.Tables[0].Rows[0]["College"].ToString();
            lblCourse.Text = ds.Tables[0].Rows[0]["Course"].ToString();
            lblCourseHeader.Text = ds.Tables[0].Rows[0]["Course"].ToString();
            lblDepartment.Text = ds.Tables[0].Rows[0]["Department"].ToString();
            lblSemester.Text = ds.Tables[0].Rows[0]["CurrentSemester"].ToString();
            lblGraduationYear.Text = ds.Tables[0].Rows[0]["GraduationYear"].ToString();
            lblCgpa.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();
            lblCgpaInfo.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();

            // Address
            lblCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            lblState.Text = ds.Tables[0].Rows[0]["State"].ToString();
            lblPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();

            // About
            lblAboutMe.Text = ds.Tables[0].Rows[0]["AboutMe"].ToString();

            // Preferences
            lblPreferredDomain.Text = ds.Tables[0].Rows[0]["PreferredDomain"].ToString();
            lblPreferredRole.Text = ds.Tables[0].Rows[0]["PreferredRole"].ToString();
            lblPreferredLocation.Text = ds.Tables[0].Rows[0]["PreferredLocation"].ToString();
            lblWorkMode.Text = ds.Tables[0].Rows[0]["WorkMode"].ToString();
            lblAvailability.Text = ds.Tables[0].Rows[0]["Availability"].ToString();

            // Social Links
            lblLinkedInText.Text = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
            lblGitHubText.Text = ds.Tables[0].Rows[0]["GitHub"].ToString();
            lblPortfolioText.Text = ds.Tables[0].Rows[0]["Portfolio"].ToString();
            hlLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
            hlGitHub.NavigateUrl = ds.Tables[0].Rows[0]["GitHub"].ToString();
            hlPortfolio.NavigateUrl = ds.Tables[0].Rows[0]["Portfolio"].ToString();
            hlHeaderLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
            hlHeaderGitHub.NavigateUrl = ds.Tables[0].Rows[0]["GitHub"].ToString();
            hlHeaderPortfolio.NavigateUrl = ds.Tables[0].Rows[0]["Portfolio"].ToString();

            // Resume
            string resume =
                ds.Tables[0].Rows[0]["Resume"].ToString();

            if (resume != "")
            {
                pnlResumeData.Visible = true;
                lblNoResume.Visible = false;

                string resumeUrl = resume.StartsWith("~") || resume.StartsWith("/") 
                    ? ResolveUrl(resume) 
                    : ResolveUrl("~/StudentUploads/" + resume);

                hlViewResume.NavigateUrl = resumeUrl;
                hlDownloadResume.NavigateUrl = resumeUrl;
                hlDownloadResume.Attributes["download"] = Path.GetFileName(resume);
            }
            else
            {
                pnlResumeData.Visible = false;
                lblNoResume.Visible = true;
                lblNoResume.Text =
                    "No resume uploaded by the student.";
            }
        }

        void LoadSkills()
        {
            getcon();
            da = new SqlDataAdapter("select * from StudentSkills where StudentId='" + Request.QueryString["id"] + "' and SkillCategory='technical'", con);
            ds = new DataSet();
            da.Fill(ds);
            gvTechSkills.DataSource = ds;
            gvTechSkills.DataBind();

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvTechSkills.Visible = true;
                lblNoTechSkills.Visible = false;
            }
            else
            {
                gvTechSkills.Visible = false;
                lblNoTechSkills.Visible = true;
            }

            da = new SqlDataAdapter("select * from StudentSkills where StudentId='" + Request.QueryString["id"] + "' and SkillCategory='soft'", con);
            ds = new DataSet();
            da.Fill(ds);
            gvSoftSkills.DataSource = ds;
            gvSoftSkills.DataBind();

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvSoftSkills.Visible = true;
                lblNoSoftSkills.Visible = false;
            }
            else
            {
                gvSoftSkills.Visible = false;
                lblNoSoftSkills.Visible = true;
            }

            da = new SqlDataAdapter("select * from StudentSkills where StudentId='" + Request.QueryString["id"] + "' and SkillCategory='other'", con);
            ds = new DataSet();
            da.Fill(ds);
            gvOtherSkills.DataSource = ds;
            gvOtherSkills.DataBind();

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvOtherSkills.Visible = true;
                lblNoOtherSkills.Visible = false;
            }
            else
            {
                gvOtherSkills.Visible = false;
                lblNoOtherSkills.Visible = true;
            }
        }

        void LoadProjects()
        {
            getcon();
            da = new SqlDataAdapter("select * from StudentProjects where StudentId='" + Request.QueryString["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvProjects.DataSource = ds;
                gvProjects.DataBind();

                gvProjects.Visible = true;
                lblNoProjects.Visible = false;
            }
            else
            {
                gvProjects.Visible = false;

                lblNoProjects.Text = "No projects available.";
                lblNoProjects.Visible = true;
            }
        }


        //---------------------------------
        string GetInitials(string name)
        {
            if (name == "")
                return "ST";

            string[] parts = name.Split(' ');

            if (parts.Length == 1)
                return parts[0].Substring(0, 1).ToUpper();

            return (parts[0].Substring(0, 1) +
                    parts[parts.Length - 1].Substring(0, 1)).ToUpper();
        }
    }
}

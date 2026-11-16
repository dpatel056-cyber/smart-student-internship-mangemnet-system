using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace asp.net
{
    public partial class company_student_details : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (Request.QueryString["download"] == "1")
                {
                    DownloadStudentResume();
                    return;
                }

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

        string GetStudentId()
        {
            string sid = Request.QueryString["id"];
            if (string.IsNullOrEmpty(sid) && Request.QueryString["appId"] != null)
            {
                getcon();
                cmd = new SqlCommand("SELECT StudentId FROM StudentApplications WHERE ApplicationId=" + Request.QueryString["appId"], con);
                object objId = cmd.ExecuteScalar();
                if (objId != null) sid = objId.ToString();
            }
            return sid;
        }

        public string ResolveStudentPhoto(object photoObj)
        {
            if (photoObj == null || photoObj == DBNull.Value)
            {
                return ResolveUrl("~/student_images/default-avatar.png");
            }
            string photo = photoObj.ToString().Trim();
            if (string.IsNullOrEmpty(photo))
            {
                return ResolveUrl("~/student_images/default-avatar.png");
            }
            if (photo.StartsWith("~/"))
            {
                return ResolveUrl(photo);
            }
            if (photo.StartsWith("/") || photo.StartsWith("http://") || photo.StartsWith("https://"))
            {
                return photo;
            }
            if (photo.StartsWith("student_images/", StringComparison.OrdinalIgnoreCase) ||
                photo.StartsWith("StudentUploads/", StringComparison.OrdinalIgnoreCase) ||
                photo.StartsWith("assets/", StringComparison.OrdinalIgnoreCase))
            {
                return ResolveUrl("~/" + photo);
            }
            return ResolveUrl("~/student_images/" + photo);
        }

        void studentfilldata()
        {
            getcon();
            string sid = GetStudentId();
            if (string.IsNullOrEmpty(sid))
            {
                pnlNotFound.Visible = true;
                pnlDetails.Visible = false;
                return;
            }

            da = new SqlDataAdapter("SELECT StudentId, FullName, DateOfBirth, Gender, Email, ContactNo, Address, City, State, Pincode, AboutMe, PreferredDomain, PreferredRole, PreferredLocation, WorkMode, Availability, LinkedIn, GitHub, Portfolio, EnrollmentNo, College, Course, Department, CurrentSemester, CGPA, GraduationYear, Password, ConfirmPassword, Resume, IsBlocked, Status, RegistrationDate, CASE WHEN ProfilePhoto LIKE '~/%' THEN ProfilePhoto WHEN ProfilePhoto LIKE 'student_images/%' THEN '~/' + ProfilePhoto WHEN ProfilePhoto LIKE 'StudentUploads/%' THEN '~/' + ProfilePhoto WHEN ProfilePhoto LIKE 'assets/%' THEN '~/' + ProfilePhoto WHEN ProfilePhoto IS NOT NULL AND ProfilePhoto <> '' THEN '~/student_images/' + ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM Students WHERE StudentId='" + sid + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                pnlNotFound.Visible = true;
                pnlDetails.Visible = false;
                return;
            }

            pnlNotFound.Visible = false;
            pnlDetails.Visible = true;

            lblStudentId.Text = ds.Tables[0].Rows[0]["StudentId"].ToString();
            lblFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
            lblFullNameInfo.Text = ds.Tables[0].Rows[0]["FullName"].ToString();

            // Photo (DataList bound with Eval)
            DataListStudentPhoto.DataSource = ds;
            DataListStudentPhoto.DataBind();

            // Basic Details
            lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            lblEmailInfo.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            lblContact.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
            lblContactInfo.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
            lblDob.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DateOfBirth"]).ToString("dd MMM yyyy");
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
            string resume = ds.Tables[0].Rows[0]["Resume"].ToString();

            if (resume != "")
            {
                pnlResumeData.Visible = true;
                lblNoResume.Visible = false;

                lblResumeFileName.Text = resume;
                lblResumeDate.Text = "Verified PDF";

                hlViewResume.NavigateUrl = "~/resume_upload/" + resume;
                hlDownloadResume.NavigateUrl = "company-student-details.aspx?id=" + Request.QueryString["id"]  + "&download=1";
            }
            else
            {
                pnlResumeData.Visible = false;
                lblNoResume.Visible = true;
                lblNoResume.Text = "No resume uploaded by the student.";
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

        void DownloadStudentResume()
        {
            getcon();

            da = new SqlDataAdapter("SELECT Resume FROM Students WHERE StudentId='" + Request.QueryString["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            string resume = ds.Tables[0].Rows[0]["Resume"].ToString();
            string path = Server.MapPath("~/resume_upload/" + resume);

            if (resume != "" && File.Exists(path))
            {
                Response.ContentType = "application/pdf";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + resume);
                Response.TransmitFile(path);
                Response.End();
            }
        }
    }
}


using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

namespace asp.net
{
    public partial class company_student_details : System.Web.UI.Page
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
                    studentfilldata();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        private string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "ST";
            var parts = name.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 1)
            {
                return parts[0].Length >= 2 ? parts[0].Substring(0, 2).ToUpper() : parts[0].ToUpper();
            }
            return (parts[0][0].ToString() + parts[parts.Length - 1][0].ToString()).ToUpper();
        }

        string ResolveStudentId()
        {
            string studentId = Request.QueryString["id"];
            string appId = Request.QueryString["appId"];
            string email = Request.QueryString["email"];

            if (!string.IsNullOrEmpty(studentId)) return studentId;

            getcon();
            if (!string.IsNullOrEmpty(appId))
            {
                da = new SqlDataAdapter("SELECT StudentId, StudentEmail FROM StudentApplications WHERE ApplicationId = '" + appId + "'", con);
                DataSet dsA = new DataSet();
                da.Fill(dsA);
                if (dsA.Tables.Count > 0 && dsA.Tables[0].Rows.Count > 0)
                {
                    string sId = dsA.Tables[0].Rows[0]["StudentId"] != DBNull.Value ? dsA.Tables[0].Rows[0]["StudentId"].ToString() : "";
                    if (!string.IsNullOrEmpty(sId) && sId != "0") return sId;

                    string sEmail = dsA.Tables[0].Rows[0]["StudentEmail"].ToString();
                    da = new SqlDataAdapter("SELECT StudentId FROM Students WHERE Email = '" + sEmail + "'", con);
                    DataSet dsS = new DataSet();
                    da.Fill(dsS);
                    if (dsS.Tables.Count > 0 && dsS.Tables[0].Rows.Count > 0)
                    {
                        return dsS.Tables[0].Rows[0]["StudentId"].ToString();
                    }
                }
            }

            if (!string.IsNullOrEmpty(email))
            {
                da = new SqlDataAdapter("SELECT StudentId FROM Students WHERE Email = '" + email + "'", con);
                DataSet dsE = new DataSet();
                da.Fill(dsE);
                if (dsE.Tables.Count > 0 && dsE.Tables[0].Rows.Count > 0)
                {
                    return dsE.Tables[0].Rows[0]["StudentId"].ToString();
                }
            }

            return "";
        }

        void studentfilldata()
        {
            getcon();
            string sId = ResolveStudentId();

            if (string.IsNullOrEmpty(sId))
            {
                // Try to load basic info if appId exists
                string appId = Request.QueryString["appId"];
                if (!string.IsNullOrEmpty(appId))
                {
                    LoadFromApplicationOnly(appId);
                    return;
                }

                pnlNotFound.Visible = true;
                pnlDetails.Visible = false;
                return;
            }

            da = new SqlDataAdapter("SELECT * FROM Students WHERE StudentId='" + sId + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                pnlNotFound.Visible = false;
                pnlDetails.Visible = true;

                lblStudentId.Text = ds.Tables[0].Rows[0]["StudentId"].ToString();
                lblFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                lblFullNameInfo.Text = ds.Tables[0].Rows[0]["FullName"].ToString();

                string photo = ds.Tables[0].Rows[0]["ProfilePhoto"] != DBNull.Value ? ds.Tables[0].Rows[0]["ProfilePhoto"].ToString() : "";
                if (!string.IsNullOrEmpty(photo))
                {
                    if (!photo.StartsWith("~") && !photo.StartsWith("/"))
                    {
                        photo = "~/StudentUploads/" + photo;
                    }
                    imgStudentPhoto.ImageUrl = ResolveUrl(photo);
                    imgStudentPhoto.Visible = true;
                    lblInitials.Visible = false;
                }
                else
                {
                    imgStudentPhoto.Visible = false;
                    lblInitials.Visible = true;
                    lblInitials.Text = GetInitials(lblFullName.Text);
                }

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

                lblEnrollment.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();
                lblEnrollmentInfo.Text = lblEnrollment.Text;

                lblCollege.Text = ds.Tables[0].Rows[0]["College"].ToString();
                lblCollegeHeader.Text = lblCollege.Text;

                lblCourse.Text = ds.Tables[0].Rows[0]["Course"].ToString();
                lblCourseHeader.Text = lblCourse.Text;

                lblDepartment.Text = ds.Tables[0].Rows[0]["Department"].ToString();
                lblSemester.Text = ds.Tables[0].Rows[0]["CurrentSemester"].ToString();
                lblGraduationYear.Text = ds.Tables[0].Rows[0]["GraduationYear"].ToString();

                lblCgpa.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();
                lblCgpaInfo.Text = lblCgpa.Text;

                lblCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                lblState.Text = ds.Tables[0].Rows[0]["State"].ToString();
                lblPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();

                lblAboutMe.Text = ds.Tables[0].Rows[0]["AboutMe"].ToString();

                if (string.IsNullOrWhiteSpace(lblAboutMe.Text))
                {
                    lblAboutMe.Text = "No bio provided.";
                }

                lblPreferredDomain.Text = ds.Tables[0].Rows[0]["PreferredDomain"].ToString();
                lblPreferredRole.Text = ds.Tables[0].Rows[0]["PreferredRole"].ToString();
                lblPreferredLocation.Text = ds.Tables[0].Rows[0]["PreferredLocation"].ToString();
                lblWorkMode.Text = ds.Tables[0].Rows[0]["WorkMode"].ToString();
                lblAvailability.Text = ds.Tables[0].Rows[0]["Availability"].ToString();

                lblLinkedInText.Text = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                lblGitHubText.Text = ds.Tables[0].Rows[0]["GitHub"].ToString();
                lblPortfolioText.Text = ds.Tables[0].Rows[0]["Portfolio"].ToString();

                hlLinkedIn.NavigateUrl = lblLinkedInText.Text;
                hlGitHub.NavigateUrl = lblGitHubText.Text;
                hlPortfolio.NavigateUrl = lblPortfolioText.Text;

                hlHeaderLinkedIn.NavigateUrl = lblLinkedInText.Text;
                hlHeaderGitHub.NavigateUrl = lblGitHubText.Text;
                hlHeaderPortfolio.NavigateUrl = lblPortfolioText.Text;

                // Resume
                string resume = ds.Tables[0].Rows[0]["Resume"] != DBNull.Value ? ds.Tables[0].Rows[0]["Resume"].ToString() : "";
                if (!string.IsNullOrEmpty(resume))
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
                    lblNoResume.Text = "No resume uploaded by the student.";
                }

                LoadSkills(sId);
                LoadProjects(sId);
            }
            else
            {
                pnlNotFound.Visible = true;
                pnlDetails.Visible = false;
            }
        }

        void LoadFromApplicationOnly(string appId)
        {
            da = new SqlDataAdapter("SELECT * FROM StudentApplications WHERE ApplicationId = '" + appId + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                pnlNotFound.Visible = false;
                pnlDetails.Visible = true;
                DataRow r = ds.Tables[0].Rows[0];

                lblStudentId.Text = appId;
                lblFullName.Text = r["FullName"].ToString();
                lblFullNameInfo.Text = r["FullName"].ToString();
                imgStudentPhoto.Visible = false;
                lblInitials.Visible = true;
                lblInitials.Text = GetInitials(lblFullName.Text);

                lblEmail.Text = r["StudentEmail"].ToString();
                lblEmailInfo.Text = r["StudentEmail"].ToString();
                lblContact.Text = r["ContactNo"].ToString();
                lblContactInfo.Text = r["ContactNo"].ToString();

                lblCollege.Text = r["College"].ToString();
                lblCollegeHeader.Text = r["College"].ToString();
                lblCourse.Text = r["Course"].ToString();
                lblCourseHeader.Text = r["Course"].ToString();
                lblDepartment.Text = r["Department"].ToString();
                lblSemester.Text = r["Semester"].ToString();
                lblCgpa.Text = r["CGPA"].ToString();
                lblCgpaInfo.Text = r["CGPA"].ToString();

                string resume = r["ResumePath"] != DBNull.Value ? r["ResumePath"].ToString() : "";
                if (!string.IsNullOrEmpty(resume))
                {
                    pnlResumeData.Visible = true;
                    lblNoResume.Visible = false;
                    lblResumeFileName.Text = resume;
                    lblResumeDate.Text = "Application Resume";
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
                }
            }
            else
            {
                pnlNotFound.Visible = true;
                pnlDetails.Visible = false;
            }
        }

        void LoadSkills(string sId)
        {
            getcon();

            da = new SqlDataAdapter("SELECT * FROM StudentSkills WHERE StudentId='" + sId + "' AND SkillCategory='technical'", con);
            ds = new DataSet();
            da.Fill(ds);
            gvTechSkills.DataSource = ds;
            gvTechSkills.DataBind();
            gvTechSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoTechSkills.Visible = ds.Tables[0].Rows.Count == 0;

            da = new SqlDataAdapter("SELECT * FROM StudentSkills WHERE StudentId='" + sId + "' AND SkillCategory='soft'", con);
            ds = new DataSet();
            da.Fill(ds);
            gvSoftSkills.DataSource = ds;
            gvSoftSkills.DataBind();
            gvSoftSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoSoftSkills.Visible = ds.Tables[0].Rows.Count == 0;

            da = new SqlDataAdapter("SELECT * FROM StudentSkills WHERE StudentId='" + sId + "' AND SkillCategory='other'", con);
            ds = new DataSet();
            da.Fill(ds);
            gvOtherSkills.DataSource = ds;
            gvOtherSkills.DataBind();
            gvOtherSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoOtherSkills.Visible = ds.Tables[0].Rows.Count == 0;
        }

        void LoadProjects(string sId)
        {
            getcon();

            da = new SqlDataAdapter("SELECT * FROM StudentProjects WHERE StudentId='" + sId + "'", con);
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
                lblNoProjects.CssClass = "no-projects-text";
                lblNoProjects.Visible = true;
            }
        }
    }
}

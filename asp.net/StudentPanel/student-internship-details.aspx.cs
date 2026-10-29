using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Web.UI;

namespace asp.net
{
    public partial class student_internship_details : System.Web.UI.Page
    {
        StudentClass stu = new StudentClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                loadInternshipDetails();
                LoadStudentProfileForModal();

                if (Request.QueryString["apply"] == "1")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "autoOpenModal", "setTimeout(openApplyModal, 300);", true);
                }
            }
        }

        void loadInternshipDetails()
        {
            stu = new StudentClass();
            string internshipId = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";
            DataSet ds = stu.select_internship_details(internshipId);

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataListInternshipDetail.DataSource = ds;
                DataListInternshipDetail.DataBind();

                DataListInternshipDetail.Visible = true;
                divNotFound.Visible = false;

                lblModalRoleTitle.Text = ds.Tables[0].Rows[0]["InternshipTitle"].ToString();
                lblModalCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
            }
            else
            {
                DataListInternshipDetail.Visible = false;
                divNotFound.Visible = true;
            }
        }

        void LoadStudentProfileForModal()
        {
            string studentKey = Session["student"].ToString();
            stu = new StudentClass();
            DataSet ds = stu.get_student_info(studentKey);

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataRow r = ds.Tables[0].Rows[0];
                txtApplicantName.Text = r["FullName"] != DBNull.Value ? r["FullName"].ToString() : "";
                txtApplicantEmail.Text = r["Email"] != DBNull.Value ? r["Email"].ToString() : studentKey;
                txtApplicantMobile.Text = r["ContactNo"] != DBNull.Value ? r["ContactNo"].ToString() : "";
                txtApplicantCollege.Text = r["College"] != DBNull.Value ? r["College"].ToString() : "";
                txtApplicantCourse.Text = r["Course"] != DBNull.Value ? r["Course"].ToString() : "";
                txtApplicantSemester.Text = r["CurrentSemester"] != DBNull.Value ? r["CurrentSemester"].ToString() : "";
                txtApplicantCGPA.Text = r["CGPA"] != DBNull.Value ? r["CGPA"].ToString() : "";

                string resume = r["Resume"] != DBNull.Value ? r["Resume"].ToString() : "";
                hfProfileResume.Value = resume;

                if (!string.IsNullOrEmpty(resume))
                {
                    divCurrentResume.Visible = true;
                    lblCurrentResumeName.Text = resume;
                    lblUploadResumePrompt.Text = "Upload a different resume if desired (otherwise your profile resume will be attached):";
                }
                else
                {
                    divCurrentResume.Visible = false;
                    lblUploadResumePrompt.Text = "Attach your Resume / CV in PDF or DOC format:";
                }
            }
            else
            {
                txtApplicantEmail.Text = studentKey;
            }
        }

        protected void btnSubmitApplication_Click(object sender, ImageClickEventArgs e)
        {
            if (Request.QueryString["id"] == null)
            {
                return;
            }

            string internshipId = Request.QueryString["id"].ToString();
            string studentKey = Session["student"].ToString();

            if (string.IsNullOrWhiteSpace(txtApplicantName.Text) || string.IsNullOrWhiteSpace(txtApplicantEmail.Text))
            {
                lblModalError.Visible = true;
                lblModalError.Text = "Please fill in all required contact information.";
                ScriptManager.RegisterStartupScript(this, GetType(), "reopenModal", "openApplyModal();", true);
                return;
            }

            stu = new StudentClass();
            if (stu.check_already_applied(studentKey, internshipId))
            {
                Response.Redirect("~/StudentPanel/student-my-applications.aspx");
                return;
            }

            string resumeFileName = hfProfileResume.Value;

            if (fuApplicantResume.HasFile)
            {
                string ext = Path.GetExtension(fuApplicantResume.FileName).ToLower();
                if (ext == ".pdf" || ext == ".doc" || ext == ".docx")
                {
                    string folderPath = Server.MapPath("~/StudentUploads/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    resumeFileName = Guid.NewGuid().ToString("N").Substring(0, 8) + "_" + Path.GetFileName(fuApplicantResume.FileName);
                    fuApplicantResume.SaveAs(Path.Combine(folderPath, resumeFileName));
                }
                else
                {
                    lblModalError.Visible = true;
                    lblModalError.Text = "Please upload a valid PDF or DOC file for your resume.";
                    ScriptManager.RegisterStartupScript(this, GetType(), "reopenModal", "openApplyModal();", true);
                    return;
                }
            }

            if (string.IsNullOrEmpty(resumeFileName))
            {
                lblModalError.Visible = true;
                lblModalError.Text = "Please upload your resume to complete the application.";
                ScriptManager.RegisterStartupScript(this, GetType(), "reopenModal", "openApplyModal();", true);
                return;
            }

            stu.submit_internship_application(
                internshipId,
                studentKey,
                txtApplicantName.Text,
                txtApplicantMobile.Text,
                txtApplicantCollege.Text,
                txtApplicantCourse.Text,
                txtApplicantSemester.Text,
                txtApplicantCGPA.Text,
                ddlApplicantAvailability.SelectedValue,
                resumeFileName,
                txtApplicantCoverLetter.Text
            );

            Response.Redirect("~/StudentPanel/student-my-applications.aspx?applied=1");
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            if (Request.QueryString["id"] != null && Session["student"] != null)
            {
                string internshipId = Request.QueryString["id"].ToString();
                string studentKey = Session["student"].ToString();

                stu = new StudentClass();
                stu.save_internship(studentKey, internshipId);

                ScriptManager.RegisterStartupScript(this, GetType(), "saveAlert", "alert('Internship saved to your Saved Internships list!');", true);
            }
        }

        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj == null || logoObj == DBNull.Value)
                return ResolveUrl("~/CompanyUploads/default-company.png");

            string logo = logoObj.ToString().Trim();
            if (string.IsNullOrEmpty(logo))
                return ResolveUrl("~/CompanyUploads/default-company.png");

            if (logo.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || logo.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                return logo;

            if (logo.StartsWith("~"))
                return ResolveUrl(logo);

            if (logo.StartsWith("/"))
                return ResolveUrl("~" + logo);

            if (System.IO.File.Exists(Server.MapPath("~/company_images/" + logo)))
                return ResolveUrl("~/company_images/" + logo);
            if (System.IO.File.Exists(Server.MapPath("~/compnay_images/" + logo)))
                return ResolveUrl("~/compnay_images/" + logo);
            return ResolveUrl("~/CompanyUploads/" + logo);
        }
    }
}

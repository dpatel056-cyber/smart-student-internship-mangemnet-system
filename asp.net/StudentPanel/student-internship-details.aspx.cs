using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace asp.net
{
    public partial class student_internship_details : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            

            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    LoadInternshipDetails();
                    LoadStudentProfileForModal();
                    CheckIfAlreadyApplied();

                    if (Request.QueryString["apply"] == "1" && pnlApplyBtn.Visible)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "autoOpenModal", "setTimeout(openApplyModal, 300);", true);
                    }
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

        void LoadInternshipDetails()
        {
            string internshipId = Request.QueryString["id"].ToString();
            getcon();
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo, c.c_industry, c.c_location, c.c_about, c.c_website from internship i inner join c_registration c on i.CompanyId=c.CompanyId where i.Id=" + internshipId + " and (c.IsBlocked=0 or c.IsBlocked is null) and (c.Status<>'Blocked' or c.Status is null) and (i.Status is null or (i.Status<>'Inactive' and i.Status<>'Draft'))", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblTitle.Text = ds.Tables[0].Rows[0]["InternshipTitle"].ToString();
                lblModalRoleTitle.Text = ds.Tables[0].Rows[0]["InternshipTitle"].ToString();
                lblCompany.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblModalCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblLocation.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                if (lblLocation.Text == "") { lblLocation.Text = "Not Specified"; }
                lblWorkMode.Text = ds.Tables[0].Rows[0]["WorkMode"].ToString();
                if (lblWorkMode.Text == "") { lblWorkMode.Text = "Full Time"; }
                lblStipend.Text = ds.Tables[0].Rows[0]["StipendAmount"].ToString();
                if (lblStipend.Text == "") { lblStipend.Text = "Unpaid / Fixed"; }
                lblDuration.Text = ds.Tables[0].Rows[0]["Duration"].ToString();
                if (lblDuration.Text == "") { lblDuration.Text = "Flexible"; }
                lblOverview.Text = ds.Tables[0].Rows[0]["InternshipDescription"].ToString();
                lblResponsibilities.Text = ds.Tables[0].Rows[0]["Responsibilities"].ToString();
                if (lblResponsibilities.Text == "") { lblResponsibilities.Text = "As assigned by team lead."; }
                lblQualifications.Text = ds.Tables[0].Rows[0]["RequiredQualifications"].ToString();
                if (lblQualifications.Text == "") { lblQualifications.Text = "Relevant degree or skills."; }
                lblSkills.Text = ds.Tables[0].Rows[0]["RequiredSkills"].ToString();
                if (lblSkills.Text == "") { lblSkills.Text = "Core fundamentals"; }
                lblBenefits.Text = ds.Tables[0].Rows[0]["Benefits"].ToString();
                if (lblBenefits.Text == "") { lblBenefits.Text = "Certificate, Letter of Recommendation & Mentorship"; }
                lblDomain.Text = ds.Tables[0].Rows[0]["InternshipDomain"].ToString();
                lblType.Text = ds.Tables[0].Rows[0]["InternshipType"].ToString();
                lblSideWorkMode.Text = ds.Tables[0].Rows[0]["WorkMode"].ToString();
                lblOpenings.Text = ds.Tables[0].Rows[0]["NumberOfOpenings"].ToString();
                if (ds.Tables[0].Rows[0]["StartDate"] != DBNull.Value) { lblStartDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["StartDate"]).ToString("dd MMM yyyy"); }
                else { lblStartDate.Text = "Immediate"; }
                if (ds.Tables[0].Rows[0]["ApplicationDeadline"] != DBNull.Value) { lblDeadline.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["ApplicationDeadline"]).ToString("dd MMM yyyy"); }
                else { lblDeadline.Text = "Open until filled"; }

                string companyId = ds.Tables[0].Rows[0]["CompanyId"].ToString();

                string companyUrl = ResolveUrl( "~/StudentPanel/student-company-details.aspx?CompanyId=" + companyId);

                hlCompany.NavigateUrl = companyUrl;
                hlCompanyLogo.NavigateUrl = companyUrl;
                hlViewCompanyProfile.NavigateUrl = companyUrl;

                string about =
                    ds.Tables[0].Rows[0]["c_about"].ToString();

                if (about != "")
                {
                    if (about.Length > 160)
                    {
                        about = about.Substring(0, 160) + "...";
                    }

                    lblCompanyAbout.Text = about;
                }
                else
                {
                    lblCompanyAbout.Text = "Learn more about corporate background, workplace culture, and other active internship opportunities.";
                }

                imgCompanyLogo.ImageUrl = GetCompanyLogo(ds.Tables[0].Rows[0]["c_logo"]);
            }
            else
            {
                Response.Redirect("~/StudentPanel/student-internships.aspx");
            }
        }

        void LoadStudentProfileForModal()
        {
            string studentKey = Session["student"].ToString();

            getcon();

            da = new SqlDataAdapter("select * from Students where Email='" + studentKey + "' or EnrollmentNo='" + studentKey + "'", con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtApplicantName.Text =ds.Tables[0].Rows[0]["FullName"].ToString();

                txtApplicantEmail.Text =ds.Tables[0].Rows[0]["Email"].ToString();

                txtApplicantMobile.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();

                txtApplicantCollege.Text =  ds.Tables[0].Rows[0]["College"].ToString();

                txtApplicantCourse.Text =  ds.Tables[0].Rows[0]["Course"].ToString();

                txtApplicantSemester.Text =  ds.Tables[0].Rows[0]["CurrentSemester"].ToString();

                txtApplicantCGPA.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();

                hfProfileResume.Value = ds.Tables[0].Rows[0]["Resume"].ToString();

                if (hfProfileResume.Value != "")
                {
                    divCurrentResume.Visible = true;

                    lblCurrentResumeName.Text = hfProfileResume.Value;

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

        void CheckIfAlreadyApplied()
        {
            string internshipId = Request.QueryString["id"].ToString();

            string studentKey =Session["student"].ToString();

            getcon();

            da = new SqlDataAdapter("select ApplicationId from StudentApplications where InternshipId=" + internshipId + " and (StudentEmail='" + studentKey + "' or StudentId in (select StudentId from Students where Email='" + studentKey + "' or EnrollmentNo='" + studentKey + "'))", con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                pnlApplyBtn.Visible = false;
                pnlAlreadyApplied.Visible = true;
            }
            else
            {
                pnlApplyBtn.Visible = true;
                pnlAlreadyApplied.Visible = false;
            }
        }

        protected void btnSubmitApplication_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null)
            {
                return;
            }

            string internshipId = Request.QueryString["id"].ToString();

            string studentKey = Session["student"].ToString();

            if (txtApplicantName.Text == "" ||
                txtApplicantEmail.Text == "")
            {
                lblModalError.Visible = true;
                lblModalError.Text ="Please fill in all required contact information.";

                ScriptManager.RegisterStartupScript(this, GetType(), "reopenModal", "openApplyModal();", true); return;
            }

            getcon();

            da = new SqlDataAdapter("select ApplicationId from StudentApplications where InternshipId=" + internshipId + " and (StudentEmail='" + studentKey + "' or StudentId in (select StudentId from Students where Email='" + studentKey + "' or EnrollmentNo='" + studentKey + "'))", con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                Response.Redirect("~/StudentPanel/student-my-applications.aspx");

                return;
            }

            da = new SqlDataAdapter("select StudentId from Students where Email='" + studentKey + "' or EnrollmentNo='" + studentKey + "'", con);

            ds = new DataSet();
            da.Fill(ds);

            string studentId = ds.Tables[0].Rows[0]["StudentId"].ToString();

            string resumeFileName = hfProfileResume.Value;

            if (fuApplicantResume.HasFile)
            {
                string ext =
                    Path.GetExtension(
                        fuApplicantResume.FileName).ToLower();

                if (ext == ".pdf" ||
                    ext == ".doc" ||
                    ext == ".docx")
                {
                    string folderPath =
                        Server.MapPath("~/StudentUploads/");

                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    resumeFileName =
                        Guid.NewGuid().ToString("N").Substring(0, 8) +
                        "_" +
                        Path.GetFileName(
                            fuApplicantResume.FileName);

                    fuApplicantResume.SaveAs(
                        Path.Combine(
                            folderPath,
                            resumeFileName));
                }
                else
                {
                    lblModalError.Visible = true;
                    lblModalError.Text = "Please upload a valid PDF or DOC file for your resume.";

                    ScriptManager.RegisterStartupScript(this, GetType(), "reopenModal", "openApplyModal();", true); return;
                }
            }

            if (resumeFileName == "")
            {
                lblModalError.Visible = true;
                lblModalError.Text = "Please upload your resume to complete the application.";

                ScriptManager.RegisterStartupScript(this, GetType(), "reopenModal", "openApplyModal();", true); return;
            }

            cmd = new SqlCommand("insert into StudentApplications (InternshipId,StudentId,StudentEmail,FullName,ContactNo,College,Course,Semester,CGPA,CoverLetter,ResumePath,Availability,Status,AppliedDate) values(" + internshipId + "," + studentId + ",'" + txtApplicantEmail.Text + "','" + txtApplicantName.Text + "','" + txtApplicantMobile.Text + "','" + txtApplicantCollege.Text + "','" + txtApplicantCourse.Text + "','" + txtApplicantSemester.Text + "','" + txtApplicantCGPA.Text + "','" + txtApplicantCoverLetter.Text + "','" + resumeFileName + "','" + ddlApplicantAvailability.SelectedValue + "','Applied',GETDATE())", con);

            cmd.ExecuteNonQuery();

            Response.Redirect( "~/StudentPanel/student-my-applications.aspx?applied=1");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] != null)
            {
                string internshipId =Request.QueryString["id"].ToString();

                string studentKey =Session["student"].ToString();

                getcon();

                da = new SqlDataAdapter("select StudentId from Students where Email='" + studentKey + "' or EnrollmentNo='" + studentKey + "'", con);

                ds = new DataSet();
                da.Fill(ds);

                string studentId = ds.Tables[0].Rows[0]["StudentId"].ToString();

                cmd = new SqlCommand("if not exists (select 1 from StudentSavedInternships where InternshipId=" + internshipId + " and (StudentEmail='" + studentKey + "' or StudentId=" + studentId + ")) begin insert into StudentSavedInternships (StudentId,StudentEmail,InternshipId,SavedDate) values(" + studentId + ",'" + studentKey + "'," + internshipId + ",GETDATE()) end", con);

                cmd.ExecuteNonQuery();

                lblActionMsg.Visible = true;

                lblActionMsg.Text ="Internship saved to your Saved Internships list!";
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

            return ResolveUrl("~/CompanyUploads/" + logo);
        }
    }
}
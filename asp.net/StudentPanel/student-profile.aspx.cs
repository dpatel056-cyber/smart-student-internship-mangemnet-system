using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net.js
{
    public partial class student_profile : System.Web.UI.Page
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
                cmd = new SqlCommand("select * from Students where Email=@Identity or EnrollmentNo=@Identity", con);
                cmd.Parameters.AddWithValue("@Identity", Session["student"].ToString());
                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    loadStudentProfile();
                    filldata();
                    showSkills();
                    showProjects();
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

        void loadStudentProfile()
        {
            getcon();

            cmd = new SqlCommand("select * from Students where Email=@Identity or EnrollmentNo=@Identity", con);
            cmd.Parameters.AddWithValue("@Identity", Session["student"].ToString());
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lblName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                lblFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                lblCourse.Text = ds.Tables[0].Rows[0]["Course"].ToString();
                lblCollege.Text = ds.Tables[0].Rows[0]["College"].ToString();
                lblHeaderCGPA.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();

                string photo = ds.Tables[0].Rows[0]["ProfilePhoto"].ToString();

                if (photo != "")
                {
                    if (!photo.StartsWith("~") && !photo.StartsWith("/"))
                        photo = "~/StudentUploads/" + photo;

                    imgStudentPhoto.ImageUrl = ResolveUrl(photo);
                    imgStudentPhoto.Visible = true;
                    lblAvatarInitials.Visible = false;
                }
                else
                {
                    imgStudentPhoto.Visible = false;
                    lblAvatarInitials.Visible = true;
                    lblAvatarInitials.Text = "ST";
                }

                lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblMobile.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
                lblEnrollment.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();

                lblGender.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
                lblPersonalEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblPersonalMobile.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
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

                lblAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                lblCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                lblState.Text = ds.Tables[0].Rows[0]["State"].ToString();
                lblPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();
                lblAboutMe.Text = ds.Tables[0].Rows[0]["AboutMe"].ToString();

                lblPreferredDomain.Text = ds.Tables[0].Rows[0]["PreferredDomain"].ToString();
                lblPreferredRole.Text = ds.Tables[0].Rows[0]["PreferredRole"].ToString();
                lblPreferredLocation.Text = ds.Tables[0].Rows[0]["PreferredLocation"].ToString();
                lblWorkMode.Text = ds.Tables[0].Rows[0]["WorkMode"].ToString();
                lblAvailability.Text = ds.Tables[0].Rows[0]["Availability"].ToString();

                hlLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                hlHeaderLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                lblLinkedInText.Text = ds.Tables[0].Rows[0]["LinkedIn"].ToString();

                hlGitHub.NavigateUrl = ds.Tables[0].Rows[0]["GitHub"].ToString();
                hlHeaderGitHub.NavigateUrl = ds.Tables[0].Rows[0]["GitHub"].ToString();
                lblGitHubText.Text = ds.Tables[0].Rows[0]["GitHub"].ToString();

                hlPortfolio.NavigateUrl = ds.Tables[0].Rows[0]["Portfolio"].ToString();
                hlHeaderPortfolio.NavigateUrl = ds.Tables[0].Rows[0]["Portfolio"].ToString();
                lblPortfolioText.Text = ds.Tables[0].Rows[0]["Portfolio"].ToString();

                lblEduEnrollment.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();
                lblEduCollege.Text = ds.Tables[0].Rows[0]["College"].ToString();
                lblEduCourse.Text = ds.Tables[0].Rows[0]["Course"].ToString();
                lblEduDepartment.Text = ds.Tables[0].Rows[0]["Department"].ToString();
                lblEduSemester.Text = ds.Tables[0].Rows[0]["CurrentSemester"].ToString();
                lblEduCgpa.Text = ds.Tables[0].Rows[0]["CGPA"].ToString() + " CGPA";
                lblEduGraduationYear.Text = ds.Tables[0].Rows[0]["GraduationYear"].ToString();

                string resume = ds.Tables[0].Rows[0]["Resume"].ToString();

                if (resume != "")
                {
                    pnlResumeData.Visible = true;
                    pnlResumeUploadArea.Visible = false;
                    lblResumeFileName.Text = resume;
                    lblResumeDate.Text = "Active Resume";
                    hlViewResume.NavigateUrl = resume.StartsWith("~") ? resume : "~/StudentUploads/" + resume;
                    hlViewResume.Visible = true;
                }
                else
                {
                    pnlResumeData.Visible = false;
                    pnlResumeUploadArea.Visible = true;
                }
            }
        }

        void filldata()
        {
            getcon();

            cmd = new SqlCommand("select * from Students where Email=@Identity or EnrollmentNo=@Identity", con);
            cmd.Parameters.AddWithValue("@Identity", Session["student"].ToString());
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtEditFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                txtEditDob.Text = ds.Tables[0].Rows[0]["DateOfBirth"].ToString();
                txtEditEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                txtEditMobile.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
                txtEditEnrollment.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();

                txtEditCollege.Text = ds.Tables[0].Rows[0]["College"].ToString();
                txtEditCourse.Text = ds.Tables[0].Rows[0]["Course"].ToString();
                txtEditDepartment.Text = ds.Tables[0].Rows[0]["Department"].ToString();
                txtEditSemester.Text = ds.Tables[0].Rows[0]["CurrentSemester"].ToString();
                txtEditGraduationYear.Text = ds.Tables[0].Rows[0]["GraduationYear"].ToString();
                txtEditCgpa.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();

                txtEditAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                txtEditCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                txtEditState.Text = ds.Tables[0].Rows[0]["State"].ToString();
                txtEditPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();

                txtEditPreferredDomain.Text = ds.Tables[0].Rows[0]["PreferredDomain"].ToString();
                txtEditPreferredRole.Text = ds.Tables[0].Rows[0]["PreferredRole"].ToString();
                txtEditPreferredLocation.Text = ds.Tables[0].Rows[0]["PreferredLocation"].ToString();
                txtEditAboutMe.Text = ds.Tables[0].Rows[0]["AboutMe"].ToString();

                txtEditLinkedIn.Text = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                txtEditGitHub.Text = ds.Tables[0].Rows[0]["GitHub"].ToString();
                txtEditPortfolio.Text = ds.Tables[0].Rows[0]["Portfolio"].ToString();

                ddlEditGender.SelectedValue = ds.Tables[0].Rows[0]["Gender"].ToString();
                ddlEditWorkMode.SelectedValue = ds.Tables[0].Rows[0]["WorkMode"].ToString();
                ddlEditAvailability.SelectedValue = ds.Tables[0].Rows[0]["Availability"].ToString();
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Students set FullName=@FullName,DateOfBirth=@DateOfBirth,Email=@NewEmail,ContactNo=@ContactNo,EnrollmentNo=@EnrollmentNo,College=@College,Course=@Course,Department=@Department,CurrentSemester=@CurrentSemester,GraduationYear=@GraduationYear,CGPA=@CGPA,Gender=@Gender,Address=@Address,City=@City,State=@State,Pincode=@Pincode,AboutMe=@AboutMe,PreferredDomain=@PreferredDomain,PreferredRole=@PreferredRole,PreferredLocation=@PreferredLocation,WorkMode=@WorkMode,Availability=@Availability,LinkedIn=@LinkedIn,GitHub=@GitHub,Portfolio=@Portfolio where Email=@Identity or EnrollmentNo=@Identity", con);
            cmd.Parameters.AddWithValue("@FullName", txtEditFullName.Text);
            cmd.Parameters.AddWithValue("@DateOfBirth", txtEditDob.Text);
            cmd.Parameters.AddWithValue("@NewEmail", txtEditEmail.Text);
            cmd.Parameters.AddWithValue("@ContactNo", txtEditMobile.Text);
            cmd.Parameters.AddWithValue("@EnrollmentNo", txtEditEnrollment.Text);
            cmd.Parameters.AddWithValue("@College", txtEditCollege.Text);
            cmd.Parameters.AddWithValue("@Course", txtEditCourse.Text);
            cmd.Parameters.AddWithValue("@Department", txtEditDepartment.Text);
            cmd.Parameters.AddWithValue("@CurrentSemester", txtEditSemester.Text);
            cmd.Parameters.AddWithValue("@GraduationYear", txtEditGraduationYear.Text);
            cmd.Parameters.AddWithValue("@CGPA", txtEditCgpa.Text);
            cmd.Parameters.AddWithValue("@Gender", ddlEditGender.SelectedValue);
            cmd.Parameters.AddWithValue("@Address", txtEditAddress.Text);
            cmd.Parameters.AddWithValue("@City", txtEditCity.Text);
            cmd.Parameters.AddWithValue("@State", txtEditState.Text);
            cmd.Parameters.AddWithValue("@Pincode", txtEditPincode.Text);
            cmd.Parameters.AddWithValue("@AboutMe", txtEditAboutMe.Text);
            cmd.Parameters.AddWithValue("@PreferredDomain", txtEditPreferredDomain.Text);
            cmd.Parameters.AddWithValue("@PreferredRole", txtEditPreferredRole.Text);
            cmd.Parameters.AddWithValue("@PreferredLocation", txtEditPreferredLocation.Text);
            cmd.Parameters.AddWithValue("@WorkMode", ddlEditWorkMode.SelectedValue);
            cmd.Parameters.AddWithValue("@Availability", ddlEditAvailability.SelectedValue);
            cmd.Parameters.AddWithValue("@LinkedIn", txtEditLinkedIn.Text);
            cmd.Parameters.AddWithValue("@GitHub", txtEditGitHub.Text);
            cmd.Parameters.AddWithValue("@Portfolio", txtEditPortfolio.Text);
            cmd.Parameters.AddWithValue("@Identity", Session["student"].ToString());
            cmd.ExecuteNonQuery();
            Session["student"] = txtEditEmail.Text;
            Response.Redirect("student-profile.aspx");
        }

        string GetStudentId()
        {
            getcon();
            cmd = new SqlCommand("select StudentId from Students where Email=@Identity or EnrollmentNo=@Identity", con);
            cmd.Parameters.AddWithValue("@Identity", Session["student"].ToString());
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            return ds.Tables[0].Rows[0]["StudentId"].ToString();
        }

        protected void btnEditProfile_Click(object sender, EventArgs e)
        {
            filldata();
        }

        protected void btnAddSkill_Click(object sender, EventArgs e)
        {
            getcon();

            string studentId = GetStudentId();
            cmd = new SqlCommand("insert into StudentSkills(StudentId,SkillCategory,SkillName) values(@StudentId,@SkillCategory,@SkillName)", con);
            cmd.Parameters.AddWithValue("@StudentId", studentId);
            cmd.Parameters.AddWithValue("@SkillCategory", ddlSkillCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@SkillName", txtNewSkillName.Text);

            cmd.ExecuteNonQuery();

            txtNewSkillName.Text = "";
            showSkills();
        }

        void showSkills()
        {
            string studentId = GetStudentId();

            getcon();

            cmd = new SqlCommand("select * from StudentSkills where StudentId=@StudentId and SkillCategory=@SkillCategory", con);
            cmd.Parameters.AddWithValue("@StudentId", studentId);
            cmd.Parameters.AddWithValue("@SkillCategory", "technical");
            da = new SqlDataAdapter(cmd);

            ds = new DataSet();
            da.Fill(ds);

            gvTechSkills.DataSource = ds;
            gvTechSkills.DataBind();
            gvTechSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoTechSkills.Visible = ds.Tables[0].Rows.Count == 0;

            cmd = new SqlCommand("select * from StudentSkills where StudentId=@StudentId and SkillCategory=@SkillCategory", con);
            cmd.Parameters.AddWithValue("@StudentId", studentId);
            cmd.Parameters.AddWithValue("@SkillCategory", "soft");
            da = new SqlDataAdapter(cmd);

            ds = new DataSet();
            da.Fill(ds);

            gvSoftSkills.DataSource = ds;
            gvSoftSkills.DataBind();
            gvSoftSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoSoftSkills.Visible = ds.Tables[0].Rows.Count == 0;

            cmd = new SqlCommand("select * from StudentSkills where StudentId=@StudentId and SkillCategory=@SkillCategory", con);
            cmd.Parameters.AddWithValue("@StudentId", studentId);
            cmd.Parameters.AddWithValue("@SkillCategory", "other");
            da = new SqlDataAdapter(cmd);

            ds = new DataSet();
            da.Fill(ds);

            gvOtherSkills.DataSource = ds;
            gvOtherSkills.DataBind();
            gvOtherSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoOtherSkills.Visible = ds.Tables[0].Rows.Count == 0;
        }

        protected void gvSkills_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteSkill")
            {
                getcon();

                cmd = new SqlCommand("delete from StudentSkills where SkillId=@SkillId and StudentId=@StudentId", con);
                cmd.Parameters.AddWithValue("@SkillId", Convert.ToInt32(e.CommandArgument));
                cmd.Parameters.AddWithValue("@StudentId", GetStudentId());

                cmd.ExecuteNonQuery();

                showSkills();
            }
        }

        void showProjects()
        {
            string studentId = GetStudentId();

            getcon();

            cmd = new SqlCommand("select * from StudentProjects where StudentId=@StudentId", con);
            cmd.Parameters.AddWithValue("@StudentId", studentId);
            da = new SqlDataAdapter(cmd);

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
                lblNoProjects.Text = "No projects added yet.";
                lblNoProjects.Visible = true;
            }
        }

        protected void btnSaveProject_Click(object sender, EventArgs e)
        {
            string studentId = GetStudentId();

            getcon();

            if (hdnProjectId.Value == "")
            {
                cmd = new SqlCommand("insert into StudentProjects(StudentId,ProjectName,ProjectType,Description,TechnologiesUsed,ProjectLink) values(@StudentId,@ProjectName,@ProjectType,@Description,@TechnologiesUsed,@ProjectLink)", con);
            }
            else
            {
                cmd = new SqlCommand("update StudentProjects set ProjectName=@ProjectName,ProjectType=@ProjectType,Description=@Description,TechnologiesUsed=@TechnologiesUsed,ProjectLink=@ProjectLink where ProjectId=@ProjectId and StudentId=@StudentId", con);
                cmd.Parameters.AddWithValue("@ProjectId", Convert.ToInt32(hdnProjectId.Value));
            }
            cmd.Parameters.AddWithValue("@StudentId", studentId);
            cmd.Parameters.AddWithValue("@ProjectName", txtProjectName.Text);
            cmd.Parameters.AddWithValue("@ProjectType", ddlProjectType.SelectedValue);
            cmd.Parameters.AddWithValue("@Description", txtProjectDesc.Text);
            cmd.Parameters.AddWithValue("@TechnologiesUsed", txtProjectTech.Text);
            cmd.Parameters.AddWithValue("@ProjectLink", txtProjectLink.Text);

            cmd.ExecuteNonQuery();

            hdnProjectId.Value = "";
            txtProjectName.Text = "";
            ddlProjectType.SelectedIndex = 0;
            txtProjectDesc.Text = "";
            txtProjectTech.Text = "";
            txtProjectLink.Text = "";

            lblProjectModalTitle.Text = "Add Project";

            showProjects();
        }

        protected void gvProjects_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string studentId = GetStudentId();

            if (e.CommandName == "EditProject")
            {
                hdnProjectId.Value = e.CommandArgument.ToString();

                getcon();

                cmd = new SqlCommand("select * from StudentProjects where ProjectId=@ProjectId and StudentId=@StudentId", con);
                cmd.Parameters.AddWithValue("@ProjectId", Convert.ToInt32(e.CommandArgument));
                cmd.Parameters.AddWithValue("@StudentId", studentId);
                da = new SqlDataAdapter(cmd);

                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtProjectName.Text = ds.Tables[0].Rows[0]["ProjectName"].ToString();
                    ddlProjectType.SelectedValue = ds.Tables[0].Rows[0]["ProjectType"].ToString();
                    txtProjectDesc.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                    txtProjectTech.Text = ds.Tables[0].Rows[0]["TechnologiesUsed"].ToString();
                    txtProjectLink.Text = ds.Tables[0].Rows[0]["ProjectLink"].ToString();

                    lblProjectModalTitle.Text = "Edit Project";
                }
            }

            if (e.CommandName == "DeleteProject")
            {
                getcon();

                cmd = new SqlCommand("delete from StudentProjects where ProjectId=@ProjectId and StudentId=@StudentId", con);
                cmd.Parameters.AddWithValue("@ProjectId", Convert.ToInt32(e.CommandArgument));
                cmd.Parameters.AddWithValue("@StudentId", studentId);

                cmd.ExecuteNonQuery();

                showProjects();
            }
        }

        protected void btnUploadResume_Click(object sender, EventArgs e)
        {
            if (fuResume.HasFile)
            {
                string ext = Path.GetExtension(fuResume.FileName).ToLower();

                if (ext != ".pdf")
                {
                    ScriptManager.RegisterStartupScript(
                        this,
                        this.GetType(),
                        "error",
                        "alert('Please select PDF file only');",
                        true);

                    return;
                }

                string folder = Server.MapPath("~/StudentUploads/");

                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                string studentId = GetStudentId();

                string fileName = "resume_student_" + studentId + "_" +
                                  DateTime.Now.ToString("yyyyMMdd_HHmmss") + ".pdf";

                fuResume.SaveAs(Path.Combine(folder, fileName));

                getcon();

                cmd = new SqlCommand("update Students set Resume=@Resume where Email=@Identity or EnrollmentNo=@Identity", con);
                cmd.Parameters.AddWithValue("@Resume", fileName);
                cmd.Parameters.AddWithValue("@Identity", Session["student"].ToString());

                cmd.ExecuteNonQuery();

                loadStudentProfile();
            }
        }

        protected void btnDownloadResume_Click(object sender, EventArgs e)
        {
            getcon();

            cmd = new SqlCommand("select Resume from Students where Email=@Identity or EnrollmentNo=@Identity", con);
            cmd.Parameters.AddWithValue("@Identity", Session["student"].ToString());
            da = new SqlDataAdapter(cmd);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string fileName = ds.Tables[0].Rows[0]["Resume"].ToString();
                if (fileName.StartsWith("~"))
                {
                    fileName = Path.GetFileName(fileName);
                }
                string path = Server.MapPath("~/StudentUploads/" + fileName);

                if (File.Exists(path))
                {
                    Response.Clear();
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader(
                        "Content-Disposition",
                        "attachment; filename=" + fileName);

                    Response.TransmitFile(path);
                    Response.End();
                }
            }
        }

        protected void btnDeleteResume_Click(object sender, EventArgs e)
        {
            getcon();

            cmd = new SqlCommand("select Resume from Students where Email=@Identity or EnrollmentNo=@Identity", con);
            cmd.Parameters.AddWithValue("@Identity", Session["student"].ToString());
            da = new SqlDataAdapter(cmd);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string fileName = ds.Tables[0].Rows[0]["Resume"].ToString();

                if (fileName != "")
                {
                    if (fileName.StartsWith("~"))
                    {
                        fileName = Path.GetFileName(fileName);
                    }
                    string path = Server.MapPath("~/StudentUploads/" + fileName);

                    if (File.Exists(path))
                        File.Delete(path);
                }
            }

            cmd = new SqlCommand("update Students set Resume=NULL where Email=@Identity or EnrollmentNo=@Identity", con);
            cmd.Parameters.AddWithValue("@Identity", Session["student"].ToString());

            cmd.ExecuteNonQuery();

            loadStudentProfile();
        }
    }
}
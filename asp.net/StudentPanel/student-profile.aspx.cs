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

        string nm, path;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.Form != null)
            {
                Page.Form.Enctype = "multipart/form-data";
            }

            if (Session["student"] != null)
            {
                if (Request.QueryString["download"] == "1")
                {
                    DownloadStudentResume();
                    return;
                }

                getcon();
                cmd = new SqlCommand("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
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

            cmd = new SqlCommand("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
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

                // Photo (DataList bound with Eval)
                DataListStudentPhoto.DataSource = ds;
                DataListStudentPhoto.DataBind();

                lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblMobile.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
                lblEnrollment.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();

                lblGender.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
                lblPersonalEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblPersonalMobile.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();

                lblDob.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DateOfBirth"]).ToString("dd MMM yyyy");
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

                // Resume
                string resume = ds.Tables[0].Rows[0]["Resume"].ToString();

                if (resume != "")
                {
                    pnlResumeData.Visible = true;
                    pnlResumeUploadArea.Visible = false;

                    lblResumeFileName.Text = Path.GetFileName(resume);
                    lblResumeDate.Text = "Verified PDF";

                    hlViewResume.NavigateUrl = "~/resume_upload/" + Path.GetFileName(resume);
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

            cmd = new SqlCommand("select * from Students where Email='"+ Session["student"].ToString() + "' or EnrollmentNo='"+ Session["student"].ToString() + "'", con);
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
            cmd = new SqlCommand("update Students set FullName='" + txtEditFullName.Text +
                "',DateOfBirth='" + txtEditDob.Text +
                "',Email='" + txtEditEmail.Text +
                "',ContactNo='" + txtEditMobile.Text +
                "',EnrollmentNo='" + txtEditEnrollment.Text +
                "',College='" + txtEditCollege.Text +
                "',Course='" + txtEditCourse.Text +
                "',Department='" + txtEditDepartment.Text +
                "',CurrentSemester='" + txtEditSemester.Text +
                "',GraduationYear='" + txtEditGraduationYear.Text +
                "',CGPA='" + txtEditCgpa.Text +
                "',Gender='" + ddlEditGender.SelectedValue +
                "',Address='" + txtEditAddress.Text +
                "',City='" + txtEditCity.Text +
                "',State='" + txtEditState.Text +
                "',Pincode='" + txtEditPincode.Text +
                "',AboutMe='" + txtEditAboutMe.Text +
                "',PreferredDomain='" + txtEditPreferredDomain.Text +
                "',PreferredRole='" + txtEditPreferredRole.Text +
                "',PreferredLocation='" + txtEditPreferredLocation.Text +
                "',WorkMode='" + ddlEditWorkMode.SelectedValue +
                "',Availability='" + ddlEditAvailability.SelectedValue +
                "',LinkedIn='" + txtEditLinkedIn.Text +
                "',GitHub='" + txtEditGitHub.Text +
                "',Portfolio='" + txtEditPortfolio.Text +
                "' where Email='" + Session["student"] +
                "' or EnrollmentNo='" + Session["student"] + "'", con);

            cmd.ExecuteNonQuery();
            Session["student"] = txtEditEmail.Text;
            Response.Redirect("student-profile.aspx");
        }

        string GetStudentId()
        {
            getcon();

            cmd = new SqlCommand("select StudentId from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);

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

            cmd = new SqlCommand("insert into StudentSkills(StudentId,SkillCategory,SkillName) values('" + studentId + "','" + ddlSkillCategory.SelectedValue + "','" + txtNewSkillName.Text + "')", con);

            cmd.ExecuteNonQuery();

            txtNewSkillName.Text = "";
            showSkills();
        }

        void showSkills()
        {
            string studentId = GetStudentId();

            getcon();

            cmd = new SqlCommand("select * from StudentSkills where StudentId='" + studentId + "' and SkillCategory='technical'", con);

            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            gvTechSkills.DataSource = ds;
            gvTechSkills.DataBind();
            gvTechSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoTechSkills.Visible = ds.Tables[0].Rows.Count == 0;

            cmd = new SqlCommand("select * from StudentSkills where StudentId='" + studentId + "' and SkillCategory='soft'", con);

            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            gvSoftSkills.DataSource = ds;
            gvSoftSkills.DataBind();
            gvSoftSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoSoftSkills.Visible = ds.Tables[0].Rows.Count == 0;

            cmd = new SqlCommand("select * from StudentSkills where StudentId='" + studentId + "' and SkillCategory='other'", con);

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

                cmd = new SqlCommand("delete from StudentSkills where SkillId='" + e.CommandArgument + "' and StudentId='" + GetStudentId() + "'", con);

                cmd.ExecuteNonQuery();

                showSkills();
            }
        }

        void showProjects()
        {
            string studentId = GetStudentId();

            getcon();

            cmd = new SqlCommand("select * from StudentProjects where StudentId='" + studentId + "'", con);

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
                cmd = new SqlCommand("insert into StudentProjects(StudentId,ProjectName,ProjectType,Description,TechnologiesUsed,ProjectLink) values('" + studentId + "','" + txtProjectName.Text + "','" + ddlProjectType.SelectedValue + "','" + txtProjectDesc.Text + "','" + txtProjectTech.Text + "','" + txtProjectLink.Text + "')", con);
            }
            else
            {
                cmd = new SqlCommand("update StudentProjects set ProjectName='" + txtProjectName.Text + "',ProjectType='" + ddlProjectType.SelectedValue + "',Description='" + txtProjectDesc.Text + "',TechnologiesUsed='" + txtProjectTech.Text + "',ProjectLink='" + txtProjectLink.Text + "' where ProjectId='" + hdnProjectId.Value + "' and StudentId='" + studentId + "'", con);
            }

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

                cmd = new SqlCommand("select * from StudentProjects where ProjectId='" + e.CommandArgument + "' and StudentId='" + studentId + "'", con);

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

                cmd = new SqlCommand("delete from StudentProjects where ProjectId='" + e.CommandArgument + "' and StudentId='" + studentId + "'", con);

                cmd.ExecuteNonQuery();

                showProjects();
            }
        }
        void upload()
        {
            path = Path.GetExtension(FileUpload1.FileName);
            if (path == ".pdf" || path == ".PDF")
            {
                nm = "resume_upload/" + FileUpload1.FileName;

                FileUpload1.SaveAs(Server.MapPath(nm));
            }
            else if (path != "")
            {
                Response.Write("<script>alert('Only upload pdf file.');</script>");
            }
        }

        protected void btnUploadResume_Click(object sender, EventArgs e)
        {
            upload();
            getcon();

            if (nm != null)
            {
                cmd = new SqlCommand("update Students set Resume='" + nm + "' where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
                cmd.ExecuteNonQuery();
                loadStudentProfile();
            }
        }
        void DownloadStudentResume()
        {
            getcon();

            da = new SqlDataAdapter("SELECT Resume FROM Students WHERE Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string resume = ds.Tables[0].Rows[0]["Resume"].ToString();
                string fileName = Path.GetFileName(resume);
                string path = Server.MapPath("~/resume_upload/" + fileName);

                if (resume != "")
                {
                    Response.ContentType = "application/pdf";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                    Response.TransmitFile(path);
                    Response.End();
                }
            }
        }

        protected void btnDownloadResume_Click(object sender, EventArgs e)
        {
            DownloadStudentResume();
        }
        protected void btnDeleteResume_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Students set Resume=NULL where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
            cmd.ExecuteNonQuery();
            Response.Redirect("student-profile.aspx");
        }
    }
}

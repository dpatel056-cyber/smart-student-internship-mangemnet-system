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
            // FileUpload controls only post their content when the page form is multipart.
           // Page.Form.Enctype = "multipart/form-data";

            if (!IsPostBack)
            {
                loadStudentProfile();
                filldata();
                showSkills();
                showProjects();
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
            da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "'",con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                // Basic Details
                lblName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                lblFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                lblCourse.Text = ds.Tables[0].Rows[0]["Course"].ToString();
                lblCollege.Text = ds.Tables[0].Rows[0]["College"].ToString();
                lblHeaderCGPA.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();

                string photo = ds.Tables[0].Rows[0]["ProfilePhoto"].ToString();
                if (!string.IsNullOrEmpty(photo))
                {
                    if (!photo.StartsWith("~") && !photo.StartsWith("/"))
                    {
                        photo = "~/StudentUploads/" + photo;
                    }
                    imgStudentPhoto.ImageUrl = ResolveUrl(photo);
                    imgStudentPhoto.Visible = true;
                    lblAvatarInitials.Visible = false;
                }

                // Personal Details
                lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblMobile.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
                lblEnrollment.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();

                lblGender.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
                lblPersonalEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblPersonalMobile.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();

                // Date of Birth
                lblDob.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DateOfBirth"]).ToString("dd-MM-yyyy");

                // Address
                lblAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                lblCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                lblState.Text = ds.Tables[0].Rows[0]["State"].ToString();
                lblPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();
                lblAboutMe.Text = ds.Tables[0].Rows[0]["AboutMe"].ToString();

                // Preferences
                lblPreferredDomain.Text = ds.Tables[0].Rows[0]["PreferredDomain"].ToString();

                lblPreferredRole.Text = ds.Tables[0].Rows[0]["PreferredRole"].ToString();

                lblPreferredLocation.Text = ds.Tables[0].Rows[0]["PreferredLocation"].ToString();

                lblWorkMode.Text = ds.Tables[0].Rows[0]["WorkMode"].ToString();

                lblAvailability.Text = ds.Tables[0].Rows[0]["Availability"].ToString();

                // LinkedIn
                hlLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                hlHeaderLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                lblLinkedInText.Text = ds.Tables[0].Rows[0]["LinkedIn"].ToString();

                // GitHub
                hlGitHub.NavigateUrl = ds.Tables[0].Rows[0]["GitHub"].ToString();
                hlHeaderGitHub.NavigateUrl = ds.Tables[0].Rows[0]["GitHub"].ToString();
                lblGitHubText.Text = ds.Tables[0].Rows[0]["GitHub"].ToString();

                // Portfolio
                hlPortfolio.NavigateUrl = ds.Tables[0].Rows[0]["Portfolio"].ToString();
                hlHeaderPortfolio.NavigateUrl = ds.Tables[0].Rows[0]["Portfolio"].ToString();
                lblPortfolioText.Text = ds.Tables[0].Rows[0]["Portfolio"].ToString();

                // Education
                lblEduEnrollment.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();

                lblEduCollege.Text = ds.Tables[0].Rows[0]["College"].ToString();

                lblEduCourse.Text = ds.Tables[0].Rows[0]["Course"].ToString();

                lblEduDepartment.Text = ds.Tables[0].Rows[0]["Department"].ToString();

                lblEduSemester.Text = ds.Tables[0].Rows[0]["CurrentSemester"].ToString();

                lblEduCgpa.Text = ds.Tables[0].Rows[0]["CGPA"].ToString() + " CGPA";

                lblEduGraduationYear.Text = ds.Tables[0].Rows[0]["GraduationYear"].ToString();
            }
        }

        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "'",con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtEditFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();

                txtEditDob.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DateOfBirth"]).ToString("yyyy-MM-dd");

                txtEditEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();

                txtEditEmail.Text =ds.Tables[0].Rows[0]["Email"].ToString();

                txtEditMobile.Text =ds.Tables[0].Rows[0]["ContactNo"].ToString();

                txtEditEnrollment.Text =ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();

                txtEditCollege.Text =ds.Tables[0].Rows[0]["College"].ToString();

                txtEditCourse.Text =ds.Tables[0].Rows[0]["Course"].ToString();

                txtEditDepartment.Text =ds.Tables[0].Rows[0]["Department"].ToString();

                txtEditSemester.Text =ds.Tables[0].Rows[0]["CurrentSemester"].ToString();

                txtEditGraduationYear.Text =ds.Tables[0].Rows[0]["GraduationYear"].ToString();

                txtEditCgpa.Text =ds.Tables[0].Rows[0]["CGPA"].ToString();

                txtEditAddress.Text =ds.Tables[0].Rows[0]["Address"].ToString();

                txtEditCity.Text =ds.Tables[0].Rows[0]["City"].ToString();

                txtEditState.Text =ds.Tables[0].Rows[0]["State"].ToString();

                txtEditPincode.Text =ds.Tables[0].Rows[0]["Pincode"].ToString();

                txtEditPreferredDomain.Text =ds.Tables[0].Rows[0]["PreferredDomain"].ToString();
                txtEditPreferredRole.Text =ds.Tables[0].Rows[0]["PreferredRole"].ToString();

                txtEditPreferredLocation.Text =ds.Tables[0].Rows[0]["PreferredLocation"].ToString();

                txtEditAboutMe.Text =ds.Tables[0].Rows[0]["AboutMe"].ToString();

                txtEditLinkedIn.Text =ds.Tables[0].Rows[0]["LinkedIn"].ToString();

                txtEditGitHub.Text =ds.Tables[0].Rows[0]["GitHub"].ToString();

                txtEditPortfolio.Text =ds.Tables[0].Rows[0]["Portfolio"].ToString();


                ddlEditGender.SelectedValue = ds.Tables[0].Rows[0]["Gender"].ToString();
                ddlEditWorkMode.SelectedValue = ds.Tables[0].Rows[0]["WorkMode"].ToString();
                ddlEditAvailability.SelectedValue = ds.Tables[0].Rows[0]["Availability"].ToString();
            }
        }
        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Students set FullName='" + txtEditFullName.Text + "',DateOfBirth='" + txtEditDob.Text + "',Email='" + txtEditEmail.Text + "',ContactNo='" + txtEditMobile.Text + "',EnrollmentNo='" + txtEditEnrollment.Text + "',College='" + txtEditCollege.Text + "',Course='" + txtEditCourse.Text + "',Department='" + txtEditDepartment.Text + "',CurrentSemester='" + txtEditSemester.Text + "',GraduationYear='" + txtEditGraduationYear.Text + "',CGPA='" + txtEditCgpa.Text + "',Gender='" + ddlEditGender.SelectedValue + "',Address='" + txtEditAddress.Text + "',City='" + txtEditCity.Text + "',State='" + txtEditState.Text + "',Pincode='" + txtEditPincode.Text + "',AboutMe='" + txtEditAboutMe.Text + "',PreferredDomain='" + txtEditPreferredDomain.Text + "',PreferredRole='" + txtEditPreferredRole.Text + "',PreferredLocation='" + txtEditPreferredLocation.Text + "',WorkMode='" + ddlEditWorkMode.SelectedValue + "',Availability='" + ddlEditAvailability.SelectedValue + "',LinkedIn='" + txtEditLinkedIn.Text + "',GitHub='" + txtEditGitHub.Text + "',Portfolio='" + txtEditPortfolio.Text + "' where Email='" + Session["student"] + "'", con);
            cmd.ExecuteNonQuery();

            Session["student"] = txtEditEmail.Text;
            Response.Redirect("student-profile.aspx");
        }
       
        protected void btnEditProfile_Click(object sender, EventArgs e)
        {
            filldata();
        }

        int getStudentId()
        {
            getcon();

            cmd = new SqlCommand("select StudentId from Students where Email='" + Session["student"] + "'",con);

            int id = Convert.ToInt32(cmd.ExecuteScalar());

            return id;
        }


        protected void btnAddSkill_Click(object sender, EventArgs e)
        {
            getcon();

            cmd = new SqlCommand("insert into StudentSkills(StudentId,SkillCategory,SkillName) values('" + getStudentId() + "','" + ddlSkillCategory.SelectedValue + "','" + txtNewSkillName.Text + "')", con);

            cmd.ExecuteNonQuery();

            txtNewSkillName.Text = "";

            showSkills();
        }

        void showSkills()
        {
            getcon();

            da = new SqlDataAdapter("select * from StudentSkills where StudentId='" + getStudentId() + "' and SkillCategory='technical'", con);
            ds = new DataSet();
            da.Fill(ds);
            gvTechSkills.DataSource = ds;
            gvTechSkills.DataBind();
            gvTechSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoTechSkills.Visible = ds.Tables[0].Rows.Count == 0;

            da = new SqlDataAdapter("select * from StudentSkills where StudentId='" + getStudentId() + "' and SkillCategory='soft'", con);
            ds = new DataSet();
            da.Fill(ds);
            gvSoftSkills.DataSource = ds;
            gvSoftSkills.DataBind();
            gvSoftSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoSoftSkills.Visible = ds.Tables[0].Rows.Count == 0;

            da = new SqlDataAdapter("select * from StudentSkills where StudentId='" + getStudentId() + "' and SkillCategory='other'", con);
            ds = new DataSet();
            da.Fill(ds);
            gvOtherSkills.DataSource = ds;
            gvOtherSkills.DataBind();
            gvOtherSkills.Visible = ds.Tables[0].Rows.Count > 0;
            lblNoOtherSkills.Visible = ds.Tables[0].Rows.Count == 0;

            con.Close();
        }

        protected void gvSkills_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteSkill")
            {
                getcon();

                cmd = new SqlCommand("delete from StudentSkills where SkillId='" + e.CommandArgument + "'",con);

                cmd.ExecuteNonQuery();

                showSkills();
            }
        }



        // ==========================================
        // LOAD PROJECTS (SELECT)
        // Concatenation method thi StudentProjects select
        // ==========================================
        void showProjects()
        {
            getcon();

            da = new SqlDataAdapter("select * from StudentProjects where StudentId='" + getStudentId() + "'", con);

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
                lblNoProjects.CssClass = "no-projects-text";
                lblNoProjects.Visible = true;
            }
            con.Close();
        }

        public string FormatTechTags(object techObj)
        {
            if (techObj == null || techObj == DBNull.Value || string.IsNullOrWhiteSpace(techObj.ToString()))
                return "";

            string techStr = techObj.ToString();
            string[] tags = techStr.Split(new char[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries);

            if (tags.Length == 0)
                return "";

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<div class=\"project-info\"><div class=\"project-info-label\"><i class=\"fa-solid fa-microchip\"></i> Technologies Used</div><div class=\"technology-tags\">");
            foreach (string tag in tags)
            {
                sb.Append("<span class=\"tech-tag\">" + Server.HtmlEncode(tag.Trim()) + "</span>");
            }
            sb.Append("</div></div>");
            return sb.ToString();
        }

        public string FormatProjectLink(object linkObj)
        {
            if (linkObj == null || linkObj == DBNull.Value || string.IsNullOrWhiteSpace(linkObj.ToString()))
                return "";

            string link = linkObj.ToString().Trim();
            if (string.IsNullOrEmpty(link))
                return "";

            string targetUrl = link;
            if (!targetUrl.StartsWith("http://", StringComparison.OrdinalIgnoreCase) && !targetUrl.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
            {
                targetUrl = "http://" + targetUrl;
            }

            return "<div class=\"project-links\"><a href=\"" + Server.HtmlEncode(targetUrl) + "\" target=\"_blank\" class=\"project-link-btn\"><i class=\"fa-solid fa-arrow-up-right-from-square\"></i> " + Server.HtmlEncode(link) + "</a></div>";
        }
        // ==========================================
        // SAVE / UPDATE PROJECT (INSERT & UPDATE)
        // Concatenation method thi insert and update
        // ==========================================
        protected void btnSaveProject_Click(object sender, EventArgs e)
        {
            getcon();

            if (hdnProjectId.Value == "")
            {
                cmd = new SqlCommand("insert into StudentProjects (StudentId,ProjectName,ProjectType,Description,TechnologiesUsed,ProjectLink) values('" + getStudentId() + "','" + txtProjectName.Text + "','" + ddlProjectType.SelectedValue + "','" + txtProjectDesc.Text + "','" + txtProjectTech.Text + "','" + txtProjectLink.Text + "')", con);
            }
            else
            {
                cmd = new SqlCommand("update StudentProjects set ProjectName='" + txtProjectName.Text + "',ProjectType='" + ddlProjectType.SelectedValue + "',Description='" + txtProjectDesc.Text + "',TechnologiesUsed='" + txtProjectTech.Text + "',ProjectLink='" + txtProjectLink.Text + "' where ProjectId='" + hdnProjectId.Value + "' and StudentId='" + getStudentId() + "'", con);
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

            ScriptManager.RegisterStartupScript(this,this.GetType(),"SwitchToProjects","sessionStorage.setItem('activeProfileTab','projects'); openProfileTab('projects');",true);
        }
        // ==========================================
        // PROJECT REPEATER ITEM COMMAND (EDIT & DELETE)
        // Concatenation method thi select and delete
        // ==========================================

        protected void gvProjects_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditProject")
            {
                hdnProjectId.Value = e.CommandArgument.ToString();

                getcon();

                da = new SqlDataAdapter("select * from StudentProjects where ProjectId='" +e.CommandArgument + "' and StudentId='" +getStudentId() + "'", con);

                ds = new DataSet();
                da.Fill(ds);

                txtProjectName.Text = ds.Tables[0].Rows[0]["ProjectName"].ToString();
                ddlProjectType.SelectedValue = ds.Tables[0].Rows[0]["ProjectType"].ToString();
                txtProjectDesc.Text = ds.Tables[0].Rows[0]["Description"].ToString();
                txtProjectTech.Text = ds.Tables[0].Rows[0]["TechnologiesUsed"].ToString();
                txtProjectLink.Text = ds.Tables[0].Rows[0]["ProjectLink"].ToString();

                lblProjectModalTitle.Text = "Edit Project";

                ScriptManager.RegisterStartupScript( this,this.GetType(),"openProjectModal","openProjectModal();", true);
            }

            if (e.CommandName == "DeleteProject")
            {
                getcon();

                cmd = new SqlCommand( "delete from StudentProjects where ProjectId='" + e.CommandArgument + "' and StudentId='" +getStudentId() + "'", con);

                cmd.ExecuteNonQuery();

                showProjects();
            }
        }
    }
}






using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class viewStudentDetails : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                studentfilldata();
                LoadSkills();
                LoadProjects();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        string getStudentId()
        {
            return Request.QueryString["id"];
        }

        void studentfilldata()
        {
            getcon();

            da = new SqlDataAdapter(
                "select * from Students where StudentId='" + getStudentId() + "'",
                con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lblStudentId.Text = ds.Tables[0].Rows[0]["StudentId"].ToString();
                lblFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                lblFullNameInfo.Text = ds.Tables[0].Rows[0]["FullName"].ToString();

                string photo = ds.Tables[0].Rows[0]["ProfilePhoto"].ToString();
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

                lblEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                lblEmailInfo.Text = ds.Tables[0].Rows[0]["Email"].ToString();

                lblContact.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
                lblContactInfo.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();

                lblDob.Text = ds.Tables[0].Rows[0]["DateOfBirth"].ToString();
                lblGender.Text = ds.Tables[0].Rows[0]["Gender"].ToString();
                lblAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();

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

                lblCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                lblState.Text = ds.Tables[0].Rows[0]["State"].ToString();
                lblPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();

                lblAboutMe.Text = ds.Tables[0].Rows[0]["AboutMe"].ToString();

                lblPreferredDomain.Text = ds.Tables[0].Rows[0]["PreferredDomain"].ToString();
                lblPreferredRole.Text = ds.Tables[0].Rows[0]["PreferredRole"].ToString();
                lblPreferredLocation.Text = ds.Tables[0].Rows[0]["PreferredLocation"].ToString();
                lblWorkMode.Text = ds.Tables[0].Rows[0]["WorkMode"].ToString();
                lblAvailability.Text = ds.Tables[0].Rows[0]["Availability"].ToString();

                lblLinkedInText.Text = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                lblGitHubText.Text = ds.Tables[0].Rows[0]["GitHub"].ToString();
                lblPortfolioText.Text = ds.Tables[0].Rows[0]["Portfolio"].ToString();

                hlLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                hlGitHub.NavigateUrl = ds.Tables[0].Rows[0]["GitHub"].ToString();
                hlPortfolio.NavigateUrl = ds.Tables[0].Rows[0]["Portfolio"].ToString();

                hlHeaderLinkedIn.NavigateUrl = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                hlHeaderGitHub.NavigateUrl = ds.Tables[0].Rows[0]["GitHub"].ToString();
                hlHeaderPortfolio.NavigateUrl = ds.Tables[0].Rows[0]["Portfolio"].ToString();
            }

            con.Close();
        }

        void LoadSkills()
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

        void LoadProjects()
        {
            getcon();

            da = new SqlDataAdapter(
                "select * from StudentProjects where StudentId='" + getStudentId() + "'",
                con);

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

            con.Close();
        }

        //public string FormatTechTags(object techObj)
        //{
        //    if (techObj == null || techObj == DBNull.Value || string.IsNullOrWhiteSpace(techObj.ToString()))
        //        return "";

        //    string techStr = techObj.ToString();
        //    string[] tags = techStr.Split(new char[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries);

        //    if (tags.Length == 0)
        //        return "";

        //    System.Text.StringBuilder sb = new System.Text.StringBuilder();
        //    sb.Append("<div class=\"project-info\"><div class=\"project-info-label\"><i class=\"fa-solid fa-microchip\"></i> Technologies Used</div><div class=\"technology-tags\">");
        //    foreach (string tag in tags)
        //    {
        //        sb.Append("<span class=\"tech-tag\">" + Server.HtmlEncode(tag.Trim()) + "</span>");
        //    }
        //    sb.Append("</div></div>");
        //    return sb.ToString();
        //}

        //public string FormatProjectLink(object linkObj)
        //{
        //    if (linkObj == null || linkObj == DBNull.Value || string.IsNullOrWhiteSpace(linkObj.ToString()))
        //        return "";

        //    string link = linkObj.ToString().Trim();
        //    if (string.IsNullOrEmpty(link))
        //        return "";

        //    string targetUrl = link;
        //    if (!targetUrl.StartsWith("http://", StringComparison.OrdinalIgnoreCase) && !targetUrl.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
        //    {
        //        targetUrl = "http://" + targetUrl;
        //    }

        //    return "<div class=\"project-links\"><a href=\"" + Server.HtmlEncode(targetUrl) + "\" target=\"_blank\" class=\"project-link-btn\"><i class=\"fa-solid fa-arrow-up-right-from-square\"></i> " + Server.HtmlEncode(link) + "</a></div>";
        //}
    }
}
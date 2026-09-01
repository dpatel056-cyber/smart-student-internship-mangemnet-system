using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_edit_profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Disable unobtrusive validation mode requirement for jQuery
            UnobtrusiveValidationMode = System.Web.UI.UnobtrusiveValidationMode.None;

            // Security Check
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "student")
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadStudentProfileData();
            }
        }

        private void LoadStudentProfileData()
        {
            // Populate student fields if Session data exists
            if (Session["UserName"] != null)
            {
                string fullName = Session["UserName"].ToString();
                string[] nameParts = fullName.Split(' ');
                if (nameParts.Length > 0) txtFirstName.Text = nameParts[0];
                if (nameParts.Length > 1) txtLastName.Text = string.Join(" ", nameParts, 1, nameParts.Length - 1);
            }

            if (Session["UserEmail"] != null)
            {
                txtEmail.Text = Session["UserEmail"].ToString();
            }

            // Ready for real Database Binding:
            // e.g. DataTable dt = GetStudentProfileFromDB(Session["UserId"].ToString());
            // Populate all fields from database record...
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            try
            {
                // Handle Profile Photo Upload
                if (fuProfilePhoto.HasFile)
                {
                    string photoExt = Path.GetExtension(fuProfilePhoto.FileName).ToLower();
                    if (photoExt == ".jpg" || photoExt == ".jpeg" || photoExt == ".png")
                    {
                        string photoFileName = "student_" + Session["UserId"] + photoExt;
                        string photoSavePath = Server.MapPath("~/images/profiles/") + photoFileName;
                        
                        // Ensure directory exists
                        string dir = Server.MapPath("~/images/profiles/");
                        if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);

                        fuProfilePhoto.SaveAs(photoSavePath);
                    }
                }

                // Handle Resume Upload
                if (fuResume.HasFile)
                {
                    string resumeExt = Path.GetExtension(fuResume.FileName).ToLower();
                    if (resumeExt == ".pdf")
                    {
                        string resumeFileName = "resume_" + Session["UserId"] + ".pdf";
                        string resumeSavePath = Server.MapPath("~/uploads/resumes/") + resumeFileName;

                        string dir = Server.MapPath("~/uploads/resumes/");
                        if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);

                        fuResume.SaveAs(resumeSavePath);
                    }
                }

                // Save profile details to database
                // UpdateStudentProfileInDB(...);

                // Show success feedback
                pnlAlert.Visible = true;
                lblAlertMessage.Text = "Profile updated successfully!";
            }
            catch (Exception ex)
            {
                pnlAlert.Visible = true;
                pnlAlert.CssClass = "student-edit-card";
                pnlAlert.Attributes["style"] = "border-left: 4px solid #EF4444; background:#FEF2F2;";
                lblAlertMessage.Text = "An error occurred while saving profile: " + ex.Message;
            }
        }
    }
}

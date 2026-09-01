using System;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_resume : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            // Security Check
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "student")
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCurrentResume();
            }
        }

        private void LoadCurrentResume()
        {
            // In production: Load student resume details from database
            // Example:
            // DataRow dr = GetActiveStudentResume(Session["UserId"].ToString());
            // if (dr != null) { ... pnlCurrentResume.Visible = true; pnlNoResume.Visible = false; }
            // else { pnlCurrentResume.Visible = false; pnlNoResume.Visible = true; }
        }

        protected void btnUploadResume_Click(object sender, EventArgs e)
        {
            if (!fuResumeUpload.HasFile)
            {
                ShowAlert("Please select a PDF resume file to upload.", false);
                return;
            }

            try
            {
                string fileExtension = Path.GetExtension(fuResumeUpload.FileName).ToLower();

                // Validation 1: Only PDF
                if (fileExtension != ".pdf")
                {
                    ShowAlert("Invalid file format! Please upload a PDF file (.pdf) only.", false);
                    return;
                }

                // Validation 2: Maximum 5 MB (5 * 1024 * 1024 bytes)
                if (fuResumeUpload.PostedFile.ContentLength > 5 * 1024 * 1024)
                {
                    ShowAlert("File too large! Maximum allowed file size is 5 MB.", false);
                    return;
                }

                // Safe Server-side filename generation
                string studentId = Session["UserId"] != null ? Session["UserId"].ToString() : "temp";
                string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmss");
                string safeFileName = "resume_student_" + studentId + "_" + timestamp + ".pdf";

                string uploadFolderPath = Server.MapPath("~/uploads/resumes/");

                if (!Directory.Exists(uploadFolderPath))
                {
                    Directory.CreateDirectory(uploadFolderPath);
                }

                string fullSavePath = Path.Combine(uploadFolderPath, safeFileName);
                fuResumeUpload.SaveAs(fullSavePath);

                // Update UI state
                lblCurrentFileName.Text = fuResumeUpload.FileName;
                lblUploadDate.Text = DateTime.Now.ToString("dd MMM yyyy");
                lblFileSize.Text = (fuResumeUpload.PostedFile.ContentLength / (1024.0 * 1024.0)).ToString("0.0") + " MB";

                pnlCurrentResume.Visible = true;
                pnlNoResume.Visible = false;

                ShowAlert("Resume uploaded successfully!", true);
            }
            catch (Exception ex)
            {
                ShowAlert("An error occurred while uploading your resume: " + ex.Message, false);
            }
        }

        protected void btnDownloadResume_Click(object sender, EventArgs e)
        {
            // Download logic
            string fileName = lblCurrentFileName.Text;
            string filePath = Server.MapPath("~/uploads/resumes/" + fileName);

            if (File.Exists(filePath))
            {
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                Response.TransmitFile(filePath);
                Response.End();
            }
            else
            {
                ShowAlert("Resume file for download was not found on server.", false);
            }
        }

        protected void btnConfirmDelete_Click(object sender, EventArgs e)
        {
            // Delete active resume logic
            pnlCurrentResume.Visible = false;
            pnlNoResume.Visible = true;

            ShowAlert("Resume deleted successfully.", true);
        }

        private void ShowAlert(string message, bool isSuccess)
        {
            pnlAlert.Visible = true;
            lblAlertMessage.Text = message;
            if (isSuccess)
            {
                pnlAlert.Attributes["style"] = "border-left: 4px solid #16A34A; background:#F0FDF4; padding:16px 20px;";
            }
            else
            {
                pnlAlert.Attributes["style"] = "border-left: 4px solid #EF4444; background:#FEF2F2; padding:16px 20px;";
            }
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class student_change_password : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string currentPwd = txtCurrentPassword.Text.Trim();
            string newPwd = txtNewPassword.Text.Trim();
            string confirmPwd = txtConfirmPassword.Text.Trim();
            string studentSession = Session["student"].ToString();

            if (string.IsNullOrEmpty(currentPwd) || string.IsNullOrEmpty(newPwd) || string.IsNullOrEmpty(confirmPwd))
            {
                ShowAlert("Please fill in all password fields.", false);
                return;
            }

            if (newPwd.Length < 6)
            {
                ShowAlert("New password must be at least 6 characters long.", false);
                return;
            }

            if (newPwd != confirmPwd)
            {
                ShowAlert("New password and confirm password do not match.", false);
                return;
            }

            if (currentPwd == newPwd)
            {
                ShowAlert("New password cannot be the same as your current password.", false);
                return;
            }

            try
            {
                getcon();

                // 1. Verify Current Password
                string checkQuery = "select count(*) from Students where (Email='" + studentSession + "' or EnrollmentNo='" + studentSession + "') and Password='" + currentPwd + "'";
                cmd = new SqlCommand(checkQuery, con);
                int count = Convert.ToInt32(cmd.ExecuteScalar());

                if (count == 0)
                {
                    ShowAlert("Current password is incorrect. Please try again.", false);
                    con.Close();
                    return;
                }

                // 2. Update Password
                string updateQuery = "update Students set Password='" + newPwd + "' where Email='" + studentSession + "' or EnrollmentNo='" + studentSession + "'";
                cmd = new SqlCommand(updateQuery, con);
                cmd.ExecuteNonQuery();

                con.Close();

                ShowAlert("Your password has been updated successfully!", true);

                // Clear textboxes
                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";
            }
            catch (Exception ex)
            {
                ShowAlert("An error occurred while updating your password. Please try again.", false);
            }
        }

        private void ShowAlert(string msg, bool isSuccess)
        {
            pnlAlert.Visible = true;
            lblMessage.Text = msg;
            if (isSuccess)
            {
                alertBox.Attributes["class"] = "alert-msg alert-success";
                lblAlertIcon.Text = "<i class=\"fa-solid fa-circle-check\"></i>";
            }
            else
            {
                alertBox.Attributes["class"] = "alert-msg alert-danger";
                lblAlertIcon.Text = "<i class=\"fa-solid fa-triangle-exclamation\"></i>";
            }
        }
    }
}

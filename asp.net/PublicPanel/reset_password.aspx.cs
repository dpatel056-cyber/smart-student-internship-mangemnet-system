using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace asp.net
{
    public partial class reset_password : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ResetEmail"] == null || Session["OtpVerified"] == null || Convert.ToBoolean(Session["OtpVerified"]) == false)
            {
                Response.Redirect("~/PublicPanel/forgot_password.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblResetMsg.Text = "";
                litTargetEmail.Text = Session["ResetEmail"].ToString();
            }
        }

        protected void fpResetPasswordBtn_Click(object sender, ImageClickEventArgs e)
        {
            string newPwd = fpNewPassword.Text.Trim();
            string confirmPwd = fpConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(newPwd))
            {
                lblResetMsg.Text = "Please enter a new password.";
                return;
            }

            if (newPwd.Length < 6)
            {
                lblResetMsg.Text = "Password must be at least 6 characters long.";
                return;
            }

            if (newPwd != confirmPwd)
            {
                lblResetMsg.Text = "Passwords do not match. Please re-enter.";
                return;
            }

            string email = Session["ResetEmail"].ToString();
            string role = Session["ResetRole"] != null ? Session["ResetRole"].ToString() : "student";

            getcon();

            if (role == "student")
            {
                cmd = new SqlCommand("UPDATE Students SET Password = '" + newPwd + "', ConfirmPassword = '" + newPwd + "' WHERE Email = '" + email + "' OR EnrollmentNo = '" + email + "'", con);
                cmd.ExecuteNonQuery();
            }
            else if (role == "company")
            {
                cmd = new SqlCommand("UPDATE c_registration SET c_password = '" + newPwd + "', c_confirm = '" + newPwd + "' WHERE c_email = '" + email + "'", con);
                cmd.ExecuteNonQuery();
            }
            else if (role == "admin")
            {
                cmd = new SqlCommand("UPDATE admin_registration SET Password = '" + newPwd + "' WHERE Email = '" + email + "'", con);
                cmd.ExecuteNonQuery();
            }

            // Show success screen
            divResetForm.Visible = false;
            divResetSuccess.Visible = true;
            if (step3Circle != null)
            {
                step3Circle.InnerHtml = "<i class=\"fa-solid fa-check\"></i>";
                step3Circle.Style["background"] = "#10b981";
            }

            // Clear temporary reset sessions
            Session.Remove("ResetOtp");
            Session.Remove("OtpVerified");
        }
    }
}

using System;
using System.Configuration;
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
            if (Session["ResetEmail"] == null || Session["OtpVerified"] == null)
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
            if (fpNewPassword.Text == "")
            {
                lblResetMsg.Text = "Enter new password.";
                return;
            }

            if (fpNewPassword.Text.Length < 6)
            {
                lblResetMsg.Text = "Password must be at least 6 characters.";
                return;
            }

            if (fpNewPassword.Text != fpConfirmPassword.Text)
            {
                lblResetMsg.Text = "Passwords do not match.";
                return;
            }

            string email = Session["ResetEmail"].ToString();
            string role = Session["ResetRole"].ToString();

            getcon();

            if (role == "student")
            {
                cmd = new SqlCommand("UPDATE Students SET Password='" + fpNewPassword.Text + "', ConfirmPassword='" + fpConfirmPassword.Text + "' WHERE Email='" + email + "'", con);
            }
            else if (role == "company")
            {
                cmd = new SqlCommand("UPDATE c_registration SET c_password='" + fpNewPassword.Text + "', c_confirm='" + fpConfirmPassword.Text + "' WHERE c_email='" + email + "'", con);
            }
            else
            {
                cmd = new SqlCommand("UPDATE admin_registration SET Password='" + fpNewPassword.Text + "' WHERE Email='" + email + "'", con);
            }

            cmd.ExecuteNonQuery();

            divResetForm.Visible = false;
            divResetSuccess.Visible = true;

            step3Circle.InnerHtml = "<i class=\"fa-solid fa-check\"></i>";
            step3Circle.Style["background"] = "#10b981";

            Session.Remove("ResetOtp");
            Session.Remove("OtpVerified");
            Session.Remove("ResetEmail");
            Session.Remove("ResetRole");
        }
    }
}

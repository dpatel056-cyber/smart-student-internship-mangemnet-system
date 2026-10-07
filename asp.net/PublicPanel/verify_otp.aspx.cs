using System;
using System.Web.UI;

namespace asp.net
{
    public partial class verify_otp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ResetEmail"] == null || Session["ResetOtp"] == null)
            {
                Response.Redirect("~/PublicPanel/forgot_password.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblOtpError.Text = "";
                string email = Session["ResetEmail"].ToString();
                litMaskedEmail.Text = MaskEmail(email);
                litDemoOtp.Text = Session["ResetOtp"].ToString();
            }
        }

        protected void fpVerifyOtpBtn_Click(object sender, ImageClickEventArgs e)
        {
            string enteredOtp = (otp0.Text + otp1.Text + otp2.Text + otp3.Text + otp4.Text + otp5.Text).Trim();

            if (enteredOtp.Length != 6)
            {
                lblOtpError.Text = "Please enter all 6 digits of the OTP.";
                return;
            }

            string expectedOtp = Session["ResetOtp"] != null ? Session["ResetOtp"].ToString() : "";

            // Check if OTP matches generated OTP or demo 123456
            if (enteredOtp == expectedOtp || enteredOtp == "123456")
            {
                Session["OtpVerified"] = true;
                Response.Redirect("~/PublicPanel/reset_password.aspx");
            }
            else
            {
                lblOtpError.Text = "Invalid OTP. Please enter the correct 6-digit code.";
            }
        }

        private string MaskEmail(string email)
        {
            if (string.IsNullOrEmpty(email) || !email.Contains("@"))
                return email;

            string[] parts = email.Split('@');
            string user = parts[0];
            string domain = parts[1];

            if (user.Length <= 3)
                return user + "***@" + domain;

            return user.Substring(0, 3) + "***@" + domain;
        }
    }
}

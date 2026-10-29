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
            }

            if (!IsPostBack)
            {
                lblOtpError.Text = "";
                litMaskedEmail.Text = Session["ResetEmail"].ToString();
                litDemoOtp.Text = Session["ResetOtp"].ToString();
            }
        }

        protected void fpVerifyOtpBtn_Click(object sender, ImageClickEventArgs e)
        {
            string otp = otp0.Text + otp1.Text + otp2.Text + otp3.Text + otp4.Text + otp5.Text;

            if (otp.Length != 6)
            {
                lblOtpError.Text = "Enter all 6 digits.";
            }
            else if (otp == Session["ResetOtp"].ToString())
            {
                Session["OtpVerified"] = true;
                Response.Redirect("~/PublicPanel/reset_password.aspx");
            }
            else
            {
                lblOtpError.Text = "Invalid OTP.";
            }
        }
    }
}

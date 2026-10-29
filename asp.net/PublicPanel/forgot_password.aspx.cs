using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace asp.net
{
    public partial class forgot_password : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMsg.Text = "";
            }
        }

        protected void fpSendOtpBtn_Click(object sender, ImageClickEventArgs e)
        {
            if (fpEmail.Text == "")
            {
                lblMsg.Text = "Please enter email or enrollment number.";
            }

            getcon();

            // Student check
            da = new SqlDataAdapter("SELECT StudentId, Email, FullName FROM Students WHERE Email = '" + fpEmail.Text + "' OR EnrollmentNo = '" + fpEmail.Text + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                GenerateAndSendOtp(ds.Tables[0].Rows[0]["Email"].ToString(), "student", ds.Tables[0].Rows[0]["FullName"].ToString());
            }

            // Company check
            da = new SqlDataAdapter("SELECT c_email, c_company FROM c_registration WHERE c_email = '" + fpEmail.Text + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                GenerateAndSendOtp(ds.Tables[0].Rows[0]["c_email"].ToString(), "company", ds.Tables[0].Rows[0]["c_company"].ToString());
            }

            // Admin check
            da = new SqlDataAdapter("SELECT Email FROM admin_registration WHERE Email = '" + fpEmail.Text + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                GenerateAndSendOtp(ds.Tables[0].Rows[0]["Email"].ToString(), "admin", "Admin");
            }

            lblMsg.Text = "Account not found.";
        }

        private void GenerateAndSendOtp(string email, string role, string name)
        {
            string otp = new Random().Next(100000, 1000000).ToString();

            Session["ResetEmail"] = email;
            Session["ResetRole"] = role;
            Session["ResetName"] = name;
            Session["ResetOtp"] = otp;
            Session["ResetOtpTime"] = DateTime.Now;

            Response.Redirect("~/PublicPanel/verify_otp.aspx");
        }
    }
}

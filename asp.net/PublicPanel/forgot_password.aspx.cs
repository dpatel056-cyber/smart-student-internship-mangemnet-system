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
        SqlCommand cmd;
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
            string input = fpEmail.Text.Trim();
            if (string.IsNullOrEmpty(input))
            {
                lblMsg.Text = "Please enter your registered email or enrollment number.";
                return;
            }

            getcon();

            // 1. Check Students Table
            da = new SqlDataAdapter("SELECT StudentId, Email, FullName FROM Students WHERE Email = '" + input + "' OR EnrollmentNo = '" + input + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string email = ds.Tables[0].Rows[0]["Email"].ToString();
                string name = ds.Tables[0].Rows[0]["FullName"].ToString();
                GenerateAndSendOtp(email, "student", name);
                return;
            }

            // 2. Check Company Table (c_registration)
            da = new SqlDataAdapter("SELECT CompanyId, c_email, c_company FROM c_registration WHERE c_email = '" + input + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string email = ds.Tables[0].Rows[0]["c_email"].ToString();
                string name = ds.Tables[0].Rows[0]["c_company"].ToString();
                GenerateAndSendOtp(email, "company", name);
                return;
            }

            // 3. Check Admin Table (admin_registration)
            da = new SqlDataAdapter("SELECT Email FROM admin_registration WHERE Email = '" + input + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string email = ds.Tables[0].Rows[0]["Email"].ToString();
                GenerateAndSendOtp(email, "admin", "Admin");
                return;
            }

            // Not found in any table
            lblMsg.Text = "No registered account found with this email or enrollment number.";
        }

        private void GenerateAndSendOtp(string email, string role, string name)
        {
            Random rnd = new Random();
            string otp = rnd.Next(100000, 999999).ToString();

            Session["ResetEmail"] = email;
            Session["ResetRole"] = role;
            Session["ResetName"] = name;
            Session["ResetOtp"] = otp;
            Session["ResetOtpTime"] = DateTime.Now;

            Response.Redirect("~/PublicPanel/verify_otp.aspx");
        }
    }
}

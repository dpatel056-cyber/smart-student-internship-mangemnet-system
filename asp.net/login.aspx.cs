using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Data.SqlClient;
using System.Configuration;
namespace asp.net
{
    public partial class login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
        }

        void getcon() {
            con = new SqlConnection(s);
            con.Open();

        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            getcon();
            string role = hfSelectedRole.Value;
            if (role == "admin")
            {
                if ((txtemail.Text == "admin@sims.com" || txtemail.Text == "SIMS-ADMIN-2026") && txtpassword.Text == "admin123")
                {
                    Session["UserRole"] = "admin";
                    Response.Redirect("AdminPanel/admin-dashboard.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid Admin Login";
                }

                return;
            }
            else if (role == "student")
            {
                if ((txtemail.Text == "student@sims.com") && txtpassword.Text == "student123")
                {
                    Session["UserRole"] = "student";
                    Response.Redirect("student-dashboard.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid student Login";
                }
            }
            else {
                if ((txtemail.Text == "company@sims.com") && txtpassword.Text == "company123")
                {
                    Session["UserRole"] = "company";

                    Response.Redirect("Companydashboard.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid company Login";
                }
            }
        }
    }
}



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
        int i;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            string role = hfSelectedRole.Value;

            if (!(string.IsNullOrEmpty(txtemail.Text)) &&!(string.IsNullOrEmpty(txtpassword.Text)))
            {

                if (role == "admin")
                {
                    if (txtemail.Text == "admin@sims.com" && txtpassword.Text == "admin123")
                    {
                        Session["admin"] = txtemail.Text;
                        Response.Redirect("AdminPanel/admin-dashboard.aspx");
                    }
                    else
                    {
                        lblMsg.Text = "Invalid Admin Email or Password";
                    }
                }
                else if (role == "student")
                {
                    cmd = new SqlCommand("select count(*) from s_registration where (s_email='" + txtemail.Text +"' or s_enrollment='" + txtemail.Text +"') and s_password='" + txtpassword.Text + "'", con);
                    i = Convert.ToInt32(cmd.ExecuteScalar());
                    if (i > 0)
                    {
                        Session["student"] = txtemail.Text;
                        Response.Redirect("StudentPanel/student-dashboard.aspx");
                    }
                    else
                    {
                        lblMsg.Text = "Invalid Student Email/Enrollment or Password";
                    }
                }
                else if (role == "company")
                {
                    cmd = new SqlCommand("select count(*) from c_registration where c_email='" + txtemail.Text + "' and c_password='" + txtpassword.Text + "'",con);
                    i = Convert.ToInt32(cmd.ExecuteScalar());
                    if (i > 0)
                    {
                        Session["company"] = txtemail.Text;
                        Response.Redirect("CompanyPanel/company-dashboard.aspx");
                    }
                    else
                    {
                        lblMsg.Text = "Invalid Company Email or Password";
                    }
                }
                else
                {
                    lblMsg.Text = "Please Select Role";
                }
            }
            else
            {
                lblMsg.Text = "Please Enter Email and Password";
            }
        }
    }
}


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

                con.Open();

        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            getcon();

            // Check current password
            cmd = new SqlCommand(
                "select * from c_registration where c_email='" +
                Session["company"].ToString() +
                "' and c_password='" +
                txtCurrentPassword.Text + "'", con);

            ds = new DataSet();
            da = new SqlDataAdapter(cmd);
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                // Check new and confirm password
                if (txtNewPassword.Text == txtConfirmPassword.Text)
                {
                    cmd = new SqlCommand(
                        "update c_registration set c_password='" +
                        txtNewPassword.Text +
                        "' where c_email='" +
                        Session["company"].ToString() + "'", con);

                    cmd.ExecuteNonQuery();

                    lblMessage.Text = "Password changed successfully.";

                    txtCurrentPassword.Text = "";
                    txtNewPassword.Text = "";
                    txtConfirmPassword.Text = "";
                }
                else
                {
                    lblMessage.Text =
                        "New password and confirm password do not match.";
                }
            }
            else
            {
                lblMessage.Text =
                    "Current password is incorrect.";
            }
        }
    }
}

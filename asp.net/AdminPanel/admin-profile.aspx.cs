using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class admin_profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        void getcon()
        {
            con = new SqlConnection(s);

            con.Open();
        }
        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            getcon();

            cmd = new SqlCommand(
                "select * from admin_registration where Email='" + Session["admin"].ToString() +
                "' and Password='" + txtCurrentPassword.Text + "'", con);

            ds = new DataSet();
            da = new SqlDataAdapter(cmd);
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                cmd = new SqlCommand(
                    "update admin_registration set Password='" + txtNewPassword.Text +
                    "' where Email='" + Session["admin"].ToString() + "'", con);

                cmd.ExecuteNonQuery();

                lblPasswordMessage.Text = "Password changed successfully.";

                txtCurrentPassword.Text = "";
                txtNewPassword.Text = "";
                txtConfirmPassword.Text = "";
            }
            else
            {
                lblPasswordMessage.Text = "Current password is incorrect.";
            }

            con.Close();
        }



    }
}
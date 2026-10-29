using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace asp.net
{
    public partial class company_change_password : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void clear()
        {
            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";
        }

        protected void btnChangePassword_Click(object sender, ImageClickEventArgs e)
        {
            if (txtCurrentPassword.Text == "" || txtNewPassword.Text == "" || txtConfirmPassword.Text == "")
            {
                lblMessage.Text = "Please fill in all required password fields.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.CssClass = "sims-profile-msg msg-error";
                return;
            }

            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.Text = "New password and confirm password do not match.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.CssClass = "sims-profile-msg msg-error";
                return;
            }

            getcon();
            da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "' and c_password='" + txtCurrentPassword.Text + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                cmd = new SqlCommand("update c_registration set c_password='" + txtNewPassword.Text + "', c_confirm='" + txtNewPassword.Text + "' where c_email='" + Session["company"] + "'", con);
                cmd.ExecuteNonQuery();
                lblMessage.Text = "Password changed successfully.";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.CssClass = "sims-profile-msg msg-success";
                clear();
            }
            else
            {
                lblMessage.Text = "Current password is incorrect.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.CssClass = "sims-profile-msg msg-error";
            }
        }
    }
}

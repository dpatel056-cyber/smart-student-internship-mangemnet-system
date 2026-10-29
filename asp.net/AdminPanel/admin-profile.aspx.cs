using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

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
            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from admin_registration where Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    lblAdminEmailView.Text = Session["admin"].ToString();
                }
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

        protected void btnChangePassword_Click(object sender, EventArgs e)
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
            da = new SqlDataAdapter("select * from admin_registration where Email='" + Session["admin"] + "' and Password='" + txtCurrentPassword.Text + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                cmd = new SqlCommand("update admin_registration set Password='" + txtNewPassword.Text + "' where Email='" + Session["admin"] + "'", con);
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

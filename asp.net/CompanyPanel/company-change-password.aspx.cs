using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

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

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (txtCurrentPassword.Text == "" || txtNewPassword.Text == "" || txtConfirmPassword.Text == "")
            {
                lblMessage.Text = "<span style='color:#dc2626;'><i class='fa-solid fa-circle-xmark'></i> Please fill in all required password fields.</span>";
                return;
            }

            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                lblMessage.Text = "<span style='color:#dc2626;'><i class='fa-solid fa-circle-xmark'></i> New password and confirm password do not match.</span>";
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
                lblMessage.Text = "<span style='color:#16a34a;'><i class='fa-solid fa-circle-check'></i> Password changed successfully.</span>";
                clear();
            }
            else
            {
                lblMessage.Text = "<span style='color:#dc2626;'><i class='fa-solid fa-circle-xmark'></i> Current password is incorrect.</span>";
            }
        }
    }
}

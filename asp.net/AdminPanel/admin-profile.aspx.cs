using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

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

        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            if (txtCurrentPassword.Text == "" || txtNewPassword.Text == "" || txtConfirmPassword.Text == "")
            {
                showAlert("Please fill in all required password fields.", "error");
                return;
            }

            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                showAlert("New password and confirm password do not match.", "error");
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
                showAlert("Password changed successfully.", "success");
                clear();
            }
            else
            {
                showAlert("Current password is incorrect.", "error");
            }
        }

        void showAlert(string message, string type)
        {
            pnlPasswordAlert.Visible = true;

            if (type == "success")
            {
                divPasswordAlert.Attributes["class"] = "password-alert success";
                lblPasswordAlertIcon.Text = "<i class='fa-solid fa-circle-check'></i>";
            }
            else
            {
                divPasswordAlert.Attributes["class"] = "password-alert error";
                lblPasswordAlertIcon.Text = "<i class='fa-solid fa-circle-xmark'></i>";
            }

            lblPasswordMessage.Text = message;
        }
    }
}
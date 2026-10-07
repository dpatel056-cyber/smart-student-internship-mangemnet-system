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
            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
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
                showAlert("Please fill in all required password fields.", "error");
                return;
            }

            if (txtNewPassword.Text != txtConfirmPassword.Text)
            {
                showAlert("New password and confirm password do not match.", "error");
                return;
            }

            getcon();
            da = new SqlDataAdapter("select * from Students where (Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "') and Password='" + txtCurrentPassword.Text + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                cmd = new SqlCommand("update Students set Password='" + txtNewPassword.Text + "', ConfirmPassword='" + txtNewPassword.Text + "' where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
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
            pnlAlert.Visible = true;

            if (type == "success")
            {
                alertBox.Attributes["class"] = "alert-msg alert-success";
                lblAlertIcon.Text = "<i class='fa-solid fa-circle-check'></i>";
            }
            else
            {
                alertBox.Attributes["class"] = "alert-msg alert-danger";
                lblAlertIcon.Text = "<i class='fa-solid fa-circle-xmark'></i>";
            }

            lblMessage.Text = message;
        }
    }
}

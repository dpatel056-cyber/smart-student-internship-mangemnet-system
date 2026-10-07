using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

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

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            string role = hfSelectedRole.Value;

            if (!string.IsNullOrEmpty(txtemail.Text) && !string.IsNullOrEmpty(txtpassword.Text))
            {
                if (role == "admin")
                {
                    getcon();
                    da = new SqlDataAdapter("SELECT Email FROM admin_registration WHERE Email = '" + txtemail.Text + "' AND Password = '" + txtpassword.Text + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        Session["admin"] = ds.Tables[0].Rows[0]["Email"].ToString();
                        Response.Redirect("~/AdminPanel/admin-dashboard.aspx");
                    }
                    else
                    {
                        lblMsg.Text = "Invalid Admin Email or Password";
                    }
                }
                else if (role == "student")
                {
                    getcon();
                    da = new SqlDataAdapter("SELECT Email, ISNULL(IsBlocked, 0) AS IsBlocked, ISNULL(Status, 'Active') AS Status FROM Students WHERE (Email = '" + txtemail.Text + "' OR EnrollmentNo = '" + txtemail.Text + "') AND Password = '" + txtpassword.Text + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        bool isBlocked = Convert.ToBoolean(ds.Tables[0].Rows[0]["IsBlocked"]) || ds.Tables[0].Rows[0]["Status"].ToString().Equals("Blocked", StringComparison.OrdinalIgnoreCase);

                        if (isBlocked)
                        {
                            lblMsg.Text = "Your account has been blocked by Admin. Please contact support.";
                            return;
                        }

                        Session["student"] = ds.Tables[0].Rows[0]["Email"].ToString();
                        Response.Redirect("~/StudentPanel/student-dashboard.aspx");
                    }
                    else
                    {
                        lblMsg.Text = "Invalid Student Email/Enrollment or Password";
                    }
                }
                else if (role == "company")
                {
                    getcon();
                    da = new SqlDataAdapter("SELECT c_email, ISNULL(IsBlocked, 0) AS IsBlocked, ISNULL(Status, 'Active') AS Status FROM c_registration WHERE c_email = '" + txtemail.Text + "' AND c_password = '" + txtpassword.Text + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        bool isBlocked = Convert.ToBoolean(ds.Tables[0].Rows[0]["IsBlocked"]) ||  ds.Tables[0].Rows[0]["Status"].ToString().Equals("Blocked", StringComparison.OrdinalIgnoreCase);

                        if (isBlocked)
                        {
                            lblMsg.Text = "Your company account has been blocked by Admin. Please contact support.";
                            return;
                        }

                        Session["company"] = ds.Tables[0].Rows[0]["c_email"].ToString();
                        Response.Redirect("~/CompanyPanel/company-dashboard.aspx");
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
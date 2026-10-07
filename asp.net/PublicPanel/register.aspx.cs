using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//namesppace for database connection
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace asp.net
{
    public partial class register : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        //connection string from web.config file
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ImageButton2.ToolTip = "Save";
            }
        }

        //getcon method
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        //student clear method
        void studentclear()
        {
            FullName.Text = "";
            DateOfBirth.Text = "";
            Email.Text = "";
            ContactNo.Text = "";
            EnrollmentNo.Text = "";
            Password.Text = "";
            ConfirmPassword.Text = "";
            College.Text = "";
            Course.SelectedIndex = -1;
            GraduationYear.SelectedIndex = -1;
            CGPA.Text = "";
        }

        //company clear method
        void companyclear()
        {
            c_company.Text = "";
            c_contact.Text = "";
            c_email.Text = "";
            c_mobile.Text = "";
            c_password.Text = "";
            c_confirm.Text = "";
            c_website.Text = "";
            c_industry.SelectedIndex = -1;
            c_size.SelectedIndex = -1;
            c_location.Text = "";
        }

        //insert update for company and student
        protected void ImageButton2_Click(object sender,ImageClickEventArgs e)
        {
            string role = hfSelectedRole.Value;

            if (role == "student")
            {
                getcon();
                cmd = new SqlCommand("insert into Students (FullName,DateOfBirth,Email,ContactNo,EnrollmentNo,Password,ConfirmPassword,College,Course,GraduationYear,CGPA) values ('" + FullName.Text + "','" + DateOfBirth.Text + "','" + Email.Text + "','" + ContactNo.Text + "','" + EnrollmentNo.Text + "','" + Password.Text + "','" + Password.Text + "','" + College.Text + "','" + Course.SelectedValue + "','" + GraduationYear.SelectedValue + "','" + CGPA.Text + "'); select cast(scope_identity() as int)", con);
                cmd.ExecuteNonQuery();
                studentclear();
                ImageButton2.ToolTip = "Save";
                Label1.Text = "Student Registration Successful!";
            }
            else
            {
                getcon();
                cmd = new SqlCommand("insert into c_registration(c_company,c_contact,c_email,c_mobile,c_password,c_confirm,c_website,c_industry,c_size,c_location) values ('" + c_company.Text + "','" + c_contact.Text + "','" + c_email.Text + "','" + c_mobile.Text + "','" + c_password.Text + "','" + c_password.Text + "','" + c_website.Text + "','" + c_industry.SelectedValue + "','" + c_size.SelectedValue + "','" + c_location.Text + "')", con);
                cmd.ExecuteNonQuery();
                companyclear();
                ImageButton2.ToolTip = "Save";
                Label1.Text = "Company Registration Successful!";
            }
        }
    }
}

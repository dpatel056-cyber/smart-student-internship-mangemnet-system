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
    public partial class register : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillgrid();
                companygrid();
            }
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from s_registration", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
    
        }

        void companygrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from c_registration", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView2.DataSource = ds;
            GridView2.DataBind();
        
        }
        void clear()
        {
            s_fullname.Text = "";
            s_dob.Text = "";
            s_email.Text = "";
            s_mobile.Text = "";
            s_enrollment.Text = "";
            s_password.Text = "";
            s_confirm.Text = "";
            s_college.Text = "";
            s_course.Text = "";
            s_gradeyear.Text = "";
            s_location.Text = "";
        }
        void companyclear()
        {
            c_company.Text = "";
            c_contact.Text = "";
            c_email.Text = "";
            c_mobile.Text = "";
            c_password.Text = "";
            c_confirm.Text = "";
            c_website.Text = "";
            c_industry.Text = "";
            c_size.Text = "";
            c_location.Text = "";
        }
        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            string role = hfSelectedRole.Value;
            if (role == "company")
            {
                getcon();
                cmd = new SqlCommand("insert into c_registration(c_company,c_contact,c_email,c_mobile,c_password,c_confirm,c_website,c_industry,c_size,c_location) values('" + c_company.Text + "','" + c_contact.Text + "','" + c_email.Text + "','" + c_mobile.Text + "','" + c_password.Text + "','" + c_confirm.Text + "','" + c_website.Text + "','" + c_industry.Text + "','" + c_size.Text + "','" + c_location.Text + "')", con);
                cmd.ExecuteNonQuery();
                con.Close();
                companyclear();
                companygrid();
               
                Label1.Text = "Company Registration Successful!";
            }
            else
            {
                getcon();
                cmd = new SqlCommand("insert into s_registration(s_fullname,s_dob,s_email,s_mobile,s_enrollment,s_password,s_confirm,s_college,s_course,s_gradeyear,s_location) values('" + s_fullname.Text + "','" + s_dob.Text + "','" + s_email.Text + "','" + s_mobile.Text + "','" + s_enrollment.Text + "','" + s_password.Text + "','" + s_confirm.Text + "','" + s_college.Text + "','" + s_course.Text + "','" + s_gradeyear.Text + "','" + s_location.Text + "')", con);
                cmd.ExecuteNonQuery();
               
                clear();
                fillgrid();
               
                Label1.Text = "Student Registration Successful!";
            }

        }
    }
}
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
                studentfillgrid();
                companyfillgrid();
            }
        }

        //getcon method
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        //student fill grid method
        void studentfillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from Students",con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        //company fill grid method
        void companyfillgrid()
        {
            getcon();
            da = new SqlDataAdapter("select * from c_registration",con);
            ds = new DataSet();
            da.Fill(ds);
            GridView2.DataSource = ds;
            GridView2.DataBind();
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

        //student fill data method
        void studentfilldata()
        {
            getcon();

            da = new SqlDataAdapter("select * from Students where StudentId='" +ViewState["id"] +"'",con);
            ds = new DataSet();
            da.Fill(ds);

            //paring
            FullName.Text =ds.Tables[0].Rows[0]["FullName"].ToString();
            DateOfBirth.Text =ds.Tables[0].Rows[0]["DateOfBirth"].ToString();
            Email.Text =ds.Tables[0].Rows[0]["Email"].ToString();
            ContactNo.Text =ds.Tables[0].Rows[0]["ContactNo"].ToString();
            EnrollmentNo.Text =ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();
            Password.Text =ds.Tables[0].Rows[0]["Password"].ToString();
            ConfirmPassword.Text =ds.Tables[0].Rows[0]["ConfirmPassword"].ToString();
            College.Text =ds.Tables[0].Rows[0]["College"].ToString();
            Course.SelectedValue = ds.Tables[0].Rows[0]["Course"].ToString();
            GraduationYear.SelectedValue = ds.Tables[0].Rows[0]["GraduationYear"].ToString();
            CGPA.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();

        }

        //company fill data method
        void companyfilldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from c_registration where CompanyId='" + ViewState["id"] +"'",con);
            ds = new DataSet();
            da.Fill(ds);

            //paring
            c_company.Text =ds.Tables[0].Rows[0]["c_company"].ToString();
            c_contact.Text =ds.Tables[0].Rows[0]["c_contact"].ToString();
            c_email.Text =ds.Tables[0].Rows[0]["c_email"].ToString();
            c_mobile.Text =ds.Tables[0].Rows[0]["c_mobile"].ToString();
            c_password.Text =ds.Tables[0].Rows[0]["c_password"].ToString();
            c_confirm.Text =ds.Tables[0].Rows[0]["c_confirm"].ToString();
            c_website.Text =ds.Tables[0].Rows[0]["c_website"].ToString();
            c_industry.SelectedValue = ds.Tables[0].Rows[0]["c_industry"].ToString();
            c_size.SelectedValue = ds.Tables[0].Rows[0]["c_size"].ToString();
            c_location.Text = ds.Tables[0].Rows[0]["c_location"].ToString();
           
        }

        //insert update for company and student
        protected void ImageButton2_Click(object sender,ImageClickEventArgs e)
        {
            string role = hfSelectedRole.Value;
            string mode = ImageButton2.ToolTip;

            if (role == "student")
            { 
                if (mode == "Update")
                {
                    getcon();
                    cmd = new SqlCommand("update Students set FullName='" + FullName.Text + "',DateOfBirth='" + DateOfBirth.Text + "',Email='" + Email.Text + "',ContactNo='" + ContactNo.Text + "',EnrollmentNo='" + EnrollmentNo.Text + "',Password='" + Password.Text + "',ConfirmPassword='" + ConfirmPassword.Text + "',College='" + College.Text + "',Course='" + Course.Text + "',GraduationYear='" + GraduationYear.Text + "',CGPA='" + CGPA.Text + "' where StudentId='" + ViewState["id"] + "'",con);
                    cmd.ExecuteNonQuery();
                    studentclear();
                    studentfillgrid();
                    ImageButton2.ToolTip = "Save";
                    ImageButton2.ImageUrl = "~/assets/register.png";
                    Label1.Text ="Student Updated Successfully!";
                }

                else
                {
                    getcon();
                    cmd = new SqlCommand("insert into Students (FullName,DateOfBirth,Email,ContactNo,EnrollmentNo,Password,ConfirmPassword,College,Course,GraduationYear,CGPA) values ('" + FullName.Text + "','" + DateOfBirth.Text + "','" + Email.Text + "','" + ContactNo.Text + "','" + EnrollmentNo.Text + "','" + Password.Text + "','" + ConfirmPassword.Text + "','" + College.Text + "','" + Course.Text + "','" + GraduationYear.Text + "','" + CGPA.Text + "'); select cast(scope_identity() as int)",con);
                    int studentId = Convert.ToInt32(cmd.ExecuteScalar());
                    studentclear();
                    studentfillgrid();
                    ImageButton2.ToolTip = "Save";
                    Label1.Text ="Student Registration Successful!";
                }
            }
            else
            {

                if (mode == "Update")
                {
                    getcon();
                    cmd = new SqlCommand("update c_registration set c_company='" + c_company.Text + "',c_contact='" + c_contact.Text + "',c_email='" + c_email.Text + "',c_mobile='" + c_mobile.Text + "',c_password='" + c_password.Text + "',c_confirm='" + c_confirm.Text + "',c_website='" + c_website.Text + "',c_industry='" + c_industry.Text + "',c_size='" + c_size.Text + "',c_location='" + c_location.Text + "' where CompanyId='" + ViewState["id"] + "'", con);
                    cmd.ExecuteNonQuery();
                    companyclear();
                    companyfillgrid();
                    ImageButton2.ToolTip = "Save";
                    ImageButton2.ImageUrl = "~/assets/register.png";
                    Label1.Text = "Company Updated Successfully!";
                }
                else
                {
                    getcon();
                    cmd = new SqlCommand("insert into c_registration(c_company,c_contact,c_email,c_mobile,c_password,c_confirm,c_website,c_industry,c_size,c_location) values ('" + c_company.Text + "','" + c_contact.Text + "','" + c_email.Text + "','" + c_mobile.Text + "','" + c_password.Text + "','" + c_confirm.Text + "','" + c_website.Text + "','" + c_industry.Text + "','" + c_size.Text + "','" + c_location.Text + "')",con);
                    cmd.ExecuteNonQuery();
                    companyclear();
                    companyfillgrid();
                    ImageButton2.ToolTip = "Save";
                    Label1.Text ="Company Registration Successful!";
                }
            }
        }

        //gridview for student data
        protected void GridView1_RowCommand(object sender,GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt_s")
            {
                string id = e.CommandArgument.ToString();
                ViewState["id"] = id;
                ImageButton2.ToolTip = "Update";
                ImageButton2.ImageUrl = "~/assets/update.png";
                studentfilldata();
            }
            else if (e.CommandName == "cmd_del_s")
            {
                getcon();
                cmd = new SqlCommand( "delete from Students where StudentId='" + e.CommandArgument + "'",con);
                cmd.ExecuteNonQuery();
                studentfillgrid();
                studentclear();
                ImageButton2.ToolTip = "Save";
                ImageButton2.ImageUrl = "~/assets/register.png";
                Label1.Text = "Student Deleted Successfully!";
            }
        }

        //gridview for company data
        protected void GridView2_RowCommand(object sender,GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt_c")
            {
                string id = e.CommandArgument.ToString();
                ViewState["id"] = id;
                ImageButton2.ToolTip = "Update";
                ImageButton2.ImageUrl = "~/assets/update.png";
                companyfilldata();
            }
            else if (e.CommandName == "cmd_dlt_c")
            {
                getcon();
                cmd = new SqlCommand("delete from c_registration where CompanyId='" + e.CommandArgument + "'",con);
                cmd.ExecuteNonQuery();
                companyfillgrid();
                companyclear();
                ImageButton2.ToolTip = "Save";
                ImageButton2.ImageUrl = "~/assets/register.png";
                Label1.Text = "Company Deleted Successfully!";
            }
        }
    }
}

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
            da = new SqlDataAdapter("select * from s_registration",con);
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
            s_fullname.Text = "";
            s_dob.Text = "";
            s_email.Text = "";
            s_mobile.Text = "";
            s_enrollment.Text = "";
            s_password.Text = "";
            s_confirm.Text = "";
            s_college.Text = "";
            s_course.SelectedIndex = -1;
            s_gradeyear.SelectedIndex = -1;
            s_location.Text = "";
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

            da = new SqlDataAdapter("select * from s_registration where Id='" +ViewState["id"] +"'",con);
            ds = new DataSet();
            da.Fill(ds);

            //paring
            s_fullname.Text =ds.Tables[0].Rows[0]["s_fullname"].ToString();
            s_dob.Text =ds.Tables[0].Rows[0]["s_dob"].ToString();
            s_email.Text =ds.Tables[0].Rows[0]["s_email"].ToString();
            s_mobile.Text =ds.Tables[0].Rows[0]["s_mobile"].ToString();
            s_enrollment.Text =ds.Tables[0].Rows[0]["s_enrollment"].ToString();
            s_password.Text =ds.Tables[0].Rows[0]["s_password"].ToString();
            s_confirm.Text =ds.Tables[0].Rows[0]["s_confirm"].ToString();
            s_college.Text =ds.Tables[0].Rows[0]["s_college"].ToString();
            s_course.SelectedValue = ds.Tables[0].Rows[0]["s_course"].ToString();
            s_gradeyear.SelectedValue = ds.Tables[0].Rows[0]["s_gradeyear"].ToString();
            s_location.Text = ds.Tables[0].Rows[0]["s_location"].ToString();
           
        }

        //company fill data method
        void companyfilldata()
        {
            getcon();

            da = new SqlDataAdapter("select * from c_registration where Id='" + ViewState["id"] +"'",con);
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
                    cmd = new SqlCommand("update s_registration set s_fullname='" + s_fullname.Text + "',s_dob='" + s_dob.Text + "',s_email='" + s_email.Text + "',s_mobile='" + s_mobile.Text + "',s_enrollment='" + s_enrollment.Text + "',s_password='" + s_password.Text + "',s_confirm='" + s_confirm.Text + "',s_college='" + s_college.Text + "',s_course='" + s_course.Text + "',s_gradeyear='" + s_gradeyear.Text + "',s_location='" + s_location.Text + "' where Id='" + ViewState["id"] + "'",con);
                    cmd.ExecuteNonQuery();
                    studentclear();
                    studentfillgrid();
                    ImageButton2.ToolTip = "Save";
                    ImageButton2.ImageUrl = "~/register.png";
                    Label1.Text ="Student Updated Successfully!";
                }

                else
                {
                    getcon();
                    cmd = new SqlCommand("insert into s_registration (s_fullname,s_dob,s_email,s_mobile,s_enrollment,s_password,s_confirm,s_college,s_course,s_gradeyear,s_location) values ('" + s_fullname.Text + "','" + s_dob.Text + "','" + s_email.Text + "','" + s_mobile.Text + "','" + s_enrollment.Text + "','" + s_password.Text + "','" + s_confirm.Text + "','" + s_college.Text + "','" + s_course.Text + "','" + s_gradeyear.Text + "','" + s_location.Text + "')",con);
                    cmd.ExecuteNonQuery();
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
                    cmd = new SqlCommand("update c_registration set c_company='" + c_company.Text + "',c_contact='" + c_contact.Text + "',c_email='" + c_email.Text + "',c_mobile='" + c_mobile.Text + "',c_password='" + c_password.Text + "',c_confirm='" + c_confirm.Text + "',c_website='" + c_website.Text + "',c_industry='" + c_industry.Text + "',c_size='" + c_size.Text + "',c_location='" + c_location.Text + "' where Id='" + ViewState["id"] + "'", con);
                    cmd.ExecuteNonQuery();
                    companyclear();
                    companyfillgrid();
                    ImageButton2.ToolTip = "Save";
                    ImageButton2.ImageUrl = "~/register.png";
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
                ImageButton2.ImageUrl = "~/update.png";
                studentfilldata();
            }
            else if (e.CommandName == "cmd_del_s")
            {
                getcon();
                cmd = new SqlCommand( "delete from s_registration where Id='" + e.CommandArgument + "'",con);
                cmd.ExecuteNonQuery();
                studentfillgrid();
                studentclear();
                ImageButton2.ToolTip = "Save";
                ImageButton2.ImageUrl = "~/register.png";
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
                ImageButton2.ImageUrl = "~/update.png";
                companyfilldata();
            }
            else if (e.CommandName == "cmd_dlt_c")
            {
                getcon();
                cmd = new SqlCommand("delete from c_registration where Id='" + e.CommandArgument + "'",con);
                cmd.ExecuteNonQuery();
                companyfillgrid();
                companyclear();
                ImageButton2.ToolTip = "Save";
                ImageButton2.ImageUrl = "~/register.png";
                Label1.Text = "Company Deleted Successfully!";
            }
        }
    }
}

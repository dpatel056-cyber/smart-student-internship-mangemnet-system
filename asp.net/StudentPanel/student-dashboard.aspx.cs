using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace asp.net
{
    public partial class student_dashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string nm;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from s_registration where s_email='" +Session["student"] + "' or s_enrollment='" +Session["student"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    nm = ds.Tables[0].Rows[0]["s_fullname"].ToString();
                    Label1.Text = nm;
                }
            }
            else
            {
                Response.Redirect("../login.aspx");
            }
        }

       
    }
}

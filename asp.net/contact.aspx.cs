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
    public partial class contact : System.Web.UI.Page
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
        void getcon() {
            con = new SqlConnection(s);
            con.Open();
        }
        void clear() {
            txtname.Text = "";
            txtemail.Text = "";
            txtsubject.Text = "";
            txtMessage.Text = "";
        }
        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            getcon();
            cmd = new SqlCommand("insert into Contact(c_name,c_email,c_subject,c_message) values('" + txtname.Text + "','" + txtemail.Text + "','" + txtsubject.Text + "','" + txtMessage.Text + "')", con);
            cmd.ExecuteNonQuery();
            clear();
        }
    }
}
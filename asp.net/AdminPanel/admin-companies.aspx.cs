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
    public partial class admin_companies : System.Web.UI.Page
    {
        SqlCommand cmd;
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void showCompany()
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM c_registration", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
          
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                showCompany();
            }
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("viewCompanyDetails.aspx?id=" + id);
            }
            else if (e.CommandName == "cmd_del")
            {
                string id = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("delete from c_registration where CompanyId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                showCompany();
            }
        }

       
    }
}

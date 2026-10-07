using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace asp.net
{
    public partial class admin_companies : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
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
                    bindCompanies();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }
        void bindCompanies()
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM c_registration ORDER BY CompanyId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();

            if (e.CommandName == "cmd_view")
            {
                Response.Redirect("viewCompanyDetails.aspx?id=" + id);
            }
            if (e.CommandName == "cmd_toggle_block")
            {
                getcon();
                cmd = new SqlCommand("SELECT IsBlocked FROM c_registration WHERE CompanyId=" + id, con);
                bool blocked = Convert.ToBoolean(cmd.ExecuteScalar());
                int block = blocked ? 0 : 1;
                string status = block == 1 ? "Blocked" : "Active";
                cmd = new SqlCommand("UPDATE c_registration SET IsBlocked=" + block + ", Status='" + status + "' WHERE CompanyId=" + id, con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("UPDATE internship SET Status='" + (block == 1 ? "Inactive" : "Active") + "' WHERE CompanyId=" + id, con);
                cmd.ExecuteNonQuery();
                bindCompanies();
            }
            if (e.CommandName == "cmd_del")
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM internship WHERE CompanyId=" + id, con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("DELETE FROM c_registration WHERE CompanyId=" + id, con);
                cmd.ExecuteNonQuery();
                bindCompanies();
            }
        }
    }
}
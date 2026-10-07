using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net.AdminPanel
{
    public partial class Admin_Contact_Messages : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from admin_registration where Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    showcontact();
                }
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

        void showcontact()
        {
            getcon();
            da = new SqlDataAdapter("select * from cont", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "ViewContact")
            {
                getcon();
                da = new SqlDataAdapter("select * from cont where Id=" + id, con);
                ds = new DataSet();
                da.Fill(ds);

                lblDetailName.Text = ds.Tables[0].Rows[0]["c_name"].ToString();
                lblDetailEmail.Text = ds.Tables[0].Rows[0]["c_email"].ToString();
                lblDetailSubject.Text = ds.Tables[0].Rows[0]["c_subject"].ToString();
                lblDetailMessage.Text = ds.Tables[0].Rows[0]["c_message"].ToString();
                lblDetailDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["c_date"]).ToString("dd MMM yyyy");
                lblDetailTime.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["c_date"]).ToString("hh:mm tt");

                ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenDrawer", "openDrawer();", true);
            }
            if (e.CommandName == "cmd_dlt")
            {
                getcon();
                cmd = new SqlCommand("delete from cont where Id=" + id, con);
                cmd.ExecuteNonQuery();
                showcontact();
            }
        }
    }
}

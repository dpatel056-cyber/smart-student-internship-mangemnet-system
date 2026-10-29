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
        {
            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from admin_registration where Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    ViewState["page"] = 0;
                    contactfillgrid();
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

        AdminClass admin = new AdminClass();

        void contactfillgrid()
        {
            admin = new AdminClass();
            DataTable dt = admin.select_contact_messages().Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 5.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }
            GridView1.DataSource = admin.contact_message_pagination(dt, page);
            GridView1.DataBind();
            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 5 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            GridView1.DataSource = admin.contact_message_pagination(dt, 0);
            GridView1.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 5.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = dt != null && dt.Rows.Count > 5;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.search_contact_messages(txtSearch.Text).Tables[0]);
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ViewState["page"] = 0;
            contactfillgrid();
        }

        // Pagination Click Events

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            contactfillgrid();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            contactfillgrid();
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
                contactfillgrid();
            }
        }
    }
}

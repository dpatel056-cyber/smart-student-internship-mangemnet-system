using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class admin_internships : System.Web.UI.Page
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
                    AdminInternships();
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

        void AdminInternships()
        {
            getcon();
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo, c.c_industry from internship i inner join c_registration c on i.CompanyId=c.CompanyId order by i.Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListAdminInternships.DataSource = ds;
                DataListAdminInternships.DataBind();

                DataListAdminInternships.Visible = true;
                pnlNoInternships.Visible = false;

                lblResultCount.Text = "Showing " + ds.Tables[0].Rows.Count + " internships";
            }
            else
            {
                DataListAdminInternships.Visible = false;
                pnlNoInternships.Visible = true;

                lblResultCount.Text = "Showing 0 internships";
            }
        }

        protected void DataListAdminInternships_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                Response.Redirect("admin-internship-details.aspx?id=" + e.CommandArgument);
            }
            else if (e.CommandName == "cmd_toggle_status")
            {
                string[] data = e.CommandArgument.ToString().Split('|');
                string id = data[0];
                string status = data[1];
                string newStatus = (status == "Active") ? "Inactive" : "Active";

                getcon();
                cmd = new SqlCommand("update internship set Status='" + newStatus + "' where Id='" + id + "'", con);
                cmd.ExecuteNonQuery();
                AdminInternships();
            }
            else if (e.CommandName == "cmd_delete")
            {
                getcon();
                cmd = new SqlCommand("delete from internship where Id='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                AdminInternships();
            }
        }
        //-------------------------------------
        public bool IsInternshipActive(object status)
        {
            return status.ToString() == "Active";
        }
        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj != null && logoObj != DBNull.Value && !string.IsNullOrEmpty(logoObj.ToString().Trim()))
            {
                string logo = logoObj.ToString().Trim();
                if (logo.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || logo.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                {
                    return logo;
                }
                if (logo.StartsWith("~") || logo.StartsWith("/"))
                {
                    return ResolveUrl(logo);
                }

                return ResolveUrl("~/CompanyUploads/" + logo);
            }
            return ResolveUrl("~/CompanyUploads/default-company.png");
        }
    }
}

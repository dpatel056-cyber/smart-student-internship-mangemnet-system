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
            if (!IsPostBack)
            {
                AdminInternships();
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
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo, c.c_industry from internship i left join c_registration c on i.CompanyId = c.CompanyId order by i.Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            DataListAdminInternships.DataSource = ds;
            DataListAdminInternships.DataBind();
        }

        protected void DataListAdminInternships_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                Response.Redirect("admin-internship-details.aspx?id=" + e.CommandArgument.ToString());
            }
            else if (e.CommandName == "cmd_delete")
            {
                getcon();
                cmd = new SqlCommand("delete from internship where Id='" + e.CommandArgument.ToString() + "'", con);
                cmd.ExecuteNonQuery();
                AdminInternships();
            }
        }

        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj != null && logoObj != DBNull.Value && !string.IsNullOrEmpty(logoObj.ToString()))
            {
                string logo = logoObj.ToString().Trim();
                if (logo.StartsWith("~") || logo.StartsWith("/"))
                {
                    return ResolveUrl(logo);
                }
                return ResolveUrl("~/CompanyUploads/" + logo);
            }
            return ResolveUrl("~/assets/default-company.png");
        }
    }
}
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class internships : System.Web.UI.Page
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
                showInternships();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void showInternships()
        {
            getcon();
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListPublicInternships.DataSource = ds;
                DataListPublicInternships.DataBind();
                DataListPublicInternships.Visible = true;
                lblResultCount.Text = "Showing " + ds.Tables[0].Rows.Count + " internships";
            }
            else
            {
                DataListPublicInternships.Visible = false;
                lblResultCount.Text = "Showing 0 internships";
            }
        }
        //LOGO
        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj == null || logoObj == DBNull.Value)
                return ResolveUrl("~/CompanyUploads/default-company.png");

            string logo = logoObj.ToString().Trim();
            if (string.IsNullOrEmpty(logo))
                return ResolveUrl("~/CompanyUploads/default-company.png");

            if (logo.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || logo.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                return logo;

            if (logo.StartsWith("~"))
                return ResolveUrl(logo);

            if (logo.StartsWith("/"))
                return ResolveUrl("~" + logo);

            string uploadsPath = Server.MapPath("~/uploads/company_logos/" + logo);
            if (System.IO.File.Exists(uploadsPath))
            {
                return ResolveUrl("~/uploads/company_logos/" + logo);
            }

            string compUploadsPath = Server.MapPath("~/CompanyUploads/" + logo);
            if (System.IO.File.Exists(compUploadsPath))
            {
                return ResolveUrl("~/CompanyUploads/" + logo);
            }

            return ResolveUrl("~/CompanyUploads/" + logo);
        }
    }
}

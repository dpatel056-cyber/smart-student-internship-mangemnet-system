using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class companies : System.Web.UI.Page
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
                fillGrid();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillGrid()
        {
            getcon();
            da = new SqlDataAdapter("select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c where (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by c.CompanyId desc", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListPublicCompanies.DataSource = ds;
                DataListPublicCompanies.DataBind();
                DataListPublicCompanies.Visible = true;
                lblResultCount.Text = "Showing " + ds.Tables[0].Rows.Count + " companies";
            }
            else
            {
                DataListPublicCompanies.Visible = false;
                lblResultCount.Text = "Showing 0 companies";
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

            if (logo.StartsWith("~") || logo.StartsWith("/"))
                return ResolveUrl(logo);

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

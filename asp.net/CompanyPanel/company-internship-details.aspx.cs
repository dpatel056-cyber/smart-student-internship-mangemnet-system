using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_internship_details : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadInternshipDetails();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void LoadInternshipDetails()
        {
            getcon();
            cmd = new SqlCommand("SELECT p.*, c.c_company, c.c_logo, c.c_industry, c.c_location, c.c_about, c.c_website FROM PostInternship p LEFT JOIN c_registration c ON p.CompanyId = c.c_id WHERE p.Id = '" + Request.QueryString["id"].ToString() + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            DataListInternshipDetail.DataSource = ds;
            DataListInternshipDetail.DataBind();
        }

        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj != null && logoObj != DBNull.Value && !string.IsNullOrEmpty(logoObj.ToString()))
            {
                string logo = logoObj.ToString();
                if (!logo.StartsWith("~") && !logo.StartsWith("/"))
                {
                    logo = "~/CompanyUploads/" + logo;
                }
                return ResolveUrl(logo);
            }
            return ResolveUrl("~/assets/default-company.png");
        }
    }
}

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

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    LoadInternshipDetails();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void LoadInternshipDetails()
        {
            getcon();
            if (Request.QueryString["id"] == null) return;
            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo, c.c_industry, c.c_location, c.c_about, c.c_website FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE i.Id = '" + Request.QueryString["id"].ToString() + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            DataListInternshipDetail.DataSource = ds;
            DataListInternshipDetail.DataBind();
        }

        //------------------------------
        //*****************************
        //-----------------------------
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

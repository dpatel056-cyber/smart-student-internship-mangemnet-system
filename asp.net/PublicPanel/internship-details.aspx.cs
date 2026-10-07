using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class internship_details : System.Web.UI.Page
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
                loadInternshipDetails();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void loadInternshipDetails()
        {
            getcon();
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo, c.c_industry, c.c_location, c.c_city, c.c_state, c.c_about, c.c_email, c.c_contact, c.c_hr_name from internship i inner join c_registration c on i.CompanyId=c.CompanyId where i.Id='" + Request.QueryString["id"] + "' and (i.Status is null or (i.Status<>'Inactive' and i.Status<>'Draft')) and (c.IsBlocked=0 or c.IsBlocked is null) and (c.Status<>'Blocked' or c.Status is null)", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListInternshipDetail.DataSource = ds;
                DataListInternshipDetail.DataBind();

                DataListInternshipDetail.Visible = true;
                divNotFound.Visible = false;
            }
            else
            {
                DataListInternshipDetail.Visible = false;
                divNotFound.Visible = true;
            }
        }
        //LOGO
        public string GetCompanyLogo(object logo)
        {
            if (logo == null || logo == DBNull.Value)
                return ResolveUrl("~/CompanyUploads/default-company.png");

            string l = logo.ToString().Trim();
            if (string.IsNullOrEmpty(l))
                return ResolveUrl("~/CompanyUploads/default-company.png");

            if (l.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || l.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                return l;

            if (l.StartsWith("~") || l.StartsWith("/"))
                return ResolveUrl(l);

            string uploadsPath = Server.MapPath("~/uploads/company_logos/" + l);
            if (System.IO.File.Exists(uploadsPath))
            {
                return ResolveUrl("~/uploads/company_logos/" + l);
            }

            string compUploadsPath = Server.MapPath("~/CompanyUploads/" + l);
            if (System.IO.File.Exists(compUploadsPath))
            {
                return ResolveUrl("~/CompanyUploads/" + l);
            }

            return ResolveUrl("~/CompanyUploads/" + l);
        }
    }
}

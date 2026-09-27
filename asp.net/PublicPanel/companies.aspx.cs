using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class companies : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bindCompanies();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
        }

        void bindCompanies()
        {
            try
            {
                getcon();
                string query = "select c.*, (select count(*) from internship i where i.CompanyId = c.CompanyId) as TotalOpenings from c_registration c order by c.CompanyId desc";

                da = new SqlDataAdapter(query, con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataListPublicCompanies.DataSource = ds;
                    DataListPublicCompanies.DataBind();
                    DataListPublicCompanies.Visible = true;
                    if (pnlNoCompanies != null) pnlNoCompanies.Visible = false;
                }
                else
                {
                    DataListPublicCompanies.Visible = false;
                    if (pnlNoCompanies != null) pnlNoCompanies.Visible = true;
                }

                con.Close();
            }
            catch (Exception ex)
            {
                // Fallback gracefully
            }
        }

        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj != null && logoObj != DBNull.Value && !string.IsNullOrEmpty(logoObj.ToString()))
            {
                string logo = logoObj.ToString();
                if (logo.StartsWith("~") || logo.StartsWith("/"))
                {
                    return ResolveUrl(logo);
                }
                return ResolveUrl("~/CompanyUploads/" + logo);
            }
            return ResolveUrl("~/assets/default-company.png");
        }

        public string GetCompanyName(object nameObj)
        {
            if (nameObj != null && nameObj != DBNull.Value && !string.IsNullOrEmpty(nameObj.ToString()))
            {
                return nameObj.ToString();
            }
            return "Company";
        }

        public string GetCompanyIndustry(object indObj, object domainObj = null)
        {
            if (indObj != null && indObj != DBNull.Value && !string.IsNullOrEmpty(indObj.ToString()))
            {
                return indObj.ToString();
            }
            if (domainObj != null && domainObj != DBNull.Value && !string.IsNullOrEmpty(domainObj.ToString()))
            {
                return domainObj.ToString();
            }
            return "Technology, Internet";
        }

        public string GetCompanyLocation(object locObj, object cityObj = null, object stateObj = null)
        {
            if (locObj != null && locObj != DBNull.Value && !string.IsNullOrEmpty(locObj.ToString()))
            {
                return locObj.ToString();
            }
            string city = cityObj != null && cityObj != DBNull.Value ? cityObj.ToString().Trim() : "";
            string state = stateObj != null && stateObj != DBNull.Value ? stateObj.ToString().Trim() : "";
            if (!string.IsNullOrEmpty(city) && !string.IsNullOrEmpty(state))
            {
                return city + ", " + state;
            }
            if (!string.IsNullOrEmpty(city)) return city;
            if (!string.IsNullOrEmpty(state)) return state;
            return "India";
        }
    }
}

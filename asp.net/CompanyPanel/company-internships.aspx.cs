using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_internships : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }

            if (!IsPostBack)
            {
                bindInternships();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);

                con.Open();

        }



        void bindInternships()
        {
            getcon();

            da = new SqlDataAdapter(" SELECT i.*, c.c_company, c.c_logo FROM internship i LEFT JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE c.c_email = '" + Session["company"] + "'ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListMyInternships.DataSource = ds.Tables[0];
                DataListMyInternships.DataBind();

                DataListMyInternships.Visible = true;
                pnlNoMyInternships.Visible = false;
            }
            else
            {
                DataListMyInternships.Visible = false;
                pnlNoMyInternships.Visible = true;
            }


        }

        public string GetCompanyLogo(object logoObj, object logoObj2 = null)
        {
            object targetLogo = (logoObj != null && logoObj != DBNull.Value && !string.IsNullOrEmpty(logoObj.ToString())) ? logoObj : logoObj2;
            if (targetLogo != null && targetLogo != DBNull.Value && !string.IsNullOrEmpty(targetLogo.ToString()))
            {
                string logo = targetLogo.ToString();
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

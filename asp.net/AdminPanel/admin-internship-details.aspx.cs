using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class admin_internship_details : System.Web.UI.Page
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
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo, c.c_industry, c.c_location, c.c_city, c.c_state, c.c_about, c.c_email, c.c_contact, c.c_hr_name from internship i left join c_registration c on i.CompanyId = c.CompanyId where i.Id='" + Request.QueryString["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            DataListInternshipDetail.DataSource = ds;
            DataListInternshipDetail.DataBind();
        }

        protected void DataListInternshipDetail_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "DeleteInternship")
            {
                getcon();
                cmd = new SqlCommand("delete from internship where Id='" + e.CommandArgument.ToString() + "'",con);
                cmd.ExecuteNonQuery();
                Response.Redirect("admin-internships.aspx");
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
    }
}
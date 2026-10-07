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
            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from admin_registration where Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    loadInternshipDetails();
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

        void loadInternshipDetails()
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, ISNULL(c.c_company, 'Company') AS c_company, c.c_logo, ISNULL(c.c_industry, i.InternshipDomain) AS c_industry, c.c_location, c.c_website, c.c_about, c.c_email, c.c_contact FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE i.Id='" + Request.QueryString["id"] + "'", con);
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
                cmd = new SqlCommand("delete from internship where Id='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                Response.Redirect("admin-internships.aspx");
            }
            else if (e.CommandName == "ToggleStatus")
            {
                string[] data = e.CommandArgument.ToString().Split('|');
                string id = data[0];
                string status = data[1];
                string newStatus = (status == "Active") ? "Inactive" : "Active";

                getcon();
                cmd = new SqlCommand("update internship set Status='" + newStatus + "' where Id='" + id + "'", con);
                cmd.ExecuteNonQuery();
                loadInternshipDetails();
            }
        }
        //-------------------------------------
        public bool IsInternshipActive(object status)
        {
            if (status == null || status == DBNull.Value) return true;
            string st = status.ToString().Trim();
            if (st.Equals("Inactive", StringComparison.OrdinalIgnoreCase) || st.Equals("Draft", StringComparison.OrdinalIgnoreCase) || st.Equals("Blocked", StringComparison.OrdinalIgnoreCase))
                return false;

            return true;
        }
        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj != null && logoObj != DBNull.Value && !string.IsNullOrEmpty(logoObj.ToString()))
            {
                string logo = logoObj.ToString().Trim();
                if (logo.StartsWith("~") || logo.StartsWith("/") || logo.StartsWith("http"))
                {
                    return ResolveUrl(logo);
                }
                return ResolveUrl("~/CompanyUploads/" + logo);
            }
            return ResolveUrl("~/CompanyUploads/default-company.png");
        }
    }
}

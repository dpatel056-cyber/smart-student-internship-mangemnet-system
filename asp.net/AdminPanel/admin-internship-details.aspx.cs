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
            da = new SqlDataAdapter("SELECT i.*, ISNULL(c.c_company, 'Company') AS c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo, ISNULL(c.c_industry, i.InternshipDomain) AS c_industry, c.c_location, c.c_website, c.c_about, c.c_email, c.c_contact FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE i.Id='" + Request.QueryString["id"] + "'", con);
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
        }
    }
}

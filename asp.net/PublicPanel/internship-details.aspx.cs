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
            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo, c.c_industry, c.c_location, c.c_city, c.c_state, c.c_about, c.c_email, c.c_contact, c.c_hr_name FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE i.Id = '" + Request.QueryString["id"] + "' AND (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) AND (c.IsBlocked = 0 OR c.IsBlocked IS NULL) AND (c.Status <> 'Blocked' OR c.Status IS NULL)", con);
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
    }
}
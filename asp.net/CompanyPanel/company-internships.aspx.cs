using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_internships : System.Web.UI.Page
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
                    bindInternships();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void bindInternships()
        {
            getcon();

            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE c.c_email = '" + Session["company"] + "' ORDER BY i.Id DESC", con);
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
        protected void DataListMyInternships_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "DeleteInternship")
            {
                string internshipId = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("DELETE FROM internship WHERE Id='" + internshipId + "' AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"] + "')", con);
                cmd.ExecuteNonQuery();

                bindInternships();
            }
        }
    }
}

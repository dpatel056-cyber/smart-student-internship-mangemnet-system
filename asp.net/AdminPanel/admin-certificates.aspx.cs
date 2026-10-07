using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net.css
{
    public partial class admin_certificates : System.Web.UI.Page
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
            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from admin_registration where Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    fillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void fillgrid()
        {
            getcon();
            da = new SqlDataAdapter("SELECT cc.*, s.FullName, s.Email AS StudentEmail, s.College, i.InternshipTitle, i.Duration, comp.c_company FROM CompanyCertificates cc LEFT JOIN Students s ON cc.StudentId = s.StudentId LEFT JOIN internship i ON cc.InternshipId = i.Id LEFT JOIN c_registration comp ON cc.CompanyId = comp.CompanyId ORDER BY cc.CertificateId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                Response.Redirect("admin-certificate-view.aspx?id=" + e.CommandArgument);
            }
            else if (e.CommandName == "cmd_delete")
            {
                getcon();
                cmd = new SqlCommand("delete from CompanyCertificates where CertificateId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                fillgrid();
            }
        }
    }
}

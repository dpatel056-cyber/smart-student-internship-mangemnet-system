using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_saved_internships : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    LoadSavedInternships();
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

        void LoadSavedInternships()
        {
            string studentKey = Session["student"].ToString();

            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo, c.c_industry, s.SavedDate FROM StudentSavedInternships s INNER JOIN internship i ON s.InternshipId=i.Id INNER JOIN c_registration c ON i.CompanyId=c.CompanyId WHERE (s.StudentEmail='" + studentKey + "' OR s.StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "')) AND (c.IsBlocked=0 OR c.IsBlocked IS NULL) AND (c.Status!='Blocked' OR c.Status IS NULL) ORDER BY s.SaveId DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                dlSaved.DataSource = ds;
                dlSaved.DataBind();

                dlSaved.Visible = true;
                pnlNoSaved.Visible = false;
            }
            else
            {
                dlSaved.Visible = false;
                pnlNoSaved.Visible = true;
            }
        }

        protected void dlSaved_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "RemoveBookmark")
            {
                string internshipId = e.CommandArgument.ToString();
                string studentKey = Session["student"].ToString();

                getcon();
                cmd = new SqlCommand("DELETE FROM StudentSavedInternships WHERE InternshipId=" + internshipId + " AND (StudentEmail='" + studentKey + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + studentKey + "' OR EnrollmentNo='" + studentKey + "'))", con);
                cmd.ExecuteNonQuery();
                LoadSavedInternships();
            }
        }
        //LOGO
        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj == null || logoObj == DBNull.Value)
                return ResolveUrl("~/CompanyUploads/default-company.png");

            string logo = logoObj.ToString().Trim();
            if (string.IsNullOrEmpty(logo))
                return ResolveUrl("~/CompanyUploads/default-company.png");

            if (logo.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || logo.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                return logo;

            if (logo.StartsWith("~"))
                return ResolveUrl(logo);

            if (logo.StartsWith("/"))
                return ResolveUrl("~" + logo);

            return ResolveUrl("~/CompanyUploads/" + logo);
        }
    }
}
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace asp.net
{
    public partial class student_internships : System.Web.UI.Page
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
            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (!IsPostBack)
                {
                    showInternships();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }
        void showInternships()
        {
            getcon();
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId=c.CompanyId where (i.Status is null or (i.Status<>'Inactive' and i.Status<>'Draft')) and (c.IsBlocked=0 or c.IsBlocked is null) and (c.Status<>'Blocked' or c.Status is null) order by i.Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListPublicInternships.DataSource = ds;
                DataListPublicInternships.DataBind();
                DataListPublicInternships.Visible = true;
                pnlNoInternships.Visible = false;
                lblResultCount.Text = "Showing " + ds.Tables[0].Rows.Count + " internships";
            }
            else
            {
                DataListPublicInternships.Visible = false;
                pnlNoInternships.Visible = true;
                lblResultCount.Text = "Showing 0 internships";
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            showInternships();
        }
        protected void btnClearAll_Click(object sender, EventArgs e)
        {
            topKeywordInput.Text = "";
            sideKeywordInput.Text = "";
            topCategory.SelectedIndex = 0;
            sideCategory.SelectedIndex = 0;
            topLocation.SelectedIndex = 0;
            sideLocation.SelectedIndex = 0;
            topDuration.SelectedIndex = 0;
            sortBySelect.SelectedIndex = 0;
            cblDuration.ClearSelection();
            cblStipend.ClearSelection();
            cblMode.ClearSelection();
            showInternships();
        }
        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            showInternships();
        }
        protected void DataListPublicInternships_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Bookmark")
            {
                getcon();
                string internshipId = e.CommandArgument.ToString();
                string studentKey = Session["student"].ToString();
                da = new SqlDataAdapter("select StudentId from Students where Email='" + studentKey + "' or EnrollmentNo='" + studentKey + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                string studentId = ds.Tables[0].Rows[0]["StudentId"].ToString();
                cmd = new SqlCommand("if not exists (select 1 from StudentSavedInternships where InternshipId=" + internshipId + " and (StudentEmail='" + studentKey + "' or StudentId=" + studentId + ")) begin insert into StudentSavedInternships (StudentId,StudentEmail,InternshipId,SavedDate) values(" + studentId + ",'" + studentKey + "'," + internshipId + ",GETDATE()) end", con);
                cmd.ExecuteNonQuery();
                Response.Redirect("~/StudentPanel/student-saved-internships.aspx");
            }
        }
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
        public string FormatPostedDate(object dateObj)
        {
            if (dateObj != null && dateObj != DBNull.Value)
            {
                DateTime dt;
                if (DateTime.TryParse(dateObj.ToString(), out dt))
                {
                    return dt.ToString("dd-MM-yyyy");
                }
                return dateObj.ToString();
            }
            return "";
        }
    }
}
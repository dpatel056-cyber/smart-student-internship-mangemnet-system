using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class admin_student_applications : System.Web.UI.Page
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
        {            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from admin_registration where Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    loadStats();
                    bindApplications();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

// Statistics
        void loadStats()
        {
            getcon();

            da = new SqlDataAdapter( "SELECT COUNT(*) FROM StudentApplications", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalApps.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Pending' OR Status='Applied' OR Status IS NULL",con);
            ds = new DataSet();
            da.Fill(ds);
            lblPendingApps.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Shortlisted'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblShortlistedApps.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter( "SELECT COUNT(*) FROM StudentApplications WHERE Status='Selected'",con);
            ds = new DataSet();
            da.Fill(ds);
            lblSelectedApps.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentApplications WHERE Status='Rejected'",con);
            ds = new DataSet();
            da.Fill(ds);
            lblRejectedApps.Text = ds.Tables[0].Rows[0][0].ToString();

        }

        // Show Applications
        void bindApplications()
        {
            getcon();
            da = new SqlDataAdapter("SELECT a.*, i.InternshipTitle, ISNULL(c.c_company, 'N/A') AS c_company, ISNULL(c.c_industry, 'General') AS c_industry, s.ProfilePhoto FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id INNER JOIN c_registration c ON i.CompanyId = c.CompanyId INNER JOIN Students s ON a.StudentId = s.StudentId ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            gvApplications.DataSource = ds;
            gvApplications.DataBind();
        }

        // Row Commands
        protected void gvApplications_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string appId = e.CommandArgument.ToString();

            if (e.CommandName == "cmd_delete")
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM StudentApplications WHERE ApplicationId='" + appId + "'",con);
                cmd.ExecuteNonQuery();
                lblMsg.Text = "Application deleted successfully.";
                lblMsg.Visible = true;
                loadStats();
                bindApplications();
            }
        }
        //---------------------------------------
        public string GetStudentAvatar(object photoObj, object nameObj)
        {
            string name = nameObj != null ? nameObj.ToString() : "";
            string initial = !string.IsNullOrEmpty(name) ? name.Substring(0, 1).ToUpper() : "S";
            string photo = photoObj != null && photoObj != DBNull.Value ? photoObj.ToString().Trim() : "";

            if (!string.IsNullOrEmpty(photo))
            {
                if (photo.StartsWith("~"))
                {
                    photo = ResolveUrl(photo);
                }
                else if (!photo.StartsWith("/") && !photo.StartsWith("http"))
                {
                    photo = ResolveUrl("~/StudentUploads/" + photo);
                }
                return string.Format("<img src='{0}' alt='{1}' style='width: 38px; height: 38px; border-radius: 50%; object-fit: cover; border: 1.5px solid #e2e8f0; box-shadow: 0 2px 4px rgba(0,0,0,0.08); flex-shrink: 0;' onerror=\"this.outerHTML='<div style=\\'width: 38px; height: 38px; border-radius: 50%; background: linear-gradient(135deg, #6366f1, #8b5cf6); color: #ffffff; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 14px; flex-shrink: 0;\\'>{2}</div>'\" />", photo, name, initial);
            }

            return string.Format("<div style='width: 38px; height: 38px; border-radius: 50%; background: linear-gradient(135deg, #6366f1, #8b5cf6); color: #ffffff; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 14px; flex-shrink: 0; box-shadow: 0 2px 6px rgba(99, 102, 241, 0.25);'>{0}</div>", initial);
        }

        public string GetStatusBadge(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value)
                return "<span class='badge-pending'>Pending</span>";

            string status = statusObj.ToString().Trim();

            if (string.Equals(status, "Shortlisted", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-shortlisted'>Shortlisted</span>";

            if (string.Equals(status, "Selected", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-selected'>Selected</span>";

            if (string.Equals(status, "Rejected", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-rejected'>Rejected</span>";

            return "<span class='badge-pending'>Pending</span>";
        }
    }
}

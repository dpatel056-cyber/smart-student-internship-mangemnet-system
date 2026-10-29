using System;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.IO;
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
        {
            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from admin_registration where Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (!IsPostBack)
                {
                    ViewState["page"] = 0;
                    totalapps();
                    pendingapps();
                    shortlistedapps();
                    selectedapps();
                    rejectedapps();
                    applicationfillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        // Statistics

        void totalapps()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalApps.Text = i.ToString();
        }

        void pendingapps()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE Status='Pending' OR Status='Applied' OR Status IS NULL OR Status NOT IN ('Shortlisted', 'Selected', 'Rejected')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblPendingApps.Text = i.ToString();
        }

        void shortlistedapps()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE Status='Shortlisted'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblShortlistedApps.Text = i.ToString();
        }

        void selectedapps()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE Status='Selected'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblSelectedApps.Text = i.ToString();
        }

        void rejectedapps()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications WHERE Status='Rejected'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblRejectedApps.Text = i.ToString();
        }

        AdminClass admin = new AdminClass();

        // Fill GridView / Select all applications

        void applicationfillgrid()
        {
            admin = new AdminClass();
            DataTable dt = admin.select_applications().Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 3.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            gvApplications.DataSource = admin.application_pagination(dt, page);
            gvApplications.DataBind();
            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 3 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            gvApplications.DataSource = admin.application_pagination(dt, 0);
            gvApplications.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 3.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = dt != null && dt.Rows.Count > 3;
        }

        // Search Button Click

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.search_applications(txtSearch.Text).Tables[0]);
        }

        // Status DropDownList SelectedIndexChanged

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_applications_by_status(ddlStatusFilter.SelectedValue).Tables[0]);
        }

        // Reset Button Click

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlStatusFilter.SelectedIndex = 0;
            ViewState["page"] = 0;
            applicationfillgrid();
        }

        // Pagination Click Events

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            applicationfillgrid();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            applicationfillgrid();
        }

        // Row Commands

        protected void gvApplications_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string appId = e.CommandArgument.ToString();
            if (e.CommandName == "cmd_delete")
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM StudentApplications WHERE ApplicationId='" + appId + "'", con);
                cmd.ExecuteNonQuery();
                lblMsg.Text = "Application deleted successfully.";
                lblMsg.Visible = true;
                applicationfillgrid();
            }
        }

        public string GetStatusBadge(object statusObj)
        {
            string status = Convert.ToString(statusObj);
            if (status == "Shortlisted")

                return "<span class='badge-shortlisted'>Shortlisted</span>";
            if (status == "Selected")

                return "<span class='badge-selected'>Selected</span>";
            if (status == "Rejected")

                return "<span class='badge-rejected'>Rejected</span>";
            return "<span class='badge-pending'>Pending</span>";
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            getcon();
            string q = "select a.ApplicationId as [Application Id], s.FullName as [Student Name], s.Email as [Email], " +
                       "i.InternshipTitle as [Internship], c.c_company as [Company], " +
                       "a.AppliedDate as [Applied Date], ISNULL(a.Status, 'Applied') as [Status] " +
                       "from StudentApplications a " +
                       "inner join internship i on a.InternshipId = i.Id " +
                       "inner join c_registration c on i.CompanyId = c.CompanyId " +
                       "inner join Students s on a.StudentId = s.StudentId " +
                       "order by a.ApplicationId desc";
            da = new SqlDataAdapter(q, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            using (MemoryStream ms = new MemoryStream())
            {
                Document doc = new Document(PageSize.A4.Rotate());
                PdfWriter.GetInstance(doc, ms);
                doc.Open();
                PdfPTable table = new PdfPTable(dt.Columns.Count);

                // Add column names
                foreach (DataColumn column in dt.Columns)
                {
                    table.AddCell(column.ColumnName);
                }

                // Add database data
                foreach (DataRow row in dt.Rows)
                {
                    foreach (DataColumn column in dt.Columns)
                    {
                        string value = row[column] == DBNull.Value ? "" : Convert.ToString(row[column]);
                        table.AddCell(value);
                    }
                }

                doc.Add(table);
                doc.Close();
                byte[] bytes = ms.ToArray();
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", "attachment; filename=StudentApplicationsReport.pdf");
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.SuppressContent = true;
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }
}

using System;
using System.Web;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.IO;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web.Design;
namespace asp.net
{
    public partial class admin_student_applications : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new ReportDocument();
        static string Crypath = "";

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
            //getcon();

            //string q = "select a.ApplicationId as [Application Id], s.FullName as [Student Name], s.Email as [Email], " +
            //           "i.InternshipTitle as [Internship], c.c_company as [Company], " +
            //           "a.AppliedDate as [Applied Date], ISNULL(a.Status, 'Applied') as [Status] " +
            //           "from StudentApplications a " +
            //           "inner join internship i on a.InternshipId = i.Id " +
            //           "inner join c_registration c on i.CompanyId = c.CompanyId " +
            //           "inner join Students s on a.StudentId = s.StudentId " +
            //           "order by a.ApplicationId desc";

            //da = new SqlDataAdapter(q, con);
            //DataTable dt = new DataTable();
            //da.Fill(dt);

            ////create pdf document
            //Document pdfdoc = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            //MemoryStream ms = new MemoryStream();
            //PdfWriter.GetInstance(pdfdoc, ms);
            //pdfdoc.Open();

            ////add title
            //pdfdoc.Add(new Paragraph("Student Applications Report"));
            //pdfdoc.Add(new Paragraph(""));

            ////create pdf table
            //PdfPTable pdfPTable = new PdfPTable(dt.Columns.Count);
            //pdfPTable.WidthPercentage = 100;

            ////add headers
            //foreach (DataColumn column in dt.Columns)
            //{
            //    pdfPTable.AddCell(new Phrase(column.ColumnName));
            //}

            ////add data rows
            //foreach (DataRow row in dt.Rows)
            //{
            //    foreach (object cell in row.ItemArray)
            //    {
            //        pdfPTable.AddCell(new Phrase(cell.ToString()));
            //    }
            //}
            //pdfdoc.Add(pdfPTable);
            //pdfdoc.Close();

            ////send pdf to browser
            //Response.ContentType = "application/pdf";
            //Response.AddHeader("Content-Disposition", "attachment; filename=StudentApplicationsReport.pdf");
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.BinaryWrite(ms.ToArray());
            //Response.End();

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
            ds = new DataSet();
            da.Fill(ds);
            string s = Server.MapPath("~/admin_students_applications_report_data.xml");
            ds.WriteXmlSchema(s);

            //Now add crystalreportviewer to view the report.
            Crypath = Server.MapPath("~/AdminPanel/admin_students_applications_report.rpt");
            cr.Load(Crypath);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer5.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "Admin Students Applications Report");
        }
    }
}

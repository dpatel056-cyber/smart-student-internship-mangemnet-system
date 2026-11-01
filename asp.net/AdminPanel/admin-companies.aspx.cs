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
    public partial class admin_companies : System.Web.UI.Page
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

        AdminClass admin = new AdminClass();
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
                    companyfillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        // Fill GridView with pagination (3 rows per page)

        void companyfillgrid()
        {
            admin = new AdminClass();
            DataTable dt = admin.select_companies().Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 3.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            GridView1.DataSource = admin.company_pagination(dt, page);
            GridView1.DataBind();
            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 3 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            GridView1.DataSource = admin.company_pagination(dt, 0);
            GridView1.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 3.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = dt != null && dt.Rows.Count > 3;
        }

        // Search Button Click

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.search_companies(txtSearch.Text).Tables[0]);
        }

        // Industry DropDownList SelectedIndexChanged

        protected void ddlIndustry_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_companies_by_industry(ddlIndustry.SelectedValue).Tables[0]);
        }

        // Location DropDownList SelectedIndexChanged

        protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_companies_by_location(ddlLocation.SelectedValue).Tables[0]);
        }

        // Status DropDownList SelectedIndexChanged

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_companies_by_status(ddlStatus.SelectedValue).Tables[0]);
        }

        // Reset Button Click

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlIndustry.SelectedIndex = 0;
            ddlLocation.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            ViewState["page"] = 0;
            companyfillgrid();
        }

        // Pagination Click Events

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            companyfillgrid();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            companyfillgrid();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string id = e.CommandArgument.ToString();
            if (e.CommandName == "cmd_view")
            {
                Response.Redirect("viewCompanyDetails.aspx?id=" + id);
            }

            if (e.CommandName == "cmd_toggle_block")
            {
                getcon();
                cmd = new SqlCommand("SELECT IsBlocked FROM c_registration WHERE CompanyId=" + id, con);
                bool blocked = Convert.ToBoolean(cmd.ExecuteScalar());
                int block = blocked ? 0 : 1;
                cmd = new SqlCommand("UPDATE c_registration SET IsBlocked=" + block + ", Status='" + (block == 1 ? "Blocked" : "Active") + "' WHERE CompanyId=" + id, con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("UPDATE internship SET Status='" + (block == 1 ? "Inactive" : "Active") + "' WHERE CompanyId=" + id, con);
                cmd.ExecuteNonQuery();
                companyfillgrid();
            }

            if (e.CommandName == "cmd_del")
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM internship WHERE CompanyId=" + id, con);
                cmd.ExecuteNonQuery();
                cmd = new SqlCommand("DELETE FROM c_registration WHERE CompanyId=" + id, con);
                cmd.ExecuteNonQuery();
                companyfillgrid();
            }
        }
        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            //getcon();

            //string q = "select c.CompanyId as [Company Id], c.c_company as [Company Name], c.c_email as [Email], " +
            //           "c.c_contact as [Contact], ISNULL(c.c_industry, 'General') as [Industry], " +
            //           "ISNULL(c.c_city, 'N/A') as [City], " +
            //           "case when c.IsBlocked = 1 or c.Status = 'Blocked' then 'Blocked' else 'Active' end as [Status] " +
            //           "from c_registration c " +
            //           "order by c.CompanyId desc";

            //da = new SqlDataAdapter(q, con);
            //DataTable dt = new DataTable();
            //da.Fill(dt);

            ////create pdf document
            //Document pdfdoc = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            //MemoryStream ms = new MemoryStream();
            //PdfWriter.GetInstance(pdfdoc, ms);
            //pdfdoc.Open();

            ////add title
            //pdfdoc.Add(new Paragraph("Companies Report"));
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
            //Response.AddHeader("Content-Disposition", "attachment; filename=CompaniesReport.pdf");
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.BinaryWrite(ms.ToArray());
            //Response.End();

            getcon();
            string q = "select c.CompanyId as [Company Id], c.c_company as [Company Name], c.c_email as [Email], " +
                       "c.c_contact as [Contact], ISNULL(c.c_industry, 'General') as [Industry], " +
                       "ISNULL(c.c_city, 'N/A') as [City], " +
                       "case when c.IsBlocked = 1 or c.Status = 'Blocked' then 'Blocked' else 'Active' end as [Status] " +
                       "from c_registration c " +
                       "order by c.CompanyId desc";

            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            string s = Server.MapPath("~/admin_companies_report_data.xml");
            ds.WriteXmlSchema(s);

            //Now add crystalreportviewer to view the report.
            string path = Server.MapPath("~/AdminPanel/admin_companies_report.rpt");
            cr.Load(path);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer4.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "Admin Companies Report");

        }
    }
}

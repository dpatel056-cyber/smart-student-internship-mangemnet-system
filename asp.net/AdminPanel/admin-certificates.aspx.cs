using asp.net;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;
using CrystalDecisions.Web.Design;
//using iTextSharp.text;
//using iTextSharp.text.pdf;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
//using System.IO;
using System.Web;
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
                    certificatefillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void certificatefillgrid()
        {
            admin = new AdminClass();
            DataTable dt = admin.select_certificates().Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 5.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            GridView1.DataSource = admin.certificate_pagination(dt, page);
            GridView1.DataBind();
            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 5 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            GridView1.DataSource = admin.certificate_pagination(dt, 0);
            GridView1.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 5.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = dt != null && dt.Rows.Count > 5;
        }

        // Search Button Click

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.search_certificates(txtSearch.Text).Tables[0]);
        }

        // Reset Button Click

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ViewState["page"] = 0;
            certificatefillgrid();
        }

        // Pagination Click Events

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            certificatefillgrid();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            certificatefillgrid();
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
                certificatefillgrid();
            }
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            //getcon();

            //string q = "select cc.CertificateNo as [Certificate No], s.FullName as [Student Name], " +
            //           "c.c_company as [Company], ISNULL(i.InternshipTitle, cc.CertificateTitle) as [Internship], " +
            //           "cc.IssueDate as [Issue Date], ISNULL(cc.Performance, 'Completed') as [Performance] " +
            //           "from CompanyCertificates cc " +
            //           "inner join Students s on cc.StudentId = s.StudentId " +
            //           "inner join c_registration c on cc.CompanyId = c.CompanyId " +
            //           "left join internship i on cc.InternshipId = i.Id " +
            //           "order by cc.CertificateId desc";

            //da = new SqlDataAdapter(q, con);
            //DataTable dt = new DataTable();
            //da.Fill(dt);

            ////create pdf document
            //Document pdfdoc = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            //MemoryStream ms = new MemoryStream();
            //PdfWriter.GetInstance(pdfdoc, ms);
            //pdfdoc.Open();

            ////add title
            //pdfdoc.Add(new Paragraph("Certificates Report"));
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
            //Response.AddHeader("Content-Disposition", "attachment; filename=CertificatesReport.pdf");
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.BinaryWrite(ms.ToArray());
            //Response.End();

            getcon();
            string q = "select cc.CertificateNo as [Certificate No], s.FullName as [Student Name], " +
                       "c.c_company as [Company], ISNULL(i.InternshipTitle, cc.CertificateTitle) as [Internship], " +
                       "cc.IssueDate as [Issue Date], ISNULL(cc.Performance, 'Completed') as [Performance] " +
                       "from CompanyCertificates cc " +
                       "inner join Students s on cc.StudentId = s.StudentId " +
                       "inner join c_registration c on cc.CompanyId = c.CompanyId " +
                       "left join internship i on cc.InternshipId = i.Id " +
                       "order by cc.CertificateId desc";

            da = new SqlDataAdapter(q, con);
           // da = new SqlDataAdapter("select * from Cat_tbl", con);
            ds = new DataSet();
            da.Fill(ds);
            string s = Server.MapPath("~/admin_certificate_report_data.xml");
            ds.WriteXmlSchema(s);

            //Now add crystalreportviewer to view the report.
            string path = Server.MapPath("~/AdminPanel/admin_certificate_report.rpt");
            cr.Load(path);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "Admin Certificate Report");
        }
    }
}

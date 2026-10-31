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
    public partial class admin_offer_letters : System.Web.UI.Page
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
                da = new SqlDataAdapter("SELECT * FROM admin_registration WHERE Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (!IsPostBack)
                {
                    ViewState["page"] = 0;
                    totaloffers();
                    acceptedoffers();
                    pendingoffers();
                    rejectedoffers();
                    offerletterfillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void totaloffers()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyOfferLetters", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalOffers.Text = i.ToString();
        }

        void acceptedoffers()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyOfferLetters WHERE Status='Accepted'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblAcceptedOffers.Text = i.ToString();
        }

        void pendingoffers()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyOfferLetters WHERE Status='Offered' OR Status='Pending'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblPendingOffers.Text = i.ToString();
        }

        void rejectedoffers()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyOfferLetters WHERE Status='Rejected' OR Status='Withdrawn' OR Status='Declined'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblRejectedOffers.Text = i.ToString();
        }

        void offerletterfillgrid()
        {
            admin = new AdminClass();
            DataTable dt = admin.select_offer_letters().Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 6.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            DataListOfferLetters.DataSource = admin.offer_letter_pagination(dt, page);
            DataListOfferLetters.DataBind();
            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 6 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            DataListOfferLetters.DataSource = admin.offer_letter_pagination(dt, 0);
            DataListOfferLetters.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 6.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = dt != null && dt.Rows.Count > 6;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.search_offer_letters(txtSearch.Text).Tables[0]);
        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_offer_letters_by_status(ddlStatus.SelectedValue).Tables[0]);
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlStatus.SelectedIndex = 0;
            ViewState["page"] = 0;
            offerletterfillgrid();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            offerletterfillgrid();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            offerletterfillgrid();
        }

        protected void DataListOfferLetters_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                Response.Redirect("admin-offer-letter-view.aspx?id=" + e.CommandArgument);
            }
            else if (e.CommandName == "cmd_delete")
            {
                getcon();
                cmd = new SqlCommand("delete from CompanyOfferLetters where OfferId='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                offerletterfillgrid();
            }
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            //getcon();

            //string q = "select o.OfferId as [Offer Id], ISNULL(s.FullName, 'Student') as [Student Name], " +
            //           "ISNULL(c.c_company, 'Company') as [Company], " +
            //           "ISNULL(i.InternshipTitle, o.OfferTitle) as [Internship], " +
            //           "ISNULL(o.Stipend, 'N/A') as [Stipend], o.JoiningDate as [Joining Date], " +
            //           "o.IssuedDate as [Issue Date], ISNULL(o.Status, 'Offered') as [Status] " +
            //           "from CompanyOfferLetters o " +
            //           "left join Students s on o.StudentId = s.StudentId " +
            //           "left join c_registration c on o.CompanyId = c.CompanyId " +
            //           "left join internship i on o.InternshipId = i.Id " +
            //           "order by o.OfferId desc";

            //da = new SqlDataAdapter(q, con);
            //DataTable dt = new DataTable();
            //da.Fill(dt);

            ////create pdf document 
            //Document pdfdoc = new Document(PageSize.A4, 10f, 10f, 10f, 10f);
            //MemoryStream ms = new MemoryStream();
            //PdfWriter.GetInstance(pdfdoc, ms);
            //pdfdoc.Open();

            ////add title
            //pdfdoc.Add(new Paragraph("Offer Letters Report"));
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
            //Response.AddHeader("Content-Disposition", "attachment; filename=OfferLettersReport.pdf");
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.BinaryWrite(ms.ToArray());
            //Response.End();

            getcon();
            string q = "select o.OfferId as [Offer Id], ISNULL(s.FullName, 'Student') as [Student Name], " +
                       "ISNULL(c.c_company, 'Company') as [Company], " +
                       "ISNULL(i.InternshipTitle, o.OfferTitle) as [Internship], " +
                       "ISNULL(o.Stipend, 'N/A') as [Stipend], o.JoiningDate as [Joining Date], " +
                       "o.IssuedDate as [Issue Date], ISNULL(o.Status, 'Offered') as [Status] " +
                       "from CompanyOfferLetters o " +
                       "left join Students s on o.StudentId = s.StudentId " +
                       "left join c_registration c on o.CompanyId = c.CompanyId " +
                       "left join internship i on o.InternshipId = i.Id " +
                       "order by o.OfferId desc";

            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            string s = Server.MapPath("~/admin_offer_letters_report_data.xml");
            ds.WriteXmlSchema(s);

            //Now add crystalreportviewer to view the report.
            string path = Server.MapPath("~/AdminPanel/admin_offer_letters_report.rpt");
            cr.Load(path);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer7.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "Admin Offer Letters Report");
        }
    }
}

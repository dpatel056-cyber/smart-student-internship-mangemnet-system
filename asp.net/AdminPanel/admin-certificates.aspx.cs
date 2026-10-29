using System;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.IO;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using asp.net;
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
                Response.AddHeader("Content-Disposition", "attachment; filename=CertificatesReport.pdf");
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.SuppressContent = true;
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }
}

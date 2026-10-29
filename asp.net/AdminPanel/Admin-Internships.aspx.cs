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
    public partial class admin_internships : System.Web.UI.Page
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
                    internshipfillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void internshipfillgrid()
        {
            admin = new AdminClass();
            DataTable dt = admin.select_internships().Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 12.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            DataListAdminInternships.DataSource = admin.internship_pagination(dt, page);
            DataListAdminInternships.DataBind();
            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 12 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            DataListAdminInternships.DataSource = admin.internship_pagination(dt, 0);
            DataListAdminInternships.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 12.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = dt != null && dt.Rows.Count > 12;
        }

        // Search Button Click

protected void btnSearch_Click(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.search_internships(txtSearch.Text).Tables[0]);
        }

        // Domain DropDownList SelectedIndexChanged

        protected void ddlDomain_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_internships_by_domain(ddlDomain.SelectedValue).Tables[0]);
        }

        // Location DropDownList SelectedIndexChanged

        protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_internships_by_location(ddlLocation.SelectedValue).Tables[0]);
        }

        // WorkMode DropDownList SelectedIndexChanged

        protected void ddlWorkMode_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_internships_by_workmode(ddlWorkMode.SelectedValue).Tables[0]);
        }

        // Type DropDownList SelectedIndexChanged

        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_internships_by_type(ddlType.SelectedValue).Tables[0]);
        }

        // Status DropDownList SelectedIndexChanged

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_internships_by_status(ddlStatus.SelectedValue).Tables[0]);
        }

        // Clear Filters Click

protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlDomain.SelectedIndex = 0;
            ddlLocation.SelectedIndex = 0;
            ddlWorkMode.SelectedIndex = 0;
            ddlType.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            ViewState["page"] = 0;
            internshipfillgrid();
        }

        // Pagination Click Events

protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            internshipfillgrid();
        }

protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            internshipfillgrid();
        }

        protected void DataListAdminInternships_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                Response.Redirect("admin-internship-details.aspx?id=" + e.CommandArgument);
            }
            else if (e.CommandName == "cmd_delete")
            {
                getcon();
                cmd = new SqlCommand("delete from internship where Id='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                internshipfillgrid();
            }
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            getcon();
            string q = "select i.Id as [Internship Id], i.InternshipTitle as [Title], c.c_company as [Company], " +
                       "i.InternshipDomain as [Domain], i.InternshipDuration as [Duration], " +
                       "i.InternshipStipend as [Stipend], i.WorkMode as [Mode], " +
                       "ISNULL(i.InternshipStatus, 'Active') as [Status] " +
                       "from internship i " +
                       "inner join c_registration c on i.CompanyId = c.CompanyId " +
                       "order by i.Id desc";
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
                Response.AddHeader("Content-Disposition", "attachment; filename=InternshipsReport.pdf");
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.SuppressContent = true;
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }
}

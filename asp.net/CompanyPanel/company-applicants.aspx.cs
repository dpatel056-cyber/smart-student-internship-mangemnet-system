using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace asp.net
{
    public partial class company_applicants : System.Web.UI.Page
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

        CompanyClass comp = new CompanyClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (!IsPostBack)
                {
                    ViewState["page"] = 0;
                    applicantfillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        // Fill GridView with pagination (4 rows per page)
        void applicantfillgrid()
        {
            comp = new CompanyClass();
            DataTable dt = comp.select_applicants().Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 4.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }
            gvApplicants.DataSource = comp.applicant_pagination(dt, page);
            gvApplicants.DataBind();
            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 4 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            gvApplicants.DataSource = comp.applicant_pagination(dt, 0);
            gvApplicants.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 4.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = dt != null && dt.Rows.Count > 4;
        }

        // Search Button Click
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            comp = new CompanyClass();
            filtergrid(comp.search_applicants(txtSearch.Text).Tables[0]);
        }

        // Status DropDownList SelectedIndexChanged
        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            comp = new CompanyClass();
            filtergrid(comp.select_applicants_by_status(ddlStatusFilter.SelectedValue).Tables[0]);
        }

        // Reset Button Click
        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlStatusFilter.SelectedIndex = 0;
            ViewState["page"] = 0;
            applicantfillgrid();
        }

        // Generate Report Button Click (Admin Panel style PDF Export)
        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            getcon();
            string q = "select a.ApplicationId as [Application Id], ISNULL(a.FullName, s.FullName) as [Student Name], ISNULL(a.StudentEmail, s.Email) as [Email], " +
                       "i.InternshipTitle as [Internship], " +
                       "a.AppliedDate as [Applied Date], ISNULL(a.Status, 'Applied') as [Status] " +
                       "from StudentApplications a " +
                       "inner join internship i on a.InternshipId = i.Id " +
                       "left join Students s on a.StudentId = s.StudentId " +
                       "where i.CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "') " +
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
                Response.AddHeader("Content-Disposition", "attachment; filename=CompanyApplicantsReport.pdf");
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.SuppressContent = true;
                Context.ApplicationInstance.CompleteRequest();
            }
        }

        // Pagination Click Events
        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            applicantfillgrid();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            applicantfillgrid();
        }

        protected void gvApplicants_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvApplicants.EditIndex = e.NewEditIndex;
            applicantfillgrid();
        }

        protected void gvApplicants_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvApplicants.EditIndex = -1;
            applicantfillgrid();
        }

        protected void gvApplicants_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int appId = Convert.ToInt32(gvApplicants.DataKeys[e.RowIndex].Value.ToString());
            GridViewRow row = (GridViewRow)gvApplicants.Rows[e.RowIndex];
            DropDownList ddl = (DropDownList)row.FindControl("ddlChangeStatus");
            string status = ddl.SelectedValue;
            getcon();
            cmd = new SqlCommand("update StudentApplications set Status='" + status + "' where ApplicationId='" + appId + "'", con);
            cmd.ExecuteNonQuery();
            gvApplicants.EditIndex = -1;
            applicantfillgrid();
        }

        public string GetStatusBadge(object status)
        {
            if (status == null || status == DBNull.Value)
            {
                return "<span class='badge-status-chip st-applied'>Applied</span>";
            }
            if (status.ToString() == "Shortlisted")
            {
                return "<span class='badge-status-chip st-shortlisted'>Shortlisted</span>";
            }
            if (status.ToString() == "Selected")
            {
                return "<span class='badge-status-chip st-selected'>Selected</span>";
            }
            if (status.ToString() == "Rejected")
            {
                return "<span class='badge-status-chip st-rejected'>Rejected</span>";
            }
            return "<span class='badge-status-chip st-applied'>" + status.ToString() + "</span>";
        }
    }
}

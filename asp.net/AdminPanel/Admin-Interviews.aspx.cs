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
    public partial class admin_interviews : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;
        AdminClass admin = new AdminClass();
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
                    interviewfillgrid();
                    totalinterviews();
                    scheduledinterviews();
                    completedinterviews();
                    cancelledinterviews();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void totalinterviews()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyInterviews", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalInterviews.Text = i.ToString();
        }

        void scheduledinterviews()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyInterviews WHERE Status='Scheduled'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblScheduled.Text = i.ToString();
        }

        void completedinterviews()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyInterviews WHERE Status='Completed'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblCompleted.Text = i.ToString();
        }

        void cancelledinterviews()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyInterviews WHERE Status='Cancelled'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblCancelled.Text = i.ToString();
        }

        void interviewfillgrid()
        {
            admin = new AdminClass();
            DataTable dt = admin.select_interviews().Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 3.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            dlInterviews.DataSource = admin.interview_pagination(dt, page);
            dlInterviews.DataBind();
            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 3 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            dlInterviews.DataSource = admin.interview_pagination(dt, 0);
            dlInterviews.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 3.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = dt != null && dt.Rows.Count > 3;
        }

        // Search Button Click

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.search_interviews(txtSearch.Text).Tables[0]);
        }

        // Status DropDownList SelectedIndexChanged

        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_interviews_by_status(ddlStatusFilter.SelectedValue).Tables[0]);
        }

        // Reset Button Click

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlStatusFilter.SelectedIndex = 0;
            ViewState["page"] = 0;
            interviewfillgrid();
        }

        // Pagination Click Events

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            interviewfillgrid();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            interviewfillgrid();
        }

        public string GetStatusBadge(object status)
        {
            string st = Convert.ToString(status);
            if (st == "Completed")

                return "<span class='status-completed'><i class='fa-solid fa-circle-check'></i> Completed</span>";
            if (st == "Cancelled")

                return "<span class='status-cancelled'><i class='fa-solid fa-ban'></i> Cancelled</span>";
            return "<span class='status-scheduled'><i class='fa-solid fa-calendar-check'></i> Scheduled</span>";
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            getcon();
            string q = "select civ.InterviewId as [Interview Id], s.FullName as [Student Name], " +
                       "c.c_company as [Company], i.InternshipTitle as [Internship], " +
                       "civ.InterviewDate as [Date], civ.InterviewTime as [Time], " +
                       "civ.InterviewType as [Type], ISNULL(civ.Status, 'Scheduled') as [Status] " +
                       "from CompanyInterviews civ " +
                       "inner join Students s on civ.StudentId = s.StudentId " +
                       "inner join internship i on civ.InternshipId = i.Id " +
                       "inner join c_registration c on civ.CompanyId = c.CompanyId " +
                       "order by civ.InterviewId desc";
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
                Response.AddHeader("Content-Disposition", "attachment; filename=InterviewsReport.pdf");
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.SuppressContent = true;
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }
}

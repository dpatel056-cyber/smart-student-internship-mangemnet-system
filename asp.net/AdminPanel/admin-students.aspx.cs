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
    public partial class admin_students : System.Web.UI.Page
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
                    studentfillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        // Fill GridView / Select all students

        void studentfillgrid()
        {
            admin = new AdminClass();
            DataTable dt = admin.select_students().Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 5.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            GridView1.DataSource = admin.student_pagination(dt, page);
            GridView1.DataBind();
            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 5 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            GridView1.DataSource = admin.student_pagination(dt, 0);
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
            filtergrid(admin.search_students(txtSearch.Text).Tables[0]);
        }

        // Course DropDownList SelectedIndexChanged

        protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_students_by_course(ddlCourse.SelectedValue).Tables[0]);
        }

        // Status DropDownList SelectedIndexChanged

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_students_by_status(ddlStatus.SelectedValue).Tables[0]);
        }

        // Reset Button Click

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlCourse.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            ViewState["page"] = 0;
            studentfillgrid();
        }

        // Pagination Click Events

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            studentfillgrid();
        }

protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            studentfillgrid();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("viewStudentDetails.aspx?id=" + id);
            }
            else if (e.CommandName == "cmd_toggle_block")
            {
                string id = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("SELECT IsBlocked FROM Students WHERE StudentId='" + id + "'", con);
                ds = new DataSet();
                da = new SqlDataAdapter(cmd);
                da.Fill(ds);
                if (Convert.ToBoolean(ds.Tables[0].Rows[0]["IsBlocked"]))
                {
                    cmd = new SqlCommand("UPDATE Students SET IsBlocked=0, Status='Active' WHERE StudentId='" + id + "'", con);
                }
                else
                {
                    cmd = new SqlCommand("UPDATE Students SET IsBlocked=1, Status='Blocked' WHERE StudentId='" + id + "'", con);
                }

                cmd.ExecuteNonQuery();
                studentfillgrid();
            }
            else if (e.CommandName == "cmd_del")
            {
                string id = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("DELETE FROM StudentTasks WHERE StudentId=" + id + "; " + "DELETE FROM StudentProjects WHERE StudentId=" + id + "; " + "DELETE FROM StudentSkills WHERE StudentId=" + id + "; " + "DELETE FROM StudentQuizAssignments WHERE StudentId=" + id + "; " + "DELETE FROM StudentSavedInternships WHERE StudentId=" + id + "; " + "DELETE FROM CompanyCertificates WHERE StudentId=" + id + "; " + "DELETE FROM CompanyOfferLetters WHERE StudentId=" + id + "; " + "DELETE FROM CompanyInterviews WHERE StudentId=" + id + "; " + "DELETE FROM StudentApplications WHERE StudentId=" + id + "; " + "DELETE FROM Students WHERE StudentId=" + id, con);
                cmd.ExecuteNonQuery();
                studentfillgrid();
            }
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            getcon();
            string q = "select s.StudentId as [Student Id], s.FullName as [Name], s.Email as [Email], " +
                       "s.ContactNo as [Contact], ISNULL(s.College, 'N/A') as [College], " +
                       "ISNULL(s.Course, 'N/A') as [Course], " +
                       "case when s.IsBlocked = 1 then 'Blocked' else 'Active' end as [Status] " +
                       "from Students s " +
                       "order by s.StudentId desc";
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
                Response.AddHeader("Content-Disposition", "attachment; filename=StudentsReport.pdf");
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.SuppressContent = true;
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }
}

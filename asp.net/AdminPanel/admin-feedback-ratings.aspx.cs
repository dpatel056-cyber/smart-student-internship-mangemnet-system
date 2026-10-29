using System;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.IO;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace asp.net.css
{
    public partial class admin_feedback_ratings : System.Web.UI.Page
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
                    totalfeedback();
                    studentfeedback();
                    companyfeedback();
                    avgrating();
                    feedbackfillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void totalfeedback()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM PlatformFeedback", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalFeedback.Text = i.ToString();
        }

        void studentfeedback()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM PlatformFeedback WHERE SenderType='Student'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblStudentFeedback.Text = i.ToString();
        }

        void companyfeedback()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM PlatformFeedback WHERE SenderType='Company'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblCompanyFeedback.Text = i.ToString();
        }

        void avgrating()
        {
            getcon();
            cmd = new SqlCommand("SELECT ISNULL(AVG(CAST(Rating AS FLOAT)), 5) FROM PlatformFeedback", con);
            double i = Convert.ToDouble(cmd.ExecuteScalar());
            lblAvgRating.Text = i.ToString("0.0") + " / 5";
        }

        AdminClass admin = new AdminClass();
        void feedbackfillgrid()
        {
            admin = new AdminClass();
            DataTable dt = admin.select_feedback().Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 5.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            gvFeedback.DataSource = admin.feedback_pagination(dt, page);
            gvFeedback.DataBind();
            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 5 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            gvFeedback.DataSource = admin.feedback_pagination(dt, 0);
            gvFeedback.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 5.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = dt != null && dt.Rows.Count > 5;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.search_feedback(txtSearch.Text).Tables[0]);
        }

        protected void ddlFilterType_SelectedIndexChanged(object sender, EventArgs e)
        {
            admin = new AdminClass();
            filtergrid(admin.select_feedback_by_type(ddlFilterType.SelectedValue).Tables[0]);
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlFilterType.SelectedIndex = 0;
            ViewState["page"] = 0;
            feedbackfillgrid();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            feedbackfillgrid();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            feedbackfillgrid();
        }

        protected void gvFeedback_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewFeedback")
            {
                getcon();
                da = new SqlDataAdapter("SELECT pf.*, c.c_company, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN c_registration c ON pf.CompanyId=c.CompanyId LEFT JOIN internship i ON pf.InternshipId=i.Id WHERE pf.FeedbackId=" + e.CommandArgument, con);
                ds = new DataSet();
                da.Fill(ds);
                drSenderName.Text = ds.Tables[0].Rows[0]["SenderName"].ToString();
                drSenderEmail.Text = ds.Tables[0].Rows[0]["SenderEmail"].ToString();
                drSenderLabel.Text = ds.Tables[0].Rows[0]["SenderType"].ToString().ToUpper();
                drRatingScore.Text = ds.Tables[0].Rows[0]["Rating"].ToString() + " / 5";
                drSubject.Text = ds.Tables[0].Rows[0]["Subject"].ToString();
                drMessage.Text = ds.Tables[0].Rows[0]["Message"].ToString();
                drSubmittedDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CreatedDate"]).ToString("dd MMM yyyy");
                drSubmittedTime.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CreatedDate"]).ToString("hh:mm tt");
                drTarget.Text = ds.Tables[0].Rows[0]["FeedbackCategory"].ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenDrawer", "openDrawer();", true);
            }
            else if (e.CommandName == "cmd_delete")
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM PlatformFeedback WHERE FeedbackId=" + e.CommandArgument, con);
                cmd.ExecuteNonQuery();
                lblMsg.Text = "Feedback deleted successfully.";
                lblMsg.Visible = true;
                feedbackfillgrid();
            }
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            getcon();
            string q = "select pf.FeedbackId as [Id], pf.SenderName as [User], pf.SenderEmail as [Email], " +
                       "pf.SenderType as [Role], pf.Rating as [Rating], " +
                       "ISNULL(pf.FeedbackCategory, 'General') as [Category], " +
                       "pf.Message as [Message], pf.CreatedDate as [Date] " +
                       "from PlatformFeedback pf " +
                       "order by pf.FeedbackId desc";
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
                Response.AddHeader("Content-Disposition", "attachment; filename=FeedbackReport.pdf");
                Response.BinaryWrite(bytes);
                Response.Flush();
                Response.SuppressContent = true;
                Context.ApplicationInstance.CompleteRequest();
            }
        }
    }
}

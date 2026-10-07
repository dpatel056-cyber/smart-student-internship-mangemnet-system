using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace asp.net
{
    public partial class company_feedback : System.Web.UI.Page
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
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (!IsPostBack)
                {
                    bindStudentReviews();
                    bindSentFeedbacks();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }
        void bindStudentReviews()
        {
            string compEmail = Session["company"].ToString();
            getcon();
            string query = "SELECT pf.*, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN internship i ON pf.InternshipId = i.Id WHERE pf.SenderType='Student' AND pf.FeedbackType='Company' AND pf.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') ORDER BY pf.FeedbackId DESC";
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvStudentReviews.DataSource = ds.Tables[0];
                gvStudentReviews.DataBind();
                gvStudentReviews.Visible = true;
                pnlNoStudentReviews.Visible = false;
                lblStudentReviewCount.Text = "(" + ds.Tables[0].Rows.Count + " reviews)";
            }
            else
            {
                gvStudentReviews.Visible = false;
                pnlNoStudentReviews.Visible = true;
                lblStudentReviewCount.Text = "(0 reviews)";
            }
        }
        void bindSentFeedbacks()
        {
            string compEmail = Session["company"].ToString();
            getcon();
            string query = "SELECT * FROM PlatformFeedback WHERE SenderType='Company' AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') ORDER BY FeedbackId DESC";
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvSentFeedbacks.DataSource = ds.Tables[0];
                gvSentFeedbacks.DataBind();
                gvSentFeedbacks.Visible = true;
                pnlNoFeedback.Visible = false;
            }
            else
            {
                gvSentFeedbacks.Visible = false;
                pnlNoFeedback.Visible = true;
            }
        }
        protected void btnSubmitFeedback_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtSubject.Text.Trim()) || string.IsNullOrEmpty(txtMessage.Text.Trim()))
            {
                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-exclamation'></i> Please enter both subject and message.</div>";
                lblMsg.Visible = true;
                return;
            }
            string compEmail = Session["company"].ToString();
            string cat = ddlCategory.SelectedValue;
            string rating = ddlRating.SelectedValue;
            string subject = txtSubject.Text.Trim();
            string msg = txtMessage.Text.Trim();
            getcon();
            // Get company details
            string compName = compEmail;
            string compId = "NULL";
            da = new SqlDataAdapter("SELECT CompanyId, c_company FROM c_registration WHERE c_email='" + compEmail + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                compId = ds.Tables[0].Rows[0]["CompanyId"].ToString();
                if (ds.Tables[0].Rows[0]["c_company"] != DBNull.Value)
                {
                    compName = ds.Tables[0].Rows[0]["c_company"].ToString();
                }
            }
            string insertSql = "INSERT INTO PlatformFeedback (SenderType, SenderName, SenderEmail, FeedbackType, CompanyId, FeedbackCategory, Rating, Subject, Message, CreatedDate) VALUES ('Company', '" + compName.Replace("'", "''") + "', '" + compEmail.Replace("'", "''") + "', 'General', " + compId + ", '" + cat + "', " + int.Parse(rating) + ", '" + subject.Replace("'", "''") + "', '" + msg.Replace("'", "''") + "', GETDATE())";
            cmd = new SqlCommand(insertSql, con);
            cmd.ExecuteNonQuery();
            // Log Activity if table exists
            SqlCommand actCmd = new SqlCommand("INSERT INTO CompanyActivityHistory (CompanyId, ActivityType, Description, IPAddress, ActivityDate) VALUES (" + compId + ", 'Feedback Submitted', 'Submitted feedback to admin: " + subject.Replace("'", "''") + "', '" + Request.UserHostAddress + "', GETDATE())", con);
            actCmd.ExecuteNonQuery();
            lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-check-circle'></i> Thank you! Your feedback has been submitted to the platform admin.</div>";
            lblMsg.Visible = true;
            txtSubject.Text = "";
            txtMessage.Text = "";
            bindSentFeedbacks();
        }
        protected void gvSentFeedbacks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_delete")
            {
                string id = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("DELETE FROM PlatformFeedback WHERE FeedbackId=" + id + " AND SenderType='Company'", con);
                cmd.ExecuteNonQuery();
                lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-check-circle'></i> Feedback deleted successfully.</div>";
                lblMsg.Visible = true;
                bindSentFeedbacks();
            }
        }
        public string GetStars(object ratingObj)
        {
            int rating = 5;
            if (ratingObj != null && int.TryParse(ratingObj.ToString(), out int r))
            {
                rating = r;
            }
            string html = "<span style='color:#f59e0b; font-size:12px; white-space:nowrap; display:inline-flex; align-items:center; gap:2px;'>";
            for (int i = 1; i <= 5; i++)
            {
                if (i <= rating)
                    html += "<i class='fa-solid fa-star'></i>";
                else
                    html += "<i class='fa-regular fa-star' style='color:#cbd5e1;'></i>";
            }
            html += "</span>";
            return html;
        }
        public string FormatDate(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return "N/A";
            if (DateTime.TryParse(dateObj.ToString(), out DateTime dt))
            {
                return dt.ToString("dd MMM yyyy");
            }
            return dateObj.ToString();
        }
        public string FormatTime(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return "";
            if (DateTime.TryParse(dateObj.ToString(), out DateTime dt))
            {
                return dt.ToString("hh:mm tt");
            }
            return "";
        }
        public string CleanJsString(object obj)
        {
            if (obj == null || obj == DBNull.Value) return "";
            string str = obj.ToString();
            return str.Replace("\\", "\\\\").Replace("'", "\\'").Replace("\"", "\\\"").Replace("\r\n", " ").Replace("\n", " ").Replace("\r", " ");
        }
    }
}
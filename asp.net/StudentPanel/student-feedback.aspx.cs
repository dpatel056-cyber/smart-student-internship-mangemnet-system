using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace asp.net
{
    public partial class student_feedback : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (!IsPostBack)
                {
                    bindCompanyInternshipDropdown();
                    fillGrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        void bindCompanyInternshipDropdown()
        {
            string studentEmail = Session["student"].ToString();
            getcon();
            da = new SqlDataAdapter("select distinct i.Id as InternshipId, c.CompanyId, i.InternshipTitle, c.c_company from StudentApplications a inner join internship i on a.InternshipId=i.Id inner join c_registration c on i.CompanyId=c.CompanyId where a.StudentEmail='" + studentEmail + "' union select i.Id as InternshipId, c.CompanyId, i.InternshipTitle, c.c_company from internship i inner join c_registration c on i.CompanyId=c.CompanyId order by c.c_company, i.InternshipTitle", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlCompanyInternship.Items.Clear();
            ddlCompanyInternship.Items.Add(new ListItem("-- Select Company & Internship --", ""));
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string text = ds.Tables[0].Rows[i]["c_company"].ToString() + " - " + ds.Tables[0].Rows[i]["InternshipTitle"].ToString();
                string value = ds.Tables[0].Rows[i]["CompanyId"].ToString() + "|" + ds.Tables[0].Rows[i]["InternshipId"].ToString();
                ddlCompanyInternship.Items.Add(new ListItem(text, value));
            }
        }
        protected void ddlFeedbackType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFeedbackType.SelectedValue == "Company")
            {
                pnlCompanySelect.Visible = true;
            }
            else
            {
                pnlCompanySelect.Visible = false;
            }
        }
        void fillGrid()
        {
            string studentEmail = Session["student"].ToString();
            getcon();
            da = new SqlDataAdapter("select pf.*, c.c_company, i.InternshipTitle from PlatformFeedback pf left join c_registration c on pf.CompanyId=c.CompanyId left join internship i on pf.InternshipId=i.Id where pf.SenderEmail='" + studentEmail + "' order by pf.FeedbackId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvFeedback.DataSource = ds;
                gvFeedback.DataBind();
                gvFeedback.Visible = true;
                pnlNoFeedback.Visible = false;
            }
            else
            {
                gvFeedback.Visible = false;
                pnlNoFeedback.Visible = true;
            }
        }
        void clearForm()
        {
            txtSubject.Text = "";
            txtComments.Text = "";
            ddlCategory.SelectedIndex = 0;
            ddlRating.SelectedValue = "5";
            if (ddlCompanyInternship.Items.Count > 0)
            {
                ddlCompanyInternship.SelectedIndex = 0;
            }
        }
        protected void btnSubmitFeedback_Click(object sender, EventArgs e)
        {
            string studentEmail = Session["student"].ToString();
            if (txtSubject.Text == "" || txtComments.Text == "")
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Please provide both a subject and detailed feedback comments.";
                return;
            }
            string feedbackType = ddlFeedbackType.SelectedValue;
            string companyId = "NULL";
            string internshipId = "NULL";
            if (feedbackType == "Company")
            {
                if (ddlCompanyInternship.SelectedValue == "")
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Please select the company and internship for your review.";
                    return;
                }
                string[] parts = ddlCompanyInternship.SelectedValue.Split('|');
                if (parts.Length == 2)
                {
                    companyId = parts[0];
                    internshipId = parts[1];
                }
            }
            getcon();
            da = new SqlDataAdapter("select FullName from Students where Email='" + studentEmail + "' or EnrollmentNo='" + studentEmail + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            string studentName = studentEmail;
            if (ds.Tables[0].Rows.Count > 0)
            {
                studentName = ds.Tables[0].Rows[0]["FullName"].ToString();
            }
            cmd = new SqlCommand("insert into PlatformFeedback (SenderType,SenderName,SenderEmail,FeedbackType,CompanyId,InternshipId,FeedbackCategory,Rating,Subject,Message,CreatedDate) values('Student','" + studentName + "','" + studentEmail + "','" + feedbackType + "'," + companyId + "," + internshipId + ",'" + ddlCategory.SelectedValue + "'," + ddlRating.SelectedValue + ",'" + txtSubject.Text + "','" + txtComments.Text + "',GETDATE())", con);
            cmd.ExecuteNonQuery();
            lblMsg.Visible = true;
            lblMsg.Text = "Thank you! Your feedback has been submitted successfully.";
            clearForm();
            fillGrid();
        }
        protected void gvFeedback_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_dlt")
            {
                string id = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("delete from PlatformFeedback where FeedbackId=" + id + " and SenderEmail='" + Session["student"] + "'", con);
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Feedback deleted successfully.";
                fillGrid();
            }
        }
        public string GetTargetDisplay(object typeObj, object compObj, object internObj)
        {
            string type = "";
            string company = "";
            string internship = "";
            if (typeObj != null)
            {
                type = typeObj.ToString();
            }
            if (compObj != null)
            {
                company = compObj.ToString();
            }
            if (internObj != null)
            {
                internship = internObj.ToString();
            }
            if (type == "Company" && company != "")
            {
                return "<i class='fa-solid fa-building'></i> " + company + " (" + internship + ")";
            }
            return "<i class='fa-solid fa-globe'></i> " + "General Platform Feedback (Admin)";
        }
        public string GetStars(object ratingObj)
        {
            int rating = 5;
            if (ratingObj != null && ratingObj != DBNull.Value)
            {
                rating = Convert.ToInt32(ratingObj);
            }
            string html = "";
            for (int i = 1; i <= 5; i++)
            {
                if (i <= rating)
                {
                    html += "<i class='fa-solid fa-star'></i>";
                }
                else
                {
                    html += "<i class='fa-regular fa-star'></i>";
                }
            }
            return html;
        }
        public string FormatDate(object dateObj)
        {
            if (dateObj != null && dateObj != DBNull.Value)
            {
                DateTime dt;
                if (DateTime.TryParse(dateObj.ToString(), out dt))
                {
                    return dt.ToString("dd MMM yyyy");
                }
                return dateObj.ToString();
            }
            return "N/A";
        }
        public string FormatTime(object dateObj)
        {
            if (dateObj != null && dateObj != DBNull.Value)
            {
                DateTime dt;
                if (DateTime.TryParse(dateObj.ToString(), out dt))
                {
                    return dt.ToString("hh:mm tt");
                }
            }
            return "";
        }
        public string CleanJsString(object obj)
        {
            if (obj == null || obj == DBNull.Value)
            {
                return "";
            }
            string value = obj.ToString();
            value = value.Replace("\\", "\\\\");
            value = value.Replace("'", "\\'");
            value = value.Replace("\"", "\\\"");
            value = value.Replace("\r\n", " ");
            value = value.Replace("\n", " ");
            value = value.Replace("\r", " ");
            return value;
        }
    }
}
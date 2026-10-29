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
            getcon();
            da = new SqlDataAdapter("select pf.*, i.InternshipTitle from PlatformFeedback pf left join internship i on pf.InternshipId = i.Id where pf.SenderType='Student' and pf.FeedbackType='Company' and pf.CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "') order by pf.FeedbackId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvStudentReviews.DataSource = ds;
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
            getcon();
            da = new SqlDataAdapter("select * from PlatformFeedback where SenderType='Company' and CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "') order by FeedbackId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                gvSentFeedbacks.DataSource = ds;
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
            getcon();
            da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            string compId = ds.Tables[0].Rows[0]["CompanyId"].ToString();
            string compName = ds.Tables[0].Rows[0]["c_company"].ToString();

            cmd = new SqlCommand("insert into PlatformFeedback (SenderType, SenderName, SenderEmail, FeedbackType, CompanyId, FeedbackCategory, Rating, Subject, Message, CreatedDate) values ('Company', '" + compName + "', '" + Session["company"] + "', 'General', " + compId + ", '" + ddlCategory.SelectedValue + "', " + ddlRating.SelectedValue + ", '" + txtSubject.Text + "', '" + txtMessage.Text + "', GETDATE())", con);
            cmd.ExecuteNonQuery();

            txtSubject.Text = "";
            txtMessage.Text = "";
            bindSentFeedbacks();
        }

        protected void gvStudentReviews_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "ViewReview")
            {
                getcon();
                da = new SqlDataAdapter("select pf.*, i.InternshipTitle from PlatformFeedback pf left join internship i on pf.InternshipId = i.Id where pf.FeedbackId=" + id, con);
                ds = new DataSet();
                da.Fill(ds);

                drHeaderTitle.Text = "Student Review Details";
                drSenderLabel.Text = "STUDENT";
                drSenderName.Text = ds.Tables[0].Rows[0]["SenderName"].ToString();
                drTargetLabel.Text = "INTERNSHIP";
                drTargetVal.Text = ds.Tables[0].Rows[0]["InternshipTitle"] != DBNull.Value ? ds.Tables[0].Rows[0]["InternshipTitle"].ToString() : "Internship Review";
                drCategory.Text = ds.Tables[0].Rows[0]["FeedbackCategory"].ToString();
                drRatingScore.Text = ds.Tables[0].Rows[0]["Rating"].ToString();
                drSubmittedDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CreatedDate"]).ToString("dd MMM yyyy");
                drSubmittedTime.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CreatedDate"]).ToString("hh:mm tt");
                drSubject.Text = ds.Tables[0].Rows[0]["Subject"].ToString();
                drMessage.Text = ds.Tables[0].Rows[0]["Message"].ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenDrawer", "openDrawer();", true);
            }
        }

        protected void gvSentFeedbacks_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            if (e.CommandName == "ViewSentFeedback")
            {
                getcon();
                da = new SqlDataAdapter("select * from PlatformFeedback where FeedbackId=" + id, con);
                ds = new DataSet();
                da.Fill(ds);

                drHeaderTitle.Text = "Feedback Sent to Admin";
                drSenderLabel.Text = "SENT TO";
                drSenderName.Text = "Platform Administrator";
                drTargetLabel.Text = "FEEDBACK TYPE";
                drTargetVal.Text = "Platform Suggestion";
                drCategory.Text = ds.Tables[0].Rows[0]["FeedbackCategory"].ToString();
                drRatingScore.Text = ds.Tables[0].Rows[0]["Rating"].ToString();
                drSubmittedDate.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CreatedDate"]).ToString("dd MMM yyyy");
                drSubmittedTime.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["CreatedDate"]).ToString("hh:mm tt");
                drSubject.Text = ds.Tables[0].Rows[0]["Subject"].ToString();
                drMessage.Text = ds.Tables[0].Rows[0]["Message"].ToString();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "OpenDrawer", "openDrawer();", true);
            }
            if (e.CommandName == "cmd_delete")
            {
                getcon();
                cmd = new SqlCommand("delete from PlatformFeedback where FeedbackId=" + id + " and SenderType='Company'", con);
                cmd.ExecuteNonQuery();
                bindSentFeedbacks();
            }
        }
    }
}

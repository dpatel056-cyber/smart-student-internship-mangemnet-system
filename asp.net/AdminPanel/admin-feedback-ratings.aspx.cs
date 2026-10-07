using System;
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
                    loadStats();
                    bindFeedback();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void loadStats()
        {
            getcon();
            da = new SqlDataAdapter("SELECT COUNT(*) FROM PlatformFeedback", con);
            ds = new DataSet();
            da.Fill(ds);
            lblTotalFeedback.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM PlatformFeedback WHERE SenderType='Student'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblStudentFeedback.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT COUNT(*) FROM PlatformFeedback WHERE SenderType='Company'", con);
            ds = new DataSet();
            da.Fill(ds);
            lblCompanyFeedback.Text = ds.Tables[0].Rows[0][0].ToString();

            da = new SqlDataAdapter("SELECT AVG(CAST(Rating AS FLOAT)) FROM PlatformFeedback", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0][0] != DBNull.Value)
            {
                lblAvgRating.Text = Convert.ToDouble(ds.Tables[0].Rows[0][0]).ToString("0.0") + " / 5";
            }
            else
            {
                lblAvgRating.Text = "5.0 / 5";
            }
        }

        void bindFeedback()
        {
            getcon();
            da = new SqlDataAdapter("SELECT pf.*, c.c_company, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN c_registration c ON pf.CompanyId = c.CompanyId LEFT JOIN internship i ON pf.InternshipId = i.Id ORDER BY pf.FeedbackId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            gvFeedback.DataSource = ds;
            gvFeedback.DataBind();
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
                drSubmittedDate.Text =Convert.ToDateTime(ds.Tables[0].Rows[0]["CreatedDate"]).ToString("dd MMM yyyy");
                drSubmittedTime.Text =Convert.ToDateTime(ds.Tables[0].Rows[0]["CreatedDate"]).ToString("hh:mm tt");
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
                loadStats();
                bindFeedback();
            }
        }
    }
}

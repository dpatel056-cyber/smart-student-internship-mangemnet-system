using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace asp.net
{
    public partial class company_interviews : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        CompanyClass comp = new CompanyClass();
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
                    fillcombo();
                    bindInterviews();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }
        void fillcombo()
        {
            comp = new CompanyClass();
            ds = comp.fill_combo(Session["company"].ToString());
            ddlCandidate.DataSource = ds;
            ddlCandidate.DataTextField = "FullName";
            ddlCandidate.DataValueField = "ApplicationId";
            ddlCandidate.DataBind();
            ddlCandidate.Items.Insert(0, new ListItem("-- Select Shortlisted Candidate --", ""));
        }

        void bindInterviews()
        {
            getcon();
            da = new SqlDataAdapter("SELECT civ.InterviewId, civ.ApplicationId, civ.InternshipId, civ.StudentId, civ.CompanyId, ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 120), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 23), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate), civ.CreatedDate))) AS InterviewDate, civ.InterviewTime, civ.InterviewType, civ.MeetingLink, civ.Location, civ.Notes, civ.Status, civ.CreatedDate, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(i.InternshipTitle, 'Interview Assessment') AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyInterviews civ LEFT JOIN StudentApplications a ON civ.ApplicationId = a.ApplicationId LEFT JOIN Students s ON civ.StudentId = s.StudentId LEFT JOIN internship i ON civ.InternshipId = i.Id WHERE civ.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + @"') ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                dlInterviews.DataSource = ds.Tables[0];
                dlInterviews.DataBind();
                dlInterviews.Visible = true;
                pnlNoInterviews.Visible = false;
            }
            else
            {
                dlInterviews.Visible = false;
                pnlNoInterviews.Visible = true;
            }
        }
        protected void btnSchedule_Click(object sender, EventArgs e)
        {
            if (ddlCandidate.SelectedValue == "" || txtDate.Text == "")
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Please select a candidate and interview date.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            comp = new CompanyClass();
            comp.insert_interview(Convert.ToInt32(ddlCandidate.SelectedValue), Session["company"].ToString(), txtDate.Text, txtTime.Text, ddlType.SelectedValue, txtLinkLocation.Text, txtNotes.Text);

            lblMsg.Visible = true;
            lblMsg.Text = "Interview scheduled successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;
            txtDate.Text = "";
            txtTime.Text = "";
            txtLinkLocation.Text = "";
            txtNotes.Text = "";
            ddlCandidate.SelectedIndex = 0;
            bindInterviews();
        }
        protected void dlInterviews_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Complete" || e.CommandName == "MarkComplete")
            {
                getcon();
                cmd = new SqlCommand("UPDATE CompanyInterviews SET Status='Completed' WHERE InterviewId=" + e.CommandArgument.ToString(), con);
                cmd.ExecuteNonQuery();
                lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-check'></i> Interview marked as Completed.</div>";
                lblMsg.Visible = true;
                bindInterviews();
            }
            else if (e.CommandName == "CancelInterview")
            {
                getcon();
                cmd = new SqlCommand("UPDATE CompanyInterviews SET Status='Cancelled' WHERE InterviewId=" + e.CommandArgument.ToString(), con);
                cmd.ExecuteNonQuery();
                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-xmark'></i> Interview cancelled.</div>";
                lblMsg.Visible = true;
                bindInterviews();
            }
        }
        public string GetStatusBadge(object statusObj)
        {
            string st = Convert.ToString(statusObj);

            if (st == "Completed")
                return "<span class='interview-status-badge status-completed'>Completed</span>";

            if (st == "Cancelled")
                return "<span class='interview-status-badge status-cancelled'>Cancelled</span>";

            return "<span class='interview-status-badge status-scheduled'>" + (st == "" ? "Scheduled" : st) + "</span>";
        }
    }
}

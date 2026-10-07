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
                    bindCandidateDropdown();
                    bindInterviews();
                    if (Request.QueryString["appId"] != null)
                    {
                        string preAppId = Request.QueryString["appId"].ToString();
                        if (ddlCandidate.Items.FindByValue(preAppId) != null)
                        {
                            ddlCandidate.SelectedValue = preAppId;
                        }
                        ClientScript.RegisterStartupScript(this.GetType(), "OpenDrawerAuto", "setTimeout(function(){ openDrawer(); }, 150);", true);
                    }
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }
        void bindCandidateDropdown()
        {
            getcon();
            ddlCandidate.Items.Clear();
            ddlCandidate.Items.Add(new ListItem("-- Select Registered Candidate / Intern --", ""));
            string compEmail = Session["company"].ToString();
            string query = @"SELECT a.ApplicationId, a.FullName, a.StudentEmail, a.Status, i.InternshipTitle FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + @"') ORDER BY a.ApplicationId DESC";
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    string statusStr = row["Status"] != DBNull.Value ? row["Status"].ToString() : "Applied";
                    ddlCandidate.Items.Add(new ListItem(row["FullName"].ToString() + " (" + row["InternshipTitle"].ToString() + " • " + statusStr + ")", row["ApplicationId"].ToString()));
                }
            }
            // Also registered students
            da = new SqlDataAdapter("SELECT StudentId, FullName, Email, EnrollmentNo, College FROM Students ORDER BY FullName ASC", con);
            DataSet dsSt = new DataSet();
            da.Fill(dsSt);
            if (dsSt.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in dsSt.Tables[0].Rows)
                {
                    string email = row["Email"].ToString();
                    bool alreadyAdded = false;
                    foreach (ListItem li in ddlCandidate.Items)
                    {
                        if (li.Text.Contains(email))
                        {
                            alreadyAdded = true;
                            break;
                        }
                    }
                    if (!alreadyAdded)
                    {
                        string itemText = "👤 " + row["FullName"].ToString() + " (" + email + " • " + row["College"].ToString() + ")";
                        string itemVal = "ST_" + row["StudentId"].ToString();
                        ddlCandidate.Items.Add(new ListItem(itemText, itemVal));
                    }
                }
            }
        }
        void bindInterviews()
        {
            getcon();
            string query = @"SELECT civ.*, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(i.InternshipTitle, 'Interview Assessment') AS InternshipTitle FROM CompanyInterviews civ LEFT JOIN StudentApplications a ON civ.ApplicationId = a.ApplicationId LEFT JOIN Students s ON civ.StudentId = s.StudentId LEFT JOIN internship i ON civ.InternshipId = i.Id WHERE civ.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + @"') ORDER BY civ.InterviewId DESC";
            da = new SqlDataAdapter(query, con);
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
            if (string.IsNullOrEmpty(ddlCandidate.SelectedValue) || string.IsNullOrEmpty(txtDate.Text.Trim()))
            {
                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-exclamation'></i> Please select a candidate and interview date.</div>";
                lblMsg.Visible = true;
                ClientScript.RegisterStartupScript(this.GetType(), "ReopenDrawer", "setTimeout(function(){ openDrawer(); }, 150);", true);
                return;
            }
            string rawVal = ddlCandidate.SelectedValue;
            string date = txtDate.Text.Trim();
            string time = txtTime.Text.Trim();
            string type = ddlType.SelectedValue;
            string linkLoc = txtLinkLocation.Text.Trim();
            string notes = txtNotes.Text.Trim();
            getcon();
            int finalAppId = 0;
            int studentId = 0;
            int internshipId = 0;
            if (rawVal.StartsWith("ST_"))
            {
                studentId = Convert.ToInt32(rawVal.Replace("ST_", ""));
                da = new SqlDataAdapter("SELECT TOP 1 ApplicationId, InternshipId FROM StudentApplications WHERE StudentId=" + studentId + " AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'))", con);
                DataSet dsEx = new DataSet();
                da.Fill(dsEx);
                if (dsEx.Tables[0].Rows.Count > 0)
                {
                    finalAppId = Convert.ToInt32(dsEx.Tables[0].Rows[0]["ApplicationId"]);
                    internshipId = Convert.ToInt32(dsEx.Tables[0].Rows[0]["InternshipId"]);
                }
                else
                {
                    string insAppSql = "INSERT INTO StudentApplications (InternshipId, StudentId, FullName, StudentEmail, College, ContactNo, Status, AppliedDate) " + "VALUES ((SELECT TOP 1 Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')), " + studentId + ", (SELECT FullName FROM Students WHERE StudentId=" + studentId + "), (SELECT Email FROM Students WHERE StudentId=" + studentId + "), " + "(SELECT College FROM Students WHERE StudentId=" + studentId + "), (SELECT ContactNo FROM Students WHERE StudentId=" + studentId + "), 'Shortlisted', GETDATE()); " + "SELECT SCOPE_IDENTITY();";
                    SqlCommand cmdApp = new SqlCommand(insAppSql, con);
                    object newId = cmdApp.ExecuteScalar();
                    finalAppId = Convert.ToInt32(newId);
                    da = new SqlDataAdapter("SELECT TOP 1 Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')", con);
                    DataSet dsI = new DataSet();
                    da.Fill(dsI);
                    if (dsI.Tables[0].Rows.Count > 0)
                        internshipId = Convert.ToInt32(dsI.Tables[0].Rows[0]["Id"]);
                }
            }
            else
            {
                finalAppId = Convert.ToInt32(rawVal);
                da = new SqlDataAdapter("SELECT ApplicationId, StudentId, InternshipId FROM StudentApplications WHERE ApplicationId=" + finalAppId, con);
                DataSet dsA = new DataSet();
                da.Fill(dsA);
                if (dsA.Tables[0].Rows.Count > 0)
                {
                    internshipId = Convert.ToInt32(dsA.Tables[0].Rows[0]["InternshipId"]);
                    if (dsA.Tables[0].Rows[0]["StudentId"] != DBNull.Value)
                        int.TryParse(dsA.Tables[0].Rows[0]["StudentId"].ToString(), out studentId);
                }
            }
            string insIntSql = "INSERT INTO CompanyInterviews (ApplicationId, InternshipId, StudentId, CompanyId, InterviewDate, InterviewTime, InterviewType, MeetingLink, Location, Notes, Status, CreatedDate) VALUES (" + finalAppId + ", " + internshipId + ", " + studentId + ", (SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'), '" + date.Replace("'", "''") + "', '" + time.Replace("'", "''") + "', '" + type.Replace("'", "''") + "', '" + linkLoc.Replace("'", "''") + "', '" + linkLoc.Replace("'", "''") + "', '" + notes.Replace("'", "''") + "', 'Scheduled', GETDATE())";
            cmd = new SqlCommand(insIntSql, con);
            cmd.ExecuteNonQuery();
            // Log Activity
            cmd = new SqlCommand("INSERT INTO CompanyActivityHistory (CompanyId, ActivityType, Description, IPAddress, ActivityDate) VALUES ((SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'), 'Interview Scheduled', 'Scheduled " + type.Replace("'", "''") + " interview for candidate', '" + Request.UserHostAddress + "', GETDATE())", con);
            cmd.ExecuteNonQuery();
            lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-check'></i> Interview scheduled successfully!</div>";
            lblMsg.Visible = true;
            txtDate.Text = "";
            txtTime.Text = "";
            txtLinkLocation.Text = "";
            txtNotes.Text = "";
            ddlCandidate.SelectedIndex = -1;
            bindInterviews();
        }
        protected void dlInterviews_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandArgument == null) return;
            string interviewId = e.CommandArgument.ToString();
            if (e.CommandName == "Complete" || e.CommandName == "MarkComplete")
            {
                getcon();
                cmd = new SqlCommand("UPDATE CompanyInterviews SET Status='Completed' WHERE InterviewId=" + interviewId, con);
                cmd.ExecuteNonQuery();
                lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-check'></i> Interview marked as Completed.</div>";
                lblMsg.Visible = true;
                bindInterviews();
            }
            else if (e.CommandName == "CancelInterview")
            {
                getcon();
                cmd = new SqlCommand("UPDATE CompanyInterviews SET Status='Cancelled' WHERE InterviewId=" + interviewId, con);
                cmd.ExecuteNonQuery();
                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-xmark'></i> Interview cancelled.</div>";
                lblMsg.Visible = true;
                bindInterviews();
            }
        }
        public string FormatDay(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return DateTime.Now.ToString("dd");
            DateTime dt;
            if (DateTime.TryParse(dateObj.ToString(), out dt))
            {
                return dt.ToString("dd");
            }
            return dateObj.ToString();
        }
        public string FormatMonth(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return DateTime.Now.ToString("MMM");
            DateTime dt;
            if (DateTime.TryParse(dateObj.ToString(), out dt))
            {
                return dt.ToString("MMM").ToUpper();
            }
            return "DATE";
        }
        public string GetStatusBadge(object statusObj)
        {
            string st = statusObj != null ? statusObj.ToString() : "Scheduled";
            if (st.Equals("Completed", StringComparison.OrdinalIgnoreCase))
            {
                return "<span class='interview-status-badge status-completed'><i class='fa-solid fa-circle-check'></i> Completed</span>";
            }
            if (st.Equals("Cancelled", StringComparison.OrdinalIgnoreCase))
            {
                return "<span class='interview-status-badge status-cancelled'><i class='fa-solid fa-circle-xmark'></i> Cancelled</span>";
            }
            return "<span class='interview-status-badge status-scheduled'><i class='fa-solid fa-calendar-check'></i> Scheduled</span>";
        }
        public string GetInitials(object nameObj)
        {
            if (nameObj == null || nameObj == DBNull.Value) return "ST";
            string name = nameObj.ToString().Trim();
            if (string.IsNullOrEmpty(name)) return "ST";
            string[] parts = name.Split(' ');
            if (parts.Length > 1 && parts[1].Length > 0)
                return (parts[0][0].ToString() + parts[1][0].ToString()).ToUpper();
            return name.Length > 1 ? name.Substring(0, 2).ToUpper() : name.ToUpper();
        }
        public string FormatMeetingLink(object linkObj, object locObj)
        {
            string link = linkObj != null ? linkObj.ToString().Trim() : "";
            string loc = locObj != null ? locObj.ToString().Trim() : "";
            string val = !string.IsNullOrEmpty(link) ? link : loc;
            if (string.IsNullOrEmpty(val)) return "Online / TBA";
            if (val.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || val.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
            {
                return "<a href='" + val + "' target='_blank' style='color:#2563eb; font-weight:600; text-decoration:none;'><i class='fa-solid fa-arrow-up-right-from-square'></i> Join Meeting</a>";
            }
            return val;
        }
    }
}
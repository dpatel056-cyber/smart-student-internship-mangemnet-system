using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_tasks : System.Web.UI.Page
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
                    bindCandidateDropdowns();
                    bindQuizDropdown();
                    bindQuizAssignments();
                    loadStats();

                    if (Request.QueryString["appId"] != null)
                    {
                        string preAppId = Request.QueryString["appId"].ToString();
                        if (ddlQuizCandidate.Items.FindByValue(preAppId) != null)
                        {
                            ddlQuizCandidate.SelectedValue = preAppId;
                        }
                        ClientScript.RegisterStartupScript(this.GetType(), "OpenDrawer", "setTimeout(openDrawer, 300);", true);
                    }
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void bindCandidateDropdowns()
        {
            getcon();
            ddlQuizCandidate.Items.Clear();
            ddlQuizCandidate.Items.Add(new ListItem("-- Select Selected Intern for Quiz Challenge --", ""));

            string compEmail = Session["company"].ToString();
            string queryApp = @"SELECT DISTINCT a.ApplicationId, a.FullName, a.StudentEmail, a.Status, i.InternshipTitle
                                FROM StudentApplications a
                                INNER JOIN internship i ON a.InternshipId = i.Id
                                WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + @"')
                                AND (
                                    a.Status IN ('Selected', 'Shortlisted', 'Completed', 'Offer Accepted', 'Accepted')
                                    OR a.ApplicationId IN (SELECT ApplicationId FROM CompanyOfferLetters WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + @"') AND Status='Accepted')
                                )
                                ORDER BY a.ApplicationId DESC";

            da = new SqlDataAdapter(queryApp, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    string statusStr = row["Status"] != DBNull.Value ? row["Status"].ToString() : "Selected";
                    string itemText = row["FullName"].ToString() + " (" + row["InternshipTitle"].ToString() + " • " + statusStr + ")";
                    string itemVal = row["ApplicationId"].ToString();
                    ddlQuizCandidate.Items.Add(new ListItem(itemText, itemVal));
                }
            }

        }

        void bindQuizDropdown()
        {
            getcon();
            da = new SqlDataAdapter("SELECT QuizId, QuizTitle, Topic, DurationMinutes, TotalQuestions FROM CompanyQuizzes WHERE IsActive=1 ORDER BY QuizId ASC", con);
            DataSet dsQ = new DataSet();
            da.Fill(dsQ);

            ddlQuizSelect.Items.Clear();
            ddlQuizSelect.Items.Add(new ListItem("-- Select Quiz Challenge --", ""));
            if (dsQ.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in dsQ.Tables[0].Rows)
                {
                    string text = row["QuizTitle"].ToString() + " (" + row["Topic"].ToString() + " • " + row["TotalQuestions"].ToString() + " Qs • " + row["DurationMinutes"].ToString() + " mins)";
                    ddlQuizSelect.Items.Add(new ListItem(text, row["QuizId"].ToString()));
                }
            }
        }

        void loadStats()
        {
            getcon();
            string compEmail = Session["company"].ToString();
            string compIdQuery = "(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "')";

            // 1. Total Assigned Quiz Challenges
            int quizCount = 0;
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentQuizAssignments WHERE CompanyId=" + compIdQuery, con);
            DataSet ds1 = new DataSet();
            da.Fill(ds1);
            if (ds1.Tables[0].Rows.Count > 0 && ds1.Tables[0].Rows[0][0] != DBNull.Value)
                int.TryParse(ds1.Tables[0].Rows[0][0].ToString(), out quizCount);
            lblActiveQuizzes.Text = quizCount.ToString();

            // 2. Passed & Completed Quizzes
            int passedQuizCount = 0;
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentQuizAssignments WHERE CompanyId=" + compIdQuery + " AND Status='Passed'", con);
            DataSet ds3 = new DataSet();
            da.Fill(ds3);
            if (ds3.Tables[0].Rows.Count > 0 && ds3.Tables[0].Rows[0][0] != DBNull.Value)
                int.TryParse(ds3.Tables[0].Rows[0][0].ToString(), out passedQuizCount);
            lblPassedQuizzes.Text = passedQuizCount.ToString();

            // 3. Pending / In Progress Quizzes
            int pendingQuizzes = 0;
            da = new SqlDataAdapter("SELECT COUNT(*) FROM StudentQuizAssignments WHERE CompanyId=" + compIdQuery + " AND (Status IN ('Assigned', 'Pending', 'In Progress') OR Status IS NULL OR Status='')", con);
            DataSet ds5 = new DataSet();
            da.Fill(ds5);
            if (ds5.Tables[0].Rows.Count > 0 && ds5.Tables[0].Rows[0][0] != DBNull.Value)
                int.TryParse(ds5.Tables[0].Rows[0][0].ToString(), out pendingQuizzes);
            lblTotalTasks.Text = pendingQuizzes.ToString();

            // 4. Eligible / Certified Interns (Distinct candidates who passed quiz)
            int eligibleCount = 0;
            string eligQuery = @"SELECT COUNT(DISTINCT ISNULL(sqa.ApplicationId, sqa.StudentId))
                                 FROM StudentQuizAssignments sqa
                                 WHERE sqa.CompanyId=" + compIdQuery + @" AND sqa.Status='Passed'";
            da = new SqlDataAdapter(eligQuery, con);
            DataSet ds7 = new DataSet();
            da.Fill(ds7);
            if (ds7.Tables[0].Rows.Count > 0 && ds7.Tables[0].Rows[0][0] != DBNull.Value)
                int.TryParse(ds7.Tables[0].Rows[0][0].ToString(), out eligibleCount);
            lblCompletedTasks.Text = eligibleCount.ToString();

        }

        void bindQuizAssignments()
        {
            getcon();
            string query = @"SELECT sqa.*, q.QuizTitle, q.Topic, q.DurationMinutes, q.PassingScore,
                             ISNULL(a.FullName, s.FullName) AS FullName,
                             ISNULL(a.StudentEmail, s.Email) AS StudentEmail,
                             ISNULL(a.College, s.College) AS College,
                             ISNULL(i.InternshipTitle, 'Skill Assessment') AS InternshipTitle,
                             s.ProfilePhoto
                             FROM StudentQuizAssignments sqa
                             INNER JOIN CompanyQuizzes q ON sqa.QuizId = q.QuizId
                             LEFT JOIN StudentApplications a ON sqa.ApplicationId = a.ApplicationId
                             LEFT JOIN Students s ON (sqa.StudentId = s.StudentId OR a.StudentId = s.StudentId OR a.StudentEmail = s.Email)
                             LEFT JOIN internship i ON a.InternshipId = i.Id
                             WHERE sqa.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + @"')
                             ORDER BY sqa.AssignmentId DESC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvQuizAssignments.DataSource = ds.Tables[0];
                gvQuizAssignments.DataBind();
                gvQuizAssignments.Visible = true;
                pnlNoQuizAssignments.Visible = false;
            }
            else
            {
                gvQuizAssignments.Visible = false;
                pnlNoQuizAssignments.Visible = true;
            }
        }

        protected void btnAssignQuiz_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlQuizCandidate.SelectedValue) || string.IsNullOrEmpty(ddlQuizSelect.SelectedValue))
            {
                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-exclamation'></i> Please select both an intern and a quiz challenge.</div>";
                lblMsg.Visible = true;
                ClientScript.RegisterStartupScript(this.GetType(), "KeepDrawerOpen", "setTimeout(openDrawer, 100);", true);
                return;
            }

            string rawVal = ddlQuizCandidate.SelectedValue;
            string quizId = ddlQuizSelect.SelectedValue;

            getcon();
            int finalAppId = 0;
            int studentId = 0;

            if (rawVal.StartsWith("ST_"))
            {
                studentId = Convert.ToInt32(rawVal.Replace("ST_", ""));
                // Check if application exists or create one
                da = new SqlDataAdapter("SELECT TOP 1 ApplicationId FROM StudentApplications WHERE StudentId=" + studentId + " AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'))", con);
                DataSet dsEx = new DataSet();
                da.Fill(dsEx);
                if (dsEx.Tables[0].Rows.Count > 0)
                {
                    finalAppId = Convert.ToInt32(dsEx.Tables[0].Rows[0]["ApplicationId"]);
                }
                else
                {
                    string insAppSql = "INSERT INTO StudentApplications (InternshipId, StudentId, FullName, StudentEmail, College, ContactNo, Status, AppliedDate) " +
                        "VALUES ((SELECT TOP 1 Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')), " +
                        studentId + ", (SELECT FullName FROM Students WHERE StudentId=" + studentId + "), (SELECT Email FROM Students WHERE StudentId=" + studentId + "), " +
                        "(SELECT College FROM Students WHERE StudentId=" + studentId + "), (SELECT ContactNo FROM Students WHERE StudentId=" + studentId + "), 'Selected', GETDATE()); " +
                        "SELECT SCOPE_IDENTITY();";
                    SqlCommand cmdApp = new SqlCommand(insAppSql, con);
                    object newId = cmdApp.ExecuteScalar();
                    finalAppId = Convert.ToInt32(newId);
                }
            }
            else
            {
                finalAppId = Convert.ToInt32(rawVal);
                da = new SqlDataAdapter("SELECT StudentId FROM StudentApplications WHERE ApplicationId=" + finalAppId, con);
                DataSet dsA = new DataSet();
                da.Fill(dsA);
                if (dsA.Tables[0].Rows.Count > 0 && dsA.Tables[0].Rows[0]["StudentId"] != DBNull.Value)
                {
                    int.TryParse(dsA.Tables[0].Rows[0]["StudentId"].ToString(), out studentId);
                }
            }

            string insAssignSql = "INSERT INTO StudentQuizAssignments " +
                "(QuizId, CompanyId, ApplicationId, StudentId, AssignedDate, Status, Score, CorrectCount, TotalQuestions, CertificateIssued) " +
                "VALUES (" + quizId + ", (SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'), " + finalAppId + ", " + studentId + ", GETDATE(), 'Assigned', 0, 0, " +
                "(SELECT TotalQuestions FROM CompanyQuizzes WHERE QuizId=" + quizId + "), 0)";

            SqlCommand insCmd = new SqlCommand(insAssignSql, con);
            insCmd.ExecuteNonQuery();

            // Log Activity
            SqlCommand actCmd = new SqlCommand("INSERT INTO CompanyActivityHistory (CompanyId, ActivityType, Description, IPAddress, ActivityDate) VALUES ((SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'), 'Quiz Assigned', 'Assigned Quiz Challenge to intern (App ID: " + finalAppId + ")', '" + Request.UserHostAddress + "', GETDATE())", con);
            actCmd.ExecuteNonQuery();

            lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-check'></i> Quiz Challenge assigned successfully! The intern can now play the quiz in their dashboard.</div>";
            lblMsg.Visible = true;

            ddlQuizCandidate.SelectedIndex = -1;
            ddlQuizSelect.SelectedIndex = -1;

            bindQuizAssignments();
            loadStats();
        }

        protected void gvQuizAssignments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandArgument == null) return;
            string id = e.CommandArgument.ToString();

            if (e.CommandName == "DeleteAssignment")
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM StudentQuizAssignments WHERE AssignmentId=" + id, con);
                cmd.ExecuteNonQuery();

                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-trash'></i> Quiz assignment deleted.</div>";
                lblMsg.Visible = true;

                bindQuizAssignments();
                loadStats();
            }
        }

        public string GetQuizStatusBadge(object statusObj, object scoreObj)
        {
            string st = statusObj != null ? statusObj.ToString() : "Assigned";
            int score = 0;
            if (scoreObj != null && scoreObj != DBNull.Value)
            {
                int.TryParse(scoreObj.ToString(), out score);
            }

            if (st.Equals("Passed", StringComparison.OrdinalIgnoreCase))
            {
                return "<span style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:4px 10px; border-radius:20px; font-size:12px; font-weight:700; display:inline-flex; align-items:center; gap:5px;'><i class='fa-solid fa-trophy'></i> Passed (" + score + "%)</span>";
            }
            if (st.Equals("Failed", StringComparison.OrdinalIgnoreCase))
            {
                return "<span style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:4px 10px; border-radius:20px; font-size:12px; font-weight:700; display:inline-flex; align-items:center; gap:5px;'><i class='fa-solid fa-circle-xmark'></i> Failed (" + score + "%)</span>";
            }
            return "<span style='background:#eff6ff; color:#2563eb; border:1px solid #bfdbfe; padding:4px 10px; border-radius:20px; font-size:12px; font-weight:600; display:inline-flex; align-items:center; gap:5px;'><i class='fa-solid fa-clock'></i> Pending Quiz Play</span>";
        }

        public string GetCertificateActionBtn(object statusObj, object appIdObj, object certIssuedObj)
        {
            string st = statusObj != null ? statusObj.ToString() : "";
            string appId = appIdObj != null ? appIdObj.ToString() : "";
            bool certIssued = false;
            if (certIssuedObj != null && certIssuedObj != DBNull.Value)
            {
                bool.TryParse(certIssuedObj.ToString(), out certIssued);
            }

            if (st.Equals("Passed", StringComparison.OrdinalIgnoreCase))
            {
                if (certIssued)
                {
                    return "<a href='company-certificates.aspx?appId=" + appId + "' class='btn-table-action btn-action-cert-done'><i class='fa-solid fa-certificate'></i> Certificate Issued</a>";
                }
                else
                {
                    return "<a href='company-certificates.aspx?appId=" + appId + "' class='btn-table-action btn-action-cert'><i class='fa-solid fa-award'></i> Issue Certificate</a>";
                }
            }
            return "";
        }

        public string FormatDate(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return "N/A";
            DateTime dt;
            if (DateTime.TryParse(dateObj.ToString(), out dt))
            {
                return dt.ToString("dd MMM yyyy, hh:mm tt");
            }
            return dateObj.ToString();
        }

        public string GetProfileAvatarHtml(object photoObj, object nameObj)
        {
            string photo = photoObj != null ? photoObj.ToString().Trim() : "";
            string name = nameObj != null ? nameObj.ToString().Trim() : "Student";
            string initials = GetInitials(name);

            if (!string.IsNullOrEmpty(photo))
            {
                string resolvedPhoto = photo;
                if (!resolvedPhoto.StartsWith("http://") && !resolvedPhoto.StartsWith("https://") && !resolvedPhoto.StartsWith("/") && !resolvedPhoto.StartsWith("~"))
                {
                    resolvedPhoto = ResolveUrl("~/StudentUploads/" + photo);
                }
                else if (resolvedPhoto.StartsWith("~"))
                {
                    resolvedPhoto = ResolveUrl(resolvedPhoto);
                }

                return "<div style=\"width:40px; height:40px; border-radius:10px; overflow:hidden; flex-shrink:0; display:flex; align-items:center; justify-content:center;\">"
                     + "<img src=\"" + resolvedPhoto + "\" alt=\"" + Server.HtmlEncode(name) + "\" style=\"width:40px; height:40px; border-radius:10px; object-fit:cover; border:1.5px solid #e2e8f0; display:block;\" onerror=\"this.style.display='none'; this.nextElementSibling.style.display='flex';\" />"
                     + "<div style=\"display:none; width:40px; height:40px; border-radius:10px; background:#f3e8ff; color:#7c3aed; align-items:center; justify-content:center; font-weight:700; font-size:13px; border:1.5px solid #e9d5ff;\">" + initials + "</div>"
                     + "</div>";
            }

            return "<div style=\"width:40px; height:40px; border-radius:10px; background:#f3e8ff; color:#7c3aed; display:flex; align-items:center; justify-content:center; font-weight:700; font-size:13px; border:1.5px solid #e9d5ff; flex-shrink:0;\">" + initials + "</div>";
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
    }
}

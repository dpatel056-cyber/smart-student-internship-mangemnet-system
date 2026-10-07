using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace asp.net
{
    public partial class company_certificates : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;
        public string CompName = "Company Name";
        public string CompEmail = "hr@company.com";
        public string CompPhone = "+91 98765 43210";
        public string CompLocation = "Ahmedabad, Gujarat";
        public string CompWebsite = "www.company.com";
        public string CompLogo = "";
        public string CompHr = "Talent Acquisition Team";
        public string SelectedCandName = "[Candidate Full Name]";
        public string SelectedCandCollege = "College / University Name";
        public string SelectedCertTitle = "Certificate of Internship Excellence";
        public string SelectedRole = "[Internship Role]";
        public string SelectedDuration = "3 Months";
        public string SelectedPerformance = "Outstanding Performance & Dedication";
        public string SelectedSignatory = "Talent Acquisition Team";
        public string FormattedIssueDate = "";
        public string PreviewCertNo = "CERT-2026-0001";
        public string PreviewVerifyCode = "8F9B2C1A";
        int totalCerts = 0;
        int eligibleInterns = 0;
        int certifiedInterns = 0;
        int pendingCertificates = 0;
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
                LoadCompanyInfo();
                FormattedIssueDate = DateTime.Now.ToString("dd MMMM yyyy");
                SelectedSignatory = CompHr;
                if (!IsPostBack)
                {
                    txtIssueDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txtCertTitle.Text = "Certificate of Internship Excellence";
                    txtPerformance.Text = "Outstanding Performance & Dedication";
                    txtSignatoryName.Text = CompHr;
                    bindCandidateDropdown();
                    bindCertificates();
                    if (Request.QueryString["appId"] != null)
                    {
                        string preAppId = Request.QueryString["appId"].ToString();
                        if (ddlCandidate.Items.FindByValue(preAppId) != null)
                        {
                            ddlCandidate.SelectedValue = preAppId;
                            AutoFillCandidateDetails(preAppId);
                        }
                        ScriptManager.RegisterStartupScript(this, GetType(), "openNewCertDrawer", "openDrawer();", true);
                    }
                }
                else
                {
                    UpdatePreviewStateFromControls();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }
        void UpdatePreviewStateFromControls()
        {
            if (!string.IsNullOrEmpty(txtCandidateName.Text.Trim()))
                SelectedCandName = txtCandidateName.Text.Trim();
            if (!string.IsNullOrEmpty(txtCandidateCollege.Text.Trim()))
                SelectedCandCollege = txtCandidateCollege.Text.Trim();
            if (!string.IsNullOrEmpty(txtCertTitle.Text.Trim()))
                SelectedCertTitle = txtCertTitle.Text.Trim();
            if (!string.IsNullOrEmpty(txtInternshipRole.Text.Trim()))
                SelectedRole = txtInternshipRole.Text.Trim();
            if (!string.IsNullOrEmpty(txtDuration.Text.Trim()))
                SelectedDuration = txtDuration.Text.Trim();
            if (!string.IsNullOrEmpty(txtPerformance.Text.Trim()))
                SelectedPerformance = txtPerformance.Text.Trim();
            if (!string.IsNullOrEmpty(txtSignatoryName.Text.Trim()))
                SelectedSignatory = txtSignatoryName.Text.Trim();
            if (!string.IsNullOrEmpty(txtIssueDate.Text.Trim()))
            {
                DateTime dt;
                FormattedIssueDate = DateTime.TryParse(txtIssueDate.Text.Trim(), out dt) ? dt.ToString("dd MMMM yyyy") : txtIssueDate.Text.Trim();
            }
        }
        void LoadCompanyInfo()
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'", con);
            DataSet dsC = new DataSet();
            da.Fill(dsC);
            if (dsC.Tables.Count > 0 && dsC.Tables[0].Rows.Count > 0)
            {
                DataRow r = dsC.Tables[0].Rows[0];
                CompName = r["c_company"] != DBNull.Value ? r["c_company"].ToString() : "Company";
                CompEmail = r["c_email"] != DBNull.Value ? r["c_email"].ToString() : "";
                CompPhone = r["c_contact"] != DBNull.Value ? r["c_contact"].ToString() : "";
                string city = r["c_city"] != DBNull.Value ? r["c_city"].ToString() : "";
                string state = r["c_state"] != DBNull.Value ? r["c_state"].ToString() : "";
                CompLocation = !string.IsNullOrEmpty(city) ? (city + (!string.IsNullOrEmpty(state) ? ", " + state : "")) : "India";
                CompWebsite = r["c_website"] != DBNull.Value ? r["c_website"].ToString() : "";
                CompHr = r["c_hr_name"] != DBNull.Value && !string.IsNullOrEmpty(r["c_hr_name"].ToString()) ? r["c_hr_name"].ToString() : "Talent Acquisition Team";
                string logo = r["c_logo"] != DBNull.Value ? r["c_logo"].ToString().Trim() : "";
                if (!string.IsNullOrEmpty(logo))
                {
                    if (logo.StartsWith("http://") || logo.StartsWith("https://"))
                    {
                        CompLogo = logo;
                    }
                    else
                    {
                        if (!logo.StartsWith("~") && !logo.StartsWith("/"))
                        {
                            logo = "~/CompanyUploads/" + logo;
                        }
                        CompLogo = ResolveUrl(logo);
                    }
                }
            }
        }
        void bindCandidateDropdown()
        {
            getcon();
            ddlCandidate.Items.Clear();
            ddlCandidate.Items.Add(new ListItem("-- Select Intern with Completed Tasks / Quizzes --", ""));
            string compEmail = Session["company"].ToString();
            string query = @"SELECT DISTINCT a.ApplicationId, a.FullName, a.StudentEmail, a.Status, i.InternshipTitle FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + @"') AND ( a.Status = 'Completed' OR a.ApplicationId IN (SELECT ApplicationId FROM StudentTasks WHERE Status='Completed' AND CompanyId=i.CompanyId) OR a.ApplicationId IN (SELECT ApplicationId FROM StudentQuizAssignments WHERE Status='Passed' AND CompanyId=i.CompanyId) ) ORDER BY a.ApplicationId DESC";
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    ddlCandidate.Items.Add(new ListItem(row["FullName"].ToString() + " (" + row["InternshipTitle"].ToString() + " • Task / Quiz Completed)", row["ApplicationId"].ToString()));
                }
            }
        }
        protected void ddlCandidate_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlCandidate.SelectedValue))
            {
                AutoFillCandidateDetails(ddlCandidate.SelectedValue);
            }
            else
            {
                clear();
            }
            ScriptManager.RegisterStartupScript(this, GetType(), "reopenDrawer", "openDrawer();", true);
        }
        void AutoFillCandidateDetails(string appId)
        {
            getcon();
            if (appId.StartsWith("ST_"))
            {
                int stId = Convert.ToInt32(appId.Replace("ST_", ""));
                da = new SqlDataAdapter("SELECT StudentId, FullName, Email, College, ContactNo FROM Students WHERE StudentId=" + stId, con);
                DataSet dsSt = new DataSet();
                da.Fill(dsSt);
                if (dsSt.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = dsSt.Tables[0].Rows[0];
                    txtCandidateName.Text = dr["FullName"].ToString();
                    txtCandidateCollege.Text = dr["College"].ToString();
                    // Get company's first internship title
                    da = new SqlDataAdapter("SELECT TOP 1 InternshipTitle, Duration FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')", con);
                    DataSet dsI = new DataSet();
                    da.Fill(dsI);
                    if (dsI.Tables[0].Rows.Count > 0)
                    {
                        txtInternshipRole.Text = dsI.Tables[0].Rows[0]["InternshipTitle"].ToString();
                        txtDuration.Text = dsI.Tables[0].Rows[0]["Duration"] != DBNull.Value ? dsI.Tables[0].Rows[0]["Duration"].ToString() : "3 Months";
                    }
                    else
                    {
                        txtInternshipRole.Text = "Software Engineering Intern";
                        txtDuration.Text = "3 Months";
                    }
                    txtCertTitle.Text = "Certificate of Internship Excellence";
                    txtPerformance.Text = "Outstanding Performance & Dedication";
                    txtSignatoryName.Text = CompHr;
                    txtIssueDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    UpdatePreviewStateFromControls();
                }
            }
            else
            {
                da = new SqlDataAdapter(@"SELECT a.ApplicationId, a.FullName, a.StudentEmail, a.College, a.ContactNo, i.InternshipTitle, i.Duration, i.Location FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE a.ApplicationId='" + appId + "'", con);
                DataSet dsA = new DataSet();
                da.Fill(dsA);
                if (dsA.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = dsA.Tables[0].Rows[0];
                    txtCandidateName.Text = dr["FullName"].ToString();
                    txtCandidateCollege.Text = dr["College"].ToString();
                    txtInternshipRole.Text = dr["InternshipTitle"].ToString();
                    string dur = dr["Duration"] != DBNull.Value ? dr["Duration"].ToString() : "3 Months";
                    txtDuration.Text = !string.IsNullOrEmpty(dur) ? dur : "3 Months";
                    if (string.IsNullOrEmpty(txtCertTitle.Text))
                        txtCertTitle.Text = "Certificate of Internship Excellence";
                    if (string.IsNullOrEmpty(txtPerformance.Text))
                        txtPerformance.Text = "Outstanding Performance & Dedication";
                    if (string.IsNullOrEmpty(txtSignatoryName.Text))
                        txtSignatoryName.Text = CompHr;
                    if (string.IsNullOrEmpty(txtIssueDate.Text))
                        txtIssueDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    UpdatePreviewStateFromControls();
                }
            }
        }
        void bindCertificates()
        {
            getcon();
            string compEmail = Session["company"].ToString();
            // 1. Total & list of issued certificates
            string query = @"SELECT cc.*, ISNULL(a.FullName, ISNULL(s.FullName, cc.CandidateName)) AS FullName, ISNULL(a.StudentEmail, ISNULL(s.Email, '')) AS StudentEmail, ISNULL(a.College, ISNULL(s.College, cc.CandidateCollege)) AS College, ISNULL(a.ContactNo, ISNULL(s.ContactNo, '')) AS ContactNo, ISNULL(i.InternshipTitle, cc.InternshipRole) AS InternshipTitle, ISNULL(s.ProfilePhoto, '') AS ProfilePhoto FROM CompanyCertificates cc LEFT JOIN StudentApplications a ON cc.ApplicationId = a.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR (a.StudentId = s.StudentId AND a.StudentId > 0) OR a.StudentEmail = s.Email) LEFT JOIN internship i ON cc.InternshipId = i.Id WHERE cc.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + @"') AND (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) ORDER BY cc.CertificateId DESC";
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            totalCerts = 0;
            certifiedInterns = 0;
            if (ds.Tables[0].Rows.Count > 0)
            {
                totalCerts = ds.Tables[0].Rows.Count;
                HashSet<string> candSet = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
                foreach (DataRow r in ds.Tables[0].Rows)
                {
                    string cand = r["FullName"] != DBNull.Value ? r["FullName"].ToString().Trim() : "";
                    if (!string.IsNullOrEmpty(cand)) candSet.Add(cand);
                }
                certifiedInterns = candSet.Count;
                gvCerts.DataSource = ds.Tables[0];
                gvCerts.DataBind();
                gvCerts.Visible = true;
                pnlNoCerts.Visible = false;
            }
            else
            {
                gvCerts.Visible = false;
                pnlNoCerts.Visible = true;
            }
            // 2. Count total eligible candidates with completed tasks / quiz / internship
            string eligQuery = @"SELECT COUNT(DISTINCT a.ApplicationId) FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + @"') AND ( a.Status = 'Completed' OR a.ApplicationId IN (SELECT ApplicationId FROM StudentTasks WHERE Status='Completed' AND CompanyId=i.CompanyId) OR a.ApplicationId IN (SELECT ApplicationId FROM StudentQuizAssignments WHERE Status='Passed' AND CompanyId=i.CompanyId) )";
            SqlCommand eligCmd = new SqlCommand(eligQuery, con);
            object eligObj = eligCmd.ExecuteScalar();
            eligibleInterns = eligObj != null && eligObj != DBNull.Value ? Convert.ToInt32(eligObj) : 0;
            if (eligibleInterns < certifiedInterns) eligibleInterns = certifiedInterns;
            // 3. Count Pending Certificates
            string pendingQuery = @"SELECT COUNT(DISTINCT a.ApplicationId) FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + @"') AND ( a.Status = 'Completed' OR a.ApplicationId IN (SELECT ApplicationId FROM StudentTasks WHERE Status='Completed' AND CompanyId=i.CompanyId) OR a.ApplicationId IN (SELECT ApplicationId FROM StudentQuizAssignments WHERE Status='Passed' AND CompanyId=i.CompanyId) ) AND a.ApplicationId NOT IN (SELECT ApplicationId FROM CompanyCertificates WHERE (IsDeleted=0 OR IsDeleted IS NULL) AND ApplicationId IS NOT NULL)";
            SqlCommand pendCmd = new SqlCommand(pendingQuery, con);
            object pendObj = pendCmd.ExecuteScalar();
            pendingCertificates = pendObj != null && pendObj != DBNull.Value ? Convert.ToInt32(pendObj) : Math.Max(0, eligibleInterns - certifiedInterns);
            if (lblTotalCerts != null) lblTotalCerts.Text = totalCerts.ToString();
            if (lblEligibleInterns != null) lblEligibleInterns.Text = eligibleInterns.ToString();
            if (lblCertifiedInterns != null) lblCertifiedInterns.Text = certifiedInterns.ToString();
            if (lblPendingCertificates != null) lblPendingCertificates.Text = pendingCertificates.ToString();
        }
        protected void btnIssueCert_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlCandidate.SelectedValue) || string.IsNullOrEmpty(txtCandidateName.Text.Trim()))
            {
                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-exclamation'></i> Please select an intern / candidate to issue certificate.</div>";
                lblMsg.Visible = true;
                ScriptManager.RegisterStartupScript(this, GetType(), "reopenDrawer", "openDrawer();", true);
                return;
            }
            string rawVal = ddlCandidate.SelectedValue;
            string candName = txtCandidateName.Text.Trim();
            string college = txtCandidateCollege.Text.Trim();
            string certTitle = txtCertTitle.Text.Trim();
            string role = txtInternshipRole.Text.Trim();
            string duration = txtDuration.Text.Trim();
            string issueDate = txtIssueDate.Text.Trim();
            string performance = txtPerformance.Text.Trim();
            string signatory = txtSignatoryName.Text.Trim();
            if (ViewState["id"] != null)
            {
                getcon();
                string updateSql = "UPDATE CompanyCertificates SET " + "CandidateName='" + candName.Replace("'", "''") + "', CandidateCollege='" + college.Replace("'", "''") + "', CertificateTitle='" + certTitle.Replace("'", "''") + "', " + "InternshipRole='" + role.Replace("'", "''") + "', Duration='" + duration.Replace("'", "''") + "', IssueDate='" + issueDate.Replace("'", "''") + "', " + "Performance='" + performance.Replace("'", "''") + "', SignatoryName='" + signatory.Replace("'", "''") + "' " + "WHERE CertificateId=" + (ViewState["id"] ?? "0");
                SqlCommand updateCmd = new SqlCommand(updateSql, con);
                updateCmd.ExecuteNonQuery();
                lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-check-circle'></i> Certificate updated successfully!</div>";
                lblMsg.Visible = true;
                btnIssueCert.Text = "<i class=\"fa-solid fa-award\"></i> Issue Certificate to Student";
                ViewState["id"] = null;
                clear();
                bindCertificates();
                return;
            }
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
                    string insAppSql = "INSERT INTO StudentApplications (InternshipId, StudentId, FullName, StudentEmail, College, ContactNo, Status, AppliedDate) " + "VALUES ((SELECT TOP 1 Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')), " + studentId + ", '" + candName.Replace("'", "''") + "', (SELECT Email FROM Students WHERE StudentId=" + studentId + "), " + "'" + college.Replace("'", "''") + "', (SELECT ContactNo FROM Students WHERE StudentId=" + studentId + "), 'Completed', GETDATE()); " + "SELECT SCOPE_IDENTITY();";
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
            // Auto-generate CertificateNo (CERT-YYYY-XXXX)
            int currentYear = DateTime.Now.Year;
            string prefix = "CERT-" + currentYear + "-";
            SqlCommand nextNumCmd = new SqlCommand("SELECT ISNULL(MAX(CAST(RIGHT(CertificateNo, 4) AS INT)), 0) + 1 FROM CompanyCertificates WHERE CertificateNo LIKE '" + prefix + "%'", con);
            int nextSeq = 1;
            object seqObj = nextNumCmd.ExecuteScalar();
            if (seqObj != null && seqObj != DBNull.Value)
            {
                int.TryParse(seqObj.ToString(), out nextSeq);
            }
            string certNo = prefix + nextSeq.ToString("D4");
            // Random 8-character Verification Code
            string verifyCode = Guid.NewGuid().ToString("N").Substring(0, 8).ToUpper();
            string insertCertSql = "INSERT INTO CompanyCertificates " + "(ApplicationId, InternshipId, StudentId, CompanyId, CertificateTitle, IssueDate, CertificatePath, Status, CreatedDate, CertificateNo, VerificationCode, IsDeleted, CandidateName, CandidateCollege, InternshipRole, Duration, Performance, SignatoryName) " + "VALUES (" + finalAppId + ", " + internshipId + ", " + studentId + ", " + "(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'), " + "'" + certTitle.Replace("'", "''") + "', '" + issueDate.Replace("'", "''") + "', 'TEMPLATE_GENERATED', 'Issued', GETDATE(), '" + certNo + "', '" + verifyCode + "', 0, '" + candName.Replace("'", "''") + "', '" + college.Replace("'", "''") + "', '" + role.Replace("'", "''") + "', '" + duration.Replace("'", "''") + "', '" + performance.Replace("'", "''") + "', '" + signatory.Replace("'", "''") + "')";
            cmd = new SqlCommand(insertCertSql, con);
            cmd.ExecuteNonQuery();
            // Also update StudentQuizAssignments if any
            cmd = new SqlCommand("UPDATE StudentQuizAssignments SET CertificateIssued=1 WHERE ApplicationId=" + finalAppId + " OR (StudentId=" + studentId + " AND StudentId>0)", con);
            cmd.ExecuteNonQuery();
            // Log Activity
            cmd = new SqlCommand("INSERT INTO CompanyActivityHistory (CompanyId, ActivityType, Description, IPAddress, ActivityDate) VALUES ((SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'), 'Certificate Issued', 'Issued official certificate for: " + candName.Replace("'", "''") + " (" + certNo + ")', '" + Request.UserHostAddress + "', GETDATE())", con);
            cmd.ExecuteNonQuery();
            lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-check'></i> Official Certificate issued successfully! Certificate No: <strong>" + certNo + "</strong></div>";
            lblMsg.Visible = true;
            clear();
            bindCertificates();
        }
        protected void btnResetForm_Click(object sender, EventArgs e)
        {
            clear();
            ScriptManager.RegisterStartupScript(this, GetType(), "keepDrawerOpen", "openDrawer();", true);
        }
        void clear()
        {
            txtCandidateName.Text = "";
            txtCandidateCollege.Text = "";
            txtCertTitle.Text = "Certificate of Internship Excellence";
            txtInternshipRole.Text = "";
            txtDuration.Text = "3 Months";
            txtIssueDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtPerformance.Text = "Outstanding Performance & Dedication";
            txtSignatoryName.Text = CompHr;
            ddlCandidate.SelectedIndex = -1;
            btnIssueCert.Text = "<i class=\"fa-solid fa-award\"></i> Issue Certificate to Student";
            ViewState["id"] = null;
            SelectedCandName = "[Candidate Full Name]";
            SelectedCandCollege = "College / University Name";
            SelectedCertTitle = "Certificate of Internship Excellence";
            SelectedRole = "[Internship Role]";
            SelectedDuration = "3 Months";
            SelectedPerformance = "Outstanding Performance & Dedication";
            SelectedSignatory = CompHr;
            FormattedIssueDate = DateTime.Now.ToString("dd MMMM yyyy");
        }
        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM CompanyCertificates WHERE CertificateId='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                txtCandidateName.Text = dr["CandidateName"] != DBNull.Value ? dr["CandidateName"].ToString() : "";
                txtCandidateCollege.Text = dr["CandidateCollege"] != DBNull.Value ? dr["CandidateCollege"].ToString() : "";
                txtCertTitle.Text = dr["CertificateTitle"] != DBNull.Value ? dr["CertificateTitle"].ToString() : "Certificate of Internship Excellence";
                txtInternshipRole.Text = dr["InternshipRole"] != DBNull.Value ? dr["InternshipRole"].ToString() : "";
                txtDuration.Text = dr["Duration"] != DBNull.Value ? dr["Duration"].ToString() : "3 Months";
                if (dr["IssueDate"] != DBNull.Value)
                {
                    DateTime dt;
                    if (DateTime.TryParse(dr["IssueDate"].ToString(), out dt))
                        txtIssueDate.Text = dt.ToString("yyyy-MM-dd");
                    else
                        txtIssueDate.Text = dr["IssueDate"].ToString();
                }
                txtPerformance.Text = dr["Performance"] != DBNull.Value ? dr["Performance"].ToString() : "Outstanding Performance & Dedication";
                txtSignatoryName.Text = dr["SignatoryName"] != DBNull.Value ? dr["SignatoryName"].ToString() : CompHr;
                if (dr["ApplicationId"] != DBNull.Value && ddlCandidate.Items.FindByValue(dr["ApplicationId"].ToString()) != null)
                {
                    ddlCandidate.SelectedValue = dr["ApplicationId"].ToString();
                }
                btnIssueCert.Text = "<i class=\"fa-solid fa-floppy-disk\"></i> Update Certificate Details";
                UpdatePreviewStateFromControls();
            }
        }
        protected void gvCerts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandArgument == null) return;
            string id = e.CommandArgument.ToString();
            if (e.CommandName == "EditCert" || e.CommandName == "cmd_edt")
            {
                ViewState["id"] = id;
                filldata();
                btnIssueCert.Text = "<i class=\"fa-solid fa-floppy-disk\"></i> Update Certificate Details";
                ScriptManager.RegisterStartupScript(this, GetType(), "openEditModal", "openDrawer();", true);
            }
            else if (e.CommandName == "DeleteCert" || e.CommandName == "cmd_dlt")
            {
                getcon();
                SqlCommand delCmd = new SqlCommand("UPDATE CompanyCertificates SET IsDeleted=1 WHERE CertificateId=" + id, con);
                delCmd.ExecuteNonQuery();
                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-trash'></i> Certificate deleted successfully.</div>";
                lblMsg.Visible = true;
                bindCertificates();
            }
        }
        public string GetCertStatusBadge(object statusObj)
        {
            string st = statusObj != null ? statusObj.ToString() : "Issued";
            return "<span style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:4px 10px; border-radius:20px; font-size:12px; font-weight:700; display:inline-flex; align-items:center; gap:5px;'><i class='fa-solid fa-circle-check'></i> " + st + "</span>";
        }
        public string FormatDate(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return "N/A";
            DateTime dt;
            if (DateTime.TryParse(dateObj.ToString(), out dt))
            {
                return dt.ToString("dd MMM yyyy");
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
                return "<div style=\"display:flex; align-items:center; justify-content:center;\">" + "<img src=\"" + resolvedPhoto + "\" alt=\"" + Server.HtmlEncode(name) + "\" style=\"width:38px; height:38px; border-radius:50%; object-fit:cover; border:2px solid #e2e8f0; display:block;\" onerror=\"this.style.display='none'; this.nextElementSibling.style.display='flex';\" />" + "<div style=\"display:none; width:38px; height:38px; border-radius:50%; background:#eff6ff; color:#2563eb; align-items:center; justify-content:center; font-weight:700; font-size:13px; border:2px solid #e2e8f0;\">" + initials + "</div>" + "</div>";
            }
            return "<div style=\"display:flex; align-items:center; justify-content:center;\">" + "<div style=\"width:38px; height:38px; border-radius:50%; background:#eff6ff; color:#2563eb; display:flex; align-items:center; justify-content:center; font-weight:700; font-size:13px; border:2px solid #e2e8f0;\">" + initials + "</div>" + "</div>";
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
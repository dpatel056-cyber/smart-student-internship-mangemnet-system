using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_offer_letters : System.Web.UI.Page
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
        public string SelectedRole = "[Internship Role]";
        public string SelectedStipend = "<i class=\"fa-solid fa-indian-rupee-sign\" style=\"font-size:12px; margin-right:3px;\"></i> 15,000 / month";
        public string SelectedDuration = "3 Months";
        public string SelectedJoining = "";
        public string SelectedValidTill = "";
        public string SelectedLocation = "Ahmedabad, Gujarat";
        public string FormattedOfferDate = "";

        public int totalOffers = 0;
        public int acceptedOffers = 0;
        public int sentOffers = 0;
        public int rejectedOffers = 0;

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

                FormattedOfferDate = DateTime.Now.ToString("dd MMMM yyyy");
                SelectedJoining = DateTime.Now.AddDays(7).ToString("dd MMM yyyy");
                SelectedValidTill = DateTime.Now.AddDays(14).ToString("dd MMM yyyy");
                SelectedLocation = CompLocation;

                if (!IsPostBack)
                {
                    txtOfferDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txtJoiningDate.Text = DateTime.Now.AddDays(7).ToString("yyyy-MM-dd");
                    txtValidTill.Text = DateTime.Now.AddDays(14).ToString("yyyy-MM-dd");
                    txtWorkLocation.Text = CompLocation;

                    bindCandidateDropdown();
                    bindOffers();

                    if (Request.QueryString["appId"] != null)
                    {
                        string preAppId = Request.QueryString["appId"].ToString();
                        if (ddlCandidate.Items.FindByValue(preAppId) != null)
                        {
                            ddlCandidate.SelectedValue = preAppId;
                            AutoFillCandidateDetails(preAppId);
                        }
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
            if (!string.IsNullOrEmpty(txtOfferTitle.Text.Trim()))
                SelectedRole = txtOfferTitle.Text.Trim();
            if (!string.IsNullOrEmpty(txtStipend.Text.Trim()))
            {
                string st = txtStipend.Text.Trim().Replace("â,¹", "").Replace("â‚¹", "").Replace("?", "").Replace("₹", "").Replace("Rs.", "").Replace("INR", "").Trim();
                if (!st.ToLower().Contains("month") && !st.ToLower().Contains("unpaid") && !st.ToLower().Contains("fixed"))
                {
                    st = st + " / month";
                }
                SelectedStipend = "<i class=\"fa-solid fa-indian-rupee-sign\" style=\"font-size:12px; margin-right:3px;\"></i> " + st;
            }
            if (!string.IsNullOrEmpty(txtDuration.Text.Trim()))
                SelectedDuration = txtDuration.Text.Trim();
            if (!string.IsNullOrEmpty(txtJoiningDate.Text.Trim()))
            {
                DateTime dt;
                SelectedJoining = DateTime.TryParse(txtJoiningDate.Text.Trim(), out dt) ? dt.ToString("dd MMM yyyy") : txtJoiningDate.Text.Trim();
            }
            if (!string.IsNullOrEmpty(txtValidTill.Text.Trim()))
            {
                DateTime dt;
                SelectedValidTill = DateTime.TryParse(txtValidTill.Text.Trim(), out dt) ? dt.ToString("dd MMM yyyy") : txtValidTill.Text.Trim();
            }
            if (!string.IsNullOrEmpty(txtWorkLocation.Text.Trim()))
                SelectedLocation = txtWorkLocation.Text.Trim();
            if (!string.IsNullOrEmpty(txtOfferDate.Text.Trim()))
            {
                DateTime dt;
                FormattedOfferDate = DateTime.TryParse(txtOfferDate.Text.Trim(), out dt) ? dt.ToString("dd MMMM yyyy") : txtOfferDate.Text.Trim();
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
            ddlCandidate.Items.Add(new ListItem("-- Select Selected Candidate for Offer Letter --", ""));

            string compEmail = Session["company"].ToString();
            string query = @"SELECT a.ApplicationId, a.FullName, a.StudentEmail, a.Status, i.InternshipTitle
                             FROM StudentApplications a
                             INNER JOIN internship i ON a.InternshipId = i.Id
                             WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + @"')
                             AND a.Status IN ('Selected', 'Shortlisted')
                             ORDER BY a.ApplicationId DESC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    string statusStr = row["Status"] != DBNull.Value ? row["Status"].ToString() : "Selected";
                    ddlCandidate.Items.Add(new ListItem(row["FullName"].ToString() + " (" + row["InternshipTitle"].ToString() + " • " + statusStr + ")", row["ApplicationId"].ToString()));
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

                    da = new SqlDataAdapter("SELECT TOP 1 InternshipTitle, StipendAmount, Duration, Location FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')", con);
                    DataSet dsI = new DataSet();
                    da.Fill(dsI);
                    if (dsI.Tables[0].Rows.Count > 0)
                    {
                        DataRow drI = dsI.Tables[0].Rows[0];
                        txtOfferTitle.Text = drI["InternshipTitle"].ToString();
                        string stp = drI["StipendAmount"] != DBNull.Value ? drI["StipendAmount"].ToString() : "";
                        stp = stp.Replace("â,¹", "").Replace("?", "").Replace("₹", "").Trim();
                        txtStipend.Text = !string.IsNullOrEmpty(stp) ? stp : "15,000 / month";
                        txtDuration.Text = drI["Duration"] != DBNull.Value ? drI["Duration"].ToString() : "3 Months";
                        txtWorkLocation.Text = drI["Location"] != DBNull.Value ? drI["Location"].ToString() : CompLocation;
                    }
                    else
                    {
                        txtOfferTitle.Text = "Software Engineering Intern";
                        txtStipend.Text = "15,000 / month";
                        txtDuration.Text = "3 Months";
                        txtWorkLocation.Text = CompLocation;
                    }

                    if (string.IsNullOrEmpty(txtOfferDate.Text))
                        txtOfferDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    if (string.IsNullOrEmpty(txtJoiningDate.Text))
                        txtJoiningDate.Text = DateTime.Now.AddDays(7).ToString("yyyy-MM-dd");
                    if (string.IsNullOrEmpty(txtValidTill.Text))
                        txtValidTill.Text = DateTime.Now.AddDays(14).ToString("yyyy-MM-dd");

                    UpdatePreviewStateFromControls();
                }
            }
            else
            {
                da = new SqlDataAdapter(@"SELECT a.ApplicationId, a.FullName, a.StudentEmail, a.College, a.ContactNo,
                                         i.InternshipTitle, i.StipendAmount, i.Duration, i.Location
                                         FROM StudentApplications a
                                         INNER JOIN internship i ON a.InternshipId = i.Id
                                         WHERE a.ApplicationId='" + appId + "'", con);
                DataSet dsA = new DataSet();
                da.Fill(dsA);

                if (dsA.Tables[0].Rows.Count > 0)
                {
                    DataRow dr = dsA.Tables[0].Rows[0];
                    txtCandidateName.Text = dr["FullName"].ToString();
                    txtCandidateCollege.Text = dr["College"].ToString();
                    txtOfferTitle.Text = dr["InternshipTitle"].ToString();

                    string stp = dr["StipendAmount"] != DBNull.Value ? dr["StipendAmount"].ToString() : "";
                    stp = stp.Replace("â,¹", "").Replace("â‚¹", "").Replace("?", "").Replace("₹", "").Trim();
                    txtStipend.Text = !string.IsNullOrEmpty(stp) ? stp : "15,000 / month";

                    string dur = dr["Duration"].ToString();
                    txtDuration.Text = !string.IsNullOrEmpty(dur) ? dur : "3 Months";

                    string loc = dr["Location"].ToString();
                    txtWorkLocation.Text = !string.IsNullOrEmpty(loc) ? loc : CompLocation;

                    if (string.IsNullOrEmpty(txtOfferDate.Text))
                        txtOfferDate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                    if (string.IsNullOrEmpty(txtJoiningDate.Text))
                        txtJoiningDate.Text = DateTime.Now.AddDays(7).ToString("yyyy-MM-dd");

                    if (string.IsNullOrEmpty(txtValidTill.Text))
                        txtValidTill.Text = DateTime.Now.AddDays(14).ToString("yyyy-MM-dd");

                    UpdatePreviewStateFromControls();
                }
            }
        }

        void bindOffers()
        {
            getcon();
            string query = @"SELECT col.*,
                             ISNULL(a.FullName, s.FullName) AS FullName,
                             ISNULL(a.StudentEmail, s.Email) AS StudentEmail,
                             ISNULL(a.College, s.College) AS College,
                             ISNULL(a.ContactNo, s.ContactNo) AS ContactNo,
                             ISNULL(i.InternshipTitle, col.OfferTitle) AS InternshipTitle,
                             ISNULL(NULLIF(col.Duration, ''), ISNULL(i.Duration, '3 Months')) AS Duration,
                             ISNULL(NULLIF(col.WorkLocation, ''), ISNULL(i.Location, 'Ahmedabad')) AS Location
                             FROM CompanyOfferLetters col
                             LEFT JOIN StudentApplications a ON col.ApplicationId = a.ApplicationId
                             LEFT JOIN Students s ON col.StudentId = s.StudentId
                             LEFT JOIN internship i ON col.InternshipId = i.Id
                             WHERE col.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + @"')
                             ORDER BY col.OfferId DESC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            totalOffers = 0;
            acceptedOffers = 0;
            sentOffers = 0;
            rejectedOffers = 0;

            if (ds.Tables[0].Rows.Count > 0)
            {
                totalOffers = ds.Tables[0].Rows.Count;
                foreach (DataRow r in ds.Tables[0].Rows)
                {
                    string st = r["Status"] != null ? r["Status"].ToString() : "";
                    if (st.Equals("Accepted", StringComparison.OrdinalIgnoreCase)) acceptedOffers++;
                    else if (st.Equals("Rejected", StringComparison.OrdinalIgnoreCase)) rejectedOffers++;
                    else sentOffers++;
                }

                gvOffers.DataSource = ds.Tables[0];
                gvOffers.DataBind();
                gvOffers.Visible = true;
                pnlNoOffers.Visible = false;
            }
            else
            {
                gvOffers.Visible = false;
                pnlNoOffers.Visible = true;
            }

            if (lblTotalOffers != null) lblTotalOffers.Text = totalOffers.ToString();
            if (lblAcceptedOffers != null) lblAcceptedOffers.Text = acceptedOffers.ToString();
            if (lblSentOffers != null) lblSentOffers.Text = sentOffers.ToString();
            if (lblRejectedOffers != null) lblRejectedOffers.Text = rejectedOffers.ToString();

        }

        protected void btnIssueOffer_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlCandidate.SelectedValue) || string.IsNullOrEmpty(txtOfferTitle.Text.Trim()))
            {
                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-exclamation'></i> Please select a candidate and enter offer designation.</div>";
                lblMsg.Visible = true;
                ScriptManager.RegisterStartupScript(this, GetType(), "reopenDrawer", "openDrawer();", true);
                return;
            }

            string rawVal = ddlCandidate.SelectedValue;
            string title = txtOfferTitle.Text.Trim();
            string stipend = txtStipend.Text.Trim().Replace("â,¹", "").Replace("?", "").Replace("₹", "").Trim();
            string joinDate = txtJoiningDate.Text.Trim();
            string duration = txtDuration.Text.Trim();
            string workLoc = txtWorkLocation.Text.Trim();
            string validTill = txtValidTill.Text.Trim();
            string candName = txtCandidateName.Text.Trim();
            string college = txtCandidateCollege.Text.Trim();

            if (ViewState["id"] != null)
            {
                getcon();
                string updateSql = "UPDATE CompanyOfferLetters SET OfferTitle='" + title.Replace("'", "''") + "', Stipend='" + stipend.Replace("'", "''") + "', JoiningDate='" + joinDate.Replace("'", "''") + "', Duration='" + duration.Replace("'", "''") + "', WorkLocation='" + workLoc.Replace("'", "''") + "', ValidTill='" + validTill.Replace("'", "''") + "' WHERE OfferId=" + (ViewState["id"] ?? "0");
                SqlCommand updateCmd = new SqlCommand(updateSql, con);
                updateCmd.ExecuteNonQuery();

                lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-check-circle'></i> Offer letter updated successfully!</div>";
                lblMsg.Visible = true;

                btnIssueOffer.Text = "<i class=\"fa-solid fa-paper-plane\"></i> Send Offer Letter to Student";
                ViewState["id"] = null;
                clear();
                bindOffers();
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
                    string insAppSql = "INSERT INTO StudentApplications (InternshipId, StudentId, FullName, StudentEmail, College, ContactNo, Status, AppliedDate) " +
                        "VALUES ((SELECT TOP 1 Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')), " +
                        studentId + ", '" + candName.Replace("'", "''") + "', (SELECT Email FROM Students WHERE StudentId=" + studentId + "), " +
                        "'" + college.Replace("'", "''") + "', (SELECT ContactNo FROM Students WHERE StudentId=" + studentId + "), 'Selected', GETDATE()); " +
                        "SELECT SCOPE_IDENTITY();";
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

            string insOfferSql = "INSERT INTO CompanyOfferLetters " +
                "(ApplicationId, InternshipId, StudentId, CompanyId, OfferTitle, Stipend, JoiningDate, OfferLetterPath, Status, IssuedDate, Duration, WorkLocation, ValidTill) " +
                "VALUES (" + finalAppId + ", " + internshipId + ", " + studentId + ", " +
                "(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'), " +
                "'" + title.Replace("'", "''") + "', '" + stipend.Replace("'", "''") + "', '" + joinDate.Replace("'", "''") + "', 'TEMPLATE_GENERATED', 'Sent', GETDATE(), '" + duration.Replace("'", "''") + "', '" + workLoc.Replace("'", "''") + "', '" + validTill.Replace("'", "''") + "')";

            cmd = new SqlCommand(insOfferSql, con);
            cmd.ExecuteNonQuery();

            // Update application status to Selected
            cmd = new SqlCommand("UPDATE StudentApplications SET Status='Selected' WHERE ApplicationId=" + finalAppId, con);
            cmd.ExecuteNonQuery();

            // Log Activity
            cmd = new SqlCommand("INSERT INTO CompanyActivityHistory (CompanyId, ActivityType, Description, IPAddress, ActivityDate) VALUES ((SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'), 'Offer Issued', 'Issued official offer letter for position: " + title.Replace("'", "''") + "', '" + Request.UserHostAddress + "', GETDATE())", con);
            cmd.ExecuteNonQuery();

            lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-check'></i> Official Offer Letter sent to student successfully!</div>";
            lblMsg.Visible = true;

            clear();
            bindOffers();
        }

        protected void btnResetForm_Click(object sender, EventArgs e)
        {
            clear();
            ScriptManager.RegisterStartupScript(this, GetType(), "reopenDrawer", "openDrawer();", true);
        }

        void clear()
        {
            txtCandidateName.Text = "";
            txtCandidateCollege.Text = "";
            txtOfferTitle.Text = "";
            txtStipend.Text = "";
            txtDuration.Text = "";
            txtOfferDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtJoiningDate.Text = DateTime.Now.AddDays(7).ToString("yyyy-MM-dd");
            txtWorkLocation.Text = CompLocation;
            txtValidTill.Text = DateTime.Now.AddDays(14).ToString("yyyy-MM-dd");
            ddlCandidate.SelectedIndex = -1;
            btnIssueOffer.Text = "<i class=\"fa-solid fa-paper-plane\"></i> Send Offer Letter to Student";
            ViewState["id"] = null;

            SelectedCandName = "[Candidate Full Name]";
            SelectedCandCollege = "College / University Name";
            SelectedRole = "[Internship Role]";
            SelectedStipend = "<i class=\"fa-solid fa-indian-rupee-sign\" style=\"font-size:12px; margin-right:3px;\"></i> 15,000 / month";
            SelectedDuration = "3 Months";
            SelectedJoining = DateTime.Now.AddDays(7).ToString("dd MMM yyyy");
            SelectedValidTill = DateTime.Now.AddDays(14).ToString("dd MMM yyyy");
            SelectedLocation = CompLocation;
            FormattedOfferDate = DateTime.Now.ToString("dd MMMM yyyy");
        }

        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM CompanyOfferLetters WHERE OfferId='" + ViewState["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow dr = ds.Tables[0].Rows[0];
                string appId = dr["ApplicationId"].ToString();
                if (ddlCandidate.Items.FindByValue(appId) != null)
                {
                    ddlCandidate.SelectedValue = appId;
                    AutoFillCandidateDetails(appId);
                }
                txtOfferTitle.Text = dr["OfferTitle"].ToString();
                txtStipend.Text = dr["Stipend"].ToString();
                txtJoiningDate.Text = dr["JoiningDate"].ToString();
                if (dr["Duration"] != DBNull.Value && !string.IsNullOrEmpty(dr["Duration"].ToString()))
                    txtDuration.Text = dr["Duration"].ToString();
                if (dr["WorkLocation"] != DBNull.Value && !string.IsNullOrEmpty(dr["WorkLocation"].ToString()))
                    txtWorkLocation.Text = dr["WorkLocation"].ToString();
                if (dr["ValidTill"] != DBNull.Value && !string.IsNullOrEmpty(dr["ValidTill"].ToString()))
                    txtValidTill.Text = dr["ValidTill"].ToString();

                UpdatePreviewStateFromControls();
            }
        }

        protected void gvOffers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandArgument == null) return;
            string id = e.CommandArgument.ToString();

            if (e.CommandName == "EditOffer" || e.CommandName == "cmd_edt")
            {
                ViewState["id"] = id;
                filldata();
                btnIssueOffer.Text = "<i class=\"fa-solid fa-floppy-disk\"></i> Update Offer Letter";
                ScriptManager.RegisterStartupScript(this, GetType(), "openEditModal", "openDrawer();", true);
            }
            else if (e.CommandName == "DeleteOffer" || e.CommandName == "cmd_dlt")
            {
                getcon();
                SqlCommand delCmd = new SqlCommand("DELETE FROM CompanyOfferLetters WHERE OfferId=" + id, con);
                delCmd.ExecuteNonQuery();

                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-trash'></i> Offer letter deleted successfully.</div>";
                lblMsg.Visible = true;

                bindOffers();
            }
        }

        public string GetOfferStatusBadge(object statusObj)
        {
            string st = statusObj != null ? statusObj.ToString() : "Sent";
            if (st.Equals("Accepted", StringComparison.OrdinalIgnoreCase))
            {
                return "<span style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:4px 10px; border-radius:20px; font-size:12px; font-weight:700; display:inline-flex; align-items:center; gap:5px;'><i class='fa-solid fa-circle-check'></i> Accepted</span>";
            }
            if (st.Equals("Rejected", StringComparison.OrdinalIgnoreCase))
            {
                return "<span style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:4px 10px; border-radius:20px; font-size:12px; font-weight:700; display:inline-flex; align-items:center; gap:5px;'><i class='fa-solid fa-circle-xmark'></i> Rejected</span>";
            }
            return "<span style='background:#eff6ff; color:#2563eb; border:1px solid #bfdbfe; padding:4px 10px; border-radius:20px; font-size:12px; font-weight:600; display:inline-flex; align-items:center; gap:5px;'><i class='fa-solid fa-paper-plane'></i> Sent</span>";
        }

        public string FormatStipend(object stipendObj)
        {
            if (stipendObj == null || stipendObj == DBNull.Value) return "₹ 15,000 / month";
            string st = stipendObj.ToString().Replace("â,¹", "").Replace("â‚¹", "").Replace("?", "").Replace("₹", "").Trim();
            if (!st.ToLower().Contains("month") && !st.ToLower().Contains("unpaid") && !st.ToLower().Contains("fixed"))
            {
                st = st + " / month";
            }
            return "₹ " + st;
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

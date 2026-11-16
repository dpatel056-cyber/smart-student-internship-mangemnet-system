using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web.Design;

namespace asp.net
{
    public partial class company_certificates : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        CompanyClass comp = new CompanyClass();
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new ReportDocument();
        static string Crypath = "";

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
                    ViewState["page"] = 0;
                    totalcertificates();
                    eligibleinterns();
                    certifiedinterns();
                    pendingcertificates();
                    certificatefillgrid();

                    txtIssueDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txtCertTitle.Text = "Certificate of Internship Excellence";
                    txtPerformance.Text = "Outstanding Performance & Dedication";
                    txtSignatoryName.Text = CompHr;

                    fillcombo();

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

        void totalcertificates()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from CompanyCertificates where CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "') and (IsDeleted=0 or IsDeleted is null)", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalCerts.Text = i.ToString();
        }

        void eligibleinterns()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications a inner join internship i on a.InternshipId=i.Id where i.CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "') and a.Status in ('Completed', 'Selected', 'Offer Accepted', 'Accepted')", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblEligibleInterns.Text = i.ToString();
        }

        void certifiedinterns()
        {
            getcon();
            cmd = new SqlCommand("select count(distinct ApplicationId) from CompanyCertificates where CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "') and (IsDeleted=0 or IsDeleted is null)", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblCertifiedInterns.Text = i.ToString();
        }

        void pendingcertificates()
        {
            getcon();
            cmd = new SqlCommand("select count(*) from StudentApplications a inner join internship i on a.InternshipId=i.Id where i.CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "') and a.Status in ('Completed', 'Selected', 'Offer Accepted', 'Accepted') and a.ApplicationId not in (select ApplicationId from CompanyCertificates where (IsDeleted=0 or IsDeleted is null) and ApplicationId is not null)", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblPendingCertificates.Text = i.ToString();
        }

        void fillcombo()
        {
            comp = new CompanyClass();
            ds = comp.fill_combo_certificate(Session["company"].ToString());
            ddlCandidate.DataSource = ds;
            ddlCandidate.DataTextField = "FullName";
            ddlCandidate.DataValueField = "ApplicationId";
            ddlCandidate.DataBind();
            ddlCandidate.Items.Insert(0, new ListItem("-- Select Candidate for Certificate --", ""));
        }

        void certificatefillgrid()
        {
            comp = new CompanyClass();
            DataTable dt = comp.select_certificates(Session["company"].ToString()).Tables[0];
            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 5.0);
            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            if (dt.Rows.Count > 0)
            {
                gvCerts.DataSource = comp.certificate_pagination(dt, page);
                gvCerts.DataBind();
                gvCerts.Visible = true;
                pnlNoCerts.Visible = false;
            }
            else
            {
                gvCerts.Visible = false;
                pnlNoCerts.Visible = true;
            }

            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = (page + 1) * 5 < dt.Rows.Count;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 5.0) : 0;
            if (dt != null && dt.Rows.Count > 0)
            {
                gvCerts.DataSource = comp.certificate_pagination(dt, 0);
                gvCerts.DataBind();
                gvCerts.Visible = true;
                pnlNoCerts.Visible = false;
            }
            else
            {
                gvCerts.Visible = false;
                pnlNoCerts.Visible = true;
            }
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = dt != null && dt.Rows.Count > 5;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            comp = new CompanyClass();
            filtergrid(comp.search_certificates(txtSearch.Text, Session["company"].ToString()).Tables[0]);
        }

        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ViewState["page"] = 0;
            certificatefillgrid();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            certificatefillgrid();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            certificatefillgrid();
        }

        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select cc.CertificateNo as [Certificate No], ISNULL(a.FullName, s.FullName) as [Student Name], c.c_company as [Company], ISNULL(i.InternshipTitle, cc.CertificateTitle) as [Internship], cc.IssueDate as [Issue Date], ISNULL(cc.Performance, 'Completed') as [Performance] from CompanyCertificates cc left join StudentApplications a on cc.ApplicationId = a.ApplicationId left join Students s on (cc.StudentId = s.StudentId or a.StudentId = s.StudentId) inner join c_registration c on cc.CompanyId = c.CompanyId left join internship i on cc.InternshipId = i.Id where c.c_email='" + Session["company"] + "' and (cc.IsDeleted=0 or cc.IsDeleted is null) order by cc.CertificateId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            string sXml = Server.MapPath("~/company_certificates_report_data.xml");
            ds.WriteXmlSchema(sXml);

            //Now add crystalreportviewer to view the report.
            Crypath = Server.MapPath("~/CompanyPanel/company_certificates_report.rpt");
            cr.Load(Crypath);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "Company Certificate Report");
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
                string logo = r["c_logo"] != DBNull.Value ? r["c_logo"].ToString() : "";
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

        void UpdatePreviewStateFromControls()
        {
            if (!string.IsNullOrEmpty(txtCandidateName.Text))
                SelectedCandName = txtCandidateName.Text;
            if (!string.IsNullOrEmpty(txtCandidateCollege.Text))
                SelectedCandCollege = txtCandidateCollege.Text;
            if (!string.IsNullOrEmpty(txtCertTitle.Text))
                SelectedCertTitle = txtCertTitle.Text;
            if (!string.IsNullOrEmpty(txtInternshipRole.Text))
                SelectedRole = txtInternshipRole.Text;
            if (!string.IsNullOrEmpty(txtDuration.Text))
                SelectedDuration = txtDuration.Text;
            if (!string.IsNullOrEmpty(txtPerformance.Text))
                SelectedPerformance = txtPerformance.Text;
            if (!string.IsNullOrEmpty(txtSignatoryName.Text))
                SelectedSignatory = txtSignatoryName.Text;
            if (!string.IsNullOrEmpty(txtIssueDate.Text))
            {
                DateTime dt;
                FormattedIssueDate = DateTime.TryParse(txtIssueDate.Text, out dt) ? dt.ToString("dd MMMM yyyy") : txtIssueDate.Text;
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
            da = new SqlDataAdapter("SELECT a.ApplicationId, a.FullName, a.StudentEmail, a.College, a.ContactNo, i.InternshipTitle, i.Duration FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE a.ApplicationId=" + appId, con);
            DataSet dsA = new DataSet();
            da.Fill(dsA);

            if (dsA.Tables[0].Rows.Count > 0)
            {
                DataRow dr = dsA.Tables[0].Rows[0];
                txtCandidateName.Text = dr["FullName"].ToString();
                txtCandidateCollege.Text = dr["College"].ToString();
                txtInternshipRole.Text = dr["InternshipTitle"].ToString();
                string dur = dr["Duration"] != DBNull.Value ? dr["Duration"].ToString() : "3 Months";
                txtDuration.Text = dur != "" ? dur : "3 Months";
                txtCertTitle.Text = "Certificate of Internship Excellence";
                txtPerformance.Text = "Outstanding Performance & Dedication";
                txtSignatoryName.Text = CompHr;
                txtIssueDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                UpdatePreviewStateFromControls();
            }
        }

        protected void btnIssueCert_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlCandidate.SelectedValue) || string.IsNullOrEmpty(txtCandidateName.Text))
            {
                lblMsg.Text = "<div class='cert-alert-danger'><i class='fa-solid fa-circle-exclamation'></i> Please select a candidate to issue certificate.</div>";
                lblMsg.Visible = true;
                ScriptManager.RegisterStartupScript(this, GetType(), "reopenDrawer", "openDrawer();", true);
                return;
            }

            string candName = txtCandidateName.Text;
            string college = txtCandidateCollege.Text;
            string certTitle = txtCertTitle.Text;
            string role = txtInternshipRole.Text;
            string duration = txtDuration.Text;
            string issueDate = txtIssueDate.Text;
            string performance = txtPerformance.Text;
            string signatory = txtSignatoryName.Text;

            if (ViewState["id"] != null)
            {
                int certId = Convert.ToInt32(ViewState["id"]);
                comp = new CompanyClass();
                comp.update_certificate(certId, certTitle, role, duration, issueDate, performance, signatory, candName, college);

                lblMsg.Text = "<div class='cert-alert-success'><i class='fa-solid fa-check-circle'></i> Certificate updated successfully!</div>";
                lblMsg.Visible = true;
                btnIssueCert.Text = "<i class=\"fa-solid fa-award\"></i> Issue Certificate to Student";
                ViewState["id"] = null;
                clear();
                totalcertificates();
                eligibleinterns();
                certifiedinterns();
                pendingcertificates();
                certificatefillgrid();
                return;
            }

            int finalAppId = Convert.ToInt32(ddlCandidate.SelectedValue);
            comp = new CompanyClass();
            comp.insert_certificate(finalAppId, Session["company"].ToString(), certTitle, role, duration, issueDate, performance, signatory, candName, college);

            lblMsg.Text = "<div class='cert-alert-success'><i class='fa-solid fa-check-circle'></i> Official Certificate issued successfully!</div>";
            lblMsg.Visible = true;
            clear();
            totalcertificates();
            eligibleinterns();
            certifiedinterns();
            pendingcertificates();
            certificatefillgrid();
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

            if (e.CommandName == "cmd_edt" || e.CommandName == "EditCert")
            {
                ViewState["id"] = id;
                filldata();
                btnIssueCert.Text = "<i class=\"fa-solid fa-floppy-disk\"></i> Update Certificate Details";
                ScriptManager.RegisterStartupScript(this, GetType(), "openEditModal", "openDrawer();", true);
            }
            else if (e.CommandName == "cmd_dlt" || e.CommandName == "DeleteCert")
            {
                comp = new CompanyClass();
                comp.delete_certificate(Convert.ToInt32(id));
                lblMsg.Text = "<div class='cert-alert-danger'><i class='fa-solid fa-trash'></i> Certificate deleted successfully.</div>";
                lblMsg.Visible = true;
                totalcertificates();
                eligibleinterns();
                certifiedinterns();
                pendingcertificates();
                certificatefillgrid();
            }
        }

        public string GetCertStatusBadge(object statusObj)
        {
            string st = statusObj != null ? statusObj.ToString() : "Issued";
            return "<span class='cert-status-badge'><i class='fa-solid fa-circle-check'></i> " + st + "</span>";
        }
    }
}

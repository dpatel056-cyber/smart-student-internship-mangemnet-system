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
        CompanyClass comp = new CompanyClass();
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

                    fillcombo();
                    bindOffers();
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

        void fillcombo()
        {
            comp = new CompanyClass();
            ds = comp.fill_combo_offer(Session["company"].ToString());
            ddlCandidate.DataSource = ds;
            ddlCandidate.DataTextField = "FullName";
            ddlCandidate.DataValueField = "ApplicationId";
            ddlCandidate.DataBind();
            ddlCandidate.Items.Insert(0, new ListItem("-- Select Candidate for Offer Letter --", ""));
        }

        void UpdatePreviewStateFromControls()
        {
            if (!string.IsNullOrEmpty(txtCandidateName.Text))
                SelectedCandName = txtCandidateName.Text;
            if (!string.IsNullOrEmpty(txtCandidateCollege.Text))
                SelectedCandCollege = txtCandidateCollege.Text;
            if (!string.IsNullOrEmpty(txtOfferTitle.Text))
                SelectedRole = txtOfferTitle.Text;
            if (!string.IsNullOrEmpty(txtStipend.Text))
            {
                string st = txtStipend.Text.Replace("?", "").Replace("₹", "").Replace("Rs.", "").Replace("INR", "");
                if (!st.ToLower().Contains("month") && !st.ToLower().Contains("unpaid") && !st.ToLower().Contains("fixed"))
                {
                    st = st + " / month";
                }
                SelectedStipend = "<i class=\"fa-solid fa-indian-rupee-sign\" style=\"font-size:12px; margin-right:3px;\"></i> " + st;
            }
            if (!string.IsNullOrEmpty(txtDuration.Text))
                SelectedDuration = txtDuration.Text;
            if (!string.IsNullOrEmpty(txtJoiningDate.Text))
            {
                DateTime dt;
                SelectedJoining = DateTime.TryParse(txtJoiningDate.Text, out dt) ? dt.ToString("dd MMM yyyy") : txtJoiningDate.Text;
            }
            if (!string.IsNullOrEmpty(txtValidTill.Text))
            {
                DateTime dt;
                SelectedValidTill = DateTime.TryParse(txtValidTill.Text, out dt) ? dt.ToString("dd MMM yyyy") : txtValidTill.Text;
            }
            if (!string.IsNullOrEmpty(txtWorkLocation.Text))
                SelectedLocation = txtWorkLocation.Text;
            if (!string.IsNullOrEmpty(txtOfferDate.Text))
            {
                DateTime dt;
                FormattedOfferDate = DateTime.TryParse(txtOfferDate.Text, out dt) ? dt.ToString("dd MMMM yyyy") : txtOfferDate.Text;
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
            da = new SqlDataAdapter("SELECT a.ApplicationId, a.FullName, a.StudentEmail, a.College, a.ContactNo, i.InternshipTitle, i.StipendAmount, i.Duration, i.Location FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE a.ApplicationId=" + appId, con);
            DataSet dsA = new DataSet();
            da.Fill(dsA);

            if (dsA.Tables[0].Rows.Count > 0)
            {
                DataRow dr = dsA.Tables[0].Rows[0];
                txtCandidateName.Text = dr["FullName"].ToString();
                txtCandidateCollege.Text = dr["College"].ToString();
                txtOfferTitle.Text = dr["InternshipTitle"].ToString();

                string stp = dr["StipendAmount"] != DBNull.Value ? dr["StipendAmount"].ToString() : "";
                stp = stp.Replace("?", "").Replace("₹", "");
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

        void bindOffers()
        {
            comp = new CompanyClass();
            ds = comp.select_offers(Session["company"].ToString());

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
            if (string.IsNullOrEmpty(ddlCandidate.SelectedValue) || string.IsNullOrEmpty(txtOfferTitle.Text))
            {
                lblMsg.Text = "<div style='background:#fee2e2; color:#dc2626; border:1px solid #fecaca; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-circle-exclamation'></i> Please select a candidate and enter offer designation.</div>";
                lblMsg.Visible = true;
                ScriptManager.RegisterStartupScript(this, GetType(), "reopenDrawer", "openDrawer();", true);
                return;
            }

            string title = txtOfferTitle.Text;
            string stipend = txtStipend.Text.Replace("?", "").Replace("₹", "");
            string joinDate = txtJoiningDate.Text;
            string duration = txtDuration.Text;
            string workLoc = txtWorkLocation.Text;
            string validTill = txtValidTill.Text;

            if (ViewState["id"] != null)
            {
                int offerId = Convert.ToInt32(ViewState["id"]);
                comp = new CompanyClass();
                comp.update_offer(offerId, title, stipend, joinDate, duration, workLoc, validTill);

                lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:12px 16px; border-radius:8px; margin-bottom:16px; font-weight:600;'><i class='fa-solid fa-check-circle'></i> Offer letter updated successfully!</div>";
                lblMsg.Visible = true;

                btnIssueOffer.Text = "<i class=\"fa-solid fa-paper-plane\"></i> Send Offer Letter to Student";
                ViewState["id"] = null;
                clear();
                bindOffers();
                return;
            }

            int finalAppId = Convert.ToInt32(ddlCandidate.SelectedValue);
            comp = new CompanyClass();
            comp.insert_offer(finalAppId, Session["company"].ToString(), title, stipend, joinDate, duration, workLoc, validTill);

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
            da = new SqlDataAdapter("SELECT * FROM CompanyOfferLetters WHERE OfferId=" + ViewState["id"], con);
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
                comp = new CompanyClass();
                comp.delete_offer(Convert.ToInt32(id));

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
            string st = stipendObj.ToString().Replace("?", "").Replace("₹", "");
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
    }
}

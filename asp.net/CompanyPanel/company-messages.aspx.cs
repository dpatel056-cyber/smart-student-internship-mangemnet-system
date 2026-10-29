using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_messages : System.Web.UI.Page
    {
        private ChatApiService chatApi = new ChatApiService();
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ViewState["ContactFilter"] = "all";
                ViewState["ContactSearch"] = "";

                LoadContacts();

                if (Session["CompanySelectedContactEmail"] != null)
                {
                    LoadConversation();
                }
                else
                {
                    pnlEmptyState.Visible = true;
                    pnlChatActive.Visible = false;
                }
            }
        }

        // =========================================================================
        // 1. RESOLVE COMPANY INFO FROM SESSION
        // =========================================================================
        private void ResolveCompanyInfo(out string companyEmail, out string companyName, out int companyId)
        {
            companyEmail = Session["company"] != null ? Session["company"].ToString() : "";
            companyName = "Company";
            companyId = 0;

            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("SELECT TOP 1 CompanyId, c_company, c_email FROM c_registration WHERE c_email = '" + Session["company"].ToString() + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                {
                    DataRow r = ds.Tables[0].Rows[0];
                    companyId = Convert.ToInt32(r["CompanyId"]);
                    if (r["c_company"] != DBNull.Value)
                        companyName = r["c_company"].ToString();
                    if (r["c_email"] != DBNull.Value)
                        companyEmail = r["c_email"].ToString();
                }
            }
        }

        // =========================================================================
        // 2. LOAD REGISTERED STUDENTS & ADMIN FOR COMPANY
        // =========================================================================
        private void LoadContacts()
        {
            string companyEmail, companyName;
            int companyId;
            ResolveCompanyInfo(out companyEmail, out companyName, out companyId);

            string search = ViewState["ContactSearch"] != null ? ViewState["ContactSearch"].ToString() : "";
            string filter = ViewState["ContactFilter"] != null ? ViewState["ContactFilter"].ToString() : "all";

            // 1. Fetch all contacts for count
            List<WhatsAppContact> allContacts = chatApi.GetContactsForCompany(companyEmail, "", "all");

            int totalStudents = 0;
            int totalAdmin = 0;
            foreach (var c in allContacts)
            {
                if (c.Role.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                    totalAdmin++;
                else
                    totalStudents++;
            }

            lblTotalContacts.Text = allContacts.Count + " Contacts";

            // 2. Fetch filtered contacts for display (newest messages jump to top!)
            List<WhatsAppContact> displayedContacts = chatApi.GetContactsForCompany(companyEmail, search, filter);

            rptContacts.DataSource = displayedContacts;
            rptContacts.DataBind();

            pnlNoContacts.Visible = (displayedContacts.Count == 0);
            UpdateFilterPills(allContacts.Count, totalStudents, totalAdmin);
        }

        private void UpdateFilterPills(int allCount, int stCount, int adCount)
        {
            string current = ViewState["ContactFilter"] != null ? ViewState["ContactFilter"].ToString() : "all";

            btnFilterAll.Text = "<span>All</span> <span class=\"pill-count\">" + allCount + "</span>";
            btnFilterAll.CssClass = "filter-pill" + (current.Equals("all", StringComparison.OrdinalIgnoreCase) ? " active" : "");

            btnFilterStudents.Text = "<span>Students</span> <span class=\"pill-count\">" + stCount + "</span>";
            btnFilterStudents.CssClass = "filter-pill" + (current.Equals("Student", StringComparison.OrdinalIgnoreCase) ? " active" : "");

            btnFilterAdmin.Text = "<span>Admin</span> <span class=\"pill-count\">" + adCount + "</span>";
            btnFilterAdmin.CssClass = "filter-pill" + (current.Equals("Admin", StringComparison.OrdinalIgnoreCase) ? " active" : "");
        }

        // =========================================================================
        // 3. SELECT CONTACT (STUDENT OR ADMIN)
        // =========================================================================
        protected void rptContacts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectContact")
            {
                string[] parts = e.CommandArgument.ToString().Split('|');
                if (parts.Length >= 5)
                {
                    Session["CompanySelectedContactId"] = parts[0];
                    Session["CompanySelectedContactName"] = parts[1];
                    Session["CompanySelectedContactRole"] = parts[2];
                    Session["CompanySelectedContactSubtitle"] = parts.Length > 3 ? parts[3] : "";
                    Session["CompanySelectedContactEmail"] = parts.Length > 4 ? parts[4] : "";
                    Session["CompanySelectedContactAvatar"] = parts.Length > 5 ? parts[5] : "";

                    txtMessage.Text = "";
                    lblSendError.Visible = false;

                    LoadConversation();
                    LoadContacts();
                    ScrollToBottom();
                }
            }
        }

        // =========================================================================
        // 4. LOAD CONVERSATION
        // =========================================================================
        private void LoadConversation()
        {
            if (Session["CompanySelectedContactEmail"] == null)
            {
                pnlEmptyState.Visible = true;
                pnlChatActive.Visible = false;
                return;
            }

            pnlEmptyState.Visible = false;
            pnlChatActive.Visible = true;

            int contactId = Session["CompanySelectedContactId"] != null ? Convert.ToInt32(Session["CompanySelectedContactId"]) : 1;
            string contactName = Session["CompanySelectedContactName"] != null ? Session["CompanySelectedContactName"].ToString() : "Contact";
            string contactRole = Session["CompanySelectedContactRole"] != null ? Session["CompanySelectedContactRole"].ToString() : "Student";
            string contactSub = Session["CompanySelectedContactSubtitle"] != null ? Session["CompanySelectedContactSubtitle"].ToString() : "";
            string contactEmail = Session["CompanySelectedContactEmail"] != null ? Session["CompanySelectedContactEmail"].ToString() : "";
            string contactAvatar = Session["CompanySelectedContactAvatar"] != null ? Session["CompanySelectedContactAvatar"].ToString() : "";

            string companyEmail, companyName;
            int companyId;
            ResolveCompanyInfo(out companyEmail, out companyName, out companyId);

            // Populate Active Header Details
            lblActiveName.Text = contactName;
            lblActiveRole.Text = contactRole.ToUpper();
            lblActiveRole.CssClass = "role-pill-mini " + (contactRole.Equals("Admin", StringComparison.OrdinalIgnoreCase) ? "role-ad" : "role-st");
            lblActiveSubtitle.Text = !string.IsNullOrEmpty(contactSub) ? contactSub : contactEmail;

            if (!string.IsNullOrEmpty(contactAvatar))
            {
                imgActiveAvatar.ImageUrl = contactAvatar;
                imgActiveAvatar.Visible = true;
                lblActiveAvatar.Visible = false;
            }
            else
            {
                imgActiveAvatar.Visible = false;
                lblActiveAvatar.Text = ChatApiService.GetInitials(contactName);
                lblActiveAvatar.Visible = true;
            }

            // Fetch Real Conversation from DB & DummyJSON API
            List<WhatsAppMessage> messages = chatApi.GetConversationForUser(companyEmail, "Company", contactEmail, contactName, contactRole, contactId);
            rptMessages.DataSource = messages;
            rptMessages.DataBind();
            pnlNoMessages.Visible = (messages.Count == 0);

            ScrollToBottom();
        }

        // =========================================================================
        // 5. SEND MESSAGE (CALL DUMMYJSON POST API VIA 3T METHOD + SAVE TO DB)
        // =========================================================================
        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (Session["CompanySelectedContactEmail"] == null)
            {
                lblSendError.Text = "Please select a registered student or administrator first.";
                lblSendError.Visible = true;
                return;
            }

            string text = txtMessage.Text;
            string attachUrl = "";
            string attachType = "";
            string attachName = "";

            if (fuChatAttachment != null && fuChatAttachment.HasFile)
            {
                string uploadDir = Server.MapPath("~/uploads/chat_attachments/");
                if (!System.IO.Directory.Exists(uploadDir))
                {
                    System.IO.Directory.CreateDirectory(uploadDir);
                }

                attachName = System.IO.Path.GetFileName(fuChatAttachment.FileName);
                string ext = System.IO.Path.GetExtension(attachName).ToLower();
                string savedFileName = DateTime.Now.Ticks + "_" + attachName;
                string savePath = System.IO.Path.Combine(uploadDir, savedFileName);
                fuChatAttachment.SaveAs(savePath);

                attachUrl = "~/uploads/chat_attachments/" + savedFileName;

                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif" || ext == ".webp" || ext == ".bmp")
                {
                    attachType = "image";
                }
                else if (ext == ".pdf")
                {
                    attachType = "pdf";
                }
                else if (ext == ".doc" || ext == ".docx")
                {
                    attachType = "word";
                }
                else if (ext == ".xls" || ext == ".xlsx" || ext == ".csv")
                {
                    attachType = "excel";
                }
                else
                {
                    attachType = "doc";
                }
            }

            if (string.IsNullOrEmpty(text) && string.IsNullOrEmpty(attachUrl))
            {
                lblSendError.Text = "Please enter a message or choose a photo / document.";
                lblSendError.Visible = true;
                return;
            }

            lblSendError.Visible = false;

            int contactId = Session["CompanySelectedContactId"] != null ? Convert.ToInt32(Session["CompanySelectedContactId"]) : 1;
            string contactEmail = Session["CompanySelectedContactEmail"].ToString();
            string contactName = Session["CompanySelectedContactName"] != null ? Session["CompanySelectedContactName"].ToString() : "Contact";
            string contactRole = Session["CompanySelectedContactRole"] != null ? Session["CompanySelectedContactRole"].ToString() : "Student";

            string companyEmail, companyName;
            int companyId;
            ResolveCompanyInfo(out companyEmail, out companyName, out companyId);

            string err;
            bool ok = chatApi.SendMessage("Company", companyEmail, companyName, contactRole, contactEmail, contactName, contactId, text, attachUrl, attachType, attachName, out err);

            if (ok)
            {
                txtMessage.Text = "";
                lblSendError.Visible = false;

                LoadConversation();
                LoadContacts();
                ScrollToBottom();
            }
            else
            {
                lblSendError.Text = "Error delivering message: " + err;
                lblSendError.Visible = true;
            }
        }

        // =========================================================================
        // 6. REFRESH & SEARCH / FILTER HANDLERS
        // =========================================================================
        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadContacts();
            if (Session["CompanySelectedContactEmail"] != null)
            {
                LoadConversation();
            }
            ScrollToBottom();
        }

        protected void btnSearchContact_Click(object sender, EventArgs e)
        {
            ViewState["ContactSearch"] = txtSearchContact.Text;
            LoadContacts();
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearchContact.Text = "";
            ViewState["ContactSearch"] = "";
            LoadContacts();
        }

        protected void FilterContacts_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            ViewState["ContactFilter"] = btn.CommandArgument;
            LoadContacts();
        }

        // =========================================================================
        // 7. HELPERS
        // =========================================================================
        public bool IsSelectedContact(string contactEmail)
        {
            if (Session["CompanySelectedContactEmail"] != null && !string.IsNullOrEmpty(contactEmail))
            {
                return Session["CompanySelectedContactEmail"].ToString().Equals(contactEmail, StringComparison.OrdinalIgnoreCase);
            }
            return false;
        }

        public string GetFilterClass(string filterName)
        {
            string current = ViewState["ContactFilter"] != null ? ViewState["ContactFilter"].ToString() : "all";
            return "filter-pill" + (current.Equals(filterName, StringComparison.OrdinalIgnoreCase) ? " active" : "");
        }

        public string RenderAttachment(object urlObj, object typeObj, object nameObj)
        {
            if (urlObj == null || urlObj == DBNull.Value || string.IsNullOrEmpty(urlObj.ToString()))
                return "";

            string rawUrl = urlObj.ToString();
            string url = rawUrl;
            if (rawUrl.StartsWith("~/"))
            {
                url = ResolveUrl(rawUrl);
            }

            string type = typeObj != null && typeObj != DBNull.Value ? typeObj.ToString().ToLower() : "doc";
            string name = nameObj != null && nameObj != DBNull.Value && !string.IsNullOrEmpty(nameObj.ToString())
                ? nameObj.ToString()
                : "Attachment";

            string encodedName = System.Web.HttpUtility.HtmlEncode(name);

            if (type == "image")
            {
                return string.Format(@"<div class=""chat-media-image-wrap"">
                    <a href=""{0}"" target=""_blank"" class=""chat-media-link"">
                        <img src=""{0}"" class=""chat-media-img"" alt=""{1}"" />
                    </a>
                </div>", url, encodedName);
            }

            string iconClass = "fa-solid fa-file-pdf";
            string boxClass = "doc-icon-box doc-pdf";
            string typeLabel = "PDF Document";

            if (type == "word")
            {
                iconClass = "fa-solid fa-file-word";
                boxClass = "doc-icon-box doc-word";
                typeLabel = "Word Document";
            }
            else if (type == "excel")
            {
                iconClass = "fa-solid fa-file-excel";
                boxClass = "doc-icon-box doc-excel";
                typeLabel = "Spreadsheet";
            }
            else if (type == "doc")
            {
                iconClass = "fa-solid fa-file-lines";
                boxClass = "doc-icon-box doc-generic";
                typeLabel = "Document";
            }

            return string.Format(@"<a href=""{0}"" target=""_blank"" download class=""chat-media-doc-card"">
                <div class=""{1}"">
                    <i class=""{2}""></i>
                </div>
                <div class=""doc-info"">
                    <span class=""doc-name"">{3}</span>
                    <span class=""doc-meta"">{4} &bull; Download</span>
                </div>
                <div class=""doc-download-icon"">
                    <i class=""fa-solid fa-circle-down""></i>
                </div>
            </a>", url, boxClass, iconClass, encodedName, typeLabel);
        }

        private void ScrollToBottom()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ScrollChatBottom", "var el = document.getElementById('chatMessagesScroll'); if (el) { setTimeout(function(){ el.scrollTop = el.scrollHeight; }, 60); }", true);
        }
    }
}

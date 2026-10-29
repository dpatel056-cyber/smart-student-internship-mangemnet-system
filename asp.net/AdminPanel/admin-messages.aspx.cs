using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using asp.net;
namespace asp.net.css
{
    public partial class admin_messages : System.Web.UI.Page
    {
        private ChatApiService chatApi = new ChatApiService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ViewState["ContactFilter"] = "all";
                ViewState["ContactSearch"] = "";
                LoadContacts();
                if (Session["SelectedContactEmail"] != null)
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
        // 1. LOAD REGISTERED STUDENTS & COMPANIES (SYNCED WITH SQL DB)
        // =========================================================================
        private void LoadContacts()
        {
            string search = ViewState["ContactSearch"] != null ? ViewState["ContactSearch"].ToString() : "";
            string filter = ViewState["ContactFilter"] != null ? ViewState["ContactFilter"].ToString() : "all";
            string adminEmail = GetAdminEmail();

            // 1. Fetch total counts across all registered students & companies
            List<WhatsAppContact> allContacts = chatApi.GetRegisteredContacts("", "all", adminEmail);
            int totalStudents = 0;
            int totalCompanies = 0;
            foreach (var c in allContacts)
            {
                if (c.Role.Equals("Student", StringComparison.OrdinalIgnoreCase))
                    totalStudents++;
                else
                    totalCompanies++;
            }

            lblTotalContacts.Text = allContacts.Count + " Contacts";

            // 2. Fetch filtered contacts for display (already sorted WhatsApp-style with newest messages at the top!)
            List<WhatsAppContact> displayedContacts = chatApi.GetRegisteredContacts(search, filter, adminEmail);
            rptContacts.DataSource = displayedContacts;
            rptContacts.DataBind();
            pnlNoContacts.Visible = (displayedContacts.Count == 0);
            UpdateFilterPills(allContacts.Count, totalStudents, totalCompanies);
        }

        private void UpdateFilterPills(int allCount, int stCount, int coCount)
        {
            string current = ViewState["ContactFilter"] != null ? ViewState["ContactFilter"].ToString() : "all";
            btnFilterAll.Text = "<span>All</span> <span class=\"pill-count\">" + allCount + "</span>";
            btnFilterAll.CssClass = "filter-pill" + (current.Equals("all", StringComparison.OrdinalIgnoreCase) ? " active" : "");
            btnFilterStudents.Text = "<span>Students</span> <span class=\"pill-count\">" + stCount + "</span>";
            btnFilterStudents.CssClass = "filter-pill" + (current.Equals("Student", StringComparison.OrdinalIgnoreCase) ? " active" : "");
            btnFilterCompanies.Text = "<span>Companies</span> <span class=\"pill-count\">" + coCount + "</span>";
            btnFilterCompanies.CssClass = "filter-pill" + (current.Equals("Company", StringComparison.OrdinalIgnoreCase) ? " active" : "");
        }

        // =========================================================================
        // 2. SELECT CONTACT (STUDENT OR COMPANY)
        // =========================================================================
        protected void rptContacts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectContact")
            {
                string[] parts = e.CommandArgument.ToString().Split('|');
                if (parts.Length >= 5)
                {
                    Session["SelectedContactId"] = parts[0];
                    Session["SelectedContactName"] = parts[1];
                    Session["SelectedContactRole"] = parts[2];
                    Session["SelectedContactSubtitle"] = parts.Length > 3 ? parts[3] : "";
                    Session["SelectedContactEmail"] = parts.Length > 4 ? parts[4] : "";
                    Session["SelectedContactAvatar"] = parts.Length > 5 ? parts[5] : "";
                    txtMessage.Text = "";
                    lblSendError.Visible = false;
                    LoadConversation();
                    LoadContacts();
                    ScrollToBottom();
                }
            }
        }

        // =========================================================================
        // 3. LOAD CHAT CONVERSATION FOR SELECTED REGISTERED CONTACT
        // =========================================================================
        private void LoadConversation()
        {
            if (Session["SelectedContactEmail"] == null)
            {
                pnlEmptyState.Visible = true;
                pnlChatActive.Visible = false;
                return;
            }

            pnlEmptyState.Visible = false;
            pnlChatActive.Visible = true;
            int contactId = Session["SelectedContactId"] != null ? Convert.ToInt32(Session["SelectedContactId"]) : 1;
            string contactName = Session["SelectedContactName"] != null ? Session["SelectedContactName"].ToString() : "User";
            string contactRole = Session["SelectedContactRole"] != null ? Session["SelectedContactRole"].ToString() : "Student";
            string contactSub = Session["SelectedContactSubtitle"] != null ? Session["SelectedContactSubtitle"].ToString() : "";
            string contactEmail = Session["SelectedContactEmail"] != null ? Session["SelectedContactEmail"].ToString() : "";
            string contactAvatar = Session["SelectedContactAvatar"] != null ? Session["SelectedContactAvatar"].ToString() : "";
            string adminEmail = GetAdminEmail();

            // Populate Active Header Details
            lblActiveName.Text = contactName;
            lblActiveRole.Text = contactRole.ToUpper();
            lblActiveRole.CssClass = "role-pill-mini " + (contactRole.Equals("Student", StringComparison.OrdinalIgnoreCase) ? "role-st" : "role-co");
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
                lblActiveAvatar.CssClass = "contact-avatar " + (contactRole.Equals("Student", StringComparison.OrdinalIgnoreCase) ? "avatar-student" : "avatar-company");
                lblActiveAvatar.Visible = true;
            }

            // Fetch Real Conversation from DB & DummyJSON API using 3T method
            List<WhatsAppMessage> messages = chatApi.GetConversation(contactEmail, contactName, contactRole, contactId, adminEmail);
            rptMessages.DataSource = messages;
            rptMessages.DataBind();
            pnlNoMessages.Visible = (messages.Count == 0);
            ScrollToBottom();
        }

        // =========================================================================
        // 4. SEND MESSAGE (CALL DUMMYJSON POST API VIA 3T METHOD + SAVE TO DB)
        // =========================================================================
        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (Session["SelectedContactEmail"] == null)
            {
                lblSendError.Text = "Please select a registered student or company first.";
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
            int contactId = Session["SelectedContactId"] != null ? Convert.ToInt32(Session["SelectedContactId"]) : 1;
            string contactEmail = Session["SelectedContactEmail"].ToString();
            string contactName = Session["SelectedContactName"] != null ? Session["SelectedContactName"].ToString() : "User";
            string contactRole = Session["SelectedContactRole"] != null ? Session["SelectedContactRole"].ToString() : "Student";
            string adminEmail = GetAdminEmail();
            string err;
            bool ok = chatApi.SendMessage(contactId, contactEmail, contactName, contactRole, adminEmail, text, attachUrl, attachType, attachName, out err);
            if (ok)
            {
                txtMessage.Text = "";
                LoadConversation();
                LoadContacts(); // Re-sorts contacts so the messaged contact immediately jumps to position 0 at top!
                ScrollToBottom();
            }
            else
            {
                lblSendError.Text = err;
                lblSendError.Visible = true;
            }
        }

        // =========================================================================
        // 5. REFRESH & SEARCH / FILTER HANDLERS
        // =========================================================================
        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadContacts();
            if (Session["SelectedContactEmail"] != null)
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
        // 6. HELPERS
        // =========================================================================
        private string GetAdminEmail()
        {
            if (Session["admin"] != null && !string.IsNullOrWhiteSpace(Session["admin"].ToString()))
            {
                return Session["admin"].ToString();
            }
            return "admin@sims.com";
        }

        public bool IsSelectedContact(string contactEmail)
        {
            if (Session["SelectedContactEmail"] != null && !string.IsNullOrEmpty(contactEmail))
            {
                return Session["SelectedContactEmail"].ToString().Equals(contactEmail, StringComparison.OrdinalIgnoreCase);
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

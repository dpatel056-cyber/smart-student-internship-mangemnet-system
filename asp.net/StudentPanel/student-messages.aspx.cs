using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_messages : System.Web.UI.Page
    {
        private ChatApiService chatApi = new ChatApiService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ViewState["ContactFilter"] = "all";
                ViewState["ContactSearch"] = "";

                LoadContacts();

                if (Session["StudentSelectedContactEmail"] != null)
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
        // 1. RESOLVE STUDENT INFO FROM SESSION
        // =========================================================================
        private void ResolveStudentInfo(out string studentEmail, out string studentName, out int studentId)
        {
            studentEmail = "";
            studentName = "Student";
            studentId = 0;

            if (Session["student"] == null) return;
            string sVal = Session["student"].ToString().Trim();

            string cs = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    string q = "SELECT TOP 1 StudentId, FullName, Email FROM Students WHERE Email = '" + sVal + "' OR EnrollmentNo = '" + sVal + "'";
                    SqlDataAdapter da = new SqlDataAdapter(q, con);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
                    {
                        DataRow r = ds.Tables[0].Rows[0];
                        studentId = Convert.ToInt32(r["StudentId"]);
                        studentName = r["FullName"] != DBNull.Value ? r["FullName"].ToString().Trim() : "Student";
                        studentEmail = r["Email"] != DBNull.Value ? r["Email"].ToString().Trim() : sVal;
                    }
                }
            }
            catch { }

            if (string.IsNullOrEmpty(studentEmail))
            {
                studentEmail = sVal;
            }
        }

        // =========================================================================
        // 2. LOAD REGISTERED COMPANIES & ADMIN FOR STUDENT
        // =========================================================================
        private void LoadContacts()
        {
            string studentEmail, studentName;
            int studentId;
            ResolveStudentInfo(out studentEmail, out studentName, out studentId);

            string search = ViewState["ContactSearch"] != null ? ViewState["ContactSearch"].ToString().Trim() : "";
            string filter = ViewState["ContactFilter"] != null ? ViewState["ContactFilter"].ToString().Trim() : "all";

            // 1. Fetch all contacts for count
            List<WhatsAppContact> allContacts = chatApi.GetContactsForStudent(studentEmail, "", "all");

            int totalCompanies = 0;
            int totalAdmin = 0;
            foreach (var c in allContacts)
            {
                if (c.Role.Equals("Admin", StringComparison.OrdinalIgnoreCase))
                    totalAdmin++;
                else
                    totalCompanies++;
            }

            lblTotalContacts.Text = allContacts.Count + " Contacts";

            // 2. Fetch filtered contacts for display (newest messages jump to top!)
            List<WhatsAppContact> displayedContacts = chatApi.GetContactsForStudent(studentEmail, search, filter);

            rptContacts.DataSource = displayedContacts;
            rptContacts.DataBind();

            pnlNoContacts.Visible = (displayedContacts.Count == 0);
            UpdateFilterPills(allContacts.Count, totalCompanies, totalAdmin);
        }

        private void UpdateFilterPills(int allCount, int coCount, int adCount)
        {
            string current = ViewState["ContactFilter"] != null ? ViewState["ContactFilter"].ToString() : "all";

            btnFilterAll.Text = "<span>All</span> <span class=\"pill-count\">" + allCount + "</span>";
            btnFilterAll.CssClass = "filter-pill" + (current.Equals("all", StringComparison.OrdinalIgnoreCase) ? " active" : "");

            btnFilterCompanies.Text = "<span>Companies</span> <span class=\"pill-count\">" + coCount + "</span>";
            btnFilterCompanies.CssClass = "filter-pill" + (current.Equals("Company", StringComparison.OrdinalIgnoreCase) ? " active" : "");

            btnFilterAdmin.Text = "<span>Admin</span> <span class=\"pill-count\">" + adCount + "</span>";
            btnFilterAdmin.CssClass = "filter-pill" + (current.Equals("Admin", StringComparison.OrdinalIgnoreCase) ? " active" : "");
        }

        // =========================================================================
        // 3. SELECT CONTACT (COMPANY OR ADMIN)
        // =========================================================================
        protected void rptContacts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectContact")
            {
                string[] parts = e.CommandArgument.ToString().Split('|');
                if (parts.Length >= 5)
                {
                    Session["StudentSelectedContactId"] = parts[0];
                    Session["StudentSelectedContactName"] = parts[1];
                    Session["StudentSelectedContactRole"] = parts[2];
                    Session["StudentSelectedContactSubtitle"] = parts.Length > 3 ? parts[3] : "";
                    Session["StudentSelectedContactEmail"] = parts.Length > 4 ? parts[4] : "";
                    Session["StudentSelectedContactAvatar"] = parts.Length > 5 ? parts[5] : "";

                    txtMessage.Text = "";
                    lblSendError.Visible = false;

                    LoadConversation();
                    LoadContacts(); // Re-bind so unread count updates and badge disappears!
                    ScrollToBottom();
                }
            }
        }

        // =========================================================================
        // 4. LOAD CONVERSATION
        // =========================================================================
        private void LoadConversation()
        {
            if (Session["StudentSelectedContactEmail"] == null)
            {
                pnlEmptyState.Visible = true;
                pnlChatActive.Visible = false;
                return;
            }

            pnlEmptyState.Visible = false;
            pnlChatActive.Visible = true;

            int contactId = Session["StudentSelectedContactId"] != null ? Convert.ToInt32(Session["StudentSelectedContactId"]) : 1;
            string contactName = Session["StudentSelectedContactName"] != null ? Session["StudentSelectedContactName"].ToString().Trim() : "Contact";
            string contactRole = Session["StudentSelectedContactRole"] != null ? Session["StudentSelectedContactRole"].ToString().Trim() : "Company";
            string contactSub = Session["StudentSelectedContactSubtitle"] != null ? Session["StudentSelectedContactSubtitle"].ToString().Trim() : "";
            string contactEmail = Session["StudentSelectedContactEmail"] != null ? Session["StudentSelectedContactEmail"].ToString().Trim() : "";
            string contactAvatar = Session["StudentSelectedContactAvatar"] != null ? Session["StudentSelectedContactAvatar"].ToString().Trim() : "";

            string studentEmail, studentName;
            int studentId;
            ResolveStudentInfo(out studentEmail, out studentName, out studentId);

            // Populate Active Header Details
            lblActiveName.Text = contactName;
            lblActiveRole.Text = contactRole.ToUpper();
            lblActiveRole.CssClass = "role-pill-mini " + (contactRole.Equals("Admin", StringComparison.OrdinalIgnoreCase) ? "role-ad" : "role-co");
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
                lblActiveAvatar.CssClass = "contact-avatar " + (contactRole.Equals("Admin", StringComparison.OrdinalIgnoreCase) ? "avatar-admin" : "avatar-company");
                lblActiveAvatar.Visible = true;
            }

            // Fetch Real Conversation from DB & DummyJSON API using 3T method (Marks messages as read in DB!)
            List<WhatsAppMessage> messages = chatApi.GetConversationForUser(studentEmail, "Student", contactEmail, contactName, contactRole, contactId);

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
            if (Session["StudentSelectedContactEmail"] == null)
            {
                lblSendError.Text = "Please select a company or admin contact first.";
                lblSendError.Visible = true;
                return;
            }

            string text = txtMessage.Text.Trim();
            string attachUrl = "";
            string attachType = "";
            string attachName = "";

            if (fuChatAttachment != null && fuChatAttachment.HasFile)
            {
                try
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
                catch (Exception ex)
                {
                    lblSendError.Text = "Could not upload attachment: " + ex.Message;
                    lblSendError.Visible = true;
                    return;
                }
            }

            if (string.IsNullOrEmpty(text) && string.IsNullOrEmpty(attachUrl))
            {
                lblSendError.Text = "Please enter a message or choose a photo / document.";
                lblSendError.Visible = true;
                return;
            }

            lblSendError.Visible = false;

            int contactId = Session["StudentSelectedContactId"] != null ? Convert.ToInt32(Session["StudentSelectedContactId"]) : 1;
            string contactEmail = Session["StudentSelectedContactEmail"].ToString().Trim();
            string contactName = Session["StudentSelectedContactName"] != null ? Session["StudentSelectedContactName"].ToString().Trim() : "Contact";
            string contactRole = Session["StudentSelectedContactRole"] != null ? Session["StudentSelectedContactRole"].ToString().Trim() : "Company";

            string studentEmail, studentName;
            int studentId;
            ResolveStudentInfo(out studentEmail, out studentName, out studentId);

            string err;
            bool ok = chatApi.SendMessage("Student", studentEmail, studentName, contactRole, contactEmail, contactName, contactId, text, attachUrl, attachType, attachName, out err);

            if (ok)
            {
                txtMessage.Text = "";
                LoadConversation();
                LoadContacts(); // Contact jumps to top
                ScrollToBottom();
            }
            else
            {
                lblSendError.Text = err;
                lblSendError.Visible = true;
            }
        }

        // =========================================================================
        // 6. REFRESH & SEARCH / FILTER HANDLERS
        // =========================================================================
        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadContacts();
            if (Session["StudentSelectedContactEmail"] != null)
            {
                LoadConversation();
            }
            ScrollToBottom();
        }

        protected void btnSearchContact_Click(object sender, EventArgs e)
        {
            ViewState["ContactSearch"] = txtSearchContact.Text.Trim();
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
            if (Session["StudentSelectedContactEmail"] != null && !string.IsNullOrEmpty(contactEmail))
            {
                return Session["StudentSelectedContactEmail"].ToString().Trim().Equals(contactEmail.Trim(), StringComparison.OrdinalIgnoreCase);
            }
            return false;
        }

        public string RenderAttachment(object urlObj, object typeObj, object nameObj)
        {
            if (urlObj == null || urlObj == DBNull.Value || string.IsNullOrEmpty(urlObj.ToString().Trim()))
                return "";

            string rawUrl = urlObj.ToString().Trim();
            string url = rawUrl;
            try
            {
                if (rawUrl.StartsWith("~/"))
                {
                    url = ResolveUrl(rawUrl);
                }
            }
            catch
            {
                url = rawUrl.StartsWith("~/") ? rawUrl.Substring(1) : rawUrl;
            }

            string type = typeObj != null && typeObj != DBNull.Value ? typeObj.ToString().Trim().ToLower() : "doc";
            string name = nameObj != null && nameObj != DBNull.Value && !string.IsNullOrEmpty(nameObj.ToString().Trim())
                ? nameObj.ToString().Trim()
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

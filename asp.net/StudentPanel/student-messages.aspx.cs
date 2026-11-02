using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_messages : System.Web.UI.Page
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

        void ResolveStudentInfo(out string studentEmail, out string studentName, out int studentId)
        {
            studentEmail = "";
            studentName = "Student";
            studentId = 0;

            if (Session["student"] == null) return;
            string sVal = Session["student"].ToString();

            getcon();
            da = new SqlDataAdapter("SELECT TOP 1 StudentId, FullName, Email FROM Students WHERE Email = '" + sVal + "' OR EnrollmentNo = '" + sVal + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                studentId = Convert.ToInt32(ds.Tables[0].Rows[0]["StudentId"]);
                studentName = ds.Tables[0].Rows[0]["FullName"].ToString();
                studentEmail = ds.Tables[0].Rows[0]["Email"].ToString();
            }

            if (studentEmail == "")
                studentEmail = sVal;
        }

        void LoadContacts()
        {
            string studentEmail, studentName;
            int studentId;
            ResolveStudentInfo(out studentEmail, out studentName, out studentId);

            string search = ViewState["ContactSearch"] != null ? ViewState["ContactSearch"].ToString() : "";
            string filter = ViewState["ContactFilter"] != null ? ViewState["ContactFilter"].ToString() : "all";

            DataTable dt = new DataTable();
            dt.Columns.Add("Id");
            dt.Columns.Add("Name");
            dt.Columns.Add("Role");
            dt.Columns.Add("Subtitle");
            dt.Columns.Add("Email");
            dt.Columns.Add("AvatarUrl");
            dt.Columns.Add("Initials");
            dt.Columns.Add("LastTime");
            dt.Columns.Add("LastMessage");
            dt.Columns.Add("UnreadCount", typeof(int));

            getcon();

            // 1. Admin Contact
            if (filter == "all" || filter == "Admin")
            {
                if (search == "" || "Platform Administrator".ToLower().Contains(search.ToLower()) || "admin@sims.com".Contains(search.ToLower()))
                {
                    DataRow rAdmin = dt.NewRow();
                    rAdmin["Id"] = "999999";
                    rAdmin["Name"] = "Platform Administrator";
                    rAdmin["Role"] = "Admin";
                    rAdmin["Subtitle"] = "SIMS Support & Official Administration";
                    rAdmin["Email"] = "admin@sims.com";
                    rAdmin["AvatarUrl"] = "";
                    rAdmin["Initials"] = "AD";
                    rAdmin["LastTime"] = "";
                    rAdmin["LastMessage"] = "Start a conversation";
                    rAdmin["UnreadCount"] = 0;
                    dt.Rows.Add(rAdmin);
                }
            }

            // 2. Companies
            if (filter == "all" || filter == "Company")
            {
                string q = "SELECT CompanyId, c_company, c_email, c_industry, c_city, c_logo FROM c_registration";
                if (search != "")
                {
                    q += " WHERE c_company LIKE '%" + search + "%' OR c_email LIKE '%" + search + "%' OR c_industry LIKE '%" + search + "%' OR c_city LIKE '%" + search + "%'";
                }
                q += " ORDER BY c_company ASC";

                da = new SqlDataAdapter(q, con);
                DataSet dsCo = new DataSet();
                da.Fill(dsCo);

                for (int i = 0; i < dsCo.Tables[0].Rows.Count; i++)
                {
                    DataRow dr = dsCo.Tables[0].Rows[i];
                    DataRow row = dt.NewRow();
                    row["Id"] = dr["CompanyId"].ToString();
                    row["Name"] = dr["c_company"].ToString();
                    row["Role"] = "Company";
                    row["Subtitle"] = dr["c_industry"].ToString() + " · " + dr["c_city"].ToString();
                    row["Email"] = dr["c_email"].ToString();

                    string logo = dr["c_logo"].ToString();
                    if (logo != "")
                    {
                        if (logo.StartsWith("~/"))
                            row["AvatarUrl"] = ResolveUrl(logo);
                        else
                            row["AvatarUrl"] = ResolveUrl("~/compnay_images/" + logo);
                    }
                    else
                    {
                        row["AvatarUrl"] = "";
                    }

                    string comp = dr["c_company"].ToString();
                    row["Initials"] = comp.Length > 0 ? comp.Substring(0, 1).ToUpper() : "C";
                    row["LastMessage"] = "Start a conversation";
                    row["LastTime"] = "";
                    row["UnreadCount"] = 0;

                    dt.Rows.Add(row);
                }
            }

            // 3. For each contact, get latest message and unread count
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string cEmail = dt.Rows[i]["Email"].ToString();
                string cRole = dt.Rows[i]["Role"].ToString();

                if (cEmail != "")
                {
                    da = new SqlDataAdapter("SELECT TOP 1 MessageText, SentAt, AttachmentType, AttachmentName FROM ChatMessages WHERE (((SenderEmail = '" + cEmail + "' OR (SenderRole = 'Admin' AND '" + cRole + "' = 'Admin')) AND ReceiverEmail = '" + studentEmail + "') OR (SenderEmail = '" + studentEmail + "' AND (ReceiverEmail = '" + cEmail + "' OR (ReceiverRole = 'Admin' AND '" + cRole + "' = 'Admin')))) ORDER BY MessageId DESC", con);
                    DataSet dsLast = new DataSet();
                    da.Fill(dsLast);
                    if (dsLast.Tables[0].Rows.Count > 0)
                    {
                        string msg = dsLast.Tables[0].Rows[0]["MessageText"].ToString();
                        string aType = dsLast.Tables[0].Rows[0]["AttachmentType"].ToString();
                        string aName = dsLast.Tables[0].Rows[0]["AttachmentName"].ToString();

                        if (msg != "")
                        {
                            dt.Rows[i]["LastMessage"] = msg;
                        }
                        else if (aType != "")
                        {
                            if (aType == "image") dt.Rows[i]["LastMessage"] = "📷 Photo";
                            else if (aType == "pdf") dt.Rows[i]["LastMessage"] = "📄 " + (aName != "" ? aName : "PDF Document");
                            else dt.Rows[i]["LastMessage"] = "📎 " + (aName != "" ? aName : "Document");
                        }

                        DateTime dtMsg = Convert.ToDateTime(dsLast.Tables[0].Rows[0]["SentAt"]);
                        if (dtMsg.Date == DateTime.Today)
                            dt.Rows[i]["LastTime"] = dtMsg.ToString("hh:mm tt");
                        else
                            dt.Rows[i]["LastTime"] = dtMsg.ToString("dd MMM");
                    }

                    da = new SqlDataAdapter("SELECT COUNT(*) FROM ChatMessages WHERE ((SenderEmail = '" + cEmail + "') OR (SenderRole = 'Admin' AND '" + cRole + "' = 'Admin')) AND ReceiverEmail = '" + studentEmail + "' AND IsRead = 0", con);
                    DataSet dsUnread = new DataSet();
                    da.Fill(dsUnread);
                    if (dsUnread.Tables[0].Rows.Count > 0)
                    {
                        dt.Rows[i]["UnreadCount"] = Convert.ToInt32(dsUnread.Tables[0].Rows[0][0]);
                    }
                }
            }

            // Total counts for pills
            da = new SqlDataAdapter("SELECT COUNT(*) FROM c_registration", con);
            DataSet dsTotalCo = new DataSet();
            da.Fill(dsTotalCo);
            int totalCompanies = Convert.ToInt32(dsTotalCo.Tables[0].Rows[0][0]);
            int totalAdmin = 1;
            int totalContacts = totalCompanies + totalAdmin;

            lblTotalContacts.Text = totalContacts.ToString() + " Contacts";

            dlContacts.DataSource = dt;
            dlContacts.DataBind();

            if (dt.Rows.Count == 0)
                pnlNoContacts.Visible = true;
            else
                pnlNoContacts.Visible = false;

            UpdateFilterPills(totalContacts, totalCompanies, totalAdmin);
        }

        void UpdateFilterPills(int allCount, int coCount, int adCount)
        {
            string current = ViewState["ContactFilter"] != null ? ViewState["ContactFilter"].ToString() : "all";

            btnFilterAll.Text = "<span>All</span> <span class=\"pill-count\">" + allCount + "</span>";
            btnFilterAll.CssClass = "filter-pill" + (current == "all" ? " active" : "");

            btnFilterCompanies.Text = "<span>Companies</span> <span class=\"pill-count\">" + coCount + "</span>";
            btnFilterCompanies.CssClass = "filter-pill" + (current == "Company" ? " active" : "");

            btnFilterAdmin.Text = "<span>Admin</span> <span class=\"pill-count\">" + adCount + "</span>";
            btnFilterAdmin.CssClass = "filter-pill" + (current == "Admin" ? " active" : "");
        }

        protected void dlContacts_ItemCommand(object source, DataListCommandEventArgs e)
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
                    LoadContacts();
                    ScrollToBottom();
                }
            }
        }

        void LoadConversation()
        {
            if (Session["StudentSelectedContactEmail"] == null)
            {
                pnlEmptyState.Visible = true;
                pnlChatActive.Visible = false;
                return;
            }

            pnlEmptyState.Visible = false;
            pnlChatActive.Visible = true;

            string contactName = Session["StudentSelectedContactName"] != null ? Session["StudentSelectedContactName"].ToString() : "";
            string contactRole = Session["StudentSelectedContactRole"] != null ? Session["StudentSelectedContactRole"].ToString() : "";
            string contactSub = Session["StudentSelectedContactSubtitle"] != null ? Session["StudentSelectedContactSubtitle"].ToString() : "";
            string contactEmail = Session["StudentSelectedContactEmail"] != null ? Session["StudentSelectedContactEmail"].ToString() : "";
            string contactAvatar = Session["StudentSelectedContactAvatar"] != null ? Session["StudentSelectedContactAvatar"].ToString() : "";

            string studentEmail, studentName;
            int studentId;
            ResolveStudentInfo(out studentEmail, out studentName, out studentId);

            lblActiveName.Text = contactName;
            lblActiveRole.Text = contactRole.ToUpper();
            if (contactRole == "Admin")
                lblActiveRole.CssClass = "role-pill-mini role-ad";
            else
                lblActiveRole.CssClass = "role-pill-mini role-co";

            lblActiveSubtitle.Text = contactSub != "" ? contactSub : contactEmail;

            if (contactAvatar != "")
            {
                imgActiveAvatar.ImageUrl = contactAvatar;
                imgActiveAvatar.Visible = true;
                lblActiveAvatar.Visible = false;
            }
            else
            {
                imgActiveAvatar.Visible = false;
                lblActiveAvatar.Text = contactName.Length > 0 ? contactName.Substring(0, 1).ToUpper() : "C";
                if (contactRole == "Admin")
                    lblActiveAvatar.CssClass = "contact-avatar avatar-admin";
                else
                    lblActiveAvatar.CssClass = "contact-avatar avatar-company";
                lblActiveAvatar.Visible = true;
            }

            getcon();

            // 1. Mark unread messages as read
            cmd = new SqlCommand("UPDATE ChatMessages SET IsRead = 1 WHERE ((SenderEmail = '" + contactEmail + "') OR (SenderRole = 'Admin' AND '" + contactRole + "' = 'Admin')) AND ReceiverEmail = '" + studentEmail + "' AND IsRead = 0", con);
            cmd.ExecuteNonQuery();

            // 2. Load conversation into DataTable
            da = new SqlDataAdapter("SELECT MessageId, SenderRole, SenderName, SenderEmail, ReceiverRole, ReceiverEmail, MessageText, SentAt, IsRead, AttachmentUrl, AttachmentType, AttachmentName FROM ChatMessages WHERE (((SenderEmail = '" + contactEmail + "' OR (SenderRole = 'Admin' AND '" + contactRole + "' = 'Admin')) AND ReceiverEmail = '" + studentEmail + "') OR (SenderEmail = '" + studentEmail + "' AND (ReceiverEmail = '" + contactEmail + "' OR (ReceiverRole = 'Admin' AND '" + contactRole + "' = 'Admin')))) ORDER BY MessageId ASC", con);
            DataSet dsMsg = new DataSet();
            da.Fill(dsMsg);

            DataTable dtMsg = new DataTable();
            dtMsg.Columns.Add("MessageId");
            dtMsg.Columns.Add("SenderName");
            dtMsg.Columns.Add("SenderRole");
            dtMsg.Columns.Add("MessageText");
            dtMsg.Columns.Add("SentTime");
            dtMsg.Columns.Add("IsOutgoing", typeof(bool));
            dtMsg.Columns.Add("AttachmentUrl");
            dtMsg.Columns.Add("AttachmentType");
            dtMsg.Columns.Add("AttachmentName");

            for (int i = 0; i < dsMsg.Tables[0].Rows.Count; i++)
            {
                DataRow dr = dsMsg.Tables[0].Rows[i];
                DataRow row = dtMsg.NewRow();
                row["MessageId"] = dr["MessageId"].ToString();

                string sEmail = dr["SenderEmail"].ToString();
                bool isOut = (sEmail == studentEmail);

                row["IsOutgoing"] = isOut;
                row["SenderName"] = isOut ? "You" : dr["SenderName"].ToString();
                row["SenderRole"] = dr["SenderRole"].ToString();
                row["MessageText"] = dr["MessageText"].ToString();

                if (dr["SentAt"] != DBNull.Value)
                {
                    DateTime dtTime = Convert.ToDateTime(dr["SentAt"]);
                    if (dtTime.Date == DateTime.Today)
                        row["SentTime"] = dtTime.ToString("hh:mm tt");
                    else
                        row["SentTime"] = dtTime.ToString("dd MMM, hh:mm tt");
                }
                else
                {
                    row["SentTime"] = "Just now";
                }

                row["AttachmentUrl"] = dr["AttachmentUrl"].ToString();
                row["AttachmentType"] = dr["AttachmentType"].ToString();
                row["AttachmentName"] = dr["AttachmentName"].ToString();

                dtMsg.Rows.Add(row);
            }

            dlMessages.DataSource = dtMsg;
            dlMessages.DataBind();

            if (dtMsg.Rows.Count == 0)
                pnlNoMessages.Visible = true;
            else
                pnlNoMessages.Visible = false;

            ScrollToBottom();
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (Session["StudentSelectedContactEmail"] == null)
            {
                lblSendError.Text = "Please select a contact first.";
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
                fuChatAttachment.SaveAs(System.IO.Path.Combine(uploadDir, savedFileName));

                attachUrl = "~/uploads/chat_attachments/" + savedFileName;

                if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif")
                    attachType = "image";
                else if (ext == ".pdf")
                    attachType = "pdf";
                else if (ext == ".doc" || ext == ".docx")
                    attachType = "word";
                else if (ext == ".xls" || ext == ".xlsx")
                    attachType = "excel";
                else
                    attachType = "doc";
            }

            if (text == "" && attachUrl == "")
            {
                lblSendError.Text = "Please enter a message or choose an attachment.";
                lblSendError.Visible = true;
                return;
            }

            lblSendError.Visible = false;

            string contactEmail = Session["StudentSelectedContactEmail"].ToString();
            string contactName = Session["StudentSelectedContactName"] != null ? Session["StudentSelectedContactName"].ToString() : "Contact";
            string contactRole = Session["StudentSelectedContactRole"] != null ? Session["StudentSelectedContactRole"].ToString() : "Company";

            string studentEmail, studentName;
            int studentId;
            ResolveStudentInfo(out studentEmail, out studentName, out studentId);

            getcon();
            cmd = new SqlCommand("INSERT INTO ChatMessages(SenderRole, SenderEmail, SenderName, ReceiverRole, ReceiverEmail, ReceiverName, MessageText, IsRead, SentAt, AttachmentUrl, AttachmentType, AttachmentName) VALUES('Student', '" + studentEmail + "', '" + studentName + "', '" + contactRole + "', '" + contactEmail + "', '" + contactName + "', '" + text + "', 0, GETDATE(), '" + attachUrl + "', '" + attachType + "', '" + attachName + "')", con);
            cmd.ExecuteNonQuery();

            txtMessage.Text = "";
            LoadConversation();
            LoadContacts();
            ScrollToBottom();
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadContacts();
            if (Session["StudentSelectedContactEmail"] != null)
            {
                LoadConversation();
            }
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

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            LinkButton btn = sender as LinkButton;
            if (btn != null)
            {
                ViewState["ContactFilter"] = btn.CommandArgument;
                LoadContacts();
            }
        }

        public bool IsSelectedContact(string contactEmail)
        {
            if (Session["StudentSelectedContactEmail"] != null)
            {
                return Session["StudentSelectedContactEmail"].ToString() == contactEmail;
            }
            return false;
        }

        public string RenderAttachment(object urlObj, object typeObj, object nameObj)
        {
            if (urlObj == null || urlObj == DBNull.Value || urlObj.ToString() == "")
            {
                return "";
            }

            string rawUrl = urlObj.ToString();
            string url = ResolveUrl(rawUrl);
            string type = typeObj != null ? typeObj.ToString().ToLower() : "doc";
            string name = nameObj != null && nameObj.ToString() != "" ? nameObj.ToString() : "Attachment";

            if (type == "image")
            {
                return "<div class=\"chat-media-image-wrap\"><a href=\"" + url + "\" target=\"_blank\" class=\"chat-media-link\"><img src=\"" + url + "\" class=\"chat-media-img\" alt=\"" + name + "\" /></a></div>";
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

            return "<a href=\"" + url + "\" target=\"_blank\" download class=\"chat-media-doc-card\"><div class=\"" + boxClass + "\"><i class=\"" + iconClass + "\"></i></div><div class=\"doc-info\"><span class=\"doc-name\">" + name + "</span><span class=\"doc-meta\">" + typeLabel + " &bull; Download</span></div><div class=\"doc-download-icon\"><i class=\"fa-solid fa-circle-down\"></i></div></a>";
        }

        void ScrollToBottom()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ScrollChatBottom", "var el = document.getElementById('chatMessagesScroll'); if (el) { setTimeout(function(){ el.scrollTop = el.scrollHeight; }, 60); }", true);
        }
    }
}

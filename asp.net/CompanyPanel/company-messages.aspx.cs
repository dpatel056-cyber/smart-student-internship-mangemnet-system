using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_messages : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
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
                ViewState["ContactSearch"] = "";
                ViewState["ContactFilter"] = "all";

                fillContacts();

                if (Session["SelectedContactEmail"] != null)
                {
                    loadConversation();
                }
                else
                {
                    pnlEmptyState.Visible = true;
                    pnlChatActive.Visible = false;
                }
            }
        }

        string GetCompanyEmail()
        {
            getcon();
            da = new SqlDataAdapter("SELECT c_email FROM c_registration WHERE c_email='" + Session["company"] + "'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["c_email"].ToString();
            }
            return Session["company"].ToString();
        }

        string GetCompanyName()
        {
            getcon();
            da = new SqlDataAdapter("SELECT c_company FROM c_registration WHERE c_email='" + Session["company"] + "'", con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0]["c_company"].ToString();
            }
            return "Company";
        }

        // =========================================================================
        // 1. FILL CONTACTS (ADMIN & STUDENTS)
        // =========================================================================
        void fillContacts()
        {
            string search = ViewState["ContactSearch"].ToString();
            string filter = ViewState["ContactFilter"].ToString();
            string companyEmail = GetCompanyEmail();

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

            // Load Admin
            if (filter == "all" || filter == "Admin")
            {
                if (search == "" || "Platform Administrator".ToLower().Contains(search.ToLower()) || "admin@sims.com".Contains(search.ToLower()))
                {
                    dt.Rows.Add("1", "Platform Administrator", "Admin", "SIMS Support & Official Administration", "admin@sims.com", "", "AD", "", "Start a conversation", 0);
                }
            }

            // Load Students
            if (filter == "all" || filter == "Student")
            {
                if (search == "")
                {
                    da = new SqlDataAdapter("SELECT StudentId, FullName, Email, College, Course, ProfilePhoto FROM Students ORDER BY FullName", con);
                }
                else
                {
                    da = new SqlDataAdapter("SELECT StudentId, FullName, Email, College, Course, ProfilePhoto FROM Students WHERE FullName LIKE '%" + search + "%' OR Email LIKE '%" + search + "%' OR College LIKE '%" + search + "%' OR Course LIKE '%" + search + "%' ORDER BY FullName", con);
                }

                DataTable dtStudents = new DataTable();
                da.Fill(dtStudents);

                foreach (DataRow r in dtStudents.Rows)
                {
                    string initial = r["FullName"].ToString().Length > 0 ? r["FullName"].ToString().Substring(0, 1).ToUpper() : "S";
                    string photo = r["ProfilePhoto"].ToString();
                    if (photo != "" && !photo.StartsWith("~/"))
                    {
                        photo = "~/student_images/" + photo;
                    }

                    dt.Rows.Add(r["StudentId"], r["FullName"], "Student", r["College"] + " · " + r["Course"], r["Email"], photo, initial, "", "Start a conversation", 0);
                }
            }

            // Update Last Message & Unread Count for each contact
            foreach (DataRow r in dt.Rows)
            {
                string email = r["Email"].ToString();

                // Last Message
                da = new SqlDataAdapter("SELECT TOP 1 MessageText, SentAt FROM ChatMessages WHERE (SenderEmail='" + email + "' AND ReceiverEmail='" + companyEmail + "') OR (SenderEmail='" + companyEmail + "' AND ReceiverEmail='" + email + "') ORDER BY MessageId DESC", con);

                DataTable dtLast = new DataTable();
                da.Fill(dtLast);

                if (dtLast.Rows.Count > 0)
                {
                    r["LastMessage"] = dtLast.Rows[0]["MessageText"];

                    DateTime time = Convert.ToDateTime(dtLast.Rows[0]["SentAt"]);

                    if (time.Date == DateTime.Today)
                        r["LastTime"] = time.ToString("hh:mm tt");
                    else
                        r["LastTime"] = time.ToString("dd MMM");
                }

                // Unread Count
                da = new SqlDataAdapter("SELECT COUNT(*) FROM ChatMessages WHERE SenderEmail='" + email + "' AND ReceiverEmail='" + companyEmail + "' AND IsRead=0", con);

                DataTable dtCount = new DataTable();
                da.Fill(dtCount);

                r["UnreadCount"] = dtCount.Rows[0][0];
            }

            // Update Header Count & Filter Pills
            da = new SqlDataAdapter("SELECT COUNT(*) FROM Students", con);
            DataTable dtTotalSt = new DataTable();
            da.Fill(dtTotalSt);
            int totalStudents = (int)dtTotalSt.Rows[0][0];
            int totalAdmin = 1;
            int totalContacts = totalStudents + totalAdmin;

            lblTotalContacts.Text = totalContacts + " Contacts";

            btnFilterAll.Text = "<span>All</span> <span class=\"pill-count\">" + totalContacts + "</span>";
            btnFilterAll.CssClass = "filter-pill" + (filter == "all" ? " active" : "");

            btnFilterStudents.Text = "<span>Students</span> <span class=\"pill-count\">" + totalStudents + "</span>";
            btnFilterStudents.CssClass = "filter-pill" + (filter == "Student" ? " active" : "");

            btnFilterAdmin.Text = "<span>Admin</span> <span class=\"pill-count\">" + totalAdmin + "</span>";
            btnFilterAdmin.CssClass = "filter-pill" + (filter == "Admin" ? " active" : "");

            dlContacts.DataSource = dt;
            dlContacts.DataBind();

            if (dt.Rows.Count == 0)
                pnlNoContacts.Visible = true;
            else
                pnlNoContacts.Visible = false;
        }

        // =========================================================================
        // 2. SELECT CONTACT
        // =========================================================================
        protected void dlContacts_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "SelectContact")
            {
                string[] parts = e.CommandArgument.ToString().Split('|');

                Session["SelectedContactId"] = parts[0];
                Session["SelectedContactName"] = parts[1];
                Session["SelectedContactRole"] = parts[2];
                Session["SelectedContactSubtitle"] = parts[3];
                Session["SelectedContactEmail"] = parts[4];
                Session["SelectedContactAvatar"] = parts[5];

                txtMessage.Text = "";
                lblSendError.Visible = false;

                loadConversation();
                fillContacts();
                ScrollToBottom();
            }
        }

        // =========================================================================
        // 3. LOAD CHAT CONVERSATION
        // =========================================================================
        void loadConversation()
        {
            if (Session["SelectedContactEmail"] == null)
            {
                pnlEmptyState.Visible = true;
                pnlChatActive.Visible = false;
            }
            else
            {
                pnlEmptyState.Visible = false;
                pnlChatActive.Visible = true;

                string contactName = Session["SelectedContactName"].ToString();
                string contactRole = Session["SelectedContactRole"].ToString();
                string contactSub = Session["SelectedContactSubtitle"].ToString();
                string contactEmail = Session["SelectedContactEmail"].ToString();
                string contactAvatar = Session["SelectedContactAvatar"].ToString();
                string companyEmail = GetCompanyEmail();

                lblActiveName.Text = contactName;
                lblActiveRole.Text = contactRole;
                lblActiveRole.CssClass = contactRole == "Admin" ? "role-pill-mini role-ad" : "role-pill-mini role-st";
                lblActiveSubtitle.Text = contactSub;

                if (contactAvatar != "")
                {
                    imgActiveAvatar.ImageUrl = contactAvatar;
                    imgActiveAvatar.Visible = true;
                    lblActiveAvatar.Visible = false;
                }
                else
                {
                    imgActiveAvatar.Visible = false;
                    lblActiveAvatar.Text = contactName.Length > 0 ? contactName.Substring(0, 1).ToUpper() : "S";
                    lblActiveAvatar.CssClass = contactRole == "Admin" ? "contact-avatar avatar-admin" : "contact-avatar avatar-student";
                    lblActiveAvatar.Visible = true;
                }

                getcon();

                cmd = new SqlCommand("UPDATE ChatMessages SET IsRead=1 WHERE SenderEmail='" + contactEmail + "' AND ReceiverEmail='" + companyEmail + "' AND IsRead=0", con);
                cmd.ExecuteNonQuery();

                da = new SqlDataAdapter("SELECT MessageId, SenderRole, SenderName, SenderEmail, MessageText, SentAt FROM ChatMessages WHERE (SenderEmail='" + contactEmail + "' AND ReceiverEmail='" + companyEmail + "') OR (SenderEmail='" + companyEmail + "' AND ReceiverEmail='" + contactEmail + "') ORDER BY MessageId", con);

                DataTable dtRaw = new DataTable();
                da.Fill(dtRaw);

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

                foreach (DataRow r in dtRaw.Rows)
                {
                    bool isOut = r["SenderEmail"].ToString() == companyEmail;

                    string senderName = r["SenderName"].ToString();

                    if (isOut)
                        senderName = "You";

                    DateTime time = Convert.ToDateTime(r["SentAt"]);
                    string sentTime = time.ToString("dd MMM, hh:mm tt");

                    if (time.Date == DateTime.Today)
                        sentTime = time.ToString("hh:mm tt");

                    dtMsg.Rows.Add(r["MessageId"], senderName, r["SenderRole"], r["MessageText"], sentTime, isOut, "", "", "");
                }

                dlMessages.DataSource = dtMsg;
                dlMessages.DataBind();

                if (dtMsg.Rows.Count == 0)
                    pnlNoMessages.Visible = true;
                else
                    pnlNoMessages.Visible = false;

                ScrollToBottom();
            }
        }

        // =========================================================================
        // 4. SEND MESSAGE
        // =========================================================================
        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (Session["SelectedContactEmail"] == null)
            {
                lblSendError.Text = "Please select a contact first.";
                lblSendError.Visible = true;
            }
            else if (txtMessage.Text == "")
            {
                lblSendError.Text = "Please enter a message.";
                lblSendError.Visible = true;
            }
            else
            {
                string msg = txtMessage.Text;
                string contactEmail = Session["SelectedContactEmail"].ToString();
                string contactName = Session["SelectedContactName"].ToString();
                string contactRole = Session["SelectedContactRole"].ToString();
                string companyEmail = GetCompanyEmail();
                string companyName = GetCompanyName();

                getcon();

                cmd = new SqlCommand("INSERT INTO ChatMessages(SenderRole, SenderEmail, SenderName, ReceiverRole, ReceiverEmail, ReceiverName, MessageText, IsRead, SentAt) VALUES('Company', '" + companyEmail + "', '" + companyName + "', '" + contactRole + "', '" + contactEmail + "', '" + contactName + "', '" + msg + "', 0, GETDATE())", con);

                cmd.ExecuteNonQuery();

                txtMessage.Text = "";
                lblSendError.Visible = false;

                loadConversation();
                fillContacts();
                ScrollToBottom();
            }
        }

        // =========================================================================
        // 5. SEARCH & FILTERS
        // =========================================================================
        protected void btnSearchContact_Click(object sender, EventArgs e)
        {
            ViewState["ContactSearch"] = txtSearchContact.Text;
            fillContacts();
        }

        protected void btnClearSearch_Click(object sender, EventArgs e)
        {
            txtSearchContact.Text = "";
            ViewState["ContactSearch"] = "";
            ViewState["ContactFilter"] = "all";
            fillContacts();
        }

        protected void FilterContacts_Click(object sender, EventArgs e)
        {
            LinkButton btn = sender as LinkButton;
            if (btn != null)
            {
                ViewState["ContactFilter"] = btn.CommandArgument;
                fillContacts();
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            fillContacts();
            if (Session["SelectedContactEmail"] != null)
            {
                loadConversation();
            }
        }

        // =========================================================================
        // 6. HELPERS
        // =========================================================================
        public bool IsSelectedContact(string contactEmail)
        {
            return Session["SelectedContactEmail"] != null && Session["SelectedContactEmail"].ToString() == contactEmail;
        }

        public string RenderAttachment(object urlObj, object typeObj, object nameObj)
        {
            return "";
        }

        void ScrollToBottom()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ScrollChatBottom", "var el = document.getElementById('chatMessagesScroll'); if(el){el.scrollTop = el.scrollHeight;}", true);
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net.css
{
    public partial class admin_messages : System.Web.UI.Page
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
            if (Session["admin"] == null)
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

        // =========================================================================
        // 1. FILL CONTACTS (STUDENTS & COMPANIES)
        // =========================================================================
        void fillContacts()
        {
            string search = ViewState["ContactSearch"].ToString();
            string filter = ViewState["ContactFilter"].ToString();
            string adminEmail = Session["admin"].ToString();

            DataTable dt = new DataTable();

            dt.Columns.Add("Id");
            dt.Columns.Add("Name");
            dt.Columns.Add("Role");
            dt.Columns.Add("Subtitle");
            dt.Columns.Add("Email");
            dt.Columns.Add("AvatarUrl");
            dt.Columns.Add("LastTime");
            dt.Columns.Add("LastMessage");
            dt.Columns.Add("UnreadCount", typeof(int));

            getcon();

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
                    dt.Rows.Add(r["StudentId"], r["FullName"], "Student", r["College"] + " · " + r["Course"], r["Email"], r["ProfilePhoto"], "", "Start a conversation", 0);
                }
            }

            // Load Companies
            if (filter == "all" || filter == "Company")
            {
                if (search == "")
                {
                    da = new SqlDataAdapter("SELECT CompanyId, c_company, c_email, c_industry, c_city, c_logo FROM c_registration ORDER BY c_company", con);
                }
                else
                {
                    da = new SqlDataAdapter("SELECT CompanyId, c_company, c_email, c_industry, c_city, c_logo FROM c_registration WHERE c_company LIKE '%" + search + "%' OR c_email LIKE '%" + search + "%' OR c_industry LIKE '%" + search + "%' OR c_city LIKE '%" + search + "%' ORDER BY c_company", con);
                }

                DataTable dtCompanies = new DataTable();
                da.Fill(dtCompanies);

                foreach (DataRow r in dtCompanies.Rows)
                {
                    dt.Rows.Add(r["CompanyId"], r["c_company"], "Company", r["c_industry"] + " · " + r["c_city"], r["c_email"], r["c_logo"], "", "Start a conversation", 0);
                }
            }

            // 3. Update Last Message & Unread Count for each contact
            foreach (DataRow r in dt.Rows)
            {
                string email = r["Email"].ToString();

                // Last Message
                da = new SqlDataAdapter("SELECT TOP 1 MessageText, SentAt FROM ChatMessages WHERE (SenderEmail='" + email + "' AND ReceiverEmail='" + adminEmail + "') OR (SenderEmail='" + adminEmail + "' AND ReceiverEmail='" + email + "') ORDER BY MessageId DESC", con);

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
                da = new SqlDataAdapter("SELECT COUNT(*) FROM ChatMessages WHERE SenderEmail='" + email + "' AND ReceiverEmail='" + adminEmail + "' AND IsRead=0", con);

                DataTable dtCount = new DataTable();
                da.Fill(dtCount);

                r["UnreadCount"] = dtCount.Rows[0][0];
            }

            // 4. Update Header Badge & Dropdown Counts
            da = new SqlDataAdapter("SELECT (SELECT COUNT(*) FROM Students), (SELECT COUNT(*) FROM c_registration)", con);

            DataTable dtTotals = new DataTable();
            da.Fill(dtTotals);

            int totalStudents = (int)dtTotals.Rows[0][0];
            int totalCompanies = (int)dtTotals.Rows[0][1];
            int totalContacts = totalStudents + totalCompanies;

            lblTotalContacts.Text = totalContacts + " Contacts";

            ddlRole.Items[0].Text = "All Contacts (" + totalContacts + ")";
            ddlRole.Items[1].Text = "Students (" + totalStudents + ")";
            ddlRole.Items[2].Text = "Companies (" + totalCompanies + ")";

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
                string adminEmail = Session["admin"].ToString();

                lblActiveName.Text = contactName;
                lblActiveRole.Text = contactRole;
                lblActiveRole.CssClass = contactRole == "Student" ? "role-pill-mini role-st" : "role-pill-mini role-co";
                lblActiveSubtitle.Text = contactSub;

                DataTable dtAvatar = new DataTable();
                dtAvatar.Columns.Add("AvatarUrl");
                dtAvatar.Rows.Add(contactAvatar);

                DataListActiveAvatar.DataSource = dtAvatar;
                DataListActiveAvatar.DataBind();

                getcon();

                cmd = new SqlCommand("UPDATE ChatMessages SET IsRead=1 WHERE SenderEmail='" + contactEmail + "' AND ReceiverEmail='" + adminEmail + "' AND IsRead=0", con);
                cmd.ExecuteNonQuery();

                da = new SqlDataAdapter("SELECT MessageId, SenderRole, SenderName, SenderEmail, MessageText, SentAt FROM ChatMessages WHERE (SenderEmail='" + contactEmail + "' AND ReceiverEmail='" + adminEmail + "') OR (SenderEmail='" + adminEmail + "' AND ReceiverEmail='" + contactEmail + "') ORDER BY MessageId", con);

                DataTable dtRaw = new DataTable();
                da.Fill(dtRaw);

                DataTable dtMsg = new DataTable();

                dtMsg.Columns.Add("MessageId");
                dtMsg.Columns.Add("SenderName");
                dtMsg.Columns.Add("SenderRole");
                dtMsg.Columns.Add("MessageText");
                dtMsg.Columns.Add("SentTime");
                dtMsg.Columns.Add("IsOutgoing", typeof(bool));

                foreach (DataRow r in dtRaw.Rows)
                {
                    bool isOut = r["SenderEmail"].ToString() == adminEmail;

                    string senderName = r["SenderName"].ToString();

                    if (isOut)
                        senderName = "You";

                    DateTime time = Convert.ToDateTime(r["SentAt"]);
                    string sentTime = time.ToString("dd MMM, hh:mm tt");

                    if (time.Date == DateTime.Today)
                        sentTime = time.ToString("hh:mm tt");

                    dtMsg.Rows.Add(r["MessageId"], senderName, r["SenderRole"], r["MessageText"], sentTime, isOut);
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
                string adminEmail = Session["admin"].ToString();

                getcon();

                cmd = new SqlCommand("INSERT INTO ChatMessages(SenderRole, SenderEmail, SenderName, ReceiverRole, ReceiverEmail, ReceiverName, MessageText, IsRead, SentAt) VALUES('Admin', '" + adminEmail + "', 'Platform Admin', '" + contactRole + "', '" + contactEmail + "', '" + contactName + "', '" + msg + "', 0, GETDATE())", con);

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
        protected void btnSearch_Click(object sender, ImageClickEventArgs e)
        {
            ViewState["ContactSearch"] = txtSearch.Text;
            ViewState["ContactFilter"] = ddlRole.SelectedValue;
            fillContacts();
        }

        protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState["ContactFilter"] = ddlRole.SelectedValue;
            ViewState["ContactSearch"] = txtSearch.Text;
            fillContacts();
        }

        protected void btnClearFilters_Click(object sender, ImageClickEventArgs e)
        {
            txtSearch.Text = "";
            ddlRole.SelectedIndex = 0;
            ViewState["ContactSearch"] = "";
            ViewState["ContactFilter"] = "all";
            fillContacts();
        }

        // =========================================================================
        // 6. HELPERS
        // =========================================================================
        public bool IsSelectedContact(string contactEmail)
        {
            return Session["SelectedContactEmail"] != null && Session["SelectedContactEmail"].ToString() == contactEmail;
        }

        void ScrollToBottom()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "ScrollChatBottom", "var el = document.getElementById('chatMessagesScroll'); if(el){el.scrollTop = el.scrollHeight;}", true);
        }
    }
}

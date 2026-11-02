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

            string search = ViewState["ContactSearch"].ToString();
            string filter = ViewState["ContactFilter"].ToString();
            string adminEmail = Session["admin"].ToString();

            getcon();

            // STUDENTS

            if (filter == "all" || filter == "Student")
            {
                string q = "SELECT StudentId, FullName, Email, College, Course, CASE WHEN ProfilePhoto LIKE '~/%' THEN ProfilePhoto WHEN ProfilePhoto LIKE 'student_images/%' THEN '~/' + ProfilePhoto WHEN ProfilePhoto IS NOT NULL AND ProfilePhoto <> '' THEN '~/student_images/' + ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS AvatarUrl FROM Students WHERE FullName LIKE '%" + search + "%' OR Email LIKE '%" + search + "%' OR College LIKE '%" + search + "%' OR Course LIKE '%" + search + "%' ORDER BY FullName ASC";

                if (search == "")
                {
                    q = "SELECT StudentId, FullName, Email, College, Course, CASE WHEN ProfilePhoto LIKE '~/%' THEN ProfilePhoto WHEN ProfilePhoto LIKE 'student_images/%' THEN '~/' + ProfilePhoto WHEN ProfilePhoto IS NOT NULL AND ProfilePhoto <> '' THEN '~/student_images/' + ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS AvatarUrl FROM Students ORDER BY FullName ASC";
                }

                da = new SqlDataAdapter(q, con);
                ds = new DataSet();
                da.Fill(ds);

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    dt.Rows.Add(
                        ds.Tables[0].Rows[i]["StudentId"].ToString(),
                        ds.Tables[0].Rows[i]["FullName"].ToString(),
                        "Student",
                        ds.Tables[0].Rows[i]["College"].ToString() + " · " + ds.Tables[0].Rows[i]["Course"].ToString(),
                        ds.Tables[0].Rows[i]["Email"].ToString(),
                        ds.Tables[0].Rows[i]["AvatarUrl"].ToString(),
                        "",
                        "Start a conversation",
                        0
                    );
                }
            }

            // COMPANIES

            if (filter == "all" || filter == "Company")
            {
                string q = "SELECT CompanyId, c_company, c_email, c_industry, c_city, CASE WHEN c_logo LIKE '~/%' THEN c_logo WHEN c_logo IS NOT NULL AND c_logo <> '' THEN '~/compnay_images/' + c_logo ELSE '~/compnay_images/default-company.png' END AS AvatarUrl FROM c_registration WHERE c_company LIKE '%" + search + "%' OR c_email LIKE '%" + search + "%' OR c_industry LIKE '%" + search + "%' OR c_city LIKE '%" + search + "%' ORDER BY c_company ASC";

                if (search == "")
                {
                    q = "SELECT CompanyId, c_company, c_email, c_industry, c_city, CASE WHEN c_logo LIKE '~/%' THEN c_logo WHEN c_logo IS NOT NULL AND c_logo <> '' THEN '~/compnay_images/' + c_logo ELSE '~/compnay_images/default-company.png' END AS AvatarUrl FROM c_registration ORDER BY c_company ASC";
                }

                da = new SqlDataAdapter(q, con);
                ds = new DataSet();
                da.Fill(ds);

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    dt.Rows.Add(
                        ds.Tables[0].Rows[i]["CompanyId"].ToString(),
                        ds.Tables[0].Rows[i]["c_company"].ToString(),
                        "Company",
                        ds.Tables[0].Rows[i]["c_industry"].ToString() + " · " + ds.Tables[0].Rows[i]["c_city"].ToString(),
                        ds.Tables[0].Rows[i]["c_email"].ToString(),
                        ds.Tables[0].Rows[i]["AvatarUrl"].ToString(),
                        "",
                        "Start a conversation",
                        0
                    );
                }
            }

            // LAST MESSAGE AND UNREAD COUNT

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string email = dt.Rows[i]["Email"].ToString();

                if (email != "")
                {
                    da = new SqlDataAdapter("SELECT TOP 1 MessageText, SentAt FROM ChatMessages WHERE ((SenderEmail = '" + email + "' AND (ReceiverEmail = '" + adminEmail + "' OR ReceiverRole = 'Admin')) OR ((SenderEmail = '" + adminEmail + "' OR SenderRole = 'Admin') AND ReceiverEmail = '" + email + "')) ORDER BY MessageId DESC", con);
                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        dt.Rows[i]["LastMessage"] = ds.Tables[0].Rows[0]["MessageText"].ToString();

                        DateTime time = Convert.ToDateTime(ds.Tables[0].Rows[0]["SentAt"]);

                        if (time.Date == DateTime.Today)
                        {
                            dt.Rows[i]["LastTime"] = time.ToString("hh:mm tt");
                        }
                        else
                        {
                            dt.Rows[i]["LastTime"] = time.ToString("dd MMM");
                        }
                    }

                    // UNREAD COUNT

                    da = new SqlDataAdapter("SELECT COUNT(*) FROM ChatMessages WHERE SenderEmail = '" + email + "' AND (ReceiverEmail = '" + adminEmail + "' OR ReceiverRole = 'Admin') AND IsRead = 0", con);
                    ds = new DataSet();
                    da.Fill(ds);

                    dt.Rows[i]["UnreadCount"] = Convert.ToInt32(ds.Tables[0].Rows[0][0]);
                }
            }

            // TOTAL STUDENTS

            da = new SqlDataAdapter("SELECT COUNT(*) FROM Students", con);
            ds = new DataSet();
            da.Fill(ds);

            int totalStudents = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            // TOTAL COMPANIES

            da = new SqlDataAdapter("SELECT COUNT(*) FROM c_registration", con);
            ds = new DataSet();
            da.Fill(ds);

            int totalCompanies = Convert.ToInt32(ds.Tables[0].Rows[0][0]);

            // TOTAL CONTACTS

            int totalContacts = totalStudents + totalCompanies;

            lblTotalContacts.Text = totalContacts + " Contacts";

            ddlRole.Items[0].Text = "All Contacts (" + totalContacts + ")";
            ddlRole.Items[1].Text = "Students (" + totalStudents + ")";
            ddlRole.Items[2].Text = "Companies (" + totalCompanies + ")";

            // BIND CONTACTS

            dlContacts.DataSource = dt;
            dlContacts.DataBind();

            pnlNoContacts.Visible = dt.Rows.Count == 0;

        }

        // =========================================================================
        // 2. SELECT CONTACT (STUDENT OR COMPANY)
        // =========================================================================
        // SELECT CONTACT (STUDENT OR COMPANY)

        protected void dlContacts_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "SelectContact")
            {
                string[] parts = e.CommandArgument.ToString().Split('|');

                if (parts.Length >= 6)
                {
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
        }
        // =========================================================================
        // 3. LOAD CHAT CONVERSATION FOR SELECTED CONTACT
        // =========================================================================
        // LOAD CHAT CONVERSATION

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
                lblActiveRole.Text = contactRole.ToUpper();

                if (contactRole == "Student")
                {
                    lblActiveRole.CssClass = "role-pill-mini role-st";
                }
                else
                {
                    lblActiveRole.CssClass = "role-pill-mini role-co";
                }

                if (contactSub != "")
                {
                    lblActiveSubtitle.Text = contactSub;
                }
                else
                {
                    lblActiveSubtitle.Text = contactEmail;
                }

                getcon();

                // Active Contact Avatar DataList
                if (contactRole == "Student")
                {
                    da = new SqlDataAdapter("SELECT CASE WHEN ProfilePhoto LIKE '~/%' THEN ProfilePhoto WHEN ProfilePhoto LIKE 'student_images/%' THEN '~/' + ProfilePhoto WHEN ProfilePhoto IS NOT NULL AND ProfilePhoto <> '' THEN '~/student_images/' + ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS AvatarUrl FROM Students WHERE Email='" + contactEmail + "'", con);
                }
                else
                {
                    da = new SqlDataAdapter("SELECT CASE WHEN c_logo LIKE '~/%' THEN c_logo WHEN c_logo IS NOT NULL AND c_logo <> '' THEN '~/compnay_images/' + c_logo ELSE '~/compnay_images/default-company.png' END AS AvatarUrl FROM c_registration WHERE c_email='" + contactEmail + "'", con);
                }
                DataSet dsAvatar = new DataSet();
                da.Fill(dsAvatar);
                DataListActiveAvatar.DataSource = dsAvatar;
                DataListActiveAvatar.DataBind();

                // MARK MESSAGES AS READ

                cmd = new SqlCommand("UPDATE ChatMessages SET IsRead = 1 WHERE SenderEmail = '" + contactEmail + "' AND (ReceiverEmail = '" + adminEmail + "' OR ReceiverRole = 'Admin') AND IsRead = 0", con);
                cmd.ExecuteNonQuery();

                // LOAD MESSAGES

                string q = "SELECT MessageId, SenderRole, SenderName, SenderEmail, MessageText, SentAt FROM ChatMessages WHERE ((SenderEmail = '" + contactEmail + "' AND (ReceiverEmail = '" + adminEmail + "' OR ReceiverRole = 'Admin')) OR ((SenderEmail = '" + adminEmail + "' OR SenderRole = 'Admin') AND ReceiverEmail = '" + contactEmail + "')) ORDER BY MessageId ASC";

                da = new SqlDataAdapter(q, con);
                ds = new DataSet();
                da.Fill(ds);

                DataTable dtMsg = new DataTable();

                dtMsg.Columns.Add("MessageId");
                dtMsg.Columns.Add("SenderName");
                dtMsg.Columns.Add("SenderRole");
                dtMsg.Columns.Add("MessageText");
                dtMsg.Columns.Add("SentTime");
                dtMsg.Columns.Add("IsOutgoing", typeof(bool));

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    string role = ds.Tables[0].Rows[i]["SenderRole"].ToString();
                    string senderEmail = ds.Tables[0].Rows[i]["SenderEmail"].ToString();

                    bool isOut = false;

                    if (role == "Admin" || senderEmail == adminEmail)
                    {
                        isOut = true;
                    }

                    string senderName = ds.Tables[0].Rows[i]["SenderName"].ToString();

                    if (isOut)
                    {
                        senderName = "You";
                    }

                    string sentTime = "Just now";

                    if (ds.Tables[0].Rows[i]["SentAt"] != DBNull.Value)
                    {
                        DateTime time = Convert.ToDateTime(ds.Tables[0].Rows[i]["SentAt"]);

                        if (time.Date == DateTime.Today)
                        {
                            sentTime = time.ToString("hh:mm tt");
                        }
                        else
                        {
                            sentTime = time.ToString("dd MMM, hh:mm tt");
                        }
                    }

                    dtMsg.Rows.Add(
                        ds.Tables[0].Rows[i]["MessageId"].ToString(),
                        senderName,
                        role,
                        ds.Tables[0].Rows[i]["MessageText"].ToString(),
                        sentTime,
                        isOut
                    );
                }

                dlMessages.DataSource = dtMsg;
                dlMessages.DataBind();

                if (dtMsg.Rows.Count == 0)
                {
                    pnlNoMessages.Visible = true;
                }
                else
                {
                    pnlNoMessages.Visible = false;
                }

                con.Close();

                ScrollToBottom();
            }
        }

        // =========================================================================
        // 4. SEND MESSAGE (DIRECT INSERT INTO ChatMessages)
        // =========================================================================
        // SEND MESSAGE

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
                lblSendError.Visible = false;

                string contactEmail = Session["SelectedContactEmail"].ToString();
                string contactName = Session["SelectedContactName"].ToString();
                string contactRole = Session["SelectedContactRole"].ToString();
                string adminEmail = Session["admin"].ToString();

                getcon();

                cmd = new SqlCommand("INSERT INTO ChatMessages(SenderRole, SenderEmail, SenderName, ReceiverRole, ReceiverEmail, ReceiverName, MessageText, IsRead, SentAt) VALUES('Admin', '" + adminEmail + "', 'Platform Admin', '" + contactRole + "', '" + contactEmail + "', '" + contactName + "', '" + txtMessage.Text + "', 0, GETDATE())", con);

                cmd.ExecuteNonQuery();

                con.Close();

                txtMessage.Text = "";

                loadConversation();
                fillContacts();
                ScrollToBottom();
            }
        }

        // =========================================================================
        // 5. SEARCH & FILTER
        // =========================================================================
        // SEARCH CONTACT

        protected void btnSearch_Click(object sender, ImageClickEventArgs e)
        {
            ViewState["ContactSearch"] = txtSearch.Text;
            ViewState["ContactFilter"] = ddlRole.SelectedValue;

            fillContacts();
        }


        // FILTER CONTACT

        protected void ddlRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState["ContactFilter"] = ddlRole.SelectedValue;
            ViewState["ContactSearch"] = txtSearch.Text;

            fillContacts();
        }


        // CLEAR FILTERS

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
        // CHECK SELECTED CONTACT

        public bool IsSelectedContact(string contactEmail)
        {
            if (Session["SelectedContactEmail"] != null)
            {
                if (Session["SelectedContactEmail"].ToString() == contactEmail)
                {
                    return true;
                }
            }

            return false;
        }


        // SCROLL CHAT TO BOTTOM

        void ScrollToBottom()
        {
            ScriptManager.RegisterStartupScript(
                this,
                GetType(),
                "ScrollChatBottom",
                "var el = document.getElementById('chatMessagesScroll'); if(el){el.scrollTop = el.scrollHeight;}",
                true
            );
        }
    }
}

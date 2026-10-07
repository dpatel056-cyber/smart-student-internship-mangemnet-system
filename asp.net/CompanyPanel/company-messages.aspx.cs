using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI;

namespace asp.net
{
    public partial class company_messages : System.Web.UI.Page
    {
        static string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        // WebMethods are static, so each call gets its own connection (same getcon() idea as other pages)
        static SqlConnection getcon()
        {
            SqlConnection con = new SqlConnection(s);
            con.Open();
            return con;
        }

        public class ContactItem
        {
            public string Email { get; set; }
            public string Name { get; set; }
            public string Role { get; set; } // "Student" or "Admin"
            public string Subtitle { get; set; }
            public string Initials { get; set; }
            public string LastMessage { get; set; }
            public string LastTime { get; set; }
            public int UnreadCount { get; set; }
        }

        public class MessageItem
        {
            public int MessageId { get; set; }
            public string SenderRole { get; set; }
            public string SenderEmail { get; set; }
            public string SenderName { get; set; }
            public string ReceiverRole { get; set; }
            public string ReceiverEmail { get; set; }
            public string ReceiverName { get; set; }
            public string MessageText { get; set; }
            public bool IsRead { get; set; }
            public string SentTime { get; set; }
            public string SentDate { get; set; }
            public bool IsOutgoing { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }
        }

        [WebMethod(EnableSession = true)]
        public static List<ContactItem> GetContactsList()
        {
            var contacts = new List<ContactItem>();
            if (HttpContext.Current.Session == null || HttpContext.Current.Session["company"] == null)
                return contacts;

            string companyEmail = HttpContext.Current.Session["company"].ToString().Trim();

            SqlConnection con = getcon();
            SqlDataAdapter da;
            DataSet ds;

            // 1. Platform Admin Contact
            contacts.Add(new ContactItem
            {
                Email = "admin@sims.com",
                Name = "Platform Administrator",
                Role = "Admin",
                Subtitle = "SIMS Support & Official Administration",
                Initials = "AD",
                LastMessage = "No messages yet",
                LastTime = "",
                UnreadCount = 0
            });

            // 2. Get registered students
            string studentSql = @"
                SELECT DISTINCT s.Email, s.FullName, s.College, s.Course
                FROM Students s
                WHERE s.Email IS NOT NULL AND s.Email <> ''
                ORDER BY s.FullName";

            da = new SqlDataAdapter(studentSql, con);
            ds = new DataSet();
            da.Fill(ds);
            foreach (DataRow r in ds.Tables[0].Rows)
            {
                string email = r["Email"].ToString().Trim();
                string name = r["FullName"] != DBNull.Value ? r["FullName"].ToString().Trim() : email;
                string college = r["College"] != DBNull.Value ? r["College"].ToString().Trim() : "";
                string course = r["Course"] != DBNull.Value ? r["Course"].ToString().Trim() : "";
                string subtitle = (!string.IsNullOrEmpty(course) ? course : "Student") + (!string.IsNullOrEmpty(college) ? " · " + college : "");

                contacts.Add(new ContactItem
                {
                    Email = email,
                    Name = name,
                    Role = "Student",
                    Subtitle = subtitle,
                    Initials = GetInitials(name),
                    LastMessage = "No messages yet",
                    LastTime = "",
                    UnreadCount = 0
                });
            }

            // 3. Attach last message snippet and unread count for each contact
            foreach (var c in contacts)
            {
                string msgSql = "SELECT TOP 1 MessageText, SentAt, IsRead, SenderEmail FROM ChatMessages " +
                                "WHERE (SenderEmail = '" + c.Email + "' AND ReceiverEmail = '" + companyEmail + "') " +
                                "   OR (SenderEmail = '" + companyEmail + "' AND ReceiverEmail = '" + c.Email + "') " +
                                "ORDER BY SentAt DESC";

                da = new SqlDataAdapter(msgSql, con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataRow mr = ds.Tables[0].Rows[0];
                    c.LastMessage = mr["MessageText"].ToString();
                    if (DateTime.TryParse(mr["SentAt"].ToString(), out DateTime dt))
                    {
                        if (dt.Date == DateTime.Today)
                            c.LastTime = dt.ToString("hh:mm tt");
                        else
                            c.LastTime = dt.ToString("dd MMM");
                    }
                }

                // Unread count
                string unreadSql = "SELECT COUNT(*) FROM ChatMessages WHERE SenderEmail = '" + c.Email + "' AND ReceiverEmail = '" + companyEmail + "' AND IsRead = 0";
                SqlCommand cmd = new SqlCommand(unreadSql, con);
                c.UnreadCount = Convert.ToInt32(cmd.ExecuteScalar());
            }

// Sort: Contacts with most recent messages first, Admin on top if no messages
            contacts.Sort((a, b) =>
            {
                if (!string.IsNullOrEmpty(a.LastTime) && string.IsNullOrEmpty(b.LastTime)) return -1;
                if (string.IsNullOrEmpty(a.LastTime) && !string.IsNullOrEmpty(b.LastTime)) return 1;
                if (a.Role == "Admin" && b.Role != "Admin") return -1;
                if (b.Role == "Admin" && a.Role != "Admin") return 1;
                return a.Name.CompareTo(b.Name);
            });

            return contacts;
        }

        [WebMethod(EnableSession = true)]
        public static List<MessageItem> GetConversation(string contactEmail)
        {
            var list = new List<MessageItem>();
            if (string.IsNullOrWhiteSpace(contactEmail)) return list;
            if (HttpContext.Current.Session == null || HttpContext.Current.Session["company"] == null)
                return list;

            string companyEmail = HttpContext.Current.Session["company"].ToString().Trim();

            SqlConnection con = getcon();
            SqlDataAdapter da;
            DataSet ds;
            SqlCommand cmd;

            // Mark received messages from this contact as read
            string markRead = "UPDATE ChatMessages SET IsRead = 1 WHERE SenderEmail = '" + contactEmail.Trim() + "' AND ReceiverEmail = '" + companyEmail + "' AND IsRead = 0";
            cmd = new SqlCommand(markRead, con);
            cmd.ExecuteNonQuery();

            // Fetch full conversation between company and contact
            string query = "SELECT MessageId, SenderRole, SenderEmail, SenderName, ReceiverRole, ReceiverEmail, ReceiverName, MessageText, IsRead, SentAt " +
                           "FROM ChatMessages " +
                           "WHERE (SenderEmail = '" + contactEmail.Trim() + "' AND ReceiverEmail = '" + companyEmail + "') " +
                           "   OR (SenderEmail = '" + companyEmail + "' AND ReceiverEmail = '" + contactEmail.Trim() + "') " +
                           "ORDER BY SentAt ASC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            foreach (DataRow r in ds.Tables[0].Rows)
            {
                string sEmail = r["SenderEmail"].ToString();
                bool isOut = sEmail.Equals(companyEmail, StringComparison.OrdinalIgnoreCase);
                string timeStr = "";
                string dateStr = "";

                if (DateTime.TryParse(r["SentAt"].ToString(), out DateTime dt))
                {
                    timeStr = dt.ToString("hh:mm tt");
                    if (dt.Date == DateTime.Today)
                        dateStr = "Today";
                    else if (dt.Date == DateTime.Today.AddDays(-1))
                        dateStr = "Yesterday";
                    else
                        dateStr = dt.ToString("dd MMM yyyy");
                }

                list.Add(new MessageItem
                {
                    MessageId = Convert.ToInt32(r["MessageId"]),
                    SenderRole = r["SenderRole"].ToString(),
                    SenderEmail = sEmail,
                    SenderName = r["SenderName"].ToString(),
                    ReceiverRole = r["ReceiverRole"].ToString(),
                    ReceiverEmail = r["ReceiverEmail"].ToString(),
                    ReceiverName = r["ReceiverName"].ToString(),
                    MessageText = r["MessageText"].ToString(),
                    IsRead = Convert.ToBoolean(r["IsRead"]),
                    SentTime = timeStr,
                    SentDate = dateStr,
                    IsOutgoing = isOut
                });
            }

            return list;
        }

        [WebMethod(EnableSession = true)]
        public static MessageItem SendChatMessage(string receiverEmail, string receiverName, string receiverRole, string messageText)
        {
            if (string.IsNullOrWhiteSpace(receiverEmail) || string.IsNullOrWhiteSpace(messageText))
                return null;
            if (HttpContext.Current.Session == null || HttpContext.Current.Session["company"] == null)
                return null;

            string companyEmail = HttpContext.Current.Session["company"].ToString().Trim();
            string companyName = companyEmail;

            SqlConnection con = getcon();
            SqlDataAdapter da;
            DataSet ds;
            SqlCommand cmd;

            // Get company name
            string cSql = "SELECT c_company FROM c_registration WHERE c_email = '" + companyEmail + "'";
            cmd = new SqlCommand(cSql, con);
            object res = cmd.ExecuteScalar();
            if (res != null && res != DBNull.Value)
            {
                companyName = res.ToString();
            }

            string recRole = (receiverRole ?? "User").Replace("'", "''");
            string recName = (receiverName ?? receiverEmail).Replace("'", "''");
            string msgClean = messageText.Trim().Replace("'", "''");

            string insertSql = "INSERT INTO ChatMessages (SenderRole, SenderEmail, SenderName, ReceiverRole, ReceiverEmail, ReceiverName, MessageText, IsRead, SentAt) " +
                               "OUTPUT INSERTED.MessageId, INSERTED.SentAt " +
                               "VALUES ('Company', '" + companyEmail + "', '" + companyName.Replace("'", "''") + "', '" + recRole + "', '" + receiverEmail.Trim() + "', '" + recName + "', '" + msgClean + "', 0, GETDATE())";

            da = new SqlDataAdapter(insertSql, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                DataRow r = ds.Tables[0].Rows[0];
                int newId = Convert.ToInt32(r["MessageId"]);
                DateTime dt = Convert.ToDateTime(r["SentAt"]);

                return new MessageItem
                {
                    MessageId = newId,
                    SenderRole = "Company",
                    SenderEmail = companyEmail,
                    SenderName = companyName,
                    ReceiverRole = receiverRole,
                    ReceiverEmail = receiverEmail,
                    ReceiverName = receiverName,
                    MessageText = messageText.Trim(),
                    IsRead = false,
                    SentTime = dt.ToString("hh:mm tt"),
                    SentDate = "Today",
                    IsOutgoing = true
                };
            }

            return null;
        }

        private static string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "U";
            var parts = name.Trim().Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 1)
            {
                return parts[0].Length >= 2 ? parts[0].Substring(0, 2).ToUpper() : parts[0].ToUpper();
            }
            return (parts[0][0].ToString() + parts[parts.Length - 1][0].ToString()).ToUpper();
        }
    }
}

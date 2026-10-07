using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

namespace asp.net.css
{
    public partial class admin_messages : System.Web.UI.Page
    {
        static string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        public class ContactItem
        {
            public string Email { get; set; }
            public string Name { get; set; }
            public string Role { get; set; }
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
            if (Session["admin"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }
        }

        [WebMethod]
        public static List<ContactItem> GetContactsList()
        {
            List<ContactItem> contacts = new List<ContactItem>();

            SqlConnection con = new SqlConnection(s);
            con.Open();

            SqlDataAdapter da;
            DataSet ds;

            // Students
            da = new SqlDataAdapter(
                "SELECT Email, FullName, College FROM Students ORDER BY FullName",
                con);

            ds = new DataSet();
            da.Fill(ds);

            foreach (DataRow r in ds.Tables[0].Rows)
            {
                string name = r["FullName"].ToString();

                contacts.Add(new ContactItem
                {
                    Email = r["Email"].ToString(),
                    Name = name,
                    Role = "Student",
                    Subtitle = r["College"].ToString(),
                    Initials = GetInitials(name),
                    LastMessage = "No messages yet",
                    LastTime = "",
                    UnreadCount = 0
                });
            }

            // Companies
            da = new SqlDataAdapter(
                "SELECT c_email, c_company, c_industry, c_city FROM c_registration ORDER BY c_company",
                con);

            ds = new DataSet();
            da.Fill(ds);

            foreach (DataRow r in ds.Tables[0].Rows)
            {
                string name = r["c_company"].ToString();

                contacts.Add(new ContactItem
                {
                    Email = r["c_email"].ToString(),
                    Name = name,
                    Role = "Company",
                    Subtitle = r["c_industry"].ToString() + " · " + r["c_city"].ToString(),
                    Initials = GetInitials(name),
                    LastMessage = "No messages yet",
                    LastTime = "",
                    UnreadCount = 0
                });
            }

            // Last message and unread count
            foreach (ContactItem c in contacts)
            {

                da = new SqlDataAdapter("SELECT TOP 1 MessageText, SentAt FROM ChatMessages " +
                    "WHERE (SenderEmail='" + c.Email + "' AND ReceiverEmail='admin@sims.com') " +
                    "OR (SenderEmail='admin@sims.com' AND ReceiverEmail='" + c.Email + "') " +
                    "ORDER BY SentAt DESC", con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    c.LastMessage = ds.Tables[0].Rows[0]["MessageText"].ToString();

                    DateTime dt = Convert.ToDateTime(ds.Tables[0].Rows[0]["SentAt"]);

                    if (dt.Date == DateTime.Today)
                    {
                        c.LastTime = dt.ToString("hh:mm tt");
                    }
                    else
                    {
                        c.LastTime = dt.ToString("dd MMM");
                    }
                }

                SqlCommand cmd = new SqlCommand(
                    "SELECT COUNT(*) FROM ChatMessages " +
                    "WHERE SenderEmail='" + c.Email + "' " +
                    "AND ReceiverEmail='admin@sims.com' " +
                    "AND IsRead=0",
                    con);

                c.UnreadCount = Convert.ToInt32(cmd.ExecuteScalar());
            }

            return contacts;
        }

        [WebMethod]
        public static List<MessageItem> GetConversation(string contactEmail)
        {
            List<MessageItem> list = new List<MessageItem>();

            SqlConnection con = new SqlConnection(s);
            con.Open();

            SqlDataAdapter da;
            DataSet ds;

            // Mark messages as read
            SqlCommand cmd = new SqlCommand(
                "UPDATE ChatMessages SET IsRead=1 " +
                "WHERE SenderEmail='" + contactEmail + "' " +
                "AND ReceiverEmail='admin@sims.com'",
                con);

            cmd.ExecuteNonQuery();

            // Get conversation
            da = new SqlDataAdapter(
                "SELECT * FROM ChatMessages " +
                "WHERE (SenderEmail='" + contactEmail + "' AND ReceiverEmail='admin@sims.com') " +
                "OR (SenderEmail='admin@sims.com' AND ReceiverEmail='" + contactEmail + "') " +
                "ORDER BY SentAt",
                con);

            ds = new DataSet();
            da.Fill(ds);

            foreach (DataRow r in ds.Tables[0].Rows)
            {
                DateTime dt = Convert.ToDateTime(r["SentAt"]);

                string date;

                if (dt.Date == DateTime.Today)
                {
                    date = "Today";
                }
                else if (dt.Date == DateTime.Today.AddDays(-1))
                {
                    date = "Yesterday";
                }
                else
                {
                    date = dt.ToString("dd MMM yyyy");
                }

                list.Add(new MessageItem
                {
                    MessageId = Convert.ToInt32(r["MessageId"]),
                    SenderRole = r["SenderRole"].ToString(),
                    SenderEmail = r["SenderEmail"].ToString(),
                    SenderName = r["SenderName"].ToString(),
                    ReceiverRole = r["ReceiverRole"].ToString(),
                    ReceiverEmail = r["ReceiverEmail"].ToString(),
                    ReceiverName = r["ReceiverName"].ToString(),
                    MessageText = r["MessageText"].ToString(),
                    IsRead = Convert.ToBoolean(r["IsRead"]),
                    SentTime = dt.ToString("hh:mm tt"),
                    SentDate = date,
                    IsOutgoing = r["SenderEmail"].ToString() == "admin@sims.com"
                });
            }

            return list;
        }

        [WebMethod]
        public static MessageItem SendChatMessage(
            string receiverEmail,
            string receiverName,
            string receiverRole,
            string messageText)
        {
            if (receiverEmail == "" || messageText == "")
            {
                return null;
            }

            SqlConnection con = new SqlConnection(s);
            con.Open();

            SqlDataAdapter da;
            DataSet ds;

da = new SqlDataAdapter("INSERT INTO ChatMessages " +
                "(SenderRole, SenderEmail, SenderName, ReceiverRole, ReceiverEmail, ReceiverName, MessageText, IsRead, SentAt) " +
                "OUTPUT INSERTED.MessageId, INSERTED.SentAt " +
                "VALUES " +
                "('Admin', 'admin@sims.com', 'Platform Admin', '" +
                receiverRole + "', '" +
                receiverEmail + "', '" +
                receiverName + "', '" +
                messageText + "', 0, GETDATE())", con);

            ds = new DataSet();
            da.Fill(ds);

            DateTime dt = Convert.ToDateTime(ds.Tables[0].Rows[0]["SentAt"]);

            MessageItem message = new MessageItem
            {
                MessageId = Convert.ToInt32(ds.Tables[0].Rows[0]["MessageId"]),
                SenderRole = "Admin",
                SenderEmail = "admin@sims.com",
                SenderName = "Platform Admin",
                ReceiverRole = receiverRole,
                ReceiverEmail = receiverEmail,
                ReceiverName = receiverName,
                MessageText = messageText,
                IsRead = false,
                SentTime = dt.ToString("hh:mm tt"),
                SentDate = "Today",
                IsOutgoing = true
            };

            return message;
        }

        static string GetInitials(string name)
        {
            string[] p = name.Split(' ');

            if (p.Length == 1)
            {
                return p[0].Substring(0, 1).ToUpper();
            }

            return (p[0][0].ToString() + p[p.Length - 1][0].ToString()).ToUpper();
        }
    }
}

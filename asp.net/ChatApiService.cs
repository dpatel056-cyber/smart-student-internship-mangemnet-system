using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Newtonsoft.Json;

namespace asp.net
{
    // =========================================================================
    // STEP 1: DTO MODELS FOR DUMMYJSON API (SAME AS 3T PROJECT)
    // =========================================================================
    public class DummyUser
    {
        public int id { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public string image { get; set; }
        public string role { get; set; }
        public DummyCompany company { get; set; }
    }

    public class DummyCompany
    {
        public string department { get; set; }
        public string name { get; set; }
        public string title { get; set; }
    }

    public class UserApiResponse
    {
        public List<DummyUser> users { get; set; }
        public int total { get; set; }
        public int skip { get; set; }
        public int limit { get; set; }
    }

    public class DummyComment
    {
        public int id { get; set; }
        public string body { get; set; }
        public int postId { get; set; }
        public int likes { get; set; }
        public DummyCommentUser user { get; set; }
    }

    public class DummyCommentUser
    {
        public int id { get; set; }
        public string username { get; set; }
        public string fullName { get; set; }
    }

    public class CommentApiResponse
    {
        public List<DummyComment> comments { get; set; }
        public int total { get; set; }
        public int skip { get; set; }
        public int limit { get; set; }
    }

    // =========================================================================
    // STEP 2: WHATSAPP CHAT MODELS
    // =========================================================================
    [Serializable]
    public class WhatsAppContact
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string AvatarUrl { get; set; }
        public string Initials { get; set; }
        public string Role { get; set; } // "Student", "Company", "Admin"
        public string Subtitle { get; set; }
        public string LastMessage { get; set; }
        public string LastTime { get; set; }
        public int UnreadCount { get; set; }
        public bool IsOnline { get; set; }
        public DateTime LastMessageDate { get; set; } = DateTime.MinValue;
    }

    [Serializable]
    public class WhatsAppMessage
    {
        public int MessageId { get; set; }
        public int ContactId { get; set; }
        public string SenderName { get; set; }
        public string SenderRole { get; set; } // "Student", "Company", "Admin"
        public string MessageText { get; set; }
        public string SentTime { get; set; }
        public bool IsOutgoing { get; set; }
        public bool IsRead { get; set; }
        public string AttachmentUrl { get; set; }
        public string AttachmentType { get; set; } // "image", "pdf", "word", "excel", "doc"
        public string AttachmentName { get; set; }
    }

    // =========================================================================
    // STEP 3: CHAT API SERVICE USING 3T METHOD (HTTPCLIENT + JSONCONVERT)
    // =========================================================================
    public class ChatApiService
    {
        private static readonly HttpClient client = new HttpClient();
        private string cs = ConfigurationManager.ConnectionStrings["SimsConnectionString"] != null
            ? ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString
            : @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=F:\asp.net\asp.net\App_Data\sims.mdf;Integrated Security=True";

        static ChatApiService()
        {
            try
            {
                System.Net.ServicePointManager.SecurityProtocol =
                    System.Net.SecurityProtocolType.Tls12 |
                    System.Net.SecurityProtocolType.Tls11 |
                    System.Net.SecurityProtocolType.Tls;

                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Add("User-Agent", "SIMS-LiveChat/1.0");
            }
            catch { }
        }

        // -------------------------------------------------------------------------
        // 3T Method: Call Users API asynchronously with HttpClient & JsonConvert
        // -------------------------------------------------------------------------
        public async Task<List<DummyUser>> CallUsersApi()
        {
            string apiurl = "https://dummyjson.com/users?limit=30&select=id,firstName,lastName,image,email,phone,company,role";

            try
            {
                HttpResponseMessage response = await client.GetAsync(apiurl).ConfigureAwait(false);

                if (response.IsSuccessStatusCode)
                {
                    string json = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                    var userResponse = JsonConvert.DeserializeObject<UserApiResponse>(json);

                    return userResponse != null && userResponse.users != null ? userResponse.users : new List<DummyUser>();
                }
            }
            catch { }

            return new List<DummyUser>();
        }

        // -------------------------------------------------------------------------
        // 3T Method: Call Comments API asynchronously with HttpClient & JsonConvert
        // -------------------------------------------------------------------------
        public async Task<List<DummyComment>> CallCommentsApi()
        {
            string apiurl = "https://dummyjson.com/comments?limit=100";

            try
            {
                HttpResponseMessage response = await client.GetAsync(apiurl).ConfigureAwait(false);

                if (response.IsSuccessStatusCode)
                {
                    string json = await response.Content.ReadAsStringAsync().ConfigureAwait(false);
                    var commentResponse = JsonConvert.DeserializeObject<CommentApiResponse>(json);

                    return commentResponse != null && commentResponse.comments != null ? commentResponse.comments : new List<DummyComment>();
                }
            }
            catch { }

            return new List<DummyComment>();
        }

        // -------------------------------------------------------------------------
        // 3T Method: Post Comment API asynchronously with HttpClient & JsonConvert
        // -------------------------------------------------------------------------
        public async Task<bool> PostCommentApi(int postId, string message)
        {
            string apiurl = "https://dummyjson.com/comments/add";

            try
            {
                var payload = new
                {
                    body = message,
                    postId = postId,
                    userId = 1
                };

                string json = JsonConvert.SerializeObject(payload);
                StringContent content = new StringContent(json, Encoding.UTF8, "application/json");

                HttpResponseMessage response = await client.PostAsync(apiurl, content).ConfigureAwait(false);
                return response.IsSuccessStatusCode;
            }
            catch
            {
                return false;
            }
        }

                // =========================================================================
        // STEP 4A: LOAD CONTACTS FOR ADMIN (REGISTERED STUDENTS + COMPANIES)
        // =========================================================================
        public List<WhatsAppContact> GetRegisteredContacts(string search = "", string roleFilter = "all", string adminEmail = "admin@sims.com")
        {
            List<WhatsAppContact> contacts = new List<WhatsAppContact>();
            if (string.IsNullOrEmpty(cs)) return contacts;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // 1. Fetch Registered Students
                    string qStudents = "SELECT StudentId, FullName, Email, ContactNo, College, Course, CASE WHEN ProfilePhoto LIKE '~/%' THEN ProfilePhoto WHEN ProfilePhoto LIKE 'student_images/%' THEN '~/' + ProfilePhoto WHEN ProfilePhoto IS NOT NULL AND ProfilePhoto <> '' THEN '~/student_images/' + ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM Students ORDER BY FullName ASC";
                    SqlDataAdapter daStudents = new SqlDataAdapter(qStudents, con);
                    DataSet dsStudents = new DataSet();
                    daStudents.Fill(dsStudents);

                    if (dsStudents.Tables.Count > 0)
                    {
                        foreach (DataRow r in dsStudents.Tables[0].Rows)
                        {
                            int id = Convert.ToInt32(r["StudentId"]);
                            string name = r["FullName"] != DBNull.Value ? r["FullName"].ToString().Trim() : "Student";
                            string email = r["Email"] != DBNull.Value ? r["Email"].ToString().Trim() : "";
                            string phone = r["ContactNo"] != DBNull.Value ? r["ContactNo"].ToString().Trim() : "";
                            string college = r["College"] != DBNull.Value ? r["College"].ToString().Trim() : "";
                            string course = r["Course"] != DBNull.Value ? r["Course"].ToString().Trim() : "";
                            string photo = r["ProfilePhoto"] != DBNull.Value ? r["ProfilePhoto"].ToString().Trim() : "";
                            string sub = (!string.IsNullOrEmpty(college) ? college : "Student") + (!string.IsNullOrEmpty(course) ? " · " + course : "");

                            contacts.Add(new WhatsAppContact
                            {
                                Id = id,
                                Name = name,
                                Email = email,
                                Phone = phone,
                                Role = "Student",
                                Subtitle = sub,
                                AvatarUrl = ResolveAvatarUrl(photo),
                                Initials = GetInitials(name),
                                LastMessage = "Start a conversation",
                                LastTime = "",
                                UnreadCount = 0,
                                IsOnline = true
                            });
                        }
                    }

                    // 2. Fetch Registered Companies
                    string qCompanies = "SELECT CompanyId, c_company, c_email, c_contact, c_industry, c_city, CASE WHEN c_logo LIKE '~/%' THEN c_logo WHEN c_logo IS NOT NULL AND c_logo <> '' THEN '~/compnay_images/' + c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo FROM c_registration ORDER BY c_company ASC";
                    SqlDataAdapter daCompanies = new SqlDataAdapter(qCompanies, con);
                    DataSet dsCompanies = new DataSet();
                    daCompanies.Fill(dsCompanies);

                    if (dsCompanies.Tables.Count > 0)
                    {
                        foreach (DataRow r in dsCompanies.Tables[0].Rows)
                        {
                            int id = Convert.ToInt32(r["CompanyId"]);
                            string company = r["c_company"] != DBNull.Value ? r["c_company"].ToString().Trim() : "Company";
                            string email = r["c_email"] != DBNull.Value ? r["c_email"].ToString().Trim() : "";
                            string phone = r["c_contact"] != DBNull.Value ? r["c_contact"].ToString().Trim() : "";
                            string industry = r["c_industry"] != DBNull.Value ? r["c_industry"].ToString().Trim() : "";
                            string city = r["c_city"] != DBNull.Value ? r["c_city"].ToString().Trim() : "";
                            string logo = r["c_logo"] != DBNull.Value ? r["c_logo"].ToString().Trim() : "";
                            string sub = (!string.IsNullOrEmpty(industry) ? industry : "Company") + (!string.IsNullOrEmpty(city) ? " · " + city : "");

                            contacts.Add(new WhatsAppContact
                            {
                                Id = id,
                                Name = company,
                                Email = email,
                                Phone = phone,
                                Role = "Company",
                                Subtitle = sub,
                                AvatarUrl = ResolveAvatarUrl(logo),
                                Initials = GetInitials(company),
                                LastMessage = "Start a conversation",
                                LastTime = "",
                                UnreadCount = 0,
                                IsOnline = true
                            });
                        }
                    }

                    // 3. Populate latest messages and unread counts from ChatMessages table
                    string adm = !string.IsNullOrEmpty(adminEmail) ? adminEmail : "admin@sims.com";
                    foreach (var c in contacts)
                    {
                        string qLast = "SELECT TOP 1 MessageText, SentAt, IsRead, SenderEmail, AttachmentType, AttachmentName FROM ChatMessages WHERE (SenderEmail = '" + c.Email + "' AND (ReceiverEmail = '" + adm + "' OR ReceiverRole = 'Admin')) OR ((SenderEmail = '" + adm + "' OR SenderRole = 'Admin') AND ReceiverEmail = '" + c.Email + "') ORDER BY SentAt DESC";
                        SqlDataAdapter daLast = new SqlDataAdapter(qLast, con);
                        DataSet dsLast = new DataSet();
                        daLast.Fill(dsLast);

                        if (dsLast.Tables.Count > 0 && dsLast.Tables[0].Rows.Count > 0)
                        {
                            DataRow r = dsLast.Tables[0].Rows[0];
                            string msgTxt = r["MessageText"] != DBNull.Value ? r["MessageText"].ToString().Trim() : "";
                            string aType = r["AttachmentType"] != DBNull.Value ? r["AttachmentType"].ToString().Trim().ToLower() : "";
                            string aName = r["AttachmentName"] != DBNull.Value ? r["AttachmentName"].ToString().Trim() : "";

                            if (!string.IsNullOrEmpty(msgTxt))
                            {
                                c.LastMessage = msgTxt;
                            }
                            else if (!string.IsNullOrEmpty(aType))
                            {
                                if (aType == "image") c.LastMessage = "📷 Photo";
                                else if (aType == "pdf") c.LastMessage = "📄 " + (!string.IsNullOrEmpty(aName) ? aName : "PDF Document");
                                else c.LastMessage = "📎 " + (!string.IsNullOrEmpty(aName) ? aName : "Document");
                            }

                            if (r["SentAt"] != DBNull.Value)
                            {
                                DateTime dt = Convert.ToDateTime(r["SentAt"]);
                                c.LastMessageDate = dt;
                                c.LastTime = dt.Date == DateTime.Today ? dt.ToString("hh:mm tt") : dt.ToString("dd MMM");
                            }
                        }

                        string qUnread = "SELECT COUNT(*) FROM ChatMessages WHERE SenderEmail = '" + c.Email + "' AND (ReceiverEmail = '" + adm + "' OR ReceiverRole = 'Admin') AND IsRead = 0";
                        SqlDataAdapter daUnread = new SqlDataAdapter(qUnread, con);
                        DataSet dsUnread = new DataSet();
                        daUnread.Fill(dsUnread);
                        if (dsUnread.Tables.Count > 0 && dsUnread.Tables[0].Rows.Count > 0)
                        {
                            c.UnreadCount = Convert.ToInt32(dsUnread.Tables[0].Rows[0][0]);
                        }
                    }
                }
            }
            catch { }

            // WhatsApp Real-Time Sorting: contacts with the most recent messages jump to the very top!
            contacts.Sort((a, b) =>
            {
                int cmp = b.LastMessageDate.CompareTo(a.LastMessageDate);
                if (cmp != 0) return cmp;
                return string.Compare(a.Name, b.Name, StringComparison.OrdinalIgnoreCase);
            });

            // Filter by search & role
            List<WhatsAppContact> filtered = new List<WhatsAppContact>();
            string s = (search ?? "").Trim().ToLower();
            string rf = (roleFilter ?? "all").Trim();

            foreach (var c in contacts)
            {
                bool matchesRole = rf.Equals("all", StringComparison.OrdinalIgnoreCase) ||
                                   c.Role.Equals(rf, StringComparison.OrdinalIgnoreCase);

                bool matchesSearch = string.IsNullOrEmpty(s) ||
                                     c.Name.ToLower().Contains(s) ||
                                     c.Email.ToLower().Contains(s) ||
                                     (c.Subtitle != null && c.Subtitle.ToLower().Contains(s)) ||
                                     (c.LastMessage != null && c.LastMessage.ToLower().Contains(s));

                if (matchesRole && matchesSearch)
                {
                    filtered.Add(c);
                }
            }

            // Keep filtered list also sorted by newest message at the top
            filtered.Sort((a, b) =>
            {
                int cmp = b.LastMessageDate.CompareTo(a.LastMessageDate);
                if (cmp != 0) return cmp;
                return string.Compare(a.Name, b.Name, StringComparison.OrdinalIgnoreCase);
            });

            return filtered;
        }

        // =========================================================================
        // STEP 4B: LOAD CONTACTS FOR STUDENT (ADMIN + REGISTERED COMPANIES)
        // =========================================================================
        public List<WhatsAppContact> GetContactsForStudent(string studentEmail, string search = "", string roleFilter = "all")
        {
            List<WhatsAppContact> contacts = new List<WhatsAppContact>();
            if (string.IsNullOrEmpty(studentEmail) || string.IsNullOrEmpty(cs)) return contacts;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // 1. Platform Admin Contact
                    contacts.Add(new WhatsAppContact
                    {
                        Id = 999999,
                        Name = "Platform Administrator",
                        Email = "admin@sims.com",
                        Phone = "SIMS Support",
                        Role = "Admin",
                        Subtitle = "SIMS Support & Official Administration",
                        AvatarUrl = "",
                        Initials = "AD",
                        LastMessage = "Start a conversation",
                        LastTime = "",
                        UnreadCount = 0,
                        IsOnline = true
                    });

                    // 2. Registered Companies
                    string qCompanies = "SELECT CompanyId, c_company, c_email, c_contact, c_industry, c_city, CASE WHEN c_logo LIKE '~/%' THEN c_logo WHEN c_logo IS NOT NULL AND c_logo <> '' THEN '~/compnay_images/' + c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo FROM c_registration ORDER BY c_company ASC";
                    SqlDataAdapter daCompanies = new SqlDataAdapter(qCompanies, con);
                    DataSet dsCompanies = new DataSet();
                    daCompanies.Fill(dsCompanies);

                    if (dsCompanies.Tables.Count > 0)
                    {
                        foreach (DataRow r in dsCompanies.Tables[0].Rows)
                        {
                            int id = Convert.ToInt32(r["CompanyId"]);
                            string company = r["c_company"] != DBNull.Value ? r["c_company"].ToString().Trim() : "Company";
                            string email = r["c_email"] != DBNull.Value ? r["c_email"].ToString().Trim() : "";
                            string phone = r["c_contact"] != DBNull.Value ? r["c_contact"].ToString().Trim() : "";
                            string industry = r["c_industry"] != DBNull.Value ? r["c_industry"].ToString().Trim() : "";
                            string city = r["c_city"] != DBNull.Value ? r["c_city"].ToString().Trim() : "";
                            string logo = r["c_logo"] != DBNull.Value ? r["c_logo"].ToString().Trim() : "";
                            string sub = (!string.IsNullOrEmpty(industry) ? industry : "Company") + (!string.IsNullOrEmpty(city) ? " · " + city : "");

                            contacts.Add(new WhatsAppContact
                            {
                                Id = id,
                                Name = company,
                                Email = email,
                                Phone = phone,
                                Role = "Company",
                                Subtitle = sub,
                                AvatarUrl = ResolveAvatarUrl(logo),
                                Initials = GetInitials(company),
                                LastMessage = "Start a conversation",
                                LastTime = "",
                                UnreadCount = 0,
                                IsOnline = true
                            });
                        }
                    }

                    // 3. Attach last message and unread count for student
                    foreach (var c in contacts)
                    {
                        string qLast = "SELECT TOP 1 MessageText, SentAt, IsRead, SenderEmail, AttachmentType, AttachmentName FROM ChatMessages WHERE (SenderEmail = '" + studentEmail + "' AND (ReceiverEmail = '" + c.Email + "' OR (ReceiverRole = 'Admin' AND '" + c.Role + "' = 'Admin'))) OR ((SenderEmail = '" + c.Email + "' OR (SenderRole = 'Admin' AND '" + c.Role + "' = 'Admin')) AND ReceiverEmail = '" + studentEmail + "') ORDER BY SentAt DESC";
                        SqlDataAdapter daLast = new SqlDataAdapter(qLast, con);
                        DataSet dsLast = new DataSet();
                        daLast.Fill(dsLast);

                        if (dsLast.Tables.Count > 0 && dsLast.Tables[0].Rows.Count > 0)
                        {
                            DataRow r = dsLast.Tables[0].Rows[0];
                            string msgTxt = r["MessageText"] != DBNull.Value ? r["MessageText"].ToString().Trim() : "";
                            string aType = r["AttachmentType"] != DBNull.Value ? r["AttachmentType"].ToString().Trim().ToLower() : "";
                            string aName = r["AttachmentName"] != DBNull.Value ? r["AttachmentName"].ToString().Trim() : "";

                            if (!string.IsNullOrEmpty(msgTxt))
                            {
                                c.LastMessage = msgTxt;
                            }
                            else if (!string.IsNullOrEmpty(aType))
                            {
                                if (aType == "image") c.LastMessage = "📷 Photo";
                                else if (aType == "pdf") c.LastMessage = "📄 " + (!string.IsNullOrEmpty(aName) ? aName : "PDF Document");
                                else c.LastMessage = "📎 " + (!string.IsNullOrEmpty(aName) ? aName : "Document");
                            }

                            if (r["SentAt"] != DBNull.Value)
                            {
                                DateTime dt = Convert.ToDateTime(r["SentAt"]);
                                c.LastMessageDate = dt;
                                c.LastTime = dt.Date == DateTime.Today ? dt.ToString("hh:mm tt") : dt.ToString("dd MMM");
                            }
                        }

                        // WhatsApp Unread Count circle badge for Student
                        string qUnread = "SELECT COUNT(*) FROM ChatMessages WHERE ((SenderEmail = '" + c.Email + "') OR (SenderRole = 'Admin' AND '" + c.Role + "' = 'Admin')) AND ReceiverEmail = '" + studentEmail + "' AND IsRead = 0";
                        SqlDataAdapter daUnread = new SqlDataAdapter(qUnread, con);
                        DataSet dsUnread = new DataSet();
                        daUnread.Fill(dsUnread);
                        if (dsUnread.Tables.Count > 0 && dsUnread.Tables[0].Rows.Count > 0)
                        {
                            c.UnreadCount = Convert.ToInt32(dsUnread.Tables[0].Rows[0][0]);
                        }
                    }
                }
            }
            catch { }

            contacts.Sort((a, b) =>
            {
                int cmp = b.LastMessageDate.CompareTo(a.LastMessageDate);
                if (cmp != 0) return cmp;
                return string.Compare(a.Name, b.Name, StringComparison.OrdinalIgnoreCase);
            });

            List<WhatsAppContact> filtered = new List<WhatsAppContact>();
            string s = (search ?? "").Trim().ToLower();
            string rf = (roleFilter ?? "all").Trim();

            foreach (var c in contacts)
            {
                bool matchesRole = rf.Equals("all", StringComparison.OrdinalIgnoreCase) ||
                                   c.Role.Equals(rf, StringComparison.OrdinalIgnoreCase);

                bool matchesSearch = string.IsNullOrEmpty(s) ||
                                     c.Name.ToLower().Contains(s) ||
                                     c.Email.ToLower().Contains(s) ||
                                     (c.Subtitle != null && c.Subtitle.ToLower().Contains(s)) ||
                                     (c.LastMessage != null && c.LastMessage.ToLower().Contains(s));

                if (matchesRole && matchesSearch)
                {
                    filtered.Add(c);
                }
            }

            filtered.Sort((a, b) =>
            {
                int cmp = b.LastMessageDate.CompareTo(a.LastMessageDate);
                if (cmp != 0) return cmp;
                return string.Compare(a.Name, b.Name, StringComparison.OrdinalIgnoreCase);
            });

            return filtered;
        }

        // =========================================================================
        // STEP 4C: LOAD CONTACTS FOR COMPANY (ADMIN + REGISTERED STUDENTS)
        // =========================================================================
        public List<WhatsAppContact> GetContactsForCompany(string companyEmail, string search = "", string roleFilter = "all")
        {
            List<WhatsAppContact> contacts = new List<WhatsAppContact>();
            if (string.IsNullOrEmpty(companyEmail) || string.IsNullOrEmpty(cs)) return contacts;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // 1. Platform Admin Contact
                    contacts.Add(new WhatsAppContact
                    {
                        Id = 999999,
                        Name = "Platform Administrator",
                        Email = "admin@sims.com",
                        Phone = "SIMS Support",
                        Role = "Admin",
                        Subtitle = "SIMS Support & Official Administration",
                        AvatarUrl = "",
                        Initials = "AD",
                        LastMessage = "Start a conversation",
                        LastTime = "",
                        UnreadCount = 0,
                        IsOnline = true
                    });

                    // 2. Registered Students
                    string qStudents = "SELECT StudentId, FullName, Email, ContactNo, College, Course, CASE WHEN ProfilePhoto LIKE '~/%' THEN ProfilePhoto WHEN ProfilePhoto LIKE 'student_images/%' THEN '~/' + ProfilePhoto WHEN ProfilePhoto IS NOT NULL AND ProfilePhoto <> '' THEN '~/student_images/' + ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM Students ORDER BY FullName ASC";
                    SqlDataAdapter daStudents = new SqlDataAdapter(qStudents, con);
                    DataSet dsStudents = new DataSet();
                    daStudents.Fill(dsStudents);

                    if (dsStudents.Tables.Count > 0)
                    {
                        foreach (DataRow r in dsStudents.Tables[0].Rows)
                        {
                            int id = Convert.ToInt32(r["StudentId"]);
                            string name = r["FullName"] != DBNull.Value ? r["FullName"].ToString().Trim() : "Student";
                            string email = r["Email"] != DBNull.Value ? r["Email"].ToString().Trim() : "";
                            string phone = r["ContactNo"] != DBNull.Value ? r["ContactNo"].ToString().Trim() : "";
                            string college = r["College"] != DBNull.Value ? r["College"].ToString().Trim() : "";
                            string course = r["Course"] != DBNull.Value ? r["Course"].ToString().Trim() : "";
                            string photo = r["ProfilePhoto"] != DBNull.Value ? r["ProfilePhoto"].ToString().Trim() : "";
                            string sub = (!string.IsNullOrEmpty(college) ? college : "Student") + (!string.IsNullOrEmpty(course) ? " · " + course : "");

                            contacts.Add(new WhatsAppContact
                            {
                                Id = id,
                                Name = name,
                                Email = email,
                                Phone = phone,
                                Role = "Student",
                                Subtitle = sub,
                                AvatarUrl = ResolveAvatarUrl(photo),
                                Initials = GetInitials(name),
                                LastMessage = "Start a conversation",
                                LastTime = "",
                                UnreadCount = 0,
                                IsOnline = true
                            });
                        }
                    }

                    // 3. Attach last message and unread count for company
                    foreach (var c in contacts)
                    {
                        string qLast = "SELECT TOP 1 MessageText, SentAt, IsRead, SenderEmail, AttachmentType, AttachmentName FROM ChatMessages WHERE (SenderEmail = '" + companyEmail + "' AND (ReceiverEmail = '" + c.Email + "' OR (ReceiverRole = 'Admin' AND '" + c.Role + "' = 'Admin'))) OR ((SenderEmail = '" + c.Email + "' OR (SenderRole = 'Admin' AND '" + c.Role + "' = 'Admin')) AND ReceiverEmail = '" + companyEmail + "') ORDER BY SentAt DESC";
                        SqlDataAdapter daLast = new SqlDataAdapter(qLast, con);
                        DataSet dsLast = new DataSet();
                        daLast.Fill(dsLast);

                        if (dsLast.Tables.Count > 0 && dsLast.Tables[0].Rows.Count > 0)
                        {
                            DataRow r = dsLast.Tables[0].Rows[0];
                            string msgTxt = r["MessageText"] != DBNull.Value ? r["MessageText"].ToString().Trim() : "";
                            string aType = r["AttachmentType"] != DBNull.Value ? r["AttachmentType"].ToString().Trim().ToLower() : "";
                            string aName = r["AttachmentName"] != DBNull.Value ? r["AttachmentName"].ToString().Trim() : "";

                            if (!string.IsNullOrEmpty(msgTxt))
                            {
                                c.LastMessage = msgTxt;
                            }
                            else if (!string.IsNullOrEmpty(aType))
                            {
                                if (aType == "image") c.LastMessage = "📷 Photo";
                                else if (aType == "pdf") c.LastMessage = "📄 " + (!string.IsNullOrEmpty(aName) ? aName : "PDF Document");
                                else c.LastMessage = "📎 " + (!string.IsNullOrEmpty(aName) ? aName : "Document");
                            }

                            if (r["SentAt"] != DBNull.Value)
                            {
                                DateTime dt = Convert.ToDateTime(r["SentAt"]);
                                c.LastMessageDate = dt;
                                c.LastTime = dt.Date == DateTime.Today ? dt.ToString("hh:mm tt") : dt.ToString("dd MMM");
                            }
                        }

                        // WhatsApp Unread Count circle badge for Company
                        string qUnread = "SELECT COUNT(*) FROM ChatMessages WHERE ((SenderEmail = '" + c.Email + "') OR (SenderRole = 'Admin' AND '" + c.Role + "' = 'Admin')) AND ReceiverEmail = '" + companyEmail + "' AND IsRead = 0";
                        SqlDataAdapter daUnread = new SqlDataAdapter(qUnread, con);
                        DataSet dsUnread = new DataSet();
                        daUnread.Fill(dsUnread);
                        if (dsUnread.Tables.Count > 0 && dsUnread.Tables[0].Rows.Count > 0)
                        {
                            c.UnreadCount = Convert.ToInt32(dsUnread.Tables[0].Rows[0][0]);
                        }
                    }
                }
            }
            catch { }

            contacts.Sort((a, b) =>
            {
                int cmp = b.LastMessageDate.CompareTo(a.LastMessageDate);
                if (cmp != 0) return cmp;
                return string.Compare(a.Name, b.Name, StringComparison.OrdinalIgnoreCase);
            });

            List<WhatsAppContact> filtered = new List<WhatsAppContact>();
            string s = (search ?? "").Trim().ToLower();
            string rf = (roleFilter ?? "all").Trim();

            foreach (var c in contacts)
            {
                bool matchesRole = rf.Equals("all", StringComparison.OrdinalIgnoreCase) ||
                                   c.Role.Equals(rf, StringComparison.OrdinalIgnoreCase);

                bool matchesSearch = string.IsNullOrEmpty(s) ||
                                     c.Name.ToLower().Contains(s) ||
                                     c.Email.ToLower().Contains(s) ||
                                     (c.Subtitle != null && c.Subtitle.ToLower().Contains(s)) ||
                                     (c.LastMessage != null && c.LastMessage.ToLower().Contains(s));

                if (matchesRole && matchesSearch)
                {
                    filtered.Add(c);
                }
            }

            filtered.Sort((a, b) =>
            {
                int cmp = b.LastMessageDate.CompareTo(a.LastMessageDate);
                if (cmp != 0) return cmp;
                return string.Compare(a.Name, b.Name, StringComparison.OrdinalIgnoreCase);
            });

            return filtered;
        }

        // =========================================================================
        // STEP 5: LOAD CONVERSATION FOR SELECTED REGISTERED CONTACT
        // =========================================================================
        public List<WhatsAppMessage> GetConversation(string contactEmail, string contactName, string contactRole, int contactId, string adminEmail)
        {
            return GetConversationForUser(!string.IsNullOrEmpty(adminEmail) ? adminEmail : "admin@sims.com", "Admin", contactEmail, contactName, contactRole, contactId);
        }

        public List<WhatsAppMessage> GetConversationForUser(string myEmail, string myRole, string contactEmail, string contactName, string contactRole, int contactId)
        {
            List<WhatsAppMessage> conversation = new List<WhatsAppMessage>();
            if (string.IsNullOrEmpty(contactEmail) || string.IsNullOrEmpty(myEmail) || string.IsNullOrEmpty(cs)) return conversation;

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    // 1. Mark incoming unread messages as read when opening conversation!
                    string qRead = "UPDATE ChatMessages SET IsRead = 1 WHERE ((SenderEmail = '" + contactEmail + "') OR (SenderRole = 'Admin' AND '" + contactRole + "' = 'Admin')) AND ((ReceiverEmail = '" + myEmail + "') OR (ReceiverRole = 'Admin' AND '" + myRole + "' = 'Admin')) AND IsRead = 0";
                    using (SqlCommand cmd = new SqlCommand(qRead, con))
                    {
                        cmd.ExecuteNonQuery();
                    }

                    // 2. Fetch full conversation between me and this contact
                    string qMsg = "SELECT MessageId, SenderRole, SenderName, SenderEmail, ReceiverRole, ReceiverEmail, MessageText, SentAt, IsRead, AttachmentUrl, AttachmentType, AttachmentName FROM ChatMessages WHERE (((SenderEmail = '" + contactEmail + "' OR (SenderRole = 'Admin' AND '" + contactRole + "' = 'Admin')) AND (ReceiverEmail = '" + myEmail + "' OR (ReceiverRole = 'Admin' AND '" + myRole + "' = 'Admin'))) OR ((SenderEmail = '" + myEmail + "' OR (SenderRole = 'Admin' AND '" + myRole + "' = 'Admin')) AND (ReceiverEmail = '" + contactEmail + "' OR (ReceiverRole = 'Admin' AND '" + contactRole + "' = 'Admin')))) ORDER BY SentAt ASC";
                    SqlDataAdapter daMsg = new SqlDataAdapter(qMsg, con);
                    DataSet dsMsg = new DataSet();
                    daMsg.Fill(dsMsg);

                    if (dsMsg.Tables.Count > 0)
                    {
                        foreach (DataRow r in dsMsg.Tables[0].Rows)
                        {
                            int mId = Convert.ToInt32(r["MessageId"]);
                            string role = r["SenderRole"] != DBNull.Value ? r["SenderRole"].ToString() : "";
                            string name = r["SenderName"] != DBNull.Value ? r["SenderName"].ToString() : "";
                            string sEmail = r["SenderEmail"] != DBNull.Value ? r["SenderEmail"].ToString() : "";
                            string text = r["MessageText"] != DBNull.Value ? r["MessageText"].ToString() : "";
                            string time = "Just now";
                            if (r["SentAt"] != DBNull.Value)
                            {
                                time = Convert.ToDateTime(r["SentAt"]).ToString("hh:mm tt");
                            }

                            string attachUrl = r["AttachmentUrl"] != DBNull.Value ? r["AttachmentUrl"].ToString() : "";
                            string attachType = r["AttachmentType"] != DBNull.Value ? r["AttachmentType"].ToString() : "";
                            string attachName = r["AttachmentName"] != DBNull.Value ? r["AttachmentName"].ToString() : "";

                            bool isOut = sEmail.Equals(myEmail, StringComparison.OrdinalIgnoreCase) || (myRole == "Admin" && role == "Admin");

                            conversation.Add(new WhatsAppMessage
                            {
                                MessageId = mId,
                                ContactId = contactId,
                                SenderName = isOut ? "You" : name,
                                SenderRole = role,
                                MessageText = text,
                                SentTime = time,
                                IsOutgoing = isOut,
                                IsRead = true,
                                AttachmentUrl = attachUrl,
                                AttachmentType = attachType,
                                AttachmentName = attachName
                            });
                        }
                    }
                }
            }
            catch { }

            // 3. If no prior messages exist in DB, fetch dynamic welcome comments from DummyJSON API using 3T method!
            if (conversation.Count == 0)
            {
                var apiComments = CallCommentsApi().GetAwaiter().GetResult();
                string initialBody = (apiComments != null && apiComments.Count > 0 && !string.IsNullOrEmpty(apiComments[contactId % apiComments.Count].body))
                    ? apiComments[contactId % apiComments.Count].body
                    : "Hello! Welcome to SIMS Live Messenger.";

                conversation.Add(new WhatsAppMessage
                {
                    MessageId = 1,
                    ContactId = contactId,
                    SenderName = !string.IsNullOrEmpty(contactName) ? contactName : "User",
                    SenderRole = !string.IsNullOrEmpty(contactRole) ? contactRole : "Contact",
                    MessageText = initialBody,
                    SentTime = "10:15 AM",
                    IsOutgoing = false,
                    IsRead = true
                });

                conversation.Add(new WhatsAppMessage
                {
                    MessageId = 2,
                    ContactId = contactId,
                    SenderName = myRole == "Admin" ? "Platform Admin" : "You",
                    SenderRole = myRole,
                    MessageText = "Hello " + contactName + "! Nice to connect with you on SIMS.",
                    SentTime = "10:18 AM",
                    IsOutgoing = true,
                    IsRead = true
                });
            }

            return conversation;
        }

        // =========================================================================
        // STEP 6: SEND MESSAGE (CALL DUMMYJSON POST API VIA 3T METHOD + SAVE TO DB)
        // =========================================================================
        public bool SendMessage(int contactId, string contactEmail, string contactName, string contactRole, string adminEmail, string messageText, out string error)
        {
            return SendMessage("Admin", !string.IsNullOrEmpty(adminEmail) ? adminEmail : "admin@sims.com", "Platform Admin", contactRole, contactEmail, contactName, contactId, messageText, "", "", "", out error);
        }

        public bool SendMessage(int contactId, string contactEmail, string contactName, string contactRole, string adminEmail, string messageText, string attachUrl, string attachType, string attachName, out string error)
        {
            return SendMessage("Admin", !string.IsNullOrEmpty(adminEmail) ? adminEmail : "admin@sims.com", "Platform Admin", contactRole, contactEmail, contactName, contactId, messageText, attachUrl, attachType, attachName, out error);
        }

        public bool SendMessage(string senderRole, string senderEmail, string senderName, string receiverRole, string receiverEmail, string receiverName, int contactId, string messageText, string attachUrl, string attachType, string attachName, out string error)
        {
            error = "";
            string text = (messageText ?? "").Trim();
            if (string.IsNullOrEmpty(text) && string.IsNullOrEmpty(attachUrl))
            {
                error = "Please enter a message or choose an attachment.";
                return false;
            }

            // 1. Post to DummyJSON API via 3T method
            string apiPayload = !string.IsNullOrEmpty(text) ? text : (!string.IsNullOrEmpty(attachName) ? "[" + attachType + ": " + attachName + "]" : "Attachment");
            PostCommentApi(contactId, apiPayload).GetAwaiter().GetResult();

            // 2. Save directly to local SQL Database ChatMessages table with IsRead = 0 (Unread until receiver views it!)
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string safeText = text.Replace("'", "''");
                    string safeSenderName = (senderName ?? "").Replace("'", "''");
                    string safeReceiverName = (receiverName ?? "").Replace("'", "''");
                    string valAttachUrl = string.IsNullOrEmpty(attachUrl) ? "NULL" : "'" + attachUrl.Replace("'", "''") + "'";
                    string valAttachType = string.IsNullOrEmpty(attachType) ? "NULL" : "'" + attachType.Replace("'", "''") + "'";
                    string valAttachName = string.IsNullOrEmpty(attachName) ? "NULL" : "'" + attachName.Replace("'", "''") + "'";

                    string q = "INSERT INTO ChatMessages (SenderRole, SenderEmail, SenderName, ReceiverRole, ReceiverEmail, ReceiverName, MessageText, IsRead, SentAt, AttachmentUrl, AttachmentType, AttachmentName) VALUES ('" + senderRole + "', '" + senderEmail + "', '" + safeSenderName + "', '" + receiverRole + "', '" + receiverEmail + "', '" + safeReceiverName + "', '" + safeText + "', 0, GETDATE(), " + valAttachUrl + ", " + valAttachType + ", " + valAttachName + ")";

                    using (SqlCommand cmd = new SqlCommand(q, con))
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                error = "Could not save message to database: " + ex.Message;
                return false;
            }

            return true;
        }

        // =========================================================================
        // STEP 7: UTILITIES & AVATAR RESOLVER
        // =========================================================================
        public static string ResolveAvatarUrl(string avatarPath)
        {
            if (string.IsNullOrWhiteSpace(avatarPath)) return "";
            string path = avatarPath.Trim();

            if (path.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || path.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
            {
                return path;
            }

            if (HttpContext.Current != null)
            {
                try
                {
                    if (path.StartsWith("~/"))
                    {
                        return VirtualPathUtility.ToAbsolute(path);
                    }
                    if (path.StartsWith("/"))
                    {
                        return path;
                    }
                    return VirtualPathUtility.ToAbsolute("~/" + path);
                }
                catch
                {
                    return path;
                }
            }

            return path;
        }

        public static string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "U";
            string[] parts = name.Trim().Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 1)
            {
                return parts[0].Substring(0, Math.Min(2, parts[0].Length)).ToUpper();
            }
            return (parts[0][0].ToString() + parts[parts.Length - 1][0].ToString()).ToUpper();
        }
    }
}

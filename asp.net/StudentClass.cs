using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public class StudentClass
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        public SqlConnection getcon()
        {
            con = new SqlConnection(s);
            con.Open();
            return con;
        }

        // ==================== 1. STUDENT IDENTITY & PROFILE ====================

        public DataSet get_student_info(string sessionStudent)
        {
            getcon();
            string clean = (sessionStudent ?? "").Trim().Replace("'", "''");
            da = new SqlDataAdapter("SELECT * FROM Students WHERE Email = '" + clean + "' OR EnrollmentNo = '" + clean + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public string get_student_email(string sessionStudent)
        {
            getcon();
            string clean = (sessionStudent ?? "").Trim().Replace("'", "''");
            cmd = new SqlCommand("SELECT TOP 1 Email FROM Students WHERE Email = '" + clean + "' OR EnrollmentNo = '" + clean + "'", con);
            object res = cmd.ExecuteScalar();
            if (res != null && res != DBNull.Value && !string.IsNullOrEmpty(res.ToString()))
            {
                return res.ToString().Trim();
            }
            return clean;
        }

        public string get_student_name(string sessionStudent)
        {
            getcon();
            string clean = (sessionStudent ?? "").Trim().Replace("'", "''");
            cmd = new SqlCommand("SELECT TOP 1 FullName FROM Students WHERE Email = '" + clean + "' OR EnrollmentNo = '" + clean + "'", con);
            object res = cmd.ExecuteScalar();
            if (res != null && res != DBNull.Value && !string.IsNullOrEmpty(res.ToString()))
            {
                return res.ToString().Trim();
            }
            return clean;
        }

        // ==================== 2. MESSAGES & CONTACTS ====================

        public DataSet select_message_companies()
        {
            getcon();
            da = new SqlDataAdapter(@"
                SELECT DISTINCT c.c_email, c.c_company, c.c_industry, c.c_city
                FROM c_registration c
                WHERE c.c_email IS NOT NULL AND c.c_email <> ''
                ORDER BY c.c_company", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_message_companies(string search)
        {
            getcon();
            string clean = (search ?? "").Trim().Replace("'", "''");
            if (string.IsNullOrEmpty(clean))
            {
                return select_message_companies();
            }

            string q = @"
                SELECT DISTINCT c.c_email, c.c_company, c.c_industry, c.c_city
                FROM c_registration c
                WHERE c.c_email IS NOT NULL AND c.c_email <> ''
                  AND (c.c_company LIKE '%" + clean + @"%'
                       OR c.c_email LIKE '%" + clean + @"%'
                       OR c.c_industry LIKE '%" + clean + @"%'
                       OR c.c_city LIKE '%" + clean + @"%')
                ORDER BY c.c_company";

            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_chat_messages(string studentEmail, string contactEmail)
        {
            getcon();
            string sClean = (studentEmail ?? "").Trim().Replace("'", "''");
            string cClean = (contactEmail ?? "").Trim().Replace("'", "''");

            string query = @"
                SELECT MessageId, SenderRole, SenderEmail, SenderName, ReceiverRole, ReceiverEmail, ReceiverName, MessageText, IsRead, SentAt
                FROM ChatMessages
                WHERE (SenderEmail = '" + cClean + "' AND ReceiverEmail = '" + sClean + @"')
                   OR (SenderEmail = '" + sClean + "' AND ReceiverEmail = '" + cClean + @"')
                ORDER BY SentAt ASC";

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public void mark_messages_read(string studentEmail, string contactEmail)
        {
            getcon();
            string sClean = (studentEmail ?? "").Trim().Replace("'", "''");
            string cClean = (contactEmail ?? "").Trim().Replace("'", "''");

            string markRead = "UPDATE ChatMessages SET IsRead = 1 WHERE SenderEmail = '" + cClean + "' AND ReceiverEmail = '" + sClean + "' AND IsRead = 0";
            cmd = new SqlCommand(markRead, con);
            cmd.ExecuteNonQuery();
        }

        public DataSet send_chat_message(string studentEmail, string studentName, string receiverRole, string receiverEmail, string receiverName, string messageText)
        {
            getcon();
            string sEmail = (studentEmail ?? "").Trim().Replace("'", "''");
            string sName = (studentName ?? "").Trim().Replace("'", "''");
            string rRole = (receiverRole ?? "User").Trim().Replace("'", "''");
            string rEmail = (receiverEmail ?? "").Trim().Replace("'", "''");
            string rName = (receiverName ?? receiverEmail ?? "").Trim().Replace("'", "''");
            string msg = (messageText ?? "").Trim().Replace("'", "''");

            string insertSql = @"
                INSERT INTO ChatMessages (SenderRole, SenderEmail, SenderName, ReceiverRole, ReceiverEmail, ReceiverName, MessageText, IsRead, SentAt)
                OUTPUT INSERTED.MessageId, INSERTED.SentAt
                VALUES ('Student', '" + sEmail + "', '" + sName + "', '" + rRole + "', '" + rEmail + "', '" + rName + "', '" + msg + @"', 0, GETDATE())";

            da = new SqlDataAdapter(insertSql, con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet get_last_chat_message(string studentEmail, string contactEmail)
        {
            getcon();
            string sClean = (studentEmail ?? "").Trim().Replace("'", "''");
            string cClean = (contactEmail ?? "").Trim().Replace("'", "''");

            string msgSql = @"
                SELECT TOP 1 MessageText, SentAt, IsRead, SenderEmail
                FROM ChatMessages
                WHERE (SenderEmail = '" + cClean + "' AND ReceiverEmail = '" + sClean + @"')
                   OR (SenderEmail = '" + sClean + "' AND ReceiverEmail = '" + cClean + @"')
                ORDER BY SentAt DESC";

            da = new SqlDataAdapter(msgSql, con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public int get_unread_chat_count(string studentEmail, string contactEmail)
        {
            getcon();
            string sClean = (studentEmail ?? "").Trim().Replace("'", "''");
            string cClean = (contactEmail ?? "").Trim().Replace("'", "''");

            string unreadSql = "SELECT COUNT(*) FROM ChatMessages WHERE SenderEmail = '" + cClean + "' AND ReceiverEmail = '" + sClean + "' AND IsRead = 0";
            cmd = new SqlCommand(unreadSql, con);
            object res = cmd.ExecuteScalar();
            return (res != null && res != DBNull.Value) ? Convert.ToInt32(res) : 0;
        }

        // ==================== 3. INTERNSHIPS (MATCHING PUBLIC PANEL) ====================

        // Select all active internships
        public DataSet select_internship()
        {
            getcon();
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Search internships by keyword/title/company/domain
        public DataSet search_internship(string nm)
        {
            getcon();
            string clean = (nm ?? "").Trim().Replace("'", "''");
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and (i.InternshipTitle like '%" + clean + "%' or c.c_company like '%" + clean + "%' or i.InternshipDomain like '%" + clean + "%') order by i.Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select internships by category / domain
        public DataSet select_internship_by_category(string cat)
        {
            getcon();
            if (string.IsNullOrEmpty(cat))
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            }
            else
            {
                string clean = cat.Trim().Replace("'", "''");
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and i.InternshipDomain = '" + clean + "' order by i.Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select internships by city / location
        public DataSet select_internship_by_city(string ct)
        {
            getcon();
            if (string.IsNullOrEmpty(ct))
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            }
            else
            {
                string clean = ct.Trim().Replace("'", "''");
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and i.Location = '" + clean + "' order by i.Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select internships by duration
        public DataSet select_internship_by_duration(string dur)
        {
            getcon();
            if (string.IsNullOrEmpty(dur))
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            }
            else
            {
                string clean = dur.Trim().Replace("'", "''");
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) and i.Duration = '" + clean + "' order by i.Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Sort internships
        public DataSet sort_internship(string s)
        {
            getcon();
            if (s == "stipend-desc")
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by TRY_CAST(i.StipendAmount AS INT) desc, i.Id desc", con);
            }
            else if (s == "stipend-asc")
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by TRY_CAST(i.StipendAmount AS INT) asc, i.Id desc", con);
            }
            else if (s == "duration-asc")
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Duration asc, i.Id desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo from internship i inner join c_registration c on i.CompanyId = c.CompanyId where (i.Status IS NULL OR (i.Status <> 'Inactive' AND i.Status <> 'Draft')) and (c.IsBlocked = 0 OR c.IsBlocked IS NULL) and (c.Status != 'Blocked' OR c.Status IS NULL) order by i.Id desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Pagination for internships (12 per page)
        public DataTable Internship_pagination(DataTable dt, int page)
        {
            if (dt == null) return new DataTable();
            DataTable dt1 = dt.Clone();
            int start = page * 12;
            for (int i = start; i < start + 12 && i < dt.Rows.Count; i++)
            {
                dt1.ImportRow(dt.Rows[i]);
            }
            return dt1;
        }

        // ==================== 4. BOOKMARK / SAVED INTERNSHIPS ====================

        public bool is_internship_saved(string sessionStudent, string internshipId)
        {
            if (string.IsNullOrEmpty(sessionStudent) || string.IsNullOrEmpty(internshipId))
                return false;

            getcon();
            string sClean = sessionStudent.Trim().Replace("'", "''");
            string idClean = internshipId.Trim().Replace("'", "''");
            string q = "SELECT COUNT(*) FROM StudentSavedInternships WHERE InternshipId = '" + idClean + "' AND (StudentEmail = '" + sClean + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email = '" + sClean + "' OR EnrollmentNo = '" + sClean + "'))";
            cmd = new SqlCommand(q, con);
            object res = cmd.ExecuteScalar();
            return (res != null && res != DBNull.Value && Convert.ToInt32(res) > 0);
        }

        public bool toggle_bookmark(string sessionStudent, string internshipId)
        {
            if (string.IsNullOrEmpty(sessionStudent) || string.IsNullOrEmpty(internshipId))
                return false;

            getcon();
            string sClean = sessionStudent.Trim().Replace("'", "''");
            string idClean = internshipId.Trim().Replace("'", "''");

            da = new SqlDataAdapter("SELECT StudentId FROM Students WHERE Email='" + sClean + "' OR EnrollmentNo='" + sClean + "'", con);
            DataSet sDs = new DataSet();
            da.Fill(sDs);
            string studentId = (sDs.Tables[0].Rows.Count > 0) ? sDs.Tables[0].Rows[0]["StudentId"].ToString() : "0";

            if (is_internship_saved(sessionStudent, internshipId))
            {
                getcon();
                cmd = new SqlCommand("DELETE FROM StudentSavedInternships WHERE InternshipId=" + idClean + " AND (StudentEmail='" + sClean + "' OR StudentId=" + studentId + ")", con);
                cmd.ExecuteNonQuery();
                return false;
            }
            else
            {
                getcon();
                cmd = new SqlCommand("INSERT INTO StudentSavedInternships (StudentId, StudentEmail, InternshipId, SavedDate) VALUES (" + studentId + ", '" + sClean + "', " + idClean + ", GETDATE())", con);
                cmd.ExecuteNonQuery();
                return true;
            }
        }

        public void save_internship(string sessionStudent, string internshipId)
        {
            if (string.IsNullOrEmpty(sessionStudent) || string.IsNullOrEmpty(internshipId))
                return;

            if (!is_internship_saved(sessionStudent, internshipId))
            {
                toggle_bookmark(sessionStudent, internshipId);
            }
        }

        // ==================== 5. INTERNSHIP & COMPANY DETAILS ====================

        public DataSet select_internship_details(string id)
        {
            getcon();
            string idClean = (id ?? "").Trim().Replace("'", "''");
            da = new SqlDataAdapter("select i.*, c.c_company, c.c_logo, c.c_industry, c.c_location, c.c_city, c.c_state, c.c_about, c.c_email, c.c_contact, c.c_hr_name, c.c_website from internship i inner join c_registration c on i.CompanyId=c.CompanyId where i.Id='" + idClean + "' and (i.Status is null or (i.Status<>'Inactive' and i.Status<>'Draft')) and (c.IsBlocked=0 or c.IsBlocked is null) and (c.Status<>'Blocked' or c.Status is null)", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public bool check_already_applied(string sessionStudent, string internshipId)
        {
            if (string.IsNullOrEmpty(sessionStudent) || string.IsNullOrEmpty(internshipId))
                return false;

            getcon();
            string sClean = sessionStudent.Trim().Replace("'", "''");
            string idClean = internshipId.Trim().Replace("'", "''");
            da = new SqlDataAdapter("select ApplicationId from StudentApplications where InternshipId=" + idClean + " and (StudentEmail='" + sClean + "' or StudentId in (select StudentId from Students where Email='" + sClean + "' or EnrollmentNo='" + sClean + "'))", con);
            ds = new DataSet();
            da.Fill(ds);
            return (ds.Tables[0].Rows.Count > 0);
        }

        public void submit_internship_application(string internshipId, string sessionStudent, string fullName, string contactNo, string college, string course, string semester, string cgpa, string availability, string resumeFileName, string coverLetter)
        {
            getcon();
            string sClean = (sessionStudent ?? "").Trim().Replace("'", "''");
            string idClean = (internshipId ?? "").Trim().Replace("'", "''");

            da = new SqlDataAdapter("select StudentId, Email from Students where Email='" + sClean + "' or EnrollmentNo='" + sClean + "'", con);
            DataSet sDs = new DataSet();
            da.Fill(sDs);
            string studentId = sDs.Tables[0].Rows[0]["StudentId"].ToString();
            string studentEmail = sDs.Tables[0].Rows[0]["Email"].ToString();

            string q = "insert into StudentApplications (InternshipId,StudentId,StudentEmail,FullName,ContactNo,College,Course,Semester,CGPA,CoverLetter,ResumePath,Availability,Status,AppliedDate) values("
                + idClean + "," + studentId + ",'" + studentEmail.Replace("'", "''") + "','" + (fullName ?? "").Replace("'", "''") + "','" + (contactNo ?? "").Replace("'", "''") + "','" + (college ?? "").Replace("'", "''") + "','" + (course ?? "").Replace("'", "''") + "','" + (semester ?? "").Replace("'", "''") + "','" + (cgpa ?? "").Replace("'", "''") + "','" + (coverLetter ?? "").Replace("'", "''") + "','" + (resumeFileName ?? "").Replace("'", "''") + "','" + (availability ?? "").Replace("'", "''") + "','Applied',GETDATE())";
            cmd = new SqlCommand(q, con);
            cmd.ExecuteNonQuery();
        }

        public DataSet select_company_details(string companyId)
        {
            getcon();
            string cClean = (companyId ?? "").Trim().Replace("'", "''");
            da = new SqlDataAdapter("SELECT * FROM c_registration WHERE CompanyId='" + cClean + "' and (IsBlocked = 0 OR IsBlocked IS NULL) and (Status != 'Blocked' OR Status IS NULL)", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_company_internships(string companyId)
        {
            getcon();
            string cClean = (companyId ?? "").Trim().Replace("'", "''");
            da = new SqlDataAdapter("SELECT * FROM internship WHERE CompanyId='" + cClean + "' AND (Status IS NULL OR (Status <> 'Inactive' AND Status <> 'Draft')) ORDER BY Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }
    }
}

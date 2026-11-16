using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public class CompanyClass
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

        // ==================== 1. APPLICANTS / APPLICATIONS ====================
        // Select applicants by company email
        public DataSet select_applicants(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("select a.ApplicationId, a.StudentId, a.InternshipId, a.AppliedDate, ISNULL(a.Status, 'Applied') AS Status, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id inner join c_registration c on i.CompanyId=c.CompanyId left join Students s on a.StudentId=s.StudentId where c.c_email='" + compEmail + "' order by a.ApplicationId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select all applicants
        public DataSet select_applicants()
        {
            getcon();
            da = new SqlDataAdapter("select a.ApplicationId, a.StudentId, a.InternshipId, a.AppliedDate, ISNULL(a.Status, 'Applied') AS Status, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id left join Students s on a.StudentId=s.StudentId order by a.ApplicationId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Search applicants by keyword (with company email)
        public DataSet search_applicants(string nm, string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("select a.ApplicationId, a.StudentId, a.InternshipId, a.AppliedDate, ISNULL(a.Status, 'Applied') AS Status, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id inner join c_registration c on i.CompanyId=c.CompanyId left join Students s on a.StudentId=s.StudentId where c.c_email='" + compEmail + "' and (a.FullName like '%" + nm + "%' or a.StudentEmail like '%" + nm + "%' or i.InternshipTitle like '%" + nm + "%') order by a.ApplicationId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Search applicants by Name (all)
        public DataSet search_applicants(string nm)
        {
            getcon();
            da = new SqlDataAdapter("select a.ApplicationId, a.StudentId, a.InternshipId, a.AppliedDate, ISNULL(a.Status, 'Applied') AS Status, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id left join Students s on a.StudentId=s.StudentId where (a.FullName like '%" + nm + "%' or a.StudentEmail like '%" + nm + "%' or i.InternshipTitle like '%" + nm + "%') order by a.ApplicationId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select applicants by Status (with company email)
        public DataSet select_applicants_by_status(string st, string compEmail)
        {
            getcon();
            string q = "select a.ApplicationId, a.StudentId, a.InternshipId, a.AppliedDate, ISNULL(a.Status, 'Applied') AS Status, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id inner join c_registration c on i.CompanyId=c.CompanyId left join Students s on a.StudentId=s.StudentId where c.c_email='" + compEmail + "'";
            if (st == "All" || string.IsNullOrEmpty(st))
            {
            }
            else if (st == "Applied" || st == "Pending")
            {
                q += " and (a.Status='Applied' or a.Status is null or a.Status='Pending' or a.Status='' or a.Status not in ('Shortlisted', 'Selected', 'Rejected'))";
            }
            else
            {
                q += " and a.Status='" + st + "'";
            }
            q += " order by a.ApplicationId desc";
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select applicants by Status (all)
        public DataSet select_applicants_by_status(string st)
        {
            getcon();
            if (st == "All")
            {
                da = new SqlDataAdapter("select a.ApplicationId, a.StudentId, a.InternshipId, a.AppliedDate, ISNULL(a.Status, 'Applied') AS Status, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id left join Students s on a.StudentId=s.StudentId order by a.ApplicationId desc", con);
            }
            else if (st == "Applied" || st == "Pending")
            {
                da = new SqlDataAdapter("select a.ApplicationId, a.StudentId, a.InternshipId, a.AppliedDate, ISNULL(a.Status, 'Applied') AS Status, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id left join Students s on a.StudentId=s.StudentId where (a.Status='Applied' or a.Status is null or a.Status='Pending' or a.Status='' or a.Status not in ('Shortlisted', 'Selected', 'Rejected')) order by a.ApplicationId desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select a.ApplicationId, a.StudentId, a.InternshipId, a.AppliedDate, ISNULL(a.Status, 'Applied') AS Status, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id left join Students s on a.StudentId=s.StudentId where a.Status='" + st + "' order by a.ApplicationId desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

       
        public void update_applicant_status(int appId, string status)
        {
            getcon();
            cmd = new SqlCommand("update StudentApplications set Status='" + status + "' where ApplicationId=" + appId, con);
            cmd.ExecuteNonQuery();
        }

        // ==================== 2. INTERNSHIPS ====================
        public DataSet select_internships(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE c.c_email = '" + compEmail + "' ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_internships()
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_internships(string search, string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE c.c_email = '" + compEmail + "' AND (i.InternshipTitle LIKE '%" + search + "%' OR i.RequiredSkills LIKE '%" + search + "%' OR i.InternshipDomain LIKE '%" + search + "%' OR i.Location LIKE '%" + search + "%') ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_internships(string search)
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE (i.InternshipTitle LIKE '%" + search + "%' OR i.RequiredSkills LIKE '%" + search + "%' OR c.c_company LIKE '%" + search + "%' OR i.InternshipDomain LIKE '%" + search + "%' OR i.Location LIKE '%" + search + "%') ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_internships_by_status(string status, string compEmail)
        {
            getcon();
            string q = "SELECT i.*, c.c_company, c.c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE c.c_email = '" + compEmail + "'";
            if (status == "All" || string.IsNullOrEmpty(status))
            {
                // no filter
            }
            else if (status == "Inactive")
            {
                q += " AND i.Status = 'Inactive'";
            }
            else
            {
                q += " AND (i.Status = 'Active' OR i.Status IS NULL)";
            }
            q += " ORDER BY i.Id DESC";
            da = new SqlDataAdapter(q, con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_internships_by_domain(string domain, string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE c.c_email = '" + compEmail + "' AND i.InternshipDomain = '" + domain + "' ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public void delete_internship(int id, string compEmail)
        {
            getcon();
            cmd = new SqlCommand("DELETE FROM internship WHERE Id=" + id + " AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "')", con);
            cmd.ExecuteNonQuery();
        }

        // ==================== 3. INTERVIEWS ====================
        public DataSet fill_combo(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT a.ApplicationId, a.FullName + ' (' + i.InternshipTitle + ')' AS FullName FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE a.Status='Shortlisted' AND i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_interviews(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT civ.InterviewId, civ.ApplicationId, civ.InternshipId, civ.StudentId, civ.CompanyId, ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 120), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 23), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate), civ.CreatedDate))) AS InterviewDate, civ.InterviewTime, civ.InterviewType, civ.MeetingLink, civ.Location, civ.Notes, civ.Status, civ.CreatedDate, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(i.InternshipTitle, 'Interview Assessment') AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyInterviews civ LEFT JOIN StudentApplications a ON civ.ApplicationId = a.ApplicationId LEFT JOIN Students s ON civ.StudentId = s.StudentId LEFT JOIN internship i ON civ.InternshipId = i.Id WHERE civ.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_interviews()
        {
            getcon();
            da = new SqlDataAdapter("SELECT civ.InterviewId, civ.ApplicationId, civ.InternshipId, civ.StudentId, civ.CompanyId, ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 120), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 23), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate), civ.CreatedDate))) AS InterviewDate, civ.InterviewTime, civ.InterviewType, civ.MeetingLink, civ.Location, civ.Notes, civ.Status, civ.CreatedDate, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(i.InternshipTitle, 'Interview Assessment') AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyInterviews civ LEFT JOIN StudentApplications a ON civ.ApplicationId = a.ApplicationId LEFT JOIN Students s ON civ.StudentId = s.StudentId LEFT JOIN internship i ON civ.InternshipId = i.Id ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_interviews(string search, string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT civ.InterviewId, civ.ApplicationId, civ.InternshipId, civ.StudentId, civ.CompanyId, ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 120), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 23), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate), civ.CreatedDate))) AS InterviewDate, civ.InterviewTime, civ.InterviewType, civ.MeetingLink, civ.Location, civ.Notes, civ.Status, civ.CreatedDate, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(i.InternshipTitle, 'Interview Assessment') AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyInterviews civ LEFT JOIN StudentApplications a ON civ.ApplicationId = a.ApplicationId LEFT JOIN Students s ON civ.StudentId = s.StudentId LEFT JOIN internship i ON civ.InternshipId = i.Id WHERE civ.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND (ISNULL(a.FullName, s.FullName) LIKE '%" + search + "%' OR ISNULL(a.StudentEmail, s.Email) LIKE '%" + search + "%' OR i.InternshipTitle LIKE '%" + search + "%' OR civ.InterviewType LIKE '%" + search + "%') ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_interviews(string search)
        {
            getcon();
            da = new SqlDataAdapter("SELECT civ.InterviewId, civ.ApplicationId, civ.InternshipId, civ.StudentId, civ.CompanyId, ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 120), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 23), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate), civ.CreatedDate))) AS InterviewDate, civ.InterviewTime, civ.InterviewType, civ.MeetingLink, civ.Location, civ.Notes, civ.Status, civ.CreatedDate, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(i.InternshipTitle, 'Interview Assessment') AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyInterviews civ LEFT JOIN StudentApplications a ON civ.ApplicationId = a.ApplicationId LEFT JOIN Students s ON civ.StudentId = s.StudentId LEFT JOIN internship i ON civ.InternshipId = i.Id WHERE (ISNULL(a.FullName, s.FullName) LIKE '%" + search + "%' OR ISNULL(a.StudentEmail, s.Email) LIKE '%" + search + "%' OR i.InternshipTitle LIKE '%" + search + "%' OR civ.InterviewType LIKE '%" + search + "%') ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_interviews_by_status(string status, string compEmail)
        {
            getcon();
            if (status == "All" || string.IsNullOrEmpty(status))
            {
                return select_interviews(compEmail);
            }
            da = new SqlDataAdapter("SELECT civ.InterviewId, civ.ApplicationId, civ.InternshipId, civ.StudentId, civ.CompanyId, ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 120), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 23), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate), civ.CreatedDate))) AS InterviewDate, civ.InterviewTime, civ.InterviewType, civ.MeetingLink, civ.Location, civ.Notes, civ.Status, civ.CreatedDate, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(i.InternshipTitle, 'Interview Assessment') AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyInterviews civ LEFT JOIN StudentApplications a ON civ.ApplicationId = a.ApplicationId LEFT JOIN Students s ON civ.StudentId = s.StudentId LEFT JOIN internship i ON civ.InternshipId = i.Id WHERE civ.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND civ.Status = '" + status + "' ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_interviews_by_status(string status)
        {
            getcon();
            if (status == "All" || string.IsNullOrEmpty(status))
            {
                return select_interviews();
            }
            da = new SqlDataAdapter("SELECT civ.InterviewId, civ.ApplicationId, civ.InternshipId, civ.StudentId, civ.CompanyId, ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 120), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate, 23), ISNULL(TRY_CONVERT(DATETIME, civ.InterviewDate), civ.CreatedDate))) AS InterviewDate, civ.InterviewTime, civ.InterviewType, civ.MeetingLink, civ.Location, civ.Notes, civ.Status, civ.CreatedDate, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(i.InternshipTitle, 'Interview Assessment') AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyInterviews civ LEFT JOIN StudentApplications a ON civ.ApplicationId = a.ApplicationId LEFT JOIN Students s ON civ.StudentId = s.StudentId LEFT JOIN internship i ON civ.InternshipId = i.Id WHERE civ.Status = '" + status + "' ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public void insert_interview(int appId, string compEmail, string date, string time, string type, string linkLoc, string notes)
        {
            getcon();
            da = new SqlDataAdapter("select InternshipId, StudentId from StudentApplications where ApplicationId=" + appId, con);
            ds = new DataSet();
            da.Fill(ds);
            int internshipId = Convert.ToInt32(ds.Tables[0].Rows[0]["InternshipId"]);
            int studentId = Convert.ToInt32(ds.Tables[0].Rows[0]["StudentId"]);

            cmd = new SqlCommand("insert into CompanyInterviews (ApplicationId, InternshipId, StudentId, CompanyId, InterviewDate, InterviewTime, InterviewType, MeetingLink, Location, Notes, Status, CreatedDate) values (" + appId + ", " + internshipId + ", " + studentId + ", (select CompanyId from c_registration where c_email='" + compEmail + "'), '" + date + "', '" + time + "', '" + type + "', '" + linkLoc + "', '" + linkLoc + "', '" + notes + "', 'Scheduled', GETDATE())", con);
            cmd.ExecuteNonQuery();
        }

        public void update_interview_status(int interviewId, string status)
        {
            getcon();
            cmd = new SqlCommand("UPDATE CompanyInterviews SET Status='" + status + "' WHERE InterviewId=" + interviewId, con);
            cmd.ExecuteNonQuery();
        }

        public void delete_interview(int interviewId)
        {
            getcon();
            cmd = new SqlCommand("DELETE FROM CompanyInterviews WHERE InterviewId=" + interviewId, con);
            cmd.ExecuteNonQuery();
        }

        // ==================== 4. OFFER LETTERS ====================
        public DataSet fill_combo_offer(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT a.ApplicationId, a.FullName + ' (' + i.InternshipTitle + ')' AS FullName FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND a.Status IN ('Selected', 'Shortlisted') ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_offers(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT col.*, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(a.College, s.College) AS College, ISNULL(a.ContactNo, s.ContactNo) AS ContactNo, ISNULL(i.InternshipTitle, col.OfferTitle) AS InternshipTitle, ISNULL(NULLIF(col.Duration, ''), ISNULL(i.Duration, '3 Months')) AS Duration, ISNULL(NULLIF(col.WorkLocation, ''), ISNULL(i.Location, 'Ahmedabad')) AS Location, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyOfferLetters col LEFT JOIN StudentApplications a ON col.ApplicationId = a.ApplicationId LEFT JOIN Students s ON col.StudentId = s.StudentId LEFT JOIN internship i ON col.InternshipId = i.Id WHERE col.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') ORDER BY col.OfferId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_offers()
        {
            getcon();
            da = new SqlDataAdapter("SELECT col.*, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(a.College, s.College) AS College, ISNULL(a.ContactNo, s.ContactNo) AS ContactNo, ISNULL(i.InternshipTitle, col.OfferTitle) AS InternshipTitle, ISNULL(NULLIF(col.Duration, ''), ISNULL(i.Duration, '3 Months')) AS Duration, ISNULL(NULLIF(col.WorkLocation, ''), ISNULL(i.Location, 'Ahmedabad')) AS Location, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyOfferLetters col LEFT JOIN StudentApplications a ON col.ApplicationId = a.ApplicationId LEFT JOIN Students s ON col.StudentId = s.StudentId LEFT JOIN internship i ON col.InternshipId = i.Id ORDER BY col.OfferId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_offers(string search, string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT col.*, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(a.College, s.College) AS College, ISNULL(a.ContactNo, s.ContactNo) AS ContactNo, ISNULL(i.InternshipTitle, col.OfferTitle) AS InternshipTitle, ISNULL(NULLIF(col.Duration, ''), ISNULL(i.Duration, '3 Months')) AS Duration, ISNULL(NULLIF(col.WorkLocation, ''), ISNULL(i.Location, 'Ahmedabad')) AS Location, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyOfferLetters col LEFT JOIN StudentApplications a ON col.ApplicationId = a.ApplicationId LEFT JOIN Students s ON col.StudentId = s.StudentId LEFT JOIN internship i ON col.InternshipId = i.Id WHERE col.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND (ISNULL(a.FullName, s.FullName) LIKE '%" + search + "%' OR ISNULL(a.StudentEmail, s.Email) LIKE '%" + search + "%' OR col.OfferTitle LIKE '%" + search + "%' OR ISNULL(i.InternshipTitle, '') LIKE '%" + search + "%' OR col.WorkLocation LIKE '%" + search + "%') ORDER BY col.OfferId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_offers(string search)
        {
            getcon();
            da = new SqlDataAdapter("SELECT col.*, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(a.College, s.College) AS College, ISNULL(a.ContactNo, s.ContactNo) AS ContactNo, ISNULL(i.InternshipTitle, col.OfferTitle) AS InternshipTitle, ISNULL(NULLIF(col.Duration, ''), ISNULL(i.Duration, '3 Months')) AS Duration, ISNULL(NULLIF(col.WorkLocation, ''), ISNULL(i.Location, 'Ahmedabad')) AS Location, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyOfferLetters col LEFT JOIN StudentApplications a ON col.ApplicationId = a.ApplicationId LEFT JOIN Students s ON col.StudentId = s.StudentId LEFT JOIN internship i ON col.InternshipId = i.Id WHERE (ISNULL(a.FullName, s.FullName) LIKE '%" + search + "%' OR ISNULL(a.StudentEmail, s.Email) LIKE '%" + search + "%' OR col.OfferTitle LIKE '%" + search + "%' OR ISNULL(i.InternshipTitle, '') LIKE '%" + search + "%' OR col.WorkLocation LIKE '%" + search + "%') ORDER BY col.OfferId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_offers_by_status(string status, string compEmail)
        {
            getcon();
            if (status == "All" || string.IsNullOrEmpty(status))
            {
                return select_offers(compEmail);
            }
            da = new SqlDataAdapter("SELECT col.*, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(a.College, s.College) AS College, ISNULL(a.ContactNo, s.ContactNo) AS ContactNo, ISNULL(i.InternshipTitle, col.OfferTitle) AS InternshipTitle, ISNULL(NULLIF(col.Duration, ''), ISNULL(i.Duration, '3 Months')) AS Duration, ISNULL(NULLIF(col.WorkLocation, ''), ISNULL(i.Location, 'Ahmedabad')) AS Location, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyOfferLetters col LEFT JOIN StudentApplications a ON col.ApplicationId = a.ApplicationId LEFT JOIN Students s ON col.StudentId = s.StudentId LEFT JOIN internship i ON col.InternshipId = i.Id WHERE col.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND col.Status = '" + status + "' ORDER BY col.OfferId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_offers_by_status(string status)
        {
            getcon();
            if (status == "All" || string.IsNullOrEmpty(status))
            {
                return select_offers();
            }
            da = new SqlDataAdapter("SELECT col.*, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, ISNULL(a.College, s.College) AS College, ISNULL(a.ContactNo, s.ContactNo) AS ContactNo, ISNULL(i.InternshipTitle, col.OfferTitle) AS InternshipTitle, ISNULL(NULLIF(col.Duration, ''), ISNULL(i.Duration, '3 Months')) AS Duration, ISNULL(NULLIF(col.WorkLocation, ''), ISNULL(i.Location, 'Ahmedabad')) AS Location, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyOfferLetters col LEFT JOIN StudentApplications a ON col.ApplicationId = a.ApplicationId LEFT JOIN Students s ON col.StudentId = s.StudentId LEFT JOIN internship i ON col.InternshipId = i.Id WHERE col.Status = '" + status + "' ORDER BY col.OfferId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Aliases matching AdminClass offer letter naming
        public DataSet select_offer_letters(string compEmail) { return select_offers(compEmail); }
        public DataSet select_offer_letters() { return select_offers(); }
        public DataSet search_offer_letters(string nm, string compEmail) { return search_offers(nm, compEmail); }
        public DataSet search_offer_letters(string nm) { return search_offers(nm); }
        public DataSet select_offer_letters_by_status(string st, string compEmail) { return select_offers_by_status(st, compEmail); }
        public DataSet select_offer_letters_by_status(string st) { return select_offers_by_status(st); }

        public void insert_offer(int appId, string compEmail, string title, string stipend, string joinDate, string duration, string workLoc, string validTill)
        {
            getcon();
            da = new SqlDataAdapter("select InternshipId, StudentId from StudentApplications where ApplicationId=" + appId, con);
            ds = new DataSet();
            da.Fill(ds);
            int internshipId = Convert.ToInt32(ds.Tables[0].Rows[0]["InternshipId"]);
            int studentId = Convert.ToInt32(ds.Tables[0].Rows[0]["StudentId"]);

            cmd = new SqlCommand("insert into CompanyOfferLetters (ApplicationId, InternshipId, StudentId, CompanyId, OfferTitle, Stipend, JoiningDate, OfferLetterPath, Status, IssuedDate, Duration, WorkLocation, ValidTill) values (" + appId + ", " + internshipId + ", " + studentId + ", (select CompanyId from c_registration where c_email='" + compEmail + "'), '" + title + "', '" + stipend + "', '" + joinDate + "', 'TEMPLATE_GENERATED', 'Sent', GETDATE(), '" + duration + "', '" + workLoc + "', '" + validTill + "')", con);
            cmd.ExecuteNonQuery();

            cmd = new SqlCommand("update StudentApplications set Status='Selected' where ApplicationId=" + appId, con);
            cmd.ExecuteNonQuery();
        }

        public void update_offer(int offerId, string title, string stipend, string joinDate, string duration, string workLoc, string validTill)
        {
            getcon();
            cmd = new SqlCommand("update CompanyOfferLetters set OfferTitle='" + title + "', Stipend='" + stipend + "', JoiningDate='" + joinDate + "', Duration='" + duration + "', WorkLocation='" + workLoc + "', ValidTill='" + validTill + "' where OfferId=" + offerId, con);
            cmd.ExecuteNonQuery();
        }

        public void delete_offer(int offerId)
        {
            getcon();
            cmd = new SqlCommand("delete from CompanyOfferLetters where OfferId=" + offerId, con);
            cmd.ExecuteNonQuery();
        }

        // ==================== 5. CERTIFICATES ====================
        public DataSet fill_combo_certificate(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT a.ApplicationId, a.FullName + ' (' + i.InternshipTitle + ')' AS FullName FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND a.Status IN ('Completed', 'Selected', 'Offer Accepted', 'Accepted') ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_certificates(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT cc.*, ISNULL(a.FullName, ISNULL(s.FullName, cc.CandidateName)) AS FullName, ISNULL(a.StudentEmail, ISNULL(s.Email, '')) AS StudentEmail, ISNULL(a.College, ISNULL(s.College, cc.CandidateCollege)) AS College, ISNULL(a.ContactNo, ISNULL(s.ContactNo, '')) AS ContactNo, ISNULL(i.InternshipTitle, cc.InternshipRole) AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyCertificates cc LEFT JOIN StudentApplications a ON cc.ApplicationId = a.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR a.StudentId = s.StudentId OR a.StudentEmail = s.Email) LEFT JOIN internship i ON cc.InternshipId = i.Id WHERE cc.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) ORDER BY cc.CertificateId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_certificates()
        {
            getcon();
            da = new SqlDataAdapter("SELECT cc.*, ISNULL(a.FullName, ISNULL(s.FullName, cc.CandidateName)) AS FullName, ISNULL(a.StudentEmail, ISNULL(s.Email, '')) AS StudentEmail, ISNULL(a.College, ISNULL(s.College, cc.CandidateCollege)) AS College, ISNULL(a.ContactNo, ISNULL(s.ContactNo, '')) AS ContactNo, ISNULL(i.InternshipTitle, cc.InternshipRole) AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyCertificates cc LEFT JOIN StudentApplications a ON cc.ApplicationId = a.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR a.StudentId = s.StudentId OR a.StudentEmail = s.Email) LEFT JOIN internship i ON cc.InternshipId = i.Id WHERE (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) ORDER BY cc.CertificateId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_certificates(string search, string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT cc.*, ISNULL(a.FullName, ISNULL(s.FullName, cc.CandidateName)) AS FullName, ISNULL(a.StudentEmail, ISNULL(s.Email, '')) AS StudentEmail, ISNULL(a.College, ISNULL(s.College, cc.CandidateCollege)) AS College, ISNULL(a.ContactNo, ISNULL(s.ContactNo, '')) AS ContactNo, ISNULL(i.InternshipTitle, cc.InternshipRole) AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyCertificates cc LEFT JOIN StudentApplications a ON cc.ApplicationId = a.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR a.StudentId = s.StudentId OR a.StudentEmail = s.Email) LEFT JOIN internship i ON cc.InternshipId = i.Id WHERE cc.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) AND (ISNULL(a.FullName, ISNULL(s.FullName, cc.CandidateName)) LIKE '%" + search + "%' OR ISNULL(a.StudentEmail, ISNULL(s.Email, '')) LIKE '%" + search + "%' OR cc.CertificateNo LIKE '%" + search + "%' OR ISNULL(i.InternshipTitle, cc.InternshipRole) LIKE '%" + search + "%' OR cc.CertificateTitle LIKE '%" + search + "%') ORDER BY cc.CertificateId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_certificates(string search)
        {
            getcon();
            da = new SqlDataAdapter("SELECT cc.*, ISNULL(a.FullName, ISNULL(s.FullName, cc.CandidateName)) AS FullName, ISNULL(a.StudentEmail, ISNULL(s.Email, '')) AS StudentEmail, ISNULL(a.College, ISNULL(s.College, cc.CandidateCollege)) AS College, ISNULL(a.ContactNo, ISNULL(s.ContactNo, '')) AS ContactNo, ISNULL(i.InternshipTitle, cc.InternshipRole) AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyCertificates cc LEFT JOIN StudentApplications a ON cc.ApplicationId = a.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR a.StudentId = s.StudentId OR a.StudentEmail = s.Email) LEFT JOIN internship i ON cc.InternshipId = i.Id WHERE (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) AND (ISNULL(a.FullName, ISNULL(s.FullName, cc.CandidateName)) LIKE '%" + search + "%' OR ISNULL(a.StudentEmail, ISNULL(s.Email, '')) LIKE '%" + search + "%' OR cc.CertificateNo LIKE '%" + search + "%' OR ISNULL(i.InternshipTitle, cc.InternshipRole) LIKE '%" + search + "%' OR cc.CertificateTitle LIKE '%" + search + "%') ORDER BY cc.CertificateId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_certificates_by_status(string status, string compEmail)
        {
            getcon();
            if (status == "All" || string.IsNullOrEmpty(status))
            {
                return select_certificates(compEmail);
            }
            da = new SqlDataAdapter("SELECT cc.*, ISNULL(a.FullName, ISNULL(s.FullName, cc.CandidateName)) AS FullName, ISNULL(a.StudentEmail, ISNULL(s.Email, '')) AS StudentEmail, ISNULL(a.College, ISNULL(s.College, cc.CandidateCollege)) AS College, ISNULL(a.ContactNo, ISNULL(s.ContactNo, '')) AS ContactNo, ISNULL(i.InternshipTitle, cc.InternshipRole) AS InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM CompanyCertificates cc LEFT JOIN StudentApplications a ON cc.ApplicationId = a.ApplicationId LEFT JOIN Students s ON (cc.StudentId = s.StudentId OR a.StudentId = s.StudentId OR a.StudentEmail = s.Email) LEFT JOIN internship i ON cc.InternshipId = i.Id WHERE cc.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND (cc.IsDeleted = 0 OR cc.IsDeleted IS NULL) AND cc.Status = '" + status + "' ORDER BY cc.CertificateId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public void insert_certificate(int appId, string compEmail, string certTitle, string role, string duration, string issueDate, string performance, string signatory, string candName, string college)
        {
            getcon();

            da = new SqlDataAdapter("SELECT InternshipId, StudentId FROM StudentApplications WHERE ApplicationId=" + appId, con);
            ds = new DataSet();
            da.Fill(ds);

            int internshipId = Convert.ToInt32(ds.Tables[0].Rows[0]["InternshipId"]);
            int studentId = Convert.ToInt32(ds.Tables[0].Rows[0]["StudentId"]);

            string certNo = "CERT-" + DateTime.Now.Year + "-" + (Convert.ToInt32(new SqlCommand("SELECT ISNULL(MAX(CAST(RIGHT(CertificateNo, 4) AS INT)), 0) + 1 FROM CompanyCertificates WHERE CertificateNo LIKE 'CERT-" + DateTime.Now.Year + "-%'", con).ExecuteScalar())).ToString("D4");
            string verifyCode = Guid.NewGuid().ToString("N").Substring(0, 8).ToUpper();
            cmd = new SqlCommand("INSERT INTO CompanyCertificates (ApplicationId, InternshipId, StudentId, CompanyId, CertificateTitle, IssueDate, CertificatePath, Status, CreatedDate, CertificateNo, VerificationCode, IsDeleted, CandidateName, CandidateCollege, InternshipRole, Duration, Performance, SignatoryName) VALUES (" + appId + ", " + internshipId + ", " + studentId + ", (SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "'), '" + certTitle + "', '" + issueDate + "', 'TEMPLATE_GENERATED', 'Issued', GETDATE(), '" + certNo + "', '" + verifyCode + "', 0, '" + candName + "', '" + college + "', '" + role + "', '" + duration + "', '" + performance + "', '" + signatory + "')", con);
            cmd.ExecuteNonQuery();

            cmd = new SqlCommand("UPDATE StudentApplications SET Status='Completed' WHERE ApplicationId=" + appId, con);
            cmd.ExecuteNonQuery();
        }

        public void update_certificate(int certId, string certTitle, string role, string duration, string issueDate, string performance, string signatory, string candName, string college)
        {
            getcon();
            string q = "UPDATE CompanyCertificates SET CandidateName='" + candName + "', CandidateCollege='" + college + "', CertificateTitle='" + certTitle + "', InternshipRole='" + role + "', Duration='" + duration + "', IssueDate='" + issueDate + "', Performance='" + performance + "', SignatoryName='" + signatory + "' WHERE CertificateId=" + certId;
            cmd = new SqlCommand(q, con);
            cmd.ExecuteNonQuery();
        }

        public void delete_certificate(int certId)
        {
            getcon();
            cmd = new SqlCommand("DELETE FROM CompanyCertificates WHERE CertificateId=" + certId, con);
            cmd.ExecuteNonQuery();
        }

        // ==================== 6. FEEDBACK & REVIEWS ====================
        public DataSet select_feedback(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT pf.*, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN internship i ON pf.InternshipId = i.Id WHERE pf.SenderType='Student' AND pf.FeedbackType='Company' AND pf.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') ORDER BY pf.FeedbackId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_feedback()
        {
            getcon();
            da = new SqlDataAdapter("SELECT pf.*, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN internship i ON pf.InternshipId = i.Id WHERE pf.SenderType='Student' AND pf.FeedbackType='Company' ORDER BY pf.FeedbackId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_feedback(string search, string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT pf.*, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN internship i ON pf.InternshipId = i.Id WHERE pf.SenderType='Student' AND pf.FeedbackType='Company' AND pf.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND (pf.SenderName LIKE '%" + search + "%' OR pf.Subject LIKE '%" + search + "%' OR pf.Message LIKE '%" + search + "%' OR i.InternshipTitle LIKE '%" + search + "%') ORDER BY pf.FeedbackId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_sent_feedback(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM PlatformFeedback WHERE SenderType='Company' AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') ORDER BY FeedbackId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // ==================== 7. TASKS & QUIZZES ====================
        public DataSet select_tasks(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT cqa.*, q.QuizTitle, q.Topic, q.DurationMinutes, q.TotalQuestions, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle FROM CompanyQuizAssignments cqa INNER JOIN CompanyQuizzes q ON cqa.QuizId = q.QuizId INNER JOIN StudentApplications a ON cqa.ApplicationId = a.ApplicationId INNER JOIN internship i ON a.InternshipId = i.Id LEFT JOIN Students s ON a.StudentId = s.StudentId WHERE cqa.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') ORDER BY cqa.AssignmentId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_tasks()
        {
            getcon();
            da = new SqlDataAdapter("SELECT cqa.*, q.QuizTitle, q.Topic, q.DurationMinutes, q.TotalQuestions, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle FROM CompanyQuizAssignments cqa INNER JOIN CompanyQuizzes q ON cqa.QuizId = q.QuizId INNER JOIN StudentApplications a ON cqa.ApplicationId = a.ApplicationId INNER JOIN internship i ON a.InternshipId = i.Id LEFT JOIN Students s ON a.StudentId = s.StudentId ORDER BY cqa.AssignmentId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_tasks(string search, string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT cqa.*, q.QuizTitle, q.Topic, q.DurationMinutes, q.TotalQuestions, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle FROM CompanyQuizAssignments cqa INNER JOIN CompanyQuizzes q ON cqa.QuizId = q.QuizId INNER JOIN StudentApplications a ON cqa.ApplicationId = a.ApplicationId INNER JOIN internship i ON a.InternshipId = i.Id LEFT JOIN Students s ON a.StudentId = s.StudentId WHERE cqa.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') AND (ISNULL(a.FullName, s.FullName) LIKE '%" + search + "%' OR q.QuizTitle LIKE '%" + search + "%' OR q.Topic LIKE '%" + search + "%' OR i.InternshipTitle LIKE '%" + search + "%') ORDER BY cqa.AssignmentId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // ==================== 8. PAGINATION (ADMIN CLASS STYLE) ====================
        public DataTable applicant_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int pageSize = 5;
            int start = page * pageSize;
            for (int i = start; i < start + pageSize && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable application_pagination(DataTable dt, int page)
        {
            return applicant_pagination(dt, page);
        }

        public DataTable internship_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int pageSize = 5;
            int start = page * pageSize;
            for (int i = start; i < start + pageSize && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable interview_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int pageSize = 5;
            int start = page * pageSize;
            for (int i = start; i < start + pageSize && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable offer_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int pageSize = 5;
            int start = page * pageSize;
            for (int i = start; i < start + pageSize && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable offer_letter_pagination(DataTable dt, int page)
        {
            return offer_pagination(dt, page);
        }

        public DataTable certificate_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int pageSize = 5;
            int start = page * pageSize;
            for (int i = start; i < start + pageSize && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable feedback_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int pageSize = 5;
            int start = page * pageSize;
            for (int i = start; i < start + pageSize && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable task_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int pageSize = 5;
            int start = page * pageSize;
            for (int i = start; i < start + pageSize && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }
    }
}

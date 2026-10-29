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

        // ==================== APPLICANTS ====================
        // Select all applicants
        public DataSet select_applicants()
        {
            getcon();
            da = new SqlDataAdapter("select a.*, ISNULL(a.Status, 'Applied') AS Status, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id left join Students s on a.StudentId=s.StudentId order by a.ApplicationId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Search applicants by Name (also email, title)
        public DataSet search_applicants(string nm)
        {
            getcon();
            da = new SqlDataAdapter("select a.*, ISNULL(a.Status, 'Applied') AS Status, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id left join Students s on a.StudentId=s.StudentId where (a.FullName like '%" + nm + "%' or a.StudentEmail like '%" + nm + "%' or i.InternshipTitle like '%" + nm + "%') order by a.ApplicationId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select applicants by Status
        public DataSet select_applicants_by_status(string st)
        {
            getcon();
            if (st == "All" || string.IsNullOrEmpty(st))
            {
                da = new SqlDataAdapter("select a.*, ISNULL(a.Status, 'Applied') AS Status, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id left join Students s on a.StudentId=s.StudentId order by a.ApplicationId desc", con);
            }
            else if (st == "Applied")
            {
                da = new SqlDataAdapter("select a.*, ISNULL(a.Status, 'Applied') AS Status, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id left join Students s on a.StudentId=s.StudentId where (a.Status='Applied' or a.Status is null or a.Status='Pending') order by a.ApplicationId desc", con);
            }
            else
            {
                da = new SqlDataAdapter("select a.*, ISNULL(a.Status, 'Applied') AS Status, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id left join Students s on a.StudentId=s.StudentId where a.Status='" + st + "' order by a.ApplicationId desc", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Pagination for applicants
        public DataTable applicant_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int pageSize = 4;
            int start = page * pageSize;
            for (int i = start; i < start + pageSize && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }
        // ==================== INTERVIEWS (2-TIER) ====================
        public DataSet fill_combo(string compEmail)
        {
            getcon();
            da = new SqlDataAdapter("SELECT a.ApplicationId, a.FullName + ' (' + i.InternshipTitle + ')' AS FullName FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE a.Status='Shortlisted' AND i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + compEmail + "') ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet fillcombo(string compEmail)
        {
            return fill_combo(compEmail);
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

        public void schedule_interview(int appId, string compEmail, string date, string time, string type, string linkLoc, string notes)
        {
            insert_interview(appId, compEmail, date, time, type, linkLoc, notes);
        }

        // ==================== OFFER LETTERS (2-TIER) ====================
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
    }
}

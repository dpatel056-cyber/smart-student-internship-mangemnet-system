using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public class AdminClass
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        public SqlConnection getcon()
        {
            con = new SqlConnection(s);
            con.Open();
            return con;
        }

        // ==================== 1. STUDENTS ====================
        public DataSet select_students()
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM Students ORDER BY StudentId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Search students by keyword (matching search_internship method)
        public DataSet search_students(string nm)
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM Students WHERE (FullName LIKE '%" + nm + "%' OR Email LIKE '%" + nm + "%' OR CAST(StudentId AS VARCHAR) LIKE '%" + nm + "%' OR EnrollmentNo LIKE '%" + nm + "%' OR ContactNo LIKE '%" + nm + "%' OR College LIKE '%" + nm + "%' OR Course LIKE '%" + nm + "%') ORDER BY StudentId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select students by course (matching select_internship_by_category method)
        public DataSet select_students_by_course(string crs)
        {
            getcon();
            if (crs == "All")
            {
                da = new SqlDataAdapter("SELECT * FROM Students ORDER BY StudentId DESC", con);
            }
            else
            {
                da = new SqlDataAdapter("SELECT * FROM Students WHERE Course = '" + crs + "' ORDER BY StudentId DESC", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select students by status
        public DataSet select_students_by_status(string st)
        {
            getcon();
            if (st == "All")
            {
                da = new SqlDataAdapter("SELECT * FROM Students ORDER BY StudentId DESC", con);
            }
            else if (st == "Blocked")
            {
                da = new SqlDataAdapter("SELECT * FROM Students WHERE IsBlocked = 1 ORDER BY StudentId DESC", con);
            }
            else // Active
            {
                da = new SqlDataAdapter("SELECT * FROM Students WHERE (IsBlocked = 0 OR IsBlocked IS NULL) ORDER BY StudentId DESC", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // ==================== 2. COMPANIES ====================
        public DataSet select_companies()
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM c_registration ORDER BY CompanyId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_companies(string search)
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM c_registration WHERE (c_company LIKE '%" + search + "%' OR c_email LIKE '%" + search + "%' OR c_contact LIKE '%" + search + "%' OR c_industry LIKE '%" + search + "%' OR c_location LIKE '%" + search + "%') ORDER BY CompanyId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_companies_by_industry(string industry)
        {
            getcon();
            if (industry == "All")
            {
                da = new SqlDataAdapter("SELECT * FROM c_registration ORDER BY CompanyId DESC", con);
            }
            else
            {
                da = new SqlDataAdapter("SELECT * FROM c_registration WHERE c_industry = '" + industry + "' ORDER BY CompanyId DESC", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_companies_by_location(string location)
        {
            getcon();
            if (location == "All")
            {
                da = new SqlDataAdapter("SELECT * FROM c_registration ORDER BY CompanyId DESC", con);
            }
            else
            {
                da = new SqlDataAdapter("SELECT * FROM c_registration WHERE c_location = '" + location + "' ORDER BY CompanyId DESC", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_companies_by_status(string status)
        {
            getcon();
            if (status == "All")
            {
                da = new SqlDataAdapter("SELECT * FROM c_registration ORDER BY CompanyId DESC", con);
            }
            else if (status == "Blocked")
            {
                da = new SqlDataAdapter("SELECT * FROM c_registration WHERE (IsBlocked = 1 OR Status = 'Blocked') ORDER BY CompanyId DESC", con);
            }
            else // Active
            {
                da = new SqlDataAdapter("SELECT * FROM c_registration WHERE ((IsBlocked = 0 OR IsBlocked IS NULL) AND (Status != 'Blocked' OR Status IS NULL)) ORDER BY CompanyId DESC", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // ==================== 3. INTERNSHIPS ====================
        public DataSet select_internships()
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }
        public DataSet search_internships(string search)
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE (i.InternshipTitle LIKE '%" + search + "%' OR i.RequiredSkills LIKE '%" + search + "%' OR c.c_company LIKE '%" + search + "%' OR i.InternshipDomain LIKE '%" + search + "%' OR i.Location LIKE '%" + search + "%') ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_internships_by_domain(string domain)
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE i.InternshipDomain = '" + domain + "' ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_internships_by_location(string location)
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE i.Location = '" + location + "' ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_internships_by_workmode(string workmode)
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE i.WorkMode = '" + workmode + "' ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_internships_by_type(string type)
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE i.InternshipType = '" + type + "' ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_internships_by_status(string status)
        {
            getcon();
            if (status == "All")
            {
                da = new SqlDataAdapter("SELECT i.*, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId ORDER BY i.Id DESC", con);
            }
            else if (status == "Inactive")
            {
                da = new SqlDataAdapter("SELECT i.*, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE i.Status = 'Inactive' ORDER BY i.Id DESC", con);
            }
            else // Active
            {
                da = new SqlDataAdapter("SELECT i.*, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo, c.c_industry FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE (i.Status = 'Active' OR i.Status IS NULL) ORDER BY i.Id DESC", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // ==================== 4. APPLICATIONS ====================
        public DataSet select_applications()
        {
            getcon();
            da = new SqlDataAdapter("SELECT a.*, i.InternshipTitle, ISNULL(c.c_company, 'N/A') AS c_company, ISNULL(c.c_industry, 'General') AS c_industry, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto ELSE '~/student_images/' + s.ProfilePhoto END AS ProfilePhoto FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id INNER JOIN c_registration c ON i.CompanyId = c.CompanyId INNER JOIN Students s ON a.StudentId = s.StudentId ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Search applications by keyword (Full Name, Email, Internship Title, Company)
        public DataSet search_applications(string nm)
        {
            getcon();
            da = new SqlDataAdapter("SELECT a.*, i.InternshipTitle, ISNULL(c.c_company, 'N/A') AS c_company, ISNULL(c.c_industry, 'General') AS c_industry, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto ELSE '~/student_images/' + s.ProfilePhoto END AS ProfilePhoto FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id INNER JOIN c_registration c ON i.CompanyId = c.CompanyId INNER JOIN Students s ON a.StudentId = s.StudentId WHERE (s.FullName LIKE '%" + nm + "%' OR s.Email LIKE '%" + nm + "%' OR i.InternshipTitle LIKE '%" + nm + "%' OR c.c_company LIKE '%" + nm + "%') ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select applications by status
        public DataSet select_applications_by_status(string st)
        {
            getcon();
            if (st == "All")
            {
                da = new SqlDataAdapter("SELECT a.*, i.InternshipTitle, ISNULL(c.c_company, 'N/A') AS c_company, ISNULL(c.c_industry, 'General') AS c_industry, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto ELSE '~/student_images/' + s.ProfilePhoto END AS ProfilePhoto FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id INNER JOIN c_registration c ON i.CompanyId = c.CompanyId INNER JOIN Students s ON a.StudentId = s.StudentId ORDER BY a.ApplicationId DESC", con);
            }
            else if (st == "Pending")
            {
                da = new SqlDataAdapter("SELECT a.*, i.InternshipTitle, ISNULL(c.c_company, 'N/A') AS c_company, ISNULL(c.c_industry, 'General') AS c_industry, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto ELSE '~/student_images/' + s.ProfilePhoto END AS ProfilePhoto FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id INNER JOIN c_registration c ON i.CompanyId = c.CompanyId INNER JOIN Students s ON a.StudentId = s.StudentId WHERE (a.Status = 'Pending' OR a.Status = 'Applied' OR a.Status IS NULL OR a.Status NOT IN ('Shortlisted', 'Selected', 'Rejected')) ORDER BY a.ApplicationId DESC", con);
            }
            else
            {
                da = new SqlDataAdapter("SELECT a.*, i.InternshipTitle, ISNULL(c.c_company, 'N/A') AS c_company, ISNULL(c.c_industry, 'General') AS c_industry, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto ELSE '~/student_images/' + s.ProfilePhoto END AS ProfilePhoto FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id INNER JOIN c_registration c ON i.CompanyId = c.CompanyId INNER JOIN Students s ON a.StudentId = s.StudentId WHERE a.Status = '" + st + "' ORDER BY a.ApplicationId DESC", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // ==================== 5. INTERVIEWS ====================
        public DataSet select_interviews()
        {
            getcon();
            da = new SqlDataAdapter("SELECT civ.*, s.FullName, s.Email AS StudentEmail, i.InternshipTitle, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo FROM CompanyInterviews civ INNER JOIN Students s ON civ.StudentId = s.StudentId INNER JOIN internship i ON civ.InternshipId = i.Id INNER JOIN c_registration c ON civ.CompanyId = c.CompanyId ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_interviews(string search)
        {
            getcon();
            da = new SqlDataAdapter("SELECT civ.*, s.FullName, s.Email AS StudentEmail, i.InternshipTitle, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo FROM CompanyInterviews civ INNER JOIN Students s ON civ.StudentId = s.StudentId INNER JOIN internship i ON civ.InternshipId = i.Id INNER JOIN c_registration c ON civ.CompanyId = c.CompanyId WHERE (s.FullName LIKE '%" + search + "%' OR s.Email LIKE '%" + search + "%' OR i.InternshipTitle LIKE '%" + search + "%' OR c.c_company LIKE '%" + search + "%') ORDER BY civ.InterviewId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_interviews_by_status(string status)
        {
            getcon();
            if (status == "All")
            {
                da = new SqlDataAdapter("SELECT civ.*, s.FullName, s.Email AS StudentEmail, i.InternshipTitle, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo FROM CompanyInterviews civ INNER JOIN Students s ON civ.StudentId = s.StudentId INNER JOIN internship i ON civ.InternshipId = i.Id INNER JOIN c_registration c ON civ.CompanyId = c.CompanyId ORDER BY civ.InterviewId DESC", con);
            }
            else
            {
                da = new SqlDataAdapter("SELECT civ.*, s.FullName, s.Email AS StudentEmail, i.InternshipTitle, c.c_company, CASE WHEN c.c_logo LIKE '~/%' THEN c.c_logo WHEN c.c_logo IS NOT NULL AND c.c_logo <> '' THEN '~/compnay_images/' + c.c_logo ELSE '~/compnay_images/default-company.png' END AS c_logo FROM CompanyInterviews civ INNER JOIN Students s ON civ.StudentId = s.StudentId INNER JOIN internship i ON civ.InternshipId = i.Id INNER JOIN c_registration c ON civ.CompanyId = c.CompanyId WHERE civ.Status = '" + status + "' ORDER BY civ.InterviewId DESC", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

// ==================== 6. CERTIFICATES ====================
        public DataSet select_certificates()
        {
            getcon();
            da = new SqlDataAdapter("SELECT cc.*, s.FullName, s.Email AS StudentEmail, c.c_company, i.InternshipTitle FROM CompanyCertificates cc INNER JOIN Students s ON cc.StudentId = s.StudentId INNER JOIN c_registration c ON cc.CompanyId = c.CompanyId LEFT JOIN internship i ON cc.InternshipId = i.Id ORDER BY cc.CertificateId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }
        public DataSet search_certificates(string search)
        {
            getcon();
            da = new SqlDataAdapter("SELECT cc.*, s.FullName, s.Email AS StudentEmail, c.c_company, i.InternshipTitle FROM CompanyCertificates cc INNER JOIN Students s ON cc.StudentId = s.StudentId INNER JOIN c_registration c ON cc.CompanyId = c.CompanyId LEFT JOIN internship i ON cc.InternshipId = i.Id WHERE (s.FullName LIKE '%" + search + "%' OR s.Email LIKE '%" + search + "%' OR cc.CertificateNo LIKE '%" + search + "%' OR c.c_company LIKE '%" + search + "%' OR i.InternshipTitle LIKE '%" + search + "%' OR cc.CertificateTitle LIKE '%" + search + "%') ORDER BY cc.CertificateId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // ==================== 7. FEEDBACK & RATINGS ====================
        public DataSet select_feedback()
        {
            getcon();
            da = new SqlDataAdapter("SELECT pf.*, c.c_company, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN c_registration c ON pf.CompanyId = c.CompanyId LEFT JOIN internship i ON pf.InternshipId = i.Id ORDER BY pf.FeedbackId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_feedback(string search)
        {
            getcon();
            da = new SqlDataAdapter("SELECT pf.*, c.c_company, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN c_registration c ON pf.CompanyId = c.CompanyId LEFT JOIN internship i ON pf.InternshipId = i.Id WHERE (pf.SenderName LIKE '%" + search + "%' OR pf.SenderEmail LIKE '%" + search + "%' OR pf.Subject LIKE '%" + search + "%' OR pf.Message LIKE '%" + search + "%' OR c.c_company LIKE '%" + search + "%' OR i.InternshipTitle LIKE '%" + search + "%') ORDER BY pf.FeedbackId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet select_feedback_by_type(string filterType)
        {
            getcon();
            if (filterType == "All")
            {
                da = new SqlDataAdapter("SELECT pf.*, c.c_company, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN c_registration c ON pf.CompanyId = c.CompanyId LEFT JOIN internship i ON pf.InternshipId = i.Id ORDER BY pf.FeedbackId DESC", con);
            }
            else if (filterType == "StudentCompany")
            {
                da = new SqlDataAdapter("SELECT pf.*, c.c_company, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN c_registration c ON pf.CompanyId = c.CompanyId LEFT JOIN internship i ON pf.InternshipId = i.Id WHERE pf.SenderType = 'Student' AND pf.CompanyId IS NOT NULL ORDER BY pf.FeedbackId DESC", con);
            }
            else if (filterType == "StudentGeneral")
            {
                da = new SqlDataAdapter("SELECT pf.*, c.c_company, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN c_registration c ON pf.CompanyId = c.CompanyId LEFT JOIN internship i ON pf.InternshipId = i.Id WHERE pf.SenderType = 'Student' AND (pf.CompanyId IS NULL OR pf.FeedbackCategory = 'General Platform') ORDER BY pf.FeedbackId DESC", con);
            }
            else // CompanyGeneral
            {
                da = new SqlDataAdapter("SELECT pf.*, c.c_company, i.InternshipTitle FROM PlatformFeedback pf LEFT JOIN c_registration c ON pf.CompanyId = c.CompanyId LEFT JOIN internship i ON pf.InternshipId = i.Id WHERE pf.SenderType = 'Company' ORDER BY pf.FeedbackId DESC", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // ==================== 8. CONTACT MESSAGES ====================
        public DataSet select_contact_messages()
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM cont ORDER BY Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataSet search_contact_messages(string search)
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM cont WHERE (c_name LIKE '%" + search + "%' OR c_email LIKE '%" + search + "%' OR c_subject LIKE '%" + search + "%' OR c_message LIKE '%" + search + "%') ORDER BY Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // ==================== 9. PAGINATION ====================
        public DataTable student_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int start = page * 5;
            for (int i = start; i < start + 5 && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable application_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int start = page * 3;
            for (int i = start; i < start + 3 && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable company_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int start = page * 3;
            for (int i = start; i < start + 3 && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable internship_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int start = page * 12;
            for (int i = start; i < start + 12 && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable interview_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int start = page * 3;
            for (int i = start; i < start + 3 && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable certificate_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int start = page * 5;
            for (int i = start; i < start + 5 && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable contact_message_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int start = page * 5;
            for (int i = start; i < start + 5 && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }

        public DataTable feedback_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int start = page * 5;
            for (int i = start; i < start + 5 && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }
        // ==================== 10. OFFER LETTERS ====================
        // Select all offer letters
        public DataSet select_offer_letters()
        {
            getcon();
            da = new SqlDataAdapter("SELECT o.OfferId, o.ApplicationId, o.InternshipId, o.StudentId, o.CompanyId, o.OfferTitle, o.Stipend, o.JoiningDate, o.OfferLetterPath, o.Status, o.IssuedDate, o.Duration, o.WorkLocation, o.ValidTill, o.AdditionalNotes, ISNULL(s.FullName, 'Student #' + CAST(o.StudentId AS VARCHAR)) AS FullName, ISNULL(s.Email, 'N/A') AS StudentEmail, ISNULL(s.ContactNo, 'N/A') AS StudentContact, ISNULL(s.College, 'N/A') AS College, ISNULL(c.c_company, 'Company #' + CAST(o.CompanyId AS VARCHAR)) AS c_company, c.c_logo, c.c_location, ISNULL(c.c_email, 'N/A') AS CompanyEmail, ISNULL(c.c_contact, 'N/A') AS CompanyContact, ISNULL(c.c_website, 'N/A') AS CompanyWebsite, ISNULL(c.c_hr_name, 'HR Department') AS CompanyHrName, ISNULL(i.InternshipTitle, o.OfferTitle) AS InternshipTitle FROM CompanyOfferLetters o LEFT JOIN Students s ON o.StudentId = s.StudentId LEFT JOIN c_registration c ON o.CompanyId = c.CompanyId LEFT JOIN internship i ON o.InternshipId = i.Id ORDER BY o.OfferId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Search offer letters by keyword
        public DataSet search_offer_letters(string nm)
        {
            getcon();
            da = new SqlDataAdapter("SELECT o.OfferId, o.ApplicationId, o.InternshipId, o.StudentId, o.CompanyId, o.OfferTitle, o.Stipend, o.JoiningDate, o.OfferLetterPath, o.Status, o.IssuedDate, o.Duration, o.WorkLocation, o.ValidTill, o.AdditionalNotes, ISNULL(s.FullName, 'Student #' + CAST(o.StudentId AS VARCHAR)) AS FullName, ISNULL(s.Email, 'N/A') AS StudentEmail, ISNULL(s.ContactNo, 'N/A') AS StudentContact, ISNULL(s.College, 'N/A') AS College, ISNULL(c.c_company, 'Company #' + CAST(o.CompanyId AS VARCHAR)) AS c_company, c.c_logo, c.c_location, ISNULL(c.c_email, 'N/A') AS CompanyEmail, ISNULL(c.c_contact, 'N/A') AS CompanyContact, ISNULL(c.c_website, 'N/A') AS CompanyWebsite, ISNULL(c.c_hr_name, 'HR Department') AS CompanyHrName, ISNULL(i.InternshipTitle, o.OfferTitle) AS InternshipTitle FROM CompanyOfferLetters o LEFT JOIN Students s ON o.StudentId = s.StudentId LEFT JOIN c_registration c ON o.CompanyId = c.CompanyId LEFT JOIN internship i ON o.InternshipId = i.Id WHERE (o.OfferTitle LIKE '%" + nm + "%' OR s.FullName LIKE '%" + nm + "%' OR s.Email LIKE '%" + nm + "%' OR c.c_company LIKE '%" + nm + "%' OR o.Status LIKE '%" + nm + "%' OR o.Stipend LIKE '%" + nm + "%' OR i.InternshipTitle LIKE '%" + nm + "%' OR s.College LIKE '%" + nm + "%' OR o.WorkLocation LIKE '%" + nm + "%') ORDER BY o.OfferId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // Select offer letters by status
        public DataSet select_offer_letters_by_status(string st)
        {
            getcon();
            if (st == "All")
            {
                da = new SqlDataAdapter("SELECT o.OfferId, o.ApplicationId, o.InternshipId, o.StudentId, o.CompanyId, o.OfferTitle, o.Stipend, o.JoiningDate, o.OfferLetterPath, o.Status, o.IssuedDate, o.Duration, o.WorkLocation, o.ValidTill, o.AdditionalNotes, ISNULL(s.FullName, 'Student #' + CAST(o.StudentId AS VARCHAR)) AS FullName, ISNULL(s.Email, 'N/A') AS StudentEmail, ISNULL(s.ContactNo, 'N/A') AS StudentContact, ISNULL(s.College, 'N/A') AS College, ISNULL(c.c_company, 'Company #' + CAST(o.CompanyId AS VARCHAR)) AS c_company, c.c_logo, c.c_location, ISNULL(c.c_email, 'N/A') AS CompanyEmail, ISNULL(c.c_contact, 'N/A') AS CompanyContact, ISNULL(c.c_website, 'N/A') AS CompanyWebsite, ISNULL(c.c_hr_name, 'HR Department') AS CompanyHrName, ISNULL(i.InternshipTitle, o.OfferTitle) AS InternshipTitle FROM CompanyOfferLetters o LEFT JOIN Students s ON o.StudentId = s.StudentId LEFT JOIN c_registration c ON o.CompanyId = c.CompanyId LEFT JOIN internship i ON o.InternshipId = i.Id ORDER BY o.OfferId DESC", con);
            }
            else if (st == "Offered")
            {
                da = new SqlDataAdapter("SELECT o.OfferId, o.ApplicationId, o.InternshipId, o.StudentId, o.CompanyId, o.OfferTitle, o.Stipend, o.JoiningDate, o.OfferLetterPath, o.Status, o.IssuedDate, o.Duration, o.WorkLocation, o.ValidTill, o.AdditionalNotes, ISNULL(s.FullName, 'Student #' + CAST(o.StudentId AS VARCHAR)) AS FullName, ISNULL(s.Email, 'N/A') AS StudentEmail, ISNULL(s.ContactNo, 'N/A') AS StudentContact, ISNULL(s.College, 'N/A') AS College, ISNULL(c.c_company, 'Company #' + CAST(o.CompanyId AS VARCHAR)) AS c_company, c.c_logo, c.c_location, ISNULL(c.c_email, 'N/A') AS CompanyEmail, ISNULL(c.c_contact, 'N/A') AS CompanyContact, ISNULL(c.c_website, 'N/A') AS CompanyWebsite, ISNULL(c.c_hr_name, 'HR Department') AS CompanyHrName, ISNULL(i.InternshipTitle, o.OfferTitle) AS InternshipTitle FROM CompanyOfferLetters o LEFT JOIN Students s ON o.StudentId = s.StudentId LEFT JOIN c_registration c ON o.CompanyId = c.CompanyId LEFT JOIN internship i ON o.InternshipId = i.Id WHERE (o.Status = 'Offered' OR o.Status = 'Pending') ORDER BY o.OfferId DESC", con);
            }
            else if (st == "Rejected")
            {
                da = new SqlDataAdapter("SELECT o.OfferId, o.ApplicationId, o.InternshipId, o.StudentId, o.CompanyId, o.OfferTitle, o.Stipend, o.JoiningDate, o.OfferLetterPath, o.Status, o.IssuedDate, o.Duration, o.WorkLocation, o.ValidTill, o.AdditionalNotes, ISNULL(s.FullName, 'Student #' + CAST(o.StudentId AS VARCHAR)) AS FullName, ISNULL(s.Email, 'N/A') AS StudentEmail, ISNULL(s.ContactNo, 'N/A') AS StudentContact, ISNULL(s.College, 'N/A') AS College, ISNULL(c.c_company, 'Company #' + CAST(o.CompanyId AS VARCHAR)) AS c_company, c.c_logo, c.c_location, ISNULL(c.c_email, 'N/A') AS CompanyEmail, ISNULL(c.c_contact, 'N/A') AS CompanyContact, ISNULL(c.c_website, 'N/A') AS CompanyWebsite, ISNULL(c.c_hr_name, 'HR Department') AS CompanyHrName, ISNULL(i.InternshipTitle, o.OfferTitle) AS InternshipTitle FROM CompanyOfferLetters o LEFT JOIN Students s ON o.StudentId = s.StudentId LEFT JOIN c_registration c ON o.CompanyId = c.CompanyId LEFT JOIN internship i ON o.InternshipId = i.Id WHERE (o.Status = 'Rejected' OR o.Status = 'Declined' OR o.Status = 'Withdrawn') ORDER BY o.OfferId DESC", con);
            }
            else
            {
                da = new SqlDataAdapter("SELECT o.OfferId, o.ApplicationId, o.InternshipId, o.StudentId, o.CompanyId, o.OfferTitle, o.Stipend, o.JoiningDate, o.OfferLetterPath, o.Status, o.IssuedDate, o.Duration, o.WorkLocation, o.ValidTill, o.AdditionalNotes, ISNULL(s.FullName, 'Student #' + CAST(o.StudentId AS VARCHAR)) AS FullName, ISNULL(s.Email, 'N/A') AS StudentEmail, ISNULL(s.ContactNo, 'N/A') AS StudentContact, ISNULL(s.College, 'N/A') AS College, ISNULL(c.c_company, 'Company #' + CAST(o.CompanyId AS VARCHAR)) AS c_company, c.c_logo, c.c_location, ISNULL(c.c_email, 'N/A') AS CompanyEmail, ISNULL(c.c_contact, 'N/A') AS CompanyContact, ISNULL(c.c_website, 'N/A') AS CompanyWebsite, ISNULL(c.c_hr_name, 'HR Department') AS CompanyHrName, ISNULL(i.InternshipTitle, o.OfferTitle) AS InternshipTitle FROM CompanyOfferLetters o LEFT JOIN Students s ON o.StudentId = s.StudentId LEFT JOIN c_registration c ON o.CompanyId = c.CompanyId LEFT JOIN internship i ON o.InternshipId = i.Id WHERE o.Status = '" + st + "' ORDER BY o.OfferId DESC", con);
            }
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        public DataTable offer_letter_pagination(DataTable dt, int page)
        {
            DataTable dt2 = dt.Clone();
            int pageSize = 6;
            int start = page * pageSize;
            for (int i = start; i < start + pageSize && i < dt.Rows.Count; i++)
            {
                dt2.ImportRow(dt.Rows[i]);
            }
            return dt2;
        }
    }
}

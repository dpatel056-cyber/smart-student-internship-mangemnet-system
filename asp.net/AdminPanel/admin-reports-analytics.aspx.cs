using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
namespace asp.net
{
    public partial class ReportsAnalytics : System.Web.UI.Page
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
                loadAnalytics();
                // Chart 1: Students and Companies
                LoadChart(Chart1, "WITH M AS (SELECT DATEADD(MONTH, -N, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)) AS D FROM (VALUES (5),(4),(3),(2),(1),(0)) V(N)) SELECT FORMAT(D, 'MMM') AS Month, (SELECT COUNT(*) FROM Students WHERE RegistrationDate >= D AND RegistrationDate < DATEADD(MONTH, 1, D)) AS Students, (SELECT COUNT(*) FROM c_registration WHERE RegistrationDate >= D AND RegistrationDate < DATEADD(MONTH, 1, D)) AS Companies FROM M ORDER BY D");
                // Chart 2: Applications by Month
                LoadChart(Chart2, "WITH M AS (SELECT DATEADD(MONTH, -N, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)) AS D FROM (VALUES (5),(4),(3),(2),(1),(0)) V(N)) SELECT FORMAT(D, 'MMM') AS Month, (SELECT COUNT(*) FROM StudentApplications WHERE AppliedDate >= D AND AppliedDate < DATEADD(MONTH, 1, D)) AS Total FROM M ORDER BY D");
                // Chart 3: Application Status
                LoadChart(Chart3, "SELECT CASE WHEN Status = 'Selected' THEN 'Selected' WHEN Status = 'Shortlisted' THEN 'Shortlisted' WHEN Status = 'Rejected' THEN 'Rejected' ELSE 'Pending' END AS Status, COUNT(*) AS Total FROM StudentApplications GROUP BY CASE WHEN Status = 'Selected' THEN 'Selected' WHEN Status = 'Shortlisted' THEN 'Shortlisted' WHEN Status = 'Rejected' THEN 'Rejected' ELSE 'Pending' END");
                // Chart 4: Internships by Domain
                LoadChart(Chart4, "SELECT TOP 6 ISNULL(NULLIF(InternshipDomain, ''), 'Other') AS Domain, COUNT(*) AS Total FROM internship GROUP BY ISNULL(NULLIF(InternshipDomain, ''), 'Other') ORDER BY Total DESC");
                // Chart 5: Company Applications
                LoadChart(Chart5, "SELECT TOP 6 c.c_company AS Company, COUNT(a.ApplicationId) AS AppCount FROM c_registration c LEFT JOIN internship i ON c.CompanyId = i.CompanyId LEFT JOIN StudentApplications a ON i.Id = a.InternshipId GROUP BY c.CompanyId, c.c_company ORDER BY AppCount DESC");
                // Chart 6: Work Mode
                LoadChart(Chart6, "SELECT ISNULL(NULLIF(WorkMode, ''), 'On-site') AS WorkMode, COUNT(*) AS Total FROM internship GROUP BY ISNULL(NULLIF(WorkMode, ''), 'On-site') ORDER BY Total DESC");
                // Chart 7: Monthly Application Status
                LoadChart(Chart7, "WITH M AS (SELECT DATEADD(MONTH, -N, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)) AS D FROM (VALUES (5),(4),(3),(2),(1),(0)) V(N)) SELECT FORMAT(D, 'MMM') AS Month, (SELECT COUNT(*) FROM StudentApplications WHERE AppliedDate >= D AND AppliedDate < DATEADD(MONTH, 1, D) AND Status = 'Selected') AS Selected, (SELECT COUNT(*) FROM StudentApplications WHERE AppliedDate >= D AND AppliedDate < DATEADD(MONTH, 1, D) AND Status = 'Shortlisted') AS Shortlisted, (SELECT COUNT(*) FROM StudentApplications WHERE AppliedDate >= D AND AppliedDate < DATEADD(MONTH, 1, D) AND (Status IS NULL OR Status NOT IN ('Selected', 'Shortlisted'))) AS Applied FROM M ORDER BY D");
                // Chart 8: Internships and Applications by Domain
                LoadChart(Chart8, "SELECT TOP 6 i.InternshipDomain AS Domain, COUNT(DISTINCT i.Id) AS TotalInternships, COUNT(a.ApplicationId) AS TotalApps FROM internship i LEFT JOIN StudentApplications a ON i.Id = a.InternshipId WHERE ISNULL(i.InternshipDomain, '') <> '' GROUP BY i.InternshipDomain ORDER BY TotalInternships DESC");
                // Chart 9: Application Funnel
                LoadChart(Chart9, "SELECT Stage, [Count] FROM (SELECT (SELECT COUNT(*) FROM StudentApplications) AS Applied, (SELECT COUNT(*) FROM StudentApplications WHERE Status = 'Shortlisted') AS Shortlisted, (SELECT COUNT(*) FROM CompanyInterviews) AS Interviewed, (SELECT COUNT(*) FROM StudentApplications WHERE Status = 'Selected') AS Selected, (SELECT COUNT(*) FROM CompanyCertificates) AS Certified) A CROSS APPLY (VALUES ('Applied', Applied), ('Shortlisted', Shortlisted), ('Interviewed', Interviewed), ('Selected', Selected), ('Certified', Certified)) B(Stage, [Count])");
                // Chart 10: Students by College
                LoadChart(Chart10, "SELECT TOP 5 ISNULL(NULLIF(College, ''), 'Other') AS College, COUNT(*) AS Total FROM Students GROUP BY ISNULL(NULLIF(College, ''), 'Other') ORDER BY Total DESC");
                // Chart 11: Feedback Ratings
                LoadChart(Chart11, "SELECT CAST(V.Star AS VARCHAR(5)) + CASE WHEN V.Star = 1 THEN ' Star' ELSE ' Stars' END AS Star, COUNT(P.Rating) AS Total FROM (VALUES (1),(2),(3),(4),(5)) V(Star) LEFT JOIN PlatformFeedback P ON P.Rating = V.Star GROUP BY V.Star ORDER BY V.Star");
                // Chart 12: Selection Rate
                LoadChart(Chart12, "SELECT Category, Percentage FROM (SELECT COUNT(*) AS Total, SUM(CASE WHEN Status = 'Selected' THEN 1 ELSE 0 END) AS Selected FROM StudentApplications) A CROSS APPLY (VALUES ('Selected', CAST(CASE WHEN Total = 0 THEN 0 ELSE Selected * 100.0 / Total END AS DECIMAL(5,1))), ('Other', CAST(CASE WHEN Total = 0 THEN 100 ELSE 100.0 - (Selected * 100.0 / Total) END AS DECIMAL(5,1)))) B(Category, Percentage)");
            }
        }

        // Common Chart Method
        void LoadChart(Chart chart, string q)
        {
            da = new SqlDataAdapter(q, s);
            ds = new DataSet();
            da.Fill(ds);
            if (ds != null && ds.Tables.Count > 0)
            {
                chart.DataSource = ds.Tables[0];
                chart.DataBind();
            }
        }

        void totalstudents()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM Students", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalStudents.Text = i.ToString();
        }

        void totalcompanies()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM c_registration", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalCompanies.Text = i.ToString();
        }

        void totalinternships()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM internship", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalInternships.Text = i.ToString();
        }

        void totalapplications()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM StudentApplications", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalApplications.Text = i.ToString();
        }

        void avgrating()
        {
            getcon();
            cmd = new SqlCommand("SELECT ISNULL(AVG(CAST(Rating AS FLOAT)), 5) FROM PlatformFeedback", con);
            double i = Convert.ToDouble(cmd.ExecuteScalar());
            lblAvgRating.Text = i.ToString("0.0") + " / 5";
        }

        void interviewscount()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyInterviews WHERE Status!='Cancelled'", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblInterviewsCount.Text = i.ToString();
        }

        void certificatescount()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyCertificates", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblCertificatesCount.Text = i.ToString();
        }

        void totalinquiries()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM cont", con);
            int i = Convert.ToInt16(cmd.ExecuteScalar());
            lblTotalInquiries.Text = i.ToString();
        }

        void loadAnalytics()
        {
            totalstudents();
            totalcompanies();
            totalinternships();
            totalapplications();
            avgrating();
            interviewscount();
            certificatescount();
            totalinquiries();
        }
    }
}

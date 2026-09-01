using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security check: ensure student is authenticated
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "student")
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadStudentDashboardData();
            }
        }

        private void LoadStudentDashboardData()
        {
            // Set dynamic student name from session if available
            if (Session["UserName"] != null && !string.IsNullOrEmpty(Session["UserName"].ToString()))
            {
                litStudentName.Text = Session["UserName"].ToString();
            }

            // Ready for dynamic database integration:
            // e.g. Fetch metrics from DB using Session["UserId"]
            // litProfileCompletion.Text = GetProfileCompletionPercentage(userId).ToString();
            // litAppliedCount.Text = GetTotalApplications(userId).ToString();
            // litSelectedCount.Text = GetSelectedApplications(userId).ToString();
            // litInterviewsCount.Text = GetScheduledInterviews(userId).ToString();
            // litPendingCount.Text = GetPendingApplications(userId).ToString();
        }
    }
}

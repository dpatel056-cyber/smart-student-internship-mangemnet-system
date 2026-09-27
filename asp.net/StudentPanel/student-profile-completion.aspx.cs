using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_profile_completion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check
            if (Session["student"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CalculateAndSetCompletionStatus();
            }
        }

        private void CalculateAndSetCompletionStatus()
        {
            // Sample / Default percentage
            int percentage = 85;

            // In production:
            // percentage = CalculateStudentProfileCompletion(Session["UserId"].ToString());

            litOverallPercentage.Text = percentage.ToString();

            // Set dynamic status heading based on percentage
            if (percentage >= 90)
            {
                litStatusHeading.Text = "Excellent! Your profile is almost complete.";
            }
            else if (percentage >= 70)
            {
                litStatusHeading.Text = "Good progress! Complete a few more details.";
            }
            else if (percentage >= 40)
            {
                litStatusHeading.Text = "Your profile needs more information.";
            }
            else
            {
                litStatusHeading.Text = "Complete your profile to start applying for internships.";
            }
        }
    }
}

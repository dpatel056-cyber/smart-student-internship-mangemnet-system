using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class company_post_internship : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }

            if (!IsPostBack)
            {
                loadCompanyData();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void loadCompanyData()
        {
            getcon();

            da = new SqlDataAdapter(
                "select * from c_registration where c_email='" +
                Session["company"] + "'", con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtCompanyName.Text =
                    ds.Tables[0].Rows[0]["c_company"].ToString();

                txtIndustry.Text =
                    ds.Tables[0].Rows[0]["c_industry"].ToString();

                txtCompanyLocation.Text =
                    ds.Tables[0].Rows[0]["c_location"].ToString();

                txtContactPerson.Text =
                    ds.Tables[0].Rows[0]["c_contact"].ToString();

                txtCompanyEmail.Text =
                    ds.Tables[0].Rows[0]["c_email"].ToString();

                txtCompanyWebsite.Text =
                    ds.Tables[0].Rows[0]["c_website"].ToString();
            }

            con.Close();
        }

        void SaveInternship(string status)
        {
            string benefits = "";

            if (chkCert.Checked)
                benefits += "Internship Certificate, ";

            if (chkLOR.Checked)
                benefits += "Letter of Recommendation, ";

            if (chkMentorship.Checked)
                benefits += "Mentorship, ";

            if (chkFlexTime.Checked)
                benefits += "Flexible Working Hours, ";

            if (chkWFH.Checked)
                benefits += "Work From Home, ";

            if (chkPPO.Checked)
                benefits += "PPO Opportunity, ";

            if (chkLearning.Checked)
                benefits += "Learning & Training";

            string paymentStatus = "";

            if (rbPaid.Checked)
                paymentStatus = "Paid";
            else
                paymentStatus = "Unpaid";

            getcon();

            cmd = new SqlCommand
                 ("insert into internship " +
                "(CompanyId, InternshipTitle, InternshipDomain, " +
                "InternshipDescription, InternshipType, WorkMode, " +
                "Location, StartDate, EndDate, Duration, WorkingHours, " +
                "WorkingDays, PaymentStatus, StipendAmount, " +
                "NumberOfOpenings, ApplicationDeadline, EligibleCourses, " +
                "EligibleDepartments, PreferredSemester, MinimumCGPA, " +
                "Experience, RequiredSkills, Responsibilities, " +
                "RequiredQualifications, Benefits, OtherBenefits, " +
                "Status, PostedDate) " +

                "values(" +

                "(select CompanyId from c_registration where c_email='" +
                Session["company"] + "')," +

                "'" + txtTitle.Text + "'," +
                "'" + ddlDomain.SelectedValue + "'," +
                "'" + txtDescription.Text + "'," +
                "'" + ddlInternshipType.SelectedValue + "'," +
                "'" + ddlWorkMode.SelectedValue + "'," +
                "'" + txtLocation.Text + "'," +
                "'" + txtStartDate.Text + "'," +
                "'" + txtEndDate.Text + "'," +
                "'" + ddlDuration.SelectedValue + "'," +
                "'" + txtWorkingHours.Text + "'," +
                "'" + txtWorkingDays.Text + "'," +
                "'" + paymentStatus + "'," +
                "'" + txtStipendAmount.Text + "'," +
                "'" + txtOpenings.Text + "'," +
                "'" + txtDeadline.Text + "'," +
                "'" + txtEligibleCourses.Text + "'," +
                "'" + txtEligibleDepts.Text + "'," +
                "'" + txtPreferredSemester.Text + "'," +
                "'" + txtMinCGPA.Text + "'," +
                "'" + ddlExperience.SelectedValue + "'," +
                "'" + txtRequiredSkills.Text + "'," +
                "'" + txtResponsibilities.Text + "'," +
                "'" + txtQualifications.Text + "'," +
                "'" + benefits + "'," +
                "'" + txtOtherBenefits.Text + "'," +
                "'" + status + "'," +
                "GETDATE())",con);

            cmd.ExecuteNonQuery();

            if (status == "Draft")
            {
                lblMessage.Text =
                    "Internship Saved as Draft successfully!";
            }
            else
            {
                lblMessage.Text =
                    "Internship Published successfully!";
            }

            lblMessage.Visible = true;
        }

        protected void btnSaveDraft_Click(object sender, EventArgs e)
        {
            SaveInternship("Draft");
        }

        protected void btnPublish_Click(object sender, EventArgs e)
        {
            SaveInternship("Published");
        }
    }
}
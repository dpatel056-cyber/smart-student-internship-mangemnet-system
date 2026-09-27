using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

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

        // Get CompanyId
        string getCompanyId()
        {
            getcon();

            da = new SqlDataAdapter(
                "select CompanyId from c_registration where c_email='" +
                Session["company"] + "'",
                con);

            ds = new DataSet();
            da.Fill(ds);

            string companyId = "";

            if (ds.Tables[0].Rows.Count > 0)
            {
                companyId = ds.Tables[0].Rows[0]["CompanyId"].ToString();
            }

            con.Close();

            return companyId;
        }

        // Load Company Details
        void loadCompanyData()
        {
            getcon();

            da = new SqlDataAdapter(
                "select * from c_registration where c_email='" +
                Session["company"] + "'",
                con);

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

        // Clear Form Method
        void clearFields()
        {
            txtTitle.Text = "";
            if (ddlDomain.Items.Count > 0) ddlDomain.SelectedIndex = 0;
            txtDescription.Text = "";
            if (ddlInternshipType.Items.Count > 0) ddlInternshipType.SelectedIndex = 0;
            if (ddlWorkMode.Items.Count > 0) ddlWorkMode.SelectedIndex = 0;
            txtLocation.Text = "";
            txtStartDate.Text = "";
            txtEndDate.Text = "";
            if (ddlDuration.Items.Count > 0) ddlDuration.SelectedIndex = 0;
            txtWorkingHours.Text = "";
            txtWorkingDays.Text = "";
            rbPaid.Checked = true;
            rbUnpaid.Checked = false;
            txtStipendAmount.Text = "";
            txtOpenings.Text = "";
            txtDeadline.Text = "";
            txtEligibleCourses.Text = "";
            txtEligibleDepts.Text = "";
            txtPreferredSemester.Text = "";
            txtMinCGPA.Text = "";
            if (ddlExperience.Items.Count > 0) ddlExperience.SelectedIndex = 0;
            txtRequiredSkills.Text = "";
            txtResponsibilities.Text = "";
            txtQualifications.Text = "";
            chkCert.Checked = false;
            chkLOR.Checked = false;
            chkMentorship.Checked = false;
            chkFlexTime.Checked = false;
            chkWFH.Checked = false;
            chkPPO.Checked = false;
            chkLearning.Checked = false;
            txtOtherBenefits.Text = "";
        }

        // Save Internship
        void SaveInternship(string status)
        {
            string companyId = getCompanyId();

            // Benefits
            string benefits = "";

            if (chkCert.Checked)
            {
                benefits = benefits + "Internship Certificate, ";
            }

            if (chkLOR.Checked)
            {
                benefits = benefits + "Letter of Recommendation, ";
            }

            if (chkMentorship.Checked)
            {
                benefits = benefits + "Mentorship, ";
            }

            if (chkFlexTime.Checked)
            {
                benefits = benefits + "Flexible Working Hours, ";
            }

            if (chkWFH.Checked)
            {
                benefits = benefits + "Work From Home, ";
            }

            if (chkPPO.Checked)
            {
                benefits = benefits + "PPO Opportunity, ";
            }

            if (chkLearning.Checked)
            {
                benefits = benefits + "Learning & Training";
            }

            // Paid / Unpaid
            string paymentStatus = "";

            if (rbPaid.Checked)
            {
                paymentStatus = "Paid";
            }
            else
            {
                paymentStatus = "Unpaid";
            }

            // Database Insert
            getcon();

            cmd = new SqlCommand(
                "insert into internship " +

                "(CompanyId, " +
                "InternshipTitle, " +
                "InternshipDomain, " +
                "InternshipDescription, " +
                "InternshipType, " +
                "WorkMode, " +
                "Location, " +
                "StartDate, " +
                "EndDate, " +
                "Duration, " +
                "WorkingHours, " +
                "WorkingDays, " +
                "PaymentStatus, " +
                "StipendAmount, " +
                "NumberOfOpenings, " +
                "ApplicationDeadline, " +
                "EligibleCourses, " +
                "EligibleDepartments, " +
                "PreferredSemester, " +
                "MinimumCGPA, " +
                "Experience, " +
                "RequiredSkills, " +
                "Responsibilities, " +
                "RequiredQualifications, " +
                "Benefits, " +
                "OtherBenefits, " +
                "Status, " +
                "PostedDate) " +

                "values('" +

                companyId + "','" +

                txtTitle.Text + "','" +

                ddlDomain.SelectedValue + "','" +

                txtDescription.Text + "','" +

                ddlInternshipType.SelectedValue + "','" +

                ddlWorkMode.SelectedValue + "','" +

                txtLocation.Text + "','" +

                txtStartDate.Text + "','" +

                txtEndDate.Text + "','" +

                ddlDuration.SelectedValue + "','" +

                txtWorkingHours.Text + "','" +

                txtWorkingDays.Text + "','" +

                paymentStatus + "','" +

                txtStipendAmount.Text + "','" +

                txtOpenings.Text + "','" +

                txtDeadline.Text + "','" +

                txtEligibleCourses.Text + "','" +

                txtEligibleDepts.Text + "','" +

                txtPreferredSemester.Text + "','" +

                txtMinCGPA.Text + "','" +

                ddlExperience.SelectedValue + "','" +

                txtRequiredSkills.Text + "','" +

                txtResponsibilities.Text + "','" +

                txtQualifications.Text + "','" +

                benefits + "','" +

                txtOtherBenefits.Text + "','" +

                status + "',GETDATE())",

                con
            );

            cmd.ExecuteNonQuery();

            con.Close();

            // Clear form fields after successful insert
            clearFields();

            // Message
            if (status == "Draft")
            {
                lblMessage.Text =
                    "Internship Saved as Draft successfully!";

                lblMessage.ForeColor =
                    System.Drawing.Color.DimGray;
            }
            else
            {
                lblMessage.Text =
                    "Internship Published successfully!";

                lblMessage.ForeColor =
                    System.Drawing.Color.MediumSeaGreen;
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
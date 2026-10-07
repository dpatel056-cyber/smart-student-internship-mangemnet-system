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
        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                if (!IsPostBack)
                {
                    loadCompanyData();
                    if (Request.QueryString["id"] != null)
                    {
                        lblPageTitle.InnerText = "Edit Internship Opportunity";
                        lblPageSubTitle.InnerText = "Update your posted internship details.";
                        btnPublish.Text = "Update Internship";
                        loadInternshipData(Request.QueryString["id"].ToString());
                    }
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }
        void loadInternshipData(string id)
        {
            getcon();
            da = new SqlDataAdapter("select * from internship where Id='" + id + "' and CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "')", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtTitle.Text = ds.Tables[0].Rows[0]["InternshipTitle"].ToString();
                ddlDomain.SelectedValue = ds.Tables[0].Rows[0]["InternshipDomain"].ToString();
                txtDescription.Text = ds.Tables[0].Rows[0]["InternshipDescription"].ToString();
                ddlInternshipType.SelectedValue = ds.Tables[0].Rows[0]["InternshipType"].ToString();
                ddlWorkMode.SelectedValue = ds.Tables[0].Rows[0]["WorkMode"].ToString();
                txtLocation.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                txtStartDate.Text = ds.Tables[0].Rows[0]["StartDate"].ToString();
                txtEndDate.Text = ds.Tables[0].Rows[0]["EndDate"].ToString();
                ddlDuration.SelectedValue = ds.Tables[0].Rows[0]["Duration"].ToString();
                txtWorkingHours.Text = ds.Tables[0].Rows[0]["WorkingHours"].ToString();
                txtWorkingDays.Text = ds.Tables[0].Rows[0]["WorkingDays"].ToString();
                if (ds.Tables[0].Rows[0]["PaymentStatus"].ToString() == "Paid")
                    rbPaid.Checked = true;
                else
                    rbUnpaid.Checked = true;
                txtStipendAmount.Text = ds.Tables[0].Rows[0]["StipendAmount"].ToString();
                txtOpenings.Text = ds.Tables[0].Rows[0]["NumberOfOpenings"].ToString();
                txtDeadline.Text = ds.Tables[0].Rows[0]["ApplicationDeadline"].ToString();
                txtEligibleCourses.Text = ds.Tables[0].Rows[0]["EligibleCourses"].ToString();
                txtEligibleDepts.Text = ds.Tables[0].Rows[0]["EligibleDepartments"].ToString();
                txtPreferredSemester.Text = ds.Tables[0].Rows[0]["PreferredSemester"].ToString();
                txtMinCGPA.Text = ds.Tables[0].Rows[0]["MinimumCGPA"].ToString();
                ddlExperience.SelectedValue = ds.Tables[0].Rows[0]["Experience"].ToString();
                txtRequiredSkills.Text = ds.Tables[0].Rows[0]["RequiredSkills"].ToString();
                txtResponsibilities.Text = ds.Tables[0].Rows[0]["Responsibilities"].ToString();
                txtQualifications.Text = ds.Tables[0].Rows[0]["RequiredQualifications"].ToString();
                chkCert.Checked = ds.Tables[0].Rows[0]["Benefits"].ToString().Contains("Internship Certificate");
                chkLOR.Checked = ds.Tables[0].Rows[0]["Benefits"].ToString().Contains("Letter of Recommendation");
                chkMentorship.Checked = ds.Tables[0].Rows[0]["Benefits"].ToString().Contains("Mentorship");
                chkFlexTime.Checked = ds.Tables[0].Rows[0]["Benefits"].ToString().Contains("Flexible Working Hours");
                chkWFH.Checked = ds.Tables[0].Rows[0]["Benefits"].ToString().Contains("Work From Home");
                chkPPO.Checked = ds.Tables[0].Rows[0]["Benefits"].ToString().Contains("PPO Opportunity");
                chkLearning.Checked = ds.Tables[0].Rows[0]["Benefits"].ToString().Contains("Learning & Training");
                txtOtherBenefits.Text = ds.Tables[0].Rows[0]["OtherBenefits"].ToString();
            }
        }
        void loadCompanyData()
        {
            getcon();
            da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                txtIndustry.Text = ds.Tables[0].Rows[0]["c_industry"].ToString();
                txtCompanyLocation.Text = ds.Tables[0].Rows[0]["c_location"].ToString();
                txtContactPerson.Text = ds.Tables[0].Rows[0]["c_contact"].ToString();
                txtCompanyEmail.Text = ds.Tables[0].Rows[0]["c_email"].ToString();
                txtCompanyWebsite.Text = ds.Tables[0].Rows[0]["c_website"].ToString();
            }
        }
        void SaveInternship(string status)
        {
            string benefits = "";
            if (chkCert.Checked) benefits += "Internship Certificate,";
            if (chkLOR.Checked) benefits += "Letter of Recommendation,";
            if (chkMentorship.Checked) benefits += "Mentorship,";
            if (chkFlexTime.Checked) benefits += "Flexible Working Hours,";
            if (chkWFH.Checked) benefits += "Work From Home,";
            if (chkPPO.Checked) benefits += "PPO Opportunity,";
            if (chkLearning.Checked) benefits += "Learning & Training";
            string paymentStatus = "Unpaid";
            if (rbPaid.Checked)
                paymentStatus = "Paid";
            getcon();
            if (Request.QueryString["id"] != null)
            {
                string id = Request.QueryString["id"].ToString();
                cmd = new SqlCommand("update internship set InternshipTitle='" + txtTitle.Text + "',InternshipDomain='" + ddlDomain.Text + "',InternshipDescription='" + txtDescription.Text + "',InternshipType='" + ddlInternshipType.Text + "',WorkMode='" + ddlWorkMode.Text + "',Location='" + txtLocation.Text + "',StartDate='" + txtStartDate.Text + "',EndDate='" + txtEndDate.Text + "',Duration='" + ddlDuration.Text + "',WorkingHours='" + txtWorkingHours.Text + "',WorkingDays='" + txtWorkingDays.Text + "',PaymentStatus='" + paymentStatus + "',StipendAmount='" + txtStipendAmount.Text + "',NumberOfOpenings='" + txtOpenings.Text + "',ApplicationDeadline='" + txtDeadline.Text + "',EligibleCourses='" + txtEligibleCourses.Text + "',EligibleDepartments='" + txtEligibleDepts.Text + "',PreferredSemester='" + txtPreferredSemester.Text + "',MinimumCGPA='" + txtMinCGPA.Text + "',Experience='" + ddlExperience.Text + "',RequiredSkills='" + txtRequiredSkills.Text + "',Responsibilities='" + txtResponsibilities.Text + "',RequiredQualifications='" + txtQualifications.Text + "',Benefits='" + benefits + "',OtherBenefits='" + txtOtherBenefits.Text + "',Status='" + status + "' where Id='" + id + "'", con);
                cmd.ExecuteNonQuery();
                if (status == "Draft")
                    lblMessage.Text = "Internship Draft updated successfully!";
                else
                    lblMessage.Text = "Internship Updated successfully!";
            }
            else
            {
                cmd = new SqlCommand("insert into internship (CompanyId,InternshipTitle,InternshipDomain,InternshipDescription,InternshipType,WorkMode,Location,StartDate,EndDate,Duration,WorkingHours,WorkingDays,PaymentStatus,StipendAmount,NumberOfOpenings,ApplicationDeadline,EligibleCourses,EligibleDepartments,PreferredSemester,MinimumCGPA,Experience,RequiredSkills,Responsibilities,RequiredQualifications,Benefits,OtherBenefits,Status,PostedDate) values ((select CompanyId from c_registration where c_email='" + Session["company"] + "'),'" + txtTitle.Text + "','" + ddlDomain.Text + "','" + txtDescription.Text + "','" + ddlInternshipType.Text + "','" + ddlWorkMode.Text + "','" + txtLocation.Text + "','" + txtStartDate.Text + "','" + txtEndDate.Text + "','" + ddlDuration.Text + "','" + txtWorkingHours.Text + "','" + txtWorkingDays.Text + "','" + paymentStatus + "','" + txtStipendAmount.Text + "','" + txtOpenings.Text + "','" + txtDeadline.Text + "','" + txtEligibleCourses.Text + "','" + txtEligibleDepts.Text + "','" + txtPreferredSemester.Text + "','" + txtMinCGPA.Text + "','" + ddlExperience.Text + "','" + txtRequiredSkills.Text + "','" + txtResponsibilities.Text + "','" + txtQualifications.Text + "','" + benefits + "','" + txtOtherBenefits.Text + "','" + status + "',GETDATE())", con);
                cmd.ExecuteNonQuery();
                if (status == "Draft")
                    lblMessage.Text = "Internship Saved as Draft successfully!";
                else
                    lblMessage.Text = "Internship Published successfully!";
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
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace asp.net
{
    public partial class student_apply_internship : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string path, nm;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void upload()
        {
            path = Path.GetExtension(fuApplicantResume.FileName);
            if (path == ".pdf" || path == ".PDF")
            {
                nm = "resume_upload/" + fuApplicantResume.FileName;

                fuApplicantResume.SaveAs(Server.MapPath(nm));
            }
            else if (path != "")
            {
                Response.Write("<script>alert('Only upload pdf file.');</script>");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }

            if (Request.QueryString["id"] == null)
            {
                Response.Redirect("~/StudentPanel/student-internships.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadInternshipSummary();
                LoadStudentProfile();
            }
        }

        void LoadInternshipSummary()
        {
            hlBack.NavigateUrl = "student-internship-details.aspx?id=" + Request.QueryString["id"];
            hlCancel.NavigateUrl = "student-internship-details.aspx?id=" + Request.QueryString["id"];

            getcon();

            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo, c.c_location FROM internship i INNER JOIN c_registration c ON i.CompanyId=c.CompanyId WHERE i.Id='" + Request.QueryString["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lblRoleTitle.Text = ds.Tables[0].Rows[0]["InternshipTitle"].ToString();
                lblCompanyName.Text = ds.Tables[0].Rows[0]["c_company"].ToString();
                lblLocation.Text = ds.Tables[0].Rows[0]["Location"].ToString();
                lblStipend.Text = "₹ " + ds.Tables[0].Rows[0]["StipendAmount"].ToString();
                imgCompanyLogo.ImageUrl = ds.Tables[0].Rows[0]["c_logo"].ToString();
            }

            da = new SqlDataAdapter("SELECT ApplicationId FROM StudentApplications WHERE InternshipId=" + Request.QueryString["id"] + " AND (StudentEmail='" + Session["student"] + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "'))", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
                Response.Redirect("~/StudentPanel/student-my-applications.aspx");
        }

        void LoadStudentProfile()
        {
            getcon();

            da = new SqlDataAdapter("SELECT * FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtApplicantName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                txtApplicantEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                txtApplicantMobile.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
                txtApplicantCollege.Text = ds.Tables[0].Rows[0]["College"].ToString();
                txtApplicantCourse.Text = ds.Tables[0].Rows[0]["Course"].ToString();
                txtApplicantSemester.Text = ds.Tables[0].Rows[0]["CurrentSemester"].ToString();
                txtApplicantCGPA.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();

                hfProfileResume.Value = ds.Tables[0].Rows[0]["Resume"].ToString();

                if (hfProfileResume.Value != "")
                {
                    divCurrentResume.Visible = true;
                    lblCurrentResumeName.Text = hfProfileResume.Value;
                    lblUploadResumePrompt.Text = "Upload a different resume if desired (otherwise your profile resume will be attached):";
                }
                else
                {
                    divCurrentResume.Visible = false;
                    lblUploadResumePrompt.Text = "Attach your Resume / CV in PDF format:";
                }
            }
        }

        protected void btnSubmitApplication_Click(object sender, ImageClickEventArgs e)
        {
            if (txtApplicantName.Text == "" || txtApplicantEmail.Text == "")
            {
                lblError.Visible = true;
                lblError.Text = "Please fill in all required contact information.";
                return;
            }

            upload();

            if (path != "" && nm == null)
            {
                return;
            }

            string resume = hfProfileResume.Value;

            if (nm != null)
            {
                resume = nm;
            }

            if (resume == "")
            {
                lblError.Visible = true;
                lblError.Text = "Please upload your resume to complete the application.";
                return;
            }

            getcon();

            da = new SqlDataAdapter("SELECT StudentId, Email FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                cmd = new SqlCommand("INSERT INTO StudentApplications (InternshipId, StudentId, StudentEmail, FullName, ContactNo, College, Course, Semester, CGPA, CoverLetter, ResumePath, Availability, Status, AppliedDate) VALUES (" + Request.QueryString["id"] + ", " + ds.Tables[0].Rows[0]["StudentId"] + ", '" + ds.Tables[0].Rows[0]["Email"] + "', '" + txtApplicantName.Text + "', '" + txtApplicantMobile.Text + "', '" + txtApplicantCollege.Text + "', '" + txtApplicantCourse.Text + "', '" + txtApplicantSemester.Text + "', '" + txtApplicantCGPA.Text + "', '" + txtApplicantCoverLetter.Text + "', '" + resume + "', '" + ddlApplicantAvailability.SelectedValue + "', 'Applied', GETDATE())", con);

                cmd.ExecuteNonQuery();

                Response.Redirect("~/StudentPanel/student-my-applications.aspx?applied=1");
            }
        }
    }
}

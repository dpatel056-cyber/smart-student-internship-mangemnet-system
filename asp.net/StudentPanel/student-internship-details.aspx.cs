using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace asp.net
{
    public partial class student_internship_details : System.Web.UI.Page
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
            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    if (Request.QueryString["apply"] == "1" && Request.QueryString["id"] != null)
                    {
                        Response.Redirect("~/StudentPanel/student-apply-internship.aspx?id=" + Request.QueryString["id"]);
                        return;
                    }

                    loadInternshipDetails();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void loadInternshipDetails()
        {
            getcon();
            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo, c.c_industry, c.c_location, c.c_city, c.c_state, c.c_about, c.c_email, c.c_contact, c.c_hr_name, c.c_website FROM internship i INNER JOIN c_registration c ON i.CompanyId=c.CompanyId WHERE i.Id='" + Request.QueryString["id"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListInternshipDetail.DataSource = ds;
                DataListInternshipDetail.DataBind();

                DataListInternshipDetail.Visible = true;
                divNotFound.Visible = false;
            }
            else
            {
                DataListInternshipDetail.Visible = false;
                divNotFound.Visible = true;
            }
        }


        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            getcon();

            da = new SqlDataAdapter("SELECT StudentId, Email FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string studentId = ds.Tables[0].Rows[0]["StudentId"].ToString();
                string email = ds.Tables[0].Rows[0]["Email"].ToString();

                cmd = new SqlCommand("SELECT COUNT(*) FROM StudentSavedInternships WHERE InternshipId='" + Request.QueryString["id"] + "' AND StudentId=" + studentId, con);

                if (Convert.ToInt32(cmd.ExecuteScalar()) == 0)
                {
                    cmd = new SqlCommand("INSERT INTO StudentSavedInternships (StudentId, StudentEmail, InternshipId, SavedDate) VALUES (" + studentId + ", '" + email + "', '" + Request.QueryString["id"] + "', GETDATE())", con);
                    cmd.ExecuteNonQuery();
                }

                ScriptManager.RegisterStartupScript(this, GetType(), "saveAlert", "alert('Internship saved successfully!');", true);
            }
        }
    }
}

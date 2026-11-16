using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net.js
{
    public partial class student_edit_profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string nm, path;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.Form != null)
            {
                Page.Form.Enctype = "multipart/form-data";
            }

            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    filldata();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void upload()
        {
            path = Path.GetExtension(FileUpload1.FileName);
            if (path == ".jpg" || path == ".png" || path == ".jpeg" || path == ".JPG" || path == ".PNG")
            {
                nm = "student_images/" + FileUpload1.FileName;

                FileUpload1.SaveAs(Server.MapPath(nm));
            }
            else if (path != "")
            {
                Response.Write("<script>alert('Only upload jpg and png file.');</script>");
            }
        }

        void filldata()
        {
            getcon();

            da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                txtDateOfBirth.Text = ds.Tables[0].Rows[0]["DateOfBirth"].ToString();
                ddlGender.SelectedValue = ds.Tables[0].Rows[0]["Gender"].ToString();
                txtEmailAddress.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                txtContactNumber.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();
                txtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                txtState.Text = ds.Tables[0].Rows[0]["State"].ToString();
                txtPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();
                txtPreferredDomain.Text = ds.Tables[0].Rows[0]["PreferredDomain"].ToString();
                txtPreferredRole.Text = ds.Tables[0].Rows[0]["PreferredRole"].ToString();
                txtPreferredLocation.Text = ds.Tables[0].Rows[0]["PreferredLocation"].ToString();
                ddlWorkMode.SelectedValue = ds.Tables[0].Rows[0]["WorkMode"].ToString();
                ddlAvailability.SelectedValue = ds.Tables[0].Rows[0]["Availability"].ToString();
                txtLinkedIn.Text = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
                txtGitHub.Text = ds.Tables[0].Rows[0]["GitHub"].ToString();
                txtPortfolio.Text = ds.Tables[0].Rows[0]["Portfolio"].ToString();
                txtEnrollmentNumber.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();
                txtCollegeName.Text = ds.Tables[0].Rows[0]["College"].ToString();
                ddlCourse.SelectedValue = ds.Tables[0].Rows[0]["Course"].ToString();
                txtDepartment.Text = ds.Tables[0].Rows[0]["Department"].ToString();
                txtSemester.Text = ds.Tables[0].Rows[0]["CurrentSemester"].ToString();
                txtGraduationYear.Text = ds.Tables[0].Rows[0]["GraduationYear"].ToString();
                txtCGPA.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();

                DataListStudentLogo.DataSource = ds;
                DataListStudentLogo.DataBind();
            }
        }

        protected void btnRemovePhoto_Click(object sender, EventArgs e)
        {
            getcon();
            cmd = new SqlCommand("update Students set ProfilePhoto=NULL where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
            cmd.ExecuteNonQuery();
            Response.Redirect("student-edit-profile.aspx");
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            upload();
            getcon();

            if (nm != null)
            {
                cmd = new SqlCommand("update Students set FullName='" + txtFullName.Text + "',DateOfBirth='" + txtDateOfBirth.Text + "',Gender='" + ddlGender.SelectedValue + "',Email='" + txtEmailAddress.Text + "',ContactNo='" + txtContactNumber.Text + "',EnrollmentNo='" + txtEnrollmentNumber.Text + "',Address='" + txtAddress.Text + "',City='" + txtCity.Text + "',State='" + txtState.Text + "',Pincode='" + txtPincode.Text + "',College='" + txtCollegeName.Text + "',Course='" + ddlCourse.SelectedValue + "',Department='" + txtDepartment.Text + "',CurrentSemester='" + txtSemester.Text + "',GraduationYear='" + txtGraduationYear.Text + "',CGPA='" + txtCGPA.Text + "',PreferredDomain='" + txtPreferredDomain.Text + "',PreferredRole='" + txtPreferredRole.Text + "',PreferredLocation='" + txtPreferredLocation.Text + "',WorkMode='" + ddlWorkMode.SelectedValue + "',Availability='" + ddlAvailability.SelectedValue + "',AboutMe='" + txtAboutMe.Text + "',LinkedIn='" + txtLinkedIn.Text + "',GitHub='" + txtGitHub.Text + "',Portfolio='" + txtPortfolio.Text + "' ,ProfilePhoto='" + nm + "' where Email = '" + Session["student"] + "' or EnrollmentNo = '" + Session["student"] + "'", con);
            }
            else
            {
                cmd = new SqlCommand("update Students set FullName='" + txtFullName.Text + "',DateOfBirth='" + txtDateOfBirth.Text + "',Gender='" + ddlGender.SelectedValue + "',Email='" + txtEmailAddress.Text + "',ContactNo='" + txtContactNumber.Text + "',EnrollmentNo='" + txtEnrollmentNumber.Text + "',Address='" + txtAddress.Text + "',City='" + txtCity.Text + "',State='" + txtState.Text + "',Pincode='" + txtPincode.Text + "',College='" + txtCollegeName.Text + "',Course='" + ddlCourse.SelectedValue + "',Department='" + txtDepartment.Text + "',CurrentSemester='" + txtSemester.Text + "',GraduationYear='" + txtGraduationYear.Text + "',CGPA='" + txtCGPA.Text + "',PreferredDomain='" + txtPreferredDomain.Text + "',PreferredRole='" + txtPreferredRole.Text + "',PreferredLocation='" + txtPreferredLocation.Text + "',WorkMode='" + ddlWorkMode.SelectedValue + "',Availability='" + ddlAvailability.SelectedValue + "',AboutMe='" + txtAboutMe.Text + "',LinkedIn='" + txtLinkedIn.Text + "',GitHub='" + txtGitHub.Text + "',Portfolio='" + txtPortfolio.Text + "' where Email = '" + Session["student"] + "' or EnrollmentNo = '" + Session["student"] + "'", con);
            }
            cmd.ExecuteNonQuery();
            Session["student"] = txtEmailAddress.Text;
            Response.Redirect("student-profile.aspx");
        }
    }
}

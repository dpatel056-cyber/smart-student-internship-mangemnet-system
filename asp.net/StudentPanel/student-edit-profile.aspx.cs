using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace asp.net.js
{
    public partial class student_edit_profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string fnm;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            getcon();
            if (!IsPostBack)
            {
                filldata();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void imgupload()
        {
            if (fileProfilePhoto.HasFile)
            {
                string path = Server.MapPath("~/StudentUploads/");

                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                fnm = "~/StudentUploads/" + fileProfilePhoto.FileName;

                fileProfilePhoto.SaveAs(Server.MapPath(fnm));
            }
            else
            {
                fnm = null;
            }
        }

        void filldata()
        {
            getcon();
            da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            //paring
            txtFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
            txtDateOfBirth.Text = Convert.ToDateTime(ds.Tables[0].Rows[0]["DateOfBirth"]).ToString("yyyy-MM-dd");
            if (ds.Tables[0].Rows[0]["Gender"].ToString() == "Male")
            {
                ddlGender.SelectedValue = "Male";
            }
            else if (ds.Tables[0].Rows[0]["Gender"].ToString() == "Female")
            {
                ddlGender.SelectedValue = "Female";
            }
            else if (ds.Tables[0].Rows[0]["Gender"].ToString() == "Other")
            {
                ddlGender.SelectedValue = "Other";
            }
            txtEmailAddress.Text = ds.Tables[0].Rows[0]["Email"].ToString();
            txtContactNumber.Text = ds.Tables[0].Rows[0]["ContactNo"].ToString();


            txtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
            txtCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
            txtState.Text = ds.Tables[0].Rows[0]["State"].ToString();
            txtPincode.Text = ds.Tables[0].Rows[0]["Pincode"].ToString();


            txtAboutMe.Text = ds.Tables[0].Rows[0]["AboutMe"].ToString();


            txtPreferredDomain.Text = ds.Tables[0].Rows[0]["PreferredDomain"].ToString();
            txtPreferredRole.Text = ds.Tables[0].Rows[0]["PreferredRole"].ToString();
            txtPreferredLocation.Text = ds.Tables[0].Rows[0]["PreferredLocation"].ToString();
            if (ds.Tables[0].Rows[0]["WorkMode"].ToString() != "")
            {
                ddlWorkMode.SelectedValue = ds.Tables[0].Rows[0]["WorkMode"].ToString();
            }

            if (ds.Tables[0].Rows[0]["Availability"].ToString() != "")
            {
                ddlAvailability.SelectedValue = ds.Tables[0].Rows[0]["Availability"].ToString();
            }



            txtLinkedIn.Text = ds.Tables[0].Rows[0]["LinkedIn"].ToString();
            txtGitHub.Text = ds.Tables[0].Rows[0]["GitHub"].ToString();
            txtPortfolio.Text = ds.Tables[0].Rows[0]["Portfolio"].ToString();


            txtEnrollmentNumber.Text = ds.Tables[0].Rows[0]["EnrollmentNo"].ToString();
            txtCollegeName.Text = ds.Tables[0].Rows[0]["College"].ToString();
            txtCourse.Text = ds.Tables[0].Rows[0]["Course"].ToString();
            txtDepartment.Text = ds.Tables[0].Rows[0]["Department"].ToString();
            txtSemester.Text = ds.Tables[0].Rows[0]["CurrentSemester"].ToString();
            txtGraduationYear.Text = ds.Tables[0].Rows[0]["GraduationYear"].ToString();
            txtCGPA.Text = ds.Tables[0].Rows[0]["CGPA"].ToString();


            string photo = ds.Tables[0].Rows[0]["ProfilePhoto"].ToString();
            if (!string.IsNullOrEmpty(photo))
            {
                if (!photo.StartsWith("~") && !photo.StartsWith("/"))
                {
                    photo = "~/StudentUploads/" + photo;
                }
                imgProfilePreview.ImageUrl = ResolveUrl(photo);
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            getcon();
            imgupload();

            if (fnm != null)
            {
                cmd = new SqlCommand("update Students set FullName='" + txtFullName.Text + "',DateOfBirth='" + txtDateOfBirth.Text + "',Gender='" + ddlGender.SelectedValue + "',Email='" + txtEmailAddress.Text + "',ContactNo='" + txtContactNumber.Text + "',EnrollmentNo='" + txtEnrollmentNumber.Text + "',Address='" + txtAddress.Text + "',City='" + txtCity.Text + "',State='" + txtState.Text + "',Pincode='" + txtPincode.Text + "',College='" + txtCollegeName.Text + "',Course='" + txtCourse.Text + "',Department='" + txtDepartment.Text + "',CurrentSemester='" + txtSemester.Text + "',GraduationYear='" + txtGraduationYear.Text + "',CGPA='" + txtCGPA.Text + "',PreferredDomain='" + txtPreferredDomain.Text + "',PreferredRole='" + txtPreferredRole.Text + "',PreferredLocation='" + txtPreferredLocation.Text + "',WorkMode='" + ddlWorkMode.SelectedValue + "',Availability='" + ddlAvailability.SelectedValue + "',AboutMe='" + txtAboutMe.Text + "',LinkedIn='" + txtLinkedIn.Text + "',GitHub='" + txtGitHub.Text + "',Portfolio='" + txtPortfolio.Text + "',ProfilePhoto='" + fnm + "' where Email='" + Session["student"] + "'", con);
            }
            else
            {
                cmd = new SqlCommand("update Students set FullName='" + txtFullName.Text + "',DateOfBirth='" + txtDateOfBirth.Text + "',Gender='" + ddlGender.SelectedValue + "',Email='" + txtEmailAddress.Text + "',ContactNo='" + txtContactNumber.Text + "',EnrollmentNo='" + txtEnrollmentNumber.Text + "',Address='" + txtAddress.Text + "',City='" + txtCity.Text + "',State='" + txtState.Text + "',Pincode='" + txtPincode.Text + "',College='" + txtCollegeName.Text + "',Course='" + txtCourse.Text + "',Department='" + txtDepartment.Text + "',CurrentSemester='" + txtSemester.Text + "',GraduationYear='" + txtGraduationYear.Text + "',CGPA='" + txtCGPA.Text + "',PreferredDomain='" + txtPreferredDomain.Text + "',PreferredRole='" + txtPreferredRole.Text + "',PreferredLocation='" + txtPreferredLocation.Text + "',WorkMode='" + ddlWorkMode.SelectedValue + "',Availability='" + ddlAvailability.SelectedValue + "',AboutMe='" + txtAboutMe.Text + "',LinkedIn='" + txtLinkedIn.Text + "',GitHub='" + txtGitHub.Text + "',Portfolio='" + txtPortfolio.Text + "' where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
            }

            cmd.ExecuteNonQuery();

            Session["student"] = txtEmailAddress.Text;
            Response.Redirect("student-profile.aspx");
        }
    }
}

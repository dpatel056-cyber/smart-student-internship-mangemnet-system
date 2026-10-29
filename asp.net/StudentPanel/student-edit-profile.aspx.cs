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

        private string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "ST";
            var parts = name.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 1)
            {
                return parts[0].Length >= 2 ? parts[0].Substring(0, 2).ToUpper() : parts[0].ToUpper();
            }
            return (parts[0][0].ToString() + parts[parts.Length - 1][0].ToString()).ToUpper();
        }

        void upload()
        {
            path = Path.GetExtension(FileUpload1.FileName);
            if (path == ".jpg" || path == ".png" || path == ".jpeg" || path == ".JPG" || path == ".PNG")
            {
                nm = "student_images/" + FileUpload1.FileName;
                string fullPath = Server.MapPath("~/" + nm);
                string dir = Path.GetDirectoryName(fullPath);
                if (!Directory.Exists(dir))
                {
                    Directory.CreateDirectory(dir);
                }
                FileUpload1.SaveAs(fullPath);
            }
            else
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

                string photo = ds.Tables[0].Rows[0]["ProfilePhoto"] != DBNull.Value ? ds.Tables[0].Rows[0]["ProfilePhoto"].ToString() : "";

                if (!string.IsNullOrEmpty(photo))
                {
                    if (!photo.StartsWith("~") && !photo.StartsWith("/"))
                    {
                        if (photo.StartsWith("student_images/") || photo.StartsWith("images/"))
                            photo = "~/" + photo;
                        else if (System.IO.File.Exists(Server.MapPath("~/student_images/" + photo)))
                            photo = "~/student_images/" + photo;
                        else
                            photo = "~/StudentUploads/" + photo;
                    }
                    imgProfilePreview.ImageUrl = ResolveUrl(photo);
                    imgProfilePreview.Visible = true;
                    lblProfileInitials.Visible = false;
                    btnRemovePhoto.Visible = true;
                }
                else
                {
                    imgProfilePreview.Visible = false;
                    lblProfileInitials.Visible = true;
                    lblProfileInitials.Text = GetInitials(txtFullName.Text);
                    btnRemovePhoto.Visible = false;
                }
            }
        }

        protected void btnRemovePhoto_Click(object sender, ImageClickEventArgs e)
        {
            getcon();

            da = new SqlDataAdapter("select ProfilePhoto from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string photo = ds.Tables[0].Rows[0]["ProfilePhoto"] != DBNull.Value ? ds.Tables[0].Rows[0]["ProfilePhoto"].ToString() : "";

                if (!string.IsNullOrEmpty(photo))
                {
                    string p = Server.MapPath(photo.StartsWith("~") ? photo : "~/" + photo);
                    if (File.Exists(p))
                    {
                        try { File.Delete(p); } catch { }
                    }
                }
            }

            cmd = new SqlCommand("update Students set ProfilePhoto=NULL where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
            cmd.ExecuteNonQuery();
            Response.Redirect("student-edit-profile.aspx");
        }

        protected void btnSaveChanges_Click(object sender, ImageClickEventArgs e)
        {
            btnSaveChanges_Click(sender, (EventArgs)e);
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            getcon();

            if (FileUpload1.HasFile)
            {
                path = Path.GetExtension(FileUpload1.FileName);
                if (path == ".jpg" || path == ".png" || path == ".jpeg" || path == ".JPG" || path == ".PNG")
                {
                    upload();
                }
                else
                {
                    Response.Write("<script>alert('Only upload jpg and png file.');</script>");
                    return;
                }
            }

            string q = "update Students set FullName='" + txtFullName.Text.Replace("'", "''") + "',DateOfBirth='" + txtDateOfBirth.Text.Replace("'", "''") + "',Gender='" + ddlGender.SelectedValue.Replace("'", "''") + "',Email='" + txtEmailAddress.Text.Replace("'", "''") + "',ContactNo='" + txtContactNumber.Text.Replace("'", "''") + "',EnrollmentNo='" + txtEnrollmentNumber.Text.Replace("'", "''") + "',Address='" + txtAddress.Text.Replace("'", "''") + "',City='" + txtCity.Text.Replace("'", "''") + "',State='" + txtState.Text.Replace("'", "''") + "',Pincode='" + txtPincode.Text.Replace("'", "''") + "',College='" + txtCollegeName.Text.Replace("'", "''") + "',Course='" + ddlCourse.SelectedValue.Replace("'", "''") + "',Department='" + txtDepartment.Text.Replace("'", "''") + "',CurrentSemester='" + txtSemester.Text.Replace("'", "''") + "',GraduationYear='" + txtGraduationYear.Text.Replace("'", "''") + "',CGPA='" + txtCGPA.Text.Replace("'", "''") + "',PreferredDomain='" + txtPreferredDomain.Text.Replace("'", "''") + "',PreferredRole='" + txtPreferredRole.Text.Replace("'", "''") + "',PreferredLocation='" + txtPreferredLocation.Text.Replace("'", "''") + "',WorkMode='" + ddlWorkMode.SelectedValue.Replace("'", "''") + "',Availability='" + ddlAvailability.SelectedValue.Replace("'", "''") + "',AboutMe='" + txtAboutMe.Text.Replace("'", "''") + "',LinkedIn='" + txtLinkedIn.Text.Replace("'", "''") + "',GitHub='" + txtGitHub.Text.Replace("'", "''") + "',Portfolio='" + txtPortfolio.Text.Replace("'", "''") + "'";

            if (!string.IsNullOrEmpty(nm))
            {
                q += ",ProfilePhoto='" + nm + "'";
            }

            q += " where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'";

            cmd = new SqlCommand(q, con);
            cmd.ExecuteNonQuery();

            Session["student"] = txtEmailAddress.Text;

            Response.Redirect("student-profile.aspx");
        }
    }
}

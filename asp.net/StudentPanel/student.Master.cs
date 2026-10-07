using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class student : System.Web.UI.MasterPage
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }

            getcon();
            da = new SqlDataAdapter("select * from Students where (Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "') and (IsBlocked = 0 OR IsBlocked IS NULL) and (Status != 'Blocked' OR Status IS NULL)", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string name =ds.Tables[0].Rows[0]["FullName"].ToString();
                Label1.Text = "Welcome " + name;
                lblSidebarStudentName.Text = name;

                string photo = ds.Tables[0].Rows[0]["ProfilePhoto"] != DBNull.Value ? ds.Tables[0].Rows[0]["ProfilePhoto"].ToString() : "";

                if (!string.IsNullOrEmpty(photo))
                {
                    if (!photo.StartsWith("~") && !photo.StartsWith("/"))
                    {
                        photo = "~/StudentUploads/" + photo;
                    }
                    imgHeaderAvatar.ImageUrl = ResolveUrl(photo);
                    imgHeaderAvatar.Visible = true;
                    lblHeaderAvatarInitials.Visible = false;

                    imgSidebarAvatar.ImageUrl = ResolveUrl(photo);
                    imgSidebarAvatar.Visible = true;
                    lblSidebarAvatarInitials.Visible = false;
                }
                else
                {
                    imgHeaderAvatar.Visible = false;
                    lblHeaderAvatarInitials.Visible = true;
                    lblHeaderAvatarInitials.Text = GetInitials(name);

                    imgSidebarAvatar.Visible = false;
                    lblSidebarAvatarInitials.Visible = true;
                    lblSidebarAvatarInitials.Text = GetInitials(name);
                }
            }
            else
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        protected void lbLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/PublicPanel/login.aspx");
        }
    }
}

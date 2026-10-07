using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class company : System.Web.UI.MasterPage
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        private string GetInitials(string name)
        {
            if (string.IsNullOrWhiteSpace(name)) return "CO";
            var parts = name.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length == 1)
            {
                return parts[0].Length >= 2 ? parts[0].Substring(0, 2).ToUpper() : parts[0].ToUpper();
            }
            return (parts[0][0].ToString() + parts[parts.Length - 1][0].ToString()).ToUpper();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }

            getcon();

                da = new SqlDataAdapter(
                    "select * from c_registration where c_email='" +
                    Session["company"] + "' and (IsBlocked = 0 OR IsBlocked IS NULL) and (Status != 'Blocked' OR Status IS NULL)", con);

                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string name =
                        ds.Tables[0].Rows[0]["c_company"].ToString();

                    lblProfileName.Text = "Welcome " + name;
                    lblSidebarCompanyName.Text = name;

                    string logo = ds.Tables[0].Rows[0]["c_logo"] != DBNull.Value ? ds.Tables[0].Rows[0]["c_logo"].ToString() : "";

                    if (!string.IsNullOrEmpty(logo))
                    {
                        if (!logo.StartsWith("~") && !logo.StartsWith("/"))
                        {
                            logo = "~/CompanyUploads/" + logo;
                        }
                        string resolvedUrl = ResolveUrl(logo);
                        imgHeaderLogo.ImageUrl = resolvedUrl;
                        imgHeaderLogo.Visible = true;
                        lblAvatarInitials.Visible = false;

                        imgSidebarLogo.ImageUrl = resolvedUrl;
                        imgSidebarLogo.Visible = true;
                        lblSidebarAvatarInitials.Visible = false;
                    }
                    else
                    {
                        string initials = GetInitials(name);
                        imgHeaderLogo.Visible = false;
                        lblAvatarInitials.Visible = true;
                        lblAvatarInitials.Text = initials;

                        imgSidebarLogo.Visible = false;
                        lblSidebarAvatarInitials.Visible = true;
                        lblSidebarAvatarInitials.Text = initials;
                    }

                    // Dynamic Badges for Messages
                    string compId = ds.Tables[0].Rows[0]["CompanyId"].ToString();

                    SqlDataAdapter daMsg = new SqlDataAdapter("SELECT COUNT(*) FROM CompanyMessages WHERE CompanyId=" + compId + " AND (IsRead = 0 OR IsRead IS NULL)", con);
                    DataSet dsMsg = new DataSet();
                    daMsg.Fill(dsMsg);
                    if (dsMsg.Tables.Count > 0 && dsMsg.Tables[0].Rows.Count > 0)
                    {
                        int msgCount = Convert.ToInt32(dsMsg.Tables[0].Rows[0][0]);
                        if (msgCount > 0)
                        {
                            lblMsgBadge.Text = msgCount > 99 ? "99+" : msgCount.ToString();
                            lblMsgBadge.Visible = true;
                        }
                        else
                        {
                            lblMsgBadge.Visible = false;
                        }
                    }
                }
                else
                {
                    Session.Clear();
                    Session.Abandon();

                    Response.Redirect("~/PublicPanel/login.aspx");
                    return;
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

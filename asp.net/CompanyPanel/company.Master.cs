using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

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

                    string logo = ds.Tables[0].Rows[0]["c_logo"].ToString();
                    string resolvedUrl = ResolveUrl("~/student_images/default-avatar.png");
                    if (logo != "")
                    {
                        resolvedUrl = ResolveUrl(logo);
                    }
                    imgHeaderLogo.ImageUrl = resolvedUrl;
                    imgHeaderLogo.Visible = true;

                    imgSidebarLogo.ImageUrl = resolvedUrl;
                    imgSidebarLogo.Visible = true;

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

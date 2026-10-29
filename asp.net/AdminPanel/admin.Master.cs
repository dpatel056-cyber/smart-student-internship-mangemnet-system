using System;

namespace asp.net
{
    public partial class admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        public string GetAdminName()
        {
            if (Session["admin"] != null)
            {
                return Session["admin"].ToString().Split('@')[0];
            }

            return "Admin";
        }

        public string GetAdminInitials()
        {
            string name = GetAdminName();

            if (name.Length >= 2)
            {
                return name.Substring(0, 2).ToUpper();
            }

            return name.ToUpper();
        }
    }
}

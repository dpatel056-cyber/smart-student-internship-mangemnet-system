using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        public string GetAdminName()
        {
            if (Session["admin"] != null && !string.IsNullOrWhiteSpace(Session["admin"].ToString()))
            {
                string adminEmail = Session["admin"].ToString().Trim();
                int atIndex = adminEmail.IndexOf('@');
                if (atIndex > 0)
                {
                    string namePart = adminEmail.Substring(0, atIndex);
                    return char.ToUpper(namePart[0]) + namePart.Substring(1);
                }
                return adminEmail;
            }
            return "Admin";
        }

        public string GetAdminInitials()
        {
            string name = GetAdminName();
            if (string.IsNullOrWhiteSpace(name)) return "AD";
            if (name.Length >= 2) return name.Substring(0, 2).ToUpper();
            return name.ToUpper();
        }
    }
}

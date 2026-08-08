using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class Companydashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "company")
            {
                Response.Redirect("login.aspx");
                return;
            }

            //if (!IsPostBack)
            //{
            //    if (Session["UserName"] != null)
            //    {
            //        litWelcomeCompanyName.Text = Session["UserName"].ToString();
            //    }
            //    litToday.Text = DateTime.Now.ToString("dddd, dd MMMM yyyy");
            //}
        }
    }
}
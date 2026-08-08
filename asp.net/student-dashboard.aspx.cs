using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserRole"] == null || Session["UserRole"].ToString() != "student")
            {
                Response.Redirect("login.aspx");
                return;
            }

            //if (!IsPostBack)
            //{
            //    string sName = Session["UserName"] != null ? Session["UserName"].ToString() : "Student";
            //    string sEmail = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : "student@sims.com";

            //    litWelcomeStudentName.Text = sName;
            //    litProfileName.Text = sName;
            //    litProfileEmail.Text = sEmail;
            //    litToday.Text = DateTime.Now.ToString("dddd, dd MMMM yyyy");
            //}
        }
    }
}
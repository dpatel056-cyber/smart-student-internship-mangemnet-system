using System;
using System.Web.UI;

namespace asp.net.AdminPanel
{
    public partial class Admin_Contact_Messages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // In a real application, you would load contact messages from the database here
                // e.g., BindMessagesTable();
            }
        }
    }
}

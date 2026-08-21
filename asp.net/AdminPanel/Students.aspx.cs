using System;
using System.Data;

namespace asp.net
{
    public partial class Students : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindStudents();
            }
        }

        private void BindStudents()
        {
            var dt = new DataTable();
            dt.Columns.Add("StudentID");
            dt.Columns.Add("StudentName");
            dt.Columns.Add("Email");
            dt.Columns.Add("Mobile");
            dt.Columns.Add("Course");
            dt.Columns.Add("Semester");
            dt.Columns.Add("Department");
            dt.Columns.Add("Status");
            dt.Columns.Add("StatusClass");
            dt.Columns.Add("Avatar");

            dt.Rows.Add("ST001", "Aarav Patel", "aarav@gmail.com", "9876543210", "BCA", "5th", "Computer Science", "Active", "is-active", "AP");
            dt.Rows.Add("ST002", "Dhruv Patel", "dhruv@gmail.com", "9876543211", "BCA", "5th", "Computer Science", "Active", "is-active", "DP");
            dt.Rows.Add("ST003", "Riya Shah", "riya@gmail.com", "9876543212", "MCA", "3rd", "Computer Science", "Pending", "is-pending", "RS");
            dt.Rows.Add("ST004", "Krisha Patel", "krisha@gmail.com", "9876543213", "BCA", "3rd", "Information Technology", "Active", "is-active", "KP");

            gvStudents.DataSource = dt;
            gvStudents.DataBind();
        }
    }
}


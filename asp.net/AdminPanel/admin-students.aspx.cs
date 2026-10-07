using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class admin_students : System.Web.UI.Page
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from admin_registration where Email='" + Session["admin"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    studentfillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void studentfillgrid()
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM Students ORDER BY StudentId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_view")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("viewStudentDetails.aspx?id=" + id);
            }
            else if (e.CommandName == "cmd_toggle_block")
            {
                string id = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("SELECT IsBlocked FROM Students WHERE StudentId='" + id + "'", con);
                ds = new DataSet();
                da = new SqlDataAdapter(cmd);
                da.Fill(ds);

                if (Convert.ToBoolean(ds.Tables[0].Rows[0]["IsBlocked"]))
                {
                    cmd = new SqlCommand("UPDATE Students SET IsBlocked=0, Status='Active' WHERE StudentId='" + id + "'", con);
                }
                else
                {
                    cmd = new SqlCommand("UPDATE Students SET IsBlocked=1, Status='Blocked' WHERE StudentId='" + id + "'", con);
                }

                cmd.ExecuteNonQuery();
                studentfillgrid();
            }
            else if (e.CommandName == "cmd_del")
            {
                string id = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("DELETE FROM StudentTasks WHERE StudentId=" + id + "; " + "DELETE FROM StudentProjects WHERE StudentId=" + id + "; " + "DELETE FROM StudentSkills WHERE StudentId=" + id + "; " + "DELETE FROM StudentQuizAssignments WHERE StudentId=" + id + "; " + "DELETE FROM StudentSavedInternships WHERE StudentId=" + id + "; " + "DELETE FROM CompanyCertificates WHERE StudentId=" + id + "; " + "DELETE FROM CompanyOfferLetters WHERE StudentId=" + id + "; " + "DELETE FROM CompanyInterviews WHERE StudentId=" + id + "; " + "DELETE FROM StudentApplications WHERE StudentId=" + id + "; " + "DELETE FROM Students WHERE StudentId=" + id, con);
                cmd.ExecuteNonQuery();
                studentfillgrid();
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

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

        void ShowStudents()
        {
            getcon();
            da = new SqlDataAdapter("SELECT * FROM Students ORDER BY StudentId DESC", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();

            if (GridView1.Rows.Count > 0)
            {
                GridView1.UseAccessibleHeader = true;
                GridView1.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ShowStudents();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_del")
            {
                string id = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("delete from Students where StudentId=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
                con.Close();
                ShowStudents();
            }
        }

        protected void btnConfirmDeleteStudent_Click(object sender, EventArgs e)
        {
            if (hfDeleteStudentId.Value != "")
            {
                string id = hfDeleteStudentId.Value;
                getcon();
                cmd = new SqlCommand("delete from Students where StudentId=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
                con.Close();
                hfDeleteStudentId.Value = "";
                ShowStudents();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "CloseDeleteModal", "closeDeleteModal();", true);
            }
        }
    }
}


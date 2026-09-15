using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace asp.net.AdminPanel
{
    public partial class Admin_Contact_Messages : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                showcontact();
                
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void showcontact()
        {
            getcon();
            da = new SqlDataAdapter("select * from cont order by c_date desc, Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();
        }

        

        protected void GridView1_RowCommand(object sender,System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewContact")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                hfContactId.Value = id.ToString();
                getContactDetails(id);

            }
        }

        void getContactDetails(int id)
        {
            getcon();
            da = new SqlDataAdapter("select * from cont where Id=@id", con);
            da.SelectCommand.Parameters.AddWithValue("@id", id);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {

                DataRow dr =ds.Tables[0].Rows[0];
                lblDetailName.Text =dr["c_name"].ToString();
                lblDetailEmail.Text =dr["c_email"].ToString();
                lblDetailSubject.Text =dr["c_subject"].ToString();
                lblDetailMessage.Text =dr["c_message"].ToString();

                if (dr["c_date"] != DBNull.Value)
                {
                    lblDetailDate.Text =Convert.ToDateTime(dr["c_date"]).ToString("dd MMM yyyy, hh:mm tt");
                }
                else
                {
                    lblDetailDate.Text = "";
                }

            }
            ScriptManager.RegisterStartupScript(this,this.GetType(),"OpenDrawer","openDrawer();",true);
        }



        protected void btnDeleteContact_Click(object sender,EventArgs e)
        {
            if (hfContactId.Value != "")
            {
                int id =Convert.ToInt32(hfContactId.Value);
                getcon();
                cmd = new SqlCommand("delete from cont where Id=@id", con);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.ExecuteNonQuery();
                con.Close();
                hfContactId.Value ="";
                showcontact();
           
                ScriptManager.RegisterStartupScript(this,this.GetType(),"CloseAll", "closeDeleteModal(); closeDrawer();",true);
            }
        }
    }
}
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_applicants : System.Web.UI.Page
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
            if (Session["company"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from c_registration where c_email='" + Session["company"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    bindApplicants();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void bindApplicants()
        {
            getcon();
            da = new SqlDataAdapter("select a.*, ISNULL(a.Status, 'Applied') AS Status, i.InternshipTitle from StudentApplications a inner join internship i on a.InternshipId=i.Id where i.CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"].ToString() + "') order by a.ApplicationId desc", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvApplicants.DataSource = ds;
                gvApplicants.DataBind();

                gvApplicants.Visible = true;
                pnlNoApplicants.Visible = false;
            }
            else
            {
                gvApplicants.Visible = false;
                pnlNoApplicants.Visible = true;
            }
        }

        protected void gvApplicants_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvApplicants.EditIndex = e.NewEditIndex;
            bindApplicants();
        }

        protected void gvApplicants_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvApplicants.EditIndex = -1;
            bindApplicants();
        }

        protected void gvApplicants_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int appId = Convert.ToInt32(gvApplicants.DataKeys[e.RowIndex].Value.ToString());
            GridViewRow row = (GridViewRow)gvApplicants.Rows[e.RowIndex];
            DropDownList ddl = (DropDownList)row.FindControl("ddlChangeStatus");
            string status = ddl.SelectedValue;

            getcon();
            cmd = new SqlCommand("update StudentApplications set Status='" + status + "' where ApplicationId='" + appId + "'", con);
            cmd.ExecuteNonQuery();

            gvApplicants.EditIndex = -1;
            bindApplicants();
        }

        public string GetStatusBadge(object status)
        {
            if (status == null || status == DBNull.Value)
            {
                return "<span class='badge-status-chip st-applied'>Applied</span>";
            }

            if (status.ToString() == "Shortlisted")
            {
                return "<span class='badge-status-chip st-shortlisted'>Shortlisted</span>";
            }

            if (status.ToString() == "Selected")
            {
                return "<span class='badge-status-chip st-selected'>Selected</span>";
            }

            if (status.ToString() == "Rejected")
            {
                return "<span class='badge-status-chip st-rejected'>Rejected</span>";
            }

            return "<span class='badge-status-chip st-applied'>" +
                   status.ToString() +
                   "</span>";
        }

        public string GetInitials(object nameObj)
        {
            if (nameObj == null || nameObj == DBNull.Value) return "ST";
            string name = nameObj.ToString().Trim();
            if (string.IsNullOrEmpty(name)) return "ST";
            string[] parts = name.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length > 1 && parts[1].Length > 0)
                return (parts[0][0].ToString() + parts[1][0].ToString()).ToUpper();
            return name.Length > 1 ? name.Substring(0, 2).ToUpper() : name.ToUpper();
        }
    }
}

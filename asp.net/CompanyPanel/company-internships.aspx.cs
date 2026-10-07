using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_internships : System.Web.UI.Page
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
                    bindInternships();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void bindInternships()
        {
            getcon();

            da = new SqlDataAdapter("SELECT i.*, c.c_company, c.c_logo FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId WHERE c.c_email = '" + Session["company"] + "' ORDER BY i.Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListMyInternships.DataSource = ds.Tables[0];
                DataListMyInternships.DataBind();

                DataListMyInternships.Visible = true;
                pnlNoMyInternships.Visible = false;
            }
            else
            {
                DataListMyInternships.Visible = false;
                pnlNoMyInternships.Visible = true;
            }
        }
        //------------------------------
        //*****************************
        //------------------------------
        public bool IsInternshipActive(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value || string.IsNullOrWhiteSpace(statusObj.ToString()))
            {
                return true;
            }
            string status = statusObj.ToString().Trim();
            if (string.Equals(status, "Inactive", StringComparison.OrdinalIgnoreCase) ||
                string.Equals(status, "Draft", StringComparison.OrdinalIgnoreCase))
            {
                return false;
            }
            return true;
        }

        //------------------------------
        //*****************************
        //------------------------------
        public string GetCompanyLogo(object logoObj, object logoObj2 = null)
        {
            object targetLogo = (logoObj != null && logoObj != DBNull.Value && !string.IsNullOrEmpty(logoObj.ToString())) ? logoObj : logoObj2;
            if (targetLogo != null && targetLogo != DBNull.Value && !string.IsNullOrEmpty(targetLogo.ToString()))
            {
                string logo = targetLogo.ToString();
                if (logo.StartsWith("~") || logo.StartsWith("/"))
                {
                    return ResolveUrl(logo);
                }
                return ResolveUrl("~/CompanyUploads/" + logo);
            }
            return ResolveUrl("~/assets/default-company.png");
        }

        protected void DataListMyInternships_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (Session["company"] == null) return;

            if (e.CommandName == "DeleteInternship")
            {
                string internshipId = e.CommandArgument.ToString();
                getcon();
                cmd = new SqlCommand("DELETE FROM internship WHERE Id='" + internshipId + "' AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"] + "')", con);
                cmd.ExecuteNonQuery();

                bindInternships();
            }
            //------------------------------
            //*****************************
            //------------------------------
            else if (e.CommandName == "ToggleStatus")
            {
                string arg = e.CommandArgument.ToString();
                string[] parts = arg.Split('|');
                string internshipId = parts[0];
                string currentStatus = parts.Length > 1 ? parts[1] : "";

                bool isActive = IsInternshipActive(currentStatus);
                string newStatus = isActive ? "Inactive" : "Active";

                getcon();
                cmd = new SqlCommand("UPDATE internship SET Status = '" + newStatus + "' WHERE Id = '" + internshipId + "' AND CompanyId = (SELECT CompanyId FROM c_registration WHERE c_email = '" + Session["company"].ToString() + "')", con);
                cmd.ExecuteNonQuery();

                bindInternships();
            }
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_shortlisted : System.Web.UI.Page
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
                    bindInternshipDropdown();
                    bindShortlisted();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void bindInternshipDropdown()
        {
            getcon();
            da = new SqlDataAdapter("SELECT Id, InternshipTitle FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "') ORDER BY Id DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            ddlInternshipFilter.Items.Clear();
            ddlInternshipFilter.Items.Add(new ListItem("All Internships", ""));
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    ddlInternshipFilter.Items.Add(new ListItem(row["InternshipTitle"].ToString(), row["Id"].ToString()));
                }
            }
        }

        void bindShortlisted()
        {
            getcon();
            da = new SqlDataAdapter("SELECT a.*, i.InternshipTitle FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE a.Status='Shortlisted' AND i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "') ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvShortlisted.DataSource = ds.Tables[0];
                gvShortlisted.DataBind();
                gvShortlisted.Visible = true;
                pnlNoShortlisted.Visible = false;
            }
            else
            {
                gvShortlisted.Visible = false;
                pnlNoShortlisted.Visible = true;
            }
        }

        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            bindShortlisted();
        }

        protected void gvShortlisted_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandArgument == null) return;
            string appId = e.CommandArgument.ToString();

            if (e.CommandName == "SelectCandidate")
            {
                updateStatus(appId, "Selected");
            }
            else if (e.CommandName == "RejectCandidate")
            {
                updateStatus(appId, "Rejected");
            }
        }

        void updateStatus(string appId, string newStatus)
        {
            getcon();
            cmd = new SqlCommand("UPDATE StudentApplications SET Status='" + newStatus + "' WHERE ApplicationId=" + appId + " AND InternshipId IN (SELECT Id FROM internship WHERE CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'))", con);
            cmd.ExecuteNonQuery();

            lblMsg.Text = "<div style='background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:12px 18px; border-radius:10px; margin-bottom:18px; font-weight:600; display:flex; align-items:center; gap:8px;'><i class='fa-solid fa-circle-check'></i> Student application status successfully updated to <span style=\"font-weight:700;\">" + newStatus + "</span>!</div>";
            lblMsg.Visible = true;

            bindShortlisted();
        }

        public string GetInitials(object nameObj)
        {
            if (nameObj == null || nameObj == DBNull.Value) return "ST";
            string name = nameObj.ToString().Trim();
            if (string.IsNullOrEmpty(name)) return "ST";
            string[] parts = name.Split(' ');
            if (parts.Length > 1 && parts[1].Length > 0)
                return (parts[0][0].ToString() + parts[1][0].ToString()).ToUpper();
            return name.Length > 1 ? name.Substring(0, 2).ToUpper() : name.ToUpper();
        }

        public string FormatDate(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value) return "N/A";
            DateTime dt;
            if (DateTime.TryParse(dateObj.ToString(), out dt))
            {
                return dt.ToString("dd MMM yyyy");
            }
            return dateObj.ToString();
        }

        public string GetStatusBadge(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value) return "<span class='badge-status-chip st-shortlisted'>Shortlisted</span>";
            string st = statusObj.ToString().Trim();
            if (st.Equals("Shortlisted", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-status-chip st-shortlisted'>Shortlisted</span>";
            if (st.Equals("Selected", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-status-chip st-selected'>Selected</span>";
            if (st.Equals("Rejected", StringComparison.OrdinalIgnoreCase))
                return "<span class='badge-status-chip st-rejected'>Rejected</span>";
            return "<span class='badge-status-chip st-applied'>" + st + "</span>";
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class company_selected_students : System.Web.UI.Page
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
                    bindSelected();
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

        void bindSelected()
        {
            getcon();
            da = new SqlDataAdapter("SELECT a.*, i.InternshipTitle FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id WHERE (a.Status='Selected' OR a.Status='Offer Accepted' OR a.Status='Accepted' OR a.ApplicationId IN (SELECT ApplicationId FROM CompanyOfferLetters WHERE Status='Accepted' AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')) OR a.ApplicationId IN (SELECT ApplicationId FROM CompanyInterviews WHERE Status='Completed' AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'))) AND i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "') ORDER BY a.ApplicationId DESC", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvSelected.DataSource = ds.Tables[0];
                gvSelected.DataBind();
                gvSelected.Visible = true;
                pnlNoSelected.Visible = false;
            }
            else
            {
                gvSelected.Visible = false;
                pnlNoSelected.Visible = true;
            }
        }

        protected void ddlFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            bindSelected();
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
            string st = statusObj != null ? statusObj.ToString().Trim() : "Selected";
            if (st.Equals("Offer Accepted", StringComparison.OrdinalIgnoreCase) || st.Equals("Accepted", StringComparison.OrdinalIgnoreCase))
            {
                return "<span class=\"co-badge badge-selected\" style=\"background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:5px 12px; border-radius:20px; font-size:12px; font-weight:600; display:inline-flex; align-items:center; gap:5px;\"><i class=\"fa-solid fa-circle-check\"></i> Offer Accepted</span>";
            }
            return "<span class=\"co-badge badge-selected\" style=\"background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:5px 12px; border-radius:20px; font-size:12px; font-weight:600; display:inline-flex; align-items:center; gap:5px;\"><i class=\"fa-solid fa-circle-check\"></i> Selected</span>";
        }
    }
}

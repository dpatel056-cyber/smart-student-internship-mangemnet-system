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
            da = new SqlDataAdapter("SELECT a.*, i.InternshipTitle, CASE WHEN s.ProfilePhoto LIKE '~/%' THEN s.ProfilePhoto WHEN s.ProfilePhoto LIKE 'student_images/%' THEN '~/' + s.ProfilePhoto WHEN s.ProfilePhoto IS NOT NULL AND s.ProfilePhoto <> '' THEN '~/student_images/' + s.ProfilePhoto ELSE '~/student_images/default-avatar.png' END AS ProfilePhoto FROM StudentApplications a INNER JOIN internship i ON a.InternshipId = i.Id LEFT JOIN Students s ON a.StudentId = s.StudentId WHERE (a.Status='Selected' OR a.Status='Offer Accepted' OR a.Status='Accepted' OR a.ApplicationId IN (SELECT ApplicationId FROM CompanyOfferLetters WHERE Status='Accepted' AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "')) OR a.ApplicationId IN (SELECT ApplicationId FROM CompanyInterviews WHERE Status='Completed' AND CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "'))) AND i.CompanyId=(SELECT CompanyId FROM c_registration WHERE c_email='" + Session["company"].ToString() + "') ORDER BY a.ApplicationId DESC", con);
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

        public string GetStatusBadge(object statusObj)
        {
            string st = Convert.ToString(statusObj);
            if (st == "Offer Accepted" || st == "Accepted")
            {
                return "<span class=\"co-badge badge-selected\" style=\"background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:5px 12px; border-radius:20px; font-size:12px; font-weight:600; display:inline-flex; align-items:center; gap:5px;\"><i class=\"fa-solid fa-circle-check\"></i> Offer Accepted</span>";
            }
            return "<span class=\"co-badge badge-selected\" style=\"background:#dcfce7; color:#15803d; border:1px solid #bbf7d0; padding:5px 12px; border-radius:20px; font-size:12px; font-weight:600; display:inline-flex; align-items:center; gap:5px;\"><i class=\"fa-solid fa-circle-check\"></i> Selected</span>";
        }
    }
}

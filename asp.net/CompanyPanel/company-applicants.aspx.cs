using System;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web.Design;

namespace asp.net
{
    public partial class company_applicants : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;
        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        private CrystalDecisions.CrystalReports.Engine.ReportDocument cr = new ReportDocument();
        static string Crypath = "";

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        CompanyClass comp = new CompanyClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["company"] != null)
            {
                if (!IsPostBack)
                {
                    ViewState["page"] = 0;
                    fillInternships();
                    applicantfillgrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void fillInternships()
        {
            try
            {
                if (ddlInternshipFilter != null)
                {
                    getcon();
                    da = new SqlDataAdapter("select Id, InternshipTitle from internship where CompanyId=(select CompanyId from c_registration where c_email='" + Session["company"] + "') order by InternshipTitle", con);
                    DataTable dtInt = new DataTable();
                    da.Fill(dtInt);
                    con.Close();

                    ddlInternshipFilter.Items.Clear();
                    ddlInternshipFilter.Items.Add(new System.Web.UI.WebControls.ListItem("All Internships", ""));
                    foreach (DataRow row in dtInt.Rows)
                    {
                        ddlInternshipFilter.Items.Add(new System.Web.UI.WebControls.ListItem(row["InternshipTitle"].ToString(), row["Id"].ToString()));
                    }
                }
            }
            catch
            {
                if (con != null && con.State == ConnectionState.Open) con.Close();
            }
        }

        // Fill GridView with search, status, and internship filtering (5 rows per page)
        void applicantfillgrid()
        {
            try
            {
                comp = new CompanyClass();

                string search = (txtSearch != null) ? txtSearch.Text.Trim() : "";
                string status = (ddlStatusFilter != null) ? ddlStatusFilter.SelectedValue : "";
                string internshipId = (ddlInternshipFilter != null && ddlInternshipFilter.SelectedValue != "") ? ddlInternshipFilter.SelectedValue : "";

                string q = "select a.ApplicationId, a.StudentId, a.InternshipId, a.AppliedDate, ISNULL(a.Status, 'Applied') AS Status, ISNULL(a.FullName, s.FullName) AS FullName, ISNULL(a.StudentEmail, s.Email) AS StudentEmail, i.InternshipTitle, ISNULL(s.ProfilePhoto, '~/student_images/default-avatar.png') AS ProfilePhoto from StudentApplications a inner join internship i on a.InternshipId=i.Id inner join c_registration c on i.CompanyId=c.CompanyId left join Students s on a.StudentId=s.StudentId where c.c_email='" + Session["company"] + "'";

                if (!string.IsNullOrEmpty(search))
                {
                    q += " and (a.FullName like '%" + search + "%' or s.FullName like '%" + search + "%' or a.StudentEmail like '%" + search + "%' or s.Email like '%" + search + "%' or i.InternshipTitle like '%" + search + "%')";
                }

                if (!string.IsNullOrEmpty(status))
                {
                    if (status == "Applied")
                    {
                        q += " and (a.Status='Applied' or a.Status is null or a.Status='' or a.Status not in ('Shortlisted', 'Selected', 'Rejected'))";
                    }
                    else
                    {
                        q += " and a.Status='" + status + "'";
                    }
                }

                if (!string.IsNullOrEmpty(internshipId))
                {
                    q += " and i.Id='" + internshipId + "'";
                }

                q += " order by a.ApplicationId desc";

                getcon();
                da = new SqlDataAdapter(q, con);
                DataSet dsApp = new DataSet();
                da.Fill(dsApp);
                con.Close();

                DataTable dt = dsApp.Tables[0];
                int page = Convert.ToInt32(ViewState["page"] ?? 0);
                int totalPages = (int)Math.Ceiling(dt.Rows.Count / 5.0);
                if (totalPages > 0 && page >= totalPages)
                {
                    page = totalPages - 1;
                    ViewState["page"] = page;
                }
                else if (page < 0)
                {
                    page = 0;
                    ViewState["page"] = 0;
                }

                DataTable pagedDt = comp.applicant_pagination(dt, page);
                gvApplicants.DataSource = pagedDt;
                gvApplicants.DataBind();

                if (pnlNoApplicants != null)
                {
                    pnlNoApplicants.Visible = (dt.Rows.Count == 0);
                }
                gvApplicants.Visible = (dt.Rows.Count > 0);

                lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);
                btnPrevious.Enabled = page > 0;
                btnNext.Enabled = (page + 1) * 5 < dt.Rows.Count;
            }
            catch
            {
                if (con != null && con.State == ConnectionState.Open) con.Close();
            }
        }

        // Search Button Click
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ViewState["page"] = 0;
            applicantfillgrid();
        }

        // Status DropDownList SelectedIndexChanged
        protected void ddlStatusFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState["page"] = 0;
            applicantfillgrid();
        }

        // Internship DropDownList SelectedIndexChanged
        protected void ddlInternshipFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            ViewState["page"] = 0;
            applicantfillgrid();
        }

        // Reset Button Click
        protected void btnClearFilters_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            if (ddlStatusFilter != null && ddlStatusFilter.Items.Count > 0) ddlStatusFilter.SelectedIndex = 0;
            if (ddlInternshipFilter != null && ddlInternshipFilter.Items.Count > 0) ddlInternshipFilter.SelectedIndex = 0;
            ViewState["page"] = 0;
            applicantfillgrid();
        }

        // Generate Report Button Click (Crystal Report PDF Export)
        protected void btnGenerateReport_Click(object sender, EventArgs e)
        {
            getcon();
            da = new SqlDataAdapter("select a.ApplicationId as [Application Id], ISNULL(a.FullName, s.FullName) as [Student Name], ISNULL(a.StudentEmail, s.Email) as [Email], i.InternshipTitle as [Internship], c.c_company as [Company], a.AppliedDate as [Applied Date], ISNULL(a.Status, 'Applied') as [Status] from StudentApplications a inner join internship i on a.InternshipId = i.Id inner join c_registration c on i.CompanyId = c.CompanyId left join Students s on a.StudentId = s.StudentId where c.c_email='" + Session["company"] + "' order by a.ApplicationId desc", con);
            ds = new DataSet();
            da.Fill(ds);
            con.Close();

            string sXml = Server.MapPath("~/company_applicants_report_data.xml");
            ds.WriteXmlSchema(sXml);

            Crypath = Server.MapPath("~/CompanyPanel/company_applicants_report.rpt");
            cr.Load(Crypath);
            cr.SetDataSource(ds.Tables[0]);
            cr.Refresh();
            CrystalReportViewer1.ReportSource = cr;
            cr.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, true, "Company Applicants Report");
        }

        // Pagination Click Events
        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
            applicantfillgrid();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            applicantfillgrid();
        }

        protected void gvApplicants_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvApplicants.EditIndex = e.NewEditIndex;
            applicantfillgrid();
        }

        protected void gvApplicants_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && (e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("DropDownList1");
                if (ddl != null && e.Row.DataItem != null)
                {
                    DataRowView drv = e.Row.DataItem as DataRowView;
                    if (drv != null && drv["Status"] != DBNull.Value)
                    {
                        string currentStatus = drv["Status"].ToString();
                        System.Web.UI.WebControls.ListItem item = ddl.Items.FindByValue(currentStatus);
                        if (item != null)
                        {
                            ddl.ClearSelection();
                            item.Selected = true;
                        }
                    }
                }
            }
        }

        protected void gvApplicants_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvApplicants.EditIndex = -1;
            applicantfillgrid();
        }

        protected void gvApplicants_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int appId = Convert.ToInt32(gvApplicants.DataKeys[e.RowIndex].Value.ToString());
            GridViewRow row = (GridViewRow)gvApplicants.Rows[e.RowIndex];
            DropDownList ddlstatus = (DropDownList)row.FindControl("DropDownList1");
            if (ddlstatus != null)
            {
                string status = ddlstatus.SelectedValue;
                getcon();
                cmd = new SqlCommand("update StudentApplications set Status='" + status + "' where ApplicationId='" + appId + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            gvApplicants.EditIndex = -1;
            applicantfillgrid();
        }

        public string GetStatusBadge(object status)
        {
            if (status == null || status == DBNull.Value)
            {
                return "<span class='badge-status-chip st-applied'>Applied</span>";
            }
            string st = status.ToString();
            if (st == "Shortlisted")
            {
                return "<span class='badge-status-chip st-shortlisted'>Shortlisted</span>";
            }
            if (st == "Selected")
            {
                return "<span class='badge-status-chip st-selected'>Selected</span>";
            }
            if (st == "Rejected")
            {
                return "<span class='badge-status-chip st-rejected'>Rejected</span>";
            }
            return "<span class='badge-status-chip st-applied'>" + st + "</span>";
        }
    }
}

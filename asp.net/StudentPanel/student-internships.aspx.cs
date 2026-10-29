using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_internships : System.Web.UI.Page
    {
        StudentClass stu = new StudentClass();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] == null)
            {
                Response.Redirect("~/PublicPanel/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                ViewState["page"] = 0;
                fillgrid();
            }
        }

        void fillgrid()
        {
            stu = new StudentClass();
            DataTable dt = stu.select_internship().Tables[0];

            lblTotalInternships.Text = "Total Internships: " + dt.Rows.Count;

            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 12.0);

            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            DataListPublicInternships.DataSource = stu.Internship_pagination(dt, page);
            DataListPublicInternships.DataBind();

            lblPages.Text = "Page " + (page + 1) + " of " + (totalPages > 0 ? totalPages : 1);

            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = page < totalPages - 1;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            lblTotalInternships.Text = "Total Internships: " + (dt != null ? dt.Rows.Count : 0);
            DataListPublicInternships.DataSource = stu.Internship_pagination(dt, 0);
            DataListPublicInternships.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 12.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = totalPages > 1;
        }

        // Search Button Click
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            stu = new StudentClass();
            filtergrid(stu.search_internship(searchInput.Text).Tables[0]);
        }

        // Category / Domain DropDownList SelectedIndexChanged
        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            stu = new StudentClass();
            filtergrid(stu.select_internship_by_category(ddlCategory.SelectedValue).Tables[0]);
        }

        // Location / City DropDownList SelectedIndexChanged
        protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            stu = new StudentClass();
            filtergrid(stu.select_internship_by_city(ddlLocation.SelectedValue).Tables[0]);
        }

        // Duration DropDownList SelectedIndexChanged
        protected void ddlDuration_SelectedIndexChanged(object sender, EventArgs e)
        {
            stu = new StudentClass();
            filtergrid(stu.select_internship_by_duration(ddlDuration.SelectedValue).Tables[0]);
        }

        // Sort By DropDownList SelectedIndexChanged
        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            stu = new StudentClass();
            filtergrid(stu.sort_internship(ddlSortBy.SelectedValue).Tables[0]);
        }

        // Reset Button Click
        protected void btnReset_Click(object sender, ImageClickEventArgs e)
        {
            searchInput.Text = "";
            ddlCategory.SelectedIndex = 0;
            ddlLocation.SelectedIndex = 0;
            ddlDuration.SelectedIndex = 0;
            ddlSortBy.SelectedIndex = 0;
            ViewState["page"] = 0;
            fillgrid();
        }

        // Pagination Click Events
        protected void btnPrevious_Click(object sender, ImageClickEventArgs e)
        {
            int page = Convert.ToInt32(ViewState["page"]);
            if (page > 0)
            {
                ViewState["page"] = page - 1;
            }
            fillgrid();
        }

        protected void btnNext_Click(object sender, ImageClickEventArgs e)
        {
            ViewState["page"] = Convert.ToInt32(ViewState["page"]) + 1;
            fillgrid();
        }

        // Bookmark Action
        protected void DataListPublicInternships_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Bookmark")
            {
                string internshipId = e.CommandArgument != null ? e.CommandArgument.ToString() : "";
                string sessionStudent = Session["student"] != null ? Session["student"].ToString() : "";
                if (!string.IsNullOrEmpty(sessionStudent) && !string.IsNullOrEmpty(internshipId))
                {
                    stu = new StudentClass();
                    stu.toggle_bookmark(sessionStudent, internshipId);
                    fillgrid();
                }
            }
        }

        public bool IsInternshipSaved(object idObj)
        {
            if (idObj == null || Session["student"] == null) return false;
            stu = new StudentClass();
            return stu.is_internship_saved(Session["student"].ToString(), idObj.ToString());
        }

        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj == null || logoObj == DBNull.Value)
                return ResolveUrl("~/CompanyUploads/default-company.png");

            string logo = logoObj.ToString().Trim();
            if (string.IsNullOrEmpty(logo))
                return ResolveUrl("~/CompanyUploads/default-company.png");

            if (logo.StartsWith("http://", StringComparison.OrdinalIgnoreCase) || logo.StartsWith("https://", StringComparison.OrdinalIgnoreCase))
                return logo;

            if (logo.StartsWith("~"))
                return ResolveUrl(logo);

            if (logo.StartsWith("/"))
                return ResolveUrl("~" + logo);

            if (System.IO.File.Exists(Server.MapPath("~/company_images/" + logo)))
                return ResolveUrl("~/company_images/" + logo);
            if (System.IO.File.Exists(Server.MapPath("~/compnay_images/" + logo)))
                return ResolveUrl("~/compnay_images/" + logo);
            return ResolveUrl("~/CompanyUploads/" + logo);
        }
    }
}

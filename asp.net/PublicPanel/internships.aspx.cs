using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class internships : System.Web.UI.Page
    {
        publicpanel pub = new publicpanel();

        protected void Page_Load(object sender, EventArgs e)
        {
            startcon();
            if (!IsPostBack)
            {
                ViewState["page"] = 0;
                fillgrid();
            }
        }

        void startcon()
        {
            pub = new publicpanel();
            pub.getcon();
        }

        void fillgrid()
        {
            pub = new publicpanel();
            DataTable dt = pub.select_internship().Tables[0];

            lblTotalInternships.Text = "Total Internships: " + dt.Rows.Count;

            int page = Convert.ToInt32(ViewState["page"]);

            int totalPages = (int)Math.Ceiling(dt.Rows.Count / 12.0);

            if (totalPages > 0 && page >= totalPages)
            {
                page = totalPages - 1;
                ViewState["page"] = page;
            }

            DataListPublicInternships.DataSource = pub.Internship_pagination(dt, page);
            DataListPublicInternships.DataBind();

            lblPages.Text = "Page " + (page + 1) + " of " + totalPages;

            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = page < totalPages - 1;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;
            lblTotalInternships.Text = "Total Internships: " + (dt != null ? dt.Rows.Count : 0);
            DataListPublicInternships.DataSource = pub.Internship_pagination(dt, 0);
            DataListPublicInternships.DataBind();
            int totalPages = dt != null ? (int)Math.Ceiling(dt.Rows.Count / 12.0) : 0;
            lblPages.Text = "Page 1 of " + (totalPages > 0 ? totalPages : 1);
            btnPrevious.Enabled = false;
            btnNext.Enabled = totalPages > 1;
        }

        // Search Button Click
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            pub = new publicpanel();
            //DataListPublicInternships.DataSource = pub.search_internship(searchInput.Text);
            //DataListPublicInternships.DataBind();

            filtergrid(pub.search_internship(searchInput.Text).Tables[0]);
        }

        // Category / Domain DropDownList SelectedIndexChanged
        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            pub = new publicpanel();
            //DataListPublicInternships.DataSource = pub.select_internship_by_category(ddlCategory.SelectedValue);
            //DataListPublicInternships.DataBind

            filtergrid(pub.select_internship_by_category(ddlCategory.SelectedValue).Tables[0]);
        }

        // Location / City DropDownList SelectedIndexChanged
        protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            pub = new publicpanel();
            //DataListPublicInternships.DataSource = pub.select_internship_by_city(ddlLocation.SelectedValue);
            //DataListPublicInternships.DataBind();

            filtergrid(pub.select_internship_by_city(ddlLocation.SelectedValue).Tables[0]);
        }

        // Duration DropDownList SelectedIndexChanged
        protected void ddlDuration_SelectedIndexChanged(object sender, EventArgs e)
        {
            pub = new publicpanel();
            //DataListPublicInternships.DataSource = pub.select_internship_by_duration(ddlDuration.SelectedValue);
            //DataListPublicInternships.DataBind();

            filtergrid(pub.select_internship_by_duration(ddlDuration.SelectedValue).Tables[0]);
        }

        // Sort By DropDownList SelectedIndexChanged
        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            pub = new publicpanel();
            //DataListPublicInternships.DataSource = pub.sort_internship(ddlSortBy.SelectedValue);
            //DataListPublicInternships.DataBind();

            filtergrid(pub.sort_internship(ddlSortBy.SelectedValue).Tables[0]);
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
    }
}

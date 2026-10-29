using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class companies : System.Web.UI.Page
    {
        publicpanel pub = new publicpanel();

        private const int PageSize = 4;

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
            DataTable dt = pub.select().Tables[0];

            int page = Convert.ToInt32(ViewState["page"]);
            int totalPages = (int)Math.Ceiling(dt.Rows.Count / (double)PageSize);

            lblTotalCompanies.Text = "Total Companies : " + dt.Rows.Count;

            DataListPublicCompanies.DataSource = pub.pagination(dt, page);
            DataListPublicCompanies.DataBind();

            lblPages.Text = "Page " + (page + 1) + " of " + totalPages;

            btnPrevious.Enabled = page > 0;
            btnNext.Enabled = page < totalPages - 1;
        }

        void filtergrid(DataTable dt)
        {
            ViewState["page"] = 0;

            int totalPages = (int)Math.Ceiling(dt.Rows.Count / (double)PageSize);

            lblTotalCompanies.Text = "Total Companies : " + dt.Rows.Count;

            DataListPublicCompanies.DataSource = pub.pagination(dt, 0);
            DataListPublicCompanies.DataBind();

            lblPages.Text = "Page 1 of " + totalPages;

            btnPrevious.Enabled = false;
            btnNext.Enabled = totalPages > 1;
        }

        // Search Button Click
        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            pub = new publicpanel();
            filtergrid(pub.search(searchInput.Text).Tables[0]);
        }

        // Industry DropDownList SelectedIndexChanged
        protected void ddlIndustry_SelectedIndexChanged(object sender, EventArgs e)
        {
            pub = new publicpanel();
            filtergrid(pub.selectbyindustry(ddlIndustry.SelectedValue).Tables[0]);
        }

        // Location / City DropDownList SelectedIndexChanged
        protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
        {
            pub = new publicpanel();
            filtergrid(pub.selectbycity(ddlLocation.SelectedValue).Tables[0]);
        }

        // Size DropDownList SelectedIndexChanged
        protected void ddlSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            pub = new publicpanel();
            filtergrid(pub.selectbysize(ddlSize.SelectedValue).Tables[0]);
        }

        // Sort By DropDownList SelectedIndexChanged
        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            pub = new publicpanel();
            filtergrid(pub.sortby(ddlSortBy.SelectedValue).Tables[0]);
        }

        // Reset Button Click
        protected void btnReset_Click(object sender, ImageClickEventArgs e)
        {
            searchInput.Text = "";
            ddlIndustry.SelectedIndex = 0;
            ddlLocation.SelectedIndex = 0;
            ddlSize.SelectedIndex = 0;
            ddlSortBy.SelectedIndex = 0;

            ViewState["page"] = 0;
            fillgrid();
        }

        protected void btnPrevious_Click(object sender, ImageClickEventArgs e)
        {
            if (Convert.ToInt32(ViewState["page"]) > 0)
            {
                ViewState["page"] = Convert.ToInt32(ViewState["page"]) - 1;
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

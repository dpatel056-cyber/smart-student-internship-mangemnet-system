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
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                showInternships();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);

                con.Open();

        }

        void showInternships()
        {
            try
            {
                getcon();
                string query = "select i.*, c.c_company, c.c_logo from internship i left join c_registration c on i.CompanyId = c.CompanyId order by i.Id desc";
                if (Request.QueryString["companyId"] != null && !string.IsNullOrEmpty(Request.QueryString["companyId"]))
                {
                    string cid = Request.QueryString["companyId"].Trim();
                    query = "select i.*, c.c_company, c.c_logo from internship i left join c_registration c on i.CompanyId = c.CompanyId where i.CompanyId='" + cid + "' order by i.Id desc";
                }
                da = new SqlDataAdapter(query, con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataListPublicInternships.DataSource = ds;
                    DataListPublicInternships.DataBind();
                    DataListPublicInternships.Visible = true;
                    if (pnlNoInternships != null) pnlNoInternships.Visible = false;
                }
                else
                {
                    DataListPublicInternships.Visible = false;
                    if (pnlNoInternships != null) pnlNoInternships.Visible = true;
                }

                con.Close();
            }
            catch (Exception ex)
            {
                // Graceful fallback
            }
        }

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

        public string GetCompanyName(object nameObj, object companyNameObj = null)
        {
            if (nameObj != null && nameObj != DBNull.Value && !string.IsNullOrEmpty(nameObj.ToString()))
            {
                return nameObj.ToString();
            }
            if (companyNameObj != null && companyNameObj != DBNull.Value && !string.IsNullOrEmpty(companyNameObj.ToString()))
            {
                return companyNameObj.ToString();
            }
            return "Company";
        }

        public string GetPaymentStatusText(object status1, object status2 = null)
        {
            if (status1 != null && status1 != DBNull.Value && !string.IsNullOrEmpty(status1.ToString()))
            {
                return status1.ToString();
            }
            if (status2 != null && status2 != DBNull.Value && !string.IsNullOrEmpty(status2.ToString()))
            {
                return status2.ToString();
            }
            return "Paid";
        }

        public string GetPaymentBadgeClass(object status1, object status2 = null)
        {
            string status = GetPaymentStatusText(status1, status2);
            if (status.ToLower() == "paid")
            {
                return "badge-paid";
            }
            return "badge-unpaid";
        }

        public string GetStipendText(object status1, object amountObj)
        {
            return GetStipendText(status1, null, amountObj);
        }

        public string GetStipendText(object status1, object status2, object amountObj)
        {
            string status = GetPaymentStatusText(status1, status2);
            if (status.Equals("Unpaid", StringComparison.OrdinalIgnoreCase))
            {
                return "";
            }
            string amount = amountObj != null && amountObj != DBNull.Value ? amountObj.ToString().Trim() : "";
            if (string.IsNullOrEmpty(amount) || amount == "0")
            {
                return "";
            }
            return "&#8377; " + amount + " / month";
        }

        public string FormatPostedDate(object date1, object date2 = null)
        {
            object dateObj = (date1 != null && date1 != DBNull.Value) ? date1 : date2;
            if (dateObj != null && dateObj != DBNull.Value)
            {
                DateTime dt;
                if (DateTime.TryParse(dateObj.ToString(), out dt))
                {
                    TimeSpan ts = DateTime.Now - dt;
                    if (ts.TotalDays < 1) return "today";
                    if (ts.TotalDays < 2) return "1 day ago";
                    if (ts.TotalDays < 30) return (int)ts.TotalDays + " days ago";
                    return dt.ToString("dd MMM yyyy");
                }
            }
            return "recently";
        }
    }
}

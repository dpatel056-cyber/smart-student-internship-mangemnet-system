using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class internship_details : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadInternshipDetails();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);

                con.Open();

        }

        string getInternshipId()
        {
            if (Request.QueryString["id"] != null && !string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                return Request.QueryString["id"].Trim();
            }
            if (Request.QueryString["InternshipId"] != null && !string.IsNullOrEmpty(Request.QueryString["InternshipId"]))
            {
                return Request.QueryString["InternshipId"].Trim();
            }
            return "";
        }

        void loadInternshipDetails()
        {
            string id = getInternshipId();
            if (string.IsNullOrEmpty(id))
            {
                DataListInternshipDetail.Visible = false;
                pnlNotFound.Visible = true;
                return;
            }

            try
            {
                getcon();
                string query = "select i.*, c.c_company, c.c_logo, c.c_industry, c.c_location, c.c_city, c.c_state, c.c_about, c.c_email, c.c_contact, c.c_hr_name from internship i left join c_registration c on i.CompanyId = c.CompanyId where i.Id='" + id + "'";

                da = new SqlDataAdapter(query, con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataListInternshipDetail.DataSource = ds;
                    DataListInternshipDetail.DataBind();
                    DataListInternshipDetail.Visible = true;
                    pnlNotFound.Visible = false;
                }
                else
                {
                    DataListInternshipDetail.Visible = false;
                    pnlNotFound.Visible = true;
                }

                con.Close();
            }
            catch (Exception ex)
            {
                DataListInternshipDetail.Visible = false;
                pnlNotFound.Visible = true;
            }
        }

        public string GetCompanyLogo(object logoObj)
        {
            if (logoObj != null && logoObj != DBNull.Value && !string.IsNullOrEmpty(logoObj.ToString()))
            {
                string logo = logoObj.ToString();
                if (logo.StartsWith("~") || logo.StartsWith("/"))
                {
                    return ResolveUrl(logo);
                }
                return ResolveUrl("~/CompanyUploads/" + logo);
            }
            return ResolveUrl("~/assets/default-company.png");
        }

        public string GetCompanyName(object nameObj)
        {
            if (nameObj != null && nameObj != DBNull.Value && !string.IsNullOrEmpty(nameObj.ToString()))
            {
                return nameObj.ToString();
            }
            return "Company";
        }

        public string GetCompanyLocation(object locObj, object cityObj = null, object stateObj = null)
        {
            if (locObj != null && locObj != DBNull.Value && !string.IsNullOrEmpty(locObj.ToString()))
            {
                return locObj.ToString();
            }
            string city = cityObj != null && cityObj != DBNull.Value ? cityObj.ToString().Trim() : "";
            string state = stateObj != null && stateObj != DBNull.Value ? stateObj.ToString().Trim() : "";
            if (!string.IsNullOrEmpty(city) && !string.IsNullOrEmpty(state))
            {
                return city + ", " + state;
            }
            if (!string.IsNullOrEmpty(city)) return city;
            if (!string.IsNullOrEmpty(state)) return state;
            return "India";
        }

        public string GetStipend(object statusObj, object amountObj)
        {
            string status = statusObj != null && statusObj != DBNull.Value ? statusObj.ToString() : "";
            string amount = amountObj != null && amountObj != DBNull.Value ? amountObj.ToString() : "";

            if (status.Equals("Unpaid", StringComparison.OrdinalIgnoreCase))
            {
                return "Unpaid";
            }
            if (!string.IsNullOrEmpty(amount))
            {
                if (amount.Contains("₹") || amount.Contains("Rs") || amount.Contains("/month"))
                {
                    return amount;
                }
                return "₹" + amount + "/month";
            }
            return "Negotiable";
        }

        public string GetValueOrFallback(object valObj, string fallback)
        {
            if (valObj != null && valObj != DBNull.Value && !string.IsNullOrEmpty(valObj.ToString().Trim()))
            {
                return valObj.ToString().Trim();
            }
            return fallback;
        }

        public string GetFormattedText(object textObj)
        {
            if (textObj != null && textObj != DBNull.Value && !string.IsNullOrEmpty(textObj.ToString()))
            {
                return textObj.ToString().Replace("\n", "<br/>");
            }
            return "Details for this internship will be provided during interview rounds.";
        }

        public string GetBulletList(object textObj)
        {
            if (textObj != null && textObj != DBNull.Value && !string.IsNullOrEmpty(textObj.ToString().Trim()))
            {
                string text = textObj.ToString();
                string[] lines = text.Split(new char[] { '\n', '\r', ',' }, StringSplitOptions.RemoveEmptyEntries);
                StringBuilder sb = new StringBuilder();
                sb.Append("<ul style='padding-left:20px; line-height:1.8; color:#334155;'>");
                foreach (string line in lines)
                {
                    string clean = line.Trim().TrimStart(new char[] { '-', '*', '•' }).Trim();
                    if (!string.IsNullOrEmpty(clean))
                    {
                        sb.Append("<li>").Append(clean).Append("</li>");
                    }
                }
                sb.Append("</ul>");
                return sb.ToString();
            }
            return "<p style='color:#64748b;'>Specific details will be communicated during candidate evaluation.</p>";
        }

        public string GetSkillBadges(object skillsObj)
        {
            if (skillsObj != null && skillsObj != DBNull.Value && !string.IsNullOrEmpty(skillsObj.ToString().Trim()))
            {
                string[] skills = skillsObj.ToString().Split(new char[] { ',', ';', '\n' }, StringSplitOptions.RemoveEmptyEntries);
                StringBuilder sb = new StringBuilder();
                foreach (string skill in skills)
                {
                    string clean = skill.Trim();
                    if (!string.IsNullOrEmpty(clean))
                    {
                        sb.Append("<span class='imd-skill-badge'>").Append(clean).Append("</span>");
                    }
                }
                return sb.ToString();
            }
            return "<span class='imd-skill-badge'>Problem Solving</span><span class='imd-skill-badge'>Communication</span>";
        }

        public string GetBenefitBadges(object benefitsObj, object otherObj = null)
        {
            StringBuilder sb = new StringBuilder();
            if (benefitsObj != null && benefitsObj != DBNull.Value && !string.IsNullOrEmpty(benefitsObj.ToString().Trim()))
            {
                string[] benefits = benefitsObj.ToString().Split(new char[] { ',', ';' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string b in benefits)
                {
                    string clean = b.Trim();
                    if (!string.IsNullOrEmpty(clean))
                    {
                        sb.Append("<span class='imd-skill-badge' style='background:#f1f5f9; color:#0f172a; border:1px solid #cbd5e1;'><i class='fa-solid fa-circle-check' style='color:#16a34a; margin-right:4px;'></i> ").Append(clean).Append("</span>");
                    }
                }
            }
            if (otherObj != null && otherObj != DBNull.Value && !string.IsNullOrEmpty(otherObj.ToString().Trim()))
            {
                sb.Append("<span class='imd-skill-badge' style='background:#f1f5f9; color:#0f172a; border:1px solid #cbd5e1;'><i class='fa-solid fa-circle-check' style='color:#16a34a; margin-right:4px;'></i> ").Append(otherObj.ToString().Trim()).Append("</span>");
            }
            if (sb.Length == 0)
            {
                return "<span class='imd-skill-badge' style='background:#f1f5f9; color:#0f172a; border:1px solid #cbd5e1;'><i class='fa-solid fa-certificate' style='color:#2563eb; margin-right:4px;'></i> Internship Certificate</span>";
            }
            return sb.ToString();
        }

        public string GetApplyUrl(object idObj)
        {
            string intId = idObj != null ? idObj.ToString() : "";
            if (Session["student"] != null)
            {
                return ResolveUrl("~/StudentPanel/my-applications.aspx?applyId=" + intId);
            }
            return ResolveUrl("~/login.aspx?returnUrl=" + Server.UrlEncode("~/internship-details.aspx?id=" + intId));
        }
    }
}

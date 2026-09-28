using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace asp.net
{
    public partial class company_details : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                loadCompanyDetails();
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);

                con.Open();

        }

        string getCompanyId()
        {
            if (Request.QueryString["CompanyId"] != null && !string.IsNullOrEmpty(Request.QueryString["CompanyId"]))
            {
                return Request.QueryString["CompanyId"].Trim();
            }
            if (Request.QueryString["id"] != null && !string.IsNullOrEmpty(Request.QueryString["id"]))
            {
                return Request.QueryString["id"].Trim();
            }
            return "";
        }

        void loadCompanyDetails()
        {
            string cid = getCompanyId();
            if (string.IsNullOrEmpty(cid))
            {
                pnlDetails.Visible = false;
                pnlNotFound.Visible = true;
                return;
            }

            try
            {
                getcon();

                // Fetch Company Info
                string query = "select * from c_registration where CompanyId='" + cid + "'";
                da = new SqlDataAdapter(query, con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    pnlDetails.Visible = true;
                    pnlNotFound.Visible = false;

                    DataRow row = ds.Tables[0].Rows[0];

                    string compName = row["c_company"] != DBNull.Value ? row["c_company"].ToString() : "";
                    lblCompanyName.Text = compName;
                    lblFieldCompanyName.Text = compName;

                    if (!string.IsNullOrEmpty(compName))
                    {
                        lblCompanyInitials.Text = compName.Substring(0, 1).ToUpper();
                    }

                    // Logo
                    string logo = row["c_logo"] != DBNull.Value ? row["c_logo"].ToString() : "";
                    if (!string.IsNullOrEmpty(logo))
                    {
                        if (!logo.StartsWith("~") && !logo.StartsWith("/"))
                        {
                            logo = "~/CompanyUploads/" + logo;
                        }
                        imgCompanyLogo.ImageUrl = ResolveUrl(logo);
                        imgCompanyLogo.Visible = true;
                        pnlLogoInitials.Visible = false;
                    }
                    else
                    {
                        imgCompanyLogo.Visible = false;
                        pnlLogoInitials.Visible = true;
                    }

                    // Basic Meta
                    string industry = row["c_industry"] != DBNull.Value ? row["c_industry"].ToString() : "";
                    lblIndustry.Text = string.IsNullOrEmpty(industry) ? "Not Specified" : industry;
                    lblFieldIndustry.Text = lblIndustry.Text;

                    string city = row["c_city"] != DBNull.Value ? row["c_city"].ToString() : "";
                    string state = row["c_state"] != DBNull.Value ? row["c_state"].ToString() : "";
                    lblLocation.Text = (!string.IsNullOrEmpty(city) ? city : "") + (!string.IsNullOrEmpty(state) ? ", " + state : "");
                    if (string.IsNullOrEmpty(lblLocation.Text.Trim(new char[] { ',', ' ' })))
                    {
                        lblLocation.Text = "Not Specified";
                    }

                    string website = row["c_website"] != DBNull.Value ? row["c_website"].ToString() : "";
                    if (!string.IsNullOrEmpty(website))
                    {
                        hlWebsite.Text = website;
                        string webUrl = website.StartsWith("http") ? website : "http://" + website;
                        hlWebsite.NavigateUrl = webUrl;
                        hlWebsiteSocial.NavigateUrl = webUrl;
                    }

                    string email = row["c_email"] != DBNull.Value ? row["c_email"].ToString() : "";
                    lblHeroEmail.Text = string.IsNullOrEmpty(email) ? "Not Specified" : email;
                    lblEmail.Text = lblHeroEmail.Text;
                    if (!string.IsNullOrEmpty(email)) hlEmailSocial.NavigateUrl = "mailto:" + email;

                    string phone = row["c_contact"] != DBNull.Value ? row["c_contact"].ToString() : "";
                    lblHeroPhone.Text = string.IsNullOrEmpty(phone) ? "Not Specified" : phone;
                    lblPhone.Text = lblHeroPhone.Text;
                    if (!string.IsNullOrEmpty(phone)) hlCallSocial.NavigateUrl = "tel:" + phone;

                    string hrName = row["c_hr_name"] != DBNull.Value ? row["c_hr_name"].ToString() : "";
                    lblHeroContactPerson.Text = string.IsNullOrEmpty(hrName) ? "Not Specified" : hrName;
                    lblContactPerson.Text = lblHeroContactPerson.Text;

                    // Overview
                    lblCompanyType.Text = row["c_type"] != DBNull.Value && !string.IsNullOrEmpty(row["c_type"].ToString()) ? row["c_type"].ToString() : "Private";
                    string size = row["c_size"] != DBNull.Value && !string.IsNullOrEmpty(row["c_size"].ToString()) ? row["c_size"].ToString() : "10-50 Employees";
                    lblCompanySize.Text = size;
                    lblCompanySizeStat.Text = size;

                    string founded = row["c_founded_year"] != DBNull.Value && !string.IsNullOrEmpty(row["c_founded_year"].ToString()) ? row["c_founded_year"].ToString() : "N/A";
                    lblFoundedYear.Text = founded;
                    lblFoundedYearStat.Text = founded;

                    lblHeadquarters.Text = row["c_headquarters"] != DBNull.Value && !string.IsNullOrEmpty(row["c_headquarters"].ToString()) ? row["c_headquarters"].ToString() : lblLocation.Text;
                    lblDescription.Text = row["c_about"] != DBNull.Value && !string.IsNullOrEmpty(row["c_about"].ToString()) ? row["c_about"].ToString() : "No detailed description available for this company.";

                    // Specialization
                    lblBusinessDomain.Text = row["c_business_domain"] != DBNull.Value && !string.IsNullOrEmpty(row["c_business_domain"].ToString()) ? row["c_business_domain"].ToString() : "Software & Technology";
                    lblProductsServices.Text = row["c_products"] != DBNull.Value && !string.IsNullOrEmpty(row["c_products"].ToString()) ? row["c_products"].ToString() : "IT Services & Solutions";
                    lblMission.Text = row["c_mission"] != DBNull.Value && !string.IsNullOrEmpty(row["c_mission"].ToString()) ? row["c_mission"].ToString() : "To deliver innovative solutions and build a thriving workplace for upcoming talent.";
                    lblVision.Text = row["c_vision"] != DBNull.Value && !string.IsNullOrEmpty(row["c_vision"].ToString()) ? row["c_vision"].ToString() : "To be a leading technology organization empowering future professionals.";

                    // HR Details
                    lblHRDesignation.Text = row["c_hr_designation"] != DBNull.Value && !string.IsNullOrEmpty(row["c_hr_designation"].ToString()) ? row["c_hr_designation"].ToString() : "HR Manager";
                    lblAddress.Text = row["c_address"] != DBNull.Value && !string.IsNullOrEmpty(row["c_address"].ToString()) ? row["c_address"].ToString() : "Not Specified";
                    lblCity.Text = string.IsNullOrEmpty(city) ? "Not Specified" : city;
                    lblState.Text = string.IsNullOrEmpty(state) ? "Not Specified" : state;
                    lblPincode.Text = row["c_pincode"] != DBNull.Value && !string.IsNullOrEmpty(row["c_pincode"].ToString()) ? row["c_pincode"].ToString() : "N/A";

                    string linkedin = row["c_linkedin"] != DBNull.Value ? row["c_linkedin"].ToString() : "";
                    if (!string.IsNullOrEmpty(linkedin))
                    {
                        hlLinkedIn.Text = linkedin;
                        hlLinkedIn.NavigateUrl = linkedin.StartsWith("http") ? linkedin : "https://" + linkedin;
                    }
                    else
                    {
                        hlLinkedIn.Text = "Not Specified";
                        hlLinkedIn.NavigateUrl = "#";
                    }

                    //// Fetch Company Internships
                    //string intQuery = "select * from internship where CompanyId='" + cid + "' order by Id desc";
                    //SqlDataAdapter daInt = new SqlDataAdapter(intQuery, con);
                    //DataSet dsInt = new DataSet();
                    //daInt.Fill(dsInt);

                    //int totalInts = dsInt.Tables[0].Rows.Count;
                    //lblTotalInternships.Text = totalInts.ToString();
                    //lblActiveInternships.Text = totalInts.ToString();

                    //if (totalInts > 0)
                    //{
                    //    DataListCompanyInternships.DataSource = dsInt;
                    //    DataListCompanyInternships.DataBind();
                    //    DataListCompanyInternships.Visible = true;
                    //    pnlNoInternships.Visible = false;
                    //}
                    //else
                    //{
                    //    DataListCompanyInternships.Visible = false;
                    //    pnlNoInternships.Visible = true;
                    //}
                }
                else
                {
                    pnlDetails.Visible = false;
                    pnlNotFound.Visible = true;
                }

                con.Close();
            }
            catch (Exception ex)
            {
                pnlDetails.Visible = false;
                pnlNotFound.Visible = true;
            }
        }
    }
}

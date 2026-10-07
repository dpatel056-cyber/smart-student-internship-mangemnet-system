using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_offer_letters : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
          
            if (Session["student"] != null)
            {
                getcon();
                da = new SqlDataAdapter("select * from Students where Email='" + Session["student"] + "' or EnrollmentNo='" + Session["student"] + "'", con);
                ds = new DataSet();
                da.Fill(ds);

                if (!IsPostBack)
                {
                    LoadOffers();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void LoadOffers()
        {
            getcon();

            da = new SqlDataAdapter("select col.*, ISNULL(NULLIF(col.OfferTitle,''),ISNULL(i.InternshipTitle,'Internship Offer')) as OfferTitle, ISNULL(a.FullName,s.FullName) as FullName, ISNULL(a.StudentEmail,s.Email) as StudentEmail, ISNULL(a.College,s.College) as College, ISNULL(a.ContactNo,s.ContactNo) as ContactNo, ISNULL(NULLIF(col.Duration,''),ISNULL(i.Duration,'3 Months')) as Duration, ISNULL(NULLIF(col.WorkLocation,''),ISNULL(i.Location,ISNULL(c.c_location,'Ahmedabad'))) as JobLocation, ISNULL(c.c_company,'Partner Company') as c_company, c.c_logo, ISNULL(c.c_location,'Headquarters') as c_location, c.c_email as CompEmail, c.c_contact as CompContact, c.c_website, ISNULL(c.c_hr_name,'Talent Acquisition Team') as c_hr_name, col.IssuedDate as IssuedDateDisplay from CompanyOfferLetters col left join StudentApplications a on col.ApplicationId=a.ApplicationId left join Students s on (col.StudentId=s.StudentId or a.StudentId=s.StudentId) left join internship i on col.InternshipId=i.Id left join c_registration c on col.CompanyId=c.CompanyId where a.StudentEmail='" + Session["student"] + "' or s.Email='" + Session["student"] + "' or s.EnrollmentNo='" + Session["student"] + "' order by col.OfferId desc", con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                dlOffers.DataSource = ds;
                dlOffers.DataBind();

                dlOffers.Visible = true;
                pnlNoOffers.Visible = false;

                LoadStats();
            }
            else
            {
                dlOffers.Visible = false;
                pnlNoOffers.Visible = true;

                lblTotalOffers.Text = "0";
                lblPendingOffers.Text = "0";
                lblAcceptedOffers.Text = "0";
                lblCompaniesCount.Text = "0";
            }
        }

        void LoadStats()
        {
            int total = ds.Tables[0].Rows.Count;
            int pending = 0;
            int accepted = 0;
            int companies = 0;

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string status = ds.Tables[0].Rows[i]["Status"].ToString();

                if (status == "Accepted")
                {
                    accepted++;
                }

                if (status == "Sent" || status == "Pending" || status == "")
                {
                    pending++;
                }
            }

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                string company = ds.Tables[0].Rows[i]["c_company"].ToString();

                bool found = false;

                for (int j = 0; j < i; j++)
                {
                    if (company == ds.Tables[0].Rows[j]["c_company"].ToString())
                    {
                        found = true;
                        break;
                    }
                }

                if (company != "" && !found)
                {
                    companies++;
                }
            }

            lblTotalOffers.Text = total.ToString();
            lblPendingOffers.Text = pending.ToString();
            lblAcceptedOffers.Text = accepted.ToString();
            lblCompaniesCount.Text = companies.ToString();
        }

        protected void dlOffers_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "AcceptOffer")
            {
                getcon();

                cmd = new SqlCommand("update CompanyOfferLetters set Status='Accepted' where OfferId=" +  e.CommandArgument, con);

                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("update StudentApplications set Status='Offer Accepted' " + "where ApplicationId=(select ApplicationId from CompanyOfferLetters " +"where OfferId=" + e.CommandArgument + ")", con);

                cmd.ExecuteNonQuery();

                lblMsg.Text = "Congratulations! You have successfully accepted the internship offer.";
                lblMsg.Visible = true;
            }

            if (e.CommandName == "DeclineOffer")
            {
                getcon();

                cmd = new SqlCommand(
                    "update CompanyOfferLetters set Status='Declined' where OfferId=" +
                    e.CommandArgument, con);

                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("update StudentApplications set Status='Offer Declined' " + "where ApplicationId=(select ApplicationId from CompanyOfferLetters " + "where OfferId=" + e.CommandArgument + ")", con);

                cmd.ExecuteNonQuery();

                lblMsg.Text = "You have declined this internship offer.";
                lblMsg.Visible = true;
            }

            LoadOffers();
        }

        public string FormatDay(object dateObj)
        {
            if (dateObj != null && dateObj != DBNull.Value)
            {
                DateTime dt;

                if (DateTime.TryParse(dateObj.ToString(), out dt))
                    return dt.ToString("dd");
            }

            return DateTime.Now.ToString("dd");
        }

        public string FormatMonth(object dateObj)
        {
            if (dateObj != null && dateObj != DBNull.Value)
            {
                DateTime dt;

                if (DateTime.TryParse(dateObj.ToString(), out dt))
                    return dt.ToString("MMM").ToUpper();
            }

            return DateTime.Now.ToString("MMM").ToUpper();
        }

        public string GetResolvedLogoUrl(object logoObj)
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

            return ResolveUrl("~/CompanyUploads/" + logo);
        }

        public string FormatCompanyLogo(object logoObj, object nameObj)
        {
            string name = "Company";

            if (nameObj != null && !string.IsNullOrEmpty(nameObj.ToString()))
                name = nameObj.ToString();

            string resolvedUrl = GetResolvedLogoUrl(logoObj);
            if (!string.IsNullOrEmpty(resolvedUrl))
            {
                return "<img src='" + resolvedUrl + "' alt='" + Server.HtmlEncode(name) + "' onerror=\"this.style.display='none'; this.parentElement.innerHTML='<i class=\\\'fa-solid fa-building\\\'></i>';\" />";
            }

            return "<i class='fa-solid fa-building'></i>";
        }

        public bool IsPending(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value)
                return true;

            string status = statusObj.ToString();

            if (status == "Sent" || status == "Pending" || status == "")
                return true;

            return false;
        }

        public bool IsAccepted(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value)
                return false;

            return statusObj.ToString() == "Accepted";
        }

        public bool IsDeclined(object statusObj)
        {
            if (statusObj == null || statusObj == DBNull.Value)
                return false;

            return statusObj.ToString() == "Declined";
        }

        public string FormatDate(object dateObj)
        {
            if (dateObj == null || dateObj == DBNull.Value)
                return "N/A";

            DateTime dt;

            if (DateTime.TryParse(dateObj.ToString(), out dt))
                return dt.ToString("dd MMM yyyy");

            return dateObj.ToString();
        }

        public string FormatJoining(object joiningObj)
        {
            if (joiningObj == null || joiningObj == DBNull.Value)
                return "Immediate";

            DateTime dt;

            if (DateTime.TryParse(joiningObj.ToString(), out dt))
                return dt.ToString("dd MMM yyyy");

            return joiningObj.ToString();
        }

        public string FormatStipend(object stipendObj)
        {
            if (stipendObj == null || stipendObj == DBNull.Value)
                return "Unpaid";

            string stipend = stipendObj.ToString();

            if (stipend == "")
                return "Unpaid";

            if (!stipend.ToLower().Contains("month") &&
                !stipend.ToLower().Contains("unpaid") &&
                !stipend.ToLower().Contains("fixed"))
            {
                stipend = stipend + " / month";
            }

            return "<i class='fa-solid fa-indian-rupee-sign'></i> " + stipend;
        }

        public string GetOfferStatusBadge(object statusObj)
        {
            string status = "Sent";

            if (statusObj != null && statusObj != DBNull.Value)
                status = statusObj.ToString();

            if (status == "Accepted")
                return "<span class='offer-accepted'>Offer Accepted</span>";

            if (status == "Declined")
                return "<span class='offer-declined'>Offer Declined</span>";

            return "<span class='offer-pending'>Action Pending</span>";
        }
    }
}
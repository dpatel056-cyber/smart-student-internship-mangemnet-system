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
                    TotalOfferLetters();
                    ActionPending();
                    OffersAccepted();
                    PartnerCompanies();
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
            }
            else
            {
                dlOffers.Visible = false;
                pnlNoOffers.Visible = true;
            }
        }

        void TotalOfferLetters()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyOfferLetters WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"] + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "')) OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "')", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblTotalOffers.Text = i.ToString();
        }

        void ActionPending()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyOfferLetters WHERE (Status IS NULL OR Status='' OR Status='Pending' OR Status='Sent' OR Status='Offered') AND (ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"] + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "')) OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "'))", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblPendingOffers.Text = i.ToString();
        }

        void OffersAccepted()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(*) FROM CompanyOfferLetters WHERE Status='Accepted' AND (ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"] + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "')) OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "'))", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblAcceptedOffers.Text = i.ToString();
        }

        void PartnerCompanies()
        {
            getcon();
            cmd = new SqlCommand("SELECT COUNT(DISTINCT CompanyId) FROM CompanyOfferLetters WHERE ApplicationId IN (SELECT ApplicationId FROM StudentApplications WHERE StudentEmail='" + Session["student"] + "' OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "')) OR StudentId IN (SELECT StudentId FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "')", con);
            int i = Convert.ToInt32(cmd.ExecuteScalar());
            lblCompaniesCount.Text = i.ToString();
        }

        protected void dlOffers_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "AcceptOffer")
            {
                getcon();

                cmd = new SqlCommand("update CompanyOfferLetters set Status='Accepted' where OfferId=" + e.CommandArgument, con);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("update StudentApplications set Status='Offer Accepted' where ApplicationId=(select ApplicationId from CompanyOfferLetters where OfferId=" + e.CommandArgument + ")", con);
                cmd.ExecuteNonQuery();

                lblMsg.Text = "Congratulations! You have successfully accepted the internship offer.";
                lblMsg.Visible = true;
            }

            if (e.CommandName == "DeclineOffer")
            {
                getcon();

                cmd = new SqlCommand("update CompanyOfferLetters set Status='Declined' where OfferId=" + e.CommandArgument, con);
                cmd.ExecuteNonQuery();

                cmd = new SqlCommand("update StudentApplications set Status='Offer Declined' where ApplicationId=(select ApplicationId from CompanyOfferLetters where OfferId=" + e.CommandArgument + ")", con);
                cmd.ExecuteNonQuery();

                lblMsg.Text = "You have declined this internship offer.";
                lblMsg.Visible = true;
            }

            LoadOffers();
            TotalOfferLetters();
            ActionPending();
            OffersAccepted();
            PartnerCompanies();
        }

        public bool IsPending(object statusObj)
        {
            return statusObj == null || statusObj == DBNull.Value ||
                   statusObj.ToString() == "Sent" ||
                   statusObj.ToString() == "Pending" ||
                   statusObj.ToString() == "Offered" ||
                   statusObj.ToString() == "";
        }

        public bool IsAccepted(object statusObj)
        {
            return statusObj != null && statusObj.ToString() == "Accepted";
        }

        public bool IsDeclined(object statusObj)
        {
            return statusObj != null &&
                   (statusObj.ToString() == "Declined" || statusObj.ToString() == "Rejected");
        }

        public string GetOfferStatusBadge(object statusObj)
        {
            if (IsAccepted(statusObj))
                return "<span class='offer-accepted'>Offer Accepted</span>";

            if (IsDeclined(statusObj))
                return "<span class='offer-declined'>Offer Declined</span>";

            return "<span class='offer-pending'>Action Pending</span>";
        }

    }
}

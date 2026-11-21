
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace asp.net
{
    public partial class student_feedback : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["SimsConnectionString"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["student"] != null)
            {
                if (!IsPostBack)
                {
                    bindCompanyInternshipDropdown();
                    fillGrid();
                }
            }
            else
            {
                Response.Redirect("~/PublicPanel/login.aspx");
            }
        }

        void bindCompanyInternshipDropdown()
        {
            getcon();

            da = new SqlDataAdapter("SELECT i.Id, c.CompanyId, i.InternshipTitle, c.c_company FROM internship i INNER JOIN c_registration c ON i.CompanyId = c.CompanyId", con);

            ds = new DataSet();
            da.Fill(ds);

            ddlCompanyInternship.Items.Clear();
            ddlCompanyInternship.Items.Add("-- Select Company & Internship --");

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                ddlCompanyInternship.Items.Add(new ListItem(
                    ds.Tables[0].Rows[i]["c_company"].ToString() + " - " + ds.Tables[0].Rows[i]["InternshipTitle"].ToString(),
                    ds.Tables[0].Rows[i]["CompanyId"].ToString() + "|" + ds.Tables[0].Rows[i]["Id"].ToString()
                ));
            }
        }

        protected void ddlFeedbackType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFeedbackType.SelectedValue == "Company")
            {
                pnlCompanySelect.Visible = true;
            }
            else
            {
                pnlCompanySelect.Visible = false;
            }
        }

        void fillGrid()
        {
            getcon();

            da = new SqlDataAdapter("select pf.*, c.c_company, i.InternshipTitle from PlatformFeedback pf left join c_registration c on pf.CompanyId=c.CompanyId left join internship i on pf.InternshipId=i.Id where pf.SenderEmail='" + Session["student"] + "' order by pf.FeedbackId desc", con);

            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                gvFeedback.DataSource = ds;
                gvFeedback.DataBind();
                gvFeedback.Visible = true;
                pnlNoFeedback.Visible = false;
            }
            else
            {
                gvFeedback.Visible = false;
                pnlNoFeedback.Visible = true;
            }
        }

        void clearForm()
        {
            txtSubject.Text = "";
            txtComments.Text = "";
            ddlCategory.SelectedIndex = 0;
            ddlRating.SelectedValue = "5";
            ddlCompanyInternship.SelectedIndex = 0;
        }

        protected void btnSubmitFeedback_Click(object sender, ImageClickEventArgs e)
        {
            if (txtSubject.Text == "" || txtComments.Text == "")
            {
                lblMsg.Text = "Please enter subject and comments.";
                lblMsg.Visible = true;
            }
            else
            {
                string companyId = "NULL";
                string internshipId = "NULL";

                if (ddlFeedbackType.SelectedValue == "Company")
                {
                    if (ddlCompanyInternship.SelectedValue == "")
                    {
                        lblMsg.Text = "Please select company and internship.";
                        lblMsg.Visible = true;
                        return;
                    }

                    companyId = ddlCompanyInternship.SelectedValue.Split('|')[0];
                    internshipId = ddlCompanyInternship.SelectedValue.Split('|')[1];
                }

                getcon();

                da = new SqlDataAdapter("SELECT FullName FROM Students WHERE Email='" + Session["student"] + "' OR EnrollmentNo='" + Session["student"] + "'", con);

                ds = new DataSet();
                da.Fill(ds);

                string studentName = Session["student"].ToString();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    studentName = ds.Tables[0].Rows[0]["FullName"].ToString();
                }

                cmd = new SqlCommand("INSERT INTO PlatformFeedback VALUES('Student', '" + studentName + "', '" + Session["student"] + "', '" + ddlFeedbackType.SelectedValue + "', " + companyId + ", " + internshipId + ", '" + ddlCategory.SelectedValue + "', " + ddlRating.SelectedValue + ", '" + txtSubject.Text + "', '" + txtComments.Text + "', GETDATE())", con);

                cmd.ExecuteNonQuery();

                lblMsg.Text = "Thank you! Your feedback has been submitted successfully.";
                lblMsg.Visible = true;

                clearForm();
                fillGrid();
            }
        }

        protected void gvFeedback_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_dlt")
            {
                getcon();
                cmd = new SqlCommand("delete from PlatformFeedback where FeedbackId=" + e.CommandArgument + " and SenderEmail='" + Session["student"] + "'", con);
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Feedback deleted successfully.";
                fillGrid();
            }
        }
    }
}

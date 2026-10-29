using System;
using System.Web;
using System.Web.Routing;

namespace asp.net
{
    public class Global : HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);
        }

        protected void RegisterRoutes(RouteCollection routes)
        {
            // Public panel routes
            routes.MapPageRoute("CompanyDetailsRoot", "company-details.aspx", "~/PublicPanel/company-details.aspx");
            routes.MapPageRoute("InternshipDetailsRoot", "internship-details.aspx", "~/PublicPanel/internship-details.aspx");
            routes.MapPageRoute("CompaniesRoot", "companies.aspx", "~/PublicPanel/companies.aspx");
            routes.MapPageRoute("InternshipsRoot", "internships.aspx", "~/PublicPanel/internships.aspx");
            routes.MapPageRoute("LoginRoot", "login.aspx", "~/PublicPanel/login.aspx");
            routes.MapPageRoute("RegisterRoot", "register.aspx", "~/PublicPanel/register.aspx");
            routes.MapPageRoute("IndexRoot", "index.aspx", "~/PublicPanel/index.aspx");
            routes.MapPageRoute("AboutRoot", "about.aspx", "~/PublicPanel/about.aspx");
            routes.MapPageRoute("ContactRoot", "contact.aspx", "~/PublicPanel/contact.aspx");
            routes.MapPageRoute("FaqRoot", "faq.aspx", "~/PublicPanel/faq.aspx");
            routes.MapPageRoute("StoriesRoot", "stories.aspx", "~/PublicPanel/stories.aspx");
            routes.MapPageRoute("ForgotPasswordRoot", "forgot_password.aspx", "~/PublicPanel/forgot_password.aspx");
            routes.MapPageRoute("ResetPasswordRoot", "reset_password.aspx", "~/PublicPanel/reset_password.aspx");
            routes.MapPageRoute("VerifyOtpRoot", "verify_otp.aspx", "~/PublicPanel/verify_otp.aspx");

            // Direct & Fallback Panel routes
            routes.MapPageRoute("StudentDashboardRoot", "student-dashboard.aspx", "~/StudentPanel/student-dashboard.aspx");
            routes.MapPageRoute("CompanyDashboardRoot", "company-dashboard.aspx", "~/CompanyPanel/company-dashboard.aspx");
            routes.MapPageRoute("PublicStudentDashboardFix", "PublicPanel/StudentPanel/student-dashboard.aspx", "~/StudentPanel/student-dashboard.aspx");
            routes.MapPageRoute("PublicCompanyDashboardFix", "PublicPanel/CompanyPanel/company-dashboard.aspx", "~/CompanyPanel/company-dashboard.aspx");
            routes.MapPageRoute("PublicAdminDashboardFix", "PublicPanel/AdminPanel/admin-dashboard.aspx", "~/AdminPanel/admin-dashboard.aspx");
        }
    }
}

<%@ WebHandler Language="C#" Class="SendOTP" %>
using System;
using System.Web;
using System.Web.SessionState;
using System.Net;
using System.Net.Mail;
using System.Configuration;
public class SendOTP : IHttpHandler, IRequiresSessionState {
    public void ProcessRequest(HttpContext context) {
        context.Response.ContentType = "application/json";
        string email = context.Request.Form["email"];
        if (string.IsNullOrEmpty(email)) {
            context.Response.Write("{\"success\": false, \"message\": \"Email is required.\"}");
            return;
        }
        // Generate 6-digit OTP
        Random rnd = new Random();
        string otp = rnd.Next(100000, 999999).ToString();
        // Store OTP in session
        context.Session["OTP"] = otp;
        context.Session["OTP_Email"] = email;
        // Get SMTP settings from Web.config
        string smtpHost = ConfigurationManager.AppSettings["SmtpHost"];
        string smtpPortStr = ConfigurationManager.AppSettings["SmtpPort"];
        string smtpEmail = ConfigurationManager.AppSettings["SmtpEmail"];
        string smtpPassword = ConfigurationManager.AppSettings["SmtpPassword"];
        // If settings are not configured properly, just simulate it
        if (string.IsNullOrEmpty(smtpHost) || smtpHost == "smtp.yourprovider.com") {
            // Dummy mode: pretend it was sent successfully
            context.Response.Write("{\"success\": true, \"message\": \"(Dummy) OTP sent successfully.\", \"dummyOtp\": \"" + otp + "\"}");
            return;
        }
        int smtpPort = 587;
        int.TryParse(smtpPortStr, out smtpPort);
        // Send Email
        MailMessage mail = new MailMessage();
        mail.From = new MailAddress(smtpEmail, "SIMS Support");
        mail.To.Add(email);
        mail.Subject = "Your Password Reset OTP - SIMS";
        mail.Body = "Hello,\n\nYour One-Time Password (OTP) for password reset is: " + otp + "\n\nPlease do not share this with anyone.\n\nThanks,\nSIMS Team";
        SmtpClient smtp = new SmtpClient(smtpHost, smtpPort);
        smtp.Credentials = new NetworkCredential(smtpEmail, smtpPassword);
        smtp.EnableSsl = true;
        smtp.Send(mail);
        context.Response.Write("{\"success\": true, \"message\": \"OTP sent successfully.\"}");
    }
    public bool IsReusable {
        get { return false; }
    }
}

<%@ WebHandler Language="C#" Class="VerifyOTP" %>

using System;
using System.Web;
using System.Web.SessionState;

public class VerifyOTP : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest(HttpContext context) {
        context.Response.ContentType = "application/json";

        string otpEntered = context.Request.Form["otp"];
        if (string.IsNullOrEmpty(otpEntered)) {
            context.Response.Write("{\"success\": false, \"message\": \"OTP is required.\"}");
            return;
        }

        string sessionOtp = context.Session["OTP"] as string;

        if (string.IsNullOrEmpty(sessionOtp)) {
            context.Response.Write("{\"success\": false, \"message\": \"Session expired or OTP not generated.\"}");
            return;
        }

        if (otpEntered == sessionOtp) {
            // Clear OTP to prevent reuse
            context.Session.Remove("OTP");
            context.Response.Write("{\"success\": true, \"message\": \"OTP verified successfully.\"}");
        }
        else {
            context.Response.Write("{\"success\": false, \"message\": \"Invalid OTP.\"}");
        }
    }

    public bool IsReusable {
        get { return false; }
    }
}

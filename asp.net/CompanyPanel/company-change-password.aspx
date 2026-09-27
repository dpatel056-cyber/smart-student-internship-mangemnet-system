<%@ Page Title="Company Change Password" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-change-password.aspx.cs" Inherits="asp.net.company_change_password" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">

    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

    <style>

        .company-change-password-container {
            max-width: 650px;
            margin: 30px auto;
            padding: 0 15px;
        }

        .pwd-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 36px 32px;
            box-shadow: 0 4px 20px rgba(15, 23, 42, 0.06);
        }

        .pwd-header {
            text-align: center;
            margin-bottom: 28px;
        }

        .pwd-icon-wrap {
            width: 64px;
            height: 64px;
            background: #eff6ff;
            color: #2563eb;
            border-radius: 50%;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            margin-bottom: 14px;
        }

        .pwd-title {
            font-size: 22px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 6px;
        }

        .pwd-subtitle {
            font-size: 14px;
            color: #64748b;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
        }

        .input-group-custom {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 14px;
            top: 14px;
            color: #94a3b8;
        }

        .pwd-input {
            width: 100%;
            box-sizing: border-box;
            padding: 12px 42px 12px 40px;
            font-size: 14px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            outline: none;
        }

        .pwd-input:focus {
            border-color: #2563eb;
        }

        .toggle-password {
            position: absolute;
            right: 14px;
            top: 14px;
            color: #94a3b8;
            cursor: pointer;
        }

        .password-message {
            display: block;
            margin-bottom: 20px;
            font-size: 14px;
            color: #2563eb;
        }

        .btn-submit-pwd {
            width: 100%;
            padding: 13px;
            background: #2563eb;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-submit-pwd:hover {
            background: #1d4ed8;
        }

    </style>

</asp:Content>


<asp:Content ID="MainContent"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <div class="company-change-password-container">

        <div class="pwd-card">

            <div class="pwd-header">

                <div class="pwd-icon-wrap">
                    <i class="fa-solid fa-lock"></i>
                </div>

                <h1 class="pwd-title">
                    Change Company Password
                </h1>

                <p class="pwd-subtitle">
                    Update your company password
                </p>

            </div>


            <!-- MESSAGE -->

            <asp:Label ID="lblMessage"
                runat="server"
                CssClass="password-message">
            </asp:Label>


            <!-- CURRENT PASSWORD -->

            <div class="form-group">

                <asp:Label ID="lblCurrentPassword"
                    runat="server"
                    AssociatedControlID="txtCurrentPassword"
                    CssClass="form-label">

                    Current Password

                </asp:Label>

                <div class="input-group-custom">

                    <i class="fa-solid fa-key input-icon"></i>

                    <asp:TextBox ID="txtCurrentPassword"
                        runat="server"
                        TextMode="Password"
                        CssClass="pwd-input"
                        placeholder="Enter current password"
                        ClientIDMode="Static">
                    </asp:TextBox>

                    <i class="fa-solid fa-eye toggle-password"
                        onclick="toggleVisibility('txtCurrentPassword', this)">
                    </i>

                </div>

            </div>


            <!-- NEW PASSWORD -->

            <div class="form-group">

                <asp:Label ID="lblNewPassword"
                    runat="server"
                    AssociatedControlID="txtNewPassword"
                    CssClass="form-label">

                    New Password

                </asp:Label>

                <div class="input-group-custom">

                    <i class="fa-solid fa-lock input-icon"></i>

                    <asp:TextBox ID="txtNewPassword"
                        runat="server"
                        TextMode="Password"
                        CssClass="pwd-input"
                        placeholder="Enter new password"
                        ClientIDMode="Static">
                    </asp:TextBox>

                    <i class="fa-solid fa-eye toggle-password"
                        onclick="toggleVisibility('txtNewPassword', this)">
                    </i>

                </div>

            </div>


            <!-- CONFIRM PASSWORD -->

            <div class="form-group">

                <asp:Label ID="lblConfirmPassword"
                    runat="server"
                    AssociatedControlID="txtConfirmPassword"
                    CssClass="form-label">

                    Confirm New Password

                </asp:Label>

                <div class="input-group-custom">

                    <i class="fa-solid fa-shield-halved input-icon"></i>

                    <asp:TextBox ID="txtConfirmPassword"
                        runat="server"
                        TextMode="Password"
                        CssClass="pwd-input"
                        placeholder="Confirm new password"
                        ClientIDMode="Static">
                    </asp:TextBox>

                    <i class="fa-solid fa-eye toggle-password"
                        onclick="toggleVisibility('txtConfirmPassword', this)">
                    </i>

                </div>

            </div>


            <!-- BUTTON -->

            <asp:Button ID="btnChangePassword"
                runat="server"
                Text="Update Password"
                OnClick="btnChangePassword_Click"
                CssClass="btn-submit-pwd" />

        </div>

    </div>


    <script>

        function toggleVisibility(inputId, icon) {

            var input = document.getElementById(inputId);

            if (input.type == "password") {

                input.type = "text";

                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");

            }
            else {

                input.type = "password";

                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");

            }

        }

    </script>

</asp:Content>
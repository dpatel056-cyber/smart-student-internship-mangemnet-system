<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-change-password.aspx.cs" Inherits="asp.net.student_change_password" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        .change-password-container {
            max-width: 650px;
            margin: 30px auto;
            padding: 0 15px;
        }
        .pwd-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(15, 23, 42, 0.06);
            padding: 36px 32px;
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
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.12);
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
            margin-bottom: 22px;
        }
        .form-label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #334155;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .input-group-custom {
            position: relative;
            display: flex;
            align-items: center;
        }
        .input-icon {
            position: absolute;
            left: 14px;
            color: #94a3b8;
            font-size: 15px;
        }
        .pwd-input {
            width: 100%;
            padding: 12px 42px 12px 40px;
            font-size: 14px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            color: #0f172a;
        }
        .pwd-input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .toggle-password {
            position: absolute;
            right: 14px;
            color: #94a3b8;
            cursor: pointer;
            font-size: 15px;
            transition: color 0.2s;
        }
        .toggle-password:hover {
            color: #2563eb;
        }
        .alert-msg {
            padding: 12px 16px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 22px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-danger {
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }
        .alert-success {
            background: #f0fdf4;
            color: #16a34a;
            border: 1px solid #bbf7d0;
        }
        .btn-submit-pwd {
            width: 100%;
            padding: 13px;
            background: #2563eb;
            color: #ffffff;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.25);
            transition: background 0.2s, transform 0.2s;
        }
        .btn-submit-pwd:hover {
            background: #1d4ed8;
            transform: translateY(-1px);
        }
        .btn-submit-pwd:active {
            transform: translateY(0);
        }
    </style>
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="change-password-container">
        <div class="pwd-card">
            <div class="pwd-header">
                <div class="pwd-icon-wrap">
                    <i class="fa-solid fa-lock"></i>
                </div>
                <h1 class="pwd-title">Change Password</h1>
                <p class="pwd-subtitle">Update your password to keep your student account secure</p>
            </div>
            <asp:PlaceHolder ID="pnlAlert" runat="server" Visible="false">
                <div id="alertBox" runat="server" class="alert-msg">
                    <asp:Label ID="lblAlertIcon" runat="server" />
                    <asp:Label ID="lblMessage" runat="server" />
                </div>
            </asp:PlaceHolder>
            <div class="form-group">
                <asp:Label ID="lblCurrentPassword" runat="server" AssociatedControlID="txtCurrentPassword" CssClass="form-label">Current Password *</asp:Label>
                <div class="input-group-custom">
                    <i class="fa-solid fa-key input-icon"></i>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="pwd-input" placeholder="Enter current password" ClientIDMode="Static" />
                    <i class="fa-solid fa-eye toggle-password" onclick="toggleVisibility('txtCurrentPassword', this)"></i>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblNewPassword" runat="server" AssociatedControlID="txtNewPassword" CssClass="form-label">New Password *</asp:Label>
                <div class="input-group-custom">
                    <i class="fa-solid fa-lock input-icon"></i>
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="pwd-input" placeholder="Enter new password (min. 6 characters)" ClientIDMode="Static" />
                    <i class="fa-solid fa-eye toggle-password" onclick="toggleVisibility('txtNewPassword', this)"></i>
                </div>
            </div>
            <div class="form-group">
                <asp:Label ID="lblConfirmPassword" runat="server" AssociatedControlID="txtConfirmPassword" CssClass="form-label">Confirm New Password *</asp:Label>
                <div class="input-group-custom">
                    <i class="fa-solid fa-shield-halved input-icon"></i>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="pwd-input" placeholder="Confirm new password" ClientIDMode="Static" />
                    <i class="fa-solid fa-eye toggle-password" onclick="toggleVisibility('txtConfirmPassword', this)"></i>
                </div>
            </div>
            <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" OnClick="btnChangePassword_Click" CssClass="btn-submit-pwd" />
        </div>
    </div>
    <script>
        function toggleVisibility(inputId, icon) {
            var input = document.getElementById(inputId);
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }
    </script>
</asp:Content>

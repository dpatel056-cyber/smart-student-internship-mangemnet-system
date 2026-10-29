<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-change-password.aspx.cs" Inherits="asp.net.student_change_password" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-change-password.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
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
            <!-- MESSAGE -->
            <div class="sims-profile-msg-wrap">
                <asp:Label ID="lblMessage" runat="server" CssClass="sims-profile-msg"></asp:Label>
            </div>
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
            <div class="pwd-submit-wrap">
                <asp:ImageButton ID="btnChangePassword" runat="server" 
                                 ImageUrl="~/assets/btn_update_password.png" 
                                 OnClick="btnChangePassword_Click" 
                                 Height="48" 
                                 CssClass="btn-submit-pwd-img student-img-btn" />
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="ScriptContent_schpwd" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="../js/student-change-password.js"></script>
</asp:Content>

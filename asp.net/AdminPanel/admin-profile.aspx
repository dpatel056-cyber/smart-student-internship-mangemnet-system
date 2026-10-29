<%@ Page Title="Admin Profile" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-profile.aspx.cs" Inherits="asp.net.admin_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-profile.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="sims-profile-page">
        <!-- ===================== PAGE HEADER ===================== -->
        <div class="sims-profile-header">
            <h1 class="sims-profile-page-title">Admin Account Profile</h1>
            <p class="sims-profile-page-subtitle">Manage administrator account credentials, security settings and password.</p>
        </div>
        <!-- ===================== MAIN GRID ===================== -->
        <div class="sims-profile-new-grid">
            <!-- ===================== LEFT COLUMN: PERSONAL INFORMATION ===================== -->
            <div class="sims-profile-new-left">
                <div class="sims-profile-card" id="personalInfoCard">
                    <div class="sims-profile-pi-head">
                        <div class="sims-profile-pi-title-wrap">
                            <div class="sims-profile-pi-icon-wrap">
                                <i class="fa-solid fa-user"></i>
                            </div>
                            <h3 class="sims-profile-pi-title">Personal Information</h3>
                        </div>
                    </div>
                    <!-- VIEW MODE PANEL -->
                    <div id="pnlViewMode" runat="server">
                        <div class="sims-profile-pi-rows">
                            <div class="sims-profile-pi-row">
                                <span class="sims-profile-pi-label">Email Address</span>
                                <span class="sims-profile-pi-colon">:</span>
                                <span class="sims-profile-pi-value"><asp:Label ID="lblAdminEmailView" runat="server">admin@sims.com</asp:Label></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ===================== RIGHT COLUMN: CHANGE PASSWORD ===================== -->
            <div class="sims-profile-new-right">
                <div class="sims-profile-card" id="passwordCard">
                    <div class="sims-profile-section-head">
                        <div class="sims-profile-section-title-wrap">
                            <div class="sims-profile-pi-icon-wrap pwd-icon-wrap">
                                <i class="fa-solid fa-lock"></i>
                            </div>
                            <div>
                                <h3 class="sims-profile-section-title">Change Password</h3>
                                <p class="sims-profile-section-subtitle">Choose a strong password to keep your administrator account secure.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Label Message for validation & success feedback -->
                    <div class="sims-profile-msg-wrap">
                        <asp:Label ID="lblMessage" runat="server" CssClass="sims-profile-msg"></asp:Label>
                    </div>

                    <div class="sims-profile-form">
                        <div class="sims-profile-form-group">
                            <label class="sims-profile-form-label">Current Password <span class="req-star">*</span></label>
                            <div class="sims-profile-input-wrap">
                                <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="sims-profile-input" placeholder="Enter current password" ClientIDMode="Static" />
                                <i class="fa-solid fa-eye sims-profile-pwd-eye" onclick="togglePwdVisibility('txtCurrentPassword', this)"></i>
                            </div>
                        </div>
                        <div class="sims-profile-form-group">
                            <label class="sims-profile-form-label">New Password <span class="req-star">*</span></label>
                            <div class="sims-profile-input-wrap">
                                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="sims-profile-input" placeholder="Enter new password (min. 6 characters)" ClientIDMode="Static" />
                                <i class="fa-solid fa-eye sims-profile-pwd-eye" onclick="togglePwdVisibility('txtNewPassword', this)"></i>
                            </div>
                        </div>
                        <div class="sims-profile-form-group">
                            <label class="sims-profile-form-label">Confirm New Password <span class="req-star">*</span></label>
                            <div class="sims-profile-input-wrap">
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="sims-profile-input" placeholder="Re-enter new password" ClientIDMode="Static" />
                                <i class="fa-solid fa-eye sims-profile-pwd-eye" onclick="togglePwdVisibility('txtConfirmPassword', this)"></i>
                            </div>
                        </div>
                        <div class="admin-password-btn-wrap">
                            <asp:ImageButton ID="btnChangePassword" runat="server" ImageUrl="~/assets/btn_update_password.png" OnClick="btnChangePassword_Click" CssClass="admin-password-submit-btn" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/admin-profile.js"></script>
</asp:Content>

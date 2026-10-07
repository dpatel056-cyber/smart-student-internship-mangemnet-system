<%@ Page Title="Admin Profile" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-profile.aspx.cs" Inherits="asp.net.admin_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-profile.css" />
    <style>
        .sims-profile-avatar-new {
            width: 90px;
            height: 90px;
            border-radius: 50% !important;
            overflow: hidden !important;
            object-fit: cover;
            border: 3px solid #2563eb;
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.15);
        }
        .password-alert {
    padding: 12px 16px;
    border-radius: 10px;
    font-size: 14px;
    font-weight: 500;
    margin-bottom: 20px;
    display: flex;
    align-items: center;
    gap: 10px;
}

.password-alert.success {
    background: #ecfdf5;
    color: #059669;
    border: 1px solid #a7f3d0;
}

.password-alert.error {
    background: #fef2f2;
    color: #dc2626;
    border: 1px solid #fecaca;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="sims-profile-page">
        <!-- ===================== PAGE HEADER ===================== -->
        <div class="sims-profile-header" style="margin-bottom: 20px;">
            <h1 class="sims-profile-page-title" style="font-size: 20px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Admin Account Profile</h1>
            <p class="sims-profile-page-subtitle" style="font-size: 13.5px; color: #64748b; margin: 0;">Manage administrator personal information, profile photo and account password.</p>
        </div>
        <!-- ===================== MAIN GRID ===================== -->
        <div class="sims-profile-new-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(360px, 1fr)); gap: 24px;">
            <!-- ===================== LEFT COLUMN: PERSONAL INFORMATION ===================== -->
            <div class="sims-profile-new-left">
                <div class="sims-profile-card" id="personalInfoCard" style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 24px;">
                    <div class="sims-profile-pi-head" style="justify-content: space-between; display: flex; align-items: center; margin-bottom: 20px; padding-bottom: 14px; border-bottom: 1px solid #f1f5f9;">
                        <div style="display: flex; align-items: center; gap: 12px;">
                            <div class="sims-profile-pi-icon-wrap" style="width: 36px; height: 36px; background: #eff6ff; color: #2563eb; border-radius: 8px; display: flex; align-items: center; justify-content: center;">
                                <i class="fa-solid fa-user"></i>
                            </div>
                            <h3 class="sims-profile-pi-title" style="margin: 0; font-size: 18px; font-weight: 700; color: #0f172a;">Personal Information</h3>
                        </div>
                    </div>
                    <!-- VIEW MODE PANEL -->
                    <div id="pnlViewMode" runat="server">
                        <div class="sims-profile-pi-rows" style="display: flex; flex-direction: column; gap: 14px; margin-bottom: 10px;">
                            <div class="sims-profile-pi-row" style="display: flex; font-size: 14px;">
                                <span class="sims-profile-pi-label" style="width: 130px; font-weight: 600; color: #64748b;">Email Address</span>
                                <span class="sims-profile-pi-colon" style="margin-right: 12px;">:</span>
                                <span class="sims-profile-pi-value" style="font-weight: 600; color: #0f172a;"><asp:Label ID="lblAdminEmailView" runat="server">admin@sims.com</asp:Label></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ===================== RIGHT COLUMN: CHANGE PASSWORD ===================== -->
            <div class="sims-profile-new-right">
                <div class="sims-profile-card" id="passwordCard" style="background: #ffffff; border: 1px solid #e2e8f0; border-radius: 14px; padding: 24px;">
                    <div class="sims-profile-section-head" style="padding-bottom: 16px; border-bottom: 1px solid #f1f5f9; margin-bottom: 20px;">
                        <h3 class="sims-profile-section-title" style="font-size: 18px; color: #0f172a; font-weight: 700; margin: 0 0 4px 0;">
                            <i class="fa-solid fa-lock" style="color:#2563eb; margin-right:8px;"></i>Change Password
                        </h3>
                        <p class="sims-profile-section-subtitle" style="color: #64748b; font-size: 14px; margin: 0;">Choose a strong password to keep your administrator account secure.</p>
                    </div>
                    <div id="pnlPasswordAlert" runat="server" visible="false">
                        <div id="divPasswordAlert" runat="server" style="padding: 12px 16px; border-radius: 10px; font-size: 14px; font-weight: 500; margin-bottom: 20px; display: flex; align-items: center; gap: 10px;">
                            <asp:Label ID="lblPasswordAlertIcon" runat="server" />
                            <asp:Label ID="lblPasswordMessage" runat="server" />
                        </div>
                    </div>
                    <div class="sims-profile-form" style="display: flex; flex-direction: column; gap: 16px;">
                        <div class="sims-profile-form-group">
                            <label style="display: block; font-size: 13.5px; font-weight: 600; color: #334155; margin-bottom: 6px;">Current Password <span style="color: #ef4444;">*</span></label>
                            <div style="position:relative; display:flex; align-items:center;">
                                <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="sims-profile-input" placeholder="Enter current password" ClientIDMode="Static" style="width:100%; padding:10px 40px 10px 14px; border:1px solid #cbd5e1; border-radius:8px;" />
                                <i class="fa-solid fa-eye" style="position:absolute; right:14px; color:#94a3b8; cursor:pointer;" onclick="togglePwdVisibility('txtCurrentPassword', this)"></i>
                            </div>
                        </div>
                        <div class="sims-profile-form-group">
                            <label style="display: block; font-size: 13.5px; font-weight: 600; color: #334155; margin-bottom: 6px;">New Password <span style="color: #ef4444;">*</span></label>
                            <div style="position:relative; display:flex; align-items:center;">
                                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="sims-profile-input" placeholder="Enter new password (min. 6 characters)" ClientIDMode="Static" style="width:100%; padding:10px 40px 10px 14px; border:1px solid #cbd5e1; border-radius:8px;" />
                                <i class="fa-solid fa-eye" style="position:absolute; right:14px; color:#94a3b8; cursor:pointer;" onclick="togglePwdVisibility('txtNewPassword', this)"></i>
                            </div>
                        </div>
                        <div class="sims-profile-form-group">
                            <label style="display: block; font-size: 13.5px; font-weight: 600; color: #334155; margin-bottom: 6px;">Confirm New Password <span style="color: #ef4444;">*</span></label>
                            <div style="position:relative; display:flex; align-items:center;">
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="sims-profile-input" placeholder="Re-enter new password" ClientIDMode="Static" style="width:100%; padding:10px 40px 10px 14px; border:1px solid #cbd5e1; border-radius:8px;" />
                                <i class="fa-solid fa-eye" style="position:absolute; right:14px; color:#94a3b8; cursor:pointer;" onclick="togglePwdVisibility('txtConfirmPassword', this)"></i>
                            </div>
                        </div>
                        <div style="margin-top: 10px;">
                            <asp:Button ID="btnUpdatePassword" runat="server" Text="Update Password" OnClick="btnUpdatePassword_Click" CssClass="sims-profile-btn sims-profile-btn-primary" style="width:100%; padding:12px; font-size:14px; font-weight:600; cursor:pointer; background:#2563eb; color:#fff; border:none; border-radius:8px;" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function togglePwdVisibility(inputId, icon) {
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

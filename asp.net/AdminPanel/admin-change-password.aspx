<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-change-password.aspx.cs" Inherits="asp.net.admin_change_password" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/admin-change-password.css") %>">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cp-wrap">
        <!-- Breadcrumb -->
        <nav class="breadcrumb" aria-label="breadcrumb">
            <a href="admin-dashboard.aspx">Home</a>
            <i class="fa-solid fa-chevron-right"></i>
            <a href="admin-settings.aspx">Settings</a>
            <i class="fa-solid fa-chevron-right"></i>
            <span>Change Password</span>
        </nav>

        <div class="cp-hero">
            <div class="cp-hero-copy">
                <h1>Change Password</h1>
                <p>Update your password to keep your account secure.</p>
            </div>
            <div class="cp-hero-art" aria-hidden="true">
                <div class="cp-shield-badge">
                    <i class="fa-solid fa-shield-halved"></i>
                </div>
                <div class="cp-password-bubble">***</div>
                <span class="cp-orbit cp-o1"></span>
                <span class="cp-orbit cp-o2"></span>
                <span class="cp-orbit cp-o3"></span>
                <span class="cp-orbit cp-o4"></span>
            </div>
        </div>

        <div class="row g-4 cp-grid">

            <!-- Form Card -->
            <div class="col-12 col-lg-7">
                <div class="cp-card cp-main-card">
                    <div class="cp-card-head">
                        <div class="cp-card-head-icon"><i class="fa-solid fa-lock"></i></div>
                        <div class="cp-card-head-copy">
                            <h3>Change Password</h3>
                            <p>Please enter your current password and create a new password.</p>
                        </div>
                    </div>

                    <!-- Success message UI -->
                    <div class="cp-alert cp-alert-success" id="cpSuccessAlert" role="alert">
                        <i class="fa-solid fa-circle-check"></i>
                        <div>
                            <strong>Password updated successfully.</strong>
                        </div>
                        <button type="button" class="cp-alert-close" aria-label="Dismiss">&times;</button>
                    </div>

                    <!-- Error message UI -->
                    <div class="cp-alert cp-alert-error" id="cpErrorAlert" role="alert">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <div>
                            <strong>Unable to update password.</strong><br />
                            <span id="cpErrorAlertText">Please fix the highlighted fields before continuing.</span>
                        </div>
                        <button type="button" class="cp-alert-close" aria-label="Dismiss">&times;</button>
                    </div>

                    <form id="cpForm" novalidate>
                        <!-- Current Password -->
                        <div class="cp-field">
                            <label for="cpCurrentPassword">Current Password</label>
                            <div class="cp-input-group">
                                <i class="fa-solid fa-lock cp-input-icon"></i>
                                <asp:TextBox ID="cpCurrentPassword" runat="server" ClientIDMode="Static" CssClass="cp-textbox" TextMode="Password" placeholder="Enter your current password" autocomplete="current-password" />
                                <button type="button" class="cp-toggle-eye" data-target="cpCurrentPassword" aria-label="Show password">
                                    <i class="fa-solid fa-eye"></i>
                                </button>
                            </div>
                            <div class="cp-caps-warning" id="cpCapsCurrent"><i class="fa-solid fa-triangle-exclamation"></i> Caps Lock is on</div>
                            <div class="cp-field-error" id="cpCurrentError">
                                <i class="fa-solid fa-circle-exclamation"></i> Please enter your current password
                            </div>
                        </div>

                        <!-- New Password -->
                        <div class="cp-field">
                            <label for="cpNewPassword">New Password</label>
                            <div class="cp-input-group">
                                <i class="fa-solid fa-lock cp-input-icon"></i>
                                <asp:TextBox ID="cpNewPassword" runat="server" ClientIDMode="Static" CssClass="cp-textbox" TextMode="Password" placeholder="Enter your new password" autocomplete="new-password" />
                                <button type="button" class="cp-toggle-eye" data-target="cpNewPassword" aria-label="Show password">
                                    <i class="fa-solid fa-eye"></i>
                                </button>
                            </div>
                            <div class="cp-caps-warning" id="cpCapsNew"><i class="fa-solid fa-triangle-exclamation"></i> Caps Lock is on</div>
                            <div class="cp-field-error" id="cpSameAsOldError">
                                <i class="fa-solid fa-circle-exclamation"></i> New password must be different from your current password
                            </div>

                            <div class="cp-strength" id="cpStrength" data-level="">
                                <div class="cp-strength-bar">
                                    <span class="cp-strength-fill" id="cpStrengthFill"></span>
                                </div>
                                <div class="cp-strength-label" id="cpStrengthLabel" aria-live="polite">
                                    <i class="fa-solid fa-circle-info"></i>
                                    <span>Enter a new password</span>
                                </div>
                            </div>
                        </div>

                        <!-- Confirm New Password -->
                        <div class="cp-field">
                            <label for="cpConfirmPassword">Confirm New Password</label>
                            <div class="cp-input-group">
                                <i class="fa-solid fa-lock cp-input-icon"></i>
                                <asp:TextBox ID="cpConfirmPassword" runat="server" ClientIDMode="Static" CssClass="cp-textbox" TextMode="Password" placeholder="Confirm your new password" autocomplete="new-password" />
                                <button type="button" class="cp-toggle-eye" data-target="cpConfirmPassword" aria-label="Show password">
                                    <i class="fa-solid fa-eye"></i>
                                </button>
                            </div>
                            <div class="cp-field-error" id="cpConfirmError">
                                <i class="fa-solid fa-circle-exclamation"></i> Passwords do not match
                            </div>
                            <div class="cp-field-success" id="cpConfirmSuccess">
                                <i class="fa-solid fa-circle-check"></i> Passwords match
                            </div>
                        </div>

                        <!-- Password requirements -->
                        <div class="cp-field cp-requirements-block">
                            <label>Password Strength</label>
                            <div class="cp-strength-inline">
                                <div class="cp-strength-rail"><span id="cpStrengthMiniFill"></span></div>
                                <span class="cp-strength-tag" id="cpStrengthMiniText">Strong</span>
                            </div>
                        </div>

                        <div class="cp-actions">
                            <button type="button" id="cpCancelBtn" class="cp-btn cp-btn-secondary">Cancel</button>
                            <asp:Button ID="cpSubmitBtn" runat="server" ClientIDMode="Static" Text="Update Password" CssClass="cp-btn cp-btn-primary" />
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-12 col-lg-5">
                <div class="cp-right-stack">
                    <div class="cp-status-banner cp-alert-success show" id="cpSuccessPreview" role="status">
                        <i class="fa-solid fa-circle-check"></i>
                        <div>Password updated successfully.</div>
                        <button type="button" class="cp-alert-close" aria-label="Dismiss">&times;</button>
                    </div>

                    <div class="cp-card cp-side-card">
                        <div class="cp-card-head small">
                            <div class="cp-card-head-icon"><i class="fa-solid fa-shield-halved"></i></div>
                            <div class="cp-card-head-copy">
                                <h3>Password Requirements</h3>
                            </div>
                        </div>
                        <ul class="cp-requirements">
                            <li id="reqLength"><span class="cp-req-dot"><i class="fa-solid fa-check"></i></span> At least 8 characters long</li>
                            <li id="reqUpper"><span class="cp-req-dot"><i class="fa-solid fa-check"></i></span> One uppercase letter (A-Z)</li>
                            <li id="reqLower"><span class="cp-req-dot"><i class="fa-solid fa-check"></i></span> One lowercase letter (a-z)</li>
                            <li id="reqNumber"><span class="cp-req-dot"><i class="fa-solid fa-check"></i></span> One number (0-9)</li>
                            <li id="reqSpecial"><span class="cp-req-dot"><i class="fa-solid fa-check"></i></span> One special character (!@#$%^&*)</li>
                        </ul>
                    </div>

                    <div class="cp-card cp-side-card cp-tip-card">
                        <div class="cp-card-head small">
                            <div class="cp-card-head-icon cp-tip-icon"><i class="fa-solid fa-lightbulb"></i></div>
                            <div class="cp-card-head-copy">
                                <h3>Tips</h3>
                            </div>
                        </div>
                        <div class="cp-tip-summary">
                            A strong password protects your account from unauthorized access.
                        </div>
                        <div class="cp-shield-outline"><i class="fa-regular fa-shield"></i></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="cp-footer-note">
            <i class="fa-solid fa-circle-info"></i>
            <div>
                <strong>Keep your account secure</strong>
                <p>Never share your password with anyone. Make sure to choose a strong password that is hard to guess.</p>
            </div>
            <button type="button" class="cp-alert-close" aria-label="Dismiss">&times;</button>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<%= ResolveUrl("~/js/admin-change-password.js") %>"></script>
</asp:Content>



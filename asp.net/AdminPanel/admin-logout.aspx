<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-logout.aspx.cs" Inherits="asp.net.css.admin_logout" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-logout.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <div class="sims-logout-page">

    <!-- ===================== PAGE HEADER ===================== -->
    <div class="sims-logout-pageheader">
        <div class="sims-logout-breadcrumb">Dashboard / Logout</div>
        <h1 class="sims-logout-title">Logout</h1>
        <p class="sims-logout-subtitle">Securely sign out from your SIMS Administrator account.</p>
    </div>

    <!-- ===================== STATE: CONFIRM (default) ===================== -->
    <div class="sims-logout-state" id="stateConfirm">

        <div class="sims-logout-container">

            <!-- MAIN LOGOUT CARD -->
            <div class="sims-logout-card">
                <div class="sims-logout-icon">
                    <i class="fa-solid fa-right-from-bracket"></i>
                </div>
                <h2 class="sims-logout-heading">Are you sure you want to logout?</h2>
                <p class="sims-logout-description">
                    You are about to sign out from the SIMS Admin Panel.
                    Your current administrator session will be ended securely.
                </p>

                <div class="sims-logout-user">
                    <img class="sims-logout-user-avatar" src="https://ui-avatars.com/api/?name=Admin+User&background=2954E6&color=fff&size=100&bold=true" alt="Admin User" />
                    <div class="sims-logout-user-info">
                        <span class="sims-logout-user-name">Admin User</span>
                        <span class="sims-logout-user-email">admin@sims.com</span>
                        <span class="sims-logout-user-role">Super Administrator</span>
                    </div>
                    <span class="sims-logout-badge sims-logout-badge-success"><i class="fa-solid fa-circle-check"></i> Active</span>
                </div>

                <div class="sims-logout-actions">
                    <button type="button" class="sims-logout-btn sims-logout-btn-danger" id="btnLogout">
                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                    </button>
                    <a href="admin-dashboard.aspx" class="sims-logout-btn sims-logout-btn-ghost" id="btnCancel">
                        <i class="fa-solid fa-arrow-left"></i> Cancel
                    </a>
                </div>
            </div>

            <!-- SECURITY MESSAGE -->
            <div class="sims-logout-security">
                <i class="fa-solid fa-shield-halved"></i>
                <div>
                    <strong>Secure Logout</strong>
                    <p>For your security, always logout when you are finished using the Admin Panel, especially when using a shared or public computer.</p>
                </div>
            </div>

            <div class="sims-logout-grid">

                <!-- CURRENT SESSION INFORMATION -->
                <div class="sims-logout-panel sims-logout-session">
                    <h3 class="sims-logout-panel-title">Current Session</h3>
                    <div class="sims-logout-session-info">
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Logged In As</span>
                            <span class="sims-logout-info-value">Admin User</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Role</span>
                            <span class="sims-logout-info-value">Super Administrator</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Login Time</span>
                            <span class="sims-logout-info-value">20 Aug 2026, 10:30 AM</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Last Activity</span>
                            <span class="sims-logout-info-value">20 Aug 2026, 04:05 PM</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Device</span>
                            <span class="sims-logout-info-value">Windows Desktop</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Browser</span>
                            <span class="sims-logout-info-value">Chrome</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">IP Address</span>
                            <span class="sims-logout-info-value">192.168.1.105</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Session Status</span>
                            <span class="sims-logout-badge sims-logout-badge-success">Active</span>
                        </div>
                    </div>
                </div>

                <!-- LAST LOGIN -->
                <div class="sims-logout-panel sims-logout-last-login">
                    <h3 class="sims-logout-panel-title">Last Login</h3>
                    <div class="sims-logout-session-info">
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Date</span>
                            <span class="sims-logout-info-value">20 Aug 2026</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Time</span>
                            <span class="sims-logout-info-value">10:30 AM</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Device</span>
                            <span class="sims-logout-info-value">Windows Desktop</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Browser</span>
                            <span class="sims-logout-info-value">Chrome</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">IP Address</span>
                            <span class="sims-logout-info-value">192.168.1.105</span>
                        </div>
                        <div class="sims-logout-info-item">
                            <span class="sims-logout-info-label">Location</span>
                            <span class="sims-logout-info-value">Ahmedabad, India</span>
                        </div>
                        <div class="sims-logout-info-item sims-logout-info-full">
                            <span class="sims-logout-info-label">Status</span>
                            <span class="sims-logout-badge sims-logout-badge-success">Successful</span>
                        </div>
                    </div>
                    <a href="admin-profile.aspx" class="sims-logout-btn sims-logout-btn-outline sims-logout-btn-block">View Login History</a>
                </div>

            </div>

            <!-- OTHER ACTIVE SESSIONS -->
            <div class="sims-logout-panel sims-logout-active-sessions">
                <div class="sims-logout-panel-head">
                    <h3 class="sims-logout-panel-title">Other Active Sessions</h3>
                    <button type="button" class="sims-logout-btn sims-logout-btn-outline" id="btnSignOutAllOther">
                        Sign Out From All Other Devices
                    </button>
                </div>

                <div class="sims-logout-session-card">
                    <div class="sims-logout-session-card-icon"><i class="fa-solid fa-desktop"></i></div>
                    <div class="sims-logout-session-card-body">
                        <span class="sims-logout-session-card-title">Windows Desktop</span>
                        <span class="sims-logout-session-card-meta">Chrome &bull; Ahmedabad</span>
                    </div>
                    <span class="sims-logout-session-card-time">Active now</span>
                    <span class="sims-logout-badge sims-logout-badge-success">This Device</span>
                </div>

                <div class="sims-logout-session-card">
                    <div class="sims-logout-session-card-icon"><i class="fa-solid fa-laptop"></i></div>
                    <div class="sims-logout-session-card-body">
                        <span class="sims-logout-session-card-title">Windows Laptop</span>
                        <span class="sims-logout-session-card-meta">Edge &bull; Ahmedabad</span>
                    </div>
                    <span class="sims-logout-session-card-time">2 hours ago</span>
                    <button type="button" class="sims-logout-btn-link sims-logout-session-signout" data-session="laptop">Sign Out</button>
                </div>

                <div class="sims-logout-session-card">
                    <div class="sims-logout-session-card-icon"><i class="fa-solid fa-mobile-screen"></i></div>
                    <div class="sims-logout-session-card-body">
                        <span class="sims-logout-session-card-title">Mobile Device</span>
                        <span class="sims-logout-session-card-meta">Chrome &bull; Ahmedabad</span>
                    </div>
                    <span class="sims-logout-session-card-time">Yesterday</span>
                    <button type="button" class="sims-logout-btn-link sims-logout-session-signout" data-session="mobile">Sign Out</button>
                </div>
            </div>

            <!-- SECURITY TIPS -->
            <div class="sims-logout-panel sims-logout-security-tips">
                <h3 class="sims-logout-panel-title">Security Tips</h3>
                <ul class="sims-logout-tips-list">
                    <li><i class="fa-solid fa-check"></i> Always logout when finished.</li>
                    <li><i class="fa-solid fa-check"></i> Do not share your administrator credentials.</li>
                    <li><i class="fa-solid fa-check"></i> Avoid using the Admin Panel on public computers.</li>
                    <li><i class="fa-solid fa-check"></i> Keep your password secure.</li>
                    <li><i class="fa-solid fa-check"></i> Enable two-factor authentication.</li>
                </ul>
            </div>

        </div>
    </div>

    <!-- ===================== STATE: SUCCESS (hidden by default) ===================== -->
    <div class="sims-logout-state" id="stateSuccess" style="display:none;">
        <div class="sims-logout-container sims-logout-container-narrow">
            <div class="sims-logout-card sims-logout-success">
                <div class="sims-logout-icon sims-logout-icon-success">
                    <i class="fa-solid fa-shield-halved"></i>
                </div>
                <h2 class="sims-logout-heading">You have been logged out successfully.</h2>
                <p class="sims-logout-description">Your SIMS Administrator session has been securely terminated.</p>

                <div class="sims-logout-success-meta">
                    <span class="sims-logout-info-label">Logout Time</span>
                    <span class="sims-logout-info-value" id="logoutTimeValue">20 Aug 2026, 04:10 PM</span>
                </div>

                <p class="sims-logout-thankyou">Thank you for securely using the SIMS Admin Panel.</p>

                <div class="sims-logout-countdown" id="redirectCountdown">
                    Redirecting to Admin Login in <span id="countdownValue">5</span> seconds...
                </div>

                <a href="../login.aspx" class="sims-logout-btn sims-logout-btn-primary sims-logout-btn-block">
                    Go to Login
                </a>
            </div>
        </div>
    </div>

    <!-- ===================== STATE: SESSION ENDED (optional/demo trigger) ===================== -->
    <div class="sims-logout-state" id="stateSessionEnded" style="display:none;">
        <div class="sims-logout-container sims-logout-container-narrow">
            <div class="sims-logout-card sims-logout-timeout">
                <div class="sims-logout-icon sims-logout-icon-neutral">
                    <i class="fa-solid fa-lock"></i>
                </div>
                <h2 class="sims-logout-heading">Your Session Has Ended</h2>
                <p class="sims-logout-description">For security reasons, your administrator session is no longer active.</p>
                <a href="../login.aspx" class="sims-logout-btn sims-logout-btn-primary sims-logout-btn-block">
                    Return to Login
                </a>
            </div>
        </div>
    </div>

    <!-- ===================== STATE: SESSION TIMEOUT (optional/demo trigger) ===================== -->
    <div class="sims-logout-state" id="stateSessionTimeout" style="display:none;">
        <div class="sims-logout-container sims-logout-container-narrow">
            <div class="sims-logout-card sims-logout-timeout">
                <div class="sims-logout-icon sims-logout-icon-warning">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                </div>
                <h2 class="sims-logout-heading">Session Expired</h2>
                <p class="sims-logout-description">Your session has expired due to inactivity. Please login again to continue.</p>
                <a href="../login.aspx" class="sims-logout-btn sims-logout-btn-primary sims-logout-btn-block">
                    Login Again
                </a>
            </div>
        </div>
    </div>

</div>

<!-- ===================== MODAL: CONFIRM LOGOUT ===================== -->
<div class="sims-logout-modal-overlay" id="modalLogoutOverlay">
    <div class="sims-logout-modal sims-logout-modal-sm" role="dialog" aria-modal="true">
        <div class="sims-logout-modal-head">
            <h3>Confirm Logout</h3>
            <button type="button" class="sims-logout-modal-close" data-close="modalLogoutOverlay"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="sims-logout-modal-body">
            <div class="sims-logout-modal-warning sims-logout-modal-warning-danger">
                <i class="fa-solid fa-right-from-bracket"></i>
                <p>Are you sure you want to logout from the SIMS Admin Panel?</p>
            </div>
            <p class="sims-logout-modal-note">Your administrator session will be securely terminated.</p>
        </div>
        <div class="sims-logout-modal-foot">
            <button type="button" class="sims-logout-btn sims-logout-btn-ghost" data-close="modalLogoutOverlay">Cancel</button>
            <button type="button" class="sims-logout-btn sims-logout-btn-danger" id="btnConfirmLogout">Confirm Logout</button>
        </div>
    </div>
</div>

<!-- ===================== MODAL: SIGN OUT ALL OTHER DEVICES ===================== -->
<div class="sims-logout-modal-overlay" id="modalSignOutOtherOverlay">
    <div class="sims-logout-modal sims-logout-modal-sm" role="dialog" aria-modal="true">
        <div class="sims-logout-modal-head">
            <h3>Sign Out From All Devices</h3>
            <button type="button" class="sims-logout-modal-close" data-close="modalSignOutOtherOverlay"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="sims-logout-modal-body">
            <div class="sims-logout-modal-warning">
                <i class="fa-solid fa-triangle-exclamation"></i>
                <p>Are you sure you want to sign out from all other active sessions?</p>
            </div>
            <p class="sims-logout-modal-note">You will remain logged in on this device.</p>
        </div>
        <div class="sims-logout-modal-foot">
            <button type="button" class="sims-logout-btn sims-logout-btn-ghost" data-close="modalSignOutOtherOverlay">Cancel</button>
            <button type="button" class="sims-logout-btn sims-logout-btn-warning" id="btnConfirmSignOutOther">Sign Out Other Devices</button>
        </div>
    </div>
</div>

<!-- ===================== TOAST CONTAINER ===================== -->
<div class="sims-logout-toast-container" id="toastContainer"></div>

<script src="../js/admin-logout.js"></script>
</asp:Content>






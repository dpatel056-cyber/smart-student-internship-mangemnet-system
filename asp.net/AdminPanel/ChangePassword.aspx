<%@ Page Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="asp.net.ChangePassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Change Password</title>
    <style>
        .cp-page {
            background: #F6F8FC;
            padding: 24px;
            box-sizing: border-box;
            min-height: calc(100vh - 140px);
        }

        .cp-shell {
            max-width: 1180px;
            margin: 0 auto;
        }

        .cp-breadcrumb {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 13px;
            color: #64748B;
            margin-bottom: 18px;
        }

        .cp-breadcrumb span:last-child {
            color: #4F6FF5;
            font-weight: 600;
        }

        .cp-hero {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 22px;
        }

        .cp-hero h1 {
            margin: 0;
            font-size: clamp(30px, 3vw, 42px);
            line-height: 1.1;
            color: #17233C;
            font-weight: 800;
            letter-spacing: -0.03em;
        }

        .cp-hero p {
            margin: 8px 0 0;
            color: #64748B;
            font-size: 15px;
            line-height: 1.55;
        }

        .cp-hero-art {
            width: 132px;
            height: 96px;
            position: relative;
            flex: 0 0 auto;
        }

        .cp-shield {
            position: absolute;
            left: 40px;
            top: 0;
            width: 68px;
            height: 68px;
            border-radius: 22px;
            background: linear-gradient(180deg, #5F7AF8 0%, #4F6FF5 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 28px;
            box-shadow: 0 16px 30px rgba(79, 111, 245, .28);
            clip-path: polygon(50% 0%, 92% 16%, 92% 64%, 50% 100%, 8% 64%, 8% 16%);
        }

        .cp-hero-bubble {
            position: absolute;
            left: 67px;
            top: 47px;
            padding: 7px 14px;
            border-radius: 12px;
            background: rgba(255,255,255,.96);
            border: 1px solid #DDE6FF;
            box-shadow: 0 10px 20px rgba(15, 23, 42, .08);
            color: #17233C;
            font-weight: 700;
            letter-spacing: 2px;
        }

        .cp-hero-dot {
            position: absolute;
            width: 6px;
            height: 6px;
            border-radius: 50%;
            border: 2px solid rgba(79, 111, 245, .22);
        }

        .cp-dot-1 { left: 18px; top: 24px; }
        .cp-dot-2 { right: 12px; top: 16px; }
        .cp-dot-3 { right: 24px; bottom: 18px; }
        .cp-dot-4 { left: 18px; bottom: 20px; }

        .cp-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.45fr) minmax(310px, .95fr);
            gap: 18px;
            align-items: start;
        }

        .cp-card {
            background: #fff;
            border: 1px solid #E2E8F0;
            border-radius: 18px;
            box-shadow: 0 10px 28px rgba(15, 23, 42, .06);
        }

        .cp-main-card {
            padding: 22px;
        }

        .cp-card-head {
            display: flex;
            gap: 14px;
            align-items: flex-start;
            padding-bottom: 18px;
            margin-bottom: 18px;
            border-bottom: 1px solid #E2E8F0;
        }

        .cp-card-icon {
            width: 44px;
            height: 44px;
            border-radius: 999px;
            background: #EEF3FF;
            color: #4F6FF5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex: 0 0 auto;
        }

        .cp-card-head h2,
        .cp-side-head h3 {
            margin: 0;
            color: #17233C;
            font-size: 18px;
            font-weight: 700;
        }

        .cp-card-head p {
            margin: 4px 0 0;
            color: #64748B;
            font-size: 13px;
            line-height: 1.55;
        }

        .cp-field {
            margin-bottom: 18px;
        }

        .cp-field label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #17233C;
            margin-bottom: 8px;
        }

        .cp-input {
            position: relative;
        }

        .cp-input .cp-left-icon,
        .cp-input .cp-eye {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            color: #94A3B8;
        }

        .cp-input .cp-left-icon {
            left: 14px;
            font-size: 14px;
        }

        .cp-input .cp-eye {
            right: 8px;
            width: 34px;
            height: 34px;
            border: 0;
            background: transparent;
            border-radius: 10px;
            cursor: pointer;
        }

        .cp-input .cp-eye:hover {
            background: rgba(79, 111, 245, .08);
            color: #4F6FF5;
        }

        .cp-input input {
            width: 100%;
            height: 48px;
            border: 1.5px solid #E2E8F0;
            border-radius: 12px;
            background: #fff;
            padding: 0 44px 0 40px;
            font-size: 14px;
            color: #17233C;
            box-sizing: border-box;
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }

        .cp-input input:focus {
            border-color: #4F6FF5;
            box-shadow: 0 0 0 4px rgba(79, 111, 245, .12);
        }

        .cp-strength-block {
            margin-top: 4px;
        }

        .cp-strength-title {
            display: block;
            margin-bottom: 8px;
            font-size: 13px;
            font-weight: 600;
            color: #17233C;
        }

        .cp-strength-rail {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 6px;
        }

        .cp-seg {
            height: 8px;
            border-radius: 999px;
            background: #E2E8F0;
        }

        .cp-strength-label {
            margin-top: 8px;
            font-size: 12px;
            font-weight: 700;
            color: #64748B;
        }

        .cp-strength-rail[data-level="weak"] .cp-seg:nth-child(-n+1) {
            background: linear-gradient(90deg, #EF4444, #F87171);
        }

        .cp-strength-rail[data-level="medium"] .cp-seg:nth-child(-n+2) {
            background: linear-gradient(90deg, #F59E0B, #FBBF24);
        }

        .cp-strength-rail[data-level="strong"] .cp-seg:nth-child(-n+4) {
            background: linear-gradient(90deg, #22C55E, #4ADE80);
        }

        .cp-actions {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 22px;
        }

        .cp-btn {
            height: 44px;
            padding: 0 22px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 600;
            border: 1px solid transparent;
            cursor: pointer;
        }

        .cp-btn-cancel {
            background: #fff;
            border-color: #CBD5E1;
            color: #334155;
        }

        .cp-btn-primary {
            background: linear-gradient(135deg, #5F7AF8, #4F6FF5);
            color: #fff;
            box-shadow: 0 10px 20px rgba(79, 111, 245, .24);
        }

        .cp-side-col {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .cp-side-card {
            padding: 18px;
        }

        .cp-side-head {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 14px;
        }

        .cp-side-icon {
            width: 40px;
            height: 40px;
            border-radius: 999px;
            background: #EEF3FF;
            color: #4F6FF5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            flex: 0 0 auto;
        }

        .cp-req-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .cp-req-list li {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            font-size: 13px;
            line-height: 1.6;
            color: #334155;
            padding: 7px 0;
        }

        .cp-check {
            color: #22C55E;
            font-weight: 700;
            flex: 0 0 auto;
        }

        .cp-tip-text {
            font-size: 13px;
            line-height: 1.65;
            color: #64748B;
            margin: 0;
        }

        .cp-tip-illustration {
            margin-top: 14px;
            display: flex;
            justify-content: flex-end;
            color: rgba(79, 111, 245, .14);
            font-size: 56px;
        }

        .cp-alert {
            margin-top: 16px;
            padding: 16px 18px;
            border-radius: 14px;
            background: #EEF3FF;
            border: 1px solid #DCE7FF;
            display: flex;
            gap: 12px;
            align-items: flex-start;
        }

        .cp-alert i {
            color: #4F6FF5;
            font-size: 18px;
            margin-top: 2px;
        }

        .cp-alert strong {
            display: block;
            color: #17233C;
            font-size: 14px;
            margin-bottom: 4px;
        }

        .cp-alert p {
            margin: 0;
            color: #334155;
            font-size: 13px;
            line-height: 1.55;
        }

        @media (max-width: 991px) {
            .cp-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 767px) {
            .cp-page {
                padding: 16px;
            }

            .cp-hero {
                flex-direction: column;
                align-items: flex-start;
            }

            .cp-actions {
                flex-direction: column-reverse;
            }

            .cp-btn {
                width: 100%;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cp-page">
        <div class="cp-shell">
            <div class="cp-breadcrumb">
                <span>Settings</span>
                <span>/</span>
                <span>Change Password</span>
            </div>

            <div class="cp-hero">
                <div>
                    <h1>Change Password</h1>
                    <p>Update your password to keep your account secure.</p>
                </div>
                <div class="cp-hero-art" aria-hidden="true">
                    <div class="cp-shield"><i class="fa-solid fa-shield-halved"></i></div>
                    <div class="cp-hero-bubble">***</div>
                    <span class="cp-hero-dot cp-dot-1"></span>
                    <span class="cp-hero-dot cp-dot-2"></span>
                    <span class="cp-hero-dot cp-dot-3"></span>
                    <span class="cp-hero-dot cp-dot-4"></span>
                </div>
            </div>

            <div class="cp-grid">
                <div>
                    <div class="cp-card cp-main-card">
                        <div class="cp-card-head">
                            <div class="cp-card-icon"><i class="fa-solid fa-lock"></i></div>
                            <div>
                                <h2>Change Password</h2>
                                <p>Please enter your current password and create a new password.</p>
                            </div>
                        </div>

                        <div class="cp-field">
                            <label for="txtCurrentPassword">Current Password</label>
                            <div class="cp-input">
                                <i class="fa-solid fa-lock cp-left-icon"></i>
                                <asp:TextBox ID="txtCurrentPassword" runat="server" ClientIDMode="Static" TextMode="Password" CssClass="cp-textbox" placeholder="Enter your current password" />
                                <button type="button" class="cp-eye" data-target="txtCurrentPassword" aria-label="Show password">
                                    <i class="fa-regular fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="cp-field">
                            <label for="txtNewPassword">New Password</label>
                            <div class="cp-input">
                                <i class="fa-solid fa-lock cp-left-icon"></i>
                                <asp:TextBox ID="txtNewPassword" runat="server" ClientIDMode="Static" TextMode="Password" CssClass="cp-textbox" placeholder="Enter your new password" />
                                <button type="button" class="cp-eye" data-target="txtNewPassword" aria-label="Show password">
                                    <i class="fa-regular fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="cp-field">
                            <label for="txtConfirmPassword">Confirm New Password</label>
                            <div class="cp-input">
                                <i class="fa-solid fa-lock cp-left-icon"></i>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" ClientIDMode="Static" TextMode="Password" CssClass="cp-textbox" placeholder="Confirm your new password" />
                                <button type="button" class="cp-eye" data-target="txtConfirmPassword" aria-label="Show password">
                                    <i class="fa-regular fa-eye"></i>
                                </button>
                            </div>
                        </div>

                        <div class="cp-strength-block">
                            <label class="cp-strength-title">Password Strength</label>
                            <div class="cp-strength-rail" id="strengthRail" data-level="">
                                <span class="cp-seg"></span>
                                <span class="cp-seg"></span>
                                <span class="cp-seg"></span>
                                <span class="cp-seg"></span>
                            </div>
                            <div class="cp-strength-label" id="strengthLabel">Weak</div>
                        </div>

                        <div class="cp-actions">
                            <button type="button" id="btnCancelPassword" class="cp-btn cp-btn-cancel">Cancel</button>
                            <asp:Button ID="btnUpdatePassword" runat="server" Text="Update Password" CssClass="cp-btn cp-btn-primary" />
                        </div>
                    </div>

                    <div class="cp-alert">
                        <i class="fa-solid fa-circle-info"></i>
                        <div>
                            <strong>Keep your account secure</strong>
                            <p>Never share your password with anyone. Make sure to choose a strong password that is hard to guess.</p>
                        </div>
                    </div>
                </div>

                <div class="cp-side-col">
                    <div class="cp-card cp-side-card">
                        <div class="cp-side-head">
                            <div class="cp-side-icon"><i class="fa-solid fa-shield-halved"></i></div>
                            <h3>Password Requirements</h3>
                        </div>
                        <ul class="cp-req-list">
                            <li><span class="cp-check">✓</span><span>At least 8 characters long</span></li>
                            <li><span class="cp-check">✓</span><span>One uppercase letter (A-Z)</span></li>
                            <li><span class="cp-check">✓</span><span>One lowercase letter (a-z)</span></li>
                            <li><span class="cp-check">✓</span><span>One number (0-9)</span></li>
                            <li><span class="cp-check">✓</span><span>One special character (!@#$%^&*)</span></li>
                        </ul>
                    </div>

                    <div class="cp-card cp-side-card">
                        <div class="cp-side-head">
                            <div class="cp-side-icon"><i class="fa-solid fa-lightbulb"></i></div>
                            <h3>Tips</h3>
                        </div>
                        <p class="cp-tip-text">A strong password protects your account from unauthorized access.</p>
                        <div class="cp-tip-illustration" aria-hidden="true">
                            <i class="fa-regular fa-shield"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="<%= ResolveUrl("~/js/ChangePassword.js") %>"></script>
</asp:Content>



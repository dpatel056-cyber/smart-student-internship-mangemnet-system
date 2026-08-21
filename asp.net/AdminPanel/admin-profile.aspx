<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-profile.aspx.cs" Inherits="asp.net.admin_profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-profile.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <div class="sims-profile-page">

    <!-- ===================== PAGE HEADER ===================== -->
    <div class="sims-profile-pageheader">
        <div class="sims-profile-pageheader-left">
            <div class="sims-profile-breadcrumb">Dashboard / Admin Profile</div>
            <h1 class="sims-profile-title">Admin Profile</h1>
            <p class="sims-profile-subtitle">Manage your personal information, account details and security settings.</p>
        </div>
        <!-- Header actions moved to hero card -->
    </div>

    <!-- ===================== PROFILE HERO CARD ===================== -->
    <div class="sims-profile-hero-new" style="background: transparent; box-shadow: none; border: none; padding: 0 0 20px 0;">
        <div class="sims-profile-hero-content" style="justify-content: center; flex-direction: column; align-items: center; gap: 10px;">
            <div class="sims-profile-avatar-wrap-new">
                <img id="simsProfileAvatarImg" class="sims-profile-avatar-new" src="../assets/admin-avatar.jpg" alt="Admin" onerror="this.src='https://ui-avatars.com/api/?name=Admin&background=f0f2f5&color=333&size=200'" />
                <button type="button" class="sims-profile-camera-btn" id="btnChangePhoto" title="Change Profile Photo">
                    <i class="fa-solid fa-camera"></i>
                </button>
            </div>
            <button type="button" id="btnRemoveProfilePhoto" onclick="removeProfilePhoto()" style="background:none; border:1px solid #fecaca; color:#ef4444; font-size:12px; font-weight:600; cursor:pointer; padding:6px 14px; border-radius:20px; display:flex; align-items:center; gap:6px; transition:all 0.2s;">
                <i class="fa-solid fa-trash-can" style="font-size:11px;"></i> Remove Profile
            </button>
        </div>
    </div>

    <script>
        function removeProfilePhoto() {
            var img = document.getElementById('simsProfileAvatarImg');
            if (img) {
                img.src = 'https://ui-avatars.com/api/?name=Admin&background=f0f2f5&color=333&size=200';
            }
        }
    </script>



    <div class="sims-profile-new-grid">

        <!-- ===================== LEFT COLUMN ===================== -->
        <div class="sims-profile-new-left">

            <!-- PERSONAL INFORMATION -->
            <div class="sims-profile-card" id="personalInfoCard">
                <div class="sims-profile-pi-head" style="justify-content: space-between; display: flex; align-items: center;">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <div class="sims-profile-pi-icon-wrap">
                            <i class="fa-solid fa-user"></i>
                        </div>
                        <h3 class="sims-profile-pi-title" style="margin: 0;">Personal Information</h3>
                    </div>
                    <button type="button" class="sims-profile-btn sims-profile-btn-primary" id="btnEditProfileHero">
                        <i class="fa-solid fa-pen"></i> Edit Profile
                    </button>
                </div>

                <!-- VIEW MODE -->
                <div id="personalViewMode">
                    <div class="sims-profile-pi-rows">
                        <div class="sims-profile-pi-row">
                            <span class="sims-profile-pi-label">Full Name</span>
                            <span class="sims-profile-pi-colon">:</span>
                            <span class="sims-profile-pi-value sims-profile-info-value">System Administrator</span>
                        </div>
                        <div class="sims-profile-pi-row">
                            <span class="sims-profile-pi-label">Email Address</span>
                            <span class="sims-profile-pi-colon">:</span>
                            <span class="sims-profile-pi-value sims-profile-info-value">admin@sims.com</span>
                        </div>
                        <div class="sims-profile-pi-row">
                            <span class="sims-profile-pi-label">Role</span>
                            <span class="sims-profile-pi-colon">:</span>
                            <span class="sims-profile-pi-value sims-profile-info-value">Administrator</span>
                        </div>
                        <div class="sims-profile-pi-row">
                            <span class="sims-profile-pi-label">Phone Number</span>
                            <span class="sims-profile-pi-colon">:</span>
                            <span class="sims-profile-pi-value sims-profile-info-value">+91 98765 43210</span>
                        </div>
                        <div class="sims-profile-pi-row">
                            <span class="sims-profile-pi-label">Last Login</span>
                            <span class="sims-profile-pi-colon">:</span>
                            <span class="sims-profile-pi-value sims-profile-info-value">20 May 2025 10:30 AM</span>
                        </div>
                    </div>
                </div>

                <!-- EDIT MODE -->
                <div class="sims-profile-form" id="personalEditMode" style="display:none;">
                    <div class="sims-profile-form-grid">
                        <div class="sims-profile-form-group">
                            <label>Full Name <span class="sims-profile-required">*</span></label>
                            <input type="text" class="sims-profile-input" id="fldFullName" value="System Administrator" />
                            <span class="sims-profile-validation" id="valFullName"></span>
                        </div>
                        <div class="sims-profile-form-group">
                            <label>Email Address <span class="sims-profile-required">*</span></label>
                            <input type="email" class="sims-profile-input" id="fldEmail" value="admin@sims.com" />
                            <span class="sims-profile-validation" id="valEmail"></span>
                        </div>
                        <div class="sims-profile-form-group">
                            <label>Phone Number</label>
                            <input type="text" class="sims-profile-input" id="fldPhone" value="+91 98765 43210" />
                            <span class="sims-profile-validation" id="valPhone"></span>
                        </div>
                        <div class="sims-profile-form-group">
                            <label>Role</label>
                            <select class="sims-profile-select" id="fldRole">
                                <option selected>Administrator</option>
                                <option>Company</option>
                                <option>Student</option>
                            </select>
                        </div>


                    </div>
                    <div class="sims-profile-form-actions">
                        <button type="button" class="sims-profile-btn sims-profile-btn-primary" id="btnSaveProfile">Save Changes</button>
                        <button type="button" class="sims-profile-btn sims-profile-btn-ghost" id="btnCancelProfile">Cancel</button>
                    </div>
                </div>
            </div>



        </div>

        <!-- ===================== RIGHT COLUMN: CHANGE PASSWORD ===================== -->
        <div class="sims-profile-new-right">
            <div class="sims-profile-card sims-profile-section sims-profile-password" id="passwordCard">
                <div class="sims-profile-section-head" style="padding-bottom: 16px; border-bottom: 1px solid #f1f5f9; margin-bottom: 20px;">
                    <div>
                        <h3 class="sims-profile-section-title" style="font-size: 18px; color: #0f172a; font-weight: 700;">Change Password</h3>
                        <p class="sims-profile-section-subtitle" style="color: #64748b; font-size: 14px; margin-top: 4px;">Choose a strong password to keep your account secure.</p>
                    </div>
                </div>
                <div class="sims-profile-form">
                    <div class="sims-profile-form-grid">
                        <div class="sims-profile-form-group sims-profile-form-full">
                            <label>Current Password <span class="sims-profile-required" style="color: #ef4444;">*</span></label>
                            <div class="sims-profile-password-wrap">
                                <input type="password" class="sims-profile-input" id="fldCurrentPassword" placeholder="Enter current password" />
                                <button type="button" class="sims-profile-password-toggle" data-target="fldCurrentPassword"><i class="fa-solid fa-eye"></i></button>
                            </div>
                            <span class="sims-profile-validation" id="valCurrentPassword"></span>
                        </div>
                        <div class="sims-profile-form-group sims-profile-form-full">
                            <label>New Password <span class="sims-profile-required" style="color: #ef4444;">*</span></label>
                            <div class="sims-profile-password-wrap">
                                <input type="password" class="sims-profile-input" id="fldNewPassword" placeholder="Enter new password" />
                                <button type="button" class="sims-profile-password-toggle" data-target="fldNewPassword"><i class="fa-solid fa-eye"></i></button>
                            </div>
                            <div class="sims-profile-strength">
                                <div class="sims-profile-strength-bar"><span id="strengthBarFill"></span></div>
                                <span class="sims-profile-strength-label" id="strengthLabel" style="font-weight: 600; color: #64748b;">Password strength</span>
                            </div>
                            <ul class="sims-profile-requirements" id="pwdRequirements" style="margin-top: 14px; margin-bottom: 8px;">
                                <li data-rule="len"><i class="fa-solid fa-circle"></i> Minimum 8 characters</li>
                                <li data-rule="upper"><i class="fa-solid fa-circle"></i> At least one uppercase letter</li>
                                <li data-rule="lower"><i class="fa-solid fa-circle"></i> At least one lowercase letter</li>
                                <li data-rule="num"><i class="fa-solid fa-circle"></i> At least one number</li>
                                <li data-rule="special"><i class="fa-solid fa-circle"></i> At least one special character</li>
                            </ul>
                        </div>
                        <div class="sims-profile-form-group sims-profile-form-full">
                            <label>Confirm New Password <span class="sims-profile-required" style="color: #ef4444;">*</span></label>
                            <div class="sims-profile-password-wrap">
                                <input type="password" class="sims-profile-input" id="fldConfirmPassword" placeholder="Re-enter new password" />
                                <button type="button" class="sims-profile-password-toggle" data-target="fldConfirmPassword"><i class="fa-solid fa-eye"></i></button>
                            </div>
                            <span class="sims-profile-validation" id="valConfirmPassword"></span>
                        </div>
                    </div>
                    <div class="sims-profile-form-actions" style="margin-top: 24px;">
                        <button type="button" class="sims-profile-btn sims-profile-btn-primary" id="btnUpdatePassword">
                            <i class="fa-solid fa-lock"></i> Update Password
                        </button>
                        <button type="button" class="sims-profile-btn sims-profile-btn-ghost" id="btnCancelPassword">Cancel</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- ===================== MODAL: CHANGE PROFILE PHOTO ===================== -->
<div class="sims-profile-modal-overlay" id="modalPhotoOverlay">
    <div class="sims-profile-modal" role="dialog" aria-modal="true" style="padding: 0; max-width: 550px; border-radius: 12px; overflow: hidden; border: none; background: #fff;">
        <div class="sims-profile-modal-head" style="display: flex; justify-content: space-between; align-items: center; padding: 20px 24px; border-bottom: 1px solid #f1f5f9; background: #fff;">
            <h3 style="margin: 0; font-size: 18px; color: #1e293b; font-weight: 700;">Update Profile Photo</h3>
            <button type="button" class="sims-profile-modal-close" data-close="modalPhotoOverlay" style="background: none; border: none; font-size: 18px; color: #64748b; cursor: pointer;"><i class="fa-solid fa-xmark"></i></button>
        </div>
        
        <div class="sims-profile-modal-body" style="padding: 24px; text-align: center; background: #fff;">
            <div class="sims-profile-photo-current" style="margin-bottom: 24px;">
                <span style="color: #64748b; font-size: 13px; display: block; margin-bottom: 12px;">Current Profile Photo</span>
                <img id="photoCurrentPreview" src="https://ui-avatars.com/api/?name=AU&background=2563eb&color=fff&size=200&bold=true" alt="Current profile photo" style="width: 84px; height: 84px; border-radius: 50%; object-fit: cover; border: 4px solid #eff6ff; box-shadow: none;" />
            </div>
            
            <div class="sims-profile-upload-area" id="uploadDropZone" style="border: 1px dashed #93c5fd; background: #f8fafc; border-radius: 12px; padding: 24px; margin-bottom: 16px;">
                <i class="fa-solid fa-cloud-arrow-up" style="font-size: 36px; color: #2563eb; margin-bottom: 12px;"></i>
                <p style="color: #1e293b; font-size: 15px; font-weight: 600; margin: 0 0 6px 0;">Drag & drop an image here</p>
                <p style="color: #64748b; font-size: 13px; margin: 0 0 16px 0;">or click the button below to browse</p>
                <button type="button" class="sims-profile-btn sims-profile-btn-primary" id="btnBrowseFile" style="padding: 10px 24px; border-radius: 6px; background: #2563eb; border: none; color: #fff; font-weight: 600;">
                    <i class="fa-regular fa-folder-open"></i> Browse File
                </button>
                <input type="file" id="fldPhotoInput" accept=".jpg,.jpeg,.png" hidden />
                <span class="sims-profile-validation" id="valPhotoUpload"></span>
            </div>
            
            <div style="background: #eff6ff; border: 1px solid #bfdbfe; border-radius: 8px; padding: 12px 16px; display: flex; align-items: center; gap: 12px; margin-bottom: 24px; text-align: left;">
                <i class="fa-solid fa-circle-info" style="color: #2563eb; font-size: 18px;"></i>
                <span style="color: #475569; font-size: 13px;">Allowed: JPG, JPEG, PNG &nbsp;|&nbsp; Maximum: 2 MB</span>
            </div>
            
            <div class="sims-profile-photo-preview" id="photoNewPreviewWrap" style="text-align: center;">
                <span style="color: #1e293b; font-size: 14px; font-weight: 600; display: block; margin-bottom: 12px;">Preview</span>
                <img id="photoNewPreview" src="https://ui-avatars.com/api/?name=%20&background=cbd5e1&color=fff&size=200" alt="New photo preview" style="width: 72px; height: 72px; border-radius: 50%; object-fit: cover; border: none; background: #e2e8f0; margin-bottom: 8px;" />
                <span style="color: #64748b; font-size: 12px; display: block;">Image preview</span>
                <button type="button" class="sims-profile-btn-link" id="btnRemoveNewPhoto" style="display: none; margin-top: 8px;">Remove Photo</button>
            </div>
        </div>
        
        <div class="sims-profile-modal-foot" style="border-top: 1px solid #f1f5f9; padding: 16px 24px; display: flex; justify-content: flex-end; gap: 12px; background: #fff;">
            <button type="button" class="sims-profile-btn sims-profile-btn-ghost" data-close="modalPhotoOverlay" style="background: #fff; border: 1px solid #cbd5e1; color: #334155; padding: 10px 20px; border-radius: 6px;">Cancel</button>
            <button type="button" class="sims-profile-btn sims-profile-btn-primary" id="btnSavePhoto" style="padding: 10px 20px; border-radius: 6px; background: #2563eb; color: #fff; border: none;">
                <i class="fa-regular fa-floppy-disk"></i> Save Photo
            </button>
        </div>
    </div>
</div>

<!-- ===================== MODAL: SIGN OUT ALL DEVICES ===================== -->
<div class="sims-profile-modal-overlay" id="modalSignOutOverlay">
    <div class="sims-profile-modal sims-profile-modal-sm" role="dialog" aria-modal="true">
        <div class="sims-profile-modal-head">
            <h3>Sign Out From All Devices</h3>
            <button type="button" class="sims-profile-modal-close" data-close="modalSignOutOverlay"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="sims-profile-modal-body">
            <div class="sims-profile-modal-warning">
                <i class="fa-solid fa-triangle-exclamation"></i>
                <p>Are you sure you want to sign out from all devices?</p>
            </div>
            <p class="sims-profile-modal-note">You will need to sign in again on all devices.</p>
        </div>
        <div class="sims-profile-modal-foot">
            <button type="button" class="sims-profile-btn sims-profile-btn-ghost" data-close="modalSignOutOverlay">Cancel</button>
            <button type="button" class="sims-profile-btn sims-profile-btn-warning" id="btnConfirmSignOutAll">Sign Out All Devices</button>
        </div>
    </div>
</div>

<!-- ===================== MODAL: DEACTIVATE ACCOUNT ===================== -->
<div class="sims-profile-modal-overlay" id="modalDeactivateOverlay">
    <div class="sims-profile-modal sims-profile-modal-sm" role="dialog" aria-modal="true">
        <div class="sims-profile-modal-head">
            <h3>Deactivate Account</h3>
            <button type="button" class="sims-profile-modal-close" data-close="modalDeactivateOverlay"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="sims-profile-modal-body">
            <div class="sims-profile-modal-warning sims-profile-modal-warning-danger">
                <i class="fa-solid fa-triangle-exclamation"></i>
                <p>Are you sure you want to deactivate this administrator account?</p>
            </div>
            <p class="sims-profile-modal-note">You may lose access to the Admin Panel until the account is reactivated.</p>
        </div>
        <div class="sims-profile-modal-foot">
            <button type="button" class="sims-profile-btn sims-profile-btn-ghost" data-close="modalDeactivateOverlay">Cancel</button>
            <button type="button" class="sims-profile-btn sims-profile-btn-danger" id="btnConfirmDeactivate">Deactivate Account</button>
        </div>
    </div>
</div>

<!-- ===================== MODAL: DISABLE 2FA CONFIRM ===================== -->
<div class="sims-profile-modal-overlay" id="modal2faOverlay">
    <div class="sims-profile-modal sims-profile-modal-sm" role="dialog" aria-modal="true">
        <div class="sims-profile-modal-head">
            <h3>Disable Two-Factor Authentication</h3>
            <button type="button" class="sims-profile-modal-close" data-close="modal2faOverlay"><i class="fa-solid fa-xmark"></i></button>
        </div>
        <div class="sims-profile-modal-body">
            <div class="sims-profile-modal-warning sims-profile-modal-warning-danger">
                <i class="fa-solid fa-triangle-exclamation"></i>
                <p>Are you sure you want to disable two-factor authentication?</p>
            </div>
            <p class="sims-profile-modal-note">This will reduce the security level of your administrator account.</p>
        </div>
        <div class="sims-profile-modal-foot">
            <button type="button" class="sims-profile-btn sims-profile-btn-ghost" data-close="modal2faOverlay">Cancel</button>
            <button type="button" class="sims-profile-btn sims-profile-btn-danger" id="btnConfirmDisable2fa">Disable 2FA</button>
        </div>
    </div>
</div>

<!-- ===================== TOAST CONTAINER ===================== -->
<div class="sims-profile-toast-container" id="toastContainer"></div>

<script src="../js/admin-profile.js"></script>
</asp:Content>






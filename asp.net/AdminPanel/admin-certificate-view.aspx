<%@ Page Title="View Certificate" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-certificate-view.aspx.cs" Inherits="asp.net.admin_certificate_view" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-certificate-view.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cert-view-container">
        <!-- Action Bar -->
        <div class="cert-action-bar">
            <asp:ImageButton ID="btnBackCertificates" runat="server" ImageUrl="~/image_button/btn_back_certificates.png" Height="38" OnClick="btnBackCertificates_Click" CssClass="admin-img-btn" />
            <asp:ImageButton ID="btnPrintCertificate" runat="server" ImageUrl="~/image_button/btn_print_cert.png" Height="38" OnClientClick="window.print(); return false;" CssClass="admin-img-btn" />
        </div>
        <!-- Certificate Card -->
        <div class="cert-sheet-card">
            <div class="cert-inner-box">
                <!-- Header -->
                <div class="cert-top-header">
                    <div class="cert-company-wrap">
                        <div class="cert-company-logo">
                            <asp:DataList ID="dlCompanyLogo" runat="server" RepeatLayout="Flow" ShowHeader="false" ShowFooter="false">
                                <ItemTemplate>
                                    <asp:Image ID="imgCompanyLogo" runat="server" ImageUrl='<%# Eval("c_logo") %>' />
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <div>
                            <div class="cert-company-name">
                                <asp:Label ID="lblCompany" runat="server"></asp:Label>
                            </div>
                            <div class="cert-company-division">
                                Internship &amp; Talent Acquisition Division
                            </div>
                        </div>
                    </div>
                    <div class="cert-header-right">
                        <div>Official Verified Certificate</div>
                        <div class="cert-no">
                            <asp:Label ID="lblCertNo" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <!-- Tag -->
                <div class="cert-badge-tag">
                    <i class="fa-solid fa-award"></i>Verified Completion
                </div>
                <!-- Title -->
                <div class="cert-title-main">
                    <asp:Label ID="lblCertTitle" runat="server"></asp:Label>
                </div>
                <div class="cert-present-lead">This is proudly presented to</div>
                <!-- Student -->
                <div>
                    <asp:Label ID="lblStudentName" runat="server" CssClass="cert-student-name"></asp:Label>
                </div>
                <div class="cert-college">
                    <asp:Label ID="lblCollege" runat="server"></asp:Label>
                </div>
                <!-- Description -->
                <p class="cert-desc-text">
                    For successfully completing the professional internship program as
                    <strong class="hl-blue"><asp:Label ID="lblInternship" runat="server"></asp:Label></strong>
                    for a duration of
                    <strong class="hl-dark"><asp:Label ID="lblDuration" runat="server"></asp:Label></strong>.
                    During this tenure, the candidate demonstrated exemplary professionalism, technical capability, and
                    <strong class="hl-orange"><asp:Label ID="lblPerformance" runat="server"></asp:Label></strong>.
                </p>
                <!-- Footer -->
                <div class="cert-bottom-grid">
                    <div class="cert-meta-left">
                        <div>
                            <strong>Issue Date:</strong>
                            <asp:Label ID="lblIssueDate" runat="server"></asp:Label>
                        </div>
                        <div>
                            <strong>Student Email:</strong>
                            <asp:Label ID="lblStudentEmail" runat="server"></asp:Label>
                        </div>
                    </div>
                    <div class="cert-medal">
                        <i class="fa-solid fa-medal"></i>
                    </div>
                    <div class="cert-sign-right">
                        <div class="cert-sign-line">Authorized Signatory</div>
                        <div class="cert-sign-name">
                            <asp:Label ID="lblSignatoryName" runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

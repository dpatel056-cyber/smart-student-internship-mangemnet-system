<%@ Page Title="Offer Letter View" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-offer-letter-view.aspx.cs" Inherits="asp.net.admin_offer_letter_view" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-offer-letter-view.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="print-modal-container">
        <div class="print-modal-bar">
            <div class="modal-bar-title">
                <i class="fa-solid fa-file-signature"></i> Official Internship Offer Letter
            </div>
            <div class="modal-bar-actions">
                <asp:ImageButton ID="btnBackOffers" runat="server" ImageUrl="~/assets/btn_back_offers.png" Height="38" OnClick="btnBackOffers_Click" CssClass="admin-img-btn" />
                <asp:ImageButton ID="btnPrintSavePdf" runat="server" ImageUrl="~/assets/btn_print_save_pdf.png" Height="38" OnClientClick="window.print(); return false;" CssClass="admin-img-btn" />
            </div>
        </div>

        <div class="modal-letter-wrapper">
            <div class="letterhead-doc" id="printableLetterhead">
                <!-- Company Header -->
                <div class="lh-company-header">
                    <div>
                        <div class="lh-logo-wrap">
                            <asp:DataList ID="dlCompanyLogo" runat="server" RepeatLayout="Flow" ShowHeader="false" ShowFooter="false">
                                <ItemTemplate>
                                    <asp:Image ID="imgCompanyLogo" runat="server" ImageUrl='<%# Eval("c_logo") %>' CssClass="lh-comp-logo" />
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <h2 class="lh-brand-name"><asp:Label ID="lblCompanyName" runat="server"></asp:Label></h2>
                        <p class="lh-brand-sub">Internship &amp; Talent Acquisition Division</p>
                    </div>
                    <div class="lh-company-meta">
                        <div><asp:Label ID="lblCompanyLocation" runat="server"></asp:Label></div>
                        <div><asp:Label ID="lblCompanyEmail" runat="server"></asp:Label></div>
                        <div><asp:Label ID="lblCompanyPhone" runat="server"></asp:Label></div>
                        <div id="pnlCompanyWeb" runat="server"><asp:Label ID="lblCompanyWebsite" runat="server"></asp:Label></div>
                    </div>
                </div>

                <!-- Date & Reference -->
                <div class="lh-date-ref">
                    <span>REF: <asp:Label ID="lblOfferRef" runat="server"></asp:Label></span>
                    <span>Date: <asp:Label ID="lblIssuedDate" runat="server"></asp:Label></span>
                </div>

                <!-- Candidate Details -->
                <div class="lh-recipient-box">
                    <p class="to-label">To,</p>
                    <p class="cand-name"><asp:Label ID="lblStudentName" runat="server"></asp:Label></p>
                    <p class="cand-college"><asp:Label ID="lblCollege" runat="server"></asp:Label></p>
                </div>

                <!-- Subject -->
                <div class="lh-subject">
                    Subject: Formal Internship Offer Letter - <span class="subject-role"><asp:Label ID="lblOfferTitle" runat="server"></asp:Label></span>
                </div>

                <!-- Letter Body -->
                <p class="letter-body-p">
                    Dear <strong><asp:Label ID="lblCandidateFirst" runat="server"></asp:Label></strong>,
                </p>

                <p class="letter-body-p">
                    On behalf of <strong><asp:Label ID="lblCompanyBody" runat="server"></asp:Label></strong>, we are pleased to offer you an internship position as <strong class="subject-role"><asp:Label ID="lblPosition" runat="server"></asp:Label></strong>. We were very impressed by your qualifications and performance during the selection process.
                </p>

                <!-- Offer Details -->
                <table class="lh-terms-table">
                    <tr>
                        <th>Position / Role</th>
                        <td><asp:Label ID="lblInternshipRole" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Internship Duration</th>
                        <td><asp:Label ID="lblDuration" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Monthly Stipend</th>
                        <td class="stipend-green"><asp:Label ID="lblStipend" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Expected Joining Date</th>
                        <td><asp:Label ID="lblJoiningDate" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Work Location / Mode</th>
                        <td><asp:Label ID="lblWorkLocation" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <th>Offer Acceptance Deadline</th>
                        <td><asp:Label ID="lblValidTill" runat="server"></asp:Label></td>
                    </tr>
                </table>

                <p class="confirm-notice">
                    Please confirm your acceptance of this offer by signing and returning a copy of this letter or confirming directly on the portal before the acceptance deadline.
                </p>

                <!-- Signatory -->
                <div class="lh-sign-section">
                    <div>
                        <div class="signatory-hr"><asp:Label ID="lblSignatoryName" runat="server"></asp:Label></div>
                        <div class="signatory-meta">Authorized Signatory &bull; <asp:Label ID="lblCompanySign" runat="server"></asp:Label></div>
                    </div>
                    <div class="lh-seal-badge">
                        <i class="fa-solid fa-certificate"></i> Official Verified Offer
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Title="Certificates & Documents" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-certificates.aspx.cs" Inherits="asp.net.student_certificates" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-certificates.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="scert-u1">
        <div class="page-header-box">
            <div class="page-title">
                <h1><i class="fa-solid fa-award scert-u2"></i> Certificates &amp; Documents</h1>
                <p>View, download, and print your verified internship completion certificates.</p>
            </div>
        </div>
        <!-- Top Stats Row -->
        <div class="task-stats-grid">
            <div class="stat-card-task">
                <div class="stat-icon-task scert-u3">
                    <i class="fa-solid fa-award"></i>
                </div>
                <div>
                    <div class="scert-u4"><asp:Label ID="lblTotalCerts" runat="server">0</asp:Label></div>
                    <div class="scert-u5">Total Certificates</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task scert-u6">
                    <i class="fa-solid fa-shield-halved"></i>
                </div>
                <div>
                    <div class="scert-u4"><asp:Label ID="lblVerifiedCerts" runat="server">0</asp:Label></div>
                    <div class="scert-u5">Verified &amp; Active</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task scert-u7">
                    <i class="fa-solid fa-building"></i>
                </div>
                <div>
                    <div class="scert-u4"><asp:Label ID="lblCompaniesCount" runat="server">0</asp:Label></div>
                    <div class="scert-u5">Partner Companies</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task scert-u8">
                    <i class="fa-regular fa-calendar-check"></i>
                </div>
                <div>
                    <div class="scert-u9"><asp:Label ID="lblLatestDate" runat="server">-</asp:Label></div>
                    <div class="scert-u5">Latest Issue Date</div>
                </div>
            </div>
        </div>
        <asp:DataList ID="dlCertificates" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="doc-cards-grid" OnItemCommand="dlCertificates_ItemCommand">
            <ItemTemplate>
                <div class="doc-card">
                    <div>
                        <div class="doc-top">
                            <div class="doc-brand-wrap">
                                <div class="doc-icon-wrap">
                                    <i class="fa-solid fa-award"></i>
                                </div>
                                <div>
                                    <h3 class="doc-title"><%# Eval("CertificateTitle") %></h3>
                                    <div class="doc-meta">
                                        <i class="fa-solid fa-building scert-u2"></i> <%# Eval("c_company") %>
                                        <%# Eval("c_location") != null && !string.IsNullOrEmpty(Eval("c_location").ToString()) ? "<span class='scert-dot'>&bull;</span> <span class='scert-loc-text'>" + Eval("c_location") + "</span>" : "" %>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <%# GetStudentStatusBadge(Eval("Status")) %>
                            </div>
                        </div>
                        <!-- Certificate Info Box -->
                        <div class="cert-info-box">
                            <div class="cert-info-role-row">
                                <span class="cert-info-role-lbl"><i class="fa-solid fa-user-tie scert-u10"></i> Role:</span>
                                <span class="cert-info-role-val"><%# Eval("RoleName") %></span>
                            </div>
                            <div class="cert-info-subgrid">
                                <div class="cert-subgrid-cell">
                                    <span class="cert-subgrid-lbl"><i class="fa-regular fa-clock scert-u11"></i> Duration</span>
                                    <span class="cert-subgrid-val"><%# Eval("CertDuration") %></span>
                                </div>
                                <div class="cert-subgrid-cell">
                                    <span class="cert-subgrid-lbl"><i class="fa-regular fa-calendar-check scert-u12"></i> Issued Date</span>
                                    <span class="cert-subgrid-val"><%# FormatDate(Eval("IssueDate")) %></span>
                                </div>
                                <div class="cert-subgrid-cell scert-u13">
                                    <span class="cert-subgrid-lbl"><i class="fa-solid fa-star scert-u14"></i> Performance Rating</span>
                                    <span class="cert-subgrid-val perf"><%# Eval("Performance") != null && !string.IsNullOrEmpty(Eval("Performance").ToString()) ? Eval("Performance") : "Outstanding Performance & Dedication" %></span>
                                </div>
                            </div>
                        </div>
                        <!-- Credentials Monospace Bar -->
                        <div class="cert-cred-bar">
                            <div>
                                <span class="scert-u15">CERT NO:</span>
                                <span class="cert-code-pill scert-u16"><%# Eval("CertificateNo") %></span>
                            </div>
                            <div>
                                <span class="scert-u15">VERIFY:</span>
                                <span class="cert-code-pill scert-u17"><%# Eval("VerificationCode") %></span>
                            </div>
                        </div>
                    </div>
                    <div class="doc-btn-group">
                        <asp:ImageButton ID="btnViewCertificate" runat="server" 
                                         ImageUrl="~/assets/btn_view_print_cert.png" 
                                         CommandName="cmd_view" 
                                         CommandArgument='<%# Eval("CertificateId") %>' 
                                         Height="44" 
                                         CssClass="student-img-btn doc-action-img-btn" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:PlaceHolder ID="pnlNoCerts" runat="server" Visible="false">
            <div class="scert-u18">
                <i class="fa-solid fa-award scert-u19"></i>
                <h3 class="scert-u20">No Certificates Issued Yet</h3>
                <p class="scert-u21">Upon successful completion of your internships, your verified certificates will appear here.</p>
                <asp:ImageButton ID="btnBrowseInternships" runat="server" 
                                 ImageUrl="~/assets/btn_browse_internships.png" 
                                 PostBackUrl="~/StudentPanel/student-internships.aspx" 
                                 Height="44" 
                                 CssClass="student-img-btn" />
            </div>
        </asp:PlaceHolder>
    </div>
</asp:Content>
<asp:Content ID="ScriptContent_scert" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="../js/student-certificates.js"></script>
</asp:Content>

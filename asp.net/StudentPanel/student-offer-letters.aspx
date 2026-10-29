<%@ Page Title="Offer Letters" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-offer-letters.aspx.cs" Inherits="asp.net.student_offer_letters" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-offer-letters.css" />
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div  class="soff-u1">
        <!-- Page Header -->
        <div class="page-header-box">
            <div class="page-title">
                <h1><i class="fa-solid fa-file-signature soff-u2" ></i> Offer Letters</h1>
                <p>Congratulations! Review, accept, and print your official internship offer letters issued by companies.</p>
            </div>
        </div>
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        <!-- Stats Grid -->
        <div class="offer-stats-grid">
            <div class="stat-card-task">
                <div class="stat-icon-task soff-u3" >
                    <i class="fa-solid fa-file-signature"></i>
                </div>
                <div>
                    <div  class="soff-u4"><asp:Label ID="lblTotalOffers" runat="server">0</asp:Label></div>
                    <div  class="soff-u5">Total Offer Letters</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task soff-u6" >
                    <i class="fa-solid fa-clock"></i>
                </div>
                <div>
                    <div  class="soff-u4"><asp:Label ID="lblPendingOffers" runat="server">0</asp:Label></div>
                    <div  class="soff-u5">Action Pending</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task soff-u7" >
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div>
                    <div  class="soff-u4"><asp:Label ID="lblAcceptedOffers" runat="server">0</asp:Label></div>
                    <div  class="soff-u5">Offers Accepted</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task soff-u8" >
                    <i class="fa-solid fa-building"></i>
                </div>
                <div>
                    <div  class="soff-u4"><asp:Label ID="lblCompaniesCount" runat="server">0</asp:Label></div>
                    <div  class="soff-u5">Partner Companies</div>
                </div>
            </div>
        </div>
        <asp:DataList ID="dlOffers" runat="server" RepeatLayout="Flow" CssClass="offer-cards-grid" OnItemCommand="dlOffers_ItemCommand">
            <ItemTemplate>
                <div class="offer-box-card">
                    <div>
                        <!-- Top Row: Date Badge + Status Badge -->
                        <div class="offer-card-top">
                            <div class="offer-date-badge">
                                <span class="day"><%# FormatDay(Eval("IssuedDateDisplay")) %></span>
                                <span class="mon"><%# FormatMonth(Eval("IssuedDateDisplay")) %></span>
                            </div>
                            <div>
                                <%# GetOfferStatusBadge(Eval("Status")) %>
                            </div>
                        </div>
                        <!-- Company Header & Avatar -->
                        <div class="offer-company-header">
                            <div class="offer-company-avatar">
                                <%# FormatCompanyLogo(Eval("c_logo"), Eval("c_company")) %>
                            </div>
                            <div  class="soff-u9">
                                <h3 class="offer-company-name"><%# Eval("c_company") %></h3>
                                <p class="offer-company-loc">
                                    <i class="fa-solid fa-location-dot soff-u2" ></i>
                                    <%# Eval("c_location") != null && !string.IsNullOrEmpty(Eval("c_location").ToString()) ? Eval("c_location") : "Headquarters" %>
                                </p>
                            </div>
                        </div>
                        <!-- Applied Role Badge -->
                        <div class="offer-role-badge">
                            <i class="fa-solid fa-briefcase soff-u10" ></i>
                            <span><%# Eval("OfferTitle") %></span>
                        </div>
                        <!-- Offer Details Box -->
                        <div class="offer-card-details">
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-solid fa-indian-rupee-sign soff-u11" ></i> Stipend:</span>
                                <span class="detail-val"><%# FormatStipend(Eval("Stipend")) %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-regular fa-calendar-check soff-u12" ></i> Joining:</span>
                                <span class="detail-val"><%# FormatJoining(Eval("JoiningDate")) %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-regular fa-hourglass-half soff-u13" ></i> Duration:</span>
                                <span class="detail-val"><%# Eval("Duration") %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-solid fa-map-pin soff-u14" ></i> Location:</span>
                                <span class="detail-val"><%# Eval("JobLocation") %></span>
                            </div>
                        </div>
                    </div>
                    <!-- Bottom Action Buttons -->
                    <div class="offer-card-actions">
                        <button type="button" class="btn-action-primary soff-u15" 
                                onclick='openStudentLetterModal("<%# Eval("c_company") %>", "<%# Eval("c_location") %>", "<%# Eval("CompEmail") %>", "<%# Eval("CompContact") %>", "<%# Eval("c_website") %>", "<%# GetResolvedLogoUrl(Eval("c_logo")) %>", "<%# Eval("FullName") %>", "<%# Eval("StudentEmail") %>", "<%# Eval("College") %>", "<%# Eval("OfferTitle") %>", "<%# Eval("Stipend") %>", "<%# Eval("JoiningDate") %>", "<%# Eval("Duration") %>", "<%# Eval("JobLocation") %>", "<%# Eval("OfferId") %>", "<%# FormatDate(Eval("IssuedDateDisplay")) %>", "<%# Eval("c_hr_name") %>");'>
                            <i class="fa-solid fa-file-pdf"></i> View &amp; Print Letter
                        </button>
                        <asp:PlaceHolder ID="phActionButtons" runat="server" Visible='<%# IsPending(Eval("Status")) %>'>
                            <div  class="soff-u16">
                                <asp:LinkButton ID="btnAccept" runat="server" CommandName="AcceptOffer" CommandArgument='<%# Eval("OfferId") %>' CssClass="btn-action-accept soff-btn-flex">
                                    <i class="fa-solid fa-check"></i> Accept
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDecline" runat="server" CommandName="DeclineOffer" CommandArgument='<%# Eval("OfferId") %>' CssClass="btn-action-decline soff-btn-flex" OnClientClick="return confirm('Are you sure you want to decline this internship offer?');">
                                    <i class="fa-solid fa-xmark"></i> Decline
                                </asp:LinkButton>
                            </div>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="phAccepted" runat="server" Visible='<%# IsAccepted(Eval("Status")) %>'>
                            <div class="badge-accepted-pill soff-u17" >
                                <i class="fa-solid fa-circle-check"></i> Offer Accepted
                            </div>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="phDeclined" runat="server" Visible='<%# IsDeclined(Eval("Status")) %>'>
                            <div class="badge-declined-pill soff-u17" >
                                <i class="fa-solid fa-circle-xmark"></i> Offer Declined
                            </div>
                        </asp:PlaceHolder>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:PlaceHolder ID="pnlNoOffers" runat="server" Visible="false">
            <div  class="soff-u18">
                <div  class="soff-u19">
                    <i class="fa-solid fa-file-circle-xmark"></i>
                </div>
                <h3  class="soff-u20">No Offer Letters Issued Yet</h3>
                <p  class="soff-u21">When companies review and select your application, your official verified internship offer letters will appear here.</p>
                <asp:HyperLink ID="hlBrowse" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-action-primary soff-u22" >
                    <i class="fa-solid fa-briefcase"></i> Explore Available Internships
                </asp:HyperLink>
            </div>
        </asp:PlaceHolder>
    </div>
    <!-- ================= FULLSCREEN PRINT / VIEW MODAL FOR STUDENT ================= -->
    <div class="print-modal-overlay" id="studentPrintModal" onclick="closeStudentModal(event);">
        <div class="print-modal-container" onclick="event.stopPropagation();">
            <div class="print-modal-bar">
                <div  class="soff-u23">
                    <i class="fa-solid fa-file-signature soff-u2" ></i> Official Internship Offer Letter
                </div>
                <div  class="soff-u24">
                    <button type="button" class="btn-print-btn" onclick="window.print();">
                        <i class="fa-solid fa-print"></i> Print / Save PDF
                    </button>
                    <button type="button" class="btn-close-modal" onclick="closeStudentModal();">&times;</button>
                </div>
            </div>
            <div  class="soff-u25">
                <div class="letterhead-doc soff-u26" id="printableLetterhead" >
                    <!-- Company Header -->
                    <div class="lh-company-header">
                        <div>
                            <div id="sModalLogoWrap"  class="soff-u27">
                                <div id="sModalLogoIcon"  class="soff-u28">
                                    <i class="fa-solid fa-building soff-u29" ></i>
                                </div>
                                <img id="sModalCompLogo" src=""   class="soff-u30" />
                            </div>
                            <h2 class="lh-brand-name" id="sModalCompName">Company Name</h2>
                            <p class="lh-brand-sub">Internship &amp; Talent Acquisition Division</p>
                        </div>
                        <div class="lh-company-meta">
                            <div id="sModalCompLoc">City, State</div>
                            <div id="sModalCompEmail">hr@company.com</div>
                            <div id="sModalCompPhone">+91 98765 43210</div>
                            <div id="sModalCompWeb"  class="soff-u31"></div>
                        </div>
                    </div>
                    <!-- Date & Ref -->
                    <div class="lh-date-ref">
                        <span>REF: <%= DateTime.Now.Year %>/OFFER/<span id="sModalRef">001</span></span>
                        <span>Date: <span id="sModalOfferDate"><%= DateTime.Now.ToString("dd MMMM yyyy") %></span></span>
                    </div>
                    <!-- Candidate To Box -->
                    <div class="lh-recipient-box">
                        <p  class="soff-u32">To,</p>
                        <p  id="sModalCandName" class="soff-u33">[Candidate Name]</p>
                        <p id="sModalCandCollege">[Candidate College]</p>
                    </div>
                    <!-- Subject -->
                    <div class="lh-subject">
                        Subject: Formal Internship Offer Letter - <span id="sModalSubjectRole"  class="soff-u12">[Role]</span>
                    </div>
                    <!-- Letter Body -->
                    <p  class="soff-u34">
                        Dear <strong id="sModalSalutation">[Candidate Name]</strong>,
                    </p>
                    <p  class="soff-u34">
                        On behalf of <strong id="sModalBodyComp">Company Name</strong>, we are pleased to offer you an internship position as <strong id="sModalBodyRole"  class="soff-u12">[Role]</strong>. We were very impressed by your qualifications and performance during the selection process.
                    </p>
                    <!-- Offer Terms Matrix Table (All 6 Rows) -->
                    <table class="lh-terms-table">
                        <tr>
                            <th>Position / Role</th>
                            <td id="sModalTableRole">[Role]</td>
                        </tr>
                        <tr>
                            <th>Internship Duration</th>
                            <td id="sModalTableDuration">3 Months</td>
                        </tr>
                        <tr>
                            <th>Monthly Stipend</th>
                            <td id="sModalTableStipend"  class="soff-u35">[Stipend]</td>
                        </tr>
                        <tr>
                            <th>Expected Joining Date</th>
                            <td id="sModalTableJoining">[Joining Date]</td>
                        </tr>
                        <tr>
                            <th>Work Location / Mode</th>
                            <td id="sModalTableLoc">[Location]</td>
                        </tr>
                        <tr>
                            <th>Offer Acceptance Deadline</th>
                            <td id="sModalTableValidTill">[Valid Till]</td>
                        </tr>
                    </table>
                    <p  class="soff-u36">
                        Please confirm your acceptance of this offer by signing and returning a copy of this letter or confirming directly on the portal before the acceptance deadline.
                    </p>
                    <!-- Signatory Section -->
                    <div class="lh-sign-section">
                        <div>
                            <div  id="sModalHrName" class="soff-u32">HR &amp; Talent Team</div>
                            <div  class="soff-u37">Authorized Signatory &bull; <span id="sModalSignCompName">Company</span></div>
                        </div>
                        <div class="lh-seal-badge">
                            <i class="fa-solid fa-certificate"></i> Official Verified Offer
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </asp:Content>
<asp:Content ID="ScriptContent_soff" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="../js/student-offer-letters.js"></script>
</asp:Content>

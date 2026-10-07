<%@ Page Title="Offer Letters" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-offer-letters.aspx.cs" Inherits="asp.net.student_offer_letters" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 24px;
        }
        .page-title h1 {
            font-size: 24px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 4px 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .page-title p {
            font-size: 14px;
            color: #64748b;
            margin: 0;
        }
        /* Stats Grid */
        .offer-stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin-bottom: 28px;
        }
        .stat-card-task {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 18px;
            padding: 18px 20px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 4px 12px rgba(15,23,42,0.03);
            transition: all 0.2s;
        }
        .stat-card-task:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.06);
        }
        .stat-icon-task {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            flex-shrink: 0;
        }
        /* 3 Columns in 1 Row Grid for Offers */
        .offer-cards-grid {
            display: grid !important;
            grid-template-columns: repeat(3, 1fr) !important;
            gap: 22px !important;
            width: 100% !important;
        }
        .offer-cards-grid br {
            display: none !important;
        }
        .offer-cards-grid > span,
        .offer-cards-grid > div {
            display: block !important;
            width: 100% !important;
            min-width: 0 !important;
            height: 100% !important;
        }
        @media (max-width: 1100px) {
            .offer-cards-grid {
                grid-template-columns: repeat(2, 1fr) !important;
            }
        }
        @media (max-width: 700px) {
            .offer-cards-grid {
                grid-template-columns: 1fr !important;
            }
        }
        .offer-box-card {
            background: #ffffff;
            border: 1.5px solid #e2e8f0;
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 4px 14px rgba(15, 23, 42, 0.03);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
            box-sizing: border-box;
            position: relative;
        }
        .offer-box-card:hover {
            border-color: #cbd5e1;
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.08);
        }
        .offer-card-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
            padding-bottom: 12px;
            border-bottom: 1px solid #f1f5f9;
        }
        .offer-date-badge {
            width: 50px;
            height: 52px;
            background: #eff6ff;
            border: 1.5px solid #bfdbfe;
            border-radius: 12px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .offer-date-badge .day {
            font-size: 18px;
            font-weight: 800;
            color: #2563eb;
            line-height: 1;
        }
        .offer-date-badge .mon {
            font-size: 10px;
            font-weight: 800;
            color: #64748b;
            text-transform: uppercase;
            margin-top: 2px;
            letter-spacing: 0.5px;
        }
        .offer-company-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 12px;
        }
        .offer-company-avatar {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            background: linear-gradient(135deg, #eff6ff, #dbeafe);
            color: #2563eb;
            border: 1px solid #bfdbfe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 15px;
            flex-shrink: 0;
        }
        .offer-company-avatar img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            border-radius: 12px;
        }
        .offer-company-name {
            font-size: 15.5px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 2px 0;
            line-height: 1.3;
        }
        .offer-company-loc {
            font-size: 12px;
            color: #64748b;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 4px;
        }
        .offer-role-badge {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 8px 12px;
            font-size: 13px;
            font-weight: 700;
            color: #1e293b;
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 14px;
        }
        .offer-card-details {
            display: flex;
            flex-direction: column;
            gap: 9px;
            flex: 1;
            margin-bottom: 16px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 12px;
            padding: 12px 14px;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 12.5px;
        }
        .detail-label {
            color: #64748b;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .detail-val {
            color: #0f172a;
            font-weight: 700;
            text-align: right;
        }
        .offer-card-actions {
            border-top: 1px solid #f1f5f9;
            padding-top: 14px;
            margin-top: auto;
        }
        .btn-action-primary {
            padding: 10px 18px;
            background: linear-gradient(135deg, #2563eb 0%, #1d4ed8 100%);
            color: #ffffff !important;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(37,99,235,0.22);
            transition: all 0.2s cubic-bezier(0.16, 1, 0.3, 1);
            box-sizing: border-box;
        }
        .btn-action-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(37,99,235,0.32);
            color: #ffffff !important;
        }
        .btn-action-accept {
            padding: 9px 14px;
            background: #f0fdf4;
            color: #15803d !important;
            border: 1.5px solid #86efac;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            transition: all 0.2s;
            box-sizing: border-box;
        }
        .btn-action-accept:hover {
            background: #16a34a;
            color: #ffffff !important;
            border-color: #16a34a;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(22,163,74,0.25);
        }
        .btn-action-decline {
            padding: 9px 14px;
            background: #fef2f2;
            color: #dc2626 !important;
            border: 1.5px solid #fecaca;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;
            transition: all 0.2s;
            box-sizing: border-box;
        }
        .btn-action-decline:hover {
            background: #dc2626;
            color: #ffffff !important;
            border-color: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(220,38,38,0.25);
        }
        .badge-accepted-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 16px;
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
        }
        .badge-declined-pill {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 16px;
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
        }
        /* Fullscreen View / Print Modal */
        .print-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(15, 23, 42, 0.6);
            backdrop-filter: blur(4px);
            z-index: 1050;
            display: none;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .print-modal-container {
            background: #f8fafc;
            width: 100%;
            max-width: 800px;
            max-height: 90vh;
            border-radius: 16px;
            overflow-y: auto;
            box-shadow: 0 20px 40px rgba(0,0,0,0.25);
            display: flex;
            flex-direction: column;
        }
        .print-modal-bar {
            padding: 14px 24px;
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        .btn-print-btn {
            padding: 8px 16px;
            background: #2563eb;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-print-btn:hover {
            background: #1d4ed8;
        }
        .btn-close-modal {
            background: none;
            border: none;
            font-size: 22px;
            color: #64748b;
            cursor: pointer;
        }
        .btn-close-modal:hover {
            color: #0f172a;
        }
        /* Letterhead styling */
        .letterhead-doc {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            padding: 36px 40px;
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            color: #1e293b;
            font-size: 13px;
            line-height: 1.6;
        }
        .lh-company-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            border-bottom: 2px solid #2563eb;
            padding-bottom: 14px;
            margin-bottom: 18px;
        }
        .lh-brand-name {
            font-size: 20px;
            font-weight: 800;
            color: #0f172a;
            margin: 0 0 3px 0;
        }
        .lh-brand-sub {
            font-size: 11.5px;
            color: #64748b;
            margin: 0;
        }
        .lh-company-meta {
            text-align: right;
            font-size: 11.5px;
            color: #475569;
            line-height: 1.4;
        }
        .lh-date-ref {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            color: #64748b;
            margin-bottom: 16px;
            font-weight: 600;
        }
        .lh-recipient-box {
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 10px 14px;
            margin-bottom: 16px;
        }
        .lh-recipient-box p {
            margin: 0;
            font-size: 12.5px;
            color: #334155;
        }
        .lh-subject {
            font-size: 13.5px;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 12px;
            padding-bottom: 4px;
            border-bottom: 1px dashed #cbd5e1;
        }
        .lh-terms-table {
            width: 100%;
            border-collapse: collapse;
            margin: 14px 0;
            font-size: 12px;
            border: 1px solid #e2e8f0;
            border-radius: 6px;
            overflow: hidden;
        }
        .lh-terms-table th {
            background: #f1f5f9;
            padding: 8px 12px;
            font-weight: 600;
            color: #475569;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
            width: 35%;
        }
        .lh-terms-table td {
            background: #ffffff;
            padding: 8px 12px;
            font-weight: 600;
            color: #0f172a;
            border-bottom: 1px solid #e2e8f0;
        }
        .lh-sign-section {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-top: 24px;
            padding-top: 14px;
            border-top: 1px solid #f1f5f9;
        }
        .lh-seal-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border: 1.5px dashed #2563eb;
            border-radius: 8px;
            color: #2563eb;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }
        @media print {
            body * {
                visibility: hidden;
            }
            #printableLetterhead, #printableLetterhead * {
                visibility: visible;
            }
            #printableLetterhead {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                box-shadow: none !important;
                border: none !important;
                padding: 0 !important;
            }
            .print-modal-bar, .student-sidebar, .student-topbar, .btn-print-btn, .btn-close-modal {
                display: none !important;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0 40px 0;">
        <!-- Page Header -->
        <div class="page-header-box">
            <div class="page-title">
                <h1><i class="fa-solid fa-file-signature" style="color:#2563eb;"></i> Offer Letters</h1>
                <p>Congratulations! Review, accept, and print your official internship offer letters issued by companies.</p>
            </div>
        </div>
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        <!-- Stats Grid -->
        <div class="offer-stats-grid">
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #eff6ff; color: #2563eb;">
                    <i class="fa-solid fa-file-signature"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblTotalOffers" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Total Offer Letters</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #eff6ff; color: #1d4ed8;">
                    <i class="fa-solid fa-clock"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblPendingOffers" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Action Pending</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #f0fdf4; color: #16a34a;">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblAcceptedOffers" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Offers Accepted</div>
                </div>
            </div>
            <div class="stat-card-task">
                <div class="stat-icon-task" style="background: #fdf4ff; color: #c026d3;">
                    <i class="fa-solid fa-building"></i>
                </div>
                <div>
                    <div style="font-size: 20px; font-weight: 800; color: #0f172a;"><asp:Label ID="lblCompaniesCount" runat="server">0</asp:Label></div>
                    <div style="font-size: 13px; color: #64748b;">Partner Companies</div>
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
                            <div style="min-width: 0; flex: 1;">
                                <h3 class="offer-company-name"><%# Eval("c_company") %></h3>
                                <p class="offer-company-loc">
                                    <i class="fa-solid fa-location-dot" style="color:#2563eb;"></i>
                                    <%# Eval("c_location") != null && !string.IsNullOrEmpty(Eval("c_location").ToString()) ? Eval("c_location") : "Headquarters" %>
                                </p>
                            </div>
                        </div>
                        <!-- Applied Role Badge -->
                        <div class="offer-role-badge">
                            <i class="fa-solid fa-briefcase" style="color: #2563eb; font-size: 12px;"></i>
                            <span><%# Eval("OfferTitle") %></span>
                        </div>
                        <!-- Offer Details Box -->
                        <div class="offer-card-details">
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-solid fa-indian-rupee-sign" style="color: #15803d;"></i> Stipend:</span>
                                <span class="detail-val"><%# FormatStipend(Eval("Stipend")) %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-regular fa-calendar-check" style="color: #2563eb;"></i> Joining:</span>
                                <span class="detail-val"><%# FormatJoining(Eval("JoiningDate")) %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-regular fa-hourglass-half" style="color: #f59e0b;"></i> Duration:</span>
                                <span class="detail-val"><%# Eval("Duration") %></span>
                            </div>
                            <div class="detail-row">
                                <span class="detail-label"><i class="fa-solid fa-map-pin" style="color: #7c3aed;"></i> Location:</span>
                                <span class="detail-val"><%# Eval("JobLocation") %></span>
                            </div>
                        </div>
                    </div>
                    <!-- Bottom Action Buttons -->
                    <div class="offer-card-actions">
                        <button type="button" class="btn-action-primary" style="width:100%; margin-bottom: 8px;"
                                onclick='openStudentLetterModal("<%# Eval("c_company") %>", "<%# Eval("c_location") %>", "<%# Eval("CompEmail") %>", "<%# Eval("CompContact") %>", "<%# Eval("c_website") %>", "<%# GetResolvedLogoUrl(Eval("c_logo")) %>", "<%# Eval("FullName") %>", "<%# Eval("StudentEmail") %>", "<%# Eval("College") %>", "<%# Eval("OfferTitle") %>", "<%# Eval("Stipend") %>", "<%# Eval("JoiningDate") %>", "<%# Eval("Duration") %>", "<%# Eval("JobLocation") %>", "<%# Eval("OfferId") %>", "<%# FormatDate(Eval("IssuedDateDisplay")) %>", "<%# Eval("c_hr_name") %>");'>
                            <i class="fa-solid fa-file-pdf"></i> View &amp; Print Letter
                        </button>
                        <asp:PlaceHolder ID="phActionButtons" runat="server" Visible='<%# IsPending(Eval("Status")) %>'>
                            <div style="display:flex; gap:8px;">
                                <asp:LinkButton ID="btnAccept" runat="server" CommandName="AcceptOffer" CommandArgument='<%# Eval("OfferId") %>' CssClass="btn-action-accept" Style="flex:1; justify-content:center;">
                                    <i class="fa-solid fa-check"></i> Accept
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDecline" runat="server" CommandName="DeclineOffer" CommandArgument='<%# Eval("OfferId") %>' CssClass="btn-action-decline" Style="flex:1; justify-content:center;" OnClientClick="return confirm('Are you sure you want to decline this internship offer?');">
                                    <i class="fa-solid fa-xmark"></i> Decline
                                </asp:LinkButton>
                            </div>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="phAccepted" runat="server" Visible='<%# IsAccepted(Eval("Status")) %>'>
                            <div class="badge-accepted-pill" style="width:100%; justify-content:center; box-sizing:border-box;">
                                <i class="fa-solid fa-circle-check"></i> Offer Accepted
                            </div>
                        </asp:PlaceHolder>
                        <asp:PlaceHolder ID="phDeclined" runat="server" Visible='<%# IsDeclined(Eval("Status")) %>'>
                            <div class="badge-declined-pill" style="width:100%; justify-content:center; box-sizing:border-box;">
                                <i class="fa-solid fa-circle-xmark"></i> Offer Declined
                            </div>
                        </asp:PlaceHolder>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:PlaceHolder ID="pnlNoOffers" runat="server" Visible="false">
            <div style="text-align:center; padding: 60px 20px; background:#fff; border-radius:18px; border:1px solid #e2e8f0; box-shadow: 0 4px 12px rgba(15,23,42,0.02);">
                <div style="width:68px; height:68px; background:#eff6ff; color:#2563eb; border-radius:50%; display:inline-flex; align-items:center; justify-content:center; font-size:28px; margin-bottom:16px;">
                    <i class="fa-solid fa-file-circle-xmark"></i>
                </div>
                <h3 style="font-size: 18px; font-weight:800; color: #0f172a; margin-bottom: 8px;">No Offer Letters Issued Yet</h3>
                <p style="font-size: 14px; color: #64748b; margin-bottom: 22px; max-width:480px; margin-left:auto; margin-right:auto;">When companies review and select your application, your official verified internship offer letters will appear here.</p>
                <asp:HyperLink ID="hlBrowse" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-action-primary" Style="width:auto; padding:12px 24px; display:inline-flex;">
                    <i class="fa-solid fa-briefcase"></i> Explore Available Internships
                </asp:HyperLink>
            </div>
        </asp:PlaceHolder>
    </div>
    <!-- ================= FULLSCREEN PRINT / VIEW MODAL FOR STUDENT ================= -->
    <div class="print-modal-overlay" id="studentPrintModal" onclick="closeStudentModal(event);">
        <div class="print-modal-container" onclick="event.stopPropagation();">
            <div class="print-modal-bar">
                <div style="font-weight:700; color:#0f172a; font-size:15px;">
                    <i class="fa-solid fa-file-signature" style="color:#2563eb;"></i> Official Internship Offer Letter
                </div>
                <div style="display:flex; gap:10px; align-items:center;">
                    <button type="button" class="btn-print-btn" onclick="window.print();">
                        <i class="fa-solid fa-print"></i> Print / Save PDF
                    </button>
                    <button type="button" class="btn-close-modal" onclick="closeStudentModal();">&times;</button>
                </div>
            </div>
            <div style="padding: 24px;">
                <div class="letterhead-doc" id="printableLetterhead" style="background:#fff; border:1px solid #e2e8f0; border-radius:10px; padding:32px 36px;">
                    <!-- Company Header -->
                    <div class="lh-company-header">
                        <div>
                            <div id="sModalLogoWrap" style="display:flex; align-items:center; gap:10px; margin-bottom:6px;">
                                <div id="sModalLogoIcon" style="width:38px; height:38px; border-radius:10px; background: linear-gradient(135deg,#1e3a8a,#2563eb); display:flex; align-items:center; justify-content:center; flex-shrink:0;">
                                    <i class="fa-solid fa-building" style="color:#fff; font-size:16px;"></i>
                                </div>
                                <img id="sModalCompLogo" src="" alt="" style="height: 38px; max-width: 140px; object-fit: contain; display: none; border-radius:6px;" />
                            </div>
                            <h2 class="lh-brand-name" id="sModalCompName">Company Name</h2>
                            <p class="lh-brand-sub">Internship &amp; Talent Acquisition Division</p>
                        </div>
                        <div class="lh-company-meta">
                            <div id="sModalCompLoc">City, State</div>
                            <div id="sModalCompEmail">hr@company.com</div>
                            <div id="sModalCompPhone">+91 98765 43210</div>
                            <div id="sModalCompWeb" style="display:none;"></div>
                        </div>
                    </div>
                    <!-- Date & Ref -->
                    <div class="lh-date-ref">
                        <span>REF: <%= DateTime.Now.Year %>/OFFER/<span id="sModalRef">001</span></span>
                        <span>Date: <span id="sModalOfferDate"><%= DateTime.Now.ToString("dd MMMM yyyy") %></span></span>
                    </div>
                    <!-- Candidate To Box -->
                    <div class="lh-recipient-box">
                        <p style="font-weight: 700; color: #0f172a;">To,</p>
                        <p style="font-weight: 700; color: #2563eb; font-size: 13.5px;" id="sModalCandName">[Candidate Name]</p>
                        <p id="sModalCandCollege">[Candidate College]</p>
                    </div>
                    <!-- Subject -->
                    <div class="lh-subject">
                        Subject: Formal Internship Offer Letter - <span id="sModalSubjectRole" style="color: #2563eb;">[Role]</span>
                    </div>
                    <!-- Letter Body -->
                    <p style="margin-bottom: 10px;">
                        Dear <strong id="sModalSalutation">[Candidate Name]</strong>,
                    </p>
                    <p style="margin-bottom: 10px;">
                        On behalf of <strong id="sModalBodyComp">Company Name</strong>, we are pleased to offer you an internship position as <strong id="sModalBodyRole" style="color: #2563eb;">[Role]</strong>. We were very impressed by your qualifications and performance during the selection process.
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
                            <td id="sModalTableStipend" style="color: #15803d; font-weight:700;">[Stipend]</td>
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
                    <p style="margin-bottom: 14px; font-size: 12px; color: #475569;">
                        Please confirm your acceptance of this offer by signing and returning a copy of this letter or confirming directly on the portal before the acceptance deadline.
                    </p>
                    <!-- Signatory Section -->
                    <div class="lh-sign-section">
                        <div>
                            <div style="font-weight: 700; color: #0f172a;" id="sModalHrName">HR &amp; Talent Team</div>
                            <div style="font-size: 11.5px; color: #64748b;">Authorized Signatory &bull; <span id="sModalSignCompName">Company</span></div>
                        </div>
                        <div class="lh-seal-badge">
                            <i class="fa-solid fa-certificate"></i> Official Verified Offer
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function openStudentLetterModal(comp, loc, email, phone, web, logo, name, candEmail, college, role, stipend, joining, duration, jobLoc, id, issuedDate, hr) {
            document.getElementById('sModalCompName').innerText = comp || 'Company';
            document.getElementById('sModalBodyComp').innerText = comp || 'Company';
            document.getElementById('sModalSignCompName').innerText = comp || 'Company';
            document.getElementById('sModalCompLoc').innerText = loc || '';
            document.getElementById('sModalCompEmail').innerText = email || '';
            document.getElementById('sModalCompPhone').innerText = phone || '';
            var webEl = document.getElementById('sModalCompWeb');
            if (web && web.trim() !== '') {
                webEl.innerText = web;
                webEl.style.display = 'block';
            } else {
                webEl.style.display = 'none';
            }
            var logoEl = document.getElementById('sModalCompLogo');
            var logoIcon = document.getElementById('sModalLogoIcon');
            var cleanLogo = (logo && logo.trim() !== '' && logo.trim() !== 'undefined' && logo.trim() !== 'null') ? logo.trim() : '';

            if (cleanLogo) {
                if (cleanLogo.startsWith('~/')) {
                    cleanLogo = cleanLogo.replace('~/', '/');
                } else if (!cleanLogo.startsWith('/') && !cleanLogo.startsWith('http://') && !cleanLogo.startsWith('https://')) {
                    cleanLogo = '/CompanyUploads/' + cleanLogo;
                }

                logoEl.src = cleanLogo;
                logoEl.style.display = 'block';
                logoIcon.style.display = 'none';

                logoEl.onerror = function () {
                    if (this.src.indexOf('/CompanyUploads/') !== -1) {
                        var fileName = this.src.substring(this.src.lastIndexOf('/') + 1);
                        this.onerror = function () {
                            if (this.src.indexOf('/uploads/company_logos/') !== -1) {
                                this.onerror = function () {
                                    logoEl.style.display = 'none';
                                    logoIcon.style.display = 'flex';
                                };
                                this.src = '/assets/' + fileName;
                            } else {
                                logoEl.style.display = 'none';
                                logoIcon.style.display = 'flex';
                            }
                        };
                        this.src = '/uploads/company_logos/' + fileName;
                    } else if (this.src.indexOf('/uploads/company_logos/') !== -1) {
                        var fileName = this.src.substring(this.src.lastIndexOf('/') + 1);
                        this.onerror = function () {
                            logoEl.style.display = 'none';
                            logoIcon.style.display = 'flex';
                        };
                        this.src = '/CompanyUploads/' + fileName;
                    } else {
                        logoEl.style.display = 'none';
                        logoIcon.style.display = 'flex';
                    }
                };
            } else {
                logoEl.style.display = 'none';
                logoIcon.style.display = 'flex';
            }
            document.getElementById('sModalRef').innerText = id || '001';
            if (issuedDate) {
                document.getElementById('sModalOfferDate').innerText = issuedDate;
            }
            document.getElementById('sModalCandName').innerText = name || 'Candidate';
            document.getElementById('sModalCandCollege').innerText = college || '';
            document.getElementById('sModalSubjectRole').innerText = role || 'Intern';
            document.getElementById('sModalSalutation').innerText = name || 'Candidate';
            document.getElementById('sModalBodyRole').innerText = role || 'Intern';
            document.getElementById('sModalTableRole').innerText = role || 'Intern';
            document.getElementById('sModalTableDuration').innerText = duration || '3 Months';
            var cleanStipend = (stipend || '').replace(/â,¹|â‚¹|\?|₹|Rs\.|INR/g, '').trim();
            var modalStipendHtml = 'Unpaid';
            if (cleanStipend) {
                if (!cleanStipend.toLowerCase().includes('month') && !cleanStipend.toLowerCase().includes('unpaid') && !cleanStipend.toLowerCase().includes('fixed')) {
                    cleanStipend = cleanStipend + ' / month';
                }
                modalStipendHtml = '<i class="fa-solid fa-indian-rupee-sign" style="font-size:12px; margin-right:3px;"></i> ' + cleanStipend;
            }
            document.getElementById('sModalTableStipend').innerHTML = modalStipendHtml;
            document.getElementById('sModalTableJoining').innerText = joining || '';
            document.getElementById('sModalTableLoc').innerText = jobLoc || loc || '';
            if (joining) {
                var jd = new Date(joining);
                if (!isNaN(jd.getTime())) {
                    var dl = new Date(jd.getTime() - (3 * 24 * 60 * 60 * 1000));
                    document.getElementById('sModalTableValidTill').innerText = dl.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
                } else {
                    document.getElementById('sModalTableValidTill').innerText = joining;
                }
            } else {
                document.getElementById('sModalTableValidTill').innerText = '<%= DateTime.Now.AddDays(14).ToString("dd MMM yyyy") %>';
            }
            document.getElementById('sModalHrName').innerText = hr || 'HR & Talent Team';
            document.getElementById('studentPrintModal').style.display = 'flex';
        }
        function closeStudentModal(e) {
            document.getElementById('studentPrintModal').style.display = 'none';
        }
    </script>
</asp:Content>

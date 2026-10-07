<%@ Page Title="Saved Internships" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-saved-internships.aspx.cs" Inherits="asp.net.student_saved_internships" %>
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
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 4px 0;
        }
        .page-title p {
            font-size: 14px;
            color: #64748b;
            margin: 0;
        }
        .saved-cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 22px;
            width: 100%;
        }
        .saved-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 22px;
            box-shadow: 0 4px 12px rgba(15,23,42,0.04);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.25s ease;
            position: relative;
        }
        .saved-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(37,99,235,0.1);
            border-color: #cbd5e1;
        }
        .card-top {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 16px;
        }
        .company-logo {
            width: 52px;
            height: 52px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e2e8f0;
            background: #f8fafc;
            flex-shrink: 0;
        }
        .card-title-wrap {
            overflow: hidden;
        }
        .card-title {
            font-size: 16.5px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .company-name {
            font-size: 13.5px;
            font-weight: 600;
            color: #2563eb;
            margin-top: 2px;
            display: block;
        }
        .card-info-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
            background: #f8fafc;
            padding: 12px 14px;
            border-radius: 10px;
            margin-bottom: 16px;
            font-size: 13px;
            color: #334155;
        }
        .info-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .info-lbl {
            color: #64748b;
            font-weight: 500;
        }
        .info-val {
            font-weight: 600;
            color: #0f172a;
        }
        .card-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .btn-view-details {
            flex: 1;
            padding: 9px 14px;
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            transition: all 0.2s;
        }
        .btn-view-details:hover {
            background: #2563eb;
            color: #fff;
        }
        .btn-remove-saved {
            padding: 9px 14px;
            background: #fef2f2;
            color: #dc2626;
            border: 1px solid #fecaca;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
        }
        .btn-remove-saved:hover {
            background: #dc2626;
            color: #fff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0 40px 0;">
        <div class="page-header-box">
            <div class="page-title">
                <h1>Saved Internships</h1>
                <p>Quick access to all the internships you have bookmarked for later review.</p>
            </div>
            <asp:HyperLink ID="hlBrowse" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-view-details" Style="flex: unset; padding: 10px 20px; background: #2563eb; color: #fff;">
                <i class="fa-solid fa-plus"></i> Explore More
            </asp:HyperLink>
        </div>
        <asp:DataList ID="dlSaved" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="saved-cards-grid" OnItemCommand="dlSaved_ItemCommand">
            <ItemTemplate>
                <div class="saved-card">
                    <div>
                        <div class="card-top">
                            <asp:Image ID="imgLogo" runat="server" CssClass="company-logo" ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' AlternateText="Company Logo" />
                            <div class="card-title-wrap">
                                <h3 class="card-title">
                                    <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                                </h3>
                                <span class="company-name">
                                    <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                </span>
                            </div>
                        </div>
                        <div class="card-info-list">
                            <div class="info-row">
                                <span class="info-lbl"><i class="fa-solid fa-location-dot"></i> Location</span>
                                <span class="info-val"><asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>'></asp:Label></span>
                            </div>
                            <div class="info-row">
                                <span class="info-lbl"><i class="fa-solid fa-indian-rupee-sign"></i> Stipend</span>
                                <span class="info-val"><asp:Label ID="lblStipend" runat="server" Text='<%# "&#8377; " + Eval("StipendAmount") %>'></asp:Label></span>
                            </div>
                            <div class="info-row">
                                <span class="info-lbl"><i class="fa-regular fa-clock"></i> Duration</span>
                                <span class="info-val"><asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>'></asp:Label></span>
                            </div>
                            <div class="info-row">
                                <span class="info-lbl"><i class="fa-solid fa-laptop-code"></i> Work Mode</span>
                                <span class="info-val"><asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label></span>
                            </div>
                        </div>
                    </div>
                    <div class="card-actions">
                        <asp:HyperLink ID="hlDetails" runat="server" NavigateUrl='<%# "~/StudentPanel/student-internship-details.aspx?id=" + Eval("Id") %>' CssClass="btn-view-details">
                            <i class="fa-solid fa-paper-plane"></i> View &amp; Apply
                        </asp:HyperLink>
                        <asp:LinkButton ID="btnRemove" runat="server" CommandName="RemoveBookmark" CommandArgument='<%# Eval("Id") %>' CssClass="btn-remove-saved" CausesValidation="false">
                            <i class="fa-solid fa-bookmark"></i>
                        </asp:LinkButton>
                    </div>
                </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:PlaceHolder ID="pnlNoSaved" runat="server" Visible="false">
            <div style="text-align: center; padding: 60px 20px; background: #fff; border-radius: 16px; border: 1px solid #e2e8f0; margin-top: 20px;">
                <i class="fa-regular fa-bookmark" style="font-size: 48px; color: #94a3b8; margin-bottom: 16px;"></i>
                <h3 style="font-size: 18px; color: #0f172a; margin-bottom: 8px;">No Saved Internships Yet</h3>
                <p style="font-size: 14px; color: #64748b; margin-bottom: 20px;">Bookmark internships while browsing to keep track of interesting opportunities.</p>
                <asp:HyperLink ID="hlBrowseNow" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-view-details" Style="padding: 10px 24px; background: #2563eb; color: #fff; display: inline-flex;">
                    <i class="fa-solid fa-briefcase"></i> Browse Internships
                </asp:HyperLink>
            </div>
        </asp:PlaceHolder>
    </div>
</asp:Content>

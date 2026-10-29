<%@ Page Title="My Internships" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-internships.aspx.cs" Inherits="asp.net.company_internships" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-internships.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="my-internships-container">
        <!-- PAGE HEADER -->
        <div class="page-header-flex">
            <div class="page-header-title">
                <h1>My Internships</h1>
                <p>Manage and view all active internship opportunities posted by your company.</p>
            </div>
            <div>
                <asp:HyperLink ID="hlPostInternship" runat="server" NavigateUrl="~/CompanyPanel/company-post-internship.aspx" CssClass="btn-add-internship">
                    <i class="fa-solid fa-plus"></i> Add New Internship
                </asp:HyperLink>
            </div>
        </div>
        <!-- DATALIST FOR MY INTERNSHIPS -->
        <div class="internship-datalist-wrapper">
           <asp:DataList ID="DataListMyInternships" runat="server"
                RepeatLayout="Flow"
                RepeatDirection="Horizontal"
                OnItemCommand="DataListMyInternships_ItemCommand"
                CssClass="internship-card-grid">
    <ItemTemplate>
            <div class="internship-card-box" onclick='window.location.href="company-internship-details.aspx?id=<%# Eval("Id") %>";' style="cursor:pointer;">
            <!-- Top Row -->
            <div class="card-top-row">
                <div class="company-logo-wrap">
                    <asp:Image ID="imgLogo" runat="server"
                        CssClass="company-logo-img"
                        ImageUrl='<%# Eval("c_logo") %>' />
                </div>
                <div class="title-company-wrap">
                    <h3 class="internship-card-title">
                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                    </h3>
                    <span class="company-card-name">
                        <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                    </span>
                </div>
            </div>
            <!-- Details -->
            <div class="card-details-row">
                <span class="detail-item">
                    <i class="fa-solid fa-location-dot"></i>
                    <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                </span>
                <span class="detail-item">
                    <i class="fa-solid fa-building"></i>
                    <asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label>
                </span>
            </div>
            <!-- Stipend -->
            <div class="card-stipend-row">
                <asp:Label ID="lblPaymentStatus" runat="server" CssClass="payment-status" Text='<%# Eval("PaymentStatus") %>'></asp:Label>
                <asp:Label ID="lblStipend" runat="server" CssClass="stipend-amount" Text='<%# Eval("StipendAmount") %>'></asp:Label>
            </div>
            <!-- Footer -->
            <div class="card-footer-row">
                <span class="footer-meta">
                    <i class="fa-regular fa-clock"></i>
                    <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>'></asp:Label>
                </span>
                <span class="footer-meta">
                    <asp:Label ID="lblPostedPrefix" runat="server" Text="Posted "></asp:Label>
                    <asp:Label ID="lblPostedDate" runat="server" Text='<%# Eval("PostedDate") %>'></asp:Label>
                </span>
            </div>
        </div>
            <!-- Action Row (Active Toggle, Edit & Delete) -->
            <div class="card-action-row" style="margin-top: 14px; padding-top: 12px; border-top: 1px dashed #e2e8f0; display: flex; gap: 8px; justify-content: flex-end; align-items: center;" onclick="event.stopPropagation();">
                <asp:HyperLink ID="hlEdit" runat="server" NavigateUrl='<%# "company-post-internship.aspx?id=" + Eval("Id") %>' CssClass="btn-action-edit" style="padding: 6px 14px; background: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe; border-radius: 8px; text-decoration: none; font-size: 13px; font-weight: 600; display: inline-flex; align-items: center; gap: 6px;">
                    <i class="fa-solid fa-pen-to-square"></i> <asp:Label ID="lblEditText" runat="server" Text="Edit"></asp:Label>
                </asp:HyperLink>
                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteInternship" CommandArgument='<%# Eval("Id") %>' CssClass="btn-action-delete" style="padding: 6px 14px; background: #fef2f2; color: #dc2626; border: 1px solid #fecaca; border-radius: 8px; text-decoration: none; font-size: 13px; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 6px;">
                    <i class="fa-solid fa-trash-can"></i> <asp:Label ID="lblDeleteText" runat="server" Text="Delete"></asp:Label>
                </asp:LinkButton>
            </div>
    </ItemTemplate>
</asp:DataList>
            <asp:PlaceHolder ID="pnlNoMyInternships" runat="server" Visible="false">
                <div class="empty-state-box">
                    <div class="empty-state-icon">
                        <i class="fa-solid fa-briefcase"></i>
                    </div>
                    <h3>No Internships Posted Yet</h3>
                    <p>You have not posted any internship opportunities yet. Start posting to find top student talent.</p>
                    <asp:HyperLink ID="hlPostFirst" runat="server" NavigateUrl="~/CompanyPanel/company-post-internship.aspx" CssClass="btn-add-internship">
                        <i class="fa-solid fa-plus"></i> Post Your First Internship
                    </asp:HyperLink>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
</asp:Content>

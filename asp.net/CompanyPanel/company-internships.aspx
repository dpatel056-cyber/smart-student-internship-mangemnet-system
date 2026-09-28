<%@ Page Title="My Internships" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeFile="company-internships.aspx.cs" Inherits="asp.net.company_internships" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .my-internships-container {
            padding: 10px 0 40px 0;
        }

        .page-header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .page-header-title h1 {
            font-size: 24px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 6px 0;
        }

        .page-header-title p {
            font-size: 14px;
            color: #64748b;
            margin: 0;
        }

        .btn-add-internship {
            background-color: #2563eb;
            color: #ffffff;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 10px rgba(37, 99, 235, 0.2);
            transition: all 0.2s ease;
        }

        .btn-add-internship:hover {
            background-color: #1d4ed8;
            color: #ffffff;
            transform: translateY(-2px);
        }

        /* DataList Layout Styles */
        .internship-datalist-wrapper {
            width: 100%;
        }

        .internship-card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 24px;
            width: 100%;
        }

        /* Individual Card Box */
        .internship-card-box {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 24px 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 260px;
        }

        .internship-card-box:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.12);
            border-color: #cbd5e1;
        }

        /* Card Top Header */
        .card-top-row {
            display: flex;
            align-items: flex-start;
            gap: 14px;
            margin-bottom: 16px;
            position: relative;
            padding-right: 30px;
        }

        .company-logo-wrap {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
        }

        .company-logo-img {
            width: 32px;
            height: 32px;
            object-fit: contain;
        }

        .title-company-wrap {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .internship-card-title {
            font-size: 17px;
            font-weight: 700;
            color: #0f172a;
            line-height: 1.3;
            margin: 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .company-card-name {
            font-size: 14px;
            font-weight: 600;
            color: #2563eb;
        }

        .bookmark-btn {
            position: absolute;
            right: 0;
            top: 0;
            color: #cbd5e1;
            font-size: 18px;
            background: transparent;
            border: none;
            cursor: pointer;
            transition: color 0.2s ease;
        }

        .bookmark-btn:hover {
            color: #2563eb;
        }

        /* Card Details Row */
        .card-details-row {
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
            margin-bottom: 16px;
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }

        .detail-item {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .detail-item i {
            color: #2563eb;
            font-size: 14px;
        }

        /* Stipend Row */
        .card-stipend-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .badge-paid {
            background: #dcfce7;
            color: #16a34a;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .badge-unpaid {
            background: #f1f5f9;
            color: #64748b;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .stipend-amount {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
        }

        /* Card Footer Row */
        .card-footer-row {
            border-top: 1px solid #f1f5f9;
            padding-top: 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }

        .footer-meta {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .footer-meta i {
            color: #94a3b8;
            font-size: 14px;
        }

        .posted-time {
            color: #64748b;
        }

        /* Empty State */
        .empty-state-box {
            background: #ffffff;
            border: 2px dashed #cbd5e1;
            border-radius: 16px;
            padding: 50px 20px;
            text-align: center;
            margin-top: 20px;
            width: 100%;
        }

        .empty-state-icon {
            font-size: 48px;
            color: #94a3b8;
            margin-bottom: 16px;
        }

        .empty-state-box h3 {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 8px 0;
        }

        .empty-state-box p {
            font-size: 14px;
            color: #64748b;
            margin: 0 0 20px 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="my-internships-container">

        <!-- PAGE HEADER -->
        <div class="page-header-flex">
            <div class="page-header-title">
                <h1>My Internships</h1>
                <p>Manage and view all active and draft internship opportunities posted by your company.</p>
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
    CssClass="internship-card-grid">

    <ItemTemplate>

        <div class="internship-card-box">

            <!-- Top Row -->
            <div class="card-top-row">

                <div class="company-logo-wrap">
                    <asp:Image ID="imgLogo" runat="server"
                        CssClass="company-logo-img"
                        ImageUrl='<%# Eval("c_logo") %>' />
                </div>

                <div class="title-company-wrap">

                    <h3 class="internship-card-title">
                        <asp:Label ID="lblTitle" runat="server"
                            Text='<%# Eval("InternshipTitle") %>'>
                        </asp:Label>
                    </h3>

                    <span class="company-card-name">
                        <asp:Label ID="lblCompany" runat="server"
                            Text='<%# Eval("c_company") %>'>
                        </asp:Label>
                    </span>

                </div>

                <button type="button" class="bookmark-btn">
                    <i class="fa-regular fa-bookmark"></i>
                </button>

            </div>


            <!-- Details -->
            <div class="card-details-row">

                <span class="detail-item">
                    <i class="fa-solid fa-location-dot"></i>

                    <asp:Label ID="lblLocation" runat="server"
                        Text='<%# Eval("Location") %>'>
                    </asp:Label>
                </span>


                <span class="detail-item">
                    <i class="fa-solid fa-building"></i>

                    <asp:Label ID="lblWorkMode" runat="server"
                        Text='<%# Eval("WorkMode") %>'>
                    </asp:Label>
                </span>

            </div>


            <!-- Stipend -->
            <div class="card-stipend-row">

                <asp:Label ID="lblPaymentStatus" runat="server"
                    CssClass="payment-status"
                    Text='<%# Eval("PaymentStatus") %>'>
                </asp:Label>

                <asp:Label ID="lblStipend" runat="server"
                    CssClass="stipend-amount"
                    Text='<%# Eval("StipendAmount") %>'>
                </asp:Label>

            </div>


            <!-- Footer -->
            <div class="card-footer-row">

                <span class="footer-meta">
                    <i class="fa-regular fa-clock"></i>

                    <asp:Label ID="lblDuration" runat="server"
                        Text='<%# Eval("Duration") %>'>
                    </asp:Label>
                </span>


                <span class="footer-meta">
                    Posted

                    <asp:Label ID="lblPostedDate" runat="server"
                        Text='<%# Eval("PostedDate") %>'>
                    </asp:Label>
                </span>

            </div>

        </div>

    </ItemTemplate>

</asp:DataList>
            <asp:Panel ID="pnlNoMyInternships" runat="server" Visible="false">
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
            </asp:Panel>
        </div>

    </div>
</asp:Content>

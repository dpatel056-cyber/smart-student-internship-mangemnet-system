<%@ Page Title="My Applications" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-my-applications.aspx.cs" Inherits="asp.net.student_my_applications" %>
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
        /* Success Banner */
        .alert-success-banner {
            background: #ecfdf5;
            border: 1px solid #a7f3d0;
            border-radius: 12px;
            padding: 16px 20px;
            color: #065f46;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            animation: slideDown 0.3s ease-out;
        }
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        /* Stats Cards */
        .app-stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 18px;
            margin-bottom: 24px;
        }
        @media (max-width: 900px) {
            .app-stats-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 500px) {
            .app-stats-grid { grid-template-columns: 1fr; }
        }
        .app-stat-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 18px 20px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.04);
        }
        .app-stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            flex-shrink: 0;
        }
        .icon-blue { background: #eff6ff; color: #2563eb; }
        .icon-amber { background: #fffbeb; color: #d97706; }
        .icon-indigo { background: #eef2ff; color: #4f46e5; }
        .icon-green { background: #ecfdf5; color: #059669; }
        .app-stat-info .title {
            font-size: 12.5px;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }
        .app-stat-info .count {
            font-size: 22px;
            font-weight: 700;
            color: #0f172a;
            line-height: 1;
        }
        /* Applications Table Card */
        .apps-table-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(15,23,42,0.03);
        }
        .apps-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            text-align: left;
        }
        .apps-table th {
            background: #f8fafc;
            padding: 16px 20px;
            font-weight: 600;
            color: #475569;
            border-bottom: 1px solid #e2e8f0;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .apps-table td {
            padding: 18px 20px;
            border-bottom: 1px solid #f1f5f9;
            color: #1e293b;
            vertical-align: middle;
        }
        .apps-table tr:last-child td {
            border-bottom: none;
        }
        .apps-table tr:hover td {
            background: #f8fafc;
        }
        .company-logo-circle {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid #e2e8f0;
            background: #fff;
            flex-shrink: 0;
        }
        /* Status Badges */
        .badge-status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 12.5px;
            font-weight: 600;
        }
        .status-applied {
            background: #f1f5f9;
            color: #475569;
            border: 1px solid #e2e8f0;
        }
        .status-under-review {
            background: #fef3c7;
            color: #b45309;
            border: 1px solid #fde68a;
        }
        .status-shortlisted {
            background: #dbeafe;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }
        .status-selected {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        .status-rejected {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fca5a5;
        }
        .btn-action-sm {
            padding: 7px 14px;
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s;
        }
        .btn-action-sm:hover {
            background: #2563eb;
            color: #fff !important;
            border-color: #2563eb;
            text-decoration: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="padding: 10px 0 40px 0;">
        <!-- Success notification on apply -->
        <asp:PlaceHolder ID="pnlSuccessMsg" runat="server" Visible="false">
            <div class="alert-success-banner">
                <i class="fa-solid fa-circle-check" style="font-size: 20px; color: #059669;"></i>
                <div>
                    <strong>Application Submitted Successfully!</strong>
                    <span> Your application has been sent to the company. You can monitor progress here in real-time.</span>
                </div>
            </div>
        </asp:PlaceHolder>
        <!-- Page Header -->
        <div class="page-header-box">
            <div class="page-title">
                <h1>My Applications</h1>
                <p>Track the real-time status of all your submitted internship applications.</p>
            </div>
            <asp:HyperLink ID="hlBrowse" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-action-sm" Style="padding: 10px 20px; font-size: 13.5px; background: #2563eb; color: #fff; border: none; box-shadow: 0 4px 12px rgba(37,99,235,0.25);">
                <i class="fa-solid fa-plus"></i> Apply to More Internships
            </asp:HyperLink>
        </div>
        <!-- Summary Stats Grid -->
        <div class="app-stats-grid">
            <div class="app-stat-card">
                <div class="app-stat-icon icon-blue"><i class="fa-solid fa-paper-plane"></i></div>
                <div class="app-stat-info">
                    <div class="title">Total Applied</div>
                    <div class="count"><asp:Label ID="lblTotalApplied" runat="server" Text="0"></asp:Label></div>
                </div>
            </div>
            <div class="app-stat-card">
                <div class="app-stat-icon icon-amber"><i class="fa-solid fa-clock-rotate-left"></i></div>
                <div class="app-stat-info">
                    <div class="title">Under Review</div>
                    <div class="count"><asp:Label ID="lblUnderReview" runat="server" Text="0"></asp:Label></div>
                </div>
            </div>
            <div class="app-stat-card">
                <div class="app-stat-icon icon-indigo"><i class="fa-solid fa-user-check"></i></div>
                <div class="app-stat-info">
                    <div class="title">Shortlisted</div>
                    <div class="count"><asp:Label ID="lblShortlisted" runat="server" Text="0"></asp:Label></div>
                </div>
            </div>
            <div class="app-stat-card">
                <div class="app-stat-icon icon-green"><i class="fa-solid fa-circle-check"></i></div>
                <div class="app-stat-info">
                    <div class="title">Selected</div>
                    <div class="count"><asp:Label ID="lblSelected" runat="server" Text="0"></asp:Label></div>
                </div>
            </div>
        </div>
        <!-- Applications Table -->
        <div class="apps-table-card">
            <asp:GridView ID="gvApplications" runat="server" AutoGenerateColumns="False" CssClass="apps-table" GridLines="None" UseAccessibleHeader="true" ShowHeaderWhenEmpty="true">
                <Columns>
                    <asp:TemplateField HeaderText="Internship / Role">
                        <ItemTemplate>
                            <div style="display: flex; align-items: center; gap: 14px;">
                                <asp:Image ID="imgLogo" runat="server" CssClass="company-logo-circle" ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' />
                                <div>
                                    <div style="font-weight: 700; color: #0f172a; font-size: 15px; margin-bottom: 2px;">
                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                                    </div>
                                    <div style="font-size: 13px; color: #2563eb; font-weight: 600;">
                                        <i class="fa-solid fa-building" style="font-size: 11px;"></i>
                                        <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Applied Date">
                        <ItemTemplate>
                            <span style="color: #475569; font-size: 13.5px; font-weight: 500;">
                                <i class="fa-regular fa-calendar" style="margin-right: 5px; color: #94a3b8;"></i>
                                <asp:Label ID="lblDate" runat="server" Text='<%# FormatDate(Eval("AppliedDate")) %>'></asp:Label>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Work Mode">
                        <ItemTemplate>
                            <span style="font-size: 13px; color: #475569; font-weight: 500;">
                                <i class="fa-solid fa-laptop-code" style="margin-right: 5px; color: #94a3b8;"></i>
                                <asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Stipend">
                        <ItemTemplate>
                            <span style="font-weight: 700; color: #0f172a; font-size: 13.5px;">
                                <asp:Label ID="lblStipend" runat="server" Text='<%# "&#8377; " + Eval("StipendAmount") %>'></asp:Label>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <%# GetStatusBadge(Eval("Status")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlView" runat="server" NavigateUrl='<%# "~/StudentPanel/student-internship-details.aspx?id=" + Eval("InternshipId") %>' CssClass="btn-action-sm">
                                <i class="fa-solid fa-eye"></i> View Role
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <!-- Empty State -->
            <asp:PlaceHolder ID="pnlNoApps" runat="server" Visible="false">
                <div style="text-align: center; padding: 60px 20px;">
                    <div style="width: 72px; height: 72px; background: #eff6ff; color: #2563eb; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 32px; margin: 0 auto 16px;">
                        <i class="fa-solid fa-briefcase"></i>
                    </div>
                    <h3 style="font-size: 18px; font-weight: 700; color: #0f172a; margin-bottom: 8px;">No Applications Submitted Yet</h3>
                    <p style="font-size: 14px; color: #64748b; margin-bottom: 24px; max-width: 460px; margin-left: auto; margin-right: auto;">
                        Explore verified internships matching your skills, apply with one click, and track your progress here.
                    </p>
                    <asp:HyperLink ID="hlExplore" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-action-sm" Style="padding: 12px 24px; font-size: 14px; background: #2563eb; color: #fff; border: none; box-shadow: 0 4px 12px rgba(37,99,235,0.25);">
                        <i class="fa-solid fa-magnifying-glass"></i> Browse Internships
                    </asp:HyperLink>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
</asp:Content>

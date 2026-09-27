<%@ Page Title="Admin - Internships" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-internships.aspx.cs" Inherits="asp.net.admin_internships" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-internships.css" />
    <style>
        .admin-internships-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 22px;
            width: 100%;
            margin-top: 10px;
        }

        .admin-internship-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(15, 23, 42, 0.04);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: all 0.25s ease;
            position: relative;
        }

        .admin-internship-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 24px rgba(37, 99, 235, 0.1);
            border-color: #cbd5e1;
        }

        .admin-card-header {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 16px;
        }

        .admin-company-logo-avatar {
            width: 52px;
            height: 52px;
            border-radius: 50% !important;
            overflow: hidden !important;
            border: 2px solid #e2e8f0;
            object-fit: cover;
            flex-shrink: 0;
            background: #f8fafc;
        }

        .admin-card-title-wrap {
            display: flex;
            flex-direction: column;
            gap: 3px;
            overflow: hidden;
        }

        .admin-card-title {
            font-size: 16.5px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            line-height: 1.3;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .admin-company-name {
            font-size: 13.5px;
            font-weight: 600;
            color: #2563eb;
        }

        .admin-info-list {
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

        .admin-info-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .admin-info-label {
            color: #64748b;
            font-weight: 500;
        }

        .admin-info-val {
            font-weight: 600;
            color: #0f172a;
        }

        .admin-card-actions {
            border-top: 1px solid #f1f5f9;
            padding-top: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .admin-btn-action {
            flex: 1;
            font-size: 13px;
            padding: 8px 12px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none !important;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            cursor: pointer;
            transition: all 0.2s ease;
            border: none;
            text-align: center;
        }

        .admin-btn-primary {
            background: #2563eb;
            color: #ffffff !important;
        }

        .admin-btn-primary:hover {
            background: #1d4ed8;
        }

        .admin-btn-danger {
            background: #fef2f2;
            color: #ef4444 !important;
            border: 1px solid #fee2e2;
        }

        .admin-btn-danger:hover {
            background: #ef4444;
            color: #ffffff !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="sims-internship-page">

        <!-- 1. PAGE HEADER -->
        <div class="sims-internship-header">
            <div class="sims-internship-header-left">
                <h1 class="sims-internship-title">Internship Management</h1>
                <p class="sims-internship-subtitle">Manage, review and monitor all internship opportunities posted by registered companies.</p>
            </div>
        </div>

        <!-- 2. DATALIST INTERNSHIPS DISPLAY -->
        <div class="sims-internship-table-card" style="padding: 24px; border-radius: 16px;">
            <div class="sims-internship-table-header" style="margin-bottom: 20px;">
                <h2>All Posted Internships</h2>
            </div>

            <asp:DataList ID="DataListAdminInternships" runat="server"
                RepeatLayout="Flow"
                RepeatDirection="Horizontal"
                CssClass="admin-internships-grid"
                OnItemCommand="DataListAdminInternships_ItemCommand">

                <ItemTemplate>
                    <div class="admin-internship-card">
                        
                        <!-- Top Header: Logo + Title & Company -->
                        <div class="admin-card-header">
                            <asp:Image ID="Image1" runat="server"
                                CssClass="admin-company-logo-avatar"
                                ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>'
                                onerror="this.onerror=null; this.src='../assets/default-company.png';" />
                            
                            <div class="admin-card-title-wrap">
                                <h3 class="admin-card-title">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                                </h3>
                                <div class="admin-company-name">
                                    <i class="fa-solid fa-building" style="font-size: 11px;"></i>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                </div>
                            </div>
                        </div>

                        <!-- Data Fields List -->
                        <div class="admin-info-list">
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-location-dot" style="color: #2563eb; width: 14px;"></i> Location:</span>
                                <span class="admin-info-val"><asp:Label ID="Label3" runat="server" Text='<%# Eval("Location") %>'></asp:Label></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-clock" style="color: #2563eb; width: 14px;"></i> Duration:</span>
                                <span class="admin-info-val"><asp:Label ID="Label4" runat="server" Text='<%# Eval("Duration") %>'></asp:Label></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-tag" style="color: #2563eb; width: 14px;"></i> Domain:</span>
                                <span class="admin-info-val"><asp:Label ID="Label5" runat="server" Text='<%# Eval("InternshipDomain") %>'></asp:Label></span>
                            </div>
                            <div class="admin-info-row">
                                <span class="admin-info-label"><i class="fa-solid fa-laptop-code" style="color: #2563eb; width: 14px;"></i> Work Mode:</span>
                                <span class="admin-info-val"><asp:Label ID="Label6" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label></span>
                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="admin-card-actions">
                            <asp:LinkButton ID="LinkButton1" runat="server"
                                CommandArgument='<%# Eval("Id") %>'
                                CommandName="cmd_view"
                                CssClass="admin-btn-action admin-btn-primary">
                                <i class="fa-solid fa-eye"></i> View Details
                            </asp:LinkButton>

                            <asp:LinkButton ID="LinkButton2" runat="server"
                                CommandArgument='<%# Eval("Id") %>'
                                CommandName="cmd_delete"
                                OnClientClick="return confirm('Are you sure you want to delete this internship posting?');"
                                CssClass="admin-btn-action admin-btn-danger">
                                <i class="fa-solid fa-trash"></i> Delete
                            </asp:LinkButton>
                        </div>
                    </div>
                </ItemTemplate>

            </asp:DataList>

            <asp:Panel ID="pnlNoInternships" runat="server" Visible="false">
                <div class="empty-state-box-admin" style="background:#fff; border:2px dashed #cbd5e1; border-radius:14px; padding:50px 20px; text-align:center; margin-top:20px; width:100%;">
                    <div style="font-size:44px; color:#94a3b8; margin-bottom:14px;">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3 style="font-size: 18px; font-weight: 700; color: #0f172a; margin: 0 0 8px 0;">No Internships Found</h3>
                    <p style="font-size: 14px; color: #64748b; margin: 0;">There are currently no internship postings available matching your search criteria.</p>
                </div>
            </asp:Panel>
        </div>

    </div>
</asp:Content>

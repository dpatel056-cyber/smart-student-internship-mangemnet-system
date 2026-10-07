<%@ Page Title="Student Applications" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-student-applications.aspx.cs" Inherits="asp.net.admin_student_applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-student-applications.css" />
    <style>
        .badge-pending,
        .badge-shortlisted,
        .badge-selected,
        .badge-rejected,
        .status-pending,
        .status-shortlisted,
        .status-selected,
        .status-rejected {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            white-space: nowrap;
            line-height: 1.2;
        }
        .badge-pending,
        .status-pending {
            background: #fef3c7;
            color: #b45309;
            border: 1px solid #fde68a;
        }
        .badge-shortlisted,
        .status-shortlisted {
            background: #dbeafe;
            color: #1d4ed8;
            border: 1px solid #bfdbfe;
        }
        .badge-selected,
        .status-selected {
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }
        .badge-rejected,
        .status-rejected {
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="sims-applications-page">
        <!-- ===================== PAGE HEADER ===================== -->
        <div class="sims-application-header">
            <div class="sims-application-header-left">
                <h1 class="sims-application-title">Student Applications</h1>
                <p class="sims-application-subtitle">Review, monitor and manage internship applications submitted by students.</p>
            </div>
        </div>
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        <!-- ===================== STATISTICS (1 ROW 5 COLUMNS) ===================== -->
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 16px; margin-bottom: 24px;">
            <!-- Card 1: Total Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-orange">
                    <i class="fa-solid fa-file-lines"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Total Applications</span>
                    <span class="sims-stat-num-v2"><asp:Label ID="lblTotalApps" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 2: Pending Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-yellow">
                    <i class="fa-solid fa-hourglass-half"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Pending</span>
                    <span class="sims-stat-num-v2"><asp:Label ID="lblPendingApps" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 3: Shortlisted Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-blue">
                    <i class="fa-solid fa-list-check"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Shortlisted</span>
                    <span class="sims-stat-num-v2"><asp:Label ID="lblShortlistedApps" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 4: Selected Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-green">
                    <i class="fa-solid fa-check"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Selected</span>
                    <span class="sims-stat-num-v2"><asp:Label ID="lblSelectedApps" runat="server">0</asp:Label></span>
                </div>
            </div>
            <!-- Card 5: Rejected Applications -->
            <div class="sims-stat-card-v2">
                <div class="sims-stat-icon-v2 sims-bg-pink">
                    <i class="fa-solid fa-xmark"></i>
                </div>
                <div class="sims-stat-info-v2">
                    <span class="sims-stat-title-v2">Rejected</span>
                    <span class="sims-stat-num-v2"><asp:Label ID="lblRejectedApps" runat="server">0</asp:Label></span>
                </div>
            </div>
        </div>
        <!-- ===================== SEARCH & FILTER PANEL (DESIGN ONLY) ===================== -->
        <div class="sims-application-filters" style="display: flex; gap: 14px; align-items: center; background: #fff; padding: 18px 24px; border-radius: 12px; margin-bottom: 24px; border: 1px solid #e2e8f0; flex-wrap: wrap;">
            <!-- Search Box with Icon -->
            <div style="flex: 1; min-width: 280px; position: relative;">
                <i class="fa-solid fa-magnifying-glass" style="position: absolute; left: 14px; top: 50%; transform: translateY(-50%); color: #94a3b8; font-size: 14px;"></i>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search by student, email, internship or company..." style="width: 100%; padding: 10px 14px 10px 38px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-size: 13.5px; color: #1e293b; outline: none;"></asp:TextBox>
            </div>
            <!-- Status Dropdown with wrapper -->
            <div style="min-width: 180px; position: relative;">
                <asp:DropDownList ID="ddlStatusFilter" runat="server" style="width: 100%; padding: 10px 36px 10px 14px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-size: 13.5px; color: #1e293b; appearance: none; background: #ffffff; cursor: pointer; outline: none;">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                    <asp:ListItem Text="Shortlisted" Value="Shortlisted"></asp:ListItem>
                    <asp:ListItem Text="Selected" Value="Selected"></asp:ListItem>
                    <asp:ListItem Text="Rejected" Value="Rejected"></asp:ListItem>
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down" style="position: absolute; right: 14px; top: 50%; transform: translateY(-50%); color: #94a3b8; font-size: 12px; pointer-events: none;"></i>
            </div>
            <!-- Action Buttons: Search & Clear -->
            <div style="display: flex; gap: 8px; align-items: center;">
                <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" CausesValidation="false" style="padding: 10px 20px; background: #2563eb; color: #fff; border-radius: 8px; text-decoration: none; display: inline-flex; align-items: center; gap: 7px; font-weight: 600; font-size: 13.5px; border: none; cursor: pointer;">
                    <i class="fa-solid fa-magnifying-glass"></i> Search
                </asp:LinkButton>
                <asp:LinkButton ID="btnClearFilters" runat="server" CausesValidation="false" style="padding: 10px 18px; background: #f1f5f9; color: #475569; border-radius: 8px; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; font-weight: 600; font-size: 13.5px; border: 1px solid #e2e8f0; cursor: pointer; transition: all 0.15s ease;" onmouseover="this.style.background='#e2e8f0'; this.style.color='#0f172a';" onmouseout="this.style.background='#f1f5f9'; this.style.color='#475569';">
                    <i class="fa-solid fa-xmark"></i> Clear Filters
                </asp:LinkButton>
            </div>
        </div>
        <!-- ===================== TABLE CARD ===================== -->
        <div style="background: #ffffff; border-radius: 16px; border: 1px solid #e2e8f0; box-shadow: 0 2px 8px rgba(0,0,0,0.04); overflow: hidden; margin-bottom: 24px;">
            <div class="sims-table-responsive-v2" style="overflow-x: auto; width: 100%;">
                <asp:GridView ID="gvApplications" runat="server" AutoGenerateColumns="False" OnRowCommand="gvApplications_RowCommand" CssClass="sims-recent-table-v2" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%" Style="width: 100%; border-collapse: collapse; margin-bottom: 0;">
                    <HeaderStyle BackColor="#f8fafc" Font-Bold="True" ForeColor="#475569" Height="46px" BorderColor="#e2e8f0" BorderWidth="1px" BorderStyle="Solid" />
                    <RowStyle BorderColor="#f1f5f9" BorderWidth="1px" BorderStyle="Solid" Height="56px" />
                    <AlternatingRowStyle BackColor="#ffffff" />
                    <Columns>
                        <asp:TemplateField HeaderText="STUDENT" HeaderStyle-Width="20%">
                            <HeaderStyle CssClass="p-3" />
                            <ItemStyle CssClass="p-3" />
                            <ItemTemplate>
                                <div style="display: flex; align-items: center; gap: 12px;">
                                    <%# GetStudentAvatar(Eval("ProfilePhoto"), Eval("FullName")) %>
                                    <asp:Label ID="lblStudentName" runat="server" Text='<%# Eval("FullName") %>' style="font-weight: 700; color: #0f172a; font-size: 13.5px;"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="EMAIL" HeaderStyle-Width="20%">
                            <HeaderStyle CssClass="p-3" />
                            <ItemStyle CssClass="p-3" />
                            <ItemTemplate>
                                <div style="display: flex; align-items: center; gap: 7px; color: #64748b; font-size: 13px;">
                                    <i class="fa-regular fa-envelope" style="color: #94a3b8; font-size: 12px;"></i>
                                    <asp:Label ID="lblStudentEmail" runat="server" Text='<%# Eval("StudentEmail") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="INTERNSHIP" HeaderStyle-Width="22%">
                            <HeaderStyle CssClass="p-3" />
                            <ItemStyle CssClass="p-3" />
                            <ItemTemplate>
                                <div style="display: flex; align-items: center; gap: 8px;">
                                    <i class="fa-solid fa-laptop-code" style="color: #2563eb; font-size: 13px;"></i>
                                    <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>' style="font-weight: 600; color: #1e293b; font-size: 13.5px;"></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="COMPANY" HeaderStyle-Width="16%">
                            <HeaderStyle CssClass="p-3" />
                            <ItemStyle CssClass="p-3" />
                            <ItemTemplate>
                                <div style="display: flex; align-items: center; gap: 7px; color: #334155; font-size: 13.5px; font-weight: 500;">
                                    <i class="fa-solid fa-building" style="color: #94a3b8; font-size: 12px;"></i>
                                    <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="APPLIED DATE" HeaderStyle-Width="11%">
                            <HeaderStyle CssClass="p-3" />
                            <ItemStyle CssClass="p-3" />
                            <ItemTemplate>
                                <div style="display: flex; align-items: center; gap: 6px; color: #64748b; font-size: 13px;">
                                    <i class="fa-regular fa-calendar" style="color: #94a3b8; font-size: 12px;"></i>
                                  <asp:Label ID="lblAppliedDate" runat="server"
    Text='<%# Convert.ToDateTime(Eval("AppliedDate")).ToString("dd MMM yyyy") %>'>
</asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                       <asp:TemplateField HeaderText="STATUS">
    <ItemTemplate>
        <asp:Label ID="lblStatus" runat="server"
            Text='<%# GetStatusBadge(Eval("Status")) %>'>
        </asp:Label>
    </ItemTemplate>
</asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="padding: 36px; text-align: center; color: #64748b; font-size: 14px;">
                            <i class="fa-regular fa-folder-open" style="font-size: 32px; color: #cbd5e1; display: block; margin-bottom: 8px;"></i>
                            No applications found.
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

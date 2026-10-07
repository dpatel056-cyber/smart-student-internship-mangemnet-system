<%@ Page Title="Applicants" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-applicants.aspx.cs" Inherits="asp.net.company_applicants" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <style>
        .page-header-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 24px;
        }
        .filter-bar-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 16px 20px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            box-shadow: 0 1px 3px rgba(16, 24, 40, 0.04);
        }
        .form-select-ctrl {
            padding: 9px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            color: #0f172a;
            outline: none;
            background: #f8fafc;
            min-width: 180px;
        }
        .form-select-ctrl:focus {
            border-color: #2563eb;
            background: #ffffff;
        }
        .table-status-select {
            padding: 6px 12px;
            font-size: 12.5px;
            font-weight: 600;
            border-radius: 8px;
            border: 1.5px solid #cbd5e1;
            background: #ffffff;
            color: #1e293b;
            outline: none;
            cursor: pointer;
            transition: all 0.15s ease;
        }
        .table-status-select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.1);
        }
        .table-status-select:hover {
            border-color: #94a3b8;
        }
        .action-link {
            padding: 5px 11px;
            font-size: 12px;
            font-weight: 600;
            border-radius: 6px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 4px;
            margin-right: 4px;
        }
        .action-link.edit-btn {
            background: #eff6ff;
            color: #2563eb;
            border: 1px solid #bfdbfe;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header -->
    <div class="page-header-box">
        <div>
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Applicants</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Review, shortlist, select or reject candidate applications.</p>
        </div>
    </div>
    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    <!-- Filter Bar (Design Only) -->
    <div class="filter-bar-card">
        <div style="display:flex; align-items:center; gap:10px;">
            <asp:Label ID="lblInternshipFilterLabel" runat="server" Style="font-size:13.5px; font-weight:600; color:#475569;"><i class="fa-solid fa-briefcase" style="color:#2563eb; margin-right:4px;"></i> Internship:</asp:Label>
            <asp:DropDownList ID="ddlInternshipFilter" runat="server" CssClass="form-select-ctrl">
                <asp:ListItem Text="All Internships" Value="" />
            </asp:DropDownList>
        </div>
        <div style="display:flex; align-items:center; gap:10px;">
            <asp:Label ID="lblStatusFilterLabel" runat="server" Style="font-size:13.5px; font-weight:600; color:#475569;"><i class="fa-solid fa-filter" style="color:#7c3aed; margin-right:4px;"></i> Status:</asp:Label>
            <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select-ctrl">
                <asp:ListItem Text="All Statuses" Value="" />
                <asp:ListItem Text="Applied" Value="Applied" />
                <asp:ListItem Text="Shortlisted" Value="Shortlisted" />
                <asp:ListItem Text="Selected" Value="Selected" />
                <asp:ListItem Text="Rejected" Value="Rejected" />
            </asp:DropDownList>
        </div>
    </div>
    <!-- Applicants Panel & GridView -->
    <div class="co-panel" style="margin-bottom: 26px; width: 100%;">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-user-group" style="color: #2563eb; margin-right: 8px;"></i> All Applications</h3>
        </div>
        <div style="overflow-x: auto; width: 100%;">
            <asp:GridView ID="gvApplicants" runat="server" AutoGenerateColumns="False" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%" DataKeyNames="ApplicationId" OnRowEditing="gvApplicants_RowEditing" OnRowCancelingEdit="gvApplicants_RowCancelingEdit" OnRowUpdating="gvApplicants_RowUpdating">
                <Columns>
                    <asp:TemplateField HeaderText="Name" HeaderStyle-Width="18%">
                        <ItemTemplate>
                            <div class="co-applicant-cell">
                                <asp:Label ID="lblInitials" runat="server" CssClass="co-applicant-avatar av1" Text='<%# GetInitials(Eval("FullName")) %>'></asp:Label>
                                <asp:Label ID="lblFullName" runat="server" Style="font-weight: 700; color: #0f172a;" Text='<%# Eval("FullName") %>'></asp:Label>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" HeaderStyle-Width="20%">
                        <ItemTemplate>
                            <asp:Label ID="lblStudentEmail" runat="server" Style="font-size: 13.5px; color: #475569;" Text='<%# Eval("StudentEmail") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Internship Title" HeaderStyle-Width="20%">
                        <ItemTemplate>
                            <asp:Label ID="lblInternshipTitle" runat="server" Style="font-weight: 600; color: #1e293b; display: block;" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                   <asp:TemplateField HeaderText="Date" HeaderStyle-Width="12%">
    <ItemTemplate>
        <asp:Label ID="lblAppliedDate" runat="server"
            Style="font-size: 13px; color: #64748b;"
            Text='<%# Convert.ToDateTime(Eval("AppliedDate")).ToString("dd MMM yyyy") %>'>
        </asp:Label>
    </ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Status" HeaderStyle-Width="12%">
    <ItemTemplate>
        <%# GetStatusBadge(Eval("Status")) %>
    </ItemTemplate>
    <EditItemTemplate>
        <asp:DropDownList ID="ddlChangeStatus" runat="server" CssClass="table-status-select">
            <asp:ListItem Value="Applied">Applied</asp:ListItem>
            <asp:ListItem Value="Shortlisted">Shortlisted</asp:ListItem>
            <asp:ListItem Value="Selected">Selected</asp:ListItem>
            <asp:ListItem Value="Rejected">Rejected</asp:ListItem>
        </asp:DropDownList>
    </EditItemTemplate>
</asp:TemplateField>

<asp:CommandField HeaderText="Modify Status" ShowEditButton="True" ButtonType="Link" EditText="&lt;i class='fa-solid fa-pen-to-square'&gt;&lt;/i&gt; Edit" UpdateText="&lt;i class='fa-solid fa-check'&gt;&lt;/i&gt; Update" CancelText="&lt;i class='fa-solid fa-xmark'&gt;&lt;/i&gt; Cancel" ControlStyle-CssClass="action-link edit-btn" HeaderStyle-Width="12%" />
                    <asp:TemplateField HeaderText="Action" HeaderStyle-Width="6%" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlViewStudent" runat="server"
                                           NavigateUrl='<%# "~/CompanyPanel/company-student-details.aspx?id=" + Eval("StudentId") + "&appId=" + Eval("ApplicationId") %>'
                                           Style="padding: 6px 14px; font-size: 12.5px; text-decoration: none; border-radius: 8px; background: #eff6ff; color: #2563eb; border: 1px solid #bfdbfe; font-weight: 600; display: inline-flex; align-items: center; gap: 5px; transition: all 0.15s ease;">
                                <i class="fa-solid fa-eye"></i> View
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoApplicants" runat="server" Visible="false"><div style="text-align:center; padding:50px 10px;">
                <i class="fa-solid fa-users-slash" style="font-size:42px; color:#cbd5e1; margin-bottom:12px; display:block;"></i>
                <h3 style="font-size:16px; color:#0f172a; margin-bottom:6px;">No Applications Found</h3>
                <p style="font-size:13.5px; color:#64748b; margin:0;">Students applying to your posted internships will appear here.</p>
            </div></asp:PlaceHolder>
        </div>
    </div>
</asp:Content>

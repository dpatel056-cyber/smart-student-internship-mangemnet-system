<%@ Page Title="Selected Students" Language="C#" MasterPageFile="~/CompanyPanel/company.Master" AutoEventWireup="true" CodeBehind="company-selected-students.aspx.cs" Inherits="asp.net.company_selected_students" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/company-dashboard.css" />
    <link rel="stylesheet" href="../css/company-selected-students.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Page Header -->
    <div class="page-header-box">
        <div>
            <h1 style="font-size: 24px; font-weight: 700; color: #0f172a; margin: 0 0 4px 0;">Selected Students</h1>
            <p style="font-size: 14px; color: #64748b; margin: 0;">Manage selected / hired candidates, generate offer letters, and issue internship certificates.</p>
        </div>
    </div>
    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    <!-- Filter Bar -->
    <div class="filter-bar-card">
        <div style="display:flex; align-items:center; gap:10px;">
            <span style="font-size:13.5px; font-weight:600; color:#475569;"><i class="fa-solid fa-briefcase" style="color:#2563eb; margin-right:4px;"></i> Internship:</span>
            <asp:DropDownList ID="ddlInternshipFilter" runat="server" CssClass="form-select-ctrl" AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_SelectedIndexChanged"></asp:DropDownList>
        </div>
    </div>
    <!-- Selected Students GridView Panel -->
    <div class="co-panel" style="margin-bottom: 26px; width: 100%;">
        <div class="co-panel-header">
            <h3><i class="fa-solid fa-award" style="color: #16a34a; margin-right: 8px;"></i> Selected Candidates</h3>
        </div>
        <div style="overflow-x: auto; width: 100%;">
            <asp:GridView ID="gvSelected" runat="server" AutoGenerateColumns="False" CssClass="co-table" GridLines="None" ShowHeaderWhenEmpty="true" Width="100%">
                <Columns>
                    <asp:TemplateField HeaderText="Name" HeaderStyle-Width="20%">
                        <ItemTemplate>
                            <div class="co-applicant-cell">
                                <asp:Image ID="imgStudentLogo" runat="server" CssClass="co-applicant-avatar" ImageUrl='<%# Eval("ProfilePhoto") %>' onerror="this.onerror=null;this.src='../student_images/default-avatar.png';" />
                                <div style="font-weight: 700; color: #0f172a;"><%# Eval("FullName") %></div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" HeaderStyle-Width="20%">
                        <ItemTemplate>
                            <span style="font-size: 13.5px; color: #475569;"><%# Eval("StudentEmail") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Internship Title" HeaderStyle-Width="20%">
                        <ItemTemplate>
                            <div style="font-weight: 600; color: #1e293b;"><%# Eval("InternshipTitle") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Date" HeaderStyle-Width="10%">
                        <ItemTemplate>
                            <span style="font-size: 13px; color: #64748b;"><%# Eval("AppliedDate", "{0:dd MMM yyyy}") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status" HeaderStyle-Width="10%">
                        <ItemTemplate>
                            <%# GetStatusBadge(Eval("Status")) %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions" HeaderStyle-Width="20%" HeaderStyle-CssClass="text-end" ItemStyle-CssClass="text-end">
                        <ItemTemplate>
                            <div style="display: flex; align-items: center; justify-content: flex-end; gap: 8px; flex-wrap: nowrap; white-space: nowrap;">
                                <a href='company-offer-letters.aspx?appId=<%# Eval("ApplicationId") %>'
                                   class="btn-table-action btn-action-offer"
>
                                    <i class="fa-solid fa-file-signature"></i> Offer Letter
                                </a>
                                <a href='company-certificates.aspx?appId=<%# Eval("ApplicationId") %>'
                                   class="btn-table-action btn-action-cert"
>
                                    <i class="fa-solid fa-certificate"></i> Certificate
                                </a>
                                <a href='company-student-details.aspx?appId=<%# Eval("ApplicationId") %>'
                                   class="btn-table-action btn-action-view"
>
                                    <i class="fa-regular fa-eye"></i> View
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:PlaceHolder ID="pnlNoSelected" runat="server" Visible="false"><div style="text-align: center; padding: 50px 20px; color: #64748b;">
                <i class="fa-solid fa-award" style="font-size: 42px; color: #cbd5e1; margin-bottom: 12px; display: block;"></i>
                <h4 style="font-size: 16px; font-weight: 600; color: #1e293b; margin-bottom: 4px;">No Selected Students Found</h4>
                <p style="font-size: 13px; margin: 0;">Students will appear here once an interview is marked as completed or status is set to Selected.</p>
            </div></asp:PlaceHolder>
        </div>
    </div>
</asp:Content>

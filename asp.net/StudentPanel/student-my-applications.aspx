<%@ Page Title="My Applications" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-my-applications.aspx.cs" Inherits="asp.net.student_my_applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-my-applications.css" />
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div  class="sapp-u1">
        <!-- Success notification on apply -->
        <asp:PlaceHolder ID="pnlSuccessMsg" runat="server" Visible="false">
            <div class="alert-success-banner">
                <i class="fa-solid fa-circle-check sapp-u2" ></i>
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
            <asp:HyperLink ID="hlBrowse" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-action-sm sapp-u3" >
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
                            <div  class="sapp-u4">
                                <asp:Image ID="imgLogo" runat="server" CssClass="company-logo-circle" ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' />
                                <div>
                                    <div  class="sapp-u5">
                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                                    </div>
                                    <div  class="sapp-u6">
                                        <i class="fa-solid fa-building sapp-u7" ></i>
                                        <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Applied Date">
                        <ItemTemplate>
                            <span  class="sapp-u8">
                                <i class="fa-regular fa-calendar sapp-u9" ></i>
                                <asp:Label ID="lblDate" runat="server" Text='<%# FormatDate(Eval("AppliedDate")) %>'></asp:Label>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Work Mode">
                        <ItemTemplate>
                            <span  class="sapp-u10">
                                <i class="fa-solid fa-laptop-code sapp-u9" ></i>
                                <asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Stipend">
                        <ItemTemplate>
                            <span  class="sapp-u11">
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
                <div  class="sapp-u12">
                    <div  class="sapp-u13">
                        <i class="fa-solid fa-briefcase"></i>
                    </div>
                    <h3  class="sapp-u14">No Applications Submitted Yet</h3>
                    <p  class="sapp-u15">
                        Explore verified internships matching your skills, apply with one click, and track your progress here.
                    </p>
                    <asp:HyperLink ID="hlExplore" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-action-sm sapp-u16" >
                        <i class="fa-solid fa-magnifying-glass"></i> Browse Internships
                    </asp:HyperLink>
                </div>
            </asp:PlaceHolder>
        </div>
    </div>
</asp:Content>

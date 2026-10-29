<%@ Page Title="Saved Internships" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-saved-internships.aspx.cs" Inherits="asp.net.student_saved_internships" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-saved-internships.css" />
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div  class="ssave-u1">
        <div class="page-header-box">
            <div class="page-title">
                <h1>Saved Internships</h1>
                <p>Quick access to all the internships you have bookmarked for later review.</p>
            </div>
            <asp:HyperLink ID="hlBrowse" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-view-details ssave-u2" >
                <i class="fa-solid fa-plus"></i> Explore More
            </asp:HyperLink>
        </div>
        <asp:DataList ID="dlSaved" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="saved-cards-grid" OnItemCommand="dlSaved_ItemCommand">
            <ItemTemplate>
                <div class="saved-card">
                    <div>
                        <div class="card-top">
                            <asp:Image ID="imgLogo" runat="server" CssClass="company-logo" ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>' />
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
            <div  class="ssave-u3">
                <i class="fa-regular fa-bookmark ssave-u4" ></i>
                <h3  class="ssave-u5">No Saved Internships Yet</h3>
                <p  class="ssave-u6">Bookmark internships while browsing to keep track of interesting opportunities.</p>
                <asp:HyperLink ID="hlBrowseNow" runat="server" NavigateUrl="~/StudentPanel/student-internships.aspx" CssClass="btn-view-details ssave-u7" >
                    <i class="fa-solid fa-briefcase"></i> Browse Internships
                </asp:HyperLink>
            </div>
        </asp:PlaceHolder>
    </div>
</asp:Content>

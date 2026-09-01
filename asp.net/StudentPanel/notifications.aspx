<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="notifications.aspx.cs" Inherits="asp.net.notifications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/internship-module.css">
<link rel="stylesheet" href="../css/communication-module.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="pm-breadcrumb" style="margin-bottom: 24px;">
   <a href="student-dashboard.html">Dashboard</a>
   <i class="fa-solid fa-chevron-right"></i>
   <span class="current">Notifications</span>
 </div>

 <!-- Tabs -->
 <div class="nt-tabs" id="ntTabs">
   <button class="nt-tab active" data-cat="all">All <span class="nt-count" id="countAll">0</span></button>
   <button class="nt-tab" data-cat="internship">Internship</button>
   <button class="nt-tab" data-cat="interview">Interview</button>
   <button class="nt-tab" data-cat="offer">Offer</button>
   <button class="nt-tab" data-cat="certificate">Certificate</button>
   <button class="nt-tab" data-cat="system">System</button>
 </div>

 <!-- Toolbar -->
 <div class="nt-toolbar">
   <div class="nt-search">
     <i class="fa-solid fa-magnifying-glass"></i>
     <input type="text" id="ntSearchInput" placeholder="Search notifications...">
   </div>
   <button class="btn btn-ghost" id="markAllBtn"><i class="fa-solid fa-check-double"></i> Mark All as Read</button>
 </div>

 <!-- List -->
 <div class="nt-list" id="ntList">
   <!-- Injected by JS -->
 </div>

 <div class="im-empty-state" id="ntEmpty" style="display:none;">
   <i class="fa-solid fa-bell-slash im-empty-icon" style="color:#cbd5e1;"></i>
   <h3 class="im-empty-title">No Notifications</h3>
   <p class="im-empty-text">You're all caught up! No notifications match your filter.</p>
 </div>
</asp:Content>


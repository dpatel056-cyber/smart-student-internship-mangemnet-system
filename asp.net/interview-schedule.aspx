<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="interview-schedule.aspx.cs" Inherits="asp.net.interview_schedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/internship-module.css">
<link rel="stylesheet" href="../css/interview-module.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!-- Breadcrumb -->
 <div class="pm-breadcrumb" style="margin-bottom: 24px;">
   <a href="student-dashboard.html">Dashboard</a>
   <i class="fa-solid fa-chevron-right"></i>
   <span class="current">Interview Schedule</span>
 </div>
 
 <div class="im-header">
   <div>
     <h2 class="im-title">Upcoming Interviews</h2>
     <p class="im-subtitle">You have <span id="ivCount">0</span> interviews scheduled.</p>
   </div>
 </div>

 <div class="iv-grid" id="ivGrid">
   <!-- Cards injected by JS -->
 </div>
 
 <div class="im-empty-state" id="noIvResults" style="display:none;">
   <i class="fa-solid fa-calendar-xmark im-empty-icon" style="color: #cbd5e1;"></i>
   <h3 class="im-empty-title">No Interviews Scheduled</h3>
   <p class="im-empty-text">You don't have any upcoming interviews at the moment. Keep applying to internships!</p>
   <a href="browse-internships.html" class="btn btn-primary">Browse Internships</a>
 </div>
</asp:Content>

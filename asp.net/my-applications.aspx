<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="my-applications.aspx.cs" Inherits="asp.net.my_applications" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/internship-module.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pm-breadcrumb" style="margin-bottom: 24px;">
  <a href="student-dashboard.aspx">Dashboard</a>
  <i class="fa-solid fa-chevron-right"></i>
  <span class="current">My Applications</span>
</div>

<div class="im-header" style="flex-wrap: wrap; gap: 16px;">
  <div>
    <h2 class="im-title">Applications</h2>
    <p class="im-subtitle">You have applied to <span id="appCount">0</span> internships.</p>
  </div>
  
  <div class="im-sort-wrap">
    <span class="im-sort-label">Filter by Status:</span>
    <select class="im-sort-select" id="statusFilter">
      <option value="all">All Applications</option>
      <option value="in_review">In Review</option>
      <option value="shortlisted">Shortlisted</option>
      <option value="rejected">Not Selected</option>
    </select>
  </div>
</div>

<div class="im-grid" id="appsGrid">
  <!-- Applications Cards injected by JS -->
</div>

<div class="im-empty-state" id="noAppsResults" style="display:none;">
  <i class="fa-solid fa-paper-plane im-empty-icon" style="color: #cbd5e1;"></i>
  <h3 class="im-empty-title">No Applications Found</h3>
  <p class="im-empty-text" id="noAppsMsg">You haven't applied to any internships yet.</p>
  <a href="browse-internships.html" class="btn btn-primary">Browse Internships</a>
</div>
</asp:Content>

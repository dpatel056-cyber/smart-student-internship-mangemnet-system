<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="profile-completion.aspx.cs" Inherits="asp.net.profile_completion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/profile-module.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="pm-breadcrumb">
  <a href="student-dashboard.html">Dashboard</a>
  <i class="fa-solid fa-chevron-right"></i>
  <a href="my-profile.html">My Profile</a>
  <i class="fa-solid fa-chevron-right"></i>
  <span class="current">Profile Completion</span>
</div>

<!-- Progress hero -->
<div class="pm-progress-hero">
  <div class="pm-progress-hero-top">
    <div>
      <h2 id="pcHeading">Profile 0% Complete</h2>
      <p id="pcSub">Complete your profile to get discovered by more recruiters.</p>
    </div>
    <div class="pm-progress-percent" id="pcPercentBig">0%</div>
  </div>
  <div class="pm-progress-track">
    <div class="pm-progress-fill" id="pcProgressFill" style="width:0%;"></div>
  </div>
</div>

<div class="pm-flex-end">
  <button type="button" class="btn btn-primary" id="completeRemainingBtn"><i class="fa-solid fa-forward"></i> Complete Remaining Details</button>
</div>

<!-- Completed / Missing -->
<div class="pm-details-grid">
  <div class="pm-card">
    <div class="pm-card-header">
      <div>
        <h3>Completed Details</h3>
        <p id="completedCountLabel">0 of 0 sections completed</p>
      </div>
    </div>
    <div class="pm-detail-list" id="completedList"></div>
  </div>

  <div class="pm-card">
    <div class="pm-card-header">
      <div>
        <h3>Missing Details</h3>
        <p id="missingCountLabel">0 sections remaining</p>
      </div>
    </div>
    <div class="pm-detail-list" id="missingList"></div>
  </div>
</div>
</asp:Content>


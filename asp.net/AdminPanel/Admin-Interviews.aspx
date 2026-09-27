<%@ Page Title="Interview Management" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-interviews.aspx.cs" Inherits="asp.net.css.admin_interviews" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --iv-primary: #4F46E5;
            --iv-primary-hover: #4338CA;
            --iv-bg: #F8FAFC;
            --iv-card: #FFFFFF;
            --iv-text: #0F172A;
            --iv-muted: #64748B;
            --iv-border: #E2E8F0;
            --iv-shadow-sm: 0 1px 2px 0 rgb(0 0 0/0.05);
            --iv-shadow-md: 0 4px 6px -1px rgb(0 0 0/0.1),0 2px 4px -2px rgb(0 0 0/0.1);
            --iv-shadow-lg: 0 10px 15px -3px rgb(0 0 0/0.1),0 4px 6px -4px rgb(0 0 0/0.1);
            --iv-radius: 12px;
            --iv-radius-lg: 16px;
            --iv-green: #10B981;
            --iv-orange: #F59E0B;
            --iv-red: #EF4444;
            --iv-blue: #3B82F6;
            --iv-purple: #8B5CF6;
        }

        .iv-page {
            font-family: 'Inter', sans-serif;
            background: var(--iv-bg);
            padding: 24px;
            min-height: calc(100vh - 80px);
            display: flex;
            flex-direction: column;
            gap: 24px;
        }

        /* ── Header ── */
        .iv-header { display: flex; justify-content: space-between; align-items: flex-start; }
        .iv-header h1 { font-size: 24px; font-weight: 700; color: var(--iv-text); margin: 0 0 4px 0; }
        .iv-header p  { font-size: 14px; color: var(--iv-muted); margin: 0; }
        .iv-header-actions { display: flex; align-items: center; gap: 12px; }

        .iv-btn-primary {
            padding: 10px 18px; background: var(--iv-primary); border: none;
            border-radius: 8px; color: #fff; font-size: 14px; font-weight: 600;
            cursor: pointer; display: inline-flex; align-items: center; gap: 8px; transition: background .2s;
        }
        .iv-btn-primary:hover { background: var(--iv-primary-hover); }

        .iv-btn-outline {
            padding: 10px 16px; background: #fff; border: 1px solid var(--iv-border);
            border-radius: 8px; color: var(--iv-text); font-size: 14px; font-weight: 600;
            cursor: pointer; display: inline-flex; align-items: center; gap: 8px; transition: all .2s;
        }
        .iv-btn-outline:hover { background: #F1F5F9; border-color: #CBD5E1; }

        .iv-btn-icon {
            padding: 10px; background: #fff; border: 1px solid var(--iv-border);
            border-radius: 8px; color: var(--iv-muted); cursor: pointer; display: flex;
            align-items: center; justify-content: center; transition: all .2s;
        }
        .iv-btn-icon:hover { color: var(--iv-primary); background: #F8FAFC; }

        .iv-admin-pill {
            display: flex; align-items: center; gap: 10px;
            border-left: 1px solid var(--iv-border); padding-left: 14px;
        }
        .iv-admin-info { display: flex; flex-direction: column; }
        .iv-admin-name { font-size: 14px; font-weight: 700; color: var(--iv-text); }
        .iv-admin-role { font-size: 12px; color: var(--iv-muted); }
        .iv-admin-avatar {
            width: 38px; height: 38px; background: var(--iv-primary); color: #fff;
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-weight: 600; font-size: 16px;
        }

        /* ── Stats Cards ── */
        .iv-stats { display: grid; grid-template-columns: repeat(5,1fr); gap: 18px; }
        .iv-stat-card {
            background: var(--iv-card); border-radius: var(--iv-radius);
            border: 1px solid var(--iv-border); padding: 18px 20px;
            box-shadow: var(--iv-shadow-sm); display: flex; align-items: center; gap: 14px;
            cursor: pointer; transition: transform .2s, box-shadow .2s, border-color .2s;
        }
        .iv-stat-card:hover, .iv-stat-card.active { transform: translateY(-2px); box-shadow: 0 8px 18px rgba(15,23,42,.12); border-color: #4F46E5; }
        .iv-stat-icon {
            width: 44px; height: 44px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center; font-size: 18px;
        }
        .ic-indigo { background: #EEF2FF; color: #4F46E5; }
        .ic-orange { background: #FFF7ED; color: #EA580C; }
        .ic-blue   { background: #EFF6FF; color: #2563EB; }
        .ic-green  { background: #DCFCE7; color: #16A34A; }
        .ic-red    { background: #FEF2F2; color: #DC2626; }
        .iv-stat-label { font-size: 12px; font-weight: 600; color: var(--iv-muted); text-transform: uppercase; letter-spacing: .05em; }
        .iv-stat-value { font-size: 26px; font-weight: 700; color: var(--iv-text); line-height: 1; margin-top: 2px; }

        /* ── Filter Bar ── */
        .iv-card {
            background: var(--iv-card); border-radius: var(--iv-radius-lg);
            border: 1px solid var(--iv-border); box-shadow: var(--iv-shadow-md);
            overflow: hidden; display: flex; flex-direction: column;
        }
        .iv-filters {
            padding: 16px 20px; background: #F8FAFC;
            border-bottom: 1px solid var(--iv-border);
            display: flex; gap: 12px; align-items: center; flex-wrap: wrap;
        }
        .iv-search-wrap { flex: 1; min-width: 220px; position: relative; }
        .iv-search-wrap i { position: absolute; left: 13px; top: 50%; transform: translateY(-50%); color: #94A3B8; font-size: 14px; }
        .iv-search-input {
            width: 100%; padding: 10px 14px 10px 36px;
            border: 1px solid var(--iv-border); border-radius: 8px;
            font-size: 14px; outline: none; background: #fff; font-family: inherit;
        }
        .iv-search-input:focus { border-color: var(--iv-primary); }
        .iv-select {
            padding: 10px 30px 10px 13px; border: 1px solid var(--iv-border);
            border-radius: 8px; font-size: 14px; color: var(--iv-text);
            background: #fff url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='%2364748B'%3E%3Cpath stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M19 9l-7 7-7-7'/%3E%3C/svg%3E") no-repeat right 8px center / 16px;
            outline: none; cursor: pointer; appearance: none;
        }
        .iv-btn-clear { background: none; border: none; color: var(--iv-muted); font-size: 14px; font-weight: 500; cursor: pointer; }
        .iv-btn-clear:hover { color: var(--iv-text); text-decoration: underline; }

        /* View Toggle */
        .iv-view-toggle { display: flex; gap: 8px; }
        .iv-toggle-btn {
            padding: 8px 14px; border: 1px solid var(--iv-border);
            border-radius: 7px; font-size: 13px; font-weight: 600;
            cursor: pointer; background: #fff; color: var(--iv-muted); transition: all .2s;
        }
        .iv-toggle-btn.active { background: var(--iv-primary); color: #fff; border-color: var(--iv-primary); }

        /* ── Table ── */
        .iv-table { width: 100%; border-collapse: collapse; }
        .iv-table th {
            background: #F8FAFC; padding: 12px 16px; text-align: left;
            font-size: 11px; font-weight: 700; color: var(--iv-muted);
            text-transform: uppercase; letter-spacing: .06em;
            border-bottom: 1px solid var(--iv-border);
        }
        .iv-table td {
            padding: 14px 16px; border-bottom: 1px solid var(--iv-border);
            font-size: 13px; color: var(--iv-text); vertical-align: middle;
        }
        .iv-table tr:last-child td { border-bottom: none; }
        .iv-table tr:hover td { background: #F8FAFC; }

        .iv-person-cell { display: flex; align-items: center; gap: 10px; }
        .iv-avatar {
            width: 32px; height: 32px; border-radius: 50%;
            color: #fff; display: flex; align-items: center; justify-content: center;
            font-weight: 600; font-size: 12px; flex-shrink: 0;
        }
        .iv-person-name { font-weight: 600; font-size: 13px; }
        .iv-person-sub { font-size: 11px; color: var(--iv-muted); }

        /* Badges */
        .iv-badge {
            display: inline-flex; align-items: center; padding: 4px 9px;
            border-radius: 9999px; font-size: 11px; font-weight: 700;
        }
        .b-scheduled  { background: #FFF7ED; color: #C2410C; }
        .b-confirmed  { background: #EDE9FE; color: #6D28D9; }
        .b-ongoing    { background: #EFF6FF; color: #1D4ED8; }
        .b-completed  { background: #DCFCE7; color: #15803D; }
        .b-rescheduled{ background: #FEF3C7; color: #B45309; }
        .b-cancelled  { background: #FEE2E2; color: #B91C1C; }
        .b-requested  { background: #EFF6FF; color: #2563EB; }

        .r-selected   { background: #DCFCE7; color: #15803D; }
        .r-rejected   { background: #FEE2E2; color: #B91C1C; }
        .r-nextround  { background: #EFF6FF; color: #1D4ED8; }
        .r-onhold     { background: #FEF3C7; color: #B45309; }
        .r-pending    { background: #F1F5F9; color: var(--iv-muted); }

        .iv-type-pill {
            display: inline-flex; align-items: center; gap: 5px;
            padding: 3px 8px; border-radius: 6px; font-size: 11px; font-weight: 600;
            background: #F1F5F9; color: var(--iv-muted);
        }

        /* 3-dot dropdown */
        .iv-dropdown { position: relative; display: inline-block; }
        .iv-dot-btn {
            background: none; border: none; color: #94A3B8;
            cursor: pointer; padding: 6px 8px; border-radius: 6px;
        }
        .iv-dot-btn:hover { background: #F1F5F9; color: var(--iv-text); }
        .iv-dropdown-menu {
            position: absolute; right: 0; top: 100%;
            min-width: 185px; background: #fff;
            border: 1px solid var(--iv-border); border-radius: 8px;
            box-shadow: var(--iv-shadow-lg); z-index: 20;
            display: none; padding: 8px 0;
        }
        .iv-dropdown:hover .iv-dropdown-menu { display: block; }
        .iv-di {
            display: flex; align-items: center; gap: 10px;
            padding: 9px 16px; font-size: 13px; color: var(--iv-text); cursor: pointer;
        }
        .iv-di:hover { background: #F1F5F9; color: var(--iv-primary); }
        .iv-di.danger:hover { background: #FEE2E2; color: var(--iv-red); }

        /* Pagination */
        .iv-pagination {
            padding: 14px 20px; display: flex; justify-content: space-between;
            align-items: center; border-top: 1px solid var(--iv-border); background: #fff;
        }
        .iv-page-info { font-size: 13px; color: var(--iv-muted); }
        .iv-page-controls { display: flex; gap: 5px; align-items: center; }
        .iv-page-btn {
            min-width: 32px; height: 32px; border: 1px solid var(--iv-border);
            background: #fff; color: var(--iv-text); border-radius: 6px;
            font-size: 13px; font-weight: 500; cursor: pointer; padding: 0 10px;
            display: flex; align-items: center; justify-content: center;
        }
        .iv-page-btn:hover:not(:disabled) { background: #F8FAFC; }
        .iv-page-btn.active { background: var(--iv-primary); color: #fff; border-color: var(--iv-primary); }
        .iv-page-btn:disabled { opacity: .45; cursor: not-allowed; }

        /* ── Calendar View ── */
        .iv-calendar-area { display: none; }
        .iv-cal-header {
            display: flex; justify-content: space-between; align-items: center;
            padding: 18px 24px; border-bottom: 1px solid var(--iv-border);
        }
        .iv-cal-title { font-size: 18px; font-weight: 700; color: var(--iv-text); }
        .iv-cal-grid { display: grid; grid-template-columns: repeat(5,1fr); }
        .iv-cal-day-header {
            padding: 10px 16px; font-size: 12px; font-weight: 700;
            color: var(--iv-muted); text-transform: uppercase; text-align: center;
            background: #F8FAFC; border-bottom: 1px solid var(--iv-border);
            border-right: 1px solid var(--iv-border);
        }
        .iv-cal-cell {
            min-height: 140px; padding: 10px; border-right: 1px solid var(--iv-border);
            border-bottom: 1px solid var(--iv-border); position: relative;
        }
        .iv-cal-date {
            font-size: 13px; font-weight: 700; color: var(--iv-text); margin-bottom: 8px;
        }
        .iv-cal-event {
            border-radius: 6px; padding: 6px 8px; margin-bottom: 6px;
            font-size: 11px; cursor: pointer;
        }
        .ev-scheduled { background: #FFF7ED; border-left: 3px solid var(--iv-orange); }
        .ev-completed { background: #DCFCE7; border-left: 3px solid var(--iv-green); }
        .iv-cal-event-time { font-weight: 700; color: var(--iv-text); }
        .iv-cal-event-name { color: var(--iv-muted); }
        .iv-cal-event-company { font-size: 10px; color: #94A3B8; }

        /* ── Detail Drawer ── */
        .iv-drawer-overlay {
            position: fixed; inset: 0; background: rgba(15,23,42,.4);
            z-index: 1000; display: none;
        }
        .iv-drawer {
            position: fixed; top: 0; right: -480px; width: 460px; height: 100vh;
            background: #fff; box-shadow: -6px 0 20px rgba(0,0,0,.12);
            z-index: 1001; transition: right .3s ease; display: flex; flex-direction: column;
        }
        .iv-drawer.open { right: 0; }
        .iv-drawer-head {
            padding: 22px 24px; border-bottom: 1px solid var(--iv-border);
            display: flex; justify-content: space-between; align-items: flex-start;
        }
        .iv-drawer-head h2 { margin: 0 0 4px 0; font-size: 18px; color: var(--iv-text); }
        .iv-drawer-head p  { margin: 0; font-size: 13px; color: var(--iv-muted); }
        .iv-drawer-close { background: none; border: none; font-size: 20px; color: #94A3B8; cursor: pointer; }
        .iv-drawer-body { flex: 1; overflow-y: auto; padding: 24px; }
        .iv-drawer-foot {
            padding: 16px 24px; border-top: 1px solid var(--iv-border);
            background: #F8FAFC; display: flex; gap: 10px;
        }
        .iv-drawer-foot button { flex: 1; justify-content: center; }

        /* Drawer sections */
        .iv-ds-title {
            font-size: 11px; font-weight: 700; color: var(--iv-muted);
            text-transform: uppercase; letter-spacing: .07em;
            margin: 20px 0 10px 0;
        }
        .iv-ds-title:first-child { margin-top: 0; }
        .iv-info-box {
            background: #F8FAFC; border: 1px solid var(--iv-border);
            border-radius: 10px; padding: 14px 16px;
        }
        .iv-dr-row {
            display: flex; justify-content: space-between;
            padding: 7px 0; border-bottom: 1px solid var(--iv-border);
        }
        .iv-dr-row:last-child { border-bottom: none; }
        .iv-dr-label { font-size: 12px; color: var(--iv-muted); font-weight: 500; }
        .iv-dr-value { font-size: 12px; color: var(--iv-text); font-weight: 600; text-align: right; }

        /* Timeline */
        .iv-timeline { display: flex; flex-direction: column; gap: 0; }
        .iv-tl-item { display: flex; gap: 12px; position: relative; padding-bottom: 18px; }
        .iv-tl-item:last-child { padding-bottom: 0; }
        .iv-tl-left { display: flex; flex-direction: column; align-items: center; }
        .iv-tl-dot {
            width: 10px; height: 10px; border-radius: 50%;
            background: var(--iv-primary); border: 2px solid white;
            box-shadow: 0 0 0 2px var(--iv-primary); flex-shrink: 0;
        }
        .iv-tl-line {
            width: 2px; flex: 1; background: #E2E8F0; margin-top: 4px;
        }
        .iv-tl-item:last-child .iv-tl-line { display: none; }
        .iv-tl-content { flex: 1; }
        .iv-tl-event { font-size: 13px; font-weight: 600; color: var(--iv-text); }
        .iv-tl-time  { font-size: 11px; color: var(--iv-muted); margin-top: 2px; }

        /* Result card */
        .iv-result-card {
            background: #F0FDF4; border: 1px solid #BBF7D0;
            border-radius: 10px; padding: 16px;
        }
        .iv-result-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .iv-result-title { font-size: 14px; font-weight: 700; color: var(--iv-text); }
        .iv-stars { color: #F59E0B; font-size: 13px; }
        .iv-rating-row { display: flex; justify-content: space-between; align-items: center; padding: 5px 0; font-size: 13px; }
        .iv-rating-row span:first-child { color: var(--iv-muted); }
        .iv-rating-row span:last-child  { color: var(--iv-text); font-weight: 600; }
        .iv-feedback-box {
            margin-top: 12px; padding: 10px 12px; background: #fff;
            border-radius: 8px; font-size: 13px; color: var(--iv-muted);
            font-style: italic; border: 1px solid #D1FAE5;
        }

        /* ── Modals ── */
        .iv-overlay {
            position: fixed; inset: 0; background: rgba(15,23,42,.5);
            backdrop-filter: blur(2px); z-index: 1100;
            display: none; align-items: center; justify-content: center;
        }
        .iv-modal {
            background: #fff; border-radius: var(--iv-radius-lg);
            box-shadow: var(--iv-shadow-lg); width: 100%; overflow: hidden;
        }
        .iv-modal-lg { max-width: 640px; }
        .iv-modal-sm { max-width: 420px; }

        .iv-modal-head {
            padding: 20px 24px; border-bottom: 1px solid var(--iv-border);
            display: flex; justify-content: space-between; align-items: center;
        }
        .iv-modal-head h2 { margin: 0; font-size: 18px; font-weight: 700; color: var(--iv-text); }
        .iv-modal-close-btn { background: none; border: none; font-size: 20px; color: #94A3B8; cursor: pointer; }
        .iv-modal-body { padding: 24px; }
        .iv-modal-foot {
            padding: 16px 24px; border-top: 1px solid var(--iv-border);
            background: #F8FAFC; display: flex; justify-content: flex-end; gap: 12px;
        }

        .iv-fg { margin-bottom: 16px; }
        .iv-fl { display: block; font-size: 12px; font-weight: 600; color: var(--iv-text); margin-bottom: 5px; }
        .iv-fi {
            width: 100%; padding: 9px 13px; border: 1px solid var(--iv-border);
            border-radius: 8px; font-size: 14px; font-family: inherit;
            outline: none; background: #fff;
        }
        .iv-fi:focus { border-color: var(--iv-primary); }
        .iv-form-row { display: flex; gap: 16px; }
        .iv-form-row .iv-fg { flex: 1; }

        .iv-checkbox-row { display: flex; align-items: center; gap: 8px; font-size: 13px; color: var(--iv-text); margin-bottom: 10px; }

        /* Cancel modal */
        .iv-danger-icon {
            width: 64px; height: 64px; background: #FEE2E2; color: var(--iv-red);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 28px; margin: 0 auto 16px;
        }
        .iv-modal-sm .iv-modal-body { text-align: center; }
        .iv-modal-sm p { font-size: 14px; color: var(--iv-muted); margin: 0 0 20px 0; }

        .iv-notif-tag {
            display: inline-flex; align-items: center; gap: 6px;
            font-size: 11px; color: var(--iv-green); font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="iv-page">

  <!-- Header -->
  <div class="iv-header">
    <div><h1>Interview Management</h1><p>Monitor and manage student-company interviews across the internship platform.</p></div>
    <div class="iv-header-actions">
      <button class="iv-btn-primary" onclick="openSchedule()"><i class="fa-solid fa-plus"></i> Schedule Interview</button>
    </div>
  </div>

  <!-- Stats -->
  <div class="iv-stats">
    <div class="iv-stat-card active" data-interview-filter="all"><div class="iv-stat-icon ic-indigo"><i class="fa-solid fa-calendar-days"></i></div><div><div class="iv-stat-label">Total</div><div class="iv-stat-value">248</div></div></div>
    <div class="iv-stat-card" data-interview-filter="upcoming"><div class="iv-stat-icon ic-orange"><i class="fa-solid fa-clock"></i></div><div><div class="iv-stat-label">Upcoming</div><div class="iv-stat-value">32</div></div></div>
    <div class="iv-stat-card" data-interview-filter="today"><div class="iv-stat-icon ic-blue"><i class="fa-solid fa-calendar-day"></i></div><div><div class="iv-stat-label">Today</div><div class="iv-stat-value">8</div></div></div>
    <div class="iv-stat-card" data-interview-filter="completed"><div class="iv-stat-icon ic-green"><i class="fa-solid fa-circle-check"></i></div><div><div class="iv-stat-label">Completed</div><div class="iv-stat-value">190</div></div></div>
    <div class="iv-stat-card" data-interview-filter="cancelled"><div class="iv-stat-icon ic-red"><i class="fa-solid fa-ban"></i></div><div><div class="iv-stat-label">Cancelled</div><div class="iv-stat-value">18</div></div></div>
  </div>

  <!-- Table Card -->
  <div class="iv-card">
    <div class="iv-filters">
      <div class="iv-search-wrap"><i class="fa-solid fa-magnifying-glass"></i><input class="iv-search-input" placeholder="Search student, company, internship or interview ID..." /></div>
      <select class="iv-select"><option>All Status</option><option>Requested</option><option>Scheduled</option><option>Confirmed</option><option>Ongoing</option><option>Completed</option><option>Rescheduled</option><option>Cancelled</option></select>
      <select class="iv-select"><option>Company</option></select>
      <select class="iv-select"><option>Interview Type</option><option>Online</option><option>Offline</option><option>Phone</option></select>
      <select class="iv-select"><option>Round</option><option>HR Round</option><option>Technical Round</option><option>Managerial Round</option><option>Final Round</option></select>
      <select class="iv-select"><option>Date Range</option><option>Today</option><option>This Week</option><option>This Month</option></select>
      <button class="iv-btn-clear">Clear Filters</button>
    </div>

    <!-- List View -->
    <div id="listView">
      <div style="overflow-x:auto;">
        <table class="iv-table">
          <thead><tr>
            <th>Student</th><th>Company</th><th>Interview ID</th><th>Date &amp; Time</th><th>Type</th><th>Round</th><th>Status</th><th>Result</th><th>Action</th>
          </tr></thead>
          <tbody>
            <tr>
              <td><div class="iv-person-cell"><div class="iv-avatar" style="background:#4F46E5">DP</div><div><div class="iv-person-name">Dhruvi Patel</div><div class="iv-person-sub">Web Developer Intern</div></div></div></td>
              <td><div class="iv-person-cell"><div class="iv-avatar" style="background:#0EA5E9;border-radius:6px">AB</div><div><div class="iv-person-name">ABC Technologies</div></div></div></td>
              <td style="font-family:monospace;font-weight:600;">INT001</td>
              <td><div style="font-weight:600;font-size:13px;">25 Aug 2026</div><div style="font-size:11px;color:var(--iv-muted);">10:00 AM</div></td>
              <td><span class="iv-type-pill"><i class="fa-solid fa-video"></i> Online</span></td>
              <td><span style="font-size:12px;font-weight:600;">Technical</span></td>
              <td><span class="iv-badge b-scheduled">Scheduled</span></td>
              <td><span class="iv-badge r-pending">&#8212;</span></td>
              <td>
                <div class="iv-dropdown">
                  <button class="iv-dot-btn" onclick="openDrawer()"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                  <div class="iv-dropdown-menu">
                    <div class="iv-di" onclick="openDrawer()"><i class="fa-solid fa-eye"></i> View Details</div>
                    <div class="iv-di"><i class="fa-solid fa-pen"></i> Edit Interview</div>
                    <div class="iv-di" onclick="openReschedule()"><i class="fa-solid fa-calendar-xmark"></i> Reschedule</div>
                    <div class="iv-di danger" onclick="openCancel()"><i class="fa-solid fa-ban"></i> Cancel Interview</div>
                    <div class="iv-di"><i class="fa-solid fa-user"></i> View Student</div>
                    <div class="iv-di"><i class="fa-solid fa-building"></i> View Company</div>
                    <div class="iv-di"><i class="fa-solid fa-file"></i> View Application</div>
                    <div class="iv-di danger"><i class="fa-solid fa-trash"></i> Delete</div>
                  </div>
                </div>
              </td>
            </tr>
            <tr>
              <td><div class="iv-person-cell"><div class="iv-avatar" style="background:#EC4899">RS</div><div><div class="iv-person-name">Rahul Shah</div><div class="iv-person-sub">Python Developer Intern</div></div></div></td>
              <td><div class="iv-person-cell"><div class="iv-avatar" style="background:#8B5CF6;border-radius:6px">XY</div><div><div class="iv-person-name">XYZ Solutions</div></div></div></td>
              <td style="font-family:monospace;font-weight:600;">INT002</td>
              <td><div style="font-weight:600;font-size:13px;">25 Aug 2026</div><div style="font-size:11px;color:var(--iv-muted);">02:00 PM</div></td>
              <td><span class="iv-type-pill"><i class="fa-solid fa-location-dot"></i> Offline</span></td>
              <td><span style="font-size:12px;font-weight:600;">HR</span></td>
              <td><span class="iv-badge b-scheduled">Scheduled</span></td>
              <td><span class="iv-badge r-pending">&#8212;</span></td>
              <td><div class="iv-dropdown"><button class="iv-dot-btn"><i class="fa-solid fa-ellipsis-vertical"></i></button></div></td>
            </tr>
            <tr>
              <td><div class="iv-person-cell"><div class="iv-avatar" style="background:#10B981">PP</div><div><div class="iv-person-name">Priya Patel</div><div class="iv-person-sub">UI/UX Intern</div></div></div></td>
              <td><div class="iv-person-cell"><div class="iv-avatar" style="background:#F59E0B;border-radius:6px">TN</div><div><div class="iv-person-name">TechNova Pvt Ltd</div></div></div></td>
              <td style="font-family:monospace;font-weight:600;">INT003</td>
              <td><div style="font-weight:600;font-size:13px;">24 Aug 2026</div><div style="font-size:11px;color:var(--iv-muted);">11:00 AM</div></td>
              <td><span class="iv-type-pill"><i class="fa-solid fa-video"></i> Online</span></td>
              <td><span style="font-size:12px;font-weight:600;">HR</span></td>
              <td><span class="iv-badge b-completed">Completed</span></td>
              <td><span class="iv-badge r-selected">Selected</span></td>
              <td><div class="iv-dropdown"><button class="iv-dot-btn"><i class="fa-solid fa-ellipsis-vertical"></i></button></div></td>
            </tr>
            <tr>
              <td><div class="iv-person-cell"><div class="iv-avatar" style="background:#EF4444">AS</div><div><div class="iv-person-name">Amit Shah</div><div class="iv-person-sub">Data Analyst Intern</div></div></div></td>
              <td><div class="iv-person-cell"><div class="iv-avatar" style="background:#64748B;border-radius:6px">BS</div><div><div class="iv-person-name">Bright Solutions</div></div></div></td>
              <td style="font-family:monospace;font-weight:600;">INT004</td>
              <td><div style="font-weight:600;font-size:13px;">23 Aug 2026</div><div style="font-size:11px;color:var(--iv-muted);">03:00 PM</div></td>
              <td><span class="iv-type-pill"><i class="fa-solid fa-video"></i> Online</span></td>
              <td><span style="font-size:12px;font-weight:600;">Technical</span></td>
              <td><span class="iv-badge b-completed">Completed</span></td>
              <td><span class="iv-badge r-rejected">Rejected</span></td>
              <td><div class="iv-dropdown"><button class="iv-dot-btn"><i class="fa-solid fa-ellipsis-vertical"></i></button></div></td>
            </tr>
          </tbody>
        </table>
      </div>
      <div class="iv-pagination">
        <div class="iv-page-info">Showing 1-10 of 248 interviews</div>
        <div style="display:flex;align-items:center;gap:20px;">
          <span style="font-size:13px;color:var(--iv-muted);">Rows per page: <select class="iv-select iv-page-size" style="padding:4px 24px 4px 10px;"><option value="10">10</option><option value="20">20</option><option value="50">50</option></select></span>
          <div class="iv-page-controls">
            <button type="button" class="iv-page-btn iv-prev">Previous</button>
            <div class="iv-page-numbers" style="display:flex;gap:6px;"></div>
            <button type="button" class="iv-page-btn iv-next">Next</button>
          </div>
        </div>
      </div>
    </div>

  </div>
</div>

<!-- Detail Drawer -->
<div class="iv-drawer-overlay" id="drawerOverlay" onclick="closeDrawer()"></div>
<div class="iv-drawer" id="ivDrawer">
  <div class="iv-drawer-head">
    <div><h2>Interview Details</h2><p>INT001 &bull; <span class="iv-badge b-scheduled" style="font-size:11px;">Scheduled</span></p></div>
    <button class="iv-drawer-close" onclick="closeDrawer()"><i class="fa-solid fa-xmark"></i></button>
  </div>
  <div class="iv-drawer-body">
    <p class="iv-ds-title">Student Information</p>
    <div class="iv-info-box">
      <div class="iv-dr-row"><span class="iv-dr-label">Name</span><span class="iv-dr-value">Dhruvi Patel</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Student ID</span><span class="iv-dr-value">STU001</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Email</span><span class="iv-dr-value">dhruvi@gmail.com</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Course</span><span class="iv-dr-value">BCA</span></div>
    </div>
    <p class="iv-ds-title">Company Information</p>
    <div class="iv-info-box">
      <div class="iv-dr-row"><span class="iv-dr-label">Company</span><span class="iv-dr-value">ABC Technologies</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Company ID</span><span class="iv-dr-value">COM001</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Position</span><span class="iv-dr-value">Web Developer Intern</span></div>
    </div>
    <p class="iv-ds-title">Interview Information</p>
    <div class="iv-info-box">
      <div class="iv-dr-row"><span class="iv-dr-label">Date</span><span class="iv-dr-value">25 August 2026</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Time</span><span class="iv-dr-value">10:00 AM - 11:00 AM</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Type</span><span class="iv-dr-value">Online</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Round</span><span class="iv-dr-value">Technical Round</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Interviewer</span><span class="iv-dr-value">Rahul Shah</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Application ID</span><span class="iv-dr-value">APP001</span></div>
      <div class="iv-dr-row"><span class="iv-dr-label">Meeting Link</span><span class="iv-dr-value"><a href="#" style="color:var(--iv-primary);">View Meeting</a></span></div>
    </div>
    <p class="iv-ds-title">Notifications</p>
    <div style="display:flex;gap:16px;padding:10px 0;">
      <span class="iv-notif-tag"><i class="fa-solid fa-circle-check"></i> Student notified</span>
      <span class="iv-notif-tag"><i class="fa-solid fa-circle-check"></i> Company notified</span>
    </div>
    <p class="iv-ds-title">Activity Timeline</p>
    <div class="iv-timeline">
      <div class="iv-tl-item"><div class="iv-tl-left"><div class="iv-tl-dot"></div><div class="iv-tl-line"></div></div><div class="iv-tl-content"><div class="iv-tl-event">Application Shortlisted</div><div class="iv-tl-time">21 Aug 2026, 09:20 AM</div></div></div>
      <div class="iv-tl-item"><div class="iv-tl-left"><div class="iv-tl-dot"></div><div class="iv-tl-line"></div></div><div class="iv-tl-content"><div class="iv-tl-event">Interview Requested</div><div class="iv-tl-time">21 Aug 2026, 10:10 AM</div></div></div>
      <div class="iv-tl-item"><div class="iv-tl-left"><div class="iv-tl-dot"></div><div class="iv-tl-line"></div></div><div class="iv-tl-content"><div class="iv-tl-event">Interview Scheduled</div><div class="iv-tl-time">21 Aug 2026, 11:00 AM</div></div></div>
      <div class="iv-tl-item"><div class="iv-tl-left"><div class="iv-tl-dot"></div><div class="iv-tl-line"></div></div><div class="iv-tl-content"><div class="iv-tl-event">Student Notified</div><div class="iv-tl-time">21 Aug 2026, 11:01 AM</div></div></div>
      <div class="iv-tl-item"><div class="iv-tl-left"><div class="iv-tl-dot" style="background:#10B981;box-shadow:0 0 0 2px #10B981;"></div><div class="iv-tl-line"></div></div><div class="iv-tl-content"><div class="iv-tl-event">Company Notified</div><div class="iv-tl-time">21 Aug 2026, 11:01 AM</div></div></div>
    </div>
  </div>
  <div class="iv-drawer-foot">
    <button class="iv-btn-outline"><i class="fa-solid fa-pen"></i> Edit</button>
    <button class="iv-btn-outline" onclick="openReschedule()"><i class="fa-solid fa-calendar-xmark"></i> Reschedule</button>
    <button class="iv-btn-outline" style="color:#EF4444;border-color:#FEE2E2;" onclick="openCancel()"><i class="fa-solid fa-ban"></i> Cancel</button>
  </div>
</div>

<!-- Schedule Modal -->
<div class="iv-overlay" id="scheduleModal">
  <div class="iv-modal iv-modal-lg">
    <div class="iv-modal-head"><h2>Schedule Interview</h2><button class="iv-modal-close-btn" onclick="closeSchedule()"><i class="fa-solid fa-xmark"></i></button></div>
    <div class="iv-modal-body" style="max-height:60vh;overflow-y:auto;">
      <div class="iv-form-row"><div class="iv-fg"><label class="iv-fl">Student</label><select class="iv-fi iv-select"><option>Search and select student...</option><option>Dhruvi Patel</option></select></div><div class="iv-fg"><label class="iv-fl">Company</label><select class="iv-fi iv-select"><option>Select company...</option><option>ABC Technologies</option></select></div></div>
      <div class="iv-form-row"><div class="iv-fg"><label class="iv-fl">Internship</label><select class="iv-fi iv-select"><option>Select internship...</option></select></div><div class="iv-fg"><label class="iv-fl">Application</label><select class="iv-fi iv-select"><option>Select application...</option></select></div></div>
      <div class="iv-form-row"><div class="iv-fg"><label class="iv-fl">Interview Round</label><select class="iv-fi iv-select"><option>Technical Round</option><option>HR Round</option><option>Managerial Round</option><option>Final Round</option></select></div><div class="iv-fg"><label class="iv-fl">Interview Type</label><select class="iv-fi iv-select"><option>Online</option><option>Offline</option><option>Phone</option></select></div></div>
      <div class="iv-form-row"><div class="iv-fg"><label class="iv-fl">Date</label><input type="date" class="iv-fi" value="2026-08-25" /></div><div class="iv-fg"><label class="iv-fl">Start Time</label><input type="time" class="iv-fi" value="10:00" /></div><div class="iv-fg"><label class="iv-fl">End Time</label><input type="time" class="iv-fi" value="11:00" /></div></div>
      <div class="iv-form-row"><div class="iv-fg"><label class="iv-fl">Interviewer</label><select class="iv-fi iv-select"><option>Select interviewer...</option></select></div><div class="iv-fg"><label class="iv-fl">Meeting Link</label><input type="text" class="iv-fi" placeholder="https://meet.google.com/..." /></div></div>
      <div class="iv-fg"><label class="iv-fl">Location (offline only)</label><input type="text" class="iv-fi" placeholder="Enter location..." /></div>
      <div class="iv-fg"><label class="iv-fl">Notes / Instructions</label><textarea class="iv-fi" rows="3" placeholder="Enter interview instructions..."></textarea></div>
      <div class="iv-checkbox-row"><input type="checkbox" checked /> Notify student</div>
      <div class="iv-checkbox-row"><input type="checkbox" checked /> Notify company</div>
    </div>
    <div class="iv-modal-foot"><button class="iv-btn-outline" onclick="closeSchedule()">Cancel</button><button class="iv-btn-primary" onclick="closeSchedule()">Schedule Interview</button></div>
  </div>
</div>

<!-- Reschedule Modal -->
<div class="iv-overlay" id="rescheduleModal">
  <div class="iv-modal iv-modal-sm">
    <div class="iv-modal-head"><h2>Reschedule Interview</h2><button class="iv-modal-close-btn" onclick="closeReschedule()"><i class="fa-solid fa-xmark"></i></button></div>
    <div class="iv-modal-body">
      <div style="background:#F8FAFC;border:1px solid var(--iv-border);border-radius:8px;padding:12px 16px;margin-bottom:20px;">
        <div style="font-size:12px;color:var(--iv-muted);margin-bottom:4px;">Current Schedule</div>
        <div style="font-size:15px;font-weight:700;color:var(--iv-text);">25 Aug 2026 &bull; 10:00 AM</div>
      </div>
      <div class="iv-form-row"><div class="iv-fg"><label class="iv-fl">New Date</label><input type="date" class="iv-fi" /></div><div class="iv-fg"><label class="iv-fl">New Time</label><input type="time" class="iv-fi" /></div></div>
      <div class="iv-fg"><label class="iv-fl">Reason for Rescheduling</label><textarea class="iv-fi" rows="3" placeholder="Enter reason..."></textarea></div>
    </div>
    <div class="iv-modal-foot"><button class="iv-btn-outline" onclick="closeReschedule()">Cancel</button><button class="iv-btn-primary" onclick="closeReschedule()">Reschedule Interview</button></div>
  </div>
</div>

<!-- Cancel Modal -->
<div class="iv-overlay" id="cancelModal">
  <div class="iv-modal iv-modal-sm">
    <div class="iv-modal-body" style="text-align:center;padding:32px 24px;">
      <div class="iv-danger-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
      <h3 style="font-size:20px;font-weight:700;color:var(--iv-text);margin:0 0 8px;">Cancel Interview?</h3>
      <p>Are you sure you want to cancel this interview? The student and company will be notified.</p>
      <div style="text-align:left;margin-bottom:20px;"><label class="iv-fl">Reason for Cancellation</label><textarea class="iv-fi" rows="3" placeholder="Enter cancellation reason..."></textarea></div>
      <div style="display:flex;gap:12px;">
        <button class="iv-btn-outline" style="flex:1;justify-content:center;" onclick="closeCancel()">Cancel</button>
        <button class="iv-btn-primary" style="flex:1;justify-content:center;background:#EF4444;" onclick="closeCancel()">Confirm Cancellation</button>
      </div>
    </div>
  </div>
</div>

<script>
  function openDrawer()    { document.getElementById('drawerOverlay').style.display='block'; document.getElementById('ivDrawer').classList.add('open'); }
  function closeDrawer()   { document.getElementById('drawerOverlay').style.display='none';  document.getElementById('ivDrawer').classList.remove('open'); }
  function openSchedule()  { document.getElementById('scheduleModal').style.display='flex'; }
  function closeSchedule() { document.getElementById('scheduleModal').style.display='none'; }
  function openReschedule(){ document.getElementById('rescheduleModal').style.display='flex'; }
  function closeReschedule(){ document.getElementById('rescheduleModal').style.display='none'; }
  function openCancel()    { document.getElementById('cancelModal').style.display='flex'; }
  function closeCancel()   { document.getElementById('cancelModal').style.display='none'; }
  document.addEventListener('DOMContentLoaded', function () {
    var cards = Array.prototype.slice.call(document.querySelectorAll('.iv-stat-card[data-interview-filter]'));
    var body = document.querySelector('.iv-table tbody');
    var info = document.querySelector('.iv-page-info');
    if (!body || !cards.length) return;
    var rows = Array.prototype.slice.call(body.querySelectorAll('tr'));
    var cancelledRow = rows[3] ? rows[3].cloneNode(true) : null;
    if (cancelledRow) {
      cancelledRow.querySelector('td:nth-child(1) .iv-person-name').textContent = 'Meera Joshi';
      cancelledRow.querySelector('td:nth-child(3)').textContent = 'INT005';
      cancelledRow.querySelector('td:nth-child(7)').innerHTML = '<span class="iv-badge b-cancelled">Cancelled</span>';
      body.appendChild(cancelledRow);
      rows.push(cancelledRow);
    }
    rows.forEach(function (row, index) {
      row.dataset.interviewCategory = index < 2 ? 'upcoming' : 'completed';
      if (index === 0) row.dataset.interviewCategory += ' today';
      if (row.querySelector('.b-cancelled')) row.dataset.interviewCategory = 'cancelled';
    });
    var search = document.querySelector('.iv-search-input');
    var filters = Array.prototype.slice.call(document.querySelectorAll('.iv-filters > .iv-select'));
    var activeCategory = 'all';
    var companies = rows.map(function (row) { return row.cells[1].textContent.trim(); }).filter(function (value, index, list) { return list.indexOf(value) === index; });
    filters[1].innerHTML = '<option>Company</option>' + companies.map(function (company) { return '<option>' + company + '</option>'; }).join('');
    var pageSizeSelect = document.querySelector('.iv-page-size');
    var pageNumbers = document.querySelector('.iv-page-numbers');
    var previousButton = document.querySelector('.iv-prev');
    var nextButton = document.querySelector('.iv-next');
    var currentPage = 1;
    var matchingRows = [];
    var applyFilters = function () {
      var query = (search.value || '').toLowerCase().trim();
      var status = filters[0].value === 'All Status' ? '' : filters[0].value.toLowerCase();
      var company = filters[1].value === 'Company' ? '' : filters[1].value.toLowerCase();
      var type = filters[2].value === 'Interview Type' ? '' : filters[2].value.toLowerCase();
      var round = filters[3].value === 'Round' ? '' : filters[3].value.toLowerCase();
      var dateRange = filters[4].value === 'Date Range' ? '' : filters[4].value.toLowerCase();
      var visible = rows.filter(function (row) {
        var text = row.textContent.toLowerCase();
        return (activeCategory === 'all' || row.dataset.interviewCategory.indexOf(activeCategory) !== -1) &&
          (!query || text.indexOf(query) !== -1) && (!status || text.indexOf(status) !== -1) &&
          (!company || text.indexOf(company) !== -1) && (!type || text.indexOf(type) !== -1) &&
          (!round || text.indexOf(round.replace(' round', '')) !== -1) &&
          (!dateRange || (dateRange === 'today' ? row.dataset.interviewCategory.indexOf('today') !== -1 : dateRange === 'this week' ? row.dataset.interviewCategory.indexOf('upcoming') !== -1 : true));
      });
      matchingRows = visible;
      var pageSize = Number(pageSizeSelect.value) || 10;
      var totalPages = Math.max(1, Math.ceil(matchingRows.length / pageSize));
      currentPage = Math.min(currentPage, totalPages);
      var start = (currentPage - 1) * pageSize;
      var pageRows = matchingRows.slice(start, start + pageSize);
      rows.forEach(function (row) { row.style.display = pageRows.indexOf(row) === -1 ? 'none' : ''; });
      info.textContent = matchingRows.length ? 'Showing ' + (start + 1) + '-' + Math.min(start + pageSize, matchingRows.length) + ' of ' + matchingRows.length + ' interviews' : 'No interviews found';
      previousButton.disabled = currentPage === 1;
      nextButton.disabled = currentPage === totalPages;
      pageNumbers.innerHTML = '';
      for (var page = 1; page <= totalPages; page += 1) {
        var button = document.createElement('button');
        button.type = 'button'; button.className = 'iv-page-btn' + (page === currentPage ? ' active' : ''); button.textContent = page;
        button.addEventListener('click', (function (selectedPage) { return function () { currentPage = selectedPage; applyFilters(); }; })(page));
        pageNumbers.appendChild(button);
      }
    };
    search.addEventListener('input', function () { currentPage = 1; applyFilters(); });
    filters.forEach(function (filter) { filter.addEventListener('change', function () { currentPage = 1; applyFilters(); }); });
    pageSizeSelect.addEventListener('change', function () { currentPage = 1; applyFilters(); });
    previousButton.addEventListener('click', function () { if (currentPage > 1) { currentPage -= 1; applyFilters(); } });
    nextButton.addEventListener('click', function () { if (currentPage < Math.ceil(matchingRows.length / Number(pageSizeSelect.value))) { currentPage += 1; applyFilters(); } });
    document.querySelector('.iv-btn-clear').addEventListener('click', function () {
      search.value = ''; filters.forEach(function (filter) { filter.selectedIndex = 0; }); activeCategory = 'all'; currentPage = 1;
      cards.forEach(function (card, index) { card.classList.toggle('active', index === 0); }); applyFilters();
    });
    cards.forEach(function (card) {
      card.addEventListener('click', function () {
        activeCategory = card.dataset.interviewFilter;
        cards.forEach(function (item) { item.classList.toggle('active', item === card); });
        applyFilters();
        document.getElementById('listView').scrollIntoView({ behavior: 'smooth', block: 'start' });
      });
    });
  });
</script>
</asp:Content>

<%@ Page Title="Browse Internships" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-internships.aspx.cs" Inherits="asp.net.student_internships" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/style.css") %>" />
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/internship-module.css") %>" />
    <style>
        .internships-page-container {
            width: 100%;
            padding: 10px 0 40px 0;
        }
        .internships-searchbar {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 14px 18px;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 24px;
            box-shadow: 0 4px 14px rgba(15,23,42,0.03);
        }
        .companies-search-input {
            flex: 2;
            min-width: 220px;
            position: relative;
            display: flex;
            align-items: center;
        }
        .companies-search-input i {
            position: absolute;
            left: 14px;
            color: #94a3b8;
            font-size: 14px;
        }
        .companies-search-input input {
            width: 100%;
            padding: 10px 14px 10px 38px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            font-size: 14px;
            color: #1e293b;
            outline: none;
            box-sizing: border-box;
        }
        .companies-select-wrap {
            flex: 1;
            min-width: 150px;
            position: relative;
            display: flex;
            align-items: center;
        }
        .select-prefix-icon {
            position: absolute;
            left: 12px;
            color: #94a3b8;
            font-size: 13.5px;
            pointer-events: none;
        }
        .select-caret {
            position: absolute;
            right: 12px;
            color: #94a3b8;
            font-size: 12px;
            pointer-events: none;
        }
        .companies-select-wrap select {
            width: 100%;
            padding: 10px 28px 10px 34px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            font-size: 13.5px;
            color: #334155;
            background: #ffffff;
            outline: none;
            cursor: pointer;
            appearance: none;
            -webkit-appearance: none;
            box-sizing: border-box;
        }
        .internships-layout {
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 24px;
            align-items: flex-start;
        }
        @media (max-width: 992px) {
            .internships-layout {
                grid-template-columns: 1fr;
            }
        }
        .filters-sidebar {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 22px;
            box-shadow: 0 2px 8px rgba(15,23,42,0.03);
        }
        .internships-filters-head {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
            padding-bottom: 12px;
            border-bottom: 1px solid #f1f5f9;
        }
        .internships-filters-head h3 {
            font-size: 16px;
            font-weight: 700;
            color: #0f172a;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .clear-all-btn {
            background: transparent;
            border: none;
            color: #2563eb;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            padding: 0;
        }
        .clear-all-btn:hover {
            text-decoration: underline;
        }
        .filter-block {
            margin-bottom: 18px;
        }
        .block-label {
            display: block;
            font-size: 13px;
            font-weight: 600;
            color: #475569;
            margin-bottom: 8px;
        }
        .filter-block input[type="text"],
        .filter-block select {
            width: 100%;
            padding: 9px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            color: #1e293b;
            outline: none;
            box-sizing: border-box;
        }
        .filter-checkbox-list {
            list-style: none !important;
            padding: 0 !important;
            margin: 0 !important;
            display: flex !important;
            flex-direction: column !important;
            gap: 10px !important;
        }
        .filter-checkbox-list li {
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
            margin: 0 !important;
            padding: 0 !important;
            list-style: none !important;
        }
        .filter-checkbox-list li input[type="checkbox"] {
            width: 17px !important;
            height: 17px !important;
            min-width: 17px !important;
            max-width: 17px !important;
            margin: 0 !important;
            padding: 0 !important;
            accent-color: #2563eb !important;
            cursor: pointer !important;
            display: inline-block !important;
            vertical-align: middle !important;
            box-shadow: none !important;
        }
        .filter-checkbox-list li label {
            font-size: 13.5px !important;
            color: #334155 !important;
            cursor: pointer !important;
            margin: 0 !important;
            padding: 0 !important;
            font-weight: 500 !important;
            line-height: 1.2 !important;
            user-select: none !important;
            display: inline-block !important;
            vertical-align: middle !important;
        }
        .filter-checkbox-list li:hover label {
            color: #2563eb !important;
        }
        .btn-apply-filters {
            width: 100%;
            padding: 11px;
            background: #2563eb;
            color: #ffffff;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: background 0.2s;
        }
        .btn-apply-filters:hover {
            background: #1d4ed8;
        }
        /* Results Area */
        .internships-results-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 12px;
        }
        .results-count {
            font-size: 14.5px;
            font-weight: 600;
            color: #475569;
        }
        .sort-by-wrap {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13.5px;
            color: #64748b;
        }
        .sort-by-wrap select {
            padding: 6px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13px;
            color: #334155;
            outline: none;
        }
        /* Internship Cards Grid & Box */
        .internship-datalist-wrapper {
            width: 100%;
        }
        .internship-card-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            width: 100%;
        }
        @media (min-width: 1400px) {
            .internship-card-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }
        @media (max-width: 768px) {
            .internship-card-grid {
                grid-template-columns: 1fr;
            }
        }
        .internship-card-box {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 24px 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.03);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 250px;
        }
        .internship-card-box:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 24px rgba(37, 99, 235, 0.12);
            border-color: #cbd5e1;
        }
        .card-top-row {
            display: flex;
            align-items: flex-start;
            gap: 14px;
            margin-bottom: 16px;
            position: relative;
            padding-right: 30px;
        }
        .company-logo-wrap {
            width: 50px;
            height: 50px;
            border-radius: 14px;
            background: #ffffff;
            border: 1px solid #e2e8f0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
            padding: 4px;
            box-sizing: border-box;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04);
        }
        .company-logo-img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            border-radius: 50%;
            display: block;
        }
        .title-company-wrap {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }
        .internship-card-title {
            font-size: 16.5px;
            font-weight: 700;
            color: #0f172a;
            line-height: 1.3;
            margin: 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .company-card-name {
            font-size: 14px;
            font-weight: 600;
            color: #2563eb;
        }
        .bookmark-btn {
            position: absolute;
            right: 0;
            top: 0;
            color: #cbd5e1;
            font-size: 18px;
            background: transparent;
            border: none;
            cursor: pointer;
            transition: color 0.2s ease;
        }
        .bookmark-btn:hover {
            color: #2563eb;
        }
        .card-details-row {
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
            margin-bottom: 16px;
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }
        .detail-item {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .detail-item i {
            color: #2563eb;
            font-size: 14px;
        }
        .card-stipend-row {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }
        .badge-paid {
            background: #dcfce7;
            color: #16a34a;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12.5px;
            font-weight: 600;
        }
        .badge-unpaid {
            background: #f1f5f9;
            color: #64748b;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12.5px;
            font-weight: 600;
        }
        .stipend-amount {
            font-size: 15.5px;
            font-weight: 700;
            color: #0f172a;
        }
        .card-footer-row {
            border-top: 1px solid #f1f5f9;
            padding-top: 14px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-size: 12.5px;
            color: #64748b;
            font-weight: 500;
        }
        .footer-meta {
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .footer-meta i {
            color: #94a3b8;
            font-size: 13.5px;
        }
        .empty-state-box {
            background: #ffffff;
            border: 2px dashed #cbd5e1;
            border-radius: 16px;
            padding: 50px 20px;
            text-align: center;
            margin-top: 20px;
            width: 100%;
        }
        .empty-state-icon {
            font-size: 48px;
            color: #94a3b8;
            margin-bottom: 16px;
        }
        .empty-state-box h3 {
            font-size: 18px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 8px 0;
        }
        .empty-state-box p {
            font-size: 14px;
            color: #64748b;
            margin: 0;
        }
        /* Pagination Styling */
        .pg-wrap {
            display: flex !important;
            justify-content: center !important;
            align-items: center !important;
            gap: 10px !important;
            margin-top: 40px !important;
            margin-bottom: 24px !important;
            width: 100% !important;
        }
        .pg-link {
            display: inline-flex !important;
            align-items: center !important;
            justify-content: center !important;
            min-width: 42px !important;
            height: 42px !important;
            padding: 0 14px !important;
            border-radius: 10px !important;
            border: 1px solid #e2e8f0 !important;
            background: #ffffff !important;
            color: #334155 !important;
            font-size: 14px !important;
            font-weight: 600 !important;
            text-decoration: none !important;
            box-shadow: 0 2px 6px rgba(15, 23, 42, 0.04) !important;
            transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1) !important;
        }
        .pg-link i {
            color: inherit !important;
        }
        .pg-link:hover:not(.pg-active):not(.pg-disabled) {
            background: #f8fafc !important;
            color: #2563eb !important;
            border-color: #93c5fd !important;
            transform: translateY(-2px) !important;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.12) !important;
            text-decoration: none !important;
        }
        .pg-link.pg-active {
            background: #2563eb !important;
            color: #ffffff !important;
            border-color: #2563eb !important;
            box-shadow: 0 4px 14px rgba(37, 99, 235, 0.3) !important;
            cursor: default !important;
        }
        .pg-link.pg-active i {
            color: #ffffff !important;
        }
        .pg-link.pg-disabled {
            background: #f8fafc !important;
            color: #cbd5e1 !important;
            border-color: #f1f5f9 !important;
            cursor: not-allowed !important;
            box-shadow: none !important;
            pointer-events: none !important;
        }
        .pg-link.pg-disabled i {
            color: #cbd5e1 !important;
        }
        .pg-nav {
            padding: 0 18px !important;
            font-weight: 600 !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="internships-page-container">
        <!-- Top Search & Quick Filters -->
        <div class="internships-searchbar">
            <div class="companies-search-input">
                <i class="fa-solid fa-magnifying-glass"></i>
                <asp:TextBox ID="topKeywordInput" runat="server" placeholder="Job title, role or keyword" />
            </div>
            <div class="companies-select-wrap">
                <i class="fa-solid fa-layer-group select-prefix-icon"></i>
                <asp:DropDownList ID="topCategory" runat="server">
                    <asp:ListItem Text="All Categories" Value="" />
                    <asp:ListItem Text="Software Development" Value="Software Development" />
                    <asp:ListItem Text="Web Development" Value="Web Development" />
                    <asp:ListItem Text="Data Science &amp; AI" Value="Data Science" />
                    <asp:ListItem Text="Design (UI/UX)" Value="Design" />
                    <asp:ListItem Text="Marketing" Value="Marketing" />
                    <asp:ListItem Text="Finance" Value="Finance" />
                    <asp:ListItem Text="Business &amp; Consulting" Value="Business" />
                    <asp:ListItem Text="Product Management" Value="Product" />
                    <asp:ListItem Text="Engineering" Value="Engineering" />
                    <asp:ListItem Text="Healthcare" Value="Healthcare" />
                    <asp:ListItem Text="Education" Value="Education" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down select-caret"></i>
            </div>
            <div class="companies-select-wrap">
                <i class="fa-solid fa-location-dot select-prefix-icon"></i>
                <asp:DropDownList ID="topLocation" runat="server">
                    <asp:ListItem Text="All Locations" Value="" />
                    <asp:ListItem Text="Ahmedabad" Value="Ahmedabad" />
                    <asp:ListItem Text="Bengaluru" Value="Bengaluru" />
                    <asp:ListItem Text="Hyderabad" Value="Hyderabad" />
                    <asp:ListItem Text="Mumbai" Value="Mumbai" />
                    <asp:ListItem Text="Gurugram" Value="Gurugram" />
                    <asp:ListItem Text="Pune" Value="Pune" />
                    <asp:ListItem Text="Noida" Value="Noida" />
                    <asp:ListItem Text="Chennai" Value="Chennai" />
                    <asp:ListItem Text="Gandhinagar" Value="Gandhinagar" />
                    <asp:ListItem Text="Surat" Value="Surat" />
                    <asp:ListItem Text="Vadodara" Value="Vadodara" />
                    <asp:ListItem Text="Remote" Value="Remote" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down select-caret"></i>
            </div>
            <div class="companies-select-wrap">
                <i class="fa-regular fa-clock select-prefix-icon"></i>
                <asp:DropDownList ID="topDuration" runat="server">
                    <asp:ListItem Text="All Durations" Value="" />
                    <asp:ListItem Text="1 Month" Value="1 Month" />
                    <asp:ListItem Text="2-3 Months" Value="3 Months" />
                    <asp:ListItem Text="3-6 Months" Value="6 Months" />
                    <asp:ListItem Text="6+ Months" Value="6+ Months" />
                </asp:DropDownList>
                <i class="fa-solid fa-chevron-down select-caret"></i>
            </div>
            <asp:ImageButton ID="ImageButton1" Height="40" Width="200" runat="server" ImageUrl="~/assets/internship.png" OnClick="btnSearch_Click" AlternateText="Search Internships" />
        </div>
        <!-- Main Layout (Sidebar + Results) -->
        <div class="internships-layout" id="internshipsResultsTop">
            <!-- Filter Sidebar -->
            <aside class="filters-sidebar">
                <div class="internships-filters-head">
                    <h3><i class="fa-solid fa-sliders"></i> Filter Internships</h3>
                    <asp:LinkButton ID="clearAllBtn" runat="server" CssClass="clear-all-btn" OnClick="btnClearAll_Click">Clear All</asp:LinkButton>
                </div>
                <div class="filter-block">
                    <label class="block-label">Keywords</label>
                    <asp:TextBox ID="sideKeywordInput" runat="server" placeholder="Job title, skills, or company" />
                </div>
                <div class="filter-block">
                    <label class="block-label">Category</label>
                    <asp:DropDownList ID="sideCategory" runat="server">
                        <asp:ListItem Text="Select Category" Value="" />
                        <asp:ListItem Text="Software Development" Value="Software Development" />
                        <asp:ListItem Text="Web Development" Value="Web Development" />
                        <asp:ListItem Text="Data Science &amp; AI" Value="Data Science" />
                        <asp:ListItem Text="Design (UI/UX)" Value="Design" />
                        <asp:ListItem Text="Marketing" Value="Marketing" />
                        <asp:ListItem Text="Finance" Value="Finance" />
                        <asp:ListItem Text="Business &amp; Consulting" Value="Business" />
                        <asp:ListItem Text="Product Management" Value="Product" />
                        <asp:ListItem Text="Engineering" Value="Engineering" />
                        <asp:ListItem Text="Healthcare" Value="Healthcare" />
                        <asp:ListItem Text="Education" Value="Education" />
                    </asp:DropDownList>
                </div>
                <div class="filter-block">
                    <label class="block-label">Location</label>
                    <asp:DropDownList ID="sideLocation" runat="server">
                        <asp:ListItem Text="Select Location" Value="" />
                        <asp:ListItem Text="Ahmedabad" Value="Ahmedabad" />
                        <asp:ListItem Text="Bengaluru" Value="Bengaluru" />
                        <asp:ListItem Text="Hyderabad" Value="Hyderabad" />
                        <asp:ListItem Text="Mumbai" Value="Mumbai" />
                        <asp:ListItem Text="Gurugram" Value="Gurugram" />
                        <asp:ListItem Text="Pune" Value="Pune" />
                        <asp:ListItem Text="Noida" Value="Noida" />
                        <asp:ListItem Text="Chennai" Value="Chennai" />
                        <asp:ListItem Text="Gandhinagar" Value="Gandhinagar" />
                        <asp:ListItem Text="Surat" Value="Surat" />
                        <asp:ListItem Text="Vadodara" Value="Vadodara" />
                        <asp:ListItem Text="Remote" Value="Remote" />
                    </asp:DropDownList>
                </div>
                <div class="filter-block">
                    <label class="block-label">Duration</label>
                    <asp:CheckBoxList ID="cblDuration" runat="server" RepeatLayout="UnorderedList" CssClass="filter-checkbox-list">
                        <asp:ListItem Text="1 Month" Value="1 Month" />
                        <asp:ListItem Text="2-3 Months" Value="3 Months" />
                        <asp:ListItem Text="3-6 Months" Value="6 Months" />
                        <asp:ListItem Text="6+ Months" Value="6+ Months" />
                    </asp:CheckBoxList>
                </div>
                <div class="filter-block">
                    <label class="block-label">Stipend</label>
                    <asp:CheckBoxList ID="cblStipend" runat="server" RepeatLayout="UnorderedList" CssClass="filter-checkbox-list">
                        <asp:ListItem Text="Paid" Value="Paid" />
                        <asp:ListItem Text="Unpaid" Value="Unpaid" />
                    </asp:CheckBoxList>
                </div>
                <div class="filter-block">
                    <label class="block-label">Mode</label>
                    <asp:CheckBoxList ID="cblMode" runat="server" RepeatLayout="UnorderedList" CssClass="filter-checkbox-list">
                        <asp:ListItem Text="Work From Home / Remote" Value="Remote" />
                        <asp:ListItem Text="Hybrid" Value="Hybrid" />
                        <asp:ListItem Text="On-site" Value="On-site" />
                    </asp:CheckBoxList>
                </div>
                <div class="filter-block">
                    <asp:ImageButton ID="ImageButton2" runat="server" Height="40" Width="220" ImageUrl="~/assets/filter_button.png" OnClick="btnSearch_Click" AlternateText="Apply Filters" />
                </div>
            </aside>
            <!-- Results Section -->
            <div class="internships-results">
                <div class="internships-results-top">
                    <asp:Label ID="lblResultCount" runat="server" CssClass="results-count">Showing internships...</asp:Label>
                    <div class="sort-by-wrap">
                        <span>Sort by:</span>
                        <asp:DropDownList ID="sortBySelect" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged">
                            <asp:ListItem Text="Newest First" Value="newest" />
                            <asp:ListItem Text="Stipend: High to Low" Value="stipend-desc" />
                            <asp:ListItem Text="Stipend: Low to High" Value="stipend-asc" />
                            <asp:ListItem Text="Duration: Short to Long" Value="duration-asc" />
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="internship-datalist-wrapper">
                    <asp:DataList ID="DataListPublicInternships" runat="server"
                        RepeatLayout="Flow"
                        RepeatDirection="Horizontal"
                        CssClass="internship-card-grid"
                        OnItemCommand="DataListPublicInternships_ItemCommand">
                        <ItemTemplate>
                            <div class="internship-card-box"
                                onclick="window.location.href='<%= ResolveUrl("~/StudentPanel/student-internship-details.aspx") %>?id=<%# Eval("Id") %>';">
                                <!-- Top Row -->
                                <div class="card-top-row">
                                    <div class="company-logo-wrap">
                                        <asp:Image ID="imgCompanyLogo" runat="server"
                                            ImageUrl='<%# GetCompanyLogo(Eval("c_logo")) %>'
                                            CssClass="company-logo-img"
                                            AlternateText="Company Logo" />
                                    </div>
                                    <div class="title-company-wrap">
                                        <h3 class="internship-card-title">
                                            <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>'></asp:Label>
                                        </h3>
                                        <span class="company-card-name">
                                            <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                        </span>
                                    </div>
                                    <asp:LinkButton ID="btnBookmark" runat="server"
                                        CommandName="Bookmark"
                                        CommandArgument='<%# Eval("Id") %>'
                                        CssClass="bookmark-btn"
                                        title="Save Internship"
                                        OnClientClick="event.stopPropagation();">
                                        <i class="fa-regular fa-bookmark"></i>
                                    </asp:LinkButton>
                                </div>
                                <!-- Details Row -->
                                <div class="card-details-row">
                                    <span class="detail-item">
                                        <i class="fa-solid fa-location-dot"></i>
                                        <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                    </span>
                                    <span class="detail-item">
                                        <i class="fa-solid fa-building"></i>
                                        <asp:Label ID="lblWorkMode" runat="server" Text='<%# Eval("WorkMode") %>'></asp:Label>
                                    </span>
                                </div>
                                <!-- Stipend Row -->
                                <div class="card-stipend-row">
                                    <span class='<%# Eval("PaymentStatus") != null && Eval("PaymentStatus").ToString().ToLower() == "unpaid" ? "badge-unpaid" : "badge-paid" %>'>
                                        <asp:Label ID="lblPaymentStatus" runat="server" Text='<%# Eval("PaymentStatus") %>'></asp:Label>
                                    </span>
                                    <span class="stipend-amount">
                                        <i class="fa-solid fa-indian-rupee-sign"></i> <asp:Label ID="lblStipend" runat="server" Text='<%# Eval("StipendAmount") %>'></asp:Label>
                                    </span>
                                </div>
                                <!-- Footer Row -->
                                <div class="card-footer-row">
                                    <span class="footer-meta">
                                        <i class="fa-regular fa-clock"></i>
                                        <asp:Label ID="lblDuration" runat="server" Text='<%# Eval("Duration") %>'></asp:Label>
                                    </span>
                                    <span class="footer-meta posted-time">
                                        <i class="fa-regular fa-calendar-days"></i>
                                        Posted <asp:Label ID="lblPostedDate" runat="server" Text='<%# FormatPostedDate(Eval("PostedDate")) %>'></asp:Label>
                                    </span>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:PlaceHolder ID="pnlNoInternships" runat="server" Visible="false">
                        <div class="empty-state-box">
                            <div class="empty-state-icon">
                                <i class="fa-solid fa-briefcase"></i>
                            </div>
                            <h3>No Internships Available Right Now</h3>
                            <p>Check back later for new opportunities.</p>
                        </div>
                    </asp:PlaceHolder>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

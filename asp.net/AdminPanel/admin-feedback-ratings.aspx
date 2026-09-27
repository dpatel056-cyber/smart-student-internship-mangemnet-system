<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-feedback-ratings.aspx.cs" Inherits="asp.net.css.admin_feedback_ratings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-feedback-ratings.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
<div class="sims-feedback-main-container">

    <!-- ============================================================
         1. TOP HEADER (Buttons removed as requested)
    ============================================================= -->
    <div class="fb-page-header">
        <div class="fb-page-header-left">
            <h1 class="fb-page-title">Feedback & Ratings</h1>
            <p class="fb-page-subtitle">Manage user feedback, ratings and reviews.</p>
        </div>
    </div>

    <!-- ============================================================
         2. 4 HORIZONTAL SUMMARY STATS CARDS
    ============================================================= -->
    <div class="fb-stats-grid">
        <!-- Average Rating -->
        <div class="fb-stat-card">
            <div class="fb-stat-icon icon-gold">
                <i class="fa-solid fa-star"></i>
            </div>
            <div class="fb-stat-body">
                <span class="fb-stat-label">Average Rating</span>
                <div class="fb-stat-num-wrap">
                    <h3 class="fb-stat-number">4.6 <span class="fb-stat-denom">/ 5</span></h3>
                </div>
                <div class="fb-stars-mini">
                    <i class="fa-solid fa-star star-filled"></i>
                    <i class="fa-solid fa-star star-filled"></i>
                    <i class="fa-solid fa-star star-filled"></i>
                    <i class="fa-solid fa-star star-filled"></i>
                    <i class="fa-solid fa-star-half-stroke star-filled"></i>
                </div>
            </div>
        </div>

        <!-- Total Feedback -->
        <div class="fb-stat-card">
            <div class="fb-stat-icon icon-blue">
                <i class="fa-solid fa-comments"></i>
            </div>
            <div class="fb-stat-body">
                <span class="fb-stat-label">Total Feedback</span>
                <div class="fb-stat-num-wrap">
                    <h3 class="fb-stat-number">1,248</h3>
                </div>
                <span class="fb-stat-subtext">From registered users</span>
            </div>
        </div>

        <!-- Positive Feedback -->
        <div class="fb-stat-card">
            <div class="fb-stat-icon icon-green">
                <i class="fa-solid fa-face-smile"></i>
            </div>
            <div class="fb-stat-body">
                <span class="fb-stat-label">Positive Feedback</span>
                <div class="fb-stat-num-wrap">
                    <h3 class="fb-stat-number">1,020</h3>
                </div>
                <span class="fb-stat-subtext">4 &amp; 5 star reviews</span>
            </div>
        </div>

        <!-- Negative Feedback -->
        <div class="fb-stat-card">
            <div class="fb-stat-icon icon-red">
                <i class="fa-solid fa-triangle-exclamation"></i>
            </div>
            <div class="fb-stat-body">
                <span class="fb-stat-label">Negative Feedback</span>
                <div class="fb-stat-num-wrap">
                    <h3 class="fb-stat-number">128</h3>
                </div>
                <span class="fb-stat-subtext">Needs attention</span>
            </div>
        </div>
    </div>

    <!-- ============================================================
         3. RATING OVERVIEW CARD
    ============================================================= -->
    <div class="fb-rating-overview-card">
        <div class="fb-card-header">
            <h2 class="fb-card-title">Rating Overview</h2>
            <span class="fb-card-subtitle">Based on 1,248 verified reviews</span>
        </div>
        <div class="fb-rating-overview-content">
            <!-- Left: Big Average Display -->
            <div class="fb-avg-score-box">
                <div class="fb-big-score">4.6 <span class="fb-score-total">/ 5</span></div>
                <div class="fb-big-stars">
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star"></i>
                    <i class="fa-solid fa-star-half-stroke"></i>
                </div>
                <p class="fb-avg-note">Overall Platform Satisfaction</p>
            </div>

            <!-- Right: Breakdown Progress Bars -->
            <div class="fb-breakdown-bars">
                <!-- 5 Stars -->
                <div class="fb-bar-row">
                    <div class="fb-bar-label">
                        <span>5</span> <i class="fa-solid fa-star"></i>
                    </div>
                    <div class="fb-progress-track">
                        <div class="fb-progress-fill fill-5" style="width: 57.7%;"></div>
                    </div>
                    <div class="fb-bar-count">720</div>
                    <div class="fb-bar-pct">57.7%</div>
                </div>

                <!-- 4 Stars -->
                <div class="fb-bar-row">
                    <div class="fb-bar-label">
                        <span>4</span> <i class="fa-solid fa-star"></i>
                    </div>
                    <div class="fb-progress-track">
                        <div class="fb-progress-fill fill-4" style="width: 33.6%;"></div>
                    </div>
                    <div class="fb-bar-count">420</div>
                    <div class="fb-bar-pct">33.6%</div>
                </div>

                <!-- 3 Stars -->
                <div class="fb-bar-row">
                    <div class="fb-bar-label">
                        <span>3</span> <i class="fa-solid fa-star"></i>
                    </div>
                    <div class="fb-progress-track">
                        <div class="fb-progress-fill fill-3" style="width: 5.6%;"></div>
                    </div>
                    <div class="fb-bar-count">70</div>
                    <div class="fb-bar-pct">5.6%</div>
                </div>

                <!-- 2 Stars -->
                <div class="fb-bar-row">
                    <div class="fb-bar-label">
                        <span>2</span> <i class="fa-solid fa-star"></i>
                    </div>
                    <div class="fb-progress-track">
                        <div class="fb-progress-fill fill-2" style="width: 2.0%;"></div>
                    </div>
                    <div class="fb-bar-count">25</div>
                    <div class="fb-bar-pct">2.0%</div>
                </div>

                <!-- 1 Star -->
                <div class="fb-bar-row">
                    <div class="fb-bar-label">
                        <span>1</span> <i class="fa-solid fa-star"></i>
                    </div>
                    <div class="fb-progress-track">
                        <div class="fb-progress-fill fill-1" style="width: 1.1%;"></div>
                    </div>
                    <div class="fb-bar-count">13</div>
                    <div class="fb-bar-pct">1.1%</div>
                </div>
            </div>
        </div>
    </div>

    <!-- ============================================================
         4. SEARCH AND FILTER BAR
    ============================================================= -->
    <div class="fb-filter-card">
        <div class="fb-filter-group search-group">
            <div class="fb-search-wrapper">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <input type="text" id="fbSearchInput" class="fb-input" placeholder="Search feedback or user..." />
            </div>
        </div>

        <div class="fb-filter-group">
            <label class="fb-filter-label">Rating</label>
            <div class="fb-select-wrapper">
                <select id="fbFilterRating" class="fb-select">
                    <option value="All">All Ratings</option>
                    <option value="5">5 Stars</option>
                    <option value="4">4 Stars</option>
                    <option value="3">3 Stars</option>
                    <option value="2">2 Stars</option>
                    <option value="1">1 Star</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="fb-filter-group">
            <label class="fb-filter-label">Status</label>
            <div class="fb-select-wrapper">
                <select id="fbFilterStatus" class="fb-select">
                    <option value="All">All Status</option>
                    <option value="New">New</option>
                    <option value="Reviewed">Reviewed</option>
                    <option value="Responded">Responded</option>
                    <option value="Resolved">Resolved</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="fb-filter-group">
            <label class="fb-filter-label">Date Range</label>
            <div class="fb-select-wrapper">
                <select id="fbFilterDate" class="fb-select">
                    <option value="All">All Time</option>
                    <option value="Today">Today</option>
                    <option value="Yesterday">Yesterday</option>
                    <option value="Last 7 Days">Last 7 Days</option>
                    <option value="Last 30 Days">Last 30 Days</option>
                    <option value="Custom">Custom</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <!-- Custom Date Range Inputs (Shown when Custom is selected) -->
        <div class="fb-filter-group custom-date-group" id="customDateGroup" style="display: none;">
            <label class="fb-filter-label">Select Dates</label>
            <div class="fb-custom-dates-wrap">
                <input type="date" id="customStartDate" class="fb-input custom-date-input" />
                <span class="custom-date-sep">to</span>
                <input type="date" id="customEndDate" class="fb-input custom-date-input" />
            </div>
        </div>

        <div class="fb-filter-group action-group">
            <button type="button" id="btnClearFbFilters" class="fb-btn-clear">
                <i class="fa-solid fa-xmark"></i> Clear Filters
            </button>
        </div>
    </div>

    <!-- ============================================================
         5. FEEDBACK TABLE CARD
    ============================================================= -->
    <div class="fb-table-card">
        <div class="fb-table-responsive">
            <table class="fb-data-table" id="feedbackTable">
                <thead>
                    <tr>
                        <th>User</th>
                        <th>Rating</th>
                        <th>Feedback</th>
                        <th>Date</th>
                        <th>Status</th>
                        <th style="text-align: right;">Action</th>
                    </tr>
                </thead>
                <tbody id="feedbackTableBody">
                    <!-- Populated dynamically via JS -->
                </tbody>
            </table>
        </div>

        <!-- ============ 6. PAGINATION ============ -->
        <div class="fb-pagination-bar">
            <div class="fb-entries-info" id="fbEntriesInfo">
                Showing 1 to 10 of 1,248 entries
            </div>
            <div class="fb-pagination-controls">
                <div class="fb-rows-per-page">
                    <span>Rows per page:</span>
                    <div class="fb-select-mini-wrap">
                        <select id="fbPageSize" class="fb-select-mini">
                            <option value="10" selected>10</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-mini-chevron"></i>
                    </div>
                </div>

                <div class="fb-pagination-nav" id="fbPaginationNav">
                    <!-- Rendered dynamically via JS -->
                </div>
            </div>
        </div>
    </div>

</div>

<!-- ============================================================
     7. RIGHT-SIDE DETAILS DRAWER / PANEL
============================================================= -->
<div class="fb-drawer-overlay" id="fbDrawerOverlay">
    <div class="fb-drawer" id="fbDrawer">
        <div class="fb-drawer-header">
            <div class="fb-drawer-title-wrap">
                <h3>Feedback Details</h3>
                <span class="fb-drawer-id" id="drawerId">#FB-1024</span>
            </div>
            <button type="button" class="fb-drawer-close" id="btnCloseDrawer">
                <i class="fa-solid fa-xmark"></i>
            </button>
        </div>

        <div class="fb-drawer-body">
            <!-- User Info Card in Drawer -->
            <div class="fb-drawer-user-card">
                <img src="" alt="" class="fb-drawer-avatar" id="drawerAvatar" />
                <div class="fb-drawer-user-info">
                    <h4 class="fb-drawer-name" id="drawerName">User Name</h4>
                    <span class="fb-drawer-email" id="drawerEmail">user@gmail.com</span>
                </div>
            </div>

            <!-- Meta Grid -->
            <div class="fb-drawer-meta-grid">
                <div class="fb-meta-item">
                    <span class="fb-meta-label">Rating</span>
                    <div class="fb-drawer-stars" id="drawerStars">
                        <!-- Filled stars -->
                    </div>
                </div>
                <div class="fb-meta-item">
                    <span class="fb-meta-label">Submitted On</span>
                    <span class="fb-meta-value" id="drawerDate">21 Aug 2026, 10:30 AM</span>
                </div>
                <div class="fb-meta-item" style="grid-column: 1 / -1;">
                    <span class="fb-meta-label">Current Status</span>
                    <div class="fb-select-wrapper drawer-select-wrap">
                        <select id="drawerStatusSelect" class="fb-select">
                            <option value="New">New</option>
                            <option value="Reviewed">Reviewed</option>
                            <option value="Responded">Responded</option>
                            <option value="Resolved">Resolved</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-chevron"></i>
                    </div>
                </div>
            </div>

            <!-- Full Feedback Text -->
            <div class="fb-drawer-section">
                <label class="fb-drawer-section-label">User Feedback</label>
                <div class="fb-drawer-quote-box" id="drawerFeedbackText">
                    "Very easy to use, responsive and smooth navigation."
                </div>
            </div>

            <!-- Admin Response Section -->
            <div class="fb-drawer-section">
                <label class="fb-drawer-section-label">Admin Response</label>
                <textarea id="drawerAdminResponse" class="fb-textarea" placeholder="Write a response to this user feedback..."></textarea>
            </div>
        </div>

        <div class="fb-drawer-footer">
            <button type="button" class="fb-btn-outline" id="btnCancelDrawer">Cancel</button>
            <button type="button" class="fb-btn-primary" id="btnSendResponse">
                <i class="fa-regular fa-paper-plane"></i> Send Response
            </button>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="../js/admin-feedback-ratings.js"></script>
</asp:Content>

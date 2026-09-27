<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-students.aspx.cs" Inherits="asp.net.admin_students" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-students.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
<div class="sims-student-main-container">

    <!-- 1. TOP HEADER -->
    <div class="stu-page-header">
        <div class="stu-page-header-left">
            <h1 class="stu-page-title">Student Management</h1>
            <p class="stu-page-subtitle">Manage registered students and their account information.</p>
        </div>
        <div class="stu-page-header-right">
        </div>
    </div>

    <!-- 2. 4 SUMMARY STATISTIC CARDS -->
    <div class="stu-stats-grid">
        <div class="stu-stat-card stu-stat-clickable active" data-student-card="all">
            <div class="stu-stat-icon icon-blue">
                <i class="fa-solid fa-user-graduate"></i>
            </div>
            <div class="stu-stat-body">
                <span class="stu-stat-label">Total Students</span>
                <div class="stu-stat-num-wrap">
                    <h3 class="stu-stat-number" id="statTotalStudents">1,248</h3>
                </div>
                <span class="stu-stat-subtext">Overall registered</span>
            </div>
        </div>

        <div class="stu-stat-card stu-stat-clickable" data-student-card="active">
            <div class="stu-stat-icon icon-green">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            <div class="stu-stat-body">
                <span class="stu-stat-label">Active Students</span>
                <div class="stu-stat-num-wrap">
                    <h3 class="stu-stat-number" id="statActiveStudents">1,180</h3>
                </div>
                <span class="stu-stat-subtext">Eligible for internships</span>
            </div>
        </div>

        <div class="stu-stat-card stu-stat-clickable" data-student-card="blocked">
            <div class="stu-stat-icon icon-red">
                <i class="fa-solid fa-ban"></i>
            </div>
            <div class="stu-stat-body">
                <span class="stu-stat-label">Blocked Students</span>
                <div class="stu-stat-num-wrap">
                    <h3 class="stu-stat-number" id="statBlockedStudents">68</h3>
                </div>
                <span class="stu-stat-subtext">Access restricted</span>
            </div>
        </div>

        <div class="stu-stat-card stu-stat-clickable" data-student-card="new">
            <div class="stu-stat-icon icon-purple">
                <i class="fa-solid fa-user-plus"></i>
            </div>
            <div class="stu-stat-body">
                <span class="stu-stat-label">New Students</span>
                <div class="stu-stat-num-wrap">
                    <h3 class="stu-stat-number" id="statNewStudents">124</h3>
                </div>
                <span class="stu-stat-subtext">Enrolled this month</span>
            </div>
        </div>
    </div>

    <!-- 3. SEARCH AND FILTER BAR -->
    <div class="stu-filter-card">
        <div class="stu-filter-group search-group">
            <div class="stu-search-wrapper">
                <i class="fa-solid fa-magnifying-glass search-icon"></i>
                <input type="text" id="stuSearchInput" class="stu-input" placeholder="Search student name, email or ID..." />
            </div>
        </div>

        <div class="stu-filter-group">
            <label class="stu-filter-label">Status</label>
            <div class="stu-select-wrapper">
                <select id="filterStatus" class="stu-select">
                    <option value="All">All Status</option>
                    <option value="Active">Active</option>
                    <option value="Blocked">Blocked</option>
                    <option value="Pending">Pending</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="stu-filter-group">
            <label class="stu-filter-label">Course</label>
            <div class="stu-select-wrapper">
                <select id="filterCourse" class="stu-select">
                    <option value="All">All Courses</option>
                    <option value="BCA">BCA</option>
                    <option value="MCA">MCA</option>
                    <option value="B.Tech">B.Tech</option>
                    <option value="M.Tech">M.Tech</option>
                    <option value="B.Sc IT">B.Sc IT</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="stu-filter-group">
            <label class="stu-filter-label">Registration Date</label>
            <div class="stu-select-wrapper">
                <select id="filterRegDate" class="stu-select">
                    <option value="All">All Time</option>
                    <option value="Today">Today</option>
                    <option value="This Month">This Month</option>
                    <option value="2026">2026</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="stu-filter-group">
            <label class="stu-filter-label">Batch</label>
            <div class="stu-select-wrapper">
                <select id="filterBatch" class="stu-select">
                    <option value="All">All Batches</option>
                    <option value="2024-2027">2024-2027</option>
                    <option value="2023-2026">2023-2026</option>
                    <option value="2022-2025">2022-2025</option>
                </select>
                <i class="fa-solid fa-chevron-down select-chevron"></i>
            </div>
        </div>

        <div class="stu-filter-group action-group">
            <button type="button" id="btnClearStuFilters" class="stu-btn-clear">
                <i class="fa-solid fa-xmark"></i> Clear Filters
            </button>
        </div>
    </div>

  
    <div class="stu-table-card">
        <div class="stu-table-responsive">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                CssClass="stu-data-table" UseAccessibleHeader="true"
                GridLines="None"
                Width="100%"
                OnRowCommand="GridView1_RowCommand">
                <HeaderStyle CssClass="stu-table-header" />
                <RowStyle CssClass="stu-table-row" />
                <AlternatingRowStyle CssClass="stu-table-row-alt" />
                <Columns>
                    <asp:BoundField DataField="StudentId"    HeaderText="Student ID" />
                    <asp:BoundField DataField="FullName"     HeaderText="Full Name" />
                    <asp:BoundField DataField="Email"        HeaderText="Email" />
                    <asp:BoundField DataField="ContactNo"    HeaderText="Phone" />
                    <asp:BoundField DataField="Course"       HeaderText="Course" />
                    <asp:BoundField DataField="EnrollmentNo" HeaderText="Enrollment No" />
                    <asp:BoundField DataField="College"      HeaderText="College" />
                    <asp:BoundField DataField="CGPA"         HeaderText="CGPA" />
                    <asp:BoundField DataField="DateOfBirth"  HeaderText="Date of Birth" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlViewStudent" runat="server" NavigateUrl='<%# "viewStudentDetails.aspx?id=" + Eval("StudentId") %>' CssClass="stu-action-view" ToolTip="View student details"><i class="fa-regular fa-eye"></i> View</asp:HyperLink>
                            <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument='<%# Eval("StudentId") %>' CommandName="cmd_del" CssClass="stu-action-delete" ToolTip="Delete student"> <i class="fa-solid fa-trash-can"></i> Delete</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <!-- 5. PAGINATION -->
        <div class="stu-pagination-bar">
            <div class="stu-entries-info" id="stuEntriesInfo">
                Showing students
            </div>
            <div class="stu-pagination-controls">
                <div class="stu-rows-per-page">
                    <span>Rows per page:</span>
                    <div class="stu-select-mini-wrap">
                        <select id="stuPageSize" class="stu-select-mini">
                            <option value="10" selected>10</option>
                            <option value="25">25</option>
                            <option value="50">50</option>
                        </select>
                        <i class="fa-solid fa-chevron-down select-mini-chevron"></i>
                    </div>
                </div>
                <div class="stu-pagination-nav" id="stuPaginationNav">
                </div>
            </div>
        </div>
    </div>

</div>



<!-- Hidden field for Delete Student ID -->
<asp:HiddenField ID="hfDeleteStudentId" runat="server" />


<!-- Toast notification popup -->
<div id="stuToast" class="stu-toast" style="display: none;"></div>



<!-- Client side script -->
<script src="../js/admin-students.js"></script>
</asp:Content>

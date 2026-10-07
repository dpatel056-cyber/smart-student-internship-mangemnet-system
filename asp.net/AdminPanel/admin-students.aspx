<%@ Page Title="Students" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-students.aspx.cs" Inherits="asp.net.admin_students" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-students.css" />
    <style>
        .sims-student-main-container {
            width: 100%;
            padding: 0;
            box-sizing: border-box;
        }

        .stu-page-header {
            margin-bottom: 24px;
        }

        .stu-page-title {
            font-size: 24px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 6px 0;
        }

        .stu-page-subtitle {
            font-size: 14px;
            color: #64748b;
            margin: 0;
        }

        /* Filter Card */
        .stu-filter-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 20px 24px;
            margin-bottom: 24px;
            display: flex;
            align-items: flex-end;
            gap: 16px;
            flex-wrap: wrap;
            box-shadow: 0 1px 3px rgba(0,0,0,0.03);
            width: 100%;
            box-sizing: border-box;
        }

        .stu-filter-group {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .stu-filter-group.search-group {
            flex: 2;
            min-width: 250px;
        }

        .stu-filter-group.course-group {
            flex: 1.2;
            min-width: 180px;
        }

        .stu-filter-group.status-group {
            flex: 1;
            min-width: 140px;
        }

        .stu-filter-group.action-group {
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 10px;
            margin-left: auto;
        }

        .stu-filter-label {
            font-size: 12.5px;
            font-weight: 600;
            color: #475569;
            margin: 0;
        }

        .stu-search-wrapper, .stu-select-wrapper {
            position: relative;
            width: 100%;
        }

        .stu-search-wrapper .search-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 14px;
            pointer-events: none;
        }

        .stu-input {
            width: 100%;
            height: 42px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            padding: 0 14px 0 38px;
            font-size: 13.5px;
            color: #0f172a;
            background: #fff;
            outline: none;
            transition: all 0.2s ease;
            box-sizing: border-box;
        }

        .stu-input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .stu-select {
            width: 100%;
            height: 42px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            padding: 0 34px 0 14px;
            font-size: 13.5px;
            color: #334155;
            background: #ffffff;
            outline: none;
            appearance: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.2s ease;
            box-sizing: border-box;
        }

        .stu-select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .select-chevron {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 11px;
            pointer-events: none;
        }

        .stu-btn-primary {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            height: 42px;
            padding: 0 20px;
            background: #2563eb;
            color: #ffffff !important;
            border-radius: 10px;
            font-size: 13.5px;
            font-weight: 600;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
            white-space: nowrap;
        }

        .stu-btn-primary:hover {
            background: #1d4ed8;
            box-shadow: 0 2px 8px rgba(37, 99, 235, 0.25);
        }

        .stu-btn-clear {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            height: 42px;
            padding: 0 18px;
            background: #f8fafc;
            color: #475569 !important;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            font-size: 13.5px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s ease;
            white-space: nowrap;
        }

        .stu-btn-clear:hover {
            background: #e2e8f0;
            color: #0f172a !important;
        }

        /* Table Card & Responsive Scroll */
        .stu-table-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.03);
            margin-bottom: 24px;
            width: 100%;
            box-sizing: border-box;
        }

        .stu-table-responsive {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

        .stu-table-responsive::-webkit-scrollbar {
            height: 7px;
        }

        .stu-table-responsive::-webkit-scrollbar-track {
            background: #f8fafc;
        }

        .stu-table-responsive::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 4px;
        }

        .stu-table-responsive::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

        .stu-data-table {
            width: 100%;
            min-width: 1100px;
            border-collapse: collapse;
            text-align: left;
            background-color: #ffffff;
        }

        .stu-table-header th {
            padding: 16px 18px !important;
            font-size: 12px;
            font-weight: 700;
            color: #475569;
            background-color: #f8fafc;
            border-bottom: 2px solid #e2e8f0;
            white-space: nowrap;
            text-transform: uppercase;
            letter-spacing: 0.04em;
        }

        .stu-table-row td, .stu-table-row-alt td {
            padding: 14px 18px !important;
            font-size: 13.5px;
            color: #334155;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
            white-space: nowrap;
        }

        .stu-table-row:hover td, .stu-table-row-alt:hover td {
            background-color: #f8fafc;
        }

        /* Status Badges */
        .status-badge-active {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 700;
            background: #dcfce7;
            color: #15803d;
            border: 1px solid #bbf7d0;
        }

        .status-badge-blocked {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 700;
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        /* Action Buttons */
        .stu-actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .stu-action-view {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 8px;
            background-color: #eff6ff;
            color: #2563eb !important;
            border: 1px solid #dbeafe;
            font-weight: 600;
            font-size: 12.5px;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .stu-action-view:hover {
            background-color: #2563eb;
            color: #ffffff !important;
            border-color: #2563eb;
            box-shadow: 0 2px 8px rgba(37, 99, 235, 0.25);
        }

        .stu-action-block {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 8px;
            background-color: #fff1f2;
            color: #e11d48 !important;
            border: 1px solid #fecdd3;
            font-weight: 600;
            font-size: 12.5px;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .stu-action-block:hover {
            background-color: #e11d48;
            color: #ffffff !important;
            border-color: #e11d48;
            box-shadow: 0 2px 8px rgba(225, 29, 72, 0.25);
        }

        .stu-action-unblock {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 8px;
            background-color: #f0fdf4;
            color: #16a34a !important;
            border: 1px solid #bbf7d0;
            font-weight: 600;
            font-size: 12.5px;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .stu-action-unblock:hover {
            background-color: #16a34a;
            color: #ffffff !important;
            border-color: #16a34a;
            box-shadow: 0 2px 8px rgba(22, 163, 74, 0.25);
        }

        .stu-action-delete {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 8px;
            background-color: #fef2f2;
            color: #dc2626 !important;
            border: 1px solid #fee2e2;
            font-weight: 600;
            font-size: 12.5px;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .stu-action-delete:hover {
            background-color: #ef4444;
            color: #ffffff !important;
            border-color: #ef4444;
            box-shadow: 0 2px 8px rgba(239, 68, 68, 0.25);
        }

        .empty-students-box {
            padding: 48px 24px;
            text-align: center;
            color: #64748b;
        }

        .empty-students-box i {
            font-size: 44px;
            color: #cbd5e1;
            margin-bottom: 12px;
            display: block;
        }

        .empty-students-box h3 {
            font-size: 18px;
            color: #1e293b;
            margin: 0 0 6px;
            font-weight: 700;
        }

        .empty-students-box p {
            font-size: 14px;
            color: #64748b;
            margin: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sims-student-main-container">

        <!-- Header -->
        <div class="stu-page-header">
            <h1 class="stu-page-title">Student Management</h1>
            <p class="stu-page-subtitle">Manage, search, monitor and block/unblock registered students.</p>
        </div>

        <!-- Search & Filter Card (Client-side fast search) -->
        <div class="stu-filter-card">
            <div class="stu-filter-group search-group">
                <label class="stu-filter-label">Search</label>
                <div class="stu-search-wrapper">
                    <i class="fa-solid fa-magnifying-glass search-icon"></i>
                    <input type="text" id="txtSearch" class="stu-input" placeholder="Search by name, email, ID, enrollment, phone, college..." onkeyup="filterStudents();" />
                </div>
            </div>

            <div class="stu-filter-group course-group">
                <label class="stu-filter-label">Course</label>
                <div class="stu-select-wrapper">
                    <select id="ddlCourse" class="stu-select" onchange="filterStudents();">
                        <option value="All">All Courses</option>
                    </select>
                    <i class="fa-solid fa-chevron-down select-chevron"></i>
                </div>
            </div>

            <div class="stu-filter-group status-group">
                <label class="stu-filter-label">Status</label>
                <div class="stu-select-wrapper">
                    <select id="ddlStatus" class="stu-select" onchange="filterStudents();">
                        <option value="All">All Status</option>
                        <option value="Active">Active</option>
                        <option value="Blocked">Blocked</option>
                    </select>
                    <i class="fa-solid fa-chevron-down select-chevron"></i>
                </div>
            </div>

            <div class="stu-filter-group action-group">
                <button type="button" class="stu-btn-primary" onclick="filterStudents();">
                    <i class="fa-solid fa-magnifying-glass"></i> Search
                </button>
                <button type="button" class="stu-btn-clear" onclick="clearStudentFilters();">
                    <i class="fa-solid fa-xmark"></i> Clear Filters
                </button>
            </div>
        </div>

        <!-- Students Table Card -->
        <div class="stu-table-card">
            <div class="stu-table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="stu-data-table"
                    UseAccessibleHeader="true" GridLines="None" Width="100%" ShowHeaderWhenEmpty="true"
                    OnRowCommand="GridView1_RowCommand">
                    <HeaderStyle CssClass="stu-table-header" />
                    <RowStyle CssClass="stu-table-row" />
                    <AlternatingRowStyle CssClass="stu-table-row-alt" />
                    <Columns>
                        <asp:BoundField DataField="StudentId" HeaderText="Student ID" />
                        <asp:TemplateField HeaderText="Full Name">
                            <ItemTemplate>
                                <asp:Label ID="lblFullName" runat="server" Text='<%# Eval("FullName") %>' Font-Bold="true" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Gender" HeaderText="Gender" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="ContactNo" HeaderText="Phone" />
                        <asp:TemplateField HeaderText="Course">
                            <ItemTemplate>
                                <asp:Label ID="lblCourse" runat="server" Text='<%# Eval("Course") %>' Font-Bold="true" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="EnrollmentNo" HeaderText="Enrollment No" />
                        <asp:BoundField DataField="College" HeaderText="College" />
                        <asp:BoundField DataField="CGPA" HeaderText="CGPA" />
                        <asp:BoundField DataField="DateOfBirth" HeaderText="Date of Birth" DataFormatString="{0:dd MMM yyyy}" HtmlEncode="false" />

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='<%# Convert.ToBoolean(Eval("IsBlocked")) ? "status-badge-blocked" : "status-badge-active" %>'>
                                    <i class='fa-solid <%# Convert.ToBoolean(Eval("IsBlocked")) ? "fa-ban" : "fa-circle-check" %>'></i>
                                    <%# Convert.ToBoolean(Eval("IsBlocked")) ? "Blocked" : "Active" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <div class="stu-actions">
                                    <asp:LinkButton ID="btnViewStudent" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("StudentId") %>'
                                        CssClass="stu-action-view" ToolTip="View student details" CausesValidation="false">
                                        <i class="fa-regular fa-eye"></i> View
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnBlockStudent" runat="server"
                                        CommandName="cmd_toggle_block"
                                        CommandArgument='<%# Eval("StudentId") %>'
                                        CssClass='<%# Convert.ToBoolean(Eval("IsBlocked")) ? "stu-action-unblock" : "stu-action-block" %>'
                                        CausesValidation="false">
                                        <i class='fa-solid <%# Convert.ToBoolean(Eval("IsBlocked")) ? "fa-circle-check" : "fa-ban" %>'></i>
                                        <%# Convert.ToBoolean(Eval("IsBlocked")) ? "Unblock" : "Block" %>
                                    </asp:LinkButton>

                                    <asp:LinkButton ID="btnDeleteStudent" runat="server" CommandName="cmd_del" CommandArgument='<%# Eval("StudentId") %>'
                                        CssClass="stu-action-delete" ToolTip="Delete student" CausesValidation="false"
                                        OnClientClick="return confirm('Are you sure you want to delete this student? All related records will also be removed.');">
                                        <i class="fa-solid fa-trash-can"></i> Delete
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <EmptyDataTemplate>
                        <div class="empty-students-box">
                            <i class="fa-solid fa-user-slash"></i>
                            <h3>No students found</h3>
                            <p>There are currently no registered students.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>

                <div id="noMatchStudentsRow" style="display: none; padding: 40px; text-align: center; color: #64748b;">
                    <i class="fa-solid fa-magnifying-glass" style="font-size: 36px; color: #cbd5e1; margin-bottom: 10px; display: block;"></i>
                    <h4 style="font-size: 16px; font-weight: 700; color: #1e293b; margin: 0 0 4px 0;">No matching students found</h4>
                    <p style="font-size: 13.5px; margin: 0;">Try adjusting your search keyword, course, or status filter.</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        function initStudentCourses() {
            var table = document.querySelector('.stu-data-table');
            if (!table) return;
            var rows = table.querySelectorAll('tbody tr');
            var courseSet = new Set();

            rows.forEach(function (row) {
                // Header rows or EmptyDataTemplate rows check
                if (row.querySelector('th') || row.classList.contains('stu-table-header')) return;
                var cells = row.querySelectorAll('td');
                if (cells.length > 5) {
                    var courseText = (cells[5].innerText || '').trim();
                    if (courseText) {
                        courseSet.add(courseText);
                    }
                }
            });

            var ddl = document.getElementById('ddlCourse');
            if (ddl && courseSet.size > 0) {
                ddl.innerHTML = '<option value="All">All Courses</option>';
                Array.from(courseSet).sort().forEach(function (course) {
                    var opt = document.createElement('option');
                    opt.value = course;
                    opt.textContent = course;
                    ddl.appendChild(opt);
                });
            }
        }

        function filterStudents() {
            var search = (document.getElementById('txtSearch').value || '').trim().toLowerCase();
            var course = (document.getElementById('ddlCourse').value || 'All').trim().toLowerCase();
            var status = (document.getElementById('ddlStatus').value || 'All').trim().toLowerCase();

            var table = document.querySelector('.stu-data-table');
            if (!table) return;

            var rows = table.querySelectorAll('tbody tr');
            var visibleCount = 0;
            var totalRows = 0;

            rows.forEach(function (row) {
                if (row.querySelector('th') || row.classList.contains('stu-table-header')) return;
                var cells = row.querySelectorAll('td');
                if (cells.length < 5) return;

                totalRows++;
                var rowText = row.innerText.toLowerCase();
                var rowCourse = (cells[5] ? cells[5].innerText : '').trim().toLowerCase();
                var rowStatus = (cells[10] ? cells[10].innerText : '').trim().toLowerCase();

                var matchSearch = (search === '' || rowText.indexOf(search) > -1);
                var matchCourse = (course === 'all' || rowCourse === course);
                var matchStatus = (status === 'all' || rowStatus.indexOf(status) > -1);

                if (matchSearch && matchCourse && matchStatus) {
                    row.style.display = '';
                    visibleCount++;
                } else {
                    row.style.display = 'none';
                }
            });

            var noMatchEl = document.getElementById('noMatchStudentsRow');
            if (noMatchEl) {
                noMatchEl.style.display = (totalRows > 0 && visibleCount === 0) ? 'block' : 'none';
            }
        }

        function clearStudentFilters() {
            document.getElementById('txtSearch').value = '';
            document.getElementById('ddlCourse').value = 'All';
            document.getElementById('ddlStatus').value = 'All';
            filterStudents();
        }

        document.addEventListener('DOMContentLoaded', function () {
            initStudentCourses();
        });
    </script>
</asp:Content>

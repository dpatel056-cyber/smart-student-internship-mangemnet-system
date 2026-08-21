<%@ Page Title="Students" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="Students.aspx.cs" Inherits="asp.net.Students" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .stu-page {
            background: #f6f8fc;
            padding: 24px;
            box-sizing: border-box;
        }

        .stu-shell {
            max-width: 1240px;
            margin: 0 auto;
        }

        .stu-breadcrumb {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #64748b;
            font-size: 13px;
            margin-bottom: 16px;
        }

        .stu-breadcrumb span:last-child {
            color: #4f6ff5;
            font-weight: 600;
        }

        .stu-header {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 20px;
            margin-bottom: 22px;
        }

        .stu-header h1 {
            margin: 0;
            font-size: clamp(30px, 3vw, 40px);
            line-height: 1.1;
            color: #17233c;
            font-weight: 800;
            letter-spacing: -0.03em;
        }

        .stu-header p {
            margin: 8px 0 0;
            color: #64748b;
            font-size: 15px;
            line-height: 1.55;
        }

        .stu-add-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            height: 44px;
            padding: 0 18px;
            border-radius: 12px;
            background: linear-gradient(135deg, #5f7af8, #4f6ff5);
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            box-shadow: 0 10px 20px rgba(79, 111, 245, .22);
            white-space: nowrap;
        }

        .stu-add-btn:hover {
            color: #fff;
            text-decoration: none;
        }

        .stu-stats {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 16px;
            margin-bottom: 18px;
        }

        .stu-stat {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            padding: 18px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, .05);
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .stu-stat-icon {
            width: 46px;
            height: 46px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #eef3ff;
            color: #4f6ff5;
            font-size: 18px;
            flex: 0 0 auto;
        }

        .stu-stat-num {
            margin: 0;
            font-size: 24px;
            font-weight: 800;
            color: #17233c;
            line-height: 1.05;
        }

        .stu-stat-label {
            margin-top: 4px;
            color: #64748b;
            font-size: 12px;
            font-weight: 600;
        }

        .stu-filters,
        .stu-card {
            background: #fff;
            border: 1px solid #e2e8f0;
            border-radius: 18px;
            box-shadow: 0 8px 24px rgba(15, 23, 42, .05);
        }

        .stu-filters {
            padding: 18px;
            margin-bottom: 18px;
        }

        .stu-filter-grid {
            display: grid;
            grid-template-columns: 1.4fr .9fr .9fr .9fr auto auto;
            gap: 12px;
            align-items: end;
        }

        .stu-field label {
            display: block;
            margin-bottom: 8px;
            color: #17233c;
            font-size: 12px;
            font-weight: 600;
        }

        .stu-input,
        .stu-select {
            width: 100%;
            height: 44px;
            border-radius: 12px;
            border: 1.5px solid #e2e8f0;
            background: #fff;
            padding: 0 14px;
            font-size: 14px;
            color: #17233c;
            outline: none;
            transition: box-shadow .2s, border-color .2s;
            box-sizing: border-box;
        }

        .stu-input {
            padding-left: 40px;
        }

        .stu-input-wrap {
            position: relative;
        }

        .stu-input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 14px;
        }

        .stu-input:focus,
        .stu-select:focus {
            border-color: #4f6ff5;
            box-shadow: 0 0 0 4px rgba(79, 111, 245, .12);
        }

        .stu-filter-btn,
        .stu-reset-btn {
            height: 44px;
            padding: 0 18px;
            border-radius: 12px;
            border: 1px solid transparent;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
        }

        .stu-filter-btn {
            background: #4f6ff5;
            color: #fff;
        }

        .stu-reset-btn {
            background: #fff;
            color: #334155;
            border-color: #cbd5e1;
        }

        .stu-table-card {
            padding: 0;
            overflow: hidden;
        }

        .stu-table-head {
            padding: 18px 20px;
            border-bottom: 1px solid #e2e8f0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
        }

        .stu-table-head h3 {
            margin: 0;
            font-size: 16px;
            font-weight: 700;
            color: #17233c;
        }

        .stu-table-wrap {
            overflow-x: auto;
        }

        .stu-grid {
            width: 100%;
            border-collapse: collapse;
            min-width: 1200px;
        }

        .stu-grid th {
            background: #f8fafc;
            color: #475569;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: .04em;
            text-align: left;
            padding: 14px 16px;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
        }

        .stu-grid td {
            padding: 16px;
            border-bottom: 1px solid #e2e8f0;
            color: #334155;
            font-size: 14px;
            vertical-align: middle;
            white-space: nowrap;
        }

        .stu-grid tr:hover td {
            background: #fbfdff;
        }

        .stu-student {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .stu-avatar {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            background: linear-gradient(135deg, #dbe7ff, #eef3ff);
            color: #4f6ff5;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            flex: 0 0 auto;
        }

        .stu-name {
            display: block;
            font-weight: 700;
            color: #17233c;
        }

        .stu-email {
            font-size: 12px;
            color: #64748b;
        }

        .stu-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 11px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
        }

        .is-active {
            background: #ecfdf3;
            color: #16a34a;
        }

        .is-pending {
            background: #fff7ed;
            color: #f59e0b;
        }

        .is-inactive {
            background: #f1f5f9;
            color: #64748b;
        }

        .stu-actions {
            display: flex;
            gap: 10px;
        }

        .stu-action {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            background: #fff;
            color: #475569;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: transform .15s, border-color .15s, color .15s, box-shadow .15s;
        }

        .stu-action:hover {
            transform: translateY(-1px);
            border-color: #cbd5e1;
            box-shadow: 0 8px 18px rgba(15, 23, 42, .06);
        }

        .view {
            color: #4f6ff5;
        }

        .edit {
            color: #16a34a;
        }

        .delete {
            color: #ef4444;
        }

        .stu-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            padding: 16px 20px;
            border-top: 1px solid #e2e8f0;
            color: #64748b;
            font-size: 13px;
            flex-wrap: wrap;
        }

        .stu-pagination a,
        .stu-pagination span {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 34px;
            height: 34px;
            padding: 0 10px;
            border-radius: 10px;
            border: 1px solid #e2e8f0;
            text-decoration: none;
            color: #334155;
            background: #fff;
            font-size: 13px;
            font-weight: 600;
        }

        .stu-pagination .current {
            background: #4f6ff5;
            border-color: #4f6ff5;
            color: #fff;
        }

        .stu-empty {
            padding: 36px 20px;
            text-align: center;
            color: #64748b;
        }

        @media (max-width: 1200px) {
            .stu-stats {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }

            .stu-filter-grid {
                grid-template-columns: 1fr 1fr;
            }
        }

        @media (max-width: 768px) {
            .stu-page {
                padding: 16px;
            }

            .stu-header {
                flex-direction: column;
            }

            .stu-stats {
                grid-template-columns: 1fr;
            }

            .stu-filter-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="stu-page">
        <div class="stu-shell">
            <div class="stu-breadcrumb">
                <span>Home</span>
                <span>/</span>
                <span>User Management</span>
                <span>/</span>
                <span>Students</span>
            </div>

            <div class="stu-header">
                <div>
                    <h1>Students</h1>
                    <p>Manage and view all registered students.</p>
                </div>
                <a href="#" class="stu-add-btn">
                    <i class="fa-solid fa-plus"></i>
                    Add Student
                </a>
            </div>

            <div class="stu-stats">
                <div class="stu-stat">
                    <div class="stu-stat-icon"><i class="fa-solid fa-users"></i></div>
                    <div>
                        <div class="stu-stat-num">248</div>
                        <div class="stu-stat-label">Total Students</div>
                    </div>
                </div>
                <div class="stu-stat">
                    <div class="stu-stat-icon"><i class="fa-solid fa-circle-check"></i></div>
                    <div>
                        <div class="stu-stat-num">230</div>
                        <div class="stu-stat-label">Active Students</div>
                    </div>
                </div>
                <div class="stu-stat">
                    <div class="stu-stat-icon"><i class="fa-solid fa-clock"></i></div>
                    <div>
                        <div class="stu-stat-num">18</div>
                        <div class="stu-stat-label">Pending Students</div>
                    </div>
                </div>
                <div class="stu-stat">
                    <div class="stu-stat-icon"><i class="fa-solid fa-briefcase"></i></div>
                    <div>
                        <div class="stu-stat-num">75</div>
                        <div class="stu-stat-label">Placed Students</div>
                    </div>
                </div>
            </div>

            <div class="stu-filters">
                <div class="stu-filter-grid">
                    <div class="stu-field">
                        <label>Search</label>
                        <div class="stu-input-wrap">
                            <i class="fa-solid fa-magnifying-glass stu-input-icon"></i>
                            <input type="text" class="stu-input" placeholder="Search by student name, email or ID" />
                        </div>
                    </div>
                    <div class="stu-field">
                        <label>Department</label>
                        <select class="stu-select">
                            <option>All Departments</option>
                            <option>Computer Science</option>
                            <option>Information Technology</option>
                            <option>Management</option>
                        </select>
                    </div>
                    <div class="stu-field">
                        <label>Course</label>
                        <select class="stu-select">
                            <option>All Courses</option>
                            <option>BCA</option>
                            <option>MCA</option>
                            <option>BBA</option>
                        </select>
                    </div>
                    <div class="stu-field">
                        <label>Status</label>
                        <select class="stu-select">
                            <option>All Status</option>
                            <option>Active</option>
                            <option>Pending</option>
                            <option>Inactive</option>
                        </select>
                    </div>
                    <button type="button" class="stu-filter-btn">Filter</button>
                    <button type="button" class="stu-reset-btn">Reset</button>
                </div>
            </div>

            <div class="stu-card stu-table-card">
                <div class="stu-table-head">
                    <h3>Student Records</h3>
                    <div style="color:#64748b;font-size:13px;">Showing 1 to 10 of 248 students</div>
                </div>

                <div class="stu-table-wrap">
                    <asp:GridView ID="gvStudents" runat="server" AutoGenerateColumns="False" CssClass="stu-grid"
                        GridLines="None" ShowHeaderWhenEmpty="True">
                        <Columns>
                            <asp:BoundField DataField="StudentID" HeaderText="Student ID" />
                            <asp:TemplateField HeaderText="Student">
                                <ItemTemplate>
                                    <div class="stu-student">
                                        <div class="stu-avatar"><%# Eval("Avatar") %></div>
                                        <div>
                                            <span class="stu-name"><%# Eval("StudentName") %></span>
                                            <span class="stu-email"><%# Eval("Email") %></span>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="Mobile" HeaderText="Mobile" />
                            <asp:BoundField DataField="Course" HeaderText="Course" />
                            <asp:BoundField DataField="Semester" HeaderText="Semester" />
                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <span class='stu-badge <%# Eval("StatusClass") %>'><%# Eval("Status") %></span>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="stu-actions">
                                        <a href="#" class="stu-action view" title="View"><i class="fa-regular fa-eye"></i></a>
                                        <a href="#" class="stu-action edit" title="Edit"><i class="fa-regular fa-pen-to-square"></i></a>
                                        <a href="#" class="stu-action delete" title="Delete"><i class="fa-regular fa-trash-can"></i></a>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <div class="stu-empty">No students found.</div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>

                <div class="stu-footer">
                    <div>Showing 1 to 10 of 248 students</div>
                    <div class="stu-pagination">
                        <span>Previous</span>
                        <span class="current">1</span>
                        <a href="#">2</a>
                        <a href="#">3</a>
                        <a href="#">4</a>
                        <a href="#">5</a>
                        <a href="#">Next</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="studentModal" style="display:none;"></div>
</asp:Content>



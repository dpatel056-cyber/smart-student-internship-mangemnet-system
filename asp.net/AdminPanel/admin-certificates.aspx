<%@ Page Title="Certificates" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-certificates.aspx.cs" Inherits="asp.net.css.admin_certificates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .cert-page-container {
            padding: 10px 0 30px 0;
        }

        /* ===== PAGE HEADER ===== */
        .cert-page-header {
            margin-bottom: 22px;
        }

        .cert-page-title {
            margin: 0 0 4px 0;
            font-size: 24px;
            font-weight: 700;
            color: #0f172a;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .cert-page-desc {
            margin: 0;
            font-size: 14px;
            color: #64748b;
        }

        /* ===== SEARCH & FILTER BAR ===== */
        .cert-search-filter {
            background: #ffffff;
            border-radius: 12px;
            padding: 16px 20px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.02);
            margin-bottom: 22px;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .cert-search-box {
            position: relative;
            flex: 2;
            min-width: 260px;
        }

        .cert-search-box .search-prefix-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 13.5px;
            pointer-events: none;
        }

        .cert-search-input {
            width: 100%;
            padding: 10px 14px 10px 38px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            color: #1e293b;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            background: #ffffff;
            box-sizing: border-box;
        }

        .cert-search-input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .cert-company-filter {
            position: relative;
            flex: 1;
            min-width: 200px;
        }

        .cert-company-filter .filter-prefix-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 13px;
            pointer-events: none;
        }

        .cert-company-filter .filter-chevron-icon {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 12px;
            pointer-events: none;
        }

        .cert-company-select {
            width: 100%;
            padding: 10px 36px 10px 36px;
            border: 1.5px solid #cbd5e1;
            border-radius: 8px;
            font-size: 13.5px;
            color: #1e293b;
            appearance: none;
            background: #ffffff;
            cursor: pointer;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
            box-sizing: border-box;
        }

        .cert-company-select:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .cert-filter-buttons {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .cert-btn-search,
        .cert-btn-clear {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 13.5px;
            font-weight: 600;
            text-decoration: none !important;
            cursor: pointer;
            transition: all 0.15s ease;
            box-sizing: border-box;
            border: none;
        }

        .cert-btn-search {
            background: #2563eb;
            color: #ffffff !important;
        }

        .cert-btn-search:hover {
            background: #1d4ed8;
        }

        .cert-btn-clear {
            background: #f1f5f9;
            color: #475569 !important;
            border: 1px solid #e2e8f0;
        }

        .cert-btn-clear:hover {
            background: #e2e8f0;
            color: #0f172a !important;
        }

        /* ===== TABLE CARD ===== */
        .cert-table-card {
            background: #ffffff;
            border-radius: 14px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.03);
            overflow: hidden;
            margin-bottom: 24px;
        }

        .cert-table-wrap {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            scrollbar-width: none !important;
            -ms-overflow-style: none !important;
        }

        .cert-table-wrap::-webkit-scrollbar {
            display: none !important;
            width: 0 !important;
            height: 0 !important;
        }

        .cert-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cert-table th {
            background: #f8fafc;
            padding: 14px 18px;
            font-size: 12px;
            font-weight: 700;
            color: #475569;
            text-transform: uppercase;
            letter-spacing: .5px;
            border-bottom: 1px solid #e2e8f0;
            white-space: nowrap;
            text-align: left;
        }

        .cert-table td {
            padding: 14px 18px;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
            color: #334155;
            font-size: 13.5px;
        }

        .cert-table tr:hover td {
            background: #f8fafc;
        }

        /* Certificate labels */
        .cert-no-label {
            font-family: monospace;
            font-weight: 700;
            color: #2563eb;
            background: #eff6ff;
            padding: 4px 10px;
            border-radius: 6px;
            border: 1px solid #bfdbfe;
            font-size: 12.5px;
            display: inline-block;
            white-space: nowrap;
        }

        .cert-student-name-wrapper {
            font-weight: 600;
            color: #0f172a;
            font-size: 13.5px;
        }

        .cert-student-email-wrapper {
            font-size: 12px;
            color: #64748b;
            margin-top: 2px;
        }

        .cert-title-label {
            font-weight: 600;
            color: #1e293b;
        }

        .cert-company-label {
            font-weight: 600;
            color: #334155;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .cert-company-label i {
            color: #64748b;
            font-size: 12px;
        }

        .cert-internship-label {
            color: #334155;
            font-weight: 500;
        }

        .cert-date-label {
            color: #475569;
            font-size: 13px;
            font-weight: 500;
            white-space: nowrap;
        }

        /* Actions */
        .cert-actions-wrap {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            justify-content: flex-end;
        }

        .cert-action-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 7px 12px;
            border-radius: 8px;
            font-size: 12.5px;
            font-weight: 600;
            text-decoration: none !important;
            transition: all 0.15s ease;
            cursor: pointer;
            border: none;
        }

        .cert-btn-view {
            background: #eff6ff;
            color: #2563eb !important;
            border: 1px solid #bfdbfe;
        }

        .cert-btn-view:hover {
            background: #2563eb;
            color: #ffffff !important;
        }

        .cert-btn-delete {
            background: #fef2f2;
            color: #ef4444 !important;
            border: 1px solid #fee2e2;
            padding: 7px 10px;
        }

        .cert-btn-delete:hover {
            background: #ef4444;
            color: #ffffff !important;
        }

        /* Empty State */
        .cert-empty-state {
            text-align: center;
            padding: 48px 20px;
            color: #64748b;
        }

        .cert-empty-state i {
            font-size: 42px;
            color: #cbd5e1;
            margin-bottom: 12px;
            display: block;
        }

        .cert-empty-state h3 {
            font-size: 17px;
            font-weight: 700;
            color: #0f172a;
            margin: 0 0 6px 0;
        }

        .cert-empty-state p {
            font-size: 13.5px;
            color: #64748b;
            margin: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="cert-page-container">

        <!-- Page Header -->
        <div class="cert-page-header">
            <div>
                <h1 class="cert-page-title">
                    <i class="fa-solid fa-award" style="color: #2563eb;"></i>
                    Certificate Management
                </h1>
                <p class="cert-page-desc">View, search, filter and manage student internship completion certificates.</p>
            </div>
        </div>

        <!-- Search Bar (Client-Side Instant Search) -->
        <div class="cert-search-filter" style="margin-bottom: 20px;">
            <div class="cert-search-box" style="flex: 1; min-width: 260px;">
                <i class="fa-solid fa-magnifying-glass search-prefix-icon"></i>
                <input type="text" id="certSearchInput" class="cert-search-input" placeholder="Quick search certificates by student, certificate no, company, internship..." onkeyup="filterCertTable();" />
            </div>
        </div>

        <!-- Certificates Table Card -->
        <div class="cert-table-card">
            <div class="cert-table-wrap">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="cert-table" UseAccessibleHeader="true" GridLines="None" Width="100%" ShowHeaderWhenEmpty="true" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Certificate No">
                            <ItemTemplate>
                                <asp:Label ID="lblCertNo" runat="server" Text='<%# Eval("CertificateNo") %>' CssClass="cert-no-label"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Student Name">
                            <ItemTemplate>
                                <div class="cert-student-name-wrapper">
                                    <asp:Label ID="lblFullName" runat="server" Text='<%# Eval("FullName") %>'></asp:Label>
                                </div>
                                <div class="cert-student-email-wrapper">
                                    <asp:Label ID="lblStudentEmail" runat="server" Text='<%# Eval("StudentEmail") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Certificate Title">
                            <ItemTemplate>
                                <asp:Label ID="lblCertTitle" runat="server" Text='<%# Eval("CertificateTitle") %>' CssClass="cert-title-label"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Company">
                            <ItemTemplate>
                                <span class="cert-company-label">
                                    <i class="fa-solid fa-building"></i>
                                    <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("c_company") %>'></asp:Label>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Internship">
                            <ItemTemplate>
                                <asp:Label ID="lblInternshipTitle" runat="server" Text='<%# Eval("InternshipTitle") %>' CssClass="cert-internship-label"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Issue Date">
                            <ItemTemplate>
                                <asp:Label ID="lblIssueDate" runat="server" Text='<%# Eval("IssueDate", "{0:dd MMM yyyy}") %>' CssClass="cert-date-label"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right">
                            <ItemTemplate>
                                <div class="cert-actions-wrap">
                                    <asp:LinkButton ID="btnViewDetails" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("CertificateId") %>' CssClass="cert-action-btn cert-btn-view" ToolTip="View Certificate" CausesValidation="false">
                                        <i class="fa-regular fa-eye"></i> View
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="cmd_delete" CommandArgument='<%# Eval("CertificateId") %>' CssClass="cert-action-btn cert-btn-delete" ToolTip="Delete Certificate" CausesValidation="false" OnClientClick="return confirm('Are you sure you want to delete this certificate?');">
                                        <i class="fa-solid fa-trash"></i>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="cert-empty-state">
                            <i class="fa-solid fa-certificate"></i>
                            <h3>No Certificates Found</h3>
                            <p>No student internship certificates have been issued yet.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
        </div>

        <script>
            function filterCertTable() {
                var input = document.getElementById('certSearchInput');
                var filter = input.value.toLowerCase();
                var table = document.querySelector('.cert-table');
                if (!table) return;
                var rows = table.getElementsByTagName('tr');
                for (var i = 1; i < rows.length; i++) {
                    var row = rows[i];
                    if (row.getElementsByTagName('th').length > 0) continue;
                    var text = row.textContent || row.innerText;
                    if (text.toLowerCase().indexOf(filter) > -1) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                }
            }
        </script>
    </div>
</asp:Content>

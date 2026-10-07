<%@ Page Title="Companies" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-companies.aspx.cs" Inherits="asp.net.admin_companies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-companies.css" />
    <style>
        /* Hide scrollbars while maintaining smooth horizontal scroll */
        .cmp-table-responsive {
            width: 100%;
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            scrollbar-width: none !important; /* Firefox */
            -ms-overflow-style: none !important; /* IE and Edge */
        }

            .cmp-table-responsive::-webkit-scrollbar {
                display: none !important; /* Chrome, Safari and Opera */
                width: 0 !important;
                height: 0 !important;
            }

        /* Simple clean grid styling */
        .sims-simple-grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 0;
        }

            .sims-simple-grid th {
                font-size: 12.5px;
                font-weight: 700;
                color: #0f172a;
                text-transform: uppercase;
                letter-spacing: 0.03em;
                padding: 16px 18px !important;
                border-bottom: 2px solid #e2e8f0;
                background-color: #f8fafc;
                white-space: nowrap;
                text-align: left;
            }

            .sims-simple-grid td {
                padding: 14px 18px !important;
                border-bottom: 1px solid #f1f5f9;
                color: #334155;
                font-size: 13.5px;
                vertical-align: middle;
                white-space: nowrap;
            }

            .sims-simple-grid tr:hover td {
                background-color: #f8fafc;
            }

        /* View Action Button */
        .cmp-action-view {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 8px;
            background-color: #eff6ff;
            color: #2563eb;
            border: 1px solid #dbeafe;
            font-weight: 600;
            font-size: 12.5px;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

            .cmp-action-view:hover {
                background-color: #2563eb;
                color: #ffffff !important;
                border-color: #2563eb;
                box-shadow: 0 2px 8px rgba(37, 99, 235, 0.25);
                text-decoration: none;
            }

        /* Delete Action Button */
        .cmp-action-delete {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 8px;
            background-color: #fef2f2;
            color: #ef4444;
            border: 1px solid #fee2e2;
            font-weight: 600;
            font-size: 12.5px;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

            .cmp-action-delete:hover {
                background-color: #ef4444;
                color: #ffffff !important;
                border-color: #ef4444;
                box-shadow: 0 2px 8px rgba(239, 68, 68, 0.25);
                text-decoration: none;
            }

        /* Status Badges */
        .status-badge-active {
            display: inline-flex;
            align-items: center;
            gap: 4px;
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
            gap: 4px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 700;
            background: #fee2e2;
            color: #dc2626;
            border: 1px solid #fecaca;
        }

        /* Block / Unblock Buttons */
        .cmp-action-block {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 8px;
            background-color: #fff1f2;
            color: #e11d48;
            border: 1px solid #fecdd3;
            font-weight: 600;
            font-size: 12.5px;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

            .cmp-action-block:hover {
                background-color: #e11d48;
                color: #ffffff !important;
                border-color: #e11d48;
                box-shadow: 0 2px 8px rgba(225, 29, 72, 0.25);
                text-decoration: none;
            }

        .cmp-action-unblock {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 8px;
            background-color: #f0fdf4;
            color: #16a34a;
            border: 1px solid #bbf7d0;
            font-weight: 600;
            font-size: 12.5px;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

            .cmp-action-unblock:hover {
                background-color: #16a34a;
                color: #ffffff !important;
                border-color: #16a34a;
                box-shadow: 0 2px 8px rgba(22, 163, 74, 0.25);
                text-decoration: none;
            }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="sims-company-main-container">

        <!-- 1. TOP HEADER -->
        <div class="cmp-page-header">
            <div class="cmp-page-header-left">
                <h1 class="cmp-page-title">Companies</h1>
                <p class="cmp-page-subtitle">Manage, monitor and block/unblock registered companies.</p>
            </div>
        </div>

        <!-- 2. SEARCH AND FILTER SECTION -->
        <div class="cmp-filter-card" style="display: flex; gap: 12px; align-items: center; background: #fff; padding: 18px 20px; border-radius: 12px; margin-bottom: 24px; border: 1px solid #e2e8f0; flex-wrap: wrap;">

            <!-- Search Input -->
            <div style="flex: 1.5; min-width: 240px; position: relative;">
                <i class="fa-solid fa-magnifying-glass" style="position: absolute; left: 14px; top: 50%; transform: translateY(-50%); color: #94a3b8; font-size: 14px;"></i>
                <input type="text" id="txtSearch" class="form-control" placeholder="Search company name, email, contact..." style="width: 100%; padding: 10px 14px 10px 38px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-size: 13.5px; color: #1e293b; outline: none;" />
            </div>

            <!-- Industry Filter Dropdown -->
            <div style="flex: 1; min-width: 170px; position: relative;">
                <select id="ddlIndustry" style="width: 100%; padding: 10px 36px 10px 14px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-size: 13.5px; color: #1e293b; appearance: none; background: #ffffff; cursor: pointer; outline: none;">
                    <option value="">All Industries</option>
                    <option value="Information Technology">Information Technology</option>
                    <option value="Software Development">Software Development</option>
                    <option value="Artificial Intelligence">Artificial Intelligence</option>
                    <option value="Cyber Security">Cyber Security</option>
                    <option value="Cloud Computing">Cloud Computing</option>
                    <option value="Data Science">Data Science</option>
                    <option value="Web Development">Web Development</option>
                    <option value="Enterprise Software">Enterprise Software</option>
                </select>
                <i class="fa-solid fa-chevron-down" style="position: absolute; right: 14px; top: 50%; transform: translateY(-50%); color: #94a3b8; font-size: 12px; pointer-events: none;"></i>
            </div>

            <!-- Location Filter Dropdown -->
            <div style="flex: 1; min-width: 150px; position: relative;">
                <select id="ddlLocation" style="width: 100%; padding: 10px 36px 10px 14px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-size: 13.5px; color: #1e293b; appearance: none; background: #ffffff; cursor: pointer; outline: none;">
                    <option value="">All Locations</option>
                    <option value="Ahmedabad">Ahmedabad</option>
                    <option value="Bengaluru">Bengaluru</option>
                    <option value="Chennai">Chennai</option>
                    <option value="Gandhinagar">Gandhinagar</option>
                    <option value="Gurugram">Gurugram</option>
                    <option value="Hyderabad">Hyderabad</option>
                    <option value="Mumbai">Mumbai</option>
                    <option value="Pune">Pune</option>
                    <option value="Remote">Remote</option>
                </select>
                <i class="fa-solid fa-chevron-down" style="position: absolute; right: 14px; top: 50%; transform: translateY(-50%); color: #94a3b8; font-size: 12px; pointer-events: none;"></i>
            </div>

            <!-- Status Filter Dropdown -->
            <div style="flex: 1; min-width: 140px; position: relative;">
                <select id="ddlStatus" style="width: 100%; padding: 10px 36px 10px 14px; border: 1.5px solid #cbd5e1; border-radius: 8px; font-size: 13.5px; color: #1e293b; appearance: none; background: #ffffff; cursor: pointer; outline: none;">
                    <option value="">All Status</option>
                    <option value="Active">Active</option>
                    <option value="Blocked">Blocked</option>
                </select>
                <i class="fa-solid fa-chevron-down" style="position: absolute; right: 14px; top: 50%; transform: translateY(-50%); color: #94a3b8; font-size: 12px; pointer-events: none;"></i>
            </div>

            <!-- Action Buttons: Search & Clear -->
            <div style="display: flex; gap: 8px; align-items: center;">
                <button type="button" style="padding: 10px 18px; background: #2563eb; color: #fff; border-radius: 8px; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; font-weight: 600; font-size: 13.5px; border: none; cursor: pointer;">
                    <i class="fa-solid fa-magnifying-glass"></i>Search
                </button>
                <button type="button" style="padding: 10px 16px; background: #f1f5f9; color: #475569; border-radius: 8px; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; font-weight: 600; font-size: 13.5px; border: 1px solid #e2e8f0; cursor: pointer; transition: all 0.15s ease;"
                    onmouseover="this.style.background='#e2e8f0'; this.style.color='#0f172a';"
                    onmouseout="this.style.background='#f1f5f9'; this.style.color='#475569';">
                    <i class="fa-solid fa-xmark"></i>Clear Filters
                </button>
            </div>

        </div>

        <!-- 3. MAIN COMPANIES TABLE CARD -->
        <div class="cmp-table-card" style="background: #ffffff; border-radius: 12px; border: 1px solid #e2e8f0; box-shadow: 0 1px 4px rgba(0,0,0,0.03); overflow: hidden; margin-bottom: 24px;">
            <div class="cmp-table-responsive">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="sims-simple-grid" UseAccessibleHeader="true" GridLines="None" Width="100%" ShowHeaderWhenEmpty="true" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="COMPANY ID">
                            <ItemTemplate>
                                <asp:Label ID="lblCompanyId" runat="server" Text='<%# Eval("CompanyId") %>' Style="color: #475569; font-size: 13.5px;"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="COMPANY NAME">
                            <ItemTemplate>
                                <asp:Label ID="lblCompanyName" runat="server" Text='<%# Eval("c_company") %>' Style="font-weight: 700; color: #0f172a; font-size: 13.5px;"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="EMAIL">
                            <ItemTemplate>
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("c_email") %>' Style="color: #475569; font-size: 13.5px;"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="PHONE">
                            <ItemTemplate>
                                <asp:Label ID="lblPhone" runat="server" Text='<%# Eval("c_contact") %>' Style="color: #475569; font-size: 13.5px;"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="INDUSTRY">
                            <ItemTemplate>
                                <asp:Label ID="lblIndustry" runat="server" Text='<%# Eval("c_industry") %>' Style="font-weight: 700; color: #1e293b; font-size: 13px;"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="LOCATION">
                            <ItemTemplate>
                                <asp:Label ID="lblLocation" runat="server" Text='<%# Eval("c_location") %>' Style="color: #475569; font-size: 13.5px;"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="SIZE">
                            <ItemTemplate>
                                <asp:Label ID="lblSize" runat="server" Text='<%# Eval("c_size") %>' Style="color: #475569; font-size: 13.5px;"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="STATUS">
                            <ItemTemplate>
                                <span class='<%# Convert.ToBoolean(Eval("IsBlocked")) ? "status-badge-blocked" : "status-badge-active" %>'>
                                    <i class='fa-solid <%# Convert.ToBoolean(Eval("IsBlocked")) ? "fa-ban" : "fa-circle-check" %>'></i>
                                    <%# Convert.ToBoolean(Eval("IsBlocked")) ? "Blocked" : "Active" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="ACTIONS">
                            <HeaderStyle CssClass="text-center" />
                            <ItemStyle CssClass="text-center" />
                            <ItemTemplate>
                                <div style="display: flex; gap: 8px; align-items: center; justify-content: center;">
                                    <asp:LinkButton ID="btnView" runat="server" CommandName="cmd_view" CommandArgument='<%# Eval("CompanyId") %>' CssClass="cmp-action-view" ToolTip="View company details" CausesValidation="false"> <i class="fa-regular fa-eye"></i> View </asp:LinkButton>
                                    <asp:LinkButton ID="btnBlockCompany" runat="server" CommandName="cmd_toggle_block" CommandArgument='<%# Eval("CompanyId") %>'
                                        CssClass='<%# Convert.ToBoolean(Eval("IsBlocked")) ? "cmp-action-unblock" : "cmp-action-block" %>'
                                        CausesValidation="false">
                                        <i class='fa-solid <%# Convert.ToBoolean(Eval("IsBlocked")) ? "fa-circle-check" : "fa-ban" %>'></i>
                                        <%# Convert.ToBoolean(Eval("IsBlocked")) ? "Unblock" : "Block" %>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="cmd_del" CommandArgument='<%# Eval("CompanyId") %>' CssClass="cmp-action-delete" ToolTip="Delete company" CausesValidation="false"> <i class="fa-solid fa-trash-can"></i> Delete </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <EmptyDataTemplate>
                        <div style="padding: 48px 24px; text-align: center;">
                            <div style="font-size: 40px; color: #94a3b8; margin-bottom: 12px;">
                                <i class="fa-solid fa-building-circle-xmark"></i>
                            </div>
                            <h3 style="font-size: 18px; font-weight: 700; color: #1e293b; margin-bottom: 6px;">No Companies Found</h3>
                            <p style="color: #64748b; font-size: 14px; margin: 0;">There are no registered companies at the moment.</p>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>

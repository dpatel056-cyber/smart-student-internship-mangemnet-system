<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-categories-skills.aspx.cs" Inherits="asp.net.admin_categories_skills" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-categories-skills.css" />
</asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <div class="sims-category-skill-page">

        <!-- ================= PAGE HEADER ================= -->
        <div class="sims-category-skill-header">
            <div class="sims-category-skill-header-left">
                <nav class="sims-category-skill-breadcrumb" aria-label="breadcrumb">
                    <span>Dashboard</span>
                    <i class="fas fa-chevron-right"></i>
                    <span>Internship Management</span>
                    <i class="fas fa-chevron-right"></i>
                    <span class="sims-category-skill-breadcrumb-current">Categories &amp; Skills</span>
                </nav>
                <h1 class="sims-category-skill-title">Categories &amp; Skills Management</h1>
                <p class="sims-category-skill-subtitle">Manage internship categories and skills used across the SIMS internship platform.</p>
            </div>
            <div class="sims-category-skill-header-right">
                <button type="button" class="sims-btn sims-btn-outline" id="btnExportData">
                    <i class="fas fa-file-export"></i>
                    <span>Export Data</span>
                </button>
                <button type="button" class="sims-btn sims-btn-secondary" id="btnOpenAddSkill">
                    <i class="fas fa-plus"></i>
                    <span>Add Skill</span>
                </button>
                <button type="button" class="sims-btn sims-btn-primary" id="btnOpenAddCategory">
                    <i class="fas fa-plus"></i>
                    <span>Add Category</span>
                </button>
            </div>
        </div>

        <!-- ================= OVERVIEW STATISTICS ================= -->
        <div class="sims-category-skill-stats">

            <div class="sims-category-skill-stat-card">
                <div class="sims-stat-icon sims-stat-icon-blue">
                    <i class="fas fa-layer-group"></i>
                </div>
                <div class="sims-stat-info">
                    <h3 class="sims-stat-value">18</h3>
                    <p class="sims-stat-label">Total Categories</p>
                    <span class="sims-stat-desc">Available internship categories</span>
                </div>
            </div>

            <div class="sims-category-skill-stat-card">
                <div class="sims-stat-icon sims-stat-icon-green">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="sims-stat-info">
                    <h3 class="sims-stat-value">15</h3>
                    <p class="sims-stat-label">Active Categories</p>
                    <span class="sims-stat-desc">Currently active categories</span>
                </div>
            </div>

            <div class="sims-category-skill-stat-card">
                <div class="sims-stat-icon sims-stat-icon-purple">
                    <i class="fas fa-tools"></i>
                </div>
                <div class="sims-stat-info">
                    <h3 class="sims-stat-value">85</h3>
                    <p class="sims-stat-label">Total Skills</p>
                    <span class="sims-stat-desc">Skills available in system</span>
                </div>
            </div>

            <div class="sims-category-skill-stat-card">
                <div class="sims-stat-icon sims-stat-icon-orange">
                    <i class="fas fa-star"></i>
                </div>
                <div class="sims-stat-info">
                    <h3 class="sims-stat-value">JavaScript</h3>
                    <p class="sims-stat-label">Most Used Skill</p>
                    <span class="sims-stat-desc">Used in 128 internships</span>
                </div>
            </div>

        </div>

        <!-- ================= MAIN LAYOUT ================= -->
        <div class="sims-category-skill-main-layout">

            <!-- ============================================================ -->
            <!-- LEFT : CATEGORY MANAGEMENT SECTION -->
            <!-- ============================================================ -->
            <section class="sims-category-section" aria-label="Internship Categories">

                <div class="sims-section-head">
                    <div>
                        <h2 class="sims-section-title">Internship Categories</h2>
                        <p class="sims-section-subtitle">Manage categories used to classify internship opportunities.</p>
                    </div>
                    <button type="button" class="sims-btn sims-btn-primary sims-btn-sm" id="btnOpenAddCategory2">
                        <i class="fas fa-plus"></i>
                        <span>Add Category</span>
                    </button>
                </div>

                <div class="sims-toolbar">
                    <div class="sims-search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="categorySearchInput" placeholder="Search categories..." />
                    </div>
                    <div class="sims-filter-group">
                        <select id="categoryStatusFilter" class="sims-select">
                            <option value="all">All Status</option>
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                        <button type="button" class="sims-btn sims-btn-ghost sims-btn-sm" id="btnResetCategoryFilters">
                            <i class="fas fa-rotate-left"></i>
                            <span>Reset</span>
                        </button>
                    </div>
                </div>

                <!-- Bulk toolbar (hidden until selection) -->
                <div class="sims-bulk-toolbar" id="categoryBulkToolbar" style="display:none;">
                    <span class="sims-bulk-count"><span id="categorySelectedCount">0</span> selected</span>
                    <div class="sims-bulk-actions">
                        <button type="button" class="sims-btn sims-btn-ghost sims-btn-sm" data-bulk-action="activate" data-target="category">
                            <i class="fas fa-toggle-on"></i> Activate Selected
                        </button>
                        <button type="button" class="sims-btn sims-btn-ghost sims-btn-sm" data-bulk-action="deactivate" data-target="category">
                            <i class="fas fa-toggle-off"></i> Deactivate Selected
                        </button>
                        <button type="button" class="sims-btn sims-btn-ghost sims-btn-sm" data-bulk-action="export" data-target="category">
                            <i class="fas fa-file-export"></i> Export Selected
                        </button>
                        <button type="button" class="sims-btn sims-btn-ghost sims-btn-sm sims-text-danger" data-bulk-action="delete" data-target="category">
                            <i class="fas fa-trash"></i> Delete Selected
                        </button>
                    </div>
                </div>

                <div class="sims-table-wrapper">
                    <table class="sims-category-table" id="categoryTable">
                        <thead>
                            <tr>
                                <th class="sims-col-check"><input type="checkbox" id="categorySelectAll" /></th>
                                <th>Category</th>
                                <th>Description</th>
                                <th>Internships</th>
                                <th>Students Applied</th>
                                <th>Status</th>
                                <th>Created Date</th>
                                <th class="sims-col-actions">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="categoryTableBody">

                            <tr class="sims-category-row" data-name="Web Development" data-code="WEB-DEV" data-status="active"
                                data-description="Web application and website development internships." data-internships="42" data-students="680" data-created="10 Aug 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="category" /></td>
                                <td>
                                    <div class="sims-category-name-cell">
                                        <span class="sims-category-icon"><i class="fas fa-code"></i></span>
                                        <div>
                                            <strong>Web Development</strong>
                                            <span class="sims-category-code">WEB-DEV</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="sims-desc-cell">Web application and website development internships.</td>
                                <td>42</td>
                                <td>680</td>
                                <td><span class="sims-category-status sims-status-active"><i class="fas fa-circle"></i> Active</span></td>
                                <td>10 Aug 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-category-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Category</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Category</a>
                                            <a href="#" class="sims-action-item" data-action="deactivate"><i class="fas fa-toggle-off"></i> Deactivate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete Category</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr class="sims-category-row" data-name="Software Development" data-code="SOFT-DEV" data-status="active"
                                data-description="Software engineering and application development." data-internships="38" data-students="590" data-created="08 Aug 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="category" /></td>
                                <td>
                                    <div class="sims-category-name-cell">
                                        <span class="sims-category-icon"><i class="fas fa-laptop-code"></i></span>
                                        <div>
                                            <strong>Software Development</strong>
                                            <span class="sims-category-code">SOFT-DEV</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="sims-desc-cell">Software engineering and application development.</td>
                                <td>38</td>
                                <td>590</td>
                                <td><span class="sims-category-status sims-status-active"><i class="fas fa-circle"></i> Active</span></td>
                                <td>08 Aug 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-category-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Category</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Category</a>
                                            <a href="#" class="sims-action-item" data-action="deactivate"><i class="fas fa-toggle-off"></i> Deactivate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete Category</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr class="sims-category-row" data-name="UI/UX Design" data-code="UI-UX" data-status="active"
                                data-description="User interface and user experience design internships." data-internships="24" data-students="320" data-created="05 Aug 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="category" /></td>
                                <td>
                                    <div class="sims-category-name-cell">
                                        <span class="sims-category-icon"><i class="fas fa-pen-nib"></i></span>
                                        <div>
                                            <strong>UI/UX Design</strong>
                                            <span class="sims-category-code">UI-UX</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="sims-desc-cell">User interface and user experience design internships.</td>
                                <td>24</td>
                                <td>320</td>
                                <td><span class="sims-category-status sims-status-active"><i class="fas fa-circle"></i> Active</span></td>
                                <td>05 Aug 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-category-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Category</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Category</a>
                                            <a href="#" class="sims-action-item" data-action="deactivate"><i class="fas fa-toggle-off"></i> Deactivate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete Category</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr class="sims-category-row" data-name="Data Analytics" data-code="DATA-AN" data-status="active"
                                data-description="Data analysis, reporting and business intelligence." data-internships="19" data-students="275" data-created="01 Aug 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="category" /></td>
                                <td>
                                    <div class="sims-category-name-cell">
                                        <span class="sims-category-icon"><i class="fas fa-chart-line"></i></span>
                                        <div>
                                            <strong>Data Analytics</strong>
                                            <span class="sims-category-code">DATA-AN</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="sims-desc-cell">Data analysis, reporting and business intelligence.</td>
                                <td>19</td>
                                <td>275</td>
                                <td><span class="sims-category-status sims-status-active"><i class="fas fa-circle"></i> Active</span></td>
                                <td>01 Aug 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-category-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Category</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Category</a>
                                            <a href="#" class="sims-action-item" data-action="deactivate"><i class="fas fa-toggle-off"></i> Deactivate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete Category</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr class="sims-category-row" data-name="Digital Marketing" data-code="DIG-MKT" data-status="inactive"
                                data-description="Digital marketing, SEO and social media internships." data-internships="12" data-students="150" data-created="28 Jul 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="category" /></td>
                                <td>
                                    <div class="sims-category-name-cell">
                                        <span class="sims-category-icon"><i class="fas fa-bullhorn"></i></span>
                                        <div>
                                            <strong>Digital Marketing</strong>
                                            <span class="sims-category-code">DIG-MKT</span>
                                        </div>
                                    </div>
                                </td>
                                <td class="sims-desc-cell">Digital marketing, SEO and social media internships.</td>
                                <td>12</td>
                                <td>150</td>
                                <td><span class="sims-category-status sims-status-inactive"><i class="fas fa-circle"></i> Inactive</span></td>
                                <td>28 Jul 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-category-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Category</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Category</a>
                                            <a href="#" class="sims-action-item" data-action="activate"><i class="fas fa-toggle-on"></i> Activate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete Category</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                        </tbody>
                    </table>

                    <!-- Empty state -->
                    <div class="sims-empty-state" id="categoryEmptyState" style="display:none;">
                        <i class="fas fa-folder-open"></i>
                        <h3>No Categories Found</h3>
                        <p>Try changing your search or filter criteria.</p>
                        <button type="button" class="sims-btn sims-btn-outline sims-btn-sm" id="btnClearCategoryFilters">Clear Filters</button>
                    </div>
                </div>

                <div class="sims-category-skill-pagination">
                    <span class="sims-pagination-info">Showing 1&ndash;10 of 18 categories</span>
                    <div class="sims-pagination-controls">
                        <button type="button" class="sims-page-btn" disabled><i class="fas fa-chevron-left"></i> Previous</button>
                        <button type="button" class="sims-page-btn sims-page-active">1</button>
                        <button type="button" class="sims-page-btn">2</button>
                        <button type="button" class="sims-page-btn">3</button>
                        <button type="button" class="sims-page-btn">Next <i class="fas fa-chevron-right"></i></button>
                    </div>
                    <select class="sims-select sims-page-size">
                        <option value="10">10 / page</option>
                        <option value="25">25 / page</option>
                        <option value="50">50 / page</option>
                    </select>
                </div>

            </section>

            <!-- ============================================================ -->
            <!-- RIGHT : SKILLS MANAGEMENT SECTION -->
            <!-- ============================================================ -->
            <section class="sims-skill-section" aria-label="Skills Management">

                <div class="sims-section-head">
                    <div>
                        <h2 class="sims-section-title">Skills Management</h2>
                        <p class="sims-section-subtitle">Manage skills that students and companies can use for internship matching.</p>
                    </div>
                    <button type="button" class="sims-btn sims-btn-primary sims-btn-sm" id="btnOpenAddSkill2">
                        <i class="fas fa-plus"></i>
                        <span>Add Skill</span>
                    </button>
                </div>

                <div class="sims-toolbar">
                    <div class="sims-search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="skillSearchInput" placeholder="Search skills..." />
                    </div>
                    <div class="sims-filter-group">
                        <select id="skillStatusFilter" class="sims-select">
                            <option value="all">All Status</option>
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                        <select id="skillTypeFilter" class="sims-select">
                            <option value="all">All Types</option>
                            <option value="technical">Technical</option>
                            <option value="soft-skill">Soft Skill</option>
                            <option value="tool">Tool</option>
                            <option value="framework">Framework</option>
                            <option value="database">Database</option>
                            <option value="other">Other</option>
                        </select>
                        <button type="button" class="sims-btn sims-btn-ghost sims-btn-sm" id="btnResetSkillFilters">
                            <i class="fas fa-rotate-left"></i>
                            <span>Reset</span>
                        </button>
                    </div>
                </div>

                <!-- Bulk toolbar -->
                <div class="sims-bulk-toolbar" id="skillBulkToolbar" style="display:none;">
                    <span class="sims-bulk-count"><span id="skillSelectedCount">0</span> selected</span>
                    <div class="sims-bulk-actions">
                        <button type="button" class="sims-btn sims-btn-ghost sims-btn-sm" data-bulk-action="activate" data-target="skill">
                            <i class="fas fa-toggle-on"></i> Activate Selected
                        </button>
                        <button type="button" class="sims-btn sims-btn-ghost sims-btn-sm" data-bulk-action="deactivate" data-target="skill">
                            <i class="fas fa-toggle-off"></i> Deactivate Selected
                        </button>
                        <button type="button" class="sims-btn sims-btn-ghost sims-btn-sm" data-bulk-action="export" data-target="skill">
                            <i class="fas fa-file-export"></i> Export Selected
                        </button>
                        <button type="button" class="sims-btn sims-btn-ghost sims-btn-sm sims-text-danger" data-bulk-action="delete" data-target="skill">
                            <i class="fas fa-trash"></i> Delete Selected
                        </button>
                    </div>
                </div>

                <div class="sims-table-wrapper">
                    <table class="sims-skill-table" id="skillTable">
                        <thead>
                            <tr>
                                <th class="sims-col-check"><input type="checkbox" id="skillSelectAll" /></th>
                                <th>Skill</th>
                                <th>Type</th>
                                <th>Internships</th>
                                <th>Students</th>
                                <th>Status</th>
                                <th>Created Date</th>
                                <th class="sims-col-actions">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="skillTableBody">

                            <tr class="sims-skill-row" data-name="JavaScript" data-code="JS" data-type="technical" data-status="active"
                                data-description="JavaScript programming language used for web development." data-internships="128" data-students="1,250" data-created="10 Aug 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="skill" /></td>
                                <td><strong>JavaScript</strong></td>
                                <td><span class="sims-skill-type sims-type-technical">Technical</span></td>
                                <td>128</td>
                                <td>1,250</td>
                                <td><span class="sims-skill-status sims-status-active"><i class="fas fa-circle"></i> Active</span></td>
                                <td>10 Aug 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-skill-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Skill</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Skill</a>
                                            <a href="#" class="sims-action-item" data-action="deactivate"><i class="fas fa-toggle-off"></i> Deactivate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item" data-action="view-students"><i class="fas fa-user-graduate"></i> View Students</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr class="sims-skill-row" data-name="ASP.NET" data-code="ASPNET" data-type="framework" data-status="active"
                                data-description="Microsoft framework used for building web applications." data-internships="85" data-students="780" data-created="09 Aug 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="skill" /></td>
                                <td><strong>ASP.NET</strong></td>
                                <td><span class="sims-skill-type sims-type-framework">Framework</span></td>
                                <td>85</td>
                                <td>780</td>
                                <td><span class="sims-skill-status sims-status-active"><i class="fas fa-circle"></i> Active</span></td>
                                <td>09 Aug 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-skill-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Skill</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Skill</a>
                                            <a href="#" class="sims-action-item" data-action="deactivate"><i class="fas fa-toggle-off"></i> Deactivate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item" data-action="view-students"><i class="fas fa-user-graduate"></i> View Students</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr class="sims-skill-row" data-name="SQL" data-code="SQL" data-type="database" data-status="active"
                                data-description="Structured Query Language used for managing relational databases." data-internships="110" data-students="1,050" data-created="07 Aug 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="skill" /></td>
                                <td><strong>SQL</strong></td>
                                <td><span class="sims-skill-type sims-type-database">Database</span></td>
                                <td>110</td>
                                <td>1,050</td>
                                <td><span class="sims-skill-status sims-status-active"><i class="fas fa-circle"></i> Active</span></td>
                                <td>07 Aug 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-skill-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Skill</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Skill</a>
                                            <a href="#" class="sims-action-item" data-action="deactivate"><i class="fas fa-toggle-off"></i> Deactivate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item" data-action="view-students"><i class="fas fa-user-graduate"></i> View Students</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr class="sims-skill-row" data-name="Communication" data-code="COMM" data-type="soft-skill" data-status="active"
                                data-description="Ability to clearly convey and exchange information in a professional setting." data-internships="95" data-students="1,400" data-created="05 Aug 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="skill" /></td>
                                <td><strong>Communication</strong></td>
                                <td><span class="sims-skill-type sims-type-soft-skill">Soft Skill</span></td>
                                <td>95</td>
                                <td>1,400</td>
                                <td><span class="sims-skill-status sims-status-active"><i class="fas fa-circle"></i> Active</span></td>
                                <td>05 Aug 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-skill-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Skill</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Skill</a>
                                            <a href="#" class="sims-action-item" data-action="deactivate"><i class="fas fa-toggle-off"></i> Deactivate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item" data-action="view-students"><i class="fas fa-user-graduate"></i> View Students</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr class="sims-skill-row" data-name="Figma" data-code="FIGMA" data-type="tool" data-status="active"
                                data-description="Design tool used for interface prototyping and collaboration." data-internships="42" data-students="390" data-created="03 Aug 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="skill" /></td>
                                <td><strong>Figma</strong></td>
                                <td><span class="sims-skill-type sims-type-tool">Tool</span></td>
                                <td>42</td>
                                <td>390</td>
                                <td><span class="sims-skill-status sims-status-active"><i class="fas fa-circle"></i> Active</span></td>
                                <td>03 Aug 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-skill-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Skill</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Skill</a>
                                            <a href="#" class="sims-action-item" data-action="deactivate"><i class="fas fa-toggle-off"></i> Deactivate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item" data-action="view-students"><i class="fas fa-user-graduate"></i> View Students</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                            <tr class="sims-skill-row" data-name="Python" data-code="PY" data-type="technical" data-status="active"
                                data-description="General-purpose programming language used across data and web projects." data-internships="96" data-students="850" data-created="01 Aug 2026">
                                <td class="sims-col-check"><input type="checkbox" class="sims-row-check" data-target="skill" /></td>
                                <td><strong>Python</strong></td>
                                <td><span class="sims-skill-type sims-type-technical">Technical</span></td>
                                <td>96</td>
                                <td>850</td>
                                <td><span class="sims-skill-status sims-status-active"><i class="fas fa-circle"></i> Active</span></td>
                                <td>01 Aug 2026</td>
                                <td class="sims-col-actions">
                                    <div class="sims-skill-action-menu">
                                        <button type="button" class="sims-action-btn" aria-label="Actions"><i class="fas fa-ellipsis-vertical"></i></button>
                                        <div class="sims-action-dropdown">
                                            <a href="#" class="sims-action-item" data-action="view"><i class="fas fa-eye"></i> View Skill</a>
                                            <a href="#" class="sims-action-item" data-action="edit"><i class="fas fa-pen"></i> Edit Skill</a>
                                            <a href="#" class="sims-action-item" data-action="deactivate"><i class="fas fa-toggle-off"></i> Deactivate</a>
                                            <a href="#" class="sims-action-item" data-action="view-internships"><i class="fas fa-briefcase"></i> View Internships</a>
                                            <a href="#" class="sims-action-item" data-action="view-students"><i class="fas fa-user-graduate"></i> View Students</a>
                                            <a href="#" class="sims-action-item sims-text-danger" data-action="delete"><i class="fas fa-trash"></i> Delete</a>
                                        </div>
                                    </div>
                                </td>
                            </tr>

                        </tbody>
                    </table>

                    <!-- Empty state -->
                    <div class="sims-empty-state" id="skillEmptyState" style="display:none;">
                        <i class="fas fa-tools"></i>
                        <h3>No Skills Found</h3>
                        <p>Try changing your search or filter criteria.</p>
                        <button type="button" class="sims-btn sims-btn-outline sims-btn-sm" id="btnClearSkillFilters">Clear Filters</button>
                    </div>
                </div>

                <div class="sims-category-skill-pagination">
                    <span class="sims-pagination-info">Showing 1&ndash;10 of 85 skills</span>
                    <div class="sims-pagination-controls">
                        <button type="button" class="sims-page-btn" disabled><i class="fas fa-chevron-left"></i> Previous</button>
                        <button type="button" class="sims-page-btn sims-page-active">1</button>
                        <button type="button" class="sims-page-btn">2</button>
                        <button type="button" class="sims-page-btn">3</button>
                        <button type="button" class="sims-page-btn">Next <i class="fas fa-chevron-right"></i></button>
                    </div>
                    <select class="sims-select sims-page-size">
                        <option value="10">10 / page</option>
                        <option value="25">25 / page</option>
                        <option value="50">50 / page</option>
                    </select>
                </div>

                <!-- Most Used Skills -->
                <div class="sims-most-used-skills">
                    <h3 class="sims-widget-title"><i class="fas fa-ranking-star"></i> Most Used Skills</h3>
                    <div class="sims-progress-row">
                        <span class="sims-progress-label">1. JavaScript</span>
                        <div class="sims-progress-track"><div class="sims-progress-fill" style="width:100%;"></div></div>
                        <span class="sims-progress-value">128</span>
                    </div>
                    <div class="sims-progress-row">
                        <span class="sims-progress-label">2. SQL</span>
                        <div class="sims-progress-track"><div class="sims-progress-fill" style="width:86%;"></div></div>
                        <span class="sims-progress-value">110</span>
                    </div>
                    <div class="sims-progress-row">
                        <span class="sims-progress-label">3. Python</span>
                        <div class="sims-progress-track"><div class="sims-progress-fill" style="width:75%;"></div></div>
                        <span class="sims-progress-value">96</span>
                    </div>
                    <div class="sims-progress-row">
                        <span class="sims-progress-label">4. ASP.NET</span>
                        <div class="sims-progress-track"><div class="sims-progress-fill" style="width:66%;"></div></div>
                        <span class="sims-progress-value">85</span>
                    </div>
                    <div class="sims-progress-row">
                        <span class="sims-progress-label">5. React</span>
                        <div class="sims-progress-track"><div class="sims-progress-fill" style="width:61%;"></div></div>
                        <span class="sims-progress-value">78</span>
                    </div>
                </div>

            </section>

        </div>

        <!-- ================= SECONDARY WIDGETS ROW ================= -->
        <div class="sims-category-skill-widgets-row">

            <!-- Category Distribution -->
            <div class="sims-category-distribution">
                <h3 class="sims-widget-title"><i class="fas fa-chart-simple"></i> Internship Category Distribution</h3>
                <div class="sims-progress-row">
                    <span class="sims-progress-label">Web Development</span>
                    <div class="sims-progress-track"><div class="sims-progress-fill sims-fill-blue" style="width:100%;"></div></div>
                    <span class="sims-progress-value">42</span>
                </div>
                <div class="sims-progress-row">
                    <span class="sims-progress-label">Software Development</span>
                    <div class="sims-progress-track"><div class="sims-progress-fill sims-fill-blue" style="width:90%;"></div></div>
                    <span class="sims-progress-value">38</span>
                </div>
                <div class="sims-progress-row">
                    <span class="sims-progress-label">UI/UX Design</span>
                    <div class="sims-progress-track"><div class="sims-progress-fill sims-fill-blue" style="width:57%;"></div></div>
                    <span class="sims-progress-value">24</span>
                </div>
                <div class="sims-progress-row">
                    <span class="sims-progress-label">Data Analytics</span>
                    <div class="sims-progress-track"><div class="sims-progress-fill sims-fill-blue" style="width:45%;"></div></div>
                    <span class="sims-progress-value">19</span>
                </div>
                <div class="sims-progress-row">
                    <span class="sims-progress-label">Digital Marketing</span>
                    <div class="sims-progress-track"><div class="sims-progress-fill sims-fill-blue" style="width:28%;"></div></div>
                    <span class="sims-progress-value">12</span>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="sims-category-skill-activity">
                <h3 class="sims-widget-title"><i class="fas fa-clock-rotate-left"></i> Recent Activity</h3>
                <ul class="sims-activity-list">
                    <li class="sims-activity-item">
                        <span class="sims-activity-icon sims-activity-icon-add"><i class="fas fa-plus"></i></span>
                        <div class="sims-activity-text">
                            <p>New category added: <strong>Web Development</strong></p>
                            <span class="sims-activity-time">10 minutes ago</span>
                        </div>
                    </li>
                    <li class="sims-activity-item">
                        <span class="sims-activity-icon sims-activity-icon-add"><i class="fas fa-plus"></i></span>
                        <div class="sims-activity-text">
                            <p>Skill added: <strong>React</strong></p>
                            <span class="sims-activity-time">30 minutes ago</span>
                        </div>
                    </li>
                    <li class="sims-activity-item">
                        <span class="sims-activity-icon sims-activity-icon-update"><i class="fas fa-pen"></i></span>
                        <div class="sims-activity-text">
                            <p>Category updated: <strong>Data Analytics</strong></p>
                            <span class="sims-activity-time">1 hour ago</span>
                        </div>
                    </li>
                    <li class="sims-activity-item">
                        <span class="sims-activity-icon sims-activity-icon-warning"><i class="fas fa-toggle-off"></i></span>
                        <div class="sims-activity-text">
                            <p>Skill deactivated: <strong>Flash</strong></p>
                            <span class="sims-activity-time">2 hours ago</span>
                        </div>
                    </li>
                    <li class="sims-activity-item">
                        <span class="sims-activity-icon sims-activity-icon-delete"><i class="fas fa-trash"></i></span>
                        <div class="sims-activity-text">
                            <p>Category deleted: <strong>Digital Marketing</strong></p>
                            <span class="sims-activity-time">3 hours ago</span>
                        </div>
                    </li>
                </ul>
            </div>

        </div>

    </div>

    <!-- ================================================================= -->
    <!-- MODALS -->
    <!-- ================================================================= -->

    <!-- ============ ADD / EDIT CATEGORY MODAL ============ -->
    <div class="sims-category-skill-modal-overlay" id="categoryFormModalOverlay">
        <div class="sims-category-skill-modal" role="dialog" aria-modal="true" aria-labelledby="categoryFormModalTitle">
            <div class="sims-modal-header">
                <h3 class="sims-modal-title" id="categoryFormModalTitle">Add Internship Category</h3>
                <button type="button" class="sims-modal-close" data-close-modal="categoryFormModalOverlay"><i class="fas fa-times"></i></button>
            </div>
            <div class="sims-category-skill-modal-body">
                <form class="sims-category-skill-form" id="categoryForm" onsubmit="return false;">
                    <div class="sims-form-group">
                        <label for="categoryNameInput">Category Name <span class="sims-required">*</span></label>
                        <input type="text" id="categoryNameInput" placeholder="e.g. Web Development" required />
                    </div>
                    <div class="sims-form-group">
                        <label for="categoryCodeInput">Category Code <span class="sims-required">*</span></label>
                        <input type="text" id="categoryCodeInput" placeholder="e.g. WEB-DEV" required />
                    </div>
                    <div class="sims-form-group">
                        <label for="categoryDescInput">Description <span class="sims-required">*</span></label>
                        <textarea id="categoryDescInput" rows="3" placeholder="Short description of this category" required></textarea>
                    </div>
                    <div class="sims-form-row">
                        <div class="sims-form-group">
                            <label for="categoryIconInput">Category Icon</label>
                            <select id="categoryIconInput" class="sims-select">
                                <option value="fa-code">Code</option>
                                <option value="fa-laptop-code">Laptop Code</option>
                                <option value="fa-pen-nib">Design</option>
                                <option value="fa-chart-line">Analytics</option>
                                <option value="fa-bullhorn">Marketing</option>
                            </select>
                        </div>
                        <div class="sims-form-group">
                            <label for="categoryStatusInput">Status <span class="sims-required">*</span></label>
                            <select id="categoryStatusInput" class="sims-select" required>
                                <option value="active">Active</option>
                                <option value="inactive">Inactive</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="sims-modal-footer">
                <button type="button" class="sims-btn sims-btn-outline" data-close-modal="categoryFormModalOverlay">Cancel</button>
                <button type="button" class="sims-btn sims-btn-primary" id="btnSaveCategory">Save Category</button>
            </div>
        </div>
    </div>

    <!-- ============ VIEW CATEGORY MODAL ============ -->
    <div class="sims-category-skill-modal-overlay" id="categoryViewModalOverlay">
        <div class="sims-category-skill-modal" role="dialog" aria-modal="true" aria-labelledby="categoryViewModalTitle">
            <div class="sims-modal-header">
                <h3 class="sims-modal-title" id="categoryViewModalTitle">Category Details</h3>
                <button type="button" class="sims-modal-close" data-close-modal="categoryViewModalOverlay"><i class="fas fa-times"></i></button>
            </div>
            <div class="sims-category-skill-modal-body">
                <div class="sims-info-grid">
                    <div class="sims-info-card">
                        <span class="sims-info-label">Category Name</span>
                        <span class="sims-info-value" id="viewCategoryName">Web Development</span>
                    </div>
                    <div class="sims-info-card">
                        <span class="sims-info-label">Category Code</span>
                        <span class="sims-info-value" id="viewCategoryCode">WEB-DEV</span>
                    </div>
                    <div class="sims-info-card sims-info-card-wide">
                        <span class="sims-info-label">Description</span>
                        <span class="sims-info-value" id="viewCategoryDesc">Web application and website development internships.</span>
                    </div>
                    <div class="sims-info-card">
                        <span class="sims-info-label">Status</span>
                        <span class="sims-info-value" id="viewCategoryStatus"><span class="sims-category-status sims-status-active"><i class="fas fa-circle"></i> Active</span></span>
                    </div>
                    <div class="sims-info-card">
                        <span class="sims-info-label">Created Date</span>
                        <span class="sims-info-value" id="viewCategoryCreated">10 Aug 2026</span>
                    </div>
                    <div class="sims-info-card">
                        <span class="sims-info-label">Last Updated</span>
                        <span class="sims-info-value" id="viewCategoryUpdated">15 Aug 2026</span>
                    </div>
                </div>

                <h4 class="sims-modal-section-title">Statistics</h4>
                <div class="sims-stat-mini-grid">
                    <div class="sims-stat-mini">
                        <span class="sims-stat-mini-value" id="viewCategoryTotalInternships">42</span>
                        <span class="sims-stat-mini-label">Total Internships</span>
                    </div>
                    <div class="sims-stat-mini">
                        <span class="sims-stat-mini-value" id="viewCategoryTotalApplications">680</span>
                        <span class="sims-stat-mini-label">Total Applications</span>
                    </div>
                    <div class="sims-stat-mini">
                        <span class="sims-stat-mini-value">45</span>
                        <span class="sims-stat-mini-label">Selected Students</span>
                    </div>
                    <div class="sims-stat-mini">
                        <span class="sims-stat-mini-value">28</span>
                        <span class="sims-stat-mini-label">Active Internships</span>
                    </div>
                </div>

                <h4 class="sims-modal-section-title">Category &rarr; Internship &rarr; Skills &rarr; Students</h4>
                <div class="sims-relationship-flow">
                    <div class="sims-flow-node">
                        <i class="fas fa-layer-group"></i>
                        <span>Web Development</span>
                    </div>
                    <i class="fas fa-arrow-down sims-flow-arrow"></i>
                    <div class="sims-flow-node">
                        <i class="fas fa-briefcase"></i>
                        <span>42 Internships</span>
                    </div>
                    <i class="fas fa-arrow-down sims-flow-arrow"></i>
                    <div class="sims-flow-node sims-flow-node-tags">
                        <span class="sims-flow-tag">HTML</span>
                        <span class="sims-flow-tag">CSS</span>
                        <span class="sims-flow-tag">JavaScript</span>
                        <span class="sims-flow-tag">ASP.NET</span>
                        <span class="sims-flow-tag">SQL</span>
                    </div>
                    <i class="fas fa-arrow-down sims-flow-arrow"></i>
                    <div class="sims-flow-node">
                        <i class="fas fa-user-graduate"></i>
                        <span>680 Students</span>
                    </div>
                </div>
            </div>
            <div class="sims-modal-footer">
                <button type="button" class="sims-btn sims-btn-outline" data-close-modal="categoryViewModalOverlay">Close</button>
                <button type="button" class="sims-btn sims-btn-primary" id="btnViewCategoryInternships">View Internships</button>
            </div>
        </div>
    </div>

    <!-- ============ DELETE CATEGORY MODAL ============ -->
    <div class="sims-category-skill-modal-overlay" id="categoryDeleteModalOverlay">
        <div class="sims-category-skill-modal sims-modal-sm" role="dialog" aria-modal="true" aria-labelledby="categoryDeleteModalTitle">
            <div class="sims-modal-header">
                <h3 class="sims-modal-title sims-text-danger" id="categoryDeleteModalTitle">Delete Category</h3>
                <button type="button" class="sims-modal-close" data-close-modal="categoryDeleteModalOverlay"><i class="fas fa-times"></i></button>
            </div>
            <div class="sims-category-skill-modal-body">
                <div class="sims-danger-icon"><i class="fas fa-triangle-exclamation"></i></div>
                <p class="sims-modal-message">Are you sure you want to delete this category?</p>
                <div class="sims-modal-target-name">
                    Category: <strong id="deleteCategoryName">Web Development</strong>
                </div>

                <!-- Blocked delete state -->
                <div class="sims-alert sims-alert-danger" id="categoryDeleteBlocked">
                    <i class="fas fa-circle-exclamation"></i>
                    <span>This category cannot be deleted because it is currently associated with <strong id="deleteCategoryInternshipCount">42</strong> active internships.</span>
                </div>

                <!-- Allowed delete state -->
                <div class="sims-alert sims-alert-warning" id="categoryDeleteWarning" style="display:none;">
                    <i class="fas fa-circle-info"></i>
                    <span>This action cannot be undone.</span>
                </div>
            </div>
            <div class="sims-modal-footer">
                <button type="button" class="sims-btn sims-btn-outline" data-close-modal="categoryDeleteModalOverlay">Cancel</button>
                <button type="button" class="sims-btn sims-btn-outline" id="btnViewAssociatedInternships">View Associated Internships</button>
                <button type="button" class="sims-btn sims-btn-danger" id="btnConfirmDeleteCategory" style="display:none;">Delete Category</button>
            </div>
        </div>
    </div>

    <!-- ============ ACTIVATE / DEACTIVATE CATEGORY MODAL ============ -->
    <div class="sims-category-skill-modal-overlay" id="categoryStatusModalOverlay">
        <div class="sims-category-skill-modal sims-modal-sm" role="dialog" aria-modal="true" aria-labelledby="categoryStatusModalTitle">
            <div class="sims-modal-header">
                <h3 class="sims-modal-title" id="categoryStatusModalTitle">Deactivate Category</h3>
                <button type="button" class="sims-modal-close" data-close-modal="categoryStatusModalOverlay"><i class="fas fa-times"></i></button>
            </div>
            <div class="sims-category-skill-modal-body">
                <p class="sims-modal-message" id="categoryStatusModalMessage">Are you sure you want to deactivate this category?</p>
                <div class="sims-alert sims-alert-warning" id="categoryStatusModalWarning">
                    <i class="fas fa-circle-info"></i>
                    <span>New internships will not be able to use this category.</span>
                </div>
            </div>
            <div class="sims-modal-footer">
                <button type="button" class="sims-btn sims-btn-outline" data-close-modal="categoryStatusModalOverlay">Cancel</button>
                <button type="button" class="sims-btn sims-btn-warning" id="btnConfirmCategoryStatus">Deactivate</button>
            </div>
        </div>
    </div>

    <!-- ============ ADD / EDIT SKILL MODAL ============ -->
    <div class="sims-category-skill-modal-overlay" id="skillFormModalOverlay">
        <div class="sims-category-skill-modal" role="dialog" aria-modal="true" aria-labelledby="skillFormModalTitle">
            <div class="sims-modal-header">
                <h3 class="sims-modal-title" id="skillFormModalTitle">Add Skill</h3>
                <button type="button" class="sims-modal-close" data-close-modal="skillFormModalOverlay"><i class="fas fa-times"></i></button>
            </div>
            <div class="sims-category-skill-modal-body">
                <form class="sims-category-skill-form" id="skillForm" onsubmit="return false;">
                    <div class="sims-form-row">
                        <div class="sims-form-group">
                            <label for="skillNameInput">Skill Name <span class="sims-required">*</span></label>
                            <input type="text" id="skillNameInput" placeholder="e.g. JavaScript" required />
                        </div>
                        <div class="sims-form-group">
                            <label for="skillCodeInput">Skill Code <span class="sims-required">*</span></label>
                            <input type="text" id="skillCodeInput" placeholder="e.g. JS" required />
                        </div>
                    </div>
                    <div class="sims-form-group">
                        <label for="skillTypeInput">Skill Type <span class="sims-required">*</span></label>
                        <select id="skillTypeInput" class="sims-select" required>
                            <option value="technical">Technical</option>
                            <option value="soft-skill">Soft Skill</option>
                            <option value="framework">Framework</option>
                            <option value="database">Database</option>
                            <option value="tool">Tool</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="sims-form-group">
                        <label for="skillDescInput">Description</label>
                        <textarea id="skillDescInput" rows="3" placeholder="Short description of this skill"></textarea>
                    </div>
                    <div class="sims-form-group">
                        <label for="skillStatusInput">Status <span class="sims-required">*</span></label>
                        <select id="skillStatusInput" class="sims-select" required>
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="sims-modal-footer">
                <button type="button" class="sims-btn sims-btn-outline" data-close-modal="skillFormModalOverlay">Cancel</button>
                <button type="button" class="sims-btn sims-btn-primary" id="btnSaveSkill">Save Skill</button>
            </div>
        </div>
    </div>

    <!-- ============ VIEW SKILL MODAL ============ -->
    <div class="sims-category-skill-modal-overlay" id="skillViewModalOverlay">
        <div class="sims-category-skill-modal" role="dialog" aria-modal="true" aria-labelledby="skillViewModalTitle">
            <div class="sims-modal-header">
                <h3 class="sims-modal-title" id="skillViewModalTitle">Skill Details</h3>
                <button type="button" class="sims-modal-close" data-close-modal="skillViewModalOverlay"><i class="fas fa-times"></i></button>
            </div>
            <div class="sims-category-skill-modal-body">
                <div class="sims-info-grid">
                    <div class="sims-info-card">
                        <span class="sims-info-label">Skill Name</span>
                        <span class="sims-info-value" id="viewSkillName">JavaScript</span>
                    </div>
                    <div class="sims-info-card">
                        <span class="sims-info-label">Skill Code</span>
                        <span class="sims-info-value" id="viewSkillCode">JS</span>
                    </div>
                    <div class="sims-info-card">
                        <span class="sims-info-label">Skill Type</span>
                        <span class="sims-info-value" id="viewSkillType"><span class="sims-skill-type sims-type-technical">Technical</span></span>
                    </div>
                    <div class="sims-info-card">
                        <span class="sims-info-label">Status</span>
                        <span class="sims-info-value" id="viewSkillStatus"><span class="sims-skill-status sims-status-active"><i class="fas fa-circle"></i> Active</span></span>
                    </div>
                    <div class="sims-info-card sims-info-card-wide">
                        <span class="sims-info-label">Description</span>
                        <span class="sims-info-value" id="viewSkillDesc">JavaScript programming language used for web development.</span>
                    </div>
                    <div class="sims-info-card">
                        <span class="sims-info-label">Created Date</span>
                        <span class="sims-info-value" id="viewSkillCreated">10 Aug 2026</span>
                    </div>
                    <div class="sims-info-card">
                        <span class="sims-info-label">Last Updated</span>
                        <span class="sims-info-value" id="viewSkillUpdated">17 Aug 2026</span>
                    </div>
                </div>

                <h4 class="sims-modal-section-title">Statistics</h4>
                <div class="sims-stat-mini-grid">
                    <div class="sims-stat-mini">
                        <span class="sims-stat-mini-value" id="viewSkillInternships">128</span>
                        <span class="sims-stat-mini-label">Used in Internships</span>
                    </div>
                    <div class="sims-stat-mini">
                        <span class="sims-stat-mini-value" id="viewSkillStudents">1,250</span>
                        <span class="sims-stat-mini-label">Students with Skill</span>
                    </div>
                    <div class="sims-stat-mini">
                        <span class="sims-stat-mini-value">2,850</span>
                        <span class="sims-stat-mini-label">Applications</span>
                    </div>
                    <div class="sims-stat-mini">
                        <span class="sims-stat-mini-value">180</span>
                        <span class="sims-stat-mini-label">Selected Students</span>
                    </div>
                </div>
            </div>
            <div class="sims-modal-footer">
                <button type="button" class="sims-btn sims-btn-outline" data-close-modal="skillViewModalOverlay">Close</button>
                <button type="button" class="sims-btn sims-btn-outline" id="btnViewSkillStudents">View Students</button>
                <button type="button" class="sims-btn sims-btn-primary" id="btnViewSkillInternships">View Internships</button>
            </div>
        </div>
    </div>

    <!-- ============ DELETE SKILL MODAL ============ -->
    <div class="sims-category-skill-modal-overlay" id="skillDeleteModalOverlay">
        <div class="sims-category-skill-modal sims-modal-sm" role="dialog" aria-modal="true" aria-labelledby="skillDeleteModalTitle">
            <div class="sims-modal-header">
                <h3 class="sims-modal-title sims-text-danger" id="skillDeleteModalTitle">Delete Skill</h3>
                <button type="button" class="sims-modal-close" data-close-modal="skillDeleteModalOverlay"><i class="fas fa-times"></i></button>
            </div>
            <div class="sims-category-skill-modal-body">
                <div class="sims-danger-icon"><i class="fas fa-triangle-exclamation"></i></div>
                <p class="sims-modal-message">Are you sure you want to delete this skill?</p>
                <div class="sims-modal-target-name">
                    Skill: <strong id="deleteSkillName">JavaScript</strong>
                </div>

                <div class="sims-alert sims-alert-danger" id="skillDeleteBlocked">
                    <i class="fas fa-circle-exclamation"></i>
                    <span>This skill cannot be deleted because it is currently associated with <strong id="deleteSkillInternshipCount">128</strong> internships and <strong id="deleteSkillStudentCount">1,250</strong> student profiles.</span>
                </div>

                <div class="sims-alert sims-alert-warning" id="skillDeleteWarning" style="display:none;">
                    <i class="fas fa-circle-info"></i>
                    <span>This action cannot be undone.</span>
                </div>
            </div>
            <div class="sims-modal-footer">
                <button type="button" class="sims-btn sims-btn-outline" data-close-modal="skillDeleteModalOverlay">Cancel</button>
                <button type="button" class="sims-btn sims-btn-outline" id="btnViewAssociatedRecords">View Associated Records</button>
                <button type="button" class="sims-btn sims-btn-danger" id="btnConfirmDeleteSkill" style="display:none;">Delete Skill</button>
            </div>
        </div>
    </div>

    <!-- ============ ACTIVATE / DEACTIVATE SKILL MODAL ============ -->
    <div class="sims-category-skill-modal-overlay" id="skillStatusModalOverlay">
        <div class="sims-category-skill-modal sims-modal-sm" role="dialog" aria-modal="true" aria-labelledby="skillStatusModalTitle">
            <div class="sims-modal-header">
                <h3 class="sims-modal-title" id="skillStatusModalTitle">Deactivate Skill</h3>
                <button type="button" class="sims-modal-close" data-close-modal="skillStatusModalOverlay"><i class="fas fa-times"></i></button>
            </div>
            <div class="sims-category-skill-modal-body">
                <p class="sims-modal-message" id="skillStatusModalMessage">Are you sure you want to deactivate this skill?</p>
                <div class="sims-alert sims-alert-warning" id="skillStatusModalWarning">
                    <i class="fas fa-circle-info"></i>
                    <span>Students and companies will no longer be able to select this skill for new records.</span>
                </div>
            </div>
            <div class="sims-modal-footer">
                <button type="button" class="sims-btn sims-btn-outline" data-close-modal="skillStatusModalOverlay">Cancel</button>
                <button type="button" class="sims-btn sims-btn-warning" id="btnConfirmSkillStatus">Deactivate</button>
            </div>
        </div>
    </div>

    <!-- ============ TOAST CONTAINER ============ -->
    <div class="sims-toast-container" id="simsToastContainer"></div>

    <script src="../js/admin-categories-skills.js"></script>
</asp:Content>






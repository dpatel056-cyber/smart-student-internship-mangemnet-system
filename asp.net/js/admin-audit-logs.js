document.addEventListener("DOMContentLoaded", function () {
    // Audit log records generator & dataset
    const baseRecords = [
        { name: "Dhruvi Patel", email: "dhruvi.patel@gmail.com", role: "Admin", loginDate: "21 Aug 2026", loginTime: "10:30 AM", logoutTime: "12:45 PM", duration: "2h 15m", ongoing: false, ip: "192.168.1.10", status: "Active", avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=80" },
        { name: "Rahul Shah", email: "rahul.shah@gmail.com", role: "Company", loginDate: "21 Aug 2026", loginTime: "09:15 AM", logoutTime: "11:30 AM", duration: "2h 15m", ongoing: false, ip: "192.168.1.15", status: "Logged Out", avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80" },
        { name: "Priya Patel", email: "priya.patel@gmail.com", role: "Student", loginDate: "21 Aug 2026", loginTime: "08:50 AM", logoutTime: "—", duration: "1h 42m", ongoing: true, ip: "192.168.1.20", status: "Active", avatar: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=100&auto=format&fit=crop&q=80" },
        { name: "Amit Joshi", email: "amit.joshi@gmail.com", role: "Admin", loginDate: "21 Aug 2026", loginTime: "07:45 AM", logoutTime: "08:30 AM", duration: "45m", ongoing: false, ip: "192.168.1.12", status: "Logged Out", avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&auto=format&fit=crop&q=80" },
        { name: "Neha Sharma", email: "neha.sharma@gmail.com", role: "Company", loginDate: "21 Aug 2026", loginTime: "06:20 AM", logoutTime: "06:45 AM", duration: "25m", ongoing: false, ip: "192.168.1.18", status: "Logged Out", avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&auto=format&fit=crop&q=80" },
        { name: "Karan Mehta", email: "karan.mehta@gmail.com", role: "Student", loginDate: "21 Aug 2026", loginTime: "05:10 AM", logoutTime: "—", duration: "3h 22m", ongoing: true, ip: "192.168.1.25", status: "Active", avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&auto=format&fit=crop&q=80" },
        { name: "Vivek Singh", email: "vivek.singh@gmail.com", role: "Student", loginDate: "21 Aug 2026", loginTime: "04:30 AM", logoutTime: "—", duration: "—", ongoing: false, ip: "192.168.1.30", status: "Failed", avatar: "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=100&auto=format&fit=crop&q=80" },
        { name: "Anjali Dave", email: "anjali.dave@gmail.com", role: "Company", loginDate: "21 Aug 2026", loginTime: "03:15 AM", logoutTime: "04:00 AM", duration: "45m", ongoing: false, ip: "192.168.1.35", status: "Logged Out", avatar: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&auto=format&fit=crop&q=80" },
        { name: "Harsh Patel", email: "harsh.patel@gmail.com", role: "Student", loginDate: "21 Aug 2026", loginTime: "02:40 AM", logoutTime: "—", duration: "5h 10m", ongoing: true, ip: "192.168.1.42", status: "Active", avatar: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100&auto=format&fit=crop&q=80" },
        { name: "Sneha Desai", email: "sneha.desai@gmail.com", role: "Student", loginDate: "21 Aug 2026", loginTime: "01:20 AM", logoutTime: "02:10 AM", duration: "50m", ongoing: false, ip: "192.168.1.48", status: "Logged Out", avatar: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=100&auto=format&fit=crop&q=80" }
    ];

    // Generate full dataset of 248 items
    const allRecords = [];
    const rolesList = ["Admin", "Company", "Student", "Student", "Company", "Student"];
    const statusesList = ["Active", "Logged Out", "Logged Out", "Active", "Logged Out", "Failed"];
    const namesList = [
        "Dhruvi Patel", "Rahul Shah", "Priya Patel", "Amit Joshi", "Neha Sharma",
        "Karan Mehta", "Vivek Singh", "Anjali Dave", "Harsh Patel", "Sneha Desai",
        "Rohan Gupta", "Pooja Varma", "Manish Trivedi", "Kinjal Rathod", "Jaydeep Parmar",
        "Bhavin Soni", "Riddhi Zala", "Nirav Patel", "Aayushi Pandya", "Chirag Barot",
        "Darshan Solanki", "Hiral Bhatt", "Jignesh Vora", "Meera Panchal", "Yashvi Shah"
    ];

    for (let i = 0; i < 248; i++) {
        if (i < baseRecords.length) {
            allRecords.push(baseRecords[i]);
        } else {
            const name = namesList[i % namesList.length];
            const email = name.toLowerCase().replace(" ", ".") + (i > 24 ? i : "") + "@gmail.com";
            const role = rolesList[i % rolesList.length];
            const status = statusesList[i % statusesList.length];
            const isOngoing = (status === "Active" && (i % 2 === 0));
            const duration = status === "Failed" ? "—" : ((i % 4 + 1) + "h " + (i * 7 % 60) + "m");
            const logoutTime = (status === "Active" || status === "Failed") ? "—" : ((i % 12 + 1) + ":" + (i * 5 % 60 < 10 ? "0" : "") + (i * 5 % 60) + " PM");
            const loginHour = (i % 12 + 1);
            const loginTime = (loginHour < 10 ? "0" : "") + loginHour + ":" + (i * 3 % 60 < 10 ? "0" : "") + (i * 3 % 60) + (i % 2 === 0 ? " AM" : " PM");
            const ip = "192.168.1." + (10 + (i % 150));
            const avatar = "https://ui-avatars.com/api/?name=" + encodeURIComponent(name) + "&background=" + (role === "Admin" ? "f3e8ff&color=7c3aed" : role === "Company" ? "ffedd5&color=ea580c" : "dbeafe&color=2563eb");

            allRecords.push({
                name: name,
                email: email,
                role: role,
                loginDate: "21 Aug 2026",
                loginTime: loginTime,
                logoutTime: logoutTime,
                duration: duration,
                ongoing: isOngoing,
                ip: ip,
                status: status,
                avatar: avatar
            });
        }
    }

    // State
    let currentPage = 1;
    let pageSize = 10;
    let filteredRecords = [...allRecords];

    // DOM Elements
    const searchInput = document.getElementById("auditSearchInput");
    const roleSelect = document.getElementById("filterRole");
    const statusSelect = document.getElementById("filterStatus");
    const dateRangeSelect = document.getElementById("filterDateRange");
    const customDateGroup = document.getElementById("customDateGroup");
    const customStartDate = document.getElementById("customStartDate");
    const customEndDate = document.getElementById("customEndDate");
    const searchBtn = document.getElementById("btnSearchAudit");
    const resetBtn = document.getElementById("btnResetAuditFilters");
    const tableBody = document.getElementById("auditTableBody");
    const pageSizeSelect = document.getElementById("auditPageSize");
    const entriesInfo = document.getElementById("auditEntriesInfo");
    const paginationNav = document.getElementById("auditPaginationNav");

    // Top stat cards
    const statTotalUsers = document.getElementById("statTotalUsers");
    const statActiveNow = document.getElementById("statActiveNow");
    const statLoggedOut = document.getElementById("statLoggedOut");
    const statFailedLogin = document.getElementById("statFailedLogin");

    function updateStats() {
        if (statTotalUsers) statTotalUsers.textContent = "248";
        if (statActiveNow) statActiveNow.textContent = "32";
        if (statLoggedOut) statLoggedOut.textContent = "210";
        if (statFailedLogin) statFailedLogin.textContent = "6";
    }

    function handleDateRangeChange() {
        if (dateRangeSelect && customDateGroup) {
            if (dateRangeSelect.value === "Custom") {
                customDateGroup.style.display = "flex";
            } else {
                customDateGroup.style.display = "none";
            }
        }
    }

    function filterData() {
        const query = searchInput ? searchInput.value.toLowerCase().trim() : "";
        const selectedRole = roleSelect ? roleSelect.value : "All";
        const selectedStatus = statusSelect ? statusSelect.value : "All";

        filteredRecords = allRecords.filter(item => {
            const matchesSearch = !query || item.name.toLowerCase().includes(query) || item.email.toLowerCase().includes(query);
            const matchesRole = (selectedRole === "All" || item.role === selectedRole);
            const matchesStatus = (selectedStatus === "All" || item.status === selectedStatus);
            return matchesSearch && matchesRole && matchesStatus;
        });

        currentPage = 1;
        renderTable();
    }

    function renderTable() {
        if (!tableBody) return;

        const totalItems = filteredRecords.length;
        const totalPages = Math.ceil(totalItems / pageSize) || 1;

        if (currentPage > totalPages) currentPage = totalPages;
        if (currentPage < 1) currentPage = 1;

        const startIndex = (currentPage - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, totalItems);
        const currentSlice = filteredRecords.slice(startIndex, endIndex);

        // Render Rows
        if (currentSlice.length === 0) {
            tableBody.innerHTML = `
                <tr>
                    <td colspan="9" style="text-align:center; padding: 30px; color: #64748b;">
                        No audit logs found matching your filters.
                    </td>
                </tr>
            `;
        } else {
            let html = "";
            currentSlice.forEach(item => {
                const roleClass = item.role === "Admin" ? "role-admin" : item.role === "Company" ? "role-company" : "role-student";
                const statusClass = item.status === "Active" ? "status-active" : item.status === "Logged Out" ? "status-loggedout" : "status-failed";

                html += `
                    <tr data-role="${item.role}" data-status="${item.status}">
                        <td>
                            <div class="audit-user-cell">
                                <img src="${item.avatar}" alt="${item.name}" class="audit-avatar" onerror="this.src='https://ui-avatars.com/api/?name=${encodeURIComponent(item.name)}&background=e2e8f0&color=333'" />
                                <span class="audit-username">${item.name}</span>
                            </div>
                        </td>
                        <td class="audit-email">${item.email}</td>
                        <td><span class="role-badge ${roleClass}">${item.role}</span></td>
                        <td>${item.loginDate}</td>
                        <td>${item.loginTime}</td>
                        <td>${item.logoutTime}</td>
                        <td class="audit-duration">
                            ${item.duration}
                            ${item.ongoing ? '<span class="duration-ongoing">Ongoing</span>' : ''}
                        </td>
                        <td class="audit-ip">${item.ip}</td>
                        <td><span class="status-badge ${statusClass}"><span class="status-dot"></span> ${item.status}</span></td>
                    </tr>
                `;
            });
            tableBody.innerHTML = html;
        }

        // Render Entries Info
        if (entriesInfo) {
            if (totalItems === 0) {
                entriesInfo.textContent = "Showing 0 to 0 of 0 entries";
            } else {
                entriesInfo.textContent = `Showing ${startIndex + 1} to ${endIndex} of ${totalItems} entries`;
            }
        }

        // Render Pagination Buttons
        renderPagination(totalPages);
    }

    function renderPagination(totalPages) {
        if (!paginationNav) return;

        let navHtml = "";

        // Prev button
        const isPrevDisabled = currentPage === 1;
        navHtml += `<button type="button" class="page-btn page-nav-btn" ${isPrevDisabled ? "disabled style='opacity:0.4; cursor:not-allowed;'" : ""} id="btnPrevPage" title="Previous Page"><i class="fa-solid fa-chevron-left"></i></button>`;

        // Helper to add a page button
        function addPageBtn(p) {
            const activeClass = p === currentPage ? "active" : "";
            navHtml += `<button type="button" class="page-btn ${activeClass}" data-page="${p}">${p}</button>`;
        }

        function addEllipsis() {
            navHtml += `<span class="page-ellipsis">...</span>`;
        }

        if (totalPages <= 7) {
            for (let i = 1; i <= totalPages; i++) {
                addPageBtn(i);
            }
        } else {
            // Complex pagination with ellipsis
            if (currentPage <= 4) {
                for (let i = 1; i <= 5; i++) {
                    addPageBtn(i);
                }
                addEllipsis();
                addPageBtn(totalPages);
            } else if (currentPage >= totalPages - 3) {
                addPageBtn(1);
                addEllipsis();
                for (let i = totalPages - 4; i <= totalPages; i++) {
                    addPageBtn(i);
                }
            } else {
                addPageBtn(1);
                addEllipsis();
                addPageBtn(currentPage - 1);
                addPageBtn(currentPage);
                addPageBtn(currentPage + 1);
                addEllipsis();
                addPageBtn(totalPages);
            }
        }

        // Next button
        const isNextDisabled = currentPage === totalPages || totalPages === 0;
        navHtml += `<button type="button" class="page-btn page-nav-btn" ${isNextDisabled ? "disabled style='opacity:0.4; cursor:not-allowed;'" : ""} id="btnNextPage" title="Next Page"><i class="fa-solid fa-chevron-right"></i></button>`;

        paginationNav.innerHTML = navHtml;

        // Attach pagination click handlers
        const pageBtns = paginationNav.querySelectorAll(".page-btn[data-page]");
        pageBtns.forEach(btn => {
            btn.addEventListener("click", function () {
                const pageNum = parseInt(this.getAttribute("data-page"), 10);
                if (pageNum && pageNum !== currentPage) {
                    currentPage = pageNum;
                    renderTable();
                }
            });
        });

        const prevBtn = document.getElementById("btnPrevPage");
        if (prevBtn && !isPrevDisabled) {
            prevBtn.addEventListener("click", function () {
                if (currentPage > 1) {
                    currentPage--;
                    renderTable();
                }
            });
        }

        const nextBtn = document.getElementById("btnNextPage");
        if (nextBtn && !isNextDisabled) {
            nextBtn.addEventListener("click", function () {
                if (currentPage < totalPages) {
                    currentPage++;
                    renderTable();
                }
            });
        }
    }

    // Page size change handler
    if (pageSizeSelect) {
        pageSizeSelect.addEventListener("change", function () {
            pageSize = parseInt(this.value, 10) || 10;
            currentPage = 1;
            renderTable();
        });
    }

    // Filter Listeners
    if (searchInput) {
        searchInput.addEventListener("input", filterData);
        searchInput.addEventListener("keyup", function (e) {
            if (e.key === "Enter") filterData();
        });
    }

    if (roleSelect) {
        roleSelect.addEventListener("change", filterData);
    }

    if (statusSelect) {
        statusSelect.addEventListener("change", filterData);
    }

    if (dateRangeSelect) {
        dateRangeSelect.addEventListener("change", function () {
            handleDateRangeChange();
            filterData();
        });
    }

    if (searchBtn) {
        searchBtn.addEventListener("click", filterData);
    }

    if (resetBtn) {
        resetBtn.addEventListener("click", function () {
            if (searchInput) searchInput.value = "";
            if (roleSelect) roleSelect.value = "All";
            if (statusSelect) statusSelect.value = "All";
            if (dateRangeSelect) dateRangeSelect.value = "Today";
            if (customStartDate) customStartDate.value = "";
            if (customEndDate) customEndDate.value = "";
            if (pageSizeSelect) pageSizeSelect.value = "10";
            pageSize = 10;
            handleDateRangeChange();
            filterData();
        });
    }

    // Initial render
    updateStats();
    renderTable();
});
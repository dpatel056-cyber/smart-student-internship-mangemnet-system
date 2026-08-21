document.addEventListener("DOMContentLoaded", function () {
    let companies = [
        {
            id: "COM001",
            name: "ABC Technologies",
            email: "abc@gmail.com",
            phone: "+91 98250 12345",
            website: "https://abctechnologies.in",
            industry: "Information Technology",
            location: "Rajkot",
            type: "Private Limited",
            founded: "2018",
            regDate: "21 Aug 2026",
            status: "Active",
            logo: "https://images.unsplash.com/photo-1549923746-c502d488b3ea?w=100&auto=format&fit=crop&q=80",
            address: "401-404, Crystal Plaza, Kalawad Road",
            city: "Rajkot",
            state: "Gujarat",
            country: "India",
            pincode: "360005",
            contactName: "Rajesh Kumar",
            contactEmail: "rajesh.hr@abc.com",
            contactPhone: "+91 98980 54321",
            contactDesignation: "HR Manager"
        },
        {
            id: "COM002",
            name: "XYZ Solutions",
            email: "xyz@gmail.com",
            phone: "+91 98240 54321",
            website: "https://xyzsolutions.com",
            industry: "Finance",
            location: "Ahmedabad",
            type: "Private Limited",
            founded: "2020",
            regDate: "20 Aug 2026",
            status: "Pending",
            logo: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=100&auto=format&fit=crop&q=80",
            address: "8th Floor, Mondeal Heights, S.G. Highway",
            city: "Ahmedabad",
            state: "Gujarat",
            country: "India",
            pincode: "380015",
            contactName: "Sunil Mehta",
            contactEmail: "sunil@xyz.com",
            contactPhone: "+91 98790 12345",
            contactDesignation: "Director"
        },
        {
            id: "COM003",
            name: "TechNova Pvt Ltd",
            email: "info@technova.com",
            phone: "+91 98251 98765",
            website: "https://technova.io",
            industry: "Software",
            location: "Surat",
            type: "Private Limited",
            founded: "2019",
            regDate: "19 Aug 2026",
            status: "Blocked",
            logo: "https://images.unsplash.com/photo-1551836022-d5d88e9218df?w=100&auto=format&fit=crop&q=80",
            address: "302, Titanium Square, Ring Road",
            city: "Surat",
            state: "Gujarat",
            country: "India",
            pincode: "395002",
            contactName: "Pooja Shah",
            contactEmail: "pooja@technova.com",
            contactPhone: "+91 97230 45678",
            contactDesignation: "HR Head"
        },
        {
            id: "COM004",
            name: "Bright Solutions",
            email: "contact@bright.com",
            phone: "+91 98252 67890",
            website: "https://brightsolutions.org",
            industry: "Education",
            location: "Vadodara",
            type: "Partnership",
            founded: "2021",
            regDate: "18 Aug 2026",
            status: "Active",
            logo: "https://images.unsplash.com/photo-1572021335469-31706a17aaef?w=100&auto=format&fit=crop&q=80",
            address: "12, Alkapuri Arcade, RC Dutt Road",
            city: "Vadodara",
            state: "Gujarat",
            country: "India",
            pincode: "390007",
            contactName: "Anand Patel",
            contactEmail: "anand@bright.com",
            contactPhone: "+91 98245 67890",
            contactDesignation: "Founder & CEO"
        },
        {
            id: "COM005",
            name: "Apex Infotech",
            email: "career@apexinfo.com",
            phone: "+91 98253 11223",
            website: "https://apexinfotech.in",
            industry: "Information Technology",
            location: "Gandhinagar",
            type: "Startup",
            founded: "2023",
            regDate: "17 Aug 2026",
            status: "Active",
            logo: "https://images.unsplash.com/photo-1560179707-f14e90ef3623?w=100&auto=format&fit=crop&q=80",
            address: "Infocity Tower 1, Sector 9",
            city: "Gandhinagar",
            state: "Gujarat",
            country: "India",
            pincode: "382007",
            contactName: "Kavita Rao",
            contactEmail: "kavita@apexinfo.com",
            contactPhone: "+91 98250 99887",
            contactDesignation: "Talent Acquisition Lead"
        }
    ];

    const industries = ["Information Technology", "Finance", "Software", "Education", "Healthcare", "Manufacturing"];
    const locations = ["Rajkot", "Ahmedabad", "Surat", "Vadodara", "Gandhinagar"];
    const types = ["Private Limited", "Public Limited", "Partnership", "Proprietorship", "Startup"];
    const statuses = ["Active", "Active", "Active", "Active", "Pending", "Blocked"];
    const sampleNames = ["Global Tech Ltd", "FinCorp Advisory", "Innovate Labs", "CloudSoft Technologies", "Matrix Infoway", "SmartEdu Systems", "CureHealth IT", "Swift Logistics Corp", "Quantum Software", "Nexus Digital"];

    for (let i = 6; i <= 248; i++) {
        const name = sampleNames[i % sampleNames.length] + (i > 10 ? ` ${i}` : "");
        const numStr = (i < 100 ? "0" : "") + (i < 10 ? "0" : "") + i;
        const loc = locations[i % locations.length];
        companies.push({
            id: `COM${numStr}`,
            name: name,
            email: name.toLowerCase().replace(/[^a-z0-9]/g, ".") + "@gmail.com",
            phone: `+91 98250 ${10000 + (i % 90000)}`,
            website: `https://${name.toLowerCase().replace(/[^a-z0-9]/g, "")}.com`,
            industry: industries[i % industries.length],
            location: loc,
            type: types[i % types.length],
            founded: `${2015 + (i % 10)}`,
            regDate: `${Math.max(1, 21 - (i % 20))} Aug 2026`,
            status: statuses[i % statuses.length],
            logo: `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=2563eb&color=fff`,
            address: `Phase ${i % 5 + 1}, GIDC Industrial Area`,
            city: loc,
            state: "Gujarat",
            country: "India",
            pincode: "380001",
            contactName: "Amit Trivedi",
            contactEmail: `contact.${numStr}@domain.com`,
            contactPhone: `+91 98980 ${10000 + (i % 90000)}`,
            contactDesignation: "HR Manager"
        });
    }

    let currentPage = 1;
    let pageSize = 10;
    let filteredCompanies = [...companies];
    let selectedCompany = null;

    const searchInput = document.getElementById("cmpSearchInput");
    const filterStatus = document.getElementById("filterCmpStatus");
    const filterIndustry = document.getElementById("filterCmpIndustry");
    const filterLocation = document.getElementById("filterCmpLocation");
    const filterType = document.getElementById("filterCmpType");
    const filterRegDate = document.getElementById("filterCmpRegDate");
    const btnClear = document.getElementById("btnClearCmpFilters");
    const tableBody = document.getElementById("companyTableBody");
    const pageSizeSelect = document.getElementById("cmpPageSize");
    const entriesInfo = document.getElementById("cmpEntriesInfo");
    const paginationNav = document.getElementById("cmpPaginationNav");
    const toastEl = document.getElementById("cmpToast");

    const drawerOverlay = document.getElementById("cmpDrawerOverlay");
    const btnCloseDrawer = document.getElementById("btnCloseCmpDrawer");
    const drawerLogo = document.getElementById("drawerCmpLogo");
    const drawerName = document.getElementById("drawerCmpName");
    const drawerId = document.getElementById("drawerCmpId");
    const drawerStatusBadge = document.getElementById("drawerCmpStatusBadge");
    const drawerBtnEdit = document.getElementById("drawerBtnEditCmp");
    const drawerBtnApprove = document.getElementById("drawerBtnApproveCmp");
    const drawerBtnBlock = document.getElementById("drawerBtnBlockCmp");
    const drawerBtnDelete = document.getElementById("drawerBtnDeleteCmp");

    const modalAdd = document.getElementById("modalAddCompany");
    const modalEdit = document.getElementById("modalEditCompany");
    const modalBlock = document.getElementById("modalBlockCompany");
    const modalDelete = document.getElementById("modalDeleteCompany");
    const btnOpenAdd = document.getElementById("btnOpenAddCompanyModal");

    function showToast(msg) {
        if (!toastEl) return;
        toastEl.innerHTML = `<i class="fa-solid fa-circle-check" style="color:#10b981;"></i> ${msg}`;
        toastEl.style.display = "block";
        setTimeout(() => { toastEl.style.display = "none"; }, 3000);
    }

    function applyFilters() {
        const query = searchInput ? searchInput.value.toLowerCase().trim() : "";
        const statusVal = filterStatus ? filterStatus.value : "All";
        const industryVal = filterIndustry ? filterIndustry.value : "All";
        const locationVal = filterLocation ? filterLocation.value : "All";
        const typeVal = filterType ? filterType.value : "All";

        filteredCompanies = companies.filter(item => {
            const matchesQuery = !query || item.name.toLowerCase().includes(query) || item.email.toLowerCase().includes(query) || item.id.toLowerCase().includes(query);
            const matchesStatus = (statusVal === "All" || item.status === statusVal);
            const matchesIndustry = (industryVal === "All" || item.industry === industryVal);
            const matchesLocation = (locationVal === "All" || item.location === locationVal);
            const matchesType = (typeVal === "All" || item.type === typeVal);
            return matchesQuery && matchesStatus && matchesIndustry && matchesLocation && matchesType;
        });

        currentPage = 1;
        renderTable();
    }

    function renderTable() {
        if (!tableBody) return;

        const totalItems = filteredCompanies.length;
        const totalPages = Math.ceil(totalItems / pageSize) || 1;

        if (currentPage > totalPages) currentPage = totalPages;
        if (currentPage < 1) currentPage = 1;

        const startIndex = (currentPage - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, totalItems);
        const pageItems = filteredCompanies.slice(startIndex, endIndex);

        if (pageItems.length === 0) {
            tableBody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding:36px; color:#64748b;">No companies found matching your filters.</td></tr>`;
        } else {
            let html = "";
            pageItems.forEach(item => {
                const statusClass = item.status === "Active" ? "status-active" : (item.status === "Blocked" ? "status-blocked" : "status-pending");
                html += `
                    <tr>
                        <td>
                            <div class="cmp-user-cell">
                                <img src="${item.logo}" alt="${item.name}" class="cmp-avatar" onerror="this.src='https://ui-avatars.com/api/?name=${encodeURIComponent(item.name)}&background=e2e8f0&color=333'" />
                                <span class="cmp-user-name">${item.name}</span>
                            </div>
                        </td>
                        <td><span class="cmp-id-text">${item.id}</span></td>
                        <td>${item.email}</td>
                        <td>${item.industry}</td>
                        <td>${item.location}</td>
                        <td>${item.regDate}</td>
                        <td><span class="cmp-status-pill ${statusClass}">${item.status}</span></td>
                        <td style="text-align: right;">
                            <div class="cmp-action-menu-wrap">
                                <button type="button" class="cmp-btn-more" data-id="${item.id}" title="Actions"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                <div class="cmp-action-dropdown" id="cmp-dropdown-${item.id}">
                                    <button type="button" class="cmp-dropdown-item btn-act-view" data-id="${item.id}"><i class="fa-regular fa-eye"></i> View Company</button>
                                    <button type="button" class="cmp-dropdown-item btn-act-edit" data-id="${item.id}"><i class="fa-regular fa-pen-to-square"></i> Edit Company</button>
                                    ${item.status === 'Pending' ? `<button type="button" class="cmp-dropdown-item item-approve btn-act-approve" data-id="${item.id}"><i class="fa-solid fa-circle-check"></i> Approve Company</button>` : ''}
                                    <button type="button" class="cmp-dropdown-item btn-act-block" data-id="${item.id}"><i class="fa-solid fa-ban"></i> ${item.status === 'Blocked' ? 'Unblock Company' : 'Block Company'}</button>
                                    <button type="button" class="cmp-dropdown-item item-danger btn-act-delete" data-id="${item.id}"><i class="fa-regular fa-trash-can"></i> Delete Company</button>
                                </div>
                            </div>
                        </td>
                    </tr>
                `;
            });
            tableBody.innerHTML = html;
        }

        if (entriesInfo) {
            if (totalItems === 0) {
                entriesInfo.textContent = "Showing 0 to 0 of 0 companies";
            } else {
                entriesInfo.textContent = `Showing ${startIndex + 1}–${endIndex} of ${totalItems.toLocaleString()} companies`;
            }
        }

        renderPagination(totalPages);
        attachRowEvents();
    }

    function renderPagination(totalPages) {
        if (!paginationNav) return;

        let navHtml = "";
        const isPrevDisabled = currentPage === 1;
        navHtml += `<button type="button" class="page-btn page-nav-btn" ${isPrevDisabled ? "disabled style='opacity:0.4; cursor:not-allowed;'" : ""} id="btnCmpPrev" title="Previous"><i class="fa-solid fa-chevron-left"></i></button>`;

        function addBtn(p) {
            navHtml += `<button type="button" class="page-btn ${p === currentPage ? "active" : ""}" data-page="${p}">${p}</button>`;
        }
        function addDots() {
            navHtml += `<span class="page-ellipsis" style="color:#94a3b8; padding:0 4px;">...</span>`;
        }

        if (totalPages <= 7) {
            for (let i = 1; i <= totalPages; i++) addBtn(i);
        } else {
            if (currentPage <= 4) {
                for (let i = 1; i <= 5; i++) addBtn(i);
                addDots();
                addBtn(totalPages);
            } else if (currentPage >= totalPages - 3) {
                addBtn(1);
                addDots();
                for (let i = totalPages - 4; i <= totalPages; i++) addBtn(i);
            } else {
                addBtn(1);
                addDots();
                addBtn(currentPage - 1);
                addBtn(currentPage);
                addBtn(currentPage + 1);
                addDots();
                addBtn(totalPages);
            }
        }

        const isNextDisabled = currentPage === totalPages || totalPages === 0;
        navHtml += `<button type="button" class="page-btn page-nav-btn" ${isNextDisabled ? "disabled style='opacity:0.4; cursor:not-allowed;'" : ""} id="btnCmpNext" title="Next"><i class="fa-solid fa-chevron-right"></i></button>`;

        paginationNav.innerHTML = navHtml;

        paginationNav.querySelectorAll(".page-btn[data-page]").forEach(btn => {
            btn.addEventListener("click", function () {
                const p = parseInt(this.getAttribute("data-page"), 10);
                if (p && p !== currentPage) {
                    currentPage = p;
                    renderTable();
                }
            });
        });

        const prevBtn = document.getElementById("btnCmpPrev");
        if (prevBtn && !isPrevDisabled) {
            prevBtn.addEventListener("click", function () {
                if (currentPage > 1) {
                    currentPage--;
                    renderTable();
                }
            });
        }

        const nextBtn = document.getElementById("btnCmpNext");
        if (nextBtn && !isNextDisabled) {
            nextBtn.addEventListener("click", function () {
                if (currentPage < totalPages) {
                    currentPage++;
                    renderTable();
                }
            });
        }
    }

    function attachRowEvents() {
        tableBody.querySelectorAll(".cmp-btn-more").forEach(btn => {
            btn.addEventListener("click", function (e) {
                e.stopPropagation();
                const id = this.getAttribute("data-id");
                const currentDropdown = document.getElementById(`cmp-dropdown-${id}`);
                document.querySelectorAll(".cmp-action-dropdown").forEach(d => {
                    if (d !== currentDropdown) d.classList.remove("active");
                });
                if (currentDropdown) currentDropdown.classList.toggle("active");
            });
        });

        tableBody.querySelectorAll(".btn-act-view").forEach(btn => {
            btn.addEventListener("click", function () {
                const id = this.getAttribute("data-id");
                const found = companies.find(c => c.id === id);
                if (found) openDrawer(found);
            });
        });

        tableBody.querySelectorAll(".btn-act-edit").forEach(btn => {
            btn.addEventListener("click", function () {
                const id = this.getAttribute("data-id");
                const found = companies.find(c => c.id === id);
                if (found) openEditModal(found);
            });
        });

        tableBody.querySelectorAll(".btn-act-approve").forEach(btn => {
            btn.addEventListener("click", function () {
                const id = this.getAttribute("data-id");
                const found = companies.find(c => c.id === id);
                if (found) {
                    found.status = "Active";
                    showToast(`Company ${found.name} approved successfully!`);
                    applyFilters();
                }
            });
        });

        tableBody.querySelectorAll(".btn-act-block").forEach(btn => {
            btn.addEventListener("click", function () {
                const id = this.getAttribute("data-id");
                const found = companies.find(c => c.id === id);
                if (found) openBlockModal(found);
            });
        });

        tableBody.querySelectorAll(".btn-act-delete").forEach(btn => {
            btn.addEventListener("click", function () {
                const id = this.getAttribute("data-id");
                const found = companies.find(c => c.id === id);
                if (found) openDeleteModal(found);
            });
        });
    }

    document.addEventListener("click", function () {
        document.querySelectorAll(".cmp-action-dropdown").forEach(d => d.classList.remove("active"));
    });

    function openDrawer(cmp) {
        selectedCompany = cmp;
        if (drawerLogo) drawerLogo.src = cmp.logo;
        if (drawerName) drawerName.textContent = cmp.name;
        if (drawerId) drawerId.textContent = cmp.id;
        if (drawerStatusBadge) {
            drawerStatusBadge.textContent = cmp.status;
            drawerStatusBadge.className = `cmp-status-pill status-${cmp.status.toLowerCase()}`;
        }

        if (drawerBtnApprove) {
            drawerBtnApprove.style.display = (cmp.status === "Pending") ? "inline-flex" : "none";
        }

        const el = id => document.getElementById(id);
        if (el("dCmpName")) el("dCmpName").textContent = cmp.name;
        if (el("dCmpId")) el("dCmpId").textContent = cmp.id;
        if (el("dCmpEmail")) el("dCmpEmail").textContent = cmp.email;
        if (el("dCmpPhone")) el("dCmpPhone").textContent = cmp.phone;
        if (el("dCmpWebsite")) el("dCmpWebsite").innerHTML = `<a href="${cmp.website}" target="_blank" style="color:#2563eb; text-decoration:none;">${cmp.website.replace('https://', '')}</a>`;
        if (el("dCmpIndustry")) el("dCmpIndustry").textContent = cmp.industry;
        if (el("dCmpType")) el("dCmpType").textContent = cmp.type;
        if (el("dCmpFounded")) el("dCmpFounded").textContent = cmp.founded || "2018";
        if (el("dCmpRegDate")) el("dCmpRegDate").textContent = cmp.regDate;
        if (el("dCmpStatus")) el("dCmpStatus").textContent = cmp.status;

        if (el("dCmpFullAddress")) el("dCmpFullAddress").textContent = cmp.address || "Main Industrial Road";
        if (el("dCmpCity")) el("dCmpCity").textContent = cmp.city;
        if (el("dCmpState")) el("dCmpState").textContent = cmp.state;
        if (el("dCmpCountry")) el("dCmpCountry").textContent = cmp.country || "India";
        if (el("dCmpPincode")) el("dCmpPincode").textContent = cmp.pincode;

        if (el("dContactName")) el("dContactName").textContent = cmp.contactName || "HR Manager";
        if (el("dContactDesignation")) el("dContactDesignation").textContent = cmp.contactDesignation || "HR Lead";
        if (el("dContactEmail")) el("dContactEmail").textContent = cmp.contactEmail || cmp.email;
        if (el("dContactPhone")) el("dContactPhone").textContent = cmp.contactPhone || cmp.phone;

        if (drawerOverlay) {
            drawerOverlay.classList.add("active");
            document.body.style.overflow = "hidden";
        }
    }

    function closeDrawer() {
        if (drawerOverlay) {
            drawerOverlay.classList.remove("active");
            document.body.style.overflow = "";
        }
    }

    if (btnCloseDrawer) btnCloseDrawer.addEventListener("click", closeDrawer);
    if (drawerOverlay) {
        drawerOverlay.addEventListener("click", function (e) {
            if (e.target === drawerOverlay) closeDrawer();
        });
    }

    document.querySelectorAll(".drawer-tab-btn").forEach(btn => {
        btn.addEventListener("click", function () {
            document.querySelectorAll(".drawer-tab-btn").forEach(b => b.classList.remove("active"));
            document.querySelectorAll(".drawer-tab-pane").forEach(p => p.classList.remove("active"));
            this.classList.add("active");
            const tabId = this.getAttribute("data-tab");
            const pane = document.getElementById(`tab-${tabId}`);
            if (pane) pane.classList.add("active");
        });
    });

    if (drawerBtnEdit) {
        drawerBtnEdit.addEventListener("click", function () {
            closeDrawer();
            if (selectedCompany) openEditModal(selectedCompany);
        });
    }
    if (drawerBtnApprove) {
        drawerBtnApprove.addEventListener("click", function () {
            if (selectedCompany) {
                selectedCompany.status = "Active";
                showToast(`Company ${selectedCompany.name} approved successfully!`);
                closeDrawer();
                applyFilters();
            }
        });
    }
    if (drawerBtnBlock) {
        drawerBtnBlock.addEventListener("click", function () {
            closeDrawer();
            if (selectedCompany) openBlockModal(selectedCompany);
        });
    }
    if (drawerBtnDelete) {
        drawerBtnDelete.addEventListener("click", function () {
            closeDrawer();
            if (selectedCompany) openDeleteModal(selectedCompany);
        });
    }

    function closeModal(modal) {
        if (modal) {
            modal.classList.remove("active");
            document.body.style.overflow = "";
        }
    }

    function openModal(modal) {
        if (modal) {
            modal.classList.add("active");
            document.body.style.overflow = "hidden";
        }
    }

    document.querySelectorAll("[data-close]").forEach(btn => {
        btn.addEventListener("click", function () {
            const modalId = this.getAttribute("data-close");
            closeModal(document.getElementById(modalId));
        });
    });

    if (btnOpenAdd) {
        btnOpenAdd.addEventListener("click", function () {
            openModal(modalAdd);
        });
    }

    const btnSubmitAdd = document.getElementById("btnSubmitAddCompany");
    if (btnSubmitAdd) {
        btnSubmitAdd.addEventListener("click", function () {
            const name = document.getElementById("addCmpName").value.trim();
            const email = document.getElementById("addCmpEmail").value.trim();
            const phone = document.getElementById("addCmpPhone").value.trim();
            const cmpId = document.getElementById("addCmpId").value.trim() || `COM${companies.length + 1}`;
            const industry = document.getElementById("addCmpIndustry").value;
            const type = document.getElementById("addCmpType").value;
            const status = document.getElementById("addCmpStatus").value;
            const logo = document.getElementById("addCmpLogo").value.trim() || `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=2563eb&color=fff`;

            if (!name || !email) {
                alert("Please enter company name and email.");
                return;
            }

            const newCmp = {
                id: cmpId,
                name: name,
                email: email,
                phone: phone,
                website: document.getElementById("addCmpWebsite").value.trim() || `https://${name.toLowerCase().replace(/[^a-z0-9]/g, '')}.com`,
                industry: industry,
                location: document.getElementById("addCmpCity").value.trim() || "Ahmedabad",
                type: type,
                founded: document.getElementById("addCmpFounded").value.trim() || "2024",
                regDate: "21 Aug 2026",
                status: status,
                logo: logo,
                address: document.getElementById("addCmpAddress").value.trim(),
                city: document.getElementById("addCmpCity").value.trim() || "Ahmedabad",
                state: document.getElementById("addCmpState").value.trim() || "Gujarat",
                country: document.getElementById("addCmpCountry").value.trim() || "India",
                pincode: document.getElementById("addCmpPincode").value.trim() || "380001",
                contactName: document.getElementById("addContactName").value.trim() || "HR Manager",
                contactEmail: document.getElementById("addContactEmail").value.trim() || email,
                contactPhone: document.getElementById("addContactPhone").value.trim() || phone,
                contactDesignation: document.getElementById("addContactDesignation").value.trim() || "HR Manager"
            };

            companies.unshift(newCmp);
            closeModal(modalAdd);
            showToast(`Company ${name} added successfully!`);
            applyFilters();
        });
    }

    function openEditModal(cmp) {
        selectedCompany = cmp;
        document.getElementById("editCmpName").value = cmp.name;
        document.getElementById("editCmpEmail").value = cmp.email;
        document.getElementById("editCmpPhone").value = cmp.phone;
        document.getElementById("editCmpWebsite").value = cmp.website;
        document.getElementById("editCmpIndustry").value = cmp.industry;
        document.getElementById("editCmpType").value = cmp.type;
        document.getElementById("editCmpFounded").value = cmp.founded || "2018";
        document.getElementById("editCmpStatus").value = cmp.status;
        document.getElementById("editCmpAddress").value = cmp.address || "";
        document.getElementById("editCmpCity").value = cmp.city;
        document.getElementById("editCmpState").value = cmp.state;
        document.getElementById("editContactName").value = cmp.contactName || "";
        document.getElementById("editContactDesignation").value = cmp.contactDesignation || "";
        openModal(modalEdit);
    }

    const btnSaveEdit = document.getElementById("btnSaveEditCompany");
    if (btnSaveEdit) {
        btnSaveEdit.addEventListener("click", function () {
            if (!selectedCompany) return;
            selectedCompany.name = document.getElementById("editCmpName").value.trim();
            selectedCompany.email = document.getElementById("editCmpEmail").value.trim();
            selectedCompany.phone = document.getElementById("editCmpPhone").value.trim();
            selectedCompany.website = document.getElementById("editCmpWebsite").value.trim();
            selectedCompany.industry = document.getElementById("editCmpIndustry").value;
            selectedCompany.type = document.getElementById("editCmpType").value;
            selectedCompany.founded = document.getElementById("editCmpFounded").value.trim();
            selectedCompany.status = document.getElementById("editCmpStatus").value;
            selectedCompany.address = document.getElementById("editCmpAddress").value.trim();
            selectedCompany.city = document.getElementById("editCmpCity").value.trim();
            selectedCompany.state = document.getElementById("editCmpState").value.trim();
            selectedCompany.contactName = document.getElementById("editContactName").value.trim();
            selectedCompany.contactDesignation = document.getElementById("editContactDesignation").value.trim();

            closeModal(modalEdit);
            showToast(`Company ${selectedCompany.name} updated successfully!`);
            applyFilters();
        });
    }

    function openBlockModal(cmp) {
        selectedCompany = cmp;
        const nameEl = document.getElementById("blockCompanyName");
        const titleEl = document.getElementById("blockCmpModalTitle");
        const textEl = document.getElementById("blockCmpModalText");
        const btn = document.getElementById("btnConfirmBlockCompany");

        if (nameEl) nameEl.textContent = cmp.name;
        if (cmp.status === "Blocked") {
            if (titleEl) titleEl.textContent = "Unblock Company?";
            if (textEl) textEl.innerHTML = `Are you sure you want to unblock <strong>${cmp.name}</strong>? The company will regain access to the platform.`;
            if (btn) btn.textContent = "Unblock Company";
        } else {
            if (titleEl) titleEl.textContent = "Block Company?";
            if (textEl) textEl.innerHTML = `Are you sure you want to block <strong>${cmp.name}</strong>? The company will no longer be able to access the platform.`;
            if (btn) btn.textContent = "Block Company";
        }
        openModal(modalBlock);
    }

    const btnConfirmBlock = document.getElementById("btnConfirmBlockCompany");
    if (btnConfirmBlock) {
        btnConfirmBlock.addEventListener("click", function () {
            if (!selectedCompany) return;
            if (selectedCompany.status === "Blocked") {
                selectedCompany.status = "Active";
                showToast(`Company ${selectedCompany.name} unblocked successfully!`);
            } else {
                selectedCompany.status = "Blocked";
                showToast(`Company ${selectedCompany.name} has been blocked.`);
            }
            closeModal(modalBlock);
            applyFilters();
        });
    }

    function openDeleteModal(cmp) {
        selectedCompany = cmp;
        const nameEl = document.getElementById("deleteCompanyName");
        if (nameEl) nameEl.textContent = cmp.name;
        openModal(modalDelete);
    }

    const btnConfirmDelete = document.getElementById("btnConfirmDeleteCompany");
    if (btnConfirmDelete) {
        btnConfirmDelete.addEventListener("click", function () {
            if (!selectedCompany) return;
            companies = companies.filter(c => c.id !== selectedCompany.id);
            closeModal(modalDelete);
            showToast(`Company ${selectedCompany.name} deleted successfully!`);
            applyFilters();
        });
    }

    if (searchInput) searchInput.addEventListener("input", applyFilters);
    if (filterStatus) filterStatus.addEventListener("change", applyFilters);
    if (filterIndustry) filterIndustry.addEventListener("change", applyFilters);
    if (filterLocation) filterLocation.addEventListener("change", applyFilters);
    if (filterType) filterType.addEventListener("change", applyFilters);
    if (filterRegDate) filterRegDate.addEventListener("change", applyFilters);

    if (btnClear) {
        btnClear.addEventListener("click", function () {
            if (searchInput) searchInput.value = "";
            if (filterStatus) filterStatus.value = "All";
            if (filterIndustry) filterIndustry.value = "All";
            if (filterLocation) filterLocation.value = "All";
            if (filterType) filterType.value = "All";
            if (filterRegDate) filterRegDate.value = "All";
            if (pageSizeSelect) pageSizeSelect.value = "10";
            pageSize = 10;
            applyFilters();
            showToast("Company filters cleared.");
        });
    }

    if (pageSizeSelect) {
        pageSizeSelect.addEventListener("change", function () {
            pageSize = parseInt(this.value, 10) || 10;
            currentPage = 1;
            renderTable();
        });
    }

    const btnRefresh = document.getElementById("btnRefreshCompanies");
    if (btnRefresh) {
        btnRefresh.addEventListener("click", function () {
            const icon = this.querySelector("i");
            if (icon) icon.classList.add("fa-spin");
            setTimeout(() => {
                if (icon) icon.classList.remove("fa-spin");
                applyFilters();
                showToast("Company records refreshed.");
            }, 400);
        });
    }

    const btnExport = document.getElementById("btnExportCompanies");
    if (btnExport) {
        btnExport.addEventListener("click", function () {
            let csv = "Company ID,Name,Email,Industry,Location,Registered Date,Status\n";
            filteredCompanies.slice(0, 100).forEach(c => {
                csv += `"${c.id}","${c.name}","${c.email}","${c.industry}","${c.location}","${c.regDate}","${c.status}"\n`;
            });
            const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
            const url = URL.createObjectURL(blob);
            const a = document.createElement("a");
            a.href = url;
            a.download = `Companies_Export_${new Date().toISOString().slice(0, 10)}.csv`;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            showToast("Exported companies CSV successfully!");
        });
    }

    renderTable();
});

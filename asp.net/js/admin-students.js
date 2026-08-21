document.addEventListener("DOMContentLoaded", function () {
    let students = [
        {
            id: "STU001",
            name: "Dhruvi Patel",
            email: "dhruvi@gmail.com",
            phone: "9876543210",
            course: "BCA",
            regDate: "21 Aug 2026",
            status: "Active",
            avatar: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=80",
            dob: "2004-10-15",
            gender: "Female",
            college: "Gujarat University",
            batch: "2024-2027",
            address: "A-402, Shivalik Heights, S.G. Highway",
            city: "Ahmedabad",
            state: "Gujarat",
            pincode: "380054"
        },
        {
            id: "STU002",
            name: "Rahul Shah",
            email: "rahul@gmail.com",
            phone: "9876512345",
            course: "BCA",
            regDate: "20 Aug 2026",
            status: "Active",
            avatar: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80",
            dob: "2003-05-12",
            gender: "Male",
            college: "Nirma University",
            batch: "2023-2026",
            address: "12, Shanti Nagar, Ashram Road",
            city: "Ahmedabad",
            state: "Gujarat",
            pincode: "380009"
        },
        {
            id: "STU003",
            name: "Priya Patel",
            email: "priya@gmail.com",
            phone: "9876598765",
            course: "MCA",
            regDate: "19 Aug 2026",
            status: "Blocked",
            avatar: "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=100&auto=format&fit=crop&q=80",
            dob: "2002-11-20",
            gender: "Female",
            college: "Ahmedabad University",
            batch: "2024-2027",
            address: "B-21, Green Park, Satellite",
            city: "Ahmedabad",
            state: "Gujarat",
            pincode: "380015"
        },
        {
            id: "STU004",
            name: "Amit Shah",
            email: "amit@gmail.com",
            phone: "9876587654",
            course: "BCA",
            regDate: "18 Aug 2026",
            status: "Active",
            avatar: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&auto=format&fit=crop&q=80",
            dob: "2004-01-25",
            gender: "Male",
            college: "Gujarat University",
            batch: "2024-2027",
            address: "C-104, Royal Palace, Vastrapur",
            city: "Ahmedabad",
            state: "Gujarat",
            pincode: "380052"
        },
        {
            id: "STU005",
            name: "Neha Sharma",
            email: "neha.sharma@gmail.com",
            phone: "9876576543",
            course: "B.Tech",
            regDate: "18 Aug 2026",
            status: "Pending",
            avatar: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&auto=format&fit=crop&q=80",
            dob: "2003-08-14",
            gender: "Female",
            college: "DA-IICT",
            batch: "2023-2026",
            address: "44, Sector 7",
            city: "Gandhinagar",
            state: "Gujarat",
            pincode: "382007"
        },
        {
            id: "STU006",
            name: "Karan Mehta",
            email: "karan.mehta@gmail.com",
            phone: "9876565432",
            course: "B.Sc IT",
            regDate: "17 Aug 2026",
            status: "Active",
            avatar: "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&auto=format&fit=crop&q=80",
            dob: "2004-09-05",
            gender: "Male",
            college: "GLS University",
            batch: "2024-2027",
            address: "88, Navrangpura",
            city: "Ahmedabad",
            state: "Gujarat",
            pincode: "380009"
        },
        {
            id: "STU007",
            name: "Vivek Singh",
            email: "vivek.singh@gmail.com",
            phone: "9876554321",
            course: "MCA",
            regDate: "16 Aug 2026",
            status: "Blocked",
            avatar: "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=100&auto=format&fit=crop&q=80",
            dob: "2002-04-18",
            gender: "Male",
            college: "Indus University",
            batch: "2024-2027",
            address: "E-5, Sunrise Apartment, Bopal",
            city: "Ahmedabad",
            state: "Gujarat",
            pincode: "380058"
        },
        {
            id: "STU008",
            name: "Anjali Dave",
            email: "anjali.dave@gmail.com",
            phone: "9876543219",
            course: "M.Tech",
            regDate: "15 Aug 2026",
            status: "Active",
            avatar: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&auto=format&fit=crop&q=80",
            dob: "2001-12-30",
            gender: "Female",
            college: "Gujarat Technological University",
            batch: "2024-2027",
            address: "Chandkheda",
            city: "Ahmedabad",
            state: "Gujarat",
            pincode: "382424"
        },
        {
            id: "STU009",
            name: "Harsh Patel",
            email: "harsh.patel@gmail.com",
            phone: "9876532108",
            course: "BCA",
            regDate: "14 Aug 2026",
            status: "Active",
            avatar: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100&auto=format&fit=crop&q=80",
            dob: "2004-07-22",
            gender: "Male",
            college: "Gujarat University",
            batch: "2024-2027",
            address: "Maninagar",
            city: "Ahmedabad",
            state: "Gujarat",
            pincode: "380008"
        },
        {
            id: "STU010",
            name: "Sneha Desai",
            email: "sneha.desai@gmail.com",
            phone: "9876521097",
            course: "B.Tech",
            regDate: "13 Aug 2026",
            status: "Active",
            avatar: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=100&auto=format&fit=crop&q=80",
            dob: "2003-03-10",
            gender: "Female",
            college: "Nirma University",
            batch: "2023-2026",
            address: "Paldi",
            city: "Ahmedabad",
            state: "Gujarat",
            pincode: "380007"
        }
    ];

    const courses = ["BCA", "MCA", "B.Tech", "M.Tech", "B.Sc IT"];
    const batches = ["2024-2027", "2023-2026", "2022-2025"];
    const statuses = ["Active", "Active", "Active", "Blocked", "Pending"];
    const colleges = ["Gujarat University", "Nirma University", "Ahmedabad University", "DA-IICT", "GLS University"];
    const names = ["Rohan Gupta", "Pooja Varma", "Manish Trivedi", "Kinjal Rathod", "Jaydeep Parmar", "Bhavin Soni", "Riddhi Zala", "Nirav Patel", "Aayushi Pandya", "Chirag Barot"];

    for (let i = 11; i <= 1248; i++) {
        const name = names[i % names.length];
        const numStr = (i < 100 ? "0" : "") + (i < 10 ? "0" : "") + i;
        students.push({
            id: `STU${numStr}`,
            name: name,
            email: name.toLowerCase().replace(" ", ".") + (i > 10 ? i : "") + "@gmail.com",
            phone: `98765${10000 + (i % 90000)}`,
            course: courses[i % courses.length],
            regDate: `${Math.max(1, 21 - (i % 20))} Aug 2026`,
            status: statuses[i % statuses.length],
            avatar: `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=2563eb&color=fff`,
            dob: "2003-06-15",
            gender: (i % 2 === 0 ? "Female" : "Male"),
            college: colleges[i % colleges.length],
            batch: batches[i % batches.length],
            address: "S.G. Road",
            city: "Ahmedabad",
            state: "Gujarat",
            pincode: "380015"
        });
    }

    let currentPage = 1;
    let pageSize = 10;
    let filteredStudents = [...students];
    let selectedStudent = null;

    const searchInput = document.getElementById("stuSearchInput");
    const filterStatus = document.getElementById("filterStatus");
    const filterCourse = document.getElementById("filterCourse");
    const filterRegDate = document.getElementById("filterRegDate");
    const filterBatch = document.getElementById("filterBatch");
    const btnClear = document.getElementById("btnClearStuFilters");
    const tableBody = document.getElementById("studentTableBody");
    const pageSizeSelect = document.getElementById("stuPageSize");
    const entriesInfo = document.getElementById("stuEntriesInfo");
    const paginationNav = document.getElementById("stuPaginationNav");
    const toastEl = document.getElementById("stuToast");

    const drawerOverlay = document.getElementById("stuDrawerOverlay");
    const btnCloseDrawer = document.getElementById("btnCloseDrawer");
    const drawerAvatar = document.getElementById("drawerAvatar");
    const drawerName = document.getElementById("drawerName");
    const drawerId = document.getElementById("drawerId");
    const drawerStatusBadge = document.getElementById("drawerStatusBadge");
    const drawerBtnEdit = document.getElementById("drawerBtnEdit");
    const drawerBtnBlock = document.getElementById("drawerBtnBlock");
    const drawerBtnDelete = document.getElementById("drawerBtnDelete");

    const modalAdd = document.getElementById("modalAddStudent");
    const modalEdit = document.getElementById("modalEditStudent");
    const modalBlock = document.getElementById("modalBlockStudent");
    const modalDelete = document.getElementById("modalDeleteStudent");
    const btnOpenAdd = document.getElementById("btnOpenAddStudentModal");

    function showToast(msg) {
        if (!toastEl) return;
        toastEl.innerHTML = `<i class="fa-solid fa-circle-check" style="color:#10b981;"></i> ${msg}`;
        toastEl.style.display = "block";
        setTimeout(() => { toastEl.style.display = "none"; }, 3000);
    }

    function applyFilters() {
        const query = searchInput ? searchInput.value.toLowerCase().trim() : "";
        const statusVal = filterStatus ? filterStatus.value : "All";
        const courseVal = filterCourse ? filterCourse.value : "All";
        const batchVal = filterBatch ? filterBatch.value : "All";

        filteredStudents = students.filter(item => {
            const matchesQuery = !query || item.name.toLowerCase().includes(query) || item.email.toLowerCase().includes(query) || item.id.toLowerCase().includes(query);
            const matchesStatus = (statusVal === "All" || item.status === statusVal);
            const matchesCourse = (courseVal === "All" || item.course === courseVal);
            const matchesBatch = (batchVal === "All" || item.batch === batchVal);
            return matchesQuery && matchesStatus && matchesCourse && matchesBatch;
        });

        currentPage = 1;
        renderTable();
    }

    function renderTable() {
        if (!tableBody) return;

        const totalItems = filteredStudents.length;
        const totalPages = Math.ceil(totalItems / pageSize) || 1;

        if (currentPage > totalPages) currentPage = totalPages;
        if (currentPage < 1) currentPage = 1;

        const startIndex = (currentPage - 1) * pageSize;
        const endIndex = Math.min(startIndex + pageSize, totalItems);
        const pageItems = filteredStudents.slice(startIndex, endIndex);

        if (pageItems.length === 0) {
            tableBody.innerHTML = `<tr><td colspan="8" style="text-align:center; padding:36px; color:#64748b;">No students found matching your criteria.</td></tr>`;
        } else {
            let html = "";
            pageItems.forEach(item => {
                const statusClass = item.status === "Active" ? "status-active" : (item.status === "Blocked" ? "status-blocked" : "status-pending");
                html += `
                    <tr>
                        <td>
                            <div class="stu-user-cell">
                                <img src="${item.avatar}" alt="${item.name}" class="stu-avatar" onerror="this.src='https://ui-avatars.com/api/?name=${encodeURIComponent(item.name)}&background=e2e8f0&color=333'" />
                                <span class="stu-user-name">${item.name}</span>
                            </div>
                        </td>
                        <td><span class="stu-id-text">${item.id}</span></td>
                        <td>${item.email}</td>
                        <td>${item.phone}</td>
                        <td><strong>${item.course}</strong></td>
                        <td>${item.regDate}</td>
                        <td><span class="stu-status-pill ${statusClass}">${item.status}</span></td>
                        <td style="text-align: right;">
                            <div class="stu-action-menu-wrap">
                                <button type="button" class="stu-btn-more" data-id="${item.id}" title="Actions"><i class="fa-solid fa-ellipsis-vertical"></i></button>
                                <div class="stu-action-dropdown" id="dropdown-${item.id}">
                                    <button type="button" class="stu-dropdown-item btn-act-view" data-id="${item.id}"><i class="fa-regular fa-eye"></i> View Student</button>
                                    <button type="button" class="stu-dropdown-item btn-act-edit" data-id="${item.id}"><i class="fa-regular fa-pen-to-square"></i> Edit Student</button>
                                    <button type="button" class="stu-dropdown-item btn-act-block" data-id="${item.id}"><i class="fa-solid fa-ban"></i> ${item.status === 'Blocked' ? 'Unblock Student' : 'Block Student'}</button>
                                    <button type="button" class="stu-dropdown-item item-danger btn-act-delete" data-id="${item.id}"><i class="fa-regular fa-trash-can"></i> Delete Student</button>
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
                entriesInfo.textContent = "Showing 0 to 0 of 0 students";
            } else {
                entriesInfo.textContent = `Showing ${startIndex + 1}â€“${endIndex} of ${totalItems.toLocaleString()} students`;
            }
        }

        renderPagination(totalPages);
        attachRowEvents();
    }

    function renderPagination(totalPages) {
        if (!paginationNav) return;

        let navHtml = "";
        const isPrevDisabled = currentPage === 1;
        navHtml += `<button type="button" class="page-btn page-nav-btn" ${isPrevDisabled ? "disabled style='opacity:0.4; cursor:not-allowed;'" : ""} id="btnStuPrev" title="Previous"><i class="fa-solid fa-chevron-left"></i></button>`;

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
        navHtml += `<button type="button" class="page-btn page-nav-btn" ${isNextDisabled ? "disabled style='opacity:0.4; cursor:not-allowed;'" : ""} id="btnStuNext" title="Next"><i class="fa-solid fa-chevron-right"></i></button>`;

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

        const prevBtn = document.getElementById("btnStuPrev");
        if (prevBtn && !isPrevDisabled) {
            prevBtn.addEventListener("click", function () {
                if (currentPage > 1) {
                    currentPage--;
                    renderTable();
                }
            });
        }

        const nextBtn = document.getElementById("btnStuNext");
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
        tableBody.querySelectorAll(".stu-btn-more").forEach(btn => {
            btn.addEventListener("click", function (e) {
                e.stopPropagation();
                const id = this.getAttribute("data-id");
                const currentDropdown = document.getElementById(`dropdown-${id}`);
                document.querySelectorAll(".stu-action-dropdown").forEach(d => {
                    if (d !== currentDropdown) d.classList.remove("active");
                });
                if (currentDropdown) currentDropdown.classList.toggle("active");
            });
        });

        tableBody.querySelectorAll(".btn-act-view").forEach(btn => {
            btn.addEventListener("click", function () {
                const id = this.getAttribute("data-id");
                const found = students.find(s => s.id === id);
                if (found) openDrawer(found);
            });
        });

        tableBody.querySelectorAll(".btn-act-edit").forEach(btn => {
            btn.addEventListener("click", function () {
                const id = this.getAttribute("data-id");
                const found = students.find(s => s.id === id);
                if (found) openEditModal(found);
            });
        });

        tableBody.querySelectorAll(".btn-act-block").forEach(btn => {
            btn.addEventListener("click", function () {
                const id = this.getAttribute("data-id");
                const found = students.find(s => s.id === id);
                if (found) openBlockModal(found);
            });
        });

        tableBody.querySelectorAll(".btn-act-delete").forEach(btn => {
            btn.addEventListener("click", function () {
                const id = this.getAttribute("data-id");
                const found = students.find(s => s.id === id);
                if (found) openDeleteModal(found);
            });
        });
    }

    document.addEventListener("click", function () {
        document.querySelectorAll(".stu-action-dropdown").forEach(d => d.classList.remove("active"));
    });

    function openDrawer(stu) {
        selectedStudent = stu;
        if (drawerAvatar) drawerAvatar.src = stu.avatar;
        if (drawerName) drawerName.textContent = stu.name;
        if (drawerId) drawerId.textContent = stu.id;
        if (drawerStatusBadge) {
            drawerStatusBadge.textContent = stu.status;
            drawerStatusBadge.className = `stu-status-pill status-${stu.status.toLowerCase()}`;
        }

        const el = id => document.getElementById(id);
        if (el("dOverviewName")) el("dOverviewName").textContent = stu.name;
        if (el("dOverviewId")) el("dOverviewId").textContent = stu.id;
        if (el("dOverviewEmail")) el("dOverviewEmail").textContent = stu.email;
        if (el("dOverviewPhone")) el("dOverviewPhone").textContent = stu.phone;
        if (el("dOverviewCourse")) el("dOverviewCourse").textContent = stu.course;
        if (el("dOverviewCollege")) el("dOverviewCollege").textContent = stu.college;
        if (el("dOverviewEnrollDate")) el("dOverviewEnrollDate").textContent = stu.regDate;
        if (el("dOverviewStatus")) el("dOverviewStatus").textContent = stu.status;

        if (el("dPersonalDob")) el("dPersonalDob").textContent = stu.dob || "15 Oct 2004";
        if (el("dPersonalGender")) el("dPersonalGender").textContent = stu.gender || "Female";
        if (el("dPersonalAddress")) el("dPersonalAddress").textContent = `${stu.address}, ${stu.city}, ${stu.state} - ${stu.pincode}`;

        if (el("dAcademicCourse")) el("dAcademicCourse").textContent = stu.course;
        if (el("dAcademicBatch")) el("dAcademicBatch").textContent = stu.batch;
        if (el("dAcademicCollege")) el("dAcademicCollege").textContent = stu.college;

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
            if (selectedStudent) openEditModal(selectedStudent);
        });
    }
    if (drawerBtnBlock) {
        drawerBtnBlock.addEventListener("click", function () {
            closeDrawer();
            if (selectedStudent) openBlockModal(selectedStudent);
        });
    }
    if (drawerBtnDelete) {
        drawerBtnDelete.addEventListener("click", function () {
            closeDrawer();
            if (selectedStudent) openDeleteModal(selectedStudent);
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

    const btnSubmitAdd = document.getElementById("btnSubmitAddStudent");
    if (btnSubmitAdd) {
        btnSubmitAdd.addEventListener("click", function () {
            const name = document.getElementById("addFullName").value.trim();
            const email = document.getElementById("addEmail").value.trim();
            const phone = document.getElementById("addPhone").value.trim();
            const studentId = document.getElementById("addStudentId").value.trim() || `STU${students.length + 1}`;
            const course = document.getElementById("addCourse").value;
            const batch = document.getElementById("addBatch").value;
            const status = document.getElementById("addStatus").value;
            const photo = document.getElementById("addPhoto").value.trim() || `https://ui-avatars.com/api/?name=${encodeURIComponent(name)}&background=2563eb&color=fff`;

            if (!name || !email) {
                alert("Please enter full name and email.");
                return;
            }

            const newStudent = {
                id: studentId,
                name: name,
                email: email,
                phone: phone,
                course: course,
                regDate: "21 Aug 2026",
                status: status,
                avatar: photo,
                dob: document.getElementById("addDob").value || "2004-01-01",
                gender: document.getElementById("addGender").value,
                college: document.getElementById("addCollege").value.trim() || "Gujarat University",
                batch: batch,
                address: document.getElementById("addAddress").value.trim(),
                city: document.getElementById("addCity").value.trim() || "Ahmedabad",
                state: document.getElementById("addState").value.trim() || "Gujarat",
                pincode: document.getElementById("addPincode").value.trim() || "380001"
            };

            students.unshift(newStudent);
            closeModal(modalAdd);
            showToast(`Student ${name} added successfully!`);
            applyFilters();
        });
    }

    function openEditModal(stu) {
        selectedStudent = stu;
        document.getElementById("editFullName").value = stu.name;
        document.getElementById("editEmail").value = stu.email;
        document.getElementById("editPhone").value = stu.phone;
        document.getElementById("editDob").value = stu.dob || "2004-10-15";
        document.getElementById("editGender").value = stu.gender || "Female";
        document.getElementById("editCourse").value = stu.course;
        document.getElementById("editCollege").value = stu.college || "Gujarat University";
        document.getElementById("editBatch").value = stu.batch || "2024-2027";
        document.getElementById("editAddress").value = stu.address || "";
        document.getElementById("editCity").value = stu.city || "Ahmedabad";
        document.getElementById("editState").value = stu.state || "Gujarat";
        document.getElementById("editPincode").value = stu.pincode || "380001";
        document.getElementById("editStatus").value = stu.status;
        openModal(modalEdit);
    }

    const btnSaveEdit = document.getElementById("btnSaveEditStudent");
    if (btnSaveEdit) {
        btnSaveEdit.addEventListener("click", function () {
            if (!selectedStudent) return;
            selectedStudent.name = document.getElementById("editFullName").value.trim();
            selectedStudent.email = document.getElementById("editEmail").value.trim();
            selectedStudent.phone = document.getElementById("editPhone").value.trim();
            selectedStudent.dob = document.getElementById("editDob").value;
            selectedStudent.gender = document.getElementById("editGender").value;
            selectedStudent.course = document.getElementById("editCourse").value;
            selectedStudent.college = document.getElementById("editCollege").value.trim();
            selectedStudent.batch = document.getElementById("editBatch").value;
            selectedStudent.address = document.getElementById("editAddress").value.trim();
            selectedStudent.city = document.getElementById("editCity").value.trim();
            selectedStudent.state = document.getElementById("editState").value.trim();
            selectedStudent.pincode = document.getElementById("editPincode").value.trim();
            selectedStudent.status = document.getElementById("editStatus").value;

            closeModal(modalEdit);
            showToast(`Student ${selectedStudent.name} updated successfully!`);
            applyFilters();
        });
    }

    function openBlockModal(stu) {
        selectedStudent = stu;
        const nameEl = document.getElementById("blockStudentName");
        const titleEl = document.getElementById("blockModalTitle");
        const textEl = document.getElementById("blockModalText");
        const btn = document.getElementById("btnConfirmBlockStudent");

        if (nameEl) nameEl.textContent = stu.name;
        if (stu.status === "Blocked") {
            if (titleEl) titleEl.textContent = "Unblock Student?";
            if (textEl) textEl.innerHTML = `Are you sure you want to unblock <strong>${stu.name}</strong>? The student will regain access to their account.`;
            if (btn) btn.textContent = "Unblock Student";
        } else {
            if (titleEl) titleEl.textContent = "Block Student?";
            if (textEl) textEl.innerHTML = `Are you sure you want to block <strong>${stu.name}</strong>? The student will no longer be able to access their account.`;
            if (btn) btn.textContent = "Block Student";
        }
        openModal(modalBlock);
    }

    const btnConfirmBlock = document.getElementById("btnConfirmBlockStudent");
    if (btnConfirmBlock) {
        btnConfirmBlock.addEventListener("click", function () {
            if (!selectedStudent) return;
            if (selectedStudent.status === "Blocked") {
                selectedStudent.status = "Active";
                showToast(`Student ${selectedStudent.name} unblocked successfully!`);
            } else {
                selectedStudent.status = "Blocked";
                showToast(`Student ${selectedStudent.name} has been blocked.`);
            }
            closeModal(modalBlock);
            applyFilters();
        });
    }

    function openDeleteModal(stu) {
        selectedStudent = stu;
        const nameEl = document.getElementById("deleteStudentName");
        if (nameEl) nameEl.textContent = stu.name;
        openModal(modalDelete);
    }

    const btnConfirmDelete = document.getElementById("btnConfirmDeleteStudent");
    if (btnConfirmDelete) {
        btnConfirmDelete.addEventListener("click", function () {
            if (!selectedStudent) return;
            students = students.filter(s => s.id !== selectedStudent.id);
            closeModal(modalDelete);
            showToast(`Student ${selectedStudent.name} deleted successfully!`);
            applyFilters();
        });
    }

    if (searchInput) searchInput.addEventListener("input", applyFilters);
    if (filterStatus) filterStatus.addEventListener("change", applyFilters);
    if (filterCourse) filterCourse.addEventListener("change", applyFilters);
    if (filterRegDate) filterRegDate.addEventListener("change", applyFilters);
    if (filterBatch) filterBatch.addEventListener("change", applyFilters);

    if (btnClear) {
        btnClear.addEventListener("click", function () {
            if (searchInput) searchInput.value = "";
            if (filterStatus) filterStatus.value = "All";
            if (filterCourse) filterCourse.value = "All";
            if (filterRegDate) filterRegDate.value = "All";
            if (filterBatch) filterBatch.value = "All";
            if (pageSizeSelect) pageSizeSelect.value = "10";
            pageSize = 10;
            applyFilters();
            showToast("Filters cleared.");
        });
    }

    if (pageSizeSelect) {
        pageSizeSelect.addEventListener("change", function () {
            pageSize = parseInt(this.value, 10) || 10;
            currentPage = 1;
            renderTable();
        });
    }

    const btnRefresh = document.getElementById("btnRefreshStudents");
    if (btnRefresh) {
        btnRefresh.addEventListener("click", function () {
            const icon = this.querySelector("i");
            if (icon) icon.classList.add("fa-spin");
            setTimeout(() => {
                if (icon) icon.classList.remove("fa-spin");
                applyFilters();
                showToast("Student records refreshed.");
            }, 400);
        });
    }

    const btnExport = document.getElementById("btnExportStudents");
    if (btnExport) {
        btnExport.addEventListener("click", function () {
            let csv = "Student ID,Name,Email,Phone,Course,Registration Date,Status\n";
            filteredStudents.slice(0, 100).forEach(s => {
                csv += `"${s.id}","${s.name}","${s.email}","${s.phone}","${s.course}","${s.regDate}","${s.status}"\n`;
            });
            const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
            const url = URL.createObjectURL(blob);
            const a = document.createElement("a");
            a.href = url;
            a.download = `Students_Export_${new Date().toISOString().slice(0, 10)}.csv`;
            document.body.appendChild(a);
            a.click();
            document.body.removeChild(a);
            showToast("Exported students CSV successfully!");
        });
    }

    renderTable();
});

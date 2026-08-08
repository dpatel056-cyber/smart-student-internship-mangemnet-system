document.addEventListener('DOMContentLoaded', () => {
    const tbody = document.getElementById('dynamicApplicationsBody');
    if (!tbody) return;

    let session = {};
    try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}
    const companyName = session.name || 'TechNova Pvt Ltd';

    // Filters & State
    let searchVal = '';
    let internshipFilter = '';
    let statusFilter = '';
    let sortBy = 'newest';
    let currentPage = 1;
    const itemsPerPage = 5;

    // Get input elements
    const searchInput = document.querySelector('.login-input-wrap input');
    const filterSelects = document.querySelectorAll('.companies-results-top select');
    const sortSelect = document.querySelector('.sort-by-wrap select');
    const paginationEl = document.querySelector('.pagination');

    // Populate internship dropdown dynamically
    const internshipSelect = filterSelects[0];
    if (internshipSelect) {
        internshipSelect.innerHTML = '<option value="">All Internships</option>';
        const allInternships = window.GlobalStore ? window.GlobalStore.getInternships() : [];
        const companyInternships = allInternships.filter(i => i.company === companyName);
        const uniqueTitles = [...new Set(companyInternships.map(i => i.title))];
        uniqueTitles.forEach(title => {
            internshipSelect.innerHTML += `<option value="${title}">${title}</option>`;
        });
    }

    // Set up status filter dropdown options
    const statusSelect = filterSelects[1];
    if (statusSelect) {
        statusSelect.innerHTML = `
            <option value="">All Statuses</option>
            <option value="Pending">Pending</option>
            <option value="Shortlisted">Shortlisted</option>
            <option value="Selected">Selected</option>
            <option value="Rejected">Rejected</option>
        `;
    }

    // Listeners
    if (searchInput) {
        searchInput.addEventListener('input', (e) => {
            searchVal = e.target.value.trim().toLowerCase();
            currentPage = 1;
            renderApplications();
        });
    }

    if (internshipSelect) {
        internshipSelect.addEventListener('change', (e) => {
            internshipFilter = e.target.value;
            currentPage = 1;
            renderApplications();
        });
    }

    if (statusSelect) {
        statusSelect.addEventListener('change', (e) => {
            statusFilter = e.target.value;
            currentPage = 1;
            renderApplications();
        });
    }

    if (sortSelect) {
        sortSelect.addEventListener('change', (e) => {
            sortBy = e.target.value;
            currentPage = 1;
            renderApplications();
        });
    }

    function renderApplications() {
        tbody.innerHTML = '';
        const allApps = window.GlobalStore ? window.GlobalStore.getApplications() : [];
        let companyApps = allApps.filter(a => a.company === companyName);

        // Apply search
        if (searchVal) {
            companyApps = companyApps.filter(a => 
                a.studentName.toLowerCase().includes(searchVal) || 
                (a.studentEnrollment || '').toLowerCase().includes(searchVal)
            );
        }

        // Apply filters
        if (internshipFilter) {
            companyApps = companyApps.filter(a => a.internshipTitle === internshipFilter);
        }
        if (statusFilter) {
            companyApps = companyApps.filter(a => a.status === statusFilter);
        }

        // Apply sorting
        if (sortBy === 'Newest First') {
            companyApps.sort((a, b) => new Date(b.appliedOn) - new Date(a.appliedOn));
        } else if (sortBy === 'Oldest First') {
            companyApps.sort((a, b) => new Date(a.appliedOn) - new Date(b.appliedOn));
        }

        // Pagination
        const totalItems = companyApps.length;
        const totalPages = Math.max(1, Math.ceil(totalItems / itemsPerPage));
        if (currentPage > totalPages) currentPage = totalPages;

        const startIdx = (currentPage - 1) * itemsPerPage;
        const paginatedApps = companyApps.slice(startIdx, startIdx + itemsPerPage);

        if (paginatedApps.length === 0) {
            tbody.innerHTML = '<tr><td colspan="7" style="text-align:center;">No applications found matching your criteria.</td></tr>';
            if (paginationEl) paginationEl.innerHTML = '';
            return;
        }

        paginatedApps.forEach(app => {
            const tr = document.createElement('tr');
            const statusClass = 
                app.status === 'Selected' ? 'co-badge' : 
                app.status === 'Shortlisted' ? 'co-badge co-badge-closed' : 
                app.status === 'Rejected' ? 'co-badge co-badge-closed' : 'co-badge';

            const statusStyle = 
                app.status === 'Selected' ? 'background:#dcfce7;color:#16a34a;' : 
                app.status === 'Shortlisted' ? 'background:#fef9c3;color:#ca8a04;' : 
                app.status === 'Rejected' ? 'background:#fee2e2;color:#dc2626;' : 'background:#f1f5f9;color:#64748b;';

            tr.innerHTML = `
                <td>
                    <div style="display:flex;align-items:center;gap:10px;">
                        <img src="https://ui-avatars.com/api/?name=${encodeURIComponent(app.studentName)}&background=2563eb&color=fff" style="width:36px;height:36px;border-radius:50%;object-fit:cover;">
                        <strong style="color:var(--text-dark);font-size:14px;">${app.studentName}</strong>
                    </div>
                </td>
                <td>${app.studentEnrollment || 'ENR-' + String(app.id).replace('APP-', '')}</td>
                <td>
                    <div style="font-size:13px;color:var(--text-dark);">${app.studentEmail}</div>
                    <div style="font-size:11px;color:var(--text-muted);">B.Tech Computer Science</div>
                </td>
                <td><strong>${app.internshipTitle}</strong></td>
                <td>${new Date(app.appliedOn).toLocaleDateString()}</td>
                <td><span class="${statusClass}" style="${statusStyle} padding:4px 8px; border-radius:4px; font-weight:600; font-size:12px;">${app.status}</span></td>
                <td style="text-align:right; white-space:nowrap;">
                    ${app.status === 'Pending' ? `
                        <button class="btn btn-ghost shortlist-btn" data-id="${app.id}" style="padding:6px;font-size:13px;color:#d97706;" title="Shortlist"><i class="fa-solid fa-star"></i> Shortlist</button>
                        <button class="btn btn-ghost reject-btn" data-id="${app.id}" style="padding:6px;font-size:13px;color:#dc2626;" title="Reject"><i class="fa-solid fa-xmark"></i> Reject</button>
                    ` : ''}
                    ${app.status === 'Shortlisted' ? `
                        <button class="btn btn-ghost select-btn" data-id="${app.id}" style="padding:6px;font-size:13px;color:#16a34a;" title="Select / Hire"><i class="fa-solid fa-circle-check"></i> Select</button>
                        <button class="btn btn-ghost reject-btn" data-id="${app.id}" style="padding:6px;font-size:13px;color:#dc2626;" title="Reject"><i class="fa-solid fa-xmark"></i> Reject</button>
                    ` : ''}
                    ${app.status === 'Selected' ? `
                        <span style="font-size:13px;color:#16a34a;font-weight:600;"><i class="fa-solid fa-check-double"></i> Selected & Hired</span>
                    ` : ''}
                    ${app.status === 'Rejected' ? `
                        <span style="font-size:13px;color:#dc2626;font-weight:600;"><i class="fa-solid fa-circle-xmark"></i> Application Rejected</span>
                    ` : ''}
                </td>
            `;
            tbody.appendChild(tr);
        });

        // Event actions
        tbody.querySelectorAll('.shortlist-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const id = e.currentTarget.getAttribute('data-id');
                window.GlobalStore.updateApplicationStatus(id, 'Shortlisted');
                if(window.simsShowToast) window.simsShowToast('Student application shortlisted!');
                renderApplications();
            });
        });

        tbody.querySelectorAll('.select-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const id = e.currentTarget.getAttribute('data-id');
                window.GlobalStore.updateApplicationStatus(id, 'Selected');
                if(window.simsShowToast) window.simsShowToast('Student selected & offer ready!');
                renderApplications();
            });
        });

        tbody.querySelectorAll('.reject-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const id = e.currentTarget.getAttribute('data-id');
                window.GlobalStore.updateApplicationStatus(id, 'Rejected');
                if(window.simsShowToast) window.simsShowToast('Application marked as rejected.', 'error');
                renderApplications();
            });
        });

        renderPagination(totalPages);
    }

    function renderPagination(totalPages) {
        if (!paginationEl) return;
        if (totalPages <= 1) {
            paginationEl.innerHTML = '';
            return;
        }

        let html = `<button class="page-btn" data-page="prev" ${currentPage === 1 ? 'disabled' : ''}><i class="fa-solid fa-chevron-left"></i></button>`;
        for (let i = 1; i <= totalPages; i++) {
            html += `<button class="page-btn ${i === currentPage ? 'active' : ''}" data-page="${i}">${i}</button>`;
        }
        html += `<button class="page-btn" data-page="next" ${currentPage === totalPages ? 'disabled' : ''}><i class="fa-solid fa-chevron-right"></i></button>`;
        paginationEl.innerHTML = html;

        paginationEl.querySelectorAll('.page-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                const action = btn.getAttribute('data-page');
                if (action === 'prev') {
                    if (currentPage > 1) currentPage--;
                } else if (action === 'next') {
                    if (currentPage < totalPages) currentPage++;
                } else {
                    currentPage = parseInt(action);
                }
                renderApplications();
            });
        });
    }

    renderApplications();

    window.addEventListener('storage', (e) => {
        if (e.key === 'SIMS_APPLICATIONS_DATA') {
            renderApplications();
        }
    });
});

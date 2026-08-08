document.addEventListener('DOMContentLoaded', () => {
    const tbody = document.getElementById('dynamic-table-body');
    if (!tbody) return;

    let session = {};
    try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}
    const path = window.location.pathname.split('/').pop();

    function render() {
        tbody.innerHTML = '';
        const allApps = window.GlobalStore ? window.GlobalStore.getApplications() : [];
        const allInternships = window.GlobalStore ? window.GlobalStore.getInternships() : [];
        const allCompanies = window.COMPANIES_DATA || [];

        // Admin: Companies
        if (path === 'admin-companies.html') {
            allCompanies.forEach(company => {
                tbody.innerHTML += `
                    <tr>
                        <td>
                            <div style="display:flex;align-items:center;gap:10px;">
                                <img src="${company.icon.url.replace('../', 'https://ui-avatars.com/api/?name=' + encodeURIComponent(company.name) + '&')}" style="width:36px;height:36px;border-radius:50%;">
                                <strong style="color:var(--text-dark);">${company.name}</strong>
                            </div>
                        </td>
                        <td>${company.tag}</td>
                        <td>${company.location}</td>
                        <td>${company.openings} Openings</td>
                        <td><span style="color:#16a34a;font-weight:600;">Verified</span></td>
                        <td style="text-align:right;">
                            <button class="btn btn-ghost" onclick="window.simsShowToast && window.simsShowToast('Action simulated!')"><i class="fa-solid fa-pen"></i></button>
                        </td>
                    </tr>
                `;
            });
            return;
        }

        // Admin: Internships
        if (path === 'admin-internships.html') {
            allInternships.forEach(internship => {
                tbody.innerHTML += `
                    <tr>
                        <td><strong>${internship.title}</strong></td>
                        <td>${internship.company}</td>
                        <td>${internship.location}</td>
                        <td>${internship.modeLabel}</td>
                        <td>${internship.stipendType === 'paid' ? '₹' + internship.stipend : 'Unpaid'}</td>
                        <td style="text-align:right;">
                            <button class="btn btn-ghost" onclick="window.simsShowToast && window.simsShowToast('Action simulated!')"><i class="fa-solid fa-pen"></i></button>
                        </td>
                    </tr>
                `;
            });
            return;
        }

        // Admin: Applications
        if (path === 'admin-student-applications.html') {
            allApps.forEach(app => {
                tbody.innerHTML += `
                    <tr>
                        <td><strong>${app.studentName}</strong></td>
                        <td>${app.internshipTitle}</td>
                        <td>${app.company}</td>
                        <td>${new Date(app.appliedOn).toLocaleDateString()}</td>
                        <td><span style="color:#2563eb;font-weight:600;">${app.status}</span></td>
                        <td style="text-align:right;">
                            <button class="btn btn-ghost" onclick="window.simsShowToast && window.simsShowToast('Action simulated!')"><i class="fa-solid fa-pen"></i></button>
                        </td>
                    </tr>
                `;
            });
            return;
        }

        // Admin: Students (Derived from applications)
        if (path === 'admin-students.html') {
            const uniqueStudents = [];
            allApps.forEach(app => {
                if (!uniqueStudents.find(s => s.email === app.studentEmail)) {
                    uniqueStudents.push({name: app.studentName, email: app.studentEmail, date: app.appliedOn});
                }
            });
            uniqueStudents.forEach(student => {
                tbody.innerHTML += `
                    <tr>
                        <td>
                            <div style="display:flex;align-items:center;gap:10px;">
                                <img src="https://ui-avatars.com/api/?name=${encodeURIComponent(student.name)}&background=2563eb&color=fff" style="width:36px;height:36px;border-radius:50%;">
                                <strong style="color:var(--text-dark);">${student.name}</strong>
                            </div>
                        </td>
                        <td>${student.email}</td>
                        <td>B.Tech Computer Science</td>
                        <td>${new Date(student.date).toLocaleDateString()}</td>
                        <td><span style="color:#16a34a;font-weight:600;">Active</span></td>
                        <td style="text-align:right;">
                            <button class="btn btn-ghost" onclick="window.simsShowToast && window.simsShowToast('Action simulated!')"><i class="fa-solid fa-pen"></i></button>
                        </td>
                    </tr>
                `;
            });
            return;
        }

        // Company: Manage Internships
        if (path === 'company-manage-internships.html') {
            const companyInternships = allInternships.filter(i => i.company === session.name);
            if (companyInternships.length === 0) tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;">No internships posted.</td></tr>';
            companyInternships.forEach(internship => {
                const statusLabel = internship.status || 'Active';
                tbody.innerHTML += `
                    <tr data-id="${internship.id}">
                        <td><strong>${internship.title}</strong></td>
                        <td>${internship.categoryLabel}</td>
                        <td>${internship.location}</td>
                        <td>${internship.modeLabel}</td>
                        <td><span class="co-badge ${statusLabel === 'Closed' ? 'co-badge-closed' : ''}">${statusLabel}</span></td>
                        <td style="text-align:right;">
                            <button class="btn btn-ghost" onclick="window.location.href='company-internship-details.html?id=${internship.id}'"><i class="fa-solid fa-eye"></i></button>
                            <button class="btn btn-ghost" onclick="window.location.href='company-edit-internship.html?id=${internship.id}'"><i class="fa-solid fa-pen"></i></button>
                            ${statusLabel === 'Closed' ? '' : `<button class="btn btn-ghost" onclick="closeInternship(this)"><i class="fa-solid fa-lock"></i></button>`}
                            <button class="btn btn-ghost" style="color:#dc2626;" onclick="deleteInternship(this)"><i class="fa-solid fa-trash"></i></button>
                        </td>
                    </tr>
                `;
            });
            return;
        }

        // Company: Shortlisted / Selected / Rejected
        if (path.startsWith('company-')) {
            let statusFilter = '';
            if (path.includes('shortlisted')) statusFilter = 'Shortlisted';
            if (path.includes('selected')) statusFilter = 'Selected';
            if (path.includes('rejected')) statusFilter = 'Rejected';

            if (statusFilter) {
                const filteredApps = allApps.filter(a => a.company === session.name && a.status === statusFilter);
                if (filteredApps.length === 0) tbody.innerHTML = '<tr><td colspan="5" style="text-align:center;">No applications in this category.</td></tr>';
                filteredApps.forEach(app => {
                    tbody.innerHTML += `
                        <tr>
                            <td>
                                <div style="display:flex;align-items:center;gap:10px;">
                                    <img src="https://ui-avatars.com/api/?name=${encodeURIComponent(app.studentName)}&background=2563eb&color=fff" style="width:36px;height:36px;border-radius:50%;">
                                    <strong style="color:var(--text-dark);">${app.studentName}</strong>
                                </div>
                            </td>
                            <td>${app.internshipTitle}</td>
                            <td>${new Date(app.appliedOn).toLocaleDateString()}</td>
                            <td><span style="color:${statusFilter==='Rejected'?'#dc2626':'#d97706'};font-weight:600;">${statusFilter}</span></td>
                            <td style="text-align:right;">
                                <button class="btn btn-ghost" onclick="window.simsShowToast && window.simsShowToast('Action simulated!')"><i class="fa-solid fa-pen"></i></button>
                            </td>
                        </tr>
                    `;
                });
            }
        }
    }

    render();

    window.addEventListener('storage', (e) => {
        if (['SIMS_APPLICATIONS_DATA', 'SIMS_INTERNSHIPS_DATA', 'SIMS_COMPANIES_DATA'].includes(e.key)) {
            render();
        }
    });
});

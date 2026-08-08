// Dynamic Reports Generator for SIMS Company Panel
document.addEventListener('DOMContentLoaded', () => {
    let session = {};
    try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}
    const companyName = session.name || 'TechNova Pvt Ltd';

    const reportForm = document.getElementById('reportForm');
    const typeSelect = document.querySelector('#reportForm select[required]');
    const internshipSelect = document.querySelectorAll('#reportForm select')[1];
    const genExcelBtn = document.getElementById('genExcelBtn');

    // Populate Internship Filter Select
    if (internshipSelect) {
        internshipSelect.innerHTML = '<option value="">All Internships</option>';
        const allInternships = window.GlobalStore ? window.GlobalStore.getInternships() : [];
        const companyInternships = allInternships.filter(i => i.company === companyName);
        const uniqueTitles = [...new Set(companyInternships.map(i => i.title))];
        uniqueTitles.forEach(title => {
            internshipSelect.innerHTML += `<option value="${title}">${title}</option>`;
        });
    }

    if (reportForm) {
        reportForm.addEventListener('submit', (e) => {
            e.preventDefault();
            generateReport('pdf');
        });
    }

    if (genExcelBtn) {
        genExcelBtn.addEventListener('click', () => {
            generateReport('excel');
        });
    }

    function generateReport(format) {
        const type = typeSelect ? typeSelect.value : '';
        const internship = internshipSelect ? internshipSelect.value : '';
        
        if (!type) {
            alert('Please select a report type.');
            return;
        }

        const allApps = window.GlobalStore ? window.GlobalStore.getApplications() : [];
        let data = allApps.filter(a => a.company === companyName);

        if (internship) {
            data = data.filter(a => a.internshipTitle === internship);
        }

        let headers = [];
        let title = '';
        let filename = '';

        if (type === 'Internship Performance Report') {
            title = 'Internship Performance & Application Load Report';
            filename = 'Internship_Performance_Report';
            headers = ['Internship Title', 'Total Applications', 'Shortlisted', 'Hired / Selected', 'Rejected'];
            
            // Group by internship title
            const grouped = {};
            data.forEach(a => {
                if (!grouped[a.internshipTitle]) {
                    grouped[a.internshipTitle] = { title: a.internshipTitle, total: 0, shortlisted: 0, hired: 0, rejected: 0 };
                }
                grouped[a.internshipTitle].total++;
                if (a.status === 'Shortlisted') grouped[a.internshipTitle].shortlisted++;
                if (a.status === 'Selected') grouped[a.internshipTitle].hired++;
                if (a.status === 'Rejected') grouped[a.internshipTitle].rejected++;
            });
            data = Object.values(grouped);
        } else if (type === 'Applications Summary') {
            title = 'Applications Summary List';
            filename = 'Applications_Summary_Report';
            headers = ['Student Name', 'Enrollment', 'Email', 'Internship Title', 'Applied On', 'Status'];
        } else if (type === 'Interview & Hiring Results') {
            title = 'Interview Schedules & Recruitment Funnel';
            filename = 'Interview_Recruitment_Report';
            headers = ['Student Name', 'Email', 'Internship Title', 'Interview Date', 'Interview Time', 'Mode', 'Status'];
            
            const allInterviews = window.GlobalStore ? window.GlobalStore.getInterviews() : [];
            let ivs = allInterviews.filter(i => i.company === companyName);
            if (internship) {
                ivs = ivs.filter(i => i.internshipTitle === internship);
            }
            data = ivs;
        } else if (type === 'Hired Students List') {
            title = 'Hired & Selected Interns Directory';
            filename = 'Hired_Interns_Report';
            headers = ['Student Name', 'Enrollment', 'Email', 'Internship Title', 'Hired Date'];
            data = data.filter(a => a.status === 'Selected');
        }

        if (format === 'excel') {
            exportToExcel(data, headers, filename, type);
        } else {
            exportToPDF(data, headers, title, type);
        }
    }

    function exportToExcel(data, headers, filename, type) {
        let csvContent = '\uFEFF';
        csvContent += headers.join(',') + '\r\n';

        data.forEach(item => {
            let row = [];
            if (type === 'Internship Performance Report') {
                row = [item.title, item.total, item.shortlisted, item.hired, item.rejected];
            } else if (type === 'Applications Summary') {
                row = [item.studentName, item.studentEnrollment, item.studentEmail, item.internshipTitle, new Date(item.appliedOn).toLocaleDateString(), item.status];
            } else if (type === 'Interview & Hiring Results') {
                row = [item.studentName, item.studentEmail, item.internshipTitle, new Date(item.date).toLocaleDateString(), item.time, item.mode, item.status];
            } else if (type === 'Hired Students List') {
                row = [item.studentName, item.studentEnrollment, item.studentEmail, item.internshipTitle, new Date(item.appliedOn).toLocaleDateString()];
            }

            const escapedRow = row.map(val => {
                const str = String(val || '').replace(/"/g, '""');
                return `"${str}"`;
            });
            csvContent += escapedRow.join(',') + '\r\n';
        });

        const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        if (link.download !== undefined) {
            link.setAttribute('href', URL.createObjectURL(blob));
            link.setAttribute('download', filename + '.csv');
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            if (window.simsShowToast) window.simsShowToast('Excel report downloaded successfully!', 'success');
        }
    }

    function exportToPDF(data, headers, title, type) {
        const printWindow = window.open('', '_blank');
        if (!printWindow) {
            alert('Popup blocker prevented opening the report. Please allow popups.');
            return;
        }

        let rowsHtml = '';
        data.forEach((item, idx) => {
            let cols = [];
            if (type === 'Internship Performance Report') {
                cols = [item.title, item.total, item.shortlisted, item.hired, item.rejected];
            } else if (type === 'Applications Summary') {
                cols = [item.studentName, item.studentEnrollment, item.studentEmail, item.internshipTitle, new Date(item.appliedOn).toLocaleDateString(), item.status];
            } else if (type === 'Interview & Hiring Results') {
                cols = [item.studentName, item.studentEmail, item.internshipTitle, new Date(item.date).toLocaleDateString(), item.time, item.mode, item.status];
            } else if (type === 'Hired Students List') {
                cols = [item.studentName, item.studentEnrollment, item.studentEmail, item.internshipTitle, new Date(item.appliedOn).toLocaleDateString()];
            }

            rowsHtml += `<tr><td>${idx + 1}</td>${cols.map(c => `<td>${c || '-'}</td>`).join('')}</tr>`;
        });

        const htmlContent = `
            <html>
            <head>
                <title>${title}</title>
                <style>
                    body { font-family: 'Poppins', sans-serif; color: #1e293b; padding: 24px; }
                    .header { text-align: center; margin-bottom: 30px; border-bottom: 2px solid #2563eb; padding-bottom: 15px; }
                    .header h1 { margin: 0; font-size: 24px; color: #2563eb; }
                    .header p { margin: 5px 0 0 0; font-size: 14px; color: #64748b; }
                    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                    th, td { border: 1px solid #e2e8f0; padding: 10px; text-align: left; font-size: 13px; }
                    th { background-color: #f8fafc; font-weight: 600; color: #1e293b; }
                    tr:nth-child(even) { background-color: #f8fafc; }
                    .footer { margin-top: 40px; font-size: 11px; text-align: center; color: #94a3b8; }
                    @media print {
                        .no-print { display: none; }
                    }
                    .print-btn { background-color: #2563eb; color: #fff; border: none; padding: 10px 20px; font-size: 14px; border-radius: 6px; cursor: pointer; font-weight: 600; margin-bottom: 20px; }
                </style>
            </head>
            <body>
                <div class="no-print" style="text-align: right;">
                    <button class="print-btn" onclick="window.print()">Print / Save as PDF</button>
                </div>
                <div class="header">
                    <h1>SIMS - Company Recruitment Portal</h1>
                    <h2>${title}</h2>
                    <p>Company: ${companyName}</p>
                    <p>Generated on: ${new Date().toLocaleString('en-IN')}</p>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            ${headers.map(h => `<th>${h}</th>`).join('')}
                        </tr>
                    </thead>
                    <tbody>
                        ${rowsHtml}
                    </tbody>
                </table>
                <div class="footer">
                    &copy; 2026 SIMS. This is a system-generated document.
                </div>
            </body>
            </html>
        `;

        printWindow.document.write(htmlContent);
        printWindow.document.close();
    }
});

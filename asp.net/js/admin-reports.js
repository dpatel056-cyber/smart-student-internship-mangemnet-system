// Dynamic Reports Generator for SIMS Admin Panel
document.addEventListener('DOMContentLoaded', () => {
    // Override the global genReport
    window.genReport = function(type, format) {
        if (!window.GlobalStore) {
            alert('GlobalStore not loaded.');
            return;
        }

        let data = [];
        let filename = '';
        let headers = [];
        let title = '';

        if (type === 'student') {
            data = window.GlobalStore.getStudents();
            headers = ['Name', 'Enrollment', 'Department', 'Semester', 'Email', 'Mobile', 'Status', 'Registration Date'];
            filename = 'SIMS_Students_Report';
            title = 'Student Registration Report';
        } else if (type === 'company') {
            data = window.GlobalStore.getCompanies();
            headers = ['Company Name', 'Industry', 'HR Contact', 'Email', 'Phone', 'Status', 'Joined Date'];
            filename = 'SIMS_Companies_Report';
            title = 'Company Verification & Industry Report';
        } else if (type === 'internship') {
            data = window.GlobalStore.getInternships();
            headers = ['Title', 'Company', 'Location', 'Mode', 'Stipend', 'Category', 'Status'];
            filename = 'SIMS_Internships_Report';
            title = 'Internship Positions Report';
        } else if (type === 'placement') {
            const apps = window.GlobalStore.getApplications();
            data = apps.filter(a => a.status === 'Selected' || a.status === 'Shortlisted');
            headers = ['Student Name', 'Enrollment', 'Internship Title', 'Company', 'Applied Date', 'Current Status'];
            filename = 'SIMS_Placement_Report';
            title = 'Placements & Selection Analytics Report';
        }

        if (format === 'excel') {
            exportToCSV(data, headers, filename, type);
        } else if (format === 'pdf') {
            exportToPDF(data, headers, title, type);
        }
    };

    function exportToCSV(data, headers, filename, type) {
        let csvContent = '\uFEFF'; // Add BOM for UTF-8 Excel support
        csvContent += headers.join(',') + '\r\n';

        data.forEach(item => {
            let row = [];
            if (type === 'student') {
                row = [
                    item.name,
                    item.enr,
                    item.dept,
                    item.sem,
                    item.email,
                    item.mobile,
                    item.status,
                    item.date
                ];
            } else if (type === 'company') {
                row = [
                    item.name,
                    item.ind,
                    item.hr,
                    item.email,
                    item.phone,
                    item.status,
                    item.date
                ];
            } else if (type === 'internship') {
                row = [
                    item.title,
                    item.company,
                    item.location,
                    item.modeLabel || item.modeKey,
                    item.stipendType === 'paid' ? 'Paid (' + item.stipend + ')' : 'Unpaid',
                    item.categoryLabel || item.categoryKey,
                    item.status || 'Active'
                ];
            } else if (type === 'placement') {
                row = [
                    item.studentName,
                    item.studentEnrollment,
                    item.internshipTitle,
                    item.company,
                    new Date(item.appliedOn).toLocaleDateString(),
                    item.status
                ];
            }

            // Escape quotes and wrap values in quotes
            const escapedRow = row.map(val => {
                const str = String(val || '').replace(/"/g, '""');
                return `"${str}"`;
            });
            csvContent += escapedRow.join(',') + '\r\n';
        });

        const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement('a');
        if (link.download !== undefined) {
            const url = URL.createObjectURL(blob);
            link.setAttribute('href', url);
            link.setAttribute('download', filename + '.csv');
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);

            // Show success popup
            const modal = document.getElementById('successModal');
            if (modal) modal.classList.add('open');
        }
    }

    function exportToPDF(data, headers, title, type) {
        const printWindow = window.open('', '_blank');
        if (!printWindow) {
            alert('Popup blocker prevented opening the report preview. Please allow popups.');
            return;
        }

        let rowsHtml = '';
        data.forEach((item, idx) => {
            let cols = [];
            if (type === 'student') {
                cols = [item.name, item.enr, item.dept, item.sem, item.email, item.mobile, item.status, item.date];
            } else if (type === 'company') {
                cols = [item.name, item.ind, item.hr, item.email, item.phone, item.status, item.date];
            } else if (type === 'internship') {
                cols = [item.title, item.company, item.location, item.modeLabel || item.modeKey, item.stipendType === 'paid' ? '₹' + item.stipend : 'Unpaid', item.categoryLabel || item.categoryKey, item.status || 'Active'];
            } else if (type === 'placement') {
                cols = [item.studentName, item.studentEnrollment, item.internshipTitle, item.company, new Date(item.appliedOn).toLocaleDateString(), item.status];
            }

            rowsHtml += `
                <tr>
                    <td>${idx + 1}</td>
                    ${cols.map(c => `<td>${c || '-'}</td>`).join('')}
                </tr>
            `;
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
                    <h1>SIMS - Smart Student Internship Management System</h1>
                    <h2>${title}</h2>
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

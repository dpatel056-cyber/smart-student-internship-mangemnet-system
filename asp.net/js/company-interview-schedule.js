document.addEventListener('DOMContentLoaded', () => {

    let session = {};
    try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}
    const companyName = session.name || 'TechNova Pvt Ltd';

    const tbody = document.getElementById('dynamicInterviewBody') || document.querySelector('tbody');
    const scheduleForm = document.getElementById('scheduleInterviewForm') || document.querySelector('form');

    function renderInterviews() {
        if (!tbody) return;
        tbody.innerHTML = '';
        const allInterviews = window.GlobalStore ? window.GlobalStore.getInterviews() : [];
        const myInterviews = allInterviews.filter(i => i.company === companyName);

        if (myInterviews.length === 0) {
            tbody.innerHTML = '<tr><td colspan="6" style="text-align:center;">No interviews scheduled yet.</td></tr>';
            return;
        }

        myInterviews.forEach(iv => {
            tbody.innerHTML += `
                <tr>
                    <td><strong>${iv.studentName}</strong></td>
                    <td>${iv.internshipTitle || 'Interview'}</td>
                    <td>${new Date(iv.date).toLocaleDateString()}</td>
                    <td>${iv.time || 'TBD'}</td>
                    <td>${iv.mode || 'Online'}</td>
                    <td><span style="color:#16a34a;font-weight:600;">${iv.status || 'Scheduled'}</span></td>
                </tr>
            `;
        });
    }

    // Schedule Interview Form
    if (scheduleForm) {
        scheduleForm.addEventListener('submit', (e) => {
            e.preventDefault();
            const apps = window.GlobalStore ? window.GlobalStore.getApplications().filter(a => a.company === companyName && a.status === 'Shortlisted') : [];
            
            const studentSelect = document.getElementById('interviewStudent') || document.getElementById('student');
            const dateInput = document.getElementById('interviewDate') || document.getElementById('date');
            const timeInput = document.getElementById('interviewTime') || document.getElementById('time');
            const modeInput = document.getElementById('interviewMode') || document.getElementById('mode');
            const linkInput = document.getElementById('interviewLink') || document.getElementById('link');

            const studentEmail = studentSelect ? studentSelect.value : '';
            const selectedApp = apps.find(a => a.studentEmail === studentEmail) || apps[0];

            if (!selectedApp) {
                if (window.simsShowToast) window.simsShowToast('No shortlisted student found.', 'error');
                return;
            }

            const interview = {
                studentName: selectedApp.studentName,
                studentEmail: selectedApp.studentEmail,
                company: companyName,
                internshipTitle: selectedApp.internshipTitle,
                date: dateInput ? dateInput.value : new Date().toISOString().split('T')[0],
                time: timeInput ? timeInput.value : '10:00 AM',
                mode: modeInput ? modeInput.value : 'Online',
                link: linkInput ? linkInput.value : '',
                interviewer: session.name || 'HR Team',
                status: 'scheduled'
            };

            if (window.GlobalStore) window.GlobalStore.addInterview(interview);
            if (window.simsShowToast) window.simsShowToast('Interview scheduled successfully!', 'success');
            scheduleForm.reset();
            renderInterviews();
        });
    }

    // Populate student dropdown with shortlisted students
    function populateStudentDropdown() {
        const studentSelect = document.getElementById('interviewStudent') || document.getElementById('student');
        if (!studentSelect) return;
        const apps = window.GlobalStore ? window.GlobalStore.getApplications().filter(a => a.company === companyName && a.status === 'Shortlisted') : [];
        studentSelect.innerHTML = '<option value="">Select Student</option>' + apps.map(a => `<option value="${a.studentEmail}">${a.studentName}</option>`).join('');
    }

    renderInterviews();
    populateStudentDropdown();

    window.addEventListener('storage', (e) => {
        if (['SIMS_INTERVIEWS_DATA', 'SIMS_APPLICATIONS_DATA'].includes(e.key)) {
            renderInterviews();
            populateStudentDropdown();
        }
    });
});

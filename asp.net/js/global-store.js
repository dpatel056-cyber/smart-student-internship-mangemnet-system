// Centralized Store for SIMS - Expanded
window.GlobalStore = {
    // --- APPLICATIONS ---
    getApplications: function() {
        if (!localStorage.getItem('SIMS_APPLICATIONS_DATA')) {
            this.ensureSeedStudentData();
        }
        return JSON.parse(localStorage.getItem('SIMS_APPLICATIONS_DATA')) || [];
    },
    saveApplications: function(apps) {
        localStorage.setItem('SIMS_APPLICATIONS_DATA', JSON.stringify(apps));
        window.dispatchEvent(new Event('storage'));
    },
    deleteApplication: function(id) {
        const apps = this.getApplications();
        const nextApps = apps.filter(app => String(app.id) !== String(id));
        this.saveApplications(nextApps);
        return nextApps;
    },
    addApplication: function(app) {
        const apps = this.getApplications();
        const session = (() => {
            try { return JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) { return {}; }
        })();
        const nextApp = {
            studentEnrollment: app.studentEnrollment || session.enrollment || '',
            ...app
        };
        apps.push(nextApp);
        this.saveApplications(apps);
        // Create Notification for Company
        this.addNotification({
            userId: nextApp.company, // Sending to company name as ID
            title: 'New Application',
            message: `${nextApp.studentName} applied for ${nextApp.internshipTitle}`,
            type: 'info',
            date: new Date().toISOString()
        });
    },
    updateApplicationStatus: function(id, newStatus) {
        const apps = this.getApplications();
        const idx = apps.findIndex(a => a.id === id);
        if (idx !== -1) {
            apps[idx].status = newStatus;
            this.saveApplications(apps);
            // Create Notification for Student
            this.addNotification({
                userId: apps[idx].studentEmail, // Sending to student email
                title: 'Application Update',
                message: `Your application for ${apps[idx].internshipTitle} was marked as ${newStatus}`,
                type: newStatus === 'Rejected' ? 'error' : 'success',
                date: new Date().toISOString()
            });
        }
    },

    // --- INTERNSHIPS ---
    getInternships: function() {
        const stored = localStorage.getItem('SIMS_INTERNSHIPS_DATA');
        if (stored) {
            window.INTERNSHIPS_DATA = JSON.parse(stored);
            return window.INTERNSHIPS_DATA;
        }
        if (window.INTERNSHIPS_DATA && window.INTERNSHIPS_DATA.length) return window.INTERNSHIPS_DATA;
        const seeded = window.DEFAULT_INTERNSHIPS_DATA || [];
        window.INTERNSHIPS_DATA = seeded;
        localStorage.setItem('SIMS_INTERNSHIPS_DATA', JSON.stringify(seeded));
        return seeded;
    },
    saveInternships: function(internships) {
        window.INTERNSHIPS_DATA = internships;
        localStorage.setItem('SIMS_INTERNSHIPS_DATA', JSON.stringify(internships));
        window.dispatchEvent(new Event('storage'));
    },
    addInternship: function(internship) {
        const internships = this.getInternships();
        internship.id = internships.length > 0 ? Math.max(...internships.map(i => i.id)) + 1 : 1;
        internships.unshift(internship);
        this.saveInternships(internships);
        return internship;
    },
    updateInternship: function(id, updates) {
        const internships = this.getInternships();
        const idx = internships.findIndex(item => String(item.id) === String(id));
        if (idx === -1) return null;
        internships[idx] = { ...internships[idx], ...updates };
        this.saveInternships(internships);
        return internships[idx];
    },
    deleteInternship: function(id) {
        const internships = this.getInternships();
        const nextInternships = internships.filter(item => String(item.id) !== String(id));
        this.saveInternships(nextInternships);
        return nextInternships;
    },

    // --- STUDENTS (Admin) ---
    getStudents: function() {
        const stored = localStorage.getItem('SIMS_STUDENTS_DATA');
        if (stored) return JSON.parse(stored);
        const seeded = [
            { id: 1, photo: 'https://ui-avatars.com/api/?name=Rahul+Sharma&background=2563eb&color=fff', name: 'Rahul Sharma', enr: 'ENR2024001', dept: 'Computer Science', sem: '6th', email: 'rahul@example.com', mobile: '9876543210', date: '01 Jan 2024', status: 'Active' },
            { id: 2, photo: 'https://ui-avatars.com/api/?name=Kavya+Shah&background=ea580c&color=fff', name: 'Kavya Shah', enr: 'ENR2024002', dept: 'Information Technology', sem: '4th', email: 'kavya@example.com', mobile: '9876543211', date: '03 Jan 2024', status: 'Pending' },
            { id: 3, photo: 'https://ui-avatars.com/api/?name=Anjali+Desai&background=db2777&color=fff', name: 'Anjali Desai', enr: 'ENR2024003', dept: 'Design', sem: '6th', email: 'anjali@example.com', mobile: '9876543212', date: '05 Jan 2024', status: 'Active' },
            { id: 4, photo: 'https://ui-avatars.com/api/?name=Sneha+Joshi&background=16a34a&color=fff', name: 'Sneha Joshi', enr: 'ENR2024004', dept: 'Mechanical Engineering', sem: '2nd', email: 'sneha@example.com', mobile: '9876543213', date: '07 Jan 2024', status: 'Pending' },
            { id: 5, photo: 'https://ui-avatars.com/api/?name=Arjun+Mehta&background=7c3aed&color=fff', name: 'Arjun Mehta', enr: 'ENR2024005', dept: 'Computer Science', sem: '8th', email: 'arjun@example.com', mobile: '9876543214', date: '10 Jan 2024', status: 'Active' }
        ];
        localStorage.setItem('SIMS_STUDENTS_DATA', JSON.stringify(seeded));
        return seeded;
    },
    saveStudents: function(students) {
        localStorage.setItem('SIMS_STUDENTS_DATA', JSON.stringify(students));
        window.dispatchEvent(new Event('storage'));
    },
    addStudent: function(student) {
        const students = this.getStudents();
        const nextId = students.length > 0 ? Math.max(...students.map(item => Number(item.id) || 0)) + 1 : 1;
        const newStudent = { id: nextId, ...student, status: student.status || 'Pending', date: student.date || new Date().toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' }) };
        students.unshift(newStudent);
        this.saveStudents(students);
        return newStudent;
    },
    updateStudent: function(id, updates) {
        const students = this.getStudents();
        const idx = students.findIndex(item => String(item.id) === String(id));
        if (idx === -1) return null;
        students[idx] = { ...students[idx], ...updates };
        this.saveStudents(students);
        return students[idx];
    },
    deleteStudent: function(id) {
        const students = this.getStudents();
        const nextStudents = students.filter(item => String(item.id) !== String(id));
        this.saveStudents(nextStudents);
        return nextStudents;
    },

    // --- COMPANIES (Admin) ---
    getCompanies: function() {
        const stored = localStorage.getItem('SIMS_COMPANIES_DATA');
        if (stored) {
            window.COMPANIES_DATA = JSON.parse(stored);
            return window.COMPANIES_DATA;
        }
        const seeded = [
            { id: 1, logo: 'https://ui-avatars.com/api/?name=TechNova&background=2563eb&color=fff', name: 'TechNova Pvt Ltd', ind: 'Information Technology', hr: 'Amit Patel', email: 'hr@technova.com', phone: '9876543210', date: '01 Jan 2024', status: 'Active' },
            { id: 2, logo: 'https://ui-avatars.com/api/?name=DesignStudio&background=ea580c&color=fff', name: 'DesignStudio Co.', ind: 'Design', hr: 'Priya Shah', email: 'contact@designstudio.com', phone: '9876543211', date: '05 Jan 2024', status: 'Pending' },
            { id: 3, logo: 'https://ui-avatars.com/api/?name=DataMind&background=16a34a&color=fff', name: 'DataMind Analytics', ind: 'Data Science', hr: 'Rohan Joshi', email: 'careers@datamind.in', phone: '9876543212', date: '10 Jan 2024', status: 'Active' },
            { id: 4, logo: 'https://ui-avatars.com/api/?name=InnoSoft&background=7c3aed&color=fff', name: 'InnoSoft Solutions', ind: 'Information Technology', hr: 'Kavya Desai', email: 'hello@innosoft.com', phone: '9876543213', date: '12 Jan 2024', status: 'Active' },
            { id: 5, logo: 'https://ui-avatars.com/api/?name=FinTech&background=ef4444&color=fff', name: 'FinTech Global', ind: 'Finance', hr: 'Suresh Mehta', email: 'hr@fintech.com', phone: '9876543214', date: '15 Jan 2024', status: 'Blocked' }
        ];
        localStorage.setItem('SIMS_COMPANIES_DATA', JSON.stringify(seeded));
        window.COMPANIES_DATA = seeded;
        return seeded;
    },
    saveCompanies: function(companies) {
        localStorage.setItem('SIMS_COMPANIES_DATA', JSON.stringify(companies));
        window.COMPANIES_DATA = companies;
        window.dispatchEvent(new Event('storage'));
    },
    addCompany: function(company) {
        const companies = this.getCompanies();
        const nextId = companies.length > 0 ? Math.max(...companies.map(item => Number(item.id) || 0)) + 1 : 1;
        const newCompany = { id: nextId, ...company, status: company.status || 'Pending', date: company.date || new Date().toLocaleDateString('en-IN', { day: 'numeric', month: 'short', year: 'numeric' }) };
        companies.unshift(newCompany);
        this.saveCompanies(companies);
        return newCompany;
    },
    updateCompany: function(id, updates) {
        const companies = this.getCompanies();
        const idx = companies.findIndex(item => String(item.id) === String(id));
        if (idx === -1) return null;
        companies[idx] = { ...companies[idx], ...updates };
        this.saveCompanies(companies);
        return companies[idx];
    },
    deleteCompany: function(id) {
        const companies = this.getCompanies();
        const nextCompanies = companies.filter(item => String(item.id) !== String(id));
        this.saveCompanies(nextCompanies);
        return nextCompanies;
    },

    // --- USERS ---
    getUsers: function() {
        const users = JSON.parse(localStorage.getItem('SIMS_USERS_DATA'));
        if (users) return users;
        // Default admin and demo users
        const defaultUsers = [
            { email: 'admin@sims.com', password: 'admin123', role: 'admin', name: 'Admin User' },
            { email: 'student@sims.com', password: 'student123', role: 'student', name: 'Student', enrollment: 'ENR2024001', profile: {} },
            { email: 'company@sims.com', password: 'company123', role: 'company', name: 'TechNova Pvt Ltd', profile: {} }
        ];
        localStorage.setItem('SIMS_USERS_DATA', JSON.stringify(defaultUsers));
        return defaultUsers;
    },
    saveUsers: function(users) {
        localStorage.setItem('SIMS_USERS_DATA', JSON.stringify(users));
    },
    addUser: function(user) {
        const users = this.getUsers();
        users.push(user);
        this.saveUsers(users);
    },
    updateUser: function(email, updates) {
        const users = this.getUsers();
        const idx = users.findIndex(u => u.email === email);
        if (idx !== -1) {
            users[idx] = { ...users[idx], ...updates };
            this.saveUsers(users);
            
            // If updating current session user, update session too
            let session = {};
            try { session = JSON.parse(localStorage.getItem('simsSession')); } catch(e){}
            if(session && session.email === email) {
                session.name = users[idx].name;
                localStorage.setItem('simsSession', JSON.stringify(session));
                window.dispatchEvent(new Event('storage'));
            }
        }
    },

    // Update every student-owned record after a student edits their profile.
    // This keeps application, interview and communication screens consistent.
    syncStudentProfile: function(previousEmail, profile) {
        if (!previousEmail || !profile) return;
        const nextEmail = profile.email || previousEmail;
        const nextName = profile.fullName || profile.name || '';
        const updateList = (key, mapper) => {
            let list;
            const raw = localStorage.getItem(key);
            if (!raw) return;
            try { list = JSON.parse(raw) || []; } catch (e) { return; }
            const next = list.map(mapper);
            localStorage.setItem(key, JSON.stringify(next));
        };

        updateList('SIMS_APPLICATIONS_DATA', item => item.studentEmail === previousEmail
            ? { ...item, studentEmail: nextEmail, studentName: nextName, studentEnrollment: profile.enrollment || item.studentEnrollment }
            : item);
        updateList('SIMS_INTERVIEWS_DATA', item => item.studentEmail === previousEmail
            ? { ...item, studentEmail: nextEmail, studentName: nextName }
            : item);
        updateList('SIMS_NOTIFS_DATA', item => item.userId === previousEmail ? { ...item, userId: nextEmail } : item);
        updateList('SIMS_MESSAGES_DATA', item => ({
            ...item,
            from: item.from === previousEmail ? nextEmail : item.from,
            to: item.to === previousEmail ? nextEmail : item.to
        }));
        updateList('SIMS_OFFERS_DATA', item => item.studentEmail === previousEmail
            ? { ...item, studentEmail: nextEmail, studentName: nextName }
            : item);
        updateList('SIMS_FEEDBACK_DATA', item => item.studentEmail === previousEmail ? { ...item, studentEmail: nextEmail } : item);
        updateList('SIMS_SUPPORT_TICKETS_DATA', item => item.studentEmail === previousEmail
            ? { ...item, studentEmail: nextEmail, studentName: nextName }
            : item);
        window.dispatchEvent(new CustomEvent('sims:data-changed', { detail: { key: 'student-profile' } }));
    },

    // --- NOTIFICATIONS ---
    getNotifications: function(userId) {
        if (!localStorage.getItem('SIMS_NOTIFS_DATA')) {
            this.ensureSeedStudentData();
        }
        const notifs = JSON.parse(localStorage.getItem('SIMS_NOTIFS_DATA')) || [];
        return notifs.filter(n => n.userId === userId);
    },
    addNotification: function(notif) {
        const notifs = JSON.parse(localStorage.getItem('SIMS_NOTIFS_DATA')) || [];
        notif.id = 'NOTIF-' + Math.floor(Math.random() * 1000000);
        notifs.unshift(notif);
        localStorage.setItem('SIMS_NOTIFS_DATA', JSON.stringify(notifs));
        window.dispatchEvent(new Event('storage'));
    },

    // --- MESSAGES ---
    getMessages: function() {
        return JSON.parse(localStorage.getItem('SIMS_MESSAGES_DATA')) || [];
    },
    addMessage: function(msg) {
        const msgs = this.getMessages();
        msg.id = 'MSG-' + Math.floor(Math.random() * 1000000);
        msg.date = new Date().toISOString();
        msgs.push(msg);
        localStorage.setItem('SIMS_MESSAGES_DATA', JSON.stringify(msgs));
        window.dispatchEvent(new Event('storage'));
    },

    // --- INTERVIEWS ---
    getInterviews: function() {
        if (!localStorage.getItem('SIMS_INTERVIEWS_DATA')) {
            this.ensureSeedStudentData();
        }
        return JSON.parse(localStorage.getItem('SIMS_INTERVIEWS_DATA')) || [];
    },
    addInterview: function(interview) {
        const intvs = this.getInterviews();
        interview.id = 'INTV-' + Math.floor(Math.random() * 1000000);
        intvs.push(interview);
        localStorage.setItem('SIMS_INTERVIEWS_DATA', JSON.stringify(intvs));
        window.dispatchEvent(new Event('storage'));
        
        // Notify Student
        this.addNotification({
            userId: interview.studentEmail,
            title: 'Interview Scheduled',
            message: `${interview.company} scheduled an interview for ${new Date(interview.date).toLocaleDateString()}`,
            type: 'info',
            date: new Date().toISOString()
        });
    },

    // --- STUDENT WORKSPACE DATA ---
    // These records are intentionally kept in the same shared store as the
    // rest of the panel so changes made on one student page appear everywhere.
    getOffers: function(studentEmail) {
        const key = 'SIMS_OFFERS_DATA';
        let offers;
        try { offers = JSON.parse(localStorage.getItem(key)); } catch (e) { offers = null; }
        if (!Array.isArray(offers)) {
            offers = [{
                id: 'OFFER-10001', studentEmail: 'student@sims.com', studentName: 'Aarav Patel',
                company: 'TechNova Pvt Ltd', position: 'Frontend Developer Intern', stipend: '₹25,000 / month',
                duration: '6 Months', joiningDate: '2026-08-15', deadlineDate: '2026-08-05', status: 'pending',
                content: 'We are pleased to offer you the position of Frontend Developer Intern at TechNova Pvt Ltd. Your profile and interview performance were impressive, and we look forward to having you on our team.'
            }];
            localStorage.setItem(key, JSON.stringify(offers));
        }
        return studentEmail ? offers.filter(offer => offer.studentEmail === studentEmail) : offers;
    },
    saveOffers: function(offers) {
        localStorage.setItem('SIMS_OFFERS_DATA', JSON.stringify(offers));
        window.dispatchEvent(new CustomEvent('sims:data-changed', { detail: { key: 'SIMS_OFFERS_DATA' } }));
    },
    updateOffer: function(id, updates) {
        const offers = this.getOffers();
        const index = offers.findIndex(offer => String(offer.id) === String(id));
        if (index === -1) return null;
        offers[index] = { ...offers[index], ...updates };
        this.saveOffers(offers);
        return offers[index];
    },
    getFeedback: function(studentEmail) {
        const key = 'SIMS_FEEDBACK_DATA';
        let feedback;
        try { feedback = JSON.parse(localStorage.getItem(key)); } catch (e) { feedback = null; }
        if (!Array.isArray(feedback)) { feedback = []; localStorage.setItem(key, JSON.stringify(feedback)); }
        return studentEmail ? feedback.filter(item => item.studentEmail === studentEmail) : feedback;
    },
    addFeedback: function(feedback) {
        const all = this.getFeedback();
        const item = { id: 'FDB-' + Date.now(), createdAt: new Date().toISOString(), ...feedback };
        all.unshift(item);
        localStorage.setItem('SIMS_FEEDBACK_DATA', JSON.stringify(all));
        window.dispatchEvent(new CustomEvent('sims:data-changed', { detail: { key: 'SIMS_FEEDBACK_DATA' } }));
        return item;
    },
    getSupportTickets: function(studentEmail) {
        const key = 'SIMS_SUPPORT_TICKETS_DATA';
        let tickets;
        try { tickets = JSON.parse(localStorage.getItem(key)); } catch (e) { tickets = null; }
        if (!Array.isArray(tickets)) { tickets = []; localStorage.setItem(key, JSON.stringify(tickets)); }
        return studentEmail ? tickets.filter(item => item.studentEmail === studentEmail) : tickets;
    },
    addSupportTicket: function(ticket) {
        const all = this.getSupportTickets();
        const item = { id: 'TKT-' + Date.now(), status: 'Open', createdAt: new Date().toISOString(), ...ticket };
        all.unshift(item);
        localStorage.setItem('SIMS_SUPPORT_TICKETS_DATA', JSON.stringify(all));
        this.addNotification({ userId: item.studentEmail, title: 'Support ticket created', message: `Your ticket ${item.id} has been submitted.`, type: 'info', read: false, date: item.createdAt });
        window.dispatchEvent(new CustomEvent('sims:data-changed', { detail: { key: 'SIMS_SUPPORT_TICKETS_DATA' } }));
        return item;
    },

    ensureSeedStudentData: function() {
        const session = (() => {
            try { return JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) { return {}; }
        })();
        const studentEmail = session.email || 'student@sims.com';
        const studentName = session.name || 'Aarav Patel';

        if (!localStorage.getItem('SIMS_APPLICATIONS_DATA')) {
            const demoApps = [
                {
                    id: 'APP-10001',
                    internshipId: 1,
                    internshipTitle: 'Frontend Developer Intern',
                    company: 'TechNova Pvt Ltd',
                    studentName,
                    studentEmail,
                    studentEnrollment: session.enrollment || 'ENR2024001',
                    status: 'Shortlisted',
                    appliedOn: new Date(Date.now() - 1000 * 60 * 60 * 24 * 3).toISOString()
                },
                {
                    id: 'APP-10002',
                    internshipId: 2,
                    internshipTitle: 'Data Analyst Intern',
                    company: 'Bright Solutions',
                    studentName,
                    studentEmail,
                    studentEnrollment: session.enrollment || 'ENR2024001',
                    status: 'Pending',
                    appliedOn: new Date(Date.now() - 1000 * 60 * 60 * 24 * 7).toISOString()
                }
            ];
            localStorage.setItem('SIMS_APPLICATIONS_DATA', JSON.stringify(demoApps));
        }

        if (!localStorage.getItem('SIMS_NOTIFS_DATA')) {
            const demoNotifs = [
                {
                    id: 'NOTIF-10001',
                    userId: studentEmail,
                    title: 'Application Update',
                    message: 'Your application for Frontend Developer Intern was shortlisted.',
                    type: 'success',
                    read: false,
                    date: new Date().toISOString()
                },
                {
                    id: 'NOTIF-10002',
                    userId: studentEmail,
                    title: 'Resume Reminder',
                    message: 'Your latest resume was successfully uploaded.',
                    type: 'info',
                    read: true,
                    date: new Date(Date.now() - 1000 * 60 * 60 * 24).toISOString()
                }
            ];
            localStorage.setItem('SIMS_NOTIFS_DATA', JSON.stringify(demoNotifs));
        }

        if (!localStorage.getItem('SIMS_MESSAGES_DATA')) {
            const demoMessages = [
                {
                    id: 'MSG-10001',
                    from: 'support@sims.com',
                    to: studentEmail,
                    text: 'Welcome! We can help with interviews and document submissions.',
                    date: new Date().toISOString()
                }
            ];
            localStorage.setItem('SIMS_MESSAGES_DATA', JSON.stringify(demoMessages));
        }

        if (!localStorage.getItem('SIMS_INTERVIEWS_DATA')) {
            const demoInterviews = [
                {
                    id: 'INTV-10001',
                    studentEmail,
                    studentName,
                    company: 'Bright Solutions',
                    internshipTitle: 'Data Analyst Intern',
                    date: new Date(Date.now() + 1000 * 60 * 60 * 24 * 5).toISOString()
                }
            ];
            localStorage.setItem('SIMS_INTERVIEWS_DATA', JSON.stringify(demoInterviews));
        }

        if (!localStorage.getItem('SIMS_STUDENTS_DATA')) {
            const demoStudents = [
                { id: 1, photo: 'https://ui-avatars.com/api/?name=Rahul+Sharma&background=2563eb&color=fff', name: 'Rahul Sharma', enr: 'ENR2024001', dept: 'Computer Science', sem: '6th', email: 'rahul@example.com', mobile: '9876543210', date: '01 Jan 2024', status: 'Active' },
                { id: 2, photo: 'https://ui-avatars.com/api/?name=Kavya+Shah&background=ea580c&color=fff', name: 'Kavya Shah', enr: 'ENR2024002', dept: 'Information Technology', sem: '4th', email: 'kavya@example.com', mobile: '9876543211', date: '03 Jan 2024', status: 'Pending' }
            ];
            localStorage.setItem('SIMS_STUDENTS_DATA', JSON.stringify(demoStudents));
        }

        if (!localStorage.getItem('SIMS_COMPANIES_DATA')) {
            const demoCompanies = [
                { id: 1, logo: 'https://ui-avatars.com/api/?name=TechNova&background=2563eb&color=fff', name: 'TechNova Pvt Ltd', ind: 'Information Technology', hr: 'Amit Patel', email: 'hr@technova.com', phone: '9876543210', date: '01 Jan 2024', status: 'Active' },
                { id: 2, logo: 'https://ui-avatars.com/api/?name=DesignStudio&background=ea580c&color=fff', name: 'DesignStudio Co.', ind: 'Design', hr: 'Priya Shah', email: 'contact@designstudio.com', phone: '9876543211', date: '05 Jan 2024', status: 'Pending' }
            ];
            localStorage.setItem('SIMS_COMPANIES_DATA', JSON.stringify(demoCompanies));
            window.COMPANIES_DATA = demoCompanies;
        }

        window.dispatchEvent(new Event('storage'));
        return true;
    }
};

window.GlobalStore.ensureSeedStudentData();

window.StudentProfileSync = (function () {
    const STUDENT_PROFILE_KEY_PREFIX = 'simsStudentProfileData_';

    function getSession() {
        try { return JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) { return {}; }
    }

    function getProfile() {
        const session = getSession();
        if (typeof window.PMData !== 'undefined' && window.PMData && typeof window.PMData.getProfile === 'function') {
            return window.PMData.getProfile();
        }
        if (!session || session.role !== 'student') {
            return null;
        }
        const key = `${STUDENT_PROFILE_KEY_PREFIX}${session.email || 'student@sims.com'}`;
        try {
            const raw = localStorage.getItem(key);
            if (raw) return JSON.parse(raw);
        } catch (e) {}
        return {
            fullName: session.name || 'Student',
            enrollment: session.enrollment || 'ENR2024001',
            email: session.email || 'student@sims.com',
            mobile: '',
            department: '',
            course: '',
            semester: '',
            college: '',
            address: '',
            resumeUploaded: false,
            resumeName: '',
            resumeUpdated: ''
        };
    }

    function setText(id, value) {
        const el = document.getElementById(id);
        if (el && value !== undefined && value !== null) {
            el.textContent = value;
        }
    }

    function setHtml(id, value) {
        const el = document.getElementById(id);
        if (el && value !== undefined && value !== null) {
            el.innerHTML = value;
        }
    }

    function normalizeStudentHeader(session, profileData) {
        const topbarLeft = document.querySelector('.dashboard-topbar-left');
        const topbarRight = document.querySelector('.dashboard-topbar-right');
        const profileDropdown = document.getElementById('profileDropdown');
        const profileTrigger = document.getElementById('dashProfileTrigger');

        if (profileDropdown) {
            profileDropdown.querySelectorAll('a[href="settings.html"]').forEach((link) => {
                const maybeHr = link.nextElementSibling && link.nextElementSibling.tagName === 'HR'
                    ? link.nextElementSibling
                    : (link.previousElementSibling && link.previousElementSibling.tagName === 'HR' ? link.previousElementSibling : null);
                link.remove();
                if (maybeHr) maybeHr.remove();
            });
        }

        if (topbarLeft) {
            if (!topbarLeft.querySelector('.sidebar-toggle-btn')) {
                const toggleBtn = document.createElement('button');
                toggleBtn.className = 'sidebar-toggle-btn';
                toggleBtn.id = 'sidebarToggleBtn';
                toggleBtn.type = 'button';
                toggleBtn.setAttribute('aria-label', 'Toggle menu');
                toggleBtn.innerHTML = '<i class="fa-solid fa-bars"></i>';
                topbarLeft.insertBefore(toggleBtn, topbarLeft.firstChild);
            }

            const searchWrap = topbarLeft.querySelector('.dashboard-topbar-search');
            if (!searchWrap) {
                const searchBar = document.createElement('div');
                searchBar.className = 'dashboard-topbar-search';
                searchBar.innerHTML = '<i class="fa-solid fa-magnifying-glass"></i><input type="text" placeholder="Search menus, updates, records...">';
                topbarLeft.appendChild(searchBar);
            } else {
                const input = searchWrap.querySelector('input');
                if (input) input.placeholder = 'Search menus, updates, records...';
            }
        }

        if (topbarRight) {
            const makeBtn = (id, className, title, ariaLabel, iconHtml, onClick) => {
                let btn = document.getElementById(id);
                if (btn) return btn;
                btn = document.createElement('button');
                btn.type = 'button';
                btn.id = id;
                btn.className = className;
                if (title) btn.title = title;
                if (ariaLabel) btn.setAttribute('aria-label', ariaLabel);
                btn.innerHTML = iconHtml;
                if (typeof onClick === 'function') btn.addEventListener('click', onClick);
                return btn;
            };

            const logoutBtn = makeBtn(
                'headerLogoutBtn',
                'icon-btn dash-icon-btn',
                'Logout',
                'Logout',
                '<i class="fa-solid fa-right-from-bracket"></i>',
                () => {
                    if (confirm('Are you sure you want to logout?')) {
                        localStorage.removeItem('simsSession');
                        window.location.href = 'index.html';
                    }
                }
            );

            const themeBtn = makeBtn(
                'themeToggleBtn',
                'theme-toggle-btn',
                'Toggle theme',
                'Toggle theme',
                '<i class="fa-solid fa-moon"></i>',
                () => {
                    document.body.classList.toggle('dark-theme');
                    themeBtn.classList.toggle('active');
                    const icon = themeBtn.querySelector('i');
                    if (icon) {
                        icon.className = document.body.classList.contains('dark-theme') ? 'fa-solid fa-sun' : 'fa-solid fa-moon';
                    }
                }
            );

            const notifBtn = makeBtn(
                'dashNotifBtn',
                'icon-btn dash-icon-btn',
                'Notifications',
                'Notifications',
                '<i class="fa-regular fa-bell"></i><span class="badge">4</span>',
                () => window.location.href = 'notifications.html'
            );

            const messageBtn = makeBtn(
                'dashMessageBtn',
                'icon-btn dash-icon-btn',
                'Messages',
                'Messages',
                '<i class="fa-regular fa-comment"></i>',
                () => window.location.href = 'messages.html'
            );

            const toInsert = [];
            if (!document.getElementById('headerLogoutBtn')) toInsert.push(logoutBtn);
            if (!document.getElementById('themeToggleBtn')) toInsert.push(themeBtn);
            if (!document.getElementById('dashNotifBtn')) toInsert.push(notifBtn);
            if (!document.getElementById('dashMessageBtn')) toInsert.push(messageBtn);

            const refNode = profileTrigger || topbarRight.firstChild;
            if (toInsert.length) {
                const fragment = document.createDocumentFragment();
                toInsert.forEach(node => fragment.appendChild(node));
                if (refNode) {
                    topbarRight.insertBefore(fragment, profileTrigger || refNode);
                } else {
                    topbarRight.appendChild(fragment);
                }
            }
        }

        if (session && session.role === 'student' && profileData) {
            const name = profileData.fullName || profileData.name || session.name || 'Student';
            const avatarHtml = profileData.photo
                ? `<img src="${profileData.photo}" alt="${name}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;">`
                : (typeof window.PMData !== 'undefined' && window.PMData && typeof window.PMData.getInitials === 'function'
                    ? window.PMData.getInitials(name)
                    : name.trim().split(/\s+/).map(part => part[0]).join('').slice(0, 2).toUpperCase());

            document.querySelectorAll('#dashAvatarSm, .dash-avatar-sm').forEach(el => {
                if (el) el.innerHTML = avatarHtml;
            });
            document.querySelectorAll('#dashNameTop, .dash-name').forEach(el => {
                if (el) el.innerHTML = `${name}<span>Student</span>`;
            });
        }
    }

    function apply(profile) {
        const session = getSession();
        if (!session || session.role !== 'student') return null;

        const data = profile || getProfile();
        if (!data) return null;

        const name = data.fullName || data.name || session.name || 'Student';
        const email = data.email || session.email || 'student@sims.com';
        const enrollment = data.enrollment || session.enrollment || 'ENR2024001';
        const initials = (typeof window.PMData !== 'undefined' && window.PMData && typeof window.PMData.getInitials === 'function')
            ? window.PMData.getInitials(name)
            : name.trim().split(/\s+/).map(part => part[0]).join('').slice(0, 2).toUpperCase();

        const avatarHtml = data.photo
            ? `<img src="${data.photo}" alt="${name}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;">`
            : initials;

        document.querySelectorAll('#dashAvatarSm, .dash-avatar-sm').forEach(el => {
            if (el) el.innerHTML = avatarHtml;
        });

        document.querySelectorAll('#dashNameTop, .dash-name').forEach(el => {
            if (el) el.innerHTML = `${name}<span>Student</span>`;
        });

        normalizeStudentHeader(session, data);

        setText('profileName', name);
        setText('profileEmail', email);
        setText('profileEnrollment', enrollment);

        const courseLine = [data.course, data.department].filter(Boolean).join(', ');
        setText('pmName', name);
        setText('pmEnrollment', enrollment);
        setText('pmCourseLine', courseLine);
        setText('pmCollegeLine', data.college || '');
        setText('pmEmail', email);
        setText('pmMobile', data.mobile || '');
        setText('pmDepartment', data.department || '');
        setText('pmCourse', data.course || '');
        setText('pmSemester', data.semester || '');
        setText('pmCollege', data.college || '');
        setText('pmAddress', data.address && data.address.trim() ? data.address : 'Not added yet');
        setText('applicationProfileName', name);
        setText('applicationProfileAcademic', [data.course, data.department, data.college].filter(Boolean).join(' • '));
        setText('applicationProfileEmail', email);
        setText('applicationProfileMobile', data.mobile || '');
        setText('studentName', name);
        setText('studentEmail', email);

        const avatarLg = document.getElementById('pmAvatarLg');
        if (avatarLg) {
            if (data.photo) {
                avatarLg.innerHTML = `<img src="${data.photo}" alt="${name}">`;
            } else {
                avatarLg.textContent = initials;
            }
        }

        const resumeStatusEl = document.getElementById('pmResumeStatus');
        if (resumeStatusEl) {
            if (data.resumeUploaded) {
                resumeStatusEl.className = 'pm-resume-status uploaded';
                resumeStatusEl.innerHTML = '<i class="fa-solid fa-circle-check"></i> Uploaded';
            } else {
                resumeStatusEl.className = 'pm-resume-status missing';
                resumeStatusEl.innerHTML = '<i class="fa-solid fa-circle-exclamation"></i> Not Uploaded';
            }
        }

        const completion = (typeof window.PMData !== 'undefined' && window.PMData && typeof window.PMData.getCompletion === 'function')
            ? window.PMData.getCompletion(data)
            : null;
        if (completion) {
            setText('pmCompletionValue', `${completion.percent}% Complete`);
            setText('pmMiniPercent', `${completion.percent}%`);
            const bar = document.getElementById('pmMiniBar');
            if (bar) bar.style.width = completion.percent + '%';
        }

        const skillsWrap = document.getElementById('pmSkillsInline');
        if (skillsWrap && data.skills) {
            if (data.skills.length) {
                skillsWrap.innerHTML = data.skills.map(s => `<span class="skill-tag">${String(s.name || '').replace(/[&<>"']/g, ch => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[ch]))}</span>`).join('');
            } else {
                skillsWrap.innerHTML = `<span style="font-size:12.5px;color:var(--text-muted);">No skills added yet. <a href="skills-management.html" style="color:var(--blue-600);font-weight:600;">Add skills</a></span>`;
            }
        }

        return data;
    }

    function bind() {
        const run = () => apply();
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', run, { once: true });
        } else {
            run();
        }
        window.addEventListener('sims:profile-updated', () => apply());
        window.addEventListener('sims:data-changed', (e) => {
            if (!e || !e.detail || e.detail.key === 'student-profile') {
                apply();
            }
        });
    }

    return { getProfile, apply, bind };
})();

if (window.StudentProfileSync && typeof window.StudentProfileSync.bind === 'function') {
    window.StudentProfileSync.bind();
}

window.addEventListener('storage', function(e) {
    if (e.key === 'SIMS_INTERNSHIPS_DATA' && typeof buildInternshipsData !== 'undefined') {
        window.INTERNSHIPS_DATA = JSON.parse(e.newValue);
    }
    if (e.key === 'SIMS_COMPANIES_DATA' && typeof COMPANIES_DATA !== 'undefined') {
        window.COMPANIES_DATA = JSON.parse(e.newValue);
    }
});

<%@ Page Title="Education" Language="C#" MasterPageFile="~/StudentPanel/student.Master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/student-education.css") %>" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="student-education-page">
        <section class="student-education-header">
            <div><span class="student-education-eyebrow"><i class="fa-solid fa-graduation-cap"></i> Academic profile</span><h1>Education</h1><p>Manage your academic background</p></div>
            <button type="button" id="addEducationButton" class="student-education-primary"><i class="fa-solid fa-plus"></i> Add Education</button>
        </section>

        <section id="educationList" class="student-education-timeline" aria-live="polite">
            <article class="student-education-card">
                <div class="student-education-card-heading"><div class="student-education-heading-icon"><i class="fa-solid fa-graduation-cap"></i></div><div><h2>Gujarat University</h2><p>Bachelor of Computer Applications (BCA)</p></div><div class="student-education-card-actions"><button type="button" class="student-education-icon-button" aria-label="Edit education"><i class="fa-solid fa-pen"></i></button><button type="button" class="student-education-icon-button delete" aria-label="Delete education"><i class="fa-solid fa-trash-can"></i></button></div></div>
                <div class="student-education-details"><div class="student-education-detail"><label>Grade Year</label><strong>Third Year</strong></div><div class="student-education-detail"><label>Semester</label><strong>Semester 5</strong></div><div class="student-education-detail"><label>Location</label><strong><i class="fa-solid fa-location-dot"></i>Ahmedabad, Gujarat</strong></div></div>
            </article>
        </section>
        <section id="educationEmpty" class="student-education-empty" hidden><div class="student-education-empty-icon"><i class="fa-solid fa-building-columns"></i></div><h2>No education added yet</h2><p>Add your college or university details to complete your academic profile.</p><button type="button" class="student-education-primary" id="emptyAddButton"><i class="fa-solid fa-plus"></i> Add Education</button></section>

        <section class="student-education-card student-education-form-card" id="educationFormCard" hidden>
            <div class="student-education-card-heading"><div class="student-education-heading-icon"><i class="fa-solid fa-pen-to-square"></i></div><div><h2 id="formTitle">Add Education</h2><p>Keep your academic information accurate and up to date.</p></div></div>
            <form id="educationForm" novalidate>
                <div class="student-education-form-grid">
                    <div class="student-education-field wide"><label for="collegeName">College Name <span>*</span></label><div class="student-education-input"><i class="fa-solid fa-building-columns"></i><input id="collegeName" required maxlength="120" placeholder="e.g. Gujarat University" /></div><small class="student-education-error" data-error-for="collegeName"></small></div>
                    <div class="student-education-field"><label for="courseName">Course <span>*</span></label><div class="student-education-input"><i class="fa-solid fa-book-open"></i><input id="courseName" required maxlength="80" placeholder="e.g. BCA" /></div><small class="student-education-error" data-error-for="courseName"></small></div>
                    <div class="student-education-field"><label for="gradeYear">Grade Year</label><div class="student-education-input"><i class="fa-solid fa-calendar-check"></i><select id="gradeYear"><option value="">Select year</option><option>First Year</option><option>Second Year</option><option>Third Year</option><option>Final Year</option></select></div></div>
                    <div class="student-education-field"><label for="semester">Semester</label><div class="student-education-input"><i class="fa-solid fa-list-ol"></i><select id="semester"><option value="">Select semester</option><option>Semester 1</option><option>Semester 2</option><option>Semester 3</option><option>Semester 4</option><option>Semester 5</option><option>Semester 6</option><option>Semester 7</option><option>Semester 8</option></select></div></div>
                    <div class="student-education-field"><label for="location">Location</label><div class="student-education-input"><i class="fa-solid fa-location-dot"></i><input id="location" maxlength="80" placeholder="e.g. Ahmedabad, Gujarat" /></div></div>
                </div>
                <div class="student-education-form-actions"><button type="button" id="cancelEducationButton" class="student-education-secondary">Cancel</button><button type="submit" class="student-education-primary"><i class="fa-solid fa-check"></i> Save Education</button></div>
            </form>
        </section>
    </main>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="ScriptContent" runat="server"><script src="<%= ResolveUrl("~/js/student-education.js") %>"></script></asp:Content>

<%@ Page Title="Skills" Language="C#" MasterPageFile="~/StudentPanel/student.Master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/student-skills.css") %>" />
</asp:Content>

<asp:Content ID="ContentMain" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="student-skills-page">
        <section class="student-skills-header">
            <div>
                <span class="student-skills-eyebrow"><i class="fa-solid fa-layer-group"></i> Profile strengths</span>
                <h1>Skills</h1>
                <p>Manage your technical and professional skills</p>
            </div>
            <div class="student-skills-count-card"><strong id="skillsCount">0</strong><span>skills added</span></div>
        </section>

        <section class="student-skills-card student-skills-add-card">
            <div class="student-skills-card-heading"><div class="student-skills-heading-icon"><i class="fa-solid fa-plus"></i></div><div><h2>Add a skill</h2><p>Add skills that showcase your strengths to recruiters.</p></div></div>
            <div class="student-skills-entry">
                <label for="skillInput">Skill name</label>
                <div class="student-skills-input-row">
                    <div class="student-skills-input-wrap"><i class="fa-solid fa-magnifying-glass"></i><input id="skillInput" type="text" placeholder="e.g. JavaScript" maxlength="40" autocomplete="off" /></div>
                    <button type="button" id="addSkillButton" class="student-skills-primary"><i class="fa-solid fa-plus"></i> Add Skill</button>
                </div>
                <span class="student-skills-error" id="skillError" role="alert"></span>
            </div>
        </section>

        <section class="student-skills-card">
            <div class="student-skills-card-heading"><div class="student-skills-heading-icon blue"><i class="fa-solid fa-tags"></i></div><div><h2>My Skills <span class="student-skills-inline-count" id="skillsCountLabel">0</span></h2><p>Remove a skill anytime using the delete icon.</p></div></div>
            <div id="skillsList" class="student-skills-list" aria-live="polite"></div>
            <div id="skillsEmpty" class="student-skills-empty"><div class="student-skills-empty-icon"><i class="fa-solid fa-wand-magic-sparkles"></i></div><h3>No skills added yet</h3><p>Add your first skill above or choose one from the suggestions below.</p></div>
        </section>

        <section class="student-skills-card student-skills-suggestions-card">
            <div class="student-skills-card-heading"><div class="student-skills-heading-icon violet"><i class="fa-solid fa-lightbulb"></i></div><div><h2>Suggested Skills</h2><p>Click a suggestion to add it to your profile.</p></div></div>
            <div class="student-skills-suggestions" id="suggestedSkills">
                <button type="button" data-skill="HTML">HTML</button><button type="button" data-skill="CSS">CSS</button><button type="button" data-skill="JavaScript">JavaScript</button><button type="button" data-skill="C#">C#</button><button type="button" data-skill="ASP.NET">ASP.NET</button><button type="button" data-skill="SQL">SQL</button><button type="button" data-skill="Java">Java</button><button type="button" data-skill="Python">Python</button><button type="button" data-skill="Communication">Communication</button><button type="button" data-skill="Teamwork">Teamwork</button>
            </div>
        </section>

        <div class="student-skills-actions"><span id="skillsSaveMessage" class="student-skills-save-message" role="status"></span><button type="button" id="saveSkillsButton" class="student-skills-primary"><i class="fa-solid fa-check"></i> Save Skills</button></div>
    </main>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="ScriptContent" runat="server">
    <script src="<%= ResolveUrl("~/js/student-skills.js") %>"></script>
</asp:Content>

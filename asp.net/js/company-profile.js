// SIMS - Company Profile Script
function openCompanyTab(id, button) {
        document.querySelectorAll('.profile-tab-content').forEach(function (x) { x.classList.remove('active'); });
        document.querySelectorAll('.profile-tab').forEach(function (x) { x.classList.remove('active'); });
        var section = document.getElementById(id);
        if (section) section.classList.add('active');
        if (button) button.classList.add('active');
    }

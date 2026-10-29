/* =====================================================
   SCRIPT FOR viewCompanyDetails.aspx
   ===================================================== */
function openCompanyTab(tabId, tabBtn) {
        var contents = document.querySelectorAll('.profile-tab-content');
        contents.forEach(function(content) {
            content.classList.remove('active');
        });
        var tabs = document.querySelectorAll('.profile-tab');
        tabs.forEach(function(tab) {
            tab.classList.remove('active');
        });
        var target = document.getElementById(tabId);
        if (target) {
            target.classList.add('active');
        }
        if (tabBtn) {
            tabBtn.classList.add('active');
        }
    }

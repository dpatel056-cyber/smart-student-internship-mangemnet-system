function openCompanyTab(tabId, btn) {
        var contents = document.querySelectorAll('.profile-tab-content');
        contents.forEach(function (c) {
            c.classList.remove('active');
        });
        var tabs = document.querySelectorAll('.profile-tab');
        tabs.forEach(function (t) {
            t.classList.remove('active');
        });
        var target = document.getElementById(tabId);
        if (target) {
            target.classList.add('active');
        }
        if (btn) {
            btn.classList.add('active');
        }
    }

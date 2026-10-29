/**
 * Company Details JavaScript - SIMS
 * Public Panel Company Details Page
 */

function openCompanyTab(tabId, tabBtn) {
    document.querySelectorAll('.profile-tab-content').forEach(function (c) {
        c.classList.remove('active');
    });
    document.querySelectorAll('.profile-tab').forEach(function (t) {
        t.classList.remove('active');
    });
    var target = document.getElementById(tabId);
    if (target) {
        target.classList.add('active');
    }
    if (tabBtn) {
        tabBtn.classList.add('active');
    }
}

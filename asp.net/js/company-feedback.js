// SIMS - Company Feedback Script
function openDrawer() {
    var overlay = document.getElementById('drawerOverlay');
    var drawer = document.getElementById('feedbackDrawer');
    if (overlay) {
        overlay.classList.add('is-active');
    }
    if (drawer) {
        drawer.classList.add('is-open');
    }
    document.body.style.overflow = 'hidden';
}

function closeDrawer() {
    var overlay = document.getElementById('drawerOverlay');
    var drawer = document.getElementById('feedbackDrawer');
    if (overlay) {
        overlay.classList.remove('is-active');
    }
    if (drawer) {
        drawer.classList.remove('is-open');
    }
    document.body.style.overflow = '';
}

document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') {
        closeDrawer();
    }
});

/**
 * Internship Details JavaScript - SIMS
 * Public Panel Internship Details Page
 */

document.addEventListener('DOMContentLoaded', function () {
    var skillsWraps = document.querySelectorAll('.imd-skills');
    skillsWraps.forEach(function (wrap) {
        var badges = wrap.querySelectorAll('.imd-skill-badge');
        badges.forEach(function (badge) {
            var text = (badge.textContent || '').trim();
            if (text.indexOf(',') !== -1) {
                var items = text.split(',');
                var frag = document.createDocumentFragment();
                items.forEach(function (item) {
                    var trimmed = item.trim();
                    if (trimmed) {
                        var span = document.createElement('span');
                        span.className = 'imd-skill-tag';
                        span.textContent = trimmed;
                        frag.appendChild(span);
                    }
                });
                badge.replaceWith(frag);
            }
        });
    });
});

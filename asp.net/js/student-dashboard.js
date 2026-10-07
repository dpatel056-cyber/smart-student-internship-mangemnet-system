(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        animateProgressBar();
    });

    function animateProgressBar() {
        var fill = document.getElementById('profileProgressFill');
        if (fill) {
            var targetWidth = fill.getAttribute('data-percentage') || '0%';
            setTimeout(function () {
                fill.style.width = targetWidth;
            }, 150);
        }
    }
})();

(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        animateCircularRing();
        animateBreakdownBars();
    });

    /* ---------------------------------------------------------------
       1. ANIMATE CIRCULAR PROGRESS RING
    --------------------------------------------------------------- */
    function animateCircularRing() {
        var fillCircle = document.getElementById('ringFillCircle');
        var percentageEl = document.getElementById('ringPercentageText');

        if (!fillCircle) return;

        var percent = parseInt(fillCircle.getAttribute('data-percentage') || '85', 10);
        var radius = 60;
        var circumference = 2 * Math.PI * radius; // Approx 377px

        // Calculate offset (377 * (1 - percent / 100))
        var offset = circumference * (1 - (percent / 100));

        setTimeout(function () {
            fillCircle.style.strokeDashoffset = offset;
        }, 300);
    }

    /* ---------------------------------------------------------------
       2. ANIMATE HORIZONTAL BREAKDOWN BARS
    --------------------------------------------------------------- */
    function animateBreakdownBars() {
        var breakdownFills = document.querySelectorAll('.profile-completion-row-fill');
        breakdownFills.forEach(function (fill) {
            var targetWidth = fill.getAttribute('data-percentage') || '0%';
            setTimeout(function () {
                fill.style.width = targetWidth;
            }, 300);
        });
    }

})();

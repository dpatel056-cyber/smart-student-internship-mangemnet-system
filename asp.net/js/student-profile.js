// ==================================================
// SIMS - Student Profile Page Script
// ==================================================

(function () {
    "use strict";

    document.addEventListener("DOMContentLoaded", function () {
        animateProgressBar();
    });

    // Animate the profile completion bar on load for a subtle polish effect
    function animateProgressBar() {
        var fill = document.getElementById("profileCompletionFill");
        if (!fill) return;

        var targetWidth = fill.getAttribute("data-percent") || "0";
        fill.style.width = "0%";

        setTimeout(function () {
            fill.style.width = targetWidth + "%";
        }, 150);
    }
})();

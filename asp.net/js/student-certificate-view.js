document.addEventListener("DOMContentLoaded", function () {
    var f = document.querySelector(".student-footer") || document.querySelector("footer");
    if (f) {
        f.style.setProperty("display", "none", "important");
    }
});

// SIMS Admin Panel - Offer Letters JavaScript

function openOfferDrawer() {
    var overlay = document.getElementById("offerDrawerOverlay");
    if (overlay) {
        overlay.classList.add("active");
        document.body.style.overflow = "hidden";
    }
}

function closeOfferDrawer() {
    var overlay = document.getElementById("offerDrawerOverlay");
    if (overlay) {
        overlay.classList.remove("active");
        document.body.style.overflow = "";
    }
}

document.addEventListener("DOMContentLoaded", function () {
    var overlay = document.getElementById("offerDrawerOverlay");
    if (overlay) {
        overlay.addEventListener("click", function (e) {
            if (e.target === overlay) {
                closeOfferDrawer();
            }
        });
    }

    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") {
            closeOfferDrawer();
        }
    });
});

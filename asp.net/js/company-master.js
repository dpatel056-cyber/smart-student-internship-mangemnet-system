// ==================================================
// SIMS - Company Master Page Script
// ==================================================

(function () {
    "use strict";

    document.addEventListener("DOMContentLoaded", function () {
        var layout = document.querySelector(".company-layout");
        if (layout) {
            layout.classList.remove("is-collapsed");
        }
        try {
            localStorage.removeItem("sims_company_sidebar_collapsed");
        } catch (e) { }

        initMobileDrawer();
        initSubmenus();
        setActiveMenuFromUrl();
        initProfileDropdown();
    });

    // --------------------------------------------------
    // Mobile off-canvas drawer
    // --------------------------------------------------
    function initMobileDrawer() {
        var layout = document.querySelector(".company-layout");
        var overlay = document.getElementById("companySidebarOverlay");
        if (!layout || !overlay) return;

        overlay.addEventListener("click", function () {
            closeMobileDrawer();
        });

        // Close drawer when a sidebar link is clicked (mobile)
        var links = document.querySelectorAll(".company-sidebar-link, .company-sidebar-bottom-logout");
        links.forEach(function (link) {
            link.addEventListener("click", function () {
                if (window.innerWidth <= 991) {
                    closeMobileDrawer();
                }
            });
        });

        window.addEventListener("resize", function () {
            if (window.innerWidth > 991) {
                closeMobileDrawer();
            }
        });
    }

    function toggleMobileDrawer() {
        var layout = document.querySelector(".company-layout");
        var overlay = document.getElementById("companySidebarOverlay");
        var isOpen = layout.classList.toggle("is-mobile-open");
        if (overlay) overlay.classList.toggle("is-visible", isOpen);
        var toggleBtn = document.getElementById("companySidebarToggle");
        if (toggleBtn) toggleBtn.setAttribute("aria-expanded", String(isOpen));
    }

    function closeMobileDrawer() {
        var layout = document.querySelector(".company-layout");
        var overlay = document.getElementById("companySidebarOverlay");
        if (layout) layout.classList.remove("is-mobile-open");
        if (overlay) overlay.classList.remove("is-visible");
    }

    // --------------------------------------------------
    // Submenu expand/collapse (accordion - only one open)
    // --------------------------------------------------
    function initSubmenus() {
        var parents = document.querySelectorAll(".company-sidebar-parent");

        parents.forEach(function (parent) {
            parent.addEventListener("click", function () {
                var isOpen = parent.classList.contains("is-open");

                // Close all other submenus (accordion behavior)
                parents.forEach(function (p) {
                    p.classList.remove("is-open");
                    p.setAttribute("aria-expanded", "false");
                });

                if (!isOpen) {
                    parent.classList.add("is-open");
                    parent.setAttribute("aria-expanded", "true");
                }
            });
        });
    }

    // --------------------------------------------------
    // Active menu detection based on current URL
    // --------------------------------------------------
    function setActiveMenuFromUrl() {
        var currentPage = window.location.pathname.split("/").pop().toLowerCase();
        if (!currentPage) return;

        var allLinks = document.querySelectorAll(".company-sidebar-link");
        var matchedLink = null;

        allLinks.forEach(function (link) {
            var href = (link.getAttribute("href") || "").toLowerCase();
            if (href && href.indexOf(currentPage) !== -1 && currentPage !== "") {
                matchedLink = link;
            }
        });

        if (matchedLink) {
            matchedLink.classList.add("company-sidebar-active");

            // If the matched link is inside a submenu, open the parent and mark it active
            var submenu = matchedLink.closest(".company-sidebar-submenu");
            if (submenu) {
                var parent = submenu.previousElementSibling;
                if (parent && parent.classList.contains("company-sidebar-parent")) {
                    parent.classList.add("is-open");
                    parent.classList.add("company-sidebar-active");
                    parent.setAttribute("aria-expanded", "true");
                }
            }
        }
    }

    // --------------------------------------------------
    // Profile dropdown
    // --------------------------------------------------
    function initProfileDropdown() {
        var profileBtn = document.getElementById("companyProfileBtn");
        var dropdown = document.getElementById("companyProfileDropdown");
        if (!profileBtn || !dropdown) return;

        profileBtn.addEventListener("click", function (e) {
            e.stopPropagation();
            var isOpen = dropdown.classList.toggle("is-open");
            profileBtn.setAttribute("aria-expanded", String(isOpen));
        });

        document.addEventListener("click", function (e) {
            if (!dropdown.contains(e.target) && !profileBtn.contains(e.target)) {
                dropdown.classList.remove("is-open");
                profileBtn.setAttribute("aria-expanded", "false");
            }
        });

        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") {
                dropdown.classList.remove("is-open");
                profileBtn.setAttribute("aria-expanded", "false");
            }
        });
    }
})();

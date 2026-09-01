// ==================================================
// SIMS - Student Master Page Script
// ==================================================

(function () {
    "use strict";

    var STORAGE_KEY = "sims_student_sidebar_collapsed";

    document.addEventListener("DOMContentLoaded", function () {
        initSidebarCollapse();
        initMobileDrawer();
        initSubmenus();
        setActiveMenuFromUrl();
        initProfileDropdown();
    });

    // --------------------------------------------------
    // Sidebar collapse (desktop) with localStorage
    // --------------------------------------------------
    function initSidebarCollapse() {
        var layout = document.querySelector(".student-layout");
        var toggleBtn = document.getElementById("studentSidebarToggle");
        if (!layout || !toggleBtn) return;

        var isCollapsed = localStorage.getItem(STORAGE_KEY) === "true";
        if (isCollapsed) {
            layout.classList.add("is-collapsed");
        }
        toggleBtn.setAttribute("aria-expanded", String(!isCollapsed));

        toggleBtn.addEventListener("click", function () {
            // On mobile, toggle acts as drawer opener instead of collapse
            if (window.innerWidth <= 991) {
                toggleMobileDrawer();
                return;
            }

            var collapsed = layout.classList.toggle("is-collapsed");
            localStorage.setItem(STORAGE_KEY, String(collapsed));
            toggleBtn.setAttribute("aria-expanded", String(!collapsed));
        });
    }

    // --------------------------------------------------
    // Mobile off-canvas drawer
    // --------------------------------------------------
    function initMobileDrawer() {
        var layout = document.querySelector(".student-layout");
        var overlay = document.getElementById("studentSidebarOverlay");
        if (!layout || !overlay) return;

        overlay.addEventListener("click", function () {
            closeMobileDrawer();
        });

        // Close drawer when a sidebar link is clicked (mobile)
        var links = document.querySelectorAll(".student-sidebar-link");
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
        var layout = document.querySelector(".student-layout");
        var overlay = document.getElementById("studentSidebarOverlay");
        var isOpen = layout.classList.toggle("is-mobile-open");
        if (overlay) overlay.classList.toggle("is-visible", isOpen);
        var toggleBtn = document.getElementById("studentSidebarToggle");
        if (toggleBtn) toggleBtn.setAttribute("aria-expanded", String(isOpen));
    }

    function closeMobileDrawer() {
        var layout = document.querySelector(".student-layout");
        var overlay = document.getElementById("studentSidebarOverlay");
        if (layout) layout.classList.remove("is-mobile-open");
        if (overlay) overlay.classList.remove("is-visible");
    }

    // --------------------------------------------------
    // Submenu expand/collapse (accordion - only one open)
    // --------------------------------------------------
    function initSubmenus() {
        var parents = document.querySelectorAll(".student-sidebar-parent");

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

        var allLinks = document.querySelectorAll(".student-sidebar-link");
        var matchedLink = null;

        allLinks.forEach(function (link) {
            var href = (link.getAttribute("href") || "").toLowerCase();
            if (href && href.indexOf(currentPage) !== -1 && currentPage !== "") {
                matchedLink = link;
            }
        });

        if (matchedLink) {
            matchedLink.classList.add("student-sidebar-active");

            // If the matched link is inside a submenu, open the parent and mark it active
            var submenu = matchedLink.closest(".student-sidebar-submenu");
            if (submenu) {
                var parent = submenu.previousElementSibling;
                if (parent && parent.classList.contains("student-sidebar-parent")) {
                    parent.classList.add("is-open");
                    parent.classList.add("student-sidebar-active");
                    parent.setAttribute("aria-expanded", "true");
                }
            }
        }
    }

    // --------------------------------------------------
    // Profile dropdown
    // --------------------------------------------------
    function initProfileDropdown() {
        var profileBtn = document.getElementById("studentProfileBtn");
        var dropdown = document.getElementById("studentProfileDropdown");
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

/* =====================================================
   SIMS Admin Panel - Master Layout Script
   ===================================================== */
(function () {
  "use strict";

  document.addEventListener("DOMContentLoaded", function () {
    var wrapper = document.querySelector(".sims-wrapper");
    var sidebarToggleBtn = document.getElementById("sidebarToggleBtn");
    var sidebarOverlay = document.getElementById("sidebarOverlay");
    var profileMenu = document.getElementById("profileMenu");
    var profileTrigger = document.getElementById("profileTrigger");

    if (!wrapper) return;

    var isMobile = function () {
      return window.innerWidth <= 991;
    };

    /* ---------- Sidebar toggle (desktop collapse / mobile off-canvas) ---------- */
    function toggleSidebar() {
      if (isMobile()) {
        wrapper.classList.toggle("sidebar-mobile-open");
      } else {
        wrapper.classList.toggle("sidebar-collapsed");
      }
    }

    if (sidebarToggleBtn) {
      sidebarToggleBtn.addEventListener("click", function (e) {
        e.stopPropagation();
        toggleSidebar();
      });
    }

    if (sidebarOverlay) {
      sidebarOverlay.addEventListener("click", function () {
        wrapper.classList.remove("sidebar-mobile-open");
      });
    }

    /* Close mobile sidebar on resize to desktop */
    window.addEventListener("resize", function () {
      if (!isMobile()) {
        wrapper.classList.remove("sidebar-mobile-open");
      }
    });

    /* ---------- Accordion submenu behavior ---------- */
    var navItemsWithChildren = document.querySelectorAll(".sims-nav-item.has-submenu > .sims-nav-link");

    navItemsWithChildren.forEach(function (link) {
      link.addEventListener("click", function (e) {
        e.preventDefault();
        var parentItem = link.closest(".sims-nav-item");
        var isOpen = parentItem.classList.contains("open");

        /* Close all other open submenus (accordion behavior) */
        document.querySelectorAll(".sims-nav-item.open").forEach(function (item) {
          if (item !== parentItem) {
            item.classList.remove("open");
          }
        });

        /* Toggle current submenu */
        if (isOpen) {
          parentItem.classList.remove("open");
        } else {
          parentItem.classList.add("open");
        }
      });
    });

    /* ---------- Profile dropdown ---------- */
    if (profileTrigger && profileMenu) {
      profileTrigger.addEventListener("click", function (e) {
        e.stopPropagation();
        profileMenu.classList.toggle("open");
      });

      document.addEventListener("click", function (e) {
        if (!profileMenu.contains(e.target)) {
          profileMenu.classList.remove("open");
        }
      });

      document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") {
          profileMenu.classList.remove("open");
        }
      });
    }



    /* ---------- Persist sidebar collapsed state (optional, session-based) ---------- */
    try {
      var savedState = sessionStorage.getItem("simsSidebarCollapsed");
      if (savedState === "1" && !isMobile()) {
        wrapper.classList.add("sidebar-collapsed");
      }
    } catch (err) {
      /* sessionStorage unavailable - ignore */
    }

    if (sidebarToggleBtn) {
      sidebarToggleBtn.addEventListener("click", function () {
        try {
          if (!isMobile()) {
            sessionStorage.setItem(
              "simsSidebarCollapsed",
              wrapper.classList.contains("sidebar-collapsed") ? "1" : "0"
            );
          }
        } catch (err) {
          /* ignore */
        }
      });
    }

    /* ---------- Auto-highlight current page in sidebar ---------- */
    var currentPath = window.location.pathname;
    // Get just the filename (e.g. "admin-dashboard.aspx")
    var currentPage = currentPath.substring(currentPath.lastIndexOf('/') + 1).toLowerCase();

    if (currentPage) {
      // Find all sidebar links
      var allLinks = document.querySelectorAll('.sims-sidebar-nav a');
      
      allLinks.forEach(function(link) {
        var href = link.getAttribute('href');
        if (href && href.toLowerCase() === currentPage) {
          // If it's a submenu link
          if (link.classList.contains('sims-submenu-link')) {
            var submenuItem = link.closest('.sims-submenu-item');
            if (submenuItem) submenuItem.classList.add('active');
            
            var parentItem = link.closest('.sims-nav-item.has-submenu');
            if (parentItem) {
              parentItem.classList.add('active');
              parentItem.classList.add('open');
            }
          } 
          // If it's a top-level link
          else if (link.classList.contains('sims-nav-link')) {
            var navItem = link.closest('.sims-nav-item');
            if (navItem) navItem.classList.add('active');
          }
        }
      });
    }

  });
})();

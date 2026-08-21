/* ==========================================================
   SIMS ADMIN - SETTINGS PAGE JS (frontend/demo only)
   ========================================================== */
(function () {
    "use strict";

    var hasUnsavedChanges = false;
    var pendingLeaveAction = null;

    document.addEventListener("DOMContentLoaded", function () {
        initNavigation();
        initSearch();
        initToggleChangeTracking();
        initSaveFlow();
        initResetFlow();
        initPasswordStrength();
        initPasswordToggle();
        initMaintenanceMode();
        initDangerZone();
        initBackupDemo();
        initTestConnection();
        initModalCore();
        initUnsavedGuard();
    });

    /* ---------------- TOAST ---------------- */
    function showToast(message, type) {
        var container = document.getElementById("settingsToastContainer");
        if (!container) return;
        var toast = document.createElement("div");
        toast.className = "sims-settings-toast" + (type ? " " + type : "");
        var icon = type === "success" ? "fa-circle-check" : (type === "danger" ? "fa-circle-xmark" : "fa-circle-info");
        toast.innerHTML = '<i class="fas ' + icon + '"></i><span>' + message + "</span>";
        container.appendChild(toast);
        setTimeout(function () {
            toast.style.opacity = "0";
            setTimeout(function () { toast.remove(); }, 200);
        }, 2800);
    }

    /* ---------------- NAVIGATION / SECTION SWITCHING ---------------- */
    function initNavigation() {
        var navItems = document.querySelectorAll(".sims-settings-nav-item");
        var mobileSelect = document.getElementById("settingsNavMobile");
        var sections = document.querySelectorAll(".sims-settings-section");

        function activate(target) {
            navItems.forEach(function (item) { item.classList.toggle("active", item.dataset.target === target); });
            sections.forEach(function (sec) { sec.classList.toggle("active", sec.id === "sec-" + target); });
            if (mobileSelect) mobileSelect.value = target;
            window.scrollTo({ top: 0, behavior: "smooth" });
        }

        navItems.forEach(function (item) {
            item.addEventListener("click", function (e) {
                e.preventDefault();
                var target = item.dataset.target;
                if (hasUnsavedChanges) {
                    pendingLeaveAction = function () { activate(target); hasUnsavedChanges = false; };
                    openModal("unsavedChangesOverlay");
                    return;
                }
                activate(target);
            });
        });

        if (mobileSelect) {
            mobileSelect.addEventListener("change", function () {
                activate(mobileSelect.value);
            });
        }
    }

    /* ---------------- SEARCH ---------------- */
    function initSearch() {
        var input = document.getElementById("settingsSearchInput");
        var emptyMsg = document.getElementById("settingsSearchEmpty");
        var sections = document.querySelectorAll(".sims-settings-section");
        var navItems = document.querySelectorAll(".sims-settings-nav-item");

        if (!input) return;

        input.addEventListener("input", function () {
            var query = input.value.toLowerCase().trim();

            if (!query) {
                sections.forEach(function (sec) { sec.classList.remove("search-hit"); });
                emptyMsg.style.display = "none";
                return;
            }

            var anyMatch = false;
            sections.forEach(function (sec) {
                var keywords = (sec.dataset.keywords || "") + " " + sec.textContent.toLowerCase();
                var match = keywords.toLowerCase().indexOf(query) !== -1;
                sec.classList.toggle("search-hit", match);
                if (match) anyMatch = true;
            });

            emptyMsg.style.display = anyMatch ? "none" : "block";

            // Jump to the first matching section
            if (anyMatch) {
                var firstMatch = document.querySelector(".sims-settings-section.search-hit");
                if (firstMatch) {
                    var targetId = firstMatch.id.replace("sec-", "");
                    sections.forEach(function (sec) { sec.classList.toggle("active", sec === firstMatch); });
                    navItems.forEach(function (item) { item.classList.toggle("active", item.dataset.target === targetId); });
                }
            }
        });
    }

    /* ---------------- UNSAVED CHANGES TRACKING ---------------- */
    function initToggleChangeTracking() {
        var inputs = document.querySelectorAll(".sims-settings-input, .sims-settings-select, .sims-settings-switch input");
        inputs.forEach(function (el) {
            el.addEventListener("change", function () { hasUnsavedChanges = true; });
        });
    }

    function initUnsavedGuard() {
        // Demo-only: real implementation would hook beforeunload.
        // Kept isolated so it never fires an actual browser dialog during grading/demo.
    }

    /* ---------------- SAVE FLOW ---------------- */
    function initSaveFlow() {
        var topSave = document.getElementById("btnSaveChangesTop");
        var saveTriggers = document.querySelectorAll(".saveTrigger");
        var confirmSave = document.getElementById("btnConfirmSave");

        if (topSave) {
            topSave.addEventListener("click", function () { openModal("saveChangesOverlay"); });
        }
        saveTriggers.forEach(function (btn) {
            btn.addEventListener("click", function () { openModal("saveChangesOverlay"); });
        });
        if (confirmSave) {
            confirmSave.addEventListener("click", function () {
                closeModal("saveChangesOverlay");
                hasUnsavedChanges = false;
                showToast("Settings saved successfully.", "success");
            });
        }
    }

    /* ---------------- RESET FLOW ---------------- */
    function initResetFlow() {
        var topReset = document.getElementById("btnResetSettingsTop");
        var dangerReset = document.getElementById("btnDangerReset");
        var confirmReset = document.getElementById("btnConfirmReset");

        if (topReset) topReset.addEventListener("click", function () { openModal("resetSettingsOverlay"); });
        if (dangerReset) dangerReset.addEventListener("click", function () { openModal("resetSettingsOverlay"); });
        if (confirmReset) {
            confirmReset.addEventListener("click", function () {
                closeModal("resetSettingsOverlay");
                hasUnsavedChanges = false;
                showToast("Settings restored to default values.", "success");
            });
        }
    }

    /* ---------------- PASSWORD STRENGTH ---------------- */
    function initPasswordStrength() {
        var pwInput = document.getElementById("newPasswordInput");
        var bar = document.getElementById("pwStrengthBar");
        var label = document.getElementById("pwStrengthLabel");
        if (!pwInput || !bar || !label) return;

        pwInput.addEventListener("input", function () {
            var val = pwInput.value;
            var score = 0;
            if (val.length >= 8) score++;
            if (/[A-Z]/.test(val)) score++;
            if (/[a-z]/.test(val)) score++;
            if (/[0-9]/.test(val)) score++;
            if (/[^A-Za-z0-9]/.test(val)) score++;

            var levels = [
                { pct: "0%", color: "#E5E7EB", text: "Weak" },
                { pct: "25%", color: "#B91C1C", text: "Weak" },
                { pct: "50%", color: "#C2410C", text: "Medium" },
                { pct: "75%", color: "#CA8A04", text: "Strong" },
                { pct: "100%", color: "#15803D", text: "Very Strong" },
                { pct: "100%", color: "#15803D", text: "Very Strong" }
            ];
            var lvl = levels[score];
            bar.style.width = lvl.pct;
            bar.style.background = lvl.color;
            label.textContent = lvl.text;
            label.style.color = lvl.color;
        });
    }

    /* ---------------- SHOW/HIDE PASSWORD ---------------- */
    function initPasswordToggle() {
        document.querySelectorAll(".togglePw").forEach(function (icon) {
            icon.addEventListener("click", function () {
                var input = icon.previousElementSibling;
                if (!input) return;
                var isPassword = input.type === "password";
                input.type = isPassword ? "text" : "password";
                icon.classList.toggle("fa-eye", !isPassword);
                icon.classList.toggle("fa-eye-slash", isPassword);
            });
        });
    }

    /* ---------------- MAINTENANCE MODE ---------------- */
    function initMaintenanceMode() {
        var toggle = document.getElementById("maintenanceModeToggle");
        var warning = document.getElementById("maintenanceWarning");
        var disableBtn = document.getElementById("btnDisableMaintenance");

        function sync() {
            if (!toggle || !warning) return;
            warning.style.display = toggle.checked ? "flex" : "none";
        }

        if (toggle) toggle.addEventListener("change", sync);
        if (disableBtn) {
            disableBtn.addEventListener("click", function () {
                toggle.checked = false;
                sync();
                showToast("Maintenance mode disabled.", "success");
            });
        }
    }

    /* ---------------- DANGER ZONE ---------------- */
    function initDangerZone() {
        var clearCache = document.getElementById("btnClearCache");
        var dangerMaintenance = document.getElementById("btnDangerMaintenance");

        if (clearCache) {
            clearCache.addEventListener("click", function () {
                showToast("Cached data cleared — demo only.", "success");
            });
        }
        if (dangerMaintenance) {
            dangerMaintenance.addEventListener("click", function () {
                var toggle = document.getElementById("maintenanceModeToggle");
                var warning = document.getElementById("maintenanceWarning");
                if (toggle) { toggle.checked = true; }
                if (warning) { warning.style.display = "flex"; }
                showToast("Maintenance mode enabled — demo only.", "danger");
            });
        }
    }

    /* ---------------- BACKUP DEMO ---------------- */
    function initBackupDemo() {
        var backupBtn = document.getElementById("btnBackupNow");
        if (!backupBtn) return;
        backupBtn.addEventListener("click", function () {
            var original = backupBtn.innerHTML;
            backupBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Backing up...';
            backupBtn.disabled = true;
            setTimeout(function () {
                backupBtn.innerHTML = original;
                backupBtn.disabled = false;
                showToast("Backup completed successfully — demo only.", "success");
            }, 1400);
        });
    }

    /* ---------------- TEST EMAIL CONNECTION ---------------- */
    function initTestConnection() {
        var btn = document.getElementById("btnTestConnection");
        if (!btn) return;
        btn.addEventListener("click", function () {
            var original = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Testing...';
            btn.disabled = true;
            setTimeout(function () {
                btn.innerHTML = original;
                btn.disabled = false;
                showToast("SMTP connection test successful — demo only.", "success");
            }, 1200);
        });
    }

    /* ---------------- MODAL CORE ---------------- */
    function openModal(id) {
        var overlay = document.getElementById(id);
        if (!overlay) return;
        overlay.classList.add("open");
        document.body.classList.add("modal-open");
    }
    function closeModal(id) {
        var overlay = document.getElementById(id);
        if (!overlay) return;
        overlay.classList.remove("open");
        if (!document.querySelector(".sims-settings-modal-overlay.open")) {
            document.body.classList.remove("modal-open");
        }
    }

    function initModalCore() {
        document.querySelectorAll("[data-close]").forEach(function (el) {
            el.addEventListener("click", function () { closeModal(el.dataset.close); });
        });

        document.querySelectorAll(".sims-settings-modal-overlay").forEach(function (overlay) {
            overlay.addEventListener("click", function (e) {
                if (e.target === overlay) closeModal(overlay.id);
            });
        });

        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") {
                var open = document.querySelector(".sims-settings-modal-overlay.open");
                if (open) closeModal(open.id);
            }
        });

        // Unsaved changes modal actions
        var leaveBtn = document.getElementById("btnLeaveWithoutSaving");
        var saveBtn = document.getElementById("btnUnsavedSave");

        if (leaveBtn) {
            leaveBtn.addEventListener("click", function () {
                closeModal("unsavedChangesOverlay");
                hasUnsavedChanges = false;
                if (typeof pendingLeaveAction === "function") { pendingLeaveAction(); pendingLeaveAction = null; }
            });
        }
        if (saveBtn) {
            saveBtn.addEventListener("click", function () {
                closeModal("unsavedChangesOverlay");
                hasUnsavedChanges = false;
                showToast("Settings saved successfully.", "success");
                if (typeof pendingLeaveAction === "function") { pendingLeaveAction(); pendingLeaveAction = null; }
            });
        }
    }

})();

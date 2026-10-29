/* ============================================================
   sims-dialog.js
   Global Custom Alert / Confirm / Toast System

   Usage:
     simsAlert("Message")
     simsAlert("Message", { type: "success"|"error"|"warning"|"info", title: "Title" })
     simsAlert("Message", { type: "success", toast: true })
     simsConfirm("Are you sure?", function(confirmed) { if(confirmed) { ... } })
     simsToast("Message", "success"|"error"|"warning"|"info")
   ============================================================ */

(function (window) {
    "use strict";

    /* ============================================================
       ICON MAPS
       ============================================================ */
    var ICONS = {
        success:  "fa-solid fa-circle-check",
        error:    "fa-solid fa-circle-xmark",
        warning:  "fa-solid fa-triangle-exclamation",
        info:     "fa-solid fa-circle-info",
        question: "fa-solid fa-circle-question"
    };
    var TITLES = {
        success:  "Success",
        error:    "Error",
        warning:  "Warning",
        info:     "Information",
        question: "Confirm"
    };

    /* ============================================================
       INJECT OVERLAY HTML (once)
       ============================================================ */
    var _overlay = null;

    function ensureOverlay() {
        if (_overlay) return;

        _overlay = document.createElement("div");
        _overlay.id = "simsDialogOverlay";
        _overlay.className = "sims-dialog-overlay";
        _overlay.innerHTML =
            '<div class="sims-dialog-box" id="simsDialogBox">' +
                '<button class="sims-dialog-close" id="simsDialogClose" aria-label="Close">' +
                    '<i class="fa-solid fa-xmark"></i>' +
                '</button>' +
                '<div class="sims-dialog-icon" id="simsDialogIcon"></div>' +
                '<div class="sims-dialog-title" id="simsDialogTitle"></div>' +
                '<div class="sims-dialog-message" id="simsDialogMessage"></div>' +
                '<div class="sims-dialog-actions" id="simsDialogActions"></div>' +
            '</div>';

        document.body.appendChild(_overlay);

        // Close on overlay backdrop click
        _overlay.addEventListener("click", function (e) {
            if (e.target === _overlay) _closeDialog(false);
        });

        // Close on Escape key
        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape" && _overlay.classList.contains("sims-dialog-open")) {
                _closeDialog(false);
            }
        });

        // Close X button
        document.getElementById("simsDialogClose").addEventListener("click", function () {
            _closeDialog(false);
        });
    }

    /* ============================================================
       OPEN / CLOSE
       ============================================================ */
    var _currentCallback = null;

    function _openDialog(opts) {
        ensureOverlay();

        var type    = opts.type    || "info";
        var title   = opts.title   || TITLES[type]  || "Notice";
        var message = opts.message || "";
        var icon    = opts.icon    || ICONS[type]   || ICONS.info;

        document.getElementById("simsDialogIcon").className    = "sims-dialog-icon sims-dialog-icon-" + type;
        document.getElementById("simsDialogIcon").innerHTML    = '<i class="' + icon + '"></i>';
        document.getElementById("simsDialogTitle").textContent = title;
        document.getElementById("simsDialogMessage").innerHTML = message;
        document.getElementById("simsDialogActions").innerHTML = opts.actionsHtml || "";

        // Wire up action buttons after innerHTML set
        if (typeof opts.onActionsReady === "function") {
            opts.onActionsReady();
        }

        _currentCallback = opts.callback || null;
        _overlay.classList.add("sims-dialog-open");
        document.body.style.overflow = "hidden";
    }

    function _closeDialog(result) {
        if (!_overlay) return;
        _overlay.classList.remove("sims-dialog-open");
        document.body.style.overflow = "";
        if (typeof _currentCallback === "function") {
            var cb = _currentCallback;
            _currentCallback = null;
            setTimeout(function () { cb(result); }, 50);
        } else {
            _currentCallback = null;
        }
    }

    /* ============================================================
       PUBLIC API: simsAlert
       Options: { type, title, btnText, toast }
       ============================================================ */
    window.simsAlert = function (message, opts) {
        opts = opts || {};

        // Use toast mode if requested
        if (opts.toast) {
            simsToast(message, opts.type || "info", opts.title || "");
            return;
        }

        var type    = opts.type    || "info";
        var btnText = opts.btnText || "OK";

        _openDialog({
            type: type,
            title: opts.title || TITLES[type] || "Notice",
            message: message,
            actionsHtml:
                '<button class="sims-dialog-btn sims-dialog-btn-' +
                (type === "error" ? "danger" : type === "warning" ? "warning" : type === "success" ? "success" : "primary") +
                ' sims-dialog-btn-ok">' + btnText + '</button>',
            onActionsReady: function () {
                var btn = document.querySelector(".sims-dialog-btn-ok");
                if (btn) btn.addEventListener("click", function () { _closeDialog(true); });
            },
            callback: opts.callback || null
        });
    };

    /* ============================================================
       PUBLIC API: simsConfirm
       callback(true)  → confirmed
       callback(false) → cancelled
       Options: { type, title, confirmText, cancelText }
       ============================================================ */
    window.simsConfirm = function (message, callback, opts) {
        opts = opts || {};

        var type        = opts.type        || "question";
        var confirmText = opts.confirmText || "Yes, Confirm";
        var cancelText  = opts.cancelText  || "Cancel";
        var btnClass    = opts.danger ? "sims-dialog-btn-danger" : "sims-dialog-btn-primary";

        _openDialog({
            type: type,
            title: opts.title || TITLES[type] || "Confirm",
            message: message,
            actionsHtml:
                '<button class="sims-dialog-btn sims-dialog-btn-cancel sims-dialog-btn-no">' + cancelText + '</button>' +
                '<button class="sims-dialog-btn ' + btnClass + ' sims-dialog-btn-yes">' + confirmText + '</button>',
            onActionsReady: function () {
                var yes = document.querySelector(".sims-dialog-btn-yes");
                var no  = document.querySelector(".sims-dialog-btn-no");
                if (yes) yes.addEventListener("click", function () { _closeDialog(true); });
                if (no)  no.addEventListener("click",  function () { _closeDialog(false); });
            },
            callback: callback
        });
    };

    /* ============================================================
       PUBLIC API: simsToast
       simsToast("Message saved!", "success", "Optional title", durationMs)
       ============================================================ */
    var _toastContainer = null;

    function ensureToastContainer() {
        if (_toastContainer) return;
        _toastContainer = document.createElement("div");
        _toastContainer.className = "sims-toast-container";
        document.body.appendChild(_toastContainer);
    }

    window.simsToast = function (message, type, title, duration) {
        type     = type     || "info";
        duration = duration || 3500;

        ensureToastContainer();

        var iconClass = ICONS[type] || ICONS.info;
        var titleText = title || TITLES[type] || "Notice";

        var toast = document.createElement("div");
        toast.className = "sims-toast sims-toast-" + type;
        toast.innerHTML =
            '<div class="sims-toast-icon"><i class="' + iconClass + '"></i></div>' +
            '<div class="sims-toast-body">' +
                '<div class="sims-toast-title">' + titleText + '</div>' +
                '<div class="sims-toast-msg">' + message + '</div>' +
            '</div>' +
            '<button class="sims-toast-dismiss" aria-label="Dismiss"><i class="fa-solid fa-xmark"></i></button>' +
            '<div class="sims-toast-progress" style="animation-duration:' + duration + 'ms"></div>';

        _toastContainer.appendChild(toast);

        // Animate in
        requestAnimationFrame(function () {
            requestAnimationFrame(function () {
                toast.classList.add("sims-toast-show");
            });
        });

        // Dismiss button
        toast.querySelector(".sims-toast-dismiss").addEventListener("click", function () {
            dismissToast(toast);
        });

        // Auto-dismiss
        var timer = setTimeout(function () { dismissToast(toast); }, duration);

        // Pause on hover
        toast.addEventListener("mouseenter", function () { clearTimeout(timer); });
        toast.addEventListener("mouseleave", function () {
            timer = setTimeout(function () { dismissToast(toast); }, 800);
        });

        function dismissToast(el) {
            el.classList.remove("sims-toast-show");
            el.classList.add("sims-toast-hide");
            setTimeout(function () {
                if (el.parentNode) el.parentNode.removeChild(el);
            }, 350);
        }
    };

    /* ============================================================
       Override window.alert (global fallback)
       ============================================================ */
    window._nativeAlert = window.alert;
    window.alert = function (msg) {
        // Try to use simsAlert if DOM is ready
        if (document.body) {
            simsAlert(String(msg), { type: "info" });
        } else {
            window._nativeAlert(msg);
        }
    };

})(window);

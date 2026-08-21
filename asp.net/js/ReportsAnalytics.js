/* ==========================================================================
   SIMS - Reports & Analytics Page JavaScript
   Frontend/demo only. No backend calls.
   ========================================================================== */

(function () {
    "use strict";

    document.addEventListener("DOMContentLoaded", function () {
        initCharts();
        initFilters();
        initExportMenu();
        initModals();
        initReportActions();
        initEmptyStateDemo();
    });

    /* ---------------------------------------------------------------------
       TOAST NOTIFICATIONS
    --------------------------------------------------------------------- */
    function showToast(message, type) {
        var container = document.getElementById("simsAnalyticsToastContainer");
        if (!container) return;

        var toast = document.createElement("div");
        toast.className = "sims-analytics-toast sims-toast-" + (type || "info");

        var icon = type === "success" ? "fa-solid fa-circle-check" : "fa-solid fa-circle-info";
        toast.innerHTML = '<i class="' + icon + '"></i><span>' + message + "</span>";

        container.appendChild(toast);

        setTimeout(function () {
            toast.style.opacity = "0";
            toast.style.transition = "opacity .25s ease";
            setTimeout(function () {
                toast.remove();
            }, 250);
        }, 2800);
    }

    /* ---------------------------------------------------------------------
       FILTERS
    --------------------------------------------------------------------- */
    function initFilters() {
        var applyBtn = document.getElementById("btnApplyFilters");
        var resetBtn = document.getElementById("btnResetFilters");

        if (applyBtn) {
            applyBtn.addEventListener("click", function () {
                showToast("Filters applied. Dashboard data refreshed.", "success");
                refreshChartsDemo();
            });
        }

        if (resetBtn) {
            resetBtn.addEventListener("click", function () {
                document.getElementById("filterDateRange").selectedIndex = 2;
                document.getElementById("filterCategory").selectedIndex = 0;
                document.getElementById("filterCompany").selectedIndex = 0;
                document.getElementById("filterStatus").selectedIndex = 0;
                document.getElementById("filterFromDate").value = "";
                document.getElementById("filterToDate").value = "";
                showToast("Filters reset to default.", "info");
            });
        }
    }

    /* Demo-only: slightly perturb chart data to simulate a data refresh */
    function refreshChartsDemo() {
        Object.keys(window.simsAnalyticsCharts || {}).forEach(function (key) {
            var chart = window.simsAnalyticsCharts[key];
            if (!chart || !chart.data || !chart.data.datasets) return;
            chart.data.datasets.forEach(function (ds) {
                if (!Array.isArray(ds.data)) return;
                ds.data = ds.data.map(function (v) {
                    var variance = v * (Math.random() * 0.1 - 0.05);
                    return Math.max(0, Math.round(v + variance));
                });
            });
            chart.update();
        });
    }

    /* ---------------------------------------------------------------------
       EXPORT DROPDOWN
    --------------------------------------------------------------------- */
    function initExportMenu() {
        var toggle = document.getElementById("btnExportToggle");
        var menu = document.getElementById("exportMenu");
        if (!toggle || !menu) return;

        toggle.addEventListener("click", function (e) {
            e.stopPropagation();
            menu.classList.toggle("sims-open");
        });

        document.addEventListener("click", function (e) {
            if (!menu.contains(e.target) && e.target !== toggle) {
                menu.classList.remove("sims-open");
            }
        });

        document.querySelectorAll(".sims-analytics-export-item").forEach(function (item) {
            item.addEventListener("click", function (e) {
                e.preventDefault();
                var type = item.getAttribute("data-export");
                menu.classList.remove("sims-open");
                showToast("Export started: " + friendlyExportName(type) + " (demo).", "success");
            });
        });
    }

    function friendlyExportName(type) {
        var map = {
            "pdf-dashboard": "Dashboard PDF",
            "excel": "Excel Workbook",
            "csv": "CSV File",
            "current": "Current Report",
            "selected": "Selected Data"
        };
        return map[type] || "Report";
    }

    /* ---------------------------------------------------------------------
       MODALS (Preview + Schedule)
    --------------------------------------------------------------------- */
    function initModals() {
        var openers = {
            "btnGenerateReport": "previewModalOverlay",
            "btnGenerateReport2": "previewModalOverlay",
            "btnPreviewReport": "previewModalOverlay",
            "btnScheduleReport": "scheduleModalOverlay"
        };

        Object.keys(openers).forEach(function (btnId) {
            var btn = document.getElementById(btnId);
            if (btn) {
                btn.addEventListener("click", function () {
                    openModal(openers[btnId]);
                });
            }
        });

        document.querySelectorAll("[data-close]").forEach(function (btn) {
            btn.addEventListener("click", function () {
                closeModal(btn.getAttribute("data-close"));
            });
        });

        document.querySelectorAll(".sims-analytics-modal-overlay").forEach(function (overlay) {
            overlay.addEventListener("click", function (e) {
                if (e.target === overlay) {
                    closeModal(overlay.id);
                }
            });
        });

        document.addEventListener("keydown", function (e) {
            if (e.key === "Escape") {
                document.querySelectorAll(".sims-analytics-modal-overlay.sims-open").forEach(function (overlay) {
                    closeModal(overlay.id);
                });
            }
        });

        var printBtn = document.getElementById("btnPrintReport");
        if (printBtn) {
            printBtn.addEventListener("click", function () {
                showToast("Preparing report for print (demo).", "info");
                window.print();
            });
        }

        var downloadPdfBtn = document.getElementById("btnDownloadPdf");
        if (downloadPdfBtn) {
            downloadPdfBtn.addEventListener("click", function () {
                showToast("Downloading report as PDF (demo).", "success");
            });
        }

        var exportExcelModalBtn = document.getElementById("btnExportExcelModal");
        if (exportExcelModalBtn) {
            exportExcelModalBtn.addEventListener("click", function () {
                showToast("Exporting report as Excel (demo).", "success");
            });
        }

        var confirmScheduleBtn = document.getElementById("btnConfirmSchedule");
        if (confirmScheduleBtn) {
            confirmScheduleBtn.addEventListener("click", function () {
                showToast("Report scheduled successfully (demo).", "success");
                closeModal("scheduleModalOverlay");
            });
        }
    }

    function openModal(overlayId) {
        var overlay = document.getElementById(overlayId);
        if (!overlay) return;
        overlay.classList.add("sims-open");
        document.body.classList.add("modal-open");

        // Render the preview chart once, first time the preview modal opens
        if (overlayId === "previewModalOverlay") {
            renderPreviewChartIfNeeded();
        }
    }

    function closeModal(overlayId) {
        var overlay = document.getElementById(overlayId);
        if (!overlay) return;
        overlay.classList.remove("sims-open");

        var anyOpen = document.querySelector(".sims-analytics-modal-overlay.sims-open");
        if (!anyOpen) {
            document.body.classList.remove("modal-open");
        }
    }

    /* ---------------------------------------------------------------------
       REPORT ROW ACTIONS (Recent Reports table) - demo only
    --------------------------------------------------------------------- */
    function initReportActions() {
        document.querySelectorAll(".sims-analytics-row-actions .sims-icon-btn").forEach(function (btn) {
            btn.addEventListener("click", function () {
                var title = btn.getAttribute("title");
                if (title === "View") {
                    openModal("previewModalOverlay");
                } else if (title === "Download") {
                    showToast("Downloading report (demo).", "success");
                } else if (title === "Delete") {
                    var row = btn.closest("tr");
                    if (row) {
                        row.style.opacity = "0.4";
                        showToast("Report removed (demo).", "info");
                    }
                }
            });
        });
    }

    /* ---------------------------------------------------------------------
       EMPTY STATE DEMO (Reset Filters button inside empty state)
    --------------------------------------------------------------------- */
    function initEmptyStateDemo() {
        var btn = document.getElementById("btnEmptyResetFilters");
        if (btn) {
            btn.addEventListener("click", function () {
                document.getElementById("simsAnalyticsEmptyState").style.display = "none";
                showToast("Filters reset.", "info");
            });
        }
    }

    /* ---------------------------------------------------------------------
       CHART.JS CHARTS
    --------------------------------------------------------------------- */
    function initCharts() {
        if (typeof Chart === "undefined") {
            console.warn("Chart.js not loaded; charts will not render.");
            return;
        }

        window.simsAnalyticsCharts = window.simsAnalyticsCharts || {};

        Chart.defaults.font.family = "'Inter', 'Poppins', sans-serif";
        Chart.defaults.color = "#66738a";
        Chart.defaults.font.size = 11.5;

        var months = ["Mar", "Apr", "May", "Jun", "Jul", "Aug"];

        /* 4. Application Trend (multi-series bar/line) */
        var appTrendCtx = document.getElementById("chartApplicationTrend");
        if (appTrendCtx) {
            window.simsAnalyticsCharts.appTrend = new Chart(appTrendCtx, {
                type: "bar",
                data: {
                    labels: months,
                    datasets: [
                        { label: "Total Applications", data: [420, 510, 580, 620, 780, 940], backgroundColor: "#2f5df0", borderRadius: 4 },
                        { label: "Selected", data: [140, 165, 190, 205, 260, 310], backgroundColor: "#1f9d55", borderRadius: 4 },
                        { label: "Pending", data: [90, 95, 100, 110, 130, 150], backgroundColor: "#d9822b", borderRadius: 4 },
                        { label: "Rejected", data: [190, 250, 290, 305, 390, 480], backgroundColor: "#de4b4b", borderRadius: 4 }
                    ]
                },
                options: baseBarOptions(true)
            });
        }

        /* 5. Application Status Donut */
        var appStatusCtx = document.getElementById("chartApplicationStatus");
        if (appStatusCtx) {
            window.simsAnalyticsCharts.appStatus = new Chart(appStatusCtx, {
                type: "doughnut",
                data: {
                    labels: ["Selected", "Pending", "Rejected", "In Review"],
                    datasets: [{
                        data: [1280, 620, 1950, 0],
                        backgroundColor: ["#1f9d55", "#d9822b", "#de4b4b", "#2f5df0"],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: "68%",
                    plugins: { legend: { display: false }, tooltip: { enabled: true } }
                }
            });
        }

        /* 8. Company Industry (small bar) */
        var companyIndustryCtx = document.getElementById("chartCompanyIndustry");
        if (companyIndustryCtx) {
            window.simsAnalyticsCharts.companyIndustry = new Chart(companyIndustryCtx, {
                type: "bar",
                data: {
                    labels: ["IT & Software", "Finance", "Healthcare", "Education", "Manufacturing", "Other"],
                    datasets: [{
                        label: "Companies",
                        data: [85, 30, 22, 18, 15, 15],
                        backgroundColor: "#7c4fe0",
                        borderRadius: 4
                    }]
                },
                options: baseBarOptions(false, true)
            });
        }

        /* 9. Placement Trend */
        var placementTrendCtx = document.getElementById("chartPlacementTrend");
        if (placementTrendCtx) {
            window.simsAnalyticsCharts.placementTrend = new Chart(placementTrendCtx, {
                type: "line",
                data: {
                    labels: months,
                    datasets: [{
                        label: "Placements",
                        data: [120, 145, 160, 175, 210, 240],
                        borderColor: "#2f5df0",
                        backgroundColor: "rgba(47,93,240,.12)",
                        fill: true,
                        tension: 0.35,
                        pointRadius: 4,
                        pointBackgroundColor: "#2f5df0"
                    }]
                },
                options: baseBarOptions(false)
            });
        }

        /* 12. Student Performance donut */
        var studentPerfCtx = document.getElementById("chartStudentPerformance");
        if (studentPerfCtx) {
            window.simsAnalyticsCharts.studentPerf = new Chart(studentPerfCtx, {
                type: "doughnut",
                data: {
                    labels: ["High Performing", "Average Performing", "Needs Improvement", "Not Participated"],
                    datasets: [{
                        data: [450, 1280, 320, 400],
                        backgroundColor: ["#1f9d55", "#2f5df0", "#d9822b", "#9aa5b5"],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: "62%",
                    plugins: { legend: { display: false } }
                }
            });
        }

        /* 13. Interview Status donut */
        var interviewCtx = document.getElementById("chartInterviewStatus");
        if (interviewCtx) {
            window.simsAnalyticsCharts.interviewStatus = new Chart(interviewCtx, {
                type: "doughnut",
                data: {
                    labels: ["Scheduled", "Completed", "Cancelled", "Pending"],
                    datasets: [{
                        data: [1620, 1420, 120, 310],
                        backgroundColor: ["#2f5df0", "#1f9d55", "#de4b4b", "#d9822b"],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: "62%",
                    plugins: { legend: { position: "bottom", labels: { boxWidth: 8, padding: 12 } } }
                }
            });
        }

        /* 14. Certificate Trend */
        var certTrendCtx = document.getElementById("chartCertificateTrend");
        if (certTrendCtx) {
            window.simsAnalyticsCharts.certTrend = new Chart(certTrendCtx, {
                type: "bar",
                data: {
                    labels: months,
                    datasets: [{
                        label: "Certificates Issued",
                        data: [110, 130, 145, 160, 195, 210],
                        backgroundColor: "#158a8a",
                        borderRadius: 4
                    }]
                },
                options: baseBarOptions(false, true)
            });
        }

        /* 16. Monthly System Performance (large multi-series) */
        var monthlyPerfCtx = document.getElementById("chartMonthlyPerformance");
        if (monthlyPerfCtx) {
            window.simsAnalyticsCharts.monthlyPerf = new Chart(monthlyPerfCtx, {
                type: "line",
                data: {
                    labels: months,
                    datasets: [
                        { label: "Students Registered", data: [180, 210, 230, 250, 300, 340], borderColor: "#2f5df0", backgroundColor: "transparent", tension: 0.3 },
                        { label: "Companies Registered", data: [10, 14, 16, 18, 22, 25], borderColor: "#7c4fe0", backgroundColor: "transparent", tension: 0.3 },
                        { label: "Internships Posted", data: [40, 48, 55, 60, 72, 85], borderColor: "#158a8a", backgroundColor: "transparent", tension: 0.3 },
                        { label: "Applications", data: [420, 510, 580, 620, 780, 940], borderColor: "#d9822b", backgroundColor: "transparent", tension: 0.3 },
                        { label: "Selections", data: [140, 165, 190, 205, 260, 310], borderColor: "#1f9d55", backgroundColor: "transparent", tension: 0.3 },
                        { label: "Placements", data: [120, 145, 160, 175, 210, 240], borderColor: "#de4b4b", backgroundColor: "transparent", tension: 0.3 }
                    ]
                },
                options: baseBarOptions(true)
            });
        }

        /* 21. Preview modal mini chart - rendered lazily on modal open */
    }

    function renderPreviewChartIfNeeded() {
        if (window.simsAnalyticsCharts && window.simsAnalyticsCharts.preview) return;
        var ctx = document.getElementById("chartPreview");
        if (!ctx || typeof Chart === "undefined") return;

        window.simsAnalyticsCharts.preview = new Chart(ctx, {
            type: "bar",
            data: {
                labels: ["Students", "Companies", "Internships", "Applications", "Selected", "Placements"],
                datasets: [{
                    label: "Overall System Report",
                    data: [2450, 185, 420, 3850, 1280, 1050],
                    backgroundColor: "#2f5df0",
                    borderRadius: 4
                }]
            },
            options: baseBarOptions(false, true)
        });
    }

    function baseBarOptions(showLegend, hideYGrid) {
        return {
            responsive: true,
            maintainAspectRatio: false,
            interaction: { mode: "index", intersect: false },
            plugins: {
                legend: {
                    display: !!showLegend,
                    position: "bottom",
                    labels: { boxWidth: 10, padding: 14 }
                },
                tooltip: {
                    backgroundColor: "#101b2c",
                    padding: 10,
                    cornerRadius: 6
                }
            },
            scales: {
                x: {
                    grid: { display: false },
                    ticks: { color: "#7c8a9d" }
                },
                y: {
                    beginAtZero: true,
                    grid: { color: hideYGrid ? "transparent" : "#eef1f6" },
                    ticks: { color: "#7c8a9d" }
                }
            }
        };
    }

})();

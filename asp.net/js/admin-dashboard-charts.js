/* =====================================================
   SIMS Admin Dashboard - Chart.js Initialisation (v2)
   ===================================================== */
(function () {
  "use strict";

  document.addEventListener("DOMContentLoaded", function () {
    initRegistrationLineChart();
    initApplicationStatusDonut();
  });

  /* ---------- 1. Line Chart: Registration Overview ---------- */
  function initRegistrationLineChart() {
    var canvas = document.getElementById("simsRegistrationChart");
    if (!canvas || typeof Chart === "undefined") return;

    var ctx = canvas.getContext("2d");

    // Create gradient fills
    var gradientPurple = ctx.createLinearGradient(0, 0, 0, 220);
    gradientPurple.addColorStop(0, "rgba(139, 92, 246, 0.25)");
    gradientPurple.addColorStop(1, "rgba(139, 92, 246, 0.0)");

    var gradientCyan = ctx.createLinearGradient(0, 0, 0, 220);
    gradientCyan.addColorStop(0, "rgba(6, 182, 212, 0.2)");
    gradientCyan.addColorStop(1, "rgba(6, 182, 212, 0.0)");

    new Chart(ctx, {
      type: "line",
      data: {
        labels: ["Mar", "Apr", "May", "Jun", "Jul", "Aug"],
        datasets: [
          {
            label: "Students",
            data: [200, 310, 360, 510, 600, 750],
            borderColor: "#8b5cf6",
            backgroundColor: gradientPurple,
            fill: true,
            tension: 0.4,
            borderWidth: 3,
            pointRadius: 4,
            pointBackgroundColor: "#8b5cf6",
            pointBorderColor: "#ffffff",
            pointBorderWidth: 2,
            pointHoverRadius: 6
          },
          {
            label: "Companies",
            data: [50, 100, 140, 180, 210, 245],
            borderColor: "#06b6d4",
            backgroundColor: gradientCyan,
            fill: true,
            tension: 0.4,
            borderWidth: 3,
            pointRadius: 4,
            pointBackgroundColor: "#06b6d4",
            pointBorderColor: "#ffffff",
            pointBorderWidth: 2,
            pointHoverRadius: 6
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        interaction: { mode: "index", intersect: false },
        plugins: {
          legend: { display: false },
          tooltip: {
            backgroundColor: "#ffffff",
            borderColor: "#e2e8f0",
            borderWidth: 1,
            padding: { top: 8, bottom: 8, left: 12, right: 14 },
            cornerRadius: 10,
            titleColor: "#1a2233",
            bodyColor: "#475569",
            titleFont: { size: 12, weight: "700", family: "Inter, sans-serif" },
            bodyFont:  { size: 12, family: "Inter, sans-serif" },
            displayColors: true,
            boxWidth: 10,
            boxHeight: 10
          }
        },
        scales: {
          x: {
            grid: { display: false },
            ticks: { color: "#94a3b8", font: { size: 11.5 } }
          },
          y: {
            beginAtZero: true,
            min: 0,
            max: 800,
            ticks: { stepSize: 200, color: "#94a3b8", font: { size: 11.5 } },
            grid: { color: "rgba(226, 232, 240, 0.6)" }
          }
        }
      }
    });
  }

  /* ---------- 2. Donut Chart: Application Status ---------- */

  /* Colour map for each segment */
  var DONUT_COLORS = {
    "Applied":     "#f59e0b",
    "Shortlisted": "#3b82f6",
    "Interview":   "#8b5cf6",
    "Selected":    "#10b981",
    "Rejected":    "#ef4444"
  };

  /* External tooltip handler — renders an HTML div OUTSIDE the canvas */
  function donutExternalTooltip(context) {
    var chart   = context.chart;
    var tooltip = context.tooltip;

    /* --- locate or create the tooltip div --- */
    var tooltipEl = chart.canvas.parentNode.querySelector(".sims-donut-tooltip");
    if (!tooltipEl) {
      tooltipEl = document.createElement("div");
      tooltipEl.className = "sims-donut-tooltip";
      chart.canvas.parentNode.appendChild(tooltipEl);
    }

    /* --- hide when no items --- */
    if (tooltip.opacity === 0) {
      tooltipEl.style.opacity = "0";
      tooltipEl.style.pointerEvents = "none";
      return;
    }

    /* --- build content --- */
    var item  = tooltip.dataPoints[0];
    var label = item.label;
    var val   = item.raw;
    var total = 2845;
    var pct   = ((val / total) * 100).toFixed(1);
    var color = DONUT_COLORS[label] || "#64748b";

    tooltipEl.innerHTML =
      '<div class="sims-dtt-label">' +
        '<span class="sims-dtt-dot" style="background:' + color + '"></span>' +
        label +
      '</div>' +
      '<div class="sims-dtt-val">' + val.toLocaleString() + '<span class="sims-dtt-pct"> (' + pct + '%)</span></div>';

    /* --- position: centre the tooltip over the hovered arc segment,
         but keep it inside the card by clamping --- */
    var canvasRect = chart.canvas.getBoundingClientRect();
    var parentRect = chart.canvas.parentNode.getBoundingClientRect();

    /* Use Chart.js tooltip x/y (relative to canvas) */
    var left = tooltip.caretX;
    var top  = tooltip.caretY;

    tooltipEl.style.opacity        = "1";
    tooltipEl.style.pointerEvents  = "none";
    tooltipEl.style.position       = "absolute";
    tooltipEl.style.left           = left + "px";
    tooltipEl.style.top            = top  + "px";
    tooltipEl.style.transform      = "translate(-50%, calc(-100% - 10px))";
  }

  function initApplicationStatusDonut() {
    var canvas = document.getElementById("simsApplicationStatusDonut");
    if (!canvas || typeof Chart === "undefined") return;

    /* The parent of the canvas must be position:relative for the tooltip div */
    canvas.parentNode.style.position = "relative";

    var ctx = canvas.getContext("2d");

    new Chart(ctx, {
      type: "doughnut",
      data: {
        labels: ["Applied", "Shortlisted", "Interview", "Selected", "Rejected"],
        datasets: [
          {
            data: [1245, 645, 485, 325, 145],
            backgroundColor: [
              "#f59e0b", // Applied
              "#3b82f6", // Shortlisted
              "#8b5cf6", // Interview
              "#10b981", // Selected
              "#ef4444"  // Rejected
            ],
            borderWidth: 3,
            borderColor: "#ffffff",
            hoverOffset: 8
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: "68%",
        plugins: {
          legend: { display: false },
          tooltip: {
            enabled: false,              /* disable built-in canvas tooltip */
            external: donutExternalTooltip
          }
        }
      }
    });
  }

})();

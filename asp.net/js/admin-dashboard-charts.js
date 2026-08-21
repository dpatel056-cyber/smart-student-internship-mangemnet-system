/* =====================================================
   SIMS Admin Dashboard - Chart.js Initialisation
   ===================================================== */
(function () {
  "use strict";

  document.addEventListener("DOMContentLoaded", function () {
    initApplicationsLineChart();
    initInternshipDoughnutChart();
  });

  function initApplicationsLineChart() {
    var canvas = document.getElementById("simsApplicationsChart");
    if (!canvas || typeof Chart === "undefined") return;

    var ctx = canvas.getContext("2d");

    var labels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug"];
    var applied = [180, 210, 240, 260, 300, 340, 380, 420];
    var selected = [40, 55, 60, 70, 85, 95, 110, 130];
    var rejected = [30, 35, 45, 50, 55, 60, 65, 70];
    var pending = [90, 100, 110, 120, 130, 150, 160, 175];

    var styles = getComputedStyle(document.documentElement);
    var colorBlue = styles.getPropertyValue("--sims-blue").trim() || "#2f6feb";
    var colorGreen = styles.getPropertyValue("--sims-green").trim() || "#22c55e";
    var colorRed = styles.getPropertyValue("--sims-red").trim() || "#ef4444";
    var colorAmber = styles.getPropertyValue("--sims-amber").trim() || "#f59e0b";
    var gridColor = "rgba(16, 24, 40, 0.06)";
    var textColor = styles.getPropertyValue("--sims-text-muted").trim() || "#98a2b3";

    new Chart(ctx, {
      type: "line",
      data: {
        labels: labels,
        datasets: [
          {
            label: "Applied",
            data: applied,
            borderColor: colorBlue,
            backgroundColor: hexToRgba(colorBlue, 0.08),
            fill: true,
            tension: 0.4,
            pointRadius: 3,
            pointHoverRadius: 5,
            pointBackgroundColor: colorBlue,
            borderWidth: 2
          },
          {
            label: "Selected",
            data: selected,
            borderColor: colorGreen,
            backgroundColor: hexToRgba(colorGreen, 0.08),
            fill: true,
            tension: 0.4,
            pointRadius: 3,
            pointHoverRadius: 5,
            pointBackgroundColor: colorGreen,
            borderWidth: 2
          },
          {
            label: "Rejected",
            data: rejected,
            borderColor: colorRed,
            backgroundColor: hexToRgba(colorRed, 0.08),
            fill: true,
            tension: 0.4,
            pointRadius: 3,
            pointHoverRadius: 5,
            pointBackgroundColor: colorRed,
            borderWidth: 2
          },
          {
            label: "Pending",
            data: pending,
            borderColor: colorAmber,
            backgroundColor: hexToRgba(colorAmber, 0.08),
            fill: true,
            tension: 0.4,
            pointRadius: 3,
            pointHoverRadius: 5,
            pointBackgroundColor: colorAmber,
            borderWidth: 2
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
            backgroundColor: "#1a2233",
            padding: 10,
            cornerRadius: 8,
            titleFont: { size: 12, weight: "600" },
            bodyFont: { size: 12 }
          }
        },
        scales: {
          x: {
            grid: { display: false },
            ticks: { color: textColor, font: { size: 11.5 } }
          },
          y: {
            beginAtZero: true,
            grid: { color: gridColor },
            ticks: { color: textColor, font: { size: 11.5 } }
          }
        }
      }
    });
  }

  function initInternshipDoughnutChart() {
    var canvas = document.getElementById("simsInternshipDoughnut");
    if (!canvas || typeof Chart === "undefined") return;

    var ctx = canvas.getContext("2d");

    var styles = getComputedStyle(document.documentElement);
    var colorTeal = styles.getPropertyValue("--sims-teal").trim() || "#14b8a6";
    var colorMuted = styles.getPropertyValue("--sims-text-muted").trim() || "#98a2b3";
    var colorAmber = styles.getPropertyValue("--sims-amber").trim() || "#f59e0b";

    new Chart(ctx, {
      type: "doughnut",
      data: {
        labels: ["Active Internships", "Closed Internships", "Pending Approval"],
        datasets: [
          {
            data: [92, 48, 16],
            backgroundColor: [colorTeal, colorMuted, colorAmber],
            borderWidth: 0,
            hoverOffset: 6
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: "72%",
        plugins: {
          legend: { display: false },
          tooltip: {
            backgroundColor: "#1a2233",
            padding: 10,
            cornerRadius: 8,
            titleFont: { size: 12, weight: "600" },
            bodyFont: { size: 12 }
          }
        }
      }
    });
  }

  function hexToRgba(hex, alpha) {
    hex = (hex || "").trim();
    if (!hex || hex[0] !== "#") return "rgba(47, 111, 235, " + alpha + ")";
    var r = parseInt(hex.slice(1, 3), 16);
    var g = parseInt(hex.slice(3, 5), 16);
    var b = parseInt(hex.slice(5, 7), 16);
    return "rgba(" + r + ", " + g + ", " + b + ", " + alpha + ")";
  }
})();

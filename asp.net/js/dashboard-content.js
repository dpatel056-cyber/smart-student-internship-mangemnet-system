/* =====================================================
   SIMS Admin Dashboard - Chart.js Initialization
   Requires Chart.js to be loaded on the page:
   <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>
   ===================================================== */
(function () {
  "use strict";

  document.addEventListener("DOMContentLoaded", function () {
    if (typeof Chart === "undefined") {
      console.warn("Chart.js not found. Add the Chart.js script tag to the Master Page head.");
      return;
    }

    Chart.defaults.font.family =
      "Inter, Poppins, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif";
    Chart.defaults.color = "#667085";

    /* ---------------------------------------------------
       1. APPLICATIONS OVERVIEW - Line/Area Chart
       --------------------------------------------------- */
    var appsCanvas = document.getElementById("simsApplicationsChart");
    if (appsCanvas) {
      var appsCtx = appsCanvas.getContext("2d");

      var appliedGradient = appsCtx.createLinearGradient(0, 0, 0, 280);
      appliedGradient.addColorStop(0, "rgba(47, 111, 235, 0.18)");
      appliedGradient.addColorStop(1, "rgba(47, 111, 235, 0)");

      new Chart(appsCtx, {
        type: "line",
        data: {
          labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug"],
          datasets: [
            {
              label: "Applied",
              data: [180, 220, 260, 300, 340, 380, 410, 450],
              borderColor: "#2f6feb",
              backgroundColor: appliedGradient,
              tension: 0.35,
              fill: true,
              pointRadius: 0,
              pointHoverRadius: 5,
              borderWidth: 2.5
            },
            {
              label: "Selected",
              data: [40, 55, 60, 75, 90, 95, 110, 120],
              borderColor: "#16a34a",
              backgroundColor: "transparent",
              tension: 0.35,
              fill: false,
              pointRadius: 0,
              pointHoverRadius: 5,
              borderWidth: 2.5
            },
            {
              label: "Rejected",
              data: [30, 35, 40, 38, 45, 50, 55, 60],
              borderColor: "#dc2626",
              backgroundColor: "transparent",
              tension: 0.35,
              fill: false,
              pointRadius: 0,
              pointHoverRadius: 5,
              borderWidth: 2.5
            },
            {
              label: "Pending",
              data: [60, 70, 85, 95, 100, 110, 118, 130],
              borderColor: "#d97706",
              backgroundColor: "transparent",
              tension: 0.35,
              fill: false,
              pointRadius: 0,
              pointHoverRadius: 5,
              borderWidth: 2.5
            }
          ]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          interaction: {
            mode: "index",
            intersect: false
          },
          plugins: {
            legend: {
              display: false
            },
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
              ticks: { font: { size: 11.5 } }
            },
            y: {
              beginAtZero: true,
              grid: { color: "#eef0f4" },
              ticks: { font: { size: 11.5 } },
              title: {
                display: true,
                text: "Number of Applications",
                font: { size: 11.5, weight: "600" },
                color: "#98a2b3"
              }
            }
          }
        }
      });
    }

    /* ---------------------------------------------------
       2. INTERNSHIP STATISTICS - Doughnut Chart
       --------------------------------------------------- */
    var doughnutCanvas = document.getElementById("simsInternshipDoughnut");
    if (doughnutCanvas) {
      new Chart(doughnutCanvas.getContext("2d"), {
        type: "doughnut",
        data: {
          labels: ["Active Internships", "Closed Internships", "Pending Approval"],
          datasets: [
            {
              data: [92, 48, 16],
              backgroundColor: ["#2f6feb", "#98a2b3", "#d97706"],
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
            legend: {
              display: false
            },
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
  });
})();

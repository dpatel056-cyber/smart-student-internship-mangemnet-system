(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        initApplicationOverviewChart();
        animateProgressBar();
    });

    /* ---------------------------------------------------------------
       1. DOUGHNUT CHART FOR APPLICATION OVERVIEW
    --------------------------------------------------------------- */
    function initApplicationOverviewChart() {
        var canvas = document.getElementById('applicationOverviewChart');
        if (!canvas) return;

        // Check if Chart.js is loaded
        if (typeof Chart === 'undefined') {
            console.warn('Chart.js library is not loaded.');
            return;
        }

        var ctx = canvas.getContext('2d');

        // Sample / Default Data (Matches application status counts)
        var selectedCount = parseInt(canvas.getAttribute('data-selected') || '3', 10);
        var pendingCount = parseInt(canvas.getAttribute('data-pending') || '5', 10);
        var rejectedCount = parseInt(canvas.getAttribute('data-rejected') || '4', 10);

        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Selected', 'Pending', 'Rejected'],
                datasets: [{
                    data: [selectedCount, pendingCount, rejectedCount],
                    backgroundColor: [
                        '#16A34A', // Success Green
                        '#F59E0B', // Warning Orange
                        '#EF4444'  // Danger Red
                    ],
                    borderWidth: 3,
                    borderColor: '#FFFFFF',
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            usePointStyle: true,
                            padding: 16,
                            font: {
                                family: "'Inter', sans-serif",
                                size: 12,
                                weight: '600'
                            },
                            color: '#17233D'
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                var label = context.label || '';
                                var value = context.parsed || 0;
                                var total = context.dataset.data.reduce(function (a, b) { return a + b; }, 0);
                                var percentage = Math.round((value / total) * 100);
                                return ' ' + label + ': ' + value + ' (' + percentage + '%)';
                            }
                        }
                    }
                },
                cutout: '70%'
            }
        });
    }

    /* ---------------------------------------------------------------
       2. ANIMATE PROGRESS BAR FILL
    --------------------------------------------------------------- */
    function animateProgressBar() {
        var fill = document.getElementById('profileProgressFill');
        if (fill) {
            var targetWidth = fill.getAttribute('data-percentage') || '85%';
            setTimeout(function () {
                fill.style.width = targetWidth;
            }, 200);
        }
    }

})();

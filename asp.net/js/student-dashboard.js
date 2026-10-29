(function () {
    'use strict';

    document.addEventListener('DOMContentLoaded', function () {
        animateProgressBar();
    });

    function animateProgressBar() {
        var fill = document.getElementById('profileProgressFill');
        if (fill) {
            var targetWidth = fill.getAttribute('data-percentage') || '0%';
            setTimeout(function () {
                fill.style.width = targetWidth;
            }, 150);
        }
    }
})();

document.addEventListener('DOMContentLoaded', function () {
            if (typeof Chart === 'undefined') return;
            // 1. Application Status Donut Chart
            var appCanvas = document.getElementById('studentStatusChart');
            if (appCanvas) {
                var appCtx = appCanvas.getContext('2d');
                var selectedCount = parseInt(appCanvas.getAttribute('data-selected') || '0', 10);
                var pendingCount = parseInt(appCanvas.getAttribute('data-pending') || '0', 10);
                var rejectedCount = parseInt(appCanvas.getAttribute('data-rejected') || '0', 10);
                var appTotal = selectedCount + pendingCount + rejectedCount;
                var appData = [selectedCount, pendingCount, rejectedCount];
                var appLabels = ['Selected', 'Pending', 'Rejected'];
                var appColors = ['#16a34a', '#f59e0b', '#ef4444'];
                if (appTotal === 0) {
                    appData = [1];
                    appLabels = ['No Applications Yet'];
                    appColors = ['#e2e8f0'];
                }
                new Chart(appCtx, {
                    type: 'doughnut',
                    data: {
                        labels: appLabels,
                        datasets: [{
                            data: appData,
                            backgroundColor: appColors,
                            borderWidth: 3,
                            borderColor: '#FFFFFF',
                            hoverOffset: appTotal > 0 ? 4 : 0
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
                                    pointStyle: 'circle',
                                    padding: 14,
                                    font: {
                                        family: "'Inter', sans-serif",
                                        size: 13,
                                        weight: '600'
                                    },
                                    color: '#1e293b'
                                }
                            },
                            tooltip: {
                                enabled: appTotal > 0,
                                callbacks: {
                                    label: function (context) {
                                        var label = context.label || '';
                                        var value = context.parsed || 0;
                                        var pct = appTotal > 0 ? Math.round((value / appTotal) * 100) : 0;
                                        return ' ' + label + ': ' + value + ' (' + pct + '%)';
                                    }
                                }
                            }
                        },
                        cutout: '70%'
                    }
                });
            }
            // 2. Interview Status Bar Chart
            var intCanvas = document.getElementById('studentInterviewChart');
            if (intCanvas) {
                var intCtx = intCanvas.getContext('2d');
                var schCount = parseInt(intCanvas.getAttribute('data-scheduled') || '0', 10);

                var cancCount = parseInt(intCanvas.getAttribute('data-cancelled') || '0', 10);
                var intTotal = schCount + cancCount;
                new Chart(intCtx, {
                    type: 'bar',
                    data: {
                        labels: ['Scheduled', 'Cancelled'],
                        datasets: [{
                            label: 'Interviews',
                            data: [schCount, cancCount],
                            backgroundColor: ['#2563eb', '#ef4444'],
                            borderRadius: 8,
                            borderSkipped: false,
                            maxBarThickness: 42
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            },
                            tooltip: {
                                callbacks: {
                                    label: function (context) {
                                        var val = context.raw || 0;
                                        var pct = intTotal > 0 ? Math.round((val / intTotal) * 100) : 0;
                                        return ' ' + context.dataset.label + ': ' + val + (intTotal > 0 ? ' (' + pct + '%)' : '');
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    precision: 0,
                                    font: {
                                        family: "'Inter', sans-serif",
                                        size: 11
                                    },
                                    color: '#64748b'
                                },
                                grid: {
                                    color: '#f1f5f9',
                                    drawBorder: false
                                }
                            },
                            x: {
                                ticks: {
                                    font: {
                                        family: "'Inter', sans-serif",
                                        size: 12,
                                        weight: '600'
                                    },
                                    color: '#334155'
                                },
                                grid: {
                                    display: false,
                                    drawBorder: false
                                }
                            }
                        }
                    }
                });
            }
        });

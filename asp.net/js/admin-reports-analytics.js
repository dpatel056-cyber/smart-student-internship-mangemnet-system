/* =====================================================
   APEXCHARTS INITIALIZATION FOR admin-reports-analytics.aspx
   ===================================================== */
document.addEventListener('DOMContentLoaded', function () {
    let data = {};
    const hdn = document.getElementById('hdnAnalyticsData');
    if (hdn && hdn.value) {
        try {
            data = JSON.parse(hdn.value);
        } catch (e) {
            console.error('Error parsing analytics data:', e);
        }
    } else if (window.AdminAnalyticsData) {
        data = window.AdminAnalyticsData;
    }

    const c1Data = data.c1Data || {};
    const c2Data = data.c2Data || {};
    const c3Data = data.c3Data || {};
    const c4Data = data.c4Data || {};
    const c5Data = data.c5Data || {};
    const c6Data = data.c6Data || {};
    const c7Data = data.c7Data || {};
    const c8Data = data.c8Data || {};
    const c9Data = data.c9Data || {};
    const c10Data = data.c10Data || {};
    const c11Data = data.c11Data || {};
    const c12Data = data.c12Data || {};

    // 1. Monthly Registrations (Line Chart)
    const el1 = document.querySelector("#chart1_monthly_reg");
    if (el1) {
        new ApexCharts(el1, {
            series: [
                { name: 'Students', data: c1Data.studentSeries || [2, 3, 4, 6, 12, 15] },
                { name: 'Companies', data: c1Data.companySeries || [1, 2, 3, 5, 10, 15] }
            ],
            chart: { height: 280, type: 'line', toolbar: { show: false }, zoom: { enabled: false } },
            colors: ['#2563EB', '#16A34A'],
            stroke: { width: [3, 3], curve: 'smooth' },
            xaxis: { categories: c1Data.categories || ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'] },
            markers: { size: 5 },
            legend: { position: 'top' },
            grid: { borderColor: '#F1F5F9' }
        }).render();
    }
            // 2. Applications per Month (Area Chart)
            new ApexCharts(document.querySelector("#chart2_apps_month"), {
                series: [{ name: 'Applications', data: c2Data.data || [0, 0, 1, 3, 12, 9] }],
                chart: { height: 280, type: 'area', toolbar: { show: false } },
                colors: ['#059669'],
                stroke: { curve: 'smooth', width: 2 },
                fill: { type: 'gradient', gradient: { shadeIntensity: 1, opacityFrom: 0.45, opacityTo: 0.05 } },
                xaxis: { categories: c2Data.categories || ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'] },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 3. Application Status (Doughnut Chart)
            new ApexCharts(document.querySelector("#chart3_app_status"), {
                series: c3Data.series || [1, 14, 6],
                labels: c3Data.labels || ['Pending', 'Selected', 'Shortlisted'],
                chart: { height: 280, type: 'donut' },
                colors: ['#F59E0B', '#10B981', '#3B82F6', '#EF4444'],
                legend: { position: 'bottom' },
                plotOptions: { pie: { donut: { size: '65%' } } }
            }).render();
            // 4. Internships by Domain (Vertical Column Bar)
            new ApexCharts(document.querySelector("#chart4_internship_domains"), {
                series: [{ name: 'Internships', data: c4Data.data || [8, 6, 6, 5, 5, 5, 5] }],
                chart: { height: 280, type: 'bar', toolbar: { show: false } },
                colors: ['#EA580C'],
                plotOptions: { bar: { borderRadius: 6, columnWidth: '45%' } },
                xaxis: { categories: c4Data.categories || ['Software Dev', 'Cloud', 'Web Dev', 'Data Science', 'Cyber Security', 'AI', 'Full Stack'] },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 5. Top 10 Companies by Applicants (Horizontal Bar)
            new ApexCharts(document.querySelector("#chart5_top_companies"), {
                series: [{ name: 'Applicants', data: c5Data.data || [3, 2, 2, 2, 2, 1, 1, 1, 1, 1] }],
                chart: { height: 280, type: 'bar', toolbar: { show: false } },
                colors: ['#0284C7'],
                plotOptions: { bar: { horizontal: true, borderRadius: 6, barHeight: '55%' } },
                xaxis: { categories: c5Data.categories || ['TechNova', 'Apex Web', 'CloudSphere', 'CyberPulse', 'InnovateX', 'BlueWave', 'CartSphere', 'DataCraft', 'EduVerse', 'FinVeda'] },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 6. Work Mode Split (Pie Chart)
            new ApexCharts(document.querySelector("#chart6_work_mode"), {
                series: c6Data.series || [25, 22, 13],
                labels: c6Data.labels || ['Hybrid', 'On-site', 'Remote'],
                chart: { height: 280, type: 'pie' },
                colors: ['#3B82F6', '#10B981', '#8B5CF6'],
                legend: { position: 'bottom' }
            }).render();
            // 7. Status per Month (Stacked Bar)
            new ApexCharts(document.querySelector("#chart7_status_month"), {
                series: [
                    { name: 'Selected', data: c7Data.selected || [0, 0, 0, 1, 5, 8] },
                    { name: 'Shortlisted', data: c7Data.shortlisted || [0, 0, 0, 1, 3, 2] },
                    { name: 'Applied / Pending', data: c7Data.applied || [0, 0, 1, 1, 4, 3] }
                ],
                chart: { height: 280, type: 'bar', stacked: true, toolbar: { show: false } },
                colors: ['#10B981', '#3B82F6', '#F59E0B'],
                xaxis: { categories: c7Data.categories || ['May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct'] },
                legend: { position: 'top' },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 8. Domain: Internships vs Applications (Radar Chart)
            new ApexCharts(document.querySelector("#chart8_domain_radar"), {
                series: [
                    { name: 'Internships Posted', data: c8Data.internships || [8, 6, 6, 5, 5, 5] },
                    { name: 'Applications Received', data: c8Data.applications || [3, 3, 2, 2, 1, 1] }
                ],
                chart: {
                    height: 320,
                    type: 'radar',
                    toolbar: { show: false },
                    dropShadow: { enabled: true, blur: 2, left: 1, top: 1, opacity: 0.08 }
                },
                colors: ['#2563EB', '#EC4899'],
                stroke: { width: 2.5 },
                fill: { opacity: 0.25 },
                markers: { size: 4, hover: { size: 7 } },
                plotOptions: {
                    radar: {
                        size: 100,
                        polygons: {
                            strokeColors: '#E2E8F0',
                            strokeWidth: 1,
                            connectorColors: '#E2E8F0',
                            fill: { colors: ['#F8FAFC', '#FFFFFF'] }
                        }
                    }
                },
                yaxis: { show: false },
                xaxis: {
                    categories: c8Data.categories || ['Software Dev', 'Web Dev', 'Cloud', 'Cyber Sec', 'Data Science', 'Full Stack'],
                    labels: {
                        style: {
                            colors: ['#334155', '#334155', '#334155', '#334155', '#334155', '#334155'],
                            fontSize: '12px',
                            fontWeight: 600
                        }
                    }
                },
                legend: {
                    position: 'bottom',
                    fontSize: '13px',
                    markers: { radius: 6 }
                }
            }).render();
            // 9. Hiring Funnel (Funnel / Horizontal Bar)
            new ApexCharts(document.querySelector("#chart9_hiring_funnel"), {
                series: [{ name: 'Count', data: c9Data.data || [21, 6, 9, 14, 0] }],
                chart: { height: 280, type: 'bar', toolbar: { show: false } },
                colors: ['#4F46E5'],
                plotOptions: {
                    bar: {
                        horizontal: true,
                        borderRadius: 6,
                        barHeight: '55%',
                        distributed: true
                    }
                },
                colors: ['#3B82F6', '#6366F1', '#8B5CF6', '#10B981', '#06B6D4'],
                xaxis: { categories: c9Data.categories || ['1. Applied', '2. Shortlisted', '3. Interviewed', '4. Selected', '5. Certified'] },
                legend: { show: false },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 10. Top Colleges (Polar Area Chart)
            new ApexCharts(document.querySelector("#chart10_top_colleges"), {
                series: c10Data.series || [5, 1, 1, 1, 1, 1],
                labels: c10Data.labels || ['RK University', 'Gujarat Univ', 'GTU', 'Govt Poly', 'GLS Univ', 'DA-IICT'],
                chart: { height: 280, type: 'polarArea' },
                colors: ['#0D9488', '#3B82F6', '#8B5CF6', '#EC4899', '#F59E0B', '#10B981'],
                stroke: { colors: ['#fff'] },
                fill: { opacity: 0.85 },
                legend: { position: 'bottom' }
            }).render();
            // 11. Rating Distribution (Bar Chart)
            new ApexCharts(document.querySelector("#chart11_rating_dist"), {
                series: [{ name: 'Reviews', data: c11Data.data || [0, 0, 0, 2, 3] }],
                chart: { height: 280, type: 'bar', toolbar: { show: false } },
                colors: ['#F59E0B'],
                plotOptions: { bar: { borderRadius: 6, columnWidth: '45%', distributed: true } },
                colors: ['#EF4444', '#F97316', '#FBBF24', '#34D399', '#10B981'],
                xaxis: { categories: c11Data.categories || ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'] },
                legend: { show: false },
                grid: { borderColor: '#F1F5F9' }
            }).render();
            // 12. Selection Rate % (Gauge / RadialBar Chart)
            new ApexCharts(document.querySelector("#chart12_selection_gauge"), {
                series: [c12Data.percentage || 66.7],
                chart: { height: 280, type: 'radialBar' },
                plotOptions: {
                    radialBar: {
                        startAngle: -135,
                        endAngle: 135,
                        hollow: { size: '70%' },
                        track: { background: '#F1F5F9', strokeWidth: '100%' },
                        dataLabels: {
                            name: { fontSize: '14px', color: '#64748B', offsetY: -10 },
                            value: { fontSize: '26px', fontWeight: 700, color: '#0F172A', offsetY: 5, formatter: val => val + '%' }
                        }
                    }
                },
                fill: {
                    type: 'gradient',
                    gradient: {
                        shade: 'dark',
                        type: 'horizontal',
                        shadeIntensity: 0.5,
                        gradientToColors: ['#10B981'],
                        stops: [0, 100]
                    }
                },
                colors: ['#3B82F6'],
                stroke: { dashArray: 4 },
                labels: ['Placement Rate']
            }).render();

            // =========================================================================
            // Tooltip Box & Responsive Map Coordinate Resizer for ASP.NET Chart 1
            // =========================================================================
            function initChart1Tooltips() {
                const chartImg = document.querySelector('.chart-body-asp img, #ContentPlaceHolder1_Chart1, img[usemap]');
                if (!chartImg) return;

                // Tooltip floating box
                let tooltipBox = document.getElementById('chartMapTooltipBox');
                if (!tooltipBox) {
                    tooltipBox = document.createElement('div');
                    tooltipBox.id = 'chartMapTooltipBox';
                    tooltipBox.className = 'chart-tooltip-box';
                    document.body.appendChild(tooltipBox);
                }

                function positionTooltip(e) {
                    const pad = 12;
                    let left = e.clientX + pad;
                    let top = e.clientY + pad;

                    const boxRect = tooltipBox.getBoundingClientRect();
                    if (left + boxRect.width > window.innerWidth - 10) {
                        left = e.clientX - boxRect.width - pad;
                    }
                    if (top + boxRect.height > window.innerHeight - 10) {
                        top = e.clientY - boxRect.height - pad;
                    }

                    tooltipBox.style.left = left + 'px';
                    tooltipBox.style.top = top + 'px';
                }

                function updateAreaCoords() {
                    const usemap = chartImg.getAttribute('usemap');
                    if (!usemap) return;

                    const mapName = usemap.replace('#', '');
                    const map = document.querySelector('map[name="' + mapName + '"], map[id="' + mapName + '"]');
                    if (!map) return;

                    const natW = chartImg.naturalWidth || parseInt(chartImg.getAttribute('width')) || 650;
                    const natH = chartImg.naturalHeight || parseInt(chartImg.getAttribute('height')) || 320;
                    const curW = chartImg.clientWidth || chartImg.offsetWidth;
                    const curH = chartImg.clientHeight || chartImg.offsetHeight;

                    if (!curW || !natW || !curH || !natH) return;

                    const ratioX = curW / natW;
                    const ratioY = curH / natH;

                    const areas = map.querySelectorAll('area');
                    areas.forEach(area => {
                        if (!area.dataset.origCoords) {
                            area.dataset.origCoords = area.getAttribute('coords') || '';
                        }
                        if (!area.dataset.origCoords) return;

                        const orig = area.dataset.origCoords.split(',').map(s => parseFloat(s.trim()));
                        const shape = (area.getAttribute('shape') || '').toLowerCase();

                        if (shape === 'circle') {
                            const cx = Math.round(orig[0] * ratioX);
                            const cy = Math.round(orig[1] * ratioY);
                            // Comfortable hover radius (at least 14px)
                            const r = Math.max(14, Math.round((orig[2] || 4) * ratioX * 2.5));
                            area.setAttribute('coords', cx + ',' + cy + ',' + r);
                        } else if (shape === 'poly' || shape === 'polygon') {
                            const scaled = orig.map((val, idx) => Math.round(idx % 2 === 0 ? val * ratioX : val * ratioY));
                            area.setAttribute('coords', scaled.join(','));
                        } else if (shape === 'rect') {
                            const x1 = Math.round(orig[0] * ratioX);
                            const y1 = Math.round(orig[1] * ratioY);
                            const x2 = Math.round(orig[2] * ratioX);
                            const y2 = Math.round(orig[3] * ratioY);
                            area.setAttribute('coords', x1 + ',' + y1 + ',' + x2 + ',' + y2);
                        }

                        // Attach hover listeners once
                        if (!area.dataset.tooltipBound) {
                            area.dataset.tooltipBound = 'true';
                            const rawTip = area.getAttribute('title') || area.getAttribute('alt') || '';
                            if (rawTip) {
                                area.dataset.tipContent = rawTip;
                                area.removeAttribute('title');
                            }

                            area.addEventListener('mouseenter', function (e) {
                                const tipText = area.dataset.tipContent;
                                if (!tipText) return;

                                const lines = tipText.split(/\r?\n/);
                                let formattedHtml = '';
                                if (lines.length > 1) {
                                    formattedHtml = '<div class="tooltip-title">' + lines[0] + '</div><div class="tooltip-val">' + lines.slice(1).join('<br>') + '</div>';
                                } else {
                                    formattedHtml = '<div class="tooltip-val">' + tipText + '</div>';
                                }

                                tooltipBox.innerHTML = formattedHtml;
                                tooltipBox.style.display = 'block';
                                positionTooltip(e);
                            });

                            area.addEventListener('mousemove', function (e) {
                                positionTooltip(e);
                            });

                            area.addEventListener('mouseleave', function () {
                                tooltipBox.style.display = 'none';
                            });
                        }
                    });
                }

                if (chartImg.complete) {
                    updateAreaCoords();
                } else {
                    chartImg.addEventListener('load', updateAreaCoords);
                }

                window.addEventListener('resize', updateAreaCoords);
                setTimeout(updateAreaCoords, 200);
                setTimeout(updateAreaCoords, 600);
                setTimeout(updateAreaCoords, 1500);
            }

            initChart1Tooltips();
        });
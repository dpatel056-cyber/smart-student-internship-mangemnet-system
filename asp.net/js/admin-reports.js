/* ============================================================
   admin-reports.js — ReportsAnalytics.aspx Interactivity
   ============================================================ */

(function () {
    'use strict';

    /* ── Export Dropdown toggle ── */
    var btnExport = document.getElementById('btnExportToggle');
    var exportMenu = document.getElementById('exportMenu');
    if (btnExport && exportMenu) {
        btnExport.addEventListener('click', function (e) {
            e.stopPropagation();
            exportMenu.classList.toggle('open');
        });
        document.addEventListener('click', function () {
            exportMenu.classList.remove('open');
        });
    }

    /* ── Tab switching ── */
    var tabs = document.querySelectorAll('.sims-analytics-tab');
    tabs.forEach(function (tab) {
        tab.addEventListener('click', function () {
            var target = this.dataset.tab;
            tabs.forEach(function (t) { t.classList.remove('active'); });
            this.classList.add('active');
            var panels = document.querySelectorAll('.sims-analytics-tab-panel');
            panels.forEach(function (p) {
                p.classList.toggle('active', p.id === target);
            });
        });
    });
    var firstTab = document.querySelector('.sims-analytics-tab');
    if (firstTab) firstTab.click();

    /* ── Apply Filters ── */
    var btnApply = document.getElementById('btnApplyFilters');
    if (btnApply) {
        btnApply.addEventListener('click', function () {
            var btn = this;
            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Applying...';
            btn.disabled = true;
            setTimeout(function () {
                btn.innerHTML = '<i class="fa-solid fa-filter"></i> Apply Filters';
                btn.disabled = false;
                showToast('Filters applied successfully!', 'success');
            }, 800);
        });
    }

    /* ── Reset Filters ── */
    var btnReset = document.getElementById('btnResetFilters');
    if (btnReset) {
        btnReset.addEventListener('click', function () {
            document.querySelectorAll('.sims-analytics-select').forEach(function (s) { s.selectedIndex = 0; });
            document.querySelectorAll('.sims-analytics-input[type="date"]').forEach(function (i) { i.value = ''; });
            showToast('Filters reset.', 'info');
        });
    }

    /* ── Generate Report ── */
    var btnGenerate = document.getElementById('btnGenerateReport');
    if (btnGenerate) {
        btnGenerate.addEventListener('click', function () {
            var btn = this;
            btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Generating...';
            btn.disabled = true;
            setTimeout(function () {
                btn.innerHTML = '<i class="fa-solid fa-chart-line"></i> Generate Report';
                btn.disabled = false;
                showToast('Report generated successfully!', 'success');
            }, 1200);
        });
    }

    /* ── Schedule Report ── */
    var btnSchedule = document.getElementById('btnScheduleReport');
    if (btnSchedule) {
        btnSchedule.addEventListener('click', function () {
            showToast('Schedule Report feature coming soon.', 'info');
        });
    }

    /* ── Export items ── */
    document.querySelectorAll('.sims-analytics-export-item').forEach(function (item) {
        item.addEventListener('click', function (e) {
            e.preventDefault();
            var labels = { 'pdf-dashboard':'Dashboard PDF','excel':'Excel file','csv':'CSV file','current':'Current report','selected':'Selected data' };
            if (exportMenu) exportMenu.classList.remove('open');
            showToast('Exporting ' + (labels[this.dataset.export] || 'report') + '...', 'success');
        });
    });

    /* ── Progress bar animation ── */
    document.querySelectorAll('.ra-progress-fill').forEach(function (bar) {
        var target = bar.dataset.width || bar.style.width;
        bar.style.width = '0';
        setTimeout(function () { bar.style.width = target; }, 200);
    });

    /* ── KPI count-up ── */
    document.querySelectorAll('.sims-analytics-kpi-value').forEach(function (el) {
        var raw = el.textContent.replace(/[^0-9.]/g, '');
        var target = parseFloat(raw);
        if (isNaN(target) || target === 0) return;
        var suffix = el.textContent.replace(raw, '').trim();
        var step = target / 75;
        var cur = 0;
        var timer = setInterval(function () {
            cur += step;
            if (cur >= target) { cur = target; clearInterval(timer); }
            el.textContent = Math.round(cur).toLocaleString() + (suffix ? ' ' + suffix : '');
        }, 16);
    });

    /* ── Sortable table headers ── */
    document.querySelectorAll('.sims-analytics-data-table thead th[data-sort]').forEach(function (th) {
        th.style.cursor = 'pointer';
        th.addEventListener('click', function () {
            var idx = Array.from(this.parentNode.children).indexOf(this);
            var asc = this.dataset.dir !== 'asc';
            this.dataset.dir = asc ? 'asc' : 'desc';
            var tbody = this.closest('table').querySelector('tbody');
            var rows = Array.from(tbody.querySelectorAll('tr'));
            rows.sort(function (a, b) {
                var av = a.cells[idx] ? a.cells[idx].innerText.trim() : '';
                var bv = b.cells[idx] ? b.cells[idx].innerText.trim() : '';
                return asc ? av.localeCompare(bv) : bv.localeCompare(av);
            });
            rows.forEach(function (r) { tbody.appendChild(r); });
        });
    });

    /* ── Page buttons ── */
    document.querySelectorAll('.sims-analytics-page-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var grp = this.closest('.sims-analytics-page-controls');
            if (!grp) return;
            var label = this.textContent.trim();
            if (label === 'Previous' || label === 'Next') return;
            grp.querySelectorAll('.sims-analytics-page-btn').forEach(function (b) { b.classList.remove('active'); });
            this.classList.add('active');
        });
    });

    /* ── Toast ── */
    function showToast(msg, type) {
        var c = { success:'#10B981', error:'#EF4444', info:'#4F46E5' };
        var icons = { success:'fa-circle-check', error:'fa-circle-xmark', info:'fa-circle-info' };
        var t = document.createElement('div');
        t.style.cssText = 'position:fixed;bottom:24px;right:24px;z-index:9999;background:' + (c[type]||c.info) + ';color:white;padding:12px 20px;border-radius:10px;font-family:Inter,sans-serif;font-size:14px;font-weight:600;box-shadow:0 8px 20px rgba(0,0,0,.15);display:flex;align-items:center;gap:10px;animation:raIn .3s ease';
        t.innerHTML = '<i class="fa-solid ' + (icons[type]||icons.info) + '"></i> ' + msg;
        document.body.appendChild(t);
        setTimeout(function () { t.style.opacity='0'; t.style.transition='opacity .3s'; setTimeout(function(){t.remove();},300); }, 3000);
    }

    if (!document.getElementById('raStyle')) {
        var s = document.createElement('style');
        s.id = 'raStyle';
        s.textContent = '@keyframes raIn{from{opacity:0;transform:translateY(10px)}to{opacity:1;transform:translateY(0)}}';
        document.head.appendChild(s);
    }

})();

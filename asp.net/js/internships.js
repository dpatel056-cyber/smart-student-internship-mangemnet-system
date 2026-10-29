/**
 * Internships Page JavaScript - SIMS
 * Public Panel Internships Directory
 */

function formatPagination() {
    var lbl = document.querySelector('.pagination-pages') || document.querySelector('[id$="lblPages"]');
    var prevBtn = document.querySelector('.page-btn.previous') || document.querySelector('[id$="btnPrevious"]');
    var nextBtn = document.querySelector('.page-btn.next') || document.querySelector('[id$="btnNext"]');

    if (lbl) {
        var text = (lbl.innerText || lbl.textContent || '').trim();
        var match = text.match(/Page\s+(\d+)\s+of\s+(\d+)/i);
        if (match) {
            var curPage = parseInt(match[1], 10);
            var totalPages = parseInt(match[2], 10);

            lbl.innerHTML = '<span class="page-text-muted">Page</span> ' +
                            '<span class="current-page-badge">' + curPage + '</span> ' +
                            '<span class="page-text-muted">of</span> ' +
                            '<span class="total-pages-badge">' + totalPages + '</span>';

            if (prevBtn) {
                if (curPage <= 1) {
                    prevBtn.classList.add('disabled', 'aspNetDisabled');
                    prevBtn.setAttribute('aria-disabled', 'true');
                } else {
                    prevBtn.classList.remove('disabled', 'aspNetDisabled');
                    prevBtn.removeAttribute('aria-disabled');
                }
            }

            if (nextBtn) {
                if (curPage >= totalPages) {
                    nextBtn.classList.add('disabled', 'aspNetDisabled');
                    nextBtn.setAttribute('aria-disabled', 'true');
                } else {
                    nextBtn.classList.remove('disabled', 'aspNetDisabled');
                    nextBtn.removeAttribute('aria-disabled');
                }
            }
        }
    }

    if (prevBtn && (prevBtn.classList.contains('aspNetDisabled') || !prevBtn.getAttribute('href') || prevBtn.getAttribute('disabled'))) {
        prevBtn.classList.add('disabled');
    }
    if (nextBtn && (nextBtn.classList.contains('aspNetDisabled') || !nextBtn.getAttribute('href') || nextBtn.getAttribute('disabled'))) {
        nextBtn.classList.add('disabled');
    }
}

// Initialize on DOM ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', formatPagination);
} else {
    formatPagination();
}

// Support ASP.NET AJAX partial postbacks if ScriptManager is present
if (typeof Sys !== 'undefined' && Sys.WebForms && Sys.WebForms.PageRequestManager) {
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(formatPagination);
}

/**
 * ==========================================================================
 * Company Applicants JavaScript (company-applicants.js)
 * SIMS - Student Internship Management System
 * ==========================================================================
 */

document.addEventListener('DOMContentLoaded', function () {
    // 1. Enter key support in search textbox
    var txtSearch = document.getElementById('ContentPlaceHolder1_txtSearch') || document.querySelector('input[id*="txtSearch"]');
    var btnSearch = document.getElementById('ContentPlaceHolder1_btnSearch') || document.querySelector('input[id*="btnSearch"]');

    if (txtSearch && btnSearch) {
        txtSearch.addEventListener('keydown', function (e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                btnSearch.click();
            }
        });
    }

    // 2. Avatar fallback handler for missing student photos
    var studentAvatars = document.querySelectorAll('.co-applicant-avatar');
    studentAvatars.forEach(function (img) {
        img.addEventListener('error', function () {
            this.onerror = null;
            this.src = '../student_images/default-avatar.png';
        });
    });

    // 3. Auto-hide message alert if visible
    var lblMsg = document.getElementById('ContentPlaceHolder1_lblMsg') || document.querySelector('span[id*="lblMsg"]');
    if (lblMsg && lblMsg.innerText.trim() !== '') {
        setTimeout(function () {
            lblMsg.style.transition = 'opacity 0.5s ease';
            lblMsg.style.opacity = '0';
            setTimeout(function () {
                lblMsg.style.display = 'none';
            }, 500);
        }, 4000);
    }
});

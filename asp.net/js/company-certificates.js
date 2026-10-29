// SIMS - Company Certificates Script
function openDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var panel = document.getElementById('drawerPanel');
            if (overlay && panel) {
                overlay.style.display = 'block';
                setTimeout(function () {
                    panel.classList.add('open');
                }, 10);
            }
            updateCertPreview();
        }
        function closeDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var panel = document.getElementById('drawerPanel');
            if (overlay && panel) {
                panel.classList.remove('open');
                setTimeout(function () {
                    overlay.style.display = 'none';
                }, 300);
            }
        }
        function updateCertPreview() {
            var candNameInput = document.querySelector('[id$="txtCandidateName"]');
            var candName = candNameInput ? (candNameInput.value || '[Candidate Full Name]') : '[Candidate Full Name]';
            var candCollegeInput = document.querySelector('[id$="txtCandidateCollege"]');
            var candCollege = candCollegeInput ? (candCollegeInput.value || 'College / University Name') : 'College / University Name';
            var certTitleInput = document.querySelector('[id$="txtCertTitle"]');
            var certTitle = certTitleInput ? (certTitleInput.value || 'Certificate of Internship Excellence') : 'Certificate of Internship Excellence';
            var roleInput = document.querySelector('[id$="txtInternshipRole"]');
            var role = roleInput ? (roleInput.value || '[Internship Role]') : '[Internship Role]';
            var durationInput = document.querySelector('[id$="txtDuration"]');
            var duration = durationInput ? (durationInput.value || '3 Months') : '3 Months';
            var issueDateInput = document.querySelector('[id$="txtIssueDate"]');
            var issueDate = issueDateInput ? issueDateInput.value : '';
            var performanceInput = document.querySelector('[id$="txtPerformance"]');
            var performance = performanceInput ? (performanceInput.value || 'Outstanding Performance & Dedication') : 'Outstanding Performance & Dedication';
            var signatoryInput = document.querySelector('[id$="txtSignatoryName"]');
            var signatory = signatoryInput ? (signatoryInput.value || (window.COMP_HR || '')) : (window.COMP_HR || '');
            var prevCandName = document.getElementById('prevCandName');
            if (prevCandName) prevCandName.innerText = candName;
            var prevCandCollege = document.getElementById('prevCandCollege');
            if (prevCandCollege) prevCandCollege.innerText = candCollege;
            var prevCertTitle = document.getElementById('prevCertTitle');
            if (prevCertTitle) prevCertTitle.innerText = certTitle;
            var prevCertRole = document.getElementById('prevCertRole');
            if (prevCertRole) prevCertRole.innerText = role;
            var prevCertDuration = document.getElementById('prevCertDuration');
            if (prevCertDuration) prevCertDuration.innerText = duration;
            var prevCertPerformance = document.getElementById('prevCertPerformance');
            if (prevCertPerformance) prevCertPerformance.innerText = performance;
            var prevSignatoryName = document.getElementById('prevSignatoryName');
            if (prevSignatoryName) prevSignatoryName.innerText = signatory;
            var prevCertDate = document.getElementById('prevCertDate');
            if (prevCertDate) {
                if (issueDate) {
                    var d = new Date(issueDate);
                    if (!isNaN(d.getTime())) {
                        var options = { day: '2-digit', month: 'long', year: 'numeric' };
                        prevCertDate.innerText = d.toLocaleDateString('en-GB', options);
                    } else {
                        prevCertDate.innerText = issueDate;
                    }
                }
            }
        }
        function openCertModal(name, college, title, role, duration, issueDate, performance, signatory, certNo, verifyCode) {
            document.getElementById('modalCandName').innerText = name || '[Candidate Full Name]';
            document.getElementById('modalCandCollege').innerText = college || '';
            document.getElementById('modalCertTitle').innerText = title || 'Certificate of Internship Excellence';
            document.getElementById('modalCertRole').innerText = role || '[Internship Role]';
            document.getElementById('modalCertDuration').innerText = duration || '3 Months';
            document.getElementById('modalCertPerformance').innerText = performance || 'Outstanding Performance & Dedication';
            document.getElementById('modalSignatoryName').innerText = signatory || (window.COMP_HR || '');
            document.getElementById('modalCertNo').innerText = certNo || 'CERT-2026-0001';
            document.getElementById('modalVerifyCode').innerText = verifyCode || '8F9B2C1A';
            if (issueDate) {
                document.getElementById('modalCertDate').innerText = issueDate;
            }
            document.getElementById('printModal').style.display = 'flex';
        }
        function closePrintModal(e) {
            document.getElementById('printModal').style.display = 'none';
        }
        // Initialize on load
        window.addEventListener('DOMContentLoaded', function() {
            updateCertPreview();
        });

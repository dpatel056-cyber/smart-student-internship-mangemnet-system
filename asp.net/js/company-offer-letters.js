// SIMS - Company Offer Letters Script
function openDrawer() {
            var overlay = document.getElementById('drawerOverlay');
            var panel = document.getElementById('drawerPanel');
            if (overlay && panel) {
                overlay.style.display = 'block';
                setTimeout(function () {
                    panel.classList.add('open');
                }, 10);
            }
            updateTemplatePreview();
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
        function updateTemplatePreview() {
            var candNameInput = document.querySelector('[id$="txtCandidateName"]');
            var candName = candNameInput ? (candNameInput.value || '[Candidate Full Name]') : '[Candidate Full Name]';
            var candCollegeInput = document.querySelector('[id$="txtCandidateCollege"]');
            var candCollege = candCollegeInput ? (candCollegeInput.value || 'College / University Name') : 'College / University Name';
            var offerDateInput = document.querySelector('[id$="txtOfferDate"]');
            var offerDate = offerDateInput ? offerDateInput.value : '';
            var titleInput = document.querySelector('[id$="txtOfferTitle"]');
            var title = titleInput ? (titleInput.value || '[Internship Role]') : '[Internship Role]';
            var stipendInput = document.querySelector('[id$="txtStipend"]');
            var rawStipend = stipendInput ? (stipendInput.value || '15,000 / month') : '15,000 / month';
            rawStipend = rawStipend.replace(/â,¹|â‚¹|\?|₹|Rs\.|INR/g, '').trim();
            var stipendHtml = 'Unpaid';
            if (rawStipend) {
                if (!rawStipend.toLowerCase().includes('month') && !rawStipend.toLowerCase().includes('unpaid') && !rawStipend.toLowerCase().includes('fixed')) {
                    rawStipend = rawStipend + ' / month';
                }
                stipendHtml = '<i class="fa-solid fa-indian-rupee-sign" style="font-size:12px; margin-right:3px;"></i> ' + rawStipend;
            }
            var durationInput = document.querySelector('[id$="txtDuration"]');
            var duration = durationInput ? (durationInput.value || '3 Months') : '3 Months';
            var joiningInput = document.querySelector('[id$="txtJoiningDate"]');
            var joining = joiningInput ? (joiningInput.value || (window.DEFAULT_JOINING_DATE || '')) : (window.DEFAULT_JOINING_DATE || '');
            var locationInput = document.querySelector('[id$="txtWorkLocation"]');
            var location = locationInput ? (locationInput.value || (window.COMP_LOCATION || '')) : (window.COMP_LOCATION || '');
            var validTillInput = document.querySelector('[id$="txtValidTill"]');
            var validTill = validTillInput ? (validTillInput.value || (window.DEFAULT_VALID_TILL || '')) : (window.DEFAULT_VALID_TILL || '');
            // Update candidate info
            var prevCand = document.getElementById('prevCandidateName');
            if (prevCand) prevCand.innerText = candName;
            var prevSal = document.getElementById('prevSalutationName');
            if (prevSal) prevSal.innerText = candName;
            var prevColl = document.getElementById('prevCandidateCollege');
            if (prevColl) prevColl.innerText = candCollege;
            // Update offer date
            var prevDate = document.getElementById('prevOfferDate');
            if (prevDate) {
                if (offerDate) {
                    var d = new Date(offerDate);
                    if (!isNaN(d.getTime())) {
                        var options = { day: '2-digit', month: 'long', year: 'numeric' };
                        prevDate.innerText = d.toLocaleDateString('en-GB', options);
                    } else {
                        prevDate.innerText = offerDate;
                    }
                }
            }
            // Update role & details
            var prevSubRole = document.getElementById('prevSubjectRole');
            if (prevSubRole) prevSubRole.innerText = title;
            var prevBodyRole = document.getElementById('prevBodyRole');
            if (prevBodyRole) prevBodyRole.innerText = title;
            var prevTableRole = document.getElementById('prevTableRole');
            if (prevTableRole) prevTableRole.innerText = title;
            var prevTableStipend = document.getElementById('prevTableStipend');
            if (prevTableStipend) prevTableStipend.innerHTML = stipendHtml;
            var prevTableDur = document.getElementById('prevTableDuration');
            if (prevTableDur) prevTableDur.innerText = duration;
            var prevTableJoin = document.getElementById('prevTableJoiningDate');
            if (prevTableJoin) {
                if (joining && joining.indexOf('-') > -1) {
                    var jd = new Date(joining);
                    if (!isNaN(jd.getTime())) {
                        prevTableJoin.innerText = jd.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
                    } else {
                        prevTableJoin.innerText = joining;
                    }
                } else {
                    prevTableJoin.innerText = joining;
                }
            }
            var prevTableLoc = document.getElementById('prevTableLocation');
            if (prevTableLoc) prevTableLoc.innerText = location;
            var prevTableValid = document.getElementById('prevTableValidTill');
            if (prevTableValid) {
                if (validTill && validTill.indexOf('-') > -1) {
                    var vd = new Date(validTill);
                    if (!isNaN(vd.getTime())) {
                        prevTableValid.innerText = vd.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
                    } else {
                        prevTableValid.innerText = validTill;
                    }
                } else {
                    prevTableValid.innerText = validTill;
                }
            }
        }
        function openLetterModal(name, college, role, stipend, joining, duration, location, id, issuedDate) {
            document.getElementById('modalRef').innerText = id || '001';
            document.getElementById('modalCandName').innerText = name || '[Candidate Full Name]';
            document.getElementById('modalCandCollege').innerText = college || 'College / University Name';
            document.getElementById('modalSubjectRole').innerText = role || '[Internship Role]';
            document.getElementById('modalSalutation').innerText = name || 'Candidate';
            document.getElementById('modalBodyRole').innerText = role || '[Internship Role]';
            document.getElementById('modalTableRole').innerText = role || '[Internship Role]';
            document.getElementById('modalTableDuration').innerText = duration || '3 Months';
            var cleanStipend = (stipend || '').replace(/â,¹|â‚¹|\?|₹|Rs\.|INR/g, '').trim();
            var modalStipendHtml = 'Unpaid';
            if (cleanStipend) {
                if (!cleanStipend.toLowerCase().includes('month') && !cleanStipend.toLowerCase().includes('unpaid') && !cleanStipend.toLowerCase().includes('fixed')) {
                    cleanStipend = cleanStipend + ' / month';
                }
                modalStipendHtml = '<i class="fa-solid fa-indian-rupee-sign" style="font-size:12px; margin-right:3px;"></i> ' + cleanStipend;
            }
            document.getElementById('modalTableStipend').innerHTML = modalStipendHtml;
            document.getElementById('modalTableJoiningDate').innerText = joining || '';
            document.getElementById('modalTableLocation').innerText = location || (window.COMP_LOCATION || '');
            if (joining) {
                var jd = new Date(joining);
                if (!isNaN(jd.getTime())) {
                    var dl = new Date(jd.getTime() - (3 * 24 * 60 * 60 * 1000));
                    document.getElementById('modalTableValidTill').innerText = dl.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
                } else {
                    document.getElementById('modalTableValidTill').innerText = joining;
                }
            } else {
                document.getElementById('modalTableValidTill').innerText = (window.DEFAULT_VALID_TILL || '');
            }
            if (issuedDate) {
                document.getElementById('modalOfferDate').innerText = issuedDate;
            }
            document.getElementById('printModal').style.display = 'flex';
        }
        function closePrintModal(e) {
            document.getElementById('printModal').style.display = 'none';
        }
        // Initialize on load
        window.addEventListener('DOMContentLoaded', function() {
            updateTemplatePreview();
        });

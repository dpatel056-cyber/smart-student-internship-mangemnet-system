function openStudentCertModal(comp, loc, email, logo, name, college, title, role, duration, issueDate, performance, signatory, certNo, verifyCode) {
            document.getElementById('sModalCompName').innerText = comp || 'Company';
            document.getElementById('sModalBodyComp').innerText = comp || 'Company';
            document.getElementById('sModalSignComp').innerText = comp || 'Company';
            document.getElementById('sModalCompLoc').innerText = loc || '';
            document.getElementById('sModalCompEmail').innerText = email || '';
            var logoEl = document.getElementById('sModalCompLogo');
            var logoIcon = document.getElementById('sModalLogoIcon');
            var cleanLogo = (logo && logo.trim() !== '' && logo.trim() !== 'undefined') ? logo.trim() : '';
            
            if (cleanLogo) {
                if (cleanLogo.indexOf('~/') === 0) {
                    cleanLogo = cleanLogo.replace('~/', '/');
                }
                if (!cleanLogo.startsWith('http') && !cleanLogo.startsWith('/') && !cleanLogo.startsWith('.')) {
                    cleanLogo = '../CompanyUploads/' + cleanLogo;
                }
                var testImg = new Image();
                testImg.onload = function () {
                    logoEl.src = cleanLogo;
                    logoEl.style.display = 'block';
                    logoIcon.style.display = 'none';
                };
                testImg.onerror = function () {
                    var altPath = cleanLogo.indexOf('CompanyUploads') !== -1 ? 
                        cleanLogo.replace('CompanyUploads', 'uploads/company_logos') : 
                        cleanLogo.replace('uploads/company_logos', 'CompanyUploads');
                    var altImg = new Image();
                    altImg.onload = function () {
                        logoEl.src = altPath;
                        logoEl.style.display = 'block';
                        logoIcon.style.display = 'none';
                    };
                    altImg.onerror = function () {
                        logoEl.style.display = 'none';
                        logoIcon.style.display = 'flex';
                    };
                    altImg.src = altPath;
                };
                testImg.src = cleanLogo;
            } else {
                logoEl.style.display = 'none';
                logoIcon.style.display = 'flex';
            }
            document.getElementById('sModalCandName').innerText = name || '[Candidate Full Name]';
            document.getElementById('sModalCandCollege').innerText = college || '';
            document.getElementById('sModalCertTitle').innerText = title || 'Certificate of Internship Excellence';
            document.getElementById('sModalCertRole').innerText = role || '[Internship Role]';
            document.getElementById('sModalCertDuration').innerText = duration || '3 Months';
            document.getElementById('sModalCertPerformance').innerText = performance || 'Outstanding Performance & Dedication';
            document.getElementById('sModalSignatoryName').innerText = signatory || 'HR & Talent Team';
            document.getElementById('sModalCertNo').innerText = certNo || 'CERT-2026-0001';
            document.getElementById('sModalVerifyCode').innerText = verifyCode || '8F9B2C1A';
            if (issueDate) {
                document.getElementById('sModalCertDate').innerText = issueDate;
            }
            document.getElementById('studentPrintModal').style.display = 'flex';
        }
        function closeStudentModal(e) {
            document.getElementById('studentPrintModal').style.display = 'none';
        }

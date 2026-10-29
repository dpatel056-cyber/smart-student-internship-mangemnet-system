function openStudentLetterModal(comp, loc, email, phone, web, logo, name, candEmail, college, role, stipend, joining, duration, jobLoc, id, issuedDate, hr) {
            document.getElementById('sModalCompName').innerText = comp || 'Company';
            document.getElementById('sModalBodyComp').innerText = comp || 'Company';
            document.getElementById('sModalSignCompName').innerText = comp || 'Company';
            document.getElementById('sModalCompLoc').innerText = loc || '';
            document.getElementById('sModalCompEmail').innerText = email || '';
            document.getElementById('sModalCompPhone').innerText = phone || '';
            var webEl = document.getElementById('sModalCompWeb');
            if (web && web.trim() !== '') {
                webEl.innerText = web;
                webEl.style.display = 'block';
            } else {
                webEl.style.display = 'none';
            }
            var logoEl = document.getElementById('sModalCompLogo');
            var logoIcon = document.getElementById('sModalLogoIcon');
            var cleanLogo = (logo && logo.trim() !== '' && logo.trim() !== 'undefined' && logo.trim() !== 'null') ? logo.trim() : '';

            if (cleanLogo) {
                if (cleanLogo.startsWith('~/')) {
                    cleanLogo = cleanLogo.replace('~/', '/');
                } else if (!cleanLogo.startsWith('/') && !cleanLogo.startsWith('http://') && !cleanLogo.startsWith('https://')) {
                    cleanLogo = '/CompanyUploads/' + cleanLogo;
                }

                logoEl.src = cleanLogo;
                logoEl.style.display = 'block';
                logoIcon.style.display = 'none';

                logoEl.onerror = function () {
                    if (this.src.indexOf('/CompanyUploads/') !== -1) {
                        var fileName = this.src.substring(this.src.lastIndexOf('/') + 1);
                        this.onerror = function () {
                            if (this.src.indexOf('/uploads/company_logos/') !== -1) {
                                this.onerror = function () {
                                    logoEl.style.display = 'none';
                                    logoIcon.style.display = 'flex';
                                };
                                this.src = '/assets/' + fileName;
                            } else {
                                logoEl.style.display = 'none';
                                logoIcon.style.display = 'flex';
                            }
                        };
                        this.src = '/uploads/company_logos/' + fileName;
                    } else if (this.src.indexOf('/uploads/company_logos/') !== -1) {
                        var fileName = this.src.substring(this.src.lastIndexOf('/') + 1);
                        this.onerror = function () {
                            logoEl.style.display = 'none';
                            logoIcon.style.display = 'flex';
                        };
                        this.src = '/CompanyUploads/' + fileName;
                    } else {
                        logoEl.style.display = 'none';
                        logoIcon.style.display = 'flex';
                    }
                };
            } else {
                logoEl.style.display = 'none';
                logoIcon.style.display = 'flex';
            }
            document.getElementById('sModalRef').innerText = id || '001';
            if (issuedDate) {
                document.getElementById('sModalOfferDate').innerText = issuedDate;
            }
            document.getElementById('sModalCandName').innerText = name || 'Candidate';
            document.getElementById('sModalCandCollege').innerText = college || '';
            document.getElementById('sModalSubjectRole').innerText = role || 'Intern';
            document.getElementById('sModalSalutation').innerText = name || 'Candidate';
            document.getElementById('sModalBodyRole').innerText = role || 'Intern';
            document.getElementById('sModalTableRole').innerText = role || 'Intern';
            document.getElementById('sModalTableDuration').innerText = duration || '3 Months';
            var cleanStipend = (stipend || '').replace(/â,¹|â‚¹|\?|₹|Rs\.|INR/g, '').trim();
            var modalStipendHtml = 'Unpaid';
            if (cleanStipend) {
                if (!cleanStipend.toLowerCase().includes('month') && !cleanStipend.toLowerCase().includes('unpaid') && !cleanStipend.toLowerCase().includes('fixed')) {
                    cleanStipend = cleanStipend + ' / month';
                }
                modalStipendHtml = '<i class="fa-solid fa-indian-rupee-sign" style="font-size:12px; margin-right:3px;"></i> ' + cleanStipend;
            }
            document.getElementById('sModalTableStipend').innerHTML = modalStipendHtml;
            document.getElementById('sModalTableJoining').innerText = joining || '';
            document.getElementById('sModalTableLoc').innerText = jobLoc || loc || '';
            if (joining) {
                var jd = new Date(joining);
                if (!isNaN(jd.getTime())) {
                    var dl = new Date(jd.getTime() - (3 * 24 * 60 * 60 * 1000));
                    document.getElementById('sModalTableValidTill').innerText = dl.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: 'numeric' });
                } else {
                    document.getElementById('sModalTableValidTill').innerText = joining;
                }
            } else {
                var validDate = new Date(); validDate.setDate(validDate.getDate() + 14); var months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']; var day = ('0' + validDate.getDate()).slice(-2); document.getElementById('sModalTableValidTill').innerText = day + ' ' + months[validDate.getMonth()] + ' ' + validDate.getFullYear();
            }
            document.getElementById('sModalHrName').innerText = hr || 'HR & Talent Team';
            document.getElementById('studentPrintModal').style.display = 'flex';
        }
        function closeStudentModal(e) {
            document.getElementById('studentPrintModal').style.display = 'none';
        }

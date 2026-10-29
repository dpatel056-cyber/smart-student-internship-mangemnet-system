// SIMS - Company Student Details Script
function formatTechnologyTags() {
            var techContainers = document.querySelectorAll('.technology-tags');
            techContainers.forEach(function (container) {
                if (container.getAttribute('data-formatted') === 'true') {
                    return;
                }
                var rawText = (container.textContent || '').trim();
                if (!rawText) return;
                var tags = rawText.split(/[,،]+/).map(function (item) {
                    return item.trim();
                }).filter(function (item) {
                    return item.length > 0;
                });
                if (tags.length > 0) {
                    container.innerHTML = '';
                    tags.forEach(function (tag) {
                        var span = document.createElement('span');
                        span.className = 'tech-tag';
                        span.textContent = tag;
                        container.appendChild(span);
                    });
                    container.setAttribute('data-formatted', 'true');
                }
            });
        }
        function openTab(id, button) {
            document.querySelectorAll('.tab-content').forEach(function (x) { x.classList.remove('active'); });
            document.querySelectorAll('.profile-tab').forEach(function (x) { x.classList.remove('active'); });
            var section = document.getElementById(id);
            if (section) section.classList.add('active');
            if (button) button.classList.add('active');
            window.scrollTo({ top: 0, behavior: 'smooth' });
            if (id === 'projects') {
                formatTechnologyTags();
            }
        }
        document.addEventListener('DOMContentLoaded', function () {
            formatTechnologyTags();
        });

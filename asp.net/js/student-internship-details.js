function openApplyModal() {
            var modal = document.getElementById('applyModalOverlay');
            if (modal) {
                modal.style.display = 'flex';
            }
        }
        function closeApplyModal() {
            var modal = document.getElementById('applyModalOverlay');
            if (modal) {
                modal.style.display = 'none';
            }
        }
        // Close on clicking outside
        window.onclick = function (event) {
            var modal = document.getElementById('applyModalOverlay');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        };

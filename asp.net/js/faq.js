/**
 * FAQ Page JavaScript - SIMS
 * Public Panel Frequently Asked Questions
 */

var currentCategory = 'all';

function initFaqAccordion() {
    document.querySelectorAll('.faq-question').forEach(function (btn) {
        btn.addEventListener('click', function () {
            var item = this.closest('.faq-item');
            var icon = this.querySelector('i');
            var isOpen = item.classList.contains('open');

            // Close sibling open items
            document.querySelectorAll('.faq-item.open').forEach(function (openItem) {
                if (openItem !== item) {
                    openItem.classList.remove('open');
                    var openIcon = openItem.querySelector('.faq-question i');
                    if (openIcon) {
                        openIcon.classList.remove('fa-minus');
                        openIcon.classList.add('fa-plus');
                    }
                }
            });

            item.classList.toggle('open', !isOpen);
            if (icon) {
                icon.classList.toggle('fa-plus', isOpen);
                icon.classList.toggle('fa-minus', !isOpen);
            }
        });
    });
}

function filterFaqs() {
    var items = document.querySelectorAll('.faq-item');
    var visibleCount = 0;

    items.forEach(function (item) {
        var cat = item.getAttribute('data-category');
        var matchesCat = (currentCategory === 'all' || cat === currentCategory);

        if (matchesCat) {
            item.style.display = '';
            visibleCount++;
        } else {
            item.style.display = 'none';
        }
    });

    var emptyEl = document.getElementById('faqEmptyState');
    if (emptyEl) {
        emptyEl.style.display = visibleCount === 0 ? 'block' : 'none';
    }
}

document.addEventListener('DOMContentLoaded', function () {
    initFaqAccordion();

    // Open first FAQ item by default
    var firstItem = document.querySelector('.faq-item');
    if (firstItem) {
        firstItem.classList.add('open');
        var firstIcon = firstItem.querySelector('.faq-question i');
        if (firstIcon) {
            firstIcon.classList.remove('fa-plus');
            firstIcon.classList.add('fa-minus');
        }
    }

    // Category Tab Clicks
    document.querySelectorAll('.faq-cat-btn').forEach(function (btn) {
        btn.addEventListener('click', function () {
            document.querySelectorAll('.faq-cat-btn').forEach(function (b) {
                b.classList.remove('active');
            });
            this.classList.add('active');
            currentCategory = this.getAttribute('data-cat') || 'all';
            filterFaqs();
        });
    });
});

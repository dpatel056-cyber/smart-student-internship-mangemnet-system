document.addEventListener('DOMContentLoaded', () => {
  const filterTabs = Array.from(document.querySelectorAll('.filter-tab'));
  const storyCards = Array.from(document.querySelectorAll('.story-card'));
  const viewMoreBtn = document.getElementById('viewMoreBtn');
  const storiesEmpty = document.getElementById('storiesEmpty');
  const storiesGrid = document.getElementById('storiesGrid');

  if (!storyCards.length) return;

  const EXTRA_START = 4;
  let currentFilter = 'all';
  let expanded = false;

  function setViewMoreLabel() {
    if (!viewMoreBtn) return;
    viewMoreBtn.innerHTML = expanded
      ? 'View Less Stories <i class="fa-solid fa-chevron-up"></i>'
      : 'View More Stories <i class="fa-solid fa-chevron-down"></i>';
    viewMoreBtn.classList.toggle('expanded', expanded);
  }

  function applyFilter() {
    let visibleCount = 0;
    let matchedCount = 0;

    storyCards.forEach((card) => {
      const categories = String(card.dataset.category || '').split(/\s+/).filter(Boolean);
      const matches = currentFilter === 'all' || categories.includes(currentFilter);

      if (!matches) {
        card.style.display = 'none';
        card.classList.remove('hidden-story');
        return;
      }

      matchedCount += 1;
      visibleCount += 1;
      card.style.display = '';

      if (!expanded && matchedCount > EXTRA_START) {
        card.classList.add('hidden-story');
      } else {
        card.classList.remove('hidden-story');
      }
    });

    if (viewMoreBtn) {
      viewMoreBtn.style.display = matchedCount > EXTRA_START ? 'inline-flex' : 'none';
      setViewMoreLabel();
    }

    if (storiesEmpty) {
      storiesEmpty.style.display = visibleCount === 0 ? 'block' : 'none';
    }
  }

  filterTabs.forEach((tab) => {
    tab.addEventListener('click', () => {
      filterTabs.forEach((t) => t.classList.remove('active'));
      tab.classList.add('active');
      currentFilter = tab.dataset.filter || 'all';
      expanded = false;
      setViewMoreLabel();
      applyFilter();
      storiesGrid?.scrollIntoView({ behavior: 'smooth', block: 'start' });
    });
  });

  if (viewMoreBtn) {
    viewMoreBtn.addEventListener('click', () => {
      expanded = !expanded;
      setViewMoreLabel();
      applyFilter();
      if (!expanded) {
        storiesGrid?.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  }

  applyFilter();
});

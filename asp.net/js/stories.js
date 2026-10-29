document.addEventListener('DOMContentLoaded', () => {
  const filterTabs = Array.from(document.querySelectorAll('.filter-tab'));
  const storyCards = Array.from(document.querySelectorAll('.story-card'));
  const viewMoreBtn = document.getElementById('ImageButton2');
  const viewLessBtn = document.getElementById('btnViewLessStories');
  const storiesEmpty = document.getElementById('storiesEmpty');
  const storiesGrid = document.getElementById('storiesGrid');
  const viewMoreWrap = document.querySelector('.view-more-wrap');

  if (!storyCards.length) return;

  const EXTRA_START = 6;
  let currentFilter = 'all';
  let expanded = false;

  function applyFilter() {
    let matchedCount = 0;
    let visibleCount = 0;

    storyCards.forEach((card) => {
      const catAttr = (card.dataset.category || '').toLowerCase().trim();
      const categories = catAttr.split(/[,\s]+/).filter(Boolean);

      const matches = (currentFilter === 'all') ||
                      categories.includes(currentFilter.toLowerCase()) ||
                      catAttr.includes(currentFilter.toLowerCase());

      const parentSpan = (card.parentElement && card.parentElement.tagName === 'SPAN' && card.parentElement !== storiesGrid)
        ? card.parentElement
        : null;

      if (!matches) {
        card.style.display = 'none';
        card.classList.remove('hidden-story');
        if (parentSpan) parentSpan.style.display = 'none';
        return;
      }

      matchedCount += 1;

      if (!expanded && matchedCount > EXTRA_START) {
        card.classList.add('hidden-story');
        card.style.display = 'none';
        if (parentSpan) parentSpan.style.display = 'none';
      } else {
        card.classList.remove('hidden-story');
        card.style.display = 'flex';
        if (parentSpan) parentSpan.style.display = '';
        visibleCount += 1;
      }
    });

    const hasMore = matchedCount > EXTRA_START;

    if (viewMoreWrap) {
      viewMoreWrap.style.display = hasMore ? 'block' : 'none';
    }

    const moreBtn = document.getElementById('ImageButton2');
    const lessBtn = document.getElementById('btnViewLessStories');

    if (moreBtn && lessBtn) {
      if (!hasMore) {
        moreBtn.classList.remove('stories-btn-visible');
        moreBtn.classList.add('stories-btn-hidden');
        moreBtn.style.setProperty('display', 'none', 'important');

        lessBtn.classList.remove('stories-btn-visible');
        lessBtn.classList.add('stories-btn-hidden');
        lessBtn.style.setProperty('display', 'none', 'important');
      } else if (expanded) {
        // VIEW MORE CLICKED -> HIDE MORE BUTTON, SHOW LESS BUTTON!
        moreBtn.classList.remove('stories-btn-visible');
        moreBtn.classList.add('stories-btn-hidden');
        moreBtn.style.setProperty('display', 'none', 'important');

        lessBtn.classList.remove('stories-btn-hidden');
        lessBtn.classList.add('stories-btn-visible');
        lessBtn.style.setProperty('display', 'inline-block', 'important');
      } else {
        // INITIAL OR VIEW LESS CLICKED -> SHOW MORE BUTTON, HIDE LESS BUTTON!
        moreBtn.classList.remove('stories-btn-hidden');
        moreBtn.classList.add('stories-btn-visible');
        moreBtn.style.setProperty('display', 'inline-block', 'important');

        lessBtn.classList.remove('stories-btn-visible');
        lessBtn.classList.add('stories-btn-hidden');
        lessBtn.style.setProperty('display', 'none', 'important');
      }
    } else if (moreBtn) {
      if (hasMore && !expanded) {
        moreBtn.classList.remove('stories-btn-hidden');
        moreBtn.classList.add('stories-btn-visible');
        moreBtn.style.setProperty('display', 'inline-block', 'important');
      } else {
        moreBtn.classList.remove('stories-btn-visible');
        moreBtn.classList.add('stories-btn-hidden');
        moreBtn.style.setProperty('display', 'none', 'important');
      }
    }

    if (storiesEmpty) {
      storiesEmpty.style.display = visibleCount === 0 ? 'block' : 'none';
    }
  }

  function handleToggleStories(e, action) {
    if (e) {
      if (typeof e.preventDefault === 'function') e.preventDefault();
      if (typeof e.stopPropagation === 'function') e.stopPropagation();
    }
    if (action === 'more') {
      expanded = true;
      applyFilter();
      const firstNewCard = storyCards[EXTRA_START];
      if (firstNewCard && typeof firstNewCard.scrollIntoView === 'function') {
        firstNewCard.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
      }
    } else {
      expanded = false;
      applyFilter();
      if (storiesGrid && typeof storiesGrid.scrollIntoView === 'function') {
        storiesGrid.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    }
    return false;
  }

  // Make globally available for inline OnClientClick
  window.handleToggleStories = handleToggleStories;
  window.handleViewMoreStories = (e) => handleToggleStories(e, 'more');

  filterTabs.forEach((tab) => {
    tab.addEventListener('click', () => {
      filterTabs.forEach((t) => t.classList.remove('active'));
      tab.classList.add('active');
      currentFilter = tab.dataset.filter || 'all';
      expanded = false;
      applyFilter();
    });
  });

  const moreBtn = document.getElementById('ImageButton2');
  if (moreBtn) {
    moreBtn.addEventListener('click', (e) => handleToggleStories(e, 'more'));
  }
  const lessBtn = document.getElementById('btnViewLessStories');
  if (lessBtn) {
    lessBtn.addEventListener('click', (e) => handleToggleStories(e, 'less'));
  }

  applyFilter();
});

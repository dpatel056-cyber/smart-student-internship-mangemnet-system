// notifications.js – renders notification list and updates badge in real time
// Assumes existence of GlobalStore (store-extensions.js) with addNotification, getNotifications, markNotificationRead

(function() {
  document.addEventListener('DOMContentLoaded', () => {
    const badgeEl = document.getElementById('notifBadge');
    const listContainer = document.getElementById('ntList');
    if (!badgeEl || !listContainer) return;

    const session = (() => { try { return JSON.parse(localStorage.getItem('simsSession')) || {}; } catch (e) { return {}; } })();
    const currentUserId = session.email || '';

    function renderList() {
      const notifs = GlobalStore.getNotifications({ userId: currentUserId });
      const unread = notifs.filter(n => !n.read);
      badgeEl.textContent = unread.length;
      badgeEl.style.display = unread.length > 0 ? 'inline-block' : 'none';
      listContainer.innerHTML = notifs.map(n => {
        const titlePart = n.title ? `<strong>${n.title}</strong><br>` : '';
        const readClass = n.read ? 'read' : 'unread';
        return `<li class="notification-item ${readClass}" data-id="${n.id}" data-link="${n.link || ''}">
          ${titlePart}<span class="msg">${n.message}</span>
          <div class="time">${new Date(n.date).toLocaleString()}</div>
        </li>`;
      }).join('');
      listContainer.querySelectorAll('.notification-item').forEach(li => {
        li.addEventListener('click', () => {
          const id = li.dataset.id;
          GlobalStore.markNotificationRead(id);
          const link = li.dataset.link;
          if (link) window.location.href = link;
        });
      });
    }
    renderList();
    window.addEventListener('storage', e => { if (e.key === 'SIMS_NOTIFICATIONS_DATA') renderList(); });
    window.initNotifications = renderList;
  });
})();

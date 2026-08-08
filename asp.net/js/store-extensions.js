// Store Extensions – notifications, settings, unread message flags
// This file augments the existing GlobalStore (global-store.js) with additional helper methods.
// All methods update localStorage and trigger a synthetic 'storage' event for real‑time sync.

(function() {
    if (!window.GlobalStore) {
        console.error('GlobalStore not found – store-extensions.js must be loaded after global-store.js');
        return;
    }

    // ---------- Notification API ----------
    window.GlobalStore.addNotification = function({ id, userId, title = '', message = '', type = 'info', read = false, date = new Date().toISOString() }) {
        const stored = localStorage.getItem('SIMS_NOTIFICATIONS_DATA');
        const notifications = stored ? JSON.parse(stored) : [];
        const notif = {
            id: id || Date.now() + '_' + Math.random().toString(36).substr(2, 5),
            userId,
            title,
            message,
            type,
            read,
            date
        };
        notifications.push(notif);
        localStorage.setItem('SIMS_NOTIFICATIONS_DATA', JSON.stringify(notifications));
        window.dispatchEvent(new Event('storage'));
        return notif;
    };

    window.GlobalStore.getNotifications = function(filter = {}) {
        const stored = localStorage.getItem('SIMS_NOTIFICATIONS_DATA');
        const notifications = stored ? JSON.parse(stored) : [];
        return notifications.filter(n => {
            for (const key in filter) {
                if (filter[key] != null && n[key] !== filter[key]) return false;
            }
            return true;
        });
    };

    window.GlobalStore.markNotificationRead = function(id) {
        const stored = localStorage.getItem('SIMS_NOTIFICATIONS_DATA');
        if (!stored) return false;
        const notifications = JSON.parse(stored);
        const idx = notifications.findIndex(n => n.id === id);
        if (idx === -1) return false;
        notifications[idx].read = true;
        localStorage.setItem('SIMS_NOTIFICATIONS_DATA', JSON.stringify(notifications));
        window.dispatchEvent(new Event('storage'));
        return true;
    };

    // ---------- Settings API ----------
    window.GlobalStore.updateSetting = function(key, value) {
        const stored = localStorage.getItem('SIMS_SETTINGS_DATA');
        const settings = stored ? JSON.parse(stored) : {};
        settings[key] = value;
        localStorage.setItem('SIMS_SETTINGS_DATA', JSON.stringify(settings));
        window.dispatchEvent(new Event('storage'));
        return settings;
    };

    window.GlobalStore.getSettings = function() {
        const stored = localStorage.getItem('SIMS_SETTINGS_DATA');
        return stored ? JSON.parse(stored) : {};
    };

    // ---------- Unread Message Flags ----------
    // Structure: { contactId: true }
    window.GlobalStore.setUnreadMessage = function(contactId, flag = true) {
        const stored = localStorage.getItem('SIMS_UNREAD_MSG_DATA');
        const map = stored ? JSON.parse(stored) : {};
        map[contactId] = flag;
        localStorage.setItem('SIMS_UNREAD_MSG_DATA', JSON.stringify(map));
        window.dispatchEvent(new Event('storage'));
        return map;
    };

    window.GlobalStore.isMessageUnread = function(contactId) {
        const stored = localStorage.getItem('SIMS_UNREAD_MSG_DATA');
        if (!stored) return false;
        const map = JSON.parse(stored);
        return !!map[contactId];
    };

    window.GlobalStore.clearUnreadMessage = function(contactId) {
        return window.GlobalStore.setUnreadMessage(contactId, false);
    };
})();

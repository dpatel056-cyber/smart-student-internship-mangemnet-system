document.addEventListener('DOMContentLoaded', () => {

  const contactListEl = document.getElementById('contactList');
  const chatBody = document.getElementById('chatBody');
  const chatName = document.getElementById('chatName');
  const chatStatus = document.getElementById('chatStatus');
  const chatAvatar = document.getElementById('chatAvatar');
  const msgInput = document.getElementById('msgInput');
  const sendBtn = document.getElementById('sendBtn');
  const emojiBtn = document.getElementById('emojiBtn');
  const emojiPicker = document.getElementById('emojiPicker');
  const emojiGrid = document.getElementById('emojiGrid');
  const attachBtn = document.getElementById('attachBtn');
  const chatSearchInput = document.getElementById('chatSearchInput');

  let session = {};
  try { session = JSON.parse(localStorage.getItem('simsSession')) || {}; } catch(e){}
  const myId = session.email || 'me';
  const myName = session.name || 'Me';

  let activeContactId = null;

  // Build contact list from GlobalStore applications
  function buildContacts() {
    const apps = window.GlobalStore ? window.GlobalStore.getApplications() : [];
    const contacts = [];
    const seen = new Set();
    // Helper to fetch unread status from store
    const getUnread = (id) => window.GlobalStore && typeof window.GlobalStore.isMessageUnread === 'function' ? window.GlobalStore.isMessageUnread(id) : false;

    if (session.role === 'student') {
      // Student sees companies they applied to
      apps.filter(a => a.studentEmail === myId).forEach(a => {
        if (!seen.has(a.company)) {
          seen.add(a.company);
          contacts.push({ id: a.company, name: a.company, avatar: a.company.substring(0,2).toUpperCase(), bg: '#eff6ff', color: '#2563eb', status: 'online', lastMsg: 'Click to chat', time: '', unread: getUnread(a.company) });
        }
      });
    } else if (session.role === 'company') {
      // Company sees students who applied
      apps.filter(a => a.company === myName).forEach(a => {
        if (!seen.has(a.studentEmail)) {
          seen.add(a.studentEmail);
          contacts.push({ id: a.studentEmail, name: a.studentName, avatar: a.studentName.substring(0,2).toUpperCase(), bg: '#f0fdf4', color: '#16a34a', status: 'online', lastMsg: 'Click to chat', time: '', unread: getUnread(a.studentEmail) });
        }
      });
    } else {
      // Admin sees all users
      const users = window.GlobalStore ? window.GlobalStore.getUsers() : [];
      users.forEach(u => {
        if (u.email !== myId) contacts.push({ id: u.email, name: u.name, avatar: u.name.substring(0,2).toUpperCase(), bg: '#faf5ff', color: '#7c3aed', status: 'online', lastMsg: 'Click to chat', time: '', unread: getUnread(u.email) });
      });
    }

    // Add some default contacts if empty
    if (contacts.length === 0) {
      contacts.push({ id: 'support@sims.com', name: 'SIMS Support', avatar: 'SS', bg: '#eff6ff', color: '#2563eb', status: 'online', lastMsg: 'How can we help?', time: '', unread: false });
    }
    return contacts;
  }

  function renderContacts(filter = '') {
    const contacts = buildContacts().filter(c => c.name.toLowerCase().includes(filter.toLowerCase()));
    if (!contactListEl) return;
    contactListEl.innerHTML = contacts.map(c => `
      <li class="msg-contact ${activeContactId === c.id ? 'active' : ''}" data-id="${c.id}">
        <div class="msg-avatar" style="background:${c.bg};color:${c.color};">${c.avatar}<span class="msg-status-dot ${c.status}"></span></div>
        <div class="msg-contact-info">
          <p class="msg-contact-name">${c.name}</p>
          <p class="msg-contact-preview">${getLastMsg(c.id) || c.lastMsg}</p>
        </div>
        <div style="display:flex; flex-direction:column; align-items:flex-end; gap:4px;">
          ${c.unread ? '<div class="msg-unread-dot"></div>' : ''}
        </div>
      </li>
    `).join('');

    contactListEl.querySelectorAll('.msg-contact').forEach(el => {
      el.addEventListener('click', () => openChat(el.dataset.id));
    });
  }

  function getLastMsg(contactId) {
    const msgs = getConversation(contactId);
    if (msgs.length > 0) return msgs[msgs.length-1].text.substring(0, 30) + '...';
    return null;
  }

  function getConversation(contactId) {
    const allMsgs = window.GlobalStore ? window.GlobalStore.getMessages() : [];
    return allMsgs.filter(m =>
      (m.from === myId && m.to === contactId) ||
      (m.from === contactId && m.to === myId)
    );
  }

  function openChat(id) {
    activeContactId = id;
    const contact = buildContacts().find(c => c.id === id);
    if (!contact) return;

    if (chatName) chatName.textContent = contact.name;
    if (chatStatus) { chatStatus.textContent = '● Online'; chatStatus.style.color = '#16a34a'; }
    if (chatAvatar) { chatAvatar.textContent = contact.avatar; chatAvatar.style.background = contact.bg; chatAvatar.style.color = contact.color; }
    // Clear unread flag for this conversation
    if (window.GlobalStore) {
      window.GlobalStore.clearUnreadMessage(contact.id);
    }

    renderMessages();
    renderContacts(chatSearchInput ? chatSearchInput.value : '');
  }

  function renderMessages() {
    if (!chatBody) return;
    const msgs = getConversation(activeContactId);
    if (msgs.length === 0) {
      chatBody.innerHTML = `<div style="text-align:center; color:#94a3b8; padding-top:80px;"><i class="fa-regular fa-comment-dots" style="font-size:40px; display:block; margin-bottom:12px;"></i><p>No messages yet. Start the conversation!</p></div>`;
      return;
    }
    chatBody.innerHTML = msgs.map(m => `
      <div class="msg-bubble-wrap ${m.from === myId ? 'sent' : ''}">
        <div>
          <div class="msg-bubble">${m.text}</div>
          <div class="msg-bubble-time">${new Date(m.date).toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit', hour12: true })}
            ${m.from === myId ? '<i class="fa-solid fa-check-double msg-seen-icon"></i>' : ''}
          </div>
        </div>
      </div>
    `).join('');
    chatBody.scrollTop = chatBody.scrollHeight;
  }

  function sendMessage() {
    if (!activeContactId) return;
    const text = msgInput ? msgInput.value.trim() : '';
    if (!text) return;

    if (window.GlobalStore) {
      window.GlobalStore.addMessage({ from: myId, to: activeContactId, text: text });
      // Mark recipient's conversation as unread for them
      window.GlobalStore.setUnreadMessage(activeContactId, true);
    }

    if (msgInput) msgInput.value = '';
    renderMessages();
    renderContacts(chatSearchInput ? chatSearchInput.value : '');
    if (emojiPicker) emojiPicker.classList.remove('show');
  }

  if (sendBtn) sendBtn.addEventListener('click', sendMessage);
  if (msgInput) msgInput.addEventListener('keydown', (e) => { if (e.key === 'Enter' && !e.shiftKey) sendMessage(); });

  const emojis = ['😀','😂','😍','🤔','👍','🎉','🔥','❤️','✅','🙌','💪','😎','🤝','📌','⭐','🚀','💡','🎯','👋','😊','🥳','💬','📎','✨'];
  if (emojiGrid) {
    emojiGrid.innerHTML = emojis.map(e => `<span class="msg-emoji-item">${e}</span>`).join('');
    emojiGrid.addEventListener('click', (e) => {
      if (e.target.classList.contains('msg-emoji-item') && msgInput) {
        msgInput.value += e.target.textContent;
        msgInput.focus();
      }
    });
  }
  if (emojiBtn) emojiBtn.addEventListener('click', () => { if (emojiPicker) emojiPicker.classList.toggle('show'); });

  document.addEventListener('click', (e) => {
    if (emojiPicker && !emojiPicker.contains(e.target) && e.target !== emojiBtn && !(emojiBtn && emojiBtn.contains(e.target))) {
      emojiPicker.classList.remove('show');
    }
  });

  if (attachBtn) {
    attachBtn.addEventListener('click', () => {
      if (!activeContactId) return;
      if (window.GlobalStore) window.GlobalStore.addMessage({ from: myId, to: activeContactId, text: '📎 Resume.pdf' });
      renderMessages();
    });
  }

  if (chatSearchInput) chatSearchInput.addEventListener('input', () => renderContacts(chatSearchInput.value));

  // Init
  renderContacts();

  window.addEventListener('storage', (e) => {
    if (e.key === 'SIMS_MESSAGES_DATA') { renderMessages(); renderContacts(chatSearchInput ? chatSearchInput.value : ''); }
    if (e.key === 'SIMS_APPLICATIONS_DATA') renderContacts(chatSearchInput ? chatSearchInput.value : '');
  });
});

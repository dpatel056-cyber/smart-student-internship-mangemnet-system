/* ui-utils.js – shared UI helpers for SIMS
 * -------------------------------------------------
 * Provides:
 *  - toast(message, type='info')
 *  - modal({title, body, confirmText, cancelText, onConfirm, onCancel})
 *  - debounce(func, wait)
 *  - avatar(name) – returns initials and optional colors
 *  - paginate(array, pageSize, pageNum) – returns slice for tables
 */

// Simple toast implementation (uses existing #dashToast element if present)
export function toast(msg, type = 'info') {
  const toastEl = document.getElementById('dashToast');
  const msgEl = document.getElementById('dashToastMsg');
  if (!toastEl || !msgEl) return;
  msgEl.textContent = msg;
  // set colors based on type
  const colors = {
    info: '#2563eb',
    success: '#16a34a',
    warning: '#ca8a04',
    error: '#dc2626',
  };
  toastEl.style.background = `${colors[type] || colors.info}33`;
  toastEl.style.display = 'flex';
  toastEl.style.opacity = '1';
  // auto‑hide after 3 seconds
  setTimeout(() => {
    toastEl.style.opacity = '0';
    setTimeout(() => { toastEl.style.display = 'none'; }, 300);
  }, 3000);
}

// Generic modal – creates a temporary overlay and removes it on close
export function modal({title = '', body = '', confirmText = 'OK', cancelText = null, onConfirm = null, onCancel = null}) {
  const overlay = document.createElement('div');
  overlay.className = 'modal-overlay';
  overlay.style = `position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.4);display:flex;align-items:center;justify-content:center;z-index:10000`;

  const box = document.createElement('div');
  box.className = 'modal-box';
  box.style = 'background:#fff;border-radius:12px;padding:24px;max-width:400px;width:100%;box-shadow:0 4px 12px rgba(0,0,0,0.15)';

  const h = document.createElement('h3');
  h.textContent = title;
  h.style = 'margin-top:0;margin-bottom:12px;font-size:1.2rem;color:#111';
  box.appendChild(h);

  const content = document.createElement('div');
  content.innerHTML = body;
  content.style = 'margin-bottom:20px;font-size:0.95rem;color:#333';
  box.appendChild(content);

  const actions = document.createElement('div');
  actions.style = 'display:flex;gap:12px;justify-content:flex-end';

  const okBtn = document.createElement('button');
  okBtn.className = 'btn btn-primary';
  okBtn.textContent = confirmText;
  okBtn.onclick = () => { if (onConfirm) onConfirm(); document.body.removeChild(overlay); };
  actions.appendChild(okBtn);

  if (cancelText) {
    const cancelBtn = document.createElement('button');
    cancelBtn.className = 'btn btn-ghost';
    cancelBtn.textContent = cancelText;
    cancelBtn.onclick = () => { if (onCancel) onCancel(); document.body.removeChild(overlay); };
    actions.appendChild(cancelBtn);
  }
  box.appendChild(actions);
  overlay.appendChild(box);
  document.body.appendChild(overlay);
}

// Debounce – useful for search inputs
export function debounce(fn, wait) {
  let timeout;
  return (...args) => {
    clearTimeout(timeout);
    timeout = setTimeout(() => fn.apply(this, args), wait);
  };
}

// Avatar helper – returns HTML string with initials and colors
export function avatar(name) {
  const initials = name ? name.split(' ').map(w => w[0]).join('').substring(0, 2).toUpperCase() : 'U';
  const bg = '#eff6ff'; // default – can be overridden by caller
  const color = '#2563eb';
  return `<div class="msg-avatar" style="background:${bg};color:${color};">${initials}</div>`;
}

// Simple pagination helper
export function paginate(arr, pageSize, pageNum) {
  const start = pageSize * (pageNum - 1);
  return arr.slice(start, start + pageSize);
}

// Export everything as named exports (ESM). If the project uses script tags, you can expose via window.
if (typeof window !== 'undefined') {
  window.UIUtils = { toast, modal, debounce, avatar, paginate };
}

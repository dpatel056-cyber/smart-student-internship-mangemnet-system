// offers.js – CRUD and export for offer letters
(function() {
  const storageKey = 'SIMS_OFFERS_DATA';

  // Helper to persist offers
  function saveOffers(data) {
    if (window.GlobalStore && GlobalStore.setOffers) {
      GlobalStore.setOffers(data);
    } else {
      localStorage.setItem(storageKey, JSON.stringify(data));
    }
    // trigger storage event for real‑time sync
    localStorage.setItem(storageKey, localStorage.getItem(storageKey));
  }

  function loadOffers() {
    if (window.GlobalStore && GlobalStore.getOffers) {
      return GlobalStore.getOffers() || [];
    }
    const raw = localStorage.getItem(storageKey);
    return raw ? JSON.parse(raw) : [];
  }

  // Public API
  window.OffersAPI = {
    addOffer(offer) {
      const offers = loadOffers();
      offer.id = offer.id || Date.now().toString();
      offers.push(offer);
      saveOffers(offers);
    },
    updateOffer(id, updates) {
      const offers = loadOffers();
      const idx = offers.findIndex(o => o.id === id);
      if (idx === -1) return;
      offers[idx] = { ...offers[idx], ...updates };
      saveOffers(offers);
    },
    getOffers() {
      return loadOffers();
    },
    // Export helpers
    exportCSV() {
      const offers = loadOffers();
      if (!offers.length) return alert('No offers to export');
      const headers = Object.keys(offers[0]);
      const csvRows = [headers.join(','), ...offers.map(o => headers.map(h => `\"${(o[h] ?? '').toString().replace(/\"/g, '\"\"')}`).join(','))];
      const blob = new Blob([csvRows.join('\n')], { type: 'text/csv;charset=utf-8;' });
      const url = URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = url;
      a.download = 'offers.csv';
      a.click();
      URL.revokeObjectURL(url);
    },
    exportPDF() {
      // Simple PDF generation using the browser print API (print the offer list)
      const win = window.open('', '_blank');
      const offers = loadOffers();
      if (!offers.length) return alert('No offers to export');
      const tableHtml = `<table style=\"width:100%;border-collapse:collapse;\">` +
        `<thead><tr>${Object.keys(offers[0]).map(h => `<th style='border:1px solid #ddd;padding:6px;'>${h}</th>`).join('')}</tr></thead>` +
        `<tbody>` + offers.map(o => `<tr>${Object.values(o).map(v => `<td style='border:1px solid #ddd;padding:6px;'>${v}</td>`).join('')}</tr>`).join('') + `</tbody></table>`;
      win.document.write('<html><head><title>Offers PDF</title></head><body>');
      win.document.write('<h2>Offer Letters</h2>');
      win.document.write(tableHtml);
      win.document.write('</body></html>');
      win.document.close();
      win.focus();
      win.print();
    }
  };
})();

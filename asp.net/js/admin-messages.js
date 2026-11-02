/* =====================================================
   SCRIPT FOR admin-messages.aspx
   ===================================================== */
document.addEventListener('DOMContentLoaded', function () {
    // Auto-scroll to bottom of conversation
    var chatScroll = document.getElementById('chatMessagesScroll');
    if (chatScroll) {
        chatScroll.scrollTop = chatScroll.scrollHeight;
    }
});

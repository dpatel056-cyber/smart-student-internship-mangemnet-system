/* =====================================================
   SCRIPT FOR admin-messages.aspx (WhatsApp Mini Chat)
   ===================================================== */
document.addEventListener('DOMContentLoaded', function () {
    // 1. Auto-scroll to bottom of conversation
    var chatScroll = document.getElementById('chatMessagesScroll');
    if (chatScroll) {
        chatScroll.scrollTop = chatScroll.scrollHeight;
    }

    // Elements
    var btnEmojiToggle = document.getElementById('btnEmojiToggle');
    var emojiDrawer = document.getElementById('emojiDrawer');
    var btnCloseEmoji = document.getElementById('btnCloseEmoji');
    var txtMessage = document.querySelector('.chat-input-field');

    var btnAttachToggle = document.getElementById('btnAttachToggle');
    var attachDrawer = document.getElementById('attachDrawer');
    var btnAttachPhoto = document.getElementById('btnAttachPhoto');
    var btnAttachDoc = document.getElementById('btnAttachDoc');
    var btnAttachContact = document.getElementById('btnAttachContact');

    var fuChatAttachment = document.querySelector('.chat-file-upload-hidden');
    var attachmentPreviewBar = document.getElementById('attachmentPreviewBar');
    var lblAttachedFileName = document.getElementById('lblAttachedFileName');
    var btnClearAttachment = document.getElementById('btnClearAttachment');

    // 2. Emoji Drawer Toggle
    if (btnEmojiToggle && emojiDrawer) {
        btnEmojiToggle.addEventListener('click', function (e) {
            e.stopPropagation();
            if (attachDrawer) attachDrawer.classList.remove('open');
            emojiDrawer.classList.toggle('open');
        });
    }

    if (btnCloseEmoji && emojiDrawer) {
        btnCloseEmoji.addEventListener('click', function () {
            emojiDrawer.classList.remove('open');
        });
    }

    // Insert Emoji into Message field
    var emojiButtons = document.querySelectorAll('.emoji-item');
    emojiButtons.forEach(function (btn) {
        btn.addEventListener('click', function (e) {
            e.stopPropagation();
            var emoji = this.getAttribute('data-emoji') || this.innerText;
            if (txtMessage) {
                var start = txtMessage.selectionStart || txtMessage.value.length;
                var end = txtMessage.selectionEnd || txtMessage.value.length;
                var val = txtMessage.value;
                txtMessage.value = val.substring(0, start) + emoji + val.substring(end);
                txtMessage.focus();
                var newPos = start + emoji.length;
                if (txtMessage.setSelectionRange) {
                    txtMessage.setSelectionRange(newPos, newPos);
                }
            }
        });
    });

    // 3. Attachment Drawer Toggle
    if (btnAttachToggle && attachDrawer) {
        btnAttachToggle.addEventListener('click', function (e) {
            e.stopPropagation();
            if (emojiDrawer) emojiDrawer.classList.remove('open');
            attachDrawer.classList.toggle('open');
        });
    }

    // Trigger File Upload for Photos & Docs
    function openFileUpload(acceptType) {
        if (attachDrawer) attachDrawer.classList.remove('open');
        if (fuChatAttachment) {
            fuChatAttachment.accept = acceptType || '';
            fuChatAttachment.click();
        }
    }

    if (btnAttachPhoto) {
        btnAttachPhoto.addEventListener('click', function () {
            openFileUpload('image/*');
        });
    }
    if (btnAttachDoc) {
        btnAttachDoc.addEventListener('click', function () {
            openFileUpload('.pdf,.doc,.docx,.xls,.xlsx,.txt,.zip');
        });
    }
    if (btnAttachContact) {
        btnAttachContact.addEventListener('click', function () {
            if (attachDrawer) attachDrawer.classList.remove('open');
            if (txtMessage) {
                txtMessage.value += ' [Contact: Admin Support - admin@sims.com] ';
                txtMessage.focus();
            }
        });
    }

    // Handle File Selection
    if (fuChatAttachment) {
        fuChatAttachment.addEventListener('change', function () {
            if (this.files && this.files.length > 0) {
                var file = this.files[0];
                var isImg = file.type && file.type.startsWith('image/');
                var prefix = isImg ? '📷 Photo: ' : '📄 Document: ';
                if (lblAttachedFileName) {
                    lblAttachedFileName.textContent = prefix + file.name + ' (' + Math.round(file.size / 1024) + ' KB)';
                }
                if (attachmentPreviewBar) {
                    attachmentPreviewBar.classList.add('show');
                }
            }
        });
    }

    // Clear Attachment
    if (btnClearAttachment) {
        btnClearAttachment.addEventListener('click', function () {
            if (fuChatAttachment) {
                fuChatAttachment.value = '';
            }
            if (attachmentPreviewBar) {
                attachmentPreviewBar.classList.remove('show');
            }
        });
    }

    // 4. Close drawers when clicking outside
    document.addEventListener('click', function (e) {
        if (emojiDrawer && emojiDrawer.classList.contains('open')) {
            if (!emojiDrawer.contains(e.target) && e.target !== btnEmojiToggle && !btnEmojiToggle.contains(e.target)) {
                emojiDrawer.classList.remove('open');
            }
        }
        if (attachDrawer && attachDrawer.classList.contains('open')) {
            if (!attachDrawer.contains(e.target) && e.target !== btnAttachToggle && !btnAttachToggle.contains(e.target)) {
                attachDrawer.classList.remove('open');
            }
        }
    });
});

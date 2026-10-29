<%@ Page Title="Live Messages & Chat" Language="C#" MasterPageFile="~/StudentPanel/student.Master" AutoEventWireup="true" CodeBehind="student-messages.aspx.cs" Inherits="asp.net.student_messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/student-messages.css?v=2" />
    <script src="../js/student-messages.js" defer></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="chat-page-container">
        <!-- Header -->
        <div class="chat-page-header">
            <div>
                <h1><i class="fa-solid fa-comments"></i> Live Messenger &amp; Direct Chat</h1>
                <p>Real-time communication with hiring companies and SIMS platform administrators.</p>
            </div>
            <span class="contacts-count-badge">
                <i class="fa-solid fa-users"></i>
                <asp:Label ID="lblTotalContacts" runat="server">0 Contacts</asp:Label>
            </span>
        </div>

        <!-- Messenger Frame -->
        <div class="messenger-frame">
            <!-- Sidebar: Contacts List -->
            <div class="messenger-sidebar">
                <div class="sidebar-header">
                    <div class="sidebar-search-box">
                        <div class="sidebar-search-input-wrap">
                            <i class="fa-solid fa-magnifying-glass"></i>
                            <asp:TextBox ID="txtSearchContact" runat="server" CssClass="sidebar-search-input" placeholder="Search company or admin..."></asp:TextBox>
                        </div>
                        <asp:LinkButton ID="btnSearchContact" runat="server" CssClass="sidebar-search-btn" OnClick="btnSearchContact_Click">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </asp:LinkButton>
                        <asp:LinkButton ID="btnClearSearch" runat="server" CssClass="sidebar-clear-btn" OnClick="btnClearSearch_Click">
                            <i class="fa-solid fa-xmark"></i>
                        </asp:LinkButton>
                    </div>
                    <div class="filter-pills">
                        <asp:LinkButton ID="btnFilterAll" runat="server" CommandArgument="all" OnClick="FilterContacts_Click" CssClass="filter-pill active"></asp:LinkButton>
                        <asp:LinkButton ID="btnFilterCompanies" runat="server" CommandArgument="Company" OnClick="FilterContacts_Click" CssClass="filter-pill"></asp:LinkButton>
                        <asp:LinkButton ID="btnFilterAdmin" runat="server" CommandArgument="Admin" OnClick="FilterContacts_Click" CssClass="filter-pill"></asp:LinkButton>
                    </div>
                </div>

                <div class="contacts-scroll-list">
                    <asp:Repeater ID="rptContacts" runat="server" OnItemCommand="rptContacts_ItemCommand">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkContact" runat="server"
                                CommandName="SelectContact"
                                CommandArgument='<%# Eval("Id") + "|" + Eval("Name") + "|" + Eval("Role") + "|" + Eval("Subtitle") + "|" + Eval("Email") + "|" + Eval("AvatarUrl") %>'
                                CssClass='<%# "contact-item" + (IsSelectedContact(Eval("Email").ToString()) ? " active" : "") %>'>
                                <div class="contact-avatar-wrapper">
                                    <%# !string.IsNullOrEmpty(Eval("AvatarUrl") as string) ? 
                                        "<img src='" + ResolveUrl(Eval("AvatarUrl").ToString()) + "' class='contact-avatar-img' width='46' height='46' />" : 
                                        "<div class='contact-avatar " + (Eval("Role").ToString() == "Admin" ? "avatar-admin" : "avatar-company") + "'>" + Eval("Initials") + "</div>" %>
                                    <div class="online-dot"></div>
                                </div>
                                <div class="contact-info">
                                    <div class="contact-top-row">
                                        <span class="contact-name"><%# Eval("Name") %></span>
                                        <span class='<%# "contact-time" + (Convert.ToInt32(Eval("UnreadCount")) > 0 ? " unread-time" : "") %>'><%# Eval("LastTime") %></span>
                                    </div>
                                    <div class="contact-bottom-row">
                                        <span class='<%# "contact-snippet" + (Convert.ToInt32(Eval("UnreadCount")) > 0 ? " unread-snippet" : "") %>'><%# Eval("LastMessage") %></span>
                                        <div class="contact-badges">
                                            <span class='<%# "role-pill-mini " + (Eval("Role").ToString() == "Admin" ? "role-ad" : "role-co") %>'>
                                                <%# Eval("Role").ToString() == "Admin" ? "ADM" : "CMP" %>
                                            </span>
                                            <%# Convert.ToInt32(Eval("UnreadCount")) > 0 ? "<span class='unread-badge'>" + Eval("UnreadCount") + "</span>" : "" %>
                                        </div>
                                    </div>
                                </div>
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:Repeater>
                    <asp:Panel ID="pnlNoContacts" runat="server" Visible="false" CssClass="contacts-state">
                        <i class="fa-regular fa-folder-open"></i>
                        <p>No contacts found.</p>
                    </asp:Panel>
                </div>
            </div>

            <!-- Chat Pane -->
            <div class="messenger-chat-pane">
                <!-- Empty state (When no contact is selected) -->
                <asp:Panel ID="pnlEmptyState" runat="server" CssClass="chat-empty-state">
                    <div class="empty-illustration"><i class="fa-brands fa-whatsapp"></i></div>
                    <h3>SIMS WhatsApp Messenger</h3>
                    <p>Select any registered company or administrator from the left panel to open your live conversation history and send direct messages.</p>
                    <div class="whatsapp-encrypted-note">
                        <i class="fa-solid fa-lock"></i>
                        <span>End-to-end encrypted &bull; Powered by DummyJSON Chat API</span>
                    </div>
                </asp:Panel>

                <!-- Active conversation (When a contact is selected) -->
                <asp:Panel ID="pnlChatActive" runat="server" Visible="false" CssClass="chat-active-view">
                    <!-- Chat Header -->
                    <div class="chat-header">
                        <div class="chat-header-user">
                            <div class="contact-avatar-wrapper">
                                <asp:Image ID="imgActiveAvatar" runat="server" CssClass="contact-avatar-img" Width="46" Height="46" Visible="false" />
                                <asp:Label ID="lblActiveAvatar" runat="server" CssClass="contact-avatar"></asp:Label>
                                <div class="online-dot"></div>
                            </div>
                            <div>
                                <div class="chat-header-name">
                                    <asp:Label ID="lblActiveName" runat="server"></asp:Label>
                                    <asp:Label ID="lblActiveRole" runat="server" CssClass="role-pill-mini"></asp:Label>
                                </div>
                                <div class="chat-header-sub">
                                    <span class="online-status-text"><i class="fa-solid fa-circle"></i> online</span>
                                    <span>&bull;</span>
                                    <asp:Label ID="lblActiveSubtitle" runat="server"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="chat-header-actions">
                            <asp:LinkButton ID="btnRefresh" runat="server" CssClass="chat-header-btn" OnClick="btnRefresh_Click">
                                <i class="fa-solid fa-rotate"></i>
                            </asp:LinkButton>
                        </div>
                    </div>

                    <!-- Chat Messages Scroll Area -->
                    <div class="chat-messages-scroll" id="chatMessagesScroll">
                        <div class="chat-date-divider">Today</div>

                        <asp:Panel ID="pnlNoMessages" runat="server" Visible="false" CssClass="chat-empty-messages">
                            <i class="fa-regular fa-comments"></i>
                            <p>No conversation yet. Send a message below to start chatting!</p>
                        </asp:Panel>

                        <asp:Repeater ID="rptMessages" runat="server">
                            <ItemTemplate>
                                <div class='<%# (bool)Eval("IsOutgoing") ? "chat-bubble-row outgoing" : "chat-bubble-row incoming" %>'>
                                    <div class="chat-bubble">
                                        <%# !(bool)Eval("IsOutgoing") ? "<div class='bubble-sender-name'>" + Eval("SenderName") + " <span class='bubble-role-tag'>(" + Eval("SenderRole") + ")</span></div>" : "" %>
                                        <%# RenderAttachment(Eval("AttachmentUrl"), Eval("AttachmentType"), Eval("AttachmentName")) %>
                                        <%# !string.IsNullOrWhiteSpace(Eval("MessageText") as string) ? "<span class='bubble-text'>" + Server.HtmlEncode(Eval("MessageText").ToString()) + "</span>" : "" %>
                                        <div class="bubble-meta">
                                            <span><%# Eval("SentTime") %></span>
                                            <%# (bool)Eval("IsOutgoing") ? "<i class='fa-solid fa-check-double'></i>" : "" %>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- Input Bar -->
                    <asp:Panel ID="pnlInputBar" runat="server" DefaultButton="btnSend" CssClass="chat-input-container">
                        <asp:Label ID="lblSendError" runat="server" CssClass="chat-send-error" Visible="false"></asp:Label>

                        <!-- WhatsApp Emoji Picker Drawer -->
                        <div class="emoji-picker-drawer" id="emojiDrawer">
                            <div class="emoji-drawer-header">
                                <span>Emojis</span>
                                <button type="button" class="btn-drawer-close" id="btnCloseEmoji"><i class="fa-solid fa-xmark"></i></button>
                            </div>
                            <div class="emoji-grid">
                                <button type="button" class="emoji-item" data-emoji="😊">😊</button>
                                <button type="button" class="emoji-item" data-emoji="👍">👍</button>
                                <button type="button" class="emoji-item" data-emoji="❤️">❤️</button>
                                <button type="button" class="emoji-item" data-emoji="😂">😂</button>
                                <button type="button" class="emoji-item" data-emoji="🎉">🎉</button>
                                <button type="button" class="emoji-item" data-emoji="👋">👋</button>
                                <button type="button" class="emoji-item" data-emoji="🙏">🙏</button>
                                <button type="button" class="emoji-item" data-emoji="👏">👏</button>
                                <button type="button" class="emoji-item" data-emoji="🔥">🔥</button>
                                <button type="button" class="emoji-item" data-emoji="✨">✨</button>
                                <button type="button" class="emoji-item" data-emoji="💼">💼</button>
                                <button type="button" class="emoji-item" data-emoji="🎓">🎓</button>
                                <button type="button" class="emoji-item" data-emoji="🚀">🚀</button>
                                <button type="button" class="emoji-item" data-emoji="💡">💡</button>
                                <button type="button" class="emoji-item" data-emoji="✅">✅</button>
                                <button type="button" class="emoji-item" data-emoji="📌">📌</button>
                                <button type="button" class="emoji-item" data-emoji="📞">📞</button>
                                <button type="button" class="emoji-item" data-emoji="✉️">✉️</button>
                                <button type="button" class="emoji-item" data-emoji="📅">📅</button>
                                <button type="button" class="emoji-item" data-emoji="💯">💯</button>
                                <button type="button" class="emoji-item" data-emoji="🤝">🤝</button>
                                <button type="button" class="emoji-item" data-emoji="🏢">🏢</button>
                                <button type="button" class="emoji-item" data-emoji="📝">📝</button>
                                <button type="button" class="emoji-item" data-emoji="🎯">🎯</button>
                            </div>
                        </div>

                        <!-- WhatsApp Attachment Menu -->
                        <div class="attach-menu-drawer" id="attachDrawer">
                            <button type="button" class="attach-menu-item" id="btnAttachPhoto">
                                <span class="attach-icon-circle attach-photo"><i class="fa-solid fa-image"></i></span>
                                <span>Photos &amp; Media</span>
                            </button>
                            <button type="button" class="attach-menu-item" id="btnAttachDoc">
                                <span class="attach-icon-circle attach-doc"><i class="fa-solid fa-file-lines"></i></span>
                                <span>Document</span>
                            </button>
                        </div>

                        <!-- Hidden File Upload for attachment -->
                        <asp:FileUpload ID="fuChatAttachment" runat="server" CssClass="chat-file-upload-hidden" />
                        <div class="attachment-preview-bar" id="attachmentPreviewBar">
                            <i class="fa-solid fa-paperclip"></i>
                            <span id="lblAttachedFileName">No file selected</span>
                            <button type="button" class="btn-clear-attachment" id="btnClearAttachment"><i class="fa-solid fa-xmark"></i></button>
                        </div>

                        <div class="chat-input-bar">
                            <button type="button" class="chat-input-icon-btn" id="btnEmojiToggle">
                                <i class="fa-regular fa-face-smile"></i>
                            </button>
                            <button type="button" class="chat-input-icon-btn" id="btnAttachToggle">
                                <i class="fa-solid fa-paperclip"></i>
                            </button>
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="chat-input-field" placeholder="Type a message... (Press Enter to send)" autocomplete="off"></asp:TextBox>
                            <asp:LinkButton ID="btnSend" runat="server" CssClass="btn-chat-send" OnClick="btnSend_Click">
                                <i class="fa-solid fa-paper-plane"></i>
                            </asp:LinkButton>
                        </div>
                    </asp:Panel>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>

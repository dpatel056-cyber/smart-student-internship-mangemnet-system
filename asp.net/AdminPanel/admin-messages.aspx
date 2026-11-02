<%@ Page Title="Live Messages & Chat" Language="C#" MasterPageFile="~/AdminPanel/admin.Master" AutoEventWireup="true" CodeBehind="admin-messages.aspx.cs" Inherits="asp.net.css.admin_messages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="../css/admin-messages.css?v=110" />
    <script src="../js/admin-messages.js" defer></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="chat-page-container">

        <!-- Header -->
        <div class="chat-page-header">
            <div>
                <h1><i class="fa-solid fa-comments"></i> Live Messenger &amp; Direct Chat</h1>
                <p>Direct communication with registered students and companies.</p>
            </div>

            <span class="contacts-count-badge">
                <i class="fa-solid fa-users"></i>
                <asp:Label ID="lblTotalContacts" runat="server">0 Contacts</asp:Label>
            </span>
        </div>

        <div class="messenger-frame">

            <!-- Contact Sidebar -->
            <div class="messenger-sidebar">

                <div class="sidebar-header">

                    <div class="msg-search-wrapper">
                        <i class="fa-solid fa-magnifying-glass search-icon"></i>

                        <asp:TextBox ID="txtSearch" runat="server"
                            CssClass="msg-search-input"
                            placeholder="Search contacts...">
                        </asp:TextBox>
                    </div>

                    <div class="msg-filter-actions-row">

                        <div class="msg-select-wrapper">

                            <asp:DropDownList ID="ddlRole" runat="server"
                                CssClass="msg-select"
                                AutoPostBack="true"
                                OnSelectedIndexChanged="ddlRole_SelectedIndexChanged">

                                <asp:ListItem Text="All Contacts" Value="all"></asp:ListItem>
                                <asp:ListItem Text="Students" Value="Student"></asp:ListItem>
                                <asp:ListItem Text="Companies" Value="Company"></asp:ListItem>

                            </asp:DropDownList>

                            <i class="fa-solid fa-chevron-down select-chevron"></i>

                        </div>

                        <div class="msg-action-buttons">

                            <asp:ImageButton ID="btnSearch" runat="server"
                                ImageUrl="~/image_button/btn_admin_search.png"
                                Height="34"
                                CssClass="admin-img-btn admin-img-btn-search"
                                OnClick="btnSearch_Click"
                                CausesValidation="false" />

                            <asp:ImageButton ID="btnClearFilters" runat="server"
                                ImageUrl="~/image_button/btn_admin_clear_filters.png"
                                Height="34"
                                CssClass="admin-img-btn admin-img-btn-clear"
                                OnClick="btnClearFilters_Click"
                                CausesValidation="false" />

                        </div>
                    </div>
                </div>

                <!-- Contact List -->
                <div class="contacts-scroll-list">

                    <asp:DataList ID="dlContacts" runat="server"
                        RepeatLayout="Flow"
                        RepeatDirection="Horizontal"
                        CssClass="contacts-datalist"
                        OnItemCommand="dlContacts_ItemCommand">

                        <ItemTemplate>

                            <asp:LinkButton ID="lnkContact" runat="server"
                                CommandName="SelectContact"
                                CommandArgument='<%# Eval("Id") + "|" + Eval("Name") + "|" + Eval("Role") + "|" + Eval("Subtitle") + "|" + Eval("Email") + "|" + Eval("AvatarUrl") %>'
                                CssClass='<%# "contact-item" + (IsSelectedContact(Eval("Email").ToString()) ? " active" : "") %>'
                                CausesValidation="false">

                                <div class="contact-avatar-wrapper">

                                    <asp:Image ID="imgContact" runat="server"
                                        CssClass="contact-avatar-img"
                                        Width="46"
                                        Height="46"
                                        ImageUrl='<%# Eval("AvatarUrl") %>' />

                                </div>

                                <div class="contact-info">

                                    <div class="contact-top-row">

                                        <span class="contact-name">
                                            <%#: Eval("Name") %>
                                        </span>

                                        <span class='<%# "contact-time" + (Convert.ToInt32(Eval("UnreadCount")) > 0 ? " unread-time" : "") %>'>
                                            <%#: Eval("LastTime") %>
                                        </span>

                                    </div>

                                    <div class="contact-bottom-row">

                                        <span class='<%# "contact-snippet" + (Convert.ToInt32(Eval("UnreadCount")) > 0 ? " unread-snippet" : "") %>'>
                                            <%#: Eval("LastMessage") %>
                                        </span>

                                        <div class="contact-badges">

                                            <span class='<%# "role-pill-mini " + (Eval("Role").ToString() == "Student" ? "role-st" : "role-co") %>'>
                                                <%# Eval("Role").ToString() == "Student" ? "STU" : "CMP" %>
                                            </span>

                                            <%# Convert.ToInt32(Eval("UnreadCount")) > 0 ? "<span class='unread-badge'>" + Eval("UnreadCount") + "</span>" : "" %>

                                        </div>
                                    </div>
                                </div>

                            </asp:LinkButton>

                        </ItemTemplate>

                    </asp:DataList>

                    <div id="pnlNoContacts" runat="server"
                        visible="false"
                        class="contacts-state">

                        <i class="fa-regular fa-folder-open"></i>
                        <p>No contacts found.</p>

                    </div>

                </div>
            </div>

            <!-- Chat Panel -->
            <div class="messenger-chat-pane">

                <!-- Empty Chat -->
                <div id="pnlEmptyState" runat="server"
                    class="chat-empty-state">

                    <div class="empty-illustration">
                        <i class="fa-solid fa-comments"></i>
                    </div>

                    <h3>SIMS Messenger</h3>

                    <p>Select any student or company to start a conversation.</p>

                    <div class="whatsapp-encrypted-note">
                        <i class="fa-solid fa-lock"></i>
                        <span>Student &amp; Company Communication</span>
                    </div>

                </div>

                <!-- Active Chat -->
                <div id="pnlChatActive" runat="server"
                    visible="false"
                    class="chat-active-view">

                    <!-- Chat Header -->
                    <div class="chat-header">

                        <div class="chat-header-user">

                            <div class="contact-avatar-wrapper">

                                <asp:DataList ID="DataListActiveAvatar" runat="server" RepeatLayout="Flow" ShowHeader="false" ShowFooter="false">
                                    <ItemTemplate>
                                        <asp:Image ID="imgActiveAvatar" runat="server"
                                            CssClass="contact-avatar-img"
                                            Width="46"
                                            Height="46"
                                            ImageUrl='<%# Eval("AvatarUrl") %>' />
                                    </ItemTemplate>
                                </asp:DataList>

                            </div>

                            <div>

                                <div class="chat-header-name">

                                    <asp:Label ID="lblActiveName" runat="server"></asp:Label>

                                    <asp:Label ID="lblActiveRole" runat="server"
                                        CssClass="role-pill-mini"></asp:Label>

                                </div>

                                <div class="chat-header-sub">

                                    <asp:Label ID="lblActiveSubtitle" runat="server"></asp:Label>

                                </div>

                            </div>
                        </div>
                    </div>

                    <!-- Messages -->
                    <div class="chat-messages-scroll" id="chatMessagesScroll">

                        <div class="chat-date-divider">Conversation</div>

                        <div id="pnlNoMessages" runat="server"
                            visible="false"
                            class="chat-empty-messages">

                            <i class="fa-regular fa-comments"></i>
                            <p>No conversation yet. Send a message to start chatting!</p>

                        </div>

                        <asp:DataList ID="dlMessages" runat="server"
                            RepeatLayout="Flow"
                            RepeatDirection="Horizontal"
                            CssClass="chat-messages-datalist">

                            <ItemTemplate>

                                <div class='<%# (bool)Eval("IsOutgoing") ? "chat-bubble-row outgoing" : "chat-bubble-row incoming" %>'>

                                    <div class="chat-bubble"><%# !(bool)Eval("IsOutgoing") ? "<div class='bubble-sender-name'>" + Server.HtmlEncode(Eval("SenderName").ToString()) + " <span class='bubble-role-tag'>(" + Server.HtmlEncode(Eval("SenderRole").ToString()) + ")</span></div>" : "" %><span class="bubble-text"><%#: Eval("MessageText") %></span><span class="bubble-meta"><span><%#: Eval("SentTime") %></span><%# (bool)Eval("IsOutgoing") ? "<i class='fa-solid fa-check-double'></i>" : "" %></span></div>

                                </div>

                            </ItemTemplate>

                        </asp:DataList>

                    </div>

                    <!-- Message Input -->
                    <div id="pnlInputBar" runat="server"
                        class="chat-input-container">

                        <asp:Label ID="lblSendError" runat="server"
                            CssClass="chat-send-error"
                            Visible="false">
                        </asp:Label>

                        <div class="chat-input-bar">

                            <asp:TextBox ID="txtMessage" runat="server"
                                CssClass="chat-input-field"
                                placeholder="Type a message..."
                                autocomplete="off">
                            </asp:TextBox>

                            <asp:LinkButton ID="btnSend" runat="server"
                                CssClass="btn-chat-send"
                                OnClick="btnSend_Click"
                                CausesValidation="false">

                                <i class="fa-solid fa-paper-plane"></i>

                            </asp:LinkButton>

                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>

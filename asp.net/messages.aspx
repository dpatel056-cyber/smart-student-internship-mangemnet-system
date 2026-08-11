<%@ Page Title="" Language="C#" MasterPageFile="~/student.Master" AutoEventWireup="true" CodeBehind="messages.aspx.cs" Inherits="asp.net.messages" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/internship-module.css">
<link rel="stylesheet" href="../css/communication-module.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="pm-breadcrumb" style="margin-bottom: 24px;">
   <a href="student-dashboard.html">Dashboard</a><i class="fa-solid fa-chevron-right"></i>
   <span class="current">Messages</span>
 </div>

 <div class="msg-layout">

   <!-- Contact List Sidebar -->
   <div class="msg-sidebar">
     <div class="msg-sidebar-header">
       <h3>Conversations</h3>
       <div class="msg-search">
         <i class="fa-solid fa-magnifying-glass"></i>
         <input type="text" id="chatSearchInput" placeholder="Search chats...">
       </div>
     </div>
     <ul class="msg-contact-list" id="contactList">
       <!-- Injected by JS -->
     </ul>
   </div>

   <!-- Chat Window -->
   <div class="msg-chat" id="chatWindow">
     <div class="msg-chat-header" id="chatHeader">
       <div class="msg-avatar" id="chatAvatar" style="background:#eff6ff;color:#2563eb;">G</div>
       <div>
         <h4 class="msg-chat-name" id="chatName">Select a conversation</h4>
         <p class="msg-chat-status" id="chatStatus">Choose a contact to start chatting</p>
       </div>
     </div>

     <div class="msg-chat-body" id="chatBody">
       <div style="text-align:center; color:#94a3b8; padding-top: 100px;">
         <i class="fa-solid fa-comments" style="font-size:48px; margin-bottom:16px; display:block;"></i>
         <p>Select a conversation to view messages</p>
       </div>
     </div>

     <div class="msg-chat-input" style="position:relative;">
       <div class="msg-emoji-picker" id="emojiPicker">
         <div class="msg-emoji-grid" id="emojiGrid"></div>
       </div>
       <button class="msg-input-btn msg-emoji-btn" id="emojiBtn" title="Emoji"><i class="fa-regular fa-face-smile"></i></button>
       <button class="msg-input-btn msg-attach-btn" id="attachBtn" title="Attach file"><i class="fa-solid fa-paperclip"></i></button>
       <input type="text" class="msg-input" id="msgInput" placeholder="Type a message...">
       <button class="msg-input-btn msg-send-btn" id="sendBtn" title="Send"><i class="fa-solid fa-paper-plane"></i></button>
     </div>
   </div>

 </div>
</asp:Content>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.Message" %>
<%@ page import="com.example.campusskillhub.model.Task" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat - Campus Skill Hub</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/messages.css">
</head>
<body>
<%
    String role = (String) session.getAttribute("userRole");
    String dashboardUrl = request.getContextPath() +
            "/" + role + "/dashboard";
    Task task = (Task) request.getAttribute("task");
    int userId = (Integer) session.getAttribute("userId");
    int receiverId = 0;
    if(task != null) {
        receiverId = (task.getPostedBy() == userId) ?
                task.getClaimedBy() : task.getPostedBy();
    }
%>
<div class="sidebar">
    <div class="sidebar-header">
        <h2>Campus Skill Hub</h2>
        <p><%= role.substring(0,1).toUpperCase() +
                role.substring(1) %> Panel</p>
    </div>
    <nav class="sidebar-nav">
        <a href="<%= dashboardUrl %>"
           class="nav-item">Dashboard</a>
        <a href="${pageContext.request.contextPath}/tasks/list"
           class="nav-item">Tasks</a>
        <a href="${pageContext.request.contextPath}/messages/inbox"
           class="nav-item active">Messages</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="topbar">
        <h1>Chat</h1>
        <a href="${pageContext.request.contextPath}/messages/inbox"
           style="color:#3498db; text-decoration:none;
                  font-size:14px;">
            ← Back to Inbox
        </a>
    </div>

    <% if(task != null) { %>
    <!-- Task Info Box -->
    <div class="section" style="margin-bottom:16px;
         padding:16px;">
        <strong>Task:</strong> <%= task.getTitle() %> &nbsp;|&nbsp;
        <strong>Status:</strong>
        <span class="badge" style="background:#e8f4fd;
              color:#2980b9;">
            <%= task.getStatus().replace("_"," ")
                    .toUpperCase() %>
        </span>
    </div>

    <!-- Chat Messages -->
    <div class="section chat-container">
        <div class="chat-messages" id="chatMessages">
            <%
                List<Message> messages = (List<Message>)
                        request.getAttribute("messages");
                if(messages == null || messages.isEmpty()) { %>
            <p class="no-data">
                No messages yet. Start the conversation!
            </p>
            <% } else {
                for(Message msg : messages) {
                    boolean isMe = msg.getSenderId() == userId;
            %>
            <div class="message-bubble
                <%= isMe ? "message-sent" : "message-received" %>">
                <div class="message-sender">
                    <%= isMe ? "You" : msg.getSenderName() %>
                </div>
                <div class="message-text">
                    <%= msg.getMessage() %>
                </div>
                <div class="message-time">
                    <%= msg.getSentAt().toString()
                            .substring(0, 16) %>
                    <% if(isMe) { %>
                    <%= msg.isRead() ? " ✓✓" : " ✓" %>
                    <% } %>
                </div>
            </div>
            <%  }
            } %>
        </div>

        <!-- Message Input -->
        <% if(receiverId > 0) { %>
        <div class="chat-input-area">
            <form action="${pageContext.request.contextPath}/messages/send"
                  method="post"
                  style="display:flex; gap:12px;">
                <input type="hidden" name="taskId"
                       value="<%= task.getTaskId() %>">
                <input type="hidden" name="receiverId"
                       value="<%= receiverId %>">
                <input type="text" name="message"
                       placeholder="Type your message..."
                       required
                       style="flex:1; padding:12px;
                       border:1.5px solid #ddd;
                       border-radius:8px; font-size:14px;
                       outline:none;"
                       id="messageInput">
                <button type="submit" class="btn-primary"
                        style="width:auto; padding:12px 24px;">
                    Send
                </button>
            </form>
        </div>
        <% } else { %>
        <p style="color:#e74c3c; padding:16px;">
            Cannot send message — task has no tutor
            assigned yet.
        </p>
        <% } %>
    </div>
    <% } %>
</div>

<script>
    // Auto scroll to bottom of chat
    var chatMessages = document.getElementById('chatMessages');
    if(chatMessages) {
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }
</script>
</body>
</html>
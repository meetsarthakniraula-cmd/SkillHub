<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.campusskillhub.model.Message" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Messages - Campus Skill Hub</title>
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
           class="nav-item">
            <% if(role.equals("student")) { %>
            My Tasks
            <% } else if(role.equals("tutor")) { %>
            Available Tasks
            <% } else { %>
            All Tasks
            <% } %>
        </a>
        <a href="${pageContext.request.contextPath}/messages/inbox"
           class="nav-item active">
            Messages
            <% int unread = (Integer) request
                    .getAttribute("unreadCount");
                if(unread > 0) { %>
            <span class="badge-count">
                    <%= unread %>
                </span>
            <% } %>
        </a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="topbar">
        <h1>Messages</h1>
        <span>Welcome,
            <%= session.getAttribute("userName") %>
        </span>
    </div>

    <div class="section">
        <h2>Your Conversations</h2>
        <%
            List<Message> conversations = (List<Message>)
                    request.getAttribute("conversations");
            int userId = (Integer)
                    session.getAttribute("userId");
        %>
        <% if(conversations == null ||
                conversations.isEmpty()) { %>
        <p class="no-data">
            No messages yet. Messages appear when
            you start chatting about a task.
        </p>
        <% } else { %>
        <div class="conversation-list">
            <%
                List<Integer> shownTasks = new ArrayList<>();
                for(Message msg : conversations) {
                    if(!shownTasks.contains(msg.getTaskId())) {
                        shownTasks.add(msg.getTaskId());
                        boolean isSender =
                                msg.getSenderId() == userId;
                        String otherPerson = isSender ?
                                msg.getReceiverName() :
                                msg.getSenderName();
            %>
            <div class="conversation-item">
                <div class="conv-info">
                    <strong><%= msg.getTaskTitle() %></strong>
                    <span>with <%= otherPerson %></span>
                    <p class="conv-preview">
                        <%= msg.getMessage().length() > 50 ?
                                msg.getMessage()
                                .substring(0, 50) + "..." :
                                msg.getMessage() %>
                    </p>
                </div>
                <div class="conv-action">
                    <a href="${pageContext.request.contextPath}/messages/chat?taskId=<%= msg.getTaskId() %>"
                       class="btn-approve">
                        Open Chat
                    </a>
                    <span class="conv-time">
                        <%= msg.getSentAt().toString()
                                .substring(0, 16) %>
                    </span>
                </div>
            </div>
            <%  }
            } %>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
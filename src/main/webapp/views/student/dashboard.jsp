<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard - Campus Skill Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="sidebar">
    <div class="sidebar-header">
        <h2>Campus Skill Hub</h2>
        <p>Student Panel</p>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/student/dashboard"
           class="nav-item active">Dashboard</a>
        <a href="${pageContext.request.contextPath}/tasks/list"
           class="nav-item">My Tasks</a>
        <a href="${pageContext.request.contextPath}/messages/inbox"
           class="nav-item">Messages</a>
        <a href="${pageContext.request.contextPath}/profile/view"
           class="nav-item">My Profile</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>


    </nav>
</div>
<div class="main-content">
    <div class="topbar">
        <h1>Student Dashboard</h1>
        <span>Welcome, <%= session.getAttribute("userName") %></span>
    </div>
    <div class="stats-grid">
        <div class="stat-card blue">
            <h3>Post A Task</h3>
            <p style="font-size:14px; color:#7f8c8d;
               margin-bottom:16px;">
                Need help? Post a task!</p>
            <a href="${pageContext.request.contextPath}/tasks/add"
               class="btn-approve"
               style="display:inline-block;">
                + Post Task</a>
        </div>
        <div class="stat-card green">
            <h3>My Tasks</h3>
            <p style="font-size:14px; color:#7f8c8d;
               margin-bottom:16px;">
                View all your posted tasks</p>
            <a href="${pageContext.request.contextPath}/tasks/list"
               class="btn-approve"
               style="display:inline-block;
               background:#27ae60;">
                View Tasks</a>
        </div>
    </div>
</div>
</body>
</html>
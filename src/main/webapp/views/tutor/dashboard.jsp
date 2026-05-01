<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Tutor Dashboard - Campus Skill Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="sidebar">
    <div class="sidebar-header">
        <h2>Campus Skill Hub</h2>
        <p>Tutor Panel</p>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/tutor/dashboard"
           class="nav-item active">Dashboard</a>
        <a href="${pageContext.request.contextPath}/tasks/list"
           class="nav-item">Available Tasks</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>
<div class="main-content">
    <div class="topbar">
        <h1>Tutor Dashboard</h1>
        <span>Welcome, <%= session.getAttribute("userName") %></span>
    </div>
    <div class="stats-grid">
        <div class="stat-card blue">
            <h3>Browse Tasks</h3>
            <p style="font-size:14px; color:#7f8c8d;
               margin-bottom:16px;">
                Find tasks matching your skills</p>
            <a href="${pageContext.request.contextPath}/tasks/list"
               class="btn-approve"
               style="display:inline-block;">
                Browse Tasks</a>
        </div>
    </div>
</div>
</body>
</html>
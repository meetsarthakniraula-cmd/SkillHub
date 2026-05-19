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
        <a href="${pageContext.request.contextPath}/tutor/mytasks"
           class="nav-item">My Claimed Tasks</a>
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
        <h1>Tutor Dashboard</h1>
        <span>Welcome, <%= session.getAttribute("userName") %></span>
    </div>
    <div class="stats-grid">
        <div class="stat-card blue">
            <h3>Tasks Claimed</h3>
            <p class="stat-number">
                ${myTasksCount}
            </p>
        </div>
        <div class="stat-card green">
            <h3>Average Rating</h3>
            <p class="stat-number">
                <%= request.getAttribute("avgRating") != null ?
                        String.format("%.1f", request.getAttribute("avgRating")) : "0.0" %> ★
            </p>
        </div>
        <div class="stat-card orange">
            <h3>Browse Tasks</h3>
            <p style="font-size:13px; color:#7f8c8d;
               margin-bottom:12px;">Find new tasks</p>
            <a href="${pageContext.request.contextPath}/tasks/list"
               class="btn-approve"
               style="display:inline-block;">
                Browse Now</a>
        </div>
    </div>
</div>
</body>
</html>
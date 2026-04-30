<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>
<div class="main-content">
    <div class="topbar">
        <h1>Student Dashboard</h1>
        <span>Welcome, <%= session.getAttribute("userName") %></span>
    </div>
    <div class="section">
        <h2>Welcome to Campus Skill Hub!</h2>
        <p>You can post tasks and find tutors here.</p>
    </div>
</div>
</body>
</html>
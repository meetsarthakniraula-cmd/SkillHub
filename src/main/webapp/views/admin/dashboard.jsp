<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.User" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("user") == null ||
            !session.getAttribute("userRole").equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Campus Skill Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <h2>Campus Skill Hub</h2>
        <p>Admin Panel</p>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item active">
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="nav-item">
            Manage Users
        </a>
        <a href="${pageContext.request.contextPath}/admin/skills" class="nav-item">
            Manage Skills
        </a>
        <a href="${pageContext.request.contextPath}/profile/view"
           class="nav-item">My Profile</a>
        <a href="${pageContext.request.contextPath}/admin/reports"
           class="nav-item">Reports</a>
        <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
            Logout
        </a>
    </nav>
</div>

<!-- Main Content -->
<div class="main-content">

    <!-- Top Bar -->
    <div class="topbar">
        <h1>Dashboard</h1>
        <span>Welcome, <%= session.getAttribute("userName") %></span>
    </div>

    <!-- Statistics Cards -->
    <div class="stats-grid">
        <div class="stat-card blue">
            <h3>Total Students</h3>
            <p class="stat-number">${totalStudents}</p>
        </div>
        <div class="stat-card green">
            <h3>Total Tutors</h3>
            <p class="stat-number">${totalTutors}</p>
        </div>
        <div class="stat-card orange">
            <h3>Pending Approvals</h3>
            <p class="stat-number">${pendingUsers}</p>
        </div>
        <div class="stat-card purple">
            <h3>Open Tasks</h3>
            <p class="stat-number">${openTasks}</p>
        </div>
    </div>

    <!-- Pending Users Table -->
    <div class="section">
        <h2>Pending Approvals</h2>
        <% List<User> pendingList = (List<User>) request.getAttribute("pendingList"); %>
        <% if(pendingList == null || pendingList.isEmpty()) { %>
        <p class="no-data">No pending approvals at the moment.</p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Department</th>
                <th>Registered</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for(User user : pendingList) { %>
            <tr>
                <td><%= user.getFullName() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getPhone() %></td>
                <td><span class="badge <%= user.getRole() %>">
                        <%= user.getRole() %></span>
                </td>
                <td><%= user.getDepartment() != null ? user.getDepartment() : "-" %></td>
                <td><%= user.getCreatedAt() != null ?
                        user.getCreatedAt().toString().substring(0,10) : "-" %>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/approve?id=<%= user.getUserId() %>"
                       class="btn-approve">Approve</a>
                    <a href="${pageContext.request.contextPath}/admin/delete?id=<%= user.getUserId() %>"
                       class="btn-delete"
                       onclick="return confirm('Are you sure you want to delete this user?')">
                        Delete</a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>

</div>
</body>
</html>
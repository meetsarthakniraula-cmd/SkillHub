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
    <title>Manage Users - Campus Skill Hub</title>
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
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="nav-item active">
            Manage Users
        </a>
        <a href="${pageContext.request.contextPath}/admin/skills" class="nav-item">
            Manage Skills
            <a href="${pageContext.request.contextPath}/admin/reports"
               class="nav-item">Reports</a>
        </a>
        <a href="${pageContext.request.contextPath}/logout" class="nav-item logout">
            Logout
        </a>
    </nav>
</div>

<!-- Main Content -->
<div class="main-content">

    <div class="topbar">
        <h1>Manage Users</h1>
        <span>Welcome, <%= session.getAttribute("userName") %></span>
    </div>

    <div class="section">
        <h2>All Users</h2>
        <% List<User> allUsers = (List<User>) request.getAttribute("allUsers"); %>
        <% if(allUsers == null || allUsers.isEmpty()) { %>
        <p class="no-data">No users registered yet.</p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Department</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for(User user : allUsers) { %>
            <tr>
                <td><%= user.getFullName() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getPhone() %></td>
                <td><span class="badge <%= user.getRole() %>">
                        <%= user.getRole() %></span>
                </td>
                <td><%= user.getDepartment() != null ? user.getDepartment() : "-" %></td>
                <td><span class="badge <%= user.getStatus() %>">
                        <%= user.getStatus() %></span>
                </td>
                <td>
                    <% if(user.getStatus().equals("pending") ||
                            user.getStatus().equals("suspended")) { %>
                    <a href="${pageContext.request.contextPath}/admin/approve?id=<%= user.getUserId() %>"
                       class="btn-approve">Approve</a>
                    <% } %>
                    <% if(user.getStatus().equals("active")) { %>
                    <a href="${pageContext.request.contextPath}/admin/suspend?id=<%= user.getUserId() %>"
                       class="btn-suspend">Suspend</a>
                    <% } %>
                    <a href="${pageContext.request.contextPath}/admin/delete?id=<%= user.getUserId() %>"
                       class="btn-delete"
                       onclick="return confirm('Delete this user permanently?')">
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
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.Skill" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Skills - Campus Skill Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>

<div class="sidebar">
    <div class="sidebar-header">
        <h2>Campus Skill Hub</h2>
        <p>Admin Panel</p>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/admin/dashboard"
           class="nav-item">Dashboard</a>
        <a href="${pageContext.request.contextPath}/admin/users"
           class="nav-item">Manage Users</a>
        <a href="${pageContext.request.contextPath}/admin/skills/list"
           class="nav-item active">Manage Skills</a>
        <a href="${pageContext.request.contextPath}/admin/reports"
           class="nav-item">Reports</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="topbar">
        <h1>Manage Skills</h1>
        <a href="${pageContext.request.contextPath}/admin/skills/add"
           class="btn-approve">+ Add New Skill</a>
    </div>

    <!-- Success Message -->
    <% if(request.getParameter("success") != null) { %>
    <div class="alert-success" style="padding:12px;
             background:#eafaf1; color:#27ae60;
             border-radius:8px; margin-bottom:20px;">
        <% if("added".equals(request.getParameter("success"))) { %>
        Skill added successfully! ✅
        <% } else { %>
        Skill updated successfully! ✅
        <% } %>
    </div>
    <% } %>

    <div class="section">
        <h2>All Skills</h2>
        <% List<Skill> skills = (List<Skill>)
                request.getAttribute("skills"); %>
        <% if(skills == null || skills.isEmpty()) { %>
        <p class="no-data">No skills added yet.</p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>#</th>
                <th>Skill Name</th>
                <th>Description</th>
                <th>Created At</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% int count = 1;
                for(Skill skill : skills) { %>
            <tr>
                <td><%= count++ %></td>
                <td><strong><%= skill.getSkillName() %></strong></td>
                <td><%= skill.getDescription() != null ?
                        skill.getDescription() : "-" %></td>
                <td><%= skill.getCreatedAt() != null ?
                        skill.getCreatedAt().toString()
                        .substring(0,10) : "-" %></td>
                <td>
                    <a href="${pageContext.request.contextPath}/admin/skills/edit?id=<%= skill.getSkillId() %>"
                       class="btn-suspend">Edit</a>
                    <a href="${pageContext.request.contextPath}/admin/skills/delete?id=<%= skill.getSkillId() %>"
                       class="btn-delete"
                       onclick="return confirm('Delete this skill?')">
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
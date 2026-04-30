<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.example.campusskillhub.model.Skill" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Skill Form - Campus Skill Hub</title>
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
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="topbar">
        <h1><%= request.getAttribute("edit") != null ?
                "Edit Skill" : "Add New Skill" %></h1>
    </div>

    <div class="section" style="max-width: 600px;">

        <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <% Skill skill = (Skill)
                request.getAttribute("skill"); %>

        <form action="${pageContext.request.contextPath}/admin/skills/<%= request.getAttribute("edit") != null ? "edit" : "add" %>"
              method="post">

            <% if(skill != null) { %>
            <input type="hidden" name="skillId"
                   value="<%= skill.getSkillId() %>">
            <% } %>

            <div class="form-group">
                <label for="skillName">Skill Name</label>
                <input type="text" id="skillName"
                       name="skillName"
                       placeholder="e.g. Java Programming"
                       required
                       value="<%= skill != null ?
                           skill.getSkillName() : "" %>">
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description"
                          placeholder="Describe this skill..."
                          rows="4"
                          style="width:100%; padding:12px;
                          border:1.5px solid #ddd;
                          border-radius:8px; font-size:14px;
                          outline:none; resize:vertical;"><%= skill != null && skill.getDescription() != null ?
                        skill.getDescription() : "" %></textarea>
            </div>

            <div style="display:flex; gap:12px;">
                <button type="submit" class="btn-primary"
                        style="width:auto; padding:12px 30px;">
                    <%= request.getAttribute("edit") != null ?
                            "Update Skill" : "Add Skill" %>
                </button>
                <a href="${pageContext.request.contextPath}/admin/skills/list"
                   style="padding:12px 30px;
                   background:#95a5a6; color:white;
                   border-radius:8px; text-decoration:none;
                   font-size:14px; display:inline-block;">
                    Cancel</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
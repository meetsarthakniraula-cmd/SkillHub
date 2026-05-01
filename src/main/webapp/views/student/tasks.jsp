<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.Task" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Tasks - Campus Skill Hub</title>
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
           class="nav-item">Dashboard</a>
        <a href="${pageContext.request.contextPath}/tasks/list"
           class="nav-item active">My Tasks</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="topbar">
        <h1>My Tasks</h1>
        <a href="${pageContext.request.contextPath}/tasks/add"
           class="btn-approve">+ Post New Task</a>
    </div>

    <% if(request.getParameter("success") != null) { %>
    <div style="padding:12px; background:#eafaf1;
             color:#27ae60; border-radius:8px;
             margin-bottom:20px;">
        Task saved successfully! ✅
    </div>
    <% } %>

    <div class="section">
        <h2>All My Posted Tasks</h2>
        <% List<Task> tasks = (List<Task>)
                request.getAttribute("tasks"); %>
        <% if(tasks == null || tasks.isEmpty()) { %>
        <p class="no-data">
            You haven't posted any tasks yet.
            <a href="${pageContext.request.contextPath}/tasks/add">
                Post your first task!</a>
        </p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>Title</th>
                <th>Skill</th>
                <th>Deadline</th>
                <th>Budget</th>
                <th>Status</th>
                <th>Claimed By</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for(Task task : tasks) { %>
            <tr>
                <td><strong><%= task.getTitle() %></strong>
                </td>
                <td><%= task.getSkillName() != null ?
                        task.getSkillName() : "-" %></td>
                <td><%= task.getDeadline() != null ?
                        task.getDeadline().toString() : "-" %>
                </td>
                <td><%= task.getBudget() > 0 ?
                        "Rs. " + task.getBudget() : "Free" %>
                </td>
                <td>
                        <span class="badge"
                              style="background:<%=
                            "open".equals(task.getStatus()) ?
                            "#e8f4fd" :
                            "in_progress".equals(
                                task.getStatus()) ?
                            "#fef9e7" : "#eafaf1" %>;
                                      color:<%=
                            "open".equals(task.getStatus()) ?
                            "#2980b9" :
                            "in_progress".equals(
                                task.getStatus()) ?
                            "#d68910" : "#27ae60" %>;">
                            <%= task.getStatus()
                                    .replace("_", " ")
                                    .toUpperCase() %>
                        </span>
                </td>
                <td><%= task.getClaimedByName() != null ?
                        task.getClaimedByName() : "Not yet" %>
                </td>
                <td>
                    <% if("open".equals(
                            task.getStatus())) { %>
                    <a href="${pageContext.request.contextPath}/tasks/edit?id=<%= task.getTaskId() %>"
                       class="btn-suspend">Edit</a>
                    <a href="${pageContext.request.contextPath}/tasks/delete?id=<%= task.getTaskId() %>"
                       class="btn-delete"
                       onclick="return confirm(
                           'Delete this task?')">
                        Delete</a>
                    <% } %>
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
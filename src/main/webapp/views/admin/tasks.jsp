<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.Task" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>All Tasks - Campus Skill Hub</title>
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
           class="nav-item">Manage Skills</a>
        <a href="${pageContext.request.contextPath}/tasks/list"
           class="nav-item active">All Tasks</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="topbar">
        <h1>All Tasks</h1>
    </div>

    <div class="section">
        <h2>System Tasks</h2>
        <% List<Task> tasks = (List<Task>)
                request.getAttribute("tasks"); %>
        <% if(tasks == null || tasks.isEmpty()) { %>
        <p class="no-data">No tasks posted yet.</p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>Title</th>
                <th>Posted By</th>
                <th>Skill</th>
                <th>Claimed By</th>
                <th>Deadline</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for(Task task : tasks) { %>
            <tr>
                <td><strong><%= task.getTitle() %></strong>
                </td>
                <td><%= task.getPostedByName() %></td>
                <td><%= task.getSkillName() != null ?
                        task.getSkillName() : "-" %></td>
                <td><%= task.getClaimedByName() != null ?
                        task.getClaimedByName() : "-" %></td>
                <td><%= task.getDeadline() != null ?
                        task.getDeadline().toString() : "-" %>
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
                                    .replace("_"," ")
                                    .toUpperCase() %>
                        </span>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/tasks/delete?id=<%= task.getTaskId() %>"
                       class="btn-delete"
                       onclick="return confirm(
                           'Delete this task?')">
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
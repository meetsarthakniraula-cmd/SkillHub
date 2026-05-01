<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.Task" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Tasks - Campus Skill Hub</title>
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
           class="nav-item">Dashboard</a>
        <a href="${pageContext.request.contextPath}/tasks/list"
           class="nav-item active">Available Tasks</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="topbar">
        <h1>Available Tasks</h1>
        <span>Browse and claim tasks</span>
    </div>

    <div class="section">
        <h2>Open Tasks</h2>
        <% List<Task> tasks = (List<Task>)
                request.getAttribute("tasks"); %>
        <% if(tasks == null || tasks.isEmpty()) { %>
        <p class="no-data">
            No open tasks available right now.
        </p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Skill Needed</th>
                <th>Posted By</th>
                <th>Deadline</th>
                <th>Budget</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <% for(Task task : tasks) { %>
            <tr>
                <td><strong><%= task.getTitle() %></strong>
                </td>
                <td style="max-width:200px;">
                    <%= task.getDescription().length() > 80 ?
                            task.getDescription()
                            .substring(0, 80) + "..." :
                            task.getDescription() %>
                </td>
                <td><%= task.getSkillName() != null ?
                        task.getSkillName() : "-" %></td>
                <td><%= task.getPostedByName() %></td>
                <td><%= task.getDeadline() != null ?
                        task.getDeadline().toString() : "-" %>
                </td>
                <td><%= task.getBudget() > 0 ?
                        "Rs. " + task.getBudget() : "Free" %>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/tasks/claim?id=<%= task.getTaskId() %>"
                       class="btn-approve"
                       onclick="return confirm('Claim this task?')">
                        Claim Task</a>
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
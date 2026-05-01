<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.Task" %>
<%@ page import="com.example.campusskillhub.model.Rating" %>
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
        <p>Tutor Panel</p>
    </div>
    <nav class="sidebar-nav">
        <a href="${pageContext.request.contextPath}/tutor/dashboard"
           class="nav-item">Dashboard</a>
        <a href="${pageContext.request.contextPath}/tasks/list"
           class="nav-item">Available Tasks</a>
        <a href="${pageContext.request.contextPath}/tutor/mytasks"
           class="nav-item active">My Claimed Tasks</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="topbar">
        <h1>My Claimed Tasks</h1>
    </div>

    <!-- Tasks Section -->
    <div class="section">
        <h2>Tasks I'm Working On</h2>
        <% List<Task> tasks = (List<Task>)
                request.getAttribute("tasks"); %>
        <% if(tasks == null || tasks.isEmpty()) { %>
        <p class="no-data">
            You haven't claimed any tasks yet.
        </p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>Title</th>
                <th>Posted By</th>
                <th>Skill</th>
                <th>Deadline</th>
                <th>Budget</th>
                <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <% for(Task task : tasks) { %>
            <tr>
                <td><strong>
                    <%= task.getTitle() %>
                </strong></td>
                <td><%= task.getPostedByName() %></td>
                <td><%= task.getSkillName() != null ?
                        task.getSkillName() : "-" %></td>
                <td><%= task.getDeadline() != null ?
                        task.getDeadline().toString() :
                        "-" %></td>
                <td><%= task.getBudget() > 0 ?
                        "Rs. " + task.getBudget() :
                        "Free" %></td>
                <td>
                        <span class="badge"
                              style="background:<%=
                            "in_progress".equals(
                                task.getStatus()) ?
                            "#fef9e7" : "#eafaf1" %>;
                                      color:<%=
                            "in_progress".equals(
                                task.getStatus()) ?
                            "#d68910" : "#27ae60" %>;">
                            <%= task.getStatus()
                                    .replace("_"," ")
                                    .toUpperCase() %>
                        </span>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>

    <!-- Ratings Section -->
    <div class="section">
        <h2>My Ratings & Feedback</h2>
        <% List<Rating> ratings = (List<Rating>)
                request.getAttribute("ratings"); %>
        <% if(ratings == null || ratings.isEmpty()) { %>
        <p class="no-data">No ratings yet.</p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>Task</th>
                <th>Rated By</th>
                <th>Score</th>
                <th>Feedback</th>
                <th>Date</th>
            </tr>
            </thead>
            <tbody>
            <% for(Rating rating : ratings) { %>
            <tr>
                <td><%= rating.getTaskTitle() %></td>
                <td><%= rating.getRatedByName() %></td>
                <td>
                    <% for(int i=1; i<=5; i++) { %>
                    <span style="color:<%= i <= rating.getScore() ? "#f39c12" : "#ddd" %>">★</span>
                    <% } %>
                    (<%= rating.getScore() %>/5)
                </td>
                <td><%= rating.getFeedback() != null ?
                        rating.getFeedback() : "-" %></td>
                <td><%= rating.getCreatedAt() != null ?
                        rating.getCreatedAt().toString()
                        .substring(0,10) : "-" %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>
</body>
</html>
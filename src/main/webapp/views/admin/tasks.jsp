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

<!-- Sidebar -->
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

        <a href="${pageContext.request.contextPath}/admin/reports"
           class="nav-item">Reports</a>

        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>

</div>


<!-- Main Content -->
<div class="main-content">

    <div class="topbar">
        <h1>All Tasks</h1>
    </div>


    <div class="section">

        <h2>System Tasks</h2>

        <%
            List<Task> tasks = (List<Task>) request.getAttribute("tasks");
            String keyword = (String) request.getAttribute("keyword");
        %>


        <!-- ADMIN SEARCH BAR -->
        <div style="display:flex; gap:12px; margin-bottom:20px;">

            <form action="${pageContext.request.contextPath}/tasks/search"
                  method="get"
                  style="display:flex; gap:12px; width:100%;">

                <input type="text"
                       name="keyword"
                       placeholder="Search all tasks..."
                       value="<%= keyword != null ? keyword : "" %>"
                       style="flex:1;
                       padding:10px 16px;
                       border:1.5px solid #ddd;
                       border-radius:8px;
                       font-size:14px;
                       outline:none;">

                <button type="submit"
                        class="btn-primary"
                        style="width:auto; padding:10px 20px;">
                    Search
                </button>

                <a href="${pageContext.request.contextPath}/tasks/list"
                   style="padding:10px 20px;
                   background:#95a5a6;
                   color:white;
                   border-radius:8px;
                   text-decoration:none;
                   font-size:14px;
                   display:inline-flex;
                   align-items:center;">
                    Clear
                </a>

            </form>

        </div>


        <!-- SEARCH RESULT MESSAGE -->
        <% if(request.getAttribute("isSearch") != null) { %>

        <p style="color:#7f8c8d;
                  font-size:14px;
                  margin-bottom:16px;">
            Found <%= tasks != null ? tasks.size() : 0 %> result(s)
        </p>

        <% } %>


        <!-- TASK TABLE -->

        <% if(tasks == null || tasks.isEmpty()) { %>

        <p class="no-data">
            No tasks posted yet.
        </p>

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

                <td>
                    <strong><%= task.getTitle() %></strong>
                </td>

                <td>
                    <%= task.getPostedByName() %>
                </td>

                <td>
                    <%= task.getSkillName() != null ?
                            task.getSkillName() : "-" %>
                </td>

                <td>
                    <%= task.getClaimedByName() != null ?
                            task.getClaimedByName() : "-" %>
                </td>

                <td>
                    <%= task.getDeadline() != null ?
                            task.getDeadline().toString() : "-" %>
                </td>

                <td>

                    <span class="badge"
                          style="background:<%=
                            "open".equals(task.getStatus()) ?
                            "#e8f4fd" :
                            "in_progress".equals(task.getStatus()) ?
                            "#fef9e7" : "#eafaf1" %>;

                                  color:<%=
                            "open".equals(task.getStatus()) ?
                            "#2980b9" :
                            "in_progress".equals(task.getStatus()) ?
                            "#d68910" : "#27ae60" %>;">
                        <%= task.getStatus()
                                .replace("_"," ")
                                .toUpperCase() %>
                    </span>

                </td>

                <td>

                    <a href="${pageContext.request.contextPath}/tasks/delete?id=<%= task.getTaskId() %>"
                       class="btn-delete"
                       onclick="return confirm('Delete this task?')">

                        Delete

                    </a>

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
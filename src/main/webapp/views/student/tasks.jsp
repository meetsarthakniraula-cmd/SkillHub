<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.Task" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>My Tasks - Campus Skill Hub</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin.css">

</head>

<body>

<!-- Sidebar -->
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

        <a href="${pageContext.request.contextPath}/messages/inbox"
           class="nav-item">Messages</a>

        <a href="${pageContext.request.contextPath}/profile/view"
           class="nav-item">My Profile</a>

        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>

    </nav>

</div>


<!-- Main Content -->
<div class="main-content">

    <div class="topbar">

        <h1>My Tasks</h1>

        <a href="${pageContext.request.contextPath}/tasks/add"
           class="btn-approve">
            + Post New Task
        </a>

    </div>


    <div class="section">

        <h2>All My Posted Tasks</h2>

        <%
            List<Task> tasks = (List<Task>) request.getAttribute("tasks");
            String keyword = (String) request.getAttribute("keyword");
        %>


        <!-- Success Message -->
        <% if(request.getParameter("success") != null) { %>

        <div style="padding:12px;
                    background:#eafaf1;
                    color:#27ae60;
                    border-radius:8px;
                    margin-bottom:20px;">

            Task saved successfully! ✅

        </div>

        <% } %>


        <!-- Search Bar -->
        <div style="display:flex;
                    gap:12px;
                    margin-bottom:20px;
                    flex-wrap:wrap;">

            <form action="${pageContext.request.contextPath}/tasks/search"
                  method="get"
                  style="display:flex;
                  gap:12px;
                  flex:1;">

                <input type="text"
                       name="keyword"
                       placeholder="🔍 Search tasks by title or skill..."
                       value="<%= keyword != null ? keyword : "" %>"
                       style="flex:1;
                       padding:10px 16px;
                       border:1.5px solid #ddd;
                       border-radius:8px;
                       font-size:14px;
                       outline:none;">

                <button type="submit"
                        class="btn-primary"
                        style="width:auto;
                        padding:10px 20px;">

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


        <!-- Search Result Message -->
        <% if(request.getAttribute("isSearch") != null) { %>

        <p style="color:#7f8c8d;
                  font-size:14px;
                  margin-bottom:16px;">

            <% if(keyword != null && !keyword.isEmpty()) { %>

            Showing results for
            <strong>"<%= keyword %>"</strong> —

            <% } %>

            <%= tasks != null ? tasks.size() : 0 %> result(s)

        </p>

        <% } %>


        <!-- No Tasks -->
        <% if(tasks == null || tasks.isEmpty()) { %>

        <p class="no-data">

            You haven't posted any tasks yet.

            <a href="${pageContext.request.contextPath}/tasks/add">
                Post your first task!
            </a>

        </p>

        <% } else { %>


        <!-- Tasks Table -->
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

                <td>
                    <strong><%= task.getTitle() %></strong>
                </td>

                <td>
                    <%= task.getSkillName() != null ?
                            task.getSkillName() : "-" %>
                </td>

                <td>
                    <%= task.getDeadline() != null ?
                            task.getDeadline().toString() : "-" %>
                </td>

                <td>
                    <%= task.getBudget() > 0 ?
                            "Rs. " + task.getBudget() : "Free" %>
                </td>


                <!-- Status -->
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


                <!-- Claimed By -->
                <td>

                    <%= task.getClaimedByName() != null ?
                            task.getClaimedByName() : "Not yet" %>

                </td>


                <!-- Actions -->
                <td>

                    <% if("open".equals(task.getStatus())) { %>

                    <a href="${pageContext.request.contextPath}/tasks/edit?id=<%= task.getTaskId() %>"
                       class="btn-suspend">
                        Edit
                    </a>

                    <a href="${pageContext.request.contextPath}/tasks/delete?id=<%= task.getTaskId() %>"
                       class="btn-delete"
                       onclick="return confirm('Delete this task?')">

                        Delete

                    </a>

                    <% } %>


                    <% if("in_progress".equals(task.getStatus())
                            && task.getClaimedBy() > 0) { %>

                    <a href="${pageContext.request.contextPath}/messages/chat?taskId=<%= task.getTaskId() %>"
                       class="btn-suspend"
                       style="background:#9b59b6;">
                        💬 Message Tutor
                    </a>

                    <a href="${pageContext.request.contextPath}/rating/add?taskId=<%= task.getTaskId() %>"
                       class="btn-approve">
                        ★ Rate & Complete
                    </a>

                    <% } %>


                    <% if("completed".equals(task.getStatus())) { %>

                    <span style="color:#27ae60;
                                 font-weight:600;">

                        ✅ Completed

                    </span>

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
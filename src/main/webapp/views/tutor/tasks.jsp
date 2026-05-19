<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.Task" %>
<%@ page import="com.example.campusskillhub.model.Skill" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Tasks - Campus Skill Hub</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">

</head>
<body>

<!-- Sidebar -->
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


<!-- Main Content -->
<div class="main-content">

    <div class="topbar">
        <h1>Available Tasks</h1>
        <span>Browse and claim tasks</span>
    </div>


    <div class="section">

        <h2>Open Tasks</h2>

        <%
            List<Task> tasks = (List<Task>) request.getAttribute("tasks");
            List<Skill> skills = (List<Skill>) request.getAttribute("skills");
            String keyword = (String) request.getAttribute("keyword");
            Object selectedSkill = request.getAttribute("selectedSkill");
        %>


        <!-- SEARCH + FILTER BAR -->
        <div style="display:flex; gap:12px; margin-bottom:20px; flex-wrap:wrap;">

            <!-- Search Form -->
            <form action="${pageContext.request.contextPath}/tasks/search"
                  method="get"
                  style="display:flex; gap:12px; flex:1;">

                <input type="text"
                       name="keyword"
                       placeholder="🔍 Search by title or skill..."
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

            </form>


            <!-- Skill Filter -->
            <form action="${pageContext.request.contextPath}/tasks/search"
                  method="get"
                  style="display:flex; gap:12px;">

                <select name="skillId"
                        style="padding:10px 16px;
                        border:1.5px solid #ddd;
                        border-radius:8px;
                        font-size:14px;
                        outline:none;
                        min-width:180px;">

                    <option value="0">All Skills</option>

                    <%
                        if(skills != null){
                            for(Skill sk : skills){

                                String sel = "";
                                if(selectedSkill != null &&
                                        selectedSkill.toString().equals(
                                                String.valueOf(sk.getSkillId()))){
                                    sel = "selected";
                                }
                    %>

                    <option value="<%= sk.getSkillId() %>" <%= sel %>>
                        <%= sk.getSkillName() %>
                    </option>

                    <% }} %>

                </select>

                <button type="submit"
                        class="btn-primary"
                        style="width:auto;
                        padding:10px 20px;
                        background:#9b59b6;">
                    Filter
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
            Showing <%= tasks != null ? tasks.size() : 0 %> result(s)
        </p>

        <% } %>


        <!-- TASK TABLE -->

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

                <td>
                    <strong><%= task.getTitle() %></strong>
                </td>

                <td style="max-width:200px;">
                    <%= task.getDescription().length() > 80 ?
                            task.getDescription().substring(0,80) + "..." :
                            task.getDescription() %>
                </td>

                <td>
                    <%= task.getSkillName() != null ?
                            task.getSkillName() : "-" %>
                </td>

                <td>
                    <%= task.getPostedByName() %>
                </td>

                <td>
                    <%= task.getDeadline() != null ?
                            task.getDeadline().toString() : "-" %>
                </td>

                <td>
                    <%= task.getBudget() > 0 ?
                            "Rs. " + task.getBudget() : "Free" %>
                </td>

                <td>

                    <a href="${pageContext.request.contextPath}/tasks/claim?id=<%= task.getTaskId() %>"
                       class="btn-approve"
                       onclick="return confirm('Claim this task?')">

                        Claim Task

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
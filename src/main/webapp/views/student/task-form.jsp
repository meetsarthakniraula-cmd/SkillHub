<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.Skill" %>
<%@ page import="com.example.campusskillhub.model.Task" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Post Task - Campus Skill Hub</title>
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
        <h1><%= request.getAttribute("edit") != null ?
                "Edit Task" : "Post New Task" %></h1>
    </div>

    <div class="section" style="max-width:700px;">

        <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <% Task task = (Task)
                request.getAttribute("task"); %>

        <form action="${pageContext.request.contextPath}/tasks/<%= request.getAttribute("edit") != null ? "edit" : "add" %>"
              method="post">

            <% if(task != null) { %>
            <input type="hidden" name="taskId"
                   value="<%= task.getTaskId() %>">
            <% } %>

            <div class="form-group">
                <label>Task Title</label>
                <input type="text" name="title"
                       placeholder="e.g. Help me with Java assignment"
                       required
                       value="<%= task != null ?
                           task.getTitle() : "" %>">
            </div>

            <div class="form-group">
                <label>Description</label>
                <textarea name="description" rows="5"
                          placeholder="Describe what help you need..."
                          required
                          style="width:100%; padding:12px;
                          border:1.5px solid #ddd;
                          border-radius:8px; font-size:14px;
                          outline:none;
                          resize:vertical;"><%= task != null ?
                        task.getDescription() : "" %></textarea>
            </div>

            <div class="form-group">
                <label>Required Skill</label>
                <select name="skillId">
                    <option value="">-- Select Skill --</option>
                    <% List<Skill> skills = (List<Skill>)
                            request.getAttribute("skills");
                        if(skills != null) {
                            for(Skill skill : skills) { %>
                    <option value="<%= skill.getSkillId() %>"
                            <%= task != null &&
                                    task.getSkillId() ==
                                            skill.getSkillId() ?
                                    "selected" : "" %>>
                        <%= skill.getSkillName() %>
                    </option>
                    <% }} %>
                </select>
            </div>

            <div class="form-group">
                <label>Deadline</label>
                <input type="date" name="deadline"
                       value="<%= task != null &&
                           task.getDeadline() != null ?
                           task.getDeadline().toString() :
                           "" %>">
            </div>

            <div class="form-group">
                <label>Budget (Rs.) — Optional</label>
                <input type="number" name="budget"
                       placeholder="0 for free"
                       min="0" step="0.01"
                       value="<%= task != null ?
                           task.getBudget() : "0" %>">
            </div>

            <div style="display:flex; gap:12px;">
                <button type="submit" class="btn-primary"
                        style="width:auto; padding:12px 30px;">
                    <%= request.getAttribute("edit") != null ?
                            "Update Task" : "Post Task" %>
                </button>
                <a href="${pageContext.request.contextPath}/tasks/list"
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
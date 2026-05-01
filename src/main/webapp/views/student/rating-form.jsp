<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.example.campusskillhub.model.Task" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Rate Tutor - Campus Skill Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <style>
        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            gap: 8px;
            margin: 10px 0;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            font-size: 36px;
            color: #ddd;
            cursor: pointer;
        }
        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #f39c12;
        }
    </style>
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
        <h1>Rate Your Tutor</h1>
    </div>

    <div class="section" style="max-width:600px;">

        <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <% Task task = (Task)
                request.getAttribute("task"); %>

        <% if(task != null) { %>
        <div style="background:#f8f9fa; padding:16px;
             border-radius:8px; margin-bottom:24px;">
            <p><strong>Task:</strong>
                <%= task.getTitle() %></p>
            <p><strong>Tutor:</strong>
                <%= task.getClaimedByName() %></p>
        </div>

        <form action="${pageContext.request.contextPath}/rating/add"
              method="post">

            <input type="hidden" name="taskId"
                   value="<%= task.getTaskId() %>">
            <input type="hidden" name="ratedUser"
                   value="<%= task.getClaimedBy() %>">

            <div class="form-group">
                <label>Your Rating</label>
                <div class="star-rating">
                    <input type="radio" name="score"
                           id="star5" value="5">
                    <label for="star5">★</label>
                    <input type="radio" name="score"
                           id="star4" value="4">
                    <label for="star4">★</label>
                    <input type="radio" name="score"
                           id="star3" value="3" checked>
                    <label for="star3">★</label>
                    <input type="radio" name="score"
                           id="star2" value="2">
                    <label for="star2">★</label>
                    <input type="radio" name="score"
                           id="star1" value="1">
                    <label for="star1">★</label>
                </div>
            </div>

            <div class="form-group">
                <label>Feedback</label>
                <textarea name="feedback" rows="4"
                          placeholder="Share your experience with this tutor..."
                          style="width:100%; padding:12px;
                          border:1.5px solid #ddd;
                          border-radius:8px; font-size:14px;
                          outline:none;
                          resize:vertical;"></textarea>
            </div>

            <div style="display:flex; gap:12px;">
                <button type="submit" class="btn-primary"
                        style="width:auto;
                        padding:12px 30px;">
                    Submit Rating
                </button>
                <a href="${pageContext.request.contextPath}/tasks/list"
                   style="padding:12px 30px;
                   background:#95a5a6; color:white;
                   border-radius:8px;
                   text-decoration:none; font-size:14px;
                   display:inline-block;">
                    Cancel</a>
            </div>
        </form>
        <% } %>
    </div>
</div>
</body>
</html>
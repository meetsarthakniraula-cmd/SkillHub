<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.campusskillhub.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reports - Campus Skill Hub</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin.css">
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
           class="nav-item">All Tasks</a>
        <a href="${pageContext.request.contextPath}/admin/reports"
           class="nav-item active">Reports</a>
        <a href="${pageContext.request.contextPath}/profile/view"
           class="nav-item">My Profile</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="topbar">
        <h1>System Reports</h1>
        <span>Welcome,
            <%= session.getAttribute("userName") %>
        </span>
    </div>

    <%-- USER STATISTICS --%>
    <div class="section">
        <h2>User Statistics</h2>
        <div class="stats-grid">
            <div class="stat-card blue">
                <h3>Total Students</h3>
                <p class="stat-number">
                    ${totalStudents}
                </p>
            </div>
            <div class="stat-card green">
                <h3>Total Tutors</h3>
                <p class="stat-number">
                    ${totalTutors}
                </p>
            </div>
            <div class="stat-card orange">
                <h3>Pending Approval</h3>
                <p class="stat-number">
                    ${pendingUsers}
                </p>
            </div>
            <div class="stat-card purple">
                <h3>Active Users</h3>
                <p class="stat-number">
                    ${activeUsers}
                </p>
            </div>
        </div>
    </div>

    <%-- TASK STATISTICS --%>
    <div class="section">
        <h2>Task Statistics</h2>
        <div class="stats-grid">
            <div class="stat-card blue">
                <h3>Total Tasks</h3>
                <p class="stat-number">
                    ${totalTasks}
                </p>
            </div>
            <div class="stat-card green">
                <h3>Open Tasks</h3>
                <p class="stat-number">
                    ${openTasks}
                </p>
            </div>
            <div class="stat-card orange">
                <h3>In Progress</h3>
                <p class="stat-number">
                    ${inProgressTasks}
                </p>
            </div>
            <div class="stat-card purple">
                <h3>Completed</h3>
                <p class="stat-number">
                    ${completedTasks}
                </p>
            </div>
        </div>

        <%-- Task Progress Bar --%>
        <%
            int total = (Integer) request
                    .getAttribute("totalTasks");
            int completed = (Integer) request
                    .getAttribute("completedTasks");
            int inProgress = (Integer) request
                    .getAttribute("inProgressTasks");
            int open = (Integer) request
                    .getAttribute("openTasks");
            int completedPct = total > 0 ?
                    (completed * 100 / total) : 0;
            int inProgressPct = total > 0 ?
                    (inProgress * 100 / total) : 0;
            int openPct = total > 0 ?
                    (open * 100 / total) : 0;
        %>
        <div style="margin-top:24px;">
            <h3 style="margin-bottom:16px;
                       color:#2c3e50;">
                Task Completion Rate
            </h3>

            <div style="margin-bottom:12px;">
                <div style="display:flex;
                     justify-content:space-between;
                     margin-bottom:6px;">
                    <span style="font-size:14px;
                          color:#27ae60;
                          font-weight:500;">
                        Completed
                    </span>
                    <span style="font-size:14px;
                          color:#555;">
                        <%= completedPct %>%
                        (<%= completed %> tasks)
                    </span>
                </div>
                <div style="background:#eee;
                     border-radius:8px;
                     height:12px; width:100%;">
                    <div style="background:#27ae60;
                            height:12px;
                            border-radius:8px;
                            width:<%= completedPct %>%;">
                    </div>
                </div>
            </div>

            <div style="margin-bottom:12px;">
                <div style="display:flex;
                     justify-content:space-between;
                     margin-bottom:6px;">
                    <span style="font-size:14px;
                          color:#e67e22;
                          font-weight:500;">
                        In Progress
                    </span>
                    <span style="font-size:14px;
                          color:#555;">
                        <%= inProgressPct %>%
                        (<%= inProgress %> tasks)
                    </span>
                </div>
                <div style="background:#eee;
                     border-radius:8px;
                     height:12px; width:100%;">
                    <div style="background:#e67e22;
                            height:12px;
                            border-radius:8px;
                            width:<%= inProgressPct %>%;">
                    </div>
                </div>
            </div>

            <div style="margin-bottom:12px;">
                <div style="display:flex;
                     justify-content:space-between;
                     margin-bottom:6px;">
                    <span style="font-size:14px;
                          color:#3498db;
                          font-weight:500;">
                        Open
                    </span>
                    <span style="font-size:14px;
                          color:#555;">
                        <%= openPct %>%
                        (<%= open %> tasks)
                    </span>
                </div>
                <div style="background:#eee;
                     border-radius:8px;
                     height:12px; width:100%;">
                    <div style="background:#3498db;
                            height:12px;
                            border-radius:8px;
                            width:<%= openPct %>%;">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- TOP RATED TUTORS --%>
    <div class="section">
        <h2>Top Rated Tutors</h2>
        <%
            List<String[]> topTutors = (List<String[]>)
                    request.getAttribute("topTutors");
        %>
        <% if(topTutors == null ||
                topTutors.isEmpty()) { %>
        <p class="no-data">
            No ratings submitted yet.
        </p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>Rank</th>
                <th>Tutor Name</th>
                <th>Total Ratings</th>
                <th>Average Rating</th>
                <th>Performance</th>
            </tr>
            </thead>
            <tbody>
            <% int rank = 1;
                for(String[] tutor : topTutors) { %>
            <tr>
                <td>
                    <strong style="color:<%= rank == 1 ? "#f39c12" : rank == 2 ? "#7f8c8d" : "#cd6133" %>">
                        #<%= rank++ %>
                    </strong>
                </td>
                <td><strong><%= tutor[0] %></strong></td>
                <td><%= tutor[1] %> ratings</td>
                <td>
                    <%
                        double avg = Double.parseDouble(
                                tutor[2]);
                        int fullStars = (int) avg;
                    %>
                    <% for(int i=1; i<=5; i++) { %>
                    <span style="color:<%= i <= fullStars ? "#f39c12" : "#ddd" %>">★</span>
                    <% } %>
                    (<%= tutor[2] %>/5)
                </td>
                <td>
                    <div style="background:#eee;
                             border-radius:8px;
                             height:8px; width:100px;">
                        <div style="background:#f39c12;
                                height:8px;
                                border-radius:8px;
                                width:<%= (int)(avg/5*100) %>%;">
                        </div>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>

    <%-- MOST POPULAR SKILLS --%>
    <div class="section">
        <h2>Most Popular Skills</h2>
        <%
            List<String[]> popularSkills =
                    (List<String[]>) request
                            .getAttribute("popularSkills");
        %>
        <% if(popularSkills == null ||
                popularSkills.isEmpty()) { %>
        <p class="no-data">No data yet.</p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>Rank</th>
                <th>Skill Name</th>
                <th>Total Tasks</th>
                <th>Demand Level</th>
            </tr>
            </thead>
            <tbody>
            <% int skillRank = 1;
                int maxTasks = Integer.parseInt(
                        popularSkills.get(0)[1]);
                for(String[] skill :
                        popularSkills) {
                    int taskCount = Integer.parseInt(
                            skill[1]);
                    int barWidth = maxTasks > 0 ?
                            (taskCount * 100 / maxTasks) : 0;
            %>
            <tr>
                <td><strong>
                    #<%= skillRank++ %>
                </strong></td>
                <td><strong>
                    <%= skill[0] %>
                </strong></td>
                <td><%= skill[1] %> tasks</td>
                <td>
                    <div style="background:#eee;
                             border-radius:8px;
                             height:8px;
                             width:150px;">
                        <div style="background:#9b59b6;
                                height:8px;
                                border-radius:8px;
                                width:<%= barWidth %>%;">
                        </div>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>

    <%-- RECENT REGISTRATIONS --%>
    <div class="section">
        <h2>Recent User Registrations</h2>
        <%
            List<User> recentUsers = (List<User>)
                    request.getAttribute("recentUsers");
        %>
        <% if(recentUsers == null ||
                recentUsers.isEmpty()) { %>
        <p class="no-data">No users yet.</p>
        <% } else { %>
        <table class="data-table">
            <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Status</th>
                <th>Registered</th>
            </tr>
            </thead>
            <tbody>
            <% for(User user : recentUsers) { %>
            <tr>
                <td><strong>
                    <%= user.getFullName() %>
                </strong></td>
                <td><%= user.getEmail() %></td>
                <td>
                        <span class="badge
                            <%= user.getRole() %>">
                            <%= user.getRole() %>
                        </span>
                </td>
                <td>
                        <span class="badge"
                              style="background:<%= "active".equals(user.getStatus()) ? "#eafaf1" : "pending".equals(user.getStatus()) ? "#fef9e7" : "#fdeaea" %>;
                                      color:<%= "active".equals(user.getStatus()) ? "#27ae60" : "pending".equals(user.getStatus()) ? "#d68910" : "#e74c3c" %>;">
                            <%= user.getStatus()
                                    .toUpperCase() %>
                        </span>
                </td>
                <td>
                    <%= user.getCreatedAt() != null ?
                            user.getCreatedAt()
                            .toString()
                            .substring(0,10) : "-" %>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>

    <%-- RATING STATISTICS --%>
    <div class="section">
        <h2>Rating Statistics</h2>
        <div class="stats-grid">
            <div class="stat-card green">
                <h3>Total Ratings Submitted</h3>
                <p class="stat-number">
                    ${totalRatings}
                </p>
            </div>
            <div class="stat-card blue">
                <h3>Completion Rate</h3>
                <p class="stat-number">
                    <%= total > 0 ?
                            completedPct : 0 %>%
                </p>
            </div>
        </div>
    </div>

</div>
</body>
</html>
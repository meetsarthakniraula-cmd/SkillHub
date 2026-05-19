<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.example.campusskillhub.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile - Campus Skill Hub</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<%
    String role = (String)
            session.getAttribute("userRole");
    String dashboardUrl =
            request.getContextPath() +
                    "/" + role + "/dashboard";
    User userProfile = (User)
            request.getAttribute("userProfile");
%>

<div class="sidebar">
    <div class="sidebar-header">
        <h2>Campus Skill Hub</h2>
        <p><%= role.substring(0,1).toUpperCase()
                + role.substring(1) %> Panel</p>
    </div>
    <nav class="sidebar-nav">
        <a href="<%= dashboardUrl %>"
           class="nav-item">Dashboard</a>
        <a href="${pageContext.request.contextPath}/tasks/list"
           class="nav-item">Tasks</a>
        <a href="${pageContext.request.contextPath}/messages/inbox"
           class="nav-item">Messages</a>
        <a href="${pageContext.request.contextPath}/profile/view"
           class="nav-item active">My Profile</a>
        <a href="${pageContext.request.contextPath}/logout"
           class="nav-item logout">Logout</a>
    </nav>
</div>

<div class="main-content">
    <div class="topbar">
        <h1>Edit Profile</h1>
    </div>

    <div class="section" style="max-width:600px;">

        <% if(request.getAttribute("error")
                != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/profile/update"
              method="post">

            <div class="form-group">
                <label>Full Name</label>
                <input type="text"
                       name="fullName"
                       required
                       value="<%= userProfile != null ?
                           userProfile.getFullName()
                           : "" %>">
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email"
                       value="<%= userProfile != null ?
                           userProfile.getEmail()
                           : "" %>"
                       disabled
                       style="background:#f0f0f0;
                       cursor:not-allowed;">
                <small style="color:#888;
                       font-size:12px;">
                    Email cannot be changed
                </small>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text"
                       name="phone"
                       required
                       value="<%= userProfile != null ?
                           userProfile.getPhone()
                           : "" %>">
            </div>

            <div class="form-group">
                <label>Department</label>
                <input type="text"
                       name="department"
                       placeholder="e.g. Computer Science"
                       value="<%= userProfile != null
                           && userProfile.getDepartment()
                           != null ?
                           userProfile.getDepartment()
                           : "" %>">
            </div>

            <div class="form-group">
                <label>Academic Year</label>
                <select name="academicYear">
                    <option value="">
                        -- Select Year --
                    </option>
                    <%
                        String[] years = {"1st Year",
                                "2nd Year", "3rd Year",
                                "4th Year"};
                        for(String year : years) {
                            boolean selected =
                                    userProfile != null &&
                                            year.equals(userProfile
                                                    .getAcademicYear());
                    %>
                    <option value="<%= year %>"
                            <%= selected ?
                                    "selected" : "" %>>
                        <%= year %>
                    </option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label>Bio</label>
                <textarea name="bio" rows="4"
                          placeholder="Tell others about yourself..."
                          style="width:100%;
                          padding:12px;
                          border:1.5px solid #ddd;
                          border-radius:8px;
                          font-size:14px;
                          outline:none;
                          resize:vertical;">
                    <%= userProfile != null &&
                            userProfile.getBio() != null ?
                            userProfile.getBio() : "" %>
                </textarea>
            </div>

            <div style="display:flex; gap:12px;">
                <button type="submit"
                        class="btn-primary"
                        style="width:auto;
                        padding:12px 30px;">
                    Save Changes
                </button>
                <a href="${pageContext.request.contextPath}/profile/view"
                   style="padding:12px 30px;
                   background:#95a5a6; color:white;
                   border-radius:8px;
                   text-decoration:none;
                   font-size:14px;
                   display:inline-block;">
                    Cancel
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
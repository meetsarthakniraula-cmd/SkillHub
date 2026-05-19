<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.example.campusskillhub.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Profile - Campus Skill Hub</title>
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
        <h1>My Profile</h1>
        <a href="${pageContext.request.contextPath}/profile/edit"
           class="btn-approve"
           style="text-decoration:none;">
            Edit Profile
        </a>
    </div>

    <%-- Success Messages --%>
    <% if("updated".equals(
            request.getParameter("success"))) { %>
    <div style="padding:12px;
             background:#eafaf1; color:#27ae60;
             border-radius:8px; margin-bottom:20px;">
        Profile updated successfully! ✅
    </div>
    <% } %>
    <% if("password".equals(
            request.getParameter("success"))) { %>
    <div style="padding:12px;
             background:#eafaf1; color:#27ae60;
             border-radius:8px; margin-bottom:20px;">
        Password changed successfully! ✅
    </div>
    <% } %>

    <%-- Profile Info --%>
    <div class="section" style="max-width:700px;">
        <h2>Personal Information</h2>

        <%-- Profile Avatar --%>
        <div style="text-align:center;
                    margin-bottom:24px;">
            <div style="width:80px; height:80px;
                 border-radius:50%;
                 background:#3498db;
                 display:inline-flex;
                 align-items:center;
                 justify-content:center;
                 font-size:32px; color:white;
                 font-weight:600;">
                <%= userProfile != null ?
                        String.valueOf(userProfile
                                       .getFullName().charAt(0))
                        .toUpperCase() : "?" %>
            </div>
            <h3 style="margin-top:12px;
                       color:#2c3e50;">
                <%= userProfile != null ?
                        userProfile.getFullName() : "" %>
            </h3>
            <span class="badge <%= role %>"
                  style="font-size:13px;">
                <%= role.toUpperCase() %>
            </span>
        </div>

        <%-- Info Table --%>
        <table style="width:100%;
               border-collapse:collapse;">
            <tr style="border-bottom:1px solid #eee;">
                <td style="padding:12px;
                     font-weight:600; color:#555;
                     width:35%;">Email</td>
                <td style="padding:12px; color:#333;">
                    <%= userProfile != null ?
                            userProfile.getEmail() : "-" %>
                </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;">
                <td style="padding:12px;
                     font-weight:600; color:#555;">
                    Phone</td>
                <td style="padding:12px; color:#333;">
                    <%= userProfile != null ?
                            userProfile.getPhone() : "-" %>
                </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;">
                <td style="padding:12px;
                     font-weight:600; color:#555;">
                    Department</td>
                <td style="padding:12px; color:#333;">
                    <%= userProfile != null &&
                            userProfile.getDepartment()
                                    != null ?
                            userProfile.getDepartment()
                            : "-" %>
                </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;">
                <td style="padding:12px;
                     font-weight:600; color:#555;">
                    Academic Year</td>
                <td style="padding:12px; color:#333;">
                    <%= userProfile != null &&
                            userProfile.getAcademicYear()
                                    != null ?
                            userProfile.getAcademicYear()
                            : "-" %>
                </td>
            </tr>
            <tr style="border-bottom:1px solid #eee;">
                <td style="padding:12px;
                     font-weight:600; color:#555;">
                    Status</td>
                <td style="padding:12px;">
                    <span class="badge"
                          style="background:#eafaf1;
                               color:#27ae60;">
                        ACTIVE
                    </span>
                </td>
            </tr>
            <tr>
                <td style="padding:12px;
                     font-weight:600; color:#555;">
                    Bio</td>
                <td style="padding:12px; color:#333;">
                    <%= userProfile != null &&
                            userProfile.getBio() != null ?
                            userProfile.getBio() : "-" %>
                </td>
            </tr>
        </table>
    </div>

    <%-- Change Password --%>
    <div class="section" style="max-width:700px;
         margin-top:24px;">
        <h2>Change Password</h2>

        <% if(request.getAttribute(
                "passwordError") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute(
                    "passwordError") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/profile/password"
              method="post">
            <div class="form-group">
                <label>Current Password</label>
                <input type="password"
                       name="currentPassword"
                       placeholder="Enter current password"
                       required>
            </div>
            <div class="form-group">
                <label>New Password</label>
                <input type="password"
                       name="newPassword"
                       placeholder="Enter new password"
                       required>
            </div>
            <div class="form-group">
                <label>Confirm New Password</label>
                <input type="password"
                       name="confirmPassword"
                       placeholder="Confirm new password"
                       required>
            </div>
            <button type="submit"
                    class="btn-primary"
                    style="width:auto;
                    padding:12px 30px;">
                Change Password
            </button>
        </form>
    </div>
</div>
</body>
</html>
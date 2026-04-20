<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Campus Skill Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-container">
    <div class="auth-box">

        <div class="auth-header">
            <h1>Campus Skill Hub</h1>
            <p>Connect. Learn. Grow.</p>
        </div>

        <!-- Error/Success Messages -->
        <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>
        <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            <%= request.getAttribute("success") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       placeholder="Enter your email" required
                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       placeholder="Enter your password" required>
            </div>

            <button type="submit" class="btn-primary">Login</button>
        </form>

        <div class="auth-footer">
            <p>Don't have an account?
                <a href="${pageContext.request.contextPath}/views/register.jsp">Register here</a>
            </p>
        </div>

    </div>
</div>
</body>
</html>
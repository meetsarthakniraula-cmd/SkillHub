<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Campus Skill Hub</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-container">
    <div class="auth-box">

        <div class="auth-header">
            <h1>Create Account</h1>
            <p>Join Campus Skill Hub today</p>
        </div>

        <!-- Error Message -->
        <% if(request.getAttribute("error") != null) { %>
        <div class="alert alert-error">
            <%= request.getAttribute("error") %>
        </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post">

            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName"
                       placeholder="Enter your full name" required>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       placeholder="Enter your email" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone Number</label>
                <input type="text" id="phone" name="phone"
                       placeholder="Enter your phone number" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       placeholder="Create a password" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword"
                       placeholder="Confirm your password" required>
            </div>

            <div class="form-group">
                <label for="role">Register As</label>
                <select id="role" name="role" required>
                    <option value="">-- Select Role --</option>
                    <option value="student">Student (I need help)</option>
                    <option value="tutor">Tutor (I can help others)</option>
                </select>
            </div>

            <div class="form-group">
                <label for="department">Department</label>
                <input type="text" id="department" name="department"
                       placeholder="e.g. Computer Science">
            </div>

            <div class="form-group">
                <label for="academicYear">Academic Year</label>
                <select id="academicYear" name="academicYear">
                    <option value="">-- Select Year --</option>
                    <option value="1st Year">1st Year</option>
                    <option value="2nd Year">2nd Year</option>
                    <option value="3rd Year">3rd Year</option>
                    <option value="4th Year">4th Year</option>
                </select>
            </div>

            <button type="submit" class="btn-primary">Create Account</button>
        </form>

        <div class="auth-footer">
            <p>Already have an account?
                <a href="${pageContext.request.contextPath}/views/login.jsp">Login here</a>
            </p>
        </div>

    </div>
</div>
</body>
</html>
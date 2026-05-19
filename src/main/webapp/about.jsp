<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About - Campus Skill Hub</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="main-content" style="margin-left:0; padding:40px;">
    <div class="section" style="max-width:800px; margin:0 auto;">
        <h1 style="color:#2c3e50; margin-bottom:20px;">
            About Campus Skill Hub
        </h1>
        <p style="line-height:1.8; color:#555; margin-bottom:16px;">
            Campus Skill Hub is a web-based skill exchange and
            task matching platform developed for university
            environments. It connects students who need academic
            help with tutors and experts who can provide
            assistance across a wide range of subjects.
        </p>
        <p style="line-height:1.8; color:#555; margin-bottom:16px;">
            The platform was developed as part of the CS5054NT
            Advanced Programming and Technologies module at
            London Metropolitan University, Itahari International
            College, Spring 2026.
        </p>
        <h2 style="color:#2c3e50; margin:24px 0 12px;">
            Our Mission
        </h2>
        <p style="line-height:1.8; color:#555; margin-bottom:16px;">
            To provide a structured, secure and accountable
            platform for academic collaboration within university
            communities, replacing informal and unaccountable
            channels with a centralized system that benefits
            students, tutors and administrators alike.
        </p>
        <h2 style="color:#2c3e50; margin:24px 0 12px;">
            Technologies Used
        </h2>
        <ul style="line-height:2; color:#555;
                   padding-left:20px;">
            <li>Java Servlets and JSP</li>
            <li>MySQL Database</li>
            <li>Apache Tomcat 10</li>
            <li>MVC Architecture</li>
            <li>SHA-256 Password Encryption</li>
            <li>CSS Flexbox Responsive Design</li>
        </ul>
        <div style="margin-top:32px;">
            <a href="${pageContext.request.contextPath}/login"
               class="btn-primary"
               style="display:inline-block; width:auto;
                      padding:12px 30px; text-decoration:none;">
                Back to Login
            </a>
        </div>
    </div>
</div>
</body>
</html>
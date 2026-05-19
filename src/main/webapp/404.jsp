<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>404 - Page Not Found</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .error-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            text-align: center;
            background: #f0f2f5;
        }
        .error-code {
            font-size: 120px;
            font-weight: 700;
            color: #3498db;
            margin: 0;
            line-height: 1;
        }
        .error-title {
            font-size: 28px;
            color: #2c3e50;
            margin: 16px 0 8px;
        }
        .error-message {
            font-size: 16px;
            color: #7f8c8d;
            margin-bottom: 32px;
        }
        .error-btn {
            background: #3498db;
            color: white;
            padding: 12px 32px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
        }
        .error-btn:hover {
            background: #2980b9;
        }
    </style>
</head>
<body>
<div class="error-container">
    <p class="error-code">404</p>
    <h1 class="error-title">Page Not Found</h1>
    <p class="error-message">
        The page you are looking for does not exist
        or has been moved.
    </p>
    <a href="${pageContext.request.contextPath}/login"
       class="error-btn">
        Go Back Home
    </a>
</div>
</body>
</html>
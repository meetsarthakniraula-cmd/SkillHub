<%@ page contentType="text/html;charset=UTF-8"
         isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>500 - Server Error</title>
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
            color: #e74c3c;
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
            max-width: 500px;
        }
        .error-btn {
            background: #e74c3c;
            color: white;
            padding: 12px 32px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
        }
        .error-btn:hover {
            background: #c0392b;
        }
    </style>
</head>
<body>
<div class="error-container">
    <p class="error-code">500</p>
    <h1 class="error-title">Internal Server Error</h1>
    <p class="error-message">
        Something went wrong on our end.
        Please try again later or contact
        support if the problem persists.
    </p>
    <a href="${pageContext.request.contextPath}/login"
       class="error-btn">
        Go Back Home
    </a>
</div>
</body>
</html>
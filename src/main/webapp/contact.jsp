<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact - Campus Skill Hub</title>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="main-content" style="margin-left:0; padding:40px;">
    <div class="section" style="max-width:800px; margin:0 auto;">
        <h1 style="color:#2c3e50; margin-bottom:20px;">
            Contact Us
        </h1>
        <p style="line-height:1.8; color:#555; margin-bottom:24px;">
            If you have any questions, issues or feedback
            regarding the Campus Skill Hub platform, please
            do not hesitate to contact us using the details
            below or by filling in the enquiry form.
        </p>

        <!-- Contact Details -->
        <div style="background:#f8f9fa; padding:24px;
                    border-radius:8px; margin-bottom:32px;">
            <h2 style="color:#2c3e50; margin-bottom:16px;">
                Support Details
            </h2>
            <p style="line-height:2; color:#555;">
                📍 Itahari International College,
                Itahari, Sunsari, Nepal<br>
                📧 support@campusskillhub.com<br>
                📞 +977-25-586XXX<br>
                🕐 Office Hours:
                Sunday - Friday, 9:00 AM - 5:00 PM
            </p>
        </div>

        <!-- Contact Form -->
        <h2 style="color:#2c3e50; margin-bottom:16px;">
            Send an Enquiry
        </h2>

        <% if(request.getAttribute("success") != null) { %>
        <div class="alert alert-success">
            Your enquiry has been submitted successfully!
            We will get back to you within 24 hours.
        </div>
        <% } %>

        <div class="form-group">
            <label>Full Name</label>
            <input type="text" placeholder="Enter your full name">
        </div>
        <div class="form-group">
            <label>Email Address</label>
            <input type="email"
                   placeholder="Enter your email address">
        </div>
        <div class="form-group">
            <label>Subject</label>
            <input type="text"
                   placeholder="Enter subject of enquiry">
        </div>
        <div class="form-group">
            <label>Message</label>
            <textarea rows="5"
                      placeholder="Describe your enquiry..."
                      style="width:100%; padding:12px;
                      border:1.5px solid #ddd;
                      border-radius:8px; font-size:14px;
                      outline:none; resize:vertical;">
            </textarea>
        </div>
        <button class="btn-primary"
                style="width:auto; padding:12px 30px;">
            Send Enquiry
        </button>

        <div style="margin-top:24px;">
            <a href="${pageContext.request.contextPath}/login"
               style="color:#3498db; text-decoration:none;">
                ← Back to Login
            </a>
        </div>
    </div>
</div>
</body>
</html>
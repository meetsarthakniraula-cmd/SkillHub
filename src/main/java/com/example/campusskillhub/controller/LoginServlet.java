package com.example.campusskillhub.controller;

import com.example.campusskillhub.dao.UserDAO;
import com.example.campusskillhub.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    // When user visits login page (GET request)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // If already logged in, redirect to dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectToDashboard(user.getRole(), request, response);
            return;
        }

        // Otherwise show login page
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    // When user submits login form (POST request)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validation
        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required!");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }

        // Check credentials
        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(email.trim(), password.trim());

        if (user == null) {
            request.setAttribute("error", "Invalid email or password. Please try again.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }

        // Check if account is pending approval
        if (user.getStatus().equals("pending")) {
            request.setAttribute("error", "Your account is pending admin approval. Please wait.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }

        // Check if account is suspended
        if (user.getStatus().equals("suspended")) {
            request.setAttribute("error", "Your account has been suspended. Contact admin.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            return;
        }

        // Success — create session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("userName", user.getFullName());
        session.setAttribute("userRole", user.getRole());
        session.setMaxInactiveInterval(30 * 60); // 30 minutes

        // Redirect based on role
        redirectToDashboard(user.getRole(), request, response);
    }

    private void redirectToDashboard(String role, HttpServletRequest request,
                                     HttpServletResponse response)
            throws IOException {
        switch (role) {
            case "admin":
                response.sendRedirect(request.getContextPath() + "/views/admin/dashboard.jsp");
                break;
            case "student":
                response.sendRedirect(request.getContextPath() + "/views/student/dashboard.jsp");
                break;
            case "tutor":
                response.sendRedirect(request.getContextPath() + "/views/tutor/dashboard.jsp");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        }
    }
}
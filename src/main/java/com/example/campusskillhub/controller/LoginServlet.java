package com.example.campusskillhub.controller;

import com.example.campusskillhub.dao.UserDAO;
import com.example.campusskillhub.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/login.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            request.setAttribute("error",
                    "Email and password are required!");
            request.getRequestDispatcher("/views/login.jsp")
                    .forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(
                email.trim(), password.trim());

        if (user == null) {
            request.setAttribute("error",
                    "Invalid email or password!");
            request.getRequestDispatcher("/views/login.jsp")
                    .forward(request, response);
            return;
        }

        if ("pending".equals(user.getStatus())) {
            request.setAttribute("error",
                    "Your account is pending admin approval!");
            request.getRequestDispatcher("/views/login.jsp")
                    .forward(request, response);
            return;
        }

        if ("suspended".equals(user.getStatus())) {
            request.setAttribute("error",
                    "Your account has been suspended!");
            request.getRequestDispatcher("/views/login.jsp")
                    .forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getUserId());
        session.setAttribute("userName", user.getFullName());
        session.setAttribute("userRole", user.getRole());
        session.setMaxInactiveInterval(30 * 60);

        String role = user.getRole();
        if ("admin".equals(role)) {
            response.sendRedirect(
                    request.getContextPath() + "/admin/dashboard");
        } else if ("student".equals(role)) {
            response.sendRedirect(
                    request.getContextPath() + "/student/dashboard");
        } else {
            response.sendRedirect(
                    request.getContextPath() + "/tutor/dashboard");
        }
    }
}
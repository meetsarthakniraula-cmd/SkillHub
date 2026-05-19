package com.example.campusskillhub.controller;

import com.example.campusskillhub.dao.UserDAO;
import com.example.campusskillhub.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/profile/*")
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);
        if (session == null ||
                session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/view";
        }

        switch (path) {
            case "/view":
                showProfile(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            default:
                showProfile(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);
        if (session == null ||
                session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        String path = request.getPathInfo();
        if (path == null) path = "/";

        switch (path) {
            case "/update":
                updateProfile(request, response);
                break;
            case "/password":
                changePassword(request, response);
                break;
            default:
                showProfile(request, response);
                break;
        }
    }

    private void showProfile(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession()
                .getAttribute("userId");
        User user = userDAO.getUserById(userId);
        request.setAttribute("userProfile", user);
        request.getRequestDispatcher(
                        "/views/profile/view.jsp")
                .forward(request, response);
    }

    private void showEditForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession()
                .getAttribute("userId");
        User user = userDAO.getUserById(userId);
        request.setAttribute("userProfile", user);
        request.getRequestDispatcher(
                        "/views/profile/edit.jsp")
                .forward(request, response);
    }

    private void updateProfile(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int userId = (int) request.getSession()
                .getAttribute("userId");

        String fullName =
                request.getParameter("fullName");
        String phone =
                request.getParameter("phone");
        String department =
                request.getParameter("department");
        String academicYear =
                request.getParameter("academicYear");
        String bio =
                request.getParameter("bio");

        // Validation
        if (fullName == null ||
                fullName.trim().isEmpty()) {
            request.setAttribute("error",
                    "Full name is required!");
            showEditForm(request, response);
            return;
        }

        if (!fullName.matches("[a-zA-Z ]+")) {
            request.setAttribute("error",
                    "Full name should contain " +
                            "letters only!");
            showEditForm(request, response);
            return;
        }

        if (phone == null ||
                !phone.matches("[0-9]{10}")) {
            request.setAttribute("error",
                    "Phone must be exactly 10 digits!");
            showEditForm(request, response);
            return;
        }

        User user = new User();
        user.setUserId(userId);
        user.setFullName(fullName.trim());
        user.setPhone(phone.trim());
        user.setDepartment(department);
        user.setAcademicYear(academicYear);
        user.setBio(bio);

        boolean success =
                userDAO.updateProfile(user);

        if (success) {
            // Update session name
            request.getSession().setAttribute(
                    "userName", fullName.trim());
            response.sendRedirect(
                    request.getContextPath() +
                            "/profile/view?success=updated");
        } else {
            request.setAttribute("error",
                    "Failed to update profile!");
            showEditForm(request, response);
        }
    }

    private void changePassword(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int userId = (int) request.getSession()
                .getAttribute("userId");

        String currentPassword =
                request.getParameter("currentPassword");
        String newPassword =
                request.getParameter("newPassword");
        String confirmPassword =
                request.getParameter("confirmPassword");

        // Validation
        if (!userDAO.verifyPassword(
                userId, currentPassword)) {
            request.setAttribute("passwordError",
                    "Current password is incorrect!");
            showProfile(request, response);
            return;
        }

        if (newPassword == null ||
                newPassword.length() < 6) {
            request.setAttribute("passwordError",
                    "New password must be at " +
                            "least 6 characters!");
            showProfile(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("passwordError",
                    "New passwords do not match!");
            showProfile(request, response);
            return;
        }

        boolean success = userDAO.changePassword(
                userId, newPassword);

        if (success) {
            response.sendRedirect(
                    request.getContextPath() +
                            "/profile/view?success=password");
        } else {
            request.setAttribute("passwordError",
                    "Failed to change password!");
            showProfile(request, response);
        }
    }
}
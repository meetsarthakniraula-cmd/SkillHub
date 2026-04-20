package com.example.campusskillhub.controller;

import com.example.campusskillhub.dao.UserDAO;
import com.example.campusskillhub.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    // Show register page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    // Handle register form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get all form values
        String fullName    = request.getParameter("fullName");
        String email       = request.getParameter("email");
        String phone       = request.getParameter("phone");
        String password    = request.getParameter("password");
        String confirmPass = request.getParameter("confirmPassword");
        String role        = request.getParameter("role");
        String department  = request.getParameter("department");
        String academicYear = request.getParameter("academicYear");

        // Validation checks
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Full name is required!");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        // Name should not contain numbers
        if (!fullName.matches("[a-zA-Z ]+")) {
            request.setAttribute("error", "Full name should contain letters only!");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required!");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (phone == null || phone.trim().isEmpty()) {
            request.setAttribute("error", "Phone number is required!");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        // Phone should be numbers only
        if (!phone.matches("[0-9]{10}")) {
            request.setAttribute("error", "Phone number must be exactly 10 digits!");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (password == null || password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters!");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPass)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        if (role == null || role.trim().isEmpty()) {
            request.setAttribute("error", "Please select a role!");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        UserDAO userDAO = new UserDAO();
        if (userDAO.emailExists(email.trim())) {
            request.setAttribute("error", "This email is already registered!");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        // Check if phone already exists
        if (userDAO.phoneExists(phone.trim())) {
            request.setAttribute("error", "This phone number is already registered!");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        // Create user object
        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setPassword(password);
        user.setPhone(phone.trim());
        user.setRole(role.trim());
        user.setDepartment(department);
        user.setAcademicYear(academicYear);

        // Save to database
        boolean success = userDAO.registerUser(user);

        if (success) {
            request.setAttribute("success",
                    "Registration successful! Please wait for admin approval before logging in.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}
package com.example.campusskillhub.controller;

import com.example.campusskillhub.dao.AdminDAO;
import com.example.campusskillhub.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null ||
                session.getAttribute("user") == null ||
                !"admin".equals(
                        session.getAttribute("userRole"))) {
            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        String path = request.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/dashboard";
        }

        switch (path) {
            case "/dashboard":
                showDashboard(request, response);
                break;
            case "/users":
                showUsers(request, response);
                break;
            case "/approve":
                approveUser(request, response);
                break;
            case "/suspend":
                suspendUser(request, response);
                break;
            case "/delete":
                deleteUser(request, response);
                break;
            case "/reports":
                showReports(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    private void showDashboard(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("totalStudents",
                adminDAO.countUsers("student"));
        request.setAttribute("totalTutors",
                adminDAO.countUsers("tutor"));
        request.setAttribute("pendingUsers",
                adminDAO.countPendingUsers());
        request.setAttribute("openTasks",
                adminDAO.countTasks("open"));
        List<User> pendingList = adminDAO.getPendingUsers();
        request.setAttribute("pendingList", pendingList);
        request.getRequestDispatcher(
                        "/views/admin/dashboard.jsp")
                .forward(request, response);
    }

    private void showUsers(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {
        List<User> allUsers = adminDAO.getAllUsers();
        request.setAttribute("allUsers", allUsers);
        request.getRequestDispatcher(
                        "/views/admin/users.jsp")
                .forward(request, response);
    }

    private void approveUser(HttpServletRequest request,
                             HttpServletResponse response)
            throws IOException {
        int userId = Integer.parseInt(
                request.getParameter("id"));
        adminDAO.approveUser(userId);
        response.sendRedirect(
                request.getContextPath() + "/admin/dashboard");
    }

    private void suspendUser(HttpServletRequest request,
                             HttpServletResponse response)
            throws IOException {
        int userId = Integer.parseInt(
                request.getParameter("id"));
        adminDAO.suspendUser(userId);
        response.sendRedirect(
                request.getContextPath() + "/admin/users");
    }

    private void deleteUser(HttpServletRequest request,
                            HttpServletResponse response)
            throws IOException {
        int userId = Integer.parseInt(
                request.getParameter("id"));
        adminDAO.deleteUser(userId);
        response.sendRedirect(
                request.getContextPath() + "/admin/users");
    }
    private void showReports(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Statistics
        request.setAttribute("totalStudents",
                adminDAO.countUsers("student"));
        request.setAttribute("totalTutors",
                adminDAO.countUsers("tutor"));
        request.setAttribute("totalTasks",
                adminDAO.countAllTasks());
        request.setAttribute("openTasks",
                adminDAO.countTasks("open"));
        request.setAttribute("inProgressTasks",
                adminDAO.countInProgressTasks());
        request.setAttribute("completedTasks",
                adminDAO.countCompletedTasks());
        request.setAttribute("pendingUsers",
                adminDAO.countPendingUsers());
        request.setAttribute("activeUsers",
                adminDAO.countActiveUsers());
        request.setAttribute("totalRatings",
                adminDAO.countTotalRatings());

        // Lists
        request.setAttribute("topTutors",
                adminDAO.getTopRatedTutors());
        request.setAttribute("popularSkills",
                adminDAO.getPopularSkills());
        request.setAttribute("recentUsers",
                adminDAO.getRecentUsers());

        request.getRequestDispatcher(
                        "/views/admin/reports.jsp")
                .forward(request, response);
    }
}
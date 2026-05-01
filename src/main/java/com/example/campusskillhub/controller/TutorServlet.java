package com.example.campusskillhub.controller;

import com.example.campusskillhub.dao.RatingDAO;
import com.example.campusskillhub.dao.TaskDAO;
import com.example.campusskillhub.model.Rating;
import com.example.campusskillhub.model.Task;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/tutor/*")
public class TutorServlet extends HttpServlet {

    private TaskDAO taskDAO = new TaskDAO();
    private RatingDAO ratingDAO = new RatingDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null ||
                session.getAttribute("user") == null ||
                !"tutor".equals(
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
            case "/mytasks":
                showMyTasks(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    private void showDashboard(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        int tutorId = (int) request.getSession()
                .getAttribute("userId");
        double avgRating =
                ratingDAO.getAverageRating(tutorId);
        List<Task> myTasks =
                taskDAO.getTasksByTutor(tutorId);
        request.setAttribute("avgRating", avgRating);
        request.setAttribute("myTasksCount",
                myTasks.size());
        request.getRequestDispatcher(
                        "/views/tutor/dashboard.jsp")
                .forward(request, response);
    }

    private void showMyTasks(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {
        int tutorId = (int) request.getSession()
                .getAttribute("userId");
        List<Task> tasks =
                taskDAO.getTasksByTutor(tutorId);
        List<Rating> ratings =
                ratingDAO.getRatingsForUser(tutorId);
        request.setAttribute("tasks", tasks);
        request.setAttribute("ratings", ratings);
        request.getRequestDispatcher(
                        "/views/tutor/mytasks.jsp")
                .forward(request, response);
    }
}
package com.example.campusskillhub.controller;

import com.example.campusskillhub.dao.RatingDAO;
import com.example.campusskillhub.dao.TaskDAO;
import com.example.campusskillhub.model.Rating;
import com.example.campusskillhub.model.Task;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/rating/*")
public class RatingServlet extends HttpServlet {

    private RatingDAO ratingDAO = new RatingDAO();
    private TaskDAO taskDAO = new TaskDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null ||
                session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        String path = request.getPathInfo();
        if (path == null) path = "/";

        if (path.equals("/add")) {
            showRatingForm(request, response);
        } else {
            response.sendRedirect(
                    request.getContextPath() + "/tasks/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null ||
                session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        String path = request.getPathInfo();
        if (path != null && path.equals("/add")) {
            submitRating(request, response);
        }
    }
    private void showRatingForm(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String taskIdStr = request.getParameter("taskId");

        // Check if taskId is missing
        if (taskIdStr == null || taskIdStr.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath() + "/tasks/list");
            return;
        }

        int taskId = Integer.parseInt(taskIdStr);
        Task task = taskDAO.getTaskById(taskId);

        // Check if task exists
        if (task == null) {
            response.sendRedirect(
                    request.getContextPath() + "/tasks/list");
            return;
        }

        request.setAttribute("task", task);
        request.getRequestDispatcher(
                        "/views/student/rating-form.jsp")
                .forward(request, response);
    }

    private void submitRating(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int taskId = Integer.parseInt(
                request.getParameter("taskId"));
        int ratedUser = Integer.parseInt(
                request.getParameter("ratedUser"));
        int score = Integer.parseInt(
                request.getParameter("score"));
        String feedback = request.getParameter("feedback");
        int ratedBy = (int) request.getSession()
                .getAttribute("userId");

        // Validate score
        if (score < 1 || score > 5) {
            request.setAttribute("error",
                    "Score must be between 1 and 5!");
            Task task = taskDAO.getTaskById(taskId);
            request.setAttribute("task", task);
            request.getRequestDispatcher(
                            "/views/student/rating-form.jsp")
                    .forward(request, response);
            return;
        }

        // Check already rated
        if (ratingDAO.alreadyRated(taskId, ratedBy)) {
            response.sendRedirect(
                    request.getContextPath() +
                            "/tasks/list?error=alreadyrated");
            return;
        }

        Rating rating = new Rating();
        rating.setTaskId(taskId);
        rating.setRatedBy(ratedBy);
        rating.setRatedUser(ratedUser);
        rating.setScore(score);
        rating.setFeedback(feedback);

        // Mark task as completed
        taskDAO.completeTask(taskId);

        boolean success = ratingDAO.addRating(rating);

        if (success) {
            response.sendRedirect(
                    request.getContextPath() +
                            "/tasks/list?success=rated");
        } else {
            request.setAttribute("error",
                    "Failed to submit rating!");
            Task task = taskDAO.getTaskById(taskId);
            request.setAttribute("task", task);
            request.getRequestDispatcher(
                            "/views/student/rating-form.jsp")
                    .forward(request, response);
        }
    }
}
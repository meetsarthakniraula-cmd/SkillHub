package com.example.campusskillhub.controller;

import com.example.campusskillhub.dao.SkillDAO;
import com.example.campusskillhub.dao.TaskDAO;
import com.example.campusskillhub.model.Skill;
import com.example.campusskillhub.model.Task;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/tasks/*")
public class TaskServlet extends HttpServlet {

    private TaskDAO taskDAO = new TaskDAO();
    private SkillDAO skillDAO = new SkillDAO();

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
        if (path == null || path.equals("/")) {
            path = "/list";
        }

        String role = (String) session
                .getAttribute("userRole");

        switch (path) {
            case "/list":
                listTasks(request, response, role);
                break;
            case "/add":
                showAddForm(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            case "/delete":
                deleteTask(request, response);
                break;
            case "/claim":
                claimTask(request, response);
                break;
            case "/complete":
                completeTask(request, response);
                break;
            case "/search":
                searchTasks(request, response);
                break;
            default:
                listTasks(request, response, role);
                break;
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
        if (path == null) path = "/list";

        switch (path) {
            case "/add":
                createTask(request, response);
                break;
            case "/edit":
                updateTask(request, response);
                break;
            default:
                response.sendRedirect(
                        request.getContextPath() + "/tasks/list");
                break;
        }
    }

    private void listTasks(HttpServletRequest request,
                           HttpServletResponse response,
                           String role)
            throws ServletException, IOException {

        List<Task> tasks;
        int userId = (int) request.getSession()
                .getAttribute("userId");

        if ("admin".equals(role)) {
            tasks = taskDAO.getAllTasks();
        } else if ("student".equals(role)) {
            tasks = taskDAO.getTasksByStudent(userId);
        } else {
            tasks = taskDAO.getOpenTasks();
        }

        request.setAttribute("tasks", tasks);
        request.setAttribute("role", role);

        if ("student".equals(role)) {
            request.getRequestDispatcher(
                            "/views/student/tasks.jsp")
                    .forward(request, response);
        } else if ("tutor".equals(role)) {
            request.getRequestDispatcher(
                            "/views/tutor/tasks.jsp")
                    .forward(request, response);
        } else {
            request.getRequestDispatcher(
                            "/views/admin/tasks.jsp")
                    .forward(request, response);
        }
    }

    private void showAddForm(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {
        List<Skill> skills = skillDAO.getAllSkills();
        request.setAttribute("skills", skills);
        request.getRequestDispatcher(
                        "/views/student/task-form.jsp")
                .forward(request, response);
    }

    private void showEditForm(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {
        int taskId = Integer.parseInt(
                request.getParameter("id"));
        Task task = taskDAO.getTaskById(taskId);
        List<Skill> skills = skillDAO.getAllSkills();
        request.setAttribute("task", task);
        request.setAttribute("skills", skills);
        request.setAttribute("edit", true);
        request.getRequestDispatcher(
                        "/views/student/task-form.jsp")
                .forward(request, response);
    }

    private void createTask(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter(
                "description");
        String skillIdStr = request.getParameter("skillId");
        String deadlineStr = request.getParameter("deadline");
        String budgetStr = request.getParameter("budget");
        int userId = (int) request.getSession()
                .getAttribute("userId");

        // Validation
        if (title == null || title.trim().isEmpty()) {
            request.setAttribute("error",
                    "Task title is required!");
            List<Skill> skills = skillDAO.getAllSkills();
            request.setAttribute("skills", skills);
            request.getRequestDispatcher(
                            "/views/student/task-form.jsp")
                    .forward(request, response);
            return;
        }

        if (description == null ||
                description.trim().isEmpty()) {
            request.setAttribute("error",
                    "Task description is required!");
            List<Skill> skills = skillDAO.getAllSkills();
            request.setAttribute("skills", skills);
            request.getRequestDispatcher(
                            "/views/student/task-form.jsp")
                    .forward(request, response);
            return;
        }

        Task task = new Task();
        task.setTitle(title.trim());
        task.setDescription(description.trim());
        task.setPostedBy(userId);
        task.setSkillId(skillIdStr != null &&
                !skillIdStr.isEmpty() ?
                Integer.parseInt(skillIdStr) : 0);
        task.setDeadline(deadlineStr != null &&
                !deadlineStr.isEmpty() ?
                Date.valueOf(deadlineStr) : null);
        task.setBudget(budgetStr != null &&
                !budgetStr.isEmpty() ?
                Double.parseDouble(budgetStr) : 0);

        boolean success = taskDAO.createTask(task);

        if (success) {
            response.sendRedirect(
                    request.getContextPath() +
                            "/tasks/list?success=created");
        } else {
            request.setAttribute("error",
                    "Failed to create task!");
            List<Skill> skills = skillDAO.getAllSkills();
            request.setAttribute("skills", skills);
            request.getRequestDispatcher(
                            "/views/student/task-form.jsp")
                    .forward(request, response);
        }
    }

    private void updateTask(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {

        int taskId = Integer.parseInt(
                request.getParameter("taskId"));
        String title = request.getParameter("title");
        String description = request.getParameter(
                "description");
        String skillIdStr = request.getParameter("skillId");
        String deadlineStr = request.getParameter("deadline");
        String budgetStr = request.getParameter("budget");
        int userId = (int) request.getSession()
                .getAttribute("userId");

        Task task = new Task();
        task.setTaskId(taskId);
        task.setTitle(title.trim());
        task.setDescription(description.trim());
        task.setPostedBy(userId);
        task.setSkillId(skillIdStr != null &&
                !skillIdStr.isEmpty() ?
                Integer.parseInt(skillIdStr) : 0);
        task.setDeadline(deadlineStr != null &&
                !deadlineStr.isEmpty() ?
                Date.valueOf(deadlineStr) : null);
        task.setBudget(budgetStr != null &&
                !budgetStr.isEmpty() ?
                Double.parseDouble(budgetStr) : 0);

        boolean success = taskDAO.updateTask(task);

        if (success) {
            response.sendRedirect(
                    request.getContextPath() +
                            "/tasks/list?success=updated");
        } else {
            request.setAttribute("error",
                    "Failed to update task!");
            request.setAttribute("edit", true);
            request.setAttribute("task", task);
            List<Skill> skills = skillDAO.getAllSkills();
            request.setAttribute("skills", skills);
            request.getRequestDispatcher(
                            "/views/student/task-form.jsp")
                    .forward(request, response);
        }
    }

    private void deleteTask(HttpServletRequest request,
                            HttpServletResponse response)
            throws IOException {
        int taskId = Integer.parseInt(
                request.getParameter("id"));
        taskDAO.deleteTask(taskId);
        response.sendRedirect(
                request.getContextPath() + "/tasks/list");
    }

    private void claimTask(HttpServletRequest request,
                           HttpServletResponse response)
            throws IOException {
        int taskId = Integer.parseInt(
                request.getParameter("id"));
        int tutorId = (int) request.getSession()
                .getAttribute("userId");
        taskDAO.claimTask(taskId, tutorId);
        response.sendRedirect(
                request.getContextPath() + "/tasks/list");
    }

    private void completeTask(HttpServletRequest request,
                              HttpServletResponse response)
            throws IOException {
        int taskId = Integer.parseInt(
                request.getParameter("id"));
        taskDAO.completeTask(taskId);
        response.sendRedirect(
                request.getContextPath() + "/tasks/list");
    }
    private void searchTasks(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");
        String skillIdStr =
                request.getParameter("skillId");
        String role = (String) request.getSession()
                .getAttribute("userRole");
        int userId = (int) request.getSession()
                .getAttribute("userId");

        List<Task> tasks = new ArrayList<>();

        // Filter by skill
        if (skillIdStr != null &&
                !skillIdStr.trim().isEmpty() &&
                !skillIdStr.equals("0")) {
            int skillId = Integer.parseInt(skillIdStr);
            tasks = taskDAO.filterBySkill(
                    skillId, role, userId);
        }
        // Search by keyword
        else if (keyword != null &&
                !keyword.trim().isEmpty()) {
            tasks = taskDAO.searchTasks(
                    keyword.trim(), role, userId);
        }
        // Show all if empty
        else {
            if ("admin".equals(role)) {
                tasks = taskDAO.getAllTasks();
            } else if ("student".equals(role)) {
                tasks = taskDAO.getTasksByStudent(userId);
            } else {
                tasks = taskDAO.getOpenTasks();
            }
        }

        // Get skills for filter dropdown
        List<Skill> skills = skillDAO.getAllSkills();
        request.setAttribute("skills", skills);
        request.setAttribute("tasks", tasks);
        request.setAttribute("keyword", keyword);
        request.setAttribute("selectedSkill",
                skillIdStr);
        request.setAttribute("role", role);
        request.setAttribute("isSearch", true);

        if ("student".equals(role)) {
            request.getRequestDispatcher(
                            "/views/student/tasks.jsp")
                    .forward(request, response);
        } else if ("tutor".equals(role)) {
            request.getRequestDispatcher(
                            "/views/tutor/tasks.jsp")
                    .forward(request, response);
        } else {
            request.getRequestDispatcher(
                            "/views/admin/tasks.jsp")
                    .forward(request, response);
        }
    }
}
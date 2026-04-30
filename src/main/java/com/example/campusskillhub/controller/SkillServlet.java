package com.example.campusskillhub.controller;

import com.example.campusskillhub.dao.SkillDAO;
import com.example.campusskillhub.model.Skill;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/skills/*")
public class SkillServlet extends HttpServlet {

    private SkillDAO skillDAO = new SkillDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Security check
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
            path = "/list";
        }

        switch (path) {
            case "/list":
                listSkills(request, response);
                break;
            case "/add":
                showAddForm(request, response);
                break;
            case "/edit":
                showEditForm(request, response);
                break;
            case "/delete":
                deleteSkill(request, response);
                break;
            default:
                listSkills(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null ||
                !"admin".equals(
                        session.getAttribute("userRole"))) {
            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        String path = request.getPathInfo();
        if (path == null) path = "/list";

        switch (path) {
            case "/add":
                addSkill(request, response);
                break;
            case "/edit":
                updateSkill(request, response);
                break;
            default:
                listSkills(request, response);
                break;
        }
    }

    private void listSkills(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {
        List<Skill> skills = skillDAO.getAllSkills();
        request.setAttribute("skills", skills);
        request.getRequestDispatcher(
                        "/views/admin/skills.jsp")
                .forward(request, response);
    }

    private void showAddForm(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(
                        "/views/admin/skill-form.jsp")
                .forward(request, response);
    }

    private void showEditForm(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {
        int skillId = Integer.parseInt(
                request.getParameter("id"));
        Skill skill = skillDAO.getSkillById(skillId);
        request.setAttribute("skill", skill);
        request.setAttribute("edit", true);
        request.getRequestDispatcher(
                        "/views/admin/skill-form.jsp")
                .forward(request, response);
    }

    private void addSkill(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String skillName = request.getParameter("skillName");
        String description = request.getParameter(
                "description");
        int adminId = (int) request.getSession()
                .getAttribute("userId");

        // Validation
        if (skillName == null || skillName.trim().isEmpty()) {
            request.setAttribute("error",
                    "Skill name is required!");
            request.getRequestDispatcher(
                            "/views/admin/skill-form.jsp")
                    .forward(request, response);
            return;
        }

        // Check duplicate
        if (skillDAO.skillExists(skillName.trim())) {
            request.setAttribute("error",
                    "This skill already exists!");
            request.getRequestDispatcher(
                            "/views/admin/skill-form.jsp")
                    .forward(request, response);
            return;
        }

        Skill skill = new Skill(
                skillName.trim(), description, adminId);
        boolean success = skillDAO.addSkill(skill);

        if (success) {
            response.sendRedirect(request.getContextPath()
                    + "/admin/skills/list?success=added");
        } else {
            request.setAttribute("error",
                    "Failed to add skill. Try again!");
            request.getRequestDispatcher(
                            "/views/admin/skill-form.jsp")
                    .forward(request, response);
        }
    }

    private void updateSkill(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {

        int skillId = Integer.parseInt(
                request.getParameter("skillId"));
        String skillName = request.getParameter("skillName");
        String description = request.getParameter(
                "description");

        if (skillName == null || skillName.trim().isEmpty()) {
            request.setAttribute("error",
                    "Skill name is required!");
            request.setAttribute("edit", true);
            Skill skill = skillDAO.getSkillById(skillId);
            request.setAttribute("skill", skill);
            request.getRequestDispatcher(
                            "/views/admin/skill-form.jsp")
                    .forward(request, response);
            return;
        }

        Skill skill = new Skill();
        skill.setSkillId(skillId);
        skill.setSkillName(skillName.trim());
        skill.setDescription(description);

        boolean success = skillDAO.updateSkill(skill);

        if (success) {
            response.sendRedirect(request.getContextPath()
                    + "/admin/skills/list?success=updated");
        } else {
            request.setAttribute("error",
                    "Failed to update skill!");
            request.setAttribute("edit", true);
            request.setAttribute("skill", skill);
            request.getRequestDispatcher(
                            "/views/admin/skill-form.jsp")
                    .forward(request, response);
        }
    }

    private void deleteSkill(HttpServletRequest request,
                             HttpServletResponse response)
            throws IOException {
        int skillId = Integer.parseInt(
                request.getParameter("id"));
        skillDAO.deleteSkill(skillId);
        response.sendRedirect(request.getContextPath()
                + "/admin/skills/list");
    }
}
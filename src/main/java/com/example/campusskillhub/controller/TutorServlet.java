package com.example.campusskillhub.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/tutor/*")
public class TutorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
                !session.getAttribute("userRole").equals("tutor")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getPathInfo();
        if (path == null) path = "/dashboard";

        switch (path) {
            case "/dashboard":
                request.getRequestDispatcher("/views/tutor/dashboard.jsp")
                        .forward(request, response);
                break;
            default:
                request.getRequestDispatcher("/views/tutor/dashboard.jsp")
                        .forward(request, response);
        }
    }
}
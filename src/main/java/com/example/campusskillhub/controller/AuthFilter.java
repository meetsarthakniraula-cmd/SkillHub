package com.example.campusskillhub.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebFilter;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;
        HttpServletResponse res =
                (HttpServletResponse) response;

        String uri = req.getRequestURI();

        // Allow public pages without login
        if (uri.contains("/login") ||
                uri.contains("/register") ||
                uri.contains("/logout") ||
                uri.contains("/css") ||
                uri.contains("/js") ||
                uri.contains("/images") ||
                uri.contains("/admin") ||
                uri.contains("/student") ||
                uri.contains("/tutor") ||
                uri.endsWith(".jsp") ||
                uri.endsWith(".css") ||
                uri.endsWith(".js") ||
                uri.endsWith("/")) {
            chain.doFilter(request, response);
            return;
        }

        // Check session for logged in user
        HttpSession session =
                req.getSession(false);
        if (session != null &&
                session.getAttribute("user") != null) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(
                    req.getContextPath() + "/login");
        }
    }
}
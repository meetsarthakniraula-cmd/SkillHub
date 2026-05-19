package com.example.campusskillhub.controller;

import com.example.campusskillhub.dao.MessageDAO;
import com.example.campusskillhub.dao.TaskDAO;
import com.example.campusskillhub.model.Message;
import com.example.campusskillhub.model.Task;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/messages/*")
public class MessageServlet extends HttpServlet {

    private MessageDAO messageDAO = new MessageDAO();
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
        if (path == null) path = "/inbox";

        switch (path) {
            case "/inbox":
                showInbox(request, response);
                break;
            case "/chat":
                showChat(request, response);
                break;
            default:
                showInbox(request, response);
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
        if (path != null && path.equals("/send")) {
            sendMessage(request, response);
        }
    }

    private void showInbox(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {
        int userId = (int) request.getSession()
                .getAttribute("userId");
        List<Message> conversations =
                messageDAO.getConversations(userId);
        int unreadCount = messageDAO.countUnread(userId);
        request.setAttribute("conversations", conversations);
        request.setAttribute("unreadCount", unreadCount);
        request.getRequestDispatcher(
                        "/views/messages/inbox.jsp")
                .forward(request, response);
    }

    private void showChat(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        int taskId = Integer.parseInt(
                request.getParameter("taskId"));
        int userId = (int) request.getSession()
                .getAttribute("userId");

        Task task = taskDAO.getTaskById(taskId);
        List<Message> messages =
                messageDAO.getMessagesByTask(taskId);

        // Mark messages as read
        messageDAO.markAsRead(taskId, userId);

        request.setAttribute("task", task);
        request.setAttribute("messages", messages);
        request.getRequestDispatcher(
                        "/views/messages/chat.jsp")
                .forward(request, response);
    }

    private void sendMessage(HttpServletRequest request,
                             HttpServletResponse response)
            throws IOException {
        int taskId = Integer.parseInt(
                request.getParameter("taskId"));
        int receiverId = Integer.parseInt(
                request.getParameter("receiverId"));
        String messageText =
                request.getParameter("message");
        int senderId = (int) request.getSession()
                .getAttribute("userId");

        if (messageText != null &&
                !messageText.trim().isEmpty()) {
            Message message = new Message();
            message.setTaskId(taskId);
            message.setSenderId(senderId);
            message.setReceiverId(receiverId);
            message.setMessage(messageText.trim());
            messageDAO.sendMessage(message);
        }

        response.sendRedirect(
                request.getContextPath() +
                        "/messages/chat?taskId=" + taskId);
    }
}
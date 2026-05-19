package com.example.campusskillhub.dao;

import com.example.campusskillhub.model.Message;
import com.example.campusskillhub.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {

    // Send a message
    public boolean sendMessage(Message message) {
        String sql = "INSERT INTO messages " +
                "(task_id, sender_id, receiver_id, message) " +
                "VALUES (?, ?, ?, ?)";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ps.setInt(1, message.getTaskId());
            ps.setInt(2, message.getSenderId());
            ps.setInt(3, message.getReceiverId());
            ps.setString(4, message.getMessage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error sending message: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get all messages for a task
    public List<Message> getMessagesByTask(int taskId) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT m.*, " +
                "u1.full_name as sender_name, " +
                "u2.full_name as receiver_name, " +
                "t.title as task_title " +
                "FROM messages m " +
                "JOIN users u1 ON m.sender_id = u1.user_id " +
                "JOIN users u2 ON m.receiver_id = u2.user_id " +
                "JOIN tasks t ON m.task_id = t.task_id " +
                "WHERE m.task_id = ? " +
                "ORDER BY m.sent_at ASC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ps.setInt(1, taskId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                messages.add(mapMessage(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting messages: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return messages;
    }

    // Mark messages as read
    public void markAsRead(int taskId, int receiverId) {
        String sql = "UPDATE messages SET is_read = true " +
                "WHERE task_id = ? AND receiver_id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ps.setInt(1, taskId);
            ps.setInt(2, receiverId);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error marking read: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Count unread messages for a user
    public int countUnread(int userId) {
        String sql = "SELECT COUNT(*) FROM messages " +
                "WHERE receiver_id = ? AND is_read = false";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting unread: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    // Get all conversations for a user
    public List<Message> getConversations(int userId) {
        List<Message> messages = new ArrayList<>();
        String sql = "SELECT m.*, " +
                "u1.full_name as sender_name, " +
                "u2.full_name as receiver_name, " +
                "t.title as task_title " +
                "FROM messages m " +
                "JOIN users u1 ON m.sender_id = u1.user_id " +
                "JOIN users u2 ON m.receiver_id = u2.user_id " +
                "JOIN tasks t ON m.task_id = t.task_id " +
                "WHERE m.sender_id = ? OR m.receiver_id = ? " +
                "ORDER BY m.sent_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                messages.add(mapMessage(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting convos: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return messages;
    }

    // Helper method
    private Message mapMessage(ResultSet rs)
            throws SQLException {
        Message msg = new Message();
        msg.setMessageId(rs.getInt("message_id"));
        msg.setTaskId(rs.getInt("task_id"));
        msg.setSenderId(rs.getInt("sender_id"));
        msg.setReceiverId(rs.getInt("receiver_id"));
        msg.setMessage(rs.getString("message"));
        msg.setRead(rs.getBoolean("is_read"));
        msg.setSentAt(rs.getTimestamp("sent_at"));
        msg.setSenderName(rs.getString("sender_name"));
        msg.setReceiverName(rs.getString("receiver_name"));
        msg.setTaskTitle(rs.getString("task_title"));
        return msg;
    }
}
package com.example.campusskillhub.dao;

import com.example.campusskillhub.model.User;
import com.example.campusskillhub.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    // Get all pending users
    public List<User> getPendingUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE status = 'pending'";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setDepartment(rs.getString("department"));
                user.setAcademicYear(rs.getString("academic_year"));
                user.setStatus(rs.getString("status"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.out.println("Error getting pending users: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return users;
    }

    // Get all users except admin
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role != 'admin' ORDER BY created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setDepartment(rs.getString("department"));
                user.setStatus(rs.getString("status"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.out.println("Error getting all users: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return users;
    }

    // Approve user
    public boolean approveUser(int userId) {
        String sql = "UPDATE users SET status = 'active' WHERE user_id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error approving user: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Suspend user
    public boolean suspendUser(int userId) {
        String sql = "UPDATE users SET status = 'suspended' WHERE user_id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error suspending user: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Delete user
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting user: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get system statistics
    public int countUsers(String role) {
        String sql = "SELECT COUNT(*) FROM users WHERE role = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting users: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    public int countPendingUsers() {
        String sql = "SELECT COUNT(*) FROM users WHERE status = 'pending'";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting pending: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    public int countTasks(String status) {
        String sql = "SELECT COUNT(*) FROM tasks WHERE status = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error counting tasks: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }
    // Count all active users
    public int countActiveUsers() {
        String sql = "SELECT COUNT(*) FROM users " +
                "WHERE status = 'active' " +
                "AND role != 'admin'";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    // Count completed tasks
    public int countCompletedTasks() {
        String sql = "SELECT COUNT(*) FROM tasks " +
                "WHERE status = 'completed'";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    // Count in progress tasks
    public int countInProgressTasks() {
        String sql = "SELECT COUNT(*) FROM tasks " +
                "WHERE status = 'in_progress'";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    // Count total tasks
    public int countAllTasks() {
        String sql = "SELECT COUNT(*) FROM tasks";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    // Count total ratings
    public int countTotalRatings() {
        String sql = "SELECT COUNT(*) FROM ratings";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0;
    }

    // Get top rated tutors
    public List<String[]> getTopRatedTutors() {
        List<String[]> tutors = new ArrayList<>();
        String sql = "SELECT u.full_name, " +
                "COUNT(r.rating_id) as total_ratings, " +
                "ROUND(AVG(r.score), 1) as avg_rating " +
                "FROM ratings r " +
                "JOIN users u ON r.rated_user = u.user_id " +
                "GROUP BY u.user_id, u.full_name " +
                "ORDER BY avg_rating DESC " +
                "LIMIT 5";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] tutor = {
                        rs.getString("full_name"),
                        String.valueOf(
                                rs.getInt("total_ratings")),
                        String.valueOf(
                                rs.getDouble("avg_rating"))
                };
                tutors.add(tutor);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return tutors;
    }

    // Get most popular skills
    public List<String[]> getPopularSkills() {
        List<String[]> skills = new ArrayList<>();
        String sql = "SELECT s.skill_name, " +
                "COUNT(t.task_id) as task_count " +
                "FROM skills s " +
                "LEFT JOIN tasks t " +
                "ON s.skill_id = t.skill_id " +
                "GROUP BY s.skill_id, s.skill_name " +
                "ORDER BY task_count DESC " +
                "LIMIT 5";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] skill = {
                        rs.getString("skill_name"),
                        String.valueOf(
                                rs.getInt("task_count"))
                };
                skills.add(skill);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return skills;
    }

    // Get recent registrations
    public List<User> getRecentUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users " +
                "WHERE role != 'admin' " +
                "ORDER BY created_at DESC LIMIT 5";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(
                        rs.getInt("user_id"));
                user.setFullName(
                        rs.getString("full_name"));
                user.setEmail(
                        rs.getString("email"));
                user.setRole(
                        rs.getString("role"));
                user.setStatus(
                        rs.getString("status"));
                user.setCreatedAt(
                        rs.getTimestamp("created_at"));
                users.add(user);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return users;
    }
}
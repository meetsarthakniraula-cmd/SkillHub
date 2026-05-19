package com.example.campusskillhub.dao;

import com.example.campusskillhub.model.Task;
import com.example.campusskillhub.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    // Get all tasks with user and skill names
    public List<Task> getAllTasks() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT t.*, " +
                "u1.full_name as posted_by_name, " +
                "u2.full_name as claimed_by_name, " +
                "s.skill_name " +
                "FROM tasks t " +
                "LEFT JOIN users u1 ON t.posted_by = u1.user_id " +
                "LEFT JOIN users u2 ON t.claimed_by = u2.user_id " +
                "LEFT JOIN skills s ON t.skill_id = s.skill_id " +
                "ORDER BY t.created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tasks.add(mapTask(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting tasks: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return tasks;
    }

    // Get tasks by student
    public List<Task> getTasksByStudent(int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT t.*, " +
                "u1.full_name as posted_by_name, " +
                "u2.full_name as claimed_by_name, " +
                "s.skill_name " +
                "FROM tasks t " +
                "LEFT JOIN users u1 ON t.posted_by = u1.user_id " +
                "LEFT JOIN users u2 ON t.claimed_by = u2.user_id " +
                "LEFT JOIN skills s ON t.skill_id = s.skill_id " +
                "WHERE t.posted_by = ? " +
                "ORDER BY t.created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tasks.add(mapTask(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting student tasks: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return tasks;
    }

    // Get open tasks for tutors
    public List<Task> getOpenTasks() {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT t.*, " +
                "u1.full_name as posted_by_name, " +
                "u2.full_name as claimed_by_name, " +
                "s.skill_name " +
                "FROM tasks t " +
                "LEFT JOIN users u1 ON t.posted_by = u1.user_id " +
                "LEFT JOIN users u2 ON t.claimed_by = u2.user_id " +
                "LEFT JOIN skills s ON t.skill_id = s.skill_id " +
                "WHERE t.status = 'open' " +
                "ORDER BY t.created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tasks.add(mapTask(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting open tasks: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return tasks;
    }

    // Get tasks claimed by tutor
    public List<Task> getTasksByTutor(int tutorId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT t.*, " +
                "u1.full_name as posted_by_name, " +
                "u2.full_name as claimed_by_name, " +
                "s.skill_name " +
                "FROM tasks t " +
                "LEFT JOIN users u1 ON t.posted_by = u1.user_id " +
                "LEFT JOIN users u2 ON t.claimed_by = u2.user_id " +
                "LEFT JOIN skills s ON t.skill_id = s.skill_id " +
                "WHERE t.claimed_by = ? " +
                "ORDER BY t.created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, tutorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tasks.add(mapTask(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error getting tutor tasks: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return tasks;
    }

    // Get single task by ID
    public Task getTaskById(int taskId) {
        String sql = "SELECT t.*, " +
                "u1.full_name as posted_by_name, " +
                "u2.full_name as claimed_by_name, " +
                "s.skill_name " +
                "FROM tasks t " +
                "LEFT JOIN users u1 ON t.posted_by = u1.user_id " +
                "LEFT JOIN users u2 ON t.claimed_by = u2.user_id " +
                "LEFT JOIN skills s ON t.skill_id = s.skill_id " +
                "WHERE t.task_id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, taskId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapTask(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error getting task: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    // Create new task
    public boolean createTask(Task task) {
        String sql = "INSERT INTO tasks (title, description," +
                " posted_by, skill_id, deadline, budget, status)" +
                " VALUES (?, ?, ?, ?, ?, ?, 'open')";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, task.getTitle());
            ps.setString(2, task.getDescription());
            ps.setInt(3, task.getPostedBy());
            ps.setInt(4, task.getSkillId());
            ps.setDate(5, task.getDeadline());
            ps.setDouble(6, task.getBudget());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error creating task: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Update task
    public boolean updateTask(Task task) {
        String sql = "UPDATE tasks SET title=?, " +
                "description=?, skill_id=?, " +
                "deadline=?, budget=? " +
                "WHERE task_id=? AND posted_by=?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, task.getTitle());
            ps.setString(2, task.getDescription());
            ps.setInt(3, task.getSkillId());
            ps.setDate(4, task.getDeadline());
            ps.setDouble(5, task.getBudget());
            ps.setInt(6, task.getTaskId());
            ps.setInt(7, task.getPostedBy());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating task: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Delete task
    public boolean deleteTask(int taskId) {
        String sql = "DELETE FROM tasks WHERE task_id=?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, taskId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting task: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Claim task by tutor
    public boolean claimTask(int taskId, int tutorId) {
        String sql = "UPDATE tasks SET claimed_by=?, " +
                "status='in_progress' WHERE task_id=? " +
                "AND status='open'";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, tutorId);
            ps.setInt(2, taskId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error claiming task: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Complete task
    public boolean completeTask(int taskId) {
        String sql = "UPDATE tasks SET status='completed'" +
                " WHERE task_id=?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, taskId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error completing task: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Helper method to map ResultSet to Task
    private Task mapTask(ResultSet rs) throws SQLException {
        Task task = new Task();
        task.setTaskId(rs.getInt("task_id"));
        task.setTitle(rs.getString("title"));
        task.setDescription(rs.getString("description"));
        task.setPostedBy(rs.getInt("posted_by"));
        task.setClaimedBy(rs.getInt("claimed_by"));
        task.setSkillId(rs.getInt("skill_id"));
        task.setDeadline(rs.getDate("deadline"));
        task.setBudget(rs.getDouble("budget"));
        task.setStatus(rs.getString("status"));
        task.setCreatedAt(rs.getTimestamp("created_at"));
        task.setPostedByName(rs.getString("posted_by_name"));
        task.setClaimedByName(rs.getString("claimed_by_name"));
        task.setSkillName(rs.getString("skill_name"));
        return task;
    }
    // Search tasks by keyword
    public List<Task> searchTasks(
            String keyword, String role, int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "";

        if ("admin".equals(role)) {
            sql = "SELECT t.*, " +
                    "u1.full_name as posted_by_name, " +
                    "u2.full_name as claimed_by_name, " +
                    "s.skill_name " +
                    "FROM tasks t " +
                    "LEFT JOIN users u1 " +
                    "ON t.posted_by = u1.user_id " +
                    "LEFT JOIN users u2 " +
                    "ON t.claimed_by = u2.user_id " +
                    "LEFT JOIN skills s " +
                    "ON t.skill_id = s.skill_id " +
                    "WHERE t.title LIKE ? " +
                    "OR t.description LIKE ? " +
                    "OR s.skill_name LIKE ? " +
                    "ORDER BY t.created_at DESC";
        } else if ("student".equals(role)) {
            sql = "SELECT t.*, " +
                    "u1.full_name as posted_by_name, " +
                    "u2.full_name as claimed_by_name, " +
                    "s.skill_name " +
                    "FROM tasks t " +
                    "LEFT JOIN users u1 " +
                    "ON t.posted_by = u1.user_id " +
                    "LEFT JOIN users u2 " +
                    "ON t.claimed_by = u2.user_id " +
                    "LEFT JOIN skills s " +
                    "ON t.skill_id = s.skill_id " +
                    "WHERE t.posted_by = ? " +
                    "AND (t.title LIKE ? " +
                    "OR t.description LIKE ? " +
                    "OR s.skill_name LIKE ?) " +
                    "ORDER BY t.created_at DESC";
        } else {
            sql = "SELECT t.*, " +
                    "u1.full_name as posted_by_name, " +
                    "u2.full_name as claimed_by_name, " +
                    "s.skill_name " +
                    "FROM tasks t " +
                    "LEFT JOIN users u1 " +
                    "ON t.posted_by = u1.user_id " +
                    "LEFT JOIN users u2 " +
                    "ON t.claimed_by = u2.user_id " +
                    "LEFT JOIN skills s " +
                    "ON t.skill_id = s.skill_id " +
                    "WHERE t.status = 'open' " +
                    "AND (t.title LIKE ? " +
                    "OR t.description LIKE ? " +
                    "OR s.skill_name LIKE ?) " +
                    "ORDER BY t.created_at DESC";
        }

        String pattern = "%" + keyword + "%";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            if ("student".equals(role)) {
                ps.setInt(1, userId);
                ps.setString(2, pattern);
                ps.setString(3, pattern);
                ps.setString(4, pattern);
            } else {
                ps.setString(1, pattern);
                ps.setString(2, pattern);
                ps.setString(3, pattern);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tasks.add(mapTask(rs));
            }
        } catch (SQLException e) {
            System.out.println("Search error: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return tasks;
    }

    // Filter tasks by skill
    public List<Task> filterBySkill(
            int skillId, String role, int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "";

        if ("admin".equals(role)) {
            sql = "SELECT t.*, " +
                    "u1.full_name as posted_by_name, " +
                    "u2.full_name as claimed_by_name, " +
                    "s.skill_name " +
                    "FROM tasks t " +
                    "LEFT JOIN users u1 " +
                    "ON t.posted_by = u1.user_id " +
                    "LEFT JOIN users u2 " +
                    "ON t.claimed_by = u2.user_id " +
                    "LEFT JOIN skills s " +
                    "ON t.skill_id = s.skill_id " +
                    "WHERE t.skill_id = ? " +
                    "ORDER BY t.created_at DESC";
        } else if ("student".equals(role)) {
            sql = "SELECT t.*, " +
                    "u1.full_name as posted_by_name, " +
                    "u2.full_name as claimed_by_name, " +
                    "s.skill_name " +
                    "FROM tasks t " +
                    "LEFT JOIN users u1 " +
                    "ON t.posted_by = u1.user_id " +
                    "LEFT JOIN users u2 " +
                    "ON t.claimed_by = u2.user_id " +
                    "LEFT JOIN skills s " +
                    "ON t.skill_id = s.skill_id " +
                    "WHERE t.posted_by = ? " +
                    "AND t.skill_id = ? " +
                    "ORDER BY t.created_at DESC";
        } else {
            sql = "SELECT t.*, " +
                    "u1.full_name as posted_by_name, " +
                    "u2.full_name as claimed_by_name, " +
                    "s.skill_name " +
                    "FROM tasks t " +
                    "LEFT JOIN users u1 " +
                    "ON t.posted_by = u1.user_id " +
                    "LEFT JOIN users u2 " +
                    "ON t.claimed_by = u2.user_id " +
                    "LEFT JOIN skills s " +
                    "ON t.skill_id = s.skill_id " +
                    "WHERE t.status = 'open' " +
                    "AND t.skill_id = ? " +
                    "ORDER BY t.created_at DESC";
        }

        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            if ("student".equals(role)) {
                ps.setInt(1, userId);
                ps.setInt(2, skillId);
            } else {
                ps.setInt(1, skillId);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                tasks.add(mapTask(rs));
            }
        } catch (SQLException e) {
            System.out.println("Filter error: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return tasks;
    }
}
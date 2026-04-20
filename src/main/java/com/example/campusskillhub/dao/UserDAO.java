package com.example.campusskillhub.dao;

import com.example.campusskillhub.model.User;
import com.example.campusskillhub.util.DBConnection;
import com.example.campusskillhub.util.PasswordUtil;

import java.sql.*;

public class UserDAO {

    // Register new user
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (full_name, email, password, phone, role, department, academic_year) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, PasswordUtil.encrypt(user.getPassword()));
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getRole());
            ps.setString(6, user.getDepartment());
            ps.setString(7, user.getAcademicYear());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Register error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Login - find user by email and password
    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ? AND password = ? AND status = 'active'";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, PasswordUtil.encrypt(password));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                user.setDepartment(rs.getString("department"));
                user.setAcademicYear(rs.getString("academic_year"));
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Login error: " + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    // Check if email already exists
    public boolean emailExists(String email) {
        String sql = "SELECT user_id FROM users WHERE email = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Email check error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Check if phone already exists
    public boolean phoneExists(String phone) {
        String sql = "SELECT user_id FROM users WHERE phone = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Phone check error: " + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}
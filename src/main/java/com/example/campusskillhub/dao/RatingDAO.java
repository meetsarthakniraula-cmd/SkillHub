package com.example.campusskillhub.dao;

import com.example.campusskillhub.model.Rating;
import com.example.campusskillhub.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RatingDAO {

    // Add rating
    public boolean addRating(Rating rating) {
        String sql = "INSERT INTO ratings (task_id, " +
                "rated_by, rated_user, score, feedback) " +
                "VALUES (?, ?, ?, ?, ?)";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ps.setInt(1, rating.getTaskId());
            ps.setInt(2, rating.getRatedBy());
            ps.setInt(3, rating.getRatedUser());
            ps.setInt(4, rating.getScore());
            ps.setString(5, rating.getFeedback());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding rating: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Check if already rated
    public boolean alreadyRated(int taskId, int ratedBy) {
        String sql = "SELECT rating_id FROM ratings " +
                "WHERE task_id = ? AND rated_by = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ps.setInt(1, taskId);
            ps.setInt(2, ratedBy);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error checking rating: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Get ratings for a user
    public List<Rating> getRatingsForUser(int userId) {
        List<Rating> ratings = new ArrayList<>();
        String sql = "SELECT r.*, " +
                "u1.full_name as rated_by_name, " +
                "u2.full_name as rated_user_name, " +
                "t.title as task_title " +
                "FROM ratings r " +
                "JOIN users u1 ON r.rated_by = u1.user_id " +
                "JOIN users u2 ON r.rated_user = u2.user_id " +
                "JOIN tasks t ON r.task_id = t.task_id " +
                "WHERE r.rated_user = ? " +
                "ORDER BY r.created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rating rating = new Rating();
                rating.setRatingId(
                        rs.getInt("rating_id"));
                rating.setTaskId(rs.getInt("task_id"));
                rating.setRatedBy(rs.getInt("rated_by"));
                rating.setRatedUser(
                        rs.getInt("rated_user"));
                rating.setScore(rs.getInt("score"));
                rating.setFeedback(
                        rs.getString("feedback"));
                rating.setCreatedAt(
                        rs.getTimestamp("created_at"));
                rating.setRatedByName(
                        rs.getString("rated_by_name"));
                rating.setRatedUserName(
                        rs.getString("rated_user_name"));
                rating.setTaskTitle(
                        rs.getString("task_title"));
                ratings.add(rating);
            }
        } catch (SQLException e) {
            System.out.println("Error getting ratings: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return ratings;
    }

    // Get average rating for a user
    public double getAverageRating(int userId) {
        String sql = "SELECT AVG(score) FROM ratings " +
                "WHERE rated_user = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            System.out.println("Error getting average: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return 0.0;
    }
}

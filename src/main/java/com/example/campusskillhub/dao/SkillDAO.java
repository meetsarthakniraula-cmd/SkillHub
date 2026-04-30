package com.example.campusskillhub.dao;

import com.example.campusskillhub.model.Skill;
import com.example.campusskillhub.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SkillDAO {

    // Get all skills
    public List<Skill> getAllSkills() {
        List<Skill> skills = new ArrayList<>();
        String sql = "SELECT * FROM skills ORDER BY " +
                "created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Skill skill = new Skill();
                skill.setSkillId(rs.getInt("skill_id"));
                skill.setSkillName(rs.getString("skill_name"));
                skill.setDescription(
                        rs.getString("description"));
                skill.setCreatedAt(
                        rs.getTimestamp("created_at"));
                skills.add(skill);
            }
        } catch (SQLException e) {
            System.out.println("Error getting skills: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return skills;
    }

    // Get skill by ID
    public Skill getSkillById(int skillId) {
        String sql = "SELECT * FROM skills " +
                "WHERE skill_id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, skillId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Skill skill = new Skill();
                skill.setSkillId(rs.getInt("skill_id"));
                skill.setSkillName(rs.getString("skill_name"));
                skill.setDescription(
                        rs.getString("description"));
                skill.setCreatedAt(
                        rs.getTimestamp("created_at"));
                return skill;
            }
        } catch (SQLException e) {
            System.out.println("Error getting skill: "
                    + e.getMessage());
        } finally {
            DBConnection.closeConnection(conn);
        }
        return null;
    }

    // Add new skill
    public boolean addSkill(Skill skill) {
        String sql = "INSERT INTO skills " +
                "(skill_name, description, created_by)" +
                " VALUES (?, ?, ?)";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, skill.getSkillName());
            ps.setString(2, skill.getDescription());
            ps.setInt(3, skill.getCreatedBy());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error adding skill: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Update skill
    public boolean updateSkill(Skill skill) {
        String sql = "UPDATE skills SET skill_name = ?, " +
                "description = ? " +
                "WHERE skill_id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, skill.getSkillName());
            ps.setString(2, skill.getDescription());
            ps.setInt(3, skill.getSkillId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating skill: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Delete skill
    public boolean deleteSkill(int skillId) {
        String sql = "DELETE FROM skills " +
                "WHERE skill_id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, skillId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error deleting skill: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }

    // Check if skill name already exists
    public boolean skillExists(String skillName) {
        String sql = "SELECT skill_id FROM skills " +
                "WHERE skill_name = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, skillName);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Error checking skill: "
                    + e.getMessage());
            return false;
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}

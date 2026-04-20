package com.example.campusskillhub.model;

import java.sql.Timestamp;

public class User {

    private int userId;
    private String fullName;
    private String email;
    private String password;
    private String phone;
    private String role;
    private String department;
    private String academicYear;
    private String bio;
    private String status;
    private Timestamp createdAt;

    public User() {}

    public User(String fullName, String email, String password,
                String phone, String role) {
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.role = role;
    }

    // Getters
    public int getUserId() { return userId; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getPassword() { return password; }
    public String getPhone() { return phone; }
    public String getRole() { return role; }
    public String getDepartment() { return department; }
    public String getAcademicYear() { return academicYear; }
    public String getBio() { return bio; }
    public String getStatus() { return status; }
    public Timestamp getCreatedAt() { return createdAt; }

    // Setters
    public void setUserId(int userId) { this.userId = userId; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setEmail(String email) { this.email = email; }
    public void setPassword(String password) { this.password = password; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setRole(String role) { this.role = role; }
    public void setDepartment(String department) { this.department = department; }
    public void setAcademicYear(String academicYear) { this.academicYear = academicYear; }
    public void setBio(String bio) { this.bio = bio; }
    public void setStatus(String status) { this.status = status; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
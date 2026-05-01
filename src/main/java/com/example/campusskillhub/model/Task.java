package com.example.campusskillhub.model;

import java.sql.Date;
import java.sql.Timestamp;

public class Task {

    private int taskId;
    private String title;
    private String description;
    private int postedBy;
    private int claimedBy;
    private int skillId;
    private Date deadline;
    private double budget;
    private String status;
    private Timestamp createdAt;

    // Extra fields for display
    private String postedByName;
    private String claimedByName;
    private String skillName;

    public Task() {}

    // Getters
    public int getTaskId() { return taskId; }
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public int getPostedBy() { return postedBy; }
    public int getClaimedBy() { return claimedBy; }
    public int getSkillId() { return skillId; }
    public Date getDeadline() { return deadline; }
    public double getBudget() { return budget; }
    public String getStatus() { return status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public String getPostedByName() { return postedByName; }
    public String getClaimedByName() { return claimedByName; }
    public String getSkillName() { return skillName; }

    // Setters
    public void setTaskId(int taskId) {
        this.taskId = taskId; }
    public void setTitle(String title) {
        this.title = title; }
    public void setDescription(String description) {
        this.description = description; }
    public void setPostedBy(int postedBy) {
        this.postedBy = postedBy; }
    public void setClaimedBy(int claimedBy) {
        this.claimedBy = claimedBy; }
    public void setSkillId(int skillId) {
        this.skillId = skillId; }
    public void setDeadline(Date deadline) {
        this.deadline = deadline; }
    public void setBudget(double budget) {
        this.budget = budget; }
    public void setStatus(String status) {
        this.status = status; }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt; }
    public void setPostedByName(String postedByName) {
        this.postedByName = postedByName; }
    public void setClaimedByName(String claimedByName) {
        this.claimedByName = claimedByName; }
    public void setSkillName(String skillName) {
        this.skillName = skillName; }
}
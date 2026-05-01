package com.example.campusskillhub.model;

import java.sql.Timestamp;

public class Rating {

    private int ratingId;
    private int taskId;
    private int ratedBy;
    private int ratedUser;
    private int score;
    private String feedback;
    private Timestamp createdAt;

    // Extra display fields
    private String ratedByName;
    private String ratedUserName;
    private String taskTitle;

    public Rating() {}

    // Getters
    public int getRatingId() { return ratingId; }
    public int getTaskId() { return taskId; }
    public int getRatedBy() { return ratedBy; }
    public int getRatedUser() { return ratedUser; }
    public int getScore() { return score; }
    public String getFeedback() { return feedback; }
    public Timestamp getCreatedAt() { return createdAt; }
    public String getRatedByName() { return ratedByName; }
    public String getRatedUserName() { return ratedUserName; }
    public String getTaskTitle() { return taskTitle; }

    // Setters
    public void setRatingId(int ratingId) {
        this.ratingId = ratingId; }
    public void setTaskId(int taskId) {
        this.taskId = taskId; }
    public void setRatedBy(int ratedBy) {
        this.ratedBy = ratedBy; }
    public void setRatedUser(int ratedUser) {
        this.ratedUser = ratedUser; }
    public void setScore(int score) {
        this.score = score; }
    public void setFeedback(String feedback) {
        this.feedback = feedback; }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt; }
    public void setRatedByName(String ratedByName) {
        this.ratedByName = ratedByName; }
    public void setRatedUserName(String ratedUserName) {
        this.ratedUserName = ratedUserName; }
    public void setTaskTitle(String taskTitle) {
        this.taskTitle = taskTitle; }
}
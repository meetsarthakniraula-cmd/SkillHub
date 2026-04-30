package com.example.campusskillhub.model;

import java.sql.Timestamp;

public class Skill {

    private int skillId;
    private String skillName;
    private String description;
    private int createdBy;
    private Timestamp createdAt;

    public Skill() {}

    public Skill(String skillName, String description,
                 int createdBy) {
        this.skillName = skillName;
        this.description = description;
        this.createdBy = createdBy;
    }

    // Getters
    public int getSkillId() { return skillId; }
    public String getSkillName() { return skillName; }
    public String getDescription() { return description; }
    public int getCreatedBy() { return createdBy; }
    public Timestamp getCreatedAt() { return createdAt; }

    // Setters
    public void setSkillId(int skillId) {
        this.skillId = skillId; }
    public void setSkillName(String skillName) {
        this.skillName = skillName; }
    public void setDescription(String description) {
        this.description = description; }
    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy; }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt; }
}
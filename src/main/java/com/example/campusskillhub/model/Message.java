package com.example.campusskillhub.model;

import java.sql.Timestamp;

public class Message {

    private int messageId;
    private int taskId;
    private int senderId;
    private int receiverId;
    private String message;
    private boolean isRead;
    private Timestamp sentAt;

    // Display fields
    private String senderName;
    private String receiverName;
    private String taskTitle;

    public Message() {}

    // Getters
    public int getMessageId() { return messageId; }
    public int getTaskId() { return taskId; }
    public int getSenderId() { return senderId; }
    public int getReceiverId() { return receiverId; }
    public String getMessage() { return message; }
    public boolean isRead() { return isRead; }
    public Timestamp getSentAt() { return sentAt; }
    public String getSenderName() { return senderName; }
    public String getReceiverName() { return receiverName; }
    public String getTaskTitle() { return taskTitle; }

    // Setters
    public void setMessageId(int messageId) {
        this.messageId = messageId; }
    public void setTaskId(int taskId) {
        this.taskId = taskId; }
    public void setSenderId(int senderId) {
        this.senderId = senderId; }
    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId; }
    public void setMessage(String message) {
        this.message = message; }
    public void setRead(boolean isRead) {
        this.isRead = isRead; }
    public void setSentAt(Timestamp sentAt) {
        this.sentAt = sentAt; }
    public void setSenderName(String senderName) {
        this.senderName = senderName; }
    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName; }
    public void setTaskTitle(String taskTitle) {
        this.taskTitle = taskTitle; }
}
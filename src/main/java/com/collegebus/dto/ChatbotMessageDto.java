package com.collegebus.dto;

public class ChatbotMessageDto {

    private String message;

    public ChatbotMessageDto() {
    }

    public ChatbotMessageDto(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}

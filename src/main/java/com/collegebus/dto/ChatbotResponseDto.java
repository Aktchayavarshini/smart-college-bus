package com.collegebus.dto;

import java.util.ArrayList;
import java.util.List;

public class ChatbotResponseDto {

    private String reply;
    private List<String> suggestions = new ArrayList<>();
    private String actionLink;
    private String actionLabel;

    public ChatbotResponseDto() {
    }

    public ChatbotResponseDto(String reply) {
        this.reply = reply;
    }

    public ChatbotResponseDto(String reply, List<String> suggestions, String actionLink, String actionLabel) {
        this.reply = reply;
        this.suggestions = suggestions != null ? suggestions : new ArrayList<>();
        this.actionLink = actionLink;
        this.actionLabel = actionLabel;
    }

    public String getReply() {
        return reply;
    }

    public void setReply(String reply) {
        this.reply = reply;
    }

    public List<String> getSuggestions() {
        return suggestions;
    }

    public void setSuggestions(List<String> suggestions) {
        this.suggestions = suggestions;
    }

    public String getActionLink() {
        return actionLink;
    }

    public void setActionLink(String actionLink) {
        this.actionLink = actionLink;
    }

    public String getActionLabel() {
        return actionLabel;
    }

    public void setActionLabel(String actionLabel) {
        this.actionLabel = actionLabel;
    }
}

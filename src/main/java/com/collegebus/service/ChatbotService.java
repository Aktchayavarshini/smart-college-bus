package com.collegebus.service;

import com.collegebus.dto.ChatbotResponseDto;

public interface ChatbotService {

    ChatbotResponseDto processUserQuery(String userQuery);
}

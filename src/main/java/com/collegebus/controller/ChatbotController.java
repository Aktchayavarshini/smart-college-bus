package com.collegebus.controller;

import com.collegebus.dto.ChatbotMessageDto;
import com.collegebus.dto.ChatbotResponseDto;
import com.collegebus.entity.User;
import com.collegebus.service.ChatbotService;
import com.collegebus.service.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class ChatbotController {

    private final ChatbotService chatbotService;
    private final UserService userService;

    public ChatbotController(ChatbotService chatbotService, UserService userService) {
        this.chatbotService = chatbotService;
        this.userService = userService;
    }

    @GetMapping("/talk-to-aadhi")
    public String dedicatedChatbotPage(Model model) {
        User user = userService.getAuthenticatedUser();
        model.addAttribute("currentUser", user);
        return "talk-to-aadhi";
    }

    @PostMapping("/api/chatbot/message")
    @ResponseBody
    public ResponseEntity<ChatbotResponseDto> handleMessage(@RequestBody ChatbotMessageDto request) {
        ChatbotResponseDto response = chatbotService.processUserQuery(request.getMessage());
        return ResponseEntity.ok(response);
    }
}

package com.collegebus.service;

import com.collegebus.dto.ChatbotResponseDto;
import com.collegebus.entity.*;
import com.collegebus.repository.*;
import com.collegebus.service.impl.ChatbotServiceImpl;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Collections;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ChatbotServiceTest {

    @Mock
    private BusStopRepository busStopRepository;

    @Mock
    private RouteRepository routeRepository;

    @Mock
    private TripRepository tripRepository;

    @Mock
    private BookingRepository bookingRepository;

    @Mock
    private RouteStopRepository routeStopRepository;

    @Mock
    private ExamTimetableRepository examTimetableRepository;

    @InjectMocks
    private ChatbotServiceImpl chatbotService;

    @Test
    void testProcessGreeting() {
        ChatbotResponseDto response = chatbotService.processUserQuery("Hello Aadhi");
        assertNotNull(response);
        assertTrue(response.getReply().toLowerCase().contains("aadhi"));
        assertFalse(response.getSuggestions().isEmpty());
    }

    @Test
    void testProcessBookingHelp() {
        ChatbotResponseDto response = chatbotService.processUserQuery("How do I book a seat?");
        assertNotNull(response);
        assertTrue(response.getReply().contains("3 steps"));
        assertEquals("/find-bus", response.getActionLink());
    }

    @Test
    void testProcessLocalitySearch_Pallavaram() {
        BusStop pallavaram = new BusStop("Pallavaram Bus Stand", "GST Road", "Pallavaram", "ACTIVE");
        pallavaram.setStopId(2L);
        Route route = new Route("Route 101 - Pallavaram Express", "Pallavaram", "Campus", "Desc", "ACTIVE");
        route.setRouteId(1L);
        RouteStop routeStop = new RouteStop(route, pallavaram, 1, 0);

        when(busStopRepository.findAll()).thenReturn(List.of(pallavaram));
        when(routeStopRepository.findByStop(pallavaram)).thenReturn(List.of(routeStop));
        when(tripRepository.findAll()).thenReturn(Collections.emptyList());

        ChatbotResponseDto response = chatbotService.processUserQuery("Find bus to Pallavaram");
        assertNotNull(response);
        assertTrue(response.getReply().contains("Pallavaram"));
        assertTrue(response.getReply().contains("Route 101"));
    }
}

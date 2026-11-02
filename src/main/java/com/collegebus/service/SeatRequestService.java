package com.collegebus.service;

import com.collegebus.dto.SeatRequestDto;
import com.collegebus.entity.SeatRequest;
import com.collegebus.entity.User;

import java.util.List;

public interface SeatRequestService {

    SeatRequest createRequest(User user, SeatRequestDto dto);

    SeatRequest approveRequest(Long requestId, User adminUser);

    SeatRequest rejectRequest(Long requestId, User adminUser);

    List<SeatRequest> getPendingRequests();

    List<SeatRequest> getAllRequests();

    List<SeatRequest> getRequestsByUser(User user);

    SeatRequest getRequestById(Long id);

    long countPendingRequests();
}

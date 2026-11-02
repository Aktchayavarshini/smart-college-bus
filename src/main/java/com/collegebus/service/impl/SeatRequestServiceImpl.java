package com.collegebus.service.impl;

import com.collegebus.dto.BookingRequestDto;
import com.collegebus.dto.SeatRequestDto;
import com.collegebus.entity.*;
import com.collegebus.exception.BookingException;
import com.collegebus.exception.ResourceNotFoundException;
import com.collegebus.repository.BookingRepository;
import com.collegebus.repository.BusStopRepository;
import com.collegebus.repository.SeatRequestRepository;
import com.collegebus.repository.TripRepository;
import com.collegebus.service.BookingService;
import com.collegebus.service.SeatRequestService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Transactional
public class SeatRequestServiceImpl implements SeatRequestService {

    private final SeatRequestRepository seatRequestRepository;
    private final TripRepository tripRepository;
    private final BusStopRepository busStopRepository;
    private final BookingRepository bookingRepository;
    private final BookingService bookingService;

    public SeatRequestServiceImpl(SeatRequestRepository seatRequestRepository,
                                  TripRepository tripRepository,
                                  BusStopRepository busStopRepository,
                                  BookingRepository bookingRepository,
                                  BookingService bookingService) {
        this.seatRequestRepository = seatRequestRepository;
        this.tripRepository = tripRepository;
        this.busStopRepository = busStopRepository;
        this.bookingRepository = bookingRepository;
        this.bookingService = bookingService;
    }

    @Override
    public SeatRequest createRequest(User user, SeatRequestDto dto) {
        Trip trip = tripRepository.findById(dto.getTripId())
                .orElseThrow(() -> new ResourceNotFoundException("Trip not found: " + dto.getTripId()));

        BusStop pickup = busStopRepository.findById(dto.getPickupStopId())
                .orElseThrow(() -> new ResourceNotFoundException("Pickup stop not found: " + dto.getPickupStopId()));

        BusStop dropoff = busStopRepository.findById(dto.getDropoffStopId())
                .orElseThrow(() -> new ResourceNotFoundException("Dropoff stop not found: " + dto.getDropoffStopId()));

        // Check if user already has a pending request for this trip
        seatRequestRepository.findByUserAndTripAndRequestStatus(user, trip, "PENDING")
                .ifPresent(existing -> {
                    throw new BookingException("You already have a pending seat request (#" + existing.getRequestId() + ") for this trip.");
                });

        SeatRequest request = new SeatRequest();
        request.setUser(user);
        request.setTrip(trip);
        request.setPickupStop(pickup);
        request.setDropoffStop(dropoff);
        request.setRequestStatus("PENDING");
        request.setRequestedAt(LocalDateTime.now());

        return seatRequestRepository.save(request);
    }

    @Override
    public SeatRequest approveRequest(Long requestId, User adminUser) {
        SeatRequest request = getRequestById(requestId);

        if (!"PENDING".equalsIgnoreCase(request.getRequestStatus())) {
            throw new BookingException("Request is already processed (Status: " + request.getRequestStatus() + ").");
        }

        Trip trip = request.getTrip();
        long currentConfirmed = bookingRepository.countByTripAndBookingStatus(trip, "CONFIRMED");

        // Verify available seats before approving
        if (currentConfirmed >= trip.getBus().getTotalSeats()) {
            throw new BookingException("Cannot approve: Bus is still at full capacity (" + currentConfirmed + "/" + trip.getBus().getTotalSeats() + "). Increase capacity or wait for cancellations.");
        }

        // Create the confirmed booking for the student/teacher
        BookingRequestDto bookingDto = new BookingRequestDto();
        bookingDto.setTripId(trip.getTripId());
        bookingDto.setPickupStopId(request.getPickupStop().getStopId());
        bookingDto.setDropoffStopId(request.getDropoffStop().getStopId());
        bookingDto.setRequestedPickupText(request.getPickupStop().getStopName());
        bookingDto.setRequestedDestinationText(request.getDropoffStop().getStopName());

        bookingService.bookSeat(request.getUser(), bookingDto);

        request.setRequestStatus("APPROVED");
        request.setProcessedAt(LocalDateTime.now());
        request.setProcessedBy(adminUser);

        return seatRequestRepository.save(request);
    }

    @Override
    public SeatRequest rejectRequest(Long requestId, User adminUser) {
        SeatRequest request = getRequestById(requestId);

        if (!"PENDING".equalsIgnoreCase(request.getRequestStatus())) {
            throw new BookingException("Request is already processed (Status: " + request.getRequestStatus() + ").");
        }

        request.setRequestStatus("REJECTED");
        request.setProcessedAt(LocalDateTime.now());
        request.setProcessedBy(adminUser);

        return seatRequestRepository.save(request);
    }

    @Override
    @Transactional(readOnly = true)
    public List<SeatRequest> getPendingRequests() {
        return seatRequestRepository.findByRequestStatusOrderByRequestedAtDesc("PENDING");
    }

    @Override
    @Transactional(readOnly = true)
    public List<SeatRequest> getAllRequests() {
        return seatRequestRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<SeatRequest> getRequestsByUser(User user) {
        return seatRequestRepository.findByUserOrderByRequestedAtDesc(user);
    }

    @Override
    @Transactional(readOnly = true)
    public SeatRequest getRequestById(Long id) {
        return seatRequestRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Seat request not found with ID: " + id));
    }

    @Override
    @Transactional(readOnly = true)
    public long countPendingRequests() {
        return seatRequestRepository.countByRequestStatus("PENDING");
    }
}

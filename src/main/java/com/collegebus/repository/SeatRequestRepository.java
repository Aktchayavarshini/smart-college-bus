package com.collegebus.repository;

import com.collegebus.entity.SeatRequest;
import com.collegebus.entity.Trip;
import com.collegebus.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SeatRequestRepository extends JpaRepository<SeatRequest, Long> {

    List<SeatRequest> findByUserOrderByRequestedAtDesc(User user);

    List<SeatRequest> findByTrip(Trip trip);

    List<SeatRequest> findByRequestStatusOrderByRequestedAtDesc(String requestStatus);

    long countByRequestStatus(String requestStatus);

    Optional<SeatRequest> findByUserAndTripAndRequestStatus(User user, Trip trip, String requestStatus);
}

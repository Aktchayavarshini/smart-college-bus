package com.collegebus.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "seat_requests")
public class SeatRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "request_id")
    private Long requestId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "trip_id", nullable = false)
    private Trip trip;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "pickup_stop_id", nullable = false)
    private BusStop pickupStop;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "dropoff_stop_id", nullable = false)
    private BusStop dropoffStop;

    @Column(name = "request_status", nullable = false, length = 30)
    private String requestStatus = "PENDING"; // PENDING, APPROVED, REJECTED

    @Column(name = "requested_at", nullable = false, updatable = false)
    private LocalDateTime requestedAt = LocalDateTime.now();

    @Column(name = "processed_at")
    private LocalDateTime processedAt;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "processed_by")
    private User processedBy;

    public SeatRequest() {
    }

    public SeatRequest(User user, Trip trip, BusStop pickupStop, BusStop dropoffStop, String requestStatus) {
        this.user = user;
        this.trip = trip;
        this.pickupStop = pickupStop;
        this.dropoffStop = dropoffStop;
        this.requestStatus = requestStatus;
        this.requestedAt = LocalDateTime.now();
    }

    @PrePersist
    protected void onCreate() {
        if (requestedAt == null) requestedAt = LocalDateTime.now();
    }

    public Long getRequestId() {
        return requestId;
    }

    public void setRequestId(Long requestId) {
        this.requestId = requestId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Trip getTrip() {
        return trip;
    }

    public void setTrip(Trip trip) {
        this.trip = trip;
    }

    public BusStop getPickupStop() {
        return pickupStop;
    }

    public void setPickupStop(BusStop pickupStop) {
        this.pickupStop = pickupStop;
    }

    public BusStop getDropoffStop() {
        return dropoffStop;
    }

    public void setDropoffStop(BusStop dropoffStop) {
        this.dropoffStop = dropoffStop;
    }

    public String getRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(String requestStatus) {
        this.requestStatus = requestStatus;
    }

    public LocalDateTime getRequestedAt() {
        return requestedAt;
    }

    public void setRequestedAt(LocalDateTime requestedAt) {
        this.requestedAt = requestedAt;
    }

    public LocalDateTime getProcessedAt() {
        return processedAt;
    }

    public void setProcessedAt(LocalDateTime processedAt) {
        this.processedAt = processedAt;
    }

    public User getProcessedBy() {
        return processedBy;
    }

    public void setProcessedBy(User processedBy) {
        this.processedBy = processedBy;
    }
}

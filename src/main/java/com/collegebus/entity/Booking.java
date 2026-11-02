package com.collegebus.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "bookings")
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "booking_id")
    private Long bookingId;

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

    @Column(name = "requested_pickup_text", length = 150)
    private String requestedPickupText;

    @Column(name = "requested_destination_text", length = 150)
    private String requestedDestinationText;

    @Column(name = "booking_status", nullable = false, length = 30)
    private String bookingStatus = "CONFIRMED"; // CONFIRMED, CANCELLED, MODIFIED

    @Column(name = "booking_date", nullable = false, updatable = false)
    private LocalDateTime bookingDate = LocalDateTime.now();

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt = LocalDateTime.now();

    public Booking() {
    }

    public Booking(User user, Trip trip, BusStop pickupStop, BusStop dropoffStop, String requestedPickupText, String requestedDestinationText, String bookingStatus) {
        this.user = user;
        this.trip = trip;
        this.pickupStop = pickupStop;
        this.dropoffStop = dropoffStop;
        this.requestedPickupText = requestedPickupText;
        this.requestedDestinationText = requestedDestinationText;
        this.bookingStatus = bookingStatus;
        this.bookingDate = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PrePersist
    protected void onCreate() {
        if (bookingDate == null) bookingDate = LocalDateTime.now();
        if (updatedAt == null) updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    public Long getBookingId() {
        return bookingId;
    }

    public void setBookingId(Long bookingId) {
        this.bookingId = bookingId;
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

    public String getRequestedPickupText() {
        return requestedPickupText;
    }

    public void setRequestedPickupText(String requestedPickupText) {
        this.requestedPickupText = requestedPickupText;
    }

    public String getRequestedDestinationText() {
        return requestedDestinationText;
    }

    public void setRequestedDestinationText(String requestedDestinationText) {
        this.requestedDestinationText = requestedDestinationText;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

    public LocalDateTime getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(LocalDateTime bookingDate) {
        this.bookingDate = bookingDate;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}

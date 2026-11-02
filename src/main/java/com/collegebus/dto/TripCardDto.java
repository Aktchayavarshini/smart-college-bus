package com.collegebus.dto;

import java.time.LocalDate;
import java.time.LocalTime;

public class TripCardDto {

    private Long tripId;
    private String busNumber;
    private String registrationNumber;
    private Integer totalSeats;
    private Integer availableSeats;
    private Integer bookedSeats;
    private Long routeId;
    private String routeName;
    private String source;
    private String destination;
    private LocalDate travelDate;
    private LocalTime departureTime;
    private LocalTime arrivalTime;
    private String tripType;
    private String tripStatus;
    private LocalTime bookingCutoffTime;
    private String driverName;
    private String driverPhone;
    private boolean full;
    private String pickupStopName;
    private String dropoffStopName;
    private Long pickupStopId;
    private Long dropoffStopId;
    private Integer estimatedTravelMinutes;

    public TripCardDto() {
    }

    public Long getTripId() {
        return tripId;
    }

    public void setTripId(Long tripId) {
        this.tripId = tripId;
    }

    public String getBusNumber() {
        return busNumber;
    }

    public void setBusNumber(String busNumber) {
        this.busNumber = busNumber;
    }

    public String getRegistrationNumber() {
        return registrationNumber;
    }

    public void setRegistrationNumber(String registrationNumber) {
        this.registrationNumber = registrationNumber;
    }

    public Integer getTotalSeats() {
        return totalSeats;
    }

    public void setTotalSeats(Integer totalSeats) {
        this.totalSeats = totalSeats;
    }

    public Integer getAvailableSeats() {
        return availableSeats;
    }

    public void setAvailableSeats(Integer availableSeats) {
        this.availableSeats = availableSeats;
        this.full = (availableSeats != null && availableSeats <= 0);
    }

    public Integer getBookedSeats() {
        return bookedSeats;
    }

    public void setBookedSeats(Integer bookedSeats) {
        this.bookedSeats = bookedSeats;
    }

    public Long getRouteId() {
        return routeId;
    }

    public void setRouteId(Long routeId) {
        this.routeId = routeId;
    }

    public String getRouteName() {
        return routeName;
    }

    public void setRouteName(String routeName) {
        this.routeName = routeName;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public LocalDate getTravelDate() {
        return travelDate;
    }

    public void setTravelDate(LocalDate travelDate) {
        this.travelDate = travelDate;
    }

    public LocalTime getDepartureTime() {
        return departureTime;
    }

    public void setDepartureTime(LocalTime departureTime) {
        this.departureTime = departureTime;
    }

    public LocalTime getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(LocalTime arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getTripType() {
        return tripType;
    }

    public void setTripType(String tripType) {
        this.tripType = tripType;
    }

    public String getTripStatus() {
        return tripStatus;
    }

    public void setTripStatus(String tripStatus) {
        this.tripStatus = tripStatus;
    }

    public LocalTime getBookingCutoffTime() {
        return bookingCutoffTime;
    }

    public void setBookingCutoffTime(LocalTime bookingCutoffTime) {
        this.bookingCutoffTime = bookingCutoffTime;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getDriverPhone() {
        return driverPhone;
    }

    public void setDriverPhone(String driverPhone) {
        this.driverPhone = driverPhone;
    }

    public boolean isFull() {
        return full;
    }

    public void setFull(boolean full) {
        this.full = full;
    }

    public String getPickupStopName() {
        return pickupStopName;
    }

    public void setPickupStopName(String pickupStopName) {
        this.pickupStopName = pickupStopName;
    }

    public String getDropoffStopName() {
        return dropoffStopName;
    }

    public void setDropoffStopName(String dropoffStopName) {
        this.dropoffStopName = dropoffStopName;
    }

    public Long getPickupStopId() {
        return pickupStopId;
    }

    public void setPickupStopId(Long pickupStopId) {
        this.pickupStopId = pickupStopId;
    }

    public Long getDropoffStopId() {
        return dropoffStopId;
    }

    public void setDropoffStopId(Long dropoffStopId) {
        this.dropoffStopId = dropoffStopId;
    }

    public Integer getEstimatedTravelMinutes() {
        return estimatedTravelMinutes;
    }

    public void setEstimatedTravelMinutes(Integer estimatedTravelMinutes) {
        this.estimatedTravelMinutes = estimatedTravelMinutes;
    }
}

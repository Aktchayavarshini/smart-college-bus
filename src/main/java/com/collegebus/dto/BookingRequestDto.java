package com.collegebus.dto;

import jakarta.validation.constraints.NotNull;

public class BookingRequestDto {

    @NotNull(message = "Trip ID is required")
    private Long tripId;

    @NotNull(message = "Pickup stop is required")
    private Long pickupStopId;

    @NotNull(message = "Dropoff stop is required")
    private Long dropoffStopId;

    private String requestedPickupText;
    private String requestedDestinationText;

    public BookingRequestDto() {
    }

    public BookingRequestDto(Long tripId, Long pickupStopId, Long dropoffStopId) {
        this.tripId = tripId;
        this.pickupStopId = pickupStopId;
        this.dropoffStopId = dropoffStopId;
    }

    public Long getTripId() {
        return tripId;
    }

    public void setTripId(Long tripId) {
        this.tripId = tripId;
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
}

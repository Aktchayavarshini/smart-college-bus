package com.collegebus.dto;

import org.springframework.format.annotation.DateTimeFormat;
import java.time.LocalDate;

public class BusSearchDto {

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate travelDate;

    private String preferredTimeSlot; // e.g. "06:00", "07:00", "08:00", "09:00", "12:00", "15:00", "17:00"

    private Long pickupStopId;

    private Long dropoffStopId;

    public BusSearchDto() {
    }

    public BusSearchDto(LocalDate travelDate, String preferredTimeSlot, Long pickupStopId, Long dropoffStopId) {
        this.travelDate = travelDate;
        this.preferredTimeSlot = preferredTimeSlot;
        this.pickupStopId = pickupStopId;
        this.dropoffStopId = dropoffStopId;
    }

    public LocalDate getTravelDate() {
        return travelDate;
    }

    public void setTravelDate(LocalDate travelDate) {
        this.travelDate = travelDate;
    }

    public String getPreferredTimeSlot() {
        return preferredTimeSlot;
    }

    public void setPreferredTimeSlot(String preferredTimeSlot) {
        this.preferredTimeSlot = preferredTimeSlot;
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
}

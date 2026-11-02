package com.collegebus.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "bus_stops")
public class BusStop {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "stop_id")
    private Long stopId;

    @Column(name = "stop_name", nullable = false, length = 100)
    private String stopName;

    @Column(name = "location_description", length = 255)
    private String locationDescription;

    @Column(name = "area", nullable = false, length = 100)
    private String area;

    @Column(name = "stop_status", nullable = false, length = 30)
    private String stopStatus = "ACTIVE"; // ACTIVE, INACTIVE

    public BusStop() {
    }

    public BusStop(String stopName, String locationDescription, String area, String stopStatus) {
        this.stopName = stopName;
        this.locationDescription = locationDescription;
        this.area = area;
        this.stopStatus = stopStatus;
    }

    public Long getStopId() {
        return stopId;
    }

    public void setStopId(Long stopId) {
        this.stopId = stopId;
    }

    public String getStopName() {
        return stopName;
    }

    public void setStopName(String stopName) {
        this.stopName = stopName;
    }

    public String getLocationDescription() {
        return locationDescription;
    }

    public void setLocationDescription(String locationDescription) {
        this.locationDescription = locationDescription;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getStopStatus() {
        return stopStatus;
    }

    public void setStopStatus(String stopStatus) {
        this.stopStatus = stopStatus;
    }
}

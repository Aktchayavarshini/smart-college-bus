package com.collegebus.dto;

public class DemandReportDto {

    private Long routeId;
    private String routeName;
    private String source;
    private String destination;
    private int totalTrips;
    private int totalSeatsCapacity;
    private int totalBookingsCount;
    private double occupancyPercentage;
    private String demandLevel; // HIGH, MODERATE, LOW
    private String actionRecommendation;

    public DemandReportDto() {
    }

    public DemandReportDto(Long routeId, String routeName, String source, String destination, int totalTrips, int totalSeatsCapacity, int totalBookingsCount, double occupancyPercentage, String demandLevel, String actionRecommendation) {
        this.routeId = routeId;
        this.routeName = routeName;
        this.source = source;
        this.destination = destination;
        this.totalTrips = totalTrips;
        this.totalSeatsCapacity = totalSeatsCapacity;
        this.totalBookingsCount = totalBookingsCount;
        this.occupancyPercentage = occupancyPercentage;
        this.demandLevel = demandLevel;
        this.actionRecommendation = actionRecommendation;
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

    public int getTotalTrips() {
        return totalTrips;
    }

    public void setTotalTrips(int totalTrips) {
        this.totalTrips = totalTrips;
    }

    public int getTotalSeatsCapacity() {
        return totalSeatsCapacity;
    }

    public void setTotalSeatsCapacity(int totalSeatsCapacity) {
        this.totalSeatsCapacity = totalSeatsCapacity;
    }

    public int getTotalBookingsCount() {
        return totalBookingsCount;
    }

    public void setTotalBookingsCount(int totalBookingsCount) {
        this.totalBookingsCount = totalBookingsCount;
    }

    public double getOccupancyPercentage() {
        return occupancyPercentage;
    }

    public void setOccupancyPercentage(double occupancyPercentage) {
        this.occupancyPercentage = occupancyPercentage;
    }

    public String getDemandLevel() {
        return demandLevel;
    }

    public void setDemandLevel(String demandLevel) {
        this.demandLevel = demandLevel;
    }

    public String getActionRecommendation() {
        return actionRecommendation;
    }

    public void setActionRecommendation(String actionRecommendation) {
        this.actionRecommendation = actionRecommendation;
    }
}

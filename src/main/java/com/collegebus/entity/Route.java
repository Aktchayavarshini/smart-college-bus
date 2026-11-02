package com.collegebus.entity;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "routes")
public class Route {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "route_id")
    private Long routeId;

    @Column(name = "route_name", nullable = false, length = 100)
    private String routeName;

    @Column(name = "source", nullable = false, length = 100)
    private String source;

    @Column(name = "destination", nullable = false, length = 100)
    private String destination;

    @Column(name = "route_description", columnDefinition = "TEXT")
    private String routeDescription;

    @Column(name = "route_status", nullable = false, length = 30)
    private String routeStatus = "ACTIVE"; // ACTIVE, INACTIVE

    @OneToMany(mappedBy = "route", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    @OrderBy("stopSequence ASC")
    private List<RouteStop> routeStops = new ArrayList<>();

    public Route() {
    }

    public Route(String routeName, String source, String destination, String routeDescription, String routeStatus) {
        this.routeName = routeName;
        this.source = source;
        this.destination = destination;
        this.routeDescription = routeDescription;
        this.routeStatus = routeStatus;
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

    public String getRouteDescription() {
        return routeDescription;
    }

    public void setRouteDescription(String routeDescription) {
        this.routeDescription = routeDescription;
    }

    public String getRouteStatus() {
        return routeStatus;
    }

    public void setRouteStatus(String routeStatus) {
        this.routeStatus = routeStatus;
    }

    public List<RouteStop> getRouteStops() {
        return routeStops;
    }

    public void setRouteStops(List<RouteStop> routeStops) {
        this.routeStops = routeStops;
    }
}

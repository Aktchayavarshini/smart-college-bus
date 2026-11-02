package com.collegebus.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "route_stops", uniqueConstraints = {
    @UniqueConstraint(name = "uk_route_stop_seq", columnNames = {"route_id", "stop_sequence"}),
    @UniqueConstraint(name = "uk_route_stop", columnNames = {"route_id", "stop_id"})
})
public class RouteStop {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "route_stop_id")
    private Long routeStopId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "route_id", nullable = false)
    private Route route;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "stop_id", nullable = false)
    private BusStop stop;

    @Column(name = "stop_sequence", nullable = false)
    private Integer stopSequence;

    @Column(name = "estimated_travel_minutes", nullable = false)
    private Integer estimatedTravelMinutes = 0;

    public RouteStop() {
    }

    public RouteStop(Route route, BusStop stop, Integer stopSequence, Integer estimatedTravelMinutes) {
        this.route = route;
        this.stop = stop;
        this.stopSequence = stopSequence;
        this.estimatedTravelMinutes = estimatedTravelMinutes;
    }

    public Long getRouteStopId() {
        return routeStopId;
    }

    public void setRouteStopId(Long routeStopId) {
        this.routeStopId = routeStopId;
    }

    public Route getRoute() {
        return route;
    }

    public void setRoute(Route route) {
        this.route = route;
    }

    public BusStop getStop() {
        return stop;
    }

    public void setStop(BusStop stop) {
        this.stop = stop;
    }

    public Integer getStopSequence() {
        return stopSequence;
    }

    public void setStopSequence(Integer stopSequence) {
        this.stopSequence = stopSequence;
    }

    public Integer getEstimatedTravelMinutes() {
        return estimatedTravelMinutes;
    }

    public void setEstimatedTravelMinutes(Integer estimatedTravelMinutes) {
        this.estimatedTravelMinutes = estimatedTravelMinutes;
    }
}

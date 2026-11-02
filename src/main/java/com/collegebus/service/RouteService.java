package com.collegebus.service;

import com.collegebus.entity.Route;
import com.collegebus.entity.RouteStop;

import java.util.List;

public interface RouteService {

    List<Route> getAllRoutes();

    List<Route> getActiveRoutes();

    Route getRouteById(Long id);

    Route saveRoute(Route route);

    Route updateRoute(Long id, Route routeDetails);

    void toggleRouteStatus(Long id);

    List<RouteStop> getRouteStops(Long routeId);

    RouteStop assignStopToRoute(Long routeId, Long stopId, Integer sequence, Integer estimatedMinutes);

    void removeStopFromRoute(Long routeStopId);

    long countTotalRoutes();
}

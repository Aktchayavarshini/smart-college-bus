package com.collegebus.service.impl;

import com.collegebus.entity.BusStop;
import com.collegebus.entity.Route;
import com.collegebus.entity.RouteStop;
import com.collegebus.exception.ResourceNotFoundException;
import com.collegebus.repository.BusStopRepository;
import com.collegebus.repository.RouteRepository;
import com.collegebus.repository.RouteStopRepository;
import com.collegebus.service.RouteService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class RouteServiceImpl implements RouteService {

    private final RouteRepository routeRepository;
    private final RouteStopRepository routeStopRepository;
    private final BusStopRepository busStopRepository;

    public RouteServiceImpl(RouteRepository routeRepository,
                            RouteStopRepository routeStopRepository,
                            BusStopRepository busStopRepository) {
        this.routeRepository = routeRepository;
        this.routeStopRepository = routeStopRepository;
        this.busStopRepository = busStopRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Route> getAllRoutes() {
        return routeRepository.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Route> getActiveRoutes() {
        return routeRepository.findByRouteStatus("ACTIVE");
    }

    @Override
    @Transactional(readOnly = true)
    public Route getRouteById(Long id) {
        return routeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Route not found with ID: " + id));
    }

    @Override
    public Route saveRoute(Route route) {
        return routeRepository.save(route);
    }

    @Override
    public Route updateRoute(Long id, Route details) {
        Route route = getRouteById(id);
        route.setRouteName(details.getRouteName());
        route.setSource(details.getSource());
        route.setDestination(details.getDestination());
        route.setRouteDescription(details.getRouteDescription());
        route.setRouteStatus(details.getRouteStatus());
        return routeRepository.save(route);
    }

    @Override
    public void toggleRouteStatus(Long id) {
        Route route = getRouteById(id);
        if ("ACTIVE".equalsIgnoreCase(route.getRouteStatus())) {
            route.setRouteStatus("INACTIVE");
        } else {
            route.setRouteStatus("ACTIVE");
        }
        routeRepository.save(route);
    }

    @Override
    @Transactional(readOnly = true)
    public List<RouteStop> getRouteStops(Long routeId) {
        Route route = getRouteById(routeId);
        return routeStopRepository.findByRouteOrderByStopSequenceAsc(route);
    }

    @Override
    public RouteStop assignStopToRoute(Long routeId, Long stopId, Integer sequence, Integer estimatedMinutes) {
        Route route = getRouteById(routeId);
        BusStop stop = busStopRepository.findById(stopId)
                .orElseThrow(() -> new ResourceNotFoundException("Bus Stop not found with ID: " + stopId));

        RouteStop routeStop = routeStopRepository.findByRouteAndStop(route, stop)
                .orElse(new RouteStop());

        routeStop.setRoute(route);
        routeStop.setStop(stop);
        routeStop.setStopSequence(sequence != null ? sequence : 1);
        routeStop.setEstimatedTravelMinutes(estimatedMinutes != null ? estimatedMinutes : 0);

        return routeStopRepository.save(routeStop);
    }

    @Override
    public void removeStopFromRoute(Long routeStopId) {
        routeStopRepository.deleteById(routeStopId);
    }

    @Override
    @Transactional(readOnly = true)
    public long countTotalRoutes() {
        return routeRepository.count();
    }
}

package com.collegebus.repository;

import com.collegebus.entity.BusStop;
import com.collegebus.entity.Route;
import com.collegebus.entity.RouteStop;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RouteStopRepository extends JpaRepository<RouteStop, Long> {

    List<RouteStop> findByRouteOrderByStopSequenceAsc(Route route);

    List<RouteStop> findByStop(BusStop stop);

    Optional<RouteStop> findByRouteAndStop(Route route, BusStop stop);

    void deleteByRoute(Route route);
}

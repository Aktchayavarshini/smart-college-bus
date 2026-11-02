package com.collegebus.repository;

import com.collegebus.entity.Route;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface RouteRepository extends JpaRepository<Route, Long> {

    List<Route> findByRouteStatus(String routeStatus);

    List<Route> findBySourceContainingIgnoreCaseOrDestinationContainingIgnoreCase(String source, String destination);
}

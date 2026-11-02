package com.collegebus.repository;

import com.collegebus.entity.BusStop;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BusStopRepository extends JpaRepository<BusStop, Long> {

    List<BusStop> findByStopStatus(String stopStatus);

    List<BusStop> findByAreaIgnoreCase(String area);

    List<BusStop> findByStopNameContainingIgnoreCaseOrAreaContainingIgnoreCase(String stopName, String area);
}

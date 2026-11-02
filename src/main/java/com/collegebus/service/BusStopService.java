package com.collegebus.service;

import com.collegebus.entity.BusStop;
import java.util.List;

public interface BusStopService {

    List<BusStop> getAllStops();

    List<BusStop> getActiveStops();

    BusStop getStopById(Long id);

    BusStop saveStop(BusStop stop);

    BusStop updateStop(Long id, BusStop stopDetails);

    void toggleStopStatus(Long id);

    List<BusStop> searchStops(String query);

    long countTotalStops();
}
